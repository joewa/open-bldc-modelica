#ifndef __SIM_INTERFACES__H__
#define __SIM_INTERFACES__H__
//#pragma once  // Befehlszeilenfehler: Die angegebenen Sprachmodi sind inkompatibel.C/C++(1027)


#include <stdint.h>
#include <stdbool.h>
#include <stdlib.h>

typedef uint64_t stkalign_t;
#include "ch.h"

#define __IO volatile


void NVIC_SystemReset(void);

/*===========================================================================*/
/* Module macros.                                                            */
/*===========================================================================*/

/**
 * @name    Fast time conversion utilities
 * @{
 */
/**
 * @brief   Seconds to system ticks.
 * @details Converts from seconds to system ticks number.
 * @note    The result is rounded upward to the next tick boundary.
 * @note    Use of this macro for large values is not secure because
 *          integer overflows, make sure your value can be correctly
 *          converted.
 *
 * @param[in] sec       number of seconds
 * @return              The number of ticks.
 *
 * @api
 */
#define S2ST(sec)                                                           \
  ((systime_t)((uint32_t)(sec) * (uint32_t)CH_CFG_ST_FREQUENCY))

/**
 * @brief   Milliseconds to system ticks.
 * @details Converts from milliseconds to system ticks number.
 * @note    The result is rounded upward to the next tick boundary.
 * @note    Use of this macro for large values is not secure because
 *          integer overflows, make sure your value can be correctly
 *          converted.
 *
 * @param[in] msec      number of milliseconds
 * @return              The number of ticks.
 *
 * @api
 */
#define MS2ST(msec)                                                         \
  ((systime_t)(((((uint32_t)(msec)) *                                       \
                 ((uint32_t)CH_CFG_ST_FREQUENCY)) + 999UL) / 1000UL))

/**
 * @brief   Microseconds to system ticks.
 * @details Converts from microseconds to system ticks number.
 * @note    The result is rounded upward to the next tick boundary.
 * @note    Use of this macro for large values is not secure because
 *          integer overflows, make sure your value can be correctly
 *          converted.
 *
 * @param[in] usec      number of microseconds
 * @return              The number of ticks.
 *
 * @api
 */
#define US2ST(usec)                                                         \
  ((systime_t)(((((uint32_t)(usec)) *                                       \
                 ((uint32_t)CH_CFG_ST_FREQUENCY)) + 999999UL) / 1000000UL))

/**
 * @brief   System ticks to seconds.
 * @details Converts from system ticks number to seconds.
 * @note    The result is rounded up to the next second boundary.
 * @note    Use of this macro for large values is not secure because
 *          integer overflows, make sure your value can be correctly
 *          converted.
 *
 * @param[in] n         number of system ticks
 * @return              The number of seconds.
 *
 * @api
 */
#define ST2S(n) (((n) + CH_CFG_ST_FREQUENCY - 1UL) / CH_CFG_ST_FREQUENCY)

/**
 * @brief   System ticks to milliseconds.
 * @details Converts from system ticks number to milliseconds.
 * @note    The result is rounded up to the next millisecond boundary.
 * @note    Use of this macro for large values is not secure because
 *          integer overflows, make sure your value can be correctly
 *          converted.
 *
 * @param[in] n         number of system ticks
 * @return              The number of milliseconds.
 *
 * @api
 */
#define ST2MS(n) (((n) * 1000UL + CH_CFG_ST_FREQUENCY - 1UL) /              \
                  CH_CFG_ST_FREQUENCY)

/**
 * @brief   System ticks to microseconds.
 * @details Converts from system ticks number to microseconds.
 * @note    The result is rounded up to the next microsecond boundary.
 * @note    Use of this macro for large values is not secure because
 *          integer overflows, make sure your value can be correctly
 *          converted.
 *
 * @param[in] n         number of system ticks
 * @return              The number of microseconds.
 *
 * @api
 */
#define ST2US(n) (((n) * 1000000UL + CH_CFG_ST_FREQUENCY - 1UL) /           \
                  CH_CFG_ST_FREQUENCY)

static const int waThreadNRT = 1;
static const int waThreadRT = 2;
static const int waThreadFRT = 3;
//static const int NORMALPRIO = 100;


void palTogglePad(int bank, int pad);
void palClearPad(int bank, int pad);
void palSetPad(int bank, int pad);
int chThdShouldTerminateX();
void chThdSleepMilliseconds(int t);


/**
 * @name    Priority constants
 * @{
 */
#define NOPRIO              (tprio_t)0      /**< @brief Ready list header
                                                 priority.                  */
#define IDLEPRIO            (tprio_t)1      /**< @brief Idle priority.      */
#define LOWPRIO             (tprio_t)2      /**< @brief Lowest priority.    */
#define NORMALPRIO          (tprio_t)128    /**< @brief Normal priority.    */
#define HIGHPRIO            (tprio_t)255    /**< @brief Highest priority.   */
/** @} */

/**
 * @name    Thread states
 * @{
 */
#define CH_STATE_READY      (tstate_t)0      /**< @brief Waiting on the
                                                  ready list.               */
#define CH_STATE_CURRENT    (tstate_t)1      /**< @brief Currently running. */
#define CH_STATE_WTSTART    (tstate_t)2      /**< @brief Just created.      */
#define CH_STATE_SUSPENDED  (tstate_t)3      /**< @brief Suspended state.   */
#define CH_STATE_QUEUED     (tstate_t)4      /**< @brief On an I/O queue.   */
#define CH_STATE_WTSEM      (tstate_t)5      /**< @brief On a semaphore.    */
#define CH_STATE_WTMTX      (tstate_t)6      /**< @brief On a mutex.        */
#define CH_STATE_WTCOND     (tstate_t)7      /**< @brief On a cond.variable.*/
#define CH_STATE_SLEEPING   (tstate_t)8      /**< @brief Sleeping.          */
#define CH_STATE_WTEXIT     (tstate_t)9      /**< @brief Waiting a thread.  */
#define CH_STATE_WTOREVT    (tstate_t)10     /**< @brief One event.         */
#define CH_STATE_WTANDEVT   (tstate_t)11     /**< @brief Several events.    */
#define CH_STATE_SNDMSGQ    (tstate_t)12     /**< @brief Sending a message,
                                                  in queue.                 */
#define CH_STATE_SNDMSG     (tstate_t)13     /**< @brief Sent a message,
                                                  waiting answer.           */
#define CH_STATE_WTMSG      (tstate_t)14     /**< @brief Waiting for a
                                                  message.                  */
#define CH_STATE_FINAL      (tstate_t)15     /**< @brief Thread terminated. */

/**
 * @brief   Thread states as array of strings.
 * @details Each element in an array initialized with this macro can be
 *          indexed using the numeric thread state values.
 */
#define CH_STATE_NAMES                                                     \
  "READY", "CURRENT", "WTSTART", "SUSPENDED", "QUEUED", "WTSEM", "WTMTX",  \
  "WTCOND", "SLEEPING", "WTEXIT", "WTOREVT", "WTANDEVT", "SNDMSGQ",        \
  "SNDMSG", "WTMSG", "FINAL"
/** @} */

/**
 * @name    Thread flags and attributes
 * @{
 */
#define CH_FLAG_MODE_MASK   (tmode_t)3U     /**< @brief Thread memory mode
                                                 mask.                      */
#define CH_FLAG_MODE_STATIC (tmode_t)0U     /**< @brief Static thread.      */
#define CH_FLAG_MODE_HEAP   (tmode_t)1U     /**< @brief Thread allocated
                                                 from a Memory Heap.        */
#define CH_FLAG_MODE_MPOOL  (tmode_t)2U     /**< @brief Thread allocated
                                                 from a Memory Pool.        */
#define CH_FLAG_TERMINATE   (tmode_t)4U     /**< @brief Termination requested
                                                 flag.                      */

//#define currp ch.rlist.current
#define PORT_THD_FUNCTION(tname, arg) void tname(void *arg)
#define THD_FUNCTION(tname, arg) PORT_THD_FUNCTION(tname, arg)
#define chThdSleepMilliseconds(msec) chThdSleep(MS2ST(msec))
#define THD_WORKING_AREA(waname, stacksize)



static inline void chRegSetThreadName(const char *name) {
//#if CH_CFG_USE_REGISTRY == TRUE
//  ch.rlist.current->name = name;
//#else
  (void)name;
//#endif
}



/*===========================================================================*/
/* Module data structures and types.                                         */
/*===========================================================================*/
typedef uint32_t            systime_t;
typedef uint32_t            rtcnt_t;        /**< Realtime counter.          */
typedef uint64_t            rttime_t;       /**< Realtime accumulator.      */
typedef uint32_t            tprio_t;        /**< Thread priority.           */
typedef int32_t             msg_t;          /**< Inter-thread message.      */
typedef uint8_t             tmode_t;        /**< Thread flags.              */
typedef uint8_t             tstate_t;       /**< Thread state.              */
typedef uint8_t             trefs_t;        /**< Thread references counter. */
typedef int32_t             cnt_t;          /**< Generic signed counter.    */
typedef uint32_t            ucnt_t;         /**< Generic unsigned counter.  */


typedef struct ch_thread thread_t;

/**
 * @brief   Generic threads single link list, it works like a stack.
 */
//struct ch_threads_list {
//  thread_t              *next;      /**< @brief Next in the list/queue.     */
//};

typedef struct ch_thread thread_t;

/**
 * @brief   Generic threads bidirectional linked list header and element.
 */
//struct ch_threads_queue {
//  thread_t              *next;      /**< @brief Next in the list/queue.     */
//  thread_t              *prev;      /**< @brief Previous in the queue.      */
//};

typedef struct ch_threads_queue threads_queue_t;


/**
 * @brief   Type of a generic threads single link list, it works like a stack.
 */
typedef struct ch_threads_list threads_list_t;

/**
 * @extends threads_list_t
 *
 * @brief   Type of a generic threads bidirectional linked list header and element.
 */
typedef struct ch_threads_queue threads_queue_t;


/**
 * @brief   Type of a thread reference.
 */
typedef thread_t * thread_reference_t;

/**
 * @brief   Thread function.
 */
typedef void (*tfunc_t)(void *p);

/**
 * @brief   Type of a thread descriptor.
 */
typedef struct {
  /**
   * @brief   Thread name.
   */
  const char        *name;
  /**
   * @brief   Pointer to the working area base.
   */
  //stkalign_t        *wbase;
  /**
   * @brief   End of the working area.
   */
  //stkalign_t        *wend;
  /**
   * @brief   Thread priority.
   */
  tprio_t           prio;
  /**
   * @brief   Thread function pointer.
   */
  tfunc_t           funcp;
  /**
   * @brief   Thread argument.
   */
  void              *arg;
} thread_descriptor_t;

/**
 * @extends threads_queue_t
 */
//struct ch_ready_list {
//  threads_queue_t       queue;      /**< @brief Threads queue.              */
//  tprio_t               prio;       /**< @brief This field must be
                                                //initialized to zero.        */
  //struct port_context   ctx;        /**< @brief Not used, present because
  //                                              offsets.                    */
//#if (CH_CFG_USE_REGISTRY == TRUE) || defined(__DOXYGEN__)
//  thread_t              *newer;     /**< @brief Newer registry element.     */
//  thread_t              *older;     /**< @brief Older registry element.     */
//#endif
  /* End of the fields shared with the thread_t structure.*/
//  thread_t              *current;   /**< @brief The currently running
//                                                thread.                     */
//};


/**
 * @brief   Puts the current thread to sleep into the specified state with
 *          timeout specification.
 * @details The thread goes into a sleeping state, if it is not awakened
 *          explicitly within the specified timeout then it is forcibly
 *          awakened with a @p MSG_TIMEOUT low level message. The possible
 *          @ref thread_states are defined into @p threads.h.
 *
 * @param[in] newstate  the new thread state
 * @param[in] time      the number of ticks before the operation timeouts, the
 *                      special values are handled as follow:
 *                      - @a TIME_INFINITE the thread enters an infinite sleep
 *                        state, this is equivalent to invoking
 *                        @p chSchGoSleepS() but, of course, less efficient.
 *                      - @a TIME_IMMEDIATE this value is not allowed.
 *                      .
 * @return              The wakeup message.
 * @retval MSG_TIMEOUT  if a timeout occurs.
 *
 * @sclass
 */
/*msg_t chSchGoSleepTimeoutS(tstate_t newstate, systime_t time) {

  chDbgCheckClassS();

  if (TIME_INFINITE != time) {
    virtual_timer_t vt;

    chVTDoSetI(&vt, time, wakeup, currp);
    chSchGoSleepS(newstate);
    if (chVTIsArmedI(&vt)) {
      chVTDoResetI(&vt);
    }
  }
  else {
    chSchGoSleepS(newstate);
  }

  return currp->u.rdymsg;
}*/

void chThdSleepS(systime_t time);
void chThdSleep(systime_t time);

void chThdExit(msg_t msg);
void chThdExitS(msg_t msg);
void chThdTerminate(thread_t *tp);

/**
 * @brief   Removes a thread from the registry list.
 * @note    This macro is not meant for use in application code.
 *
 * @param[in] tp        thread to remove from the registry
 */
#define REG_REMOVE(tp) {                                                    \
  (tp)->older->newer = (tp)->newer;                                         \
  (tp)->newer->older = (tp)->older;                                         \
}

/**
 * @brief   Adds a thread to the registry list.
 * @note    This macro is not meant for use in application code.
 *
 * @param[in] tp        thread to add to the registry
 */
#define REG_INSERT(tp) {                                                    \
  (tp)->newer = (thread_t *)&ch.rlist;                                      \
  (tp)->older = ch.rlist.older;                                           \
  (tp)->older->newer = (tp);                                                \
  ch.rlist.older = (tp);                                                  \
}


/**
 * @brief   Current system time.
 * @details Returns the number of system ticks since the @p chSysInit()
 *          invocation.
 * @note    The counter can reach its maximum and then restart from zero.
 * @note    This function can be called from any context but its atomicity
 *          is not guaranteed on architectures whose word size is less than
 *          @p systime_t size.
 *
 * @return              The system time in ticks.
 *
 * @xclass
 */
static systime_t chVTGetSystemTimeX(void) {
  // TODO Implement me!
//#if CH_CFG_ST_TIMEDELTA == 0
//  return ch.vtlist.systime;
//#else /* CH_CFG_ST_TIMEDELTA > 0 */
//  return port_timer_get_time();
//#endif /* CH_CFG_ST_TIMEDELTA > 0 */
  systime_t t_s = 0;
  return t_s;
}

/**
 * @brief   Returns the elapsed time since the specified start time.
 *
 * @param[in] start     start time
 * @return              The elapsed time.
 *
 * @xclass
 */
#define chVTTimeElapsedSinceX(start)                                        \
  ((systime_t)(chVTGetSystemTimeX() - (start)))





void chSysLock();
void chSysUnLock();
void chSysLockFromISR();
void chSysUnlockFromISR();

msg_t chThdWait(thread_t *tp);
void chThdResumeI(thread_reference_t *trp, msg_t msg);
void chThdResumeS(thread_reference_t *trp, msg_t msg);
void chThdResume(thread_reference_t *trp, msg_t msg);
void chSchGoSleepS(tstate_t newstate);


systime_t chVTGetSystemTime(void);


/*===========================================================================*/
/* Simulation of PWM, DMA and ADC.                                           */
/*===========================================================================*/
/**
 * @brief Simulation of PWM, DMA and ADC.
 *
*/
void pwm_dma_init_3(void);  //TODO: implement me!

typedef uint16_t adcsample_t;
typedef enum {
  ADC_ERR_DMAFAILURE = 0,                   /**< DMA operations failure.    */
  ADC_ERR_OVERFLOW = 1,                     /**< ADC overflow condition.    */
  ADC_ERR_AWD1 = 2,                         /**< Watchdog 1 triggered.      */
  ADC_ERR_AWD2 = 3,                         /**< Watchdog 2 triggered.      */
  ADC_ERR_AWD3 = 4                          /**< Watchdog 3 triggered.      */
} adcerror_t;

/**
 * @brief   Channels number in a conversion group.
 */
typedef uint16_t adc_channels_num_t;

/*===========================================================================*/
/* Other ChibiOS' stuff that is not (yet) required for the simulation...     */
/*===========================================================================*/
static inline void halInit() {}
static inline void chSysInit() {}
//int PWMD1, PWMD2;

static inline void usb_init() {}

#define STM32_DMA2_STREAM1 0
#define STM32_DMA2_STREAM6 0

/** 
  * @brief DMA Controller
  */

typedef struct
{
  uint32_t CR;     /*!< DMA stream x configuration register      */
  uint32_t NDTR;   /*!< DMA stream x number of data register     */
  uint32_t PAR;    /*!< DMA stream x peripheral address register */
  uint32_t M0AR;   /*!< DMA stream x memory 0 address register   */
  uint32_t M1AR;   /*!< DMA stream x memory 1 address register   */
  uint32_t FCR;    /*!< DMA stream x FIFO control register       */
} DMA_Stream_TypeDef;

typedef struct
{
  uint32_t LISR;   /*!< DMA low interrupt status register,      Address offset: 0x00 */
  uint32_t HISR;   /*!< DMA high interrupt status register,     Address offset: 0x04 */
  uint32_t LIFCR;  /*!< DMA low interrupt flag clear register,  Address offset: 0x08 */
  uint32_t HIFCR;  /*!< DMA high interrupt flag clear register, Address offset: 0x0C */
} DMA_TypeDef;

typedef struct
{
  __IO uint32_t SR;     /*!< ADC status register,                         Address offset: 0x00 */
  __IO uint32_t CR1;    /*!< ADC control register 1,                      Address offset: 0x04 */
  __IO uint32_t CR2;    /*!< ADC control register 2,                      Address offset: 0x08 */
  __IO uint32_t SMPR1;  /*!< ADC sample time register 1,                  Address offset: 0x0C */
  __IO uint32_t SMPR2;  /*!< ADC sample time register 2,                  Address offset: 0x10 */
  __IO uint32_t SQR1;   /*!< ADC regular sequence register 1,             Address offset: 0x2C */
  __IO uint32_t SQR2;   /*!< ADC regular sequence register 2,             Address offset: 0x30 */
  __IO uint32_t SQR3;   /*!< ADC regular sequence register 3,             Address offset: 0x34 */
  __IO uint32_t DR;     /*!< ADC regular data register,                   Address offset: 0x4C */
  // Cleaned up because not needed for the simulation
} ADC_TypeDef;

typedef struct
{
  __IO uint32_t CSR;    /*!< ADC Common status register,                  Address offset: ADC1 base address + 0x300 */
  __IO uint32_t CCR;    /*!< ADC common control register,                 Address offset: ADC1 base address + 0x304 */
  __IO uint32_t CDR;    /*!< ADC common regular data register for dual
                             AND triple modes,                            Address offset: ADC1 base address + 0x308 */
} ADC_Common_TypeDef;

typedef struct {
  DMA_Stream_TypeDef    *stream;        /**< @brief Associated DMA stream.  */
  volatile uint32_t     *ifcr;          /**< @brief Associated IFCR reg.    */
  uint8_t               ishift;         /**< @brief Bits offset in xIFCR
                                             register.                      */
  uint8_t               selfindex;      /**< @brief Index to self in array. */
  uint8_t               vector;         /**< @brief Associated IRQ vector.  */
} stm32_dma_stream_t;


/**
 * @brief   Driver state machine possible states.
 */
typedef enum {
  ADC_UNINIT = 0,                           /**< Not initialized.           */
  ADC_STOP = 1,                             /**< Stopped.                   */
  ADC_READY = 2,                            /**< Ready.                     */
  ADC_ACTIVE = 3,                           /**< Converting.                */
  ADC_COMPLETE = 4,                         /**< Conversion complete.       */
  ADC_ERROR = 5                             /**< Conversion error.          */
} adcstate_t;

/**
 * @brief   Driver configuration structure.
 * @note    It could be empty on some architectures.
 */
typedef struct {
  uint32_t                  dummy;
} ADCConfig;

typedef struct ADCDriver ADCDriver;

/**
 * @brief   ADC notification callback type.
 *
 * @param[in] adcp      pointer to the @p ADCDriver object triggering the
 *                      callback
 * @param[in] buffer    pointer to the most recent samples data
 * @param[in] n         number of buffer rows available starting from @p buffer
 */
typedef void (*adccallback_t)(ADCDriver *adcp, adcsample_t *buffer, size_t n);

/**
 * @brief   ADC error callback type.
 *
 * @param[in] adcp      pointer to the @p ADCDriver object triggering the
 *                      callback
 * @param[in] err       ADC error code
 */
typedef void (*adcerrorcallback_t)(ADCDriver *adcp, adcerror_t err);

/**
 * @brief   Conversion group configuration structure.
 * @details This implementation-dependent structure describes a conversion
 *          operation.
 * @note    The use of this configuration structure requires knowledge of
 *          PLATFORM ADC cell registers interface, please refer to the PLATFORM
 *          reference manual for details.
 */
typedef struct {
  /**
   * @brief   Enables the circular buffer mode for the group.
   */
  bool                      circular;
  /**
   * @brief   Number of the analog channels belonging to the conversion group.
   */
  adc_channels_num_t        num_channels;
  /**
   * @brief   Callback function associated to the group or @p NULL.
   */
  adccallback_t             end_cb;
  /**
   * @brief   Error callback or @p NULL.
   */
  adcerrorcallback_t        error_cb;
  /* End of the mandatory fields.*/
} ADCConversionGroup;


struct ADCDriver { 
  /**
   * @brief   Driver state.
   */
  adcstate_t                state;
  /**
   * @brief   Current configuration data.
   */
  const ADCConfig           *config;
  /**
   * @brief   Current samples buffer pointer or @p NULL.
   */
  adcsample_t               *samples;
  /**
   * @brief   Current samples buffer depth or @p 0.
   */
  size_t                    depth;
  /**
   * @brief   Current conversion group pointer or @p NULL.
   */
  const ADCConversionGroup  *grpp;
#if ADC_USE_WAIT || defined(__DOXYGEN__)
  /**
   * @brief   Waiting thread.
   */
  thread_reference_t        thread;
#endif
#if ADC_USE_MUTUAL_EXCLUSION || defined(__DOXYGEN__)
  /**
   * @brief   Mutex protecting the peripheral.
   */
  mutex_t                   mutex;
#endif /* ADC_USE_MUTUAL_EXCLUSION */
#if defined(ADC_DRIVER_EXT_FIELDS)
  ADC_DRIVER_EXT_FIELDS
#endif
  /* End of the mandatory fields.*/
  /**
   * @brief   Pointer to the master ADCx registers block.
   */
  ADC_TypeDef               *adcm;
#if STM32_ADC_DUAL_MODE || defined(__DOXYGEN__)
  /**
   * @brief   Pointer to the slave ADCx registers block.
   */
  ADC_TypeDef               *adcs;
#endif /* STM32_ADC_DUAL_MODE */
  /**
   * @brief   Pointer to the common ADCx_y registers block.
   */
  ADC_Common_TypeDef        *adcc;
  /**
   * @brief   Pointer to associated DMA channel.
   */
  const stm32_dma_stream_t  *dmastp;
  /**
   * @brief   DMA mode bit mask.
   */
  uint32_t                  dmamode;
};  // ADCDriver
extern ADCDriver ADCD1;


void adcStart(ADCDriver *adcp, const ADCConfig *config);
void USB_VCP_send_string(unsigned char *ptr);


#endif  // __SIM_INTERFACES__H__