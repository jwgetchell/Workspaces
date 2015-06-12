/*
 *  ISL29177.h - Linux kernel module for
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

class Cisl29177 : public Cisl29032
{
public:
	Cisl29177();
	~Cisl29177();

	Cstats  m_dataStats[2][4];// chan, #/ranges

	double m_proxStep[4];

	//overrides
	virtual t_status initSleep();               // done
	virtual t_status initIrdr();
	virtual t_status initRegisters();           // changed to single channel
	virtual t_status initCalibration();
	virtual t_status initIntPersist();
	virtual t_status resetDevice();
	virtual t_status getData(const uw,uw&);
	virtual t_status setPdataStats(const ul c); //
	virtual t_status getIR(dbl&);
	virtual t_status getProximity(dbl&);

	virtual t_status getEnable(const uw,     uw&);
	virtual t_status setEnable(const uw,const uw);

	// removed
	virtual t_status initAlsStateMachine();// commented out
	virtual t_status initIrStateMachine();// commented out
	virtual t_status initRange();
	virtual t_status setIRcomp       (const uw );
	virtual t_status getIRcomp       (      uw&);



	// original

	virtual t_status getThreshLo(const uw,     uw& );
	virtual t_status setThreshLo(const uw,const uw );
	virtual t_status getThreshHi(const uw,     uw& );
	virtual t_status setThreshHi(const uw,const uw );

	// New Functions (added to 38 derived from the 28)
	virtual t_status setProxIntEnable(const uw );
	virtual t_status getProxIntEnable(      uw&);
	virtual t_status setProxOffset   (      uw&);
	virtual t_status getProxOffset   (      uw&);
	virtual t_status getProxAlrm     (      uw&);
	virtual t_status setVddAlrm      (const uw );
	virtual t_status getVddAlrm      (      uw&);

	// changes
	virtual t_status setIrdr         (const uw );
	virtual t_status getIrdr         (      uw&);

	// new
		uw m_PrxRngOffCmpEn;// default to on
		virtual t_status setPrxRngOffCmpEn(const uw );
		virtual t_status getPrxRngOffCmpEn(      uw&);

		uw m_irdrMode;// {0:2} = {All,LO,HI}, default=HI
		virtual t_status setIrdrMode(const uw );
		virtual t_status getIrdrMode(      uw&);

		dbl m_prox30Ratio;

};
