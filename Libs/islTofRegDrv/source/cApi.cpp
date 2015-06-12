#include "resMgr.h"

#ifndef _CPP
	#define _CPP
#endif

#include "ALSbaseClass.h"
#include "alsPrxI2cIo.h"
#include "cApi.h"

DLLAPI CresourceManager resMgr;
DLLAPI CalsBase* pCalsBase=NULL;


CAPI cSetAmbientCoeffs(uw e,dbl c1,dbl c2){	return pCalsBase->setAmbientCoeffs   (e,c1,c2);}
CAPI cGetError(ul e,char* m)  {return pCalsBase->getError(e,m);}

CAPI cGetMPAprimed(uw c,uw* v) {return pCalsBase->getMPAprimed(c,*v);}
CAPI cGetStats(uw c,double *m, double *s) {return pCalsBase->getStats(c,*m,*s);}
CAPI cInitDriver()  {return pCalsBase->initDriver() ;}
CAPI cPrintTrace(char* msg) {return pCalsBase->printTrace(msg);}
CAPI cResetDevice() {return pCalsBase->resetDevice();}
CAPI cSetDrvApi(ul (fpApi *pF)(ul,ul,uw*,ul))  {pCalsBase->setDrvApi(pF);return pCalsBase->initDriver();}
CAPI cGetPartNumber(uw* v){return pCalsBase->getPartNumber(*v);}
CAPI cGetPartFamily(uw* v){return pCalsBase->getPartFamily(*v);}

CAPI cIO(uw cmd,uw addr,uw* data) {return pCalsBase->m_pIO->drvApi(cmd,addr,*data);}
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