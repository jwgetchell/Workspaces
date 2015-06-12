using System;
using System.Windows.Controls;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using IntersilLib;
using System.Windows.Forms;
using Inersil_WPFV2.Repository;


namespace ISL29177
{
    public partial class StartUpForm : Form
    {
        public StartUpForm()
        {
            InitializeComponent();
        }

        private void _btnConnect_Click(object sender, EventArgs e)
        {
            try
            {
                //searching the device or sensor.
                if (DeviceUtil.SearchDevice())
                {
                    GlobalVariables.Default_Slave_Address = HIDDevInfo.I2C_Slave_Address = 0x88;
                    if (GlobalVariables.MyDeviceDetected && cb_Devices.SelectedItem !=null)
                    {

                        if ((Application.OpenForms["MainScreen"] as MainScreen) != null)
                        {
                            //Form is already open
                            System.Windows.MessageBox.Show("Application is Already is running.");
                        }
                        else
                        {
                            // Form is not open
                            MainScreen MS = new MainScreen();
                            this.Hide();
                            MS.Show();
                        }
                    }
                }
            }
            catch (Exception ex)
            { 
            
            }
        }

        private void _btnCancel_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
