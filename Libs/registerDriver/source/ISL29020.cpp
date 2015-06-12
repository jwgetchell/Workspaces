/*
 *  ISL29023.cpp - Linux kernel module for
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
#include "ISL29020.h"
#include "alsPrxI2cIo.h"

#ifdef _WINDOWS
#pragma warning (disable:4100) // unreferenced formal parameter
#endif

#ifdef _DEBUG
#define new DEBUG_NEW
#endif

using namespace alsEc;

Cisl29020::Cisl29020()
{
	m_partNumber=29020;
	m_cmdMask=0xFF;
	m_stateMachineEnabled=false;
}

Cisl29020::~Cisl29020()
{
}

	// _____________
	// initRegisters
	// =============

t_status
Cisl29020::initRegisters()
{
	static ul regTable[]={0 // reserved for size (see below)
		// function       chan,addr,shift,mask (post shift)
	/*00*/	,regIdx::enable      ,0,0x00,7,0x0001
	//*01*/	,regIdx::intFlag     ,0,0x00,2,0x0001
	//*02*/	,regIdx::intPersist  ,0,0x00,0,0x0003
	/*03*/	,regIdx::data        ,0,0x01,0,0xFFFF // base for 2 bytes
	//*04*/	,regIdx::threshLo    ,0,0x04,0,0xFFFF // base for 2 bytes
	//*05*/	,regIdx::threshHi    ,0,0x06,0,0xFFFF // base for 2 bytes
	/*06*/	,regIdx::inputSelect ,0,0x00,5,0x0001
	/*07*/	,regIdx::range       ,0,0x00,0,0x0003
	/*08*/	,regIdx::resolution  ,0,0x00,2,0x0003
	/*10*/	,regIdx::runMode     ,0,0x00,6,0x0001
		};

	regTable[0]=sizeof(regTable)/sizeof(regTable[0])-1;
	m_regTable=(uw*)regTable;

    m_reg=new CfunctionList(m_regTable);

	m_reg->m_data[0].m_isVolatile=1;
	
	return CalsBase::initRegisters();
}

t_status
Cisl29020::initCalibration()
{
	uw mode,res,rng,addr;
	dbl m=0.0;

	class Cdb{public:dbl m;dbl b;} db[64];

	for (mode=0;mode<4;mode++)
	{
		for (res=0;res<4;res++)
		{
			for (rng=0;rng<4;rng++)
			{
				addr = mode<<4 | res<<2 | rng;

				switch (mode & 1)
				{
				case alsType::als:// ALS					
					m=(dbl)m_rangeList[rng]/(dbl)m_resolutionList[res];
					break;
				case alsType::ir:// IR
					m=1.0/(dbl)m_resolutionList[res];
					break;
				default:;
				}

				m_dataStats[addr].setNominal(m);
				m_dataStats[addr].setState(addr);

				m_dataStats[addr].getNominal(db[addr].m);
				m_dataStats[addr].getOffset(db[addr].b);
			}
		}
	}
	return ok;//detectDevice();// JWG Ctime measurement
}

t_status
Cisl29020::setPdataStats(const uw c)
{
	ul addr=((m_regmap[0] >> 1) & 0x30)
		   |((m_regmap[0] >> 0) & 0x0F);

	m_pDataStats[c]=&m_dataStats[addr];

	return ok;
}

	// ______________
	// setInputSelect
	// ==============

t_status
Cisl29020::setInputSelect(const uw c,const uw v)
{
	t_status status;

	if (!c) // must be 1st channel
	{
		if (v<m_NinputSelect)
		{
			if (ok==(status=m_pIO->write(&m_reg->m_inputSelect[c],v)))
			{
				return setPdataStats(c);
			}
			else
				return status;
		}
		else
			return illegalValue;
	}
	else 
		return illegalChannel;
}

	// _________
	// setEnable
	// =========
t_status
Cisl29020::setEnable(const uw c,const uw v)
{
	t_status status;

	if (c<m_Nchannels)
	{
		if (ok==(status=m_pIO->write(&m_reg->m_enable[c], v)))
			return setPdataStats(c);
		return status;
	}
	else
		return illegalChannel;
}

	// ___________
	// resetDevice
	// ===========
t_status
Cisl29020::resetDevice()
{
	PrintTrace("Cisl29020::resetDevice");

	t_status status=ok;

	uc reset[]={0xC0,0xC0,0xC0},
		size=sizeof(reset)/sizeof(reset[0]);

	for (uw i=0;i<size;i++)
	{
		if ((status=m_pIO->write(i,reset[i])))
			return status;
	}

	return status;
}

	// ___________________
	// initAlsStateMachine
	// ===================
t_status
Cisl29020::initAlsStateMachine()
{
	t_status status=alsEc::ok;
	uw chan=0;

	CstateMachine::Cstate tbl[]={
#if 1
		{0,0,    0.0,   10.5,0,0,0,0,&m_alsState},// Reference Manual Example
		{1,0,    9.5,  105.0,0,0,0,0,&m_alsState},
		{2,0,   95.0, 1050.0,0,0,0,0,&m_alsState},
		{3,0,  950.0, 3800.0,0,0,0,0,&m_alsState},
		{3,0, 3600.0,10500.0,0,0,0,0,&m_alsState},
		{4,0, 9500.0,15200.0,0,0,0,0,&m_alsState},
		{4,0,14400.0,99999.9,0,0,6,0,&m_alsState}
#else
		{0,0,    0.0,99999.9,0,0,&m_prxState} // fixed range, masked int
#endif
	};
	size_t i,tblSz=sizeof(tbl)/sizeof(tbl[0]);

	if (!(m_alsState=new CstateMachine(chan,tblSz,alsType::als,m_stateMachineEnabled)))
		goto error;

	if (!(m_alsState->m_state=new CstateMachine::Cstate[tblSz]))
		goto error;

	if (( m_alsState->m_state!=memcpy(m_alsState->m_state,tbl,sizeof(tbl))))
		goto error;

	if (( m_alsState->setMask(m_cmdMask) ))
		goto error;

	m_alsState->m_cycles=1;

	if ((status=setInputSelect(chan,alsType::als)))
		goto error;

	if ((status=setEnable(0,1)))
		goto error;
	if ((status=setRunMode(1)))
		goto error;
	if ((status=setRange(chan,0)))
		goto error;
	if ((status=setResolution(0)))
		goto error;

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

		if (m_alsState->m_state[i].m_tL <= 0.0)
			m_pDataStats[0]->getReal(0x0000,m_alsState->m_state[i].m_tL);

		if (m_alsState->m_state[i].m_tH >= 99999.9)
			m_pDataStats[0]->getReal(0xFFFF,m_alsState->m_state[i].m_tH);

		m_alsState->m_state[i].m_cmd= m_regmap[0] | (m_regmap[1] << 8);
	}

	return status;
error:PrintTrace("Cisl29020::initAlsStateMachine ERROR");
	return driverError;
}

	// _______
	// removed
	// =======

t_status Cisl29020::getThreshHi(const uw c,      uw& v){return CalsBase::getThreshHi(c,v);}
t_status Cisl29020::setThreshHi(const uw c,const uw  v){return CalsBase::setThreshHi(c,v);}
t_status Cisl29020::getThreshLo(const uw c,      uw& v){return CalsBase::getThreshLo(c,v);}
t_status Cisl29020::setThreshLo(const uw c,const uw  v){return CalsBase::setThreshLo(c,v);}

t_status Cisl29020::getIntPersist(const uw c,      uw& v){return CalsBase::getIntPersist(c,v);}
t_status Cisl29020::setIntPersist(const uw c,const uw  v){return CalsBase::setIntPersist(c,v);}

t_status Cisl29020::getIntFlag(const uw c,      uw& v){return CalsBase::getThreshLo(c,v);}
t_status Cisl29020::setIntFlag(const uw c,const uw  v){return CalsBase::setThreshLo(c,v);}

