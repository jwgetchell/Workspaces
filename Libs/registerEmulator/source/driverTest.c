// driverTest.c : Defines the entry point for the console application.
//

#include "stdafx.h"
#include <string.h>
#include <stdio.h>
#include <time.h>

#include "../source/cApi.h"

#define callBackOk 71077345

#include "emulator.h"
static uc reg[32];

#ifdef  _WIN32
	#include <conio.h>
	#pragma warning (disable:4996) // allow getch
#endif

extern void cApi(uw);

// I/O interface
#if ( _WINDOWS || _WIN32 )
	#include <windows.h>
	ul __stdcall drvApi(ul cmd,ul addr, ul* data){
#else
	//typedef unsigned char uc;
	ul drvApi(ul cmd,ul addr, ul* data){
#endif

	//static uc reg[32];
	static uc initDone=0;

	if (!initDone)
	{
		memset(reg,0,sizeof(reg));
		initDone=1;
	}

	emulator(cmd,addr,data,reg);

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

int main(int argc, char* argv[])
{
	char drvList[1024];
	ul dLp=0,i=0;
	uw status;

	ul dev,nDev;
	ul data=0;
	clock_t startTime=clock(),lastTime=0,thisTime=0;
	double ir,lux,proximity;
	double lIr=-1.0,lLux=-1.0,lProximity=-1.0;
	char msg[1024];

	//printf("%lf\n",sqrt(3));
//goto start11;
	//================================= 
	printf("Testing error Checking:\n");
	//================================= 

	cSetDrvApi(&drvApi);
	cGetNdevice(&nDev);
	cGetDeviceList(drvList);

	cPrintTrace("HW setup done");

	for (dev=0;dev<nDev;dev++)
	{
		cSetDevice(dev);

		sprintf(msg,"devN=%ld:%s regression test ",dev,&drvList[dLp]);
		cPrintTrace(msg);

		printf("%s ",msg);

		dLp+=(strlen(&drvList[dLp])+1);

		if (cTest(1))
			printf("FAILS\n");
		else
			printf("passed\n");

		cPrintTrace("regression test DONE");

//goto start11;
	}


//goto done;
start11:
	//================================================
	printf("\nTesting State Machine devN=%d\n",dev=0);
	//================================================
	// 29011
	cApi(dev);

	// setup "emulator"
	emulator(eEnable,eDev,29011,reg);
	data=0xFFFF;
	emulator(eEnable,dAls,&data,reg);
	emulator(eEnable,dIr,&data,reg);
	data=0x7FFF;
	emulator(eEnable,dPrx,&data,reg);
	lastTime=thisTime=clock();

	for (i=0;i<50;i++)
	{
		if ((status=cGetLux(&lux)))
			printf ("ERROR returned from cGetLux=%d\n",status);
#if _WIN32
		Sleep(34);
#endif
		if ((status=cGetProximity(&proximity)))
			printf ("ERROR returned from cGetProximity=%d\n",status);
#if _WIN32
		Sleep(34);
#endif
		if ((status=cGetIR(&ir)))
			printf ("ERROR returned from cGetIR=%d\n",status);
#if _WIN32
		Sleep(34);
#endif

		if (((lLux)!=(lux)) || ((lProximity)!=(proximity)) || ((lIr)!=(ir)))
		{
			thisTime=clock();
			sprintf(msg,"i:%2d t=%3.2f dt=%3.2f lux=%07.1f proximity=%06.1fm ir=%4.1fm",
			i,(thisTime-startTime)/1000.0,(thisTime-lastTime)/1000.0
			,lux,proximity*1000.0,ir);
			printf("%s\n",msg);
			cPrintTrace(msg);
			lastTime=thisTime;
		}
		lLux=lux;lProximity=proximity;lIr=ir;

		if (( 64000.0==lux) && (1.0==proximity) && (0.0==ir))
			break;
	}
//goto done;
start28:
	//================================================
	printf("\nTesting State Machine devN=%d\n",dev=4);
	//================================================
	// 29028
	cApi(dev);

	emulator(eEnable,eDev,29028,reg);
	data=0x0FFF;
	emulator(eEnable,dAls,&data,reg);
	emulator(eEnable,dIr,&data,reg);
	data=0x00FF;
	emulator(eEnable,dPrx,&data,reg);
	lastTime=thisTime=clock();

	lIr=-1.0,lLux=-1.0,lProximity=-1.0;
	for (i=0;i<50;i++)
	{
		cGetLux(&lux);
		Sleep(34);
		cGetProximity(&proximity);
		Sleep(34);
		cGetIR(&ir);
		Sleep(34);
		if (((lLux)!=(lux)) || ((lProximity)!=(proximity)) || ((lIr)!=(ir)))
		{
			thisTime=clock();
			sprintf(msg,"i:%2d t=%3.2f dt=%3.2f lux=%07.1f proximity=%06.1fm ir=%4.1fm",
			i,(thisTime-startTime)/1000.0,(thisTime-lastTime)/1000.0
			,lux,proximity*1000.0,ir);
			printf("%s\n",msg);
			cPrintTrace(msg);
			lastTime=thisTime;
		}
		lLux=lux;lProximity=proximity;lIr=ir;
		if (( 2000.0==lux) && (1.0==proximity) && (0.0==ir))
			break;
	}

done:
	printf("elapse time=%ld\n",clock()-startTime);
	{
	char bell[2]="";bell[0]=7;
	printf("\a%s",bell);
	}

#ifdef  _WIN32
	printf("[CR] to exit");
	_getch();
#endif

	return 0;
}

#define at(x) if (expect!=(status=x)) goto error

void cApi(uw dev)
{
	uw c=0,iVal=0,iList[8];
	dbl dVal=0,dVal0=0,dVal1=0;
	char cList[1024];
	t_status expect=0,status=0;


	at(cSetDevice(dev));
	at(cGetDevice(&iVal));
	at(cGetDeviceList(cList));

	cPrintTrace("==========");
	cPrintTrace("cApi Tests");
	cPrintTrace(&cList[iVal]);
	cPrintTrace("==========");
	//cInitDriver();

	at(cGetData(c,&iVal));

	at(cGetEnable(c,&iVal));
	at(cSetEnable(c,iVal));

	at(cGetError(c,cList));

	at(cGetInputSelect(c,&iVal));
	at(cSetInputSelect(c,iVal));

	at(cGetInputSelectList(c,cList));
	at(cGetIntFlag(c,&iVal));

	expect=1;
		at(cGetIntLogic(&iVal));
		at(cSetIntLogic(iVal));
	expect=0;

	at(cGetIntPersist(c,&iVal));
	at(cSetIntPersist(c,iVal));

	at(cGetIR(&dVal));
	at(cGetIRState(&iVal));

	at(cGetIrdr(&iVal));
	at(cSetIrdr(iVal));

	at(cGetIrdrFreq(&iVal));
	at(cSetIrdrFreq(iVal));

	at(cGetIrdrList(&iList));

	at(cGetLux(&dVal));
	at(cGetLuxState(&iVal));

	at(cGetMPAprimed(c,&iVal));

	at(cGetNchannel(&iVal));
	at(cGetNdevice(&iVal));
	at(cGetNinputSelect(c,&iVal));
	at(cGetNirdr(&iVal));
	at(cGetNrange(c,&iVal));
	at(cGetNresolution(c,&iVal));

	expect=1;
		at(cGetNsleep(&iVal));
	expect=0;

	at(cGetProxAmbRej(&iVal));
	at(cSetProxAmbRej(iVal));

	at(cGetProximity(&dVal));
	at(cGetProximityState(&iVal));

	at(cGetRange(c,&iVal));
	at(cSetRange(c,iVal));

	at(cGetRangeList(c,iList));

	at(cGetResolution(c,&iVal));
	at(cSetResolution(c,iVal));

	at(cGetResolutionList(c,iList));

	at(cGetRunMode(&iVal));
	at(cSetRunMode(iVal));

	expect=1;
		at(cGetSleep(&iVal));
		at(cSetSleep(iVal));

		at(cGetSleepList(iList));
	expect=0;

	at(cGetStats(c,&dVal0,&dVal1));

	at(cGetThreshHi(c,&dVal));
	at(cSetThreshHi(c,dVal));

	at(cGetThreshLo(c,&dVal));
	at(cSetThreshLo(c,dVal));

	at(cPoll(&iVal));
	at(cResetDevice());

	//cSetLux(dVal);
	at(cSetMPAsize(c,iVal=0));

	cPrintTrace("cApi tests Pass");
	return status;// good return
error:cPrintTrace("cApi tests FAIL");
	return status;
}
