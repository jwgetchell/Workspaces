/**********************************************************************
 Module     : Engineer Mode
 Created On : 6-Jun-2014      
 Class file : Enggimode.cs
 This class provides :
 1) It is enggi Mode in which Customer can read and write each register manually and auto refresh is also available.
 2) Each register has set of bits which have there own functionality are also read-write by customer.
 
 **************************************************************************/
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using Inersil_WPFV2.Repository;
using IntersilLib;
using System.IO;
namespace ISL29177
{
    public partial class EnggiMode : Form
    {
        //To store a runtime copy of regiter values.
        //byte[] CopyReg;
        //Creating dictionory to fill dropdown or combobox wirth there respective values.
        Dictionary<string, int> CBproxSLP, CBproxCurrent, CBproxPers, CBPROXSLPCTRL, CBREXTSEL, CBIBIAS, PROXTEST, IRDRTEST, REGCTRL, ANATEST, INTTEST, IRDRTRIM, OSADJ, GAIN, FUSE, EMUL, WR_EN;
        MainScreen MS;
        // constructor for Enggi Mode page
        public EnggiMode(MainScreen MS)
        {
            InitializeComponent();
            this.MS = MS;
            //Load Initial values from the sensors.
            //CopyReg =  loadInitialValues();
            //Start the timer event to retrieve the current values of register(auto refresh).
            RefreshAllTimer.Start();
            //To fill the dropdown or comobox.
            FillDropDown();
            //read Register 14 .
            GetRegister14();
            
        }

        /// <summary>
        /// Filling dropdown with ther respective values.
        /// </summary>
        private void FillDropDown()
        {
            
            CBproxSLP = new Dictionary<string, int>
                {
                     {"400ms", 0}, {"200ms", 1},{"100ms", 2},{"50ms", 3}, 
                     {"25ms[3]", 4},{"25ms[2]", 5},{"25ms[1]", 6},{"25ms[0]", 7},
                };
            this._cbPROX_SLP.DisplayMember = "Key";
            this._cbPROX_SLP.ValueMember = "Value";
            foreach (KeyValuePair<string, int> words in CBproxSLP)
            {
                _cbPROX_SLP.Items.Add(new ComboboxItem(words.Key, words.Value));
            }


            FillProxCurrDropdown();
            
            CBproxPers = new Dictionary<string, int>
                {
                   // {"1 conversion data",0}, {"2 conversion data", 1},{"4 conversion data", 2},{"8 conversion data", 3},
                   {"1 conv",0}, {"2 conv", 1},{"4 conv", 2},{"8 conv", 3},
                };
            this._cbPROX_PERST.DisplayMember = "Key";
            this._cbPROX_PERST.ValueMember = "Value";
            foreach (KeyValuePair<string, int> words in CBproxPers)
            {
                _cbPROX_PERST.Items.Add(new ComboboxItem(words.Key, words.Value));
            }
            
            CBPROXSLPCTRL = new Dictionary<string, int>
                {
                    {"Normal",0},{"512 Time Faster", 1},
                };
            this._cbproSleepCtrlWrite.DisplayMember = "Key";
            this._cbproSleepCtrlWrite.ValueMember = "Value";
            foreach (KeyValuePair<string, int> words in CBPROXSLPCTRL)
            {
                _cbproSleepCtrlWrite.Items.Add(new ComboboxItem(words.Key, words.Value));
            }
            
            CBREXTSEL = new Dictionary<string, int>
                {
                    {"500K",0},{"468K", 1},{"516K", 2},{"564K", 3},
                };
            this._cbRextSelectWrite.DisplayMember = "Key";
            this._cbRextSelectWrite.ValueMember = "Value";
            foreach (KeyValuePair<string, int> words in CBREXTSEL)
            {
                _cbRextSelectWrite.Items.Add(new ComboboxItem(words.Key, words.Value));
            }
            
            CBIBIAS = new Dictionary<string, int>
                {
                    {"0nA",0},{"500nA", 1},{"500nA Same", 2},{"1000nA", 3},
                };
            this._cbIBIAScntrlWrite.DisplayMember = "Key";
            this._cbIBIAScntrlWrite.ValueMember = "Value";
            foreach (KeyValuePair<string, int> words in CBIBIAS)
            {
                _cbIBIAScntrlWrite.Items.Add(new ComboboxItem(words.Key, words.Value));
            }
            
            PROXTEST = new Dictionary<string, int>
                {
                    {"125nA Default", 0},{"250nA", 1},{"75nA", 2},{"Abssolute Sensivity", 3},{"125nA", 4},{"250nA Inverted", 5},{"500nA", 6},{"1000nA", 7},
                };
            this._cbPROXTestWrite.DisplayMember = "Key";
            this._cbPROXTestWrite.ValueMember = "Value";
            foreach (KeyValuePair<string, int> words in PROXTEST)
            {
                _cbPROXTestWrite.Items.Add(new ComboboxItem(words.Key, words.Value));
            }
            
            IRDRTEST = new Dictionary<string, int>
                {
                    {"Current Pulse", 0},{"DC Current", 1},
                };
            this._cbIRDRcurrentWrite.DisplayMember = "Key";
            this._cbIRDRcurrentWrite.ValueMember = "Value";
            foreach (KeyValuePair<string, int> words in IRDRTEST)
            {
                _cbIRDRcurrentWrite.Items.Add(new ComboboxItem(words.Key, words.Value));
            }
            
            REGCTRL = new Dictionary<string, int>
                {
                    {"2K", 0},{"3K", 1},
                };
            this._cbRegCtrlWrite.DisplayMember = "Key";
            this._cbRegCtrlWrite.ValueMember = "Value";
            foreach (KeyValuePair<string, int> words in REGCTRL)
            {
                _cbRegCtrlWrite.Items.Add(new ComboboxItem(words.Key, words.Value));
            }
            
            ANATEST = new Dictionary<string, int>
                {
                    {"0", 0},{"1", 1},
                };
            this._cbAnatestENWrite.DisplayMember = "Key";
            this._cbAnatestENWrite.ValueMember = "Value";
            foreach (KeyValuePair<string, int> words in ANATEST)
            {
                _cbAnatestENWrite.Items.Add(new ComboboxItem(words.Key, words.Value));
            }
            
            INTTEST = new Dictionary<string, int>
                {
                    {"PROX INTR", 0},{"PROX PD", 1},
                };
            this._cbINTfuncWrite.DisplayMember = "Key";
            this._cbINTfuncWrite.ValueMember = "Value";
            foreach (KeyValuePair<string, int> words in INTTEST)
            {
                _cbINTfuncWrite.Items.Add(new ComboboxItem(words.Key, words.Value));
            }
            
            IRDRTRIM = new Dictionary<string, int>
                {
                    {"-12%", 0},{"-10%", 1}, {"-8%", 2},{"-4%", 3}, {"0%", 4},{"4%", 5}, {"8%", 6},{"10%", 7},
                };
            this._cbIRDRTRIMWrite.DisplayMember = "Key";
            this._cbIRDRTRIMWrite.ValueMember = "Value";
            foreach (KeyValuePair<string, int> words in IRDRTRIM)
            {
                _cbIRDRTRIMWrite.Items.Add(new ComboboxItem(words.Key, words.Value));
            }
            
            OSADJ = new Dictionary<string, int>
                {
                    {"4CTS", 0},{"50CTS", 1},
                };
            this._cbPROX_OSADJwrite.DisplayMember = "Key";
            this._cbPROX_OSADJwrite.ValueMember = "Value";
            foreach (KeyValuePair<string, int> words in OSADJ)
            {
                _cbPROX_OSADJwrite.Items.Add(new ComboboxItem(words.Key, words.Value));
            }
            
            GAIN = new Dictionary<string, int>
                {
                    {"11.5k Lux", 0},{"19k Lux", 1},
                };
            this._cbPROX_GAINWrite.DisplayMember = "Key";
            this._cbPROX_GAINWrite.ValueMember = "Value";
            foreach (KeyValuePair<string, int> words in GAIN)
            {
                _cbPROX_GAINWrite.Items.Add(new ComboboxItem(words.Key, words.Value));
            }
            
            FUSE = new Dictionary<string, int>
                {
                    {"0", 0},{"1", 1},
                };
            this._cbID_FUSE.DisplayMember = "Key";
            this._cbID_FUSE.ValueMember = "Value";
            foreach (KeyValuePair<string, int> words in FUSE)
            {
                _cbID_FUSE.Items.Add(new ComboboxItem(words.Key, words.Value));
            }
            EMUL = new Dictionary<string, int>
                {
                    {"OTP Slct", 0},{"Reg Slct", 1},
                };
            this._cbEMULATIONWrite.DisplayMember = "Key";
            this._cbEMULATIONWrite.ValueMember = "Value";
            foreach (KeyValuePair<string, int> words in EMUL)
            {
                _cbEMULATIONWrite.Items.Add(new ComboboxItem(words.Key, words.Value));
            }
            
            WR_EN = new Dictionary<string, int>
                {
                    {"Disable", 0},{"Enable", 1},
                };
            this._cbWR_ENWrite.DisplayMember = "Key";
            this._cbWR_ENWrite.ValueMember = "Value";
            foreach (KeyValuePair<string, int> words in WR_EN)
            {
                _cbWR_ENWrite.Items.Add(new ComboboxItem(words.Key, words.Value));
            }
        }
        /// <summary>
        /// To fill Prox Current dropdown.It depends on ID fuse bit of register 0x0E.
        /// </summary>
       private void FillProxCurrDropdown()
        {
            _cbPROXCURRENT.Items.Clear();
            if(GlobalVariables.IRDR_SHRT==(byte)0)
            {
            CBproxCurrent = new Dictionary<string, int>
                {
                    {"3.6mA", 0},                    {"7.1mA", 1},                    {"10.7mA", 2},                     {"12.5mA", 3},
                     {"14.3mA", 4},                   {"15mA", 5},                     {"17.5mA", 6},                     {"20mA", 7},
                };
            }
            else
            {
            CBproxCurrent = new Dictionary<string, int>
                {
                    {"50mA", 8},                     {"75mA", 9},                     {"100mA", 10},                     {"125mA", 11},
                     {"150mA", 12},                   {"175mA", 13},                   {"200mA", 14},                     {"225mA", 15},
                };
            }
            this._cbPROXCURRENT.DisplayMember = "Key";
            this._cbPROXCURRENT.ValueMember = "Value";
            foreach (KeyValuePair<string, int> words in CBproxCurrent)
            {
                _cbPROXCURRENT.Items.Add(new ComboboxItem(words.Key, words.Value));
            }
        }
        /// <summary>
        /// Load or Read initial values of register 
        /// </summary>
        /// <returns></returns>
        private byte[] loadInitialValues()
        {
            for (int i = 0; i <= 15; i++)
            {
                //Reading a single register at a time.
                Int16 status = HIDClass.ReadSingleRegister((byte)0, 1, (byte)i);
            }
            return GlobalVariables.WriteRegs;
        }

              
        /// <summary>
        /// GET REGISTER 1 VALUES
        /// </summary>
        private void GetRegister1()
        {
            //Read Register 1 PROX EN
            byte proxEN = (byte)((GlobalVariables.WriteRegs[1] & (byte)Convert.ToInt32(128)) >> 7);
            if (proxEN == (byte)0)
            {
                _chkPROX_EN.Checked = false;
                _lblproEn.Text = "Disable";
            }
            if (proxEN == (byte)1)
            {
                _chkPROX_EN.Checked = true;
                _lblproEn.Text = "Enable";
            }
            //Read Register 1 PROX SLP
            byte ProxSLP = (byte)((GlobalVariables.WriteRegs[1] & (byte)Convert.ToInt32(112)) >> 4);
            int PProxSLPVal = Convert.ToInt32(ProxSLP);
            foreach (ComboboxItem selectedData in _cbPROX_SLP.Items)
            {
                if (Convert.ToInt32(selectedData.Value) == PProxSLPVal)
                {
                    _txtPROX_SLP.Text = selectedData.Text;
                }
            }
            //Read IRDR currrent
            if (_chkIRDR.Checked == true)
            {
                Int16 status = HIDClass.ReadSingleRegister((byte)Convert.ToInt32(0), 1, (byte)1);
                if (status == 8)
                {
                    byte copy = GlobalVariables.WriteRegs[1];
                    byte AfterAND = (byte)(copy & (byte)247);
                    byte AfterSHIFT = (byte)((byte)Convert.ToInt32(1) << 3);
                    byte AfterOR = (byte)(AfterSHIFT | AfterAND);
                    Int16 status1 = HIDClass.WriteSingleRegister(AfterOR, 1, (byte)1);
                }
            }
            else
            {
                Int16 status = HIDClass.ReadSingleRegister((byte)Convert.ToInt32(0), 1, (byte)1);
                if (status == 8)
                {
                    byte copy = GlobalVariables.WriteRegs[1];
                    byte AfterAND = (byte)(copy & (byte)247);
                    byte AfterSHIFT = (byte)((byte)Convert.ToInt32(0) << 3);
                    byte AfterOR = (byte)(AfterSHIFT | AfterAND);
                    Int16 status1 = HIDClass.WriteSingleRegister(AfterOR, 1, (byte)1);
                }

            }
            //Read Register 1 PROX CURRENT
            byte ProxCurrent = (byte)(GlobalVariables.WriteRegs[1] & (byte)Convert.ToInt32(7));
            int ProxCurrentVal = Convert.ToInt32(ProxCurrent);
            foreach (ComboboxItem selectedData in _cbPROXCURRENT.Items)
            {
                if (_chkIRDR.Checked == true)
                {
                    if (Convert.ToInt32(selectedData.Value) == ProxCurrentVal + 8)
                    {
                        _txtPROX_CURRENT.Text = selectedData.Text;
                    }
                }
                else
                {
                    if (Convert.ToInt32(selectedData.Value) == ProxCurrentVal)
                    {
                        _txtPROX_CURRENT.Text = selectedData.Text;
                    }
                }
            }
        }

        /// <summary>
        /// GET REGISTER 2 VALUES
        /// </summary>
        private void GetRegister2()
        {
            //Read Register 2 PROX EN
            byte PROX_PULSE = (byte)((GlobalVariables.WriteRegs[2] & (byte)Convert.ToInt32(64)) >> 6);
            if (PROX_PULSE == (byte)0)
            {
                _chkPROX_PULSE.Checked = false;
            }
            if (PROX_PULSE == (byte)1)
            {
                _chkPROX_PULSE.Checked = true;
            }
            //Read Register 2 High OFFSET
            byte highOffset = (byte)((GlobalVariables.WriteRegs[2] & (byte)Convert.ToInt32(32)) >> 5);
            if (highOffset == (byte)0)
            {
                _chkhighOffset.Checked = false;
            }
            if (highOffset == (byte)1)
            {
                _chkhighOffset.Checked = true;
            }
            //Read Register 2 PROX BSCAT
            Int16 status = HIDClass.ReadSingleRegister((byte)Convert.ToInt32(0), 1, (byte)2);
            byte PROX_BSCAT = (byte)(GlobalVariables.WriteRegs[2] & (byte)31);
            _txtproBSCATRead.Text = PROX_BSCAT.ToString("X2");
        }

        /// <summary>
        /// GET REGISTER 3 VALUES
        /// </summary>
        private void GetRegister3()
        {
            Int16 status = HIDClass.ReadSingleRegister((byte)0, 1, (byte)3);
            if (status == 8)
            {
                //Register 3 PROX PERST Read
                
                byte ProxPerst = (byte)((byte)(GlobalVariables.WriteRegs[3] & (byte)Convert.ToInt32(48)) >> 4);
                int ProxPerstVal = Convert.ToInt32(ProxPerst);
                foreach (KeyValuePair<string, int> words in CBproxPers)
                {
                if (ProxPerstVal == words.Value)
                    {
                            _txtPROX_PERST.Text = words.Key;
                    }
                }
                //Register 3 IRDR TRIM Read
                byte IRDRTRIM = (byte)((GlobalVariables.WriteRegs[3] & (byte)Convert.ToInt32(64)) >> 6);
                if (IRDRTRIM == (byte)0)
                    {
                        _chkIRDRTRIM.Checked = false;
                    }
                if (IRDRTRIM == (byte)1)
                    {
                        _chkIRDRTRIM.Checked = true;
                    }
                //Register 3 PROX FLAG Read
                byte PROXFLAG = (byte)((GlobalVariables.WriteRegs[3] & (byte)Convert.ToInt32(8)) >> 3);
                if (PROXFLAG == (byte)0)
                    {
                        _chkPROXFLAG.Checked = false;
                    }
                if (PROXFLAG == (byte)1)
                    {
                        _chkPROXFLAG.Checked = true;
                    }
                //Register 3 PROX DONE Read
                byte PROXDONE = (byte)((GlobalVariables.WriteRegs[3] & (byte)Convert.ToInt32(4)) >> 2);
                if (PROXDONE == (byte)0)
                {
                        _chlPROXDONE.Checked = false;
                }
                if (PROXDONE == (byte)1)
                {
                        _chlPROXDONE.Checked = true;
                }
                //Register 3 IRDR SHRT read
                byte IRDR_SHRT = (byte)((GlobalVariables.WriteRegs[3] & (byte)Convert.ToInt32(2)) >> 1);
                if (IRDR_SHRT == (byte)0)
                {
                    _chkIRDR_SHRT.Checked = false;
                }
                if (IRDR_SHRT == (byte)1)
                {
                    _chkIRDR_SHRT.Checked = true;
                }
                //Register 3 INT WSH Read
                byte INT_WSH = (byte)(GlobalVariables.WriteRegs[3] & (byte)Convert.ToInt32(1));
                if (INT_WSH == (byte)0)
                {
                    _chkINT_WSH_EN.Checked = false;
                }
                if (INT_WSH == (byte)1)
                {
                    _chkINT_WSH_EN.Checked = true;
                }
            }
        }
        
        /// <summary>
        /// GET REGISTER 4 VALUES
        /// </summary>
        private void GetRegister4()
        { 
            Int16 status = HIDClass.ReadSingleRegister((byte)0, 1, (byte)4);
            //Register 4 Low TH Read
            if (status == 8)
            {
                _txtLowTHRead.Text = GlobalVariables.WriteRegs[4].ToString("X2");
            }
        
        }

        /// <summary>
        ///GET REGISTER 5 VALUES 
        /// </summary>
        private void GetRegister5()
        {
            Int16 status = HIDClass.ReadSingleRegister((byte)0, 1, (byte)5);
            if (status == 8)
            {
                //Register 5 HIGH TH Read
                _txtHighTHRead.Text = GlobalVariables.WriteRegs[5].ToString("X2");
            }
        }

        /// <summary>
        /// GET REGISTER 6 VALUES 
        /// </summary>
        private void GetRegister6()
        {
                //Register 6 I2C Fault Detection
                byte I2C_Fault_detection = (byte)((GlobalVariables.WriteRegs[6] & (byte)16) >> 4);
                if (I2C_Fault_detection == (byte)0)
                {
                    ovalI2C_Fault_detection.BackColor = Color.White;
                }
                if (I2C_Fault_detection == (byte)1)
                {
                    ovalI2C_Fault_detection.BackColor = Color.Green;
                }
                //Register 6 PROX INT Flag
                byte PROX_interrupt_flag = (byte)((GlobalVariables.WriteRegs[6] & (byte)8) >> 3);
                if (Convert.ToInt16(PROX_interrupt_flag) == 0)
                {
                    oval_PROX_interrupt_flag.BackColor = Color.White;
                }
                if (Convert.ToInt16(PROX_interrupt_flag) == 1)
                {
                    oval_PROX_interrupt_flag.BackColor = Color.Green;
                }
                //Register 6 PROX CONV INT
                byte PROX_conversion_intr = (byte)((GlobalVariables.WriteRegs[6] & (byte)4) >> 2);
                if (Convert.ToInt16(PROX_conversion_intr) == 0)
                {
                    ovalPROX_conversion_intr.BackColor = Color.White;
                }
                if (Convert.ToInt16(PROX_conversion_intr) == 1)
                {
                    ovalPROX_conversion_intr.BackColor = Color.Red;
                }
                //Register 6 LOW IRDR VDS DETECT
                byte LOW_IRDR_VDS_DETECT = (byte)((GlobalVariables.WriteRegs[6] & (byte)2) >> 1);
                if (Convert.ToInt16(LOW_IRDR_VDS_DETECT) == 0)
                {
                    oval_LOW_IRDR_VDS_DETECT.BackColor = Color.White;
                }
                if (Convert.ToInt16(LOW_IRDR_VDS_DETECT) == 1)
                {
                    oval_LOW_IRDR_VDS_DETECT.BackColor = Color.Green;
                }
                //Register 6 PROX Wahsout Flag
                byte PROX_wahsout_flag = (byte)(GlobalVariables.WriteRegs[6] & (byte)1);
                if (Convert.ToInt16(PROX_wahsout_flag) == 0)
                {
                    ovalPROX_wahsout_flag.BackColor = Color.White;
                }
                if (Convert.ToInt16(PROX_wahsout_flag) == 1)
                {
                    ovalPROX_wahsout_flag.BackColor = Color.Green;
                }
           
        }
        /// <summary>
        /// GET REGISTER 7 VALUES 
        /// </summary>
        private void GetRegister7()
        {
            //Register 7 PROX COUNT
            Int16 status = HIDClass.ReadSingleRegister((byte)0, 1, (byte)7);
            if (status == 8)
            {
                _txtPROXCount.Text = GlobalVariables.WriteRegs[7].ToString("X2");

            }
        }

        /// <summary>
        /// GET REGISTER 8 VALUES 
        /// </summary>
        private void GetRegister8()
        {
            //Register 8 PROX DAC DATA
            Int16 status = HIDClass.ReadSingleRegister((byte)0, 1, (byte)8);
            if (status == 8)
            {
                _txtPROX_DACDATA.Text = GlobalVariables.WriteRegs[8].ToString("X2");
            }
        }
       
        /// <summary>
        /// GET REGISTER 10 VALUES
        /// </summary>
        private void GetRegister10()
        {
            Int16 status = HIDClass.ReadSingleRegister((byte)0, 1, (byte)10);
            if (status == 8)
            {
                //Register 10 PROX COUNT MODE2
                byte ProxCountMODE2 = (byte)(GlobalVariables.WriteRegs[10] & (byte)15);
                _txtProxCountMODE2.Text = ProxCountMODE2.ToString("X2");
            }
        }
        
        /// <summary>
        /// GET REGISTER 11 VALUES
        /// </summary>
        private void GetRegister11()
        {
            Int16 status = HIDClass.ReadSingleRegister((byte)0, 1, (byte)11);
            if (status == 8)
            {
                //Register 11 PROX Slp CTRL Read
                byte ProxSLPCtrl = (byte)((GlobalVariables.WriteRegs[11] & (byte)Convert.ToInt32(32)) >> 5);
                int PProxSLPCtrlVal = Convert.ToInt32(ProxSLPCtrl);
                foreach (ComboboxItem selectedData in _cbproSleepCtrlWrite.Items)
                {
                    if (Convert.ToInt32(selectedData.Value) == PProxSLPCtrlVal)
                    {
                        _txtproSleepCtrlRead.Text = selectedData.Text;
                    }
                }
                //Register 11 Measure REXT Read
                 byte MeasRext = (byte)((GlobalVariables.WriteRegs[11] & (byte)Convert.ToInt32(16)) >> 4);
                if (_cbMeasRextWrite.Text == "Select")
                    _txtMeasRextRead.Text = MeasRext.ToString();
                else
                    _txtMeasRextRead.Text = _cbMeasRextWrite.Text;
                //Register 11 REXT Selected Read
                 byte RextSelect = (byte)((GlobalVariables.WriteRegs[11] & (byte)Convert.ToInt32(12)) >> 2);
                 int RextSelectVal = Convert.ToInt32(RextSelect);
                 foreach (ComboboxItem selectedData in _cbRextSelectWrite.Items)
                 {
                     if (Convert.ToInt32(selectedData.Value) == RextSelectVal)
                     {
                         _txtRextSelectRead.Text = selectedData.Text;
                     }
                 }
                 //Register 11 IBIAS Cntrl  Read
                  byte IBIAScntrl = (byte)(GlobalVariables.WriteRegs[11] & (byte)Convert.ToInt32(3));
                  int IBIAScntrlVal = Convert.ToInt32(IBIAScntrl);
                  foreach (ComboboxItem selectedData in _cbIBIAScntrlWrite.Items)
                  {
                      if (Convert.ToInt32(selectedData.Value) == IBIAScntrlVal)
                      {
                          _txtIBIAScntrlRead.Text = selectedData.Text;
                      }
                  }
            }         
        }
        
        /// <summary>
        /// GET REGISTER 12 VALUES
        /// </summary>
        private void GetRegister12()
        {
            Int16 status = HIDClass.ReadSingleRegister((byte)0, 1, (byte)12);
            if (status == 8)
            {
                //Register 12 Residue Cntrl Read
                byte ResidueCtrl = (byte)((GlobalVariables.WriteRegs[12] & (byte)Convert.ToInt32(8))>>3);
                _txtResidueCtrlRead.Text = ResidueCtrl.ToString("X2");
            }
            if (status == 8)
            {
                //Register 12 PROX TEST Read
                byte PROTEST = (byte)(GlobalVariables.WriteRegs[12] & (byte)Convert.ToInt32(7));
                int PROXTESTVal = Convert.ToInt32(PROTEST);
                foreach (ComboboxItem selectedData in _cbPROXTestWrite.Items)
                {
                    if (Convert.ToInt32(selectedData.Value) == PROXTESTVal)
                    {
                        _txtproTestRead.Text = selectedData.Text;
                    }
                }
            }
        
        }

        /// <summary>
        /// GET REGISTER 13 VALUES
        /// </summary>
        private void GetRegister13()
        {
            Int16 status = HIDClass.ReadSingleRegister((byte)0, 1, (byte)13);
            if (status == 8)
            {
                //Register 13 OT DoNE Read
                byte OTPDONE = (byte)((GlobalVariables.WriteRegs[13] & (byte)Convert.ToInt32(128)) >> 7);
                if (OTPDONE == (byte)0)
                {
                    _ovalotpDone.BackColor = Color.White;
                }
                if (OTPDONE == (byte)1)
                {
                    _ovalotpDone.BackColor = Color.Green;
                }
                //Register 13 GOLDEN Read
                byte Golden = (byte)((GlobalVariables.WriteRegs[13] & (byte)Convert.ToInt32(64)) >> 6);
                if (Golden == (byte)0)
                {
                    _ovalGoldenStatus.BackColor = Color.White;
                }
                if (Golden == (byte)1)
                {
                    _ovalGoldenStatus.BackColor = Color.Green;
                }
                //Register 13 I2C ADDR Read
                byte I2Caddr = (byte)((GlobalVariables.WriteRegs[13] & (byte)Convert.ToInt32(48)) >> 4);
                if (I2Caddr == (byte)0)
                {
                   _txtI2CaddrRead.Text = "44h";
                }
                else if (I2Caddr == (byte)1)
                {
                   _txtI2CaddrRead.Text = "45h";
                }
                else if (I2Caddr == (byte)2)
                {
                    _txtI2CaddrRead.Text = "46h";
                }
                else if (I2Caddr == (byte)3)
                {
                    _txtI2CaddrRead.Text = "47h";
                }
             
                //Register 13 IRDR CURR Read
                byte IRDRCurrent = (byte)((GlobalVariables.WriteRegs[13] & (byte)Convert.ToInt32(8)) >> 3);
                int IRDRCurrentVal = Convert.ToInt32(IRDRCurrent);
                foreach (ComboboxItem selectedData in _cbIRDRcurrentWrite.Items)
                {
                    if (Convert.ToInt32(selectedData.Value) == IRDRCurrentVal)
                    {
                        _txtIRDRcurrentRead.Text = selectedData.Text;
                    }
                }
                //Register 13 REG CTRL Read
                byte RegiCtrl = (byte)((GlobalVariables.WriteRegs[13] & (byte)Convert.ToInt32(4)) >> 2);
                int RegiCtrlVal = Convert.ToInt32(RegiCtrl);
                foreach (ComboboxItem selectedData in _cbRegCtrlWrite.Items)
                {
                    if (Convert.ToInt32(selectedData.Value) == RegiCtrlVal)
                    {
                        _txtRegCtrlRead.Text = selectedData.Text;
                    }
                }
                //Register 13 ANAREST EN Read
                byte AnatestEN = (byte)((GlobalVariables.WriteRegs[13] & (byte)Convert.ToInt32(2)) >> 1);
                int AnatestENVal = Convert.ToInt32(AnatestEN);
                foreach (ComboboxItem selectedData in _cbAnatestENWrite.Items)
                {
                    if (Convert.ToInt32(selectedData.Value) == AnatestENVal)
                    {
                        _txtAnatestENRead.Text = selectedData.Text;
                    }
                }
                //Register 13 INF FUNCT Read
                byte INTfunc = (byte)(GlobalVariables.WriteRegs[13] & (byte)Convert.ToInt32(1));
                int INTfuncVal = Convert.ToInt32(INTfunc);
                foreach (ComboboxItem selectedData in _cbINTfuncWrite.Items)
                {
                    if (Convert.ToInt32(selectedData.Value) == INTfuncVal)
                    {
                        _txtINTfuncRead.Text = selectedData.Text;
                    }
                }
            }
        }

        /// <summary>
        /// GET REGISTER 14 VALUES
        /// </summary>
        private void GetRegister14()
        {
            //:=Register 14 has few diffrent process which we have to follow before to and write from sensor.
            //1.Write register 9 with value 0x89 and then read it.
            //2.Write Register 15 with values 0x40 and then read it.
            //3.Now we can read or write in register 14.
            Int16 status1 = HIDClass.WriteSingleRegister((byte)137, 1, (byte)9);
            status1 = HIDClass.ReadSingleRegister((byte)0, 1, (byte)9);
            Int16 status2 = HIDClass.WriteSingleRegister((byte)64, 1, (byte)15);
            status2 = HIDClass.ReadSingleRegister((byte)0, 1, (byte)15);
            int status = HIDClass.ReadSingleRegister(32, 1, (byte)14);
            if (status == 8)
            {
                //Register 14 IRDR TRIM READ
                byte IRDR_TRIM = (byte)((GlobalVariables.WriteRegs[14] & (byte)Convert.ToInt32(56)) >> 3);
                int IRDR_TRIMVal = Convert.ToInt32(IRDR_TRIM);
                foreach (ComboboxItem selectedData in _cbIRDRTRIMWrite.Items)
                {
                    if (Convert.ToInt32(selectedData.Value) == IRDR_TRIMVal)
                    {
                        _txtIRDR_TRIM.Text = selectedData.Text;
                    }
                }
                //Register 14 PROX OSADJ READ
                 byte PROX_OSADJ = (byte)((GlobalVariables.WriteRegs[14] & (byte)Convert.ToInt32(4)) >> 2);
                 int PROX_OSADJVal = Convert.ToInt32(PROX_OSADJ);
                 foreach (ComboboxItem selectedData in _cbPROX_OSADJwrite.Items)
                 {
                     if (Convert.ToInt32(selectedData.Value) == PROX_OSADJVal)
                     {
                         _txtPROX_OSADJRead.Text = selectedData.Text;
                     }
                 }
                //Register 14 PROX GAIN READ
                byte PROX_GAIN = (byte)((GlobalVariables.WriteRegs[14] & (byte)Convert.ToInt32(2)) >> 1);
                int PROX_GAINVal = Convert.ToInt32(PROX_GAIN);
                foreach (ComboboxItem selectedData in _cbPROX_GAINWrite.Items)
                {
                    if (Convert.ToInt32(selectedData.Value) == PROX_GAINVal)
                    {
                        _txtPROX_GAINRead.Text = selectedData.Text;
                    }
                }
                //Register 14 ID FUSE READ 
                byte ID_FUSE = (byte)(GlobalVariables.WriteRegs[14] & (byte)Convert.ToInt32(1));
                int ID_FUSEVal = Convert.ToInt32(ID_FUSE);
                foreach (ComboboxItem selectedData in _cbID_FUSE.Items)
                {
                    if (Convert.ToInt32(selectedData.Value) == ID_FUSEVal)
                    {
                        _txtID_FUSE.Text = selectedData.Text;
                    }
                }
            }
        }

        /// <summary>
        /// GET REGISTER 15 VALUES
        /// </summary>
        private void GetRegister15()
        { 
            Int16 status = HIDClass.ReadSingleRegister((byte)0, 1, (byte)15);
            
            if (status == 8)
            {
                //Register 15 EMULATION READ
                byte EMULTION = (byte)((GlobalVariables.WriteRegs[15] & (byte)Convert.ToInt32(64)) >> 6);
                int EMULTIONVal = Convert.ToInt32(EMULTION);
                foreach (ComboboxItem selectedData in _cbEMULATIONWrite.Items)
                {
                    if (Convert.ToInt32(selectedData.Value) == EMULTIONVal)
                    {
                        _txtEMULATIONRead.Text = selectedData.Text;
                    }
                }
                //Register 15 OTP DATA READ 
                byte OTP_DATA = (byte)((GlobalVariables.WriteRegs[15] & (byte)Convert.ToInt32(32)) >> 5);
                _txtOTP_DATA.Text = OTP_DATA.ToString("X2");
                //Register 15 WR EN READ
                byte WR_EN1 = (byte)((GlobalVariables.WriteRegs[15] & (byte)Convert.ToInt32(16)) >> 4);
                int WR_ENVal = Convert.ToInt32(WR_EN1);
                foreach (ComboboxItem selectedData in _cbWR_ENWrite.Items)
                {
                    if (Convert.ToInt32(selectedData.Value) == WR_ENVal)
                    {
                        _txtWR_ENRead.Text = selectedData.Text;
                    }
                }
                //Register 15 FUSE ADDR Read
                byte FUSE_ADDR = (byte)(GlobalVariables.WriteRegs[15] & (byte)Convert.ToInt32(15));
                _txtFUSE_ADDRRead.Text = FUSE_ADDR.ToString("X2");
            }
        }
        
        /// <summary>
        /// To close the Enggi Mode form
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void _btnBack_Click(object sender, EventArgs e)
        {
            RefreshAllTimer.Stop();
            this.Close(); 
        }

        /// <summary>
        /// Read all register.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void _btnRefresh_Click(object sender, EventArgs e)
        {
            GetRegister1();
            GetRegister2();
            GetRegister3();
            GetRegister4();
            GetRegister5();
            GetRegister6();
            GetRegister7();
            GetRegister8();
            GetRegister10();
            GetRegister11();
            GetRegister12();
            GetRegister13();
            GetRegister15();        
          //GetRegister14();
        }

        
        
        /// <summary>
        /// REGISTER 1: READ AND WRITE REGISTER START
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void _btnProxENRead_Click(object sender, EventArgs e)
        {
            ////Register 1 PROX EN Read
            //Int16 status = HIDClass.ReadSingleRegister((byte)0, 1, (byte)1);
            //byte proxEN = (byte)((GlobalVariables.WriteRegs[1] & (byte)Convert.ToInt32(128)) >> 7);
            //if (proxEN == (byte)0)
            //{
            //    _chkPROX_EN.Checked = false;
            //}
            //if (proxEN == (byte)1)
            //{
            //    _chkPROX_EN.Checked = true;
            //}
        }

        /// <summary>
        /// Register 1 PROX EN Write
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void _chkPROX_EN_CheckedChanged(object sender, EventArgs e)
        {
            if (_chkPROX_EN.Checked == true)
            {
              Int16 status = HIDClass.ReadSingleRegister((byte)Convert.ToInt32(0), 1, (byte)1);
              if (status == 8)
              {
                  byte copy = GlobalVariables.WriteRegs[1];
                  byte AfterAND = (byte)(copy & (byte)127);
                  byte AfterSHIFT = (byte)((byte)Convert.ToInt32(1) << 7);
                  byte AfterOR = (byte)(AfterSHIFT | AfterAND);
                  Int16 status1 = HIDClass.WriteSingleRegister(AfterOR, 1, (byte)1);
                  _lblproEn.Text = "Enable";
              }
            }
            else
            {
                Int16 status = HIDClass.ReadSingleRegister((byte)Convert.ToInt32(0), 1, (byte)1);
                if (status == 8)
                {
                    byte copy = GlobalVariables.WriteRegs[1];
                    byte AfterAND = (byte)(copy & (byte)127);
                    byte AfterSHIFT = (byte)((byte)Convert.ToInt32(0) << 7);
                    byte AfterOR = (byte)(AfterSHIFT | AfterAND);
                    Int16 status1 = HIDClass.WriteSingleRegister(AfterOR, 1, (byte)1);
                    _lblproEn.Text = "Disable";
                }
                //  _chkPROX_EN.Checked = true;

            }
        }
        /// <summary>
        /// Register 1 PROX SlEEP Read
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void _btnPROX_SLP_Click(object sender, EventArgs e)
        {
            Int16 status = HIDClass.ReadSingleRegister((byte)0, 1, (byte)1);
            if (status == 8)
            {
                byte ProxSLP = (byte)((GlobalVariables.WriteRegs[1] & (byte)Convert.ToInt32(112)) >> 4);
                int PProxSLPVal = Convert.ToInt32(ProxSLP);
                //  ComboBox _cbPROX_SLP = (ComboBox)frmmain.Controls["_cbPROX_SLP"];
                foreach (ComboboxItem selectedData in _cbPROX_SLP.Items)
                {
                    if (Convert.ToInt32(selectedData.Value) == PProxSLPVal)
                    {
                        //_txtPROX_SLP.Text = selectedData.Text;

                    }
                }

            }

        }
        /// <summary>
        /// Register 1 PROX SLEEP Write
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void _cbPROX_SLP_SelectedIndexChanged(object sender, EventArgs e)
        {
            Int16 status = HIDClass.ReadSingleRegister((byte)Convert.ToInt32(0), 1, (byte)1);
            if (status == 8)
            {
                byte copy = GlobalVariables.WriteRegs[1];
                byte AfterAND = (byte)(copy & (byte)143);
                ComboboxItem selectedData = (ComboboxItem)_cbPROX_SLP.SelectedItem;
                byte AfterSHIFT = (byte)((byte)Convert.ToInt32(selectedData.Value) << 4);
                byte AfterOR = (byte)(AfterSHIFT | AfterAND);
                Int16 status1 = HIDClass.WriteSingleRegister(AfterOR, 1, (byte)1);

            }
        }

        /// <summary>
        /// Register 1 PROX CURRENT Read
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void _btnPROXCURRENTRead_Click(object sender, EventArgs e)
        {
            Int16 status = HIDClass.ReadSingleRegister((byte)0, 1, (byte)1);
            if (status == 8)
            {
                byte ProxCurrent = (byte)(GlobalVariables.WriteRegs[1] & (byte)Convert.ToInt32(7));
                int ProxCurrentVal = Convert.ToInt32(ProxCurrent);
                foreach (ComboboxItem selectedData in _cbPROXCURRENT.Items)
                {
                    if (_chkIRDR.Checked == true)
                    {
                        if (Convert.ToInt32(selectedData.Value) == ProxCurrentVal + 8)
                        {
                            _txtPROX_CURRENT.Text = selectedData.Text;
                        }
                    }
                    else
                    {
                        if (Convert.ToInt32(selectedData.Value) == ProxCurrentVal)
                        {
                            _txtPROX_CURRENT.Text = selectedData.Text;
                        }
                    }
                }
            }
        }
        /// <summary>
        /// Register 1 PROX Current Write
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void _cbPROXCURRENT_SelectedIndexChanged(object sender, EventArgs e)
        {
            Int16 status = HIDClass.ReadSingleRegister((byte)Convert.ToInt32(0), 1, (byte)1);
            if (status == 8)
            {
                byte copy = GlobalVariables.WriteRegs[1];
                byte AfterAND = (byte)(copy & (byte)248);
                ComboboxItem selectedData = (ComboboxItem)_cbPROXCURRENT.SelectedItem;
                byte AfterOR = (byte)((byte)Convert.ToInt32(selectedData.Value) | AfterAND);
                Int16 status1 = HIDClass.WriteSingleRegister(AfterOR, 1, (byte)1);

            }
        }
       
        // REGISTER 2: READ AND WRITE REGISTER START
        /// <summary>
        /// Register 2 PROX PULSE Read
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void _btnPROXPULSERead_Click(object sender, EventArgs e)
        {
            Int16 status = HIDClass.ReadSingleRegister((byte)0, 1, (byte)2);
            byte PROX_PULSE = (byte)((GlobalVariables.WriteRegs[2] & (byte)Convert.ToInt32(64)) >> 6);
            if (PROX_PULSE == (byte)0)
            {
                _chkPROX_PULSE.Checked = false;
            }
            if (PROX_PULSE == (byte)1)
            {
                _chkPROX_PULSE.Checked = true;
            }
        }
        /// <summary>
        /// Register 2 PROX PULSE Write
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void _chkPROX_PULSE_CheckedChanged(object sender, EventArgs e)
        {
            if (_chkPROX_PULSE.Checked == true)
            {

                Int16 status = HIDClass.ReadSingleRegister((byte)Convert.ToInt32(0), 1, (byte)2);
                if (status == 8)
                {
                    byte copy = GlobalVariables.WriteRegs[2];
                    byte AfterAND = (byte)(copy & (byte)191);
                    byte AfterSHIFT = (byte)((byte)Convert.ToInt32(1) << 6);
                    byte AfterOR = (byte)(AfterSHIFT | AfterAND);
                    Int16 status1 = HIDClass.WriteSingleRegister(AfterOR, 1, (byte)2);

                }
            }
            else
            {
                Int16 status = HIDClass.ReadSingleRegister((byte)Convert.ToInt32(0), 1, (byte)2);
                if (status == 8)
                {
                    byte copy = GlobalVariables.WriteRegs[2];
                    byte AfterAND = (byte)(copy & (byte)191);
                    byte AfterSHIFT = (byte)((byte)Convert.ToInt32(0) << 6);
                    byte AfterOR = (byte)(AfterSHIFT | AfterAND);
                    Int16 status1 = HIDClass.WriteSingleRegister(AfterOR, 1, (byte)2);

                }
            }
        }
        /// <summary>
        /// Register 2 HIGH OFFSET Read
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void _btnHIGHOFFRead_Click(object sender, EventArgs e)
        {
            Int16 status = HIDClass.ReadSingleRegister((byte)0, 1, (byte)2);
            byte highOffset = (byte)((GlobalVariables.WriteRegs[2] & (byte)Convert.ToInt32(32)) >> 5);
            if (highOffset == (byte)0)
            {
                _chkhighOffset.Checked = false;
            }
            if (highOffset == (byte)1)
            {
                _chkhighOffset.Checked = true;
            }
        }
        /// <summary>
        /// Register 2 HIGH OFFSET Read
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void _chkhighOffset_CheckedChanged(object sender, EventArgs e)
        {
            if (_chkhighOffset.Checked == true)
            {

                Int16 status = HIDClass.ReadSingleRegister((byte)Convert.ToInt32(0), 1, (byte)2);
                if (status == 8)
                {
                    byte copy = GlobalVariables.WriteRegs[2];
                    byte AfterAND = (byte)(copy & (byte)223);
                    byte AfterSHIFT = (byte)((byte)Convert.ToInt32(1) << 5);
                    byte AfterOR = (byte)(AfterSHIFT | AfterAND);
                    Int16 status1 = HIDClass.WriteSingleRegister(AfterOR, 1, (byte)2);
                }
            }
            else
            {
                Int16 status = HIDClass.ReadSingleRegister((byte)Convert.ToInt32(0), 1, (byte)2);
                if (status == 8)
                {
                    byte copy = GlobalVariables.WriteRegs[2];
                    byte AfterAND = (byte)(copy & (byte)223);
                    byte AfterSHIFT = (byte)((byte)Convert.ToInt32(0) << 5);
                    byte AfterOR = (byte)(AfterSHIFT | AfterAND);
                    Int16 status1 = HIDClass.WriteSingleRegister(AfterOR, 1, (byte)2);
                }
            }
        }

        /// <summary>
        /// Register 2 PROX BSCAT Read
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void _btnPROXConfig1Read_Click(object sender, EventArgs e)
        {
            Int16 status = HIDClass.ReadSingleRegister((byte)Convert.ToInt32(0), 1, (byte)2);
            byte PROX_BSCAT = (byte)(GlobalVariables.WriteRegs[2] & (byte)31);
            _txtproBSCATRead.Text = "0X"+PROX_BSCAT.ToString("X2");
        }

        /// <summary>
        /// Register 2 PROX BSCAT Write
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void _btnPROXConfig1Write_Click(object sender, EventArgs e)
        {
            try
            {
                int value = Convert.ToInt32(_txtPROX_BSCATWrite.Text, 16);
                if (value >= 0 && value <= 255)
                {
                    Int16 status = HIDClass.ReadSingleRegister((byte)Convert.ToInt32(0), 1, (byte)2);
                    if (status == 8)
                    {

                        byte copy = GlobalVariables.WriteRegs[2];
                        byte AfterAND = (byte)(copy & (byte)224);
                        byte AfterOR = (byte)(AfterAND | (byte)Convert.ToInt32(_txtPROX_BSCATWrite.Text, 16));
                        Int16 status1 = HIDClass.WriteSingleRegister(AfterOR, 1, (byte)2);

                    }
                }
            }
            catch (Exception ex)
            {
                System.Windows.MessageBox.Show("Enterd value not in correct format.");
            }
            finally
            { 
            
            }
        }
        

        /// <summary>
        /// REGISTER 3: READ AND WRITE REGISTER START
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
       private void _btnPROX_PERST_Click(object sender, EventArgs e)
        {
            //Register 3 PROX PERST Read
            Int16 status = HIDClass.ReadSingleRegister((byte)0, 1, (byte)3);
            if (status == 8)
            {
                byte ProxPerst = (byte)((byte)(GlobalVariables.WriteRegs[3] & (byte)Convert.ToInt32(48)) >> 4);
                int ProxPerstVal = Convert.ToInt32(ProxPerst);
                foreach (KeyValuePair<string, int> words in CBproxPers)
                {
                    if (ProxPerstVal == words.Value)
                    {
                        _txtPROX_PERST.Text = words.Key;
                    }
                }
            }
        }
        /// <summary>
        /// Register 3 PROX PERST Write
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void _cbPROX_PERST_SelectedIndexChanged(object sender, EventArgs e)
        {

            Int16 status = HIDClass.ReadSingleRegister((byte)Convert.ToInt32(0), 1, (byte)3);
            if (status == 8)
            {
                byte copy = GlobalVariables.WriteRegs[3];
                byte AfterAND = (byte)(copy & (byte)207);
                ComboboxItem selectedData = (ComboboxItem)_cbPROX_PERST.SelectedItem;
                byte AfterSHIFT = (byte)((byte)Convert.ToInt32(selectedData.Value) << 4);
                byte AfterOR = (byte)(AfterSHIFT | AfterAND);
                Int16 statusWrite = HIDClass.WriteSingleRegister(AfterOR, 1, (byte)3);

            }
        }
        /// <summary>
        /// Register 3 IRDR Trim Read
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void _btnIRDRTrimRead_Click(object sender, EventArgs e)
        {
            Int16 status = HIDClass.ReadSingleRegister((byte)0, 1, (byte)3);
            byte IRDRTRIM = (byte)((GlobalVariables.WriteRegs[3] & (byte)Convert.ToInt32(64)) >> 6);
            if (IRDRTRIM == (byte)0)
            {
                _chkIRDRTRIM.Checked = false;
            }
            if (IRDRTRIM == (byte)1)
            {
                _chkIRDRTRIM.Checked = true;
            }
        }
        /// <summary>
        /// Register 3 IRDR Trim Write
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void _chkIRDRTRIM_CheckedChanged(object sender, EventArgs e)
        {
            if (_chkIRDRTRIM.Checked == true)
            {

                Int16 status = HIDClass.ReadSingleRegister((byte)Convert.ToInt32(0), 1, (byte)3);
                if (status == 8)
                {
                    byte copy = GlobalVariables.WriteRegs[3];
                    byte AfterAND = (byte)(copy & (byte)191);
                    byte AfterSHIFT = (byte)((byte)Convert.ToInt32(1) << 6);
                    byte AfterOR = (byte)(AfterSHIFT | AfterAND);
                    Int16 status1 = HIDClass.WriteSingleRegister(AfterOR, 1, (byte)3);
                }
            }
            else
            {
                Int16 status = HIDClass.ReadSingleRegister((byte)Convert.ToInt32(0), 1, (byte)2);
                if (status == 8)
                {
                    byte copy = GlobalVariables.WriteRegs[3];
                    byte AfterAND = (byte)(copy & (byte)191);
                    byte AfterSHIFT = (byte)((byte)Convert.ToInt32(0) << 6);
                    byte AfterOR = (byte)(AfterSHIFT | AfterAND);
                    Int16 status1 = HIDClass.WriteSingleRegister(AfterOR, 1, (byte)3);
                }
            }
        }
        /// <summary>
        /// Register 3 PROX FLAG Read
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void _btnPROXFLAGRead_Click(object sender, EventArgs e)
        {
            Int16 status = HIDClass.ReadSingleRegister((byte)0, 1, (byte)3);
            byte PROXFLAG = (byte)((GlobalVariables.WriteRegs[3] & (byte)Convert.ToInt32(8)) >> 3);
            if (PROXFLAG == (byte)0)
            {
                _chkPROXFLAG.Checked = false;
            }
            if (PROXFLAG == (byte)1)
            {
                _chkPROXFLAG.Checked = true;
            }
        }
        /// <summary>
        /// Register 3 PROX FLAG Write
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void _chkPROXFLAG_CheckedChanged(object sender, EventArgs e)
        {
            if (_chkPROXFLAG.Checked == true)
            {

                Int16 status = HIDClass.ReadSingleRegister((byte)Convert.ToInt32(0), 1, (byte)3);
                if (status == 8)
                {
                    byte copy = GlobalVariables.WriteRegs[3];
                    byte AfterAND = (byte)(copy & (byte)247);
                    byte AfterSHIFT = (byte)((byte)Convert.ToInt32(1) << 3);
                    byte AfterOR = (byte)(AfterSHIFT | AfterAND);
                    Int16 status1 = HIDClass.WriteSingleRegister(AfterOR, 1, (byte)3);
                }
            }
            else
            {
                Int16 status = HIDClass.ReadSingleRegister((byte)Convert.ToInt32(0), 1, (byte)3);
                if (status == 8)
                {
                    byte copy = GlobalVariables.WriteRegs[3];
                    byte AfterAND = (byte)(copy & (byte)247);
                    byte AfterSHIFT = (byte)((byte)Convert.ToInt32(0) << 3);
                    byte AfterOR = (byte)(AfterSHIFT | AfterAND);
                    Int16 status1 = HIDClass.WriteSingleRegister(AfterOR, 1, (byte)3);

                }
            }
        }

        /// <summary>
        /// Register 3 PROX DONE Read
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void _btnPROXDONE_Click(object sender, EventArgs e)
        {
            Int16 status = HIDClass.ReadSingleRegister((byte)0, 1, (byte)3);
            byte PROXDONE = (byte)((GlobalVariables.WriteRegs[3] & (byte)Convert.ToInt32(4)) >> 2);
            if (PROXDONE == (byte)0)
            {
                _chlPROXDONE.Checked = false;
            }
            if (PROXDONE == (byte)1)
            {
                _chlPROXDONE.Checked = true;
            }
        }
        /// <summary>
        /// Register 3 PROX Done Write
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void _chlPROXDONE_CheckedChanged(object sender, EventArgs e)
        {
            if (_chlPROXDONE.Checked == true)
            {

                Int16 status = HIDClass.ReadSingleRegister((byte)Convert.ToInt32(0), 1, (byte)3);
                if (status == 8)
                {
                    byte copy = GlobalVariables.WriteRegs[3];
                    byte AfterAND = (byte)(copy & (byte)251);
                    byte AfterSHIFT = (byte)((byte)Convert.ToInt32(1) << 2);
                    byte AfterOR = (byte)(AfterSHIFT | AfterAND);
                    Int16 status1 = HIDClass.WriteSingleRegister(AfterOR, 1, (byte)3);
                }
            }
            else
            {
                Int16 status = HIDClass.ReadSingleRegister((byte)Convert.ToInt32(0), 1, (byte)3);
                if (status == 8)
                {
                    byte copy = GlobalVariables.WriteRegs[3];
                    byte AfterAND = (byte)(copy & (byte)251);
                    byte AfterSHIFT = (byte)((byte)Convert.ToInt32(0) << 2);
                    byte AfterOR = (byte)(AfterSHIFT | AfterAND);
                    Int16 status1 = HIDClass.WriteSingleRegister(AfterOR, 1, (byte)3);
                }
            }
        }
        /// <summary>
        /// Register 3 IRDR SHRT read
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void _btnIRDR_SHRTRead_Click(object sender, EventArgs e)
        {
            Int16 status = HIDClass.ReadSingleRegister((byte)0, 1, (byte)3);
            byte IRDR_SHRT = (byte)((GlobalVariables.WriteRegs[3] & (byte)Convert.ToInt32(2)) >> 1);
            if (IRDR_SHRT == (byte)0)
            {
                _chkIRDR_SHRT.Checked = false;
            }
            if (IRDR_SHRT == (byte)1)
            {
                _chkIRDR_SHRT.Checked = true;
            }
        }
        /// <summary>
        /// Register 3 IRDR SHRT Write
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void _chkIRDR_SHRT_CheckedChanged(object sender, EventArgs e)
        {
            if (_chkIRDR_SHRT.Checked == true)
            {

                Int16 status = HIDClass.ReadSingleRegister((byte)Convert.ToInt32(0), 1, (byte)3);
                if (status == 8)
                {
                    byte copy = GlobalVariables.WriteRegs[3];
                    byte AfterAND = (byte)(copy & (byte)253);
                    byte AfterSHIFT = (byte)((byte)Convert.ToInt32(1) << 1);
                    byte AfterOR = (byte)(AfterSHIFT | AfterAND);
                    Int16 status1 = HIDClass.WriteSingleRegister(AfterOR, 1, (byte)3);
                }
            }
            else
            {
                Int16 status = HIDClass.ReadSingleRegister((byte)Convert.ToInt32(0), 1, (byte)3);
                if (status == 8)
                {
                    byte copy = GlobalVariables.WriteRegs[3];
                    byte AfterAND = (byte)(copy & (byte)253);
                    byte AfterSHIFT = (byte)((byte)Convert.ToInt32(0) << 1);
                    byte AfterOR = (byte)(AfterSHIFT | AfterAND);
                    Int16 status1 = HIDClass.WriteSingleRegister(AfterOR, 1, (byte)3);
                }
            }
        }
        /// <summary>
        /// Register 3 INT WSH Read
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void _btnINT_WSHRead_Click(object sender, EventArgs e)
        {
            Int16 status = HIDClass.ReadSingleRegister((byte)0, 1, (byte)3);
            byte INT_WSH = (byte)(GlobalVariables.WriteRegs[3] & (byte)Convert.ToInt32(1));
            if (INT_WSH == (byte)0)
            {
                _chkINT_WSH_EN.Checked = false;
            }
            if (INT_WSH == (byte)1)
            {
                _chkINT_WSH_EN.Checked = true;
            }
        }
        /// <summary>
        /// Register 3 INT WSH Write
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void _chkINT_WSH_EN_CheckedChanged(object sender, EventArgs e)
        {
            if (_chkINT_WSH_EN.Checked == true)
            {

                Int16 status = HIDClass.ReadSingleRegister((byte)Convert.ToInt32(0), 1, (byte)3);
                if (status == 8)
                {
                    byte copy = GlobalVariables.WriteRegs[3];
                    byte AfterAND = (byte)(copy & (byte)254);
                    byte AfterSHIFT = (byte)((byte)Convert.ToInt32(1));
                    byte AfterOR = (byte)(AfterSHIFT | AfterAND);
                    Int16 status1 = HIDClass.WriteSingleRegister(AfterOR, 1, (byte)3);
                }
            }
            else
            {
                Int16 status = HIDClass.ReadSingleRegister((byte)Convert.ToInt32(0), 1, (byte)3);
                if (status == 8)
                {
                    byte copy = GlobalVariables.WriteRegs[3];
                    byte AfterAND = (byte)(copy & (byte)254);
                    byte AfterSHIFT = (byte)((byte)Convert.ToInt32(0));
                    byte AfterOR = (byte)(AfterSHIFT | AfterAND);
                    Int16 Writestatus = HIDClass.WriteSingleRegister(AfterOR, 1, (byte)3);

                }
            }
        }
        
        /// <summary>
        /// REGISTER 4: READ AND WRITE REGISTER START
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void _btnLowTHRead_Click(object sender, EventArgs e)
        {
            //Register 4 Low TH Read
            Int16 status = HIDClass.ReadSingleRegister((byte)0, 1, (byte)4);
            if (status == 8)
            {
                _txtLowTHRead.Text = GlobalVariables.WriteRegs[4].ToString("X2");
            }
        }
        //Register 4 Low TH Write
        private void _btnLowTHWrite_Click(object sender, EventArgs e)
        {
            try
            {
                Int16 status = HIDClass.WriteSingleRegister((byte)Convert.ToInt32(_txtLowTHWrite.Text, 16), 1, (byte)4);
                if (status == 8)
                {
                    _txtLowTHRead.Text = GlobalVariables.WriteRegs[4].ToString("X2");
                }
            }
            catch (Exception ex)
            {
                System.Windows.MessageBox.Show("Enterd value not in correct format.");
            }
            finally
            { 
            
            }

        }
        
        /// <summary>
        /// REGISTER 5: READ AND WRITE REGISTER START
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void _btnHighTHRead_Click(object sender, EventArgs e)
        {
            //Register 5 High TH Read
            Int16 status = HIDClass.ReadSingleRegister((byte)0, 1, (byte)5);
            if (status == 8)
            {
                _txtHighTHRead.Text = GlobalVariables.WriteRegs[5].ToString("X2");
            }
        }
        /// <summary>
        /// Register 5 High TH Write
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void _btnHighTHWrite_Click(object sender, EventArgs e)
        {
            int value = Convert.ToInt32(_txtHighTHWrite.Text, 16);
            if (value >= 0 && value <= 255)
            {
                Int16 status = HIDClass.WriteSingleRegister((byte)Convert.ToInt32(_txtHighTHWrite.Text, 16), 1, (byte)5);
            }
        }

        /// <summary>
        /// REGISTER 6: READ AND WRITE REGISTER START
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void _btnRefreshRegister6_Click(object sender, EventArgs e)
        {
            //Register 6 Read
            GetRegister6();
        }
        
        /// <summary>
        /// REGISTER 7: READ AND WRITE REGISTER START
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void _btnPROXDATA_Click(object sender, EventArgs e)
        {
            //Register 7 PROX SENS DATA Read
            Int16 status = HIDClass.ReadSingleRegister((byte)0, 1, (byte)7);
            if (status == 8)
            {
                _txtPROXCount.Text = GlobalVariables.WriteRegs[7].ToString("X2");

            }
        }
       
        /// <summary>
        /// REGISTER 8: READ AND WRITE REGISTER START
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void _btnPROXA_Click(object sender, EventArgs e)
        {
            //Register 8 PROX DAC DATA Read
            Int16 status = HIDClass.ReadSingleRegister((byte)0, 1, (byte)8);
            if (status == 8)
            {
                _txtPROX_DACDATA.Text = GlobalVariables.WriteRegs[8].ToString("X2");

            }
        }

        /// <summary>
        /// REGISTER 10: READ AND WRITE REGISTER START
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void _btnProxCountRead_Click(object sender, EventArgs e)
        {
            //Register 10 PROX Count Read
            Int16 status = HIDClass.ReadSingleRegister((byte)0, 1, (byte)10);
            if (status == 8)
            {
                byte ProxCountMODE2 = (byte)(GlobalVariables.WriteRegs[10] & (byte)15);
                _txtProxCountMODE2.Text = ProxCountMODE2.ToString("X2");
            }
        }
       
        /// <summary>
        /// REGISTER 11: READ AND WRITE REGISTER START
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void _btnproSleepCtrlRead_Click(object sender, EventArgs e)
        {
            //Register 11 PROX Slp CTRL Read
            Int16 status = HIDClass.ReadSingleRegister((byte)0, 1, (byte)11);
            if (status == 8)
            {
                byte ProxSLPCtrl = (byte)((GlobalVariables.WriteRegs[11] & (byte)Convert.ToInt32(32)) >> 5);
                int PProxSLPCtrlVal = Convert.ToInt32(ProxSLPCtrl);
                foreach (ComboboxItem selectedData in _cbproSleepCtrlWrite.Items)
                {
                    if (Convert.ToInt32(selectedData.Value) == PProxSLPCtrlVal)
                    {
                        _txtproSleepCtrlRead.Text = selectedData.Text;
                    }
                }
               
            }
        }

        /// <summary>
        /// Register 11 PROX Slp CTRL Write
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void _cbproSleepCtrlWrite_SelectedIndexChanged(object sender, EventArgs e)
        {
            Int16 status = HIDClass.ReadSingleRegister((byte)Convert.ToInt32(0), 1, (byte)11);
            if (status == 8)
            {
                byte copy = GlobalVariables.WriteRegs[11];
                byte AfterAND = (byte)(copy & (byte)223);
                ComboboxItem selectedData = (ComboboxItem)_cbproSleepCtrlWrite.SelectedItem;
                byte AfterSHIFT = (byte)((byte)Convert.ToInt32(selectedData.Value) << 5);
                byte AfterOR = (byte)(AfterSHIFT | AfterAND);
                Int16 status1 = HIDClass.WriteSingleRegister(AfterOR, 1, (byte)11);
            }
        }
        /// <summary>
        /// Register 11 Measure REXT Read
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void _btnMeasRextRead_Click(object sender, EventArgs e)
        {

            Int16 status = HIDClass.ReadSingleRegister((byte)0, 1, (byte)11);
            if (status == 8)
            {
                byte MeasRext = (byte)((GlobalVariables.WriteRegs[11] & (byte)Convert.ToInt32(16)) >> 4);
                _txtMeasRextRead.Text = MeasRext.ToString("X2");
               
            }
        }
        /// <summary>
        /// Register 11 Measure REXT Write
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void _cbMeasRextWrite_SelectedIndexChanged(object sender, EventArgs e)
        {
            Int16 status = HIDClass.ReadSingleRegister((byte)Convert.ToInt32(0), 1, (byte)11);
            if (status == 8)
            {
                byte copy = GlobalVariables.WriteRegs[11];
                byte AfterAND = (byte)(copy & (byte)239);
                byte AfterSHIFT = (byte)((byte)Convert.ToInt32(_cbMeasRextWrite.Text) << 4);
                byte AfterOR = (byte)(AfterSHIFT | AfterAND);
                Int16 status1 = HIDClass.WriteSingleRegister(AfterOR, 1, (byte)11);

            }
        }
        /// <summary>
        /// Register 11 REXT Selected Read
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void _btnRextSelectRead_Click(object sender, EventArgs e)
        {
            Int16 status = HIDClass.ReadSingleRegister((byte)0, 1, (byte)11);
            if (status == 8)
            {
                byte RextSelect = (byte)((GlobalVariables.WriteRegs[11] & (byte)Convert.ToInt32(12)) >> 2);
                int RextSelectVal = Convert.ToInt32(RextSelect);
                foreach (ComboboxItem selectedData in _cbRextSelectWrite.Items)
                {
                    if (Convert.ToInt32(selectedData.Value) == RextSelectVal)
                    {
                        _txtRextSelectRead.Text = selectedData.Text;
                    }
                }
            }
        }
        /// <summary>
        /// Register 11 REXT Selected Write
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void _cbRextSelectWrite_SelectedIndexChanged(object sender, EventArgs e)
        {
            Int16 status = HIDClass.ReadSingleRegister((byte)Convert.ToInt32(0), 1, (byte)11);
            if (status == 8)
            {
                byte copy = GlobalVariables.WriteRegs[11];
                byte AfterAND = (byte)(copy & (byte)243);
                ComboboxItem selectedData = (ComboboxItem)_cbRextSelectWrite.SelectedItem;
                byte AfterSHIFT = (byte)((byte)Convert.ToInt32(selectedData.Value) << 2);
                byte AfterOR = (byte)(AfterSHIFT | AfterAND);
                Int16 status1 = HIDClass.WriteSingleRegister(AfterOR, 1, (byte)11);

            }
        }
        /// <summary>
        /// Register 11 IBIAS Cntrl  Read
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void _btnIBIAScntrlRead_Click(object sender, EventArgs e)
        {
            Int16 status = HIDClass.ReadSingleRegister((byte)0, 1, (byte)11);
            if (status == 8)
            {
                byte IBIAScntrl = (byte)(GlobalVariables.WriteRegs[11] & (byte)Convert.ToInt32(3));
                int IBIAScntrlVal = Convert.ToInt32(IBIAScntrl);
                foreach (ComboboxItem selectedData in _cbIBIAScntrlWrite.Items)
                {
                    if (Convert.ToInt32(selectedData.Value) == IBIAScntrlVal)
                    {
                        _txtIBIAScntrlRead.Text = selectedData.Text;
                    }
                }
            }
        }
        /// <summary>
        /// Register 11 IBIAS Cntrl Write
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void _cbIBIAScntrlWrite_SelectedIndexChanged(object sender, EventArgs e)
        {
            Int16 status = HIDClass.ReadSingleRegister((byte)Convert.ToInt32(0), 1, (byte)11);
            if (status == 8)
            {
                byte copy = GlobalVariables.WriteRegs[11];
                byte AfterAND = (byte)(copy & (byte)252);
                ComboboxItem selectedData = (ComboboxItem)_cbIBIAScntrlWrite.SelectedItem;
                byte AfterSHIFT = (byte)Convert.ToInt32(selectedData.Value);
                byte AfterOR = (byte)(AfterSHIFT | AfterAND);
                Int16 statusWrite = HIDClass.WriteSingleRegister(AfterOR, 1, (byte)11);
            }
        }
        
        /// <summary>
        /// REGISTER 12: READ AND WRITE REGISTER START
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void _btnResidueCtrlRead_Click(object sender, EventArgs e)
        {
            //Register 12 Residue Cntrl Read
            Int16 status = HIDClass.ReadSingleRegister((byte)0, 1, (byte)12);
            if (status == 8)
            {
                byte ResidueCtrl = (byte)((GlobalVariables.WriteRegs[12] & (byte)Convert.ToInt32(8))>>3);
                _txtResidueCtrlRead.Text = ResidueCtrl.ToString("X2");
            }
        }
        /// <summary>
        /// Register 12 Residue Cntrl Write
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void _cbResidueCtrlWrite_SelectedIndexChanged(object sender, EventArgs e)
        {
            Int16 status = HIDClass.ReadSingleRegister((byte)Convert.ToInt32(0), 1, (byte)12);
            if (status == 8)
            {
                byte copy = GlobalVariables.WriteRegs[12];
                byte AfterAND = (byte)(copy & (byte)247);
                byte AfterSHIFT = (byte)(Convert.ToInt32(_cbResidueCtrlWrite.Text)<<3);
                byte AfterOR = (byte)(AfterSHIFT | AfterAND);
                Int16 status1 = HIDClass.WriteSingleRegister(AfterOR, 1, (byte)12);
            }
        }
        /// <summary>
        /// Register 12 PROX TEST Read
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void _btnproTestRead_Click(object sender, EventArgs e)
        {
            Int16 status = HIDClass.ReadSingleRegister((byte)0, 1, (byte)12);
            if (status == 8)
            {
                byte PROTEST = (byte)(GlobalVariables.WriteRegs[12] & (byte)Convert.ToInt32(7));
                int PROXTESTVal = Convert.ToInt32(PROTEST);
                foreach (ComboboxItem selectedData in _cbPROXTestWrite.Items)
                {
                    if (Convert.ToInt32(selectedData.Value) == PROXTESTVal)
                    {
                        _txtproTestRead.Text = selectedData.Text;
                    }
                }
             }
        }
        /// <summary>
        /// Register 12 PROX TEST Write
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void _cbPROXTestWrite_SelectedIndexChanged(object sender, EventArgs e)
        {
            Int16 status = HIDClass.ReadSingleRegister((byte)Convert.ToInt32(0), 1, (byte)12);
            if (status == 8)
            {
                byte copy = GlobalVariables.WriteRegs[12];
                byte AfterAND = (byte)(copy & (byte)248);
                ComboboxItem selectedData = (ComboboxItem)_cbPROXTestWrite.SelectedItem;
                byte AfterSHIFT = (byte)(Convert.ToInt32(selectedData.Value));
                byte AfterOR = (byte)(AfterSHIFT | AfterAND);
                Int16 status1 = HIDClass.WriteSingleRegister(AfterOR, 1, (byte)12);

            }
        }

        /// <summary>
        /// REGISTER 13: READ AND WRITE REGISTER START
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void _btnotpDoneRead_Click(object sender, EventArgs e)
        {
            //Register 13 OT DONE Read
            Int16 status = HIDClass.ReadSingleRegister((byte)0, 1, (byte)13);
            if (status == 8)
            {
                byte OTPDONE = (byte)((GlobalVariables.WriteRegs[13] & (byte)Convert.ToInt32(128)) >> 7);
                if (OTPDONE == (byte)0)
                {
                    _ovalotpDone.BackColor = Color.White;
                }
                if (OTPDONE == (byte)1)
                {
                    _ovalotpDone.BackColor = Color.Green;
                }
            }
        }
        /// <summary>
        /// Register 13 GOLDEN Read
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void _btnGoldenRead_Click(object sender, EventArgs e)
        {
            Int16 status = HIDClass.ReadSingleRegister((byte)0, 1, (byte)13);
            if (status == 8)
            {
                byte Golden = (byte)((GlobalVariables.WriteRegs[13] & (byte)Convert.ToInt32(64)) >> 6);
                if (Golden == (byte)0)
                {
                    _ovalGoldenStatus.BackColor = Color.White;
                }
                if (Golden == (byte)1)
                {
                    _ovalGoldenStatus.BackColor = Color.Green;
                }
            }
        }
        /// <summary>
        /// Register 13 I2C ADDR Read
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void _btnI2CaddrRead_Click(object sender, EventArgs e)
        {

            Int16 status = HIDClass.ReadSingleRegister((byte)0, 1, (byte)13);
            if (status == 8)
            {
                byte I2Caddr = (byte)((GlobalVariables.WriteRegs[13] & (byte)Convert.ToInt32(48)) >> 4);
                if (I2Caddr == (byte)0)
                {
                    _txtI2CaddrRead.Text = "44h";
                }
                else if (I2Caddr == (byte)1)
                {
                    _txtI2CaddrRead.Text = "45h";
                }
                else if (I2Caddr == (byte)2)
                {
                    _txtI2CaddrRead.Text = "46h";
                }
                else if (I2Caddr == (byte)3)
                {
                    _txtI2CaddrRead.Text = "47h";
                }
            }
        }
        /// <summary>
        /// Register 13 IRDR CURR Read
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void _btnIRDRcurrentRead_Click(object sender, EventArgs e)
        {
            Int16 status = HIDClass.ReadSingleRegister((byte)0, 1, (byte)13);
            if (status == 8)
            {
                byte IRDRCurrent = (byte)((GlobalVariables.WriteRegs[13] & (byte)Convert.ToInt32(8))>>3);
                int IRDRCurrentVal = Convert.ToInt32(IRDRCurrent);
                foreach (ComboboxItem selectedData in _cbIRDRcurrentWrite.Items)
                {
                    if (Convert.ToInt32(selectedData.Value) == IRDRCurrentVal)
                    {
                        _txtIRDRcurrentRead.Text = selectedData.Text;
                    }
                }
            }
        }
        /// <summary>
        /// Register 13 IRDR CURR Write
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void _cbIRDRcurrentWrite_SelectedIndexChanged(object sender, EventArgs e)
        {
            Int16 status = HIDClass.ReadSingleRegister((byte)Convert.ToInt32(0), 1, (byte)13);
            if (status == 8)
            {
                byte copy = GlobalVariables.WriteRegs[13];
                byte AfterAND = (byte)(copy & (byte)247);
                ComboboxItem selectedData = (ComboboxItem)_cbIRDRcurrentWrite.SelectedItem;
                byte AfterSHIFT = (byte)((byte)(Convert.ToInt32(selectedData.Value)) << 3);
                byte AfterOR = (byte)(AfterSHIFT | AfterAND);
                Int16 status1 = HIDClass.WriteSingleRegister(AfterOR, 1, (byte)13);

            }
        }
        /// <summary>
        /// Register 13 REG CTRL Read
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void _btnRegCtrlRead_Click(object sender, EventArgs e)
        {
            Int16 status = HIDClass.ReadSingleRegister((byte)0, 1, (byte)13);
            if (status == 8)
            {
                byte RegiCtrl = (byte)((GlobalVariables.WriteRegs[13] & (byte)Convert.ToInt32(4)) >> 2);
                int RegiCtrlVal = Convert.ToInt32(RegiCtrl);
                foreach (ComboboxItem selectedData in _cbRegCtrlWrite.Items)
                {
                    if (Convert.ToInt32(selectedData.Value) == RegiCtrlVal)
                    {
                        _txtRegCtrlRead.Text = selectedData.Text;
                    }
                }

            }
        }
        /// <summary>
        /// Register 13 REG CTRL Write
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void _cbRegCtrlWrite_SelectedIndexChanged(object sender, EventArgs e)
        {
            Int16 status = HIDClass.ReadSingleRegister((byte)Convert.ToInt32(0), 1, (byte)13);
            if (status == 8)
            {
                byte copy = GlobalVariables.WriteRegs[13];
                byte AfterAND = (byte)(copy & (byte)251);
                ComboboxItem selectedData = (ComboboxItem)_cbRegCtrlWrite.SelectedItem;
                byte AfterSHIFT = (byte)((byte)(Convert.ToInt32(selectedData.Value)) << 2);
                byte AfterOR = (byte)(AfterSHIFT | AfterAND);
                Int16 status1 = HIDClass.WriteSingleRegister(AfterOR, 1, (byte)13);
            }
        }
        //Register 13 ANAREST EN Read
        private void _btnAnatestENRead_Click(object sender, EventArgs e)
        {
            Int16 status = HIDClass.ReadSingleRegister((byte)0, 1, (byte)13);
            if (status == 8)
            {
                byte AnatestEN = (byte)((GlobalVariables.WriteRegs[13] & (byte)Convert.ToInt32(2)) >> 1);
                int AnatestENVal = Convert.ToInt32(AnatestEN);
                foreach (ComboboxItem selectedData in _cbAnatestENWrite.Items)
                {
                    if (Convert.ToInt32(selectedData.Value) == AnatestENVal)
                    {
                        _txtAnatestENRead.Text = selectedData.Text;
                    }
                }
             }
        }
        /// <summary>
        /// Register 13 ANAREST EN Write
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void _cbAnatestENWrite_SelectedIndexChanged(object sender, EventArgs e)
        {
            Int16 status = HIDClass.ReadSingleRegister((byte)Convert.ToInt32(0), 1, (byte)13);
            if (status == 8)
            {
                byte copy = GlobalVariables.WriteRegs[13];
                byte AfterAND = (byte)(copy & (byte)253);
                ComboboxItem selectedData = (ComboboxItem)_cbAnatestENWrite.SelectedItem;
                byte AfterSHIFT = (byte)((byte)(Convert.ToInt32(selectedData.Value)) << 1);
                byte AfterOR = (byte)(AfterSHIFT | AfterAND);
                Int16 status1 = HIDClass.WriteSingleRegister(AfterOR, 1, (byte)13);
            }
        }
        /// <summary>
        /// Register 13 INF FUNCT Read
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void _btnINTfuncRead_Click(object sender, EventArgs e)
        {
            Int16 status = HIDClass.ReadSingleRegister((byte)0, 1, (byte)13);
            if (status == 8)
            {
                byte INTfunc = (byte)(GlobalVariables.WriteRegs[13] & (byte)Convert.ToInt32(1));
                int INTfuncVal = Convert.ToInt32(INTfunc);
                foreach (ComboboxItem selectedData in _cbINTfuncWrite.Items)
                {
                    if (Convert.ToInt32(selectedData.Value) == INTfuncVal)
                    {
                        _txtINTfuncRead.Text = selectedData.Text;
                    }
                }
            }
        }
        /// <summary>
        /// Register 13 INF FUNCT Write
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void _cbINTfuncWrite_SelectedIndexChanged(object sender, EventArgs e)
        {
            Int16 status = HIDClass.ReadSingleRegister((byte)Convert.ToInt32(0), 1, (byte)13);
            if (status == 8)
            {
                byte copy = GlobalVariables.WriteRegs[13];
                byte AfterAND = (byte)(copy & (byte)254);
                ComboboxItem selectedData = (ComboboxItem)_cbINTfuncWrite.SelectedItem;
                byte AfterSHIFT = (byte)(Convert.ToInt32(selectedData.Value));
                byte AfterOR = (byte)(AfterSHIFT | AfterAND);
                Int16 status1 = HIDClass.WriteSingleRegister(AfterOR, 1, (byte)13);

            }
        }

        /// <summary>
        /// REGISTER 14: READ AND WRITE REGISTER START
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void _btnIRDR_TRIMRead_Click(object sender, EventArgs e)
        {
            //:=Register 14 has few diffrent process which we have to follow before to and write from sensor.
            //1.Write register 9 with value 0x89 and then read it.
            //2.Write Register 15 with values 0x40 and then read it.
            //3.Now we can read or write in register 14.
            Int16 status1 = HIDClass.WriteSingleRegister((byte)137, 1, (byte)9);
            status1 = HIDClass.ReadSingleRegister((byte)0, 1, (byte)9);
            Int16 status2 = HIDClass.WriteSingleRegister((byte)64, 1, (byte)15);
            status2 = HIDClass.ReadSingleRegister((byte)0, 1, (byte)15);
            int status = HIDClass.ReadSingleRegister(32, 1, (byte)14);
            if (status == 8)
            {

                byte IRDR_TRIM = (byte)((GlobalVariables.WriteRegs[14] & (byte)Convert.ToInt32(56)) >> 3);
                int IRDR_TRIMVal = Convert.ToInt32(IRDR_TRIM);
                foreach (ComboboxItem selectedData in _cbIRDRTRIMWrite.Items)
                {
                    if (Convert.ToInt32(selectedData.Value) == IRDR_TRIMVal)
                    {
                        _txtIRDR_TRIM.Text = selectedData.Text;
                    }
                }

            }
        }

        /// <summary>
        /// Register 14 IRDR TRIM Write
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void _cbIRDRTRIMWrite_SelectedIndexChanged(object sender, EventArgs e)
        {
            Int16 status = HIDClass.ReadSingleRegister((byte)Convert.ToInt32(0), 1, (byte)14);
            if (status == 8)
            {
                Int16 status1 = HIDClass.WriteSingleRegister((byte)137, 1, (byte)9);
                status1 = HIDClass.ReadSingleRegister((byte)0, 1, (byte)9);
                Int16 status2 = HIDClass.WriteSingleRegister((byte)64, 1, (byte)15);
                status2 = HIDClass.ReadSingleRegister((byte)0, 1, (byte)15);
                byte copy = GlobalVariables.WriteRegs[14];
                byte AfterAND = (byte)(copy & (byte)7);
                ComboboxItem selectedData = (ComboboxItem)_cbIRDRTRIMWrite.SelectedItem;
                byte AfterSHIFT = (byte)((byte)(Convert.ToInt32(selectedData.Value))<<3);
                byte AfterOR = (byte)(AfterSHIFT | AfterAND);
                status = HIDClass.WriteSingleRegister(AfterOR, 1, (byte)14);
                GetRegister14();
            }
        }
        /// <summary>
        /// Register 14 PROX OSADJ READ
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void _btnPROX_OSADJRead_Click(object sender, EventArgs e)
        {
            Int16 status1 = HIDClass.WriteSingleRegister((byte)137, 1, (byte)9);
            status1 = HIDClass.ReadSingleRegister((byte)0, 1, (byte)9);
            Int16 status2 = HIDClass.WriteSingleRegister((byte)64, 1, (byte)15);
            status2 = HIDClass.ReadSingleRegister((byte)0, 1, (byte)15);
            Int16 status = HIDClass.ReadSingleRegister((byte)0, 1, (byte)14);
            if (status == 8)
            {
                byte PROX_OSADJ = (byte)((GlobalVariables.WriteRegs[14] & (byte)Convert.ToInt32(4)) >> 2);
                int PROX_OSADJVal = Convert.ToInt32(PROX_OSADJ);
                foreach (ComboboxItem selectedData in _cbPROX_OSADJwrite.Items)
                {
                    if (Convert.ToInt32(selectedData.Value) == PROX_OSADJVal)
                    {
                        _txtPROX_OSADJRead.Text = selectedData.Text;
                    }
                }

            }
        }

        /// <summary>
        /// Register 14 PROX OSADJ Write
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void _cbPROX_OSADJwrite_SelectedIndexChanged(object sender, EventArgs e)
        {
            Int16 status = HIDClass.ReadSingleRegister((byte)Convert.ToInt32(0), 1, (byte)14);
            if (status == 8)
            {
                Int16 status1 = HIDClass.WriteSingleRegister((byte)137, 1, (byte)9);
                status1 = HIDClass.ReadSingleRegister((byte)0, 1, (byte)9);
                Int16 status2 = HIDClass.WriteSingleRegister((byte)64, 1, (byte)15);
                status2 = HIDClass.ReadSingleRegister((byte)0, 1, (byte)15);
                byte copy = GlobalVariables.WriteRegs[14];
                byte AfterAND = (byte)(copy & (byte)251);
                ComboboxItem selectedData = (ComboboxItem)_cbPROX_OSADJwrite.SelectedItem;
                byte AfterSHIFT = (byte)((byte)(Convert.ToInt32(selectedData.Value))<<2);
                byte AfterOR = (byte)(AfterSHIFT | AfterAND);
                status = HIDClass.WriteSingleRegister(AfterOR, 1, (byte)14);
                GetRegister14();
            }
        }
        /// <summary>
        /// Register 14 PROX GAIN READ
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void _btnPROX_GAINRead_Click(object sender, EventArgs e)
        {
            Int16 status1 = HIDClass.WriteSingleRegister((byte)137, 1, (byte)9);
            status1 = HIDClass.ReadSingleRegister((byte)0, 1, (byte)9);
            Int16 status2 = HIDClass.WriteSingleRegister((byte)64, 1, (byte)15);
            status2 = HIDClass.ReadSingleRegister((byte)0, 1, (byte)15);
            Int16 status = HIDClass.ReadSingleRegister((byte)0, 1, (byte)14);
            if (status == 8)
            {
                byte PROX_GAIN = (byte)((GlobalVariables.WriteRegs[14] & (byte)Convert.ToInt32(2)) >> 1);
                int PROX_GAINVal = Convert.ToInt32(PROX_GAIN);
                foreach (ComboboxItem selectedData in _cbPROX_GAINWrite.Items)
                {
                    if (Convert.ToInt32(selectedData.Value) == PROX_GAINVal)
                    {
                        _txtPROX_GAINRead.Text = selectedData.Text;
                    }
                }

            }
        }
        /// <summary>
        /// Register 14 PROX GAIN Write
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void _cbPROX_GAINWrite_SelectedIndexChanged(object sender, EventArgs e)
        {
            Int16 status = HIDClass.ReadSingleRegister((byte)Convert.ToInt32(0), 1, (byte)14);
            if (status == 8)
            {
                Int16 status1 = HIDClass.WriteSingleRegister((byte)137, 1, (byte)9);
                status1 = HIDClass.ReadSingleRegister((byte)0, 1, (byte)9);
                Int16 status2 = HIDClass.WriteSingleRegister((byte)64, 1, (byte)15);
                status2 = HIDClass.ReadSingleRegister((byte)0, 1, (byte)15);
                byte copy = GlobalVariables.WriteRegs[14];
                byte AfterAND = (byte)(copy & (byte)253);
                ComboboxItem selectedData = (ComboboxItem)_cbPROX_GAINWrite.SelectedItem;
                byte AfterSHIFT = (byte)((byte)(Convert.ToInt32(selectedData.Value)) << 1);
                byte AfterOR = (byte)(AfterSHIFT | AfterAND);
                int status3 = HIDClass.WriteSingleRegister(AfterOR, 1, (byte)14);
                GetRegister14();
            }
        }
        /// <summary>
        /// Register 14 ID FUSE READ
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void _btnID_FUSE_Click(object sender, EventArgs e)
        {
            Int16 status1 = HIDClass.WriteSingleRegister((byte)137, 1, (byte)9);
            status1 = HIDClass.ReadSingleRegister((byte)0, 1, (byte)9);
            Int16 status2 = HIDClass.WriteSingleRegister((byte)64, 1, (byte)15);
            status2 = HIDClass.ReadSingleRegister((byte)0, 1, (byte)15);
            Int16 status = HIDClass.ReadSingleRegister((byte)0, 1, (byte)14);
            if (status == 8)
            {
                byte ID_FUSE = (byte)(GlobalVariables.WriteRegs[14] & (byte)Convert.ToInt32(1));
                int ID_FUSEVal = Convert.ToInt32(ID_FUSE);
                foreach (ComboboxItem selectedData in _cbID_FUSE.Items)
                {
                    if (Convert.ToInt32(selectedData.Value) == ID_FUSEVal)
                    {
                        _txtID_FUSE.Text = selectedData.Text;
                    }
                }

            }
        }
        /// <summary>
        /// Register 14 ID FUSE WRITE
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void _cbID_FUSE_SelectedIndexChanged(object sender, EventArgs e)
        {
            Int16 status = HIDClass.ReadSingleRegister((byte)Convert.ToInt32(0), 1, (byte)14);
            if (status == 8)
            {
                Int16 status1 = HIDClass.WriteSingleRegister((byte)137, 1, (byte)9);
                status1 = HIDClass.ReadSingleRegister((byte)0, 1, (byte)9);
                Int16 status2 = HIDClass.WriteSingleRegister((byte)64, 1, (byte)15);
                status2 = HIDClass.ReadSingleRegister((byte)0, 1, (byte)15);

                byte copy = GlobalVariables.WriteRegs[14];
                byte AfterAND = (byte)(copy & (byte)254);
                //getting the selected value of combobox
                ComboboxItem selectedData = (ComboboxItem)_cbID_FUSE.SelectedItem;
                byte AfterSHIFT = (byte)(Convert.ToInt32(selectedData.Value));
                byte AfterOR = (byte)(AfterSHIFT | AfterAND);
                Int16 statusWrite = HIDClass.WriteSingleRegister(AfterOR, 1, (byte)14);
               
                GetRegister14();
            }
        }
        /// <summary>
        /// REGISTER 15: READ AND WRITE REGISTER START
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void _btnEMULATIONRead_Click(object sender, EventArgs e)
        {
            //Register 15 EMULATION READ
            Int16 status = HIDClass.ReadSingleRegister((byte)0, 1, (byte)15);
            if (status == 8)
            {
                byte EMULTION = (byte)((GlobalVariables.WriteRegs[15] & (byte)Convert.ToInt32(64))>>6);
                int EMULTIONVal = Convert.ToInt32(EMULTION);
                foreach (ComboboxItem selectedData in _cbEMULATIONWrite.Items)
                {
                    if (Convert.ToInt32(selectedData.Value) == EMULTIONVal)
                    {
                        _txtEMULATIONRead.Text = selectedData.Text;
                    }
                }
            }
        }
        /// <summary>
        /// Register 15 EMULATION Write
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void _cbEMULATIONWrite_SelectedIndexChanged(object sender, EventArgs e)
        {
            Int16 status = HIDClass.ReadSingleRegister((byte)Convert.ToInt32(0), 1, (byte)15);
            if (status == 8)
            {
                byte copy = GlobalVariables.WriteRegs[15];
                byte AfterAND = (byte)(copy & (byte)191);
                ComboboxItem selectedData = (ComboboxItem)_cbEMULATIONWrite.SelectedItem;
                byte AfterSHIFT = (byte)((byte)(Convert.ToInt32(selectedData.Value))<<6);
                byte AfterOR = (byte)(AfterSHIFT | AfterAND);
                Int16 status1 = HIDClass.WriteSingleRegister(AfterOR, 1, (byte)15);
                Int16 statusRead = HIDClass.ReadSingleRegister((byte)Convert.ToInt32(0), 1, (byte)15);
              
            }
        }
        /// <summary>
        /// Register 15 OTP DATA READ
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void _btnOTP_DATARead_Click(object sender, EventArgs e)
        {
            Int16 status = HIDClass.ReadSingleRegister((byte)0, 1, (byte)15);
            if (status == 8)
            {
                byte OTP_DATA = (byte)((GlobalVariables.WriteRegs[15] & (byte)Convert.ToInt32(32)) >> 5);
                _txtOTP_DATA.Text = OTP_DATA.ToString("X2");
            }
        }
        /// <summary>
        /// Register 15 WR EN READ
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void _btnWR_ENRead_Click(object sender, EventArgs e)
        {
            Int16 status = HIDClass.ReadSingleRegister((byte)0, 1, (byte)15);
            if (status == 8)
            {
                byte WR_EN1 = (byte)((GlobalVariables.WriteRegs[15] & (byte)Convert.ToInt32(16)) >> 4);
                int WR_ENVal = Convert.ToInt32(WR_EN1);
                foreach (ComboboxItem selectedData in _cbWR_ENWrite.Items)
                {
                    if (Convert.ToInt32(selectedData.Value) == WR_ENVal)
                    {
                        _txtWR_ENRead.Text = selectedData.Text;
                    }
                }

            }
        }
        /// <summary>
        /// Register 15 WR EN Write
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void _cbWR_ENWrite_SelectedIndexChanged(object sender, EventArgs e)
        {
            Int16 status = HIDClass.ReadSingleRegister((byte)Convert.ToInt32(0), 1, (byte)15);
            if (status == 8)
            {
                byte copy = GlobalVariables.WriteRegs[15];
                byte AfterAND = (byte)(copy & (byte)239);
                ComboboxItem selectedData = (ComboboxItem)_cbWR_ENWrite.SelectedItem;
                byte AfterSHIFT = (byte)((byte)(Convert.ToInt32(selectedData.Value)) << 4);
                byte AfterOR = (byte)(AfterSHIFT | AfterAND);
                Int16 status1 = HIDClass.WriteSingleRegister(AfterOR, 1, (byte)15);

            }
        }
        /// <summary>
        /// Register 15 FUSE ADDR Read
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void _btnFUSE_ADDRRead_Click(object sender, EventArgs e)
        {
            Int16 status = HIDClass.ReadSingleRegister((byte)0, 1, (byte)15);
            if (status == 8)
            {
                byte FUSE_ADDR = (byte)(GlobalVariables.WriteRegs[15] & (byte)Convert.ToInt32(15));
                _txtFUSE_ADDRRead.Text = FUSE_ADDR.ToString("X2");
                 
                
            }
        }
        /// <summary>
        /// Register 15 FUSE ADDR Write
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void _btnFUSE_ADDRWrite_Click(object sender, EventArgs e)
        {
            try
            {
                int value = Convert.ToInt32(_txtFUSE_ADDRWrite.Text, 16);
                if (value >= 0 && value <= 255)
                {
                    Int16 status = HIDClass.ReadSingleRegister((byte)Convert.ToInt32(0), 1, (byte)15);
                    if (status == 8)
                    {
                        byte copy = GlobalVariables.WriteRegs[15];
                        byte AfterAND = (byte)(copy & (byte)240);
                        byte AfterSHIFT = (byte)(Convert.ToInt32(_txtFUSE_ADDRWrite.Text, 16));
                        byte AfterOR = (byte)(AfterSHIFT | AfterAND);
                        Int16 status1 = HIDClass.WriteSingleRegister(AfterOR, 1, (byte)15);

                    }
                }
            }
            catch (Exception ex)
            {
                System.Windows.MessageBox.Show("Enterd value not in correct format.");
            }
        }

        /// <summary>
        /// REGISTER 15: READ AND WRITE REGISTER STOP
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void _btnSoftwareReset_Click(object sender, EventArgs e)
        {
            //Register 9 Reset
            Int16 status1 = HIDClass.WriteSingleRegister((byte)(137), 1, (byte)9);
        }

        /// <summary>
        /// Change to write mode.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void _chkEnggModeEN_CheckedChanged(object sender, EventArgs e)
        {
            if (_chkEnggModeEN.Checked == true)
            {
                //Register 1 Write Enable.
                _chkPROX_EN.Enabled = true;
                _cbPROX_SLP.Enabled = true;
                _cbPROXCURRENT.Enabled = true;
                _chkIRDR.Enabled = true;
                //Register 2 write Enable.
                _btnPROXConfig1Write.Enabled = true;
                _txtPROX_BSCATWrite.Enabled = true;
                _chkPROX_PULSE.Enabled = true;
                _chkhighOffset.Enabled = true;
                //Register 3 write Enable.
                _cbPROX_PERST.Enabled = true;
                _chkIRDRTRIM.Enabled = true;
                _chkPROXFLAG.Enabled = true;
                _chlPROXDONE.Enabled = true;
                _chkIRDR_SHRT.Enabled = true;
                _chkINT_WSH_EN.Enabled = true;
                //Register 4 write Enable.
                _btnLowTHWrite.Enabled = true;
                _txtLowTHWrite.Enabled = true;
                //Register 5 write Enable.
                _btnHighTHWrite.Enabled = true;
                _txtHighTHWrite.Enabled = true;
                //Register B write Enable.
                _cbproSleepCtrlWrite.Enabled = true;
                _cbMeasRextWrite.Enabled = true;
                _cbRextSelectWrite.Enabled = true;
                _cbIBIAScntrlWrite.Enabled = true;
                //Register C write Enable.
                _cbResidueCtrlWrite.Enabled = true;
                _cbPROXTestWrite.Enabled = true;
                //Register D write Enable.
                _cbIRDRcurrentWrite.Enabled = true;
                _cbRegCtrlWrite.Enabled = true;
                _cbAnatestENWrite.Enabled = true;
                _cbINTfuncWrite.Enabled = true;
                //Register E write Enable.
                _cbIRDRTRIMWrite.Enabled = true;
                _cbPROX_OSADJwrite.Enabled = true;
                _cbPROX_GAINWrite.Enabled = true;
                _cbID_FUSE.Enabled = true;
                //Register F write Enable.
                _cbEMULATIONWrite.Enabled = true;
                _cbWR_ENWrite.Enabled = true;
                _txtFUSE_ADDRWrite.Enabled = true;
                _btnFUSE_ADDRWrite.Enabled = true;
                //Register 9 write Enable.
                _gbTestMode1.Enabled = true;
                _chkEnggModeEN.Text = "Enable Write";
                _chkEnggModeEN.ForeColor = Color.Green;

            }
            else
            {
                //Register 1 write Enable.
                _chkPROX_EN.Enabled = false;
                _cbPROX_SLP.Enabled = false;
                _cbPROXCURRENT.Enabled = false;
                _chkIRDR.Enabled = false;
                //Register 2 write Enable.
                _btnPROXConfig1Write.Enabled = false;
                _txtPROX_BSCATWrite.Enabled = false;
                _chkPROX_PULSE.Enabled = false;
                _chkhighOffset.Enabled = false;
                //Register 3 write Enable.
                _cbPROX_PERST.Enabled = false;
                _chkIRDRTRIM.Enabled = false;
                _chkPROXFLAG.Enabled = false;
                _chlPROXDONE.Enabled = false;
                _chkIRDR_SHRT.Enabled = false;
                _chkINT_WSH_EN.Enabled = false;
                //Register 4 write Enable.
                _btnLowTHWrite.Enabled = false;
                _txtLowTHWrite.Enabled = false;
                //Register 5 write Enable.
                _btnHighTHWrite.Enabled = false;
                _txtHighTHWrite.Enabled = false;
                //Register B write Enable.
                _cbproSleepCtrlWrite.Enabled = false;
                _cbMeasRextWrite.Enabled = false;
                _cbRextSelectWrite.Enabled = false;
                _cbIBIAScntrlWrite.Enabled = false;
                //Register C write Enable.
                _cbResidueCtrlWrite.Enabled = false;
                _cbPROXTestWrite.Enabled = false;
                //Register D write Enable.
                _cbIRDRcurrentWrite.Enabled = false;
                _cbRegCtrlWrite.Enabled = false;
                _cbAnatestENWrite.Enabled = false;
                _cbINTfuncWrite.Enabled = false;
                //Register E write Enable.
                _cbIRDRTRIMWrite.Enabled = false;
                _cbPROX_OSADJwrite.Enabled = false;
                _cbPROX_GAINWrite.Enabled = false;
                _cbID_FUSE.Enabled = false;
                //Register F write Enable.
                _cbEMULATIONWrite.Enabled = false;
                _cbWR_ENWrite.Enabled = false;
                _txtFUSE_ADDRWrite.Enabled = false;
                _btnFUSE_ADDRWrite.Enabled = false;
                //Register 9 write Enable.
                _gbTestMode1.Enabled = false;
                _chkEnggModeEN.Text = "Disable Write";
                _chkEnggModeEN.ForeColor = Color.Maroon;
            }
        }

        /// <summary>
        /// Timer to refresh and read continously with a time interval=5000 ms
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void RefreshAllTimer_Tick(object sender, EventArgs e)
        {
            //CopyReg = loadInitialValues();
            //GetDeviceVersion();
            GetRegister1();
            GetRegister2();
            GetRegister3();
            GetRegister4();
            GetRegister5();
            GetRegister6();
            GetRegister7();
            GetRegister8();
            GetRegister10();
            GetRegister11();
            GetRegister12();
            GetRegister13();
            //GetRegister14();
            GetRegister15();
        }

        /// <summary>
        /// On form EnggiMode closing event
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void EnggiMode_FormClosing(object sender, FormClosingEventArgs e)
        {
            RefreshAllTimer.Stop();
        }

        private void _chkIRDR_CheckedChanged(object sender, EventArgs e)
        {
            if (_chkIRDR.Checked == true)
            {
                Int16 status = HIDClass.ReadSingleRegister((byte)Convert.ToInt32(0), 1, (byte)1);
                if (status == 8)
                {
                    byte copy = GlobalVariables.WriteRegs[1];
                    byte AfterAND = (byte)(copy & (byte)247);
                    byte AfterSHIFT = (byte)((byte)Convert.ToInt32(1) << 3);
                    byte AfterOR = (byte)(AfterSHIFT | AfterAND);
                    Int16 statusWrite = HIDClass.WriteSingleRegister(AfterOR, 1, (byte)1);
                    if (statusWrite == 8)
                    {
                        GlobalVariables.IRDR_SHRT = (byte)1;
                        FillProxCurrDropdown();
                        MS.changeLable("1");
                    }
                }
            }
            else
            {
                Int16 status = HIDClass.ReadSingleRegister((byte)Convert.ToInt32(0), 1, (byte)1);
                if (status == 8)
                {
                    byte copy = GlobalVariables.WriteRegs[1];
                    byte AfterAND = (byte)(copy & (byte)247);
                    byte AfterSHIFT = (byte)((byte)Convert.ToInt32(0) << 3);
                    byte AfterOR = (byte)(AfterSHIFT | AfterAND);
                    Int16 statusWrite = HIDClass.WriteSingleRegister(AfterOR, 1, (byte)1);
                    if (statusWrite == 8)
                    {
                        GlobalVariables.IRDR_SHRT = (byte)0;
                        FillProxCurrDropdown();
                        MS.changeLable("0");
                    }
                }   

            }
        }
 
    }
}
