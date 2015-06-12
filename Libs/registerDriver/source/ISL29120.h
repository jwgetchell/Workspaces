/*
 *  ISL29120.h - Linux kernel module for
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

class Cisl29120 : public Cisl29023
{
public:
	Cisl29120();
	~Cisl29120();

	// overrides
	virtual t_status initInputSelect();
	virtual t_status initRange();
	virtual t_status initCalibration();
	virtual t_status setPdataStats(const uw c);

	virtual t_status initRegisters();
	virtual t_status initAlsStateMachine();
	virtual t_status getData(const uw,uw &);

};
