/*
 * 
 * File         :   Fileread.cs
 * 
 * Description  :   Writing the recorded samples in to the csv file.
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
    class File
    {
        /// <summary>
        /// required fields which we wants to write in file.
        /// </summary>
        public string RegisterNo { set; get; }
        public string Registervalue { set; get; }
        public string dateTFormt { set; get; }
        public string dateFormt { set; get; }
        Form frmmain;
        ComboBox _cbPROX_SLP;
        ///
        public File()
        {
           
        }

        /// <summary>
        /// Saving the path in text file in the case of Save As.
        /// </summary>
        /// <param name="path">path which we wants to save in text file</param>
        public void SavePath(string path)
        {
            StringBuilder builder = new StringBuilder();
            StringWriter sw = new StringWriter(builder);
            try
            {
                sw.WriteLine(path);
                using (StreamWriter writer = new StreamWriter("path.txt", false))
                {
                    writer.WriteLine(sw.ToString());
                }
            }
            catch(Exception ex)
            {
                System.Windows.MessageBox.Show(ex.Message.ToString());
            }
            finally
            {
                sw.Flush();
                sw.Close();
            }
        }

        /// <summary>
        /// Write register values in to the file.
        /// </summary>
        /// <param name="li">list with file type </param>
        /// <param name="path"></param>
        public void WriteFile(List<File> li,string path,int SampleCount)
        {
            StringBuilder builder = new StringBuilder();
            StringWriter sw = new StringWriter(builder);
            try
            {
                // Generate columns..
                sw.WriteLine("Register No,Register Value,Date,Time");

                for (int i = 0; i < SampleCount; i++)
                {
                    string RegNo = li[i].RegisterNo;
                    string RegValue = li[i].Registervalue;
                    string date = li[i].dateFormt;
                    string Time = li[i].dateTFormt;
                    // Write string..
                    sw.WriteLine(RegNo + "," + RegValue + "," + date + "," + Time);

                }
                using (StreamWriter writer = new StreamWriter(new FileStream(path, FileMode.Create, FileAccess.Write, FileShare.Read)))
                {
                    writer.WriteLine(sw.ToString());
                }
                li.Clear();
                sw.Flush();
                sw.Close();
            }
            catch (Exception ex)
            {
                System.Windows.MessageBox.Show(ex.Message.ToString());
            }
            finally
            {
                li.Clear();
                sw.Flush();
                sw.Close();
            }
        }
    }
    /// <summary>
    /// Class to fill the combo box with different parameter in display field and value field
    /// </summary>
    public class ComboboxItem
    {
        public string Text { get; set; }
        public object Value { get; set; }
        public ComboboxItem(string name, int value)
        {
            Text = name;
            Value = value;
        }
        public override string ToString()
        {
            return Text;
        }
    } 

}
