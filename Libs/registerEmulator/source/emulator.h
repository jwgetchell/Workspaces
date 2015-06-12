#ifndef _EMULATOR_H
#define _EMULATOR_H

//#include "alsPrxTypes.h"
typedef unsigned long ul;
//typedef ul uw;
typedef unsigned char uc;

extern void emulator(ul,ul, ul*,uc*);

enum {
	//cmd
	eEnable = 0x80000000,
	//addr
	eDev=0,
	dAls=1,
	dIr=2,
	dPrx=3,
	wbyte=0,
	rbyte=1,
	wword=2,
	rword=4
};

#endif