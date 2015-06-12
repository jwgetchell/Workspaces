/*
 *  ISL29011.cpp - Linux kernel module for
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
#include "ISL29011.h"
#include "alsPrxI2cIo.h"

#ifdef _WINDOWS
	#pragma warning (disable:4100) // unreferenced formal parameter
	#pragma warning (disable:4706) // assignment within conditional expression
	#pragma warning (disable:4996) // allow strcpy
#endif

using namespace alsEc;

Cisl29011::Cisl29011()
:m_ProxAmbRej(0)
{
	m_Nchannels=1;
	m_partNumber=29011;
	m_partFamily=m_partNumber;
	m_inputSelectN=0;
	m_runMode=0;
	m_cmdMask=0x0FE0;// set fields controlled by state machine
	m_cmdMask=0x03E0;// range,mode
}

Cisl29011::~Cisl29011()
{
}

t_status
Cisl29011::preStateIntMask(const uw chan,CstateMachine* state)
// called prior to changing input to prevent int "flicker" during stream change
{
	t_status status=alsEc::ok;
	uw intFlag;

	if (chan>1)
		return alsEc::illegalChannel;

	if ((status=setEnable(chan,0)))
		return status;

	if ((status=getIntFlag(chan,intFlag)))// clear int after disable
		return status;

	if ((status=setThreshLo(chan,state->m_state->m_maskL)))
		return status;
	if ((status=setThreshHi(chan,state->m_state->m_maskH)))
		return status;

	return status;
}

t_status
Cisl29011::initAlsStateMachine()
{
	t_status status=alsEc::ok;
	uw chan=0;
	dbl maskL=0.0,maskH=0.0;

	CstateMachine::Cstate tbl[]={
#if 1
		{0,0,    0.0,   10.5,0,0,0,0,&m_prxState},// Reference Manual Example
		{1,0,    9.5,  105.0,0,0,0,0,&m_prxState},
		{2,0,   95.0, 1050.0,0,0,0,0,&m_prxState},
		{3,0,  950.0, 3800.0,0,0,0,0,&m_prxState},
		{3,0, 3600.0,10500.0,0,0,0,0,&m_prxState},
		{4,0, 9500.0,15200.0,0,0,0,0,&m_prxState},
		{4,0,14400.0,99999.9,0,0,6,0,&m_prxState}
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

	m_alsState->m_cycles=2;
	m_alsState->setMask(m_cmdMask);
	setInputSelect(chan,alsType::als);

	setIntPersist(chan,0);
	setEnable(0,1);
	setRunMode(1);
	setRange(chan,0);
	setResolution(0);

	setProxAmbRej(1);
	setIrdr(3);
	setIrdrFreq(0);

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
error:return driverError;
}

t_status
Cisl29011::initProximityStateMachine()
{
	t_status status=alsEc::ok;
	uw chan=0,res=1,fsL,fsH;

	CstateMachine::Cstate tbl[]={
#if 0
		{0,0, 0.1/64.0,0.80/64.0,0,0,0,0,&m_prxState},// prox only auto range
		{1,0, 0.1/16.0,0.80/16.0,0,0,0,0,&m_prxState},
		{2,0, 0.1/4.0 ,0.80/4.0 ,0,0,0,0,&m_prxState},
		{3,0, 0.1     ,1.0      ,0,0,0,0,&m_prxState}
#else
		{0,0, 0.1/64.0,0.85/64.0,0,0,0,0,&m_alsState},// auto range
		{1,0, 0.2/16.0,0.85/16.0,0,0,0,0,&m_alsState},
		{2,0, 0.2/4.0 ,0.85/4.0 ,0,0,0,0,&m_alsState},
		{3,0, 0.2     ,1.0      ,0,0,0,0,&m_alsState}
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
	m_prxState->setMask(m_cmdMask);
	setInputSelect(chan,alsType::prx);

	setIntPersist(chan,0);
	setEnable(chan,1);
	setRunMode(1);
	setRange(chan,0);
	setResolution(res);

	setProxAmbRej(1);
	setIrdr(3);
	setIrdrFreq(0);

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

		switch (res)
		{
		case 0:fsL=0x8000;fsH=0x7FFF;break;
		case 1:fsL=0xF800;fsH=0x07FF;break;
		}
		m_prxState->m_state[i].m_maskL=fsL;
		m_prxState->m_state[i].m_maskH=fsH;

		//if (m_prxState->m_state[i].m_tL <= 0.0)
		//	m_pDataStats[chan]->getReal(0x0000,m_prxState->m_state[i].m_tL);

		//if (m_prxState->m_state[i].m_tH >= 1.0)
		//	m_pDataStats[chan]->getReal(0x0FFF,m_prxState->m_state[i].m_tH);

		m_prxState->m_state[i].m_cmd= m_regmap[0] | (m_regmap[1] << 8);
	}

	return status;
initProximityStateMachineError:return driverError;
}

t_status
Cisl29011::initIrStateMachine()
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
	m_irState->setMask(m_cmdMask);

	setInputSelect(m_chan,alsType::ir);
	setEnable(m_chan,1);
	setRunMode(1);
	setRange(m_chan,3);

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
Cisl29011::initRegisters()
{
	static uw regTable[]={0 // reserved for size (see below)
		// function       chan,addr,shift,mask (post shift)
	/*00*/	,regIdx::enable      ,0,0x00,5,0x0007 // uses mode off for disable, enable is last on
	/*01*/	,regIdx::intFlag     ,0,0x00,2,0x0001
	/*02*/	,regIdx::intPersist  ,0,0x00,0,0x0003
	/*03*/	,regIdx::data        ,0,0x02,0,0xFFFF // base for 2 bytes
	/*04*/	,regIdx::threshLo    ,0,0x04,0,0xFFFF // base for 2 bytes
	/*05*/	,regIdx::threshHi    ,0,0x06,0,0xFFFF // base for 2 bytes
	/*06*/	,regIdx::inputSelect ,0,0x00,5,0x0003
	/*07*/	,regIdx::range       ,0,0x01,0,0x0003
	/*08*/	,regIdx::resolution  ,0,0x01,2,0x0003
		// per device                    
	/*09*/	,regIdx::irdr        ,0,0x01,4,0x0003
	/*10*/	,regIdx::runMode     ,0,0x00,7,0x0001
	/*11*/	,regIdx::irdrFreq    ,0,0x01,6,0x0001
	/*12*/	,regIdx::proxAmbRej  ,0,0x01,7,0x0001
		};

	regTable[0]=sizeof(regTable)/sizeof(regTable[0])-1;
	m_regTable=(uw*)regTable;

    m_reg=new CfunctionList(m_regTable);

	m_reg->m_intFlag[0].m_isVolatile=1;
	m_reg->m_data[0].m_isVolatile=1;

	CalsBase::initRegisters();

	uw v;

	PrintTrace("Cisl29011::initRegisters - Pair of NV dummy reads");
	getInputSelect(0,v); // dummy to set m_inputSelectN
	getRunMode(v);       // dummy to set m_runMode

	setPdataStats();// set initial pointer

	return ok;
}

t_status
Cisl29011::initCalibration()
{
	uw mode,res,rng,addr;
	dbl m;

	class Cdb{public:dbl m;dbl b;} db[128];

	for (mode=0;mode<8;mode++)
	{
		for (res=0;res<4;res++)
		{
			for (rng=0;rng<4;rng++)
			{
				addr = mode<<4 | res<<2 | rng;

				switch (mode & 3)
				{
				case alsType::als+1:// ALS					
					m=(dbl)m_rangeList[rng]/(dbl)m_resolutionList[res];
					break;
				case alsType::prx+1:// Proximity (JWG:AMBREJ ONLY)					
					m=2.0/(dbl)m_resolutionList[res]/((dbl)(64>>(2*rng)));
					m_dataStats[addr].setOffset(-1.0/((dbl)(64>>(2*rng))));
					//m=1.0;m_dataStats[addr].setOffset(-32768.0);
					break;
				default:
					m=1.0/(dbl)m_resolutionList[res];
				}

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
Cisl29011::resetDevice()
{
	PrintTrace("Cisl29011::resetDevice");

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

	// _____
	// Range
	// =====

t_status
Cisl29011::initRange()
{
	static uw rng[]={1000  // ______________________
			        ,4000  // Define range list here
			        ,16000 // ======================
			        ,64000
			        };
	m_Nrange=sizeof(rng)/sizeof(rng[0]);
	m_rangeList=rng;
	return ok;
}

t_status 
Cisl29011::setRange(const uw c,const uw r)
{
	t_status status=ok;

        if (c<m_Nchannels)
        {
			if (r<m_Nrange)
			{
				if (c)
					return notImplemented;
				else
				{
				if (ok==(status=m_pIO->write(&m_reg->m_range[c],r)))
				{
					m_rangeN=r;
					return setPdataStats(c);
				}
				return status;
				}
			}
			else
				return illegalValue;
        }
        else
        {
			return illegalChannel;
        }
}

	// ___________
	// InputSelect
	// ===========

t_status
Cisl29011::initInputSelect()
{
	static const char* inputSelect[]={"ALS " // ____________
		                       ,"IR  "       // Input Select
		                       ,"Prox"       // ============
	                           };

	m_NinputSelect=sizeof(inputSelect)/sizeof(inputSelect[0]);
	m_inputSelectList=(char**)inputSelect;
	return ok;
}

t_status
Cisl29011::setInputSelect(const uw c,const uw v)
{
	t_status status;

	if (!c) // must be 1st channel
	{
		//if (v<m_reg->m_inputSelect[c].m_mask)
		if (v<m_NinputSelect)
		{
			if (ok==(status=m_pIO->write(&m_reg->m_inputSelect[c],v+1)))
			{
				m_inputSelectN=v+1;// zero based input -> one based output
				return setPdataStats(0);
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

t_status
Cisl29011::getInputSelect(const uw c,uw& v)
{
	t_status status;

	if (!c) // must be 1st channel
	{
		status=m_pIO->read(&m_reg->m_inputSelect[c],v);
		m_inputSelectN=v;

		if (v)
			v--;// zero based input -> one based output
		else
			m_inputSelectN=1;

		return status;
	}
	else 
		return illegalChannel;
}

	// __________
	// Resolution
	// ==========

t_status
Cisl29011::initResolution()
{
	static uw res[]={65535 // _______________
			        ,4095  // Resolution list
			        ,255   // ===============
			        ,15
			        };
	m_Nresolution=sizeof(res)/sizeof(res[0]);
	m_resolutionList=res;
	return ok;
}

t_status
Cisl29011::getNresolution(const ul c,ul& v)
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
Cisl29011::getResolutionList(const ul c,ul* v)
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

t_status
Cisl29011::setResolution(const uw v)
{
	return setResolution(0,v);
}
t_status
Cisl29011::setResolution(const uw c,const uw v)
{
	t_status status;

	if (c<m_Nchannels)
	{
		if (ok==(status=m_pIO->write(&m_reg->m_resolution[0],v)))
		{
			m_resolutionN=v;
			return setPdataStats(0);
		}

		return status;
	}
	else
		return illegalChannel;
}
t_status
Cisl29011::getResolution(uw& v)
{
	return getResolution(0,v);
}
t_status
Cisl29011::getResolution(const uw c,uw& v)
{
	if (c<m_Nchannels)
	{
		t_status status = m_pIO->read(&m_reg->m_resolution[0],v);
		m_resolutionN=v;
		return status;
	}
	else
		return illegalChannel;
}

	// ____
	// Irdr
	// ====

t_status
Cisl29011::initIrdr()
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
Cisl29011::setEnable(const uw c,const uw v)
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
Cisl29011::getEnable(const uw c,uw& e)
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

	// _______
	// RunMode
	// =======

t_status
Cisl29011::setRunMode(const uw v)
{
	t_status status;

	if (ok==(status=m_pIO->write(m_reg->m_runMode,v)))
	{
		m_runMode=v;
		return setPdataStats();
	}

	return status;
}

t_status
Cisl29011::getRunMode(uw& v)
{
	t_status status=m_pIO->read(m_reg->m_runMode,v);
	m_runMode=v;
	return status;
}

	// ________
	// IrdrFreq
	// ========

t_status
Cisl29011::setIrdrFreq(const uw v)
{
	return m_pIO->write(m_reg->m_irdrFreq,v);
}

t_status
Cisl29011::getIrdrFreq(uw& v)
{
	return m_pIO->read(m_reg->m_irdrFreq,v);
}

	// __________
	// ProxAmbRej
	// ==========

t_status
Cisl29011::setProxAmbRej(const uw v)
{
	if (v>m_reg->m_proxAmbRej->m_mask)
		return illegalValue;
	else
	{
		t_status status=m_pIO->write(m_reg->m_proxAmbRej,m_ProxAmbRej=v);
		return status;
	}
}

t_status
Cisl29011::getProxAmbRej(uw& v)
{
	t_status status=m_pIO->read(m_reg->m_proxAmbRej,v);
	m_ProxAmbRej=v;
	return status;
}

t_status
Cisl29011::getThreshHi(const uw c,uw& m)
{
	uw res=0;getResolution(res);
	if (c<m_Nchannels)
	{
		t_status status=m_pIO->read(&m_reg->m_threshHi[c],m);
		//if (!res)
			_2sComp(m);// for proximity logic "fix"
		return status;
	}
	else
		return illegalChannel;
}

t_status
Cisl29011::setThreshHi(const uw c,const uw m)
{
	uw res=0;getResolution(res);

	if (c<m_Nchannels)

		if (m>m_reg->m_threshHi[c].m_mask)
			return illegalValue;
		else
		{
			ul v=m;
			//if (!res)
				_2sComp(v);// for proximity logic "fix"
			return m_pIO->write(&m_reg->m_threshHi[c],v);
		}

	else
		return illegalChannel;
}

t_status
Cisl29011::getThreshLo(const uw c,uw& m)
{
	uw res=0;getResolution(res);
	if (c<m_Nchannels)
	{
		t_status status=m_pIO->read(&m_reg->m_threshLo[c],m);
		//if (!res)
			_2sComp(m);// for proximity logic "fix"
		return status;
	}
	else
		return illegalChannel;
}

t_status
Cisl29011::setThreshLo(const uw c,const uw m)
{
	uw res=0;getResolution(res);
	if (c<m_Nchannels)

		if (m>m_reg->m_threshLo[c].m_mask)
			return illegalValue;
		else
		{
			ul v=m;
			//if (!res)
				_2sComp(v);// for proximity logic "fix"
			return m_pIO->write(&m_reg->m_threshLo[c],v);
		}

	else
		return illegalChannel;
}

	// ____
	// Data
	// ====

t_status
Cisl29011::_2sComp(uw& data)
{
	uw sign,wordmask;

	if ((m_regmap[0]>>5 & 3)==3)// proximity
		if ((m_regmap[1]>>7 & 1)==1)// 2's comp (Scheme1)
		{
			uw msb = (1 << (15 - 4*(m_regmap[1]>>2 & 3)));
			data ^= msb;
			sign=data & msb;
			wordmask=(msb<<1)-1;
			if (sign)
			{
				data |= (~wordmask & wordmask);// upper bits to 1's
			}
			else
			{
				data &= wordmask;
			}
		}
		
	return ok;
}

t_status
Cisl29011::getData(uw c,uw &data)
{
	t_status status;
	uw datain,msb;

	if (c<m_Nchannels)
	{
		if ((status=m_pIO->read(&m_reg->m_data[c],data)))
			return status;

		datain=data;
		_2sComp(data); // invert MSB if proximity
		msb=datain ^ data;
		if (msb) data &= ((msb<<1)-1);

		m_lastTime=clock();

		return m_pDataStats[0]->setData(data);
	}
	else
		return illegalChannel;
}

t_status
Cisl29011::setMPAsize(const ul c,const ul s)
{
	return setMPAsize(s);
}

t_status
Cisl29011::setMPAsize(const ul s)
{
	ul addr=((m_regmap[0] >> 1) & 0x70)
		   |((m_regmap[1] >> 0) & 0x0F);

	return m_dataStats[addr].setMpaSize(s);
}

t_status
Cisl29011::setPdataStats(const uw c)
{
	ul addr=((m_regmap[0] >> 1) & 0x70)
		   |((m_regmap[1] >> 0) & 0x0F);

	m_pDataStats[c]=&m_dataStats[addr];

	return ok;
}

t_status
Cisl29011::setPdataStats()
{
	return setPdataStats(0);
}

t_status
Cisl29011::measureConversionTime(uw& alsConversionTime)
{
	setRunMode(1);
	return CalsBase::measureConversionTime(alsConversionTime);
}