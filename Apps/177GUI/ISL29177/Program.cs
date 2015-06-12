/*
 * 
 * File         :   Program.cs
 * 
 * Description  :   For Sensor 29177
 * 
 * 
 * Author       :   vikashkumar.jangid@vvdntech.com
 *               
 * 
 * CopyRight    :   INTERSIL 2014
 * 
 */
using System;
using System.Collections.Generic;
using System.Linq;
using System.Windows.Forms;
using System.Diagnostics;

namespace ISL29177
{
    static class Program
    {
        /// <summary>
        /// The main entry point for the application.
        /// </summary>
        [STAThread]

        static void Main()
        {
            string RunningProcess = Process.GetCurrentProcess().ProcessName;
            Process[] processes = Process.GetProcessesByName(RunningProcess);
            if (processes.Length > 1)
            {
                MessageBox.Show("Application is already running" + processes[0].ProcessName, "Stop", MessageBoxButtons.OK, MessageBoxIcon.Error); // @@ check on this
                Application.Exit();
                Application.ExitThread();
               
            }
            else {
                Application.EnableVisualStyles();
                Application.SetCompatibleTextRenderingDefault(false);
                Application.Run(new StartUpForm());
            }
        }
    }
}
