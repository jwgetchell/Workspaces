/*
 *  alsPrxI2cIo.cpp - Linux kernel module for
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
#include "ALSbaseClass.h"
#include "alsPrxI2cIo.h"

ul (fpApi *pDrvApi)(ul,ul,ul*,ul)=NULL;

CalsPrxI2cIo::~CalsPrxI2cIo()
{
	if (m_file)
		fclose(m_file);
}

CalsPrxI2cIo::CalsPrxI2cIo(CalsBase* base)
:m_isVolatile(1)
,m_pBase(base)
,m_file(0)
,m_disableIO(false)
,m_skipDebugMap(false)
{
	memset(debugMap,NULL,sizeof(debugMap));

#ifdef _TEST
	m_file=fopen(_TEST,"w+");
#endif
}

t_status
CalsPrxI2cIo::disableIO()
{
	m_disableIO=true;
	return alsEc::ok;
}

t_status
CalsPrxI2cIo::enableIO()
{
	m_disableIO=false;
	return alsEc::ok;
}

t_status
CalsPrxI2cIo::printTrace(const char* msg)
{
	if (m_file)
		fprintf(m_file,"%s\n",msg);

	return alsEc::ok;
}

t_status
CalsPrxI2cIo::trace(const char* s,const uw rw,const uw a,const uw d)
{
	static uw lrw=(uw)-1,la=(uw)-1,ld=(uw)-1;
	static clock_t t0=0;
	uw ia=m_pBase->m_ic2Addr;

	pDrvApi(callBackCmd::rI2cAddr,ia,&ia,1);

	if (!t0)
		t0=clock();

	fprintf(m_file,"%08.3f:",((dbl)clock()-(dbl)t0)/ ((dbl)CLOCKS_PER_SEC));

	switch (rw)
	{
	case callBackCmd::rWord:fprintf(m_file,"%s:R:0x%02X:0x%02X:%04X",s,ia,a,d);break;
	case callBackCmd::rByte:fprintf(m_file,"%s:R:0x%02X:0x%02X:%02X",s,ia,a,d);break;
	case callBackCmd::wWord:fprintf(m_file,"%s:W:0x%02X:0x%02X:%04X",s,ia,a,d);break;
	case callBackCmd::wByte:fprintf(m_file,"%s:W:0x%02X:0x%02X:%02X",s,ia,a,d);break;
	}

	if ( (lrw==rw) && (la==a) && (ld==d) )
		fprintf(m_file,"*\n");
	else
		fprintf(m_file,"\n");

	lrw=rw;la=a;ld=d;

	return alsEc::ok;
}

t_status
CalsPrxI2cIo::emuApi(const uw rw,const uw a,uw& d)
{
	if (a<defaultRegMapSize)
	{

		switch (rw)
		{
		case callBackCmd::rWord:
			d=((debugMap[a+1] & 0xFF) << 8)
			 |  (debugMap[a] & 0xFF);
			break;

		case callBackCmd::rByte:
			d=debugMap[a] & 0xFF;
			break;

		case callBackCmd::wWord:
			m_pBase->m_regmap[a+1]=debugMap[a+1]=(d >> 8) & 0xFF;

		case callBackCmd::wByte:
			m_pBase->m_regmap[a]=  debugMap[a]=   d       & 0xFF;
			break;
		default:;
		}

		#ifndef NOEMUTRACE
				// I/O trace
				if (m_file)
					trace("E",rw,a,d);
		#endif

		return callBackOk;
	}
	else
		return alsEc::driverError;
}

t_status
CalsPrxI2cIo::drvApi(ul rw,ul a,uw& d)
{
	static uw ic2Addr;
	t_status retVal=(t_status)callBackOk;
	uw byte0,byte1;
	ul ia;

	if ( (pDrvApi) && (m_disableIO!=true) )
	{
		if (ic2Addr!=m_pBase->m_ic2Addr)
			retVal=pDrvApi(callBackCmd::wI2cAddr,ic2Addr=m_pBase->m_ic2Addr,&d,1);
#if 1
		pDrvApi(callBackCmd::rI2cAddr,0,&ia,1);
		if ((m_pBase->m_byteIoOnly) && (ia==0x88))
#else
		if (m_pBase->m_byteIoOnly)
#endif
		{
			if (rw==callBackCmd::wWord)
			{
				byte0=d & 0xFF;
				byte1=(d & 0xFF00) >> 8;
				drvApi(callBackCmd::wByte,a,byte0);
				drvApi(callBackCmd::wByte,a+1,byte1);
				return retVal;
			}
			else
			{
				if (rw==callBackCmd::rWord)
				{
					drvApi(callBackCmd::rByte,a,byte0);
					drvApi(callBackCmd::rByte,a+1,byte1);
					d=(byte0 & 0xFF) | ((byte1 & 0xFF) << 8);
					return retVal;
				}
				else
				{
					retVal=pDrvApi(rw,a + m_pBase->m_deviceBaseAddr,&d,1);
				}
			}
			
		}
		else
		{
			retVal=pDrvApi(rw,a + m_pBase->m_deviceBaseAddr,&d,1);
		}

		if (!m_skipDebugMap)
		{
			switch (rw)
			{
			case callBackCmd::wWord:
			case callBackCmd::rWord:
				m_pBase->m_regmap[a+1]=debugMap[a+1]=(d >> 8) & 0xFF;
			case callBackCmd::wByte:
			case callBackCmd::rByte:
				m_pBase->m_regmap[a]=  debugMap[a]=   d       & 0xFF;
				break;
			default:;
			}
		}

		if (retVal!=callBackOk)
		{
			pDrvApi=0;// switch to emulation
			retVal=alsEc::driverError;
		}

		// I/O trace
		if (m_file)
			trace("H",rw,a,d);

	}
	else
		retVal = emuApi(rw,a,d);

	return retVal;
}

t_status
CalsPrxI2cIo::read(const uw addr,uw& data)
{
	uw dBuf=0;
	t_status status=0;

	if (m_isVolatile)
		status = drvApi(callBackCmd::rWord,addr,dBuf);
	else
		status = emuApi(callBackCmd::rWord,addr,dBuf);

	if (status==callBackOk)
	{
		data=dBuf;
		return alsEc::ok;
	}
	else
		return alsEc::usbError;
}

t_status
CalsPrxI2cIo::read(const ul addr,uc& data)
{
	uw dBuf=0;
	t_status status;

	if (m_isVolatile)
		status = drvApi(callBackCmd::rByte,addr,dBuf);
	else
		status = emuApi(callBackCmd::rByte,addr,dBuf);

	if (status==callBackOk)
	{
		data=(uc)dBuf;
		return alsEc::ok;
	}
	else
		return alsEc::usbError;
}

t_status
CalsPrxI2cIo::readHW(const ul addr,uc& data)
{
	m_isVolatile=1;
	return read(addr,data);
}

t_status
CalsPrxI2cIo::readHW(const ul addr,uw& data)
{
	m_isVolatile=1;
	return read(addr,data);
}

t_status CalsPrxI2cIo::read(const uw addr,const uc shift,const uc mask,uc& data)
{
	t_status status;
	CalsBase::Cfunction reg;
	uw word=data;
	reg.m_addr=addr;
	reg.m_shift=shift;
	reg.m_mask=mask;
	reg.m_imask=(~mask & 0xFF);
	reg.m_isVolatile=1;
	status=read(&reg,word);
	data=(uc)word;
	return status;
}

t_status
CalsPrxI2cIo::read(const CalsBase::Cfunction* f,uw& w)
{
	t_status status=alsEc::ok;

	w=0;

	uw addr=f->m_addr;
	m_isVolatile=f->m_isVolatile;

	if (f->m_mask>0xFF)
		status=read(addr,w);
	else
		status=read(addr,(uc&)w);

	w = (w >> f->m_shift) & f->m_mask ;

	return status;
}

t_status
CalsPrxI2cIo::write(const uw addr,const uw data)
{
	uw rData=data;
	t_status status = drvApi(callBackCmd::wWord,addr,rData);

	if (status==callBackOk)
	{
		if (!m_skipDebugMap)
		{
			m_pBase->m_regmap[addr]=data & 0xff;
			m_pBase->m_regmap[addr+1]=(data >> 8) & 0xff;
		}
		return alsEc::ok;
	}
	else
		return alsEc::usbError;
}

t_status
CalsPrxI2cIo::write(const uw data)
{
	return write(m_pBase->m_cmdBase,data);
}

t_status
CalsPrxI2cIo::write(const uc data)
{
	return write(m_pBase->m_cmdBase,data);
}

t_status
CalsPrxI2cIo::write(const uw addr,const uc data)
{
	uw rData=data;
	t_status status = drvApi(callBackCmd::wByte,addr,rData);

	if (status==callBackOk)
	{
		if (!m_skipDebugMap)
			m_pBase->m_regmap[addr]=data & 0xff;
		return alsEc::ok;
	}
	else
		return alsEc::usbError;
}

t_status CalsPrxI2cIo::write(const uw addr,const uc shift,const uc mask,const uc data)
{
	CalsBase::Cfunction reg;
	reg.m_addr=addr;
	reg.m_shift=shift;
	reg.m_mask=mask;
	reg.m_imask=(~(mask << shift) & 0xFF);
	reg.m_isVolatile=1;
	return write(&reg,data);
}

t_status
CalsPrxI2cIo::write(const CalsBase::Cfunction* f,const uw w)
{
    uw addr=f->m_addr,data=m_pBase->m_regmap[addr]& 0xFF;

	if (w>f->m_mask)
		return alsEc::illegalValue;
	else
	{
		if (f->m_mask>0xFF)
			data |= (m_pBase->m_regmap[addr+1] & 0xFF) << 8;

		data=(data & f->m_imask)
			|( (w & f->m_mask) << f->m_shift );

		if (f->m_mask>0xFF)
			return write(addr,data);
		else
			return write(addr,(uc)data);
	}
}

t_status
CalsPrxI2cIo::writeI2c(const uw ia,const uw a,const uc d)
{
	uw da=m_pBase->m_ic2Addr,dummy=0;

	m_skipDebugMap=true;
	t_status retVal=pDrvApi(callBackCmd::wI2cAddr,ia,&dummy,1);

	if (retVal==callBackOk)
		write(a,d);

	pDrvApi(callBackCmd::wI2cAddr,da,&dummy,1);
	m_skipDebugMap=false;

	return alsEc::ok;
}
t_status
CalsPrxI2cIo::writeI2c(const uw ia,const uw a,const uw d)
{
	uw da=m_pBase->m_ic2Addr,dummy=0;

	m_skipDebugMap=true;
	t_status retVal=pDrvApi(callBackCmd::wI2cAddr,ia,&dummy,1);

	if (retVal==callBackOk)
		write(a,d);

	pDrvApi(callBackCmd::wI2cAddr,da,&dummy,1);
	m_skipDebugMap=false;

	return alsEc::ok;
}
t_status
CalsPrxI2cIo::readI2c(const uw ia,const uw a,uc& d)
{
	uw da=m_pBase->m_ic2Addr,dummy=0;

	m_skipDebugMap=true;
	t_status retVal=pDrvApi(callBackCmd::wI2cAddr,ia,&dummy,1);

	if (retVal==callBackOk)
		read(a,d);

	pDrvApi(callBackCmd::wI2cAddr,da,&dummy,1);
	m_skipDebugMap=false;

	return alsEc::ok;
}
t_status
CalsPrxI2cIo::readI2c(const uw ia,const uw a,uw& d)
{
	uw da=m_pBase->m_ic2Addr,dummy=0;

	m_skipDebugMap=true;
	t_status retVal=pDrvApi(callBackCmd::wI2cAddr,ia,&dummy,1);

	if (retVal==callBackOk)
		read(a,d);

	pDrvApi(callBackCmd::wI2cAddr,da,&dummy,1);
	m_skipDebugMap=false;

	return alsEc::ok;
}
