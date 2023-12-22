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

#ifndef _BOARD_H_
#define _BOARD_H_

/*
 * Setup for STMicroelectronics STM32F4-Discovery board.
 */

/*
 * Board identifier (set in Makefile).
 */
# ifdef SIM_TARGET
#define GPIOA 0
#define GPIOB 1
#define GPIOC 2
#define GPIOD 3
#define GPIOH 4
#define GPIOI 5
#endif


#if defined(BOARD_LOOONG_STRIP_F4)
#define BOARD_NAME					"BOARD_LOOONG_STRIP_F4"
#endif
#if defined(BOARD_LOOONG_STRIP_F7)
#define BOARD_NAME					"BOARD_LOOONG_STRIP_F7"
#endif
#if defined(BOARD_DRCHIBI_DISCO)
#define BOARD_NAME					"BOARD_DRCHIBI_DISCO"
#endif
#if defined(BOARD_NUCLEO_F446)
#define BOARD_NAME					"BOARD_NUCLEO_F446"
#endif
#if defined(BOARD_VESC)
#define BOARD_NAME					"BOARD_VESC"
#endif

/*
 * Board oscillators-related settings.
 * NOTE: LSE not fitted.
 */
#if !defined(STM32_LSECLK)
#define STM32_LSECLK                0U
#endif

#if !defined(STM32_HSECLK)
#define STM32_HSECLK                8000000U
#endif

/*
 * Board voltages.
 * Required for performance limits calculation.
 */
#define STM32_VDD                   300U

/*
 * MCU type as defined in the ST header.
 */
#if defined(BOARD_DRCHIBI_DISCO)
#define STM32F407xx
#endif

#if defined(BOARD_LOOONG_STRIP_F4) || defined(BOARD_VESC)
#define STM32F405xx
#endif

#if defined(BOARD_LOOONG_STRIP_F7)
#define STM32F722xx
#endif

#if defined(BOARD_NUCLEO_F446)
#define STM32F446xx
#endif

// Looong-Strip and VESC do not have USB-VBUSSENS wire connected (never master)
#if defined(BOARD_LOOONG_STRIP_F4) || defined(BOARD_VESC)
// TODO: NRT function blocks as long as USB is NOT connected!
#define BOARD_OTG_NOVBUSSENS
#endif


/*
 * IO pins assignments.
 */
#define GPIOA_PIN0                  0U
#define GPIOA_PIN1                  1U
#define GPIOA_PIN2                  2U
#define GPIOA_PIN3                  3U
#define GPIOA_PIN4                  4U
#define GPIOA_PIN5                  5U
#define GPIOA_PIN6                  6U
#define GPIOA_PIN7                  7U
#define GPIOA_PIN8                  8U
#define GPIOA_PIN9                  9U
#define GPIOA_PIN10                 10U
#define GPIOA_PIN11                 11U
#define GPIOA_PIN12                 12U
#define GPIOA_PIN13                 13U
#define GPIOA_PIN14                 14U
#define GPIOA_PIN15                 15U

#define GPIOB_PIN0                  0U
#define GPIOB_PIN1                  1U
#define GPIOB_PIN2                  2U
#define GPIOB_PIN3                  3U
#define GPIOB_PIN4                  4U
#define GPIOB_PIN5                  5U
#define GPIOB_PIN6                  6U
#define GPIOB_PIN7                  7U
#define GPIOB_PIN8                  8U
#define GPIOB_PIN9                  9U
#define GPIOB_PIN10                 10U
#define GPIOB_PIN11                 11U
#define GPIOB_PIN12                 12U
#define GPIOB_PIN13                 13U
#define GPIOB_PIN14                 14U
#define GPIOB_PIN15                 15U

#define GPIOC_PIN0                  0U
#define GPIOC_PIN1                  1U
#define GPIOC_PIN2                  2U
#define GPIOC_PIN3                  3U
#define GPIOC_PIN4                  4U
#define GPIOC_PIN5                  5U
#define GPIOC_PIN6                  6U
#define GPIOC_PIN7                  7U
#define GPIOC_PIN8                  8U
#define GPIOC_PIN9                  9U
#define GPIOC_PIN10                 10U
#define GPIOC_PIN11                 11U
#define GPIOC_PIN12                 12U
#define GPIOC_PIN13                 13U
#define GPIOC_PIN14                 14U
#define GPIOC_PIN15                 15U

#define GPIOD_PIN0                  0U
#define GPIOD_PIN1                  1U
#define GPIOD_PIN2                  2U
#define GPIOD_PIN3                  3U
#define GPIOD_PIN4                  4U
#define GPIOD_PIN5                  5U
#define GPIOD_PIN6                  6U
#define GPIOD_PIN7                  7U
#define GPIOD_PIN8                  8U
#define GPIOD_PIN9                  9U
#define GPIOD_PIN10                 10U
#define GPIOD_PIN11                 11U
#define GPIOD_PIN12                 12U
#define GPIOD_PIN13                 13U
#define GPIOD_PIN14                 14U
#define GPIOD_PIN15                 15U

#define GPIOE_PIN0                  0U
#define GPIOE_PIN1                  1U
#define GPIOE_PIN2                  2U
#define GPIOE_PIN3                  3U
#define GPIOE_PIN4                  4U
#define GPIOE_PIN5                  5U
#define GPIOE_PIN6                  6U
#define GPIOE_PIN7                  7U
#define GPIOE_PIN8                  8U
#define GPIOE_PIN9                  9U
#define GPIOE_PIN10                 10U
#define GPIOE_PIN11                 11U
#define GPIOE_PIN12                 12U
#define GPIOE_PIN13                 13U
#define GPIOE_PIN14                 14U
#define GPIOE_PIN15                 15U

#define GPIOF_PIN0                  0U
#define GPIOF_PIN1                  1U
#define GPIOF_PIN2                  2U
#define GPIOF_PIN3                  3U
#define GPIOF_PIN4                  4U
#define GPIOF_PIN5                  5U
#define GPIOF_PIN6                  6U
#define GPIOF_PIN7                  7U
#define GPIOF_PIN8                  8U
#define GPIOF_PIN9                  9U
#define GPIOF_PIN10                 10U
#define GPIOF_PIN11                 11U
#define GPIOF_PIN12                 12U
#define GPIOF_PIN13                 13U
#define GPIOF_PIN14                 14U
#define GPIOF_PIN15                 15U

#define GPIOG_PIN0                  0U
#define GPIOG_PIN1                  1U
#define GPIOG_PIN2                  2U
#define GPIOG_PIN3                  3U
#define GPIOG_PIN4                  4U
#define GPIOG_PIN5                  5U
#define GPIOG_PIN6                  6U
#define GPIOG_PIN7                  7U
#define GPIOG_PIN8                  8U
#define GPIOG_PIN9                  9U
#define GPIOG_PIN10                 10U
#define GPIOG_PIN11                 11U
#define GPIOG_PIN12                 12U
#define GPIOG_PIN13                 13U
#define GPIOG_PIN14                 14U
#define GPIOG_PIN15                 15U

#define GPIOH_PIN0                  0U
#define GPIOH_PIN1                  1U
#define GPIOH_PIN2                  2U
#define GPIOH_PIN3                  3U
#define GPIOH_PIN4                  4U
#define GPIOH_PIN5                  5U
#define GPIOH_PIN6                  6U
#define GPIOH_PIN7                  7U
#define GPIOH_PIN8                  8U
#define GPIOH_PIN9                  9U
#define GPIOH_PIN10                 10U
#define GPIOH_PIN11                 11U
#define GPIOH_PIN12                 12U
#define GPIOH_PIN13                 13U
#define GPIOH_PIN14                 14U
#define GPIOH_PIN15                 15U

#define GPIOI_PIN0                  0U
#define GPIOI_PIN1                  1U
#define GPIOI_PIN2                  2U
#define GPIOI_PIN3                  3U
#define GPIOI_PIN4                  4U
#define GPIOI_PIN5                  5U
#define GPIOI_PIN6                  6U
#define GPIOI_PIN7                  7U
#define GPIOI_PIN8                  8U
#define GPIOI_PIN9                  9U
#define GPIOI_PIN10                 10U
#define GPIOI_PIN11                 11U
#define GPIOI_PIN12                 12U
#define GPIOI_PIN13                 13U
#define GPIOI_PIN14                 14U
#define GPIOI_PIN15                 15U

/*
 * DrChibi Looong-Strip pin mapping
 */
#if defined(BOARD_LOOONG_STRIP_F4) || defined(BOARD_LOOONG_STRIP_F7)

#define PIN_VSENS_C					GPIOA_PIN0
#define BANK_VSENS_C				GPIOA
#define PIN_PWM_F					GPIOA_PIN1
#define BANK_PWM_F					GPIOA
#define PIN_VSENS_A					GPIOA_PIN2
#define BANK_VSENS_A				GPIOA
#define PIN_VSENS_D					GPIOA_PIN3
#define BANK_VSENS_D				GPIOA
#define PIN_VSENS_E					GPIOA_PIN4
#define BANK_VSENS_E				GPIOA
#define PIN_VSENS_F					GPIOA_PIN5
#define BANK_VSENS_F				GPIOA
#define PIN_CSENS_F					GPIOA_PIN6
#define BANK_CSENS_F				GPIOA
#define PIN_CSENS_E					GPIOA_PIN7
#define BANK_CSENS_E				GPIOA
#define PIN_PWM_C_HS				GPIOA_PIN8
#define BANK_PWM_C_HS				GPIOA
#define PIN_PWM_C					GPIOA_PIN8
#define BANK_PWM_C					GPIOA
#define PIN_PWM_B_HS				GPIOA_PIN9
#define BANK_PWM_B_HS				GPIOA
#define PIN_PWM_B					GPIOA_PIN9
#define BANK_PWM_B					GPIOA
#define PIN_PWM_A_HS				GPIOA_PIN10
#define BANK_PWM_A_HS				GPIOA
#define PIN_PWM_A					GPIOA_PIN10
#define BANK_PWM_A					GPIOA
#define PIN_USB_DM					GPIOA_PIN11
#define BANK_USB_DM					GPIOA
#define PIN_USB_DP					GPIOA_PIN12
#define BANK_USB_DP					GPIOA
#define PIN_SWDIO					GPIOA_PIN13
#define BANK_SWDIO					GPIOA
#define PIN_SWDCLK					GPIOA_PIN14
#define BANK_SWDCLK					GPIOA
#define PIN_ZCD						GPIOA_PIN15
#define BANK_ZCD					GPIOA

#define PIN_CSENS_B					GPIOB_PIN0
#define BANK_CSENS_B				GPIOB
#define PIN_CSENS_A					GPIOB_PIN1
#define BANK_CSENS_A				GPIOB
#define PIN_PB2						GPIOB_PIN2
#define BANK_PB2					GPIOB
#define PIN_TRACESWO				GPIOB_PIN3
#define BANK_TRACESWO				GPIOB
#define PIN_ENABLE_E				GPIOB_PIN4
#define BANK_ENABLE_E				GPIOB
#define PIN_ENABLE_F				GPIOB_PIN5
#define BANK_ENABLE_F				GPIOB
#define PIN_I2C_SCL					GPIOB_PIN6
#define BANK_I2C_SCL				GPIOB
#define PIN_I2C_SDA					GPIOB_PIN7
#define BANK_I2C_SDA				GPIOB
#define PIN_CAN_RX					GPIOB_PIN8
#define BANK_CAN_RX					GPIOB
#define PIN_CAN_TX					GPIOB_PIN9
#define BANK_CAN_TX					GPIOB
#define PIN_PWM_E					GPIOB_PIN10
#define BANK_PWM_E					GPIOB
#define PIN_PWM_D					GPIOB_PIN11
#define BANK_PWM_D					GPIOB
#define PIN_THWN					GPIOB_PIN12
#define BANK_THWN					GPIOB
#define PIN_PWM_C_LS				GPIOB_PIN13
#define BANK_PWM_C_LS				GPIOB
#define PIN_ENABLE_C				GPIOB_PIN13
#define BANK_ENABLE_C				GPIOB
#define PIN_PWM_B_LS				GPIOB_PIN14
#define BANK_PWM_B_LS				GPIOB
#define PIN_ENABLE_B				GPIOB_PIN14
#define BANK_ENABLE_B				GPIOB
#define PIN_PWM_A_LS				GPIOB_PIN15
#define BANK_PWM_A_LS				GPIOB
#define PIN_ENABLE_A				GPIOB_PIN15
#define BANK_ENABLE_A				GPIOB

#define PIN_VSENS_Y2				GPIOC_PIN0
#define BANK_VSENS_Y2				GPIOC
#define PIN_VSENS_Y1				GPIOC_PIN1
#define BANK_VSENS_Y1				GPIOC
#define PIN_CSENS_C					GPIOC_PIN2
#define BANK_CSENS_C				GPIOC
#define PIN_EXT						GPIOC_PIN2
#define BANK_EXT					GPIOC
#define PIN_VSENS_B					GPIOC_PIN3
#define BANK_VSENS_B				GPIOC
#define PIN_CSENS_D					GPIOC_PIN4
#define BANK_CSENS_D				GPIOC
#define PIN_PC5						GPIOC_PIN5
#define BANK_PC5					GPIOC
#define PIN_USART_TX				GPIOC_PIN6
#define BANK_USART_TX				GPIOC
#define PIN_USART_RX				GPIOC_PIN7
#define BANK_USART_RX				GPIOC
#define PIN_USART_CK				GPIOC_PIN8
#define BANK_USART_CK				GPIOC
#define PIN_PWM_IN2					GPIOC_PIN8
#define BANK_PWM_IN2				GPIOC
#define PIN_PWM_IN1					GPIOC_PIN9
#define BANK_PWM_IN1				GPIOC
#define PIN_SPI_SCK					GPIOC_PIN10
#define BANK_SPI_SCK				GPIOC
#define PIN_SPI_MISO				GPIOC_PIN11
#define BANK_SPI_MISO				GPIOC
#define PIN_SPI_MOSI				GPIOC_PIN12
#define BANK_SPI_MOSI				GPIOC
#define PIN_LED1					GPIOC_PIN13
#define BANK_LED1					GPIOC
#define PIN_LED_RED					GPIOC_PIN13
#define BANK_LED_RED				GPIOC
#define PIN_LED2					GPIOC_PIN14
#define BANK_LED2					GPIOC
#define PIN_LED_GREEN				GPIOC_PIN14
#define BANK_LED_GREEN				GPIOC
#define PIN_FAULTC					GPIOC_PIN15
#define BANK_FAULTC					GPIOC

#define PIN_ENABLE_D				GPIOD_PIN2
#define BANK_ENABLE_D				GPIOD

#define PIN_OSC_IN					GPIOH_PIN0
#define BANK_OSC_IN					GPIOH
#define PIN_OSC_OUT					GPIOH_PIN1
#define BANK_OSC_OUT				GPIOH

#endif // BOARD_LOOONG_STRIP_F4 || BOARD_LOOONG_STRIP_F7

/*
 * DrChibi on F4Discovery pin mapping
 */
#if defined(BOARD_DRCHIBI_DISCO)

#define PIN_VSENS_C					GPIOA_PIN0
#define BANK_VSENS_C				GPIOA
#define PIN_PWM_A					GPIOA_PIN1
#define BANK_PWM_A					GPIOA
#define PIN_VSENS_A					GPIOA_PIN2
#define BANK_VSENS_A				GPIOA
#define PIN_VSENS_D					GPIOA_PIN3
#define BANK_VSENS_D				GPIOA
#define PIN_VSENS_E					GPIOA_PIN4
#define BANK_VSENS_E				GPIOA
#define PIN_VSENS_F					GPIOA_PIN5
#define BANK_VSENS_F				GPIOA
#define PIN_CSENS_F					GPIOA_PIN6
#define BANK_CSENS_F				GPIOA
#define PIN_CSENS_E					GPIOA_PIN7
#define BANK_CSENS_E				GPIOA
#define PIN_PWM_C					GPIOA_PIN8
#define BANK_PWM_C					GPIOA
#define PIN_VBUS_FS					GPIOA_PIN9
#define BANK_VBUS_FS				GPIOA
#define PIN_OTG_FS_ID				GPIOA_PIN10
#define BANK_OTG_FS_ID				GPIOA
#define PIN_USB_DM					GPIOA_PIN11
#define BANK_USB_DM					GPIOA
#define PIN_USB_DP					GPIOA_PIN12
#define BANK_USB_DP					GPIOA
#define PIN_SWDIO					GPIOA_PIN13
#define BANK_SWDIO					GPIOA
#define PIN_SWDCLK					GPIOA_PIN14
#define BANK_SWDCLK					GPIOA
#define PIN_PWM_B					GPIOA_PIN15
#define BANK_PWM_B					GPIOA
//#define PIN_ZCD						GPIOA_PIN15
//#define BANK_ZCD					GPIOA

#define PIN_CSENS_B					GPIOB_PIN0
#define BANK_CSENS_B				GPIOB
#define PIN_CSENS_A					GPIOB_PIN1
#define BANK_CSENS_A				GPIOB
#define PIN_THWN					GPIOB_PIN2
#define BANK_THWN					GPIOB
#define PIN_TRACESWO				GPIOB_PIN3
#define BANK_TRACESWO				GPIOB
#define PIN_ENABLE_E				GPIOB_PIN4
#define BANK_ENABLE_E				GPIOB
#define PIN_ENABLE_F				GPIOB_PIN5
#define BANK_ENABLE_F				GPIOB
#define PIN_I2C_SCL					GPIOB_PIN6
#define BANK_I2C_SCL				GPIOB
#define PIN_I2C_SDA					GPIOB_PIN7
#define BANK_I2C_SDA				GPIOB
#define PIN_PB8						GPIOB_PIN8
#define BANK_PB8					GPIOB
#define PIN_PB9						GPIOB_PIN9
#define BANK_PB9					GPIOB
#define PIN_PWM_E					GPIOB_PIN10
#define BANK_PWM_E					GPIOB
#define PIN_PWM_D					GPIOB_PIN11
#define BANK_PWM_D					GPIOB
#define PIN_PB12					GPIOB_PIN12
#define BANK_PB12					GPIOB
#define PIN_PWM_C_LS				GPIOB_PIN13
#define BANK_PWM_C_LS				GPIOB
#define PIN_ENABLE_C				GPIOB_PIN13
#define BANK_ENABLE_C				GPIOB
#define PIN_PWM_B_LS				GPIOB_PIN14
#define BANK_PWM_B_LS				GPIOB
#define PIN_ENABLE_B				GPIOB_PIN14
#define BANK_ENABLE_B				GPIOB
#define PIN_PWM_F_LS				GPIOB_PIN15
#define BANK_PWM_F_LS				GPIOB
#define PIN_ENABLE_A				GPIOB_PIN15
#define BANK_ENABLE_A				GPIOB

#define PIN_OTG_FS_POWER_ON			GPIOC_PIN0
#define BANK_OTG_FS_POWER_ON		GPIOC
#define PIN_VSENS_Y1				GPIOC_PIN1
#define BANK_VSENS_Y1				GPIOC
#define PIN_VSENS_BAT				GPIOC_PIN2
#define BANK_VSENS_BAT				GPIOC
#define PIN_EXT						GPIOC_PIN2
#define BANK_EXT					GPIOC
#define PIN_VSENS_B					GPIOC_PIN3
#define BANK_VSENS_B				GPIOC
#define PIN_CSENS_D					GPIOC_PIN4
#define BANK_CSENS_D				GPIOC
#define PIN_CSENS_C					GPIOC_PIN5
#define BANK_CSENS_C				GPIOC
#define PIN_USART_TX				GPIOC_PIN6
#define BANK_USART_TX				GPIOC
#define PIN_USART_RX				GPIOC_PIN7
#define BANK_USART_RX				GPIOC
#define PIN_USART_CK				GPIOC_PIN8
#define BANK_USART_CK				GPIOC
#define PIN_PWM_IN2					GPIOC_PIN8
#define BANK_PWM_IN2				GPIOC
#define PIN_PWM_IN1					GPIOC_PIN9
#define BANK_PWM_IN1				GPIOC
#define PIN_SPI_SCK					GPIOC_PIN10
#define BANK_SPI_SCK				GPIOC
#define PIN_SPI_MISO				GPIOC_PIN11
#define BANK_SPI_MISO				GPIOC
#define PIN_SPI_MOSI				GPIOC_PIN12
#define BANK_SPI_MOSI				GPIOC
#define PIN_PC13					GPIOC_PIN13
#define BANK_PC13					GPIOC
#define PIN_PC14					GPIOC_PIN14
#define BANK_PC14					GPIOC
#define PIN_PC15					GPIOC_PIN15
#define BANK_PC15					GPIOC

#define PIN_CAN_RX					GPIOD_PIN0
#define BANK_CAN_RX					GPIOD
#define PIN_CAN_TX					GPIOD_PIN1
#define BANK_CAN_TX					GPIOD
#define PIN_ENABLE_D				GPIOD_PIN2
#define BANK_ENABLE_D				GPIOD
#define PIN_PD3						GPIOD_PIN3
#define BANK_PD3					GPIOD
#define PIN_RESET					GPIOD_PIN4
#define BANK_RESET					GPIOD
#define PIN_OVER_CURRENT			GPIOD_PIN5
#define BANK_OVER_CURRENT			GPIOD
#define PIN_PD6						GPIOD_PIN6
#define BANK_PD6					GPIOD
#define PIN_PD7						GPIOD_PIN7
#define BANK_PD7					GPIOD
#define PIN_PD8						GPIOD_PIN8
#define BANK_PD8					GPIOD
#define PIN_PD9						GPIOD_PIN9
#define BANK_PD9					GPIOD
#define PIN_PD10					GPIOD_PIN10
#define BANK_PD10					GPIOD
#define PIN_PD11					GPIOD_PIN11
#define BANK_PD11					GPIOD
#define PIN_LED2					GPIOD_PIN12
#define BANK_LED2					GPIOD
#define PIN_LED_GREEN				GPIOD_PIN12
#define BANK_LED_GREEN				GPIOD
#define PIN_LED3_DISCO				GPIOD_PIN13
#define BANK_LED3_DISCO				GPIOD
#define PIN_LED_ORANGE_DISCO		GPIOD_PIN13
#define BANK_LED_ORANGE_DISCO		GPIOD
#define PIN_LED1					GPIOD_PIN14
#define BANK_LED1					GPIOD
#define PIN_LED_RED					GPIOD_PIN14
#define BANK_LED_RED				GPIOD
#define PIN_FAULTC					GPIOD_PIN15
#define BANK_FAULTC					GPIOD

#define PIN_PE0						GPIOE_PIN0
#define BANK_PE0					GPIOE
#define PIN_PE1						GPIOE_PIN1
#define BANK_PE1					GPIOE
#define PIN_PE2						GPIOE_PIN2
#define BANK_PE2					GPIOE
#define PIN_PE3						GPIOE_PIN3
#define BANK_PE3					GPIOE
#define PIN_PE4						GPIOE_PIN4
#define BANK_PE4					GPIOE
#define PIN_PE5						GPIOE_PIN5
#define BANK_PE5					GPIOE
#define PIN_PE6						GPIOE_PIN6
#define BANK_PE6					GPIOE
#define PIN_PE7						GPIOE_PIN7
#define BANK_PE7					GPIOE
#define PIN_PE8						GPIOE_PIN8
#define BANK_PE8					GPIOE
#define PIN_PWM_C_HS				GPIOE_PIN9
#define BANK_PWM_C_HS				GPIOE
#define PIN_PE10					GPIOE_PIN10
#define BANK_PE10					GPIOE
#define PIN_PWM_B_HS				GPIOE_PIN11
#define BANK_PWM_B_HS				GPIOE
#define PIN_PE12					GPIOE_PIN12
#define BANK_PE12					GPIOE
#define PIN_PWM_F_HS				GPIOE_PIN13
#define BANK_PWM_F_HS				GPIOE
#define PIN_PE14					GPIOE_PIN14
#define BANK_PE14					GPIOE
#define PIN_PE15					GPIOE_PIN15
#define BANK_PE15					GPIOE

#define PIN_PF0						GPIOF_PIN0
#define BANK_PF0					GPIOF
#define PIN_PF1						GPIOF_PIN1
#define BANK_PF1					GPIOF
#define PIN_PF2						GPIOF_PIN2
#define BANK_PF2					GPIOF
#define PIN_PF3						GPIOF_PIN3
#define BANK_PF3					GPIOF
#define PIN_PF4						GPIOF_PIN4
#define BANK_PF4					GPIOF
#define PIN_PF5						GPIOF_PIN5
#define BANK_PF5					GPIOF
#define PIN_PF6						GPIOF_PIN6
#define BANK_PF6					GPIOF
#define PIN_PF7						GPIOF_PIN7
#define BANK_PF7					GPIOF
#define PIN_PF8						GPIOF_PIN8
#define BANK_PF8					GPIOF
#define PIN_PF9						GPIOF_PIN9
#define BANK_PF9					GPIOF
#define PIN_PF10					GPIOF_PIN10
#define BANK_PF10					GPIOF
#define PIN_PF11					GPIOF_PIN11
#define BANK_PF11					GPIOF
#define PIN_PF12					GPIOF_PIN12
#define BANK_PF12					GPIOF
#define PIN_PF13					GPIOF_PIN13
#define BANK_PF13					GPIOF
#define PIN_PF14					GPIOF_PIN14
#define BANK_PF14					GPIOF
#define PIN_PF15					GPIOF_PIN15
#define BANK_PF15					GPIOF

#define PIN_PG0						GPIOG_PIN0
#define BANK_PG0					GPIOG
#define PIN_PG1						GPIOG_PIN1
#define BANK_PG1					GPIOG
#define PIN_PG2						GPIOG_PIN2
#define BANK_PG2					GPIOG
#define PIN_PG3						GPIOG_PIN3
#define BANK_PG3					GPIOG
#define PIN_PG4						GPIOG_PIN4
#define BANK_PG4					GPIOG
#define PIN_PG5						GPIOG_PIN5
#define BANK_PG5					GPIOG
#define PIN_PG6						GPIOG_PIN6
#define BANK_PG6					GPIOG
#define PIN_PG7						GPIOG_PIN7
#define BANK_PG7					GPIOG
#define PIN_PG8						GPIOG_PIN8
#define BANK_PG8					GPIOG
#define PIN_PG9						GPIOG_PIN9
#define BANK_PG9					GPIOG
#define PIN_PG10					GPIOG_PIN10
#define BANK_PG10					GPIOG
#define PIN_PG11					GPIOG_PIN11
#define BANK_PG11					GPIOG
#define PIN_PG12					GPIOG_PIN12
#define BANK_PG12					GPIOG
#define PIN_PG13					GPIOG_PIN13
#define BANK_PG13					GPIOG
#define PIN_PG14					GPIOG_PIN14
#define BANK_PG14					GPIOG
#define PIN_PG15					GPIOG_PIN15
#define BANK_PG15					GPIOG

#define PIN_OSC_IN					GPIOH_PIN0
#define BANK_OSC_IN					GPIOH
#define PIN_OSC_OUT					GPIOH_PIN1
#define BANK_OSC_OUT				GPIOH
#define PIN_PH2						GPIOH_PIN2
#define BANK_PH2					GPIOH
#define PIN_PH3						GPIOH_PIN3
#define BANK_PH3					GPIOH
#define PIN_PH4						GPIOH_PIN4
#define BANK_PH4					GPIOH
#define PIN_PH5						GPIOH_PIN5
#define BANK_PH5					GPIOH
#define PIN_PH6						GPIOH_PIN6
#define BANK_PH6					GPIOH
#define PIN_PH7						GPIOH_PIN7
#define BANK_PH7					GPIOH
#define PIN_PH8						GPIOH_PIN8
#define BANK_PH8					GPIOH
#define PIN_PH9						GPIOH_PIN9
#define BANK_PH9					GPIOH
#define PIN_PH10					GPIOH_PIN10
#define BANK_PH10					GPIOH
#define PIN_PH11					GPIOH_PIN11
#define BANK_PH11					GPIOH
#define PIN_PH12					GPIOH_PIN12
#define BANK_PH12					GPIOH
#define PIN_PH13					GPIOH_PIN13
#define BANK_PH13					GPIOH
#define PIN_PH14					GPIOH_PIN14
#define BANK_PH14					GPIOH
#define PIN_PH15					GPIOH_PIN15
#define BANK_PH15					GPIOH

#define PIN_PI0						GPIOI_PIN0
#define BANK_PI0					GPIOI
#define PIN_PI1						GPIOI_PIN1
#define BANK_PI1					GPIOI
#define PIN_PI2						GPIOI_PIN2
#define BANK_PI2					GPIOI
#define PIN_PI3						GPIOI_PIN3
#define BANK_PI3					GPIOI
#define PIN_PI4						GPIOI_PIN4
#define BANK_PI4					GPIOI
#define PIN_PI5						GPIOI_PIN5
#define BANK_PI5					GPIOI
#define PIN_PI6						GPIOI_PIN6
#define BANK_PI6					GPIOI
#define PIN_PI7						GPIOI_PIN7
#define BANK_PI7					GPIOI
#define PIN_PI8						GPIOI_PIN8
#define BANK_PI8					GPIOI
#define PIN_PI9						GPIOI_PIN9
#define BANK_PI9					GPIOI
#define PIN_PI10					GPIOI_PIN10
#define BANK_PI10					GPIOI
#define PIN_PI11					GPIOI_PIN11
#define BANK_PI11					GPIOI
#define PIN_PI12					GPIOI_PIN12
#define BANK_PI12					GPIOI
#define PIN_PI13					GPIOI_PIN13
#define BANK_PI13					GPIOI
#define PIN_PI14					GPIOI_PIN14
#define BANK_PI14					GPIOI
#define PIN_PI15					GPIOI_PIN15
#define BANK_PI15					GPIOI

#endif // BOARD_DRCHIBI_DISCO

#if defined(BOARD_NUCLEO_F446)

#define PIN_CSENS_A					GPIOA_PIN0
#define BANK_CSENS_A				GPIOA
#define PIN_VSENS_BAT				GPIOA_PIN1
#define BANK_VSENS_BAT				GPIOA
#define PIN_VSENS_Y1				GPIOA_PIN2
#define BANK_VSENS_Y1				GPIOA
#define PIN_PA3						GPIOA_PIN3
#define BANK_PA3					GPIOA
#define PIN_PA4						GPIOA_PIN4
#define BANK_PA4					GPIOA
#define PIN_LED2					GPIOA_PIN5
#define BANK_LED2					GPIOA
#define PIN_LED_GREEN				GPIOA_PIN5
#define BANK_LED_GREEN				GPIOA
#define PIN_DRIVER_ENABLE_NUCLEO	GPIOA_PIN6
#define BANK_DRIVER_ENABLE_NUCLEO	GPIOA
#define PIN_VSENS_C					GPIOA_PIN7
#define BANK_VSENS_C				GPIOA
#define PIN_PWM_A					GPIOA_PIN8
#define BANK_PWM_A					GPIOA
#define PIN_PWM_B					GPIOA_PIN9
#define BANK_PWM_B					GPIOA
#define PIN_PWM_C					GPIOA_PIN10
#define BANK_PWM_C					GPIOA
#define PIN_USB_DM					GPIOA_PIN11
#define BANK_USB_DM					GPIOA
#define PIN_USB_DP					GPIOA_PIN12
#define BANK_USB_DP					GPIOA
#define PIN_SWDIO					GPIOA_PIN13
#define BANK_SWDIO					GPIOA
#define PIN_SWDCLK					GPIOA_PIN14
#define BANK_SWDCLK					GPIOA
#define PIN_PA15					GPIOA_PIN15
#define BANK_PA15					GPIOA

#define PIN_VSENS_B					GPIOB_PIN0
#define BANK_VSENS_B				GPIOB
#define PIN_POTI_NUCLEO				GPIOB_PIN1
#define BANK_POTI_NUCLEO			GPIOB
#define PIN_LED1					GPIOB_PIN2
#define BANK_LED1					GPIOB
#define PIN_LED_RED					GPIOB_PIN2
#define BANK_LED_RED				GPIOB
#define PIN_TRACESWO				GPIOB_PIN3
#define BANK_TRACESWO				GPIOB
#define PIN_PB4						GPIOB_PIN4
#define BANK_PB4					GPIOB
#define PIN_PB5						GPIOB_PIN5
#define BANK_PB5					GPIOB
#define PIN_I2C_SCL					GPIOB_PIN6
#define BANK_I2C_SCL				GPIOB
#define PIN_I2C_SDA					GPIOB_PIN7
#define BANK_I2C_SDA				GPIOB
#define PIN_CAN_RX					GPIOB_PIN8
#define BANK_CAN_RX					GPIOB
#define PIN_CAN_TX					GPIOB_PIN9
#define BANK_CAN_TX					GPIOB
#define PIN_PWM_E					GPIOB_PIN10
#define BANK_PWM_E					GPIOB
#define PIN_PB11					GPIOB_PIN11
#define BANK_PB11					GPIOB
#define PIN_PB12					GPIOB_PIN12
#define BANK_PB12					GPIOB
#define PIN_PB13					GPIOB_PIN13
#define BANK_PB13					GPIOB
#define PIN_THWN					GPIOB_PIN14
#define BANK_THWN					GPIOB
#define PIN_FAULTC					GPIOB_PIN14
#define BANK_FAULTC					GPIOB
#define PIN_PB15					GPIOB_PIN15
#define BANK_PB15					GPIOB

#define PIN_CSENS_C					GPIOC_PIN0
#define BANK_CSENS_C				GPIOC
#define PIN_CSENS_B					GPIOC_PIN1
#define BANK_CSENS_B				GPIOC
#define PIN_DRIVER_TEMP_NUCLEO		GPIOC_PIN2
#define BANK_DRIVER_TEMP_NUCLEO		GPIOC
#define PIN_VSENS_A					GPIOC_PIN3
#define BANK_VSENS_A				GPIOC
#define PIN_PC4						GPIOC_PIN4
#define BANK_PC4					GPIOC
#define PIN_PC5						GPIOC_PIN5
#define BANK_PC5					GPIOC
#define PIN_USART_TX				GPIOC_PIN6
#define BANK_USART_TX				GPIOC
#define PIN_USART_RX				GPIOC_PIN7
#define BANK_USART_RX				GPIOC
#define PIN_USART_CK				GPIOC_PIN8
#define BANK_USART_CK				GPIOC
#define PIN_PWM_IN2					GPIOC_PIN8
#define BANK_PWM_IN2				GPIOC
#define PIN_PWM_IN1					GPIOC_PIN9
#define BANK_PWM_IN1				GPIOC
#define PIN_ENABLE_A				GPIOC_PIN10
#define BANK_EABLE_A				GPIOC
#define PIN_ENABLE_B				GPIOC_PIN11
#define BANK_ENABLE_B				GPIOC
#define PIN_ENABLE_C				GPIOC_PIN12
#define BANK_ENABLE_C				GPIOC
#define PIN_PC13					GPIOC_PIN13
#define BANK_PC13					GPIOC
#define PIN_PC14					GPIOC_PIN14
#define BANK_PC14					GPIOC
#define PIN_PC15					GPIOC_PIN15
#define BANK_PC15					GPIOC

#define PIN_PD2						GPIOD_PIN2
#define BANK_PD2					GPIOD

#define PIN_OSC_IN					GPIOH_PIN0
#define BANK_OSC_IN					GPIOH
#define PIN_OSC_OUT					GPIOH_PIN1
#define BANK_OSC_OUT				GPIOH

#endif // BOARD_NUCLEO_F446

#if defined(BOARD_VESC)

#define PIN_VSENS_C					GPIOA_PIN0 	//OK
#define BANK_VSENS_C				GPIOA		//OK
#define PIN_VSENS_B					GPIOA_PIN1	//OK
#define BANK_VSENS_C				GPIOA		//OK
#define PIN_VSENS_A					GPIOA_PIN2	//OK
#define BANK_VSENS_A				GPIOA		//OK
#define PIN_TEMPSENS				GPIOA_PIN3	//OK
#define BANK_TEMPSENS				GPIOA		//OK
#define PIN_VSENS_E					GPIOA_PIN4	//
#define BANK_VSENS_E				GPIOA		//
#define PIN_VSENS_F					GPIOA_PIN5	//
#define BANK_VSENS_F				GPIOA		//
#define PIN_CSENS_F					GPIOA_PIN6	//
#define BANK_CSENS_F				GPIOA		//
#define PIN_CSENS_E					GPIOA_PIN7	//
#define BANK_CSENS_E				GPIOA		//
#define PIN_PWM_C_HS				GPIOA_PIN8	//OK
#define BANK_PWM_C_HS				GPIOA		//OK
#define PIN_PWM_B_HS				GPIOA_PIN9	//OK
#define BANK_PWM_B_HS				GPIOA		//OK
#define PIN_PWM_A_HS				GPIOA_PIN10	//OK
#define BANK_PWM_A_HS				GPIOA		//OK
#define PIN_USB_DM					GPIOA_PIN11	//OK
#define BANK_USB_DM					GPIOA		//OK
#define PIN_USB_DP					GPIOA_PIN12	//OK
#define BANK_USB_DP					GPIOA		//OK
#define PIN_SWDIO					GPIOA_PIN13	//OK
#define BANK_SWDIO					GPIOA		//OK
#define PIN_SWDCLK					GPIOA_PIN14	//OK
#define BANK_SWDCLK					GPIOA		//OK
#define PIN_PA15					GPIOA_PIN15	//OK
#define BANK_PA15					GPIOA		//OK

#define PIN_CSENS_B					GPIOB_PIN0	//OK
#define BANK_CSENS_B				GPIOB		//OK
#define PIN_CSENS_A					GPIOB_PIN1	//OK
#define BANK_CSENS_A				GPIOB		//OK
#define PIN_PB2						GPIOB_PIN2	//OK
#define BANK_PB2					GPIOB		//OK
#define PIN_TRACESWO				GPIOB_PIN3	//NC
#define BANK_TRACESWO				GPIOB		//NC
#define PIN_PB4						GPIOB_PIN4	//OK
#define BANK_PB4					GPIOB		//OK
#define PIN_SERVO					GPIOB_PIN5	//OK
#define BANK_SERVO					GPIOB		//OK
#define PIN_HALLA					GPIOB_PIN6	//OK
#define BANK_HALLA					GPIOB		//OK
#define PIN_HALLB					GPIOB_PIN7	//OK
#define BANK_HALLB					GPIOB		//OK
#define PIN_CAN_RX					GPIOB_PIN8	//OK
#define BANK_CAN_RX					GPIOB		//OK
#define PIN_CAN_TX					GPIOB_PIN9	//OK
#define BANK_CAN_TX					GPIOB		//OK
#define PIN_I2C_SCL					GPIOB_PIN10	//OK
#define BANK_I2C_SCL				GPIOB		//OK
#define PIN_I2C_SDA					GPIOB_PIN11	//OK
#define BANK_I2C_SDA				GPIOB		//OK
#define PIN_DC_CAL					GPIOB_PIN12	//OK
#define BANK_DC_CAL					GPIOB		//OK
#define PIN_PWM_C_LS				GPIOB_PIN13	//OK
#define BANK_PWM_C_LS				GPIOB		//OK
#define PIN_PWM_B_LS				GPIOB_PIN14	//OK
#define BANK_PWM_B_LS				GPIOB		//OK
#define PIN_PWM_A_LS				GPIOB_PIN15	//OK
#define BANK_PWM_A_LS				GPIOB		//OK

#define PIN_TEMPSENSMOTOR			GPIOC_PIN0	//OK
#define BANK_TEMPSENSMOTOR			GPIOC		//OK
#define PIN_PC1						GPIOC_PIN1	//NC
#define BANK_PC1					GPIOC		//NC
#define PIN_AN_IN					GPIOC_PIN2	//OK
#define BANK_AN_IN					GPIOC		//OK
#define PIN_EXT						GPIOC_PIN2	//OK
#define BANK_EXT					GPIOC		//OK
#define PIN_PC3						GPIOC_PIN3	//NC
#define BANK_PC3					GPIOC		//NC
#define PIN_LED2					GPIOC_PIN4
#define BANK_LED2					GPIOC
#define PIN_LED_GREEN				GPIOC_PIN4	//OK,CFG!
#define BANK_LED_GREEN				GPIOC		//OK
#define PIN_LED1					GPIOC_PIN5
#define BANK_LED1					GPIOC
#define PIN_LED_RED					GPIOC_PIN5	//OK,CFG!
#define BANK_LED_RED				GPIOC		//OK
#define PIN_USART_TX				GPIOC_PIN6
#define BANK_USART_TX				GPIOC
#define PIN_USART_RX				GPIOC_PIN7
#define BANK_USART_RX				GPIOC
#define PIN_PC8						GPIOC_PIN8	//NC
#define BANK_PC8					GPIOC		//NC
#define PIN_PC9						GPIOC_PIN9	//NC
#define BANK_PC9					GPIOC		//NC
#define PIN_EN_GATE					GPIOC_PIN10	//OK,CFG!
#define BANK_EN_GATE				GPIOC		//OK
#define PIN_HALLC					GPIOC_PIN11	//OK,CFG!
#define BANK_HALLC					GPIOC		//OK,CFG!
#define PIN_FAULTC					GPIOC_PIN12	//OK,CFG!
#define BANK_FAULTC					GPIOC		//OK,CFG!
#define PIN_PC13					GPIOC_PIN13	//NC
#define BANK_PC13					GPIOC		//NC
#define PIN_PC14					GPIOC_PIN14	//NC
#define BANK_PC14					GPIOC		//NC
#define PIN_PC15					GPIOC_PIN15	//NC
#define BANK_PC15					GPIOC		//NC

#define PIN_PD2						GPIOD_PIN2	//NC
#define BANK_PD2					GPIOD		//NC

#define PIN_OSC_IN					GPIOH_PIN0
#define BANK_OSC_IN					GPIOH
#define PIN_OSC_OUT					GPIOH_PIN1
#define BANK_OSC_OUT				GPIOH

#endif // BOARD_VESC

/*
 * I/O ports initial setup, this configuration is established soon after reset
 * in the initialization code.
 * Please refer to the STM32 Reference Manual for details.
 */
#define PIN_MODE_INPUT(n)           (0U << ((n) * 2U))
#define PIN_MODE_OUTPUT(n)          (1U << ((n) * 2U))
#define PIN_MODE_ALTERNATE(n)       (2U << ((n) * 2U))
#define PIN_MODE_ANALOG(n)          (3U << ((n) * 2U))
#define PIN_ODR_LOW(n)              (0U << (n))
#define PIN_ODR_HIGH(n)             (1U << (n))
#define PIN_OTYPE_PUSHPULL(n)       (0U << (n))
#define PIN_OTYPE_OPENDRAIN(n)      (1U << (n))
#define PIN_OSPEED_2M(n)            (0U << ((n) * 2U))
#define PIN_OSPEED_25M(n)           (1U << ((n) * 2U))
#define PIN_OSPEED_50M(n)           (2U << ((n) * 2U))
#define PIN_OSPEED_100M(n)          (3U << ((n) * 2U))
#define PIN_PUPDR_FLOATING(n)       (0U << ((n) * 2U))
#define PIN_PUPDR_PULLUP(n)         (1U << ((n) * 2U))
#define PIN_PUPDR_PULLDOWN(n)       (2U << ((n) * 2U))
#define PIN_AFIO_AF(n, v)           ((v) << (((n) % 8U) * 4U))


/*
 * DrChibi Looong-Srip pin setup
 */
#if defined(BOARD_LOOONG_STRIP_F4) || defined(BOARD_LOOONG_STRIP_F7)

/*
 * GPIOA setup:
 *
 * PA0  - PIN_VSENS_C               (analog input).
 * PA1  - PIN_PWM_F                 (alternate 1 (TIM2) push-pull output 50MHz).
 * PA2  - PIN_VSENS_A               (analog input).
 * PA3  - PIN_VSENS_D               (analog input).
 * PA4  - PIN_VSENS_E               (analog input).
 * PA5  - PIN_VSENS_F               (analog input).
 * PA6  - PIN_CSENS_F               (analog input).
 * PA7  - PIN_CSENS_E               (analog input).
 * PA8  - PIN_PWM_C_HS/PIN_PWM_C    (output push-pull 50MHz). Obsolete: (alternate 1 (TIM1) push-pull output 50MHz).
 * PA9  - PIN_PWM_B_HS/PIN_PWM_B    (alternate 1 (TIM1) push-pull output 50MHz).
 * PA10 - PIN_PWM_A_HS/PIN_PWM_A    (alternate 1 (TIM1) push-pull output 50MHz).
 * PA11 - PIN_USB_DM                (alternate 10 (USB), controlled automatically).
 * PA12 - PIN_USB_DP                (alternate 10 (USB), controlled automatically).
 * PA13 - PIN_SWDIO                 (alternate 0 (system)).
 * PA14 - PIN_SWDCLK                (alternate 0 (system)).
 * PA15 - PIN_ZCD                   (output push-pull 50MHz).
 */
#define VAL_GPIOA_MODER             (PIN_MODE_ANALOG(PIN_VSENS_C) |         \
                                     PIN_MODE_OUTPUT(PIN_PWM_F) |        \
                                     PIN_MODE_ANALOG(PIN_VSENS_A) |         \
                                     PIN_MODE_ANALOG(PIN_VSENS_D) |         \
                                     PIN_MODE_ANALOG(PIN_VSENS_E) |         \
                                     PIN_MODE_ANALOG(PIN_VSENS_F) |         \
                                     PIN_MODE_ANALOG(PIN_CSENS_F) |         \
                                     PIN_MODE_ANALOG(PIN_CSENS_E) |         \
                                     PIN_MODE_OUTPUT(PIN_PWM_C) |     \
                                     PIN_MODE_OUTPUT(PIN_PWM_B) |     \
                                     PIN_MODE_OUTPUT(PIN_PWM_A) |     \
                                     PIN_MODE_ALTERNATE(PIN_USB_DM) |       \
                                     PIN_MODE_ALTERNATE(PIN_USB_DP) |       \
                                     PIN_MODE_ALTERNATE(PIN_SWDIO) |        \
                                     PIN_MODE_ALTERNATE(PIN_SWDCLK) |       \
                                     PIN_MODE_OUTPUT(PIN_ZCD))
#define VAL_GPIOA_OTYPER            (PIN_OTYPE_PUSHPULL(PIN_VSENS_C) |      \
                                     PIN_OTYPE_PUSHPULL(PIN_PWM_F) |        \
                                     PIN_OTYPE_PUSHPULL(PIN_VSENS_A) |      \
                                     PIN_OTYPE_PUSHPULL(PIN_VSENS_D) |      \
                                     PIN_OTYPE_PUSHPULL(PIN_VSENS_E) |      \
                                     PIN_OTYPE_PUSHPULL(PIN_VSENS_F) |      \
                                     PIN_OTYPE_PUSHPULL(PIN_CSENS_F) |      \
                                     PIN_OTYPE_PUSHPULL(PIN_CSENS_E) |      \
                                     PIN_OTYPE_PUSHPULL(PIN_PWM_C) |     \
                                     PIN_OTYPE_PUSHPULL(PIN_PWM_B) |     \
                                     PIN_OTYPE_PUSHPULL(PIN_PWM_A) |     \
                                     PIN_OTYPE_PUSHPULL(PIN_USB_DM) |       \
                                     PIN_OTYPE_PUSHPULL(PIN_USB_DP) |       \
                                     PIN_OTYPE_PUSHPULL(PIN_SWDIO) |        \
                                     PIN_OTYPE_PUSHPULL(PIN_SWDCLK) |       \
                                     PIN_OTYPE_PUSHPULL(PIN_ZCD))
#define VAL_GPIOA_OSPEEDR           (PIN_OSPEED_100M(PIN_VSENS_C) |         \
                                     PIN_OSPEED_50M(PIN_PWM_F) |            \
                                     PIN_OSPEED_100M(PIN_VSENS_A) |         \
                                     PIN_OSPEED_100M(PIN_VSENS_D) |         \
                                     PIN_OSPEED_100M(PIN_VSENS_E) |         \
                                     PIN_OSPEED_100M(PIN_VSENS_F) |         \
                                     PIN_OSPEED_100M(PIN_CSENS_F) |         \
                                     PIN_OSPEED_100M(PIN_CSENS_E) |         \
                                     PIN_OSPEED_50M(PIN_PWM_C) |         \
                                     PIN_OSPEED_50M(PIN_PWM_B) |         \
                                     PIN_OSPEED_50M(PIN_PWM_A) |         \
                                     PIN_OSPEED_100M(PIN_USB_DM) |          \
                                     PIN_OSPEED_100M(PIN_USB_DP) |          \
                                     PIN_OSPEED_100M(PIN_SWDIO) |           \
                                     PIN_OSPEED_100M(PIN_SWDCLK) |          \
                                     PIN_OSPEED_50M(PIN_ZCD))
#define VAL_GPIOA_PUPDR             (PIN_PUPDR_FLOATING(PIN_VSENS_C) |      \
                                     PIN_PUPDR_FLOATING(PIN_PWM_F) |        \
                                     PIN_PUPDR_FLOATING(PIN_VSENS_A) |      \
                                     PIN_PUPDR_FLOATING(PIN_VSENS_D) |      \
                                     PIN_PUPDR_FLOATING(PIN_VSENS_E) |      \
                                     PIN_PUPDR_FLOATING(PIN_VSENS_F) |      \
                                     PIN_PUPDR_FLOATING(PIN_CSENS_F) |      \
                                     PIN_PUPDR_FLOATING(PIN_CSENS_E) |      \
                                     PIN_PUPDR_FLOATING(PIN_PWM_C) |     \
                                     PIN_PUPDR_FLOATING(PIN_PWM_B) |     \
                                     PIN_PUPDR_FLOATING(PIN_PWM_A) |     \
                                     PIN_PUPDR_FLOATING(PIN_USB_DM) |       \
                                     PIN_PUPDR_FLOATING(PIN_USB_DP) |       \
                                     PIN_PUPDR_FLOATING(PIN_SWDIO) |        \
                                     PIN_PUPDR_FLOATING(PIN_SWDCLK) |       \
                                     PIN_PUPDR_FLOATING(PIN_ZCD))
#define VAL_GPIOA_ODR               (PIN_ODR_HIGH(PIN_VSENS_C) |            \
                                     PIN_ODR_LOW(PIN_PWM_F) |               \
                                     PIN_ODR_HIGH(PIN_VSENS_A) |            \
                                     PIN_ODR_HIGH(PIN_VSENS_D) |            \
                                     PIN_ODR_HIGH(PIN_VSENS_E) |            \
                                     PIN_ODR_HIGH(PIN_VSENS_F) |            \
                                     PIN_ODR_HIGH(PIN_CSENS_F) |            \
                                     PIN_ODR_HIGH(PIN_CSENS_E) |            \
                                     PIN_ODR_LOW(PIN_PWM_C) |            \
                                     PIN_ODR_LOW(PIN_PWM_B) |            \
                                     PIN_ODR_LOW(PIN_PWM_A) |            \
                                     PIN_ODR_HIGH(PIN_USB_DM) |             \
                                     PIN_ODR_HIGH(PIN_USB_DP) |             \
                                     PIN_ODR_HIGH(PIN_SWDIO) |              \
                                     PIN_ODR_HIGH(PIN_SWDCLK) |             \
                                     PIN_ODR_LOW(PIN_ZCD))
#define VAL_GPIOA_AFRL              (PIN_AFIO_AF(PIN_VSENS_C, 0) |          \
                                     PIN_AFIO_AF(PIN_PWM_F, 0) |            \
                                     PIN_AFIO_AF(PIN_VSENS_A, 0) |          \
                                     PIN_AFIO_AF(PIN_VSENS_D, 0) |          \
                                     PIN_AFIO_AF(PIN_VSENS_E, 0) |          \
                                     PIN_AFIO_AF(PIN_VSENS_F, 0) |          \
                                     PIN_AFIO_AF(PIN_CSENS_F, 0) |          \
                                     PIN_AFIO_AF(PIN_CSENS_E, 0))
#define VAL_GPIOA_AFRH              (PIN_AFIO_AF(PIN_PWM_C, 0) |         \
                                     PIN_AFIO_AF(PIN_PWM_B, 0) |         \
                                     PIN_AFIO_AF(PIN_PWM_A, 0) |         \
                                     PIN_AFIO_AF(PIN_USB_DM, 10) |          \
                                     PIN_AFIO_AF(PIN_USB_DP, 10) |          \
                                     PIN_AFIO_AF(PIN_SWDIO, 0) |            \
                                     PIN_AFIO_AF(PIN_SWDCLK, 0) |           \
                                     PIN_AFIO_AF(PIN_ZCD, 0))

/*
 * GPIOB setup:
 *
 * PB0  - PIN_CSENS_B               (analog input).
 * PB1  - PIN_CSENS_A               (analog input).
 * PB2  - PIN_PB2                   (input floating).
 * PB3  - PIN_TRACESWO              (alternate 0 (system)).
 * PB4  - PIN_ENABLE_E              (output push-pull 50MHz).
 * PB5  - PIN_ENABLE_F              (output push-pull 50MHz).
 * PB6  - PIN_I2C_SCL               (alternate 4 (I2C) open drain).
 * PB7  - PIN_I2C_SDA               (alternate 4 (I2C) open drain).
 * PB8  - PIN_CAN_RX                (alternate 9 (CAN) push-pull pull-up). TODO: check CAN pin config
 * PB9  - PIN_CAN_TX                (alternate 9 (CAN) push-pull pull-up). TODO: check CAN pin config
 * PB10 - PIN_PWM_E                 (alternate 1 (TIM2) push-pull output 50MHz).
 * PB11 - PIN_PWM_D                 (alternate 1 (TIM2) push-pull output 50MHz).
 * PB12 - PIN_THWN                  (input pull-up).
 * PB13 - PIN_PWM_C_LS/PIN_ENABLE_C (alternate 1 (TIM1) push-pull output 50MHz / output push-pull).
 * PB14 - PIN_PWM_B_LS/PIN_ENABLE_B (alternate 1 (TIM1) push-pull output 50MHz / output push-pull).
 * PB15 - PIN_PWM_A_LS/PIN_ENABLE_A (alternate 1 (TIM1) push-pull output 50MHz / output push-pull).
 */
#define VAL_GPIOB_MODER             (PIN_MODE_ANALOG(PIN_CSENS_B) |         \
                                     PIN_MODE_ANALOG(PIN_CSENS_A) |         \
                                     PIN_MODE_INPUT(PIN_PB2) |              \
                                     PIN_MODE_ALTERNATE(PIN_TRACESWO) |     \
                                     PIN_MODE_OUTPUT(PIN_ENABLE_E) |        \
                                     PIN_MODE_OUTPUT(PIN_ENABLE_F) |        \
                                     PIN_MODE_ALTERNATE(PIN_I2C_SCL) |      \
                                     PIN_MODE_ALTERNATE(PIN_I2C_SDA) |      \
                                     PIN_MODE_ALTERNATE(PIN_CAN_RX) |       \
                                     PIN_MODE_ALTERNATE(PIN_CAN_TX) |       \
                                     PIN_MODE_OUTPUT(PIN_PWM_E) |        \
                                     PIN_MODE_OUTPUT(PIN_PWM_D) |        \
                                     PIN_MODE_INPUT(PIN_THWN) |             \
									 PIN_MODE_OUTPUT(PIN_ENABLE_C) |        \
									 PIN_MODE_OUTPUT(PIN_ENABLE_B) |        \
		                             PIN_MODE_OUTPUT(PIN_ENABLE_A))
#define VAL_GPIOB_OTYPER            (PIN_OTYPE_PUSHPULL(PIN_CSENS_B) |      \
                                     PIN_OTYPE_PUSHPULL(PIN_CSENS_A) |      \
                                     PIN_OTYPE_PUSHPULL(PIN_PB2) |          \
                                     PIN_OTYPE_PUSHPULL(PIN_TRACESWO) |     \
                                     PIN_OTYPE_PUSHPULL(PIN_ENABLE_E) |     \
                                     PIN_OTYPE_PUSHPULL(PIN_ENABLE_F) |     \
                                     PIN_OTYPE_OPENDRAIN(PIN_I2C_SCL) |     \
                                     PIN_OTYPE_OPENDRAIN(PIN_I2C_SDA) |     \
                                     PIN_OTYPE_PUSHPULL(PIN_CAN_RX) |       \
                                     PIN_OTYPE_PUSHPULL(PIN_CAN_TX) |       \
                                     PIN_OTYPE_PUSHPULL(PIN_PWM_E) |        \
                                     PIN_OTYPE_PUSHPULL(PIN_PWM_D) |        \
                                     PIN_OTYPE_PUSHPULL(PIN_THWN) |         \
                                     PIN_OTYPE_PUSHPULL(PIN_ENABLE_C) |     \
                                     PIN_OTYPE_PUSHPULL(PIN_ENABLE_B) |     \
                                     PIN_OTYPE_PUSHPULL(PIN_ENABLE_A))
#define VAL_GPIOB_OSPEEDR           (PIN_OSPEED_100M(PIN_CSENS_B) |         \
                                     PIN_OSPEED_100M(PIN_CSENS_A) |         \
                                     PIN_OSPEED_100M(PIN_PB2) |             \
                                     PIN_OSPEED_100M(PIN_TRACESWO) |        \
                                     PIN_OSPEED_50M(PIN_ENABLE_E) |         \
									 PIN_OSPEED_50M(PIN_ENABLE_F) |         \
                                     PIN_OSPEED_100M(PIN_I2C_SCL) |         \
									 PIN_OSPEED_100M(PIN_I2C_SDA) |         \
                                     PIN_OSPEED_50M(PIN_CAN_RX) |           \
									 PIN_OSPEED_50M(PIN_CAN_TX) |           \
                                     PIN_OSPEED_50M(PIN_PWM_E) |           \
									 PIN_OSPEED_50M(PIN_PWM_D) |           \
                                     PIN_OSPEED_100M(PIN_THWN) |            \
                                     PIN_OSPEED_50M(PIN_ENABLE_C) |         \
									 PIN_OSPEED_50M(PIN_ENABLE_B) |         \
									 PIN_OSPEED_50M(PIN_ENABLE_A))
#define VAL_GPIOB_PUPDR             (PIN_PUPDR_FLOATING(PIN_CSENS_B) |      \
		                             PIN_PUPDR_FLOATING(PIN_CSENS_A) |      \
                                     PIN_PUPDR_FLOATING(PIN_PB2) |          \
                                     PIN_PUPDR_FLOATING(PIN_TRACESWO) |     \
                                     PIN_PUPDR_FLOATING(PIN_ENABLE_E) |     \
									 PIN_PUPDR_FLOATING(PIN_ENABLE_F) |     \
                                     PIN_PUPDR_FLOATING(PIN_I2C_SCL) |      \
									 PIN_PUPDR_FLOATING(PIN_I2C_SDA) |      \
                                     PIN_PUPDR_PULLUP(PIN_CAN_RX) |         \
									 PIN_PUPDR_PULLUP(PIN_CAN_TX) |         \
                                     PIN_PUPDR_FLOATING(PIN_PWM_E) |        \
									 PIN_PUPDR_FLOATING(PIN_PWM_D) |        \
                                     PIN_PUPDR_PULLUP(PIN_THWN) |           \
                                     PIN_PUPDR_FLOATING(PIN_ENABLE_C) |     \
									 PIN_PUPDR_FLOATING(PIN_ENABLE_B) |     \
									 PIN_PUPDR_FLOATING(PIN_ENABLE_A))
#define VAL_GPIOB_ODR               (PIN_ODR_HIGH(PIN_CSENS_B) |            \
                                     PIN_ODR_HIGH(PIN_CSENS_A) |            \
                                     PIN_ODR_LOW(PIN_PB2) |                 \
                                     PIN_ODR_HIGH(PIN_TRACESWO) |           \
                                     PIN_ODR_LOW(PIN_ENABLE_E) |            \
									 PIN_ODR_LOW(PIN_ENABLE_F) |            \
                                     PIN_ODR_HIGH(PIN_I2C_SCL) |            \
									 PIN_ODR_HIGH(PIN_I2C_SDA) |            \
                                     PIN_ODR_HIGH(PIN_CAN_RX) |             \
									 PIN_ODR_HIGH(PIN_CAN_TX) |             \
                                     PIN_ODR_LOW(PIN_PWM_E) |               \
									 PIN_ODR_LOW(PIN_PWM_D) |               \
                                     PIN_ODR_HIGH(PIN_THWN) |               \
                                     PIN_ODR_LOW(PIN_ENABLE_C) |            \
									 PIN_ODR_LOW(PIN_ENABLE_B) |            \
									 PIN_ODR_LOW(PIN_ENABLE_A))
#define VAL_GPIOB_AFRL              (PIN_AFIO_AF(PIN_CSENS_B, 0) |          \
                                     PIN_AFIO_AF(PIN_CSENS_A, 0) |          \
                                     PIN_AFIO_AF(PIN_PB2, 0) |              \
                                     PIN_AFIO_AF(PIN_TRACESWO, 0) |         \
                                     PIN_AFIO_AF(PIN_ENABLE_E, 0) |         \
                                     PIN_AFIO_AF(PIN_ENABLE_F, 0) |         \
                                     PIN_AFIO_AF(PIN_I2C_SCL, 4) |          \
                                     PIN_AFIO_AF(PIN_I2C_SDA, 4))
#define VAL_GPIOB_AFRH              (PIN_AFIO_AF(PIN_CAN_RX, 9) |           \
                                     PIN_AFIO_AF(PIN_CAN_TX, 9) |           \
                                     PIN_AFIO_AF(PIN_PWM_E, 0) |            \
                                     PIN_AFIO_AF(PIN_PWM_D, 0) |            \
                                     PIN_AFIO_AF(PIN_THWN, 0) |             \
                                     PIN_AFIO_AF(PIN_ENABLE_C, 0) |         \
									 PIN_AFIO_AF(PIN_ENABLE_B, 0) |         \
									 PIN_AFIO_AF(PIN_ENABLE_A, 0))

/*
 * GPIOC setup:
 *
 * PC0  - PIN_VSENS_Y2              (analog input).
 * PC1  - PIN_VSENS_Y1              (analog input).
 * PC2  - PIN_CSENS_C               (analog input).
 * PC3  - PIN_VSENS_B               (analog input).
 * PC4  - PIN_CSENS_D               (analog input).
 * PC5  - PIN_PC5                   (input floating).
 * PC6  - PIN_USART_TX              (alternate 8 (USART) push-pull 100MHz). TODO: check USART TX pin frequency
 * PC7  - PIN_USART_RX              (alternate 8 (USART) input floating). TODO: check whether USART RX pin should be floating or pull-up
 * PC8  - PIN_USART_CK/PIN_PWM_IN2  (alternate 8 (USART) push-pull 100MHz / alternate 2 (TIM3) input floating). TODO: check USART CK pin frequency
 * PC9  - PIN_PWM_IN1               (alternate 2 (TIM3) input floating).
 * PC10 - PIN_SPI_SCK               (alternate 6 (SPI3) Master: push-pull 100MHz, Slave: input floating). TODO: check SPI_SCK pin frequency
 * PC11 - PIN_SPI_MISO              (alternate 6 (SPI3) Master: input floating/pull-up, Slave point-to-point: push-pull 100MHz, Slave multi-slave: open drain 100MHz). TODO: check SPI_MISO pin frequency and whether input should be floating or pull-up
 * PC12 - PIN_SPI_MOSI              (alternate 6 (SPI3) Master: push-pull 100MHz, Slave: input floating/pull-up). TODO: check whether SPI_MOSI pin in slave mode should be floating or pull-up
 * PC13 - PIN_LED1 (red)            (output pushpull 2MHz).
 * PC14 - PIN_LED2 (green)          (output pushpull 2MHz).
 * PC15 - PIN_FAULTC                (input pullup).
 */
#define VAL_GPIOC_MODER             (PIN_MODE_ANALOG(PIN_VSENS_Y2) |        \
                                     PIN_MODE_ANALOG(PIN_VSENS_Y1) |        \
                                     PIN_MODE_ANALOG(PIN_CSENS_C) |         \
                                     PIN_MODE_ANALOG(PIN_VSENS_B) |         \
                                     PIN_MODE_ANALOG(PIN_CSENS_D) |         \
                                     PIN_MODE_INPUT(PIN_PC5) |              \
                                     PIN_MODE_ALTERNATE(PIN_USART_TX) |     \
                                     PIN_MODE_ALTERNATE(PIN_USART_RX) |     \
                                     PIN_MODE_ALTERNATE(PIN_USART_CK) |     \
                                     PIN_MODE_ALTERNATE(PIN_PWM_IN1) |      \
                                     PIN_MODE_ALTERNATE(PIN_SPI_SCK) |      \
                                     PIN_MODE_ALTERNATE(PIN_SPI_MISO) |     \
                                     PIN_MODE_ALTERNATE(PIN_SPI_MOSI) |     \
                                     PIN_MODE_OUTPUT(PIN_LED1) |            \
                                     PIN_MODE_OUTPUT(PIN_LED2) |            \
									 PIN_MODE_INPUT(PIN_FAULTC))
#define VAL_GPIOC_OTYPER            (PIN_OTYPE_PUSHPULL(PIN_VSENS_Y2) |     \
                                     PIN_OTYPE_PUSHPULL(PIN_VSENS_Y1) |     \
                                     PIN_OTYPE_PUSHPULL(PIN_CSENS_C) |      \
                                     PIN_OTYPE_PUSHPULL(PIN_VSENS_B) |      \
                                     PIN_OTYPE_PUSHPULL(PIN_CSENS_D) |      \
                                     PIN_OTYPE_PUSHPULL(PIN_PC5) |          \
                                     PIN_OTYPE_PUSHPULL(PIN_USART_TX) |     \
                                     PIN_OTYPE_PUSHPULL(PIN_USART_RX) |     \
                                     PIN_OTYPE_PUSHPULL(PIN_USART_CK) |     \
                                     PIN_OTYPE_PUSHPULL(PIN_PWM_IN1) |      \
                                     PIN_OTYPE_PUSHPULL(PIN_SPI_SCK) |      \
                                     PIN_OTYPE_PUSHPULL(PIN_SPI_MISO) | /* for SPI master or point-to-point slave, for multi-slave slave use: PIN_OTYPE_OPENDRAIN(PIN_SPI_MISO) */ \
		                             PIN_OTYPE_PUSHPULL(PIN_SPI_MOSI) |     \
                                     PIN_OTYPE_PUSHPULL(PIN_LED1) |         \
                                     PIN_OTYPE_PUSHPULL(PIN_LED2) |         \
									 PIN_OTYPE_PUSHPULL(PIN_FAULTC))
#define VAL_GPIOC_OSPEEDR           (PIN_OSPEED_100M(PIN_VSENS_Y2) |        \
                                     PIN_OSPEED_100M(PIN_VSENS_Y1) |        \
                                     PIN_OSPEED_100M(PIN_CSENS_C) |         \
                                     PIN_OSPEED_100M(PIN_VSENS_B) |         \
                                     PIN_OSPEED_100M(PIN_CSENS_D) |         \
                                     PIN_OSPEED_100M(PIN_PC5) |             \
                                     PIN_OSPEED_100M(PIN_USART_TX) |        \
                                     PIN_OSPEED_100M(PIN_USART_RX) |        \
                                     PIN_OSPEED_100M(PIN_USART_CK) |        \
                                     PIN_OSPEED_100M(PIN_PWM_IN1) |         \
                                     PIN_OSPEED_100M(PIN_SPI_SCK) |         \
                                     PIN_OSPEED_100M(PIN_SPI_MISO) |        \
                                     PIN_OSPEED_100M(PIN_SPI_MOSI) |        \
                                     PIN_OSPEED_2M(PIN_LED1) |              \
									 PIN_OSPEED_2M(PIN_LED2) |              \
									 PIN_OSPEED_100M(PIN_FAULTC))
#define VAL_GPIOC_PUPDR             (PIN_PUPDR_FLOATING(PIN_VSENS_Y2) |     \
                                     PIN_PUPDR_FLOATING(PIN_VSENS_Y1) |     \
									 PIN_PUPDR_FLOATING(PIN_CSENS_C) |      \
                                     PIN_PUPDR_FLOATING(PIN_VSENS_B) |      \
                                     PIN_PUPDR_FLOATING(PIN_CSENS_D) |      \
                                     PIN_PUPDR_FLOATING(PIN_PC5) |          \
                                     PIN_PUPDR_FLOATING(PIN_USART_TX) |     \
                                     PIN_PUPDR_FLOATING(PIN_USART_RX) |     \
                                     PIN_PUPDR_FLOATING(PIN_USART_CK) |     \
                                     PIN_PUPDR_FLOATING(PIN_PWM_IN1) |      \
                                     PIN_PUPDR_FLOATING(PIN_SPI_SCK) |      \
                                     PIN_PUPDR_FLOATING(PIN_SPI_MISO) |     \
                                     PIN_PUPDR_FLOATING(PIN_SPI_MOSI) |     \
									 PIN_PUPDR_FLOATING(PIN_LED1) |         \
									 PIN_PUPDR_FLOATING(PIN_LED2) |         \
									 PIN_PUPDR_PULLUP(PIN_FAULTC))
#define VAL_GPIOC_ODR               (PIN_ODR_HIGH(PIN_VSENS_Y2) |           \
                                     PIN_ODR_HIGH(PIN_VSENS_Y1) |           \
                                     PIN_ODR_HIGH(PIN_CSENS_C) |            \
                                     PIN_ODR_HIGH(PIN_VSENS_B) |            \
                                     PIN_ODR_HIGH(PIN_CSENS_D) |            \
                                     PIN_ODR_LOW(PIN_PC5) |                 \
                                     PIN_ODR_LOW(PIN_USART_TX) |            \
                                     PIN_ODR_HIGH(PIN_USART_RX) |           \
                                     PIN_ODR_HIGH(PIN_USART_CK) |           \
                                     PIN_ODR_HIGH(PIN_PWM_IN1) |            \
                                     PIN_ODR_HIGH(PIN_SPI_SCK) |            \
                                     PIN_ODR_HIGH(PIN_SPI_MISO) |           \
                                     PIN_ODR_HIGH(PIN_SPI_MOSI) |           \
                                     PIN_ODR_LOW(PIN_LED1) |                \
                                     PIN_ODR_LOW(PIN_LED2) |                \
									 PIN_ODR_HIGH(PIN_FAULTC))
#define VAL_GPIOC_AFRL              (PIN_AFIO_AF(PIN_VSENS_Y2, 0) |         \
                                     PIN_AFIO_AF(PIN_VSENS_Y1, 0) |         \
                                     PIN_AFIO_AF(PIN_CSENS_C, 0) |          \
                                     PIN_AFIO_AF(PIN_VSENS_B, 0) |          \
                                     PIN_AFIO_AF(PIN_CSENS_D, 0) |          \
                                     PIN_AFIO_AF(PIN_PC5, 0) |              \
                                     PIN_AFIO_AF(PIN_USART_TX, 8) |         \
                                     PIN_AFIO_AF(PIN_USART_RX, 8))
#define VAL_GPIOC_AFRH              (PIN_AFIO_AF(PIN_USART_CK, 8) |         \
                                     PIN_AFIO_AF(PIN_PWM_IN1, 2) |          \
                                     PIN_AFIO_AF(PIN_SPI_SCK, 5) | /* TODO: check whether AF5 is correct. Could be AF6 */ \
                                     PIN_AFIO_AF(PIN_SPI_MISO, 5) |         \
                                     PIN_AFIO_AF(PIN_SPI_MOSI, 5) |         \
                                     PIN_AFIO_AF(PIN_LED1, 0) |             \
                                     PIN_AFIO_AF(PIN_LED2, 0) |             \
									 PIN_AFIO_AF(PIN_FAULTC, 0))

/*
 * GPIOD setup:
 *
 * PD2  - PIN_ENABLE_D              (output push-pull 50MHz).
 */
#define VAL_GPIOD_MODER             (PIN_MODE_INPUT(PIN_ENABLE_D))
#define VAL_GPIOD_OTYPER            (PIN_OTYPE_PUSHPULL(PIN_ENABLE_D))
#define VAL_GPIOD_OSPEEDR           (PIN_OSPEED_50M(PIN_ENABLE_D))
#define VAL_GPIOD_PUPDR             (PIN_PUPDR_FLOATING(PIN_ENABLE_D))
#define VAL_GPIOD_ODR               (PIN_ODR_LOW(PIN_ENABLE_D))
#define VAL_GPIOD_AFRL              (PIN_AFIO_AF(PIN_ENABLE_D, 0))
#define VAL_GPIOD_AFRH				0

#define VAL_GPIOE_MODER				0
#define VAL_GPIOE_OTYPER			0
#define VAL_GPIOE_OSPEEDR			0
#define VAL_GPIOE_PUPDR				0
#define VAL_GPIOE_ODR				0
#define VAL_GPIOE_AFRL				0
#define VAL_GPIOE_AFRH				0

#define VAL_GPIOF_MODER				0
#define VAL_GPIOF_OTYPER			0
#define VAL_GPIOF_OSPEEDR			0
#define VAL_GPIOF_PUPDR				0
#define VAL_GPIOF_ODR				0
#define VAL_GPIOF_AFRL				0
#define VAL_GPIOF_AFRH				0

#define VAL_GPIOG_MODER				0
#define VAL_GPIOG_OTYPER			0
#define VAL_GPIOG_OSPEEDR			0
#define VAL_GPIOG_PUPDR				0
#define VAL_GPIOG_ODR				0
#define VAL_GPIOG_AFRL				0
#define VAL_GPIOG_AFRH				0


/*
 * GPIOH setup:
 *
 * PH0  - OSC_IN                    (input floating).
 * PH1  - OSC_OUT                   (input floating).
 */
#define VAL_GPIOH_MODER             (PIN_MODE_INPUT(PIN_OSC_IN) |         \
                                     PIN_MODE_INPUT(PIN_OSC_OUT))
#define VAL_GPIOH_OTYPER            (PIN_OTYPE_PUSHPULL(PIN_OSC_IN) |     \
                                     PIN_OTYPE_PUSHPULL(PIN_OSC_OUT))
#define VAL_GPIOH_OSPEEDR           (PIN_OSPEED_100M(PIN_OSC_IN) |        \
                                     PIN_OSPEED_100M(PIN_OSC_OUT))
#define VAL_GPIOH_PUPDR             (PIN_PUPDR_FLOATING(PIN_OSC_IN) |     \
                                     PIN_PUPDR_FLOATING(PIN_OSC_OUT))
#define VAL_GPIOH_ODR               (PIN_ODR_HIGH(PIN_OSC_IN) |           \
                                     PIN_ODR_HIGH(PIN_OSC_OUT))
#define VAL_GPIOH_AFRL              (PIN_AFIO_AF(PIN_OSC_IN, 0) |         \
                                     PIN_AFIO_AF(PIN_OSC_OUT, 0))
#define VAL_GPIOH_AFRH				0

#define VAL_GPIOI_MODER				0
#define VAL_GPIOI_OTYPER			0
#define VAL_GPIOI_OSPEEDR			0
#define VAL_GPIOI_PUPDR				0
#define VAL_GPIOI_ODR				0
#define VAL_GPIOI_AFRL				0
#define VAL_GPIOI_AFRH				0

#endif // BOARD_LOOONG_STRIP

/*
 * VESC pin setup
 */
#if defined(BOARD_VESC)

/*
 * GPIOA setup:
 *
 * PA0  - PIN_VSENS_C               (analog input).
 * PA1  - PIN_VSENS_B               (analog input).
 * PA2  - PIN_VSENS_A               (analog input).
 * PA3  - PIN_VSENS_D               (analog input).
 * PA4  - PIN_VSENS_E               (analog input).
 * PA5  - PIN_VSENS_F               (analog input).
 * PA6  - PIN_CSENS_F               (analog input).
 * PA7  - PIN_CSENS_E               (analog input).
 * PA8  - PIN_PWM_C_HS/PIN_PWM_C    (alternate 1 (TIM1) push-pull output 50MHz).
 * PA9  - PIN_PWM_B_HS/PIN_PWM_B    (alternate 1 (TIM1) push-pull output 50MHz).
 * PA10 - PIN_PWM_A_HS/PIN_PWM_A    (alternate 1 (TIM1) push-pull output 50MHz).
 * PA11 - PIN_USB_DM                (alternate 10 (USB), controlled automatically).
 * PA12 - PIN_USB_DP                (alternate 10 (USB), controlled automatically).
 * PA13 - PIN_SWDIO                 (alternate 0 (system)).
 * PA14 - PIN_SWDCLK                (alternate 0 (system)).
 * PA15 - GPIOA_PIN15               (output push-pull 50MHz).
 */
#define VAL_GPIOA_MODER             (PIN_MODE_ANALOG(PIN_VSENS_C) |         \
                                     PIN_MODE_ANALOG(PIN_VSENS_B) |        \
                                     PIN_MODE_ANALOG(PIN_VSENS_A) |         \
                                     PIN_MODE_ANALOG(PIN_TEMPSENS) |         \
                                     PIN_MODE_ANALOG(PIN_VSENS_E) |         \
                                     PIN_MODE_ANALOG(PIN_VSENS_F) |         \
                                     PIN_MODE_ANALOG(PIN_CSENS_F) |         \
                                     PIN_MODE_ANALOG(PIN_CSENS_E) |         \
                                     PIN_MODE_ALTERNATE(PIN_PWM_C_HS) |     \
                                     PIN_MODE_ALTERNATE(PIN_PWM_B_HS) |     \
                                     PIN_MODE_ALTERNATE(PIN_PWM_A_HS) |     \
                                     PIN_MODE_ALTERNATE(PIN_USB_DM) |       \
                                     PIN_MODE_ALTERNATE(PIN_USB_DP) |       \
                                     PIN_MODE_ALTERNATE(PIN_SWDIO) |        \
                                     PIN_MODE_ALTERNATE(PIN_SWDCLK) |       \
									 PIN_MODE_INPUT(GPIOA_PIN15))
#define VAL_GPIOA_OTYPER            (PIN_OTYPE_PUSHPULL(PIN_VSENS_C) |      \
                                     PIN_OTYPE_PUSHPULL(PIN_VSENS_B) |      \
                                     PIN_OTYPE_PUSHPULL(PIN_VSENS_A) |      \
                                     PIN_OTYPE_PUSHPULL(PIN_TEMPSENS) |      \
                                     PIN_OTYPE_PUSHPULL(PIN_VSENS_E) |      \
                                     PIN_OTYPE_PUSHPULL(PIN_VSENS_F) |      \
                                     PIN_OTYPE_PUSHPULL(PIN_CSENS_F) |      \
                                     PIN_OTYPE_PUSHPULL(PIN_CSENS_E) |      \
                                     PIN_OTYPE_PUSHPULL(PIN_PWM_C_HS) |     \
                                     PIN_OTYPE_PUSHPULL(PIN_PWM_B_HS) |     \
                                     PIN_OTYPE_PUSHPULL(PIN_PWM_A_HS) |     \
                                     PIN_OTYPE_PUSHPULL(PIN_USB_DM) |       \
                                     PIN_OTYPE_PUSHPULL(PIN_USB_DP) |       \
                                     PIN_OTYPE_PUSHPULL(PIN_SWDIO) |        \
                                     PIN_OTYPE_PUSHPULL(PIN_SWDCLK) |       \
                                     PIN_OTYPE_PUSHPULL(GPIOA_PIN15))
#define VAL_GPIOA_OSPEEDR           (PIN_OSPEED_100M(PIN_VSENS_C) |         \
                                     PIN_OSPEED_100M(PIN_VSENS_B) |            \
                                     PIN_OSPEED_100M(PIN_VSENS_A) |         \
                                     PIN_OSPEED_100M(PIN_TEMPSENS) |         \
                                     PIN_OSPEED_100M(PIN_VSENS_E) |         \
                                     PIN_OSPEED_100M(PIN_VSENS_F) |         \
                                     PIN_OSPEED_100M(PIN_CSENS_F) |         \
                                     PIN_OSPEED_100M(PIN_CSENS_E) |         \
                                     PIN_OSPEED_50M(PIN_PWM_C_HS) |         \
                                     PIN_OSPEED_50M(PIN_PWM_B_HS) |         \
                                     PIN_OSPEED_50M(PIN_PWM_A_HS) |         \
                                     PIN_OSPEED_100M(PIN_USB_DM) |          \
                                     PIN_OSPEED_100M(PIN_USB_DP) |          \
                                     PIN_OSPEED_100M(PIN_SWDIO) |           \
                                     PIN_OSPEED_100M(PIN_SWDCLK) |          \
                                     PIN_OSPEED_100M(GPIOA_PIN15))
#define VAL_GPIOA_PUPDR             (PIN_PUPDR_FLOATING(PIN_VSENS_C) |      \
                                     PIN_PUPDR_FLOATING(PIN_VSENS_B) |        \
                                     PIN_PUPDR_FLOATING(PIN_VSENS_A) |      \
                                     PIN_PUPDR_FLOATING(PIN_TEMPSENS) |      \
                                     PIN_PUPDR_FLOATING(PIN_VSENS_E) |      \
                                     PIN_PUPDR_FLOATING(PIN_VSENS_F) |      \
                                     PIN_PUPDR_FLOATING(PIN_CSENS_F) |      \
                                     PIN_PUPDR_FLOATING(PIN_CSENS_E) |      \
                                     PIN_PUPDR_FLOATING(PIN_PWM_C_HS) |     \
                                     PIN_PUPDR_FLOATING(PIN_PWM_B_HS) |     \
                                     PIN_PUPDR_FLOATING(PIN_PWM_A_HS) |     \
                                     PIN_PUPDR_FLOATING(PIN_USB_DM) |       \
                                     PIN_PUPDR_FLOATING(PIN_USB_DP) |       \
                                     PIN_PUPDR_FLOATING(PIN_SWDIO) |        \
                                     PIN_PUPDR_FLOATING(PIN_SWDCLK) |       \
									 PIN_PUPDR_PULLUP(GPIOA_PIN15))
#define VAL_GPIOA_ODR               (PIN_ODR_HIGH(PIN_VSENS_C) |            \
                                     PIN_ODR_HIGH(PIN_VSENS_B) |               \
                                     PIN_ODR_HIGH(PIN_VSENS_A) |            \
                                     PIN_ODR_HIGH(PIN_TEMPSENS) |            \
                                     PIN_ODR_HIGH(PIN_VSENS_E) |            \
                                     PIN_ODR_HIGH(PIN_VSENS_F) |            \
                                     PIN_ODR_HIGH(PIN_CSENS_F) |            \
                                     PIN_ODR_HIGH(PIN_CSENS_E) |            \
                                     PIN_ODR_LOW(PIN_PWM_C_HS) |            \
                                     PIN_ODR_LOW(PIN_PWM_B_HS) |            \
                                     PIN_ODR_LOW(PIN_PWM_A_HS) |            \
                                     PIN_ODR_HIGH(PIN_USB_DM) |             \
                                     PIN_ODR_HIGH(PIN_USB_DP) |             \
                                     PIN_ODR_HIGH(PIN_SWDIO) |              \
                                     PIN_ODR_HIGH(PIN_SWDCLK) |             \
                                     PIN_ODR_HIGH(GPIOA_PIN15))
#define VAL_GPIOA_AFRL              (PIN_AFIO_AF(PIN_VSENS_C, 0) |          \
                                     PIN_AFIO_AF(PIN_VSENS_B, 0) |            \
                                     PIN_AFIO_AF(PIN_VSENS_A, 0) |          \
                                     PIN_AFIO_AF(PIN_TEMPSENS, 0) |          \
                                     PIN_AFIO_AF(PIN_VSENS_E, 0) |          \
                                     PIN_AFIO_AF(PIN_VSENS_F, 0) |          \
                                     PIN_AFIO_AF(PIN_CSENS_F, 0) |          \
                                     PIN_AFIO_AF(PIN_CSENS_E, 0))
#define VAL_GPIOA_AFRH              (PIN_AFIO_AF(PIN_PWM_C_HS, 1) |         \
                                     PIN_AFIO_AF(PIN_PWM_B_HS, 1) |         \
                                     PIN_AFIO_AF(PIN_PWM_A_HS, 1) |         \
                                     PIN_AFIO_AF(PIN_USB_DM, 10) |          \
                                     PIN_AFIO_AF(PIN_USB_DP, 10) |          \
                                     PIN_AFIO_AF(PIN_SWDIO, 0) |            \
                                     PIN_AFIO_AF(PIN_SWDCLK, 0) |           \
                                     PIN_AFIO_AF(GPIOA_PIN15, 0))

/*
 * GPIOB setup:
 *
 * PB0  - PIN_CSENS_B               (analog input).
 * PB1  - PIN_CSENS_A               (analog input).
 * PB2  - PIN_PB2                   (input pull-up).
 * PB3  - PIN_TRACESWO              (alternate 0 (system)).
 * PB4  - PIN_PB4            		(input pull-up).
 * PB5  - PIN_SERVO    		        (output push-pull 50MHz).TIM3_CH2
 * PB6  - PIN_HALLA               	(input pull-up).
 * PB7  - PIN_HALLB               	(input pull-up).
 * PB8  - PIN_CAN_RX                (alternate 9 (CAN) push-pull pull-up). TODO: check CAN pin config
 * PB9  - PIN_CAN_TX                (alternate 9 (CAN) push-pull pull-up). TODO: check CAN pin config
 * PB10 - PIN_I2C_SCL               (alternate 4 (I2C) open drain).
 * PB11 - PIN_I2C_SDA               (alternate 4 (I2C) open drain).
 * PB12 - PIN_DC_CAL                (output push-pull 50MHz).
 * PB13 - PIN_PWM_C_LS/PIN_ENABLE_C (alternate 1 (TIM1) push-pull output 50MHz / output push-pull).
 * PB14 - PIN_PWM_B_LS/PIN_ENABLE_B (alternate 1 (TIM1) push-pull output 50MHz / output push-pull).
 * PB15 - PIN_PWM_A_LS/PIN_ENABLE_A (alternate 1 (TIM1) push-pull output 50MHz / output push-pull).
 */
#define VAL_GPIOB_MODER             (PIN_MODE_ANALOG(PIN_CSENS_B) |         \
                                     PIN_MODE_ANALOG(PIN_CSENS_A) |         \
                                     PIN_MODE_INPUT(PIN_PB2) |             \
                                     PIN_MODE_ALTERNATE(PIN_TRACESWO) |     \
									 PIN_MODE_INPUT(PIN_PB4) |     		   \
									 PIN_MODE_ALTERNATE(PIN_SERVO) |        \
									 PIN_MODE_INPUT(PIN_HALLA) |      \
									 PIN_MODE_INPUT(PIN_HALLB) |      \
                                     PIN_MODE_ALTERNATE(PIN_CAN_RX) |       \
                                     PIN_MODE_ALTERNATE(PIN_CAN_TX) |       \
                                     PIN_MODE_ALTERNATE(PIN_I2C_SCL) |        \
                                     PIN_MODE_ALTERNATE(PIN_I2C_SDA) |        \
                                     PIN_MODE_OUTPUT(PIN_DC_CAL) |             \
                                     PIN_MODE_ALTERNATE(PIN_PWM_C_LS) |     \
                                     PIN_MODE_ALTERNATE(PIN_PWM_B_LS) |     \
									 PIN_MODE_ALTERNATE(PIN_PWM_A_LS))
#define VAL_GPIOB_OTYPER            (PIN_OTYPE_PUSHPULL(PIN_CSENS_B) |      \
                                     PIN_OTYPE_PUSHPULL(PIN_CSENS_A) |      \
                                     PIN_OTYPE_PUSHPULL(PIN_PB2) |         \
                                     PIN_OTYPE_PUSHPULL(PIN_TRACESWO) |     \
                                     PIN_OTYPE_PUSHPULL(PIN_PB4) |   	  \
                                     PIN_OTYPE_PUSHPULL(PIN_SERVO) |     \
									 PIN_OTYPE_PUSHPULL(PIN_HALLA) |     \
									 PIN_OTYPE_PUSHPULL(PIN_HALLB) |     \
                                     PIN_OTYPE_PUSHPULL(PIN_CAN_RX) |       \
                                     PIN_OTYPE_PUSHPULL(PIN_CAN_TX) |       \
                                     PIN_OTYPE_PUSHPULL(PIN_I2C_SCL) |        \
                                     PIN_OTYPE_PUSHPULL(PIN_I2C_SDA) |        \
                                     PIN_OTYPE_PUSHPULL(PIN_DC_CAL) |         \
                                     PIN_OTYPE_PUSHPULL(PIN_PWM_C_LS) |     \
                                     PIN_OTYPE_PUSHPULL(PIN_PWM_B_LS) |     \
                                     PIN_OTYPE_PUSHPULL(PIN_PWM_A_LS))
#define VAL_GPIOB_OSPEEDR           (PIN_OSPEED_100M(PIN_CSENS_B) |         \
                                     PIN_OSPEED_100M(PIN_CSENS_A) |         \
                                     PIN_OSPEED_100M(PIN_PB2) |            \
                                     PIN_OSPEED_100M(PIN_TRACESWO) |        \
                                     PIN_OSPEED_100M(PIN_PB4) |   		     \
									 PIN_OSPEED_50M(PIN_SERVO) |         \
                                     PIN_OSPEED_50M(PIN_HALLA) |         \
									 PIN_OSPEED_50M(PIN_HALLB) |         \
                                     PIN_OSPEED_50M(PIN_CAN_RX) |           \
									 PIN_OSPEED_50M(PIN_CAN_TX) |           \
                                     PIN_OSPEED_50M(PIN_I2C_SCL) |           \
									 PIN_OSPEED_50M(PIN_I2C_SDA) |           \
                                     PIN_OSPEED_50M(PIN_DC_CAL) |            \
                                     PIN_OSPEED_50M(PIN_PWM_C_LS) |         \
									 PIN_OSPEED_50M(PIN_PWM_B_LS) |         \
									 PIN_OSPEED_50M(PIN_PWM_A_LS))
#define VAL_GPIOB_PUPDR             (PIN_PUPDR_FLOATING(PIN_CSENS_B) |      \
		                             PIN_PUPDR_FLOATING(PIN_CSENS_A) |      \
                                     PIN_PUPDR_PULLUP(PIN_PB2) |           \
                                     PIN_PUPDR_FLOATING(PIN_TRACESWO) |     \
                                     PIN_PUPDR_FLOATING(PIN_PB4) |  	   \
									 PIN_PUPDR_FLOATING(PIN_SERVO) |     \
									 PIN_PUPDR_PULLUP(PIN_HALLA) |      \
									 PIN_PUPDR_PULLUP(PIN_HALLB) |      \
                                     PIN_PUPDR_PULLUP(PIN_CAN_RX) |         \
									 PIN_PUPDR_PULLUP(PIN_CAN_TX) |         \
									 PIN_PUPDR_PULLUP(PIN_I2C_SCL) |        \
									 PIN_PUPDR_PULLUP(PIN_I2C_SDA) |        \
                                     PIN_PUPDR_FLOATING(PIN_DC_CAL) |         \
                                     PIN_PUPDR_FLOATING(PIN_PWM_C_LS) |     \
									 PIN_PUPDR_FLOATING(PIN_PWM_B_LS) |     \
									 PIN_PUPDR_FLOATING(PIN_PWM_A_LS))
#define VAL_GPIOB_ODR               (PIN_ODR_HIGH(PIN_CSENS_B) |            \
                                     PIN_ODR_HIGH(PIN_CSENS_A) |            \
                                     PIN_ODR_HIGH(PIN_PB2) |               \
                                     PIN_ODR_HIGH(PIN_TRACESWO) |           \
                                     PIN_ODR_LOW(PIN_PB4) |      	      \
									 PIN_ODR_LOW(PIN_SERVO) |            \
                                     PIN_ODR_HIGH(PIN_HALLA) |            \
									 PIN_ODR_HIGH(PIN_HALLB) |            \
                                     PIN_ODR_HIGH(PIN_CAN_RX) |             \
									 PIN_ODR_HIGH(PIN_CAN_TX) |             \
                                     PIN_ODR_HIGH(PIN_I2C_SCL) |               \
									 PIN_ODR_HIGH(PIN_I2C_SDA) |               \
                                     PIN_ODR_LOW(PIN_DC_CAL) |                \
                                     PIN_ODR_LOW(PIN_PWM_C_LS) |            \
									 PIN_ODR_LOW(PIN_PWM_B_LS) |            \
									 PIN_ODR_LOW(PIN_PWM_A_LS))
#define VAL_GPIOB_AFRL              (PIN_AFIO_AF(PIN_CSENS_B, 0) |          \
                                     PIN_AFIO_AF(PIN_CSENS_A, 0) |          \
                                     PIN_AFIO_AF(PIN_PB2, 0) |             \
                                     PIN_AFIO_AF(PIN_TRACESWO, 0) |         \
                                     PIN_AFIO_AF(PIN_PB4, 0) |         \
                                     PIN_AFIO_AF(PIN_SERVO, 2) |         \
                                     PIN_AFIO_AF(PIN_HALLA, 0) |          \
                                     PIN_AFIO_AF(PIN_HALLB, 0))
#define VAL_GPIOB_AFRH              (PIN_AFIO_AF(PIN_CAN_RX, 9) |           \
                                     PIN_AFIO_AF(PIN_CAN_TX, 9) |           \
                                     PIN_AFIO_AF(PIN_I2C_SCL, 4) |            \
                                     PIN_AFIO_AF(PIN_I2C_SDA, 4) |            \
                                     PIN_AFIO_AF(PIN_DC_CAL, 0) |             \
                                     PIN_AFIO_AF(PIN_PWM_C_LS, 1) |         \
									 PIN_AFIO_AF(PIN_PWM_B_LS, 1) |         \
									 PIN_AFIO_AF(PIN_PWM_A_LS, 1))

/*
 * GPIOC setup:
 *
 * PC0  - PIN_TEMPSENSMOTOR         (analog input).
 * PC1  - PIN_PC1		            (analog input).
 * PC2  - PIN_AN_IN/PIN_VSENS_BAT/PIN_EXT     (analog input).
 * PC3  - PIN_PC3               (analog input).
 * PC4  - PIN_LED_GREEN               (analog input).
 * PC5  - PIN_LED_RED               (analog input).
 * PC6  - PIN_USART_TX              (alternate 8 (USART) push-pull 100MHz). TODO: check USART TX pin frequency
 * PC7  - PIN_USART_RX              (alternate 8 (USART) input floating). TODO: check whether USART RX pin should be floating or pull-up
 * PC8  - PIN_PC8			(not connected)  (alternate 8 (USART) push-pull 100MHz /  TODO: check USART CK pin frequency
 * PC9  - PIN_PC9               (alternate 2 (TIM3) input floating).
 * PC10 - PIN_EN_GATE               (alternate 6 (SPI3) Master: push-pull 100MHz, Slave: input floating). TODO: check SPI_SCK pin frequency
 * PC11 - PIN_HALLC              (alternate 6 (SPI3) Master: input floating/pull-up, Slave point-to-point: push-pull 100MHz, Slave multi-slave: open drain 100MHz). TODO: check SPI_MISO pin frequency and whether input should be floating or pull-up
 * PC12 - PIN_FAULTC              (alternate 6 (SPI3) Master: push-pull 100MHz, Slave: input floating/pull-up). TODO: check whether SPI_MOSI pin in slave mode should be floating or pull-up
 * PC13 - PIN_PC13           (output pushpull 2MHz).
 * PC14 - PIN_PC14          (output pushpull 2MHz).
 * PC15 - PIN_PC15                (input pullup).
 */
#define VAL_GPIOC_MODER             (PIN_MODE_ANALOG(PIN_TEMPSENSMOTOR) |        \
                                     PIN_MODE_ANALOG(PIN_PC1) |        \
                                     PIN_MODE_ANALOG(PIN_AN_IN) |       \
                                     PIN_MODE_ANALOG(PIN_PC3) |         \
									 PIN_MODE_OUTPUT(PIN_LED_GREEN) |         \
									 PIN_MODE_OUTPUT(PIN_LED_RED) |         \
                                     PIN_MODE_ALTERNATE(PIN_USART_TX) |     \
                                     PIN_MODE_ALTERNATE(PIN_USART_RX) |     \
									 PIN_MODE_INPUT(PIN_PC8) |     \
									 PIN_MODE_INPUT(PIN_PC9) |      \
									 PIN_MODE_OUTPUT(PIN_EN_GATE) |      \
									 PIN_MODE_INPUT(PIN_HALLC) |     \
									 PIN_MODE_INPUT(PIN_FAULTC) |      \
									 PIN_MODE_INPUT(PIN_PC13) |            \
									 PIN_MODE_INPUT(PIN_PC14) |            \
									 PIN_MODE_INPUT(PIN_PC15))
#define VAL_GPIOC_OTYPER            (PIN_OTYPE_PUSHPULL(PIN_TEMPSENSMOTOR) |     \
                                     PIN_OTYPE_PUSHPULL(PIN_PC1) |     \
                                     PIN_OTYPE_PUSHPULL(PIN_AN_IN) |    \
                                     PIN_OTYPE_PUSHPULL(PIN_PC3) |      \
                                     PIN_OTYPE_PUSHPULL(PIN_LED_GREEN) |      \
                                     PIN_OTYPE_PUSHPULL(PIN_LED_RED) |      \
                                     PIN_OTYPE_PUSHPULL(PIN_USART_TX) |     \
                                     PIN_OTYPE_PUSHPULL(PIN_USART_RX) |     \
                                     PIN_OTYPE_PUSHPULL(PIN_PC8) |     \
                                     PIN_OTYPE_PUSHPULL(PIN_PC9) |      \
                                     PIN_OTYPE_PUSHPULL(PIN_EN_GATE) |      \
                                     PIN_OTYPE_PUSHPULL(PIN_HALLC) |     \
                                     PIN_OTYPE_PUSHPULL(PIN_FAULTC) |     \
                                     PIN_OTYPE_PUSHPULL(PIN_PC13) |         \
                                     PIN_OTYPE_PUSHPULL(PIN_PC14) |         \
									 PIN_OTYPE_PUSHPULL(PIN_PC15))
#define VAL_GPIOC_OSPEEDR           (PIN_OSPEED_100M(PIN_TEMPSENSMOTOR) |        \
                                     PIN_OSPEED_100M(PIN_PC1) |        \
                                     PIN_OSPEED_100M(PIN_AN_IN) |       \
                                     PIN_OSPEED_100M(PIN_PC3) |         \
                                     PIN_OSPEED_50M(PIN_LED_GREEN) |         \
                                     PIN_OSPEED_50M(PIN_LED_RED) |         \
                                     PIN_OSPEED_100M(PIN_USART_TX) |        \
                                     PIN_OSPEED_100M(PIN_USART_RX) |        \
                                     PIN_OSPEED_50M(PIN_PC8) |        \
                                     PIN_OSPEED_50M(PIN_PC9) |         \
                                     PIN_OSPEED_50M(PIN_EN_GATE) |         \
                                     PIN_OSPEED_50M(PIN_HALLC) |        \
                                     PIN_OSPEED_50M(PIN_FAULTC) |        \
                                     PIN_OSPEED_2M(PIN_PC13) |              \
									 PIN_OSPEED_2M(PIN_PC14) |              \
									 PIN_OSPEED_2M(PIN_PC15))
#define VAL_GPIOC_PUPDR             (PIN_PUPDR_FLOATING(PIN_TEMPSENSMOTOR) |     \
                                     PIN_PUPDR_FLOATING(PIN_PC1) |     \
									 PIN_PUPDR_FLOATING(PIN_AN_IN) |    \
                                     PIN_PUPDR_FLOATING(PIN_PC3) |      \
                                     PIN_PUPDR_FLOATING(PIN_LED_GREEN) |      \
                                     PIN_PUPDR_FLOATING(PIN_LED_RED) |      \
                                     PIN_PUPDR_FLOATING(PIN_USART_TX) |     \
                                     PIN_PUPDR_FLOATING(PIN_USART_RX) |     \
                                     PIN_PUPDR_FLOATING(PIN_PC8) |     \
                                     PIN_PUPDR_FLOATING(PIN_PC9) |      \
                                     PIN_PUPDR_FLOATING(PIN_EN_GATE) |      \
									 PIN_PUPDR_PULLUP(PIN_HALLC) |     \
									 PIN_PUPDR_PULLUP(PIN_FAULTC) |     \
									 PIN_PUPDR_PULLUP(PIN_PC13) |         \
									 PIN_PUPDR_PULLUP(PIN_PC14) |         \
									 PIN_PUPDR_PULLUP(PIN_PC15))
#define VAL_GPIOC_ODR               (PIN_ODR_HIGH(PIN_TEMPSENSMOTOR) |           \
                                     PIN_ODR_HIGH(PIN_PC1) |           \
                                     PIN_ODR_HIGH(PIN_AN_IN) |          \
                                     PIN_ODR_HIGH(PIN_PC3) |            \
                                     PIN_ODR_LOW(PIN_LED_GREEN) |            \
                                     PIN_ODR_HIGH(PIN_LED_RED) |            \
                                     PIN_ODR_LOW(PIN_USART_TX) |            \
                                     PIN_ODR_HIGH(PIN_USART_RX) |           \
                                     PIN_ODR_HIGH(PIN_PC8) |           \
                                     PIN_ODR_HIGH(PIN_PC9) |            \
                                     PIN_ODR_HIGH(PIN_EN_GATE) |            \
                                     PIN_ODR_HIGH(PIN_HALLC) |           \
                                     PIN_ODR_HIGH(PIN_FAULTC) |           \
                                     PIN_ODR_HIGH(PIN_PC13) |               \
                                     PIN_ODR_HIGH(PIN_PC14) |                \
									 PIN_ODR_HIGH(PIN_PC15))
#define VAL_GPIOC_AFRL              (PIN_AFIO_AF(PIN_TEMPSENSMOTOR, 0) |         \
                                     PIN_AFIO_AF(PIN_PC1, 0) |         \
                                     PIN_AFIO_AF(PIN_AN_IN, 0) |        \
                                     PIN_AFIO_AF(PIN_PC3, 0) |          \
                                     PIN_AFIO_AF(PIN_LED_GREEN, 0) |          \
                                     PIN_AFIO_AF(PIN_LED_RED, 0) |          \
                                     PIN_AFIO_AF(PIN_USART_TX, 8) |         \
                                     PIN_AFIO_AF(PIN_USART_RX, 8))
#define VAL_GPIOC_AFRH              (PIN_AFIO_AF(PIN_PC8, 0) |         \
                                     PIN_AFIO_AF(PIN_PC9, 0) |          \
                                     PIN_AFIO_AF(PIN_EN_GATE, 0) |          \
                                     PIN_AFIO_AF(PIN_HALLC, 0) |         \
                                     PIN_AFIO_AF(PIN_FAULTC, 0) |         \
                                     PIN_AFIO_AF(PIN_PC13, 0) |             \
                                     PIN_AFIO_AF(PIN_PC14, 0) |             \
									 PIN_AFIO_AF(PIN_PC15, 0))

/*
 * GPIOD setup:
 *
 * PD2  - PIN_ENABLE_D              (output push-pull 50MHz).
 */
#define VAL_GPIOD_MODER             (PIN_MODE_INPUT(PIN_PD2))
#define VAL_GPIOD_OTYPER            (PIN_OTYPE_PUSHPULL(PIN_PD2))
#define VAL_GPIOD_OSPEEDR           (PIN_OSPEED_50M(PIN_PD2))
#define VAL_GPIOD_PUPDR             (PIN_PUPDR_FLOATING(PIN_PD2))
#define VAL_GPIOD_ODR               (PIN_ODR_LOW(PIN_PD2))
#define VAL_GPIOD_AFRL              (PIN_AFIO_AF(PIN_PD2, 0))
#define VAL_GPIOD_AFRH				0

#define VAL_GPIOE_MODER				0
#define VAL_GPIOE_OTYPER			0
#define VAL_GPIOE_OSPEEDR			0
#define VAL_GPIOE_PUPDR				0
#define VAL_GPIOE_ODR				0
#define VAL_GPIOE_AFRL				0
#define VAL_GPIOE_AFRH				0

#define VAL_GPIOF_MODER				0
#define VAL_GPIOF_OTYPER			0
#define VAL_GPIOF_OSPEEDR			0
#define VAL_GPIOF_PUPDR				0
#define VAL_GPIOF_ODR				0
#define VAL_GPIOF_AFRL				0
#define VAL_GPIOF_AFRH				0

#define VAL_GPIOG_MODER				0
#define VAL_GPIOG_OTYPER			0
#define VAL_GPIOG_OSPEEDR			0
#define VAL_GPIOG_PUPDR				0
#define VAL_GPIOG_ODR				0
#define VAL_GPIOG_AFRL				0
#define VAL_GPIOG_AFRH				0

/*
 * GPIOH setup:
 *
 * PH0  - OSC_IN                    (input floating).
 * PH1  - OSC_OUT                   (input floating).
 */
#define VAL_GPIOH_MODER             (PIN_MODE_INPUT(PIN_OSC_IN) |         \
                                     PIN_MODE_INPUT(PIN_OSC_OUT))
#define VAL_GPIOH_OTYPER            (PIN_OTYPE_PUSHPULL(PIN_OSC_IN) |     \
                                     PIN_OTYPE_PUSHPULL(PIN_OSC_OUT))
#define VAL_GPIOH_OSPEEDR           (PIN_OSPEED_100M(PIN_OSC_IN) |        \
                                     PIN_OSPEED_100M(PIN_OSC_OUT))
#define VAL_GPIOH_PUPDR             (PIN_PUPDR_FLOATING(PIN_OSC_IN) |     \
                                     PIN_PUPDR_FLOATING(PIN_OSC_OUT))
#define VAL_GPIOH_ODR               (PIN_ODR_HIGH(PIN_OSC_IN) |           \
                                     PIN_ODR_HIGH(PIN_OSC_OUT))
#define VAL_GPIOH_AFRL              (PIN_AFIO_AF(PIN_OSC_IN, 0) |         \
                                     PIN_AFIO_AF(PIN_OSC_OUT, 0))
#define VAL_GPIOH_AFRH 				0

#define VAL_GPIOI_MODER				0
#define VAL_GPIOI_OTYPER			0
#define VAL_GPIOI_OSPEEDR			0
#define VAL_GPIOI_PUPDR				0
#define VAL_GPIOI_ODR				0
#define VAL_GPIOI_AFRL				0
#define VAL_GPIOI_AFRH				0

#endif // BOARD_VESC


/*
 * DrChibi on F4Discovery pin setup
 */
#if defined(BOARD_DRCHIBI_DISCO)

/*
 * GPIOA setup:
 *
 * PA0  - PIN_VSENS_C               (analog input).
 * PA1  - PIN_PWM_A                 (alternate 1 (TIM2) push-pull output 50MHz).
 * PA2  - PIN_VSENS_A               (analog input).
 * PA3  - PIN_VSENS_D               (analog input).
 * PA4  - PIN_VSENS_E               (analog input).
 * PA5  - PIN_VSENS_F               (analog input).
 * PA6  - PIN_CSENS_F               (analog input).
 * PA7  - PIN_CSENS_E               (analog input).
 * PA8  - PIN_PA8 / UNUSED			(input floating).
 * PA9  - PIN_VBUS_FS               (input floating).
 * PA10 - PIN_OTG_FS_ID             (alternate 10).
 * PA11 - PIN_USB_DM                (alternate 10 (USB), controlled automatically).
 * PA12 - PIN_USB_DP                (alternate 10 (USB), controlled automatically).
 * PA13 - PIN_SWDIO                 (alternate 0 (system)).
 * PA14 - PIN_SWDCLK                (alternate 0 (system)).
 * PA15 - PIN_PWM_B                   (output push-pull 50MHz).
 */
#define VAL_GPIOA_MODER             (PIN_MODE_ANALOG(PIN_VSENS_C) |         \
                                     PIN_MODE_OUTPUT(PIN_PWM_A) |        \
                                     PIN_MODE_ANALOG(PIN_VSENS_A) |         \
                                     PIN_MODE_ANALOG(PIN_VSENS_D) |         \
                                     PIN_MODE_ANALOG(PIN_VSENS_E) |         \
                                     PIN_MODE_ANALOG(PIN_VSENS_F) |         \
                                     PIN_MODE_ANALOG(PIN_CSENS_F) |         \
                                     PIN_MODE_ANALOG(PIN_CSENS_E) |         \
                                     PIN_MODE_OUTPUT(PIN_PWM_C) |              \
                                     PIN_MODE_INPUT(PIN_VBUS_FS) |          \
                                     PIN_MODE_ALTERNATE(PIN_OTG_FS_ID) |    \
                                     PIN_MODE_ALTERNATE(PIN_USB_DM) |       \
                                     PIN_MODE_ALTERNATE(PIN_USB_DP) |       \
                                     PIN_MODE_ALTERNATE(PIN_SWDIO) |        \
                                     PIN_MODE_ALTERNATE(PIN_SWDCLK) |       \
									 PIN_MODE_OUTPUT(PIN_PWM_B))
#define VAL_GPIOA_OTYPER            (PIN_OTYPE_PUSHPULL(PIN_VSENS_C) |      \
                                     PIN_OTYPE_PUSHPULL(PIN_PWM_A) |        \
                                     PIN_OTYPE_PUSHPULL(PIN_VSENS_A) |      \
                                     PIN_OTYPE_PUSHPULL(PIN_VSENS_D) |      \
                                     PIN_OTYPE_PUSHPULL(PIN_VSENS_E) |      \
                                     PIN_OTYPE_PUSHPULL(PIN_VSENS_F) |      \
                                     PIN_OTYPE_PUSHPULL(PIN_CSENS_F) |      \
                                     PIN_OTYPE_PUSHPULL(PIN_CSENS_E) |      \
                                     PIN_OTYPE_PUSHPULL(PIN_PWM_C) |          \
                                     PIN_OTYPE_PUSHPULL(PIN_VBUS_FS) |      \
                                     PIN_OTYPE_PUSHPULL(PIN_OTG_FS_ID) |    \
                                     PIN_OTYPE_PUSHPULL(PIN_USB_DM) |       \
                                     PIN_OTYPE_PUSHPULL(PIN_USB_DP) |       \
                                     PIN_OTYPE_PUSHPULL(PIN_SWDIO) |        \
                                     PIN_OTYPE_PUSHPULL(PIN_SWDCLK) |       \
									 PIN_OTYPE_PUSHPULL(PIN_PWM_B))
#define VAL_GPIOA_OSPEEDR           (PIN_OSPEED_100M(PIN_VSENS_C) |         \
                                     PIN_OSPEED_50M(PIN_PWM_A) |            \
                                     PIN_OSPEED_100M(PIN_VSENS_A) |         \
                                     PIN_OSPEED_100M(PIN_VSENS_D) |         \
                                     PIN_OSPEED_100M(PIN_VSENS_E) |         \
                                     PIN_OSPEED_100M(PIN_VSENS_F) |         \
                                     PIN_OSPEED_100M(PIN_CSENS_F) |         \
                                     PIN_OSPEED_100M(PIN_CSENS_E) |         \
                                     PIN_OSPEED_50M(PIN_PWM_C) |             \
                                     PIN_OSPEED_100M(PIN_VBUS_FS) |         \
                                     PIN_OSPEED_100M(PIN_OTG_FS_ID) |       \
                                     PIN_OSPEED_100M(PIN_USB_DM) |          \
                                     PIN_OSPEED_100M(PIN_USB_DP) |          \
                                     PIN_OSPEED_100M(PIN_SWDIO) |           \
                                     PIN_OSPEED_100M(PIN_SWDCLK) |          \
									 PIN_OSPEED_100M(PIN_PWM_B))
#define VAL_GPIOA_PUPDR             (PIN_PUPDR_FLOATING(PIN_VSENS_C) |      \
                                     PIN_PUPDR_FLOATING(PIN_PWM_A) |        \
                                     PIN_PUPDR_FLOATING(PIN_VSENS_A) |      \
                                     PIN_PUPDR_FLOATING(PIN_VSENS_D) |      \
                                     PIN_PUPDR_FLOATING(PIN_VSENS_E) |      \
                                     PIN_PUPDR_FLOATING(PIN_VSENS_F) |      \
                                     PIN_PUPDR_FLOATING(PIN_CSENS_F) |      \
                                     PIN_PUPDR_FLOATING(PIN_CSENS_E) |      \
                                     PIN_PUPDR_FLOATING(PIN_PWM_C) |          \
                                     PIN_PUPDR_FLOATING(PIN_VBUS_FS) |      \
                                     PIN_PUPDR_FLOATING(PIN_OTG_FS_ID) |    \
                                     PIN_PUPDR_FLOATING(PIN_USB_DM) |       \
                                     PIN_PUPDR_FLOATING(PIN_USB_DP) |       \
                                     PIN_PUPDR_FLOATING(PIN_SWDIO) |        \
                                     PIN_PUPDR_FLOATING(PIN_SWDCLK) |       \
									 PIN_PUPDR_FLOATING(PIN_PWM_B))
#define VAL_GPIOA_ODR               (PIN_ODR_HIGH(PIN_VSENS_C) |            \
                                     PIN_ODR_LOW(PIN_PWM_A) |               \
                                     PIN_ODR_HIGH(PIN_VSENS_A) |            \
                                     PIN_ODR_HIGH(PIN_VSENS_D) |            \
                                     PIN_ODR_HIGH(PIN_VSENS_E) |            \
                                     PIN_ODR_HIGH(PIN_VSENS_F) |            \
                                     PIN_ODR_HIGH(PIN_CSENS_F) |            \
                                     PIN_ODR_HIGH(PIN_CSENS_E) |            \
                                     PIN_ODR_LOW(PIN_PWM_C) |                \
                                     PIN_ODR_HIGH(PIN_VBUS_FS) |            \
                                     PIN_ODR_HIGH(PIN_OTG_FS_ID) |          \
                                     PIN_ODR_HIGH(PIN_USB_DM) |             \
                                     PIN_ODR_HIGH(PIN_USB_DP) |             \
                                     PIN_ODR_HIGH(PIN_SWDIO) |              \
                                     PIN_ODR_HIGH(PIN_SWDCLK) |             \
									 PIN_ODR_LOW(PIN_PWM_B))
#define VAL_GPIOA_AFRL              (PIN_AFIO_AF(PIN_VSENS_C, 0) |          \
                                     PIN_AFIO_AF(PIN_PWM_A, 0) |            \
                                     PIN_AFIO_AF(PIN_VSENS_A, 0) |          \
                                     PIN_AFIO_AF(PIN_VSENS_D, 0) |          \
                                     PIN_AFIO_AF(PIN_VSENS_E, 0) |          \
                                     PIN_AFIO_AF(PIN_VSENS_F, 0) |          \
                                     PIN_AFIO_AF(PIN_CSENS_F, 0) |          \
                                     PIN_AFIO_AF(PIN_CSENS_E, 0))
#define VAL_GPIOA_AFRH              (PIN_AFIO_AF(PIN_PWM_C, 0) |              \
                                     PIN_AFIO_AF(PIN_VBUS_FS, 0) |          \
                                     PIN_AFIO_AF(PIN_OTG_FS_ID, 10) |       \
                                     PIN_AFIO_AF(PIN_USB_DM, 10) |          \
                                     PIN_AFIO_AF(PIN_USB_DP, 10) |          \
                                     PIN_AFIO_AF(PIN_SWDIO, 0) |            \
                                     PIN_AFIO_AF(PIN_SWDCLK, 0) |           \
									 PIN_AFIO_AF(PIN_PWM_B, 0))

/*
 * GPIOB setup:
 *
 * PB0  - PIN_CSENS_B               (analog input).
 * PB1  - PIN_CSENS_A               (analog input).
 * PB2  - PIN_THWN                  (input pull-up).
 * PB3  - PIN_TRACESWO              (alternate 0 (system)).
 * PB4  - PIN_ENABLE_E              (output push-pull 50MHz).
 * PB5  - PIN_ENABLE_F              (output push-pull 50MHz).
 * PB6  - PIN_I2C_SCL               (alternate 4 (I2C) open drain).
 * PB7  - PIN_I2C_SDA               (alternate 4 (I2C) open drain).
 * PB8  - PIN_PB8 / UNUSED			(input floating).
 * PB9  - PIN_PB9 / UNUSED			(input floating).
 * PB10 - PIN_PWM_E                 (alternate 1 (TIM2) push-pull output 50MHz).
 * PB11 - PIN_PWM_D                 (alternate 1 (TIM2) push-pull output 50MHz).
 * PB12 - PIN_PB12                  (input floating).
 * PB13 - PIN_PWM_C_LS/PIN_ENABLE_C (alternate 1 (TIM1) push-pull output 50MHz / output push-pull).
 * PB14 - PIN_PWM_B_LS/PIN_ENABLE_B (alternate 1 (TIM1) push-pull output 50MHz / output push-pull).
 * PB15 - PIN_PWM_F_LS/PIN_ENABLE_F (alternate 1 (TIM1) push-pull output 50MHz / output push-pull).
 */
#define VAL_GPIOB_MODER             (PIN_MODE_ANALOG(PIN_CSENS_B) |         \
                                     PIN_MODE_ANALOG(PIN_CSENS_A) |         \
                                     PIN_MODE_INPUT(PIN_THWN) |             \
                                     PIN_MODE_ALTERNATE(PIN_TRACESWO) |     \
                                     PIN_MODE_OUTPUT(PIN_ENABLE_E) |        \
                                     PIN_MODE_OUTPUT(PIN_ENABLE_F) |        \
                                     PIN_MODE_ALTERNATE(PIN_I2C_SCL) |      \
                                     PIN_MODE_ALTERNATE(PIN_I2C_SDA) |      \
                                     PIN_MODE_INPUT(PIN_PB8) |              \
                                     PIN_MODE_INPUT(PIN_PB9) |              \
                                     PIN_MODE_ALTERNATE(PIN_PWM_E) |        \
                                     PIN_MODE_ALTERNATE(PIN_PWM_D) |        \
                                     PIN_MODE_OUTPUT(PIN_PB12) |            \
                                     PIN_MODE_ALTERNATE(PIN_PWM_C_LS) | /*PIN_MODE_OUTPUT(PIN_ENABLE_C)*/ \
                                     PIN_MODE_ALTERNATE(PIN_PWM_B_LS) | /*PIN_MODE_OUTPUT(PIN_ENABLE_B)*/ \
									 PIN_MODE_ALTERNATE(PIN_PWM_F_LS)) /*PIN_MODE_OUTPUT(PIN_ENABLE_A))*/
#define VAL_GPIOB_OTYPER            (PIN_OTYPE_PUSHPULL(PIN_CSENS_B) |      \
                                     PIN_OTYPE_PUSHPULL(PIN_CSENS_A) |      \
                                     PIN_OTYPE_PUSHPULL(PIN_THWN) |         \
                                     PIN_OTYPE_PUSHPULL(PIN_TRACESWO) |     \
                                     PIN_OTYPE_PUSHPULL(PIN_ENABLE_E) |     \
                                     PIN_OTYPE_PUSHPULL(PIN_ENABLE_F) |     \
                                     PIN_OTYPE_OPENDRAIN(PIN_I2C_SCL) |     \
                                     PIN_OTYPE_OPENDRAIN(PIN_I2C_SDA) |     \
                                     PIN_OTYPE_PUSHPULL(PIN_PB8) |          \
                                     PIN_OTYPE_PUSHPULL(PIN_PB9) |          \
                                     PIN_OTYPE_PUSHPULL(PIN_PWM_E) |        \
                                     PIN_OTYPE_PUSHPULL(PIN_PWM_D) |        \
                                     PIN_OTYPE_PUSHPULL(PIN_PB12) |         \
                                     PIN_OTYPE_PUSHPULL(PIN_PWM_C_LS) |     \
                                     PIN_OTYPE_PUSHPULL(PIN_PWM_B_LS) |     \
                                     PIN_OTYPE_PUSHPULL(PIN_PWM_F_LS))
#define VAL_GPIOB_OSPEEDR           (PIN_OSPEED_100M(PIN_CSENS_B) |         \
                                     PIN_OSPEED_100M(PIN_CSENS_A) |         \
                                     PIN_OSPEED_100M(PIN_THWN) |            \
                                     PIN_OSPEED_100M(PIN_TRACESWO) |        \
                                     PIN_OSPEED_50M(PIN_ENABLE_E) |         \
									 PIN_OSPEED_50M(PIN_ENABLE_F) |         \
                                     PIN_OSPEED_100M(PIN_I2C_SCL) |         \
									 PIN_OSPEED_100M(PIN_I2C_SDA) |         \
                                     PIN_OSPEED_100M(PIN_PB8) |             \
									 PIN_OSPEED_100M(PIN_PB9) |             \
                                     PIN_OSPEED_100M(PIN_PWM_E) |           \
									 PIN_OSPEED_100M(PIN_PWM_D) |           \
                                     PIN_OSPEED_50M(PIN_PB12) |             \
                                     PIN_OSPEED_50M(PIN_PWM_C_LS) |         \
									 PIN_OSPEED_50M(PIN_PWM_B_LS) |         \
									 PIN_OSPEED_50M(PIN_PWM_F_LS))
#define VAL_GPIOB_PUPDR             (PIN_PUPDR_FLOATING(PIN_CSENS_B) |      \
		                             PIN_PUPDR_FLOATING(PIN_CSENS_A) |      \
                                     PIN_PUPDR_PULLUP(PIN_THWN) |           \
                                     PIN_PUPDR_FLOATING(PIN_TRACESWO) |     \
                                     PIN_PUPDR_FLOATING(PIN_ENABLE_E) |     \
									 PIN_PUPDR_FLOATING(PIN_ENABLE_F) |     \
                                     PIN_PUPDR_FLOATING(PIN_I2C_SCL) |      \
									 PIN_PUPDR_FLOATING(PIN_I2C_SDA) |      \
                                     PIN_PUPDR_FLOATING(PIN_PB8) |          \
									 PIN_PUPDR_FLOATING(PIN_PB9) |          \
                                     PIN_PUPDR_FLOATING(PIN_PWM_E) |        \
									 PIN_PUPDR_FLOATING(PIN_PWM_D) |        \
                                     PIN_PUPDR_FLOATING(PIN_PB12) |         \
                                     PIN_PUPDR_FLOATING(PIN_PWM_C_LS) |     \
									 PIN_PUPDR_FLOATING(PIN_PWM_B_LS) |     \
									 PIN_PUPDR_FLOATING(PIN_PWM_F_LS))
#define VAL_GPIOB_ODR               (PIN_ODR_HIGH(PIN_CSENS_B) |            \
                                     PIN_ODR_HIGH(PIN_CSENS_A) |            \
                                     PIN_ODR_HIGH(PIN_THWN) |               \
                                     PIN_ODR_HIGH(PIN_TRACESWO) |           \
                                     PIN_ODR_LOW(PIN_ENABLE_E) |            \
									 PIN_ODR_LOW(PIN_ENABLE_F) |            \
                                     PIN_ODR_HIGH(PIN_I2C_SCL) |            \
									 PIN_ODR_HIGH(PIN_I2C_SDA) |            \
                                     PIN_ODR_HIGH(PIN_PB8) |                \
									 PIN_ODR_HIGH(PIN_PB9) |                \
                                     PIN_ODR_LOW(PIN_PWM_E) |               \
									 PIN_ODR_LOW(PIN_PWM_D) |               \
                                     PIN_ODR_LOW(PIN_PB12) |                \
                                     PIN_ODR_LOW(PIN_PWM_C_LS) |            \
									 PIN_ODR_LOW(PIN_PWM_B_LS) |            \
									 PIN_ODR_LOW(PIN_PWM_F_LS))
#define VAL_GPIOB_AFRL              (PIN_AFIO_AF(PIN_CSENS_B, 0) |          \
                                     PIN_AFIO_AF(PIN_CSENS_A, 0) |          \
                                     PIN_AFIO_AF(PIN_THWN, 0) |             \
                                     PIN_AFIO_AF(PIN_TRACESWO, 0) |         \
                                     PIN_AFIO_AF(PIN_ENABLE_E, 0) |         \
                                     PIN_AFIO_AF(PIN_ENABLE_F, 0) |         \
                                     PIN_AFIO_AF(PIN_I2C_SCL, 4) |          \
                                     PIN_AFIO_AF(PIN_I2C_SDA, 4))
#define VAL_GPIOB_AFRH              (PIN_AFIO_AF(PIN_PB8, 0) |              \
                                     PIN_AFIO_AF(PIN_PB9, 0) |              \
                                     PIN_AFIO_AF(PIN_PWM_E, 1) |            \
                                     PIN_AFIO_AF(PIN_PWM_D, 1) |            \
                                     PIN_AFIO_AF(PIN_PB12, 0) |             \
                                     PIN_AFIO_AF(PIN_PWM_C_LS, 1) | /* TODO: make sure that AF setting is ignored when pin is in GPIO mode */ \
									 PIN_AFIO_AF(PIN_PWM_B_LS, 1) |         \
									 PIN_AFIO_AF(PIN_PWM_F_LS, 1))

/*
 * GPIOC setup:
 *
 * PC0  - PIN_OTG_FS_POWER_ON       (output pushpull maximum).
 * PC1  - PIN_VSENS_Y1              (analog input).
 * PC2  - PIN_VSENS_BAT             (analog input).
 * PC3  - PIN_VSENS_B               (analog input).
 * PC4  - PIN_CSENS_D               (analog input).
 * PC5  - PIN_CSENS_C               (analog input).
 * PC6  - PIN_USART_TX              (alternate 8 (USART) push-pull 100MHz). TODO: check USART TX pin frequency
 * PC7  - PIN_USART_RX              (alternate 8 (USART) input floating). TODO: check whether USART RX pin should be floating or pull-up
 * PC8  - PIN_USART_CK/PIN_PWM_IN2  (alternate 8 (USART) push-pull 100MHz / alternate 2 (TIM3) input floating). TODO: check USART CK pin frequency
 * PC9  - PIN_PWM_IN1               (alternate 2 (TIM3) input floating).
 * PC10 - PIN_SPI_SCK               (alternate 6 (SPI3) Master: push-pull 100MHz, Slave: input floating). TODO: check SPI_SCK pin frequency
 * PC11 - PIN_SPI_MISO              (alternate 6 (SPI3) Master: input floating/pull-up, Slave point-to-point: push-pull 100MHz, Slave multi-slave: open drain 100MHz). TODO: check SPI_MISO pin frequency and whether input should be floating or pull-up
 * PC12 - PIN_SPI_MOSI              (alternate 6 (SPI3) Master: push-pull 100MHz, Slave: input floating/pull-up). TODO: check whether SPI_MOSI pin in slave mode should be floating or pull-up
 * PC13 - PIN_PC13 / UNUSED			(input floating).
 * PC14 - PIN_PC14 / UNUSED			(input floating).
 * PC15 - PIN_PC15 / UNUSED			(input floating).
 */
#define VAL_GPIOC_MODER             (PIN_MODE_OUTPUT(PIN_OTG_FS_POWER_ON) | \
                                     PIN_MODE_ANALOG(PIN_VSENS_Y1) |        \
                                     PIN_MODE_ANALOG(PIN_VSENS_BAT) |       \
                                     PIN_MODE_ANALOG(PIN_VSENS_B) |         \
                                     PIN_MODE_ANALOG(PIN_CSENS_D) |         \
                                     PIN_MODE_ANALOG(PIN_CSENS_C) |         \
                                     PIN_MODE_ALTERNATE(PIN_USART_TX) |     \
                                     PIN_MODE_ALTERNATE(PIN_USART_RX) |     \
                                     PIN_MODE_ALTERNATE(PIN_USART_CK) |     \
                                     PIN_MODE_ALTERNATE(PIN_PWM_IN1) |      \
                                     PIN_MODE_ALTERNATE(PIN_SPI_SCK) |      \
                                     PIN_MODE_ALTERNATE(PIN_SPI_MISO) |     \
                                     PIN_MODE_ALTERNATE(PIN_SPI_MOSI) |     \
                                     PIN_MODE_INPUT(PIN_PC13) |             \
                                     PIN_MODE_INPUT(PIN_PC14) |             \
									 PIN_MODE_INPUT(PIN_PC15))
#define VAL_GPIOC_OTYPER            (PIN_OTYPE_PUSHPULL(PIN_OTG_FS_POWER_ON) | \
                                     PIN_OTYPE_PUSHPULL(PIN_VSENS_Y1) |     \
                                     PIN_OTYPE_PUSHPULL(PIN_VSENS_BAT) |    \
                                     PIN_OTYPE_PUSHPULL(PIN_VSENS_B) |      \
                                     PIN_OTYPE_PUSHPULL(PIN_CSENS_D) |      \
                                     PIN_OTYPE_PUSHPULL(PIN_CSENS_C) |      \
                                     PIN_OTYPE_PUSHPULL(PIN_USART_TX) |     \
                                     PIN_OTYPE_PUSHPULL(PIN_USART_RX) |     \
                                     PIN_OTYPE_PUSHPULL(PIN_USART_CK) |     \
                                     PIN_OTYPE_PUSHPULL(PIN_PWM_IN1) |      \
                                     PIN_OTYPE_PUSHPULL(PIN_SPI_SCK) |      \
                                     PIN_OTYPE_PUSHPULL(PIN_SPI_MISO) | /* PUSHPULL for SPI master or point-to-point slave, OPENDRAIN for SPI multi-slave slave */ \
                                     PIN_OTYPE_PUSHPULL(PIN_SPI_MOSI) |     \
                                     PIN_OTYPE_PUSHPULL(PIN_PC13) |         \
                                     PIN_OTYPE_PUSHPULL(PIN_PC14) |         \
									 PIN_OTYPE_PUSHPULL(PIN_PC15))
#define VAL_GPIOC_OSPEEDR           (PIN_OSPEED_100M(PIN_OTG_FS_POWER_ON) | \
                                     PIN_OSPEED_100M(PIN_VSENS_Y1) |        \
                                     PIN_OSPEED_100M(PIN_VSENS_BAT) |       \
                                     PIN_OSPEED_100M(PIN_VSENS_B) |         \
                                     PIN_OSPEED_100M(PIN_CSENS_D) |         \
                                     PIN_OSPEED_100M(PIN_CSENS_C) |         \
                                     PIN_OSPEED_100M(PIN_USART_TX) |        \
                                     PIN_OSPEED_100M(PIN_USART_RX) |        \
                                     PIN_OSPEED_100M(PIN_USART_CK) |        \
                                     PIN_OSPEED_100M(PIN_PWM_IN1) |         \
                                     PIN_OSPEED_100M(PIN_SPI_SCK) |         \
                                     PIN_OSPEED_100M(PIN_SPI_MISO) |        \
                                     PIN_OSPEED_100M(PIN_SPI_MOSI) |        \
                                     PIN_OSPEED_100M(PIN_PC13) |            \
									 PIN_OSPEED_100M(PIN_PC14) |            \
									 PIN_OSPEED_100M(PIN_PC15))
#define VAL_GPIOC_PUPDR             (PIN_PUPDR_FLOATING(PIN_OTG_FS_POWER_ON) | \
                                     PIN_PUPDR_FLOATING(PIN_VSENS_Y1) |     \
									 PIN_PUPDR_FLOATING(PIN_VSENS_BAT) |    \
                                     PIN_PUPDR_FLOATING(PIN_VSENS_B) |      \
                                     PIN_PUPDR_FLOATING(PIN_CSENS_D) |      \
                                     PIN_PUPDR_FLOATING(PIN_CSENS_C) |      \
                                     PIN_PUPDR_FLOATING(PIN_USART_TX) |     \
                                     PIN_PUPDR_FLOATING(PIN_USART_RX) |     \
                                     PIN_PUPDR_FLOATING(PIN_USART_CK) |     \
                                     PIN_PUPDR_FLOATING(PIN_PWM_IN1) |      \
                                     PIN_PUPDR_FLOATING(PIN_SPI_SCK) |      \
                                     PIN_PUPDR_FLOATING(PIN_SPI_MISO) |     \
                                     PIN_PUPDR_FLOATING(PIN_SPI_MOSI) |     \
									 PIN_PUPDR_FLOATING(PIN_PC13) |         \
									 PIN_PUPDR_FLOATING(PIN_PC14) |         \
									 PIN_PUPDR_FLOATING(PIN_PC15))
#define VAL_GPIOC_ODR               (PIN_ODR_HIGH(PIN_OTG_FS_POWER_ON) |    \
                                     PIN_ODR_HIGH(PIN_VSENS_Y1) |           \
                                     PIN_ODR_HIGH(PIN_VSENS_BAT) |          \
                                     PIN_ODR_HIGH(PIN_VSENS_B) |            \
                                     PIN_ODR_HIGH(PIN_CSENS_D) |            \
                                     PIN_ODR_HIGH(PIN_CSENS_C) |            \
                                     PIN_ODR_LOW(PIN_USART_TX) |            \
                                     PIN_ODR_HIGH(PIN_USART_RX) |           \
                                     PIN_ODR_HIGH(PIN_USART_CK) |           \
                                     PIN_ODR_HIGH(PIN_PWM_IN1) |            \
                                     PIN_ODR_HIGH(PIN_SPI_SCK) |            \
                                     PIN_ODR_HIGH(PIN_SPI_MISO) |           \
                                     PIN_ODR_HIGH(PIN_SPI_MOSI) |           \
                                     PIN_ODR_HIGH(PIN_PC13) |               \
                                     PIN_ODR_HIGH(PIN_PC14) |               \
									 PIN_ODR_HIGH(PIN_PC15))
#define VAL_GPIOC_AFRL              (PIN_AFIO_AF(PIN_OTG_FS_POWER_ON, 0) |  \
                                     PIN_AFIO_AF(PIN_VSENS_Y1, 0) |         \
                                     PIN_AFIO_AF(PIN_VSENS_BAT, 0) |        \
                                     PIN_AFIO_AF(PIN_VSENS_B, 0) |          \
                                     PIN_AFIO_AF(PIN_CSENS_D, 0) |          \
                                     PIN_AFIO_AF(PIN_CSENS_C, 0) |          \
                                     PIN_AFIO_AF(PIN_USART_TX, 8) |         \
                                     PIN_AFIO_AF(PIN_USART_RX, 8))
#define VAL_GPIOC_AFRH              (PIN_AFIO_AF(PIN_USART_CK, 8) |         \
                                     PIN_AFIO_AF(PIN_PWM_IN1, 2) |          \
                                     PIN_AFIO_AF(PIN_SPI_SCK, 5) | /* TODO: check whether AF5 is correct. Could be AF6 */ \
                                     PIN_AFIO_AF(PIN_SPI_MISO, 5) |         \
                                     PIN_AFIO_AF(PIN_SPI_MOSI, 5) |         \
                                     PIN_AFIO_AF(PIN_PC13, 0) |             \
                                     PIN_AFIO_AF(PIN_PC14, 0) |             \
									 PIN_AFIO_AF(PIN_PC15, 0))

/*
 * GPIOD setup:
 *
 * PD0  - PIN_CAN_RX                (alternate 9 (CAN) push-pull pull-up). TODO: check CAN pin config
 * PD1  - PIN_CAN_TX                (alternate 9 (CAN) push-pull pull-up). TODO: check CAN pin config
 * PD2  - PIN_ENABLE_D              (output push-pull 50MHz).
 * PD3  - PIN_PD3 / UNUSED          (input pullup).
 * PD4  - PIN_RESET                 (output pushpull maximum).
 * PD5  - PIN_OVER_CURRENT          (input floating).
 * PD6  - PIN_PD6 / UNUSED          (input pullup).
 * PD7  - PIN_PD7 / UNUSED          (input pullup).
 * PD8  - PIN_PD8 / UNUSED          (input pullup).
 * PD9  - PIN_PD9 / UNUSED          (input pullup).
 * PD10 - PIN_PD10 / UNUSED         (input pullup).
 * PD11 - PIN_PD11 / UNUSED         (input pullup).
 * PD12 - PIN_LED2 (green)          (output pushpull 2MHz).
 * PD13 - PIN_LED3_DISCO (orange)   (output pushpull 2MHz).
 * PD14 - PIN_LED1 (red)            (output pushpull 2MHz).
 * PD15 - PIN_FAULTC                (input pullup).
 */
#define VAL_GPIOD_MODER             (PIN_MODE_ALTERNATE(PIN_CAN_RX) |       \
                                     PIN_MODE_ALTERNATE(PIN_CAN_TX) |       \
                                     PIN_MODE_INPUT(PIN_ENABLE_D) |         \
                                     PIN_MODE_INPUT(PIN_PD3) |              \
                                     PIN_MODE_OUTPUT(PIN_RESET) |           \
                                     PIN_MODE_INPUT(PIN_OVER_CURRENT) |     \
                                     PIN_MODE_INPUT(PIN_PD6) |              \
                                     PIN_MODE_INPUT(PIN_PD7) |              \
                                     PIN_MODE_INPUT(PIN_PD8) |              \
                                     PIN_MODE_INPUT(PIN_PD9) |              \
                                     PIN_MODE_INPUT(PIN_PD10) |             \
                                     PIN_MODE_INPUT(PIN_PD11) |             \
                                     PIN_MODE_OUTPUT(PIN_LED2) |            \
                                     PIN_MODE_OUTPUT(PIN_LED3_DISCO) |      \
									 PIN_MODE_OUTPUT(PIN_LED1) |            \
									 PIN_MODE_INPUT(PIN_FAULTC))
#define VAL_GPIOD_OTYPER            (PIN_OTYPE_PUSHPULL(PIN_CAN_RX) |       \
                                     PIN_OTYPE_PUSHPULL(PIN_CAN_TX) |       \
                                     PIN_OTYPE_PUSHPULL(PIN_ENABLE_D) |     \
                                     PIN_OTYPE_PUSHPULL(PIN_PD3) |          \
                                     PIN_OTYPE_PUSHPULL(PIN_RESET) |        \
                                     PIN_OTYPE_PUSHPULL(PIN_OVER_CURRENT) | \
                                     PIN_OTYPE_PUSHPULL(PIN_PD6) |          \
                                     PIN_OTYPE_PUSHPULL(PIN_PD7) |          \
                                     PIN_OTYPE_PUSHPULL(PIN_PD8) |          \
                                     PIN_OTYPE_PUSHPULL(PIN_PD9) |          \
                                     PIN_OTYPE_PUSHPULL(PIN_PD10) |         \
                                     PIN_OTYPE_PUSHPULL(PIN_PD11) |         \
                                     PIN_OTYPE_PUSHPULL(PIN_LED2) |         \
                                     PIN_OTYPE_PUSHPULL(PIN_LED3_DISCO) |   \
									 PIN_OTYPE_PUSHPULL(PIN_LED1) |         \
									 PIN_OTYPE_PUSHPULL(PIN_FAULTC))
#define VAL_GPIOD_OSPEEDR           (PIN_OSPEED_50M(PIN_CAN_RX) |           \
									 PIN_OSPEED_50M(PIN_CAN_TX) |           \
                                     PIN_OSPEED_50M(PIN_ENABLE_D) |         \
                                     PIN_OSPEED_100M(PIN_PD3) |             \
									 PIN_OSPEED_100M(PIN_RESET) |           \
                                     PIN_OSPEED_100M(PIN_OVER_CURRENT) |    \
                                     PIN_OSPEED_100M(PIN_PD6) |             \
									 PIN_OSPEED_100M(PIN_PD7) |             \
									 PIN_OSPEED_100M(PIN_PD8) |             \
									 PIN_OSPEED_100M(PIN_PD9) |             \
									 PIN_OSPEED_100M(PIN_PD10) |            \
									 PIN_OSPEED_100M(PIN_PD11) |            \
									 PIN_OSPEED_2M(PIN_LED2) |              \
									 PIN_OSPEED_2M(PIN_LED3_DISCO) |        \
									 PIN_OSPEED_2M(PIN_LED1) |              \
									 PIN_OSPEED_100M(PIN_FAULTC))
#define VAL_GPIOD_PUPDR             (PIN_PUPDR_PULLUP(PIN_CAN_RX) |         \
									 PIN_PUPDR_PULLUP(PIN_CAN_TX) |         \
                                     PIN_PUPDR_FLOATING(PIN_ENABLE_D) |     \
									 PIN_PUPDR_PULLUP(PIN_PD3) |            \
									 PIN_PUPDR_FLOATING(PIN_RESET) |        \
                                     PIN_PUPDR_FLOATING(PIN_OVER_CURRENT) | \
                                     PIN_PUPDR_PULLUP(PIN_PD6) |            \
									 PIN_PUPDR_PULLUP(PIN_PD7) |            \
									 PIN_PUPDR_PULLUP(PIN_PD8) |            \
									 PIN_PUPDR_PULLUP(PIN_PD9) |            \
									 PIN_PUPDR_PULLUP(PIN_PD10) |           \
									 PIN_PUPDR_PULLUP(PIN_PD11) |           \
									 PIN_PUPDR_FLOATING(PIN_LED2) |         \
									 PIN_PUPDR_FLOATING(PIN_LED3_DISCO) |   \
									 PIN_PUPDR_FLOATING(PIN_LED1) |   \
									 PIN_PUPDR_PULLUP(PIN_FAULTC))
#define VAL_GPIOD_ODR               (PIN_ODR_HIGH(PIN_CAN_RX) |             \
									 PIN_ODR_HIGH(PIN_CAN_TX) |             \
                                     PIN_ODR_LOW(PIN_ENABLE_D) |            \
                                     PIN_ODR_HIGH(PIN_PD3) |                \
                                     PIN_ODR_HIGH(PIN_RESET) |              \
                                     PIN_ODR_HIGH(PIN_OVER_CURRENT) |       \
                                     PIN_ODR_HIGH(PIN_PD6) |                \
                                     PIN_ODR_HIGH(PIN_PD7) |                \
                                     PIN_ODR_HIGH(PIN_PD8) |                \
                                     PIN_ODR_HIGH(PIN_PD9) |                \
                                     PIN_ODR_HIGH(PIN_PD10) |               \
                                     PIN_ODR_HIGH(PIN_PD11) |               \
                                     PIN_ODR_LOW(PIN_LED2) |                \
                                     PIN_ODR_LOW(PIN_LED3_DISCO) |          \
									 PIN_ODR_LOW(PIN_LED1) |                \
									 PIN_ODR_HIGH(PIN_FAULTC))
#define VAL_GPIOD_AFRL              (PIN_AFIO_AF(PIN_CAN_RX, 9) |           \
                                     PIN_AFIO_AF(PIN_CAN_TX, 9) |           \
                                     PIN_AFIO_AF(PIN_ENABLE_D, 0) |         \
                                     PIN_AFIO_AF(PIN_PD3, 0) |              \
                                     PIN_AFIO_AF(PIN_RESET, 0) |            \
                                     PIN_AFIO_AF(PIN_OVER_CURRENT, 0) |     \
                                     PIN_AFIO_AF(PIN_PD6, 0) |              \
                                     PIN_AFIO_AF(PIN_PD7, 0))
#define VAL_GPIOD_AFRH              (PIN_AFIO_AF(PIN_PD8, 0) |              \
                                     PIN_AFIO_AF(PIN_PD9, 0) |              \
                                     PIN_AFIO_AF(PIN_PD10, 0) |             \
                                     PIN_AFIO_AF(PIN_PD11, 0) |             \
                                     PIN_AFIO_AF(PIN_LED2, 0) |             \
                                     PIN_AFIO_AF(PIN_LED3_DISCO, 0) |       \
									 PIN_AFIO_AF(PIN_LED1, 0) |             \
									 PIN_AFIO_AF(PIN_FAULTC, 0))

/*
 * GPIOE setup:
 *
 * PE0  - PIN_PE0                   (input floating).
 * PE1  - PIN_PE1                   (input floating).
 * PE2  - PIN_PE2                   (input floating).
 * PE3  - PIN_PE3                   (input floating).
 * PE4  - PIN_PE4                   (input floating).
 * PE5  - PIN_PE5                   (input floating).
 * PE6  - PIN_PE6                   (input floating).
 * PE7  - PIN_PE7                   (input floating).
 * PE8  - PIN_PE8                   (input floating).
 * PE9  - PIN_PWM_C_HS/PIN_PWM_C    (alternate 1 (TIM1) push-pull output 50MHz).
 * PE10 - PIN_PE10                  (input floating).
 * PE11 - PIN_PWM_B_HS/PIN_PWM_B    (alternate 1 (TIM1) push-pull output 50MHz).
 * PE12 - PIN_PE12                  (input floating).
 * PE13 - PIN_PWM_F_HS/PIN_PWM_F    (alternate 1 (TIM1) push-pull output 50MHz).
 * PE14 - PIN_PE14                  (input floating).
 * PE15 - PIN_PE15                  (input floating).
 */
#define VAL_GPIOE_MODER             (PIN_MODE_INPUT(PIN_PE0) |              \
                                     PIN_MODE_INPUT(PIN_PE1) |              \
                                     PIN_MODE_INPUT(PIN_PE2) |              \
                                     PIN_MODE_INPUT(PIN_PE3) |              \
                                     PIN_MODE_INPUT(PIN_PE4) |              \
                                     PIN_MODE_INPUT(PIN_PE5) |              \
                                     PIN_MODE_INPUT(PIN_PE6) |              \
                                     PIN_MODE_INPUT(PIN_PE7) |              \
                                     PIN_MODE_INPUT(PIN_PE8) |              \
                                     PIN_MODE_OUTPUT(PIN_PWM_C_HS) |     \
                                     PIN_MODE_INPUT(PIN_PE10) |             \
                                     PIN_MODE_OUTPUT(PIN_PWM_B_HS) |     \
                                     PIN_MODE_INPUT(PIN_PE12) |             \
                                     PIN_MODE_OUTPUT(PIN_PWM_F_HS) |     \
                                     PIN_MODE_INPUT(PIN_PE14) |             \
                                     PIN_MODE_INPUT(PIN_PE15))
#define VAL_GPIOE_OTYPER            (PIN_OTYPE_PUSHPULL(PIN_PE0) |          \
                                     PIN_OTYPE_PUSHPULL(PIN_PE1) |          \
                                     PIN_OTYPE_PUSHPULL(PIN_PE2) |          \
                                     PIN_OTYPE_PUSHPULL(PIN_PE3) |          \
                                     PIN_OTYPE_PUSHPULL(PIN_PE4) |          \
                                     PIN_OTYPE_PUSHPULL(PIN_PE5) |          \
                                     PIN_OTYPE_PUSHPULL(PIN_PE6) |          \
                                     PIN_OTYPE_PUSHPULL(PIN_PE7) |          \
                                     PIN_OTYPE_PUSHPULL(PIN_PE8) |          \
                                     PIN_OTYPE_PUSHPULL(PIN_PWM_C_HS) |     \
                                     PIN_OTYPE_PUSHPULL(PIN_PE10) |         \
                                     PIN_OTYPE_PUSHPULL(PIN_PWM_B_HS) |     \
                                     PIN_OTYPE_PUSHPULL(PIN_PE12) |         \
                                     PIN_OTYPE_PUSHPULL(PIN_PWM_F_HS) |     \
                                     PIN_OTYPE_PUSHPULL(PIN_PE14) |         \
                                     PIN_OTYPE_PUSHPULL(PIN_PE15))
#define VAL_GPIOE_OSPEEDR           (PIN_OSPEED_100M(PIN_PE0) |             \
                                     PIN_OSPEED_100M(PIN_PE1) |             \
                                     PIN_OSPEED_100M(PIN_PE2) |             \
                                     PIN_OSPEED_100M(PIN_PE3) |             \
                                     PIN_OSPEED_100M(PIN_PE4) |             \
                                     PIN_OSPEED_100M(PIN_PE5) |             \
                                     PIN_OSPEED_100M(PIN_PE6) |             \
                                     PIN_OSPEED_100M(PIN_PE7) |             \
                                     PIN_OSPEED_100M(PIN_PE8) |             \
                                     PIN_OSPEED_50M(PIN_PWM_C_HS) |         \
                                     PIN_OSPEED_100M(PIN_PE10) |            \
                                     PIN_OSPEED_50M(PIN_PWM_B_HS) |         \
                                     PIN_OSPEED_100M(PIN_PE12) |            \
                                     PIN_OSPEED_50M(PIN_PWM_F_HS) |         \
                                     PIN_OSPEED_100M(PIN_PE14) |            \
                                     PIN_OSPEED_100M(PIN_PE15))
#define VAL_GPIOE_PUPDR             (PIN_PUPDR_FLOATING(PIN_PE0) |          \
                                     PIN_PUPDR_FLOATING(PIN_PE1) |          \
                                     PIN_PUPDR_FLOATING(PIN_PE2) |          \
                                     PIN_PUPDR_FLOATING(PIN_PE3) |          \
                                     PIN_PUPDR_FLOATING(PIN_PE4) |          \
                                     PIN_PUPDR_FLOATING(PIN_PE5) |          \
                                     PIN_PUPDR_FLOATING(PIN_PE6) |          \
                                     PIN_PUPDR_FLOATING(PIN_PE7) |          \
                                     PIN_PUPDR_FLOATING(PIN_PE8) |          \
                                     PIN_PUPDR_FLOATING(PIN_PWM_C_HS) |     \
                                     PIN_PUPDR_FLOATING(PIN_PE10) |         \
                                     PIN_PUPDR_FLOATING(PIN_PWM_B_HS) |     \
                                     PIN_PUPDR_FLOATING(PIN_PE12) |         \
                                     PIN_PUPDR_FLOATING(PIN_PWM_F_HS) |     \
                                     PIN_PUPDR_FLOATING(PIN_PE14) |         \
                                     PIN_PUPDR_FLOATING(PIN_PE15))
#define VAL_GPIOE_ODR               (PIN_ODR_HIGH(PIN_PE0) |                \
                                     PIN_ODR_HIGH(PIN_PE1) |                \
                                     PIN_ODR_HIGH(PIN_PE2) |                \
                                     PIN_ODR_HIGH(PIN_PE3) |                \
                                     PIN_ODR_HIGH(PIN_PE4) |                \
                                     PIN_ODR_HIGH(PIN_PE5) |                \
                                     PIN_ODR_HIGH(PIN_PE6) |                \
                                     PIN_ODR_HIGH(PIN_PE7) |                \
                                     PIN_ODR_HIGH(PIN_PE8) |                \
                                     PIN_ODR_LOW(PIN_PWM_C_HS) |            \
                                     PIN_ODR_HIGH(PIN_PE10) |               \
                                     PIN_ODR_LOW(PIN_PWM_B_HS) |            \
                                     PIN_ODR_HIGH(PIN_PE12) |               \
                                     PIN_ODR_LOW(PIN_PWM_F_HS) |            \
                                     PIN_ODR_HIGH(PIN_PE14) |               \
                                     PIN_ODR_HIGH(PIN_PE15))
#define VAL_GPIOE_AFRL              (PIN_AFIO_AF(PIN_PE0, 0) |              \
                                     PIN_AFIO_AF(PIN_PE1, 0) |              \
                                     PIN_AFIO_AF(PIN_PE2, 0) |              \
                                     PIN_AFIO_AF(PIN_PE3, 0) |              \
                                     PIN_AFIO_AF(PIN_PE4, 0) |              \
                                     PIN_AFIO_AF(PIN_PE5, 0) |              \
                                     PIN_AFIO_AF(PIN_PE6, 0) |              \
                                     PIN_AFIO_AF(PIN_PE7, 0))
#define VAL_GPIOE_AFRH              (PIN_AFIO_AF(PIN_PE8, 0) |              \
                                     PIN_AFIO_AF(PIN_PWM_C_HS, 0) |         \
                                     PIN_AFIO_AF(PIN_PE10, 0) |             \
                                     PIN_AFIO_AF(PIN_PWM_B_HS, 0) |         \
                                     PIN_AFIO_AF(PIN_PE12, 0) |             \
                                     PIN_AFIO_AF(PIN_PWM_F_HS, 0) |         \
                                     PIN_AFIO_AF(PIN_PE14, 0) |             \
                                     PIN_AFIO_AF(PIN_PE15, 0))

/*
 * GPIOF setup:
 *
 * PF0  - PIN_PF0                   (input floating).
 * PF1  - PIN_PF1                   (input floating).
 * PF2  - PIN_PF2                   (input floating).
 * PF3  - PIN_PF3                   (input floating).
 * PF4  - PIN_PF4                   (input floating).
 * PF5  - PIN_PF5                   (input floating).
 * PF6  - PIN_PF6                   (input floating).
 * PF7  - PIN_PF7                   (input floating).
 * PF8  - PIN_PF8                   (input floating).
 * PF9  - PIN_PF9                   (input floating).
 * PF10 - PIN_PF10                  (input floating).
 * PF11 - PIN_PF11                  (input floating).
 * PF12 - PIN_PF12                  (input floating).
 * PF13 - PIN_PF13                  (input floating).
 * PF14 - PIN_PF14                  (input floating).
 * PF15 - PIN_PF15                  (input floating).
 */
#define VAL_GPIOF_MODER             (PIN_MODE_INPUT(PIN_PF0) |              \
                                     PIN_MODE_INPUT(PIN_PF1) |              \
                                     PIN_MODE_INPUT(PIN_PF2) |              \
                                     PIN_MODE_INPUT(PIN_PF3) |              \
                                     PIN_MODE_INPUT(PIN_PF4) |              \
                                     PIN_MODE_INPUT(PIN_PF5) |              \
                                     PIN_MODE_INPUT(PIN_PF6) |              \
                                     PIN_MODE_INPUT(PIN_PF7) |              \
                                     PIN_MODE_INPUT(PIN_PF8) |              \
                                     PIN_MODE_INPUT(PIN_PF9) |              \
                                     PIN_MODE_INPUT(PIN_PF10) |             \
                                     PIN_MODE_INPUT(PIN_PF11) |             \
                                     PIN_MODE_INPUT(PIN_PF12) |             \
                                     PIN_MODE_INPUT(PIN_PF13) |             \
                                     PIN_MODE_INPUT(PIN_PF14) |             \
                                     PIN_MODE_INPUT(PIN_PF15))
#define VAL_GPIOF_OTYPER            (PIN_OTYPE_PUSHPULL(PIN_PF0) |          \
                                     PIN_OTYPE_PUSHPULL(PIN_PF1) |          \
                                     PIN_OTYPE_PUSHPULL(PIN_PF2) |          \
                                     PIN_OTYPE_PUSHPULL(PIN_PF3) |          \
                                     PIN_OTYPE_PUSHPULL(PIN_PF4) |          \
                                     PIN_OTYPE_PUSHPULL(PIN_PF5) |          \
                                     PIN_OTYPE_PUSHPULL(PIN_PF6) |          \
                                     PIN_OTYPE_PUSHPULL(PIN_PF7) |          \
                                     PIN_OTYPE_PUSHPULL(PIN_PF8) |          \
                                     PIN_OTYPE_PUSHPULL(PIN_PF9) |          \
                                     PIN_OTYPE_PUSHPULL(PIN_PF10) |         \
                                     PIN_OTYPE_PUSHPULL(PIN_PF11) |         \
                                     PIN_OTYPE_PUSHPULL(PIN_PF12) |         \
                                     PIN_OTYPE_PUSHPULL(PIN_PF13) |         \
                                     PIN_OTYPE_PUSHPULL(PIN_PF14) |         \
                                     PIN_OTYPE_PUSHPULL(PIN_PF15))
#define VAL_GPIOF_OSPEEDR           (PIN_OSPEED_100M(PIN_PF0) |             \
                                     PIN_OSPEED_100M(PIN_PF1) |             \
                                     PIN_OSPEED_100M(PIN_PF2) |             \
                                     PIN_OSPEED_100M(PIN_PF3) |             \
                                     PIN_OSPEED_100M(PIN_PF4) |             \
                                     PIN_OSPEED_100M(PIN_PF5) |             \
                                     PIN_OSPEED_100M(PIN_PF6) |             \
                                     PIN_OSPEED_100M(PIN_PF7) |             \
                                     PIN_OSPEED_100M(PIN_PF8) |             \
                                     PIN_OSPEED_100M(PIN_PF9) |             \
                                     PIN_OSPEED_100M(PIN_PF10) |            \
                                     PIN_OSPEED_100M(PIN_PF11) |            \
                                     PIN_OSPEED_100M(PIN_PF12) |            \
                                     PIN_OSPEED_100M(PIN_PF13) |            \
                                     PIN_OSPEED_100M(PIN_PF14) |            \
                                     PIN_OSPEED_100M(PIN_PF15))
#define VAL_GPIOF_PUPDR             (PIN_PUPDR_FLOATING(PIN_PF0) |          \
                                     PIN_PUPDR_FLOATING(PIN_PF1) |          \
                                     PIN_PUPDR_FLOATING(PIN_PF2) |          \
                                     PIN_PUPDR_FLOATING(PIN_PF3) |          \
                                     PIN_PUPDR_FLOATING(PIN_PF4) |          \
                                     PIN_PUPDR_FLOATING(PIN_PF5) |          \
                                     PIN_PUPDR_FLOATING(PIN_PF6) |          \
                                     PIN_PUPDR_FLOATING(PIN_PF7) |          \
                                     PIN_PUPDR_FLOATING(PIN_PF8) |          \
                                     PIN_PUPDR_FLOATING(PIN_PF9) |          \
                                     PIN_PUPDR_FLOATING(PIN_PF10) |         \
                                     PIN_PUPDR_FLOATING(PIN_PF11) |         \
                                     PIN_PUPDR_FLOATING(PIN_PF12) |         \
                                     PIN_PUPDR_FLOATING(PIN_PF13) |         \
                                     PIN_PUPDR_FLOATING(PIN_PF14) |         \
                                     PIN_PUPDR_FLOATING(PIN_PF15))
#define VAL_GPIOF_ODR               (PIN_ODR_HIGH(PIN_PF0) |                \
                                     PIN_ODR_HIGH(PIN_PF1) |                \
                                     PIN_ODR_HIGH(PIN_PF2) |                \
                                     PIN_ODR_HIGH(PIN_PF3) |                \
                                     PIN_ODR_HIGH(PIN_PF4) |                \
                                     PIN_ODR_HIGH(PIN_PF5) |                \
                                     PIN_ODR_HIGH(PIN_PF6) |                \
                                     PIN_ODR_HIGH(PIN_PF7) |                \
                                     PIN_ODR_HIGH(PIN_PF8) |                \
                                     PIN_ODR_HIGH(PIN_PF9) |                \
                                     PIN_ODR_HIGH(PIN_PF10) |               \
                                     PIN_ODR_HIGH(PIN_PF11) |               \
                                     PIN_ODR_HIGH(PIN_PF12) |               \
                                     PIN_ODR_HIGH(PIN_PF13) |               \
                                     PIN_ODR_HIGH(PIN_PF14) |               \
                                     PIN_ODR_HIGH(PIN_PF15))
#define VAL_GPIOF_AFRL              (PIN_AFIO_AF(PIN_PF0, 0) |              \
                                     PIN_AFIO_AF(PIN_PF1, 0) |              \
                                     PIN_AFIO_AF(PIN_PF2, 0) |              \
                                     PIN_AFIO_AF(PIN_PF3, 0) |              \
                                     PIN_AFIO_AF(PIN_PF4, 0) |              \
                                     PIN_AFIO_AF(PIN_PF5, 0) |              \
                                     PIN_AFIO_AF(PIN_PF6, 0) |              \
                                     PIN_AFIO_AF(PIN_PF7, 0))
#define VAL_GPIOF_AFRH              (PIN_AFIO_AF(PIN_PF8, 0) |              \
                                     PIN_AFIO_AF(PIN_PF9, 0) |              \
                                     PIN_AFIO_AF(PIN_PF10, 0) |             \
                                     PIN_AFIO_AF(PIN_PF11, 0) |             \
                                     PIN_AFIO_AF(PIN_PF12, 0) |             \
                                     PIN_AFIO_AF(PIN_PF13, 0) |             \
                                     PIN_AFIO_AF(PIN_PF14, 0) |             \
                                     PIN_AFIO_AF(PIN_PF15, 0))

/*
 * GPIOG setup:
 *
 * PG0  - PIN_PG0                   (input floating).
 * PG1  - PIN_PG1                   (input floating).
 * PG2  - PIN_PG2                   (input floating).
 * PG3  - PIN_PG3                   (input floating).
 * PG4  - PIN_PG4                   (input floating).
 * PG5  - PIN_PG5                   (input floating).
 * PG6  - PIN_PG6                   (input floating).
 * PG7  - PIN_PG7                   (input floating).
 * PG8  - PIN_PG8                   (input floating).
 * PG9  - PIN_PG9                   (input floating).
 * PG10 - PIN_PG10                  (input floating).
 * PG11 - PIN_PG11                  (input floating).
 * PG12 - PIN_PG12                  (input floating).
 * PG13 - PIN_PG13                  (input floating).
 * PG14 - PIN_PG14                  (input floating).
 * PG15 - PIN_PG15                  (input floating).
 */
#define VAL_GPIOG_MODER             (PIN_MODE_INPUT(PIN_PG0) |              \
                                     PIN_MODE_INPUT(PIN_PG1) |              \
                                     PIN_MODE_INPUT(PIN_PG2) |              \
                                     PIN_MODE_INPUT(PIN_PG3) |              \
                                     PIN_MODE_INPUT(PIN_PG4) |              \
                                     PIN_MODE_INPUT(PIN_PG5) |              \
                                     PIN_MODE_INPUT(PIN_PG6) |              \
                                     PIN_MODE_INPUT(PIN_PG7) |              \
                                     PIN_MODE_INPUT(PIN_PG8) |              \
                                     PIN_MODE_INPUT(PIN_PG9) |              \
                                     PIN_MODE_INPUT(PIN_PG10) |             \
                                     PIN_MODE_INPUT(PIN_PG11) |             \
                                     PIN_MODE_INPUT(PIN_PG12) |             \
                                     PIN_MODE_INPUT(PIN_PG13) |             \
                                     PIN_MODE_INPUT(PIN_PG14) |             \
                                     PIN_MODE_INPUT(PIN_PG15))
#define VAL_GPIOG_OTYPER            (PIN_OTYPE_PUSHPULL(PIN_PG0) |          \
                                     PIN_OTYPE_PUSHPULL(PIN_PG1) |          \
                                     PIN_OTYPE_PUSHPULL(PIN_PG2) |          \
                                     PIN_OTYPE_PUSHPULL(PIN_PG3) |          \
                                     PIN_OTYPE_PUSHPULL(PIN_PG4) |          \
                                     PIN_OTYPE_PUSHPULL(PIN_PG5) |          \
                                     PIN_OTYPE_PUSHPULL(PIN_PG6) |          \
                                     PIN_OTYPE_PUSHPULL(PIN_PG7) |          \
                                     PIN_OTYPE_PUSHPULL(PIN_PG8) |          \
                                     PIN_OTYPE_PUSHPULL(PIN_PG9) |          \
                                     PIN_OTYPE_PUSHPULL(PIN_PG10) |         \
                                     PIN_OTYPE_PUSHPULL(PIN_PG11) |         \
                                     PIN_OTYPE_PUSHPULL(PIN_PG12) |         \
                                     PIN_OTYPE_PUSHPULL(PIN_PG13) |         \
                                     PIN_OTYPE_PUSHPULL(PIN_PG14) |         \
                                     PIN_OTYPE_PUSHPULL(PIN_PG15))
#define VAL_GPIOG_OSPEEDR           (PIN_OSPEED_100M(PIN_PG0) |             \
                                     PIN_OSPEED_100M(PIN_PG1) |             \
                                     PIN_OSPEED_100M(PIN_PG2) |             \
                                     PIN_OSPEED_100M(PIN_PG3) |             \
                                     PIN_OSPEED_100M(PIN_PG4) |             \
                                     PIN_OSPEED_100M(PIN_PG5) |             \
                                     PIN_OSPEED_100M(PIN_PG6) |             \
                                     PIN_OSPEED_100M(PIN_PG7) |             \
                                     PIN_OSPEED_100M(PIN_PG8) |             \
                                     PIN_OSPEED_100M(PIN_PG9) |             \
                                     PIN_OSPEED_100M(PIN_PG10) |            \
                                     PIN_OSPEED_100M(PIN_PG11) |            \
                                     PIN_OSPEED_100M(PIN_PG12) |            \
                                     PIN_OSPEED_100M(PIN_PG13) |            \
                                     PIN_OSPEED_100M(PIN_PG14) |            \
                                     PIN_OSPEED_100M(PIN_PG15))
#define VAL_GPIOG_PUPDR             (PIN_PUPDR_FLOATING(PIN_PG0) |          \
                                     PIN_PUPDR_FLOATING(PIN_PG1) |          \
                                     PIN_PUPDR_FLOATING(PIN_PG2) |          \
                                     PIN_PUPDR_FLOATING(PIN_PG3) |          \
                                     PIN_PUPDR_FLOATING(PIN_PG4) |          \
                                     PIN_PUPDR_FLOATING(PIN_PG5) |          \
                                     PIN_PUPDR_FLOATING(PIN_PG6) |          \
                                     PIN_PUPDR_FLOATING(PIN_PG7) |          \
                                     PIN_PUPDR_FLOATING(PIN_PG8) |          \
                                     PIN_PUPDR_FLOATING(PIN_PG9) |          \
                                     PIN_PUPDR_FLOATING(PIN_PG10) |         \
                                     PIN_PUPDR_FLOATING(PIN_PG11) |         \
                                     PIN_PUPDR_FLOATING(PIN_PG12) |         \
                                     PIN_PUPDR_FLOATING(PIN_PG13) |         \
                                     PIN_PUPDR_FLOATING(PIN_PG14) |         \
                                     PIN_PUPDR_FLOATING(PIN_PG15))
#define VAL_GPIOG_ODR               (PIN_ODR_HIGH(PIN_PG0) |                \
                                     PIN_ODR_HIGH(PIN_PG1) |                \
                                     PIN_ODR_HIGH(PIN_PG2) |                \
                                     PIN_ODR_HIGH(PIN_PG3) |                \
                                     PIN_ODR_HIGH(PIN_PG4) |                \
                                     PIN_ODR_HIGH(PIN_PG5) |                \
                                     PIN_ODR_HIGH(PIN_PG6) |                \
                                     PIN_ODR_HIGH(PIN_PG7) |                \
                                     PIN_ODR_HIGH(PIN_PG8) |                \
                                     PIN_ODR_HIGH(PIN_PG9) |                \
                                     PIN_ODR_HIGH(PIN_PG10) |               \
                                     PIN_ODR_HIGH(PIN_PG11) |               \
                                     PIN_ODR_HIGH(PIN_PG12) |               \
                                     PIN_ODR_HIGH(PIN_PG13) |               \
                                     PIN_ODR_HIGH(PIN_PG14) |               \
                                     PIN_ODR_HIGH(PIN_PG15))
#define VAL_GPIOG_AFRL              (PIN_AFIO_AF(PIN_PG0, 0) |              \
                                     PIN_AFIO_AF(PIN_PG1, 0) |              \
                                     PIN_AFIO_AF(PIN_PG2, 0) |              \
                                     PIN_AFIO_AF(PIN_PG3, 0) |              \
                                     PIN_AFIO_AF(PIN_PG4, 0) |              \
                                     PIN_AFIO_AF(PIN_PG5, 0) |              \
                                     PIN_AFIO_AF(PIN_PG6, 0) |              \
                                     PIN_AFIO_AF(PIN_PG7, 0))
#define VAL_GPIOG_AFRH              (PIN_AFIO_AF(PIN_PG8, 0) |              \
                                     PIN_AFIO_AF(PIN_PG9, 0) |              \
                                     PIN_AFIO_AF(PIN_PG10, 0) |             \
                                     PIN_AFIO_AF(PIN_PG11, 0) |             \
                                     PIN_AFIO_AF(PIN_PG12, 0) |             \
                                     PIN_AFIO_AF(PIN_PG13, 0) |             \
                                     PIN_AFIO_AF(PIN_PG14, 0) |             \
                                     PIN_AFIO_AF(PIN_PG15, 0))

/*
 * GPIOH setup:
 *
 * PH0  - PIN_OSC_IN                (input floating).
 * PH1  - PIN_OSC_OUT               (input floating).
 * PH2  - PIN_PH2                   (input floating).
 * PH3  - PIN_PH3                   (input floating).
 * PH4  - PIN_PH4                   (input floating).
 * PH5  - PIN_PH5                   (input floating).
 * PH6  - PIN_PH6                   (input floating).
 * PH7  - PIN_PH7                   (input floating).
 * PH8  - PIN_PH8                   (input floating).
 * PH9  - PIN_PH9                   (input floating).
 * PH10 - PIN_PH10                  (input floating).
 * PH11 - PIN_PH11                  (input floating).
 * PH12 - PIN_PH12                  (input floating).
 * PH13 - PIN_PH13                  (input floating).
 * PH14 - PIN_PH14                  (input floating).
 * PH15 - PIN_PH15                  (input floating).
 */
#define VAL_GPIOH_MODER             (PIN_MODE_INPUT(PIN_OSC_IN) |           \
                                     PIN_MODE_INPUT(PIN_OSC_OUT) |          \
                                     PIN_MODE_INPUT(PIN_PH2) |              \
                                     PIN_MODE_INPUT(PIN_PH3) |              \
                                     PIN_MODE_INPUT(PIN_PH4) |              \
                                     PIN_MODE_INPUT(PIN_PH5) |              \
                                     PIN_MODE_INPUT(PIN_PH6) |              \
                                     PIN_MODE_INPUT(PIN_PH7) |              \
                                     PIN_MODE_INPUT(PIN_PH8) |              \
                                     PIN_MODE_INPUT(PIN_PH9) |              \
                                     PIN_MODE_INPUT(PIN_PH10) |             \
                                     PIN_MODE_INPUT(PIN_PH11) |             \
                                     PIN_MODE_INPUT(PIN_PH12) |             \
                                     PIN_MODE_INPUT(PIN_PH13) |             \
                                     PIN_MODE_INPUT(PIN_PH14) |             \
                                     PIN_MODE_INPUT(PIN_PH15))
#define VAL_GPIOH_OTYPER            (PIN_OTYPE_PUSHPULL(PIN_OSC_IN) |       \
                                     PIN_OTYPE_PUSHPULL(PIN_OSC_OUT) |      \
                                     PIN_OTYPE_PUSHPULL(PIN_PH2) |          \
                                     PIN_OTYPE_PUSHPULL(PIN_PH3) |          \
                                     PIN_OTYPE_PUSHPULL(PIN_PH4) |          \
                                     PIN_OTYPE_PUSHPULL(PIN_PH5) |          \
                                     PIN_OTYPE_PUSHPULL(PIN_PH6) |          \
                                     PIN_OTYPE_PUSHPULL(PIN_PH7) |          \
                                     PIN_OTYPE_PUSHPULL(PIN_PH8) |          \
                                     PIN_OTYPE_PUSHPULL(PIN_PH9) |          \
                                     PIN_OTYPE_PUSHPULL(PIN_PH10) |         \
                                     PIN_OTYPE_PUSHPULL(PIN_PH11) |         \
                                     PIN_OTYPE_PUSHPULL(PIN_PH12) |         \
                                     PIN_OTYPE_PUSHPULL(PIN_PH13) |         \
                                     PIN_OTYPE_PUSHPULL(PIN_PH14) |         \
                                     PIN_OTYPE_PUSHPULL(PIN_PH15))
#define VAL_GPIOH_OSPEEDR           (PIN_OSPEED_100M(PIN_OSC_IN) |          \
                                     PIN_OSPEED_100M(PIN_OSC_OUT) |         \
                                     PIN_OSPEED_100M(PIN_PH2) |             \
                                     PIN_OSPEED_100M(PIN_PH3) |             \
                                     PIN_OSPEED_100M(PIN_PH4) |             \
                                     PIN_OSPEED_100M(PIN_PH5) |             \
                                     PIN_OSPEED_100M(PIN_PH6) |             \
                                     PIN_OSPEED_100M(PIN_PH7) |             \
                                     PIN_OSPEED_100M(PIN_PH8) |             \
                                     PIN_OSPEED_100M(PIN_PH9) |             \
                                     PIN_OSPEED_100M(PIN_PH10) |            \
                                     PIN_OSPEED_100M(PIN_PH11) |            \
                                     PIN_OSPEED_100M(PIN_PH12) |            \
                                     PIN_OSPEED_100M(PIN_PH13) |            \
                                     PIN_OSPEED_100M(PIN_PH14) |            \
                                     PIN_OSPEED_100M(PIN_PH15))
#define VAL_GPIOH_PUPDR             (PIN_PUPDR_FLOATING(PIN_OSC_IN) |       \
                                     PIN_PUPDR_FLOATING(PIN_OSC_OUT) |      \
                                     PIN_PUPDR_FLOATING(PIN_PH2) |          \
                                     PIN_PUPDR_FLOATING(PIN_PH3) |          \
                                     PIN_PUPDR_FLOATING(PIN_PH4) |          \
                                     PIN_PUPDR_FLOATING(PIN_PH5) |          \
                                     PIN_PUPDR_FLOATING(PIN_PH6) |          \
                                     PIN_PUPDR_FLOATING(PIN_PH7) |          \
                                     PIN_PUPDR_FLOATING(PIN_PH8) |          \
                                     PIN_PUPDR_FLOATING(PIN_PH9) |          \
                                     PIN_PUPDR_FLOATING(PIN_PH10) |         \
                                     PIN_PUPDR_FLOATING(PIN_PH11) |         \
                                     PIN_PUPDR_FLOATING(PIN_PH12) |         \
                                     PIN_PUPDR_FLOATING(PIN_PH13) |         \
                                     PIN_PUPDR_FLOATING(PIN_PH14) |         \
                                     PIN_PUPDR_FLOATING(PIN_PH15))
#define VAL_GPIOH_ODR               (PIN_ODR_HIGH(PIN_OSC_IN) |             \
                                     PIN_ODR_HIGH(PIN_OSC_OUT) |            \
                                     PIN_ODR_HIGH(PIN_PH2) |                \
                                     PIN_ODR_HIGH(PIN_PH3) |                \
                                     PIN_ODR_HIGH(PIN_PH4) |                \
                                     PIN_ODR_HIGH(PIN_PH5) |                \
                                     PIN_ODR_HIGH(PIN_PH6) |                \
                                     PIN_ODR_HIGH(PIN_PH7) |                \
                                     PIN_ODR_HIGH(PIN_PH8) |                \
                                     PIN_ODR_HIGH(PIN_PH9) |                \
                                     PIN_ODR_HIGH(PIN_PH10) |               \
                                     PIN_ODR_HIGH(PIN_PH11) |               \
                                     PIN_ODR_HIGH(PIN_PH12) |               \
                                     PIN_ODR_HIGH(PIN_PH13) |               \
                                     PIN_ODR_HIGH(PIN_PH14) |               \
                                     PIN_ODR_HIGH(PIN_PH15))
#define VAL_GPIOH_AFRL              (PIN_AFIO_AF(PIN_OSC_IN, 0) |           \
                                     PIN_AFIO_AF(PIN_OSC_OUT, 0) |          \
                                     PIN_AFIO_AF(PIN_PH2, 0) |              \
                                     PIN_AFIO_AF(PIN_PH3, 0) |              \
                                     PIN_AFIO_AF(PIN_PH4, 0) |              \
                                     PIN_AFIO_AF(PIN_PH5, 0) |              \
                                     PIN_AFIO_AF(PIN_PH6, 0) |              \
                                     PIN_AFIO_AF(PIN_PH7, 0))
#define VAL_GPIOH_AFRH              (PIN_AFIO_AF(PIN_PH8, 0) |              \
                                     PIN_AFIO_AF(PIN_PH9, 0) |              \
                                     PIN_AFIO_AF(PIN_PH10, 0) |             \
                                     PIN_AFIO_AF(PIN_PH11, 0) |             \
                                     PIN_AFIO_AF(PIN_PH12, 0) |             \
                                     PIN_AFIO_AF(PIN_PH13, 0) |             \
                                     PIN_AFIO_AF(PIN_PH14, 0) |             \
                                     PIN_AFIO_AF(PIN_PH15, 0))

/*
 * GPIOI setup:
 *
 * PI0  - PIN_PI0                   (input floating).
 * PI1  - PIN_PI1                   (input floating).
 * PI2  - PIN_PI2                   (input floating).
 * PI3  - PIN_PI3                   (input floating).
 * PI4  - PIN_PI4                   (input floating).
 * PI5  - PIN_PI5                   (input floating).
 * PI6  - PIN_PI6                   (input floating).
 * PI7  - PIN_PI7                   (input floating).
 * PI8  - PIN_PI8                   (input floating).
 * PI9  - PIN_PI9                   (input floating).
 * PI10 - PIN_PI10                  (input floating).
 * PI11 - PIN_PI11                  (input floating).
 * PI12 - PIN_PI12                  (input floating).
 * PI13 - PIN_PI13                  (input floating).
 * PI14 - PIN_PI14                  (input floating).
 * PI15 - PIN_PI15                  (input floating).
 */
#define VAL_GPIOI_MODER             (PIN_MODE_INPUT(PIN_PI0) |              \
                                     PIN_MODE_INPUT(PIN_PI1) |              \
                                     PIN_MODE_INPUT(PIN_PI2) |              \
                                     PIN_MODE_INPUT(PIN_PI3) |              \
                                     PIN_MODE_INPUT(PIN_PI4) |              \
                                     PIN_MODE_INPUT(PIN_PI5) |              \
                                     PIN_MODE_INPUT(PIN_PI6) |              \
                                     PIN_MODE_INPUT(PIN_PI7) |              \
                                     PIN_MODE_INPUT(PIN_PI8) |              \
                                     PIN_MODE_INPUT(PIN_PI9) |              \
                                     PIN_MODE_INPUT(PIN_PI10) |             \
                                     PIN_MODE_INPUT(PIN_PI11) |             \
                                     PIN_MODE_INPUT(PIN_PI12) |             \
                                     PIN_MODE_INPUT(PIN_PI13) |             \
                                     PIN_MODE_INPUT(PIN_PI14) |             \
                                     PIN_MODE_INPUT(PIN_PI15))
#define VAL_GPIOI_OTYPER            (PIN_OTYPE_PUSHPULL(PIN_PI0) |          \
                                     PIN_OTYPE_PUSHPULL(PIN_PI1) |          \
                                     PIN_OTYPE_PUSHPULL(PIN_PI2) |          \
                                     PIN_OTYPE_PUSHPULL(PIN_PI3) |          \
                                     PIN_OTYPE_PUSHPULL(PIN_PI4) |          \
                                     PIN_OTYPE_PUSHPULL(PIN_PI5) |          \
                                     PIN_OTYPE_PUSHPULL(PIN_PI6) |          \
                                     PIN_OTYPE_PUSHPULL(PIN_PI7) |          \
                                     PIN_OTYPE_PUSHPULL(PIN_PI8) |          \
                                     PIN_OTYPE_PUSHPULL(PIN_PI9) |          \
                                     PIN_OTYPE_PUSHPULL(PIN_PI10) |         \
                                     PIN_OTYPE_PUSHPULL(PIN_PI11) |         \
                                     PIN_OTYPE_PUSHPULL(PIN_PI12) |         \
                                     PIN_OTYPE_PUSHPULL(PIN_PI13) |         \
                                     PIN_OTYPE_PUSHPULL(PIN_PI14) |         \
                                     PIN_OTYPE_PUSHPULL(PIN_PI15))
#define VAL_GPIOI_OSPEEDR           (PIN_OSPEED_100M(PIN_PI0) |             \
                                     PIN_OSPEED_100M(PIN_PI1) |             \
                                     PIN_OSPEED_100M(PIN_PI2) |             \
                                     PIN_OSPEED_100M(PIN_PI3) |             \
                                     PIN_OSPEED_100M(PIN_PI4) |             \
                                     PIN_OSPEED_100M(PIN_PI5) |             \
                                     PIN_OSPEED_100M(PIN_PI6) |             \
                                     PIN_OSPEED_100M(PIN_PI7) |             \
                                     PIN_OSPEED_100M(PIN_PI8) |             \
                                     PIN_OSPEED_100M(PIN_PI9) |             \
                                     PIN_OSPEED_100M(PIN_PI10) |            \
                                     PIN_OSPEED_100M(PIN_PI11) |            \
                                     PIN_OSPEED_100M(PIN_PI12) |            \
                                     PIN_OSPEED_100M(PIN_PI13) |            \
                                     PIN_OSPEED_100M(PIN_PI14) |            \
                                     PIN_OSPEED_100M(PIN_PI15))
#define VAL_GPIOI_PUPDR             (PIN_PUPDR_FLOATING(PIN_PI0) |          \
                                     PIN_PUPDR_FLOATING(PIN_PI1) |          \
                                     PIN_PUPDR_FLOATING(PIN_PI2) |          \
                                     PIN_PUPDR_FLOATING(PIN_PI3) |          \
                                     PIN_PUPDR_FLOATING(PIN_PI4) |          \
                                     PIN_PUPDR_FLOATING(PIN_PI5) |          \
                                     PIN_PUPDR_FLOATING(PIN_PI6) |          \
                                     PIN_PUPDR_FLOATING(PIN_PI7) |          \
                                     PIN_PUPDR_FLOATING(PIN_PI8) |          \
                                     PIN_PUPDR_FLOATING(PIN_PI9) |          \
                                     PIN_PUPDR_FLOATING(PIN_PI10) |         \
                                     PIN_PUPDR_FLOATING(PIN_PI11) |         \
                                     PIN_PUPDR_FLOATING(PIN_PI12) |         \
                                     PIN_PUPDR_FLOATING(PIN_PI13) |         \
                                     PIN_PUPDR_FLOATING(PIN_PI14) |         \
                                     PIN_PUPDR_FLOATING(PIN_PI15))
#define VAL_GPIOI_ODR               (PIN_ODR_HIGH(PIN_PI0) |                \
                                     PIN_ODR_HIGH(PIN_PI1) |                \
                                     PIN_ODR_HIGH(PIN_PI2) |                \
                                     PIN_ODR_HIGH(PIN_PI3) |                \
                                     PIN_ODR_HIGH(PIN_PI4) |                \
                                     PIN_ODR_HIGH(PIN_PI5) |                \
                                     PIN_ODR_HIGH(PIN_PI6) |                \
                                     PIN_ODR_HIGH(PIN_PI7) |                \
                                     PIN_ODR_HIGH(PIN_PI8) |                \
                                     PIN_ODR_HIGH(PIN_PI9) |                \
                                     PIN_ODR_HIGH(PIN_PI10) |               \
                                     PIN_ODR_HIGH(PIN_PI11) |               \
                                     PIN_ODR_HIGH(PIN_PI12) |               \
                                     PIN_ODR_HIGH(PIN_PI13) |               \
                                     PIN_ODR_HIGH(PIN_PI14) |               \
                                     PIN_ODR_HIGH(PIN_PI15))
#define VAL_GPIOI_AFRL              (PIN_AFIO_AF(PIN_PI0, 0) |              \
                                     PIN_AFIO_AF(PIN_PI1, 0) |              \
                                     PIN_AFIO_AF(PIN_PI2, 0) |              \
                                     PIN_AFIO_AF(PIN_PI3, 0) |              \
                                     PIN_AFIO_AF(PIN_PI4, 0) |              \
                                     PIN_AFIO_AF(PIN_PI5, 0) |              \
                                     PIN_AFIO_AF(PIN_PI6, 0) |              \
                                     PIN_AFIO_AF(PIN_PI7, 0))
#define VAL_GPIOI_AFRH              (PIN_AFIO_AF(PIN_PI8, 0) |              \
                                     PIN_AFIO_AF(PIN_PI9, 0) |              \
                                     PIN_AFIO_AF(PIN_PI10, 0) |             \
                                     PIN_AFIO_AF(PIN_PI11, 0) |             \
                                     PIN_AFIO_AF(PIN_PI12, 0) |             \
                                     PIN_AFIO_AF(PIN_PI13, 0) |             \
                                     PIN_AFIO_AF(PIN_PI14, 0) |             \
                                     PIN_AFIO_AF(PIN_PI15, 0))
#endif // BOARD_DRCHIBI_DISCO

/*
 * ChibiESC on STM32F446RE-Nucleo pin setup
 */
#if defined(BOARD_NUCLEO_F446)

/*
 * GPIOA setup:
 *
 * PA0  - PIN_CSENS_A               (analog input).
 * PA1  - PIN_VSENS_BAT             (analog input).
 * PA2  - PIN_VSENS_Y1              (analog input).
 * PA3  - PIN_PA3                   (input floating).
 * PA4  - PIN_PA4                   (input floating).
 * PA5  - PIN_LED2/LED_GREEN        (output pushpull 2MHz).
 * PA6  - PIN_DRIVER_ENABLE_NUCLEO  (output push-pull 50MHz).
 * PA7  - PIN_VSENS_C               (analog input).
 * PA8  - PIN_PWM_A                 (alternate 1 (TIM1) push-pull output 50MHz).
 * PA9  - PIN_PWM_B                 (alternate 1 (TIM1) push-pull output 50MHz).
 * PA10 - PIN_PWM_C                 (alternate 1 (TIM1) push-pull output 50MHz).
 * PA11 - PIN_USB_DM                (alternate 10 (USB), controlled automatically).
 * PA12 - PIN_USB_DP                (alternate 10 (USB), controlled automatically).
 * PA13 - PIN_SWDIO                 (alternate 0 (system)).
 * PA14 - PIN_SWDCLK                (alternate 0 (system)).
 * PA15 - PIN_PA15                  (input floating).
 */
#define VAL_GPIOA_MODER             (PIN_MODE_ANALOG(PIN_CSENS_A) |         \
                                     PIN_MODE_ANALOG(PIN_VSENS_BAT) |       \
                                     PIN_MODE_ANALOG(PIN_VSENS_Y1) |        \
                                     PIN_MODE_INPUT(PIN_PA3) |              \
                                     PIN_MODE_INPUT(PIN_PA4) |              \
                                     PIN_MODE_OUTPUT(PIN_LED2) |            \
                                     PIN_MODE_OUTPUT(PIN_DRIVER_ENABLE_NUCLEO) | \
                                     PIN_MODE_ANALOG(PIN_VSENS_C) |         \
                                     PIN_MODE_OUTPUT(PIN_PWM_A) |        \
                                     PIN_MODE_OUTPUT(PIN_PWM_B) |        \
                                     PIN_MODE_OUTPUT(PIN_PWM_C) |        \
                                     PIN_MODE_ALTERNATE(PIN_USB_DM) |       \
                                     PIN_MODE_ALTERNATE(PIN_USB_DP) |       \
                                     PIN_MODE_ALTERNATE(PIN_SWDIO) |        \
                                     PIN_MODE_ALTERNATE(PIN_SWDCLK) |       \
                                     PIN_MODE_INPUT(PIN_PA15))
#define VAL_GPIOA_OTYPER            (PIN_OTYPE_PUSHPULL(PIN_CSENS_A) |      \
                                     PIN_OTYPE_PUSHPULL(PIN_VSENS_BAT) |    \
                                     PIN_OTYPE_PUSHPULL(PIN_VSENS_Y1) |     \
                                     PIN_OTYPE_PUSHPULL(PIN_PA3) |          \
                                     PIN_OTYPE_PUSHPULL(PIN_PA4) |          \
                                     PIN_OTYPE_PUSHPULL(PIN_LED2) |         \
                                     PIN_OTYPE_PUSHPULL(PIN_DRIVER_ENABLE_NUCLEO) | \
                                     PIN_OTYPE_PUSHPULL(PIN_VSENS_C) |      \
                                     PIN_OTYPE_PUSHPULL(PIN_PWM_A) |        \
                                     PIN_OTYPE_PUSHPULL(PIN_PWM_B) |        \
                                     PIN_OTYPE_PUSHPULL(PIN_PWM_C) |        \
                                     PIN_OTYPE_PUSHPULL(PIN_USB_DM) |       \
                                     PIN_OTYPE_PUSHPULL(PIN_USB_DP) |       \
                                     PIN_OTYPE_PUSHPULL(PIN_SWDIO) |        \
                                     PIN_OTYPE_PUSHPULL(PIN_SWDCLK) |       \
                                     PIN_OTYPE_PUSHPULL(PIN_PA15))
#define VAL_GPIOA_OSPEEDR           (PIN_OSPEED_100M(PIN_CSENS_A) |         \
                                     PIN_OSPEED_100M(PIN_VSENS_BAT) |       \
                                     PIN_OSPEED_100M(PIN_VSENS_Y1) |        \
                                     PIN_OSPEED_100M(PIN_PA3) |             \
                                     PIN_OSPEED_100M(PIN_PA4) |             \
                                     PIN_OSPEED_2M(PIN_LED2) |              \
                                     PIN_OSPEED_50M(PIN_DRIVER_ENABLE_NUCLEO) | \
                                     PIN_OSPEED_100M(PIN_VSENS_C) |         \
                                     PIN_OSPEED_50M(PIN_PWM_A) |            \
                                     PIN_OSPEED_50M(PIN_PWM_B) |            \
                                     PIN_OSPEED_50M(PIN_PWM_C) |            \
                                     PIN_OSPEED_100M(PIN_USB_DM) |          \
                                     PIN_OSPEED_100M(PIN_USB_DP) |          \
                                     PIN_OSPEED_100M(PIN_SWDIO) |           \
                                     PIN_OSPEED_100M(PIN_SWDCLK) |          \
                                     PIN_OSPEED_100M(PIN_PA15))
#define VAL_GPIOA_PUPDR             (PIN_PUPDR_FLOATING(PIN_CSENS_A) |      \
                                     PIN_PUPDR_FLOATING(PIN_VSENS_BAT) |    \
                                     PIN_PUPDR_FLOATING(PIN_VSENS_Y1) |     \
                                     PIN_PUPDR_FLOATING(PIN_PA3) |          \
                                     PIN_PUPDR_FLOATING(PIN_PA4) |          \
                                     PIN_PUPDR_FLOATING(PIN_LED2) |         \
                                     PIN_PUPDR_FLOATING(PIN_DRIVER_ENABLE_NUCLEO) | \
                                     PIN_PUPDR_FLOATING(PIN_VSENS_C) |      \
                                     PIN_PUPDR_FLOATING(PIN_PWM_A) |        \
                                     PIN_PUPDR_FLOATING(PIN_PWM_B) |        \
                                     PIN_PUPDR_FLOATING(PIN_PWM_C) |        \
                                     PIN_PUPDR_FLOATING(PIN_USB_DM) |       \
                                     PIN_PUPDR_FLOATING(PIN_USB_DP) |       \
                                     PIN_PUPDR_FLOATING(PIN_SWDIO) |        \
                                     PIN_PUPDR_FLOATING(PIN_SWDCLK) |       \
                                     PIN_PUPDR_FLOATING(PIN_PA15))
#define VAL_GPIOA_ODR               (PIN_ODR_HIGH(PIN_CSENS_A) |            \
                                     PIN_ODR_HIGH(PIN_VSENS_BAT) |          \
                                     PIN_ODR_HIGH(PIN_VSENS_Y1) |           \
                                     PIN_ODR_LOW(PIN_PA3) |                 \
                                     PIN_ODR_LOW(PIN_PA4) |                 \
                                     PIN_ODR_LOW(PIN_LED2) |                \
                                     PIN_ODR_LOW(PIN_DRIVER_ENABLE_NUCLEO) | \
                                     PIN_ODR_HIGH(PIN_VSENS_C) |            \
                                     PIN_ODR_LOW(PIN_PWM_A) |                \
                                     PIN_ODR_LOW(PIN_PWM_B) |               \
                                     PIN_ODR_LOW(PIN_PWM_C) |               \
                                     PIN_ODR_HIGH(PIN_USB_DM) |             \
                                     PIN_ODR_HIGH(PIN_USB_DP) |             \
                                     PIN_ODR_HIGH(PIN_SWDIO) |              \
                                     PIN_ODR_HIGH(PIN_SWDCLK) |             \
                                     PIN_ODR_LOW(PIN_PA15))
#define VAL_GPIOA_AFRL              (PIN_AFIO_AF(PIN_CSENS_A, 0) |          \
                                     PIN_AFIO_AF(PIN_VSENS_BAT, 0) |        \
                                     PIN_AFIO_AF(PIN_VSENS_Y1, 0) |         \
                                     PIN_AFIO_AF(PIN_PA3, 0) |              \
                                     PIN_AFIO_AF(PIN_PA4, 0) |              \
                                     PIN_AFIO_AF(PIN_LED2, 0) |             \
                                     PIN_AFIO_AF(PIN_DRIVER_ENABLE_NUCLEO, 0) | \
                                     PIN_AFIO_AF(PIN_VSENS_C, 0))
#define VAL_GPIOA_AFRH              (PIN_AFIO_AF(PIN_PWM_A, 0) |            \
                                     PIN_AFIO_AF(PIN_PWM_B, 0) |            \
                                     PIN_AFIO_AF(PIN_PWM_C, 0) |            \
                                     PIN_AFIO_AF(PIN_USB_DM, 10) |          \
                                     PIN_AFIO_AF(PIN_USB_DP, 10) |          \
                                     PIN_AFIO_AF(PIN_SWDIO, 0) |            \
                                     PIN_AFIO_AF(PIN_SWDCLK, 0) |           \
                                     PIN_AFIO_AF(PIN_PA15, 0))

/*
 * GPIOB setup:
 *
 * PB0  - PIN_VSENS_B               (analog input).
 * PB1  - PIN_POTI_NUCLEO           (analog input).
 * PB2  - PIN_LED1/LED_RED          (output push-pull 2MHz).
 * PB3  - PIN_TRACESWO              (alternate 0 (system)).
 * PB4  - PIN_PB4                   (input floating).
 * PB5  - PIN_PB5                   (input floating).
 * PB6  - PIN_I2C_SCL               (alternate 4 (I2C) open drain).
 * PB7  - PIN_I2C_SDA               (alternate 4 (I2C) open drain).
 * PB8  - PIN_CAN_RX                (alternate 9 (CAN) push-pull pull-up). TODO: check CAN pin config
 * PB9  - PIN_CAN_TX                (alternate 9 (CAN) push-pull pull-up). TODO: check CAN pin config
 * PB10 - PIN_PB10                  (input floating).
 * PB11 - PIN_PB11                  (input floating).
 * PB12 - PIN_PB12                  (input floating).
 * PB13 - PIN_PB13                  (input floating).
 * PB14 - PIN_THWN/PIN_FAULTC       (input floating).
 * PB15 - PIN_PB15                  (input floating).
 */
#define VAL_GPIOB_MODER             (PIN_MODE_ANALOG(PIN_VSENS_B) |         \
                                     PIN_MODE_ANALOG(PIN_POTI_NUCLEO) |     \
                                     PIN_MODE_OUTPUT(PIN_LED1) |            \
                                     PIN_MODE_ALTERNATE(PIN_TRACESWO) |     \
                                     PIN_MODE_INPUT(PIN_PB4) |              \
                                     PIN_MODE_INPUT(PIN_PB5) |              \
                                     PIN_MODE_ALTERNATE(PIN_I2C_SCL) |      \
                                     PIN_MODE_ALTERNATE(PIN_I2C_SDA) |      \
                                     PIN_MODE_ALTERNATE(PIN_CAN_RX) |       \
                                     PIN_MODE_ALTERNATE(PIN_CAN_TX) |       \
                                     PIN_MODE_ALTERNATE(PIN_PWM_E) |             \
                                     PIN_MODE_INPUT(PIN_PB11) |             \
                                     PIN_MODE_INPUT(PIN_PB12) |             \
                                     PIN_MODE_INPUT(PIN_PB13) |             \
                                     PIN_MODE_INPUT(PIN_THWN) |             \
									 PIN_MODE_INPUT(PIN_PB15))
#define VAL_GPIOB_OTYPER            (PIN_OTYPE_PUSHPULL(PIN_VSENS_B) |      \
                                     PIN_OTYPE_PUSHPULL(PIN_POTI_NUCLEO) |  \
                                     PIN_OTYPE_PUSHPULL(PIN_LED1) |         \
                                     PIN_OTYPE_PUSHPULL(PIN_TRACESWO) |     \
                                     PIN_OTYPE_PUSHPULL(PIN_PB4) |          \
                                     PIN_OTYPE_PUSHPULL(PIN_PB5) |          \
                                     PIN_OTYPE_OPENDRAIN(PIN_I2C_SCL) |     \
                                     PIN_OTYPE_OPENDRAIN(PIN_I2C_SDA) |     \
                                     PIN_OTYPE_PUSHPULL(PIN_CAN_RX) |       \
                                     PIN_OTYPE_PUSHPULL(PIN_CAN_TX) |       \
                                     PIN_OTYPE_PUSHPULL(PIN_PWM_E) |         \
                                     PIN_OTYPE_PUSHPULL(PIN_PB11) |         \
                                     PIN_OTYPE_PUSHPULL(PIN_PB12) |         \
                                     PIN_OTYPE_PUSHPULL(PIN_PB13) |         \
                                     PIN_OTYPE_PUSHPULL(PIN_THWN) |         \
                                     PIN_OTYPE_PUSHPULL(PIN_PB15))
#define VAL_GPIOB_OSPEEDR           (PIN_OSPEED_100M(PIN_VSENS_B) |         \
                                     PIN_OSPEED_100M(PIN_POTI_NUCLEO) |     \
                                     PIN_OSPEED_2M(PIN_LED1) |              \
                                     PIN_OSPEED_100M(PIN_TRACESWO) |        \
                                     PIN_OSPEED_100M(PIN_PB4) |             \
									 PIN_OSPEED_100M(PIN_PB5) |             \
                                     PIN_OSPEED_100M(PIN_I2C_SCL) |         \
									 PIN_OSPEED_100M(PIN_I2C_SDA) |         \
                                     PIN_OSPEED_50M(PIN_CAN_RX) |           \
									 PIN_OSPEED_50M(PIN_CAN_TX) |           \
                                     PIN_OSPEED_100M(PIN_PWM_E) |            \
									 PIN_OSPEED_100M(PIN_PB11) |            \
                                     PIN_OSPEED_100M(PIN_PB12) |            \
                                     PIN_OSPEED_100M(PIN_PB13) |            \
									 PIN_OSPEED_100M(PIN_THWN) |            \
									 PIN_OSPEED_100M(PIN_PB15))
#define VAL_GPIOB_PUPDR             (PIN_PUPDR_FLOATING(PIN_VSENS_B) |      \
		                             PIN_PUPDR_FLOATING(PIN_POTI_NUCLEO) |  \
                                     PIN_PUPDR_FLOATING(PIN_LED1) |         \
                                     PIN_PUPDR_FLOATING(PIN_TRACESWO) |     \
                                     PIN_PUPDR_FLOATING(PIN_PB4) |          \
									 PIN_PUPDR_FLOATING(PIN_PB5) |          \
                                     PIN_PUPDR_FLOATING(PIN_I2C_SCL) |      \
									 PIN_PUPDR_FLOATING(PIN_I2C_SDA) |      \
                                     PIN_PUPDR_PULLUP(PIN_CAN_RX) |         \
									 PIN_PUPDR_PULLUP(PIN_CAN_TX) |         \
                                     PIN_PUPDR_FLOATING(PIN_PWM_E) |         \
									 PIN_PUPDR_FLOATING(PIN_PB11) |         \
                                     PIN_PUPDR_FLOATING(PIN_PB12) |         \
                                     PIN_PUPDR_FLOATING(PIN_PB13) |         \
									 PIN_PUPDR_FLOATING(PIN_THWN) |         \
									 PIN_PUPDR_FLOATING(PIN_PB15))
#define VAL_GPIOB_ODR               (PIN_ODR_HIGH(PIN_VSENS_B) |            \
                                     PIN_ODR_HIGH(PIN_POTI_NUCLEO) |        \
                                     PIN_ODR_LOW(PIN_LED1) |                \
                                     PIN_ODR_HIGH(PIN_TRACESWO) |           \
                                     PIN_ODR_LOW(PIN_PB4) |                 \
									 PIN_ODR_LOW(PIN_PB5) |                 \
                                     PIN_ODR_HIGH(PIN_I2C_SCL) |            \
									 PIN_ODR_HIGH(PIN_I2C_SDA) |            \
                                     PIN_ODR_HIGH(PIN_CAN_RX) |             \
									 PIN_ODR_HIGH(PIN_CAN_TX) |             \
                                     PIN_ODR_LOW(PIN_PWM_E) |                \
									 PIN_ODR_LOW(PIN_PB11) |                \
                                     PIN_ODR_LOW(PIN_PB12) |                \
                                     PIN_ODR_LOW(PIN_PB13) |                \
									 PIN_ODR_LOW(PIN_THWN) |                \
									 PIN_ODR_LOW(PIN_PB15))
#define VAL_GPIOB_AFRL              (PIN_AFIO_AF(PIN_VSENS_B, 0) |          \
                                     PIN_AFIO_AF(PIN_POTI_NUCLEO, 0) |      \
                                     PIN_AFIO_AF(PIN_LED1, 0) |             \
                                     PIN_AFIO_AF(PIN_TRACESWO, 0) |         \
                                     PIN_AFIO_AF(PIN_PB4, 0) |              \
                                     PIN_AFIO_AF(PIN_PB5, 0) |              \
                                     PIN_AFIO_AF(PIN_I2C_SCL, 4) |          \
                                     PIN_AFIO_AF(PIN_I2C_SDA, 4))
#define VAL_GPIOB_AFRH              (PIN_AFIO_AF(PIN_CAN_RX, 9) |           \
                                     PIN_AFIO_AF(PIN_CAN_TX, 9) |           \
                                     PIN_AFIO_AF(PIN_PWM_E, 1) |             \
                                     PIN_AFIO_AF(PIN_PB11, 0) |             \
                                     PIN_AFIO_AF(PIN_PB12, 0) |             \
                                     PIN_AFIO_AF(PIN_PB13, 0) | /* TODO: make sure that AF setting is ignored when pin is in GPIO mode */ \
									 PIN_AFIO_AF(PIN_THWN, 0) |             \
									 PIN_AFIO_AF(PIN_PB15, 0))

/*
 * GPIOC setup:
 *
 * PC0  - PIN_CSENS_C               (analog input).
 * PC1  - PIN_CSENS_B               (analog input).
 * PC2  - PIN_DRIVER_TEMP_NUCLEO    (analog input).
 * PC3  - PIN_VSENS_A               (analog input).
 * PC4  - PIN_PC4                   (input floating).
 * PC5  - PIN_PC5                   (input floating).
 * PC6  - PIN_USART_TX              (alternate 8 (USART) push-pull 100MHz). TODO: check USART TX pin frequency
 * PC7  - PIN_USART_RX              (alternate 8 (USART) input floating). TODO: check whether USART RX pin should be floating or pull-up
 * PC8  - PIN_USART_CK/PIN_PWM_IN2  (alternate 8 (USART) push-pull 100MHz / alternate 2 (TIM3) input floating). TODO: check USART CK pin frequency
 * PC9  - PIN_PWM_IN1               (alternate 2 (TIM3) input floating).
 * PC10 - PIN_ENABLE_A              (output pushpull 50MHz).
 * PC11 - PIN_ENABLE_B              (output pushpull 50MHz).
 * PC12 - PIN_ENABLE_C              (output pushpull 50MHz).
 * PC13 - PIN_PC13                  (input floating).
 * PC14 - PIN_PC14                  (input floating).
 * PC15 - PIN_PC15                  (input floating).
 */
#define VAL_GPIOC_MODER             (PIN_MODE_ANALOG(PIN_CSENS_C) |         \
                                     PIN_MODE_ANALOG(PIN_CSENS_B) |         \
                                     PIN_MODE_ANALOG(PIN_DRIVER_TEMP_NUCLEO) | \
                                     PIN_MODE_ANALOG(PIN_VSENS_A) |         \
                                     PIN_MODE_INPUT(PIN_PC4) |              \
                                     PIN_MODE_INPUT(PIN_PC5) |              \
                                     PIN_MODE_ALTERNATE(PIN_USART_TX) |     \
                                     PIN_MODE_ALTERNATE(PIN_USART_RX) |     \
                                     PIN_MODE_ALTERNATE(PIN_USART_CK) |     \
                                     PIN_MODE_ALTERNATE(PIN_PWM_IN1) |      \
                                     PIN_MODE_OUTPUT(PIN_ENABLE_A) |        \
                                     PIN_MODE_OUTPUT(PIN_ENABLE_B) |        \
                                     PIN_MODE_OUTPUT(PIN_ENABLE_C) |        \
                                     PIN_MODE_INPUT(PIN_PC13) |             \
                                     PIN_MODE_INPUT(PIN_PC14) |             \
									 PIN_MODE_INPUT(PIN_PC15))
#define VAL_GPIOC_OTYPER            (PIN_OTYPE_PUSHPULL(PIN_CSENS_C) |      \
                                     PIN_OTYPE_PUSHPULL(PIN_CSENS_B) |      \
                                     PIN_OTYPE_PUSHPULL(PIN_DRIVER_TEMP_NUCLEO) | \
                                     PIN_OTYPE_PUSHPULL(PIN_VSENS_A) |      \
                                     PIN_OTYPE_PUSHPULL(PIN_PC4) |          \
                                     PIN_OTYPE_PUSHPULL(PIN_PC5) |          \
                                     PIN_OTYPE_PUSHPULL(PIN_USART_TX) |     \
                                     PIN_OTYPE_PUSHPULL(PIN_USART_RX) |     \
                                     PIN_OTYPE_PUSHPULL(PIN_USART_CK) |     \
                                     PIN_OTYPE_PUSHPULL(PIN_PWM_IN1) |      \
                                     PIN_OTYPE_PUSHPULL(PIN_ENABLE_A) |     \
                                     PIN_OTYPE_PUSHPULL(PIN_ENABLE_B) |     \
                                     PIN_OTYPE_PUSHPULL(PIN_ENABLE_C) |     \
                                     PIN_OTYPE_PUSHPULL(PIN_PC13) |         \
                                     PIN_OTYPE_PUSHPULL(PIN_PC14) |         \
									 PIN_OTYPE_PUSHPULL(PIN_PC15))
#define VAL_GPIOC_OSPEEDR           (PIN_OSPEED_100M(PIN_CSENS_C) |         \
                                     PIN_OSPEED_100M(PIN_CSENS_B) |         \
                                     PIN_OSPEED_100M(PIN_DRIVER_TEMP_NUCLEO) | \
                                     PIN_OSPEED_100M(PIN_VSENS_A) |         \
                                     PIN_OSPEED_100M(PIN_PC4) |             \
                                     PIN_OSPEED_100M(PIN_PC5) |             \
                                     PIN_OSPEED_100M(PIN_USART_TX) |        \
                                     PIN_OSPEED_100M(PIN_USART_RX) |        \
                                     PIN_OSPEED_100M(PIN_USART_CK) |        \
                                     PIN_OSPEED_100M(PIN_PWM_IN1) |         \
                                     PIN_OSPEED_50M(PIN_ENABLE_A) |         \
                                     PIN_OSPEED_50M(PIN_ENABLE_B) |         \
                                     PIN_OSPEED_50M(PIN_ENABLE_C) |         \
                                     PIN_OSPEED_100M(PIN_PC13) |            \
									 PIN_OSPEED_100M(PIN_PC14) |            \
									 PIN_OSPEED_100M(PIN_PC15))
#define VAL_GPIOC_PUPDR             (PIN_PUPDR_FLOATING(PIN_CSENS_C) |      \
                                     PIN_PUPDR_FLOATING(PIN_CSENS_B) |      \
									 PIN_PUPDR_FLOATING(PIN_DRIVER_TEMP_NUCLEO) | \
                                     PIN_PUPDR_FLOATING(PIN_VSENS_A) |      \
                                     PIN_PUPDR_FLOATING(PIN_PC4) |          \
                                     PIN_PUPDR_FLOATING(PIN_PC5) |          \
                                     PIN_PUPDR_FLOATING(PIN_USART_TX) |     \
                                     PIN_PUPDR_FLOATING(PIN_USART_RX) |     \
                                     PIN_PUPDR_FLOATING(PIN_USART_CK) |     \
                                     PIN_PUPDR_FLOATING(PIN_PWM_IN1) |      \
                                     PIN_PUPDR_FLOATING(PIN_ENABLE_A) |     \
                                     PIN_PUPDR_FLOATING(PIN_ENABLE_B) |     \
                                     PIN_PUPDR_FLOATING(PIN_ENABLE_C) |     \
									 PIN_PUPDR_FLOATING(PIN_PC13) |         \
									 PIN_PUPDR_FLOATING(PIN_PC14) |         \
									 PIN_PUPDR_FLOATING(PIN_PC15))
#define VAL_GPIOC_ODR               (PIN_ODR_HIGH(PIN_CSENS_C) |            \
                                     PIN_ODR_HIGH(PIN_CSENS_B) |            \
                                     PIN_ODR_HIGH(PIN_DRIVER_TEMP_NUCLEO) | \
                                     PIN_ODR_HIGH(PIN_VSENS_A) |            \
                                     PIN_ODR_HIGH(PIN_PC4) |                \
                                     PIN_ODR_HIGH(PIN_PC5) |                \
                                     PIN_ODR_LOW(PIN_USART_TX) |            \
                                     PIN_ODR_HIGH(PIN_USART_RX) |           \
                                     PIN_ODR_HIGH(PIN_USART_CK) |           \
                                     PIN_ODR_HIGH(PIN_PWM_IN1) |            \
                                     PIN_ODR_LOW(PIN_ENABLE_A) |            \
                                     PIN_ODR_LOW(PIN_ENABLE_B) |            \
                                     PIN_ODR_LOW(PIN_ENABLE_C) |            \
                                     PIN_ODR_HIGH(PIN_PC13) |               \
                                     PIN_ODR_HIGH(PIN_PC14) |               \
									 PIN_ODR_HIGH(PIN_PC15))
#define VAL_GPIOC_AFRL              (PIN_AFIO_AF(PIN_CSENS_C, 0) |          \
                                     PIN_AFIO_AF(PIN_CSENS_B, 0) |          \
                                     PIN_AFIO_AF(PIN_DRIVER_TEMP_NUCLEO, 0) | \
                                     PIN_AFIO_AF(PIN_VSENS_A, 0) |          \
                                     PIN_AFIO_AF(PIN_PC4, 0) |              \
                                     PIN_AFIO_AF(PIN_PC5, 0) |              \
                                     PIN_AFIO_AF(PIN_USART_TX, 8) |         \
                                     PIN_AFIO_AF(PIN_USART_RX, 8))
#define VAL_GPIOC_AFRH              (PIN_AFIO_AF(PIN_USART_CK, 8) |         \
                                     PIN_AFIO_AF(PIN_PWM_IN1, 2) |          \
                                     PIN_AFIO_AF(PIN_ENABLE_A, 0) |         \
                                     PIN_AFIO_AF(PIN_ENABLE_B, 0) |         \
                                     PIN_AFIO_AF(PIN_ENABLE_C, 0) |         \
                                     PIN_AFIO_AF(PIN_PC13, 0) |             \
                                     PIN_AFIO_AF(PIN_PC14, 0) |             \
									 PIN_AFIO_AF(PIN_PC15, 0))

/*
 * GPIOD setup:
 *
 * PD2  - PIN_PD2                           (input floating).
 */
#define VAL_GPIOD_MODER             (PIN_MODE_INPUT(PIN_PD2))
#define VAL_GPIOD_OTYPER            (PIN_OTYPE_PUSHPULL(PIN_PD2))
#define VAL_GPIOD_OSPEEDR           (PIN_OSPEED_100M(PIN_PD2))
#define VAL_GPIOD_PUPDR             (PIN_PUPDR_FLOATING(PIN_PD2))
#define VAL_GPIOD_ODR               (PIN_ODR_HIGH(PIN_PD2))
#define VAL_GPIOD_AFRL              (PIN_AFIO_AF(PIN_PD2, 0))
#define VAL_GPIOD_AFRH 				0

#define VAL_GPIOE_MODER				0
#define VAL_GPIOE_OTYPER			0
#define VAL_GPIOE_OSPEEDR			0
#define VAL_GPIOE_PUPDR				0
#define VAL_GPIOE_ODR				0
#define VAL_GPIOE_AFRL				0
#define VAL_GPIOE_AFRH				0

#define VAL_GPIOF_MODER				0
#define VAL_GPIOF_OTYPER			0
#define VAL_GPIOF_OSPEEDR			0
#define VAL_GPIOF_PUPDR				0
#define VAL_GPIOF_ODR				0
#define VAL_GPIOF_AFRL				0
#define VAL_GPIOF_AFRH				0

#define VAL_GPIOG_MODER				0
#define VAL_GPIOG_OTYPER			0
#define VAL_GPIOG_OSPEEDR			0
#define VAL_GPIOG_PUPDR				0
#define VAL_GPIOG_ODR				0
#define VAL_GPIOG_AFRL				0
#define VAL_GPIOG_AFRH				0

/*
 * GPIOH setup:
 *
 * PH0  - OSC_IN                    (input floating).
 * PH1  - OSC_OUT                   (input floating).
 */
#define VAL_GPIOH_MODER             (PIN_MODE_INPUT(PIN_OSC_IN) |         \
                                     PIN_MODE_INPUT(PIN_OSC_OUT))
#define VAL_GPIOH_OTYPER            (PIN_OTYPE_PUSHPULL(PIN_OSC_IN) |     \
                                     PIN_OTYPE_PUSHPULL(PIN_OSC_OUT))
#define VAL_GPIOH_OSPEEDR           (PIN_OSPEED_100M(PIN_OSC_IN) |        \
                                     PIN_OSPEED_100M(PIN_OSC_OUT))
#define VAL_GPIOH_PUPDR             (PIN_PUPDR_FLOATING(PIN_OSC_IN) |     \
                                     PIN_PUPDR_FLOATING(PIN_OSC_OUT))
#define VAL_GPIOH_ODR               (PIN_ODR_HIGH(PIN_OSC_IN) |           \
                                     PIN_ODR_HIGH(PIN_OSC_OUT))
#define VAL_GPIOH_AFRL              (PIN_AFIO_AF(PIN_OSC_IN, 0) |         \
                                     PIN_AFIO_AF(PIN_OSC_OUT, 0))
#define VAL_GPIOH_AFRH 				0

#define VAL_GPIOI_MODER				0
#define VAL_GPIOI_OTYPER			0
#define VAL_GPIOI_OSPEEDR			0
#define VAL_GPIOI_PUPDR				0
#define VAL_GPIOI_ODR				0
#define VAL_GPIOI_AFRL				0
#define VAL_GPIOI_AFRH				0

#endif // BOARD_NUCLEO_F446


#if !defined(_FROM_ASM_)
#ifdef __cplusplus
extern "C" {
#endif
  void boardInit(void);
#ifdef __cplusplus
}
#endif
#endif /* _FROM_ASM_ */

#endif /* _BOARD_H_ */
