Option Strict Off
Option Explicit On
Imports VB = Microsoft.VisualBasic
Module modHID
	'-----------------------------------------------------------------------------
	' modHID.bas
	'-----------------------------------------------------------------------------
	' Copyright 2010 Intersil, Inc.
	' http://www.intersil.com
	'
	' Program Description:
	'
	' VB6 HID module.
	'
	' Project Name:   generic
	'
	'
	' Release 1.0
	'   -100803 Initial Revision (Tushar Mazumder)
	'
	' this module should not need to be modified
	
	
	'******************************************************************************
	'Proprietary constants
	'******************************************************************************
	
	Public Const DEFAULT_REPORT_ID As Byte = 0 'default for implicit report IDs
	Public Const SHORT_REPORT_ID As Byte = 1
	Public Const USB_WRITE_ERROR As Short = 4
	Public Const USB_READ_ERROR As Short = 2
	Public Const I2C_NACK_ERROR As Short = 1
	Public Const API_FAIL As Short = 0 'API functions return non-0 upon success, to easily denote 'true' for C programs
	Public Const I2C_SUCCESS As Short = 8 'we'll also use a non-0 value to denote success, since returning a '0' would lead to trouble when mixed with API's returns.
	Public Const GP_SUCCESS As Short = 8
	Public Const GP_FAIL As Short = 0
	Public Const REPORT_SIZE As Short = 64
	Public Const IOBufSize As Byte = REPORT_SIZE - 1 'so that we get REPORT_SIZE elements; VB is weird
	
	
	'******************************************************************************
	'Public variables
	'******************************************************************************
	
	Public msgBoxVal As Short 'value returned by user from a message box
	Public I2C_Slave_Address As Byte
	Public IOBuf(IOBufSize) As Byte 'io buffer; see 'HID Buffer Structure' for details
	
	'the following are used to find and connect to HID
	Public bAlertable As Integer
	Public EventObject As Integer
	Public HIDhandle As Integer
	Public HIDOverlapped As OVERLAPPED
	Public ReadHandle As Integer
	Public Security As SECURITY_ATTRIBUTES
	Public HIDhandleArray() As Integer
	Public readHandleArray() As Integer
	'UPGRADE_NOTE: status was upgraded to status_Renamed. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="A9E4979A-37FA-4718-9994-97DD76ED70A7"'
	Public status_Renamed As Boolean
	
	
	'******************************************************************************
	'API constants, listed alphabetically
	'******************************************************************************
	
	'from setupapi.h
	Public Const DIGCF_PRESENT As Integer = &H2
	Public Const DIGCF_DEVICEINTERFACE As Integer = &H10
	Public Const FILE_FLAG_OVERLAPPED As Integer = &H40000000
	Public Const FILE_SHARE_READ As Integer = &H1
	Public Const FILE_SHARE_WRITE As Integer = &H2
	Public Const FORMAT_MESSAGE_FROM_SYSTEM As Integer = &H1000
	Public Const GENERIC_READ As Integer = &H80000000
	Public Const GENERIC_WRITE As Integer = &H40000000
	
	'Typedef enum defines a set of integer constants for HidP_Report_Type
	'Remember to declare these as integers (16 bits)
	Public Const HidP_Input As Short = 0
	Public Const HidP_Output As Short = 1
	Public Const HidP_Feature As Short = 2
	
	Public Const OPEN_EXISTING As Short = 3
	Public Const WAIT_TIMEOUT As Integer = &H102
	Public Const WAIT_OBJECT_0 As Short = 0
	
	
	'******************************************************************************
	'User-defined types for API calls, listed alphabetically
	'******************************************************************************
	
    Public Structure GUID_ ' JWG
        Dim Data1 As Integer
        Dim Data2 As Short
        Dim Data3 As Short
        '<VBFixedArray(7)> Dim Data4() As Byte
        Dim Data40, Data41, Data42, Data43, Data44, Data45, Data46, Data47 As Byte

        ''UPGRADE_TODO: "Initialize" must be called to initialize instances of this structure. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="B4BFF9E0-8631-45CF-910E-62AB3970F27B"'
        'Public Sub Initialize()
        '    ReDim Data4(7)
        'End Sub
    End Structure

    Public Structure byte100
        Dim _
            _00, _01, _02, _03, _04, _05, _06, _07, _08, _09, _
            _10, _11, _12, _13, _14, _15, _16, _17, _18, _19, _
            _20, _21, _22, _23, _24, _25, _26, _27, _28, _29, _
            _30, _31, _32, _33, _34, _35, _36, _37, _38, _39, _
            _40, _41, _42, _43, _44, _45, _46, _47, _48, _49, _
            _50, _51, _52, _53, _54, _55, _56, _57, _58, _59, _
            _60, _61, _62, _63, _64, _65, _66, _67, _68, _69, _
            _70, _71, _72, _73, _74, _75, _76, _77, _78, _79, _
            _80, _81, _82, _83, _84, _85, _86, _87, _88, _89, _
            _90, _91, _92, _93, _94, _95, _96, _97, _98, _99 _
        As Byte
    End Structure
	
	Public Structure HIDD_ATTRIBUTES
		Dim Size As Integer
		Dim VendorID As Short
		Dim ProductID As Short
		Dim VersionNumber As Short
	End Structure
	
	'Windows 98 DDK documentation is incomplete.
	'Use the structure defined in hidpi.h
	Public Structure HIDP_CAPS
		Dim Usage As Short
		Dim UsagePage As Short
		Dim InputReportByteLength As Short
		Dim OutputReportByteLength As Short
		Dim FeatureReportByteLength As Short
		<VBFixedArray(16)> Dim Reserved() As Short
		Dim NumberLinkCollectionNodes As Short
		Dim NumberInputButtonCaps As Short
		Dim NumberInputValueCaps As Short
		Dim NumberInputDataIndices As Short
		Dim NumberOutputButtonCaps As Short
		Dim NumberOutputValueCaps As Short
		Dim NumberOutputDataIndices As Short
		Dim NumberFeatureButtonCaps As Short
		Dim NumberFeatureValueCaps As Short
		Dim NumberFeatureDataIndices As Short
		
		'UPGRADE_TODO: "Initialize" must be called to initialize instances of this structure. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="B4BFF9E0-8631-45CF-910E-62AB3970F27B"'
		Public Sub Initialize()
			ReDim Reserved(16)
		End Sub
	End Structure
	
	'If IsRange is false, UsageMin is the Usage and UsageMax is unused.
	'If IsStringRange is false, StringMin is the string index and StringMax is unused.
	'If IsDesignatorRange is false, DesignatorMin is the designator index and DesignatorMax is unused.
	Public Structure HidP_Value_Caps
		Dim UsagePage As Short
		Dim reportID As Byte
		Dim IsAlias As Integer
		Dim BitField As Short
		Dim LinkCollection As Short
		Dim LinkUsage As Short
		Dim LinkUsagePage As Short
		Dim IsRange As Integer
		Dim IsStringRange As Integer
		Dim IsDesignatorRange As Integer
		Dim IsAbsolute As Integer
		Dim HasNull As Integer
		Dim Reserved As Byte
		Dim BitSize As Short
		Dim ReportCount As Short
		Dim Reserved2 As Short
		Dim Reserved3 As Short
		Dim Reserved4 As Short
		Dim Reserved5 As Short
		Dim Reserved6 As Short
		Dim LogicalMin As Integer
		Dim LogicalMax As Integer
		Dim PhysicalMin As Integer
		Dim PhysicalMax As Integer
		Dim UsageMin As Short
		Dim UsageMax As Short
		Dim StringMin As Short
		Dim StringMax As Short
		Dim DesignatorMin As Short
		Dim DesignatorMax As Short
		Dim DataIndexMin As Short
		Dim DataIndexMax As Short
	End Structure
	
	Public Structure OVERLAPPED
		Dim Internal As Integer
		Dim InternalHigh As Integer
		Dim Offset As Integer
		Dim OffsetHigh As Integer
		Dim hEvent As Integer
	End Structure
	
	Public Structure SECURITY_ATTRIBUTES
		Dim nLength As Integer
		Dim lpSecurityDescriptor As Integer
		Dim bInheritHandle As Integer
	End Structure
	
	Public Structure SP_DEVICE_INTERFACE_DATA
		Dim cbSize As Integer
		'UPGRADE_WARNING: Arrays in structure InterfaceClassGuid may need to be initialized before they can be used. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="814DF224-76BD-4BB4-BFFB-EA359CB9FC48"'
        Dim InterfaceClassGuid As GUID_
		Dim Flags As Integer
		Dim Reserved As Integer
		
		'UPGRADE_TODO: "Initialize" must be called to initialize instances of this structure. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="B4BFF9E0-8631-45CF-910E-62AB3970F27B"'
        'Public Sub Initialize() JWG
        '          InterfaceClassGuid.Initialize()
        'End Sub
	End Structure
	
	Public Structure SP_DEVICE_INTERFACE_DETAIL_DATA
		Dim cbSize As Integer
		Dim DevicePath As Byte
	End Structure
	
	Public Structure SP_DEVINFO_DATA
		Dim cbSize As Integer
		'UPGRADE_WARNING: Arrays in structure ClassGuid may need to be initialized before they can be used. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="814DF224-76BD-4BB4-BFFB-EA359CB9FC48"'
        Dim ClassGuid As GUID_
		Dim DevInst As Integer
		Dim Reserved As Integer
		
        ''UPGRADE_TODO: "Initialize" must be called to initialize instances of this structure. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="B4BFF9E0-8631-45CF-910E-62AB3970F27B"'
        'Public Sub Initialize() JWG
        '          ClassGuid.Initialize()
        '      End Sub
	End Structure
	
	
	'******************************************************************************
	'API functions, listed alphabetically
	'******************************************************************************
	
	Public Declare Function CancelIo Lib "kernel32" (ByVal hFile As Integer) As Integer
	
	Public Declare Function CloseHandle Lib "kernel32" (ByVal hObject As Integer) As Integer
	
	'UPGRADE_WARNING: Structure SECURITY_ATTRIBUTES may require marshalling attributes to be passed as an argument in this Declare statement. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="C429C3A5-5D47-4CD9-8F51-74A1616405DC"'
	Public Declare Function CreateEvent Lib "kernel32"  Alias "CreateEventA"(ByRef lpSecurityAttributes As SECURITY_ATTRIBUTES, ByVal bManualReset As Integer, ByVal bInitialState As Integer, ByVal lpName As String) As Integer
	
	'UPGRADE_WARNING: Structure SECURITY_ATTRIBUTES may require marshalling attributes to be passed as an argument in this Declare statement. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="C429C3A5-5D47-4CD9-8F51-74A1616405DC"'
	Public Declare Function CreateFile Lib "kernel32"  Alias "CreateFileA"(ByVal lpFileName As String, ByVal dwDesiredAccess As Integer, ByVal dwShareMode As Integer, ByRef lpSecurityAttributes As SECURITY_ATTRIBUTES, ByVal dwCreationDisposition As Integer, ByVal dwFlagsAndAttributes As Integer, ByVal hTemplateFile As Integer) As Integer
	
	Public Declare Function HidD_FlushQueue Lib "hid.dll" (ByRef HIDhandle As Integer) As Boolean
	
    'UPGRADE_ISSUE: Declaring a parameter 'As Any' is not supported. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="FAE78A8D-8978-4FD4-8208-5B7324A8F795"'
    ' JWG Any -> IntPtr
    Public Declare Function FormatMessage Lib "kernel32" Alias "FormatMessageA" (ByVal dwFlags As Integer, ByRef lpSource As IntPtr, ByVal dwMessageId As Integer, ByVal dwLanguageZId As Integer, ByVal lpBuffer As String, ByVal nSize As Integer, ByVal Arguments As Integer) As Integer
	
	Public Declare Function HidD_FreePreparsedData Lib "hid.dll" (ByRef PreparsedData As Integer) As Integer
	
	'UPGRADE_WARNING: Structure HIDD_ATTRIBUTES may require marshalling attributes to be passed as an argument in this Declare statement. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="C429C3A5-5D47-4CD9-8F51-74A1616405DC"'
	Public Declare Function HidD_GetAttributes Lib "hid.dll" (ByVal HidDeviceObject As Integer, ByRef Attributes As HIDD_ATTRIBUTES) As Integer
	
	'Declared as a function for consistency,
	'but returns nothing. (Ignore the returned value.)
	'UPGRADE_WARNING: Structure GUID may require marshalling attributes to be passed as an argument in this Declare statement. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="C429C3A5-5D47-4CD9-8F51-74A1616405DC"'
    Public Declare Function HidD_GetHidGuid Lib "hid.dll" (ByRef HidGuid As GUID_) As Integer
	
	Public Declare Function HidD_GetPreparsedData Lib "hid.dll" (ByVal HidDeviceObject As Integer, ByRef PreparsedData As Integer) As Integer
	
	'UPGRADE_WARNING: Structure HIDP_CAPS may require marshalling attributes to be passed as an argument in this Declare statement. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="C429C3A5-5D47-4CD9-8F51-74A1616405DC"'
	Public Declare Function HidP_GetCaps Lib "hid.dll" (ByVal PreparsedData As Integer, ByRef Capabilities As HIDP_CAPS) As Integer
	
	Public Declare Function HidP_GetValueCaps Lib "hid.dll" (ByVal ReportType As Short, ByRef ValueCaps As Byte, ByRef ValueCapsLength As Short, ByVal PreparsedData As Integer) As Integer
	
	Public Declare Function lstrcpy Lib "kernel32"  Alias "lstrcpyA"(ByVal dest As String, ByVal Source As Integer) As String
	
	Public Declare Function lstrlen Lib "kernel32"  Alias "lstrlenA"(ByVal Source As Integer) As Integer
	
	'UPGRADE_WARNING: Structure OVERLAPPED may require marshalling attributes to be passed as an argument in this Declare statement. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="C429C3A5-5D47-4CD9-8F51-74A1616405DC"'
	Public Declare Function ReadFile Lib "kernel32" (ByVal hFile As Integer, ByRef lpBuffer As Byte, ByVal nNumberOfBytesToRead As Integer, ByRef lpNumberOfBytesRead As Integer, ByRef lpOverlapped As OVERLAPPED) As Integer
	
	Public Declare Function ResetEvent Lib "kernel32" (ByVal hEvent As Integer) As Integer
	
	'UPGRADE_ISSUE: Declaring a parameter 'As Any' is not supported. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="FAE78A8D-8978-4FD4-8208-5B7324A8F795"'
	'UPGRADE_ISSUE: Declaring a parameter 'As Any' is not supported. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="FAE78A8D-8978-4FD4-8208-5B7324A8F795"'
    ' JWG Any -> IntPtr
    Public Declare Function RtlMoveMemory Lib "kernel32" (ByRef dest As IntPtr, ByRef src As IntPtr, ByVal Count As Integer) As Integer
	
	'UPGRADE_WARNING: Structure GUID may require marshalling attributes to be passed as an argument in this Declare statement. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="C429C3A5-5D47-4CD9-8F51-74A1616405DC"'
	Public Declare Function SetupDiCreateDeviceInfoList Lib "setupapi.dll" (ByRef ClassGuid As GUID, ByVal hwndParent As Integer) As Integer
	
	Public Declare Function SetupDiDestroyDeviceInfoList Lib "setupapi.dll" (ByVal DeviceInfoSet As Integer) As Integer
	
	'UPGRADE_WARNING: Structure SP_DEVICE_INTERFACE_DATA may require marshalling attributes to be passed as an argument in this Declare statement. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="C429C3A5-5D47-4CD9-8F51-74A1616405DC"'
	'UPGRADE_WARNING: Structure GUID may require marshalling attributes to be passed as an argument in this Declare statement. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="C429C3A5-5D47-4CD9-8F51-74A1616405DC"'
    Public Declare Function SetupDiEnumDeviceInterfaces Lib "setupapi.dll" (ByVal DeviceInfoSet As Integer, ByVal DeviceInfoData As Integer, ByRef InterfaceClassGuid As GUID_, ByVal MemberIndex As Integer, ByRef DeviceInterfaceData As SP_DEVICE_INTERFACE_DATA) As Integer
	
	'UPGRADE_WARNING: Structure GUID may require marshalling attributes to be passed as an argument in this Declare statement. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="C429C3A5-5D47-4CD9-8F51-74A1616405DC"'
    Public Declare Function SetupDiGetClassDevs Lib "setupapi.dll" Alias "SetupDiGetClassDevsA" (ByRef ClassGuid As GUID_, ByVal Enumerator As String, ByVal hwndParent As Integer, ByVal Flags As Integer) As Integer
	
	'UPGRADE_WARNING: Structure SP_DEVICE_INTERFACE_DATA may require marshalling attributes to be passed as an argument in this Declare statement. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="C429C3A5-5D47-4CD9-8F51-74A1616405DC"'




    Public Declare Function SetupDiGetDeviceInterfaceDetail Lib "setupapi.dll" Alias "SetupDiGetDeviceInterfaceDetailA" (ByVal DeviceInfoSet As Integer, ByRef DeviceInterfaceData As SP_DEVICE_INTERFACE_DATA, ByVal DeviceInterfaceDetailData As UInt32, ByVal DeviceInterfaceDetailDataSize As Integer, ByRef RequiredSize As Integer, ByVal DeviceInfoData As Integer) As Integer
    'Public Declare Function SetupDiGetDeviceInterfaceDetail Lib "setupapi.dll" Alias "SetupDiGetDeviceInterfaceDetailB" (ByVal DeviceInfoSet As Integer, ByRef DeviceInterfaceData As SP_DEVICE_INTERFACE_DATA, ByRef DeviceInterfaceDetailData As Byte, ByVal DeviceInterfaceDetailDataSize As Integer, ByRef RequiredSize As Integer, ByVal DeviceInfoData As Integer) As Integer





    Private Declare Sub Sleep Lib "kernel32" (ByVal dwMilliseconds As Integer) 'used in Pause sub
	
	Public Declare Function WaitForSingleObject Lib "kernel32" (ByVal hHandle As Integer, ByVal dwMilliseconds As Integer) As Integer
	
	Public Declare Function WriteFile Lib "kernel32" (ByVal hFile As Integer, ByRef lpBuffer As Byte, ByVal nNumberOfBytesToWrite As Integer, ByRef lpNumberOfBytesWritten As Integer, ByVal lpOverlapped As Integer) As Integer
	
	'http://www.vbforums.com/showthread.php?t=546633
	'use this to make a delay
	Public Sub Pause(ByRef SecsDelay As Single)
		Dim TimeOut As Single
		Dim PrevTimer As Single
		
		PrevTimer = VB.Timer()
		TimeOut = PrevTimer + SecsDelay
		Do While PrevTimer < TimeOut
			Sleep(4) '-- Timer is only updated every 1/64 sec = 15.625 millisecs.
			System.Windows.Forms.Application.DoEvents()
			If VB.Timer() < PrevTimer Then TimeOut = TimeOut - 86400 '-- pass midnight
			PrevTimer = VB.Timer()
		Loop 
    End Sub

    Public Function VarPtr(ByVal o As Object) As Integer

        Dim GC As System.Runtime.InteropServices.GCHandle = System.Runtime.InteropServices.GCHandle.Alloc(o, System.Runtime.InteropServices.GCHandleType.Pinned)

        Dim ret As Integer = GC.AddrOfPinnedObject.ToInt32

        GC.Free()

        Return ret

    End Function

	Public Function connect() As Boolean
		'Makes a series of API calls to locate the desired HID-class device.
		'Returns True if the device is detected, False if not detected.
		'Modified from Jan Axelson's HID example
		Dim VID As Integer
		Dim PID As Integer
		Dim Count As Short
		Dim GUIDString As String
		'UPGRADE_WARNING: Arrays in structure HidGuid may need to be initialized before they can be used. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="814DF224-76BD-4BB4-BFFB-EA359CB9FC48"'
        Dim HidGuid As GUID_ ': ReDim HidGuid.Data4(7) ': HidGuid.Initialize() ' JWG: need to call Initialize after definition
        Dim MemberIndex As Integer
		Dim DataString As String
		Dim DetailData As Integer
        Dim DetailDataBuffer() As Byte
        Dim DetailDataBuffer100 As byte100
        Dim DeviceAttributes As HIDD_ATTRIBUTES
		Dim DevicePathName As String
		Dim DeviceInfoSet As Integer
		Dim LastDevice As Boolean
		Dim MyDeviceDetected As Boolean
		Dim MyDeviceInfoData As SP_DEVINFO_DATA
		Dim MyDeviceInterfaceDetailData As SP_DEVICE_INTERFACE_DETAIL_DATA
		Dim MyDeviceInterfaceData As SP_DEVICE_INTERFACE_DATA
		Dim Needed As Integer
		Dim api_status As Integer
        Dim i As Short


		Security.lpSecurityDescriptor = 0
		Security.bInheritHandle = True
		Security.nLength = Len(Security)
		
		ReDim HIDhandleArray(0) ' JWG
		ReDim readHandleArray(0) ' JWG
		
		If HIDhandleArray(0) <> 0 Then Call closeHandles()
		
		'Obtain GUID for HID device interface class
		Call HidD_GetHidGuid(HidGuid)
		
		Do 
			LastDevice = False
			MyDeviceDetected = False
			
			'Request pointer to device information set with information about all installed and present HID devices
            'DeviceInfoSet = SetupDiGetClassDevs(HidGuid, vbNullString, 0, DIGCF_PRESENT Or DIGCF_DEVICEINTERFACE)
            DeviceInfoSet = SetupDiGetClassDevs(HidGuid, Nothing, 0, DIGCF_PRESENT Or DIGCF_DEVICEINTERFACE)

            'DataString = GetDataString(DeviceInfoSet, 32)
			
			MemberIndex = 0
			
			Do 
				'The cbSize element of the MyDeviceInterfaceData structure must be set to
				'the structure's size in bytes. The size is 28 bytes.
                'UPGRADE_ISSUE: ucALSusb.LenB function is not supported. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="367764E5-F3F8-4E43-AC3E-7FE0B5E074E2"'
                MyDeviceInterfaceData.cbSize = System.Runtime.InteropServices.Marshal.SizeOf(MyDeviceInterfaceData) 'ucALSusb.LenB(MyDeviceInterfaceData)

                'Request pointer to structure that contains information about a device interface in the device information set
                api_status = SetupDiEnumDeviceInterfaces(DeviceInfoSet, 0, HidGuid, MemberIndex, MyDeviceInterfaceData)

                If api_status = 0 Then LastDevice = True

                If api_status <> 0 Then
                    '******************************************************************************
                    'SetupDiGetDeviceInterfaceDetail
                    'Returns: an SP_DEVICE_INTERFACE_DETAIL_DATA structure
                    'containing information about a device.
                    'To retrieve the information, call this function twice.
                    'The first time returns the size of the structure in Needed.
                    'The second time returns a pointer to the data in DeviceInfoSet.
                    'Requires:
                    'A DeviceInfoSet returned by SetupDiGetClassDevs and
                    'an SP_DEVICE_INTERFACE_DATA structure returned by SetupDiEnumDeviceInterfaces.
                    '*******************************************************************************

                    MyDeviceInfoData.cbSize = Len(MyDeviceInfoData)
                    Dim val0 As UInt32 : val0 = 0
                    api_status = SetupDiGetDeviceInterfaceDetail(DeviceInfoSet, MyDeviceInterfaceData, 0, 0, Needed, 0)

                    DetailData = Needed
                    'Needed = 86
                    MyDeviceInterfaceDetailData.cbSize = Len(MyDeviceInterfaceDetailData)

                    ReDim DetailDataBuffer(Needed)

                    'UPGRADE_WARNING: Couldn't resolve default property of object MyDeviceInterfaceDetailData. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
                    ' JWG Call RtlMoveMemory(DetailDataBuffer(0), MyDeviceInterfaceDetailData, 4)



                    'ucALSusb.memcpy(DetailDataBuffer(0), MyDeviceInterfaceDetailData.cbSize, 4)
                    DetailDataBuffer(0) = MyDeviceInterfaceDetailData.cbSize




                    'Call SetupDiGetDeviceInterfaceDetail again.
                    'This time, pass the address of the first element of DetailDataBuffer
                    'and the returned required buffer size in DetailData.
                    'Returns a structure with the device interface's device path name in DetailDataBuffer
                    'UPGRADE_ISSUE: VarPtr function is not supported. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="367764E5-F3F8-4E43-AC3E-7FE0B5E074E2"'
                    ' JWG


                    Dim ptr, ptr0 As UInt32
                    ptr = VarPtr(DetailDataBuffer(0))
                    'ptr0 = ucALSusb.VarPtr(DetailDataBuffer(0)) actual pointer is offset by 0x60
                    api_status = SetupDiGetDeviceInterfaceDetail(DeviceInfoSet, MyDeviceInterfaceData, ptr - &H60, DetailData, Needed, 0)
                    'api_status = SetupDiGetDeviceInterfaceDetail(DeviceInfoSet, MyDeviceInterfaceData, DetailDataBuffer(0), DetailData, Needed, 0)





                    '                "012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789"
                    '                "0          1          2          3          4          5          6          7          8 "
                    'DevicePathName = "                                                                                          "

                    'ucALSusb.strcpy(DevicePathName, DetailDataBuffer(4))

                    Dim j, k As Integer : k = 4

                    For j = 0 To Needed - k
                        DetailDataBuffer(j) = DetailDataBuffer(j + k)
                    Next




                    'UPGRADE_TODO: Code was upgraded to use System.Text.UnicodeEncoding.Unicode.GetString() which may not have the same behavior. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="93DD716C-10E3-41BE-A4A8-3BA40157905B"'
                    DevicePathName = System.Text.ASCIIEncoding.ASCII.GetChars(DetailDataBuffer)
                    'DevicePathName = System.Text.UnicodeEncoding.Unicode.GetChars(DetailDataBuffer)

                    ''UPGRADE_ISSUE: Constant vbUnicode was not upgraded. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="55B59875-9A95-4B71-9D6A-7C294BF7139D"'
                    'ucALSusb.Str2Unicode(DevicePathName)
                    '' JWG DevicePathName = StrConv(DevicePathName, vbUnicode)

                    'DevicePathName = Right(DevicePathName, Len(DevicePathName) - 4)




                    '******************************************************************************
                    'CreateFile
                    'Returns: a handle that enables reading and writing to the device.
                    'Requires:
                    'The DevicePathName returned by SetupDiGetDeviceInterfaceDetail.
                    '******************************************************************************
                    HIDhandle = CreateFile(DevicePathName, GENERIC_READ Or GENERIC_WRITE, FILE_SHARE_READ Or FILE_SHARE_WRITE, Security, OPEN_EXISTING, 0, 0)
                    '& at end of hex number ensures that it is not sign extended

                    'UPGRADE_ISSUE: ucALSusb.LenB function is not supported. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="367764E5-F3F8-4E43-AC3E-7FE0B5E074E2"'
                    DeviceAttributes.Size = System.Runtime.InteropServices.Marshal.SizeOf(DeviceAttributes)
                    api_status = HidD_GetAttributes(HIDhandle, DeviceAttributes)

                    'The vendor and device ID assignments below are written so as to avoid
                    'a possible overflow in case of large unsigned ID values (due to the lack
                    'of inherent support for unsigned numbers in Visual Basic):
                    VID = CShort(DEFAULT_VENDOR_ID And &H7FFF) - CShort(DEFAULT_VENDOR_ID And &H8000)
                    PID = CShort(DEFAULT_PRODUCT_ID And &H7FFF) - CShort(DEFAULT_PRODUCT_ID And &H8000)

                    If (DeviceAttributes.VendorID = VID) And (DeviceAttributes.ProductID = PID) Then
                        MyDeviceDetected = True
                        msgBoxVal = MsgBoxResult.Ok
                        ReDim Preserve HIDhandleArray(i)
                        HIDhandleArray(i) = HIDhandle
                        ReDim Preserve readHandleArray(i)
                        'Get another handle for the overlapped ReadFiles.
                        ReadHandle = CreateFile(DevicePathName, GENERIC_READ Or GENERIC_WRITE, FILE_SHARE_READ Or FILE_SHARE_WRITE, Security, OPEN_EXISTING, FILE_FLAG_OVERLAPPED, 0)
                        readHandleArray(i) = ReadHandle
                        i = i + 1
                    Else
                        api_status = CloseHandle(HIDhandle)
                    End If
                End If
				MemberIndex = MemberIndex + 1
			Loop Until (LastDevice = True)
			
			api_status = SetupDiDestroyDeviceInfoList(DeviceInfoSet)
			
			'If MyDeviceDetected = False Then
			'    msgBoxVal = MsgBox("Please check USB connection." & vbNewLine & PRODUCT_NAME & " Evaluation Board not found.", vbRetryCancel)
			'End If
			
		Loop While msgBoxVal = MsgBoxResult.Retry
		'If msgBoxVal = vbCancel Then Unload frmMain JWG
		
		If MyDeviceDetected = True Then
			Call PrepareForOverlappedTransfer()
			
			HIDhandle = HIDhandleArray(0) : ReadHandle = readHandleArray(0) 'Call frmMain.cboEVB_init JWG
			' JWG: start
			GoTo skipInit
			'cboSMBusFrequency_init ' JWG
			'cboSPIclock_init ' JWG
			'getI2Coptions ' JWG
			'getSPIconfig ' JWG
			'getGPconfig ' JWG
			'getGPvalue ' JWG
skipInit: 
		End If
		connect = MyDeviceDetected
		' JWG: end
		'notes:
		'handle is invalid if HID is removed, whether or not the HID has been used and reconnected
	End Function
	
	Public Sub PrepareForOverlappedTransfer()
		'Modified from Jan Axelson's HID example
		'******************************************************************************
		'CreateEvent
		'Creates an event object for the overlapped structure used with ReadFile.
		'Requires a security attributes structure or null,
		'Manual Reset = True (ResetEvent resets the manual reset object to nonsignaled),
		'Initial state = True (signaled),
		'and event object name (optional)
		'Returns a handle to the event object.
		'******************************************************************************
		
		If EventObject = 0 Then
			EventObject = CreateEvent(Security, True, True, "")
		End If
		
		HIDOverlapped.Offset = 0
		HIDOverlapped.OffsetHigh = 0
		HIDOverlapped.hEvent = EventObject
	End Sub
	
	Public Function GetDataString(ByRef address As Integer, ByRef Bytes As Integer) As String
		'Retrieves a string of length Bytes from memory, beginning at Address.
		'Adapted from Dan Appleman's "Win32 API Puzzle Book"
		'Modified from Jan Axelson's HID example
		
		Dim Offset As Short
		Dim Result As String
		Dim ThisByte As Byte
		
		For Offset = 0 To Bytes - 1
            'UPGRADE_ISSUE: VarPtr function is not supported. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="367764E5-F3F8-4E43-AC3E-7FE0B5E074E2"'
            ' JWG
            ucALSusb.cpyAddr2byte(ThisByte, address + Offset)
            'Call RtlMoveMemory(ucALSusb.VarPtr(ThisByte), address + Offset, 1)
			If (ThisByte And &HF0) = 0 Then
				Result = Result & "0"
			End If
			Result = Result & Hex(ThisByte) & " "
		Next Offset
		
		GetDataString = Result
	End Function
	
	Public Function GetErrorString(ByVal LastError As Integer) As String
		'Returns the error message for the last error.
		'Adapted from Dan Appleman's "Win32 API Puzzle Book"
		'Modified from Jan Axelson's HID example
		
		'call example
		'Dim ErrorString As String
		'ErrorString = GetErrorString(Err.LastDllError)
		
		Dim Bytes As Integer
		Dim ErrorString As String
		ErrorString = New String(Chr(0), 129)
		Bytes = FormatMessage(FORMAT_MESSAGE_FROM_SYSTEM, 0, LastError, 0, ErrorString, 128, 0)
		
		'Subtract two characters from the message to strip the CR and LF.
		
		If Bytes > 2 Then
			GetErrorString = Left(ErrorString, Bytes - 2)
		End If
	End Function
	
	Public Sub DisplayResultOfAPICall(ByRef FunctionName As String)
		'Display the results of an API call.
		'Modified from Jan Axelson's HID example
		
		Dim ErrorString As String
		
		ErrorString = GetErrorString(Err.LastDllError)
		
		MsgBox(FunctionName & "  Result = " & ErrorString)
		
	End Sub
	
	Public Sub checkI2Cstatus(ByVal status As Short, ByRef ignoreNACK As Boolean)
		Dim msg As String
		
		If (status = USB_WRITE_ERROR) Or (status = USB_READ_ERROR) Then 'USB error; this section must come before I2C_NACK_ERROR section
			If (status = USB_WRITE_ERROR) Then
				msg = "WriteFile"
			Else
				msg = "ReadFile"
			End If
			msgBoxVal = MsgBox("Please check USB connection." & vbNewLine & "USB " & msg & " error.", MsgBoxStyle.RetryCancel)
			If msgBoxVal = MsgBoxResult.Retry Then
				Call connect()
			Else
				'Unload frmMain JWG
			End If
		ElseIf status = I2C_NACK_ERROR Then  'NACK error
			If ignoreNACK = False Then 'don't ignore NACK error (ignore when scanning I2C address); USB success
				msgBoxVal = MsgBox("Invalid I2C address. Press Retry to return to GUI and enter valid address or Cancel to close GUI.", MsgBoxStyle.RetryCancel)
				If msgBoxVal = MsgBoxResult.Cancel Then
					'Unload frmMain JWG
				End If
			End If
		End If
	End Sub
	
	Public Function checkStatus(ByRef api_status As Integer) As Short
		
		If (api_status = API_FAIL) Then
			msgBoxVal = MsgBox("Please check USB connection." & vbNewLine & "checkStatus", MsgBoxStyle.RetryCancel)
			If msgBoxVal = MsgBoxResult.Retry Then
				Call connect()
			Else
				'Unload frmMain JWG
			End If
			checkStatus = GP_FAIL
		Else
			checkStatus = GP_SUCCESS
		End If
	End Function
	
	Public Function readI2Cvalidate(ByRef deviceAddress As Byte, ByRef numDataBytes As Byte, ByRef numRegBytes As Object, ByRef data() As Byte, ByRef reg() As Byte, Optional ByRef ignoreNACK As Boolean = False) As Short
		'uses status information from readI2C and repeats readI2C until problem has been corrected or user quits
		'ignoreNACK is useful when scanning for I2C address
		'UPGRADE_NOTE: status was upgraded to status_Renamed. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="A9E4979A-37FA-4718-9994-97DD76ED70A7"'
		Dim status_Renamed As Short
		
		status_Renamed = readI2C(deviceAddress, numDataBytes, numRegBytes, data, reg)
		Call checkI2Cstatus(status_Renamed, ignoreNACK) 'won't pass here until USB connection is valid
		If (status_Renamed = USB_READ_ERROR) Or (status_Renamed = USB_WRITE_ERROR) Then
			'repeat the read because the USB handle was not valid, and now it is (otherwise we would still be in checkI2Cstatus), but there may still be an I2C address error
			readI2Cvalidate = readI2Cvalidate(deviceAddress, numDataBytes, numRegBytes, data, reg, ignoreNACK)
		Else
			readI2Cvalidate = status_Renamed 'readI2Cvalidate will return either I2C_SUCCESS or I2C_NACK_ERROR
		End If
	End Function
	
	Public Function readI2C(ByRef deviceAddress As Byte, ByRef numDataBytes As Byte, ByRef numRegBytes As Object, ByRef data() As Byte, ByRef reg() As Byte) As Short
		'returns status
		'readData is passed back to caller with the read data
		Dim BytesSucceed As Integer
		Dim i As Byte
		Dim api_status As Integer
		
		BytesSucceed = 0
		
		Call MemSet(0)
		
		Call reportID()
		IOBuf(1) = 6 'I2C transaction
		IOBuf(2) = deviceAddress + 1 'set read bit
		IOBuf(3) = numDataBytes
		'UPGRADE_WARNING: Couldn't resolve default property of object numRegBytes. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		IOBuf(4) = numRegBytes
		'UPGRADE_WARNING: Couldn't resolve default property of object numRegBytes. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		If numRegBytes > 0 Then
			'UPGRADE_WARNING: Couldn't resolve default property of object numRegBytes. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
			For i = 0 To (numRegBytes - 1) 'if stop index is less than start index, VB6 errors, so we need to use a flag
				IOBuf(i + 5) = reg(i)
			Next i
		End If
		api_status = WriteFile(HIDhandle, IOBuf(0), REPORT_SIZE, BytesSucceed, 0)
		
		If (api_status = API_FAIL) Then
			readI2C = USB_WRITE_ERROR
			Exit Function
		End If
		
		readI2C = checkNACK 'checkNACK also reads the data, assuming NACK didn't occur
		
		If readI2C = I2C_SUCCESS Then
			For i = 0 To numDataBytes - 1
				data(i) = IOBuf(i + 2)
			Next i
		End If
	End Function
	
	Public Function writeI2Cvalidate(ByRef deviceAddress As Byte, ByRef numDataBytes As Byte, ByRef numRegBytes As Object, ByRef data() As Byte, ByRef reg() As Byte, Optional ByRef ignoreNACK As Boolean = False) As Short
		'uses status information from writeI2C and repeats writeI2C until problem has been corrected or user quits
		'ignoreNACK probably will never be used (never ignore the NACK) in a I2C write, but is a required parameter for checkI2Cstatus
		'UPGRADE_NOTE: status was upgraded to status_Renamed. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="A9E4979A-37FA-4718-9994-97DD76ED70A7"'
		Dim status_Renamed As Short
		
		status_Renamed = writeI2C(deviceAddress, numDataBytes, numRegBytes, data, reg)
		Call checkI2Cstatus(status_Renamed, ignoreNACK) 'won't pass here until USB connection is valid
		If (status_Renamed = USB_READ_ERROR) Or (status_Renamed = USB_WRITE_ERROR) Then
			'repeat the write because the USB handle was not valid, and now it is (otherwise we would still be in checkI2Cstatus), but there may still be an I2C address error
			writeI2Cvalidate = writeI2Cvalidate(deviceAddress, numDataBytes, numRegBytes, data, reg, ignoreNACK)
		Else
			writeI2Cvalidate = status_Renamed 'writeI2Cvalidate will return either I2C_SUCCESS or I2C_NACK_ERROR
		End If
	End Function
	
	Public Function writeI2C(ByRef deviceAddress As Byte, ByRef numDataBytes As Byte, ByRef numRegBytes As Object, ByRef data() As Byte, ByRef reg() As Byte) As Short
		'returns status
		Dim BytesSucceed As Integer
		Dim i As Byte
		Dim api_status As Integer
		
		BytesSucceed = 0
		
		Call MemSet(0)
		
		Call reportID()
		IOBuf(1) = 6 'I2C transaction
		IOBuf(2) = deviceAddress
		IOBuf(3) = numDataBytes
		'UPGRADE_WARNING: Couldn't resolve default property of object numRegBytes. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		IOBuf(4) = numRegBytes
		'UPGRADE_WARNING: Couldn't resolve default property of object numRegBytes. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		If numRegBytes > 0 Then
			'UPGRADE_WARNING: Couldn't resolve default property of object numRegBytes. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
			For i = 0 To (numRegBytes - 1)
				IOBuf(i + 5) = reg(i)
			Next i
		End If
		For i = 0 To (numDataBytes - 1)
			'UPGRADE_WARNING: Couldn't resolve default property of object numRegBytes. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
			IOBuf(i + 5 + numRegBytes) = data(i)
		Next i
		
		api_status = WriteFile(HIDhandle, IOBuf(0), REPORT_SIZE, BytesSucceed, 0)
		
		If (api_status = API_FAIL) Then 'USB error
			writeI2C = USB_WRITE_ERROR
			Exit Function
		End If
		
		writeI2C = checkNACK
	End Function
	
	Private Function checkNACK() As Short
		'Check if I2C write was really succesful or a NACK occurred, since this is independent of USB success
		'This function also reads all the data from the report. If NACK occured, the data is invalid.
		Dim BytesSucceed As Integer
		Dim api_status As Integer
		
		Call MemSet(0)
		
		BytesSucceed = 0
		
		api_status = ReadFile(ReadHandle, IOBuf(0), REPORT_SIZE, BytesSucceed, HIDOverlapped)
		
		bAlertable = True
		
		api_status = WaitForSingleObject(EventObject, 6000)
		
		Call ResetEvent(EventObject)
		
		' cannot check for api_status = API_FAIL since we're using overlapped IO
		If (api_status <> WAIT_OBJECT_0) Then
			api_status = CancelIo(ReadHandle)
			checkNACK = USB_READ_ERROR
			Exit Function
		End If
		
		If IOBuf(1) <> 0 Then 'NACK occurred
			checkNACK = I2C_NACK_ERROR 'USB write success, but I2C transaction failed due to bad I2C address
		Else
			checkNACK = I2C_SUCCESS
		End If
	End Function
	
	Public Sub MemSet(ByRef value As Byte)
		Dim i As Short
		
		For i = 0 To IOBufSize
			IOBuf(i) = value
		Next i
	End Sub
	
	Public Function ConvertToVBString(ByRef byteStr() As Byte) As String
		Dim NewString As String
		Dim i As Short
		
		'for the received string array, loop until we get
		'a 0 char, or until the max length has been obtained
		'then add the ascii char value to a vb string
		i = 0
		NewString = ""
		Do While (i < 256) And (byteStr(i) <> 0)
			NewString = NewString & Chr(byteStr(i))
			i = i + 1
		Loop 
		
		ConvertToVBString = NewString
	End Function
	
	Public Function addByte(ByRef op1 As Byte, ByRef op2 As Short) As Byte
		'op2 must be an intger type since bytes cannot be negative, and we may pass in negative numbers
		
		addByte = CByte((CShort(op1) + op2) And 255)
	End Function
	
	Public Function hexpad(ByRef value As Byte) As String
		
		If (value < 16) Then
			hexpad = "0" & Hex(value)
		Else
			hexpad = Hex(value)
		End If
	End Function
	
	Public Sub closeHandles()
		Dim i As Short
		On Error GoTo redimHandle
		For i = 0 To UBound(HIDhandleArray)
			Call CloseHandle(HIDhandleArray(i))
			Call CloseHandle(readHandleArray(i))
		Next i
redimHandle: 
		ReDim HIDhandleArray(0)
		ReDim readHandleArray(0)
		HIDhandle = -1
		ReadHandle = -1
	End Sub
	
	Public Function readPurge() As Short
		'If another GUI has read data from the HID, all GUIs will receive the data at the in endpoint. Hence, the next read for other GUIs will intitially have wrong data on the pipe.
		'The proper way to fix this seems to be with HidD_FlushQueue, but it is returning "invlaid handle" and not flushing the pipe. As a temporary fix, before each write then read,
		'do multiple reads-only to purge the pipe, then when the pipe is empty (timeout in the read), we can do the actual write then read.
		Dim BytesSucceed As Integer
		Dim api_status As Integer
		'UPGRADE_NOTE: status was upgraded to status_Renamed. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="A9E4979A-37FA-4718-9994-97DD76ED70A7"'
		Dim status_Renamed As Short
		
		BytesSucceed = 0
		
		Do 
			api_status = ReadFile(ReadHandle, IOBuf(0), REPORT_SIZE, BytesSucceed, HIDOverlapped)
			'don't need to check for lost HID here, since if it's lost, the pseudo data will be gone and the subsequent calls to the HID will re-establish the connection
			
			bAlertable = True
			
			api_status = WaitForSingleObject(EventObject, 1)
			
			Call ResetEvent(EventObject)
			
			If (api_status <> WAIT_OBJECT_0) Then api_status = CancelIo(ReadHandle) 'cancel the IO operation, then exit the sub
			
		Loop While (api_status = WAIT_OBJECT_0) 'if we read data, then the pipe is not empty. Keep reading until it's empty.
	End Function
	
	Public Sub reportID()
		If explicit_report_id = False Then
			IOBuf(0) = DEFAULT_REPORT_ID 'default report ID; this byte is dropped in transfer, so we don't really waste a byte transmitting it
		Else
			IOBuf(0) = SHORT_REPORT_ID 'explicit out report ID in HID's descriptor
		End If
	End Sub
End Module