#ifndef _CAPI_H
#define _CAPI_H

#include "alsPrxTypes.h"

CAPI cSetDrvApi(uw (fpApi *pF)(uw,uw,uw*,ul));

// analogControl
CAPI getIRDR(dbl*); CAPI setIRDR(dbl);

// status
CAPI status_getChip_id(uw*);
CAPI status_getC_en(uw*);CAPI status_setC_en(uw);

CAPI cGetError(uw,char*);
CAPI cGetStats(uw,double*,double*);

	#include "..\autoGen.cpp\cApi.h"

#endif
