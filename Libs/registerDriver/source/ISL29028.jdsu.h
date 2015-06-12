/*
 *  ISL29028.jdsu.h - Linux kernel module for
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

class Cjdsu_028 : public Cisl29032
{
public:
	Cjdsu_028();
	~Cjdsu_028();

	virtual t_status initSleep();
	virtual t_status getProxIR(dbl&,uw&);
	virtual t_status getProximity(dbl&);
	virtual t_status initAlsStateMachine();
	virtual t_status initIrStateMachine();
	virtual t_status initRange();

	dbl m_prox30Ratio;

};
