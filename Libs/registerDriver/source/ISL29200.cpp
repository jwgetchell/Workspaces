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
#include "alsPrxI2cIo.h"

#ifdef _WINDOWS
	#pragma warning (disable:4100) // unreferenced formal parameter
	#pragma warning (disable:4706) // assignment within conditional expression
	#pragma warning (disable:4996) // allow strcpy
#endif

using namespace alsEc;

Cisl29200::Cisl29200()
{
	m_Nchannels=1;
	m_partNumber=29200;
	m_inputSelectN=0;
	m_alsConversionTime=0;
	m_stateMachineEnabled=false;
}

Cisl29200::~Cisl29200()
{
}

t_status
Cisl29200::preStateIntMask(const uw chan,CstateMachine* state)
// called prior to changing input to prevent INT "flicker" during stream change
{
	 return alsEc::ok;
}

t_status
Cisl29200::initAlsStateMachine()
{
	t_status status=alsEc::ok;
	uw chan=0;
	dbl maskL=0.0,maskH=0.0;

	CstateMachine::Cstate tbl[]={
#if 0
		{0,0,    0.0,   10.5,0,0,0,0,&m_prxState},// Reference Manual Example
		{1,0,    9.5,  105.0,0,0,0,0,&m_prxState},
		{2,0,   95.0, 1050.0,0,0,0,0,&m_prxState},
		{3,0,  950.0, 3800.0,0,0,0,0,&m_prxState},
		{3,0, 3600.0,10500.0,0,0,0,0,&m_prxState},
		{4,0, 9500.0,15200.0,0,0,0,0,&m_prxState},
		{4,0,14400.0,99999.9,0,0,6,0,&m_prxState}
#else
		{0,0,    0.0,99999.9,0,0,0,0,&m_alsState} // fixed range, masked int
#endif
	};
	size_t i,tblSz=sizeof(tbl)/sizeof(tbl[0]);

	if (!(m_alsState=new CstateMachine(chan,tblSz,alsType::als,m_stateMachineEnabled)))
		goto error;

	if (!(m_alsState->m_state=new CstateMachine::Cstate[tblSz]))
		goto error;

	if (( m_alsState->m_state!=memcpy(m_alsState->m_state,tbl,sizeof(tbl))))
		goto error;

	m_alsState->m_cycles=2;
	//setInputSelect(chan,alsType::als);

	setIntPersist(chan,0);
	setEnable(0,1);
	//setRunMode(1);
	//setRange(chan,0);
	//setResolution(0);

	//setProxAmbRej(1);
	//setIrdr(3);
	//setIrdrFreq(0);

	for (i=0;i<tblSz;i++)
	{
		if (i)
			m_alsState->m_state[i].m_lExit=i-1;

		if (i<tblSz-1)
			m_alsState->m_state[i].m_hExit=i+1;

		//switch(i)
		//{
		//case 2:setRange(chan,1);break;
		//case 4:setRange(chan,2);break;
		//case 6:setRange(chan,3);break;
		//}
		// threshold masks
		m_pDataStats[0]->getReal(0x00,maskL);
		m_pDataStats[0]->getReal(0xFF,maskH);
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
error:return driverError;
}

t_status
Cisl29200::initProximityStateMachine()
{
	t_status status=alsEc::ok;
	uw chan=0;

	uw fsL=0x00,fsH=0xFF;

	CstateMachine::Cstate tbl[]={
#if 0
		0,0,0.00,0.55,0,0,&m_alsState, // Near - Far ship version
		1,0,0.45,1.00,0,0,&m_alsState,

		{0,0,0.0     ,0.9/64.0,0,0,&m_prxState},// auto range
		{1,0,0.2/16.0,0.9/16.0,0,0,&m_prxState},
		{2,0,0.2/4.0 ,0.9/4.0 ,0,0,&m_prxState},
		{3,0,0.2     ,1.0     ,0,0,&m_prxState}
#else
		{0,0,0.0     ,0.85/64.0,0,0,0,0,&m_alsState},// auto range
		{1,0,0.2/16.0,0.85/16.0,0,0,0,0,&m_alsState},
		{2,0,0.2/4.0 ,0.85/4.0 ,0,0,0,0,&m_alsState},
		{3,0,0.2     ,1.0      ,0,0,0,0,&m_alsState}
#endif
	};
	size_t i,tblSz=sizeof(tbl)/sizeof(tbl[0]);

	if (!(m_prxState=new CstateMachine(chan,tblSz,alsType::prx,m_stateMachineEnabled)))
		goto initProximityStateMachineError;
	if (!(m_prxState->m_state=new CstateMachine::Cstate [tblSz]))
		goto initProximityStateMachineError;
	if ((m_prxState->m_state!=memcpy(m_prxState->m_state,tbl,sizeof(tbl))))
		goto initProximityStateMachineError;

	m_prxState->m_cycles=2;
	//setInputSelect(chan,alsType::prx);

	setIntPersist(chan,0);
	setEnable(chan,1);
	//setRunMode(1);
	//setRange(chan,0);
	//setResolution(res);

	//setProxAmbRej(1);
	//setIrdr(3);
	//setIrdrFreq(0);

	for (i=0;i<tblSz;i++)
	{
		if (tblSz>2) // for autorange testing
			setRange(chan,i);

		if (tblSz>1)
		{
			if (i)
				m_prxState->m_state[i].m_lExit=i-1;

			if (i<tblSz-1)
				m_prxState->m_state[i].m_hExit=i+1;
		}

		m_prxState->m_state[i].m_maskL=fsL;
		m_prxState->m_state[i].m_maskH=fsH;

		if (m_alsState->m_state[i].m_tL <= 0.0)
		{
			CalsBase::setThreshLo(fsL);
			CalsBase::getThreshLo(m_prxState->m_state[i].m_maskL);
		}

		if (m_alsState->m_state[i].m_tH >= 1.0)
		{
			CalsBase::setThreshHi(fsH);
			CalsBase::getThreshHi(m_prxState->m_state[i].m_maskH);
		}

		m_prxState->m_state[i].m_cmd= m_regmap[0] | (m_regmap[1] << 8);
	}

	return status;
initProximityStateMachineError:return driverError;
}

t_status
Cisl29200::initIrStateMachine()
{
	t_status status=alsEc::ok;
	uw m_chan=0;
	//dbl v;uw w;

	CstateMachine::Cstate tbl[]={
#if 1
		//0,0,0.00,1.00,2,0,0,&m_alsState,
		{0,0,0.00,1.00,0,0,0,0,&m_alsState}
#else
		0,0,0.00,0.55,2,0,0,&m_alsState,
		1,0,0.45,1.00,2,0,0,&m_alsState,
#endif
	};
	size_t i,tblSz=sizeof(tbl)/sizeof(tbl[0]);

	m_irState=new CstateMachine(m_chan,tblSz,alsType::ir,m_stateMachineEnabled);
	m_irState->m_state=new CstateMachine::Cstate[tblSz];
	memcpy(m_irState->m_state,tbl,sizeof(tbl));

	m_irState->m_cycles=2;

	//setInputSelect(m_chan,alsType::ir);
	setEnable(m_chan,1);
	//setRunMode(1);
	//setRange(m_chan,3);

	for (i=0;i<tblSz;i++)
	{
		if (tblSz>1)
		{
			if (i)
				m_irState->m_state[i].m_lExit=i-1;

			if (i<tblSz-1)
				m_irState->m_state[i].m_hExit=i+1;
		}
		if (m_irState->m_state[i].m_tL <= 0.0)
			m_pDataStats[0]->getReal(0x0000,m_irState->m_state[i].m_tL);

		if (m_irState->m_state[i].m_tH >= 1.0)
			m_pDataStats[0]->getReal(0xFFFF,m_irState->m_state[i].m_tH);

		m_irState->m_state[i].m_cmd= m_regmap[0] | (m_regmap[1] << 8);
	}

	return status;
}

t_status
Cisl29200::initRegisters()
{
	static uw regTable[]={0 // reserved for size (see below)
		// function       chan,addr,shift,mask (post shift)
		,regIdx::enable      ,0,0x56,0,0x01
		,regIdx::intFlag     ,0,0x5F,7,0x01
		,regIdx::intPersist  ,0,0x59,0,0xFF
		,regIdx::threshLo    ,0,0x57,0,0xFF
		,regIdx::threshHi    ,0,0x58,0,0xFF
		
		,regIdx::data        ,0,0x24,0,0xFFFF
		};

	regTable[0]=sizeof(regTable)/sizeof(regTable[0])-1;
	m_regTable=(uw*)regTable;

    m_reg=new CfunctionList(m_regTable);

	m_reg->m_intFlag[0].m_isVolatile=1;
	m_reg->m_data[0].m_isVolatile=1;

	CalsBase::initRegisters();

	//uw v;

	//PrintTrace("Cisl29200::initRegisters - Pair of NV dummy reads");
	//getInputSelect(0,v); // dummy to set m_inputSelectN
	//getRunMode(v);       // dummy to set m_runMode

	setPdataStats();// set initial pointer

	return ok;
}

t_status
Cisl29200::initCalibration()
{
	m_dataStats[0].setNominal((dbl)m_rangeList[0]/(dbl)m_resolutionList[0]);
	return ok;
}

t_status
Cisl29200::initRange()
{
	static uw rng[]={1};
	m_Nrange=sizeof(rng)/sizeof(rng[0]);
	m_rangeList=rng;
	return ok;
}

t_status
Cisl29200::initResolution()
{
	static uw res[]={255};                   // set to match threshold mask
	m_Nresolution=sizeof(res)/sizeof(res[0]);
	m_resolutionList=res;
	return ok;
}

t_status
Cisl29200::resetDevice()
{
	PrintTrace("Cisl29200::resetDevice");

	t_status status=ok;

	uw reset[]={0x00,0x00,0x00,0x00,0x00,0x00,0xFF,0xFF,0x00},
		size=sizeof(reset)/sizeof(reset[0]);

	for (uw i=0;i<size;i++)
	{
		if ((status=m_pIO->write(i,reset[i])))
			return status;
	}

	return status;
}


	// ___________
	// InputSelect
	// ===========

t_status
Cisl29200::initInputSelect()
{
	static const char* inputSelect[]={"ALS " // ____________
		                       ,"IR  "       // Input Select
		                       ,"Prox"       // ============
	                           };

	m_NinputSelect=sizeof(inputSelect)/sizeof(inputSelect[0]);
	m_inputSelectList=(char**)inputSelect;
	return ok;
}

	// __________
	// Resolution
	// ==========

t_status
Cisl29200::getNresolution(const ul c,ul& v)
{
	if (c<m_Nchannels)
	{
		if (c)
			v=1;
		else
			v=m_Nresolution;
		return ok;
	}
	else
		return illegalChannel;
}

t_status
Cisl29200::getResolutionList(const ul c,ul* v)
{
	if (c<m_Nchannels)
	{
		if (c)
			*v=0;
		else
			memcpy(v,m_resolutionList,m_Nresolution*sizeof(m_resolutionList[0]));
		return ok;
	}
	else
		return illegalChannel;
}

	// ____
	// Irdr
	// ====

t_status
Cisl29200::initIrdr()
{
	static uw irdr[]={12 // _________
					 ,25 // Irdr list
					 ,50 // =========
					 ,100
					 };

	m_Nirdr=sizeof(irdr)/sizeof(irdr[0]);
	m_irdrList=irdr;
	return ok;
}

	// ______
	// Enable
	// ======

t_status
Cisl29200::setEnable(const uw c,const uw v)
{
	t_status status;

	if (c<m_Nchannels)
	{
		if (v>m_reg->m_enable->m_mask)
			return illegalValue;
		else
		{
			if (v)
			{
				if (ok==(status=m_pIO->write(&m_reg->m_enable[c], m_inputSelectN | (m_runMode << 2))))
					return setPdataStats();
				return status;
			}
			else
			{
				if (ok==(status=m_pIO->write(&m_reg->m_enable[c],v)))
					return setPdataStats();
				return status;
			}
		}
	}
	else
		return illegalChannel;
}

t_status
Cisl29200::getEnable(const uw c,uw& e)
{
	t_status status;

	if (c<m_Nchannels)
	{
		status=m_pIO->read(&m_reg->m_enable[c],e);

		if (e)
			e=1;
		else
			e=0;

		return status;
	}
	else
		return illegalChannel;
}

t_status
Cisl29200::getThreshHi(const uw c,uw& m)
{
	if (c<m_Nchannels)
	{
		return m_pIO->read(&m_reg->m_threshHi[c],m);
	}
	else
	{
		return illegalChannel;
	}
}

t_status
Cisl29200::setThreshHi(const uw c,const uw m)
{
	if (c<m_Nchannels)
	{
		return m_pIO->write(&m_reg->m_threshHi[c],m);
	}
	else
	{
		return illegalChannel;
	}
}

t_status
Cisl29200::getThreshLo(const uw c,uw& m)
{
	if (c<m_Nchannels)
	{
		return m_pIO->read(&m_reg->m_threshLo[c],m);
	}
	else
	{
		return illegalChannel;
	}
}

t_status
Cisl29200::setThreshLo(const uw c,const uw m)
{
	if (c<m_Nchannels)
	{
		return m_pIO->write(&m_reg->m_threshLo[c],m);
	}
	else
	{
		return illegalChannel;
	}
}

t_status
Cisl29200::getData(uw c,uw &data)
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

t_status
Cisl29200::setMPAsize(const ul c,const ul s)
{
	return setMPAsize(s);
}

t_status
Cisl29200::setMPAsize(const ul s)
{
	return m_dataStats[0].setMpaSize(s);
}

t_status
Cisl29200::setPdataStats(const uw c)
{
	m_pDataStats[c]=&m_dataStats[0];
	return ok;
}

t_status
Cisl29200::setPdataStats()
{
	return setPdataStats(0);
}

t_status
Cisl29200::measureConversionTime(clock_t& alsConversionTime)
{
	alsConversionTime=1;
	return ok;
}