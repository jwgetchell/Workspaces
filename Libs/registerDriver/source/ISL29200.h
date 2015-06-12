/*
 *  ISL29200.h - Linux kernel module for
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
#include "avgStats.h"

class Cisl29200 : public CalsBase
{
public:
	Cisl29200();
	~Cisl29200();

	                          
	Cstats  m_dataStats[1];

	t_status resetDevice();
	t_status initRegisters();
	t_status initInputSelect();
	t_status initRange();
	t_status initResolution();
	t_status initIrdr();

	ul     m_ProxAmbRej;
    
    t_status getNresolution(const ul c,ul& v);
    t_status getResolutionList(const ul c,ul* v);

	// inherited
    //________________________________________________________________
    #define Get(x)     virtual t_status x (           uw&      v);
    #define Set(x)     virtual t_status x (           const uw v);
    #define chanGet(x) virtual t_status x (const uw c,uw&      v);//Get(x)
    #define chanSet(x) virtual t_status x (const uw c,const uw v);//Set(x)

    //chanSet(setInputSelect)  chanGet(getInputSelect)
    chanSet(setEnable) 	     chanGet(getEnable)

							 //chanSet(setRange)

	//Get(getRunMode)	         Set(setRunMode)
	//Get(getIrdrFreq)	     Set(setIrdrFreq)
	//Get(getProxAmbRej)	     Set(setProxAmbRej)

	virtual t_status getThreshLo(const uw,     uw& );
	virtual t_status setThreshLo(const uw,const uw );
	virtual t_status getThreshHi(const uw,     uw& );
	virtual t_status setThreshHi(const uw,const uw );

	virtual t_status getData(const uw c,uw &d);
	virtual t_status setMPAsize(const ul c,const ul v);
	virtual t_status setMPAsize(           const ul v);

	//virtual t_status setResolution(const uw c,const uw v);
	//virtual t_status setResolution(           const uw v);
	//virtual t_status getResolution(const uw c,uw& v);
	//virtual t_status getResolution(           uw& v);

	t_status initCalibration();

	virtual t_status setPdataStats();
	virtual t_status setPdataStats(const uw);

	t_status measureConversionTime(clock_t&);

	virtual t_status initAlsStateMachine();
	virtual t_status initProximityStateMachine();
	virtual t_status initIrStateMachine();
	virtual t_status preStateIntMask(const uw,CstateMachine*);

};
