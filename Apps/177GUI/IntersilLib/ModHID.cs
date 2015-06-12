using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using Microsoft.Win32;
using Microsoft.Win32.SafeHandles;
using System.IO;
namespace IntersilLib
{
    public static class ModHID
    {

        #region Properties
        public static Byte I2C_Slave_Address;
        public static uint memberIndex = 0;
        public static bool lastDevice = false;
        public static bool myDeviceDetected = false;
        public static SECURITY_ATTRIBUTES Security;
        public static List<SafeHandle> HIDhandleArray;
        public static List<SafeHandle> ReadHandleArray = new List<SafeHandle>();
        public static GUID HidGuid;
        //public long HIDhandle;
        public static String dataString;
        //public long ReadHandle;
        public static IntPtr DeviceInfoSetptr;
        public static SP_DEVICE_INTERFACE_DATA1 myDeviceInterfaceData1;
        public static SP_DEVICE_INTERFACE_DATA2 myDeviceInterfaceData2;
        public static SP_DEVINFO_DATA myDeviceInfoData;
        //bool lastDevice, myDeviceDetected;
        //public List<long> ReadHandleArray;

        [DllImport("kernel32", CharSet = CharSet.Auto, SetLastError = true)]
        unsafe public static extern long RtlMoveMemory(ref byte dest, IntPtr src, uint count);

        [DllImport("kernel32", CharSet = CharSet.Auto, SetLastError = true)]
        unsafe public static extern long RtlMoveMemory(ref byte dest, ref SP_DEVICE_INTERFACE_DETAIL_DATA src, uint count);


        //[DllImport("kernel32")]
        //static extern long CloseHandle(long hObject);
        //Declared as a function for consistency,
        //but returns nothing. (Ignore the returned value.)
        //[DllImport("hid.dll")]
        //static extern unsafe long HidD_GetHidGuid(ref GUID HidGuid);

        //[DllImport("setupapi.dll", SetLastError = true)]
        // [DllImport("setupapi.dll",CallingConvention=CallingConvention.Cdecl)]
        // public static extern long SetupDiGetClassDevs(out GUID ClassGuid, string Enumerator, long hwndParent, long Flags);

        [DllImport("hid.dll", EntryPoint = "HidD_GetHidGuid", SetLastError = true)]
        static extern long HidD_GetHidGuid(ref GUID HidGuid);

        [DllImport("hid.dll", EntryPoint = "HidD_GetHidGuid", SetLastError = true)]
        static extern long HidD_GetHidGuid(ref Guid HidGuid);

        [DllImport("setupapi.dll", SetLastError = true)]
        public static extern bool SetupDiDestroyDeviceInfoList
        (
             IntPtr DeviceInfoSet
        );

        //[DllImport("setupapi.dll", CharSet = CharSet.Auto, SetLastError = true)]
        //static extern IntPtr SetupDiGetClassDevs(ref GUID ClassGuid, string enumerator, uint hwndParent, uint Flags);
        [DllImport("setupapi.dll", CharSet = CharSet.Auto)]
        static extern IntPtr SetupDiGetClassDevs(ref GUID ClassGuid, int Enumerator, IntPtr hwndParent, uint Flags);

        [DllImport("setupapi.dll", CharSet = CharSet.Auto)]
        static extern IntPtr SetupDiGetClassDevs(ref Guid ClassGuid, int Enumerator, IntPtr hwndParent, uint Flags);



        //[DllImport(@"setupapi.dll", CharSet = CharSet.Auto, SetLastError = true)]
        //public static extern Boolean SetupDiEnumDeviceInterfaces(IntPtr hDevInfo, IntPtr f, ref GUID HidGuid, UInt32 deviceInterfaceDetailDataSize, ref SP_DEVICE_INTERFACE_DATA deviceInterfaceData);

        [DllImport(@"setupapi.dll", CharSet = CharSet.Auto, SetLastError = true)]
        static extern Boolean SetupDiEnumDeviceInterfaces(IntPtr hDevInfo, IntPtr devInfo, ref  Guid interfaceClassGuid, UInt32 memberIndex, ref SP_DEVICE_INTERFACE_DATA1 deviceInterfaceData);

        [DllImport(@"setupapi.dll", CharSet = CharSet.Auto, SetLastError = true)]
        static extern Boolean SetupDiEnumDeviceInterfaces(IntPtr hDevInfo, IntPtr devInfo, ref  Guid interfaceClassGuid, UInt32 memberIndex, ref SP_DEVICE_INTERFACE_DATA2 deviceInterfaceData);


        [DllImport(@"setupapi.dll", CharSet = CharSet.Auto, SetLastError = true)]
        static extern Boolean SetupDiEnumDeviceInterfaces(IntPtr hDevInfo, IntPtr devInfo, ref GUID interfaceClassGuid, UInt32 memberIndex, ref SP_DEVICE_INTERFACE_DATA1 deviceInterfaceData);

        [DllImport(@"setupapi.dll", CharSet = CharSet.Auto, SetLastError = true)]
        public static extern Boolean SetupDiGetDeviceInterfaceDetail(
           IntPtr hDevInfo,
           ref SP_DEVICE_INTERFACE_DATA1 deviceInterfaceData,
           IntPtr deviceInterfaceDetailData,
           int deviceInterfaceDetailDataSize,
           ref int requiredSize,
           IntPtr deviceInfoData
        );

        [DllImport(@"setupapi.dll", CharSet = CharSet.Auto, SetLastError = true)]
        public static extern Boolean SetupDiGetDeviceInterfaceDetail(
           IntPtr hDevInfo,
           ref SP_DEVICE_INTERFACE_DATA2 deviceInterfaceData,
           IntPtr deviceInterfaceDetailData,
           int deviceInterfaceDetailDataSize,
           ref int requiredSize,
           IntPtr deviceInfoData
        );



        [DllImport(@"setupapi.dll", CharSet = CharSet.Auto, SetLastError = true)]
        public static extern Boolean SetupDiGetDeviceInterfaceDetail(
           IntPtr hDevInfo,
           ref SP_DEVICE_INTERFACE_DATA1 deviceInterfaceData,
           ref byte deviceInterfaceDetailData,
           int deviceInterfaceDetailDataSize,
           ref int requiredSize,
            IntPtr deviceInfoData
        );

        [DllImport(@"setupapi.dll", CharSet = CharSet.Auto, SetLastError = true)]
        public static extern Boolean SetupDiGetDeviceInterfaceDetail(
           IntPtr hDevInfo,
           ref SP_DEVICE_INTERFACE_DATA2 deviceInterfaceData,
           ref byte deviceInterfaceDetailData,
           int deviceInterfaceDetailDataSize,
           ref int requiredSize,
            IntPtr deviceInfoData
        );

        [DllImport("kernel32.dll", SetLastError = true, CharSet = CharSet.Auto)]
        public static extern SafeFileHandle CreateFile(
            string lpFileName,
            [MarshalAs(UnmanagedType.U4)] FileAccess dwDesiredAccess,
            [MarshalAs(UnmanagedType.U4)] FileShare dwShareMode,
            IntPtr lpSecurityAttributes,
            [MarshalAs(UnmanagedType.U4)] FileMode dwCreationDisposition,
            [MarshalAs(UnmanagedType.U4)] FileAttributes dwFlagsAndAttributes,
            IntPtr hTemplateFile);

        [DllImport("hid.dll", SetLastError = true)]
        static extern Boolean HidD_GetAttributes(SafeFileHandle HidDeviceObject, ref HIDD_ATTRIBUTES Attributes);

        [DllImport("coredll.dll", SetLastError = true, CallingConvention = CallingConvention.Winapi, CharSet = CharSet.Auto)]
        [return: MarshalAs(UnmanagedType.Bool)]
        public static extern bool CloseHandle(SafeHandle hObject);

        /*******************************************************************************
                   API constants, listed alphabetically
       *******************************************************************************/

        //from setupapi.h
        public const int DIGCF_PRESENT = 0
            ;
        public const int DIGCF_DEVICEINTERFACE = 0x10;
        public const long FILE_FLAG_OVERLAPPED = 0x40000000;
        public const long FILE_SHARE_READ = 0x1;
        public const long FILE_SHARE_WRITE = 0x2;
        public const long FORMAT_MESSAGE_FROM_SYSTEM = 0x1000;
        public const long GENERIC_READ = 0x80000000;
        public const long GENERIC_WRITE = 0x40000000;

        /* Typedef enum defines a set of integer constants for HidP_Report_Type
Remember to declare these as integers (16 bits)
        */
        public const int HidP_Input = 0;
        public const int HidP_Output = 1;
        public const int HidP_Feature = 2;
        public const int OPEN_EXISTING = 3;
        public const long WAIT_TIMEOUT = 0x102L;
        public const int WAIT_OBJECT_0 = 0;
        #endregion




        #region    User-defined types for API calls, listed alphabetically

        public unsafe struct GUID
        {
            public int Data1;
            public System.UInt16 Data2;
            public System.UInt16 Data3;
            [MarshalAs(UnmanagedType.ByValArray, SizeConst = 8)]
            public byte[] data4;
        }

        public struct SECURITY_ATTRIBUTES
        {
            public long nLength;
            public long lpSecurityDescriptor;
            public bool bInheritHandle;
        }



        [StructLayout(LayoutKind.Sequential)]
        public struct SP_DEVICE_INTERFACE_DATA2
        {
            public uint cbSize;
            public Guid interfaceClassGuid;
            public uint lags;
            public IntPtr reserved;
        }

        [StructLayout(LayoutKind.Sequential)]
        public struct SP_DEVICE_INTERFACE_DATA1
        {
            public uint cbSize;
            public GUID interfaceClassGuid;
            public uint lags;
            public IntPtr reserved;
        }

        [StructLayout(LayoutKind.Sequential)]
        public struct HIDD_ATTRIBUTES
        {
            public Int32 Size;
            public Int16 VendorID;
            public Int16 ProductID;
            public Int16 VersionNumber;
        }

        public struct SP_DEVINFO_DATA
        {
            public uint cbSize;
            public GUID classGuid;
            public uint devInst;
            public IntPtr reserved;
        }

        [StructLayout(LayoutKind.Sequential)]
        public struct SP_DEVICE_INTERFACE_DETAIL_DATA // user made struct to store device path
        {
            public UInt32 cbSize;
            [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 256)]
            public string DevicePath;
        }
    
        #endregion


        #region Methods
        public static void Connect()
        {
            //Makes a series of API calls to locate the desired HID-class device.
            //'Returns True if the device is detected, False if not detected.
            //'Modified from Jan Axelson's HID example

            long VID;
            long PID;
            Int32 Count;
            String GUIDString;
            //Guid gid = new Guid("5175d334-c371-4806-b3ba-71fd53c9258d");
            Guid gid = new Guid();
            Security.lpSecurityDescriptor = 0;
            Security.bInheritHandle = true;
            Security.nLength = Security.ToString().Length;

            /*Close Handles*/
            HIDhandleArray = new List<SafeHandle>();
            memberIndex = 0;
            try
            {

                if (HIDhandleArray.Count != 0)
                    CloseHandles();

                //Obtain GUID for HID device interface class
                HidD_GetHidGuid(ref HidGuid);
                HidD_GetHidGuid(ref gid);
                /*Help:-http://stackoverflow.com/questions/12693429/pinvoke-method-for-guid-in-c-sharp*/

                //do
                //{
                lastDevice = false;
                myDeviceDetected = false;

                DeviceInfoSetptr = SetupDiGetClassDevs(ref HidGuid, 0, IntPtr.Zero, DIGCF_PRESENT | DIGCF_DEVICEINTERFACE);
                //h2 = SetupDiGetClassDevs(ref gid, 0, IntPtr.Zero, DIGCF_PRESENT | DIGCF_DEVICEINTERFACE);
                // IntPtr p3=   SetupDiGetClassDevs(ref HidGuid, null, IntPtr.Zero, (uint)(DIGCF_PRESENT | DIGCF_DEVICEINTERFACE));
                dataString = GetDataString(DeviceInfoSetptr, 32);
                // string dataString1 = GetDataString(h1, 32);
                //  MemberIndex = 0

                do
                {
                    myDeviceInterfaceData1.cbSize = (uint)System.Runtime.InteropServices.Marshal.SizeOf(myDeviceInterfaceData1);
                    //myDeviceInterfaceData2.cbSize = (uint)System.Runtime.InteropServices.Marshal.SizeOf(myDeviceInterfaceData2);


                    bool api_status1 = SetupDiEnumDeviceInterfaces(DeviceInfoSetptr, IntPtr.Zero, ref HidGuid, memberIndex, ref myDeviceInterfaceData1);
                    int err1 = Marshal.GetLastWin32Error();
                    //bool api_status2 = SetupDiEnumDeviceInterfaces(h2, IntPtr.Zero, ref gid, 0, ref myDeviceInterfaceData2);
                    //int err2 = Marshal.GetLastWin32Error();
                    if (!api_status1)
                    {
                        lastDevice = true;
                    }
                    else
                    {
                        myDeviceInfoData.cbSize = (uint)System.Runtime.InteropServices.Marshal.SizeOf(myDeviceInfoData);
                        SP_DEVICE_INTERFACE_DETAIL_DATA didd = new SP_DEVICE_INTERFACE_DETAIL_DATA();
                        if (IntPtr.Size == 8) // for 64 bit operating systems
                            didd.cbSize = 8;
                        else
                            didd.cbSize = (uint)(4 + Marshal.SystemDefaultCharSize); // for 32 bit systems
                        int needed = 0, nBytes = 0, detailData;
                        //api_status1 = SetupDiGetDeviceInterfaceDetail(h1, ref myDeviceInterfaceData,IntPtr.Zero, 0, ref needed, IntPtr.Zero);
                        api_status1 = SetupDiGetDeviceInterfaceDetail(DeviceInfoSetptr, ref myDeviceInterfaceData1, IntPtr.Zero, 0, ref needed, IntPtr.Zero);

                        detailData = needed;
                        // SP_DEVICE_INTERFACE_DETAIL_DATA myDeviceInterfaceDetailData = new SP_DEVICE_INTERFACE_DETAIL_DATA();
                        // myDeviceInterfaceDetailData.cbSize = (uint)System.Runtime.InteropServices.Marshal.SizeOf(myDeviceInterfaceDetailData);
                        byte[] detailDataBuffer = new byte[needed];
                        RtlMoveMemory(ref detailDataBuffer[0], ref didd, 4);
                        ////string  s = Encoding.ASCII.GetString(detailDataBuffer, 0, detailDataBuffer.Length);

                        try
                        {
                            api_status1 = SetupDiGetDeviceInterfaceDetail(DeviceInfoSetptr, ref myDeviceInterfaceData1, ref detailDataBuffer[0], detailData, ref needed, IntPtr.Zero);
                            // From byte array to string
                            String devicePath = "";
                            devicePath = devicePath + devicePath;
                            devicePath = Encoding.Unicode.GetString(detailDataBuffer, 0, detailDataBuffer.Length);
                            devicePath = devicePath.Substring(2);


                            /*
                            ******************************************************************************
                            CreateFile
                            Returns: a handle that enables reading and writing to the device.
                            Requires:
                            The DevicePathName returned by SetupDiGetDeviceInterfaceDetail.
                            ******************************************************************************
                            */
                            SafeFileHandle filehandle = CreateFile(devicePath, FileAccess.Read, FileShare.ReadWrite, IntPtr.Zero, FileMode.OpenOrCreate, FileAttributes.Normal, IntPtr.Zero);
                            int err5 = Marshal.GetLastWin32Error();
                            HIDD_ATTRIBUTES deviceAttributes = new HIDD_ATTRIBUTES();
                            deviceAttributes.Size = System.Runtime.InteropServices.Marshal.SizeOf(deviceAttributes);
                            api_status1 = HidD_GetAttributes(filehandle, ref deviceAttributes);
                            const long DEFAULT_VENDOR_ID = 0x9AA;
                            const long DEFAULT_PRODUCT_ID = 0x2019;
                            VID = (DEFAULT_VENDOR_ID & 0x7FFF) - (DEFAULT_VENDOR_ID & 0x8000);
                            PID = (DEFAULT_PRODUCT_ID & 0x7FFF) - (DEFAULT_PRODUCT_ID & 0x8000);

                            if ((deviceAttributes.VendorID == VID) && (deviceAttributes.ProductID == PID))
                            {
                                myDeviceDetected = true;
                                HIDhandleArray.Add(filehandle);
                                //Get another handle for the overlapped ReadFiles.
                                SafeHandle readFileHandle = CreateFile(devicePath, FileAccess.ReadWrite, FileShare.ReadWrite, IntPtr.Zero, FileMode.Open, FileAttributes.Normal, IntPtr.Zero);
                                ReadHandleArray.Add(readFileHandle);

                            }
                            else
                            {
                                CloseHandle(filehandle);
                            }

                        }
                        catch (Exception ex)
                        {
                        }
                    }
                    memberIndex = memberIndex + 1;
                } while (!lastDevice);

                bool status = SetupDiDestroyDeviceInfoList(DeviceInfoSetptr);


                if (myDeviceDetected == false)
                {
                    throw new CustomEx();
                }

                //} while (true);
                if (myDeviceDetected == true)
                {
                    //PrepareForOverlappedTransfer;
                }
            }
            catch (CustomEx ex) { throw ex; }

            catch (Exception ex) { throw new Exception(); }
            //frmMain.cboEVB_init;
        }

        public static void CloseHandles()
        {

        }

        /// <summary>
        /// Retrieves a string of length Bytes from memory, beginning at Address.
        ///Adapted from Dan Appleman's Win32 API Puzzle Book"
        ///Modified from Jan Axelson's HID example
        /// </summary>
        /// <param name="address"></param>
        /// <param name="bytes"></param>
        /// <returns></returns>
        public static string GetDataString(IntPtr address, long bytes)
        {

            string result = string.Empty;
            //byte thisByte = 0;
            byte thisByte = 0;
            //address = 107227880;

        

            for (int Offset = 0; Offset <= bytes - 1; Offset++)
            {
                //IntPtr p1 = Marshal.AllocHGlobal(1);
                //IntPtr p2 = new IntPtr(107227880 + Offset);

                unsafe
                {
                    //fixed (byte* p = thisByte)
                    //{
                    //    p1 = (IntPtr)p;
                    //}
                    RtlMoveMemory(ref thisByte, (address + Offset), 1);
                    if ((thisByte & 0xf0) == 0)
                        result = result + "0";
                }
                result = result + new StringBuilder().AppendFormat("{0:x2}", thisByte) + " ";
            }

            return result;
        }
        #endregion

        

    }
}
