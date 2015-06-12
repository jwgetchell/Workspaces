/*
 *  avgStats.cpp - Linux kernel module for
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
#include <math.h>
#include "ALSbaseClass.h"
#include "avgStats.h"

using namespace alsEc;

Cstats::Cstats()

//#ifdef _DEBUG
	:m_statSize(32)
//#else
//	:m_statSize(1)
//#endif

,m_minValue(10e24),m_maxValue(-10e24)
,m_statAry(NULL),m_stat2Ary(NULL)
,m_avgAry(NULL)
,m_b(0),m_m(1.0),m_ratio(1.0)
,m_value(0.0),m_mean(0.0),m_stdDev(0.0)
,m_state(-1)

{
	setSampSize(m_statSize);
	setMpaSize(1);
}

Cstats::~Cstats()
{
	resetAvgStats();
	delete[] m_statAry;
	delete[] m_stat2Ary;
	delete[] m_avgAry;
}

t_status
Cstats::setSampSize(const uw s)
{
	t_status ret=ok;

	if (m_statAry != NULL)
		delete[] m_statAry;

	if (m_stat2Ary != NULL)
		delete[] m_stat2Ary;

	m_statAry  = new t_stat  [m_statSize=s];
	m_stat2Ary = new t_dStat [m_statSize];

	memset(m_statAry, NULL,m_statSize*sizeof(m_statAry[0]));
	memset(m_stat2Ary,NULL,m_statSize*sizeof(m_stat2Ary[0]));

	m_statIndex=0;
	m_statSum=0;
	m_statSum2=0;
	m_statPrimed=false;

	return ret;
}

t_status
Cstats::setMpaSize(const uw s)
{
	t_status ret=ok;

	if (s)
		m_avgSize=s;
	else
		m_avgSize=1;

	if (m_avgAry != NULL)
		delete[] m_avgAry;

	m_avgAry  = new t_stat [m_avgSize];

	memset(m_avgAry, NULL,m_avgSize*sizeof(m_avgAry[0]));

	m_avgIndex=0;
	m_avgSum=0;
	m_mpaPrimed=false;

	return ret;
}

t_status
Cstats::resetAvgStats()
{
	t_status ret=ok;

	memset(m_statAry, NULL,m_statSize*sizeof(m_statAry[0]));
	memset(m_stat2Ary,NULL,m_statSize*sizeof(m_stat2Ary[0]));

	m_statIndex=0;
	m_statSum=0;
	m_statSum2=0;
	m_statPrimed=false;


	memset(m_avgAry, NULL,m_avgSize*sizeof(m_avgAry[0]));

	m_avgSize=m_avgIndex=0;
	m_avgSum=0;
	m_mpaPrimed=false;

	return ret;
}

t_status
Cstats::getStats(dbl& m,dbl &s)
{
	m=m_mean;
	s=m_stdDev;
	return alsEc::ok;
}

t_status
Cstats::getData(dbl& v)
{
	v=m_value;
	return alsEc::ok;
}

t_status
Cstats::setData(const uw v)
{
	t_status ret=ok;

	if (m_minValue>v)
		m_minValue=(t_stat)v;
	else
	{
		if (m_maxValue<v)
			m_maxValue=(t_stat)v;
	}
	
	// Moving Point Average
	m_avgSum+=(t_stat)(v-m_avgAry[m_avgIndex]);
	m_avgAry[m_avgIndex]=(t_stat)v;
	m_avgIndex++;
	if (m_mpaPrimed)
	{
		m_value=m_avgSum/m_avgSize;
		if (m_avgIndex>=m_avgSize)
			m_avgIndex=0;
	}
	else
	{
		m_value=m_avgSum/m_avgIndex;
		if (m_avgIndex>=m_avgSize)
		{
			m_mpaPrimed=true;
			m_avgIndex=0;
		}
	}

	// Statistics
	m_statSum +=(t_stat)(  v-m_statAry [m_statIndex]);
	m_statAry [m_statIndex]=(t_stat)v;
	m_statSum2+=(t_dStat)(v*v-m_stat2Ary[m_statIndex]);
	m_stat2Ary[m_statIndex]=(t_dStat)(v*v);
	m_statIndex++;

	if (m_statPrimed)
	{
		m_mean=m_statSum/m_statSize;
		if ( (m_statSum2/m_statSize-m_mean*m_mean) > 0 )
			m_stdDev=pow(m_statSum2/m_statSize-m_mean*m_mean,0.5);
		else
			m_stdDev=0.0;
		if (m_statIndex==m_statSize)
			m_statIndex=0;
	}
	else
	{
		m_mean=m_statSum/m_statIndex;
		if ( (m_statSum2/m_statIndex - m_mean*m_mean) >0)
			m_stdDev=pow(m_statSum2/m_statIndex - m_mean*m_mean,0.5);
		else
			m_stdDev=0.0;
		if (m_statIndex==m_statSize)
		{
			m_statPrimed=true;
			m_statIndex=0;
		}
	}

	// scale
	m_value=v*m_m*m_ratio+m_b;
	m_mean=m_mean*m_m*m_ratio+m_b;
	m_stdDev*=m_m*m_ratio;

	return ret;
}

t_status
Cstats::getReal(const uw code,dbl& value)
{
	value=code*m_m*m_ratio+m_b;
	return ok;
}

t_status
Cstats::getWord(const dbl value,uw& code)
{
	dbl dVal=0;

	dVal=(value-m_b);
	dVal/=m_m;
	dVal/=m_ratio;
	code=(uw)dVal;
	return ok;
}

t_status
Cstats::setGain(const dbl gain)
{
	m_ratio=gain;
	return ok;
}
t_status
Cstats::getGain(dbl& gain)
{
	gain=m_ratio;
	return ok;
}
t_status
Cstats::setNominal(const dbl gain)
{
	m_m=gain;
	return ok;
}
t_status
Cstats::getNominal(dbl& gain)
{
	gain=m_m;
	return ok;
}
t_status
Cstats::setOffset(const dbl offset)
{
	m_b=offset;
	return ok;
}
t_status
Cstats::getOffset(dbl& offset)
{
	offset=m_b;
	return ok;
}
t_status
Cstats::getMPAprimed(uw &v)
{
	v=m_mpaPrimed;
	return ok;
}

t_status
Cstats::setState(const uw state)
{
	m_state=state;
	return ok;
}
