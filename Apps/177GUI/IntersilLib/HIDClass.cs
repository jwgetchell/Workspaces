/**********************************************************************
 Module     : IntersilLib
 Modified On : 20-May-2014      
 Class file : HIDClass.cs
 This class provides the functionality to detect the HID device,Get the handle,read read /write the file etc.
 **************************************************************************/

using System;
using System.Collections.Generic;
using System.IO;
using System.Runtime.InteropServices;
using System.Text;

namespace IntersilLib
{
    /// <summary>
    ///  This class provides the functionality to detect the HID device,Get the handle,read read /write the file etc.
    /// </summary>
    public partial class HIDClass
    {

        #region Private Data Members

        static dynamic api_status;

        public int count = 0;
        /// <summary>
        /// Use this object to access the Methods/Data of HIDDeviceIO Class
        /// </summary>
        static HIDDeviceIO oHIDIO;
        #endregion


        #region  Properties

        #endregion


        static HIDClass()
        {


            if (oHIDIO == null)
            {
                oHIDIO = new HIDDeviceIO();
            }

        }

        /// <summary>
        /// Detect the  HID device and get the file handle if detected
        /// </summary>
        /// <returns>HIDStatus value</returns>
        public static HIDStatus Connect()
        {
            SP_DEVICE_INTERFACE_DATA myDeviceInterfaceData = new SP_DEVICE_INTERFACE_DATA();

            #region Data Members
            Guid deviceGuid = new Guid();
            GlobalVariables.MyDeviceDetected = false;
            IntPtr DeviceInfoSetptr;
            uint memberIndex = 0;
            //string dataString;
            HIDStatus status = HIDStatus.Pass;
            #endregion

            //step1 
            //Close read/write file handle
            CloseExistHandle();

            //Step 2
            HIDDevInfo._Security.lpSecurityDescriptor = IntPtr.Zero;
            HIDDevInfo._Security.bInheritHandle = true;
            HIDDevInfo._Security.nLength = System.Runtime.InteropServices.Marshal.SizeOf(HIDDevInfo._Security);
            memberIndex = 0;
            try
            {
                //Step 3
                //Get the Guid of the device
                CommonPInvoke.HidD_GetHidGuid(ref deviceGuid);

                //Step 4
                DeviceInfoSetptr = CommonPInvoke.SetupDiGetClassDevs(ref deviceGuid, 0, IntPtr.Zero, GlobalVariables.DIGCF_PRESENT | GlobalVariables.DIGCF_DEVICEINTERFACE);

                do
                {
                    myDeviceInterfaceData.cbSize = (uint)System.Runtime.InteropServices.Marshal.SizeOf(myDeviceInterfaceData);
                    //Step 5
                    api_status = CommonPInvoke.SetupDiEnumDeviceInterfaces(DeviceInfoSetptr, IntPtr.Zero, ref deviceGuid, memberIndex, ref myDeviceInterfaceData);
                    //int err1 = Marshal.GetLastWin32Error();
                    if (api_status)
                    {
                        //Step 6
                        GetFileHandes(ref GlobalVariables.MyDeviceDetected, DeviceInfoSetptr, myDeviceInterfaceData);
                    }
                    memberIndex = memberIndex + 1;
                } while (api_status);

                //Step 6(clear memory)
                api_status = CommonPInvoke.SetupDiDestroyDeviceInfoList(DeviceInfoSetptr);
                if (GlobalVariables.MyDeviceDetected == false)
                {
                    status = HIDStatus.Disconnect;
                }
                if (GlobalVariables.MyDeviceDetected == true)
                {
                    //ModGeneric.deviceAttached = true;
                    PrepareForOverlappedTransfer();
                    status = GetStateInfo();
                }
                return status;
            }

            catch (Exception ex) { throw new Exception(ex.Message); }
        }

        /// <summary>
        /// Checking the HID Connection status
        /// </summary>
        /// <returns></returns>
        public static HIDStatus CheckHIDConnStatus()
        {
            try
            {
                HIDStatus hStatus = HIDStatus.Pass;
                if (GlobalVariables.MyDeviceDetected == false)
                {
                    hStatus = HIDStatus.Fail;
                    Connect();

                }
                if (GlobalVariables.MyDeviceDetected)
                {
                    hStatus = HIDStatus.Pass;
                    if (HIDDevInfo.DicLed["chkLed1"] == 0)
                    {
                        HIDDevInfo.DicLed["chkLed1"] = 1;
                        if (ChKLed_Click() == HIDStatus.Fail)
                            return HIDStatus.Disconnect;

                        HIDDevInfo.DicLed["chkLed2"] = 1;
                        ChKLed_Click();
                        if (ChKLed_Click() == HIDStatus.Fail)
                            return HIDStatus.Disconnect;
                    }
                    else
                    {
                        HIDDevInfo.DicLed["chkLed1"] = 0;
                        if (ChKLed_Click() == HIDStatus.Fail)
                            return HIDStatus.Disconnect;
                        HIDDevInfo.DicLed["chkLed2"] = 0;

                        if (ChKLed_Click() == HIDStatus.Fail)
                            return HIDStatus.Disconnect;
                    }

                    //byte[] data = { 0 };

                    HIDDeviceIO oHIDDeviceIO = new HIDDeviceIO();
                    HIDRegRead oHIDReg = new HIDRegRead(HIDDevInfo.I2C_Slave_Address, 1, 1, HIDDevInfo.EventObject, HIDDevInfo.HIDOverlapped);

                    oHIDDeviceIO.ReadRegister(oHIDReg);

                    //  oHIDDeviceIO.Read_Register(I2C_Slave_Address, 1, 1);
                    // Int16 status = oHIDDeviceIO.CheckNACK(ReadHandleArray[0], Report_Size, IOBuf, EventObject, data, HIDOverlapped);
                    if (GlobalVariables.Global_API_Status != 0)
                    {
                        hStatus = HIDStatus.Fail;

                    }

                    if (GlobalVariables.Global_I2C_NAK_Status != 8)
                    {
                        hStatus = HIDStatus.Fail;
                    }
                }

                return hStatus;

            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public void ReadClearIStatus()
        {
        }

      
     
        /// <summary>
        /// 
        /// </summary>
        internal static void ReadPurge()
        {
            uint bytesSucceed = 0;
            dynamic res;
            bytesSucceed = 0;

            do
            {
                try
                {
                    res = CommonPInvoke.ReadFile(HIDDevInfo.HIDReadHandleArr[0], HIDDevInfo.IOBuf, HIDDevInfo.Report_Size, out bytesSucceed, ref  HIDDevInfo.HIDOverlapped);
                    res = CommonPInvoke.WaitForSingleObject(HIDDevInfo.EventObject, 1);
                    CommonPInvoke.ResetEvent(HIDDevInfo.EventObject);
                    if ((res != Status.Wait_Object_0))
                    {
                        res = CommonPInvoke.CancelIo(HIDDevInfo.HIDReadHandleArr[0]);

                    }
                }
                catch (Exception ex)
                {
                    throw new Exception(ex.Message);
                }
            } while (res == Status.Wait_Object_0);

        }

        #region Private Methods
        private static HIDStatus ChKLed_Click()
        {
            uint bytesSucceed = 0;
            MemSet(0);
            ReportId();
            HIDDevInfo.IOBuf[1] = 1; //On/Off LED command
            HIDDevInfo.IOBuf[2] = 0; //write            
            HIDDevInfo.IOBuf[3] = (byte)(HIDDevInfo.DicLed["chkLed1"] + HIDDevInfo.DicLed["chkLed2"] * 2);//on/off the led
            api_status = CommonPInvoke.WriteFile(HIDDevInfo.HIDWriteHandleArr[0], HIDDevInfo.IOBuf, HIDDevInfo.Report_Size, out bytesSucceed, IntPtr.Zero);
            HIDStatus status = CheckStatus(api_status);
            return status;
        }

        /// <summary>
        /// Get the file  handle for  read/write register 
        /// </summary>
        /// <param name="myDeviceDetected"></param>
        /// <param name="DeviceInfoSetptr"></param>
        private static void GetFileHandes(ref bool myDeviceDetected, IntPtr DeviceInfoSetptr, SP_DEVICE_INTERFACE_DATA myDeviceInterfaceData)
        {
            int needed = 0, detailData;
            //Step 1 
            api_status = CommonPInvoke.SetupDiGetDeviceInterfaceDetail(DeviceInfoSetptr, ref myDeviceInterfaceData, IntPtr.Zero, 0, ref needed, IntPtr.Zero);
            detailData = needed;
            byte[] detailDataBuffer = new byte[needed];

            //Step 2
            SP_DEVICE_INTERFACE_DETAIL_DATA didd = new SP_DEVICE_INTERFACE_DETAIL_DATA();
            if (IntPtr.Size == 8) // for 64 bit operating systems
                didd.cbSize = 8;
            else
                didd.cbSize = (uint)(4 + Marshal.SystemDefaultCharSize);// for 32 bit systems
            CommonPInvoke.RtlMoveMemory(ref detailDataBuffer[0], ref didd, 4);
            string devicePath = string.Empty;
            try
            {
                //Step 3
                api_status = CommonPInvoke.SetupDiGetDeviceInterfaceDetail(DeviceInfoSetptr, ref myDeviceInterfaceData, ref detailDataBuffer[0], detailData, ref needed, IntPtr.Zero);
                devicePath = Encoding.Unicode.GetString(detailDataBuffer, 0, detailDataBuffer.Length);
                devicePath = devicePath.Substring(2);

                //Step 4
                IntPtr filehandle = CommonPInvoke.CreateFile(devicePath, FileAccess.ReadWrite, FileShare.ReadWrite, IntPtr.Zero, FileMode.Open, FileAttributes.Normal, IntPtr.Zero);

                //Step 5
                HIDD_ATTRIBUTES deviceAttributes = new HIDD_ATTRIBUTES();
                deviceAttributes.Size = System.Runtime.InteropServices.Marshal.SizeOf(deviceAttributes);
                api_status = CommonPInvoke.HidD_GetAttributes(filehandle, ref deviceAttributes);

                //Step 6
                if (ValidateDevice(filehandle, deviceAttributes))
                {
                    myDeviceDetected = true;
                    HIDDevInfo.HIDWriteHandleArr.Add(filehandle);
                    using (FileAccessVar oFile = new FileAccessVar())
                    {
                        IntPtr ReadHandle = CommonPInvoke.CreateFile(devicePath, (oFile.GENERIC_READ | oFile.GENERIC_WRITE), (oFile.FILE_SHARE_READ | oFile.FILE_SHARE_WRITE), 0, oFile.OPEN_EXISTING, oFile.FILE_FLAG_OVERLAPPED, 0);
                        HIDDevInfo.HIDReadHandleArr.Add(ReadHandle);
                    }
                }


            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        /// <summary>
        /// Validate the device i.e  the device is the required  device or not.
        /// If device is not validated close the file handle
        /// </summary>
        /// <param name="filehandle">A handle to the device</param>
        /// <param name="deviceAttr">Attributes of the device</param>
        /// <returns>Return true if device is the required device</returns>
        private static bool ValidateDevice(IntPtr filehandle, HIDD_ATTRIBUTES deviceAttr)
        {
            bool temp = false;
            long VID, PID;
            VID = ((int)DefaultId.DEFAULT_VENDOR_ID & 0x7FFF) - ((int)DefaultId.DEFAULT_VENDOR_ID & 0x8000);
            PID = ((int)DefaultId.DEFAULT_PRODUCT_ID & 0x7FFF) - ((int)DefaultId.DEFAULT_PRODUCT_ID & 0x8000);
            if ((deviceAttr.VendorID == VID) && (deviceAttr.ProductID == PID))
            {
                temp = true;
            }
            else
            {
                CommonPInvoke.CloseHandle(filehandle);
                temp = false;
            }
            return temp;
        }

        /// <summary>
        /// Call the window's API for closing the file handle. 
        /// </summary>
        private static void CloseHandles()
        {
            foreach (IntPtr item in HIDDevInfo.HIDWriteHandleArr)
            {
                CommonPInvoke.CloseHandle(item);
            }
            HIDDevInfo.HIDWriteHandleArr.Clear();
            foreach (IntPtr item in HIDDevInfo.HIDReadHandleArr)
            {
                CommonPInvoke.CloseHandle(item);
            }
            HIDDevInfo.HIDReadHandleArr.Clear();

        }

        /// <summary>
        /// Close all file handles and clear the list containing the file handles
        /// </summary>
        private static void CloseExistHandle()
        {
            if (HIDDevInfo.HIDWriteHandleArr != null)
            {
                //WriteHandle = IntPtr.Zero;
                //ReadHandle = IntPtr.Zero;
                if (HIDDevInfo.HIDWriteHandleArr.Count != 0)
                    CloseHandles();
                HIDDevInfo.HIDWriteHandleArr.Clear();
            }
            else
            {
                HIDDevInfo.HIDWriteHandleArr = new List<IntPtr>();
            }
        }

        /// <summary>
        /// Create the event object
        /// </summary>
        private static void PrepareForOverlappedTransfer()
        {

            if (HIDDevInfo.EventObject == IntPtr.Zero)
                HIDDevInfo.EventObject = CommonPInvoke.CreateEvent(ref HIDDevInfo._Security, true, true, string.Empty);
            HIDDevInfo.HIDOverlapped.Offset = IntPtr.Zero;
            HIDDevInfo.HIDOverlapped.OffsetHigh = IntPtr.Zero;
            HIDDevInfo.HIDOverlapped.HandleEvent = HIDDevInfo.EventObject;
        }

        private static HIDStatus GetStateInfo()
        {
            return GetLedState();
        }

        private static HIDStatus GetLedState()
        {
            //Check value of LED on EVB and set chkLED appropriately
            HIDStatus hidStatus = HIDStatus.Pass;
            uint bytesSucceed = 0;
            ReadPurge();
            MemSet(0);
            //Set the 0 index value of the IOBuf
            ReportId();
            HIDDevInfo.IOBuf[1] = 1; //LED
            HIDDevInfo.IOBuf[2] = 1; //read
            api_status = CommonPInvoke.WriteFile(HIDDevInfo.HIDWriteHandleArr[0], HIDDevInfo.IOBuf, HIDDevInfo.Report_Size, out bytesSucceed, IntPtr.Zero);
            hidStatus = CheckStatus(api_status);

            if (hidStatus == HIDStatus.Pass)
            {
                MemSet(0);
                api_status = CommonPInvoke.ReadFile(HIDDevInfo.HIDReadHandleArr[0], HIDDevInfo.IOBuf, HIDDevInfo.Report_Size, out bytesSucceed, ref HIDDevInfo.HIDOverlapped);
                api_status = CommonPInvoke.WaitForSingleObject(HIDDevInfo.EventObject, 6000);
                CommonPInvoke.ResetEvent(HIDDevInfo.EventObject);
                if (api_status != Status.Wait_Object_0)
                {
                    hidStatus = CheckStatus(Status.API_Fail);
                }
                if (hidStatus == HIDStatus.Pass)
                {
                    int temp = HIDDevInfo.IOBuf[2];
                    HIDDevInfo.DicLed.Clear();
                    HIDDevInfo.DicLed.Add("chkLed1", temp & 1);
                    HIDDevInfo.DicLed.Add("chkLed2", temp & 2);
                }
            }
            return hidStatus;
        }

        private static void MemSet(byte value)
        {
            for (int i = 0; i <= HIDDevInfo.Report_Size - 1; i++)
            {
                HIDDevInfo.IOBuf[i] = value;
            }
        }

        private static void ReportId()
        {
            const byte Default_Report_Id = 0; //default for implicit report IDs
            const byte Short_Report_Id = 1;

            if (GlobalVariables.Explicit_Report_Id == false)
            {
                HIDDevInfo.IOBuf[0] = Default_Report_Id; //default report ID; this byte is dropped in transfer, so we don't really waste a byte transmitting it
            }
            else
            {
                HIDDevInfo.IOBuf[0] = Short_Report_Id; //explicit out report ID in HID's descriptor
            }
        }

        private static HIDStatus CheckStatus(Int16 api_status)
        {
            HIDStatus tempcheckStatus = 0;

            if (api_status == Status.API_Fail)
            {

                tempcheckStatus = HIDStatus.Fail;

            }
            else
            {
                tempcheckStatus = HIDStatus.Pass;
            }
            return tempcheckStatus;
        }
        #endregion


        public static Int16 ReadSingleRegister(byte value, byte numDatabytes, byte regNo)
        {
            List<byte> data, reg;
            byte numRegBytes = 0;
            try
            {

                //Step 1
              //  ReadPurge();
                data = new List<byte>();
                for (int i = 0; i < numDatabytes; i++)
                {
                    data.Add(value);
                }
                numRegBytes = 1;
                reg = new List<byte>(); ;
                for (int i = 0; i < numRegBytes; i++)
                {
                    reg.Add(regNo);
                }

                HIDRegRead oHIDReg = new HIDRegRead(HIDDevInfo.I2C_Slave_Address, numDatabytes, 1, HIDDevInfo.EventObject, HIDDevInfo.HIDOverlapped);
                return oHIDIO.ReadI2C(oHIDReg, data, reg);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        //Write a single Register.
        public static Int16 WriteSingleRegister(byte value, byte numDatabytes, byte regNo)
        {
            List<byte> data, reg;
            byte numRegBytes = 0;
            try
            {

                //Step 1
          //      ReadPurge();
                data = new List<byte>();
                for (int i = 0; i < numDatabytes; i++)
                {
                    data.Add(value);
                }
                numRegBytes = 1;
                reg = new List<byte>(); ;
                for (int i = 0; i < numRegBytes; i++)
                {
                    reg.Add(regNo);
                }

                HIDRegRead oHIDReg = new HIDRegRead(HIDDevInfo.I2C_Slave_Address, numDatabytes, 1, HIDDevInfo.EventObject, HIDDevInfo.HIDOverlapped);
                return oHIDIO.WriteI2C(oHIDReg, data, reg);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
   
    
    }



    /// <summary>
    /// Contains the information about the particular HID device.
    /// </summary>
    public struct HIDDevInfo
    {
        /// <summary>
        /// 
        /// </summary>
        internal const UInt16 Report_Size = 64;
        public static SECURITY_ATTRIBUTES _Security;
        public static OVERLAPPED HIDOverlapped;
        #region Properties


        internal static Dictionary<string, int> DicLed { get; set; }

        /// <summary>
        /// Buffer to be used in reading/writing register.
        /// </summary>
        internal static byte[] IOBuf { get; set; }

        /// <summary>
        /// Contains the handle for writing the file.
        /// </summary>
        internal static List<IntPtr> HIDWriteHandleArr { get; set; }

        /// <summary>
        /// Contains the handle for reading file.
        /// </summary>
        internal static List<IntPtr> HIDReadHandleArr { get; set; }

        /// <summary>
        /// 
        /// </summary>
        public static IntPtr EventObject { get; set; }

        /// <summary>
        /// I2C slave address of the device.
        /// </summary>
        public static Byte I2C_Slave_Address { get; set; }
        #endregion
        
        static HIDDevInfo()
        {
            IOBuf = new byte[Report_Size];
            DicLed = new Dictionary<string, int>();
            HIDReadHandleArr = new List<IntPtr>();
            HIDWriteHandleArr = new List<IntPtr>();
        }
    }

    /// <summary>
    /// Provides the constant flags used for getting file handles 
    /// </summary>
    class FileAccessVar : IDisposable
    {
        public readonly uint GENERIC_READ;
        public readonly uint GENERIC_WRITE;
        public readonly uint FILE_SHARE_READ;
        public readonly uint FILE_SHARE_WRITE;
        public readonly uint FILE_FLAG_OVERLAPPED;
        public readonly uint OPEN_EXISTING;

        public FileAccessVar()
        {
            GENERIC_READ = 0x80000000;
            GENERIC_WRITE = 0x40000000;
            FILE_SHARE_READ = 0x1;
            FILE_SHARE_WRITE = 0x2;
            FILE_FLAG_OVERLAPPED = 0x40000000;
            OPEN_EXISTING = 3;

        }

        public void Dispose()
        {


        }

        ~FileAccessVar()
        {

        }
    }

    /// <summary>
    /// Provides the current reading
    /// </summary>
    public class CurrentReading
    {
        /// <summary>
        /// Current reading in decimal
        /// </summary>
        public Int64 ADCReading { get; set; }

        /// <summary>
        /// Reading in LUX
        /// </summary>
        public decimal LuxValue { get; set; }

        /// <summary>
        /// This byte is used when poll external interrupt is enabled.
        /// </summary>
        public byte PortBData { get; set; }
    }


}



