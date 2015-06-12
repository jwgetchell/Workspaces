/*
 *  ISL29028.jdsu.cpp - Linux kernel module for
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
#include "ISL29028.jdsu.h"
#include "alsPrxI2cIo.h"
#include "stateMachine.h"

#ifdef _WINDOWS
#pragma warning (disable:4706) // assignment within conditional expression
#endif

#ifdef _DEBUG
#define new DEBUG_NEW
#endif

using namespace alsEc;

Cjdsu_028::Cjdsu_028()
:m_prox30Ratio(0.08)
{
	m_partNumber=28;
}

Cjdsu_028::~Cjdsu_028()
{
}

t_status
Cjdsu_028::initSleep()
{
	static uw res[]={400 // __________
	                ,100 // Sleep list
					,50  // ==========
					,25
					,12
					,6
					,3
					,0};
	m_Nsleep=sizeof(res)/sizeof(res[0]);
	m_sleepList=res;
	return ok;
}

t_status
Cjdsu_028::getProxIR(dbl& c,uw& iFlag){
	t_status status=ok;
	uw byte,sleep,tl,th;

	// ___________________________
	// Switch to prox30 measurment
	if ((status=m_pIO->write(&m_reg->m_enable[1],0)))// disable proximity
		return status;

	if ((status=m_pIO->write(m_reg->m_test2,0x29)))// unlock test
		return status;

	if ((status=m_pIO->write(m_reg->m_test1,0x30)))// select prox30
		return status;

	if ((status=m_pIO->read(m_reg->m_sleep,sleep)))// get current sleep
		return status;

	if ((status=m_pIO->read(&m_reg->m_threshLo[1],tl)))// get current Tl
		return status;

	if ((status=m_pIO->read(&m_reg->m_threshHi[1],th)))// get current Th
		return status;

	if ((status=m_pIO->write(&m_reg->m_threshLo[1],0x55)))// set prox30 Tl
		return status;

	if ((status=m_pIO->write(&m_reg->m_threshHi[1],0xAA)))// set prox30 Th
		return status;

	if ((status=m_pIO->write(m_reg->m_sleep,7)))// turn sleep off
		return status;

	if ((status=m_pIO->write(&m_reg->m_enable[1],1)))// enable proximity
		return status;

	// ___________
	// measurement
	Sleep(2);

	if ((status=m_pIO->read(&m_reg->m_data[1],byte)))// read "prox30"
		return status;

	c=byte/255.0;// normalize to 1

	if ((status=m_pIO->read(&m_reg->m_intFlag[1],iFlag)))// read INT flag
		return status;

	if (iFlag)
	{
		if ((status=m_pIO->write(&m_reg->m_intFlag[1],0)))// clear INT flag
			return status;
	}

	// ________________________
	// switch back to proximity
	if ((status=m_pIO->write(&m_reg->m_enable[1],0)))// disable proximity
		return status;

	if ((status=m_pIO->write(m_reg->m_sleep,sleep)))// sleep on
		return status;

	if ((status=m_pIO->write(&m_reg->m_threshLo[1],tl)))// reset Tl
		return status;

	if ((status=m_pIO->write(&m_reg->m_threshHi[1],th)))// reset Th
		return status;

	if ((status=m_pIO->write(m_reg->m_test1,0x0)))// deselect prox30
		return status;

	if ((status=m_pIO->write(m_reg->m_test2,0x0)))// lock test
		return status;

	if ((status=m_pIO->write(&m_reg->m_enable[1],1)))// enable proximity
		return status;

	Sleep(2);

	return ok;
}

t_status
Cjdsu_028::getProximity(dbl& c)
{
	t_status status;
	dbl irdetect=0.0;
	uw iFlag;

	if ((status=checkTimer(m_Nchannels-1)))
		return status;

	getProxIR(irdetect,iFlag);
	c=m_prxValue.value*(1.0-irdetect*m_prox30Ratio)+irdetect*m_prox30Ratio;
	return ok;
}

t_status
Cjdsu_028::initAlsStateMachine()
{
	t_status status=alsEc::ok;
	uw chan=0;

	CstateMachine::Cstate tbl[]={
#if 0
		{0,0,    0.0,   10.5,0,0,0,0,&m_alsState},// Reference Manual Example
		{1,0,    9.5,  105.0,0,0,0,0,&m_alsState},
		{2,0,   95.0,  120.0,0,0,0,0,&m_alsState},
		{2,0,  110.0, 1050.0,0,0,0,0,&m_alsState},
		{3,0,  950.0,99999.9,0,0,4,0,&m_alsState}
#else
		{0,0,    0.0,   10.5,0,0,0,0,&m_irState},// Reference Manual Example
		{1,0,    9.5,  105.0,0,0,0,0,&m_irState},
		{2,0,   95.0,  120.0,0,0,0,0,&m_irState},
		{2,0,  110.0, 1050.0,0,0,0,0,&m_irState},
		{3,0,  950.0,99999.9,0,0,4,0,&m_irState}
#endif
	};
	size_t i,tblSz=sizeof(tbl)/sizeof(tbl[0]);

	m_alsState=new CstateMachine(chan,tblSz,alsType::als,m_stateMachineEnabled);
	m_alsState->m_state=new CstateMachine::Cstate[tblSz];
	memcpy(m_alsState->m_state,tbl,sizeof(tbl));

	m_alsState->setMask(m_cmdMask[chan]);

	uw intPersist=0;
	m_alsState->m_cycles=2*(1<<intPersist);
	setIntPersist(chan,intPersist);

	setInputSelect(chan,alsType::als);
	setEnable(chan,1);
	setRange(chan,0);

	for (i=0;i<tblSz;i++)
	{
		if (i)
			m_alsState->m_state[i].m_lExit=i-1;

		if (i<tblSz-1)
			m_alsState->m_state[i].m_hExit=i+1;

		if (i==3)
			setRange(chan,1);

		if (m_alsState->m_state[i].m_tL <= 0.0)
			m_pDataStats[0]->getReal(0x0000,m_alsState->m_state[i].m_tL);

		if (m_alsState->m_state[i].m_tH >= 99999.9)
			m_pDataStats[0]->getReal(0xFFF,m_alsState->m_state[i].m_tH);

		m_alsState->m_state[i].m_cmd= m_regmap[m_cmdBase] | (m_regmap[m_cmdBase+1] << 8);
	}

	return status;
}

t_status
Cjdsu_028::initRange()
{
	t_status result=ok;

	static uw rng[]={125/2  // Define range list here
			        ,1000 // ======================
			        };
	m_Nrange=sizeof(rng)/sizeof(rng[0]);
	m_rangeList=rng;

	return result;
}

t_status
Cjdsu_028::initIrStateMachine()
{
	t_status status=alsEc::ok;
	uw chan=0,tHi=0xFFF,tLo=0x000;
	dbl maskL=0.0,maskH=0.0;

	CstateMachine::Cstate tbl[]={
#if 0
		{0,0,0.00,0.90,0,0,0,0,&m_alsState},
		{0,0,0.10,1.00,0,0,1,0,&m_alsState}
#else
		1,0,0.0,1.0,0,0,0,0,&m_irState,
#endif
	};
	size_t i,tblSz=sizeof(tbl)/sizeof(tbl[0]);

	m_irState=new CstateMachine(chan,tblSz,alsType::ir,m_stateMachineEnabled);
	m_irState->m_state=new CstateMachine::Cstate[tblSz];
	memcpy(m_irState->m_state,tbl,sizeof(tbl));

	m_irState->m_cycles=1;

	setInputSelect(chan,alsType::ir);
	setEnable(chan,1);
	setRange(chan,1);

	for (i=0;i<tblSz;i++)
	{
		if (i==1)
			setRange(chan,1);

		if (tblSz>1)
		{
			if (i)
				m_irState->m_state[i].m_lExit=i-1;

			if (i<tblSz-1)
				m_irState->m_state[i].m_hExit=i+1;
		}
		// threshold masks
#if 0
		m_pDataStats[0]->getReal(0x000,maskL);
		m_pDataStats[0]->getReal(0xFFF,maskH);
		CalsBase::setThreshLo(maskL);
		CalsBase::setThreshHi(maskH);
#else
		CalsBase::setThreshLo(tLo);
		CalsBase::setThreshHi(tHi);
#endif
		CalsBase::getThreshLo(m_alsState->m_state[i].m_maskL);
		CalsBase::getThreshHi(m_alsState->m_state[i].m_maskH);

		if (m_irState->m_state[i].m_tL <= 0.0)
			m_irState->m_state[i].m_tL=maskL;

		if (m_irState->m_state[i].m_tH >= 1.0)
			m_irState->m_state[i].m_tH=maskH;

		m_irState->m_state[i].m_cmd= m_regmap[1] | (m_regmap[2] << 8);
	}

	return status;
}

