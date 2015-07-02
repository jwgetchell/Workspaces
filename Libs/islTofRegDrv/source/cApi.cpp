#include "resMgr.h"

#ifndef _CPP
	#define _CPP
#endif

#include "ALSbaseClass.h"
#include "analogControlRegisters.h"
#include "alsPrxI2cIo.h"
#include "cApi.h"

DLLAPI CresourceManager resMgr;
DLLAPI CalsBase* pCalsBase=NULL;

CAPI cSetDrvApi(ul (fpApi *pF)(ul,ul,uw*,ul))  {pCalsBase->setDrvApi(pF);return pCalsBase->initDriver();}

// analogControlRegisters
CAPI getIRDR(dbl* irdr)       {return pCalsBase->analogControlRegisters->getIRDR(*irdr);}
CAPI setIRDR(dbl irdr)        {return pCalsBase->analogControlRegisters->setIRDR(irdr);}
CAPI getAFEgain(uw* gain)     {return pCalsBase->analogControlRegisters->getAFEgain(*gain);}
CAPI setAFEgain(const uw gain){return pCalsBase->analogControlRegisters->setAFEgain(gain);}


//openLoopCorrectionRegisters
CAPI getPhaseOffsetAmbientCoef(dbl* c1,dbl* c2)                   {return pCalsBase->getPhaseOffsetAmbientCoef(*c1,*c1);}
CAPI setPhaseOffsetAmbientCoef(const dbl c1,const dbl c2)         {return pCalsBase->setPhaseOffsetAmbientCoef(c1,c2);}
CAPI getPhaseOffsetVGAcoef(const uw vga,dbl* c1,dbl* c2)          {return pCalsBase->getPhaseOffsetVGAcoef(vga,*c1,*c1);}
CAPI setPhaseOffsetVGAcoef(const uw vga,const dbl c1,const dbl c2){return pCalsBase->setPhaseOffsetVGAcoef(vga,c1,c2);}





CAPI cGetError(ul e,char* m)  {return pCalsBase->getError(e,m);}
CAPI cGetStats(uw c,double *m, double *s) {return pCalsBase->getStats(c,*m,*s);}

CAPI cWriteField(uw addr,uc shift,uc mask,uc data) {return pCalsBase->m_pIO->write(addr,shift,mask,data);}
CAPI cReadField(uw addr,uc shift,uc mask,uc* data) {return pCalsBase->m_pIO->read(addr,shift,mask,*data);}


CAPI cSetIOintEn      (uw x)
{  
	if (x==0) 
	{
		return pCalsBase->setIOinterceptEnable(false);
	}
	else
	{
		//pCalsBase->m_pReg->openLoopCorrectionRegisters->ol_i_vga1_co2->write(0);
		return pCalsBase->setIOinterceptEnable(true);
	}
}

// 
// VB6 Function replacements
//

CAPI VarPtr_(uw* x)
{
	return (t_status)x;
}

CAPI memcpy_(char oVarPtr[],char iVarAddr[],uw nBytes)
{
	uw i;
	for (i=0;i<nBytes;i++)
		oVarPtr[i]=iVarAddr[i];

	return (t_status)0;
}

CAPI cpyAddr2byte_(char* o,uw i)
{
	*o=(char&)i;
	return (t_status)0;
}

CAPI strcpy_(char oVarPtr[],char iVarPtr[])
{
	int i;

	for (i=0;i<80;i++)
	{
		oVarPtr[i]=iVarPtr[i];
		if (iVarPtr[i]==0) break;
	}
	if (i==80) oVarPtr[i-1]=0;
	//strcpy(oVarPtr,iVarPtr);

	return (t_status)0;
}

//#endif