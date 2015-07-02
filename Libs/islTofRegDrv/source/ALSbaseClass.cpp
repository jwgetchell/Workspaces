#include "stdafx.h"
#include "ALSbaseClass.h"
#include "alsPrxI2cIo.h"
#include "avgStats.h"

using namespace alsEc;

__inline double _Sqrt(double y)
{
	double x=y/2,dy,dx;

	if (y<=0)
		return 0;

	do
	{
		dy=y-x*x;
		dx=dy/(2*x);
		x+=dx;
	} while (dy*dy/y>1e-20);

return x;
}

uc dbl2smb(const dbl dIn)
{
	if (dIn<-1) return 0;
	if (1<dIn)  return 0;

	if (dIn<0)
	{
		return (uc)(-dIn*127) | 0x80;
	}
	else
	{
		return (uc)(dIn*127);
	}
}

uc dbl2signed(const dbl dIn)
{
	if (dIn<-1) return 0;
	if (1<dIn)  return 0;

	if (dIn<0)
	{
		return (uc)(128+dIn*127);
	}
	else
	{
		return (uc)(dIn*127);
	}
}

t_status
CalsBase::setAmbientCoeffs(const uw exp,const dbl c1,const dbl c2)
	// exp, c1, c2 are calculated values based on corr(degrees) = c1*amb(dec)+(c2/128)*amb(dec)^2
{
	t_status status=alsEc::ok;
	m_pReg->openLoopCorrectionRegisters->ol_phase_co_exp->write (exp+7); // shift exp by 7
	m_pReg->openLoopCorrectionRegisters->ol_phase_amb_co1->write(dbl2signed(c1));
	m_pReg->openLoopCorrectionRegisters->ol_phase_amb_co2->write(dbl2signed(c2));
	return status;
}

CalsBase::CalsBase()
:m_Nreg(defaultRegMapSize)
,m_byteIoOnly(false)
,m_regmap(0)
,m_IOinterceptEnabled(false)
{
	m_pReg=new Creg(this);
	analogControlRegisters= new CanalogControlRegisters(this);

	m_pDataStats[0]=0;
	m_pDataStats[1]=0;
	m_pIO = new CalsPrxI2cIo(this);
}
CalsBase::~CalsBase()
{
	if (m_regmap)
	{
		delete[] m_regmap;
		m_regmap=NULL;
	}
	if (m_pIO)
	{
		delete m_pIO;
		m_pIO=NULL;
	}

	delete m_pReg;
	delete analogControlRegisters;

}













t_status CalsBase::getError(uw e,char* msg)
{
	switch (e)
	{
	case ok:             strcpy(msg,"")               ;break;
	case notImplemented: strcpy(msg,"Not Implemented");break;
	case illegalChannel: strcpy(msg,"Illegal Channel");break;
	case illegalValue:   strcpy(msg,"Illegal Value")  ;break;
	case usbError:       strcpy(msg,"USB Failure")    ;break;
	default:
	case driverError:    strcpy(msg,"dllError");
	}

	return ok;
}

t_status CalsBase::detectDevice()
{
	return notImplemented;
}

t_status CalsBase::setDrvApi(ul (fpApi *drvApi)(ul,ul,uw*,ul))
{
	if (!m_IOinterceptEnabled) 
	{
		//if (m_OSVer<=6.1)
		//{
			pDrvApi=drvApi;
		//}
		//else
		//{
		//	pDrvApi=drvApi;
		//}
	}

	return ok;
}

t_status CalsBase::setIOinterceptEnable(bool enable)
{
	return notImplemented;
}

t_status CalsBase::initDevice()
{
	t_status status=ok;

	if ((status=resetDevice()))
		goto error;
	//if ((status=measureConversionTime(m_alsConversionTime)))
	//	goto error;
	if ((status=resetDevice()))
		goto error;
	//if ((status=alignLuxRanges()))
	//	goto error;

	return status;// good return
error:PrintTrace("CalsBase::initDevice FAIL");
	return status;// error here
}

//t_status CalsBase::alignLuxRanges()
//{
//	return notImplemented;
//}

t_status CalsBase::initDriver()
{
	// must be done AFTER setCallBack
	// and after new device

	t_status status=ok;

	PrintTrace("CalsBase::initDriver Started");
	if ((status=initRegisters()))
		goto error;
	//if ((status=initInputSelect()))
	//	goto error;
	//if ((status=initRange()))
	//	goto error;
	//if ((status=initResolution()))
	//	goto error;
	//if ((status=initIrdr()))
	//	goto error;
	//if ((status=initIntPersist()))
	//	goto error;
	//if ((status=initSleep()))
	//	goto error;
	if ((status=initCalibration()))
		goto error;
	//if (m_stateMachineEnabled)
	//{
		//if ((status=initStateMachine()))
		//	goto error;
	//}
	if ((status=initDevice()))
		goto error;
	//if (m_stateMachineEnabled)
	//	{
	//	if ((status=(*m_activeState[0])->set()))
	//		goto error;
	//	if (m_Nchannels>1)
	//	{
	//		if ((status=(*m_activeState[1])->set()))
	//			goto error;
	//	}
	//}
	PrintTrace("CalsBase::initDriver Success");
 	return ok;// good exit
error:
	PrintTrace("CalsBase::initDriver FAIL");
	return status;// error here
}

t_status
CalsBase::initRegisters()
{
	PrintTrace("CalsBase::initRegisters");

	uw regmap[defaultRegMapSize];

	if (m_regmap)
		delete m_regmap;

	m_regmap=new uw [m_Nreg];

	memset(m_regmap,NULL,m_Nreg*sizeof(uw));

	if (pDrvApi)
	{
		for (uw i=0;i<m_Nreg-1;i+=2)
		{
			m_pIO->read(i,regmap[i]);
			regmap[i+1]=((regmap[i] >> 8) & 0xFF);
			regmap[i]&=0xFF;
		}
	}

	return ok;
}
//	// ___________
//	// InputSelect
//	// ===========
//
//t_status
//CalsBase::getNinputSelect(const uw c,uw& v)
//{
//	if (c<m_Nchannels)
//	{
//		if (c)
//			v=1;
//		else
//			v=m_NinputSelect;
//		return ok;
//	}
//	else
//		return illegalChannel;
//}
//
//t_status
//CalsBase::getInputSelectList(const uw c,char* v)
//{
//	ul i,j=0;
//	if (c<m_Nchannels)
//	{
//		if (c)
//			strcpy(v,"Prox");
//		else
//			for (i=0;i<m_NinputSelect;i++)
//			{
//				strcpy((v+j),m_inputSelectList[i]);
//				j+=(strlen(m_inputSelectList[i])+1);
//			}
//		return ok;
//	}
//	else
//		return illegalChannel;
//}
//
//	// _____
//	// Range
//	// =====
//
//t_status
//CalsBase::getNrange(const uw c,uw& v)
//{
//	if (c<m_Nchannels)
//	{
//		if (c)
//			v=1;
//		else
//			v=m_Nrange;
//		return ok;
//	}
//	else
//		return illegalChannel;
//}
//
//t_status
//CalsBase::getRangeList(const uw c,uw* v)
//{
//	if (c<m_Nchannels)
//	{
//		if (c)
//			*v=1;
//		else
//			memcpy(v,m_rangeList,m_Nrange*sizeof(m_rangeList[0]));
//		return ok;
//	}
//	else
//		return illegalChannel;
//}
//
//t_status 
//CalsBase::getRange(uw& r)
//{
//	return getRange(0,r);
//}
//
//t_status 
//CalsBase::getRange(const uw c,uw& r)
//{
//        if (c<m_Nchannels)
//        {
//                t_status status=m_pIO->read(&m_reg->m_range[c],r);
//				if (!c) m_rangeN=r;
//				return status;
//        }
//        else
//        {
//                return illegalChannel;
//        }
//}
//
//	// __________
//	// IntPersist
//	// ==========
//t_status
//CalsBase::initIntPersist()
//{
//	static uw prt[]={1 // ___________________________
//			        ,4 // Define intPersist list here
//			        ,8 // ===========================
//			        ,16
//			        };
//	m_NintPersist=sizeof(prt)/sizeof(prt[0]);
//	m_intPersistList=prt;
//	return ok;
//}
//
//t_status
//CalsBase::getNintPersist(const uw c,uw& v)
//{
//	v=m_NintPersist;
//	return ok;
//}
//
//t_status
//CalsBase::getIntPersistList(const uw c,uw* v)
//{
//	memcpy(v,m_intPersistList,m_NintPersist*sizeof(m_intPersistList[0]));
//	return ok;
//}
//
//t_status
//CalsBase::setIntPersist(const uw v)
//{
//	return setIntPersist(0,v);
//}
//
//t_status
//CalsBase::setIntPersist(const uw c,const uw v)
//{
//	if (c<m_Nchannels)
//		return m_pIO->write(&m_reg->m_intPersist[c],v);
//	else
//		return illegalChannel;
//}
//
//t_status
//CalsBase::getIntPersist(uw& v)
//{
//	return getIntPersist(0,v);
//}
//
//t_status
//CalsBase::getIntPersist(const uw c,uw& v)
//{
//	if (c<m_Nchannels)
//		return m_pIO->read(&m_reg->m_intPersist[c],v);
//	else
//		return illegalChannel;
//}
//
//t_status
//CalsBase::getNchannel(uw &v)
//{
//	v=m_Nchannels;
//	return ok;
//}
//
//
//	// _______
//	// IntFlag
//	// =======
//
//t_status
//CalsBase::getIntFlagMem(uw& v)
//{
//	return getIntFlagMem((uw)0,v);
//}
//t_status
//CalsBase::getIntFlagMem(const uw c,uw& v)
//{
//	getIntFlag(c,v);
//	v|=m_intFlag[c];
//	m_intFlag[c]=0;// clear on read by user
//	return ok;
//}
//t_status
//CalsBase::getIntFlag(uw& v)
//{
//	return getIntFlag(0,v);
//}
//t_status
//CalsBase::getIntFlag(const uw c,uw& v)
//{
//	t_status status=ok;
//	if (c<m_Nchannels)
//	{
//		status=m_pIO->read(&m_reg->m_intFlag[c],v);
//		m_intFlag[c] |= v;
//		return status;
//	}
//	else
//		return illegalChannel;
//}
//
//	// ____
//	// Irdr
//	// ====
//
//t_status
//CalsBase::getNirdr(uw& v)
//{
//	v=m_Nirdr;
//	return ok;
//}
//
//t_status
//CalsBase::getIrdrList(uw* v)
//{
//	memcpy(v,m_irdrList,m_Nirdr*sizeof(m_irdrList[0]));
//	return ok;
//}
//
//t_status
//CalsBase::setIrdr(const uw v)
//{
//	return m_pIO->write(m_reg->m_irdr,v);
//}
//
//t_status
//CalsBase::getIrdr(uw& v)
//{
//	return m_pIO->read(m_reg->m_irdr,v);
//}

t_status
CalsBase::getMPAprimed(uw& v)
{
	return getMPAprimed(0,v);
}

t_status
CalsBase::getMPAprimed(const uw c,uw& v)
{
	return m_pDataStats[c]->getMPAprimed(v);
}

//t_status
//CalsBase::checkTimer(const uw c)
//{
//	t_status status=alsEc::ok;
//
//	// m_lastTime is the last time data was read from HW
//	// set in CalsBase::getData override
//	clock_t now,sinceLastRead=((now=clock())-m_lastTime)*1000/CLOCKS_PER_SEC;
//
//	static uw time=2*m_alsConversionTime;
//	uw chan;
//
//
//	if (sinceLastRead>m_alsConversionTime)
//	{
//		// m_setTime is the time when the sequence selection was made
//		// set in CstateMachine::set
//		// Note:2 conversions are allowed for sequence change settling
//		now-=m_setTime;
////		if ( (now*1000/CLOCKS_PER_SEC) > (clock_t)time )
//		if ( now > (clock_t)time )
//		{
//			for (chan=0;chan<m_Nchannels;chan++)
//			{
//				//if ((status=(*m_activeState[chan])->call(time)))
//				//	return status;
//			}
//		}
//	}
//	return status;
//}
//
//t_status
//CalsBase::setLux(const uw alsLogicalState)
//{
//	// called from state machine
//	t_status status=m_pDataStats[0]->getData(m_alsValue.value);
//
//	if (ok==status)
//	{
//		status=m_pDataStats[0]->getStats(m_alsValue.mean,m_alsValue.stdDev);
//		if (ok==status)
//			m_alsValue.logicalState=alsLogicalState;
//	}
//	return status;
//}
//
//t_status
//CalsBase::getLux(dbl& c)
//{
//	t_status status;
//
//	if ((status=checkTimer(0)))
//		return status;
//
//	c=m_alsValue.value;
//	return ok;
//}
//
//t_status
//CalsBase::getLuxState(uw& alsLogicalState)
//{
//	alsLogicalState=m_alsValue.logicalState;
//	return ok;
//}
//
//t_status
//CalsBase::setProximity(const uw prxLogicalState)
//{
//	// called from state machine
//	t_status status=m_pDataStats[m_Nchannels-1]->getData(m_prxValue.value);
//
//	if (ok==status)
//	{
//		status=m_pDataStats[m_Nchannels-1]->getStats(m_prxValue.mean,m_prxValue.stdDev);
//		if (ok==status)
//			m_prxValue.logicalState=prxLogicalState;
//	}
//	return status;
//}
//
//t_status
//CalsBase::getProximity(dbl& c)
//{
//	t_status status;
//
//	if ((status=checkTimer(m_Nchannels-1)))
//		return status;
//
//	c=m_prxValue.value;
//	return ok;
//}
//
//t_status
//CalsBase::getProximityState(uw& prxLogicalState)
//{
//	prxLogicalState=m_prxValue.logicalState;
//	return ok;
//}
//
//t_status
//CalsBase::setIR(const uw irLogicalState)
//{
//	// called from state machine
//	t_status status=m_pDataStats[0]->getData(m_irValue.value);
//
//	if (ok==status)
//	{
//		status=m_pDataStats[0]->getStats(m_irValue.mean,m_irValue.stdDev);
//		if (ok==status)
//			m_irValue.logicalState=irLogicalState;
//	}
//	return status;
//}
//
//t_status
//CalsBase::getIR(dbl& c)
//{
//	t_status status;
//
//	if ((status=checkTimer(0)))
//		return status;
//
//	c=m_irValue.value;
//	return ok;
//}
//
//t_status
//CalsBase::getIRState(uw& irLogicalState)
//{
//	irLogicalState=m_irValue.logicalState;
//	return ok;
//}


t_status
CalsBase::getStats(const uw c, double &m, double &s)
{
	//CmeasValues* pCmeasValues;

	//switch (c)
	//{
	//case alsType::als:pCmeasValues=&m_alsValue;break;
	//case alsType::prx:pCmeasValues=&m_prxValue;break;
	//case alsType::ir: pCmeasValues=&m_irValue;break;
	//default: return illegalValue;
	//}
	//m=pCmeasValues->mean;
	//s=pCmeasValues->stdDev;
	return ok;
}

// ______________________
// default function stubs
// ======================

t_status CalsBase::getStats(double &m, double &s){return getStats(0,m,s);}
t_status CalsBase::setMPAsize(const uw v){return setMPAsize(0,v);}

//t_status CalsBase::getThreshHi(const uw c,double &v){return notImplemented;}
//t_status CalsBase::setThreshHi(const uw c,double  v){return notImplemented;}
//t_status CalsBase::getThreshLo(const uw c,double &v){return notImplemented;}
//t_status CalsBase::setThreshLo(const uw c,double  v){return notImplemented;}

//#define Get(x)     t_status CalsBase:: x (           uw&      v){return notImplemented;}
//#define Set(x)     t_status CalsBase:: x (           const uw v){return notImplemented;}
//#define Get0(x)    t_status CalsBase:: x (           uw&      v){return x (0,v);}
//#define Set0(x)    t_status CalsBase:: x (           const uw v){return x (0,v);}
//#define chanGet(x) t_status CalsBase:: x (const uw c,uw&      v){return notImplemented;};Get0(x)
//#define chanSet(x) t_status CalsBase:: x (const uw c,const uw v){return notImplemented;};Set0(x)
//
//	chanGet(getData)
//	chanGet(getEnable)       chanSet(setEnable)
//	//chanGet(getThreshHi)     chanSet(setThreshHi)
//	//chanGet(getThreshLo)     chanSet(setThreshLo)
//	chanGet(getInputSelect)  chanSet(setInputSelect)
//	chanGet(getResolution)   chanSet(setResolution)
//	
//	Get(getRunMode)          Set(setRunMode)
//	Get(getProxAmbRej)       Set(setProxAmbRej)
//	Get(getIrdrFreq)         Set(setIrdrFreq)
//	Get(getSleep)            Set(setSleep)
//	Get(getIntLogic)         Set(setIntLogic)
//	
//	chanSet(setRange)
//
//#undef chanSet
//#undef chanGet
//#undef Set0
//#undef Get0
//#undef Set
//#undef Get

#define baseDef(x) t_status CalsBase:: x {return notImplemented;}
#define stubOk(x) t_status CalsBase:: x {return ok;}

baseDef(setMPAsize(const uw c,const uw v))
//baseDef(preStateIntMask(const uw chan,CstateMachine* state))

baseDef(resetDevice())

//baseDef(initInputSelect())
//baseDef(initRange())
//baseDef(initResolution())
//baseDef(initIrdr())
//
//stubOk(initSleep())

baseDef(initCalibration())

//baseDef(getNresolution(const uw c, uw& n))
//baseDef(getResolutionList(const uw c, uw* n))
//	
//baseDef(getNsleep(uw& n))
//baseDef(getSleepList(uw* n))
//
baseDef(setPdataStats(const uw))
//
//#undef baseDef
//
//	// ________
//	// ThreshLo
//	// ========
//
//t_status
//CalsBase::getThreshLo(const uw c,uw& v){return notImplemented;}
//
//t_status
//CalsBase::getThreshLo(uw& v){return getThreshLo((uw)0,v);}
//
//t_status
//CalsBase::getThreshLo(const uw c,dbl& v)
//{
//	t_status status;
//	uw m;
//
//	if (ok==(status=getThreshLo(c,m)))
//	{
//		return m_pDataStats[c]->getReal(m,v);
//	}
//
//	return status;
//}
//
//t_status
//CalsBase::getThreshLo(dbl& v){return getThreshLo((uw)0,v);}
//
//t_status
//CalsBase::setThreshLo(const uw c,const uw v){return notImplemented;}
//
//t_status
//CalsBase::setThreshLo(const uw v){return setThreshLo((uw)0,v);}
//
//t_status
//CalsBase::setThreshLo(const uw c,const dbl v)
//{
//	t_status status;
//	uw m;
//
//	if (ok==(status=m_pDataStats[c]->getWord(v,m)))
//	{
//		return setThreshLo(c,m);
//	}
//
//	return status;
//}
//
//t_status
//CalsBase::setThreshLo(const dbl v){return setThreshLo((uw)0,v);}
//
//	// ________
//	// ThreshHi
//	// ========
//
//t_status
//CalsBase::getThreshHi(const uw c,uw& v){return notImplemented;}
//
//t_status
//CalsBase::getThreshHi(uw& v){return getThreshHi((uw)0,v);}
//
//t_status
//CalsBase::getThreshHi(const uw c,dbl& v)
//{
//	t_status status;
//	uw m;
//
//	if (ok==(status=getThreshHi(c,m)))
//	{
//		return m_pDataStats[c]->getReal(m,v);
//	}
//
//	return status;
//}
//
//t_status
//CalsBase::getThreshHi(dbl& v){return getThreshHi((uw)0,v);}
//
//t_status
//CalsBase::setThreshHi(const uw c,const uw v){return notImplemented;}
//
//t_status
//CalsBase::setThreshHi(const uw v){return setThreshHi((uw)0,v);}
//
//t_status
//CalsBase::setThreshHi(const uw c,const dbl v)
//{
//	t_status status;
//	uw m;
//
//	if (ok==(status=m_pDataStats[c]->getWord(v,m)))
//	{
//		return setThreshHi(c,m);
//	}
//
//	return status;
//}
//
//t_status
//CalsBase::setThreshHi(const dbl v){return setThreshHi((uw)0,v);}
//
//t_status
//CalsBase::measureConversionTime(uw& alsConversionTime)
//{
//	//int i;
//	//uw intFlag=0,flagCount=0;
//	//clock_t thisTime=0,lastTime=clock();
//
//	//setEnable(0,1);       // start conversions
//	////setIntPersist(0,0);   // set int persist to 1
//	//setThreshHi(0,(uw)0); // force interrupt
//	//setInputSelect(0,0);  // ALS
//	//getIntFlag(0,intFlag);// clear Flag
//	//setEnable(0,0);       // disable
//	//if (m_Nchannels>1) setEnable(1,0);
//	//lastTime=clock();thisTime=lastTime;
//	//setEnable(0,1);// start conversions
//
//	//for (i=0;i<1000;i++)
//	//{
//	//	getIntFlag(0,intFlag);
//	//	if (intFlag)
//	//	{
//	//		thisTime=clock();
//	//		if ( (++flagCount) >= 100)
//	//			break;
//	//	}
//	//}
//
//	//if (flagCount)
//	//{
//	//	alsConversionTime=(thisTime-lastTime)/flagCount*1000/CLOCKS_PER_SEC;
//	//	m_alsConversionTime=alsConversionTime;
//	//}
//	//else
//		alsConversionTime=0;//fail
//
//	return ok;
//}
//t_status
//CalsBase::getConversionTime(const uw c,uw& t)
//{
//	t=m_alsConversionTime;
//	return ok;
//}
//
//t_status
//CalsBase::setConversionTime(const uw c,const uw t)
//{
//	m_alsConversionTime=t;
//	return ok;
//}

t_status
CalsBase::getPartNumber(uw& n)
{
	n=m_partNumber;
	return ok;
}

t_status
CalsBase::getPartFamily(uw& n)
{
	n=m_partFamily;
	return ok;
}

//	// ____________
//	// StateMachine
//	// ============
//
//t_status
//CalsBase::initAlsStateMachine()
//{
//	return notImplemented;
//}
//
//t_status
//CalsBase::initProximityStateMachine()
//{
//	return notImplemented;
//}
//
//t_status
//CalsBase::initIrStateMachine()
//{
//	return notImplemented;
//}
//
//t_status
//CalsBase::initStateMachine()
//{
//	PrintTrace("CalsBase::initStateMachine, disabling I/O");
//	t_status status=notImplemented;
//
//	m_pIO->disableIO();
//
//	if (!initAlsStateMachine())
//		status=ok;
//
//	if (!initProximityStateMachine())
//		status=ok;
//
//	if (!initIrStateMachine())
//		status=ok;
//
//	m_pIO->enableIO();
//
//	PrintTrace("CalsBase::initStateMachine Done, I/O enabled");
//	return status;
//}

t_status
CalsBase::printTrace(const char* msg)
{
	return m_pIO->printTrace(msg);
}

//t_status CalsBase::setStateMachineEnable(const uw enable)
//{
//	if (enable)
//		m_stateMachineEnabled=true;
//	else
//		m_stateMachineEnabled=false;
//
//	return ok;
//}
//
//t_status CalsBase::getStateMachineEnable(uw& enable)
//{
//	if (m_stateMachineEnabled)
//		enable=1;
//	else
//		enable=0;
//
//	return ok;
//}

t_status CalsBase::setByteIoOnly(const uw enable)
{
	if (enable)
		m_byteIoOnly=true;
	else
		m_byteIoOnly=false;

	return ok;
}

t_status CalsBase::getByteIoOnly(uw& enable)
{
	if (m_byteIoOnly)
		enable=1;
	else
		enable=0;

	return ok;
}

//t_status CalsBase::getProxIR(dbl& v,uw& x){return notImplemented;}
//
//	// ___________
//	// 29038 Stubs
//	// ===========
//
//t_status CalsBase::setProxIntEnable(const  uw  x){return notImplemented;}
//t_status CalsBase::getProxIntEnable(       uw& x){return notImplemented;}
//t_status CalsBase::setProxOffset   (       uw& x){return notImplemented;}
//t_status CalsBase::getProxOffset   (       uw& x){return notImplemented;}
//t_status CalsBase::setIRcomp       (const  uw  x){return notImplemented;}
//t_status CalsBase::getIRcomp       (       uw& x){return notImplemented;}
//t_status CalsBase::getProxAlrm     (       uw& x){return notImplemented;}
//t_status CalsBase::setVddAlrm      (const  uw  x){return notImplemented;}
//t_status CalsBase::getVddAlrm      (       uw& x){return notImplemented;}
//
//	// ___________
//	// 29036 Stubs
//	// ===========
//
//t_status CalsBase::setProxGain38(const  uw  x){return notImplemented;}
//t_status CalsBase::getProxGain38(       uw& x){return notImplemented;}
//
//#if ( _DEBUG || _INCTRIM ) // 29038 trim
//t_status CalsBase::setProxTrim      (const  uw  x){return notImplemented;}
//t_status CalsBase::getProxTrim      (       uw& x){return notImplemented;}
//t_status CalsBase::setIrdrTrim      (const  uw  x){return notImplemented;}
//t_status CalsBase::getIrdrTrim      (       uw& x){return notImplemented;}
//t_status CalsBase::setAlsTrim       (const  uw  x){return notImplemented;}
//t_status CalsBase::getAlsTrim       (       uw& x){return notImplemented;}
//
//t_status CalsBase::setRegOtpSel     (const  uw  x){return notImplemented;}
//t_status CalsBase::getRegOtpSel     (       uw& x){return notImplemented;}
//t_status CalsBase::setOtpData       (const  uw  x){return notImplemented;}
//t_status CalsBase::getOtpData       (       uw& x){return notImplemented;}
//t_status CalsBase::setFuseWrEn      (const  uw  x){return notImplemented;}
//t_status CalsBase::getFuseWrEn      (       uw& x){return notImplemented;}
//t_status CalsBase::setFuseWrAddr    (const  uw  x){return notImplemented;}
//t_status CalsBase::getFuseWrAddr    (       uw& x){return notImplemented;}
//
//t_status CalsBase::getOptDone       (       uw& x){return notImplemented;}
//t_status CalsBase::setIrdrDcPulse   (const  uw  x){return notImplemented;}
//t_status CalsBase::getIrdrDcPulse   (       uw& x){return notImplemented;}
//t_status CalsBase::getGolden        (       uw& x){return notImplemented;}
//t_status CalsBase::setOtpRes        (const  uw  x){return notImplemented;}
//t_status CalsBase::getOtpRes        (       uw& x){return notImplemented;}
//t_status CalsBase::setIntTest       (const  uw  x){return notImplemented;}
//t_status CalsBase::getIntTest       (       uw& x){return notImplemented;}
//#endif
//
//	// _________
//	// RGB Stubs
//	// =========
//
//t_status CalsBase::getRed(      dbl& x){return notImplemented;}
//t_status CalsBase::getGreen(    dbl& x){return notImplemented;}
//t_status CalsBase::getBlue(     dbl& x){return notImplemented;}
//t_status CalsBase::getCCT(      dbl& x){return notImplemented;}
//t_status CalsBase::setRgbCoeffEnable(const uw  x){return notImplemented;}
//t_status CalsBase::getRgbCoeffEnable(uw&       x){return notImplemented;}
//t_status CalsBase::loadRgbCoeff(dbl* x){return notImplemented;}
//t_status CalsBase::clearRgbCoeff()     {return notImplemented;}
//	// RGB test modes
//t_status CalsBase::enable4x(const uw  x){return notImplemented;}
//t_status CalsBase::enable8bit(const uw  x){return notImplemented;}
//
//	// New 177 
//t_status CalsBase::setPrxRngOffCmpEn(const uw  x){return notImplemented;}
//t_status CalsBase::getPrxRngOffCmpEn(      uw& x){return notImplemented;}
//t_status CalsBase::setIrdrMode(const uw  x){return notImplemented;}
//t_status CalsBase::getIrdrMode(      uw& x){return notImplemented;}
