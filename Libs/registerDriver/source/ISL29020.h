/*
 *  ISL29023.h - Linux kernel module for
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
#include "ISL29023.h"

class Cisl29020 : public Cisl29023
{
public:
	Cisl29020();
	~Cisl29020();

	Cstats  m_dataStats[64];

	uw m_cmdMask;// channel mask for state machine

	// overridden
	t_status initAlsStateMachine();
	t_status resetDevice();
	t_status initRegisters();
	t_status initCalibration();
	t_status setPdataStats(const uw);
	t_status setInputSelect(const uw,const uw);
	t_status setEnable(const uw,const uw);

	// removed
	virtual t_status getThreshHi(const uw c,      uw& v);
	virtual t_status setThreshHi(const uw c,const uw  v);
	virtual t_status getThreshLo(const uw c,      uw& v);
	virtual t_status setThreshLo(const uw c,const uw  v);

	virtual t_status getIntFlag(const uw c,      uw& v);
	virtual t_status setIntFlag(const uw c,const uw  v);

	virtual t_status getIntPersist(const uw c,      uw& v);
	virtual t_status setIntPersist(const uw c,const uw  v);

};
