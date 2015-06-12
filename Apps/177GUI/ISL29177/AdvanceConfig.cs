/**********************************************************************
 Module     : Register Mode
 Created On : 6-Jun-2014      
 Class file : AdvanceConfig.cs
 This class provides :
 1) It is Register Mode in which Customer can read and write each register.
 
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
namespace ISL29177
{
    public partial class AdvanceConfig : Form
    {
        //Constructor for AdvaanceConfig form
        public AdvanceConfig()
        {
            InitializeComponent();
            //If Engi mode is enable then it will show register A to F. 
             bool RetStatus = GlobalVariables.ckeckEnggiMode();
             if (RetStatus)
             {
                 _gbMore.Visible = true;
             }
             else
             {
                 _gbMore.Visible = false;
             }
        }
        
        /// <summary>
        /// Register 6 Collapse Expand.  
        /// </summary>
        private void ExpandCollapse()
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
        /// Load fuction in form that creates textBoxes,buttons at runtime.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void AdvanceConfig_Load(object sender, EventArgs e)
        {
            //Craeting TextBox and Buttons Dynamically.
            createReadTextBox();
            createWriteTextBox();
            createReadButton();
            createWriteButton();
        }
        
        /// <summary>
        /// For creating Dynamic textBox for Read Register
        /// </summary>
        public void createReadTextBox()
        {

            for (int i = 0; i <= 15; i++)
            {
                TextBox MyTextBox = new TextBox();
                //0 to 9 register are in groupBox _gbAdvanceConfig
                if (i <= 9)
                {
                    //Assigning the textbox ID name 
                    MyTextBox.Name = "Txtread0X0_" + i;
                    MyTextBox.Width = 85;
                    MyTextBox.Height = 15;
                    MyTextBox.Location = new Point(130, 70 + (33 * i));
                    MyTextBox.Text = "";
                    MyTextBox.ReadOnly = true;
                    _gbAdvanceConfig.Controls.Add(MyTextBox);
                }
                //Other register are in groupBox _gbRegister6
                else
                {
                    TextBox MyTextBox1 = new TextBox();
                    MyTextBox1.Name = "Txtread0X0_" + i;
                    MyTextBox1.Width = 85;
                    MyTextBox1.Height = 15;
                    MyTextBox1.Location = new Point(100, (33 * i) - 310);
                    MyTextBox1.Text = "";
                    MyTextBox1.Font = new Font("Arial", 8.8f);
                    MyTextBox1.ReadOnly = true;
                    _gbRegister6.Controls.Add(MyTextBox1);

                }
            }
        }
        
        /// <summary>
        /// For creating Dynamic textBox for Write Register
        /// </summary>
        public void createWriteTextBox()
        {
            for (int i = 1; i <= 15; i++)
            {
              //0 to 9 register are in groupBox _gbAdvanceConfig
                if (i <= 9)
                {
                    //Register 6 is read only.
                    if (i != 6 && i!=7 && i!=8)
                    {
                        TextBox MyTextBox = new TextBox();
                        //Assigning the textbox ID name
                        MyTextBox.Name = "Txtwrite0X0_" + i;
                        MyTextBox.Width = 85;
                        MyTextBox.Height = 15;
                        MyTextBox.Location = new Point(380, 70 + (33 * i));
                        MyTextBox.Text = "0";
                        _gbAdvanceConfig.Controls.Add(MyTextBox);
                        
                    }
                }
                // other register are in groupBox _gbRegister6
                else
                {
                    if (i !=10)
                    {
                        TextBox MyTextBox1 = new TextBox();
                        MyTextBox1.Name = "Txtwrite0X0_" + i;
                        MyTextBox1.Width = 85;
                        MyTextBox1.Height = 15;
                        MyTextBox1.Location = new Point(350, (33 * i) - 310);
                        MyTextBox1.Text = "0";
                        MyTextBox1.Font = new Font("Arial", 8.8f);
                        _gbRegister6.Controls.Add(MyTextBox1);
                    }
                }
            }
        }
        
        /// <summary>
        /// For creating Dynamic Button for Read Register
        /// </summary>
        public void createReadButton()
        {
            for (int i = 0; i <= 15; i++)
            {
                //0 to 9 register are in groupBox _gbAdvanceConfig
                if (i <= 9)
                {
                    Button MyButton = new Button();
                    //Assigning the Button ID name
                    MyButton.Name = "Btnread0X0_" + i;
                    MyButton.Width = 87;
                    MyButton.Height = 25;
                    MyButton.Location = new Point(250, 70 + (33 * i));
                    MyButton.Text = "Read";
                    MyButton.Click += new EventHandler(ReadSingleRegister_click);
                    _gbAdvanceConfig.Controls.Add(MyButton);
                    MyButton.Font = new Font("Arial", 8.5f);
                    MyButton.BackColor = System.Drawing.Color.FromArgb(89, 170, 250);
                    MyButton.ForeColor = Color.White;
                }
                //Other register are in groupBox _gbRegister6
                else
                {
                    Button MyButton1 = new Button();
                    //Assigning the Button ID name
                    MyButton1.Name = "Btnread0X0_" + i;
                    MyButton1.Width = 87;
                    MyButton1.Height = 25;
                    MyButton1.Location = new Point(220, (33 * i) - 310);
                    MyButton1.Text = "Read";
                    MyButton1.Font = new Font("Arial", 8.5f);
                    MyButton1.BackColor = System.Drawing.Color.FromArgb(89, 170, 250);
                    MyButton1.ForeColor = Color.White;
                    MyButton1.Click += new EventHandler(ReadSingleRegister_click);
                    _gbRegister6.Controls.Add(MyButton1);

                }
            }
        }
        
        /// <summary>
        ///For creating Dynamic Button for Write Register 
        /// </summary>
        public void createWriteButton()
        {
            for (int i = 1; i <= 15; i++)
            {
                Button MyButton = new Button();
                //reguister1 and Register6 is read only.
                if (i <= 9 && i !=6 && i!=7 && i!=8)
                {
                    //Assigning the textbox ID name 
                    MyButton.Name = "Btnwrite0X0_" + i;
                    MyButton.Width = 87;
                    MyButton.Height = 25;
                    MyButton.Location = new Point(500, 70 + (33 * i));
                    MyButton.Text = "Write";
                    MyButton.Font = new Font("Arial", 8.5f);
                    MyButton.BackColor = System.Drawing.Color.FromArgb(89, 170, 250);
                    MyButton.ForeColor = Color.White;
                    MyButton.Click += new EventHandler(WriteSingleRegister_click);
                    _gbAdvanceConfig.Controls.Add(MyButton);                    
                }
                //Next TextBoxes are in other panel.
                else if (i != 10)
                {
                    Button MyButton1 = new Button();
                    MyButton1.Name = "Btnwrite0X0_" + i;
                    MyButton1.Width = 87;
                    MyButton1.Height = 25;
                    MyButton1.Location = new Point(470, (33 * i) - 310);
                    MyButton1.Text = "Write";
                    MyButton1.Font = new Font("Arial", 8.5f);
                    MyButton1.BackColor = System.Drawing.Color.FromArgb(89, 170, 250);
                    MyButton1.ForeColor = Color.White;
                    MyButton1.Click += new EventHandler(WriteSingleRegister_click);
                    _gbRegister6.Controls.Add(MyButton1);

                }
            }
        }
        
        /// <summary>
        /// created a common event For Reading a single register value at a time.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        public void ReadSingleRegister_click(object sender, EventArgs e)
        {
            Button btn = sender as Button;
            string[] ID = btn.Name.Split('_');
            //Getting the last index for ID.
            //Function for passing vaues for Reading from Sensor.
            Int16 status = HIDClass.ReadSingleRegister((byte)0, 1, (byte)Convert.ToInt16(ID[1]));
         //   MessageBox.Show(GlobalVariables.WriteRegs[Convert.ToInt16(ID[1])].ToString());
            if (status == 8)
            {
                //0 to 9 register are in groupBox _gbAdvanceConfig
                if (Convert.ToInt16(ID[1]) < 10)
                {
                    TextBox tb = (TextBox)_gbAdvanceConfig.Controls["Txtread0X0_" + Convert.ToInt16(ID[1])];
                    tb.Text = "0X" + GlobalVariables.WriteRegs[Convert.ToInt16(ID[1])].ToString("X2");
                   
                }
                //Other register are in groupBox _gbRegister6.
                else
                {
                    //i==14:==> Register 0x0E has a process which we have to follow to read and write from sensor.
                    //First: Write Register 0x09 with value 89h to Enable test mode.
                    //Second:Write Register 0x0F with value 0x40 to enabled Fuse bit Emulation Mode.
                    //Now we can read and write register 0xE.
                    if (Convert.ToInt16(ID[1]) == 14)
                    {
                        Int16 status1 = HIDClass.WriteSingleRegister((byte)137, 1, (byte)9);
                        status1 = HIDClass.ReadSingleRegister((byte)0, 1, (byte)9);
                        Int16 status2 = HIDClass.WriteSingleRegister((byte)64, 1, (byte)15);
                        status2 = HIDClass.ReadSingleRegister((byte)0, 1, (byte)15);
                        status = HIDClass.ReadSingleRegister(32, 1, (byte)Convert.ToInt16(ID[1]));
                        TextBox tb1 = (TextBox)_gbRegister6.Controls["Txtread0X0_" + Convert.ToInt16(ID[1])];
                        tb1.Text = "0X" + GlobalVariables.WriteRegs[Convert.ToInt16(ID[1])].ToString("X2");
                    }
                    else
                    {
                        TextBox tb1 = (TextBox)_gbRegister6.Controls["Txtread0X0_" + Convert.ToInt16(ID[1])];
                        tb1.Text = "0X" + GlobalVariables.WriteRegs[Convert.ToInt16(ID[1])].ToString("X2");
                    }
                }
            }
        }
        
        /// <summary>
        /// created a common event For Writing a single register value at a time.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        public void WriteSingleRegister_click(object sender, EventArgs e)
        {
            Button btn = sender as Button;
            string[] ID = btn.Name.Split('_');
            //Getting the last index for ID.
          
            int i = Convert.ToInt16(ID[1]);
            if (i != 6 && i!=7 && i!=8 && i!=10)
            {
                //0 to 9 register are in groupBox _gbAdvanceConfig
                if (i < 10)
                {
                    TextBox tbWrite = (TextBox)_gbAdvanceConfig.Controls["Txtwrite0X0_" + i];
                    TextBox tbRead = (TextBox)_gbAdvanceConfig.Controls["Txtread0X0_" + i];

                    //Function for passing vaues for Writing from Sensor.
                    int value = Convert.ToInt32(tbWrite.Text, 16);

                    if (value >= 0 && value <= 255)
                    {
                        Int16 status = HIDClass.WriteSingleRegister((byte)Convert.ToInt32(value), 1, (byte)i);
                        
                    }
                }
                //other register are in groupBox _gbRegister6
                else
                {

                    TextBox tbWrite1 = (TextBox)_gbRegister6.Controls["Txtwrite0X0_" + i];
                    TextBox tbRead1 = (TextBox)_gbRegister6.Controls["Txtread0X0_" + i];
                    int value = Convert.ToInt32(tbWrite1.Text, 16);

                    if (value >= 0 && value <= 255)
                    {
                        //i==14:==> Register 0x0E has a process which we have to follow to read and write from sensor.
                        //First: Write Register 0x09 with value 89h to Enable test mode.
                        //Second:Write Register 0x0F with value 0x40 to enabled Fuse bit Emulation Mode.
                        //Now we can read and write register 0xE.
                        if (Convert.ToInt16(ID[1]) == 14)
                        {
                            Int16 status1 = HIDClass.WriteSingleRegister((byte)137, 1, (byte)9);
                            status1 = HIDClass.ReadSingleRegister((byte)0, 1, (byte)9);
                            Int16 status2 = HIDClass.WriteSingleRegister((byte)64, 1, (byte)15);
                            status2 = HIDClass.ReadSingleRegister((byte)0, 1, (byte)15);

                            //Function for passing vaues for Writing from Sensor.
                            Int16 status = HIDClass.WriteSingleRegister((byte)value, 1, (byte)i);
                        }
                        else
                        {
                            //Function for passing vaues for Writing to Sensor.
                            Int16 status = HIDClass.WriteSingleRegister((byte)value, 1, (byte)i);
                        }
                    }
                }

            }
               
        }
        /// <summary>
        /// Function For Reading all registers value at a time.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void _btnReadAll_Click(object sender, EventArgs e)
        {
            for (int i = 0; i <= 15; i++)
            {
                //Reading a single register at a time.
                Int16 status = HIDClass.ReadSingleRegister((byte)0, 1, (byte)i);
                if (status == 8)
                {
                    if (i < 10)
                    {
                        TextBox tb = (TextBox)_gbAdvanceConfig.Controls["Txtread0X0_" + i];
                        tb.Text ="0X"+ GlobalVariables.WriteRegs[i].ToString("X2");
                    }
                    else
                    {
                        //i==14:==> Register 0x0E has a process which we have to follow to read and write from sensor.
                        //First: Write Register 0x09 with value 89h to Enable test mode.
                        //Second:Write Register 0x0F with value 0x40 to enabled Fuse bit Emulation Mode.
                        //Now we can read and write register 0xE.
                        if (i == 14)
                        {
                            Int16 status1 = HIDClass.WriteSingleRegister((byte)137, 1, (byte)9);
                            status1 = HIDClass.ReadSingleRegister((byte)0, 1, (byte)9);
                            Int16 status2 = HIDClass.WriteSingleRegister((byte)64, 1, (byte)15);
                            status2 = HIDClass.ReadSingleRegister((byte)0, 1, (byte)15);
                            status = HIDClass.ReadSingleRegister(32, 1, (byte)i);
                            TextBox tb1 = (TextBox)_gbRegister6.Controls["Txtread0X0_" + i];
                            tb1.Text = "0X" + GlobalVariables.WriteRegs[i].ToString("X2");
                        }
                        else
                        {
                            TextBox tb1 = (TextBox)_gbRegister6.Controls["Txtread0X0_" + i];
                            tb1.Text = "0X" + GlobalVariables.WriteRegs[i].ToString("X2");
                        }
                    }
                }
            }
        }
        
        /// <summary>
        ////Function For Writing all registers value at a time.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void _btnWriteAll_Click(object sender, EventArgs e)
        {
            //register 00X0 read only.
            for (int i = 1; i <= 15; i++)
            {
                //register 00X6 read only.
                if (i != 6 && i != 7 && i != 8 && i != 10)
                {
                    if (i < 10)
                    {
                        TextBox tbWrite = (TextBox)_gbAdvanceConfig.Controls["Txtwrite0X0_" + i];
                        TextBox tbRead = (TextBox)_gbAdvanceConfig.Controls["Txtread0X0_" + i];
                        Int16 status = HIDClass.WriteSingleRegister((byte)Convert.ToInt16(tbWrite.Text), 1, (byte)i);
                        if (status == 8)
                        {
                             tbRead.Text = GlobalVariables.WriteRegs[i].ToString("X2"); 
                        }
                    }

                    else
                    {
                        //i==14:==> Register 0x0E has a process which we have to follow to read and write from sensor.
                        //First: Write Register 0x09 with value 89h to Enable test mode.
                        //Second:Write Register 0x0F with value 0x40 to enabled Fuse bit Emulation Mode.
                        //Now we can read and write register 0xE.
                        if (i == 14)
                        {
                            Int16 status1 = HIDClass.WriteSingleRegister((byte)137, 1, (byte)9);
                            status1 = HIDClass.ReadSingleRegister((byte)0, 1, (byte)9);
                            Int16 status2 = HIDClass.WriteSingleRegister((byte)64, 1, (byte)15);
                            status2 = HIDClass.ReadSingleRegister((byte)0, 1, (byte)15);
                            Int16 Readstatus = HIDClass.ReadSingleRegister(32, 1, (byte)i);
                            TextBox tb1 = (TextBox)_gbRegister6.Controls["Txtread0X0_" + i];
                            tb1.Text = "0X" + GlobalVariables.WriteRegs[i].ToString("X2");
                        }
                        else
                        {
                            TextBox tb1 = (TextBox)_gbRegister6.Controls["Txtread0X0_" + i];
                            tb1.Text = "0X" + GlobalVariables.WriteRegs[i].ToString("X2");
                        }
                    }
                   
                }
               
            }
        }

        /// <summary>
        /// To explore-Collapse the panel or groupBox
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
       private void _lblMore_Click(object sender, EventArgs e)
        {
            ExpandCollapse();
        }
      
        /// <summary>
        /// To explore-Collapse the panel or groupBox
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
       private void _PCExpand_Click(object sender, EventArgs e)
       {
           ExpandCollapse();
       }

        /// <summary>
        /// To close the current Form.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
       private void _btnBack_Click(object sender, EventArgs e)
       {
           this.Close();
       }

       

       

    
       

       
    }
}
