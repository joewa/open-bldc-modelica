/*
    ChibiOS - Copyright (C) 2006..2015 Giovanni Di Sirio

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/

//#define USE_DMA_4_PWM // Configure output pins for DMA based PWM generation (in board.h). Comment out for timer usage.

#include <stdlib.h> // Needed for strtof() in term.comp
#ifndef SIM_TARGET
#include <src/pwmadcdma.h>
#include "ch.h"
#include "hal.h"
#include "ch_test.h"
#include "chprintf.h"
#include "subsystems/serial/chibiesc_serial.h"
#else
#include <stdbool.h>
#include "pwmadcdma.h"
#include "siminterfaces.h"
#include "board.h"
#endif


//#include "subsystems/serial/chibiesc_usb.h"
//#include <stdint.h>


#include "misc.h"
#include "chutil.h"
extern uint32_t *myGPIOA_BSRR;
#include "bal_interface.h"


/*
 * BEGIN Thread timing and clock configuration
 */

#define ADC_RT_DEFAULT_PERIOD_CYCLES (5*ADC_FRT_DEFAULT_PERIOD_CYCLES)

//#define PERIOD_FRT_ST	(US2ST(25))	// FRT period in TimX-Ticks or Systicks
//#define PERIOD_RT_ST	(8*PERIOD_FRT_ST)
/*
 * END  Thread timing and clock configuration
 */


typedef struct{
    int pin_count;

    volatile enum{
      FRT_WAITFOR_TIMEOUT,
	  FRT_WAITFOR_REMOTE
    } frt_extended_state;

    volatile int active_rt_func;
    volatile int active_frt_func;
    volatile int active_nrt_func;
} bal_extensions_struct_t;

bal_extensions_struct_t bal_ext;

/*
 * Application entry point.
 */
char testtext[8] = "Hallo\n";

float testfloat = 3.14;



//#define chprintf printf
// BEGIN copy&paste from stmbl usb_cdc

#include "ringbuf.h"
#include "bal.h"
#include "bal_term.h"


GLOBAL_HAL_PIN(nrt_time);
GLOBAL_HAL_PIN(rt_time);
GLOBAL_HAL_PIN(frt_time);
GLOBAL_HAL_PIN(nrt_period_time);
GLOBAL_HAL_PIN(rt_period_time);
GLOBAL_HAL_PIN(frt_period_time);

GLOBAL_HAL_PIN(something1);
GLOBAL_HAL_PIN(something2);

#define RX_QUEUE_SIZE  128
uint8_t usb_rx_buf_raw[RX_QUEUE_SIZE];
uint8_t usb_rx_string[RX_QUEUE_SIZE];
//uint8_t usb_rx_buf[RX_QUEUE_SIZE];
//char rx_buf[RX_QUEUE_SIZE];


struct ringbuf usb_rx_buf = { .buf = (char[RX_QUEUE_SIZE]) {0}, .bufsize = RX_QUEUE_SIZE, .pos = 0, .len = 0 };

uint16_t cr_count = 0;

static uint16_t VCP_DataRx(uint8_t *buf, uint32_t len)
{
    for (uint32_t i = 0; i < len; i++) {
    	if (buf[i] == 0x0A) // 0x0A == '\n'
    	    cr_count++;
        rb_putc(&usb_rx_buf, buf[i]);
    }
    return 1; //USBD_OK;
}


#define USB_CDC_FIRST_ASCII 32    // erstes Ascii-Zeichen
#define USB_CDC_LAST_ASCII  255   // letztes Ascii-Zeichen
uint16_t USB_VCP_get_string(char *ptr)
{
    uint16_t akt_pos = 0;
    char wert;

    // test ob eine Endekennung empfangen wurde
    if (cr_count == 0) return 0;

    if (usb_rx_buf.len == 0) return 0;

    // kompletten String bis zur Endekennung auslesen
    // (oder bis Puffer leer ist)
    // es werden nur Ascii-Zeichen übergeben
   do {
        rb_getc(&usb_rx_buf, &wert);
        if ((wert >= USB_CDC_FIRST_ASCII) && (wert <= USB_CDC_LAST_ASCII)) {
            *(ptr + akt_pos) = wert;
            akt_pos++;
        }
    } while ((usb_rx_buf.len != 0) && (wert != 0x0A)); // 0x0A = '\n'

    // Stringende anhängen
    *(ptr + akt_pos) = 0x00;

    // eine Endekennung wurde bearbeitet
    cr_count--;

    return akt_pos;
}


#ifndef SIM_TARGET
void USB_VCP_send_string(unsigned char *ptr)
{ //TODO: Joerg implementiere senden von 0-terminiertem string. Implementiere was Schnelleres als PRINTF!!!
	//chprintf("%s", ptr);

    while (*ptr != 0) {
        // send a queued byte - copy to usb stack buffer
        //APP_Rx_Buffer[APP_Rx_ptr_in++] = *ptr;

        streamPut(&SDU1, *ptr);
        ptr++;

            // To avoid buffer overflow
            //if (APP_Rx_ptr_in >= APP_RX_DATA_SIZE) {
            //   APP_Rx_ptr_in = 0;
            //}
    }
}
#endif  /* SIM_TARGET */

//END copy&paste


/*
static PWMConfig pwm1cfg= {
		PWM_CLOCK_FREQUENCY, //PWM clock frequency
		PWM_CLOCK_FREQUENCY / PWM_DEFAULT_FREQUENCY, // PWM period
		NULL,  // No callback
		{
				{PWM_OUTPUT_ACTIVE_HIGH, NULL},
				{PWM_OUTPUT_ACTIVE_HIGH, NULL},
				{PWM_OUTPUT_ACTIVE_HIGH, NULL},
				{PWM_OUTPUT_DISABLED, NULL},
		},
		0,//TIM_CR2_MMS_1, // 010: Update - The update event is selected as trigger output (TRGO). //TIM_CR2_MMS_2, // TIM CR2 register initialization data, OC1REF signal is used as trigger output (TRGO)
		0 // TIM DIER register initialization data, "should normally be zero"
};
*/

static THD_WORKING_AREA(waThreadFRT, 32768);
static THD_FUNCTION(ThreadFRT, arg) {
	// shortest time to compute, but highest frequency and highest priority
	(void)arg;
	chRegSetThreadName("ThreadFRT");
	int delta_count, last_delta_count;
	delta_count=0; last_delta_count=0;
	//count_adc=0; count_frt=0;
	//adcStartConversion(&ADCD1, &adcgrpcfg2, samples2, ADC_GRP2_BUF_DEPTH);
	bal_ext.frt_extended_state = FRT_WAITFOR_TIMEOUT;
	systime_t time = hal_get_systick_value();// + ADC_FRT_DEFAULT_PERIOD_CYCLES;

	while ( !chThdShouldTerminateX() ) { // TODO GPIO setzen und ruecksetzen und mit Oszi calctime messen.
		if(bal.frt_state == FRT_SLEEP) {
	         if(bal.active_frt_func > -1){
	            bal.frt_state = FRT_STOP;
	            bal.hal_state = MISC_ERROR;
	            bal.rt_state = RT_STOP;
	            break; 	//--> Terminate frt-thread
	         }
	         bal.frt_state = FRT_CALC;
		}
		else {//bal.frt_state == RT_STOP
			break;		//--> Terminate frt-thread
		}

		   static unsigned int last_start = 0;
		   unsigned int start = hal_get_systick_value();

		   palSetPad(BANK_LED_GREEN, PIN_LED_GREEN);
		   float period = ((float)(start - last_start)) / hal_get_systick_freq();
		   last_start = start;

		   hal_run_frt(period);
		   //if(rt_counter++ > 500000) chThdSleep(US2ST(20)); // Inject task overrun error

		   unsigned int end = hal_get_systick_value(); // TODO: Doppelt? Siehe bal.h

		   PIN(frt_time) = ((float)(end - start)) / hal_get_systick_freq();
		   PIN(frt_period_time) = period;
		   palClearPad(BANK_LED_GREEN, PIN_LED_GREEN);

		   //if(bal_ext.frt_extended_state == FRT_WAITFOR_TIMEOUT) {
			   // Check if deadline is missed and chThdSleepUntil next rt-cycle
			   //time += ADC_FRT_DEFAULT_PERIOD_CYCLES; //PERIOD_FRT_ST; CH_CFG_ST_TIMEDELTA
		       unsigned int waittime = get__next_pwmdma_state__adc_frt_period_cycles();
		   	   time += waittime;
			   if( time - (end + CH_CFG_ST_TIMEDELTA) > waittime+10) { // mind uint arithmetics: cannot have negative value!
				   bal.frt_state = FRT_STOP;
			       bal.hal_state = FRT_TOO_LONG;
			       bal.rt_state = RT_STOP;
				   break;
			   } // Note that this detection may fail in case of excessively missed deadlines and timer counter overrun
			   bal.frt_state = FRT_SLEEP;
			   chThdSleepUntil(time);
		   /*} else { //bal_ext.frt_extended_state == FRT_WAITFOR_REMOTE
			   // Warte auf ADC-Callback: http://www.chibios.org/dokuwiki/doku.php?id=chibios:howtos:wakeup
			   bal.frt_state = FRT_SLEEP;
			   chSysLock();
			   //msg =
			   chThdSuspendS(&adc_trp);
			   chSysUnlock();
			   time = hal_get_systick_value();// + ADC_FRT_DEFAULT_PERIOD_CYCLES;
			   // TODO: Haben time[ADC-Ticks] und hal_get_systick_value die gleiche Einheit!?
		   }*/
	} // END while
	chThdExit((msg_t)0);
}

static THD_WORKING_AREA(waThreadRT, 8192);
static THD_FUNCTION(ThreadRT, arg) {
	// longest time to compute (longer than ThreadFRT frequency, but lower frequency and lowest priority
	// long computation in this thread is interrupted by ThreadFRT and the main loop
	(void)arg;
	chRegSetThreadName("ThreadRT");
	systime_t time = hal_get_systick_value();
	uint32_t rt_counter;
	rt_counter = 0;
	while ( !chThdShouldTerminateX() ) {
		if(bal.rt_state == RT_SLEEP) {
	         if(bal.active_rt_func > -1){
	            bal.rt_state = RT_STOP;
	            bal.hal_state = MISC_ERROR;
	            bal.frt_state = FRT_STOP;
	            break; 	//--> Terminate rt-thread
	         }
	         bal.rt_state = RT_CALC;
		}
		else {//bal.rt_state == RT_STOP
			break;		//--> Terminate rt-thread
		}

		   static unsigned int last_start = 0;
		   unsigned int start = hal_get_systick_value();

		   float period = ((float)(start - last_start)) / hal_get_systick_freq();
		   last_start = start;

		   hal_run_rt(period);
		   //if(rt_counter++ > 500000) chThdSleep(US2ST(200)); // Inject task overrun error

		   unsigned int end = hal_get_systick_value();

		   PIN(rt_time) = ((float)(end - start)) / hal_get_systick_freq();
		   PIN(rt_period_time) = period;

		   // Check if deadline is missed and chThdSleepUntil next rt-cycle
		   time += ADC_RT_DEFAULT_PERIOD_CYCLES;
		   if( time - (end + (2*ADC_FRT_DEFAULT_PERIOD_CYCLES)) > ADC_RT_DEFAULT_PERIOD_CYCLES) { // mind uint arithmetics: cannot have negative value!
			   bal.rt_state = RT_STOP;
		       bal.hal_state = RT_TOO_LONG;
		       bal.frt_state = FRT_STOP;
			   break;
		   } // Note that this detection may fail in case of excessively missed deadlines and timer counter overrun
		   bal.rt_state = RT_SLEEP; chThdSleepUntil(time);
		   //palTogglePad(BANK_LED_ORANGE_DISCO, PIN_LED_ORANGE_DISCO);
	} // END while
	chThdExit((msg_t)0);
}


static THD_WORKING_AREA(waThreadNRT, 8192);
static THD_FUNCTION(ThreadNRT, arg) {
  (void)arg;
  chRegSetThreadName("ThreadNRT");
  int len;
  systime_t nrt_calctime = 0;
  systime_t nrt_starttime = chVTGetSystemTime();
  //systime_t nrt_nexttime = nrt_starttime;
  int nrt_blink_count = 1000;
#define nrt_Period MS2ST(1)
  PIN(nrt_period_time) = ((float)nrt_Period) / hal_get_systick_freq();
  while (true) {
	  if(nrt_blink_count-- <= 0) {
		  nrt_blink_count = 1000;
		  palTogglePad(BANK_LED_RED, PIN_LED_RED);
		  //palTogglePad(BANK_LED_GREEN, PIN_LED_GREEN);
	  }
	  nrt_starttime = chVTGetSystemTime();
	  hal_run_nrt(nrt_Period); // Calls term which calls USB_VCP_get_string. Call from own thread, NOT HERE!!!

	  nrt_calctime = chVTTimeElapsedSinceX(nrt_starttime);
	  PIN(nrt_time) = ((float)(nrt_calctime)) / hal_get_systick_freq();
	  //nrt_nexttime += nrt_Period; // TODO: Check if nexttime > starttime!!!
	  //chThdSleepUntil(nrt_nexttime);
	  chThdSleep(nrt_Period);
  }
}


/*
 * Start RT-Thread
 * */
thread_t *tp_rt = NULL;
void hal_enable_rt() {
	tp_rt = chThdCreateStatic(waThreadRT, sizeof(waThreadRT), NORMALPRIO+10, ThreadRT, NULL);
}

void hal_disable_rt() {
	if(tp_rt != NULL) {
		chThdTerminate(tp_rt);
		msg_t n = chThdWait(tp_rt);
		tp_rt = NULL;
	}
}


/*
 * Start Fast-RT-Thread
 */
thread_t *tp_frt = NULL;
void hal_enable_frt() {
	tp_frt = chThdCreateStatic(waThreadFRT, sizeof(waThreadFRT), NORMALPRIO+20, ThreadFRT, NULL);
}

void hal_disable_frt() {
	if(tp_frt != NULL) {
		chThdTerminate(tp_frt);
		msg_t n = chThdWait(tp_frt);
		tp_frt = NULL;
	}
}


int main(void) {
	// main loop always runs at NORMALPRIO
	int len;
  halInit();
  chSysInit();
  /*
   * Activates the ADC1 driver and the temperature sensor.
   */
  adcStart(&ADCD1, NULL);
  //adcSTM32EnableTSVREFE();

  usb_init();
  chThdSleepMilliseconds(2000);
  //setup();
  hal_init(); // from stmbl bal

  hal_set_comp_type("foo"); // default pin for mem errors
  HAL_PIN(bar) = 0.0;

  //feedback comps
  #include "comps/term.comp"
  //#include "comps/sim.comp"
  #include "comps/simfast.comp"
  //#include "comps/sixstep.comp"
  #include "comps/pwm3dma.comp"
  #include "comps/svm3.comp"
  #include "comps/genpp3.comp"

  //command comps

  //PID

  hal_set_comp_type("net");
  HAL_PIN(enable) = 0.0;
  HAL_PIN(cmd) = 0.0;
  HAL_PIN(rt_calc_time) = 0.0;
  HAL_PIN(frt_calc_time) = 0.0;
  HAL_PIN(nrt_calc_time) = 0.0;
  HAL_PIN(rt_period) = 0.0;
  HAL_PIN(frt_period) = 0.0;
  HAL_PIN(nrt_period) = 0.0;

  HAL_PIN(something1) = ADC_FRT_DEFAULT_PERIOD_CYCLES;
  HAL_PIN(something2) = ADC_RT_DEFAULT_PERIOD_CYCLES;

  // Was macht das?
  nrt_time_hal_pin = hal_map_pin("net0.nrt_calc_time");
  rt_time_hal_pin = hal_map_pin("net0.rt_calc_time");
  frt_time_hal_pin = hal_map_pin("net0.frt_calc_time");
  nrt_period_time_hal_pin = hal_map_pin("net0.nrt_period");
  rt_period_time_hal_pin = hal_map_pin("net0.rt_period");
  frt_period_time_hal_pin = hal_map_pin("net0.frt_period");

  hal_comp_init();

  // Make some inits
  hal_set_pin("term0.rt_prio", 15.0);
  hal_set_pin("simfast0.rt_prio", 50.0);
  hal_set_pin("simfast0.frt_prio", 50.0);
  //hal_set_pin("sixstep0.rt_prio", 100.0);
  //hal_set_pin("sixstep0.frt_prio", 100.0);
  hal_set_pin("svm30.frt_prio", 100.0);
  hal_set_pin("genpp30.rt_prio", 105.0);
  hal_set_pin("genpp30.frt_prio", 105.0);
  hal_set_pin("pwm3dma0.rt_prio", 110.0);
  hal_set_pin("pwm3dma0.frt_prio", 110.0);
  //hal_set_pin("sixstep0.frt_prio", 100.0);
  //hal_set_pin("sim0.rt_prio", 14.0);
  //hal_set_pin("sixstep0.rt_prio", 13.0);
 //hal_link_pins("conf0.cmd_rev", "rev0.rev");
  hal_link_pins("svm30.sdu", "genpp30.sdu");
  hal_link_pins("svm30.sdv", "genpp30.sdv");
  hal_link_pins("svm30.sdw", "genpp30.sdw");

  if(bal.pin_errors + bal.comp_errors == 0){
     hal_start();
  }
  else{
     bal.hal_state = MEM_ERROR;
  }

  chThdCreateStatic(waThreadNRT, sizeof(waThreadNRT), NORMALPRIO-20, ThreadNRT, NULL);

#ifndef SIM_TARGET
    // Main loop
    while (true) {
	chThdSleepMilliseconds(1);

	len = streamRead(&SDU1, (uint8_t*)usb_rx_buf_raw, 1);
	VCP_DataRx(usb_rx_buf_raw, len);
  }
#endif /* SIM_TARGET */
}
