using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.IO;
using System.Reflection;

namespace ISL29177
{
    public partial class ISL29177_Help : Form
    {
        public ISL29177_Help()
        {
            InitializeComponent();
           // axAcroPDF1.src = "C:\\Users\\vikash\\Downloads\\G2M_U.S._v6.2.1_b1350_MSI.pdf";
           // string path = Path.Combine(GetAppFolder(), @"help_ISL29177.html");
           // webBrowser1.Navigate(path);
        }

        /// <summary>
        /// Getting the current path library
        /// </summary>
        /// <returns></returns>
        private static string GetAppFolder()
        {
            return new FileInfo(Assembly.GetExecutingAssembly().Location).Directory.FullName;
        }

        /// <summary>
        /// Open App Manual as pdf
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void _lnkManual_Click(object sender, EventArgs e)
        {
            string path = Path.Combine(GetAppFolder(), @"VVDN_ISLU_SNSR_USER_MANUAL1.0.0.2.pdf");
            System.Diagnostics.Process.Start(path);
        }

    }
}
