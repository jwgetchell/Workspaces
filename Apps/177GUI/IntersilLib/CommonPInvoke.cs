/**********************************************************************
 Module     : Repository
 Modified On : 20-May-2014      
 Class file : CommonPInvoke.cs
 This class provides :
 1) The signature  of the windows API functions(P/Invoke)
 2) The user defines datastructures 
 
 **************************************************************************/

using System;
using System.IO;
using System.Runtime.InteropServices;

namespace IntersilLib
{
    class CommonPInvoke
    {

        #region Window API Functions for p/invoking
        /// <summary>
        /// copies the contents of a source memory block to a destination memory block, 
        /// and supports overlapping source and destination memory blocks.
        /// The RtlCopyMemory routine runs faster than RtlMoveMemory, 
        /// but RtlCopyMemory requires that the source and destination memory blocks do not overlap.
        /// </summary>
        /// <param name="dest">A pointer to the destination memory block to copy the bytes to.</param>
        /// <param name="src">A pointer to the source memory block to copy the bytes from.</param>
        /// <param name="count">The number of bytes to copy from the source to the destination.</param>
        [DllImport("kernel32", CharSet = CharSet.Auto, SetLastError = true)]
        unsafe public static extern void RtlMoveMemory(ref byte dest, IntPtr src, uint count);

        //[DllImport("kernel32", CharSet = CharSet.Auto, SetLastError = true)]
        //unsafe public static extern long RtlMoveMemory(ref byte dest, IntPtr src, uint count);
        /// <summary>
        /// copies the contents of a source memory block to a destination memory block, 
        /// and supports overlapping source and destination memory blocks.
        /// The RtlCopyMemory routine runs faster than RtlMoveMemory, 
        /// but RtlCopyMemory requires that the source and destination memory blocks do not overlap.
        /// </summary>
        /// <param name="dest">A pointer to the destination memory block to copy the bytes to.</param>
        /// <param name="src">A pointer to the source memory block to copy the bytes from.</param>
        /// <param name="count">The number of bytes to copy from the source to the destination.</param>
        [DllImport("kernel32", CharSet = CharSet.Auto, SetLastError = true)]
        unsafe public static extern void RtlMoveMemory(ref byte dest, ref SP_DEVICE_INTERFACE_DETAIL_DATA src, uint count);

        /// <summary>
        /// returns the device interfaceGUID for HIDClass devices.
        /// </summary>
        /// <param name="DeviceInfoSet">Pointer to a caller-allocated GUID buffer 
        /// that the routine uses to return the device interface GUID for HIDClass devices.</param>
        [DllImport("hid.dll", EntryPoint = "HidD_GetHidGuid", SetLastError = true)]
        public static extern void HidD_GetHidGuid(ref Guid HidGuid);


        /// <summary>
        /// Deletes a device information set and frees all associated memory.
        /// </summary>
        /// <param name="DeviceInfoSet">A handle to the device information set to delete.</param>
        /// <returns>The function returns TRUE if it is successful.
        /// Otherwise, it returns FALSE.
        /// The logged error can be retrieved with a call to GetLastError.</returns>
        [DllImport("setupapi.dll", SetLastError = true)]
        public static extern bool SetupDiDestroyDeviceInfoList
        (
             IntPtr DeviceInfoSet
        );


        /// <summary>
        /// Returns a handle to a device information set that contains requested device information elements for a local computer.
        /// </summary>
        /// <param name="ClassGuid"></param>
        /// <param name="Enumerator"></param>
        /// <param name="hwndParent"></param>
        /// <param name="Flags">A variable of type DWORD that specifies control options that filter the device information 
        /// elements that are added to the device information set. This parameter can be a bitwise OR of zero
        /// or  of the following flags : 
        /// DIGCF_PRESENT : Return only devices that are currently present in a system.
        /// </param>
        /// <returns></returns>
        [DllImport("setupapi.dll", CharSet = CharSet.Auto)]
        public static extern IntPtr SetupDiGetClassDevs(ref Guid ClassGuid, int Enumerator, IntPtr hwndParent, uint Flags);

        /// <summary>
        /// Get details about a device interface.
        /// </summary>
        /// <param name="hDevInfo">A pointer to the device information set that contains the interface for which to retrieve details. 
        /// This handle is typically returned by SetupDiGetClassDevs.</param>
        /// <param name="deviceInterfaceData">A pointer to an SP_DEVICE_INTERFACE_DATA structure that specifies the interface 
        /// in DeviceInfoSet for which to retrieve details. 
        /// A pointer of this type is typically returned by SetupDiEnumDeviceInterfaces.
        /// </param>
        /// <param name="deviceInterfaceDetailData">A pointer to an SP_DEVICE_INTERFACE_DETAIL_DATA structure to receive 
        /// information about the specified interface. This parameter is optional and can be NULL.
        /// </param>
        /// <param name="deviceInterfaceDetailDataSize">The size of the DeviceInterfaceDetailData buffer. </param>
        /// <param name="requiredSize">A ref to a variable that receives the required size of the DeviceInterfaceDetailData buffer.
        /// This size includes the size of the fixed part of the structure plus the number of bytes required for the variable-length device path string. 
        /// </param>
        /// <param name="deviceInfoData">A pointer to a buffer that receives information about the device that supports the requested interface.
        /// The caller must set DeviceInfoData.cbSize to sizeof(SP_DEVINFO_DATA).</param>
        /// <returns>Returns TRUE if the function completed without error. 
        /// If the function completed with an error, FALSE is returned and the error code for the failure can be retrieved by calling GetLastError.</returns>
        [DllImport(@"setupapi.dll", CharSet = CharSet.Auto, SetLastError = true)]
        public static extern Boolean SetupDiGetDeviceInterfaceDetail(
           IntPtr hDevInfo,
           ref SP_DEVICE_INTERFACE_DATA deviceInterfaceData,
           IntPtr deviceInterfaceDetailData,
           int deviceInterfaceDetailDataSize,
           ref int requiredSize,
           IntPtr deviceInfoData
        );

        /// <summary>
        /// 
        /// </summary>
        /// <param name="hDevInfo"></param>
        /// <param name="deviceInterfaceData"></param>
        /// <param name="deviceInterfaceDetailData"></param>
        /// <param name="deviceInterfaceDetailDataSize"></param>
        /// <param name="requiredSize"></param>
        /// <param name="deviceInfoData"></param>
        /// <returns></returns>
        [DllImport(@"setupapi.dll", CharSet = CharSet.Auto, SetLastError = true)]
        public static extern Boolean SetupDiGetDeviceInterfaceDetail(
           IntPtr hDevInfo,
           ref SP_DEVICE_INTERFACE_DATA deviceInterfaceData,
           ref byte deviceInterfaceDetailData,
           int deviceInterfaceDetailDataSize,
           ref int requiredSize,
            IntPtr deviceInfoData
        );

        /// <summary>
        /// 
        /// </summary>
        /// <param name="lpFileName"></param>
        /// <param name="dwDesiredAccess"></param>
        /// <param name="dwShareMode"></param>
        /// <param name="lpSecurityAttributes"></param>
        /// <param name="dwCreationDisposition"></param>
        /// <param name="dwFlagsAndAttributes"></param>
        /// <param name="hTemplateFile"></param>
        /// <returns></returns>
        [DllImport("kernel32.dll", SetLastError = true, CharSet = CharSet.Auto)]
        public static extern IntPtr CreateFile(
            string lpFileName,
            [MarshalAs(UnmanagedType.U4)] FileAccess dwDesiredAccess,
            [MarshalAs(UnmanagedType.U4)] FileShare dwShareMode,
            IntPtr lpSecurityAttributes,
            [MarshalAs(UnmanagedType.U4)] FileMode dwCreationDisposition,
          [MarshalAs(UnmanagedType.U4)] FileAttributes dwFlagsAndAttributes,
            IntPtr hTemplateFile);



        [DllImport("kernel32.dll", SetLastError = true, CharSet = CharSet.Auto)]
        public static extern IntPtr CreateFile(
            string lpFileName,
            [MarshalAs(UnmanagedType.U4)] FileAccess dwDesiredAccess,
            [MarshalAs(UnmanagedType.U4)] FileShare dwShareMode,
            IntPtr lpSecurityAttributes,
            [MarshalAs(UnmanagedType.U4)] FileMode dwCreationDisposition,
           uint dwFlagsAndAttributes,
            IntPtr hTemplateFile);

        /// <summary>
        /// Creates or opens a file or I/O device. 
        /// </summary>
        /// <param name="filename">The name of the file or device to be created or opened. 
        /// You may use either forward slashes (/) or backslashes (\) in this name.</param>
        /// <param name="desiredAccess">The requested access to the file or device.
        /// which can be summarized as read, write, both or neither zero</param>
        /// <param name="shareMode">The requested sharing mode of the file or device
        /// which can be read, write, both, delete, all of these, or none </param>
        /// <param name="attributes">A pointer to a SECURITY_ATTRIBUTES structure.It is optional</param>
        /// <param name="creationDisposition">An action to take on a file or device that exists or does not exist.
        /// For devices other than files, this parameter is usually set to OPEN_EXISTING.
        /// OPEN_EXISTING 3: Opens a file or device, only if it exists.
        /// If the specified file or device does not exist, the function fails and the last-error code is set to ERROR_FILE_NOT_FOUND (2).
        /// </param>
        /// <param name="flagsAndAttributes">The file or device attributes and flags, 
        /// FILE_ATTRIBUTE_NORMAL being the most common default value for files</param>
        /// <param name="templateFile">An optional  valid handle to a template file with the GENERIC_READ access right.
        /// The template file supplies file attributes and extended attributes for the file that is being created.</param>
        /// <returns>Returns a handle that can be used to access the file or device for various types of I/O depending on the file or device and the flags and attributes specified.</returns>
        [DllImport("kernel32", SetLastError = true)]
        public static extern IntPtr CreateFile(string filename,       // file name
                                        uint desiredAccess,    // read? write?
                                        uint shareMode,        // sharing
                                        uint attributes,       // SecurityAttributes pointer
                                        uint creationDisposition,
                                        uint flagsAndAttributes,
                                        uint templateFile);


        /// <summary>
        /// 
        /// </summary>
        /// <param name="HidDeviceObject">Specifies an open handle to a top-level collection.</param>
        /// <param name="Attributes">Pointer to a caller-allocated HIDD_ATTRIBUTES structure 
        /// that returns the attributes of the collection specified by HidDeviceObject.</param>
        /// <returns>Returns the attributes of a specified top-level collection.</returns>
        [DllImport("hid.dll", SetLastError = true)]
        public static extern Boolean HidD_GetAttributes(IntPtr HidDeviceObject, ref HIDD_ATTRIBUTES Attributes);


        /// <summary>
        /// Closes an open object handle.
        /// </summary>
        /// <param name="hObject">A valid handle to an open object.</param>
        /// <returns>If the function succeeds, the return value is true.</returns>
        [DllImport("kernel32.dll", SetLastError = true)]
        [return: MarshalAs(UnmanagedType.Bool)]
        public static extern bool CloseHandle(IntPtr hObject);

        /// <summary>
        /// The SetupDiEnumDeviceInterfaces function enumerates the device interfaces that are contained in a device information set.
        /// Repeated calls to this function return an SP_DEVICE_INTERFACE_DATA structure for a different device interface.
        /// </summary>
        /// <param name="hDevInfo"></param>
        /// <param name="devInfo"></param>
        /// <param name="interfaceClassGuid"></param>
        /// <param name="memberIndex"></param>
        /// <param name="deviceInterfaceData">A pointer to a caller-allocated buffer that contains, on successful return, 
        /// a completed SP_DEVICE_INTERFACE_DATA structure that identifies an interface that meets the search parameters.</param>
        /// <returns></returns>
        [DllImport(@"setupapi.dll", CharSet = CharSet.Auto, SetLastError = true)]
        public static extern Boolean SetupDiEnumDeviceInterfaces(IntPtr hDevInfo, IntPtr devInfo, ref  Guid interfaceClassGuid, UInt32 memberIndex, ref SP_DEVICE_INTERFACE_DATA deviceInterfaceData);

        /// <summary>
        /// This function creates a named or an unnamed event object.
        /// </summary>
        /// <param name="lpEventAttributes"></param>
        /// <param name="bManualReset">Specifies whether a manual-reset or auto-reset event object is created.
        /// If TRUE, then you must use the ResetEvent function to manually reset the state to nonsignaled
        ///  If FALSE, the system automatically resets the state to nonsignaled after a single waiting thread has been released.
        /// </param>
        /// <param name="bInitialState">specifies the initial state of the event object. If TRUE, the initial state is signaled; otherwise, it is nonsignaled.</param>
        /// <param name="lpName">Specifies the name of the event object.
        /// If lpName is NULL, the event object is created without a name.
        /// If lpName matches the name of an existing named event object, the bManualReset and 
        /// bInitialState parameters are ignored because they have already been set by the creation process.</param>
        /// <returns>A handle to the event object.
        /// If the named event object existed before you call this function, CreateEvent returns a handle to the existing object
        /// </returns>
        [DllImport("kernel32.dll")]
        public static extern IntPtr CreateEvent(ref SECURITY_ATTRIBUTES lpEventAttributes, bool bManualReset, bool bInitialState, string lpName);


        /// <summary>
        /// Reads data from the specified file or input/output (I/O) device.
        /// Reads occur at the position specified by the file pointer if supported by the device.
        /// </summary>
        /// <param name="hFile">A handle to the device</param>
        /// <param name="lpBuffer">A pointer to the buffer that receives the data read from a file or device.</param>
        /// <param name="nNumberOfBytesToRead">The maximum number of bytes to be read.</param>
        /// <param name="lpNumberOfBytesRead">A pointer to the variable that receives the number of bytes
        /// read when using a synchronous hFile parameter.</param>
        /// <param name="lpOverlapped">A pointer to an OVERLAPPED structure is required if the hFile parameter was opened with FILE_FLAG_OVERLAPPED, otherwise it can be NULL.</param>
        /// <returns>If the function succeeds, the return value is nonzero (TRUE).</returns>
        [DllImport("kernel32.dll")]
        public static extern bool ReadFile(IntPtr hFile, byte[] lpBuffer, uint nNumberOfBytesToRead, out uint lpNumberOfBytesRead, ref OVERLAPPED overlapped);

        /// <summary>
        /// Writes data to the specified file or input/output (I/O) device.
        /// </summary>
        /// <param name="hFile">A handle to the file or I/O device </param>
        /// <param name="lpBuffer">A pointer to the buffer containing the data to be written to the file or device.</param>
        /// <param name="nNumberOfBytesToWrite">The number of bytes to be written to the file or device.</param>
        /// <param name="lpNumberOfBytesWritten">A pointer to the variable that receives the number of bytes written when using a synchronous hFile parameter.</param>
        /// <param name="hid">A pointer to an OVERLAPPED structure is required if the hFile parameter was opened with FILE_FLAG_OVERLAPPED,
        /// otherwise this parameter can be NULL.</param>
        /// <returns>If the function succeeds, the return value is nonzero (TRUE).</returns>
        [DllImport("kernel32.dll", CharSet = CharSet.Auto, SetLastError = true)]
        public static extern Int16 WriteFile(IntPtr hFile, byte[] lpBuffer, uint nNumberOfBytesToWrite, out uint lpNumberOfBytesWritten, IntPtr hid);

        /// <summary>
        /// Waits until the specified object is in the signaled state or the time-out interval elapses.
        /// </summary>
        /// <param name="hHandle">A handle to the object.
        /// If this handle is closed while the wait is still pending, the function's behavior is undefined.
        /// </param>
        /// <param name="dwMilliseconds">The time-out interval, in milliseconds. 
        /// If dwMilliseconds is zero, the function does not enter a wait state if the object is not signaled; it always returns immediately. 
        /// </param>
        /// <returns>If the function succeeds, the return value indicates the event that caused the function to return.
        /// </returns>
        [DllImport("kernel32.dll", CharSet = CharSet.Auto, SetLastError = true)]
        public static extern UInt32 WaitForSingleObject(IntPtr hHandle, uint dwMilliseconds);

        /// <summary>
        /// Sets the specified event object to the nonsignaled state.
        /// </summary>
        /// <param name="hHandle">A handle to the event object. The CreateEvent or OpenEvent function returns this handle.</param>
        /// <returns>If the function succeeds, the return value is nonzero.</returns>
        [DllImport("kernel32.dll", SetLastError = true)]
        public static extern long ResetEvent(IntPtr hHandle);

        /// <summary>
        /// Cancels all pending input and output (I/O) operations  for the specified file.
        /// </summary>
        /// <param name="hHandle">A handle to the file.</param>
        /// <returns>If the function succeeds, the return value is nonzero.</returns>
        [DllImport("kernel32.dll", SetLastError = true)]
        public static extern Int16 CancelIo(IntPtr hHandle);



        #endregion

    }


    #region Userdefined Datastructure for P/Invoke Windows API
    /// <summary>
    /// This structure provides security settings for objects created by various functions, such as CreateFile, CreatePipe, CreateProcess or RegCreateKeyEx
    /// </summary>
    public struct SECURITY_ATTRIBUTES
    {
        /// <summary>
        /// The size, in bytes, of this structure.
        /// </summary>
        public int nLength;

        /// <summary>
        /// A pointer to a SECURITY_DESCRIPTOR structure that controls access to the object
        /// SECURITY_DESCRIPTOR structure contains the security information associated with an object.
        /// </summary>
        public IntPtr lpSecurityDescriptor;

        /// <summary>
        /// A Boolean value that specifies whether the returned handle is inherited when a new process is created. 
        /// If this member is TRUE, the new process inherits the handle.
        /// </summary>
        public bool bInheritHandle;
    }

    /// <summary>
    /// An SP_DEVICE_INTERFACE_DATA structure defines a device interface in a device information set.
    /// </summary>
    [StructLayout(LayoutKind.Sequential)]
    public struct SP_DEVICE_INTERFACE_DATA
    {
        /// <summary>
        /// The size, in bytes, of the SP_DEVICE_INTERFACE_DATA structure. 
        /// </summary>
        public uint cbSize;

        /// <summary>
        /// The Guid for the class to which the device interface belongs.
        /// </summary>
        public Guid interfaceClassGuid;
        /// <summary>
        /// Can be one or more of the following:
        /// SPINT_ACTIVE : The interface is active (enabled).
        /// SPINT_DEFAULT : The interface is the default interface for the device class.
        /// SPINT_REMOVED : The interface is removed.
        /// </summary>
        public uint Flags { get; set; }


        public IntPtr reserved;
    }


    /// <summary>
    /// The HIDD_ATTRIBUTES structure contains vendor information about a HIDClass device.
    /// A caller of HidD_GetAttributes, uses this structure to obtain a device's vendor information.
    /// Before using a HIDD_ATTRIBUTES structure with HIDClass support routines, the caller must set the Size member.
    /// </summary>
    [StructLayout(LayoutKind.Sequential)]
    public struct HIDD_ATTRIBUTES
    {
        /// <summary>
        /// Specifies the size, in bytes, of a HIDD_ATTRIBUTES structure.
        /// </summary>
        public Int32 Size;

        /// <summary>
        /// Specifies a HID device's vendor ID.
        /// </summary>
        public Int16 VendorID;

        /// <summary>
        /// Specifies a HID device's product ID.
        /// </summary>
        public Int16 ProductID;

        /// <summary>
        /// Specifies the manufacturer's revision number for a HIDClass device.
        /// </summary>
        public Int16 VersionNumber;
    }

    /// <summary>
    ///  contains the path for a device interface.
    /// </summary>
    [StructLayout(LayoutKind.Sequential)]
    public struct SP_DEVICE_INTERFACE_DETAIL_DATA
    {
        /// <summary>
        /// Size of the structure, in bytes.
        /// </summary>
        public UInt32 cbSize;

        /// <summary>
        /// NULL-terminated string that specifies the device path.
        /// </summary>
        [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 256)]
        public string DevicePath;
    }

    /// <summary>
    /// An SP_DEVINFO_DATA structure defines a device instance that is a member of a device information set.
    /// </summary>
    public struct SP_DEVINFO_DATA
    {
        /// <summary>
        /// The size, in bytes, of the SP_DEVINFO_DATA structure.
        /// </summary>
        public uint cbSize;

        /// <summary>
        /// The Guid of the device's setup class.
        /// </summary>
        public Guid classGuid;

        /// <summary>
        /// An opaque handle to the device instance (also known as a handle to the devnode).
        /// </summary>
        public uint devInst;

        /// <summary>
        /// Reserved. For internal use only.
        /// </summary>
        public IntPtr reserved;
    }

    /*
     When a function is executed synchronously, it does not return until the operation has been completed.
     Functions called for overlapped operation can return immediately, even though the operation has not been completed. 
     This enables a time-consuming I/O operation to be executed in the background while the calling thread is free to perform other tasks
     * */
    /// <summary>
    /// Contains information used in asynchronous (or overlapped) input and output.
    /// </summary>
    public struct OVERLAPPED
    {
        /// <summary>
        /// The status code for the I/O request. When the request is issued, the system sets this member to STATUS_PENDING to indicate that the operation has not yet 
        /// started. When the request is completed, the system sets this member to the status code for the completed request.
        /// </summary>
        public IntPtr Internal;

        /// <summary>
        /// The number of bytes transferred for the I/O request. The system sets this member if the request is completed without errors.
        /// </summary>
        public IntPtr InternalHigh;

        /// <summary>
        /// The low-order portion of the file position at which to start the I/O request, as specified by the user.
        /// This member is nonzero only when performing I/O requests on a seeking device that supports the concept of an offset 
        /// (also referred to as a file pointer mechanism), such as a file. Otherwise, this member must be zero.
        /// </summary>
        public IntPtr Offset;

        /// <summary>
        /// The high-order portion of the file position at which to start the I/O request, as specified by the user.
        /// </summary>
        public IntPtr OffsetHigh;

        /// <summary>
        /// A handle to the event that will be set to a signaled state by the system when the operation has completed. 
        /// The user must initialize this member either to zero or a valid event handle using the CreateEvent function before passing this structure to any overlapped functions. 
        /// </summary>
        public IntPtr HandleEvent;
    }

    #endregion
}


