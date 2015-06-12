/*
 *  ISL29200.cpp - Linux kernel module for
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

#include "stdafx.h"
#include <time.h>
#include "ISL29200.h"

#ifdef _WINDOWS
	#pragma warning (disable:4100) // unreferenced formal parameter
	#pragma warning (disable:4706) // assignment within conditional expression
	#pragma warning (disable:4996) // allow strcpy
#endif

using namespace alsEc;

Cisl29200::Cisl29200()
{
	m_partNumber=29200;

	static uw regTable[]={0
	//ID,chan,addr,shift,mask(post shift)
	,regIdx::cmpThHi   ,0,0x58,0,0xFF
	,regIdx::cmpThLo   ,0,0x57,0,0xFF
	,regIdx::cmpInSel  ,0,0x56,1,0x07
	,regIdx::cmpRsSel  ,0,0x56,4,0x0F
	,regIdx::cmpPersist,0,0x59,0,0xFF
	,regIdx::cmpEn     ,0,0x56,0,0x01

	,regIdx::cmpInt    ,0,0x5F,6,0x01
	,regIdx::cmpLvl    ,0,0x5F,0,0x03

	,regIdx::cmpThHi   ,1,0x5C,0,0xFF
	,regIdx::cmpThLo   ,1,0x5B,0,0xFF
	,regIdx::cmpInSel  ,1,0x5A,0,0x07
	,regIdx::cmpRsSel  ,1,0x5A,0,0x0F
	,regIdx::cmpPersist,1,0x5D,0,0xFF
	,regIdx::cmpEn     ,1,0x5A,0,0x01

	,regIdx::cmpInt    ,1,0x5F,7,0x01
	,regIdx::cmpLvl    ,1,0x5F,2,0x03

	,regIdx::intLgc    ,0,0x5E,1,0x01
	,regIdx::intNltch  ,0,0x5E,3,0x01
	,regIdx::intType   ,0,0x5E,6,0x03

	,regIdx::distance  ,0,0x24,0,0xFFFF
	};
	regTable[0]=sizeof(regTable)/sizeof(regTable[0])-1;

	m_regTable=(uw*)regTable;
    m_reg=new Cfunction(m_regTable);	
}

Cisl29200::~Cisl29200()
{
	delete m_reg;
}

t_status
Cisl29200::simApi(const ul cmd,const ul addr,uw& data)
{
	static uc cmpLvl=0,lo=0,hi=0,loCnt=0,hiCnt=0;
	uw word=0;
	ul adr = addr & 0xFF;

	if (!m_dataSize) return ok;

	// read INT
	if ((cmd==callBackCmd::rByte) && (adr==m_reg->m_cmpInt[0].m_addr))
	{
		m_regmap[adr] &= 0x3F;// clear on read
	}

	// data read
	if ((cmd==callBackCmd::rWord) && (adr==m_reg->m_distance->m_addr))
	{
		word=m_reg->m_distance->m_mask*m_data[m_dataIdx];
		m_regmap[adr]  = word     & 0xFF;
		m_regmap[adr+1]=(word>>8) & 0xFF;
		m_dataIdx+=m_dataDec;
		m_dataIdx%=(m_dataSize-1);

		// low threshold
		if (m_regmap[adr+1]<m_regmap[m_reg->m_cmpThLo[0].m_addr])
		{
			m_regmap[m_reg->m_cmpLvl[0].m_addr] &= 0xFE;
			if (lo)
			{
				loCnt++;
				if (loCnt>m_regmap[m_reg->m_cmpPersist[0].m_addr])
				{
					// set interrupt
					m_regmap[m_reg->m_cmpInt[0].m_addr] |= (1 << m_reg->m_cmpInt[0].m_shift);
				}
			}
			lo=1;
		}
		else
		{
			m_regmap[m_reg->m_cmpLvl[0].m_addr] |= 0x01;
			lo=loCnt=0;
		}

		// hi threshold
		if (m_regmap[adr+1]>m_regmap[m_reg->m_cmpThHi[0].m_addr])
		{
			m_regmap[m_reg->m_cmpLvl[0].m_addr] |= 0x02;
			if (hi)
			{
				hiCnt++;
				if (hiCnt>m_regmap[m_reg->m_cmpPersist[0].m_addr])
				{
					// set interrupt
					m_regmap[m_reg->m_cmpInt[0].m_addr] |= (1 << m_reg->m_cmpInt[0].m_shift);
				}
			}
			hi=1;
		}
		else
		{
			m_regmap[m_reg->m_cmpLvl[0].m_addr] &= 0xFD;
			hi=hiCnt=0;
		}
	}

	return ok;
}
