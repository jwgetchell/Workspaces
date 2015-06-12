/*
 *  stateMachine.h - Linux kernel module for
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

#include "alsPrxTypes.h"

class CstateMachine
{
public:
	CstateMachine(uw,uw,uw,bool&);
	~CstateMachine();

	t_status call(uw&);
	t_status checkThresholds(uw&);
	t_status getState();
	t_status set();
	t_status setMask(const uw);
	t_status writeCmd(const uw);
	uw m_currentState;
	uw m_type;
	uw m_chan;
	uw m_cmdMask;
	uw m_cmdImask;
	uw m_cycles;
	uw m_stateChangedFlag;
	bool m_intEnabled;
	bool* m_stateMachineEnabled;
	uw m_size;

	class Cstate
	{
	public:
		//Cstate(){};
		uw m_logicalState;
		uw m_cmd;
		dbl m_tL;
		dbl m_tH;
		uw  m_maskL;
		uw  m_maskH;
		uw m_hExit;
		uw m_lExit;
		CstateMachine** m_pExit;
		}*m_state;
};


