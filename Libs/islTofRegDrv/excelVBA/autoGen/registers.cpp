Creg::CstatusRegisters::CstatusRegisters()
    {
        chip_id=                new bitField(regDef.DeviceID,0,0xFF);
        c_en=                   new bitField(regDef.MasterControl,0,0x1);
        sleeping=               new bitField(regDef.StatusRegisters,3,0x1);
        vddok=                  new bitField(regDef.StatusRegisters,2,0x1);
        ready=                  new bitField(regDef.StatusRegisters,1,0x1);
        enout=                  new bitField(regDef.StatusRegisters,0,0x1);
    };
Creg::CstatusRegisters::~CstatusRegisters()
    {
        delete chip_id;
        delete c_en;
        delete sleeping;
        delete vddok;
        delete ready;
        delete enout;
    };

Creg::CsamplingControlRegisters::CsamplingControlRegisters()
    {
        sample_num=             new bitField(regDef.IntegrationTime,4,0xF);
        sample_len=             new bitField(regDef.IntegrationTime,0,0xF);
        sample_period=          new bitField(regDef.SamplePeriod,0,0xFF);
        sample_skip=            new bitField(regDef.SamplePeriodRange,0,0x3);
        collision_det_en=       new bitField(regDef.SampleControl,7,0x1);
        zp_cal_en=              new bitField(regDef.SampleControl,6,0x1);
        dc_cal_en=              new bitField(regDef.SampleControl,5,0x1);
        light_en=               new bitField(regDef.SampleControl,4,0x1);
        cali_freq=              new bitField(regDef.SampleControl,2,0x3);
        cali_mode=              new bitField(regDef.SampleControl,1,0x1);
        adc_mode=               new bitField(regDef.SampleControl,0,0x1);
        dc_cal_len=             new bitField(regDef.DCCalIntegrationTime,0,0xF);
        zp_cal_len=             new bitField(regDef.ZPCalIntegrationTime,0,0xF);
        collision_len=          new bitField(regDef.CollisionIntegrationTime,0,0xF);
    };
Creg::CsamplingControlRegisters::~CsamplingControlRegisters()
    {
        delete sample_num;
        delete sample_len;
        delete sample_period;
        delete sample_skip;
        delete collision_det_en;
        delete zp_cal_en;
        delete dc_cal_en;
        delete light_en;
        delete cali_freq;
        delete cali_mode;
        delete adc_mode;
        delete dc_cal_len;
        delete zp_cal_len;
        delete collision_len;
    };

Creg::CalgorithmControlRegisters::CalgorithmControlRegisters()
    {
        agc_max_iter=           new bitField(regDef.AGCControl1,4,0xF);
        agc_cal_en=             new bitField(regDef.AGCControl1,1,0x1);
        agc_en=                 new bitField(regDef.AGCControl1,0,0x1);
        agc_acc_thld=           new bitField(regDef.AGCControl2,3,0x7);
        agc_persistance_thld=   new bitField(regDef.AGCControl2,0,0x7);
        min_vga2_exp=           new bitField(regDef.AGCControl3,3,0x7);
        min_vga1_exp=           new bitField(regDef.AGCControl3,0,0x7);
        dsp_light_en=           new bitField(regDef.DSPEnable,3,0x1);
        dsp_cal_en=             new bitField(regDef.DSPEnable,2,0x1);
        dsp_ts_en=              new bitField(regDef.DSPEnable,1,0x1);
        dsp_ol_en=              new bitField(regDef.DSPEnable,0,0x1);
    };
Creg::CalgorithmControlRegisters::~CalgorithmControlRegisters()
    {
        delete agc_max_iter;
        delete agc_cal_en;
        delete agc_en;
        delete agc_acc_thld;
        delete agc_persistance_thld;
        delete min_vga2_exp;
        delete min_vga1_exp;
        delete dsp_light_en;
        delete dsp_cal_en;
        delete dsp_ts_en;
        delete dsp_ol_en;
    };

Creg::CsignalIntegrityRegisters::CsignalIntegrityRegisters()
    {
        threshhold_dc=          new bitField(regDef.DCSaturationThreshold,0,0xFF);
        noise_thld_os=          new bitField(regDef.NoiseThresholdOffset,0,0x3F);
        noise_thld_slope=       new bitField(regDef.NoiseThresholdSlope,0,0x7);
        mag_squelch_exp=        new bitField(regDef.MagnitudeSquelchExponent,0,0xF);
        mag_squelch=            new bitField(regDef.MagnitudeSquelch,0,0xFF);
        ckt_noise=              new bitField(regDef.CircuitNoise,1,0x7F);
        ckt_noise_conn=         new bitField(regDef.CircuitNoise,0,0x1);
        noise_gain=             new bitField(regDef.NoiseGain,0,0xFF);
        fixed_error=            new bitField(regDef.FixedError,0,0xFF);
        coll_pk_sel=            new bitField(regDef.CollisionPeakSelect,0,0x7);
    };
Creg::CsignalIntegrityRegisters::~CsignalIntegrityRegisters()
    {
        delete threshhold_dc;
        delete noise_thld_os;
        delete noise_thld_slope;
        delete mag_squelch_exp;
        delete mag_squelch;
        delete ckt_noise;
        delete ckt_noise_conn;
        delete noise_gain;
        delete fixed_error;
        delete coll_pk_sel;
    };

Creg::CclosedLoopCalibrationRegisters::CclosedLoopCalibrationRegisters()
    {
        i_xtalk_exp=            new bitField(regDef.CrosstalkIExponent,0,0xFF);
        i_xtalk=                new bitField(regDef.CrosstalkIMSB,0,0xFFFF);
        q_xtalk_exp=            new bitField(regDef.CrosstalkQExponent,0,0xFF);
        q_xtalk=                new bitField(regDef.CrosstalkQMSB,0,0xFFFF);
        gain_xtalk=             new bitField(regDef.CrosstalkGainMSB,0,0xFFFF);
        mag_ref_exp=            new bitField(regDef.MagnitudeReferenceExp,0,0xF);
        mag_ref=                new bitField(regDef.MagnitudeReferenceMSB,0,0xFFFF);
        phase_offset=           new bitField(regDef.PhaseOffsetMSB,0,0xFFFF);
    };
Creg::CclosedLoopCalibrationRegisters::~CclosedLoopCalibrationRegisters()
    {
        delete i_xtalk_exp;
        delete i_xtalk;
        delete q_xtalk_exp;
        delete q_xtalk;
        delete gain_xtalk;
        delete mag_ref_exp;
        delete mag_ref;
        delete phase_offset;
    };

Creg::CopenLoopCorrectionRegisters ::CopenLoopCorrectionRegisters ()
    {
        ol_temp_ref=            new bitField(regDef.TemperatureReference,0,0xFF);
        ol_emit_ref=            new bitField(regDef.EmitterReference,0,0xFF);
        ol_phase_co_exp=        new bitField(regDef.PhaseExponent,0,0xF);
        ol_phase_temp_co1=      new bitField(regDef.PhaseOffsetTempCo1,0,0xFF);
        ol_phase_emit_co1=      new bitField(regDef.PhaseOffsetEmitterCo1,0,0xFF);
        ol_phase_amb_co1=       new bitField(regDef.PhaseOffsetAmbientCo1,0,0xFF);
        ol_phase_vga1_co1=      new bitField(regDef.PhaseOffsetVGA1Co1,0,0xFF);
        ol_phase_vga2_co1=      new bitField(regDef.PhaseOffsetVGA2Co1,0,0xFF);
        ol_phase_temp_co2=      new bitField(regDef.PhaseOffsetTempCo2,0,0xFF);
        ol_phase_emit_co2=      new bitField(regDef.PhaseOffsetEmitterCo2,0,0xFF);
        ol_phase_amb_co2=       new bitField(regDef.PhaseOffsetAmbientCo2,0,0xFF);
        ol_phase_vga1_co2=      new bitField(regDef.PhaseOffsetVGA1Co2,0,0xFF);
        ol_phase_vga2_co2=      new bitField(regDef.PhaseOffsetVGA2Co2,0,0xFF);
        ol_i_temp_co1=          new bitField(regDef.CrosstalkITempCo1,0,0xFF);
        ol_i_emit_co1=          new bitField(regDef.CrosstalkIEmitterCo1,0,0xFF);
        ol_i_amb_co1=           new bitField(regDef.CrosstalkIAmbientCo1,0,0xFF);
        ol_i_vga1_co1=          new bitField(regDef.CrosstalkIVGA1Co1,0,0xFF);
        ol_i_vga2_co1=          new bitField(regDef.CrosstalkIVGA2Co1,0,0xFF);
        ol_i_temp_co2=          new bitField(regDef.CrosstalkITempCo2,0,0xFF);
        ol_i_emit_co2=          new bitField(regDef.CrosstalkIEmitterCo2,0,0xFF);
        ol_i_amb_co2=           new bitField(regDef.CrosstalkIAmbientCo2,0,0xFF);
        ol_i_vga1_co2=          new bitField(regDef.CrosstalkIVGA1Co2,0,0xFF);
        ol_i_vga2_co2=          new bitField(regDef.CrosstalkIVGA2Co2,0,0xFF);
        ol_q_temp_co1=          new bitField(regDef.CrosstalkQTempCo1,0,0xFF);
        ol_q_emit_co1=          new bitField(regDef.CrosstalkQEmitterCo1,0,0xFF);
        ol_q_amb_co1=           new bitField(regDef.CrosstalkQAmbientCo1,0,0xFF);
        ol_q_vga1_co1=          new bitField(regDef.CrosstalkQVGA1Co1,0,0xFF);
        ol_q_vga2_co1=          new bitField(regDef.CrosstalkQVGA2Co1,0,0xFF);
        ol_q_temp_co2=          new bitField(regDef.CrosstalkQTempCo2,0,0xFF);
        ol_q_emit_co2=          new bitField(regDef.CrosstalkQEmitterCo2,0,0xFF);
        ol_q_amb_co2=           new bitField(regDef.CrosstalkQAmbientCo2,0,0xFF);
        ol_q_vga1_co2=          new bitField(regDef.CrosstalkQVGA1Co2,0,0xFF);
        ol_q_vga2_co2=          new bitField(regDef.CrosstalkQVGA2Co2,0,0xFF);
        emitter_ol_sel=         new bitField(regDef.EmitterSelectforOpenLoop,0,0x1);
    };
Creg::CopenLoopCorrectionRegisters ::~CopenLoopCorrectionRegisters ()
    {
        delete ol_temp_ref;
        delete ol_emit_ref;
        delete ol_phase_co_exp;
        delete ol_phase_temp_co1;
        delete ol_phase_emit_co1;
        delete ol_phase_amb_co1;
        delete ol_phase_vga1_co1;
        delete ol_phase_vga2_co1;
        delete ol_phase_temp_co2;
        delete ol_phase_emit_co2;
        delete ol_phase_amb_co2;
        delete ol_phase_vga1_co2;
        delete ol_phase_vga2_co2;
        delete ol_i_temp_co1;
        delete ol_i_emit_co1;
        delete ol_i_amb_co1;
        delete ol_i_vga1_co1;
        delete ol_i_vga2_co1;
        delete ol_i_temp_co2;
        delete ol_i_emit_co2;
        delete ol_i_amb_co2;
        delete ol_i_vga1_co2;
        delete ol_i_vga2_co2;
        delete ol_q_temp_co1;
        delete ol_q_emit_co1;
        delete ol_q_amb_co1;
        delete ol_q_vga1_co1;
        delete ol_q_vga2_co1;
        delete ol_q_temp_co2;
        delete ol_q_emit_co2;
        delete ol_q_amb_co2;
        delete ol_q_vga1_co2;
        delete ol_q_vga2_co2;
        delete emitter_ol_sel;
    };

Creg::CinterruptRegisters::CinterruptRegisters()
    {
        ro_irq=                 new bitField(regDef.InterruptControl,5,0x1);
        change_en=              new bitField(regDef.InterruptControl,4,0x1);
        interrrupt_data_invalid=new bitField(regDef.InterruptControl,3,0x1);
        interrupt_ctrl=         new bitField(regDef.InterruptControl,0,0x7);
        data_invalid_mask=      new bitField(regDef.DataInvalid,0,0xFF);
        persistance=            new bitField(regDef.Detection,4,0x3);
        noise_buffer_enable=    new bitField(regDef.Detection,3,0x1);
        noise_buffer_sign=      new bitField(regDef.Detection,2,0x1);
        noise_buffer_ctrl=      new bitField(regDef.Detection,0,0x3);
        c1_mag3_en=             new bitField(regDef.DetectionCondition1,7,0x1);
        c1_mag2_en=             new bitField(regDef.DetectionCondition1,6,0x1);
        c1_mag1_en=             new bitField(regDef.DetectionCondition1,5,0x1);
        c1_zone3_en=            new bitField(regDef.DetectionCondition1,4,0x1);
        c1_zone2_en=            new bitField(regDef.DetectionCondition1,3,0x1);
        c1_zone1_en=            new bitField(regDef.DetectionCondition1,2,0x1);
        c1_motion_magnitude_en= new bitField(regDef.DetectionCondition1,1,0x1);
        c1_motion_distance_en=  new bitField(regDef.DetectionCondition1,0,0x1);
        c2_mag3_en=             new bitField(regDef.DetectionCondition2,7,0x1);
        c2_mag2_en=             new bitField(regDef.DetectionCondition2,6,0x1);
        c2_mag1_en=             new bitField(regDef.DetectionCondition2,5,0x1);
        c2_zone3_en=            new bitField(regDef.DetectionCondition2,4,0x1);
        c2_zone2_en=            new bitField(regDef.DetectionCondition2,3,0x1);
        c2_zone1_en=            new bitField(regDef.DetectionCondition2,2,0x1);
        c2_motion_magnitude_en= new bitField(regDef.DetectionCondition2,1,0x1);
        c2_motion_distance_en=  new bitField(regDef.DetectionCondition2,0,0x1);
        motion_dist_ref=        new bitField(regDef.ReferenceDistanceforMotionMSB,0,0xFFFF);
        motion_mag_exp=         new bitField(regDef.ReferenceMagnitudeExponent,0,0xF);
        motion_mag_ref=         new bitField(regDef.ReferenceMagnitudeSignificand,0,0xFF);
        brownout_flag=          new bitField(regDef.InterruptFlag,5,0x1);
        change_flag=            new bitField(regDef.InterruptFlag,4,0x1);
        event_flag=             new bitField(regDef.InterruptFlag,3,0x1);
        condition_2_flag=       new bitField(regDef.InterruptFlag,2,0x1);
        condition_1_flag=       new bitField(regDef.InterruptFlag,1,0x1);
        data_ready=             new bitField(regDef.InterruptFlag,0,0x1);
        mag3_flag=              new bitField(regDef.DetectionFlag,7,0x1);
        mag2_flag=              new bitField(regDef.DetectionFlag,6,0x1);
        mag1_flag=              new bitField(regDef.DetectionFlag,5,0x1);
        zone3_flag=             new bitField(regDef.DetectionFlag,4,0x1);
        zone2_flag=             new bitField(regDef.DetectionFlag,3,0x1);
        zone1_flag=             new bitField(regDef.DetectionFlag,2,0x1);
        motion_magnitude_flag=  new bitField(regDef.DetectionFlag,1,0x1);
        motion_distance_flag=   new bitField(regDef.DetectionFlag,0,0x1);
        detect_ref=             new bitField(regDef.DetectionFlagReference,0,0xFF);
    };
Creg::CinterruptRegisters::~CinterruptRegisters()
    {
        delete ro_irq;
        delete change_en;
        delete interrrupt_data_invalid;
        delete interrupt_ctrl;
        delete data_invalid_mask;
        delete persistance;
        delete noise_buffer_enable;
        delete noise_buffer_sign;
        delete noise_buffer_ctrl;
        delete c1_mag3_en;
        delete c1_mag2_en;
        delete c1_mag1_en;
        delete c1_zone3_en;
        delete c1_zone2_en;
        delete c1_zone1_en;
        delete c1_motion_magnitude_en;
        delete c1_motion_distance_en;
        delete c2_mag3_en;
        delete c2_mag2_en;
        delete c2_mag1_en;
        delete c2_zone3_en;
        delete c2_zone2_en;
        delete c2_zone1_en;
        delete c2_motion_magnitude_en;
        delete c2_motion_distance_en;
        delete motion_dist_ref;
        delete motion_mag_exp;
        delete motion_mag_ref;
        delete brownout_flag;
        delete change_flag;
        delete event_flag;
        delete condition_2_flag;
        delete condition_1_flag;
        delete data_ready;
        delete mag3_flag;
        delete mag2_flag;
        delete mag1_flag;
        delete zone3_flag;
        delete zone2_flag;
        delete zone1_flag;
        delete motion_magnitude_flag;
        delete motion_distance_flag;
        delete detect_ref;
    };

Creg::CdetectionModeControlRegisters ::CdetectionModeControlRegisters ()
    {
        dist1_high=             new bitField(regDef.Zone1ThresholdHighMSB,0,0xFFFF);
        dist1_low=              new bitField(regDef.Zone1ThresholdLowMSB,0,0xFFFF);
        dist2_high=             new bitField(regDef.Zone2ThresholdHighMSB,0,0xFFFF);
        dist2_low=              new bitField(regDef.Zone2ThresholdLowMSB,0,0xFFFF);
        dist3_high=             new bitField(regDef.Zone3ThresholdHighMSB,0,0xFFFF);
        dist3_low=              new bitField(regDef.Zone3ThresholdLowMSB,0,0xFFFF);
        mag1_high_exp=          new bitField(regDef.MagnitudeThreshold1HighExponent,0,0xF);
        mag1_high=              new bitField(regDef.MagnitudeThreshold1High,0,0xFF);
        mag2_low_exp=           new bitField(regDef.MagnitudeThreshold2LowExponent,0,0xF);
        mag2_low=               new bitField(regDef.MagnitudeThreshold2Low,0,0xFF);
        mag2_high_exp=          new bitField(regDef.MagnitudeThreshold2HighExponent,0,0xF);
        mag2_high=              new bitField(regDef.MagnitudeThreshold2High,0,0xFF);
        mag3_low_exp=           new bitField(regDef.MagnitudeThreshold3LowExponent,0,0xF);
        mag3_low=               new bitField(regDef.MagnitudeThreshold3Low,0,0xFF);
        motion_dist_thld=       new bitField(regDef.MotionDistanceThresholdMSB,0,0xFFFF);
        motion_mag_thld=        new bitField(regDef.MotionMagnitudeThreshold,0,0xFF);
    };
Creg::CdetectionModeControlRegisters ::~CdetectionModeControlRegisters ()
    {
        delete dist1_high;
        delete dist1_low;
        delete dist2_high;
        delete dist2_low;
        delete dist3_high;
        delete dist3_low;
        delete mag1_high_exp;
        delete mag1_high;
        delete mag2_low_exp;
        delete mag2_low;
        delete mag2_high_exp;
        delete mag2_high;
        delete mag3_low_exp;
        delete mag3_low;
        delete motion_dist_thld;
        delete motion_mag_thld;
    };

Creg::CanalogControlRegisters::CanalogControlRegisters()
    {
        driver_s=               new bitField(regDef.DriverRange,0,0xF);
        emitter_current=        new bitField(regDef.EmitterCurrentDAC,0,0xFF);
        driver_enbal=           new bitField(regDef.DriverControl,2,0x1);
        driver_nboost_en=       new bitField(regDef.DriverControl,1,0x1);
        driver_thresh_en=       new bitField(regDef.DriverControl,0,0x1);
        driver_t=               new bitField(regDef.ThresholdCurrentDAC,0,0xFF);
        driver_boost=           new bitField(regDef.DriverBoost,0,0xF);
        driver_d=               new bitField(regDef.DriverBoostDuration,0,0x3F);
        driver_p=               new bitField(regDef.DriverChargeBalancingDAC,0,0xFF);
        afe_pd_dc=              new bitField(regDef.FrontendControl,4,0x1);
        afe_lowcap_mode=        new bitField(regDef.FrontendControl,3,0x1);
        lna_gain=               new bitField(regDef.FrontendControl,2,0x1);
        afe_gain=               new bitField(regDef.FrontendControl,0,0x3);
        afe_bypass=             new bitField(regDef.AFEControlRegisters,7,0x1);
        afe_xtlk_en=            new bitField(regDef.AFEControlRegisters,6,0x1);
        afe_dac_hi=             new bitField(regDef.AFEControlRegisters,3,0x7);
        afe_dac_lo=             new bitField(regDef.AFEControlRegisters,0,0x7);
        amb_fast=               new bitField(regDef.AmbientADCTestFeatures,5,0x1);
        amb_dac_test=           new bitField(regDef.AmbientADCTestFeatures,0,0x1F);
        X=                      new bitField(regDef.VGAOffsetCode,6,0x3);
        zp_control=             new bitField(regDef.VGAOffsetCode,2,0xF);
        sel_256_255b=           new bitField(regDef.VGAOffsetCode,0,0x3);
        vga1_light_manual=      new bitField(regDef.VGA1ManualforLight,0,0xFF);
        vga2_light_manual=      new bitField(regDef.VGA2ManualforLight,0,0xFF);
        vga1_zp_manual=         new bitField(regDef.VGA1ManualforZP,0,0xFF);
        vga2_zp_manual=         new bitField(regDef.VGA2ManualforZP,0,0xFF);
        vga1_coll=              new bitField(regDef.VGA1ControlforCollision,0,0xFF);
        vga2_coll=              new bitField(regDef.VGA2ControlforCollision,0,0xFF);
        adc_vref=               new bitField(regDef.ADCVrefCode,0,0x1F);
        vtpk_vga2_1_hi=         new bitField(regDef.PeakDetectorThresholds0,6,0x3);
        vtpk_vga2_1_lo=         new bitField(regDef.PeakDetectorThresholds0,4,0x3);
        vtpk_vga2_0_hi=         new bitField(regDef.PeakDetectorThresholds0,2,0x3);
        vtpk_vga2_0_lo=         new bitField(regDef.PeakDetectorThresholds0,0,0x3);
        vtpk_vga2_3_hi=         new bitField(regDef.PeakDetectorThresholds1,6,0x3);
        vtpk_vga2_3_lo=         new bitField(regDef.PeakDetectorThresholds1,4,0x3);
        vtpk_vga2_2_hi=         new bitField(regDef.PeakDetectorThresholds1,2,0x3);
        vtpk_vga2_2_lo=         new bitField(regDef.PeakDetectorThresholds1,0,0x3);
        vtpk_iq_hi=             new bitField(regDef.PeakDetectorThresholds2,6,0x3);
        vtpk_iq_lo=             new bitField(regDef.PeakDetectorThresholds2,4,0x3);
        vtpk_vga2_4_hi=         new bitField(regDef.PeakDetectorThresholds2,2,0x3);
        vtpk_vga2_4_lo=         new bitField(regDef.PeakDetectorThresholds2,0,0x3);
        emit_adc_b=             new bitField(regDef.EmitterVoltageADCOffset,0,0xF);
        emit_adc_s_after=       new bitField(regDef.EmitterVoltageADCMuxSelect,4,0x7);
        emit_adc_s_before=      new bitField(regDef.EmitterVoltageADCMuxSelect,0,0x7);
        temp_reg_a=             new bitField(regDef.TempSensorRegA,0,0xFF);
        temp_reg_b=             new bitField(regDef.TempSensorRegB,0,0xFF);
        temp_reg_c=             new bitField(regDef.TempSensorRegC,0,0xFF);
        temp_adc_mode=          new bitField(regDef.TempSensorADCMode,0,0x1F);
        bf_sel=                 new bitField(regDef.BPFSelect,0,0x3);
        osc_aaf_dof=            new bitField(regDef.Oscillator_AAFOffset,0,0xF);
        osc_select=             new bitField(regDef.OscillatorSelect,0,0x1);
        rint=                   new bitField(regDef.InternalRSET,0,0x1);
        X0=                     new bitField(regDef.Spares,0,0xFF);
    };
Creg::CanalogControlRegisters::~CanalogControlRegisters()
    {
        delete driver_s;
        delete emitter_current;
        delete driver_enbal;
        delete driver_nboost_en;
        delete driver_thresh_en;
        delete driver_t;
        delete driver_boost;
        delete driver_d;
        delete driver_p;
        delete afe_pd_dc;
        delete afe_lowcap_mode;
        delete lna_gain;
        delete afe_gain;
        delete afe_bypass;
        delete afe_xtlk_en;
        delete afe_dac_hi;
        delete afe_dac_lo;
        delete amb_fast;
        delete amb_dac_test;
        delete X;
        delete zp_control;
        delete sel_256_255b;
        delete vga1_light_manual;
        delete vga2_light_manual;
        delete vga1_zp_manual;
        delete vga2_zp_manual;
        delete vga1_coll;
        delete vga2_coll;
        delete adc_vref;
        delete vtpk_vga2_1_hi;
        delete vtpk_vga2_1_lo;
        delete vtpk_vga2_0_hi;
        delete vtpk_vga2_0_lo;
        delete vtpk_vga2_3_hi;
        delete vtpk_vga2_3_lo;
        delete vtpk_vga2_2_hi;
        delete vtpk_vga2_2_lo;
        delete vtpk_iq_hi;
        delete vtpk_iq_lo;
        delete vtpk_vga2_4_hi;
        delete vtpk_vga2_4_lo;
        delete emit_adc_b;
        delete emit_adc_s_after;
        delete emit_adc_s_before;
        delete temp_reg_a;
        delete temp_reg_b;
        delete temp_reg_c;
        delete temp_adc_mode;
        delete bf_sel;
        delete osc_aaf_dof;
        delete osc_select;
        delete rint;
        delete X0;
    };

