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

	if (!t0)
		t0=clock();

	fprintf(m_file,"%08.3f:",((dbl)clock()-(dbl)t0)/ ((dbl)CLOCKS_PER_SEC));

	switch (rw)
	{
	case callBackCmd::rWord:fprintf(m_file,"%s:R:0x%02X:%04X",s,a,d);break;
	case callBackCmd::rByte:fprintf(m_file,"%s:R:0x%02X:%02X",s,a,d);break;
	case callBackCmd::wWord:fprintf(m_file,"%s:W:0x%02X:%04X",s,a,d);break;
	case callBackCmd::wByte:fprintf(m_file,"%s:W:0x%02X:%02X",s,a,d);break;
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

	if ( (pDrvApi) && (m_disableIO!=true) )
	{
		if (m_pBase->m_byteIoOnly)
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
					retVal=pDrvApi(rw,a,&d,1);
				}
			}
			
		}
		else
		{
			retVal=pDrvApi(rw,a,&d,1);
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

t_status CalsPrxI2cIo::read(const uw addr,const uc shift,const uw mask,uc& data)
{
	t_status status;
	bitField tmpReg(addr,shift,mask);
	uw word=data;
	status=read(&tmpReg,word);
	data=(uc)word;
	return status;
}

t_status
CalsPrxI2cIo::read(const bitField* f,uw& w)
{
	t_status status=alsEc::ok;

	w=0;

	uw addr=f->addr;

	if (f->mask>0xFF)
		status=read(addr,w);
	else
		status=read(addr,(uc&)w);

	w = (w >> f->shift) & f->mask ;

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

t_status CalsPrxI2cIo::write(const uw addr,const uc shift,const uw mask,const uc data)
{
	bitField reg(addr,shift,mask);
	return write(&reg,data);
}

t_status
CalsPrxI2cIo::write(const bitField* f,const uw w)
{
    uw addr=f->addr,data=m_pBase->m_regmap[addr]& 0xff;
	//uc data=0;read(addr,data);

	uw imask;
	if (f->mask > 0xff)
	{
		imask = ( (f->mask << f->shift) ^ 0xffff ) & 0xffff;
	}
	else
	{
		imask = ( (f->mask << f->shift) ^ 0xff ) & 0xff;

	}

	if (w>f->mask)
		return alsEc::illegalValue;
	else
	{
		if (f->mask>0xff)
			data |= (m_pBase->m_regmap[addr+1] & 0xFF) << 8;

		data=(data & imask)
			|( (w & f->mask) << f->shift );

		if (f->mask>0xff)
			return write(addr,data);
		else
			return write(addr,(uc)data);
	}
}

