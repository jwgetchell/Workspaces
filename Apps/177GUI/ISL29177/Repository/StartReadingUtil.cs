
using IntersilLib;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Threading;
using System.Windows.Controls;
using System.Xml.Serialization;

namespace Inersil_WPFV2.Repository
{

    class StartReadingUtil
    {

        static Int16 sampleCnt = 0;
        public static Int16 status = Status.I2C_SUCCESS;
        static Int16 loopCnt = -1;
        public static CurrentReading objCurrentVal = new CurrentReading();
        internal static void ResetReadings()
        {
          
        }

        public static void WriteRegOnStart()
        {
          for (int i = 0; i <=15; i++)
              HIDClass.ReadSingleRegister(0, 1, (byte)i);
        }

    }


 
}
