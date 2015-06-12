using IntersilLib;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Windows;
using System.Xml.Serialization;
using System.Windows.Markup;

namespace Inersil_WPFV2.Repository
{
    class CommonUtility
    {
        public static Dictionary<Int32, string> _ErrorMsgDic = new Dictionary<Int32, string>();

        static CommonUtility()
        {
            _ErrorMsgDic.Add(Status.USB_WRITE_ERROR, "USB write error occured.");
            _ErrorMsgDic.Add(Status.USB_Read_Error, "USB read error occured.");
            _ErrorMsgDic.Add(Status.GP_Fail, "USB  error occured.");
            _ErrorMsgDic.Add(Status.I2C_Nack_Error, "USB  error occured.");
          
        }
        public static void ShowMsgBox(string message, string caption, MessageBoxImage icon, MessageBoxButton buttons)
        {
         //   MessageBox.Show(message, caption, buttons, icon);
        }
       
     
    }

    class LogInfo
    {
        public string Filepath { get; set; }
        public string DateFormat { get; set; }
        public string DateTFormat { get; set; }
        public string Ext { get; set; }
    }



}
