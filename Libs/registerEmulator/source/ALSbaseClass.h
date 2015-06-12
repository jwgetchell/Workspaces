/*
 *  ALSbaseClass.h - Linux kernel module for
 * 	Intersil ambient light & proximity sensors
 *
 *  Copyright (c) 2010 Jim Getchell <Jim.Getchell@yahoo.com>
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */
#pragma once

#include "alsPrxTypes.h"
#include <time.h>

        // ___________
        // Error Codes
        // ___________

namespace alsEc{
	const uw ok=0;
	const uw notImplemented=1; // base class default stub
	const uw illegalChannel=2; // c > m_Nchannels
	const uw illegalValue=  3; // v > m_reg->pFunc->m_mask
	const uw usbError=      4; // bus failure 
	const uw driverError=   5; // everything else
}

namespace alsType{
	const uw als=0;
	const uw ir= 1;
	const uw prx=2;
}

namespace callBackCmd {
	const ul wByte=0;
	const ul rByte=1;
	const ul wWord=2;
	const ul rWord=3;
	const ul wI2cAddr=4;
};

namespace regIdx{
	const uw cmpThHi   =1;
	const uw cmpThLo   =2;
	const uw cmpInSel  =3;
	const uw cmpRsSel  =4;
	const uw cmpPersist=5;
	const uw cmpEn     =6;

	const uw cmpInt    =7;// cmpSts
	const uw cmpLvl    =8;

	const uw intLgc    =9;
	const uw intNltch  =10;
	const uw intType   =11;

	const uw distance  =12;
};

class CalsBase
{
public:
    CalsBase();
    virtual ~CalsBase();

	// device description
    uw m_Nreg;     
    uw m_Nchannels;
	uw m_partNumber;
	uw m_ic2Addr;
	uw m_deviceBaseAddr;

	class Cfield{
	public:
		Cfield();
		uw m_addr;
		uw m_mask;
		uw m_shift;
		uw m_imask;
		uw m_value;
	};
	class Cfunction{
	public:
		Cfunction(uw*);
		Cfield *m_cmpThHi;
		Cfield *m_cmpThLo;
		Cfield *m_cmpInSel;
		Cfield *m_cmpRsSel;
		Cfield *m_cmpPersist;
		Cfield *m_cmpEn;

		Cfield *m_cmpInt;
		Cfield *m_cmpLvl;

		Cfield *m_intLgc;
		Cfield *m_intNltch;
		Cfield *m_intType;

		Cfield *m_distance;
	}*m_reg;

	uc m_regmap[defaultRegMapSize];

	uw* m_regTable;

	dbl* m_data;
	ul   m_dataSize;
	ul   m_dataDec;
	ul   m_dataIdx;

    t_status getError(uw e,char* msg);

	virtual t_status drvApi  (const ul,const ul,uw&);
	virtual t_status simApi  (const ul,const ul,uw&);
	virtual t_status setData (const ul,dbl&);
};
