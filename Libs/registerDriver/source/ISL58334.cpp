#include "stdafx.h"
#include "ISL58334.h"
#include "alsPrxI2cIo.h"
#include "stateMachine.h"

#ifdef _WINDOWS
#pragma warning (disable:4706) // assignment within conditional expression
#endif

#ifdef _DEBUG
#define new DEBUG_NEW
#endif

using namespace alsEc;

ul (fpApi *pDrvApi2)(ul,ul,ul*,ul)=NULL;

const uc spiAddrShadow=0x37; // rerout Shadow to Actual via IOintercept serial
const uc spiAddrActual=0x38;

// hacks start

uw m_58334_enable;
uw m_Ni2cRegisters;

// hacks end

uw* getI2cRegisterAddr()
{
	static uw addrList[]={0x30,0x32,0x34,0x3C,0x38,0x3A};

	m_Ni2cRegisters=sizeof(addrList)/sizeof(addrList[0]);

	return addrList;
}

t_status Cisl58334::initI2cRegisters()
{
	// sets D-flops to outputs @ all 0's

	uw i;
	uw* addrList=getI2cRegisterAddr();

	uw i2cAddr=0;pDrvApi2(callBackCmd::rI2cAddr,0,&i2cAddr,1); // get drv i2cAddr

	for (i=0;i<m_Ni2cRegisters;i++)
	{
		pDrvApi2(callBackCmd::wI2cAddr,addrList[i],&addrList[i],1);
		m_pIO->write((uw)1,(uc)0);   // set output port to zero
		m_pIO->write((uw)2,(uc)0);   // disable invert
		m_pIO->write((uw)3,(uc)0x0); // enable output
	}

	pDrvApi2(callBackCmd::wI2cAddr,i2cAddr,&i2cAddr,1); // reset drv i2cAddr

	return alsEc::ok;
}

ul __stdcall
IOintercept(ul cmd,ul addr,uw* data,ul dSize)
{
	uc i,c=0,d=1;
	uw page[32];
	uw i2cAddr=0;
	ul status=callBackOk;

	pDrvApi2(callBackCmd::rI2cAddr,0,&i2cAddr,1);

	if (i2cAddr==spiAddrShadow) // only scramble for SPI address
	{
		if (cmd==callBackCmd::wByte)
		{
			for (i=0;i<2;i++)
			{
				page[i]=c*0xf | d*0xf0;
				c^=1;
			}
			for (;i<16;i++)
			{
				if ( (i % 2)==0 )
					d = ( (addr >> (7-i/2) ) & 1);
				page[i]=c*0xf | d*0xf0;
				c^=1;
			}
			for (;i<32;i++)
			{
				if ( (i % 2)==0 )
					d = ( (*data >> (15-i/2) ) & 1);
				page[i]=c*0xf | d*0xf0;
				c^=1;
			}

			cmd=callBackCmd::wPageBaddr;
			dSize=sizeof(page)/sizeof(page[0]);

			i2cAddr=spiAddrActual;
			pDrvApi2(callBackCmd::wI2cAddr,0,&i2cAddr,1);

			// Do a double 16 byte page to prevent addr increment

			for (i=0;i<dSize/2-2;i++)
				status=pDrvApi2(cmd,addr,&page[i],dSize/2);
			status=pDrvApi2(cmd,addr,&page[i],NULL); // ends transfer

			for (;i<dSize-2;i++)
				status=pDrvApi2(cmd,addr,&page[i],dSize/2);
			status=pDrvApi2(cmd,addr,&page[i],NULL); // ends transfer

			i2cAddr=spiAddrShadow;
			pDrvApi2(callBackCmd::wI2cAddr,0,&i2cAddr,1);

		}
	}
	else
	{
		status=pDrvApi2(cmd,addr,data,dSize);
	}

	status=callBackOk;
	return status;
}

Cisl58334::Cisl58334()
{
	m_Nchannels=2;
	m_partNumber=58334;
	m_partFamily=m_partNumber;
	m_cmdBase=1;
	m_cmdMask[0]=0x0003;// ALS State Machine Mask
	m_cmdMask[1]=0x60F0;// Proximity 0x60F8 (IRDR control removed)

	//m_cmdMask[0]=0x0607;// ALS State Machine Mask
	//m_cmdMask[1]=0x60F0;// Proximity 0x60F8 (IRDR control removed)

	setIOinterceptEnable(true);
}

Cisl58334::~Cisl58334()
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
	setIOinterceptEnable(false);
}

t_status
Cisl58334::resetDevice()
{
	PrintTrace("Cisl58334::resetDevice");

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
Cisl58334::detectDevice()
{
#pragma message (">>>>>>>>>>> JWG: Cisl58334::detectDevice <<<<<<<<<<<<<<")
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
Cisl58334::initRegisters()
{
	static ul regTable[]={0 // reserved for size (see below)
		// function       chan,addr,shift,mask (post shift)
	/*00*/	,regIdx::enable      ,0,0x01,2,0x01 // chan 0 is ALS/IR
	/*01*/	,regIdx::enable      ,1,0x01,7,0x01 // chan 1 is Proximity
	/*02*/	,regIdx::intFlag     ,0,0x02,3,0x01
	/*03*/	,regIdx::intFlag     ,1,0x02,7,0x01
	/*04*/	,regIdx::intPersist  ,0,0x02,1,0x03
	/*05*/	,regIdx::intPersist  ,1,0x02,5,0x03
	/*06*/	,regIdx::data        ,0,0x09,0,0xFFF // base for 2 bytes
	/*07*/	,regIdx::data        ,1,0x08,0,0x0FF
	/*08*/	,regIdx::threshLo    ,0,0x05,0,0xFFF // [11:8] addr-1:[7:0]
	/*09*/	,regIdx::threshLo    ,1,0x03,0,0xFF	 // prox
	/*10*/	,regIdx::threshHi    ,0,0x06,4,0xFFF // [3:0]  addr-1:[11:8]
	/*11*/	,regIdx::threshHi    ,1,0x04,0,0xFF	 // prox
        
	/*12*/	,regIdx::inputSelect ,0,0x01,0,0x01 // only valid on chan 0
	/*13*/	,regIdx::range       ,0,0x01,1,0x01 // only valid on chan 0
		// per device
	/*14*/	,regIdx::irdr        ,0,0x01,3,0x01
	/*15*/	,regIdx::sleep       ,0,0x01,4,0x07
	/*16*/	,regIdx::intLogic    ,0,0x02,0,0x01
	/*17*/	,regIdx::test1       ,0,0x0E,0,0x30
	/*18*/	,regIdx::test2       ,0,0x0F,0,0x29
		};

	regTable[0]=sizeof(regTable)/sizeof(regTable[0])-1;
	m_regTable=(uw*)regTable;

    m_reg=new CfunctionList(m_regTable);

	m_reg->m_intFlag[0].m_isVolatile=1;
	m_reg->m_intFlag[1].m_isVolatile=1;
	m_reg->m_data[0].m_isVolatile=1;
	m_reg->m_data[1].m_isVolatile=1;

	CalsBase::initRegisters();

	setPdataStats(0);// set initial pointer

	initI2cRegisters();
	setEnable(0,0); // set to channel 0

	return ok;
}

t_status
Cisl58334::initCalibration()
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
Cisl58334::initInputSelect()
{
	static const char* inputSelect[]={"ALS " // ____________
									 ,"IR  " // Input Select
									 };      // ============

	m_NinputSelect=sizeof(inputSelect)/sizeof(inputSelect[0]);
	m_inputSelectList=(char**)inputSelect;
	return ok;
}

t_status
Cisl58334::setInputSelect(const uw c,const uw v)
{
	t_status status;

	if (c<m_Nchannels)
	{
		if (!c) // 1st channel
		{
			if (ok==(status=m_pIO->write(&m_reg->m_inputSelect[c],v)))
			{
				m_inputSelectN=v;
				return setPdataStats(c);
			}
			return status;
		}
		else 
		{
			if (c>m_NinputSelect)
				return illegalChannel;
			else
			{
				if (!v)
					return ok;
				else
					return illegalValue;
			}
		}
	}
	else
		return illegalChannel;
}

t_status
Cisl58334::getInputSelect(const uw c,uw& v)
{
	t_status status;

	if (c<m_Nchannels)
	{
		if (!c) // must be 1st channel
		{
			status=m_pIO->read(&m_reg->m_inputSelect[c],v);
			return status;
		}
		else
		{
			v=0;
			return ok;
		}
	}
	else
		return illegalChannel;

}

t_status
Cisl58334::initRange()
{
	t_status result=ok;

	static uw rng[]={125  // Define range list here
			        ,2000 // ======================
			        };
	m_Nrange=sizeof(rng)/sizeof(rng[0]);
	m_rangeList=rng;

	return result;
}

t_status 
Cisl58334::setRange(const uw c,const uw r)
{
	t_status status=ok;

        if (c<m_Nchannels)
        {
			if (r<m_Nrange)
			{
				if (c)
					return notImplemented;
				else
				{
					if (ok==(status=m_pIO->write(&m_reg->m_range[c],r)))
					{
						m_rangeN=r;
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
Cisl58334::initResolution()
{
	static uw res[]={4095  // _______________
	                   };  // Resolution list
			               // ===============
	m_Nresolution=sizeof(res)/sizeof(res[0]);
	m_resolutionList=res;
	return ok;
}

t_status
Cisl58334::getNresolution(const uw c,uw& v)
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
Cisl58334::getResolutionList(const uw c,uw* v)
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
Cisl58334::getResolution(uw& v)
{
	return getResolution(0,v);
}

t_status
Cisl58334::getResolution(const uw c,uw& v)
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

	// ____
	// Irdr
	// ====

t_status
Cisl58334::initIrdr()
{
	static uw irdr[]={110 // _________
					 ,220 // Irdr list
					 };   // =========

	m_Nirdr=sizeof(irdr)/sizeof(irdr[0]);
	m_irdrList=irdr;
	return ok;
}

	// ______
	// Enable
	// ======

t_status
Cisl58334::getEnable(const uw c,uw& v)
{
	if (c!=0)
	{
		if (v>31)
			return alsEc::illegalValue;
		else
		{	
			v=m_58334_enable;

			return alsEc::ok;
		}
	}
	else
		return alsEc::illegalChannel;
}

t_status
Cisl58334::setEnable(const uw c,const uw v)
{
	uc amux=3,async=1,byte=0,din=1,sclk=1;
	uw* regAddr=getI2cRegisterAddr();
	int i;

	if (c==0)
	{
		if (v>31)
			return alsEc::illegalValue;
		else
		{	
			m_58334_enable=v;
			amux *= ((uc)v>>4); // DPDT
			uw i2cAddr=0;pDrvApi2(callBackCmd::rI2cAddr,0,&i2cAddr,1); // get drv i2cAddr
			pDrvApi2(callBackCmd::wI2cAddr,regAddr[5],&regAddr[5],1);

			// start/stop state
			byte= ((async*3)<<4) | (din<<3) | (sclk<<2) | amux;
			m_pIO->write((uw)1,byte); // U38, output port

			// start sequence here
			async=0;
			for (i=7;i<0;i--)
			{
				for (sclk=0;sclk<1;sclk++)
				{
					din=(v>>i) & 1;
					byte= ((async*3)<<4) | (din<<3) | (sclk<<2) | amux;
					m_pIO->write((uw)1,byte); // U38, output port 
				}
			}
			async=1;din=1;
			byte= ((async*3)<<4) | (din<<3) | (sclk<<2) | amux;
			m_pIO->write(regAddr[5],byte); // U38

			pDrvApi2(callBackCmd::wI2cAddr,i2cAddr,&i2cAddr,1); // reset drv i2cAddr

			return alsEc::ok;
		}
	}
	else
		return alsEc::illegalChannel;
}

t_status
Cisl58334::getData(const uw c,uw &v)
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
Cisl58334::setMpaSize(const ul c,const ul v)
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
Cisl58334::getDataStats(const uw c,double &v, double &m, double &s)
{
#pragma message ("JWG:Cisl58334::getDataStats")
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
Cisl58334::setThreshHi(const uw c,const uw v)
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
Cisl58334::getThreshHi(const uw c,uw& v)
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
Cisl58334::setThreshLo(const uw c,const uw v)
{
	if (c<m_Nchannels)
		return m_pIO->write(&m_reg->m_threshLo[c],v);
	else
		return illegalChannel;
}

t_status
Cisl58334::getThreshLo(const uw c,uw& v)
{
	if (c<m_Nchannels)
		return m_pIO->read(&m_reg->m_threshLo[c],v);
	else
		return illegalChannel;
}

t_status
Cisl58334::getIntFlag(const uw c,uw& v)
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

	// _____
	// Sleep
	// =====

t_status
Cisl58334::initSleep()
{
	static uw res[]={800 // __________
	                ,400 // Sleep list
					,200 // ==========
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
Cisl58334::getNsleep(ul& v)
{
	v=m_Nsleep;
	return ok;
}

t_status
Cisl58334::getSleepList(ul* v)
{
	memcpy(v,m_sleepList,m_Nsleep*sizeof(m_sleepList[0]));
	return ok;
}

t_status
Cisl58334::getSleep(uw& v)
{
	return m_pIO->read(&m_reg->m_sleep[0],v);
}

t_status
Cisl58334::setSleep(const uw v)
{
	return m_pIO->write(&m_reg->m_sleep[0],v);
}

	// ________
	// IntLogic
	// ========

t_status
Cisl58334::getIntLogic(uw& v)
{
	return m_pIO->read(&m_reg->m_intLogic[0],v);
}

t_status
Cisl58334::setIntLogic(const uw v)
{
	return m_pIO->write(&m_reg->m_intLogic[0],v);
}

t_status
Cisl58334::setPdataStats(const ul c)
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
Cisl58334::setLux(const dbl c)
{
	t_status status;

	dbl lux=0.0,m=0.0;

	if ((status=m_pDataStats[0]->getGain(m)))
		return status;
	if ((status=getLux(lux)))
		return status;
	m*=(c/lux);
	return m_pDataStats[0]->setGain(m);
}

t_status
Cisl58334::preStateIntMask(const uw chan,CstateMachine* state)
// called prior to changing input to prevent int "flicker" during stream change
// Note: sign bit position is fixed, magnitude is lsb justified
{
	t_status status=alsEc::ok;

	if (chan>1)
		return alsEc::illegalChannel;

	switch ((state->m_type))
	{
		case alsType::prx:
		case alsType::ir:
			break;
		case alsType::als:
			if ((status=setThreshHi(chan,(uw)0xFFF)))
				return status;
			if ((status=setThreshLo(chan,(uw)0x000)))
				return status;
			break;
		default:
			return alsEc::illegalChannel;
	}
return status;
}

t_status
Cisl58334::initAlsStateMachine()
{
	t_status status=alsEc::ok;
	uw chan=0;

	CstateMachine::Cstate tbl[]={
#if 1
		{0,0,    0.0,   10.5,0,0,0,0,&m_alsState},// Reference Manual Example
		{1,0,    9.5,  105.0,0,0,0,0,&m_alsState},
		{2,0,   95.0,  120.0,0,0,0,0,&m_alsState},
		{2,0,  110.0, 1050.0,0,0,0,0,&m_alsState},
		{3,0,  950.0,99999.9,0,0,4,0,&m_alsState}
#else
		{0,0,    0.0,   10.5,0,0,&m_irState},// Reference Manual Example
		{1,0,    9.5,  105.0,0,0,&m_irState},
		{2,0,   95.0,  120.0,0,0,&m_irState},
		{2,0,  110.0, 1050.0,0,0,&m_irState},
		{3,0,  950.0,99999.9,4,0,&m_irState}
#endif
	};
	size_t i,tblSz=sizeof(tbl)/sizeof(tbl[0]);

	m_alsState=new CstateMachine(chan,tblSz,alsType::als,m_stateMachineEnabled);
	m_alsState->m_state=new CstateMachine::Cstate[tblSz];
	memcpy(m_alsState->m_state,tbl,sizeof(tbl));

	m_alsState->setMask(m_cmdMask[chan]);

	uw intPersist=0;
	m_alsState->m_cycles=2*(1<<intPersist);
	setIntPersist(chan,intPersist);

	//setInputSelect(chan,alsType::als);
	setEnable(chan,1);
	setRange(chan,0);

	for (i=0;i<tblSz;i++)
	{
		if (i)
			m_alsState->m_state[i].m_lExit=i-1;

		if (i<tblSz-1)
			m_alsState->m_state[i].m_hExit=i+1;

		if (i==3)
			setRange(chan,1);

		if (m_alsState->m_state[i].m_tL <= 0.0)
			m_pDataStats[0]->getReal(0x0000,m_alsState->m_state[i].m_tL);

		if (m_alsState->m_state[i].m_tH >= 99999.9)
			m_pDataStats[0]->getReal(0xFFF,m_alsState->m_state[i].m_tH);

		m_alsState->m_state[i].m_cmd= m_regmap[m_cmdBase] | (m_regmap[m_cmdBase+1] << 8);
	}

	return status;
}

t_status
Cisl58334::initProximityStateMachine()
{
	t_status status=alsEc::ok;
	uw chan=1;

	CstateMachine::Cstate tbl[]={
#if 1
		{0,0,0.00,0.55,0,0,0,0,&m_prxState}, // Near - Far ship version
		{1,0,0.45,1.00,0,0,0,0,&m_prxState}
#else
#endif
	};
	size_t i,tblSz=sizeof(tbl)/sizeof(tbl[0]);

	m_prxState=new CstateMachine(chan,tblSz,alsType::prx,m_stateMachineEnabled);
	m_prxState->m_state=new CstateMachine::Cstate[tblSz];
	memcpy(m_prxState->m_state,tbl,sizeof(tbl));

	m_prxState->setMask(m_cmdMask[chan]);

	m_prxState->m_cycles=2;

	setEnable(chan,1);

	setIrdr(0);// 110ma
	setSleep(7);//100ms

	setRange(chan,0);
	setIntPersist(chan,0);

	setPdataStats(chan);

	for (i=0;i<tblSz;i++)
	{
		if (tblSz>1)
		{
			if (i)
				m_prxState->m_state[i].m_lExit=i-1;

			if (i<tblSz-1)
				m_prxState->m_state[i].m_hExit=i+1;
		}

		if (m_prxState->m_state[i].m_tL <= 0.0)
			m_pDataStats[chan]->getReal(0x00,m_prxState->m_state[i].m_tL);

		if (m_prxState->m_state[i].m_tH >= 1.0)
			m_pDataStats[chan]->getReal(0xFF,m_prxState->m_state[i].m_tH);

		m_prxState->m_state[i].m_cmd= m_regmap[m_cmdBase] | (m_regmap[m_cmdBase+1] << 8);
	}

	return status;
}

t_status
Cisl58334::initIrStateMachine()
{
	t_status status=alsEc::ok;
	uw chan=0;

	CstateMachine::Cstate tbl[]={
#if 1
		{0,0,0.00,0.90,0,0,0,0,&m_alsState},
		{0,0,0.10,1.00,0,0,1,0,&m_alsState}
#else
		0,0,0.00,0.55,2,0,0,&m_alsState,
		1,0,0.45,1.00,2,0,0,&m_alsState,
#endif
	};
	size_t i,tblSz=sizeof(tbl)/sizeof(tbl[0]);

	m_irState=new CstateMachine(chan,tblSz,alsType::ir,m_stateMachineEnabled);
	m_irState->m_state=new CstateMachine::Cstate[tblSz];
	memcpy(m_irState->m_state,tbl,sizeof(tbl));

	m_irState->m_cycles=2;

	setInputSelect(chan,alsType::ir);
	setEnable(chan,1);
	setRange(chan,0);

	for (i=0;i<tblSz;i++)
	{
		if (i==1)
			setRange(chan,1);

		if (tblSz>1)
		{
			if (i)
				m_irState->m_state[i].m_lExit=i-1;

			if (i<tblSz-1)
				m_irState->m_state[i].m_hExit=i+1;
		}
		if (m_irState->m_state[i].m_tL <= 0.0)
			m_pDataStats[0]->getReal(0x0000,m_irState->m_state[i].m_tL);

		if (m_irState->m_state[i].m_tH >= 1.0)
			m_pDataStats[0]->getReal(0xFFFF,m_irState->m_state[i].m_tH);

		m_irState->m_state[i].m_cmd= m_regmap[m_cmdBase] | (m_regmap[m_cmdBase+1] << 8);
	}

	return status;
}

t_status
Cisl58334::measureConversionTime(uw& alsConversionTime)
{
#if 0
	// Test code for measuring Sleep time
	int i;
	uw intFlag,flagCount=0;
	clock_t thisTime=0,lastTime=clock();

	setEnable(0,0);// als off
	setEnable(1,0);// prx off
	CalsBase::setThreshHi(1,0.0);// hi on
	CalsBase::setThreshLo(1,0.0);// lo off
	setIntPersist(1,0);// persist off
	getIntFlag(1,intFlag);
	setSleep(5);// VB not fast enough for less than 50ms (~13)
	setEnable(1,1);// prx on

	for (i=0;i<2000/1;i++)
	{
		getIntFlag(1,intFlag);
		if (intFlag)
			if ( (++flagCount) >= 100/1)
				break;
	}
	thisTime=clock();

	if (flagCount)
		alsConversionTime=(thisTime-lastTime)/flagCount*1000/CLOCKS_PER_SEC;
#endif
	return CalsBase::measureConversionTime(alsConversionTime);
}

t_status
Cisl58334::setIOinterceptEnable (bool enable)
{
	if (enable)
	{
		if (pDrvApi!=NULL)
		{
			pDrvApi2=pDrvApi;
			pDrvApi=&IOintercept;
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
