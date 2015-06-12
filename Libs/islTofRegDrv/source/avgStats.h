/*
 *  alsStats.h - Linux kernel module for
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

#ifndef _AVGSTATS_H
#define _AVGSTATS_H

#include "ALSbaseClass.h"

class Cstats
{
public:
        Cstats();
        Cstats(CalsBase* pAlsDrv);
        ~Cstats();

		t_status setSampSize(const uw  s);
        t_status getSampSize(      uw &s);
        t_status setMpaSize (const uw  s);
        t_status getMpaSize (      uw &s);

        t_status setGain   (const dbl  v);
        t_status getGain   (      dbl &v);
        t_status setNominal(const dbl  v);
        t_status getNominal(      dbl &v);
        t_status setOffset (const dbl  v);
        t_status getOffset (      dbl &v);

        t_status resetAvgStats();

		//t_status avgStats(double &v,double &m,double &s);

		t_status setData(const uw data);
		t_status getData(dbl &v);
		t_status setState(const uw state);
		t_status getStats(dbl &m,dbl &s);

		t_status getMPAprimed(const uw c,uw& v);
		t_status getMPAprimed(           uw& v);

		t_status getReal(const uw code,dbl& value);
		t_status getWord(const dbl value,uw& code);
private:
        uw m_statSize;
        uw m_statIndex;
		t_stat m_minValue;
		t_stat m_maxValue;
        t_stat m_statSum;
        t_dStat m_statSum2;
        t_stat* m_statAry;
        t_dStat* m_stat2Ary;
        bool m_statPrimed;

        uw m_avgSize;
        uw m_avgIndex;
        t_stat m_avgSum;
        t_stat* m_avgAry;
        bool m_mpaPrimed;

		dbl m_b;
		dbl m_m;
		dbl m_ratio;
		dbl m_value;
		dbl m_mean;
		dbl m_stdDev;

		uw  m_state;
};

#endif
