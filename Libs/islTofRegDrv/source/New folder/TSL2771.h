#pragma once
#include "ALSbaseClass.h"
#include "ISL29028.h"
#include "avgStats.h"

class Ctsl2771 : public Cisl29028
{
public:
	Ctsl2771();
	~Ctsl2771();

	Cstats  m_dataStats[2]; // channel

	virtual t_status detectDevice();

	t_status initRegisters();
	t_status initInputSelect();
	t_status initRange();
	t_status initResolution();
	t_status initIrdr();
	t_status initSleep();

    t_status getNresolution(const ul c,ul& v);
    t_status getResolutionList(const ul c,ul* v);

    t_status getNsleep(ul& v);
    t_status getSleepList(ul* v);

	// inherited
    //________________________________________________________________
    #define Get(x)     virtual t_status x (           ul&      v);
    #define Set(x)     virtual t_status x (           const ul v);
    #define chanGet(x) virtual t_status x (const ul c,ul&      v);//Get(x)
    #define chanSet(x) virtual t_status x (const ul c,const ul v);//Set(x)

    chanSet(setInputSelect)    chanGet(getInputSelect)
    chanSet(setEnable) 	       chanGet(getEnable)
	chanGet(getThreshLo)       chanSet(setThreshLo)

	chanSet(setThreshHi)       chanGet(getThreshHi)
	chanGet(getIntFlag)

	chanGet(getData)

	Set(setSleep)              Get(getSleep)
	Set(setIntLogic)           Get(getIntLogic)

    #undef chanGet
    #undef chanSet
    #undef Get
    #undef Set

	//virtual t_status getData(ul &d);
	virtual t_status setMpaSize(const ul c,const ul v);
	virtual t_status getDataStats(const ul c,double &v,double &m,double &s);

	virtual t_status getResolution(const ul c,ul& v);
	virtual t_status getResolution(           ul& v);

	virtual t_status setResolution(const ul c,const ul v);
	virtual t_status setResolution(           const ul v);

	ul m_NinputSelect1;char **m_inputSelectList1;
	virtual t_status getInputSelectList(const ul c,char* v);
	virtual t_status getNinputSelect(const ul c,ul& v);

	virtual t_status resetDevice();
	virtual t_status measureConversionTime(uw&);
	virtual t_status initCalibration();
	virtual t_status setPdataStats(const ul);

	virtual t_status getLux(double &ul);
};
