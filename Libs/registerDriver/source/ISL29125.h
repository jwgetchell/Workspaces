/*
 *  ISL29125.h - Linux kernel module for
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

class Cisl29125 : public CalsBase
{
public:
	Cisl29125();
	~Cisl29125();

	                              // channel
	Cstats  m_dataStats[2][2][2]; // m_inputSelectN (channel=0)
	                              // m_rangeN       (channel=0)

	//status CstateMachine::load();
	virtual t_status detectDevice();
	
	// initialization: actual
	t_status resetDevice();
	t_status initRegisters();
	t_status initInputSelect();
	t_status initRange();
	t_status initResolution();
	// initialization: stubs
	t_status initIrdr();

    t_status getNresolution(const uw c,uw& v);
    t_status getResolutionList(const uw c,uw* v);

	// inherited
    //________________________________________________________________
    #define Get(x)     virtual t_status x (           uw&      v);
    #define Set(x)     virtual t_status x (           const uw v);
    #define chanGet(x) virtual t_status x (const uw c,uw&      v);//Get(x)
    #define chanSet(x) virtual t_status x (const uw c,const uw v);//Set(x)

    chanSet(setInputSelect)  chanGet(getInputSelect)
    chanSet(setEnable) 	       chanGet(getEnable)

	chanGet(getThreshLo)       chanSet(setThreshLo)
	chanSet(setThreshHi)       chanGet(getThreshHi)

	chanGet(getIntFlag)

	chanGet(getData)

	chanSet(setRange)	chanGet(getRange)

	Set(setIntLogic)           Get(getIntLogic)

    #undef chanGet
    #undef chanSet
    #undef Get
    #undef Set

	uw m_lastEnableValue;

	virtual t_status setMpaSize(const ul c,const ul v);
	virtual t_status getDataStats(const uw c,double &v,double &m,double &s);

	virtual t_status setResolution(const uw c,const uw v);
	virtual t_status getResolution(const uw c,uw& v);
	virtual t_status getResolution(           uw& v);
	virtual t_status setIRcomp       (const uw );
	virtual t_status getIRcomp       (      uw&);

	// stubs
	t_status initCalibration();
	t_status initStateMachine();
	t_status getNsleep(uw&);
	t_status getNinputSelect(const uw,uw&);

	virtual t_status setPdataStats(const ul c);

	// new RGB
	ul m_fullscaleCode;
	dbl m_fullscaleLux;
	virtual t_status getLux(dbl&);
	virtual t_status getRed(dbl&);
	virtual t_status getGreen(dbl&);
	virtual t_status getBlue(dbl&);
	virtual t_status getCCT(dbl&);
	virtual t_status setRgbCoeffEnable(const uw);
	virtual t_status getRgbCoeffEnable(uw&);
	virtual t_status loadRgbCoeff(dbl*);
	virtual t_status clearRgbCoeff();
	virtual t_status readRGB();

	virtual t_status setHighSensitivityMode(const uw);
	bool highSensitivityOn;
	virtual t_status enable4x(const uw);
	bool highSpeedOn;
	virtual t_status enable8bit(const uw);
	bool ultraHighSpeedOn;

	virtual t_status setIOinterceptEnable(bool);
};

