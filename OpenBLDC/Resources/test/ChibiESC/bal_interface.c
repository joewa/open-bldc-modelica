/*
 * bal_interface.c
 *
 *  Created on: 26.08.2016
 *      Author: joerg
 */

/*
 *
 * TERM.COMP
`USB_CDC_is_connected'
`USB_VCP_send_string'
 `USB_CDC_is_connected'
/tmp/ccPG4hgX.ltrans3.ltrans.o: In function `cmd':
term.comp:100: undefined reference to `load'
/tmp/ccPG4hgX.ltrans3.ltrans.o: In function `hal_start':
/home/joerg/repos/OpenBLDC/joewa/ChibiESC//bal.c:173: undefined reference to `hal_enable_frt'
/home/joerg/repos/OpenBLDC/joewa/ChibiESC//bal.c:175: undefined reference to `hal_enable_rt'
/tmp/ccPG4hgX.ltrans3.ltrans.o: In function `hal_stop':
/home/joerg/repos/OpenBLDC/joewa/ChibiESC//bal.c:181: undefined reference to `hal_disable_frt'
/home/joerg/repos/OpenBLDC/joewa/ChibiESC//bal.c:182: undefined reference to `hal_disable_rt'
/tmp/ccPG4hgX.ltrans3.ltrans.o: In function `cmd':
term.comp:100: undefined reference to `save'
/tmp/ccPG4hgX.ltrans3.ltrans.o: In function `hal_term_listhal':
/home/joerg/repos/OpenBLDC/joewa/ChibiESC//bal_term.c:15: undefined reference to `Wait'
/tmp/ccPG4hgX.ltrans7.ltrans.o: In function `function.12532.lto_priv.100':
term.comp:75: undefined reference to `hal_get_systick_value'
term.comp:75: undefined reference to `hal_get_systick_value'
term.comp:75: undefined reference to `hal_get_systick_reload'
term.comp:75: undefined reference to `hal_get_systick_freq'
term.comp:75: undefined reference to `mod'

*/


#include "bal_interface.h"


#ifdef SIM_TARGET
#include "siminterfaces.h"
#endif


/*
 * Returns (systick-) timer value, count-direction: down!
 * Systick interupt muss langsamer sein als langsamster HAL-Thread (RT)
 */
uint32_t hal_get_systick_value() {
	return chVTGetSystemTimeX();
}

/*
 * Value with which the (24-bit) systick is reloaded when zero
 */
uint32_t hal_get_systick_reload() {
	return 1000;
}

/*
 * Systick frequency in Hz
 */
uint32_t hal_get_systick_freq() {
	return CH_CFG_ST_FREQUENCY;
}

/*
 * load+save Laden und speichern der Konfiguration. Load wird bei start aufgerufen.
 */

int load() {
	return 0;
}

void save() {

}

void hal_conf_init(){
 //  FLASH_Unlock();
 //  EE_Init();
 //  FLASH_Lock();
}

int USB_CDC_is_connected() {
	return 1;
}
