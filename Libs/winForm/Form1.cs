using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
//using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace winForm
{
    public partial class Form1 : Form
    {
        enum cbCMD
        {
            W,R,WW,RW,WA,RA
        }

        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            int data=0;
            ucALSusb1.setI2cAddr(0x88);
            //ucALSusb1.dSetDevice(13);

            data=ucALSusb1.readByte(0x0);

            if (data != 0x7d)
                System.Windows.Forms.MessageBox.Show("Wrong Config Value");
            else
            {
                ucALSusb1.writeByte( 0x1,0x5);
            }
        }

        private void button2_Click(object sender, EventArgs e)
        {
            int data = ucALSusb1.readWord(0x09);
            label1.Text = data.ToString();
        }

        private void Form1_Load(object sender, EventArgs e)
        {

        }
    }
}
