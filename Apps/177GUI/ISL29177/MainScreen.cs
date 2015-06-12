/**********************************************************************
 Module     : Main Screen
 Created On : 6-Jun-2014      
 Class file : MainScreen.cs
 This class provides :
 1) First page of application which involves graph and few Parameter which can b modified by Customer level
 
 **************************************************************************/

using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using Inersil_WPFV2.Repository;
using IntersilLib;
using System.IO;
using System.Threading;
namespace ISL29177 
{
    public partial class MainScreen : Form
    {
        drvAlgo pDrvAlgo;// JWG

        #region Class Data Members
       
        List<File> FiliList = new List<File>();
        Dictionary<string, int> CBproxSLP, CBproxCurrent, CBproxPers;
        byte[] CopyReg = new byte[32];
        /// <summary>
        /// I2C address of the device
        /// </summary>
        readonly string _I2CAddr = string.Empty;

        /// <summary>
        ///Graph x-axis max value
        ///400 sample reading
        /// </summary>
        public const Int16 noSamples = 400;

        /// <summary>
        ///Start this timer when start the device 
        /// </summary>
      //  public static DispatcherTimer timer = new DispatcherTimer();

       
        /// <summary>
        /// This data table is used to bind the reading values to the graph
        /// </summary>
        DataTable dtGraph = new DataTable();
        DataTable dtGraphRed = new DataTable();
        #endregion
        public MainScreen()
        {

            try
            {
                #region Initialize Readonly
                _I2CAddr = ConfigurationManager.AppSettings["usbAddr"];
                #endregion

                InitializeComponent();
                CheckForIllegalCrossThreadCalls = false;
                #region Graph
                //InitializeGraph DataTable;
                dtGraph.Columns.Add("SAMPLE", Type.GetType("System.Int32"));
                dtGraph.Columns.Add("AMBI COUNT", Type.GetType("System.Int32"));
                dtGraphRed.Columns.Add("SAMPLE", Type.GetType("System.Int32"));
                dtGraphRed.Columns.Add("PROX COUNT", Type.GetType("System.Int32"));
                #endregion
                //Initialization of Sensor.
                SetRegister1();
                //GetSetRegister6();
                //Set Default inputs to registers.
                SetDefaultInput();
                //Load the Intial values after set Defaults inputs.
                CopyReg = loadInitialValues();
                //Starts the timer to read or clear register values.
                CustomerRegisterTimer.Start();
                pDrvAlgo = new drvAlgo();// JWG
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }


        /// <summary>
        /// Write register 1 value to initialize by writing 80h
        /// </summary>
        private void SetRegister1()
        {
           // Int16 status = HIDClass.WriteSingleRegister((byte)Convert.ToInt16(56), 1, (byte)9);
            Int16 status = HIDClass.WriteSingleRegister((byte)Convert.ToInt16(128), 1, (byte)1);
        }

        /// <summary>
        /// Set Default values after initialization.
        /// </summary>
        private void SetDefaultInput()
        {
           
            //Fill dropdown PROX SLEEP with display Member and Value Member.
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

            

            //Fill dropdown PROX Current with display Member and Value Member.
            fillProxCurrDropdown();

            //Fill dropdown PROX Perst with display Member and Value Member.
            CBproxPers = new Dictionary<string, int>
                {
                    {"1 conv",0},{"2 conv", 1}, {"4 conv", 2},{"8 conv", 3},
                };
            this._cbPROX_PERST.DisplayMember = "Key";
            this._cbPROX_PERST.ValueMember = "Value";
            foreach (KeyValuePair<string, int> words in CBproxPers)
            {
                _cbPROX_PERST.Items.Add(new ComboboxItem(words.Key,words.Value));
            }
        }

        
       /// <summary>
        /// Fill Prox Current dropdown according to changes based on ID fuse.
       /// </summary>
       private void fillProxCurrDropdown()
       {
           
        //Fill dropdown PROX Current with display Member and Value Member.
           _cbPROXCURRENT.Items.Clear();
            if (GlobalVariables.IRDR_SHRT == (byte)0)
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
       /// load or Get Initial values of sensor.
       /// </summary>
       /// <returns>Byte Array of registers values</returns>
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
        /// Clear register No. 6 values.
        /// </summary>
        private void GetSetRegister6()
        {
               Int16 status = HIDClass.ReadSingleRegister((byte)0, 1, (byte)6);
                    if (status == 8)
                    {
                        CopyReg[6] = GlobalVariables.WriteRegs[6];
                    }
                //Read 5th BIT as I2C Fault DETECT
                byte I2C_Fault_detection = (byte)((CopyReg[6] & (byte)16)>>4);
                if (I2C_Fault_detection == (byte)0)
                {
                    ovalI2C_Fault_detection.BackColor = Color.White;
                }
                if (I2C_Fault_detection == (byte)1)
                {
                    ovalI2C_Fault_detection.BackColor = Color.Green;
                }
                //Read 4th BIT as PROX INT FLAG
                byte PROX_interrupt_flag = (byte)((CopyReg[6] & (byte)8)>>3);
                if (Convert.ToInt16(PROX_interrupt_flag) == 0)
                {
                    oval_PROX_interrupt_flag.BackColor = Color.White;
                }
                if (Convert.ToInt16(PROX_interrupt_flag) == 1)
                {
                    oval_PROX_interrupt_flag.BackColor = Color.Green;
                }
                //Read 3rd Bit as PROX CONV INT
                byte PROX_conversion_intr = (byte)((CopyReg[6] & (byte)4)>>2);
                if (Convert.ToInt16(PROX_conversion_intr) == 0)
                {
                    ovalPROX_conversion_intr.BackColor = Color.White;
                }
                if (Convert.ToInt16(PROX_conversion_intr) == 1)
                {
                    ovalPROX_conversion_intr.BackColor = Color.Red;
                }
                //Read 2nd Bit as LOW IRDR VDS DETECT
                byte LOW_IRDR_VDS_DETECT = (byte)((CopyReg[6] & (byte)2)>>1);
                if (Convert.ToInt16(LOW_IRDR_VDS_DETECT) == 0)
                {
                    oval_LOW_IRDR_VDS_DETECT.BackColor = Color.White;
                }
                if (Convert.ToInt16(LOW_IRDR_VDS_DETECT) == 1)
                {
                    oval_LOW_IRDR_VDS_DETECT.BackColor = Color.Green;
                }
                //Read 1st Bit as PROX WASH FLAG
                byte PROX_wahsout_flag = (byte)(CopyReg[6] & (byte)1);
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
        /// Checking the status of usb connected or not. 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void _btnUsbCheck_Click(object sender, EventArgs e)
        {
            DeviceUtil.SearchDevice();
            if (GlobalVariables.MyDeviceDetected == false)
            {
                usbPicture.Image = ISL29177.Properties.Resources.close;
                DeviceUtil.SearchDevice();
            }
            else {
                usbPicture.Image = ISL29177.Properties.Resources.connected_icon;
            }
        }

        /// <summary>
        /// Change the device name when ID FUSE bit become change.
        /// </summary>
        /// <param name="value"></param>
        public void changeLable(string value)
        {
            _lblSensor.Text = value;
            fillProxCurrDropdown();
        }


        /// <summary>
        /// Enable To write register values.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void _chkWriteEnable_CheckedChanged(object sender, EventArgs e)
        {
           
                if (_chkWriteEnable.Checked == true)
                {
                    _chkPROX_EN.Enabled = true;
                    _cbPROX_SLP.Enabled = true;
                    _chkIRDR.Enabled = true;
                    _cbPROXCURRENT.Enabled = true;
                    _chkhighOffset.Enabled = true;
                    _txtPROX_BSCATWrite.Enabled = true;
                    _btnPROXBSCAT.Enabled = true;
                    _cbPROX_PERST.Enabled = true;
                    _chkPROXFLAG.Enabled = true;
                    _chlPROXDONE.Enabled = true;
                    _chkIRDR_SHRT.Enabled = true;
                    _chkINT_WSH_EN.Enabled = true;
                    _txtPROX_HT_Read.Enabled = true;
                    _txtPROX_HTWrite.Enabled = true;
                    _txtPROX_LT_Read.Enabled = true;
                    _txtPROX_LTWrite.Enabled = true;
                    _btnPROX_HTWrite.Enabled = true;
                    _btnPROX_LTWrite.Enabled = true;
                    _chkWriteEnable.ForeColor = Color.Green;
                    _chkWriteEnable.Text = "Write Enabled";
                
                }
                else
                {
                    _chkPROX_EN.Enabled = false;
                    _cbPROX_SLP.Enabled = false;
                    _chkIRDR.Enabled = false;
                    _cbPROXCURRENT.Enabled = false;
                    _txtPROX_BSCATWrite.Enabled = true;
                    _btnPROXBSCAT.Enabled = false;
                    _chkhighOffset.Enabled = false;
                    _cbPROX_PERST.Enabled = false;
                    _chkPROXFLAG.Enabled = false;
                    _chlPROXDONE.Enabled = false;
                    _chkIRDR_SHRT.Enabled = false;
                    _chkINT_WSH_EN.Enabled = false;
                    _txtPROX_HTWrite.Enabled = false;
                    _txtPROX_LTWrite.Enabled = false;
                    _btnPROX_LTWrite.Enabled = false;
                    _btnPROX_HTWrite.Enabled = false;
                    _chkWriteEnable.ForeColor = Color.Maroon;
                    _chkWriteEnable.Text = "Write Enable";
                }
            }
           
            
       /// <summary>
       /// Expand register 6 GroupBox.
       /// </summary>
       /// <param name="sender"></param>
       /// <param name="e"></param>
        private void _PCExpand_Click(object sender, EventArgs e)
        {
            if (_gbRegister6.Visible == true)
            {
                _gbRegister6.Visible = false;
                _PCExpand.Image = ISL29177.Properties.Resources.Expand;

            }
            else
            {
                _gbRegister6.Visible = true;
                _PCExpand.Image = ISL29177.Properties.Resources.Collapse;
            }
        }

        /// <summary>
        /// Satrt the appliction to read and get the default values.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void _btnStart_Click(object sender, EventArgs e)
        {
            try
            {
                //Is device detected
                if (GlobalVariables.MyDeviceDetected)
                {
                    //Toggle the Start button to Stop and Stop to Start.
                    ToggleButton();
                    usbPicture.Image = ISL29177.Properties.Resources.connected_icon;
                    //Read Initial values from sensor when device starts.
                    StartReadingUtil.WriteRegOnStart();
                   // GetDefaultValues();

                }
                else
                {
                    DeviceUtil.SearchDevice();

                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }

        }

        /// <summary>
        /// Toggle the start and stop button.
        /// </summary>
        private void ToggleButton()
        {

            if (_btnStart.Visible == true)
            {
                _btnStart.Visible = false;
                _btnStop.Visible = true;
                timer1.Start();
            }
            else
            {
                _btnStop.Visible = false;
                _btnStart.Visible = true;
                timer1.Stop();
            }
        
        }

      

        //Reading Register 1 Prox Sleep instant value.
        private void _btnPROX_SLP_Click(object sender, EventArgs e)
        {
            Int16 status = HIDClass.ReadSingleRegister((byte)0, 1, (byte)1);
            if (status == 8)
            {
                byte ProxSLP = (byte)((GlobalVariables.WriteRegs[1] & (byte)Convert.ToInt32(112)) >> 4);
                int ProxSLPVal = Convert.ToInt32(ProxSLP);
                foreach (ComboboxItem selectedData in _cbPROX_SLP.Items)
                {
                    if (Convert.ToInt32(selectedData.Value) == ProxSLPVal)
                    {
                        _txtPROX_SLP.Text = selectedData.Text;
                    }
                }
            }
        }

        /// <summary>
        /// Reading Register 1 Prox Current instant value. 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void _btnPROXCURRENTRead_Click(object sender, EventArgs e)
        {
            Int16 status = HIDClass.ReadSingleRegister((byte)0, 1, (byte)1);
            if (status == 8)
            {
                byte ProxCurrent = (byte)(GlobalVariables.WriteRegs[1] & (byte)Convert.ToInt32(7));
                int proxCurrentval = Convert.ToInt32(ProxCurrent);
                foreach (ComboboxItem selectedData in _cbPROXCURRENT.Items)
                {
                    if (GlobalVariables.IRDR_SHRT == (byte)1)
                    {
                        if (Convert.ToInt32(selectedData.Value) == proxCurrentval + 8)
                        {
                            _txtPROX_CURRENT.Text = selectedData.Text;
                        }
                    }
                    else
                    {
                        if (Convert.ToInt32(selectedData.Value) == proxCurrentval)
                        {
                            _txtPROX_CURRENT.Text = selectedData.Text;
                        }
                    }
                }
            }
        }

        /// <summary>
        /// Reading Register 3 Prox PERST instant value. 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void _btnPROX_PERST_Click(object sender, EventArgs e)
        {
            Int16 status = HIDClass.ReadSingleRegister((byte)0, 1, (byte)3);
            if (status == 8)
            {
                byte ProxPerst = (byte)((byte)(GlobalVariables.WriteRegs[3] & (byte)Convert.ToInt32(48))>>4);
                Int32 ProxPerstVal = Convert.ToInt32(ProxPerst);
                foreach (ComboboxItem selectedData in _cbPROX_PERST.Items)
                {
                    if (Convert.ToInt32(selectedData.Value) == ProxPerstVal)
                    {
                        _txtPROX_PERST.Text = selectedData.Text;
                    }
                }
                   
            }
        }

        /// <summary>
        /// Reading Register 4 Prox Low Th value. 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void _btnPROX_LTRead_Click(object sender, EventArgs e)
        {
             Int16 status = HIDClass.ReadSingleRegister((byte)0, 1, (byte)4);
             if (status == 8)
             {
                 _txtPROX_LT_Read.Text = GlobalVariables.WriteRegs[4].ToString("X2");
               
             }
        }

        /// <summary>
        /// Reading Register 5 Prox High Th value. 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void _btnPROX_HTRead_Click(object sender, EventArgs e)
        {
            Int16 status = HIDClass.ReadSingleRegister((byte)0, 1, (byte)5);
            if (status == 8)
            {
                
                _txtPROX_HT_Read.Text = GlobalVariables.WriteRegs[5].ToString("X2");
            }
        }

        /// <summary>
        /// Writting Register 5 Prox Low Th instant value.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void _btnPROX_LTWrite_Click(object sender, EventArgs e)
        {
            try
            {
                int value = Convert.ToInt32(_txtPROX_LTWrite.Text, 16);
                if (value >= 0 && value <= 255)
                {
                    Int16 status = HIDClass.WriteSingleRegister((byte)Convert.ToInt16(_txtPROX_LTWrite.Text, 16), 1, (byte)4);
                }
            }
            catch (Exception ex)
            {
                System.Windows.MessageBox.Show("Enterd value not in correct format.");
            }
        }

        
        /// <summary>
        /// Writting Register 5 Prox High Th instant value. 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void _btnPROX_HTWrite_Click(object sender, EventArgs e)
        {
            try
            { 
              int value = Convert.ToInt32(_txtPROX_HTWrite.Text, 16);
              if (value >= 0 && value <= 255)
              {
                  Int16 status = HIDClass.WriteSingleRegister((byte)Convert.ToInt16(_txtPROX_HTWrite.Text,16), 1, (byte)5);
              }
            }
            catch(Exception ex)
            {
                System.Windows.MessageBox.Show("Enterd value not in correct format.");
            }
        }

        /// <summary>
        /// To Stop the application and graph.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void _btnStop_Click(object sender, EventArgs e)
        {
            ToggleButton();
        }

        /// <summary>
        /// To clear register 6.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void _btnRefreshRegister6_Click(object sender, EventArgs e)
        {
            GetSetRegister6();
        }

        /// <summary>
        /// To read register 1 value PRox En.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void _btnProxENRead_Click(object sender, EventArgs e)
        {
            Int16 status = HIDClass.ReadSingleRegister((byte)0, 1, (byte)1);
            byte proxEN = (byte)((GlobalVariables.WriteRegs[1] & (byte)Convert.ToInt32(128)) >> 7);
            if (proxEN == (byte)0)
            {
                _chkPROX_EN.Checked = false;
            }
            if (proxEN == (byte)1)
            {
                _chkPROX_EN.Checked = true;
            }
        }

        /// <summary>
        /// To Write register 1 value PRox Sleep.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void _cbPROX_SLP_SelectedIndexChanged(object sender, EventArgs e)
        {
            ComboboxItem selectedData = (ComboboxItem)_cbPROX_SLP.SelectedItem;
            int TimerInterval = GlobalVariables.GetTimerInterval(Convert.ToInt16(selectedData.Value));
            timer1.Interval = TimerInterval;
            Int16 status = HIDClass.ReadSingleRegister((byte)Convert.ToInt32(0), 1, (byte)1);
            if (status == 8)
            {
                byte copy=GlobalVariables.WriteRegs[1];
                byte AfterAND = (byte)(copy & (byte)143);
                byte AfterSHIFT = (byte)((byte)Convert.ToInt32(selectedData.Value) << 4);
                byte AfterOR = (byte)(AfterSHIFT | AfterAND);
                Int16 statusWrite = HIDClass.WriteSingleRegister(AfterOR, 1, (byte)1);
            }
        }

        /// <summary>
        /// To Write register 1 value PRox EN. 
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
                  Int16 statusWrite = HIDClass.WriteSingleRegister(AfterOR, 1, (byte)1);
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
                    Int16 statusWrite = HIDClass.WriteSingleRegister(AfterOR, 1, (byte)1);
                }
             }
        }

        /// <summary>
        /// To Write register 1 value PROX CURRENT.
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
                Int16 statusWrite = HIDClass.WriteSingleRegister(AfterOR, 1, (byte)1);
            }
            pDrvAlgo.adjustOffset(); // JWG
        }

        /// <summary>
        /// To Write register 1 value PROX PERST.
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
        /// Timer Event that handles graph,Register 6 flags ,PROX DATA-PROX AMBIR Readings and writes in to file.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void timer1_Tick(object sender, EventArgs e)
        {

            Int16 statusReg8 = HIDClass.ReadSingleRegister((byte)0, 1, (byte)8);
            Int16 statusReg7 = HIDClass.ReadSingleRegister((byte)0, 1, (byte)7);
            if (statusReg8 == 8 && statusReg7 == 8)
            {
                //reading register 7 and 8 values.
                _txtAMBICount.Text = GlobalVariables.WriteRegs[8].ToString();
                _txtproxCount.Text = GlobalVariables.WriteRegs[7].ToString();

                //Getting INT Polling.
                if (ovalIntPolling.BackColor == Color.White)
                    ovalIntPolling.BackColor = Color.Green;
                else
                    ovalIntPolling.BackColor = Color.White;

                //Adding the Register 7 and 8 reading to list which is file type.
                File fileli = new File();
                fileli.dateTFormt = DateTime.Now.ToString(ConfigurationManager.AppSettings["dateTFormt"]);
                fileli.dateFormt = DateTime.Now.ToString(ConfigurationManager.AppSettings["dateFormt"]);
                fileli.RegisterNo = "[7-PROX COUNT]---[8-AMBIR VALUE]";
                fileli.Registervalue = _txtAMBICount.Text + "---"+ _txtproxCount.Text;
                FiliList.Add(fileli);

                //Data Row for reading 1(Register 8[PROX AMBIR])
                DataRow dr = dtGraph.NewRow();
                dr[0] = 0;
                dr[1] = _txtAMBICount.Text;
                //Data Row for reading 2(Register 7[PROX COUNT])
                DataRow dr1 = dtGraphRed.NewRow();
                dr1[0] = 0;
                dr1[1] = _txtproxCount.Text;
                // DataRow
                
                dtGraphRed.Rows.InsertAt(dr1, 0);
                dtGraph.Rows.InsertAt(dr, 0);
                chart1.Series[0].Points.DataBind(dtGraph.DefaultView, "Sample", "AMBI COUNT", null);
                chart1.Series[1].Points.DataBind(dtGraphRed.DefaultView, "Sample", "PROX COUNT", null);
                chart1.ChartAreas[0].AxisX.MajorGrid.Enabled = false;
                chart1.ChartAreas[0].AxisY.MajorGrid.Enabled = false;
                chart1.ChartAreas[0].AxisY.MinorGrid.Enabled = false;
                chart1.ChartAreas[0].AxisY.MinorGrid.Enabled = false;
                // chart1.Series[1].Points.DataBind(dtGraph.DefaultView, "Sample", "AMBI COUNT", null);
            }
            else
            {
                //To stop timer which gets the graph value.
                _btnStop_Click(null, null);
                GlobalVariables.MyDeviceDetected = false;
                //Getting the Device status.
                if (GlobalVariables.MyDeviceDetected)
                {
                    //If detected call Similer process again as start.
                    ToggleButton();
                    StartReadingUtil.WriteRegOnStart();
                   // GetDefaultValues();
                }
                else
                {
                    //usb error
                    usbPicture.Image = ISL29177.Properties.Resources.close;
                    timer1.Stop();
                    CustomerRegisterTimer.Stop();
                    System.Windows.MessageBox.Show("USB is not properly connected.Please Check Connection.");
                    Application.Exit();
                    
                   // DeviceUtil.SearchDevice();
                   // if (GlobalVariables.MyDeviceDetected)
                    //{
                      //  usbPicture.Image = ISL29177.Properties.Resources.connected_icon;
                    //}
                }
                
            }
        }

        /// <summary>
        /// Show the save file dialogue box and save the file in the formate user select
        /// </summary>
        /// <param name="dlg"></param>
        private void SaveFile(Microsoft.Win32.SaveFileDialog dlg, string SaveAs, int SampleCount)
        {
            dlg.FileName = "Measure"; // Default file name
            dlg.DefaultExt = ".csv"; // Default file extension
            dlg.Filter = "CSV file (.csv)|*.csv"; // Filter files by extension
            
            File FileWr = new File();
            if (SaveAs == "SaveAs")
            {
                //Show Dialog
                Nullable<bool> result = dlg.ShowDialog();
                if (result == true)
                {
                    Thread thFileSaveAs=new Thread(()=>SaveAsFileTh(dlg,FileWr));
                    thFileSaveAs.Start();
                }
            }
               
            else
            {
                
                //Save configuration to file
                string[] lines = System.IO.File.ReadAllLines("path.txt");
                int caseSwitch = SampleCount;
                bool checkStatus=false;
                switch (caseSwitch)
                {
                    case 100:
                        checkStatus = checkSampleCount(SampleCount);
                        break;
                    case 500:
                        checkStatus = checkSampleCount(SampleCount);
                        break;
                    case 1000:
                        checkStatus = checkSampleCount(SampleCount);
                        break;
                    default:
                        Console.WriteLine("Default case");
                        break;
                }
                if (checkStatus == true)
                    FileWr.WriteFile(FiliList, lines[0], SampleCount);
            }
        }

        /// <summary>
        /// Save as File thread for creating file with 1000 samples
        /// </summary>
        /// <param name="dlg"></param>
        /// <param name="FileWr"></param>
        private void SaveAsFileTh(Microsoft.Win32.SaveFileDialog dlg,File FileWr)
        {
            string filename = dlg.FileName;
            LogInfo oLog = new LogInfo();
            oLog.Ext = dlg.FileName.Substring(dlg.FileName.IndexOf('.'));
            oLog.Filepath = dlg.FileName;
            //retain same path for Save As to use next time.
            FileWr.SavePath(dlg.FileName);
            //Disable save,save as  and stop button
            saveFileToolStripMenuItem.Enabled = false;
            SaveAsToolStripMenuItem.Enabled = false;
            _btnStop.Enabled = false;
            bool checkStatus = checkSampleCount(1000);
            //Write Configuaration to the file.
            if (checkStatus == true)
                FileWr.WriteFile(FiliList, oLog.Filepath, 1000);
        }

        /// <summary>
        /// Checks list has required sample or less
        /// </summary>
        private bool checkSampleCount(int RequiredSample)
        {
            bool result = false;
            if (FiliList.Count >= RequiredSample)
            {
                saveFileToolStripMenuItem.Enabled = true;
                SaveAsToolStripMenuItem.Enabled = true;
                _btnStop.Enabled = true;
                result = true;
                Thread.Sleep(1000);
                return result;
            }
            else
            {
                Thread.Sleep(1000);
                result=checkSampleCount(RequiredSample);
                return result;
            }
            
        }

        /// <summary>
        /// Form Closing event of Main Screen.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void MainScreen_FormClosing(object sender, FormClosingEventArgs e)
        {
           System.Windows.Forms.Application.Exit();
        }

              
        /// <summary>
        /// Reading Register value continously.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void CustomerRegisterTimer_Tick(object sender, EventArgs e)
        {
            
            //To Read register 1 value PRox EN.
            Int16 status = HIDClass.ReadSingleRegister((byte)0, 1, (byte)1);
            byte proxEN = (byte)((GlobalVariables.WriteRegs[1] & (byte)Convert.ToInt32(128)) >> 7);
            if (proxEN == (byte)0)
            {
                _chkPROX_EN.Checked = false;
            }
            if (proxEN == (byte)1)
            {
                _chkPROX_EN.Checked = true;
            }

            //To Read register 1 value PRox SLP.
            byte ProxSLP = (byte)((GlobalVariables.WriteRegs[1] & (byte)Convert.ToInt32(112)) >> 4);
            int ProxSLPVal = Convert.ToInt32(ProxSLP);
            foreach (ComboboxItem selectedData in _cbPROX_SLP.Items)
            {
                if (Convert.ToInt32(selectedData.Value) == ProxSLPVal)
                {
                    _txtPROX_SLP.Text = selectedData.Text;
                }
            }

            //To Read register 1 value PRox Current.
            byte ProxCurrent = (byte)(GlobalVariables.WriteRegs[1] & (byte)Convert.ToInt32(7));
            int proxCurrentval = Convert.ToInt32(ProxCurrent);
            foreach (ComboboxItem selectedData in _cbPROXCURRENT.Items)
            {
                if (GlobalVariables.IRDR_SHRT == (byte)1)
                {
                    if (Convert.ToInt32(selectedData.Value) == proxCurrentval + 8)
                    {
                        _txtPROX_CURRENT.Text = selectedData.Text;
                    }
                }
                else
                {
                    if (Convert.ToInt32(selectedData.Value) == proxCurrentval)
                    {
                        _txtPROX_CURRENT.Text = selectedData.Text;
                    }
                }
            }
            //To Read register 2 value high OffSet.
            Int16 statusHOfStatus = HIDClass.ReadSingleRegister((byte)0, 1, (byte)2);
            byte highOffset = (byte)((GlobalVariables.WriteRegs[2] & (byte)Convert.ToInt32(32)) >> 5);
            if (highOffset == (byte)0)
            {
                _chkhighOffset.Checked = false;
            }
            if (highOffset == (byte)1)
            {
                _chkhighOffset.Checked = true;
            }

            //To Read register 2 value Prox BSCAT.
            byte PROX_BSCAT = (byte)(GlobalVariables.WriteRegs[2] & (byte)31);
            _txtproBSCATRead.Text = "0X" + PROX_BSCAT.ToString("X2");
            //To Read register 3 value PRox PERST.
            Int16 statusRead = HIDClass.ReadSingleRegister((byte)0, 1, (byte)3);
            if (statusRead == 8)
            {
                byte ProxPerst = (byte)((byte)(GlobalVariables.WriteRegs[3] & (byte)Convert.ToInt32(48)) >> 4);
                int ProxPerstVal = Convert.ToInt32(ProxPerst);
                foreach (ComboboxItem selectedData in _cbPROX_PERST.Items)
                {
                    if (Convert.ToInt32(selectedData.Value) == ProxPerstVal)
                    {
                        _txtPROX_PERST.Text = selectedData.Text;
                    }
                }
            }
            //To Read register 3 value PRox Flag.
            byte PROXFLAG = (byte)((GlobalVariables.WriteRegs[3] & (byte)Convert.ToInt32(8)) >> 3);
            if (PROXFLAG == (byte)0)
            {
                _chkPROXFLAG.Checked = false;
            }
            if (PROXFLAG == (byte)1)
            {
                _chkPROXFLAG.Checked = true;
            }
            //To Read register 3 value PRox DONE.
            byte PROXDONE = (byte)((GlobalVariables.WriteRegs[3] & (byte)Convert.ToInt32(4)) >> 2);
            if (PROXDONE == (byte)0)
            {
                _chlPROXDONE.Checked = false;
            }
            if (PROXDONE == (byte)1)
            {
                _chlPROXDONE.Checked = true;
            }
            //To Read register 3 value IRDR SHRT.
            byte IRDR_SHRT = (byte)((GlobalVariables.WriteRegs[3] & (byte)Convert.ToInt32(2)) >> 1);
            if (IRDR_SHRT == (byte)0)
            {
                _chkIRDR_SHRT.Checked = false;
            }
            if (IRDR_SHRT == (byte)1)
            {
                _chkIRDR_SHRT.Checked = true;
            }
            //To Read register 3 value Int_WSH.
            byte INT_WSH = (byte)(GlobalVariables.WriteRegs[3] & (byte)Convert.ToInt32(1));
            if (INT_WSH == (byte)0)
            {
                _chkINT_WSH_EN.Checked = false;
            }
            if (INT_WSH == (byte)1)
            {
                _chkINT_WSH_EN.Checked = true;
            }
            //To Read register 4 value PRox LT.
            Int16 status2 = HIDClass.ReadSingleRegister((byte)0, 1, (byte)4);
            if (status == 8)
            {
                _txtPROX_LT_Read.Text = GlobalVariables.WriteRegs[4].ToString("X2");
            }

            //To Read register 5 value PRox HT.
            Int16 status3 = HIDClass.ReadSingleRegister((byte)0, 1, (byte)5);
            if (status == 8)
            {
                _txtPROX_HT_Read.Text = GlobalVariables.WriteRegs[5].ToString("X2");
            }

            //Clear Register 6 values.
            GetSetRegister6();
        }

        //Open file fro system and load configuration from file.
        //File format:Register=value
        //              0X01=0XYY
        private void openFileToolStripMenuItem_Click(object sender, EventArgs e)
        {
            
            Microsoft.Win32.OpenFileDialog dlg = new Microsoft.Win32.OpenFileDialog();
            dlg.FileName = "Document";
            dlg.DefaultExt = ".txt";
            dlg.Filter = "Text Documents (.txt)|*.txt|CSV File (.csv)|*.csv";

            Nullable<bool> result = dlg.ShowDialog();

            if (result == true)
            {
                int Count=0;
                string fileName = dlg.FileName;
                try
                {
                    using (StreamReader sr = new StreamReader(fileName))
                    {
                        while (!sr.EndOfStream)
                        {
                            //reading line one by one.
                            string line = sr.ReadLine();
                            //reading words in each line.
                            string[] lineWords = line.Split('=');
                            //Converting to int and register-value set to the value variable.
                            int value = Convert.ToInt32(lineWords[1], 16);
                            //Converting to int and register-add set to the reg variable.
                            int reg=Convert.ToInt16((lineWords[0].Substring(lineWords[0].Length-2)),16);
                            //checking max and min value of register and total count in file.
                            if (value >= 0 && value <= 255 && Count<=9)
                            {
                                Count++;
                                //writing the register value which we get from file.
                                Int16 status = HIDClass.WriteSingleRegister((byte)Convert.ToInt32(value), 1, (byte)reg);
                                int statusRead = HIDClass.ReadSingleRegister((byte)0, 1, (byte)reg);
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                    System.Windows.MessageBox.Show(ex.ToString().Substring(0,50));
                }
            }
        }

        /// <summary>
        /// thread function which handle process for save sample in file
        /// </summary>
        /// <param name="i"></param>
        public void saveData(string mode,int sample)
        {
            Microsoft.Win32.SaveFileDialog dlg = new Microsoft.Win32.SaveFileDialog();
            if(mode=="Save")
            dlg.Title = "Save File";
            else
            dlg.Title = "Save As File";
            saveFileToolStripMenuItem.Enabled = false;
            SaveAsToolStripMenuItem.Enabled = false;
            _btnStop.Enabled = false;
            SaveFile(dlg, mode, sample);
        }

           
        /// <summary>
        /// for SW Reset in customer mode by writing 0x38h.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void _btnSWReset_Click(object sender, EventArgs e)
        {
            Int16 status = HIDClass.WriteSingleRegister((byte)56, 1, (byte)9);
            if (status == 8)
            {
                status = HIDClass.ReadSingleRegister((byte)0, 1, (byte)9);
            }
            if ((Application.OpenForms["EnggiMode"] as EnggiMode) != null)
            {
                EnggiMode EM = new EnggiMode(this);
                EM.Close();
            }
        }

        //Open file fro system and load configuration from file.
        //File format:Register=value
        //              0X01=0XYY
        private void openFile_Click(object sender, EventArgs e)
        {
            Microsoft.Win32.OpenFileDialog dlg = new Microsoft.Win32.OpenFileDialog();
            dlg.FileName = "Document";
            dlg.DefaultExt = ".txt";
            dlg.Filter = "Text Documents (.txt)|*.txt|CSV File (.csv)|*.csv";

            Nullable<bool> result = dlg.ShowDialog();

            if (result == true)
            {
                int Count = 0;
                string fileName = dlg.FileName;
                try
                {
                    using (StreamReader sr = new StreamReader(fileName))
                    {
                        while (!sr.EndOfStream)
                        {
                            //reading line one by one.
                            string line = sr.ReadLine();
                            //reading words in each line.
                            string[] lineWords = line.Split('=');
                            //Converting to int and register-value set to the value variable.
                            int value = Convert.ToInt32(lineWords[1], 16);
                            //Converting to int and register-add set to the reg variable.
                            int reg = Convert.ToInt16((lineWords[0].Substring(lineWords[0].Length - 2)), 16);
                            //checking max and min value of register and total count in file.
                            if (value >= 0 && value <= 255 && Count <= 9)
                            {
                                Count++;
                                //writing the register value which we get from file.
                                Int16 status = HIDClass.WriteSingleRegister((byte)Convert.ToInt32(value), 1, (byte)reg);
                                int statusRead = HIDClass.ReadSingleRegister((byte)0, 1, (byte)reg);
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                    System.Windows.MessageBox.Show(ex.ToString().Substring(0, 50));
                }
            }
        }

        /// <summary>
        /// Thread calling for record 100 sample in file
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void Sample100_Click(object sender, EventArgs e)
        {
            Thread th = new Thread(() => saveData("Save", 100));
            th.Start();
        }

        /// <summary>
        /// Showing Register Mode.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void RegisterMode_Click(object sender, EventArgs e)
        {
            if ((Application.OpenForms["AdvanceConfig"] as AdvanceConfig) != null)
            {
                //Form is already open
                System.Windows.MessageBox.Show("Register Mode is Already running.");
            }
            else
            {
                // Form is not open
                AdvanceConfig AC = new AdvanceConfig();
                AC.Show();
            }
        }

        /// <summary>
        /// Shwoing Engineering Mode.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void EngiMode_Click(object sender, EventArgs e)
        {
            bool RetStatus = GlobalVariables.ckeckEnggiMode();
            if (RetStatus)
            {
                if (GlobalVariables.MyDeviceDetected)
                {
                    if ((Application.OpenForms["EnggiMode"] as EnggiMode) != null)
                    {
                        //Form is already open
                        System.Windows.MessageBox.Show("EnggiMode is Already running.");
                    }
                    else
                    {
                        // Form is not open
                        EnggiMode EM = new EnggiMode(this);
                        EM.Show();
                    }
                }
            }
        }

        /// <summary>
        /// thread calling for save 200 sample in file
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void Sample500_Click(object sender, EventArgs e)
        {
            Thread th = new Thread(() => saveData("Save", 500));
            th.Start();
        }

        /// <summary>
        /// Thread calling for save 1000 sample in a file
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void Sample1000_Click(object sender, EventArgs e)
        {
            Thread th = new Thread(() => saveData("Save", 1000));
            th.Start();
        }

        /// <summary>
        /// Save as File with current configuration.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void SaveAsFile_Click(object sender, EventArgs e)
        {
            Microsoft.Win32.SaveFileDialog dlg = new Microsoft.Win32.SaveFileDialog();
            dlg.Title = "Save As File";
            saveFileToolStripMenuItem.Enabled = false;
            SaveAsToolStripMenuItem.Enabled = false;
            _btnStop.Enabled = false;
            SaveFile(dlg, "SaveAs", 1000);
        }

        /// <summary>
        /// Show Help regarding Application
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void appHelpToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if ((Application.OpenForms["ISL29177_Help"] as ISL29177_Help) != null)
            {
                //Form is already open
                System.Windows.MessageBox.Show("App Help is already opened");
            }
            else
            {
                // Form is not open
                ISL29177_Help ISL29177_help = new ISL29177_Help();
                ISL29177_help.Show();
            }
        }

        /// <summary>
        /// Shows about the Intersil and Sensor
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void aboutUsToolStripMenuItem2_Click(object sender, EventArgs e)
        {
            if ((Application.OpenForms["AboutUs"] as AboutUs) != null)
            {
                //Form is already open
                System.Windows.MessageBox.Show("AboutUs Page is already opened");
            }
            else
            {
                // Form is not open
                AboutUs ISL29177_about = new AboutUs();
                ISL29177_about.Show();
            }
        }

        /// <summary>
        /// Exit for appliction.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void Exit_Click(object sender, EventArgs e)
        {
            System.Windows.Forms.Application.Exit();
        }

        /// <summary>
        /// Exit for appliction.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void _btnExit_Click(object sender, EventArgs e)
        {
            System.Windows.Forms.Application.Exit();
        }

        /// <summary>
        /// Setting the samples to the x-axis of graph.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void _cbAxisSample_SelectedIndexChanged(object sender, EventArgs e)
        {
            chart1.ChartAreas[0].AxisX.Maximum = Convert.ToInt16(_cbAxisSample.SelectedItem.ToString());
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
        /// Register 2 PROX BSCAT Write
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void _btnPROXBSCAT_Click(object sender, EventArgs e)
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

        private void _btnAdjustOffset_Click(object sender, EventArgs e)
        {
            pDrvAlgo.adjustOffset();            
        }

      
   
    }
}
