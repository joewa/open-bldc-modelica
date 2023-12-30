#include <stdio.h>
#include <unistd.h>
#include <sys/select.h>

#include <stdint.h>
#include <stdlib.h>
#include "siminterfaces.h"
#include "bal_interface.h"

/*
TODO: Die ChibiOS-Threads implementieren
*/

void NVIC_SystemReset(void) {

}

void adcStart(ADCDriver *adcp, const ADCConfig *config) {

}

void chSysLock() {

}
void chSysUnLock() {

}

void chSysLockFromISR() {

}

void chSysUnlockFromISR() {
  
}



void palTogglePad(int port, int pad) {
    printf("palTogglePad(port=%d, pad=%d)\n", port, pad);
}
void palClearPad(int port, int pad) {
    printf("palClearPad(port=%d, pad=%d)\n", port, pad);
}
void palSetPad(int port, int pad) {
    printf("palSetPad(port=%d, pad=%d)\n", port, pad);
}

void palSetPadMode(uint8_t port, uint8_t pad, uint32_t mode) {
    printf("palSetPadMode(port=%d, pad=%d, mode=%d)\n", port, pad, mode);
}

int chThdShouldTerminateX() {
    return 0;
}


/**
 * @brief   Requests a thread termination.
 * @pre     The target thread must be written to invoke periodically
 *          @p chThdShouldTerminate() and terminate cleanly if it returns
 *          @p true.
 * @post    The specified thread will terminate after detecting the termination
 *          condition.
 *
 * @param[in] tp        pointer to the thread
 *
 * @api
 */
void chThdTerminate(thread_t *tp) {
  //chSysLock();
  tp->flags |= CH_FLAG_TERMINATE;
  //chSysUnlock();
}

/**
 * @brief   Current system time.
 * @details Returns the number of system ticks since the @p chSysInit()
 *          invocation.
 * @note    The counter can reach its maximum and then restart from zero.
 *
 * @return              The system time in ticks.
 *
 * @api
 */
systime_t chVTGetSystemTime(void) {
  systime_t systime;

  //chSysLock();
  systime = chVTGetSystemTimeX();
  //chSysUnlock();

  return systime;
}


/*
systime_t chVTGetSystemTime() {
    systime_t time = hal_get_systick_value();
    return time;
}
*/

/**
 * @brief   Suspends the invoking thread for the specified time.
 *
 * @param[in] time      the delay in system ticks, the special values are
 *                      handled as follow:
 *                      - @a TIME_INFINITE the thread enters an infinite sleep
 *                        state.
 *                      - @a TIME_IMMEDIATE this value is not allowed.
 *                      .
 *
 * @sclass
 */
void chThdSleepS(systime_t time) {

  //chDbgCheck(time != TIME_IMMEDIATE);

  //(void) chSchGoSleepTimeoutS(CH_STATE_SLEEPING, time);
}

/**
 * @brief   Suspends the invoking thread for the specified time.
 *
 * @param[in] time      the delay in system ticks, the special values are
 *                      handled as follow:
 *                      - @a TIME_INFINITE the thread enters an infinite sleep
 *                        state.
 *                      - @a TIME_IMMEDIATE this value is not allowed.
 *                      .
 *
 * @api
 */
void chThdSleep(systime_t time) {

  //chSysLock();
  chThdSleepS(time);
  //chSysUnlock();
}


/**
 * @brief   Suspends the invoking thread until the system time arrives to the
 *          specified value.
 * @note    The function has no concept of "past", all specifiable times
 *          are in the future, this means that if you call this function
 *          exceeding your calculated intervals then the function will
 *          return in a far future time, not immediately.
 * @see     chThdSleepUntilWindowed()
 *
 * @param[in] time      absolute system time
 *
 * @api
 */
void chThdSleepUntil(systime_t time) {
  time -= chVTGetSystemTimeX();
  if (time > (systime_t)0) {
    chThdSleepS(time);
  }
}


thread_t *_thread_init(thread_t *tp, const char *name, tprio_t prio) {

  tp->prio      = prio;
  tp->state     = CH_STATE_WTSTART;
  tp->flags     = CH_FLAG_MODE_STATIC;
#if CH_CFG_TIME_QUANTUM > 0
  tp->preempt   = (tslices_t)CH_CFG_TIME_QUANTUM;
#endif
#if CH_CFG_USE_REGISTRY == TRUE
  tp->refs      = (trefs_t)1;
  tp->name      = name;
  //REG_INSERT(tp);
#else
  (void)name;
#endif
  CH_CFG_THREAD_INIT_HOOK(tp);
  return tp;
}

/**
 * @brief   Creates a new thread into a static memory area.
 * @post    The created thread has a reference counter set to one, it is
 *          caller responsibility to call @p chThdRelease() or @p chthdWait()
 *          in order to release the reference. The thread persists in the
 *          registry until its reference counter reaches zero.
 * @note    A thread can terminate by calling @p chThdExit() or by simply
 *          returning from its main function.
 *
 * @param[out] wsp      pointer to a working area dedicated to the thread stack
 * @param[in] size      size of the working area
 * @param[in] prio      the priority level for the new thread
 * @param[in] pf        the thread function
 * @param[in] arg       an argument passed to the thread function. It can be
 *                      @p NULL.
 * @return              The pointer to the @p thread_t structure allocated for
 *                      the thread into the working space area.
 *
 * @api
 */
thread_t *chThdCreateStatic(void *wsp, size_t size,
                            tprio_t prio, tfunc_t pf, void *arg) {
  thread_t *tp;

  /* Setting up the port-dependent part of the working area.*/
  //PORT_SETUP_CONTEXT(tp, wsp, tp, pf, arg);

  tp = _thread_init(tp, "noname", prio);

  return tp;
}


/**
 * @brief   Terminates the current thread.
 * @details The thread goes in the @p CH_STATE_FINAL state holding the
 *          specified exit status code, other threads can retrieve the
 *          exit status code by invoking the function @p chThdWait().
 * @post    Eventual code after this function will never be executed,
 *          this function never returns. The compiler has no way to
 *          know this so do not assume that the compiler would remove
 *          the dead code.
 *
 * @param[in] msg       thread exit code
 *
 * @api
 */
void chThdExit(msg_t msg) {

  chSysLock();
  chThdExitS(msg);
  /* The thread never returns here.*/
}

/**
 * @brief   Terminates the current thread.
 * @details The thread goes in the @p CH_STATE_FINAL state holding the
 *          specified exit status code, other threads can retrieve the
 *          exit status code by invoking the function @p chThdWait().
 * @post    Exiting a non-static thread that does not have references
 *          (detached) causes the thread to remain in the registry.
 *          It can only be removed by performing a registry scan operation.
 * @post    Eventual code after this function will never be executed,
 *          this function never returns. The compiler has no way to
 *          know this so do not assume that the compiler would remove
 *          the dead code.
 *
 * @param[in] msg       thread exit code
 *
 * @sclass
 */
void chThdExitS(msg_t msg) {
  //thread_t *tp = currp;

  /* Storing exit message.*/
  //tp->u.exitcode = msg;

  /* Exit handler hook.*/
  CH_CFG_THREAD_EXIT_HOOK(tp);

#if CH_CFG_USE_WAITEXIT == TRUE
  /* Waking up any waiting thread.*/
  //while (list_notempty(&tp->waiting)) {
  //  (void) chSchReadyI(list_remove(&tp->waiting));
  //}
#endif
}


void chThdRelease(thread_t *tp) {
  tp->refs--;

  /* If the references counter reaches zero and the thread is in its
     terminated state then the memory can be returned to the proper
     allocator.*/
  if ((tp->refs == (trefs_t)0) && (tp->state == CH_STATE_FINAL)) {
  //  REG_REMOVE(tp);

#if CH_CFG_USE_DYNAMIC == TRUE
    switch (tp->flags & CH_FLAG_MODE_MASK) {
#if CH_CFG_USE_HEAP == TRUE
    case CH_FLAG_MODE_HEAP:
      //chHeapFree(chThdGetWorkingAreaX(tp));
      break;
#endif
#if CH_CFG_USE_MEMPOOLS == TRUE
    case CH_FLAG_MODE_MPOOL:
      //chPoolFree(tp->mpool, chThdGetWorkingAreaX(tp));
      break;
#endif
    default:
      /* Nothing else to do for static threads.*/
      break;
    }
#endif /* CH_CFG_USE_DYNAMIC == TRUE */
    return;
  }
}

/**
 * @brief   Puts the current thread to sleep into the specified state.
 * @details The thread goes into a sleeping state. The possible
 *          @ref thread_states are defined into @p threads.h.
 *
 * @param[in] newstate  the new thread state
 *
 * @sclass
 */
void chSchGoSleepS(tstate_t newstate) {
  //thread_t *otp = currp;
}

msg_t chThdWait(thread_t *tp) {
  msg_t msg;
  if (tp->state != CH_STATE_FINAL) {
    //list_insert(currp, &tp->waiting);
    chSchGoSleepS(CH_STATE_WTEXIT);
  }
  //msg = tp->u.exitcode;

#if CH_CFG_USE_REGISTRY == TRUE
  /* Releasing a reference to the thread.*/
  chThdRelease(tp);
#endif

  return msg;
}

/**
 * @brief   Wakes up a thread waiting on a thread reference object.
 * @note    This function must not reschedule because it can be called from
 *          ISR context.
 *
 * @param[in] trp       a pointer to a thread reference object
 * @param[in] msg       the message code
 *
 * @iclass
 */
void chThdResumeI(thread_reference_t *trp, msg_t msg) {

  if (*trp != NULL) {
    thread_t *tp = *trp;
    *trp = NULL;
    //tp->u.rdymsg = msg;
    //(void) chSchReadyI(tp);
  }
}

/**
 * @brief   Wakes up a thread waiting on a thread reference object.
 * @note    This function must reschedule, it can only be called from thread
 *          context.
 *
 * @param[in] trp       a pointer to a thread reference object
 * @param[in] msg       the message code
 *
 * @iclass
 */
void chThdResumeS(thread_reference_t *trp, msg_t msg) {

  if (*trp != NULL) {
    thread_t *tp = *trp;
    *trp = NULL;
    //chSchWakeupS(tp, msg);
  }
}

/**
 * @brief   Wakes up a thread waiting on a thread reference object.
 * @note    This function must reschedule, it can only be called from thread
 *          context.
 *
 * @param[in] trp       a pointer to a thread reference object
 * @param[in] msg       the message code
 *
 * @api
 */
void chThdResume(thread_reference_t *trp, msg_t msg) {

  //chSysLock();
  chThdResumeS(trp, msg);
  //chSysUnlock();
}

/**
 * @brief Simulation of PWM, DMA and ADC.
 *
*/
void pwm_dma_init_3(void) {} //TODO: implement me!

ADCDriver ADCD1;


/**
 * @brief Virtual COM port
 * 
 */
void USB_VCP_send_string(unsigned char *ptr) {

}