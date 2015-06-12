using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;

namespace ISL29177
{
    class File
    {
        public string RegisterNo { set; get; }
        public string Registervalue { set; get; }
        public string dateTFormt { set; get; }
        public string dateFormt { set; get; }
        public void SavePath(string path)
        {
            StringBuilder builder = new StringBuilder();
            StringWriter sw = new StringWriter(builder);
            sw.WriteLine(path);
            using (StreamWriter writer = new StreamWriter("path.txt", false))
            {
                writer.WriteLine(sw.ToString());
            }
        }
        public void WriteFile(List<File> li,string path)
        {
            StringBuilder builder = new StringBuilder();
            StringWriter sw = new StringWriter(builder);
            // Generate columns..
            sw.WriteLine("Register No,Register Value,Date,Time");

            for (int i = 0; i < li.Count; i++)
            {
                string RegNo = li[i].RegisterNo;
                string RegValue = li[i].Registervalue;
                string date = li[i].dateFormt;
                string Time = li[i].dateTFormt;
                // Write string..
                sw.WriteLine(RegNo + "," + RegValue + "," + date + "," + Time);

            }
            using (StreamWriter writer = new StreamWriter(path, false))
            {
                writer.WriteLine(sw.ToString());
            }
            sw.Close();
        }
    }
}
