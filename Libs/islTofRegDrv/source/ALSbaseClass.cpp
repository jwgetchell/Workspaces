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

	status=                new                Cstatus(this);
	samplingControl=       new       CsamplingControl(this);
	algorithmControl=      new      CalgorithmControl(this);
	signalIntegrity=       new       CsignalIntegrity(this);
	closedLoopCalibration= new CclosedLoopCalibration(this);
	openLoopCorrection=    new    CopenLoopCorrection(this);
	interrupt=             new             Cinterrupt(this);
	detectionModeControl=  new  CdetectionModeControl(this);
	analogControl=         new         CanalogControl(this);
	dft=                   new                   Cdft(this);
	fuse=                  new                  Cfuse(this);
	digitalTest=           new           CdigitalTest(this);
	lightSampleStatus=     new     ClightSampleStatus(this);
	calibrationStatus=     new     CcalibrationStatus(this);
	debugging=             new             Cdebugging(this);

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

	delete                status;
	delete       samplingControl;
	delete      algorithmControl;
	delete       signalIntegrity;
	delete closedLoopCalibration;
	delete    openLoopCorrection;
	delete             interrupt;
	delete  detectionModeControl;
	delete         analogControl;
	delete                   dft;
	delete                  fuse;
	delete           digitalTest;
	delete     lightSampleStatus;
	delete     calibrationStatus;
	delete             debugging;

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
	if ((status=resetDevice()))
		goto error;

	return status;// good return
error:PrintTrace("CalsBase::initDevice FAIL");
	return status;// error here
}

t_status CalsBase::initDriver()
{
	// must be done AFTER setCallBack
	// and after new device

	t_status status=ok;

	PrintTrace("CalsBase::initDriver Started");
	if ((status=initRegisters()))
		goto error;
	if ((status=initCalibration()))
		goto error;
	if ((status=initDevice()))
		goto error;
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


#define baseDef(x) t_status CalsBase:: x {return notImplemented;}
#define stubOk(x) t_status CalsBase:: x {return ok;}

baseDef(setMPAsize(const uw c,const uw v))

baseDef(resetDevice())

baseDef(initCalibration())

baseDef(setPdataStats(const uw))

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


t_status
CalsBase::printTrace(const char* msg)
{
	return m_pIO->printTrace(msg);
}

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

