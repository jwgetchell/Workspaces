/**********************************************************************
 Module     : IntersilLib
 Modified On : 20-May-2014     
 
 **************************************************************************/

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace IntersilLib
{
    #region Global Class variable

    /// <summary>
    /// This class porvides the global constants and  properties
    /// properties variables are set at run time 
    /// properties Can be used by any module 
    /// </summary>
    public class GlobalVariables
    {
        GlobalVariables()
        {

            #region Simulate ISL29177 Form Load
            //Step 1 Set WriteRegs
            //for (int i = 0; i < 4; i++)
            //{
            //    if (i == 0 || i == 1 || i == 3)
            //        WriteRegs[i] = 0x0;
            //    else
            //        WriteRegs[i] = 0xFF;
            //}

            ////Step 2 Set txtRegHex
            //TxtRegHex[0] = WriteRegs[0];
            //TxtRegHex[1] = WriteRegs[1];
            
            #endregion

        }

        #region Constant Flags
        /// <summary>
        /// Return only devices that are currently present in a system.
        /// </summary>
        public const int DIGCF_PRESENT = 0x2;
        public const int DIGCF_DEVICEINTERFACE = 0x10;
        public const int WAIT_OBJECT_0 = 0;
        public const bool Explicit_Report_Id = true;        
        #endregion

        #region properties

        public static Byte Default_Slave_Address;

        /// <summary>
        /// 
        /// </summary>
        public static Int16 Global_API_Status;

        /// <summary>
        /// 
        /// </summary>
        public static Int16 Global_I2C_NAK_Status;

        /// <summary>
        /// This  variable is set to false when device is disconnected.
        /// </summary>
        public static bool MyDeviceDetected = false;

        /// <summary>
        /// Provides the sleep time between two readings.
        /// </summary>
        public static UInt16 Prox_IR_ITime = 8;
        public static int SignBitVal = 32768;
        public static int BitsUsedMask = 0xFFFF;

        /// <summary>
        /// Maximum Clock counts 
        /// </summary>
        public static uint ClockCounts = 65535;

        /// <summary>
        /// Represents the 32 bit register 
        /// Registers bit are set at run time
        /// </summary>
        public static byte[] WriteRegs = new byte[32];

        /// <summary>
        /// Represents the bool bit of register 0x0E
        /// Register values are set at run time
        /// </summary>
        public static byte IRDR_SHRT = (byte)0;
        /// <summary>
        /// Represents the 32 bit register 
        /// Register values are set at run time
        /// </summary>
        public static byte[] TxtRegHex = new byte[32];
        /// <summary>
        /// True  : Power Down Mode is on.
        /// False : other mode is active. 
        /// </summary>
        public static Boolean Read_Once { get; set; }

        /// <summary>
        /// True  : Als continous mode , IR Continous mode
        /// False : Power down mode
        /// </summary>
        public static Boolean Read_Lux { get; set; }

        /// <summary>
        /// Depends on 'PScheme' value.
        /// </summary>
        public static Boolean Read_Prox { get; set; }

        /// <summary>
        /// Provides the measurement type selected.
        /// </summary>
        public static char PScheme { get; set; }

        /// <summary>
        /// 
        /// </summary>
        public static AdSenRange Krange { get; set; }
        //public static Int16 K_Factor { get; set; }

        /// <summary>
        /// Maximum value for interrupt value
        /// </summary>
        public static uint Max_Interrupt_Limit { get; set; }

        /// <summary>
        /// Minimum value for interrupt value
        /// </summary>
        public static int Min_Interrupt_Limit { get; set; }

        
        #endregion


        /// <summary>
        /// Checking Enggi mode is enabled or not.
        /// </summary>
        /// <returns></returns>
        public static bool ckeckEnggiMode()
        { 
           // Read each line of the file into a string array. Each element 
            // of the array is one line of the file. 
            bool Retstatus = false;
            string[] lines = System.IO.File.ReadAllLines("config.ini");
            string[] mode = lines[0].Split('=');
            string[] sensor = lines[1].Split('=');
            string[] status = lines[2].Split('=');
            //This is for security purpose to open Enggi mode for that people who has a knowladge of it.
            //If you want to open the ENGGI MODE you have to make proper changes in config.ini file.
            if (mode[1] == "engineering" && sensor[1] == "ISL29177" && status[1] == "enable")
            {
                Retstatus = true;
            }
            else
                Retstatus = false;

            return Retstatus;
        }
        public static int GetTimerInterval(int PRXSlp)
        {
                int caseSwitch = PRXSlp;
                switch (caseSwitch)
                {
                    case 0:
                        caseSwitch = 400;
                        break;
                    case 1:
                        caseSwitch = 200;
                        break;
                    case 2:
                        caseSwitch = 100;
                        break;
                    case 3:
                        caseSwitch = 50;
                        break;
                    case 4:
                        caseSwitch = 25;
                        break;
                    default:
                        caseSwitch = 25;
                        break;
                }
                return caseSwitch;
        }
  
    }

  

    /// <summary>
    /// Provides the constants representing the error code for different error
    /// </summary>
    public class Error
    {
        public const Int16 USB_Read_Error = 2;
        public const Int16 I2C_Nack_Error = 1;
        public const Int16 USB_WRITE_ERROR = 4;
    }

    /// <summary>
    /// This class provides the Status of the HID device
    /// </summary>

    public class Status : Error
    {
        public readonly static Int16 GP_Success;
        public readonly static Int16 GP_Fail;
        public readonly static Int16 API_Fail;
        public readonly static Int16 USB_Disconnec;

        /// <summary>
        /// Indicates the event that the state of the specified object is signaled.
        /// </summary>
        public readonly static Int16 Wait_Object_0;
        public readonly static Int16 I2C_SUCCESS;

        static Status()
        {

            I2C_SUCCESS = GP_Success = 8;
            GP_Fail = API_Fail = 5;
            Wait_Object_0 = 0;
            USB_Disconnec = 10;

        }
    }




    /// <summary>
    /// This class provides the important information required to read/write the register  
    /// E.g : passing information for USB check stataus
    /// Read the interrupt limits
    /// </summary>
    public class HIDRegRead
    {
        public byte I2CSlaveAddress { get; set; }
        public byte NumDataBytes { get; set; }
        public byte NumRegBytes { get; set; }
        public IntPtr EventPtr { get; set; }
        public OVERLAPPED HidOverlapped { get; set; }
        public byte StartRegRD { get; set; }
        public byte[] RegRdBuffer { get; set; }
        public HIDRegRead(byte address, byte numDataBytes, byte numRegBytes, IntPtr eventPtr, OVERLAPPED hidOverlapped)
        {
            I2CSlaveAddress = address;
            NumDataBytes = numDataBytes;
            NumRegBytes = numRegBytes;
            EventPtr = eventPtr;
            HidOverlapped = hidOverlapped;
            StartRegRD = 0;
            RegRdBuffer = new byte[32];
           
        }

        public HIDRegRead(byte address, byte numDataBytes, byte numRegBytes)
        {
            I2CSlaveAddress = address;
            NumDataBytes = numDataBytes;
            NumRegBytes = numRegBytes;
            StartRegRD = 0;
            RegRdBuffer = new byte[32];
        }

    }

    #endregion

    #region Global Structs Variable
    /// <summary>
    /// Provides the interrupt scale value
    /// </summary>
    public struct IntrScale
    {
        /// <summary>
        /// Lower limit of the interrupt value
        /// </summary>
        public string LowerLimit { get; set; }

        /// <summary>
        /// Maximum limit of the Interrupt value
        /// </summary>
        public string HighLimit { get; set; }
    }
    #endregion

    #region Global Enum Variable
    public enum MeasurType { Scheme0, Scheme1 }

    public enum PinSourceType { Pin_100, Pin_50, Pin_25, Pin_12 }

    /// <summary>
    /// Provides the possible operation mode
    /// Power Down Mode  -->  device is not active
    /// ALS Continous    -->  device is active and reading continous data.
    /// </summary>
    public enum OperateMode { PwrDown, ALSCont, IRCont, ALSOnce }

    /// <summary>
    /// Provides possible  Sensitivity range  
    /// </summary>
    public enum AdSenRange { Range0 = 1000, Range1 = 4000, Range2 = 16000, Range3 = 64000 }

    /// <summary>
    /// 
    /// </summary>
    public enum Frequency { Frq1, Frq2 };


    /// <summary>
    /// Provides the status of HID device
    /// Pass        -->Device is connected
    /// Fail        -->Some error occurred
    /// Disconnect  -->Device is disconnected
    /// </summary>
    public enum HIDStatus { Pass, Fail, Disconnect };

    /// <summary>
    /// Provides the default vendorid and productid for the device  
    /// </summary>
    public enum DefaultId { DEFAULT_VENDOR_ID = 0x9AA, DEFAULT_PRODUCT_ID = 0x2019 }

    #endregion
}
