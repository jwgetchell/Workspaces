/*
 *  ISL29033.cpp - Linux kernel module for
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
#include "ISL29033.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#endif

using namespace alsEc;

Cisl29033::Cisl29033()
{
	m_partNumber=29033;
}

Cisl29033::~Cisl29033()
{
}

	// _____
	// Range
	// ¯¯¯¯¯

t_status
Cisl29033::initRange()
{
	static uw rng[]={125  // ______________________
			        ,500  // Define range list here
			        ,2000 // ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
			        ,8000
			        };
	m_Nrange=sizeof(rng)/sizeof(rng[0]);
	m_rangeList=rng;
	return ok;
}

t_status
Cisl29033::initAlsStateMachine()
{
	t_status status=alsEc::ok;
	uw chan=0;
	dbl maskL=0.0,maskH=0.0;

	CstateMachine::Cstate tbl[]={ // last column set to zero: single sequence
		{0,0,   0,   100,0,0,0,0,&m_alsState},
		{1,0,  75,   400,0,0,0,0,&m_alsState},
		{2,0, 300,  1600,0,0,0,0,&m_alsState},
		{3,0,1200,  8000,6,0,0,0,&m_alsState}
	};
	size_t i,tblSz=sizeof(tbl)/sizeof(tbl[0]);

	if (!(m_alsState=new CstateMachine(chan,tblSz,alsType::als,m_stateMachineEnabled)))
		goto initAlsStateMachineError;

	if (!(m_alsState->m_state=new CstateMachine::Cstate[tblSz]))
		goto initAlsStateMachineError;

	if (( m_alsState->m_state!=memcpy(m_alsState->m_state,tbl,sizeof(tbl))))
		goto initAlsStateMachineError;

	m_alsState->m_cycles=3;
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
		case 1:setRange(chan,1);break;
		case 2:setRange(chan,2);break;
		case 3:setRange(chan,3);break;
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
Cisl29033::initIrStateMachine()
{
	t_status status=alsEc::ok;
	uw chan=0;
	dbl maskL=0.0,maskH=0.0;

	CstateMachine::Cstate tbl[]={
#if 1
		{3,0,0.0,1.0,0,0,0,0,&m_alsState},// auto range
#else
		{0,0,0.0      ,0.8/64.0,0,0,0,0,&m_alsState},// auto range
		{1,0,0.15/16.0,0.8/16.0,0,0,0,0,&m_alsState},
		{2,0,0.15/4.0 ,0.8/4.0 ,0,0,0,0,&m_alsState},
		{3,0,0.15     ,1.0      ,0,0,0,0,&m_alsState}
#endif
	};
	size_t i,tblSz=sizeof(tbl)/sizeof(tbl[0]);

	if (!(m_irState=new CstateMachine(chan,tblSz,alsType::ir,m_stateMachineEnabled)))
		goto initIrStateMachineError;

	if (!(m_irState->m_state=new CstateMachine::Cstate[tblSz]))
		goto initIrStateMachineError;

	if (( m_irState->m_state!=memcpy(m_irState->m_state,tbl,sizeof(tbl))))
		goto initIrStateMachineError;

	m_irState->m_cycles=2;
	setInputSelect(chan,alsType::ir);

	setEnable(0,1);
	setRunMode(1);
	setRange(chan,3);
	setResolution(0);

	for (i=0;i<tblSz;i++)
	{
		if (i)
			m_irState->m_state[i].m_lExit=i-1;

		if (i<tblSz-1)
			m_irState->m_state[i].m_hExit=i+1;

		switch(i)
		{
		case 1:setRange(chan,1);break;
		case 2:setRange(chan,2);break;
		case 3:setRange(chan,3);break;
		}
		// threshold masks
		m_pDataStats[0]->getReal(0x0000,maskL);
		m_pDataStats[0]->getReal(0xFFFF,maskH);
		CalsBase::setThreshLo(maskL);
		CalsBase::setThreshHi(maskH);
		CalsBase::getThreshLo(m_alsState->m_state[i].m_maskL);
		CalsBase::getThreshHi(m_alsState->m_state[i].m_maskH);

		if (m_irState->m_state[i].m_tL <= 0.0)
			m_irState->m_state[i].m_tL=maskL;

		if (m_irState->m_state[i].m_tH >= 1.0)
			m_irState->m_state[i].m_tH=maskH;

		m_irState->m_state[i].m_cmd= m_regmap[0] | (m_regmap[1] << 8);
	}

	return status;
initIrStateMachineError:return driverError;
}

