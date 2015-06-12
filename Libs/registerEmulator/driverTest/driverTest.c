// driverTest.c : Defines the entry point for the console application.
//

#include "stdafx.h"
#include <string.h>
//#include <conio.h>

#include "../source/cApi.h"

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

int _tmain(int argc, _TCHAR* argv[])
{
	char drvList[1024];
	ul dLp=0;

	ul dev,nDev;
	ul data;
	ul d=1;

	CdrvSetDrvApi(&drvApi);
	CdrvGetNdevice(&nDev);
	CdrvGetDeviceList(drvList);
	
	for (dev=0;dev<nDev;dev++)
	{
		CdrvSetDevice(dev);
		printf("devN=%d:%s regression test ",dev,&drvList[dLp]);
		dLp+=(strlen(&drvList[dLp])+1);

		if (CdrvTest(1))
			printf("FAILS\n");
		else
			printf("passed\n");
	}


	CdrvSetInputSelect(0,0);
	CdrvSetRange(0,1);
	CdrvSetResolution(0,1);
	CdrvSetRunMode(1);
	CdrvSetIntPersist(0,1);
	CdrvSetEnable(0,1);
	CdrvGetData(0,&data);

	getch();

	return 0;
}

