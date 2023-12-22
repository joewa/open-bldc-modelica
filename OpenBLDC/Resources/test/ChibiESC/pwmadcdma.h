/*
 * pwmdma.h
 *
 *  Created on: 02.01.2017
 *      Author: joerg
 */

/**
 * @file    pwmadcdma.h
 * @author  Joerg Wangemann <joerg.wangemann@gmail.com>
 * @brief   Generic DMA-based PWM pattern generation
 *
 * Copyright (C) 2017 Joerg Wangemann
 *
 * This software may be modified and distributed under the terms
 * of the GPL-V3 license.  See the LICENSE file for details.
 *
 * @todo    Put in names and descriptions of variables which need to be defined to use this file
 */


#ifndef SRC_PWMADCDMA_H_
#define SRC_PWMADCDMA_H_

/**
 * @defgroup Generic PWM driver using DMA
 * @{
 *
 * @brief   Generic DMA-based PWM pattern generation
 *
 * A driver...
 */

/* --- PUBLIC DEPENDENCIES -------------------------------------------------- */

// Standard
#include <stdint.h>

// ChibiOS
#ifndef SIM_TARGET
#include "ch.h"
#include "hal.h"

extern ADCConversionGroup adc_commutate_group;
//extern adcsample_t commutatesamples[];
/*
 * ADC streaming callback.
 */
extern thread_reference_t adc_trp;
#else /* NOT SIM_TARGET */
#include "mcuconf.h"
#endif /* SIM_TARGET */


/* --- PUBLIC CONSTANTS ----------------------------------------------------- */

// PWM configuration
#define ADC_PWM_DIVIDER				(Ks_ADC * STM32_ADC_ADCPRESCALER) // ADC_CCR_ADCPRE_DIV2 When f_TIM1 == f_TIM2 (*STM32_PPRE2 for f_TIM1 = f_SYSCLK)
#define PWM_CLOCK_FREQUENCY 		(f_STM32_SYSCLK / 2)  // Low speed periph clock APB1! TIM1 connected to APB1!
// Define cycles!
#define ADC_COMMUTATE_NUM_CHANNELS	1		// Number of channels per ADC for (6-step mode)
#define ADC_FRT_DEFAULT_PERIOD_CYCLES 100	// Fastest FRT cycle period in ADC cycles
#define PWM_ADC_DEFAULT_PERIOD_CYCLES 20	// Choose a default number of ADC samples in a PWM period
#define PWM_ADC_MAXIMUM_PERIOD_CYCLES 200 	// Choose a maximum number of ADC samples in a PWM period (determines maximum PWM period)
#define ADC_COMMUTATE_BUF_DEPTH			(ADC_COMMUTATE_NUM_CHANNELS * PWM_ADC_MAXIMUM_PERIOD_CYCLES * 4) // TODO Check if this is sufficient!
#define PWM_FRT_DEFAULT_PERIOD_CYCLES 	(ADC_COMMUTATE_NUM_CHANNELS * ADC_PWM_DIVIDER * ADC_FRT_DEFAULT_PERIOD_CYCLES)
#define PWM_DEFAULT_PERIOD_CYCLES		(ADC_COMMUTATE_NUM_CHANNELS * ADC_PWM_DIVIDER * PWM_ADC_DEFAULT_PERIOD_CYCLES)
#define PWM_MAXIMUM_PERIOD_CYCLES		(ADC_COMMUTATE_NUM_CHANNELS * ADC_PWM_DIVIDER * PWM_ADC_MAXIMUM_PERIOD_CYCLES)
//FRT_DEFAULT_FREQUENCY = PWM_CLOCK_FREQUENCY / PWM_FRT_DEFAULT_PERIOD_CYCLES
#define PWM_DEFAULT_FREQUENCY			(PWM_CLOCK_FREQUENCY / PWM_DEFAULT_PERIOD_CYCLES)
//PWM_MINIMUM_FREQUENCY = (PWM_CLOCK_FREQUENCY / PWM_MAXIMUM_PERIOD_CYCLES)

// Fuer die Pulsmustererzeugung
#define N_PWM_CHANNELS 3
#define N_PWM_MAX_EDGES 16

//BEGIN altes Zeug: obsolet mit Timer-DMA #define WS2812_PWM_FREQUENCY    PWM_CLOCK_FREQUENCY                         /**< Clock frequency of PWM */
#define PWM_DMA_TRANSFER_PERIOD_TICKS	(10)                      /** DMA Transfer triggered after this number of PWM clock cycles */
#define PWM_DMA_CLOCK_FREQUENCY			(PWM_CLOCK_FREQUENCY / PWM_DMA_TRANSFER_PERIOD_TICKS)
#define PWM_DMA_MAXIMUM_PERIOD_CYCLES	(PWM_MAXIMUM_PERIOD_CYCLES / PWM_DMA_TRANSFER_PERIOD_TICKS)
#define PWM_DMA_DEFAULT_PERIOD_CYCLES	(PWM_DEFAULT_PERIOD_CYCLES / PWM_DMA_TRANSFER_PERIOD_TICKS)
//END altes Zeug

/*
 * Board-unabhängige Schnittstelle:
 */

/**
 * @brief   Return codes from ws2812 interface functions
 */
typedef enum {
    PWM_DMA_RUNNING      = 0x00,    /**PWM-DMA is running */
    PWM_DMA_STOPPED             /**<PWM-DMA stopped */
} pwm_dma_state_t;


typedef struct pwm_dma_s {
	uint16_t adc_frt_period_cycles;
};


/* --- PUBLIC FUNCTIONS ----------------------------------------------------- */

/**
 * @brief   Initialize the driver
 *
 * After this function is called, all necessary background tasks will be started.
 * The frame is initially dark.
 */
void pwm_dma_init(void);

/**
 * @brief   Write the value of a single LED in the chain
 *
 * The color value is written to a frame buffer, and will not
 * be updated until the next frame is written. Frames are written
 * at the maximum possible speed -- the longest latency between a
 * call to this function and the value being displayed is
 * 1.25uS*(24*@ref WS2812_LED_N + 50)
 *
 * @param[in] led_number:           The index of the LED to be written. Must be strictly less than
 *                                  @ref WS2812_N_LEDS
 * @param[in] r:                    The red level of the LED
 * @param[in] g:                    The green level of the LED
 * @param[in] b:                    The blue level of the LED
 *
 * @retval WS2812_SUCCESS:          The write was successful
 * @retval WS2812_LED_INVALID:      The write was to an invalid LED index
 */
int pwm_dma_setvals(uint8_t channel_number, uint16_t t_on, uint16_t offset, uint16_t period);

/** @} defgroup pwmdma */


void pwm_dma_init_2(void);
void pwm_dma_stop_2(void);
void pwm_dma_init_3(void);
void pwm_dma_stop_3(void);
void step_pwmdma_state_ptr();
uint16_t get__next_pwmdma_state__adc_frt_period_cycles();
//static int adcevaluate(void);


#endif /* SRC_PWMADCDMA_H_ */
