#include "resMgr.h"

#ifndef _CPP
	#define _CPP
#endif

#include "ALSbaseClass.h"
#include "analogControl.h"
#include "alsPrxI2cIo.h"
#include "cApi.h"

DLLAPI CresourceManager resMgr;
DLLAPI CalsBase* pCalsBase=NULL;

CAPI cSetDrvApi(ul (fpApi *pF)(ul,ul,uw*,ul))  {pCalsBase->setDrvApi(pF);return pCalsBase->initDriver();}

// analogControlRegisters
CAPI getIRDR(dbl* irdr)       {return pCalsBase->analogControl->getIRDR(*irdr);}
CAPI setIRDR(dbl irdr)        {return pCalsBase->analogControl->setIRDR(irdr);}
CAPI getAFEgain(uw* gain)     {return pCalsBase->analogControl->getAFEgain(*gain);}
CAPI setAFEgain(const uw gain){return pCalsBase->analogControl->setAFEgain(gain);}

// status
CAPI status_getChip_id(uw* chip_id){return pCalsBase->status->getChip_id(*chip_id);}
CAPI status_getC_en(uw* c_en){return pCalsBase->status->getC_en(*c_en);}
CAPI status_setC_en(uw c_en){return pCalsBase->status->setC_en(c_en);}

//openLoopCorrectionRegisters
CAPI getPhaseOffsetAmbientCoef(dbl* c1,dbl* c2)                   {return pCalsBase->getPhaseOffsetAmbientCoef(*c1,*c1);}
CAPI setPhaseOffsetAmbientCoef(const dbl c1,const dbl c2)         {return pCalsBase->setPhaseOffsetAmbientCoef(c1,c2);}
CAPI getPhaseOffsetVGAcoef(const uw vga,dbl* c1,dbl* c2)          {return pCalsBase->getPhaseOffsetVGAcoef(vga,*c1,*c1);}
CAPI setPhaseOffsetVGAcoef(const uw vga,const dbl c1,const dbl c2){return pCalsBase->setPhaseOffsetVGAcoef(vga,c1,c2);}

//lightSampleStatusRegisters
CAPI getDistance(dbl* c1)                   {return pCalsBase->lightSampleStatus->getDistance(*c1);}




CAPI cGetError(ul e,char* m)  {return pCalsBase->getError(e,m);}
CAPI cGetStats(uw c,double *m, double *s) {return pCalsBase->getStats(c,*m,*s);}

CAPI cWriteField(uw addr,uc shift,uc mask,uc data) {return pCalsBase->m_pIO->write(addr,shift,mask,data);}
CAPI cReadField(uw addr,uc shift,uc mask,uc* data) {return pCalsBase->m_pIO->read(addr,shift,mask,*data);}
CAPI cWriteByte(uw addr,uc data) {return pCalsBase->m_pIO->write(addr,data);}
CAPI cReadByte(uw addr,uc* data) {return pCalsBase->m_pIO->read(addr,*data);}
CAPI cWriteWord(uw addr,uw data) {return pCalsBase->m_pIO->write(addr,data);}
CAPI cReadWord(uw addr,uw* data) {return pCalsBase->m_pIO->read(addr,*data);}


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

#include "..\autoGen.cpp\cApi.cpp"