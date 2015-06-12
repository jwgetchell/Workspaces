#ifndef _CAPI_H
#define _CAPI_H

#include "alsPrxTypes.h"

CAPI setAmbientCoeffs(uw,dbl,dbl);

CAPI cGetByteIoOnly(uw*);
CAPI cGetData(uw,uw*);
CAPI cGetDevice(uw*);
CAPI cGetDeviceList(char*);
CAPI cGetEnable(uw,uw*);
CAPI cGetError(uw,char*);
CAPI cGetInputSelect(uw,uw*);
CAPI cGetInputSelectList(uw,char*);
CAPI cGetIntFlag(uw,uw*);
CAPI cGetIntLogic(uw*);
CAPI cGetIntPersist(uw,uw*);
CAPI cGetIR(dbl*);
CAPI cGetIRState(uw*);
CAPI cGetIrdr(uw*);
CAPI cGetIrdrFreq(uw*);
CAPI cGetIrdrList(uw*);
CAPI cGetLux(dbl*);
CAPI cGetLuxState(uw*);
CAPI cGetMPAprimed(uw,uw*);
CAPI cGetNchannel(uw*);
CAPI cGetNdevice(uw*);
CAPI cGetNinputSelect(uw,uw*);
CAPI cGetNirdr(uw*);
CAPI cGetNrange(uw,uw*);
CAPI cGetNresolution(uw,uw*);
CAPI cGetNsleep(uw*);
CAPI cGetProxAmbRej(uw*);
CAPI cGetProximity(dbl*);
CAPI cGetProxGain38(uw*);
CAPI cGetProxIR(dbl*,uw*);
CAPI cGetProximityState(uw*);
CAPI cGetRange(uw,uw*);
CAPI cGetRangeList(uw,uw*);
CAPI cGetResolution(uw,uw*);
CAPI cGetResolutionList(uw,uw*);
CAPI cGetRunMode(uw*);
CAPI cGetSleep(uw*);
CAPI cGetSleepList(uw*);
CAPI cGetStateMachineEnable(uw*);
CAPI cGetStats(uw,double*,double*);
CAPI cGetThreshHi(uw,dbl*);
CAPI cGetThreshLo(uw,dbl*);
CAPI cInitDriver();
CAPI cPoll(uw*);
CAPI cPrintTrace(char*);
CAPI cResetDevice();
CAPI cSetByteIoOnly(uw);
CAPI cSetDevice(uw);
CAPI cSetDrvApi(uw (fpApi *pF)(uw,uw,uw*,ul));
CAPI cSetEnable(uw,uw);
CAPI cSetInputSelect(uw,uw);
CAPI cSetIntLogic(uw);
CAPI cSetIntPersist(uw,uw);
CAPI cSetIrdr(uw);
CAPI cSetIrdrFreq(uw);
//CAPI cSetLux(dbl);
CAPI cSetMPAsize(uw,uw);
CAPI cSetProxAmbRej(uw);
CAPI cSetProxGain38(uw);
CAPI cSetRange(uw,uw);
CAPI cSetResolution(uw,uw);
CAPI cSetRunMode(uw);
CAPI cSetSleep(uw);
CAPI cSetStateMachineEnable(uw);
CAPI cSetThreshHi(uw,dbl);
CAPI cSetThreshLo(uw,dbl);
CAPI cTest(uw);
CAPI cIO(uw,uw,uw*);

CAPI cWriteI2c(uw,uw,uc);
CAPI cWriteI2cWord(uw,uw,uw);
CAPI cReadI2c(uw,uw,uc*);
CAPI cReadI2cWord(uw,uw,uw*);

// RGB
CAPI cGetRed(dbl*);
CAPI cGetGreen(dbl*);
CAPI cGetBlue(dbl*);
CAPI cGetCCT(dbl*);
CAPI cLoadRgbCoeff(dbl*);
CAPI cClearRgbCoeff();

// VB6 replacements (XP)
CAPI VarPtr_(uw*);

#endif
