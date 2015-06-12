/*
 *  ISL29120.cpp - Linux kernel module for
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
#include "ISL29120.h"
#include "alsPrxI2cIo.h"

#ifdef _WINDOWS
#pragma warning (disable:4100) // unreferenced formal parameter
#endif

#ifdef _DEBUG
#define new DEBUG_NEW
#endif

using namespace alsEc;

Cisl29120::Cisl29120()
{
	m_partNumber=29120;
}

Cisl29120::~Cisl29120()
{
}

	// ___________
	// InputSelect
	// ¯¯¯¯¯¯¯¯¯¯¯

t_status
Cisl29120::initInputSelect()
{
	static const char* inputSelect[]={"R " // ____________
                                     ,"B " // Input Select
	                                 ,"G " // ¯¯¯¯¯¯¯¯¯¯¯¯
	                                 };

	m_NinputSelect=sizeof(inputSelect)/sizeof(inputSelect[0]);
	m_inputSelectList=(char**)inputSelect;
	return ok;
}

t_status
Cisl29120::initRegisters()
{
	static ul regTable[]={0 // reserved for size (see below)
		// function       chan,addr,shift,mask (post shift)
	/*00*/	,regIdx::enable      ,0,0x00,5,0x0007 // uses mode off for disable, enable is last on
	/*01*/	,regIdx::data        ,0,0x02,0,0xFFFF // base for 2 bytes
	/*02*/	,regIdx::inputSelect ,0,0x00,5,0x0003
	/*03*/	,regIdx::range       ,0,0x01,0,0x0001
	/*04*/	,regIdx::resolution  ,0,0x01,2,0x0003
		// per device                    
	/*05*/	,regIdx::runMode     ,0,0x00,7,0x0001
		};

	regTable[0]=sizeof(regTable)/sizeof(regTable[0])-1;
	m_regTable=(uw*)regTable;

    m_reg=new CfunctionList(m_regTable);

	m_reg->m_data[0].m_isVolatile=1;

	CalsBase::initRegisters();

	uw v;

	getInputSelect(0,v); // dummy to set m_inputSelectN
	getRunMode(v);       // dummy to set m_runMode

	return ok;
}

	// _____
	// Range
	// =====

t_status
Cisl29120::initRange()
{
	static uw rng[]={1600  // ______________________
			        ,8000 // Define range list here
			        };    // ======================
	m_Nrange=sizeof(rng)/sizeof(rng[0]);
	m_rangeList=rng;
	return ok;
}

	// _______
	// getData
	// =======

t_status
Cisl29120::getData(const uw c,uw &data)
{
	t_status status;

	if (c<m_Nchannels)
	{
		if ((status=m_pIO->read(&m_reg->m_data[c],data)))
			return status;

		m_lastTime=clock();

		return m_pDataStats[0]->setData(data);
	}
	else
		return illegalChannel;
}

	// ___________________
	// initAlsStateMachine
	// ===================

t_status
Cisl29120::initAlsStateMachine()
{
	t_status status=alsEc::ok;
	uw chan=0;
	dbl maskL=0.0,maskH=0.0;

	CstateMachine::Cstate tbl[]={ // last column set to zero: single sequence
		{0,0,    0.0,   10.5,0,0,0,0,&m_alsState},
		{1,0,    9.5,  105.0,0,0,0,0,&m_alsState},
		{2,0,   95.0, 1050.0,0,0,0,0,&m_alsState},
		{3,0,  950.0, 3800.0,0,0,0,0,&m_alsState},
		{3,0, 3600.0,10500.0,0,0,0,0,&m_alsState},
		{4,0, 9500.0,15200.0,0,0,0,0,&m_alsState},
		{4,0,14400.0,99999.9,6,0,0,0,&m_alsState}
	};
	size_t i,tblSz=sizeof(tbl)/sizeof(tbl[0]);

	if (!(m_alsState=new CstateMachine(chan,tblSz,alsType::als,m_stateMachineEnabled)))
		goto initAlsStateMachineError;

	if (!(m_alsState->m_state=new CstateMachine::Cstate[tblSz]))
		goto initAlsStateMachineError;

	if (( m_alsState->m_state!=memcpy(m_alsState->m_state,tbl,sizeof(tbl))))
		goto initAlsStateMachineError;

	m_alsState->m_cycles=2;
	setInputSelect(chan,alsType::als);

	setEnable(0,1);
	setRunMode(1);
	setRange(chan,0);
	setResolution(0);

	for (i=0;i<tblSz;i++)
	{
		if (i)
			m_alsState->m_state[i].m_lExit=i-1;

		if (i<tblSz-1)
			m_alsState->m_state[i].m_hExit=i+1;

		switch(i)
		{
		case 2:setRange(chan,1);break;
		case 4:setRange(chan,2);break;
		case 6:setRange(chan,3);break;
		}
		// threshold masks
		m_pDataStats[0]->getReal(0x0000,maskL);
		m_pDataStats[0]->getReal(0xFFFF,maskH);
		CalsBase::setThreshLo(maskL);
		CalsBase::setThreshHi(maskH);
		CalsBase::getThreshLo(m_alsState->m_state[i].m_maskL);
		CalsBase::getThreshHi(m_alsState->m_state[i].m_maskH);

		if (m_alsState->m_state[i].m_tL <= 0.0)
			m_alsState->m_state[i].m_tL=maskL;

		if (m_alsState->m_state[i].m_tH >= 99999.9)
			m_alsState->m_state[i].m_tH=maskH;

		m_alsState->m_state[i].m_cmd= m_regmap[0] | (m_regmap[1] << 8);
	}

	return status;
initAlsStateMachineError:return driverError;
}


t_status
Cisl29120::initCalibration()
{
	uw mode,res,rng,addr;
	dbl m;

	class Cdb{public:dbl m;dbl b;} db[64];

	for (mode=0;mode<8;mode++)
	{
		for (res=0;res<4;res++)
		{
			for (rng=0;rng<2;rng++)
			{
				addr = mode<<3 | res<<1 | rng;

				m=(dbl)m_rangeList[rng]/(dbl)m_resolutionList[res];

				m_dataStats[addr].setNominal(m);
				m_dataStats[addr].setState(addr);

				m_dataStats[addr].getNominal(db[addr].m);
				m_dataStats[addr].getOffset(db[addr].b);
			}
		}
	}
	return ok;
}

t_status
Cisl29120::setPdataStats(const uw c)
{
	ul addr=((m_regmap[0] >> 2) & 0x38)
		   |((m_regmap[1] >> 1) & 0x06)
		   |((m_regmap[1] >> 0) & 0x01);

	m_pDataStats[c]=&m_dataStats[addr];

	return ok;
}


