/*
 *  ISL29028.h - Linux kernel module for
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

class Cisl29028 : public CalsBase
{
public:
	Cisl29028();
	~Cisl29028();

	                              // channel
	Cstats  m_dataStats[2][2][2]; // m_inputSelectN (channel=0)
	                              // m_rangeN       (channel=0)

	//status CstateMachine::load();
	virtual t_status detectDevice();

	t_status resetDevice();
	t_status initRegisters();
	t_status initInputSelect();
	t_status initRange();
	t_status initResolution();
	t_status initIrdr();
	virtual t_status initSleep();

    t_status getNresolution(const uw c,uw& v);
    t_status getResolutionList(const uw c,uw* v);

    t_status getNsleep(ul& v);
    t_status getSleepList(ul* v);

	// inherited
    //________________________________________________________________
    #define Get(x)     virtual t_status x (           uw&      v);
    #define Set(x)     virtual t_status x (           const uw v);
    #define chanGet(x) virtual t_status x (const uw c,uw&      v);//Get(x)
    #define chanSet(x) virtual t_status x (const uw c,const uw v);//Set(x)

    chanSet(setInputSelect)    chanGet(getInputSelect)
    chanSet(setEnable) 	       chanGet(getEnable)

	chanGet(getThreshLo)       chanSet(setThreshLo)
	chanSet(setThreshHi)       chanGet(getThreshHi)

	chanGet(getIntFlag)

	chanGet(getData)

	chanSet(setRange)

	Set(setSleep)              Get(getSleep)
	Set(setIntLogic)           Get(getIntLogic)

    #undef chanGet
    #undef chanSet
    #undef Get
    #undef Set


	//virtual t_status getThreshHi(const uw c,dbl& v);
	//virtual t_status setThreshHi(const uw c,dbl  v);
	//virtual t_status getThreshLo(const uw c,dbl& v);
	//virtual t_status setThreshLo(const uw c,dbl  v);

	//virtual t_status getData(const uw c,uw &d);
	virtual t_status setMpaSize(const ul c,const ul v);
	virtual t_status getDataStats(const uw c,double &v,double &m,double &s);

	virtual t_status getResolution(const uw c,uw& v);
	virtual t_status getResolution(           uw& v);

	t_status initCalibration();
	//status getLux(      dbl &d);
	t_status setLux(const dbl  d);

	virtual t_status setPdataStats(const ul c);

	virtual t_status initAlsStateMachine();
	virtual t_status initProximityStateMachine();
	virtual t_status initIrStateMachine();
	virtual t_status preStateIntMask(const uw chan,CstateMachine* state);

	virtual t_status measureConversionTime(uw&);

	uw m_cmdMask[2];// channel mask for state machine

};
