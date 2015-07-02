    class CstatusRegisters
    {
    public:
        bitField *chip_id;
        bitField *c_en;
        bitField *sleeping;
        bitField *vddok;
        bitField *ready;
        bitField *enout;

        CstatusRegisters();
        ~CstatusRegisters();
    }*statusRegisters;

    class CsamplingControlRegisters
    {
    public:
        bitField *sample_num;
        bitField *sample_len;
        bitField *sample_period;
        bitField *sample_skip;
        bitField *collision_det_en;
        bitField *zp_cal_en;
        bitField *dc_cal_en;
        bitField *light_en;
        bitField *cali_freq;
        bitField *cali_mode;
        bitField *adc_mode;
        bitField *dc_cal_len;
        bitField *zp_cal_len;
        bitField *collision_len;

        CsamplingControlRegisters();
        ~CsamplingControlRegisters();
    }*samplingControlRegisters;

    class CalgorithmControlRegisters
    {
    public:
        bitField *agc_max_iter;
        bitField *agc_cal_en;
        bitField *agc_en;
        bitField *agc_acc_thld;
        bitField *agc_persistance_thld;
        bitField *min_vga2_exp;
        bitField *min_vga1_exp;
        bitField *dsp_light_en;
        bitField *dsp_cal_en;
        bitField *dsp_ts_en;
        bitField *dsp_ol_en;

        CalgorithmControlRegisters();
        ~CalgorithmControlRegisters();
    }*algorithmControlRegisters;

    class CsignalIntegrityRegisters
    {
    public:
        bitField *threshhold_dc;
        bitField *noise_thld_os;
        bitField *noise_thld_slope;
        bitField *mag_squelch_exp;
        bitField *mag_squelch;
        bitField *ckt_noise;
        bitField *ckt_noise_conn;
        bitField *noise_gain;
        bitField *fixed_error;
        bitField *coll_pk_sel;

        CsignalIntegrityRegisters();
        ~CsignalIntegrityRegisters();
    }*signalIntegrityRegisters;

    class CclosedLoopCalibrationRegisters
    {
    public:
        bitField *i_xtalk_exp;
        bitField *i_xtalk;
        bitField *q_xtalk_exp;
        bitField *q_xtalk;
        bitField *gain_xtalk;
        bitField *mag_ref_exp;
        bitField *mag_ref;
        bitField *phase_offset;

        CclosedLoopCalibrationRegisters();
        ~CclosedLoopCalibrationRegisters();
    }*closedLoopCalibrationRegisters;

    class CopenLoopCorrectionRegisters 
    {
    public:
        bitField *ol_temp_ref;
        bitField *ol_emit_ref;
        bitField *ol_phase_co_exp;
        bitField *ol_phase_temp_co1;
        bitField *ol_phase_emit_co1;
        bitField *ol_phase_amb_co1;
        bitField *ol_phase_vga1_co1;
        bitField *ol_phase_vga2_co1;
        bitField *ol_phase_temp_co2;
        bitField *ol_phase_emit_co2;
        bitField *ol_phase_amb_co2;
        bitField *ol_phase_vga1_co2;
        bitField *ol_phase_vga2_co2;
        bitField *ol_i_temp_co1;
        bitField *ol_i_emit_co1;
        bitField *ol_i_amb_co1;
        bitField *ol_i_vga1_co1;
        bitField *ol_i_vga2_co1;
        bitField *ol_i_temp_co2;
        bitField *ol_i_emit_co2;
        bitField *ol_i_amb_co2;
        bitField *ol_i_vga1_co2;
        bitField *ol_i_vga2_co2;
        bitField *ol_q_temp_co1;
        bitField *ol_q_emit_co1;
        bitField *ol_q_amb_co1;
        bitField *ol_q_vga1_co1;
        bitField *ol_q_vga2_co1;
        bitField *ol_q_temp_co2;
        bitField *ol_q_emit_co2;
        bitField *ol_q_amb_co2;
        bitField *ol_q_vga1_co2;
        bitField *ol_q_vga2_co2;
        bitField *emitter_ol_sel;

        CopenLoopCorrectionRegisters ();
        ~CopenLoopCorrectionRegisters ();
    }*openLoopCorrectionRegisters ;

    class CinterruptRegisters
    {
    public:
        bitField *ro_irq;
        bitField *change_en;
        bitField *interrrupt_data_invalid;
        bitField *interrupt_ctrl;
        bitField *data_invalid_mask;
        bitField *persistance;
        bitField *noise_buffer_enable;
        bitField *noise_buffer_sign;
        bitField *noise_buffer_ctrl;
        bitField *c1_mag3_en;
        bitField *c1_mag2_en;
        bitField *c1_mag1_en;
        bitField *c1_zone3_en;
        bitField *c1_zone2_en;
        bitField *c1_zone1_en;
        bitField *c1_motion_magnitude_en;
        bitField *c1_motion_distance_en;
        bitField *c2_mag3_en;
        bitField *c2_mag2_en;
        bitField *c2_mag1_en;
        bitField *c2_zone3_en;
        bitField *c2_zone2_en;
        bitField *c2_zone1_en;
        bitField *c2_motion_magnitude_en;
        bitField *c2_motion_distance_en;
        bitField *motion_dist_ref;
        bitField *motion_mag_exp;
        bitField *motion_mag_ref;
        bitField *brownout_flag;
        bitField *change_flag;
        bitField *event_flag;
        bitField *condition_2_flag;
        bitField *condition_1_flag;
        bitField *data_ready;
        bitField *mag3_flag;
        bitField *mag2_flag;
        bitField *mag1_flag;
        bitField *zone3_flag;
        bitField *zone2_flag;
        bitField *zone1_flag;
        bitField *motion_magnitude_flag;
        bitField *motion_distance_flag;
        bitField *detect_ref;

        CinterruptRegisters();
        ~CinterruptRegisters();
    }*interruptRegisters;

    class CdetectionModeControlRegisters 
    {
    public:
        bitField *dist1_high;
        bitField *dist1_low;
        bitField *dist2_high;
        bitField *dist2_low;
        bitField *dist3_high;
        bitField *dist3_low;
        bitField *mag1_high_exp;
        bitField *mag1_high;
        bitField *mag2_low_exp;
        bitField *mag2_low;
        bitField *mag2_high_exp;
        bitField *mag2_high;
        bitField *mag3_low_exp;
        bitField *mag3_low;
        bitField *motion_dist_thld;
        bitField *motion_mag_thld;

        CdetectionModeControlRegisters ();
        ~CdetectionModeControlRegisters ();
    }*detectionModeControlRegisters ;

    class CanalogControlRegisters
    {
    public:
        bitField *driver_s;
        bitField *emitter_current;
        bitField *driver_enbal;
        bitField *driver_nboost_en;
        bitField *driver_thresh_en;
        bitField *driver_t;
        bitField *driver_boost;
        bitField *driver_d;
        bitField *driver_p;
        bitField *afe_pd_dc;
        bitField *afe_lowcap_mode;
        bitField *lna_gain;
        bitField *afe_gain;
        bitField *afe_bypass;
        bitField *afe_xtlk_en;
        bitField *afe_dac_hi;
        bitField *afe_dac_lo;
        bitField *amb_fast;
        bitField *amb_dac_test;
        bitField *X;
        bitField *zp_control;
        bitField *sel_256_255b;
        bitField *vga1_light_manual;
        bitField *vga2_light_manual;
        bitField *vga1_zp_manual;
        bitField *vga2_zp_manual;
        bitField *vga1_coll;
        bitField *vga2_coll;
        bitField *adc_vref;
        bitField *vtpk_vga2_1_hi;
        bitField *vtpk_vga2_1_lo;
        bitField *vtpk_vga2_0_hi;
        bitField *vtpk_vga2_0_lo;
        bitField *vtpk_vga2_3_hi;
        bitField *vtpk_vga2_3_lo;
        bitField *vtpk_vga2_2_hi;
        bitField *vtpk_vga2_2_lo;
        bitField *vtpk_iq_hi;
        bitField *vtpk_iq_lo;
        bitField *vtpk_vga2_4_hi;
        bitField *vtpk_vga2_4_lo;
        bitField *emit_adc_b;
        bitField *emit_adc_s_after;
        bitField *emit_adc_s_before;
        bitField *temp_reg_a;
        bitField *temp_reg_b;
        bitField *temp_reg_c;
        bitField *temp_adc_mode;
        bitField *bf_sel;
        bitField *osc_aaf_dof;
        bitField *osc_select;
        bitField *rint;
        bitField *X0;

        CanalogControlRegisters();
        ~CanalogControlRegisters();
    }*analogControlRegisters;

