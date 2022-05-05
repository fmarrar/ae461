/*
 * ae461starter.c
 *
 * Classroom License -- for classroom instructional use only.  Not for
 * government, commercial, academic research, or other organizational use.
 *
 * Code generation for model "ae461starter".
 *
 * Model version              : 3.5
 * Simulink Coder version : 9.5 (R2021a) 14-Nov-2020
 * C source code generated on : Tue Mar 22 18:06:35 2022
 *
 * Target selection: sldrt.tlc
 * Note: GRT includes extra infrastructure and instrumentation for prototyping
 * Embedded hardware selection: Intel->x86-64 (Windows64)
 * Code generation objectives: Unspecified
 * Validation result: Not run
 */

#include "ae461starter.h"
#include "ae461starter_private.h"
#include "ae461starter_dt.h"

/* list of Simulink Desktop Real-Time timers */
const int SLDRTTimerCount = 1;
const double SLDRTTimers[2] = {
  0.001, 0.0,
};

/* Block signals (default storage) */
B_ae461starter_T ae461starter_B;

/* Block states (default storage) */
DW_ae461starter_T ae461starter_DW;

/* Real-time model */
static RT_MODEL_ae461starter_T ae461starter_M_;
RT_MODEL_ae461starter_T *const ae461starter_M = &ae461starter_M_;

/* Model output function */
void ae461starter_output(void)
{
  /* S-Function (pciint32enc): '<S2>/S-function' */
  /* S-Function Block: <S1>/PCIINT32_DAQ (pciint32enc) */
  {
    int_T values[4];
    PCIINT32_encInput(16240.0, values);
    ae461starter_B.Sfunction[0] = values[0];
    ae461starter_B.Sfunction[1] = values[1];
    ae461starter_B.Sfunction[2] = values[2];
    ae461starter_B.Sfunction[3] = values[3];
  }

  /* Step: '<Root>/Step' */
  if (ae461starter_M->Timing.t[0] < ae461starter_P.Step_Time) {
    /* Step: '<Root>/Step' */
    ae461starter_B.Step = ae461starter_P.Step_Y0;
  } else {
    /* Step: '<Root>/Step' */
    ae461starter_B.Step = ae461starter_P.Step_YFinal;
  }

  /* End of Step: '<Root>/Step' */

  /* S-Function (pciint32dac): '<S2>/S-function2' */
  /* S-Function Block: <S1>/PCIINT32_DAQ (pciint32dac) */
  {
    real_T values[4];
    values[0] = ae461starter_B.Step;
    values[1] = 0.0;
    values[2] = 0.0;
    values[3] = 0.0;
    PCIINT32_dacOutput(16240.0, values);
  }

  /* S-Function (pciint32adc): '<S2>/S-function1' */
  /* S-Function Block: <S1>/PCIINT32_DAQ (pciint32adc) */
  {
    int_T values[4];
    PCIINT32_adcInput(16240.0, values);
    ae461starter_B.Sfunction1[0] = values[0];
    ae461starter_B.Sfunction1[1] = values[1];
    ae461starter_B.Sfunction1[2] = values[2];
    ae461starter_B.Sfunction1[3] = values[3];
  }

  /* Gain: '<Root>/Gain' */
  ae461starter_B.Gain = ae461starter_P.Gain_Gain * ae461starter_B.Sfunction[0];
}

/* Model update function */
void ae461starter_update(void)
{
  /* Update absolute time for base rate */
  /* The "clockTick0" counts the number of times the code of this task has
   * been executed. The absolute time is the multiplication of "clockTick0"
   * and "Timing.stepSize0". Size of "clockTick0" ensures timer will not
   * overflow during the application lifespan selected.
   * Timer of this task consists of two 32 bit unsigned integers.
   * The two integers represent the low bits Timing.clockTick0 and the high bits
   * Timing.clockTickH0. When the low bit overflows to 0, the high bits increment.
   */
  if (!(++ae461starter_M->Timing.clockTick0)) {
    ++ae461starter_M->Timing.clockTickH0;
  }

  ae461starter_M->Timing.t[0] = ae461starter_M->Timing.clockTick0 *
    ae461starter_M->Timing.stepSize0 + ae461starter_M->Timing.clockTickH0 *
    ae461starter_M->Timing.stepSize0 * 4294967296.0;

  {
    /* Update absolute timer for sample time: [0.001s, 0.0s] */
    /* The "clockTick1" counts the number of times the code of this task has
     * been executed. The absolute time is the multiplication of "clockTick1"
     * and "Timing.stepSize1". Size of "clockTick1" ensures timer will not
     * overflow during the application lifespan selected.
     * Timer of this task consists of two 32 bit unsigned integers.
     * The two integers represent the low bits Timing.clockTick1 and the high bits
     * Timing.clockTickH1. When the low bit overflows to 0, the high bits increment.
     */
    if (!(++ae461starter_M->Timing.clockTick1)) {
      ++ae461starter_M->Timing.clockTickH1;
    }

    ae461starter_M->Timing.t[1] = ae461starter_M->Timing.clockTick1 *
      ae461starter_M->Timing.stepSize1 + ae461starter_M->Timing.clockTickH1 *
      ae461starter_M->Timing.stepSize1 * 4294967296.0;
  }
}

/* Model initialize function */
void ae461starter_initialize(void)
{
  /* Start for S-Function (pciint32enc): '<S2>/S-function' */
  {
    PCIINT32_encResetAll(16240.0);
  }

  /* Start for S-Function (pciint32dac): '<S2>/S-function2' */
  {
  }

  /* Start for S-Function (pciint32adc): '<S2>/S-function1' */
  {
  }
}

/* Model terminate function */
void ae461starter_terminate(void)
{
  /* Terminate for S-Function (pciint32dac): '<S2>/S-function2' */

  /* S-Function Block: <S1>/PCIINT32_DAQ (pciint32dac) */
  {
    real_T values[4] = { 0.0, 0.0, 0.0, 0.0 };

    PCIINT32_dacOutput(16240.0, values);
  }
}

/*========================================================================*
 * Start of Classic call interface                                        *
 *========================================================================*/
void MdlOutputs(int_T tid)
{
  ae461starter_output();
  UNUSED_PARAMETER(tid);
}

void MdlUpdate(int_T tid)
{
  ae461starter_update();
  UNUSED_PARAMETER(tid);
}

void MdlInitializeSizes(void)
{
}

void MdlInitializeSampleTimes(void)
{
}

void MdlInitialize(void)
{
}

void MdlStart(void)
{
  ae461starter_initialize();
}

void MdlTerminate(void)
{
  ae461starter_terminate();
}

/* Registration function */
RT_MODEL_ae461starter_T *ae461starter(void)
{
  /* Registration code */

  /* initialize non-finites */
  rt_InitInfAndNaN(sizeof(real_T));

  /* initialize real-time model */
  (void) memset((void *)ae461starter_M, 0,
                sizeof(RT_MODEL_ae461starter_T));

  {
    /* Setup solver object */
    rtsiSetSimTimeStepPtr(&ae461starter_M->solverInfo,
                          &ae461starter_M->Timing.simTimeStep);
    rtsiSetTPtr(&ae461starter_M->solverInfo, &rtmGetTPtr(ae461starter_M));
    rtsiSetStepSizePtr(&ae461starter_M->solverInfo,
                       &ae461starter_M->Timing.stepSize0);
    rtsiSetErrorStatusPtr(&ae461starter_M->solverInfo, (&rtmGetErrorStatus
      (ae461starter_M)));
    rtsiSetRTModelPtr(&ae461starter_M->solverInfo, ae461starter_M);
  }

  rtsiSetSimTimeStep(&ae461starter_M->solverInfo, MAJOR_TIME_STEP);
  rtsiSetSolverName(&ae461starter_M->solverInfo,"FixedStepDiscrete");

  /* Initialize timing info */
  {
    int_T *mdlTsMap = ae461starter_M->Timing.sampleTimeTaskIDArray;
    mdlTsMap[0] = 0;
    mdlTsMap[1] = 1;
    ae461starter_M->Timing.sampleTimeTaskIDPtr = (&mdlTsMap[0]);
    ae461starter_M->Timing.sampleTimes =
      (&ae461starter_M->Timing.sampleTimesArray[0]);
    ae461starter_M->Timing.offsetTimes =
      (&ae461starter_M->Timing.offsetTimesArray[0]);

    /* task periods */
    ae461starter_M->Timing.sampleTimes[0] = (0.0);
    ae461starter_M->Timing.sampleTimes[1] = (0.001);

    /* task offsets */
    ae461starter_M->Timing.offsetTimes[0] = (0.0);
    ae461starter_M->Timing.offsetTimes[1] = (0.0);
  }

  rtmSetTPtr(ae461starter_M, &ae461starter_M->Timing.tArray[0]);

  {
    int_T *mdlSampleHits = ae461starter_M->Timing.sampleHitArray;
    mdlSampleHits[0] = 1;
    mdlSampleHits[1] = 1;
    ae461starter_M->Timing.sampleHits = (&mdlSampleHits[0]);
  }

  rtmSetTFinal(ae461starter_M, -1);
  ae461starter_M->Timing.stepSize0 = 0.001;
  ae461starter_M->Timing.stepSize1 = 0.001;

  /* External mode info */
  ae461starter_M->Sizes.checksums[0] = (3848297774U);
  ae461starter_M->Sizes.checksums[1] = (3879868193U);
  ae461starter_M->Sizes.checksums[2] = (979411043U);
  ae461starter_M->Sizes.checksums[3] = (2374555557U);

  {
    static const sysRanDType rtAlwaysEnabled = SUBSYS_RAN_BC_ENABLE;
    static RTWExtModeInfo rt_ExtModeInfo;
    static const sysRanDType *systemRan[1];
    ae461starter_M->extModeInfo = (&rt_ExtModeInfo);
    rteiSetSubSystemActiveVectorAddresses(&rt_ExtModeInfo, systemRan);
    systemRan[0] = &rtAlwaysEnabled;
    rteiSetModelMappingInfoPtr(ae461starter_M->extModeInfo,
      &ae461starter_M->SpecialInfo.mappingInfo);
    rteiSetChecksumsPtr(ae461starter_M->extModeInfo,
                        ae461starter_M->Sizes.checksums);
    rteiSetTPtr(ae461starter_M->extModeInfo, rtmGetTPtr(ae461starter_M));
  }

  ae461starter_M->solverInfoPtr = (&ae461starter_M->solverInfo);
  ae461starter_M->Timing.stepSize = (0.001);
  rtsiSetFixedStepSize(&ae461starter_M->solverInfo, 0.001);
  rtsiSetSolverMode(&ae461starter_M->solverInfo, SOLVER_MODE_SINGLETASKING);

  /* block I/O */
  ae461starter_M->blockIO = ((void *) &ae461starter_B);

  {
    ae461starter_B.Sfunction[0] = 0.0;
    ae461starter_B.Sfunction[1] = 0.0;
    ae461starter_B.Sfunction[2] = 0.0;
    ae461starter_B.Sfunction[3] = 0.0;
    ae461starter_B.Step = 0.0;
    ae461starter_B.Sfunction1[0] = 0.0;
    ae461starter_B.Sfunction1[1] = 0.0;
    ae461starter_B.Sfunction1[2] = 0.0;
    ae461starter_B.Sfunction1[3] = 0.0;
    ae461starter_B.Gain = 0.0;
  }

  /* parameters */
  ae461starter_M->defaultParam = ((real_T *)&ae461starter_P);

  /* states (dwork) */
  ae461starter_M->dwork = ((void *) &ae461starter_DW);
  (void) memset((void *)&ae461starter_DW, 0,
                sizeof(DW_ae461starter_T));

  /* data type transition information */
  {
    static DataTypeTransInfo dtInfo;
    (void) memset((char_T *) &dtInfo, 0,
                  sizeof(dtInfo));
    ae461starter_M->SpecialInfo.mappingInfo = (&dtInfo);
    dtInfo.numDataTypes = 14;
    dtInfo.dataTypeSizes = &rtDataTypeSizes[0];
    dtInfo.dataTypeNames = &rtDataTypeNames[0];

    /* Block I/O transition table */
    dtInfo.BTransTable = &rtBTransTable;

    /* Parameters transition table */
    dtInfo.PTransTable = &rtPTransTable;
  }

  /* Initialize Sizes */
  ae461starter_M->Sizes.numContStates = (0);/* Number of continuous states */
  ae461starter_M->Sizes.numY = (0);    /* Number of model outputs */
  ae461starter_M->Sizes.numU = (0);    /* Number of model inputs */
  ae461starter_M->Sizes.sysDirFeedThru = (0);/* The model is not direct feedthrough */
  ae461starter_M->Sizes.numSampTimes = (2);/* Number of sample times */
  ae461starter_M->Sizes.numBlocks = (7);/* Number of blocks */
  ae461starter_M->Sizes.numBlockIO = (4);/* Number of block outputs */
  ae461starter_M->Sizes.numBlockPrms = (4);/* Sum of parameter "widths" */
  return ae461starter_M;
}

/*========================================================================*
 * End of Classic call interface                                          *
 *========================================================================*/
