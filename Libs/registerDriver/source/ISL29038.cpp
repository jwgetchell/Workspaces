/*
 *  ISL29038.cpp - Linux kernel module for
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
#include "ISL29038.h"
#include "alsPrxI2cIo.h"
#include "stateMachine.h"

#ifdef _WINDOWS
#pragma warning (disable:4706) // assignment within conditional expression
#endif

#ifdef _DEBUG
#define new DEBUG_NEW
#endif

using namespace alsEc;

Cisl29038::Cisl29038()
:m_prox30Ratio(0.08)
{
	m_Nchannels=2;
	m_partNumber=29038;
	m_partFamily=m_partNumber;
	m_cmdBase=2;
	m_cmdMask[0]=0x0003*0;// ALS State Machine Mask
	m_cmdMask[1]=0x0000;// Proximity 0x60F8 (IRDR control removed)

	setStateMachineEnable(0);
}

Cisl29038::~Cisl29038()
{
}

t_status
Cisl29038::initSleep()
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
Cisl29038::getProxAlrm(uw& alrm)
{
	 return m_pIO->read(m_reg->m_proxAlrm,alrm);
}

t_status
Cisl29038::initAlsStateMachine()
{
	t_status status=alsEc::ok;
	uw chan=0;

	CstateMachine::Cstate tbl[]={
#if 1
		{0,0,    0.0,  105.0,0,0,0,0,&m_alsState},
		{1,0,   95.0,  210.0,0,0,0,0,&m_alsState},
		{2,0,  190.0, 1680.0,0,0,0,0,&m_alsState},
		{3,0, 1520.0, 4000.0,0,0,3,0,&m_alsState}
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

	setEnable(chan,1);

	for (i=0;i<tblSz;i++)
	{
		if (i)
			m_alsState->m_state[i].m_lExit=i-1;

		if (i<tblSz-1)
			m_alsState->m_state[i].m_hExit=i+1;

		setRange(chan,i);

		//if (m_alsState->m_state[i].m_tL <= 0.0)
		//	m_pDataStats[0]->getReal(0x0000,m_alsState->m_state[i].m_tL);

		//if (m_alsState->m_state[i].m_tH >= 99999.9)
		//	m_pDataStats[0]->getReal(0xFFF,m_alsState->m_state[i].m_tH);

		m_alsState->m_state[i].m_cmd= m_regmap[m_cmdBase] | (m_regmap[m_cmdBase+1] << 8);
	}

	return status;
}

t_status
Cisl29038::initIrStateMachine()
{
	t_status status=alsEc::ok;
	uw chan=0,tHi=0xFFF,tLo=0x000;
	dbl maskL=0.0,maskH=0.0;

	CstateMachine::Cstate tbl[]={
#if 1
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

t_status
Cisl29038::initRegisters()
{
	static ul regTable[]={0 // reserved for size (see below)
		// function       chan,addr,shift,mask (post shift)
	      	,regIdx::enable      ,0,0x02,2,0x01 // chan 0 is ALS/IR                        
	      	,regIdx::enable      ,1,0x01,5,0x01 // chan 1 is Proximity                     
	      	,regIdx::intFlag     ,0,0x04,3,0x01                                            
	      	,regIdx::intFlag     ,1,0x04,7,0x01                                            
	      	,regIdx::intPersist  ,0,0x04,1,0x03                                            
	      	,regIdx::intPersist  ,1,0x04,5,0x03                                            
	      	,regIdx::data        ,0,0x0B,0,0xFFFF // base for 2 bytes                      
	      	,regIdx::data        ,1,0x0A,0,0x0FF                                           
	      	,regIdx::threshLo    ,0,0x07,4,0xF0FF // [11:8] addr-1:[7:0]                    
	      	,regIdx::threshLo    ,1,0x05,0,0xFF	 // prox                                   
	      	,regIdx::threshHi    ,0,0x08,0,0xFFF0 // [3:0]  addr-1:[11:8]                   
	      	,regIdx::threshHi    ,1,0x06,0,0xFF	 // prox                                   
                                                                                           
	      	,regIdx::inputSelect ,0,0x02,7,0x01 // DOESN"T HAVE mapping to INT type for now
	      	,regIdx::range       ,0,0x02,0,0x03 // only valid on chan 0                    
		// per device                                                                      
	      	,regIdx::irdr        ,0,0x01,0,0x03                                            
	      	,regIdx::sleep       ,0,0x01,2,0x07                                            
	      	,regIdx::intLogic    ,0,0x04,0,0x01                                            
	      	,regIdx::test1       ,0,0x0E,0,0x30                                            
	      	,regIdx::test2       ,0,0x0F,0,0x29
	    // New
	      	,regIdx::proxIntEnable,0,0x02,7,0x01                                            
	      	,regIdx::proxOffset   ,0,0x02,3,0x0F                                            
	      	,regIdx::irComp       ,0,0x03,0,0x1F                                            
	      	,regIdx::proxIR       ,0,0x0D,1,0x7F                                            
	      	,regIdx::proxAlrm     ,0,0x0D,0,0x01                                            
	      	,regIdx::vddAlrm      ,0,0x10,4,0x01                                            
#if ( _DEBUG || _INCTRIM ) // trim
	      	,regIdx::proxTrim     ,0,0x13,6,0x03                                            
	      	,regIdx::irdrTrim     ,0,0x13,3,0x07                                            
	      	,regIdx::alsTrim      ,0,0x13,0,0x07

			,regIdx::regOtpSel    ,0,0x14,6,0x01
			,regIdx::otpData      ,0,0x14,5,0x01
			,regIdx::fuseWrEn     ,0,0x14,4,0x01
			,regIdx::fuseAddr     ,0,0x14,0,0x0F

			,regIdx::otpDone      ,0,0x12,7,0x01
			,regIdx::irdrDcPulse  ,0,0x12,6,0x01
			,regIdx::golden       ,0,0x12,5,0x01
			,regIdx::optRes       ,0,0x12,3,0x03
			,regIdx::intTest      ,0,0x12,0,0x03
#endif
		};

	regTable[0]=sizeof(regTable)/sizeof(regTable[0])-1;
	m_regTable=(uw*)regTable;

    m_reg=new CfunctionList(m_regTable);

	m_reg->m_intFlag[0].m_isVolatile=1;
	m_reg->m_intFlag[1].m_isVolatile=1;
	m_reg->m_data[0].m_isVolatile=1;
	m_reg->m_data[1].m_isVolatile=1;

	m_reg->m_proxIR->m_isVolatile=1;
	m_reg->m_proxAlrm->m_isVolatile=1;
	m_reg->m_vddAlrm->m_isVolatile=1;
	m_reg->m_otpData->m_isVolatile=1;

	CalsBase::initRegisters();

	setPdataStats(0);// set initial pointer

	return ok;
}

t_status
Cisl29038::getData(const uw c,uw &v)
{
	t_status status;

	if (c<m_Nchannels)
	{
		if ((status=m_pIO->read(&m_reg->m_data[c],v)))
			return status;

		if (!c)
			v= ( (v & 0xFF00) >> 8 ) | ( (v & 0x000F) << 8 );

		m_lastTime=clock();

		if ((status=setPdataStats(c)))
			return status;

		return m_pDataStats[c]->setData(v);
	}
	else
		return illegalChannel;
}

t_status
Cisl29038::initRange()
{
	t_status result=ok;

	static uw rng[]={125 // Define range list here
			        ,250 // ======================
			        ,2000
			        ,4000
			        };
	m_Nrange=sizeof(rng)/sizeof(rng[0]);
	m_rangeList=rng;

	return result;
}

t_status
Cisl29038::initCalibration()
{
	uw c,r,addr;
	dbl m;

	class Cdb{public:dbl m;dbl b;} db[8];

	for (c=0;c<2;c++)
	{
		for (r=0;r<4;r++)
		{
			// channel,input, range
			if (c==0)// ALS/IR
				m=(dbl)m_rangeList[r]/(dbl)m_resolutionList[0];
			else//Proximity (and don't care)
				m=1.0/(dbl)0xFF;

			m_dataStats[c][r].setNominal(m);
			m_dataStats[c][r].setState(addr=c<<2|r);

			m_dataStats[c][r].getNominal(db[addr].m);
			m_dataStats[c][r].getOffset(db[addr].b);
		}
	}

	return ok;
}

t_status
Cisl29038::resetDevice()
{
	PrintTrace("Cisl29038::resetDevice");

	t_status status=ok;

	//uc reset[]={0x00,0x00,0xFF,0x00,0xF0,0xFF,0x00,0x00,0x00},
	//	size=sizeof(reset)/sizeof(reset[0]);

	//if ((status=m_pIO->write(0xE,(uc)0)))
	//	return status;
	//if ((status=m_pIO->write(0xF,(uc)0)))
	//	return status;
	//if ((status=m_pIO->write(0x1,(uc)0)))
	//	return status;

	//clock_t t1=0,t0=clock();
	//while (((t1=clock())-t0)<0.002*CLOCKS_PER_SEC){}

	//for (uw i=0;i<size;i++)
	//{
	//	if ((status=m_pIO->write(i+2,reset[i])))
	//		return status;
	//}

	return status;
}

	// __________
	// IntPersist
	// ==========
t_status
Cisl29038::initIntPersist()
{
	static uw prt[]={1 // ___________________________
			        ,2 // Define intPersist list here
			        ,4 // ===========================
			        ,8
			        };
	m_NintPersist=sizeof(prt)/sizeof(prt[0]);
	m_intPersistList=prt;
	return ok;
}

	// ____
	// Irdr
	// ====

t_status
Cisl29038::initIrdr()
{
	static uw irdr[]={27  // _________
					 ,55  // Irdr list
					 ,110 // =========
					 ,220 
					 };   

	m_Nirdr=sizeof(irdr)/sizeof(irdr[0]);
	m_irdrList=irdr;
	return ok;
}

t_status
Cisl29038::setPdataStats(const ul c)
{
	if (c)
		m_pDataStats[c]=&m_dataStats[c][0];
	else
	{
		m_rangeN=(m_regmap[2]>>0) & 3;
		m_pDataStats[c]=&m_dataStats[c][m_rangeN];
	}

	return ok;
}

t_status
Cisl29038::getIR(dbl& c)
{
	t_status status;
	uw data=0;

	if ((status=m_pIO->read(m_reg->m_proxIR,data)))
		return status;

	c=(dbl)data/(dbl)m_reg->m_proxIR->m_mask;
	return ok;
}

t_status
Cisl29038::getProximity(dbl& c)
{
	//t_status status;
	//uw data=0;

	//if ((status=m_pIO->read(&m_reg->m_data[1],data)))
	//	return status;

	//c=(dbl)data/(dbl)m_reg->m_data[1].m_mask;
	return CalsBase::getProximity(c);
}


	// ________
	// ThreshHi
	// ========

t_status
Cisl29038::setThreshHi(const uw c,const uw v)
{
	uw word;

	if (c<m_Nchannels)
	{
		ul addr,data; 

		switch (c)
		{
		case 0:
			if (v>m_reg->m_threshHi[c].m_mask)
				return illegalValue;
			else
			{
				addr=m_reg->m_threshHi[c].m_addr;
				data  = m_regmap[addr] & 0xFF;
				data |= (m_regmap[addr+1] & 0xFF) << 8;
				data &=  m_reg->m_threshHi[c].m_imask;

				word = ((v & 0x0F00) >> 8)
					 | ((v & 0x00FF) << 8);
				data |= v;

				return m_pIO->write(addr,data);
			}

		case 1:  return m_pIO->write(&m_reg->m_threshHi[c],v);

		default: return driverError;
		}
	}
	else
		return illegalChannel;
}

t_status
Cisl29038::getThreshHi(const uw c,uw& v)
{
	t_status status;

	if (c<m_Nchannels)
	{
		uw addr,data; 

		switch (c)
		{
		case 0:  
			addr=m_reg->m_threshHi[c].m_addr;
			status=m_pIO->read(addr,data);

			v  = ((data & 0xFF00) >> 8)
			   | ((data & 0x000F) << 8);

			return status;
		case 1:
			return m_pIO->read(&m_reg->m_threshHi[c],v);

		default:
			return driverError;
		}
	}
	else
		return illegalChannel;
}

t_status
Cisl29038::setThreshLo(const uw c,const uw v)
{
	uw addr,data,word;

	if (c<m_Nchannels)
		if (c)
		{
			addr=m_reg->m_threshLo[c].m_addr;
			data  = m_regmap[addr] & 0xFF;
			data |= (m_regmap[addr+1] & 0xFF) << 8;
			data &=  m_reg->m_threshHi[c].m_imask;

			word = ((v & 0x0FF0) >>  4)
				 | ((v & 0x000F) << 12);
			data |= v;

			return m_pIO->write(addr,data);
		}
		else
			return m_pIO->write(&m_reg->m_threshLo[c],v);
	else
		return illegalChannel;
}

t_status
Cisl29038::getThreshLo(const uw c,uw& v)
{
	t_status status;
	uw addr,data;

	if (c<m_Nchannels)
		if (c)
		{
			addr=m_reg->m_threshLo[c].m_addr;
			status=m_pIO->read(addr,data);

			v  = ((data & 0xF000) >> 12)
			   | ((data & 0x00FF) <<  4);

			return status;
		}
		else
			return m_pIO->read(&m_reg->m_threshLo[c],v);
	else
		return illegalChannel;
}

	// _____________
	// New functions
	// =============

t_status Cisl29038::setProxIntEnable(const uw  x){	return ok;}
t_status Cisl29038::getProxIntEnable(      uw& x){	return ok;}
t_status Cisl29038::setVddAlrm      (const uw  x){	return ok;}
t_status Cisl29038::getVddAlrm      (      uw& x){	return ok;}

t_status Cisl29038::setProxOffset   (      uw& x){return m_pIO->write(m_reg->m_proxOffset,x);}
t_status Cisl29038::getProxOffset   (      uw& x){return m_pIO->read (m_reg->m_proxOffset,x);}

t_status Cisl29038::setIRcomp       (const uw  x){return m_pIO->write(m_reg->m_irComp,x);}
t_status Cisl29038::getIRcomp       (      uw& x){return m_pIO->read (m_reg->m_irComp,x);}

#if ( _DEBUG || _INCTRIM ) // trim
t_status Cisl29038::setProxTrim      (const uw  x){return m_pIO->write(m_reg->m_proxTrim,x);}
t_status Cisl29038::getProxTrim      (      uw& x){return m_pIO->read (m_reg->m_proxTrim,x);}
t_status Cisl29038::setIrdrTrim      (const uw  x){return m_pIO->write(m_reg->m_irdrTrim,x);}
t_status Cisl29038::getIrdrTrim      (      uw& x){return m_pIO->read (m_reg->m_irdrTrim,x);}
t_status Cisl29038::setAlsTrim       (const uw  x){return m_pIO->write(m_reg->m_alsTrim,x);}
t_status Cisl29038::getAlsTrim       (      uw& x){return m_pIO->read (m_reg->m_alsTrim,x);}

t_status Cisl29038::setRegOtpSel      (const uw  x){return m_pIO->write(m_reg->m_regOtpSel,x);}
t_status Cisl29038::getRegOtpSel      (      uw& x){return m_pIO->read (m_reg->m_regOtpSel,x);}
t_status Cisl29038::setOtpData        (const uw  x){return m_pIO->write(m_reg->m_otpData,x);}
t_status Cisl29038::getOtpData        (      uw& x){return m_pIO->read (m_reg->m_otpData,x);}
t_status Cisl29038::setFuseWrEn       (const uw  x){return m_pIO->write(m_reg->m_fuseWrEn,x);}
t_status Cisl29038::getFuseWrEn       (      uw& x){return m_pIO->read (m_reg->m_fuseWrEn,x);}
t_status Cisl29038::setFuseWrAddr     (const uw  x){return m_pIO->write(m_reg->m_fuseAddr,x);}
t_status Cisl29038::getFuseWrAddr     (      uw& x){return m_pIO->read (m_reg->m_fuseAddr,x);}

t_status Cisl29038::getOptDone        (      uw& x){return m_pIO->read (m_reg->m_otpDone,x);}

t_status Cisl29038::setIrdrDcPulse    (const uw  x){return m_pIO->write(m_reg->m_irdrDcPulse,x);}
t_status Cisl29038::getIrdrDcPulse    (      uw& x){return m_pIO->read (m_reg->m_irdrDcPulse,x);}

t_status Cisl29038::getGolden         (      uw& x){return m_pIO->read (m_reg->m_golden,x);}

t_status Cisl29038::setOtpRes         (const uw  x){return m_pIO->write(m_reg->m_optRes,x);}
t_status Cisl29038::getOtpRes         (      uw& x){return m_pIO->read (m_reg->m_optRes,x);}
t_status Cisl29038::setIntTest        (const uw  x){return m_pIO->write(m_reg->m_intTest,x);}
t_status Cisl29038::getIntTest        (      uw& x){return m_pIO->read (m_reg->m_intTest,x);}
#endif
