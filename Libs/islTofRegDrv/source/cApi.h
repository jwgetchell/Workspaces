#ifndef _CAPI_H
#define _CAPI_H

#include "alsPrxTypes.h"

CAPI cSetDrvApi(uw (fpApi *pF)(uw,uw,uw*,ul));

// analogControlRegisters
CAPI getIRDR(dbl*); CAPI setIRDR(dbl);


CAPI cGetError(uw,char*);
CAPI cGetStats(uw,double*,double*);
#endif
