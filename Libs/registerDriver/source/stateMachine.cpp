/*
 *  stateMachine.cpp - Linux kernel module for
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
#include "alsPrxTypes.h"
#include "alsPrxI2cIo.h"
#include "avgStats.h"
#include "stateMachine.h"

extern CalsBase* pCalsBase;

CstateMachine::CstateMachine(const uw chan,const uw sz,const uw type,bool& stateMachineEnabled)
:m_currentState(0)
,m_type(type)
,m_chan(chan)
,m_cmdMask(0xFFFF)
,m_stateChangedFlag(0)
,m_intEnabled(true)
,m_size(sz)
,m_stateMachineEnabled(&stateMachineEnabled)
{
	m_cmdImask = ~m_cmdMask;
}
CstateMachine::~CstateMachine()
{
	if (m_state)
	{
		delete[] m_state;
		m_state=0;
	}
}

t_status
CstateMachine::call(uw& time)
{
	t_status status=alsEc::ok;
	uw intFlag;
	clock_t now,sinceLastSet=((now=clock())-pCalsBase->m_setTime)*1000/CLOCKS_PER_SEC;

	// check current state, change if needed
	if ( (status=checkThresholds(intFlag)) )
		return status;
	if (*m_stateMachineEnabled)
	{
		// check if sequence jump is needed
		if (sinceLastSet>(clock_t)(m_cycles*pCalsBase->m_alsConversionTime))
		{
			if (m_state[m_currentState].m_pExit)
			{
				// mask before state change
				if (m_intEnabled)
				{
					if ( (status=pCalsBase->preStateIntMask(m_chan,*m_state[m_currentState].m_pExit)))
						return status;
				}

				if ( (status=(*m_state[m_currentState].m_pExit)->set()) )
					return status;

				pCalsBase->m_activeState[m_chan]=m_state[m_currentState].m_pExit;
			}
		}

		if (m_stateChangedFlag)
		{
			pCalsBase->m_setTime=clock();
			m_stateChangedFlag=0;
			time=m_cycles*pCalsBase->m_alsConversionTime;
		}
		else
			time=pCalsBase->m_alsConversionTime;
	}

	return status;
}

t_status
CstateMachine::checkThresholds(uw& intFlag)
//
// this routine
//
{
	t_status status=alsEc::ok;
	uw data;
	dbl value;
	uw nextState=m_currentState;

	// read HW data
	if ( (status=pCalsBase->getData(m_chan,data)) )
		return status;

	switch (m_type)// write data into memory
	{
	case alsType::als:
		if ( (status=pCalsBase->setLux(m_state[m_currentState].m_logicalState)) )
			return status;
		break;
	case alsType::prx:
		if ( (status=pCalsBase->setProximity(m_state[m_currentState].m_logicalState)) )
			return status;
		break;
	case alsType::ir:
		if ( (status=pCalsBase->setIR(m_state[m_currentState].m_logicalState)) )
			return status;
		break;
	}

	if (*m_stateMachineEnabled==true)
	{

		// clear interrupt
		if (m_intEnabled)
		{
			if ( (status=pCalsBase->getIntFlag(m_chan,intFlag)) )
			{
				if (status==alsEc::notImplemented)
					m_intEnabled=false;
				else
					return status;
			}
		}

		// compare value to limits (don't use intFlag result)
		if ( (status=pCalsBase->m_pDataStats[m_chan]->getReal(data,value)) )
			return status;

		if (value>m_state[m_currentState].m_tH)
		{
			nextState=m_state[m_currentState].m_hExit;
		}
		else if (value<m_state[m_currentState].m_tL)
		{
			nextState=m_state[m_currentState].m_lExit;
		}
		// change state if needed
		if (m_currentState!=nextState)
		{
			// mask before state change
			if (m_intEnabled && pCalsBase->m_stateMachineEnabled)
			{
				if ( (status=pCalsBase->preStateIntMask(m_chan,*this->m_state->m_pExit)) )
					return status;
			}
			m_currentState=nextState;
			if ( (status=set()) )
				return status;
		}

	}

	return status;// good return
}

t_status
CstateMachine::writeCmd(const uw cmd)
{
	uw word = (pCalsBase->m_regmap[pCalsBase->m_cmdBase+1] << 8)
			|  pCalsBase->m_regmap[pCalsBase->m_cmdBase];

	uw nWord = (cmd & m_cmdMask) | (word & m_cmdImask);

#if 1
	if (nWord!=word)
	{
		m_stateChangedFlag |= 1;
		if (m_cmdMask>0xFF)
			return pCalsBase->m_pIO->write(nWord);
		else
			return pCalsBase->m_pIO->write((uc)(nWord & 0xFF));
	}
	else
		return alsEc::ok;
#else
	m_stateChangedFlag |= 1;
	return pCalsBase->m_pIO->write(nWord);
#endif
}

t_status
CstateMachine::setMask(const uw mask)
{
	m_cmdMask=mask;
	m_cmdImask = ~ m_cmdMask;
	return alsEc::ok;
}


t_status
CstateMachine::set()
{
	t_status status=alsEc::ok;

	if (pCalsBase->m_stateMachineEnabled==false) return alsEc::ok;

	// set state
	if ( (status=
		writeCmd(m_state[m_currentState].m_cmd)) )
		goto setError;

	// update data pointer
	if ( (status=
		pCalsBase->setPdataStats(m_chan)) )
		goto setError;

	if (m_intEnabled) // set thresholds
	{
		if ( (status=
			pCalsBase->setThreshLo(m_chan,m_state[m_currentState].m_tL)) )
		{
			if (status==alsEc::notImplemented)
			{
				status=alsEc::ok;
				m_intEnabled=false;
			}
			else
				goto setError;
		}
		else
		{
			if ( (status=
				pCalsBase->setThreshHi(m_chan,m_state[m_currentState].m_tH)) )
				goto setError;
		}
	}

	return status;
setError:return status;// break here for error
}