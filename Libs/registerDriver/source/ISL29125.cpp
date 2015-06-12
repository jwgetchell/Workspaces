/*
 *  ISL29125.cpp - Linux kernel module for
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
#include <time.h>
#include "ISL29125.h"
#include "alsPrxI2cIo.h"
#include "stateMachine.h"

#ifdef _WINDOWS
#pragma warning (disable:4706) // assignment within conditional expression
#endif

#ifdef _DEBUG
#define new DEBUG_NEW
#endif

using namespace alsEc;

ul __stdcall
IOintercept125(ul cmd,ul addr,uw* data,ul dSize)
{
	ul status;

	status=pDrvApi2(cmd,addr,data,dSize);

	return status;
}

Cisl29125::Cisl29125()
{
	m_useRgbCoeff=true;
	m_Nchannels=3;
	m_partNumber=29125;
	m_cmdBase=1;
	m_partFamily=m_partNumber;
	m_lastEnableValue=0;
	clearRgbCoeff();

	//setIOinterceptEnable(true);
}

Cisl29125::~Cisl29125()
{
	if (m_regmap)
	{
		delete[] m_regmap;
		m_regmap=0;
	}

	if (m_reg)
	{
		delete m_reg;
		m_reg=0;
	}
	highSensitivityOn=false;

	//setIOinterceptEnable(false);
}

t_status
Cisl29125::resetDevice()
{
	PrintTrace("Cisl29125::resetDevice");

	t_status status=ok;

	uc reset[]={0x00,0x00,0xFF,0x00,0xF0,0xFF,0x00,0x00,0x00},
		size=sizeof(reset)/sizeof(reset[0]);

	if ((status=m_pIO->write(0xE,(uc)0)))
		return status;
	if ((status=m_pIO->write(0xF,(uc)0)))
		return status;
	if ((status=m_pIO->write(0x1,(uc)0)))
		return status;

	clock_t t1=0,t0=clock();
	while (((t1=clock())-t0)<0.002*CLOCKS_PER_SEC){}

	for (uw i=0;i<size;i++)
	{
		if ((status=m_pIO->write(i+2,reset[i])))
			return status;
	}

	return status;
}

t_status
Cisl29125::detectDevice()
{
#pragma message (">>>>>>>>>>> JWG: Cisl29125::detectDevice <<<<<<<<<<<<<<")
	uc d0,d1,addr=0x0;

	m_pIO->readHW(addr,d0);
	if (d0)
	{
		m_pIO->write(addr,(uc)0);
		m_pIO->readHW(addr,d1);
		if (d1)
		{
			if (d0!=d1)
				m_pIO->write(addr,d0);
			return measureConversionTime(m_alsConversionTime);
		}
		else
			return driverError;
	}
	else
		return driverError;
}

t_status
Cisl29125::initRegisters()
{
	static ul regTable[]={0 // reserved for size (see below)
		// function       chan,addr,shift,mask (post shift)
		,regIdx::enable      ,0,0x01,0,0x07 // chan 0 is ALS/IR
		,regIdx::inputSelect ,0,0x01,0,0x07 // enable/RGB/ALS
		,regIdx::intFlag     ,0,0x08,0,0x01 // interupt
		,regIdx::intPersist  ,0,0x03,2,0x03 // Persist={1,2,4,8}

		,regIdx::range       ,0,0x01,3,0x1   // Range: 330,4000, 1:12
		,regIdx::resolution  ,0,0x01,4,0x01 // Resolution: 16/12

		,regIdx::data        ,0,0x09,0,0xFFFF // Green
		,regIdx::data        ,1,0x0B,0,0xFFFF // Red
		,regIdx::data        ,2,0x0D,0,0xFFFF // Blue

		,regIdx::threshLo    ,0,0x04,0,0xFFFF // Lo thresh
		,regIdx::threshHi    ,0,0x06,0,0xFFFF // Hi thresh
    
		,regIdx::irComp      ,0,0x02,0,0xBF // 0:127 compensation (MSB 3 1/3 * 2nd MSB)
		};

	regTable[0]=sizeof(regTable)/sizeof(regTable[0])-1;
	m_regTable=(uw*)regTable;

    m_reg=new CfunctionList(m_regTable);

	m_reg->m_intFlag[0].m_isVolatile=1;
	m_reg->m_data[0].m_isVolatile=1;
	m_reg->m_data[1].m_isVolatile=1;
	m_reg->m_data[2].m_isVolatile=1;

	CalsBase::initRegisters();

	setPdataStats(0);// set initial pointer

	return ok;
}

t_status
Cisl29125::initCalibration()
{
	uw c,i,r,addr;
	dbl m;

	class Cdb{public:dbl m;dbl b;} db[8];

	for (c=0;c<2;c++)
	{
		for (i=0;i<2;i++)
		{
			for (r=0;r<2;r++)
			{
				// channel,input, range
				if (c==0)// ALS/IR
				{
					if (i==0)//ALS
						m=(dbl)m_rangeList[r]/(dbl)m_resolutionList[0];
					else     //IR
						m=(dbl)m_rangeList[r]/(dbl)m_resolutionList[0];
				}
				else//Proximity (and don't care)
					m=1.0/(dbl)0xFF;

				m_dataStats[c][i][r].setNominal(m);
				m_dataStats[c][i][r].setState(addr=c<<2|i<<1|r);

				m_dataStats[c][i][r].getNominal(db[addr].m);
				m_dataStats[c][i][r].getOffset(db[addr].b);
			}
		}
	}

	return ok;
}

	// ___________
	// InputSelect
	// ===========

t_status
Cisl29125::initInputSelect()
{
	static const char* inputSelect[]={"OFF" // ____________
									 ,"ALS" // Input Select
									 ,"RGB" // ============
									 };      

	m_NinputSelect=sizeof(inputSelect)/sizeof(inputSelect[0]);
	m_inputSelectList=(char**)inputSelect;
	return ok;
}

t_status
Cisl29125::setInputSelect(const uw c,const uw v)
{
	t_status status;

	if (!c) // must be 1st channel
	{
		if (v<m_NinputSelect)
		{
			switch (v)
			{
			case 0:
			case 1:status=m_pIO->write(&m_reg->m_inputSelect[c],v);break;
			case 2:status=m_pIO->write(&m_reg->m_inputSelect[c],(uw)5); break;
			default:status=illegalValue;
			}

			if (ok==status)
			{
				m_inputSelectN=v;
				if (v>0) m_lastEnableValue=v;
				return setPdataStats(0);
			}
			else
				return status;
		}
		else
			return illegalValue;
	}
	else 
		return illegalChannel;
}

	// ______
	// Enable
	// ======

t_status
Cisl29125::getEnable(const uw c,uw& v)
{
	t_status status;

	if (c<m_Nchannels)
	{
		status=m_pIO->read(&m_reg->m_enable[c],v);
		if (v>1) v=1;
		return status;
	}
	else
		return illegalChannel;
}

t_status
Cisl29125::setEnable(const uw c,const uw v)
{
	t_status status;

	if (c<m_Nchannels)
	{
		status=setInputSelect(0,m_lastEnableValue);
		return status;
	}
	else
		return illegalChannel;
}

t_status
Cisl29125::getInputSelect(const uw c,uw& v)
{
	t_status status;

	if (!c) // must be 1st channel
	{
		status=m_pIO->read(&m_reg->m_inputSelect[c],v);

		switch (v)
		{
		case 0:
		case 1:break;
		case 5:v=2;break;
		default:status=illegalValue;
		}

		m_inputSelectN=v;

		return status;
	}
	else 
		return illegalChannel;
}

t_status
Cisl29125::initRange()
{
	t_status result=ok;

	static uw rng[]={375   // ======================
			        ,10250 // Define range list here
					,155   // 
			        };
	m_Nrange=sizeof(rng)/sizeof(rng[0]);
	m_rangeList=rng;

	m_fullscaleLux=m_rangeList[0];

	return result;
}

t_status 
Cisl29125::getRange(const uw c,uw& r)
{
	t_status status=CalsBase::getRange(c,r);

	if (highSensitivityOn & (r==0)) r=m_Nrange-1;

	return status;
}

t_status 
Cisl29125::setRange(const uw c,const uw r0)
{
	t_status status=ok;
	uw r=r0;

        if (c<m_Nchannels)
        {
			if (r<m_Nrange)
			{
				if (c)
					return notImplemented;
				else
				{

					if (r==m_Nrange-1)
					{
						status=setHighSensitivityMode(1);
						r=0;
					}
					else
					{
						status=setHighSensitivityMode(0);
					}

					if (ok==(status=m_pIO->write(&m_reg->m_range[c],r)))
					{
						m_rangeN=r0;
						m_fullscaleLux=m_rangeList[m_rangeN];
						return setPdataStats(c);
					}

					return status;
				}
			}
			else
				return illegalValue;
        }
        else
        {
			return illegalChannel;
        }
}

	// __________
	// Resolution
	// ==========

t_status
Cisl29125::initResolution()
{
	static uw res[]={65535 // _______________
	                ,4095  // Resolution list
	                ,256   // ===============
			        };     
	m_Nresolution=sizeof(res)/sizeof(res[0]);
	m_resolutionList=res;
	m_fullscaleCode=m_resolutionList[0];
	return ok;
}

t_status
Cisl29125::setResolution(const uw c,const uw v)
{
	t_status status;

	if (c<m_Nchannels)
	{
		if (v==2)
		{
			status=enable8bit(1);m_fullscaleCode=0xff;
			m_resolutionN=v;
		}
		else
		{
			enable8bit(0);
			if (ok==(status=m_pIO->write(&m_reg->m_resolution[0],v)))
			{
				m_resolutionN=v;
				m_fullscaleCode=m_resolutionList[m_resolutionN];
				return setPdataStats(0);
			}
		}

		return status;
	}
	else
		return illegalChannel;
}

t_status
Cisl29125::getNresolution(const uw c,uw& v)
{
	if (c<m_Nchannels)
	{
		if (c)
			v=1;
		else
			v=m_Nresolution;
		return ok;
	}
	else
		return illegalChannel;
}

t_status
Cisl29125::getResolutionList(const uw c,uw* v)
{
	if (c<m_Nchannels)
	{
		if (c)
			*v=255;
		else
			memcpy(v,m_resolutionList,m_Nresolution*sizeof(m_resolutionList[0]));
		return ok;
	}
	else
		return illegalChannel;
}

t_status
Cisl29125::getResolution(uw& v)
{
	return getResolution(0,v);
}

t_status
Cisl29125::getResolution(const uw c,uw& v)
{
	if (c<m_Nchannels)
	{
		t_status status = m_pIO->read(&m_reg->m_resolution[0],v);
		if (m_fullscaleCode==0xff)  v=2;// cludge for test mode
		m_resolutionN=v; 
		return status;
	}
	else
		return illegalChannel;
}



t_status
Cisl29125::getData(const uw c,uw &v)
{
	t_status status;

	if (c<m_Nchannels)
	{
		if ((status=m_pIO->read(&m_reg->m_data[c],v)))
			return status;

		return status;

		//m_lastTime=clock();

		//if ((status=setPdataStats(c)))
		//	return status;

		//return m_pDataStats[c]->setData(v);
	}
	else
		return illegalChannel;
}

t_status
Cisl29125::setMpaSize(const ul c,const ul v)
{
	if (c<m_Nchannels)
	{
		if (c) 
			return m_dataStats[c][0][0].setMpaSize(v);
		else
			return m_dataStats[0][m_inputSelectN][m_rangeN].setMpaSize(v);
	}
	else
		return illegalChannel;
}

t_status
Cisl29125::getDataStats(const uw c,double &v, double &m, double &s)
{
#pragma message ("JWG:Cisl29125::getDataStats")
	//if (c<m_Nchannels)
	//{
	//	uw data;
	//	t_status status = getData(c,data);

	//	v=(double)data;

	//	if (c) 
	//		m_dataStats[c][0][0].avgStats(v,m,s);
	//	else
	//		m_dataStats[0][m_inputSelectN][m_rangeN].avgStats(v,m,s);

	//	return status;
	//}
	//else
	//	return illegalChannel;
	return ok;
}


	// ________
	// ThreshHi
	// ========

t_status
Cisl29125::setThreshHi(const uw c,const uw v)
{
	if (c<m_Nchannels)
	{
		ul addr,data; 

		switch (c)
		{
		case 0:
			if (v>m_reg->m_threshHi[c].m_mask)
				return illegalValue;
			else
			{
				addr=m_reg->m_threshHi[c].m_addr;
				data  = m_regmap[addr] & 0xFF;
				data |= (m_regmap[addr+1] & 0xFF) << 8;
				data &=  m_reg->m_threshHi[c].m_imask;
				data |= v << m_reg->m_threshHi[c].m_shift;
				return m_pIO->write(addr,data);
			}

		case 1:  return m_pIO->write(&m_reg->m_threshHi[c],v);

		default: return driverError;
		}
	}
	else
		return illegalChannel;
}

t_status
Cisl29125::getThreshHi(const uw c,uw& v)
{
	t_status status;

	if (c<m_Nchannels)
	{
		uw addr,data; 

		switch (c)
		{
		case 0:  
			addr=m_reg->m_threshHi[c].m_addr;
			status=m_pIO->read(addr,data);
			v  = m_regmap[addr]   >> m_reg->m_threshHi[c].m_shift;
			v |= m_regmap[addr+1] << m_reg->m_threshHi[c].m_shift;
			return status;

		case 1:
			return m_pIO->read(&m_reg->m_threshHi[c],v);

		default:
			return driverError;
		}
	}
	else
		return illegalChannel;
}

t_status
Cisl29125::setThreshLo(const uw c,const uw v)
{
	if (c<m_Nchannels)
		return m_pIO->write(&m_reg->m_threshLo[c],v);
	else
		return illegalChannel;
}

t_status
Cisl29125::getThreshLo(const uw c,uw& v)
{
	if (c<m_Nchannels)
		return m_pIO->read(&m_reg->m_threshLo[c],v);
	else
		return illegalChannel;
}

t_status
Cisl29125::getIntFlag(const uw c,uw& v)
{
	t_status status=ok;

	if (c<m_Nchannels)
	{
		if ((status=m_pIO->read(&m_reg->m_intFlag[c],v)))
			return status;
		else
		{
			if (v)
			{
				ul addr=m_reg->m_intFlag[c].m_addr;
				return m_pIO->write(addr,uc(m_regmap[addr] & m_reg->m_intFlag[c].m_imask));
			}
			else
				return status;
		}
	}
	else
		return illegalChannel;
}


	// ________
	// IntLogic
	// ========

t_status
Cisl29125::getIntLogic(uw& v)
{
	return m_pIO->read(&m_reg->m_intLogic[0],v);
}

t_status
Cisl29125::setIntLogic(const uw v)
{
	return m_pIO->write(&m_reg->m_intLogic[0],v);
}

t_status
Cisl29125::setPdataStats(const ul c)
{
	if (c)
		m_pDataStats[c]=&m_dataStats[c][0][0];
	else
	{
		m_inputSelectN=m_regmap[1] & 1;
		m_rangeN=(m_regmap[1]>>1) & 1;
		m_pDataStats[c]=&m_dataStats[c][m_inputSelectN][m_rangeN];
	}

	return ok;
}
t_status
Cisl29125::setIRcomp(const uw comp)
	// Values 0:127={0.0-3.2 , 5.3-8.5} Msb is 1.65 * 2nd MSB
{
	uw val=((comp & 0x3F) | ( (comp & 0x40) << 1 ));

	return m_pIO->write(&m_reg->m_irComp[0],val);

}

t_status
Cisl29125::getIRcomp(uw& comp)
{
	t_status status=ok;

	status=m_pIO->read(&m_reg->m_irComp[0],comp);

	comp = (comp & 0x3F) | ( (comp & 0x80) >> 1);

	return status;
}

	//=====
	//Stubs
	//=====

t_status
Cisl29125::initIrdr()
{
	m_Nirdr=0;
	m_irdrList=NULL;
	return ok;
}

t_status
Cisl29125::initStateMachine()
{
	return ok;
}

t_status
Cisl29125::getNsleep(uw& nsleep)
{
	nsleep=0;
	return ok;
}

t_status
Cisl29125::getNinputSelect(const uw c,uw& ninput)
{
	ninput=m_NinputSelect;
	return ok;
}


	//===
	//RBG
	//===
t_status
Cisl29125::getLux(dbl& lux)
{	
	t_status status=readRGB();
	lux=m_rgbCoeff->lux;
	return status;
}

t_status
Cisl29125::getRed(dbl& x)
{
	t_status status=readRGB();
	x=m_rgbCoeff->red;
	return status;
}
t_status
Cisl29125::getGreen(dbl& x)
{
	t_status status=readRGB();
	x=m_rgbCoeff->green;
	return status;
}
t_status
Cisl29125::getBlue(dbl& x)
{
	t_status status=readRGB();
	x=m_rgbCoeff->blue;
	return status;
}
t_status
Cisl29125::getCCT(dbl& cct)
{
	//x = R’/(R’ + G’ + B’) 
	//y = G’/(R’ + G’ + B’) 
	//n = (x – 0.3320) / (y – 0.1858) 
	//CCT = -449n^3 + 3525n^2 – 6823.3n + 5520.33

	dbl x,y,n;
	t_status status=readRGB();

	x=m_rgbCoeff->red/(m_rgbCoeff->red+m_rgbCoeff->green+m_rgbCoeff->blue);
	y=m_rgbCoeff->green/(m_rgbCoeff->red+m_rgbCoeff->green+m_rgbCoeff->blue);
	n=(x-0.3320)/(y-0.1858);

	cct=-449*n*n*n+3525*n*n-6823.3*n+5520.33;

	return status;
}
t_status
Cisl29125::setRgbCoeffEnable(const uw v)
{

	if (v>0)
		m_useRgbCoeff=true;
	else
		m_useRgbCoeff=false;

	return ok;
}
t_status
Cisl29125::getRgbCoeffEnable(uw &v)
{

	if (m_useRgbCoeff)
		v=1;
	else
		v=0;

	return ok;
}
t_status
Cisl29125::loadRgbCoeff(dbl* x)
{
	t_status status=alsEc::ok;
	int i=0;

	m_rgbCoeff->alpha=x[i++];
	m_rgbCoeff->beta=x[i++];
	m_rgbCoeff->gamma=x[i++];

	m_rgbCoeff->Krg=x[i++];
	m_rgbCoeff->Krb=x[i++];

	m_rgbCoeff->Kgr=x[i++];
	m_rgbCoeff->Kgb=x[i++];

	m_rgbCoeff->Kbr=x[i++];
	m_rgbCoeff->Kbg=x[i++];

	return status;
}
t_status
Cisl29125::clearRgbCoeff()
{
	t_status status=alsEc::ok;

	m_rgbCoeff->alpha=1;
	m_rgbCoeff->beta=1;
	m_rgbCoeff->gamma=1;

	m_rgbCoeff->Krg=0;
	m_rgbCoeff->Krb=0;

	m_rgbCoeff->Kgr=0;
	m_rgbCoeff->Kgb=0;

	m_rgbCoeff->Kbr=0;
	m_rgbCoeff->Kbg=0;

	return status;
}
t_status
Cisl29125::readRGB()
{
	t_status status=alsEc::ok;
	clock_t thisTime=clock();
	dbl red=0,green=0,blue=0;// uncorrected
	dbl gain=1;
	ul data;

	if (thisTime-m_rgbCoeff->lastTime>100)
	{
		getData(1,data);
		data&=m_fullscaleCode;
		red=m_fullscaleLux*data/m_fullscaleCode;

		getData(0,data);
		data&=m_fullscaleCode;
		green=m_fullscaleLux*data/m_fullscaleCode;
		m_rgbCoeff->lux=green;

		getData(2,data);
		data&=m_fullscaleCode;
		blue=m_fullscaleLux*data/m_fullscaleCode;

		if (m_useRgbCoeff)
		{
			m_rgbCoeff->red=  m_rgbCoeff->alpha*(                red+m_rgbCoeff->Krg*green+m_rgbCoeff->Krb*blue );
			m_rgbCoeff->green=m_rgbCoeff->beta* (m_rgbCoeff->Kgr*red+                green+m_rgbCoeff->Kgb*blue );
			m_rgbCoeff->blue= m_rgbCoeff->gamma*(m_rgbCoeff->Kbr*red+m_rgbCoeff->Kbg*green                +blue );
		}
		else
		{
			m_rgbCoeff->red=red;
			m_rgbCoeff->green=green;
			m_rgbCoeff->blue=blue;
		}


		if (m_rgbCoeff->red<0)
			m_rgbCoeff->red=0;
		else
			m_rgbCoeff->red*=gain;

		if (m_rgbCoeff->green<0) 
			m_rgbCoeff->green=0;
		else
			m_rgbCoeff->green*=gain;

		if (m_rgbCoeff->blue<0)
			m_rgbCoeff->blue=0;
		else
			m_rgbCoeff->blue*=gain;

		m_rgbCoeff->lastTime=thisTime;
	}
	return status;
}

t_status
Cisl29125::setHighSensitivityMode(const uw on)
{
		t_status status;

		status=m_pIO->write(0x00,(uc)0x89); // enter test mode
		status=m_pIO->write(0x00,(uc)0xC9);

		if (on==0)
		{	// turn off
			status=m_pIO->write(0x1C,(uc)0x00);// reset gain to 1
			status=m_pIO->write(0x19,(uc)0x00);// return to fuse mode
			highSensitivityOn=false;
		}
		else
		{
			status=m_pIO->write(0x19,(uc)0x40);// set to register mode
			status=m_pIO->write(0x1C,(uc)0x03);// set gain to max (2.3)
			highSensitivityOn=true;
		}

		status=m_pIO->write(0x00,(uc)0x00);// exit test mode

		return status;
}

t_status
Cisl29125::enable4x(const uw on)
{
		t_status status;

		status=m_pIO->write(0x00,(uc)0x89); // enter test mode
		status=m_pIO->write(0x00,(uc)0xC9);

		if (on==0)
		{	// turn off
			if (ultraHighSpeedOn)
			{
				status=m_pIO->write(0x1A,(uc)0x02);
			}
			else
			{
				status=m_pIO->write(0x1A,(uc)0x00);
			}
			highSpeedOn=false;
		}
		else
		{
			if (ultraHighSpeedOn)
			{
				status=m_pIO->write(0x1A,(uc)0x06);
			}
			else
			{
				status=m_pIO->write(0x1A,(uc)0x04);
			}
			highSpeedOn=true;
		}

		status=m_pIO->write(0x00,(uc)0x00);// exit test mode

		return status;
}

t_status
Cisl29125::enable8bit(const uw on)
{
		t_status status;

		status=m_pIO->write(0x00,(uc)0x89); // enter test mode
		status=m_pIO->write(0x00,(uc)0xC9);

		if (on==0)
		{	// turn off
			if (highSpeedOn)
			{
				status=m_pIO->write(0x1A,(uc)0x04);
			}
			else
			{
				status=m_pIO->write(0x1A,(uc)0x00);
			}
			ultraHighSpeedOn=false;
		}
		else
		{
			if (highSpeedOn)
			{
				status=m_pIO->write(0x1A,(uc)0x06);
			}
			else
			{
				status=m_pIO->write(0x1A,(uc)0x02);
			}
			ultraHighSpeedOn=true;
		}

		status=m_pIO->write(0x00,(uc)0x00);// exit test mode

		return status;
}

t_status
Cisl29125::setIOinterceptEnable (bool enable)
{
	if (enable)
	{
		if (pDrvApi!=NULL)
		{
			pDrvApi2=pDrvApi;
			pDrvApi=&IOintercept125;
		}
	}
	else
	{
		if (pDrvApi2!=NULL)
		{
			pDrvApi=pDrvApi2;
			pDrvApi2=NULL;
		}
	}
	m_IOinterceptEnabled=enable;

	return ok;
}

