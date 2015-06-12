// registerDriver.cpp : Defines the initialization routines for the DLL.
//

#include "stdafx.h"
#include "TSL2771.h"
#include "alsPrxI2cIo.h"
//#include <windows.h>

#ifdef _WINDOWS
#pragma warning (disable:4996) // allow strcpy
#endif

#ifdef _DEBUG
#define new DEBUG_NEW
#endif

extern CalsBase* pCalsBase;

using namespace alsEc;

Ctsl2771::Ctsl2771()
{
	m_Nchannels=2;
	m_partNumber=2771;
	m_ic2Addr=0x72;
	m_deviceBaseAddr=0xA0;
	m_stateMachineEnabled=false;
}

Ctsl2771::~Ctsl2771()
{
	if (m_regmap)
	{
		delete m_regmap;
		m_regmap=0;
	}

	if (m_reg)
	{
		delete m_reg;
		m_reg=0;
	}
}

t_status
Ctsl2771::detectDevice()
{
	uc d0,d1,addr=0x11;

	m_pIO->readHW(addr,d0);
	if (d0)
	{
		m_pIO->write(addr,(uc)0);
		m_pIO->read (addr,d1);
		if (d1)
		{
			if (d0!=d1)
				m_pIO->write(addr,d0);
			return ok;
		}
		else
			return driverError;
	}
	else
		return driverError;

}
t_status
Ctsl2771::initRegisters()
{
	static ul regTable[]={0 // reserved for size (see below)
		// function       chan,addr,shift,mask (post shift)
	/*00*/	,regIdx::enable      ,0,0x00,1,0x01 // chan 0 is ALS/IR
	/*01*/	,regIdx::enable      ,1,0x00,2,0x01 // chan 1 is Proximity
	/*02*/	,regIdx::intFlag     ,0,0x02,3,0x01
	/*03*/	,regIdx::intFlag     ,1,0x02,7,0x01
	/*04*/	,regIdx::intPersist  ,0,0x02,1,0x03
	/*05*/	,regIdx::intPersist  ,1,0x02,5,0x03
	/*06*/	,regIdx::data        ,0,0x14,0,0xFFFF // base for 2 bytes
	/*07*/	,regIdx::data        ,1,0x18,0,0x03FF
	/*08*/	,regIdx::threshLo    ,0,0x05,0,0xFFF // [11:8] addr-1:[7:0]
	/*09*/	,regIdx::threshLo    ,1,0x03,0,0xFF	 // prox
	/*10*/	,regIdx::threshHi    ,0,0x06,4,0xFFF // [3:0]  addr-1:[11:8]
	/*11*/	,regIdx::threshHi    ,1,0x04,0,0xFF	 // prox
        
	///*12*/	,regIdx::inputSelect ,0,0x01,0,0x01 // only valid on chan 0
	///*12*/	,regIdx::inputSelect ,1,0x0F,4,0x03 // only valid on chan 0
	/*13*/	,regIdx::range       ,0,0x0F,0,0x03 // only valid on chan 0
		// per device
	/*14*/	,regIdx::irdr        ,0,0x0F,6,0x03
	/*15*/	,regIdx::sleep       ,0,0x03,4,0x07
	/*16*/	,regIdx::intLogic    ,0,0x02,0,0x01

	/*08*/	,regIdx::resolution  ,0,0x01,0,0x000F
		};


	regTable[0]=sizeof(regTable)/sizeof(regTable[0])-1;

	m_regTable=(ul*)regTable;

    m_reg=new CfunctionList(m_regTable);

	m_reg->m_intFlag[0].m_isVolatile=1;
	m_reg->m_intFlag[1].m_isVolatile=1;
	m_reg->m_data[0].m_isVolatile=1;
	m_reg->m_data[1].m_isVolatile=1;

	m_Nreg=0x1A;

	CalsBase::initRegisters();

	ul i;

	i=0x0; m_pIO->write(i,m_regmap[i] | 0xF); // power on
	i=0x1; m_pIO->write(i,              (uc)0xC0); // ALS: 65535 in 174ms
	i=0x2; m_pIO->write(i,(uc)(m_regmap[i] | 0xFF)); // Prox time
	i=0x3; m_pIO->write(i,(uc)(m_regmap[i] | 0xFF)); // Wait time
	i=0xE; m_pIO->write(i,              (uc)0x01); // Proximity Pulse count
	i=0xF; m_pIO->write(i,              (uc)0x22); // IRDR, Diode, ALS Gain

	return ok;
}

	// ___________
	// InputSelect
	// ¯¯¯¯¯¯¯¯¯¯¯

t_status
Ctsl2771::initInputSelect()
{
	static char* inputSelect[]={"ALS " // ____________
		                       ,"IR  " // Input Select
	                           };      // ¯¯¯¯¯¯¯¯¯¯¯¯

	m_NinputSelect=sizeof(inputSelect)/sizeof(inputSelect[0]);
	m_inputSelectList=inputSelect;

	static char* inputSelect1[]={"CLR   "   // _____________
		                        ,"IR    "   // Input Select1
	                            ,"CLR&IR"}; // ¯¯¯¯¯¯¯¯¯¯¯¯¯

	m_NinputSelect1=sizeof(inputSelect1)/sizeof(inputSelect1[0]);
	m_inputSelectList1=inputSelect1;

	return ok;
}

t_status
Ctsl2771::getNinputSelect(const ul c,ul& v)
{
	if (c<m_Nchannels)
	{
		if (c)
			v=m_NinputSelect1;
		else
			v=m_NinputSelect;
		return ok;
	}
	else
		return illegalChannel;
}

t_status
Ctsl2771::getInputSelectList(const ul c,char* v)
{
	ul i,j=0;
	if (c<m_Nchannels)
	{
		if (c)
			for (i=0;i<m_NinputSelect1;i++)
			{
				strcpy((v+j),m_inputSelectList1[i]);
				j+=(strlen(m_inputSelectList1[i])+1);
			}
		else
			for (i=0;i<m_NinputSelect;i++)
			{
				strcpy((v+j),m_inputSelectList[i]);
				j+=(strlen(m_inputSelectList[i])+1);
			}
		return ok;
	}
	else
		return illegalChannel;
}

t_status
Ctsl2771::setInputSelect(const ul c,const ul v)
{
#if 1 then
	return ok;
#else
	if (c<m_Nchannels)
	{
		if (c)
			return m_pIO->write(&m_reg->m_inputSelect[c],v+1);
		else
			return m_pIO->write(&m_reg->m_inputSelect[c],v);
	}
	else
		return illegalChannel;
#endif
}

t_status
Ctsl2771::getInputSelect(const ul c,ul& v)
{
	t_status status;

	if (c<m_Nchannels)
	{
		status=m_pIO->read(&m_reg->m_inputSelect[c],v);
		if (c)
			v--;
		return status;
	}
	else
		return illegalChannel;

}

t_status
Ctsl2771::initRange()
{
	t_status result=ok;

	static ul rng[]={1  // Define range list here
			        ,8  // ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
			        ,16
			        ,120
			        };
	m_Nrange=sizeof(rng)/sizeof(rng[0]);
	m_rangeList=rng;

	return result;
}

	// __________
	// Resolution
	// ¯¯¯¯¯¯¯¯¯¯

t_status
Ctsl2771::initResolution()
{
	static ul res[]={65535 // _______________
	                ,37888 // Resolution list
			        ,10240 // ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
					,1024};
	m_Nresolution=sizeof(res)/sizeof(res[0]);
	m_resolutionList=res;
	return ok;
}

t_status
Ctsl2771::getNresolution(const ul c,ul& v)
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
Ctsl2771::getResolutionList(const ul c,ul* v)
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
Ctsl2771::getResolution(ul& v)
{
	return getResolution(0,v);
}

t_status
Ctsl2771::getResolution(const ul c,ul& v)
{
	if (c<m_Nchannels)
	{
		t_status status = m_pIO->read(&m_reg->m_resolution[0],v);
		m_resolutionN=v;
		return status;
	}
	else
		return illegalChannel;
}

t_status
Ctsl2771::setResolution(const ul v)
{
	return setResolution(0,v);
}
t_status
Ctsl2771::setResolution(const ul c,const ul v)
{
	if (c<m_Nchannels)
		
		switch (v)
		{
		case 0:return m_pIO->write(m_reg->m_resolution[0].m_addr,(uc)0xc0);
		case 1:return m_pIO->write(m_reg->m_resolution[0].m_addr,(uc)0xdb);
		case 2:return m_pIO->write(m_reg->m_resolution[0].m_addr,(uc)0xf6);
		case 3:return m_pIO->write(m_reg->m_resolution[0].m_addr,(uc)0xff);
		default:return illegalValue;
		}
		
	else
		return illegalChannel;
}

	// ____
	// Irdr
	// ¯¯¯¯

t_status
Ctsl2771::initIrdr()
{
	static ul irdr[]={100 // _________
					 ,50  // Irdr list
					 ,25  // ¯¯¯¯¯¯¯¯¯
					 ,12};

	m_Nirdr=sizeof(irdr)/sizeof(irdr[0]);
	m_irdrList=irdr;
	return ok;
}

	// ______
	// Enable
	// ¯¯¯¯¯¯

t_status
Ctsl2771::getEnable(const ul c,ul& v)
{
	if (c<m_Nchannels)
		return m_pIO->read(&m_reg->m_enable[c],v);
	else
		return illegalChannel;
}

t_status
Ctsl2771::setEnable(const ul c,const ul v)
{
	if (c<m_Nchannels)
		if (v>m_reg->m_enable[c].m_mask)
			return illegalValue;
		else
			return m_pIO->write(&m_reg->m_enable[c],v);
	else
		return illegalChannel;
}

t_status
Ctsl2771::getData(const ul c,ul &v)
{
	t_status status;

	if (c<m_Nchannels)
	{
		if ((status=m_pIO->read(&m_reg->m_data[c],v)))
			return status;

		m_lastTime=clock();

		if ((status=setPdataStats(c)))
			return status;

		return m_pDataStats[c]->setData(v);
	}
	else
		return illegalChannel;
}

t_status
Ctsl2771::setMpaSize(const ul c,const ul v)
{
	if (c<m_Nchannels)
	{
		if (c) 
			return m_dataStats[c].setMpaSize(v);
		else
			return m_dataStats[0].setMpaSize(v);
	}
	else
		return illegalChannel;
}

t_status
Ctsl2771::getDataStats(const ul c,double &v, double &m, double &s)
{
	//if (c<m_Nchannels)
	//{
	//	ul data;
	//	t_status status = getData(c,data);

	//	v=(double)data;

	//	if (c) 
	//		m_dataStats[c].avgStats(v,m,s);
	//	else
	//		m_dataStats[0].avgStats(v,m,s);

	//	return status;
	//}
	//else
	//	return illegalChannel;
	return ok;
}


t_status
Ctsl2771::setThreshHi(const ul c,const ul v)
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
				return m_pIO->write(addr,(uw)data);
			}

		case 1:  return m_pIO->write(&m_reg->m_threshHi[c],v);

		default: return driverError;
		}
	}
	else
		return illegalChannel;
}

t_status
Ctsl2771::getThreshHi(const ul c,ul& v)
{
	t_status status;

	if (c<m_Nchannels)
	{
		ul addr,data; 

		switch (c)
		{
		case 0:  addr=m_reg->m_threshHi[c].m_addr;
				 status=m_pIO->read(addr,(uw)data);
				 v  = m_regmap[addr]   >> m_reg->m_threshHi[c].m_shift;
				 v |= m_regmap[addr+1] << m_reg->m_threshHi[c].m_shift;
				 return status;

		case 1:  return m_pIO->read(&m_reg->m_threshHi[c],v);

		default: return driverError;
		}
	}
	else
		return illegalChannel;
}

t_status
Ctsl2771::setThreshLo(const ul c,const ul v)
{
	if (c<m_Nchannels)
	{
		ul addr,data; 

		switch (c)
		{
		case 0:
			if (v>m_reg->m_threshLo[c].m_mask)
				return illegalValue;
			else
			{
				addr=m_reg->m_threshLo[c].m_addr;
				data  = m_regmap[addr] & 0xFF;
				data |= (m_regmap[addr+1] & 0xFF) << 8;
				data &=  m_reg->m_threshLo[c].m_imask;
				data |= v << m_reg->m_threshLo[c].m_shift;
				return m_pIO->write(addr,(uw)data);
			}

		case 1:  return m_pIO->write(&m_reg->m_threshLo[c],v);

		default: return driverError;
		}
	}
	else
		return illegalChannel;
}

t_status
Ctsl2771::getThreshLo(const ul c,ul& v)
{
	t_status status;

	if (c<m_Nchannels)
	{
		switch (c)
		{
		case 0:  status=m_pIO->read(m_reg->m_threshLo[c].m_addr,(uw)v);
				 v  &= m_reg->m_threshLo[c].m_mask;
				 return status;

		case 1:  return m_pIO->read(&m_reg->m_threshLo[c],v);

		default: return driverError;
		}
	}
	else
		return illegalChannel;
}

t_status
Ctsl2771::getIntFlag(const ul c,ul& v)
{
	if (c<m_Nchannels)
	{
		t_status status=m_pIO->read(&m_reg->m_intFlag[c],v);
		if (status && v)
			return status;
		else
		{
			ul addr=m_reg->m_intFlag[c].m_addr;
			return m_pIO->write(addr,m_regmap[addr] & m_reg->m_intFlag[c].m_imask);
		}
	}
	else
		return illegalChannel;
}

	// _____
	// Sleep
	// ¯¯¯¯¯

t_status
Ctsl2771::initSleep()
{
	static ul res[]={800 // __________
	                ,400 // Sleep list
					,200 // ¯¯¯¯¯¯¯¯¯¯
					,100
					,75
					,25
					,12
					,0};
	m_Nsleep=sizeof(res)/sizeof(res[0]);
	m_sleepList=res;
	return ok;
}

t_status
Ctsl2771::getNsleep(ul& v)
{
	v=m_Nsleep;
	return ok;
}

t_status
Ctsl2771::getSleepList(ul* v)
{
	memcpy(v,m_sleepList,m_Nsleep*sizeof(m_sleepList[0]));
	return ok;
}

t_status
Ctsl2771::getSleep(ul& v)
{
	return m_pIO->read(&m_reg->m_sleep[0],v);
}

t_status
Ctsl2771::setSleep(const ul v)
{
	return m_pIO->write(&m_reg->m_sleep[0],v);
}

	// ________
	// IntLogic
	// ¯¯¯¯¯¯¯¯

t_status
Ctsl2771::getIntLogic(ul& v)
{
	return m_pIO->read(&m_reg->m_intLogic[0],v);
}

t_status
Ctsl2771::setIntLogic(const ul v)
{
	return m_pIO->write(&m_reg->m_intLogic[0],v);
}

t_status
Ctsl2771::resetDevice()
{
	return alsEc::ok;
}

t_status
Ctsl2771::measureConversionTime(uw& alsConversionTime)
{
	alsConversionTime=100;
	return alsEc::ok;
}

t_status
Ctsl2771::initCalibration()
{
	uw c,i,r,addr;
	dbl m;

	class Cdb{public:dbl m;dbl b;} db[8];

	m_dataStats[0].setNominal(1.0/0xffff);
	m_dataStats[1].setNominal(1.0/0x03ff);
	
	
	//for (c=0;c<2;c++)
	//{
	//	for (i=0;i<2;i++)
	//	{
	//		for (r=0;r<2;r++)
	//		{
	//			// channel,input, range
	//			if (c==0)// ALS/IR
	//			{
	//				if (i==0)//ALS
	//					m=(dbl)m_rangeList[r]/(dbl)m_resolutionList[0];
	//				else     //IR
	//					m=(dbl)m_rangeList[r]/(dbl)m_resolutionList[0];
	//			}
	//			else//Proximity (and don't care)
	//				m=1.0/(dbl)0x3FF;

	//			m_dataStats[c][i][r].setNominal(m);
	//			m_dataStats[c][i][r].setState(addr=c<<2|i<<1|r);

	//			m_dataStats[c][i][r].getNominal(db[addr].m);
	//			m_dataStats[c][i][r].getOffset(db[addr].b);
	//		}
	//	}
	//}

	return ok;
}

t_status
Ctsl2771::setPdataStats(const ul c)
{
	m_pDataStats[c]=&m_dataStats[c];

	//if (c)
	//	m_pDataStats[c]=&m_dataStats[c][0][0];
	//else
	//{
	//	m_inputSelectN=m_regmap[1] & 1;
	//	m_rangeN=(m_regmap[1]>>1) & 1;
	//	m_pDataStats[c]=&m_dataStats[c][m_inputSelectN][m_rangeN];
	//}

	return ok;
}

t_status
Ctsl2771::getLux(double &lux)
{
	t_status status=ok;

	double aTime=0,aGain=0,cpl=0,lux1=0,lux2=0;

	uw c0data=0,c1data=0;
	uc cData=0,cData0=0;

	lux=0;

	// ALS timing register
	status=pCalsBase->m_pIO->readHW(0x01,cData);

	if (status==ok)
	{
		aTime=2.72*((cData ^ 0xff)+1.0);
		// Control register
		status=pCalsBase->m_pIO->readHW(0x0F,cData);
	}

	if (status==ok)
	{
		cData &= 3;

		switch (cData)
		{
		case 0:aGain=1;  break;
		case 1:aGain=8;  break;
		case 2:aGain=16; break;
		case 3:aGain=120;break;
		}

		cpl=(aTime*aGain)/24.0;

		status=pCalsBase->m_pIO->readHW(0x14,c0data);
		//pCalsBase->m_pIO->read(0x14,cData);
		//pCalsBase->m_pIO->read(0x15,cData0);
	}

	if (status==ok)
	{
		status=pCalsBase->m_pIO->readHW(0x16,c1data);
		//pCalsBase->m_pIO->read(0x16,cData);
		//pCalsBase->m_pIO->read(0x17,cData0);
	}

	if (status==ok)
	{
		lux1=(c0data-2*c1data)/cpl;
		lux2=(0.6*c0data-c1data)/cpl;
		if (lux1>lux2)
		{
			if (lux1>0)
			{
				lux=lux1;
			}
		}
		else
		{
			if (lux2>0)
			{
				lux=lux2;
			}
		}
			
	}

	return status;
}
