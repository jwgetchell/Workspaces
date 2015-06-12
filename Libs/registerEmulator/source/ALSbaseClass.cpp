/*
 *  ALSbaseClass.cpp - Linux kernel module for
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
#include "ALSbaseClass.h"

using namespace alsEc;

CalsBase::CalsBase()
:m_dataDec(11)
,m_dataIdx(0)
,m_dataSize(0)
,m_data(0)
{
	memset(m_regmap,0,sizeof(m_regmap));
}
CalsBase::~CalsBase()
{
}

CalsBase::Cfield::Cfield()
:m_addr(0),m_mask(0),m_shift(0),m_imask(0),m_value(0)
{
}

CalsBase::Cfunction::Cfunction(uw* regTable)
{
	Cfield* pFunc=NULL;

	m_cmpThHi   = new Cfield[2];
	m_cmpThLo   = new Cfield[2];
	m_cmpInSel  = new Cfield[2];
	m_cmpRsSel  = new Cfield[2];
	m_cmpPersist= new Cfield[2];
	m_cmpEn     = new Cfield[2];

	m_cmpInt    = new Cfield[2];
	m_cmpLvl    = new Cfield[2];

	m_intLgc    = new Cfield;
	m_intNltch  = new Cfield;
	m_intType   = new Cfield;

	m_distance  = new Cfield;

	for (ul i=0;i<regTable[0];i+=5)
	{
		switch (regTable[i+1])
		{
		case regIdx::cmpThHi   :pFunc=&m_cmpThHi   [regTable[i+2]];break;
		case regIdx::cmpThLo   :pFunc=&m_cmpThLo   [regTable[i+2]];break;
		case regIdx::cmpInSel  :pFunc=&m_cmpInSel  [regTable[i+2]];break;
		case regIdx::cmpRsSel  :pFunc=&m_cmpRsSel  [regTable[i+2]];break;
		case regIdx::cmpPersist:pFunc=&m_cmpPersist[regTable[i+2]];break;
		case regIdx::cmpEn     :pFunc=&m_cmpEn     [regTable[i+2]];break;

		case regIdx::cmpInt    :pFunc=&m_cmpInt    [regTable[i+2]];break;
		case regIdx::cmpLvl    :pFunc=&m_cmpLvl    [regTable[i+2]];break;

		case regIdx::intLgc    :pFunc= m_intLgc                   ;break;
		case regIdx::intNltch  :pFunc= m_intNltch                 ;break;
		case regIdx::intType   :pFunc= m_intType                  ;break;

		case regIdx::distance  :pFunc= m_distance                 ;break;

		default:pFunc=NULL;
		}

		if (pFunc)
		{
			pFunc->m_addr= regTable[i+3];
			pFunc->m_shift=regTable[i+4];
			pFunc->m_mask= regTable[i+5];
			pFunc->m_imask=~(pFunc->m_mask << pFunc->m_shift);
		}
	}
	pFunc=NULL;
}

t_status
CalsBase::drvApi      (const ul cmd,const ul addr,uw& data)
{
	ul adr = addr &0xFF;

	switch (cmd)
	{
	case callBackCmd::wWord:m_regmap[adr+1]= (data>>8) & 0xFF;
	case callBackCmd::wByte:m_regmap[adr]  =  data     & 0xFF;       break;
	case callBackCmd::rByte:data=m_regmap[adr];                      break;
	case callBackCmd::rWord:data=(m_regmap[adr+1]<<8)|m_regmap[adr];break;
	default:;
	}

	return simApi(cmd,adr,data);
}

t_status
CalsBase::simApi(const ul cmd,const ul addr,uw& data)
{
	return ok;
}

t_status
CalsBase::setData(const ul c,dbl& data)
{
	m_dataSize=c;
	m_data=&data;
	return ok;
}

