
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

        public static Int64 Max_Collected_Reading = -99999, Min_Collected_Reading = 99999, sample_25;
        static Int16 sampleCnt = 0;
        public static Int16 status = Status.I2C_SUCCESS;
        static Int16 loopCnt = -1;
        public static CurrentReading objCurrentVal = new CurrentReading();
        public static ReadingLog oLog = new ReadingLog();
        public static List<ReadingLog_new> list = new List<ReadingLog_new>();

        internal static void ResetReadings()
        {
            Max_Collected_Reading = -9999999;
            Min_Collected_Reading = 9999999;

        }

        public static void WriteRegOnStart()
        {
            for (int i = 1; i >= 0; i--)
                HIDClass.WriteRegister(GlobalVariables.TxtRegHex[i], 1, (byte)i);
            //If device is in Power Down moad then Set it as ALS Continous Mode
            //if (GlobalVariables.WriteRegs[0] <= 0x1F)
            //{

            //    HIDClass.SetDevOpMode(OperateMode.ALSCont);
            //    HIDClass.SetDevOpMode(OperateMode.ALSCont);
            //    loopCnt = -1;
            //}

        }

        public static void GetCurrentReading(bool isPoll)
        {
            //if (GlobalVariables.Prox_IR == false)
            {
                if (GlobalVariables.Read_Once)
                {

                    HIDClass.WriteRegister(GlobalVariables.TxtRegHex[0], 1, 0);
                    Thread.Sleep(8);
                }

                HIDClass.GetALSCurrRead(out status, objCurrentVal, isPoll);
                if (status == Status.I2C_SUCCESS)
                {
                    if (loopCnt < 50)
                    {
                        loopCnt += 1;
                        //oLog.reading[oLog.loopCnt] = objCurrentVal.LuxValue;
                        //oLog.readTime[oLog.loopCnt] = DateTime.Now;
                        list.Add(new ReadingLog_new { SNo = loopCnt, Reading = objCurrentVal.LuxValue, ReadTime = DateTime.Now.ToString(ConfigurationManager.AppSettings["dateTFormt"]) });

                    }
                    else
                    {
                        list[loopCnt] = new ReadingLog_new { SNo = loopCnt, Reading = objCurrentVal.LuxValue, ReadTime = DateTime.Now.ToString(ConfigurationManager.AppSettings["dateTFormt"]) };
                    }


                    UpdatePeakMeasure(objCurrentVal.ADCReading);
                }
            }
        }

        public void cmdSampleInterrupt_Click()
        {

            //frmMain.getGPvalue;
            //PortBData = (PortBData & 0x1);

            //if (PortBData == 1)
            //{
            //    ShpINTexternal.BackColor = Microsoft.VisualBasic.Information.QBColor(qbBlack);
            //    Interrupt_Active = false;
            //}
            //else
            //{
            //    ShpINTexternal.BackColor = Microsoft.VisualBasic.Information.QBColor(qbRed);
            //    Interrupt_Active = true;
            //}


        }

        public static void UpdatePeakMeasure(Int64 adReading)
        {
            Max_Collected_Reading = (Max_Collected_Reading < adReading) ? adReading : Max_Collected_Reading;
            Min_Collected_Reading = (Min_Collected_Reading > adReading) ? adReading : Min_Collected_Reading;
            sampleCnt += 1;
            if (sampleCnt > 25)
            {
                sampleCnt = 0;
                sample_25 = adReading;
            }
        }




    }


    internal class ReadingLog
    {
        internal Int16 loopCnt = -1;
        internal decimal[] reading = new decimal[1101];
        internal DateTime[] readTime = new DateTime[1101];
    }


    [XmlType(TypeName = "LuxValue")]

    public class ReadingLog_new
    {
        [XmlElement("Reading_No")]
        public Int16 SNo { get; set; }
        [XmlElement("Reading_Value")]
        public decimal Reading { get; set; }
        [XmlElement("Reading_Time")]
        public string ReadTime { get; set; }
    }

    //[Serializable()]
    //public class XMLData
    //{
    //    public Int16 SNo { get; set; }
    //    public decimal Reading { get; set; }
    //    public string ReadTime { get; set; }
    //}
}
