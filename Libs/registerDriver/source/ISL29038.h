/*
 *  ISL29038.h - Linux kernel module for
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
#include "ALSbaseClass.h"
#include "ISL29032.h"
#include "avgStats.h"

class Cisl29038 : public Cisl29032
{
public:
	Cisl29038();
	~Cisl29038();

	Cstats  m_dataStats[2][4];// chan, #/ranges

	virtual t_status initSleep();
	virtual t_status initAlsStateMachine();
	virtual t_status initIrStateMachine();
	virtual t_status initIrdr();
	virtual t_status initRange();
	virtual t_status initRegisters();
	virtual t_status initCalibration();
	virtual t_status initIntPersist();
	virtual t_status resetDevice();
	virtual t_status getData(const uw,uw&);
	virtual t_status setPdataStats(const ul c);
	virtual t_status getIR(dbl&);
	virtual t_status getProximity(dbl&);

	virtual t_status getThreshLo(const uw,     uw& );
	virtual t_status setThreshLo(const uw,const uw );
	virtual t_status getThreshHi(const uw,     uw& );
	virtual t_status setThreshHi(const uw,const uw );

	// New Functions
	virtual t_status setProxIntEnable(const uw );
	virtual t_status getProxIntEnable(      uw&);
	virtual t_status setProxOffset   (      uw&);
	virtual t_status getProxOffset   (      uw&);
	virtual t_status setIRcomp       (const uw );
	virtual t_status getIRcomp       (      uw&);
	virtual t_status getProxAlrm     (      uw&);
	virtual t_status setVddAlrm      (const uw );
	virtual t_status getVddAlrm      (      uw&);

#if ( _DEBUG || _INCTRIM ) // trim
		virtual t_status setProxTrim      (const uw );
		virtual t_status getProxTrim      (      uw&);
		virtual t_status setIrdrTrim      (const uw );
		virtual t_status getIrdrTrim      (      uw&);
		virtual t_status setAlsTrim       (const uw );
		virtual t_status getAlsTrim       (      uw&);

		virtual t_status setRegOtpSel     (const  uw );
		virtual t_status getRegOtpSel     (       uw&);
		virtual t_status setOtpData       (const  uw );
		virtual t_status getOtpData       (       uw&);
		virtual t_status setFuseWrEn      (const  uw );
		virtual t_status getFuseWrEn      (       uw&);
		virtual t_status setFuseWrAddr    (const  uw );
		virtual t_status getFuseWrAddr    (       uw&);

		virtual t_status getOptDone       (       uw&);
		virtual t_status setIrdrDcPulse   (const  uw );
		virtual t_status getIrdrDcPulse   (       uw&);
		virtual t_status getGolden        (       uw&);
		virtual t_status setOtpRes        (const  uw );
		virtual t_status getOtpRes        (       uw&);
		virtual t_status setIntTest       (const  uw );
		virtual t_status getIntTest       (       uw&);
#endif

		dbl m_prox30Ratio;

};
