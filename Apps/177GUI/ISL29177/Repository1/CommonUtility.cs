using IntersilLib;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Windows;
using System.Xml.Serialization;

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
            MessageBox.Show(message, caption, buttons, icon);
        }
        public static void StartTimer(ref bool isTimerRunning, int flag)
        {

            if (flag == 1)
            {
              //  if (ISL29177.timer.IsEnabled)
                //{
                  //  ISL29177.timer.IsEnabled = false;
                    //ISL29177.timer.IsEnabled = false;
                  //  isTimerRunning = true;
                   // return;
                //}
            }
            else
            {
                if (isTimerRunning)
                {
             //       ISL29177.timer.Interval = new TimeSpan(00, 00, 00, 00, GlobalVariables.Prox_IR_ITime);
               //     ISL29177.timer.Start();
                }
            }
        }
        #region Log Writing
        /// <summary>
        /// Write the log to the file 
        /// </summary>
        /// <param name="oInfo">Information about the log writing 
        /// E.g : file name,
        ///       date format,
        ///       time format
        /// <param name="oLog">Provides the data to be written to the file</param>
        public static void WriteCSV(LogInfo oInfo, ReadingLog oLog)
        {
            string s1 = "Collect Reg0 : &", sep = ",";
            using (var stream = File.Create(oInfo.Filepath)) { }
            using (var wr = new StreamWriter(oInfo.Filepath, true))
            {
                var sb = new StringBuilder();
                sb.Append(s1);
                sb.Append(GlobalVariables.TxtRegHex[0].ToString("X4") + " : Reg1 : &" + GlobalVariables.TxtRegHex[0].ToString("X4"));
                sb.Append(string.Concat(sep, "Interval : ", GlobalVariables.Prox_IR_ITime));
                sb.Append(string.Concat(sep, "Date : ", DateTime.Now.Date.ToString(oInfo.DateFormat)));
                sb.Append(string.Concat(sep, "Time : ", DateTime.Now.ToString(oInfo.DateTFormat)));
                sb.Append(string.Concat(sep, "Qty : ", (StartReadingUtil.oLog.loopCnt - 10)));
                wr.WriteLine(sb.ToString());
                for (int i = 11; i <= oLog.loopCnt; i++)
                {
                    sb.Clear();
                    sb.Append(string.Concat((i - 11), sep, oLog.reading[i], sep, oLog.readTime[i].ToString(oInfo.DateTFormat)));
                    wr.WriteLine(sb.ToString());
                }

            }


        }

        /*This provides the absttraction to the user for saving to the file*/
        /// <summary>
        /// Write the given data to the file 
        /// </summary>
        /// <typeparam name="T">Generic type</typeparam>
        /// <param name="items">collection of the data</param>
        /// <param name="oInfo">information for writing to the file</param>
        public static void WriteToFile<T>(IEnumerable<T> items, LogInfo oInfo)
        {
            try
            {
                if (items.Count() > 0)
                {
                    if (items.Count() < 20)
                        throw new InSuffiDataEx();
                    if (oInfo.Ext == ".txt")
                    {
                        WriteCSV(items, oInfo, true);
                    }
                    else if (oInfo.Ext == ".xml")
                    {
                        WriteXML(items, oInfo);
                    }
                }
                else
                {
                    throw new NoDataAvailEx();
                }
            }
            catch (NoDataAvailEx ex)
            {
                throw ex;
            }
            catch (InSuffiDataEx ex)
            {
                throw ex;
            }

            catch (Exception ex)
            {
                throw ex;
            }

        }

        /// <summary>
        /// Generic function to Write the object of the list to the file
        /// </summary>
        /// <typeparam name="T">Type of the list</typeparam>
        /// <param name="items">List of the objects</param>
        /// <param name="oInfo">Information about the log writing 
        /// E.g : file name,
        ///       date format,
        ///       time format
        /// 
        /// </param>
        static void WriteCSV<T>(IEnumerable<T> items, LogInfo oInfo, bool showHeader)
        {
            Type itemType = typeof(T);
            var props = itemType.GetProperties();
            var props1 = itemType.GetProperties(BindingFlags.Public | BindingFlags.Instance);// .OrderBy(p => p.Name);
            using (var stream = File.Create(oInfo.Filepath)) { }
            using (var writer = new StreamWriter(oInfo.Filepath))
            {
                string s1 = "Collect Reg0 : &", sep = ",";
                var sb = new StringBuilder();
                sb.Append(s1);
                sb.Append(GlobalVariables.TxtRegHex[0].ToString("X4") + " : Reg1 : &" + GlobalVariables.TxtRegHex[0].ToString("X4"));
                sb.Append(string.Concat(sep, "Interval : ", GlobalVariables.Prox_IR_ITime));
                sb.Append(string.Concat(sep, "Date : ", DateTime.Now.Date.ToString(oInfo.DateFormat)));
                sb.Append(string.Concat(sep, "Time : ", DateTime.Now.ToString(oInfo.DateTFormat)));
                sb.Append(string.Concat(sep, "Qty : ", (StartReadingUtil.oLog.loopCnt - 10)));
                writer.WriteLine(sb.ToString());
                if (showHeader)
                {
                    writer.WriteLine(string.Join(", ", props.Select(p => p.Name)));
                }
                foreach (var item in items)
                {
                    writer.WriteLine(string.Join(", ", props.Select(p => p.GetValue(item, null))));
                }
            }
        }


        /// <summary>
        /// Generic function to Write the object of the list to the file
        /// </summary>
        /// <typeparam name="T">Type of the list</typeparam>
        /// <param name="items">List of the objects</param>
        /// <param name="oInfo">Information about the log writing 
        /// E.g : file name,
        ///       date format,
        ///       time format
        /// 
        /// </param>
        static void WriteXML<T>(IEnumerable<T> items, LogInfo oInfo)
        {
            Type itemType = typeof(T);
            var props = itemType.GetProperties();
            var props1 = itemType.GetProperties(BindingFlags.Public | BindingFlags.Instance);// .OrderBy(p => p.Name);
            using (var stream = File.Create(oInfo.Filepath)) { }
            XmlSerializer writer = new XmlSerializer(typeof(T));
            XmlSerializerNamespaces ns = new XmlSerializerNamespaces();
            ns.Add("", "");
            using (FileStream file = File.OpenWrite(oInfo.Filepath))
            {
                foreach (var item in items)
                {
                    writer.Serialize(file, item, ns);
                }
            }
        }
        #endregion
    }

    class LogInfo
    {
        public string Filepath { get; set; }
        public string DateFormat { get; set; }
        public string DateTFormat { get; set; }
        public string Ext { get; set; }
    }



}
