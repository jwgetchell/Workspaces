// __________________________
// nasty throw away test code
// ==========================

#include "emulator.h"

typedef unsigned long ul;
typedef ul uw;
typedef unsigned char uc;

void _29011(ul cmd,ul addr, ul* data,uc* reg)
{
	static uw sData[3];
	static uw initDone=0;
	uw inp=0;

	if (!initDone)
	{
		memset(sData,0,sizeof(sData));
		initDone=1;
	}

	if (cmd & eEnable)
	{
		switch(addr)
		{
			case dAls:
			case dIr:
			case dPrx:sData[addr-1]=*data;
		}
	}
	else
	{
		switch (addr)
		{
		case 0x2:
			inp= (reg[0]>>5) & 3;
			if (inp)
			{
				reg[addr+0]=(sData[inp-1] >> 0) & 0xFF;
				reg[addr+1]=(sData[inp-1] >> 8) & 0xFF;
			}
		default:;
		}
	}

}

void _29028(ul cmd,ul addr, ul* data,uc* reg)
{
	static uw sData[3];
	static uw initDone=0;
	uw inp=0;

	if (!initDone)
	{
		memset(sData,0,sizeof(sData));
		initDone=1;
	}

	if (cmd & eEnable)
	{
		switch(addr)
		{
			case dAls:
			case dIr:
			case dPrx:sData[addr-1]=*data;
		}
	}
	else
	{
		switch (addr)
		{
		case 0x8://prx
			reg[addr+0]=(sData[dPrx-1] >> 0) & 0xFF;
			break;
		case 0x9:
			inp= (reg[1]>>0) & 1;
			reg[addr+0]=(sData[inp] >> 0) & 0xFF;
			reg[addr+1]=(sData[inp] >> 8) & 0x0F;
		default:;
		}
	}

}

void emulator(ul cmd,ul addr, ul* data,uc* reg)
{
	static uw dev=0;
	addr &= 0x1F;

	// x11
	if (cmd & eEnable)
	{
		switch(addr)
		{
		case eDev:dev=data;break;
		default:;
		}
	}

	switch (dev)
	{
	case 29028:
		_29028(cmd,addr,data,reg);break;
	case 29011:
	case 29023:
	case 29025:
	case 29033:
		_29011(cmd,addr,data,reg);break;
	default:;
	}
}
