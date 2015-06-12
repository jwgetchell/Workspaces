/**********************************************************************
 Module     : Repository
 Created On : 1-sep-2013      
 Class file : DeviceUtil.cs
 This class provides :
 1) The methods to communicate with the device
 2) Work as a middle layer between APPLication and harware
 
 **************************************************************************/


using IntersilLib;
using System;
using System.Windows;
using System.Windows.Controls;

namespace Inersil_WPFV2.Repository
{
    /// <summary>
    /// This class works as an interface between application and harware.
    /// </summary>
    class DeviceUtil
    {
        /// <summary>
        /// Check device is connected or not
        /// </summary>
        /// <returns></returns>
        public static HIDStatus CheckDeviceStatus()
        {
            return HIDClass.CheckHIDConnStatus();
        }

        /// <summary>
        /// Search for the HID device.
        /// </summary>
        /// <returns>return true if HID device is detected</returns>
        public static bool SearchDevice()
        {
            HIDStatus hidStatus = DeviceUtil.Connect();
            //if device is not fount show the retry message box
            if (hidStatus == HIDStatus.Disconnect)
            {
                return ShowRetryMsgBox();
            }
            else
                return true;
        }

        /// <summary>
        /// This function read the register for the interrupt limits value
        /// </summary>
        /// <returns>IntrScale type </returns>
        public static IntrScale ReadIntrScale(ref Int16 status)
        {
            IntrScale oScale = new IntrScale();
            HIDDeviceIO oHID = new HIDDeviceIO();
            //Read the register 4 times
            HIDRegRead oHIDRegRead = new HIDRegRead(HIDDevInfo.I2C_Slave_Address, 1, 1, HIDDevInfo.EventObject, HIDDevInfo.HIDOverlapped);
            for (byte i = 4; i <= 7; i++)
            {
                oHIDRegRead.StartRegRD = i;
                status = oHID.ReadRegister(oHIDRegRead);
                if (status != Status.I2C_SUCCESS)
                    break;
            }
            if (status == Status.I2C_SUCCESS)
            {
                //No=MSB+LSB 
                oScale.LowerLimit = ((oHIDRegRead.RegRdBuffer[5] * 256) + oHIDRegRead.RegRdBuffer[4]).ToString();
                oScale.HighLimit = ((oHIDRegRead.RegRdBuffer[7] * 256) + oHIDRegRead.RegRdBuffer[6]).ToString();
            }
            return oScale;

        }

        /// <summary>
        /// Configure the register for interrupt limits
        /// </summary>
        /// <param name="adBits"></param>
        /// <param name="lowLimit"></param>
        /// <param name="highLimit"></param>
        /// <returns></returns>
        public static Int16 SetIntrLimits(ADBitsRange convertor, int lowLimit, int highLimit, out string hexLow, out string hexHigh)
        {
            try
            {
                int opIXOR = 0, signBit = 0;
                //0-->LSB of lowLimit , 1-->MSB of lowLimit
                //2-->LSB of highLimit, 3-->MSB of highLimit
                byte[] byteAr = new byte[4];

                #region Set signBit
                if (convertor == ADBitsRange.ADBits_16)
                {
                    opIXOR = 0xFFFF;
                    signBit = 65535;
                }
                if (convertor == ADBitsRange.ADBits_12)
                {
                    opIXOR = 0xFFF;
                    signBit = 2048;
                }

                if (convertor == ADBitsRange.ADBits_8)
                {
                    opIXOR = 0xFF;
                    signBit = 128;
                }


                if (convertor == ADBitsRange.ADBits_4)
                {
                    opIXOR = 0xF;
                    signBit = 16;
                }
                #endregion

                #region Find MSB and LSB for lower limit
                if (lowLimit >= 0)
                {
                    byteAr[0] = (byte)(lowLimit & 0xFF);
                    byteAr[1] = (byte)(lowLimit / 256);
                    //lowlimitMSB = (int)(lowLimit / 256);// MSB
                    //lowlimitLSB = lowLimit & 0xFF; //LSB
                }
                else
                {
                    byteAr[0] = (byte)Math.Abs(lowLimit);
                    byteAr[0] = (byte)(opIXOR - byteAr[0] + 1);
                    byteAr[1] = (byte)(byteAr[0] / 256);// ' msb
                    byteAr[0] = (byte)(byteAr[0] & 0xFF);
                    byteAr[1] = (byte)(byteAr[1] & 0xFF);
                    if (signBit == 2048)
                    {
                        byteAr[1] = (byte)(byteAr[1] | 0xF0);
                    }
                    if (signBit == 128 || signBit == 16)
                    {
                        byteAr[1] = (byte)(byteAr[1] | 0xFF);
                    }
                    if (signBit == 16)
                    {
                        byteAr[0] = (byte)(byteAr[0] | 0xF0);
                    }

                }
                #endregion

                #region Find MSB and LSB for higher limit
                if (highLimit >= 0)
                {
                    //highLimitMSB = (int)(highLimit / 256);// ' msb
                    //highLimitLSB = highLimit & 0xFF;
                    byteAr[2] = (byte)(highLimit & 0xFF);
                    byteAr[3] = (byte)(highLimit / 256);
                }
                else
                {
                    if (signBit == 2048)
                    {
                        byteAr[3] = (byte)(byteAr[3] | 0xF0);
                    }
                    if (signBit == 128 || signBit == 16)
                    {
                        byteAr[3] = (byte)(byteAr[3] | 0xFF);
                    }
                    if (signBit == 16)
                    {
                        byteAr[2] = (byte)(byteAr[2] | 0xF0);
                    }
                }
                #endregion


                hexHigh = byteAr[3].ToString("X2") + byteAr[2].ToString("X2");
                hexLow = byteAr[1].ToString("X2") + byteAr[0].ToString("X2");

                #region write LSB and MSB  into register
                return HIDClass.WriteRegister(byteAr, 1);
                #endregion

            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }

        }

        public static void SetADCConvertor(ADBitsRange convertor)
        {
            HIDClass.SetADCConvertor(convertor);
        }

        public static void SetAdSenRange(AdSenRange range, ref  uint txtScaleMax1, ref int txtScaleMin1, ref uint txtScale2, ref int txtScaleMin2)
        {
            HIDClass.SetAdSenRange(range, ref   txtScaleMax1, ref txtScaleMin1, ref  txtScale2, ref  txtScaleMin2);
        }

        public static void SetDevOpMode(OperateMode opMode)
        {
            HIDClass.SetDevOpMode(opMode);
        }

        public static void SetPinSource(PinSourceType type)
        {
            GlobalVariables.WriteRegs[1] = Convert.ToByte(GlobalVariables.WriteRegs[1] & 0xCF);
            if (type == PinSourceType.Pin_100)
            {
                GlobalVariables.WriteRegs[1] = Convert.ToByte(GlobalVariables.WriteRegs[1] & 0x30);

            }

            if (type == PinSourceType.Pin_50)
            {
                GlobalVariables.WriteRegs[1] = Convert.ToByte(GlobalVariables.WriteRegs[1] & 0x20);

            }

            if (type == PinSourceType.Pin_25)
            {
                GlobalVariables.WriteRegs[1] = Convert.ToByte(GlobalVariables.WriteRegs[1] & 0x10);

            }



            GlobalVariables.TxtRegHex[1] = GlobalVariables.WriteRegs[1];
            //If Continue = False And AbortFlag = False Then
            for (int i = 1; i >= 0; i--)
                HIDClass.WriteRegister(GlobalVariables.TxtRegHex[i], 1, (byte)i);
        }

        public static void SetDevFreq(Frequency f)
        {
            HIDClass.SetFreq(f);
        }

        #region Private Methods
        private static bool ShowRetryMsgBox()
        {
            string message = "Device is not connected.\n     Want to Retry ?";
            string caption = "Retry Again";
            MessageBoxButton buttons = MessageBoxButton.YesNo;
            MessageBoxImage icon = MessageBoxImage.Information;
            if (MessageBox.Show(message, caption, buttons, icon) == MessageBoxResult.Yes)
            {
                if (DeviceUtil.Connect() == HIDStatus.Pass)
                    return true;
                else
                    return ShowRetryMsgBox();
            }
            else
            {
                return false;
            }
        }



        /// <summary>
        /// Check for the HID device is connected to the system.
        /// If connected create a handle for the device
        /// </summary>
        /// <returns></returns>
        static HIDStatus Connect()
        {
            try
            {
                return HIDClass.Connect();

            }
            catch (Exception ex) { throw ex; }
        }
        #endregion


    }
}