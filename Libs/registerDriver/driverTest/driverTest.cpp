// driverTest.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"
#include <string.h>
#include <conio.h>

#include "../source/resMgr.h"
#include "../source/cApi.h"

//#include "../../MemLeakDetection/MFCLeakerTest/MFCLeakerTest.h"
//#include "../../MemLeakDetection/MFCLeakerTest/MFCLeakerTestDlg.h"
//#include "../../MemLeakDetection/MFCLeakerTest/MemLeakDetect.h"

#define callBackOk 71077345

#ifdef  _WIN32
#pragma warning (disable:4996) // allow getch
#endif

ul __stdcall drvApi(ul cmd,ul addr, ul* data)
{
	static uc reg[32],initDone=0;

	if (!initDone)
	{
		memset(reg,0,sizeof(reg));
		initDone=1;
	}

	switch (cmd)
	{
	case 0:reg[addr & 0x1F]= *data & 0xFF;break;     //write byte
	case 1:*data = reg[addr & 0x1F];break;           //read  byte
	case 2:reg[addr     & 0x1F]=  *data & 0xFF;      //write word
		   reg[(addr+1) & 0x1F]= (*data >> 8 )& 0xFF;
		   break;
	case 3:*data = reg[addr & 0x1F]                  //read  word
		         | (reg[(addr+1) & 0x1F] << 8);
		   break;
	default:return 1;
	}

	return callBackOk;
}

extern __declspec(dllimport) CresourceManager resMgr;
extern __declspec(dllimport) CalsBase* pCalsBase;

int _tmain(int argc, _TCHAR* argv[])
{
//#ifdef _DEBUG
//	CLeakMemory* pMem;
//	pMem = new CLeakMemory();
//	CMemLeakDetect memLeakDetect;
//#endif

	CalsBase** driver=&pCalsBase;
	char drvList[1024];
	ul dLp=0;

	ul dev,nDev;
	ul data;
	ul d=1;

	//driver=resMgr.getDriver();
	//resMgr.getDriver(&driver);

	(*driver)->setDrvApi(&drvApi);
	resMgr.getNdevice(nDev);
	resMgr.getDeviceList(drvList);
	for (dev=0;dev<nDev;dev++)
	{
		resMgr.setDevice(dev);
		printf("devN=%d:%s regression test ",dev,&drvList[dLp]);
		dLp+=(strlen(&drvList[dLp])+1);

		if ((*driver)->test(1))
			printf("FAILS\n");
		else
			printf("passed\n");
	}

	resMgr.setDevice(0); // 29011

	(*driver)->setInputSelect(0);    // select ALS sensor
	(*driver)->setRange(1);          // 16000 Lux
	(*driver)->setResolution(1);     // 16 bit
	(*driver)->setRunMode(1);        // continuous
	(*driver)->setIntPersist(1);     // persist=4
	(*driver)->setEnable(1);         // enable
	(*driver)->getData(data);        // read ALS data

	printf("check mem usage\n");getch();
	CresourceManager* aryResMgr[5];ul i;
	for (i=0;i<sizeof(aryResMgr)/sizeof(aryResMgr[0]);i++)
	{
		aryResMgr[i]=new CresourceManager;
		aryResMgr[i]->setDevice(0);
		getch();
	}


	return 0;
}

