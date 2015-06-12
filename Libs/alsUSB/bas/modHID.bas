Attribute VB_Name = "modHID"
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

Dim nTrys As Integer ' allow multiple trys if NACK occurs, value set in 'connect'

Option Explicit

'******************************************************************************
'Proprietary constants
'******************************************************************************

Public Const DEFAULT_REPORT_ID As Byte = 0  'default for implicit report IDs
Public Const SHORT_REPORT_ID As Byte = 1
Public Const USB_WRITE_ERROR = 4
Public Const USB_READ_ERROR = 2
Public Const I2C_NACK_ERROR = 1
Public Const API_FAIL = 0 'API functions return non-0 upon success, to easily denote 'true' for C programs
Public Const I2C_SUCCESS = 8 'we'll also use a non-0 value to denote success, since returning a '0' would lead to trouble when mixed with API's returns.
Public Const GP_SUCCESS = 8
Public Const GP_FAIL = 0
Public Const REPORT_SIZE = 64
Public Const IOBufSize As Byte = REPORT_SIZE - 1 'so that we get REPORT_SIZE elements; VB is weird


'******************************************************************************
'Public variables
'******************************************************************************

Public msgBoxVal As Integer     'value returned by user from a message box
Public I2C_Slave_Address As Byte
Public IOBuf(IOBufSize) As Byte 'io buffer; see 'HID Buffer Structure' for details

'the following are used to find and connect to HID
Public bAlertable As Long
Public EventObject As Long
Public HIDhandle As Long
Public HIDOverlapped As OVERLAPPED
Public ReadHandle As Long
Public Security As SECURITY_ATTRIBUTES
Public HIDhandleArray() As Long
Public readHandleArray() As Long
Public Status As Boolean


'******************************************************************************
'API constants, listed alphabetically
'******************************************************************************

'from setupapi.h
Public Const DIGCF_PRESENT = &H2
Public Const DIGCF_DEVICEINTERFACE = &H10
Public Const FILE_FLAG_OVERLAPPED = &H40000000
Public Const FILE_SHARE_READ = &H1
Public Const FILE_SHARE_WRITE = &H2
Public Const FORMAT_MESSAGE_FROM_SYSTEM = &H1000
Public Const GENERIC_READ = &H80000000
Public Const GENERIC_WRITE = &H40000000

'Typedef enum defines a set of integer constants for HidP_Report_Type
'Remember to declare these as integers (16 bits)
Public Const HidP_Input = 0
Public Const HidP_Output = 1
Public Const HidP_Feature = 2

Public Const OPEN_EXISTING = 3
Public Const WAIT_TIMEOUT = &H102&
Public Const WAIT_OBJECT_0 = 0


'******************************************************************************
'User-defined types for API calls, listed alphabetically
'******************************************************************************

Public Type GUID
    Data1 As Long
    Data2 As Integer
    Data3 As Integer
    Data4(7) As Byte
End Type

Public Type HIDD_ATTRIBUTES
    size As Long
    VendorID As Integer
    ProductID As Integer
    VersionNumber As Integer
End Type

'Windows 98 DDK documentation is incomplete.
'Use the structure defined in hidpi.h
Public Type HIDP_CAPS
    Usage As Integer
    UsagePage As Integer
    InputReportByteLength As Integer
    OutputReportByteLength As Integer
    FeatureReportByteLength As Integer
    Reserved(16) As Integer
    NumberLinkCollectionNodes As Integer
    NumberInputButtonCaps As Integer
    NumberInputValueCaps As Integer
    NumberInputDataIndices As Integer
    NumberOutputButtonCaps As Integer
    NumberOutputValueCaps As Integer
    NumberOutputDataIndices As Integer
    NumberFeatureButtonCaps As Integer
    NumberFeatureValueCaps As Integer
    NumberFeatureDataIndices As Integer
End Type

'If IsRange is false, UsageMin is the Usage and UsageMax is unused.
'If IsStringRange is false, StringMin is the string index and StringMax is unused.
'If IsDesignatorRange is false, DesignatorMin is the designator index and DesignatorMax is unused.
Public Type HidP_Value_Caps
    UsagePage As Integer
    reportID As Byte
    IsAlias As Long
    BitField As Integer
    LinkCollection As Integer
    LinkUsage As Integer
    LinkUsagePage As Integer
    IsRange As Long
    IsStringRange As Long
    IsDesignatorRange As Long
    IsAbsolute As Long
    HasNull As Long
    Reserved As Byte
    BitSize As Integer
    ReportCount As Integer
    Reserved2 As Integer
    Reserved3 As Integer
    Reserved4 As Integer
    Reserved5 As Integer
    Reserved6 As Integer
    LogicalMin As Long
    LogicalMax As Long
    PhysicalMin As Long
    PhysicalMax As Long
    UsageMin As Integer
    UsageMax As Integer
    StringMin As Integer
    StringMax As Integer
    DesignatorMin As Integer
    DesignatorMax As Integer
    DataIndexMin As Integer
    DataIndexMax As Integer
End Type

Public Type OVERLAPPED
    Internal As Long
    InternalHigh As Long
    offset As Long
    OffsetHigh As Long
    hEvent As Long
End Type

Public Type SECURITY_ATTRIBUTES
    nLength As Long
    lpSecurityDescriptor As Long
    bInheritHandle As Long
End Type

Public Type SP_DEVICE_INTERFACE_DATA
   cbSize As Long
   InterfaceClassGuid As GUID
   Flags As Long
   Reserved As Long
End Type

Public Type SP_DEVICE_INTERFACE_DETAIL_DATA
    cbSize As Long
    DevicePath As Byte
End Type

Public Type SP_DEVINFO_DATA
    cbSize As Long
    ClassGuid As GUID
    DevInst As Long
    Reserved As Long
End Type


'******************************************************************************
'API functions, listed alphabetically
'******************************************************************************

Public Declare Function CancelIo _
    Lib "kernel32" _
    (ByVal hFile As Long) _
As Long

Public Declare Function CloseHandle _
    Lib "kernel32" _
    (ByVal hObject As Long) _
As Long

Public Declare Function CreateEvent _
    Lib "kernel32" _
    Alias "CreateEventA" _
    (ByRef lpSecurityAttributes As SECURITY_ATTRIBUTES, _
    ByVal bManualReset As Long, _
    ByVal bInitialState As Long, _
    ByVal lpName As String) _
As Long

Public Declare Function CreateFile _
    Lib "kernel32" _
    Alias "CreateFileA" _
    (ByVal lpFileName As String, _
    ByVal dwDesiredAccess As Long, _
    ByVal dwShareMode As Long, _
    ByRef lpSecurityAttributes As SECURITY_ATTRIBUTES, _
    ByVal dwCreationDisposition As Long, _
    ByVal dwFlagsAndAttributes As Long, _
    ByVal hTemplateFile As Long) _
As Long

Public Declare Function HidD_FlushQueue _
    Lib "hid.dll" _
    (ByRef HIDhandle As Long) _
As Boolean

Public Declare Function FormatMessage _
    Lib "kernel32" _
    Alias "FormatMessageA" _
    (ByVal dwFlags As Long, _
    ByRef lpSource As Any, _
    ByVal dwMessageId As Long, _
    ByVal dwLanguageZId As Long, _
    ByVal lpBuffer As String, _
    ByVal nSize As Long, _
    ByVal Arguments As Long) _
As Long

Public Declare Function HidD_FreePreparsedData _
    Lib "hid.dll" _
    (ByRef PreparsedData As Long) _
As Long

Public Declare Function HidD_GetAttributes _
    Lib "hid.dll" _
    (ByVal HidDeviceObject As Long, _
    ByRef Attributes As HIDD_ATTRIBUTES) _
As Long

'Declared as a function for consistency,
'but returns nothing. (Ignore the returned value.)
Public Declare Function HidD_GetHidGuid _
    Lib "hid.dll" _
    (ByRef HidGuid As GUID) _
As Long

Public Declare Function HidD_GetPreparsedData _
    Lib "hid.dll" _
    (ByVal HidDeviceObject As Long, _
    ByRef PreparsedData As Long) _
As Long

Public Declare Function HidP_GetCaps _
    Lib "hid.dll" _
    (ByVal PreparsedData As Long, _
    ByRef Capabilities As HIDP_CAPS) _
As Long

Public Declare Function HidP_GetValueCaps _
    Lib "hid.dll" _
    (ByVal ReportType As Integer, _
    ByRef ValueCaps As Byte, _
    ByRef ValueCapsLength As Integer, _
    ByVal PreparsedData As Long) _
As Long
       
Public Declare Function lstrcpy _
    Lib "kernel32" _
    Alias "lstrcpyA" _
    (ByVal dest As String, _
    ByVal Source As Long) _
As String

Public Declare Function lstrlen _
    Lib "kernel32" _
    Alias "lstrlenA" _
    (ByVal Source As Long) _
As Long

Public Declare Function ReadFile _
    Lib "kernel32" _
    (ByVal hFile As Long, _
    ByRef lpBuffer As Byte, _
    ByVal nNumberOfBytesToRead As Long, _
    ByRef lpNumberOfBytesRead As Long, _
    ByRef lpOverlapped As OVERLAPPED) _
As Long

Public Declare Function ResetEvent _
    Lib "kernel32" _
    (ByVal hEvent As Long) _
As Long

Public Declare Function RtlMoveMemory _
    Lib "kernel32" _
    (dest As Any, _
    src As Any, _
    ByVal count As Long) _
As Long

Public Declare Function SetupDiCreateDeviceInfoList _
    Lib "setupapi.dll" _
    (ByRef ClassGuid As GUID, _
    ByVal hwndParent As Long) _
As Long

Public Declare Function SetupDiDestroyDeviceInfoList _
    Lib "setupapi.dll" _
    (ByVal DeviceInfoSet As Long) _
As Long

Public Declare Function SetupDiEnumDeviceInterfaces _
    Lib "setupapi.dll" _
    (ByVal DeviceInfoSet As Long, _
    ByVal DeviceInfoData As Long, _
    ByRef InterfaceClassGuid As GUID, _
    ByVal MemberIndex As Long, _
    ByRef DeviceInterfaceData As SP_DEVICE_INTERFACE_DATA) _
As Long

Public Declare Function SetupDiGetClassDevs _
    Lib "setupapi.dll" _
    Alias "SetupDiGetClassDevsA" _
    (ByRef ClassGuid As GUID, _
    ByVal Enumerator As String, _
    ByVal hwndParent As Long, _
    ByVal Flags As Long) _
As Long

Public Declare Function SetupDiGetDeviceInterfaceDetail _
   Lib "setupapi.dll" _
   Alias "SetupDiGetDeviceInterfaceDetailA" _
   (ByVal DeviceInfoSet As Long, _
   ByRef DeviceInterfaceData As SP_DEVICE_INTERFACE_DATA, _
   ByVal DeviceInterfaceDetailData As Long, _
   ByVal DeviceInterfaceDetailDataSize As Long, _
   ByRef RequiredSize As Long, _
   ByVal DeviceInfoData As Long) _
As Long
    
Private Declare Sub Sleep Lib "kernel32" (ByVal dwMilliseconds As Long) 'used in Pause sub

Public Declare Function WaitForSingleObject _
    Lib "kernel32" _
    (ByVal hHandle As Long, _
    ByVal dwMilliseconds As Long) _
As Long
    
Public Declare Function WriteFile _
    Lib "kernel32" _
    (ByVal hFile As Long, _
    ByRef lpBuffer As Byte, _
    ByVal nNumberOfBytesToWrite As Long, _
    ByRef lpNumberOfBytesWritten As Long, _
    ByVal lpOverlapped As Long) _
As Long

'http://www.vbforums.com/showthread.php?t=546633
'use this to make a delay
Public Sub Pause(SecsDelay As Single)
   Dim TimeOut   As Single
   Dim PrevTimer As Single
   
   PrevTimer = Timer
   TimeOut = PrevTimer + SecsDelay
   Do While PrevTimer < TimeOut
      Sleep 4 '-- Timer is only updated every 1/64 sec = 15.625 millisecs.
      DoEvents
      If Timer < PrevTimer Then TimeOut = TimeOut - 86400 '-- pass midnight
      PrevTimer = Timer
   Loop
End Sub

Public Function connect() As Boolean
'Makes a series of API calls to locate the desired HID-class device.
'Returns True if the device is detected, False if not detected.
'Modified from Jan Axelson's HID example
    Dim VID As Long
    Dim PID As Long
    Dim count As Integer
    Dim GUIDString As String
    Dim HidGuid As GUID
    Dim MemberIndex As Long
    Dim DataString As String
    Dim DetailData As Long
    Dim DetailDataBuffer() As Byte
    Dim DeviceAttributes As HIDD_ATTRIBUTES
    Dim DevicePathName As String
    Dim DeviceInfoSet As Long
    Dim LastDevice As Boolean
    Dim MyDeviceDetected As Boolean
    Dim MyDeviceInfoData As SP_DEVINFO_DATA
    Dim MyDeviceInterfaceDetailData As SP_DEVICE_INTERFACE_DETAIL_DATA
    Dim MyDeviceInterfaceData As SP_DEVICE_INTERFACE_DATA
    Dim Needed As Long
    Dim api_status As Long
    Dim i As Integer

    Security.lpSecurityDescriptor = 0
    Security.bInheritHandle = True
    Security.nLength = Len(Security)
    
    ReDim HIDhandleArray(0) As Long ' JWG
    ReDim readHandleArray(0) As Long ' JWG
    
    If HIDhandleArray(0) <> 0 Then Call closeHandles
    
    'Obtain GUID for HID device interface class
    Call HidD_GetHidGuid(HidGuid)
    
    Do
        LastDevice = False
        MyDeviceDetected = False
    
        'Request pointer to device information set with information about all installed and present HID devices
        DeviceInfoSet = SetupDiGetClassDevs(HidGuid, vbNullString, 0, (DIGCF_PRESENT Or DIGCF_DEVICEINTERFACE))
            
        DataString = GetDataString(DeviceInfoSet, 32)
        
        MemberIndex = 0
        
        Do
            'The cbSize element of the MyDeviceInterfaceData structure must be set to
            'the structure's size in bytes. The size is 28 bytes.
            MyDeviceInterfaceData.cbSize = LenB(MyDeviceInterfaceData)
            
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
                api_status = SetupDiGetDeviceInterfaceDetail(DeviceInfoSet, MyDeviceInterfaceData, 0, 0, Needed, 0)
                
                DetailData = Needed
                    
                MyDeviceInterfaceDetailData.cbSize = Len(MyDeviceInterfaceDetailData)
                
                ReDim DetailDataBuffer(Needed)
                
                Call RtlMoveMemory(DetailDataBuffer(0), MyDeviceInterfaceDetailData, 4)
                
                'Call SetupDiGetDeviceInterfaceDetail again.
                'This time, pass the address of the first element of DetailDataBuffer
                'and the returned required buffer size in DetailData.
                'Returns a structure with the device interface's device path name in DetailDataBuffer
                api_status = SetupDiGetDeviceInterfaceDetail(DeviceInfoSet, MyDeviceInterfaceData, VarPtr(DetailDataBuffer(0)), DetailData, Needed, 0)
                
                DevicePathName = CStr(DetailDataBuffer())
                
                DevicePathName = StrConv(DevicePathName, vbUnicode)
                
                DevicePathName = Right$(DevicePathName, Len(DevicePathName) - 4)
                
                '******************************************************************************
                'CreateFile
                'Returns: a handle that enables reading and writing to the device.
                'Requires:
                'The DevicePathName returned by SetupDiGetDeviceInterfaceDetail.
                '******************************************************************************
                HIDhandle = CreateFile(DevicePathName, GENERIC_READ Or GENERIC_WRITE, (FILE_SHARE_READ Or FILE_SHARE_WRITE), Security, OPEN_EXISTING, 0&, 0)
                '& at end of hex number ensures that it is not sign extended
                
                DeviceAttributes.size = LenB(DeviceAttributes)
                api_status = HidD_GetAttributes(HIDhandle, DeviceAttributes)
                    
                'The vendor and device ID assignments below are written so as to avoid
                'a possible overflow in case of large unsigned ID values (due to the lack
                'of inherent support for unsigned numbers in Visual Basic):
                VID = (DEFAULT_VENDOR_ID And &H7FFF) - (DEFAULT_VENDOR_ID And &H8000)
                PID = (DEFAULT_PRODUCT_ID And &H7FFF) - (DEFAULT_PRODUCT_ID And &H8000)
        
                If (DeviceAttributes.VendorID = VID) And (DeviceAttributes.ProductID = PID) Then
                    MyDeviceDetected = True
                    msgBoxVal = vbOK
                    ReDim Preserve HIDhandleArray(i)
                    HIDhandleArray(i) = HIDhandle
                    ReDim Preserve readHandleArray(i)
                    'Get another handle for the overlapped ReadFiles.
                    ReadHandle = CreateFile(DevicePathName, (GENERIC_READ Or GENERIC_WRITE), (FILE_SHARE_READ Or FILE_SHARE_WRITE), Security, OPEN_EXISTING, FILE_FLAG_OVERLAPPED, 0)
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
    
    Loop While msgBoxVal = vbRetry
    'If msgBoxVal = vbCancel Then Unload frmMain JWG
    
    If MyDeviceDetected = True Then
        Call PrepareForOverlappedTransfer
    
        HIDhandle = HIDhandleArray(0): ReadHandle = readHandleArray(0) 'Call frmMain.cboEVB_init JWG
        ' JWG: start
        GoTo skipInit
        'cboSMBusFrequency_init ' JWG
        'cboSPIclock_init ' JWG
        'getI2Coptions ' JWG
        'getSPIconfig ' JWG
        'getGPconfig ' JWG
        'getGPvalue ' JWG
skipInit:
    nTrys = 5
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
    
    HIDOverlapped.offset = 0
    HIDOverlapped.OffsetHigh = 0
    HIDOverlapped.hEvent = EventObject
End Sub

Public Function GetDataString(address As Long, Bytes As Long) As String
'Retrieves a string of length Bytes from memory, beginning at Address.
'Adapted from Dan Appleman's "Win32 API Puzzle Book"
'Modified from Jan Axelson's HID example

    Dim offset As Integer
    Dim Result$
    Dim ThisByte As Byte
    
    For offset = 0 To Bytes - 1
        Call RtlMoveMemory(ByVal VarPtr(ThisByte), ByVal address + offset, 1)
        If (ThisByte And &HF0) = 0 Then
            Result$ = Result$ & "0"
        End If
        Result$ = Result$ & Hex$(ThisByte) & " "
    Next offset
    
    GetDataString = Result$
End Function

Public Function GetErrorString(ByVal LastError As Long) As String
'Returns the error message for the last error.
'Adapted from Dan Appleman's "Win32 API Puzzle Book"
'Modified from Jan Axelson's HID example
    
'call example
'Dim ErrorString As String
'ErrorString = GetErrorString(Err.LastDllError)
        
    Dim Bytes As Long
    Dim ErrorString As String
    ErrorString = String$(129, 0)
    Bytes = FormatMessage(FORMAT_MESSAGE_FROM_SYSTEM, 0&, LastError, 0, ErrorString$, 128, 0)
        
    'Subtract two characters from the message to strip the CR and LF.
    
    If Bytes > 2 Then
        GetErrorString = Left$(ErrorString, Bytes - 2)
    End If
End Function

Public Sub DisplayResultOfAPICall(FunctionName As String)
'Display the results of an API call.
'Modified from Jan Axelson's HID example

Dim ErrorString As String

ErrorString = GetErrorString(Err.LastDllError)

MsgBox (FunctionName & "  Result = " & ErrorString)

End Sub

Public Sub checkI2Cstatus(ByVal Status As Integer, ignoreNACK As Boolean)
    Dim msg As String
    
    If (Status = USB_WRITE_ERROR) Or (Status = USB_READ_ERROR) Then  'USB error; this section must come before I2C_NACK_ERROR section
        If (Status = USB_WRITE_ERROR) Then
            msg = "WriteFile"
        Else
            msg = "ReadFile"
        End If
        msgBoxVal = MsgBox("Please check USB connection." & vbNewLine & "USB " & msg & " error.", vbRetryCancel)
        If msgBoxVal = vbRetry Then
            Call connect
        Else
            'Unload frmMain JWG
        End If
    ElseIf Status = I2C_NACK_ERROR Then 'NACK error
        If ignoreNACK = False Then 'don't ignore NACK error (ignore when scanning I2C address); USB success
            msgBoxVal = MsgBox("Invalid I2C address. Press Retry to return to GUI and enter valid address or Cancel to close GUI.", vbRetryCancel)
            If msgBoxVal = vbCancel Then
                'Unload frmMain JWG
            End If
        End If
    End If
End Sub

Public Function checkStatus(api_status As Long) As Integer

    If (api_status = API_FAIL) Then
        msgBoxVal = MsgBox("Please check USB connection." & vbNewLine & "checkStatus", vbRetryCancel)
        If msgBoxVal = vbRetry Then
            Call connect
        Else
            'Unload frmMain JWG
        End If
        checkStatus = GP_FAIL
    Else
        checkStatus = GP_SUCCESS
    End If
End Function

Public Function readI2Cvalidate(deviceAddress As Byte, numDataBytes As Byte, numRegBytes, data() As Byte, reg() As Byte, Optional ignoreNACK As Boolean = False) As Integer
'uses status information from readI2C and repeats readI2C until problem has been corrected or user quits
'ignoreNACK is useful when scanning for I2C address
    Dim Status As Integer

    Status = readI2C(deviceAddress, numDataBytes, numRegBytes, data, reg)
    Call checkI2Cstatus(Status, ignoreNACK) 'won't pass here until USB connection is valid
    If (Status = USB_READ_ERROR) Or (Status = USB_WRITE_ERROR) Then
        'repeat the read because the USB handle was not valid, and now it is (otherwise we would still be in checkI2Cstatus), but there may still be an I2C address error
        readI2Cvalidate = readI2Cvalidate(deviceAddress, numDataBytes, numRegBytes, data, reg, ignoreNACK)
    Else
        readI2Cvalidate = Status 'readI2Cvalidate will return either I2C_SUCCESS or I2C_NACK_ERROR
    End If
End Function

Public Function readI2C(ByVal deviceAddress As Byte, ByVal numDataBytes As Byte, ByVal numRegBytes, data() As Byte, reg() As Byte) As Integer
'returns status
'readData is passed back to caller with the read data
    Dim BytesSucceed As Long
    Dim i As Byte
    Dim api_status As Long
    Dim try As Long
    
    If deviceAddress = 0 Then Exit Function
    
    For try = nTrys - 1 To 0 Step -1
    
        BytesSucceed = 0
        
        Call MemSet(0)
        
        Call reportID
        IOBuf(1) = 6    'I2C transaction
        IOBuf(2) = deviceAddress + 1 'set read bit
        IOBuf(3) = numDataBytes
        IOBuf(4) = numRegBytes
        If numRegBytes > 0 Then
            For i = 0 To (numRegBytes - 1)  'if stop index is less than start index, VB6 errors, so we need to use a flag
                IOBuf(i + 5) = reg(i)
            Next i
        End If
        api_status = WriteFile(HIDhandle, IOBuf(0), REPORT_SIZE, BytesSucceed, 0)
        
        If (api_status = API_FAIL) Then
            readI2C = USB_WRITE_ERROR
            Exit Function
        End If
        
        readI2C = checkNACK 'checkNACK also reads the data, assuming NACK didn't occur
        
        If readI2C = I2C_SUCCESS Then try = 0
    
    Next try
    
    
    If readI2C = I2C_SUCCESS Then
        For i = 0 To numDataBytes - 1
            data(i) = IOBuf(i + 2)
        Next i
    Else
        try = nTrys ' JWG trap here for failure
    End If
End Function

Public Function writeI2Cvalidate(deviceAddress As Byte, numDataBytes As Byte, numRegBytes, data() As Byte, reg() As Byte, Optional ignoreNACK As Boolean = False) As Integer
'uses status information from writeI2C and repeats writeI2C until problem has been corrected or user quits
'ignoreNACK probably will never be used (never ignore the NACK) in a I2C write, but is a required parameter for checkI2Cstatus
    Dim Status As Integer
    
    Status = writeI2C(deviceAddress, numDataBytes, numRegBytes, data, reg)
    Call checkI2Cstatus(Status, ignoreNACK) 'won't pass here until USB connection is valid
    If (Status = USB_READ_ERROR) Or (Status = USB_WRITE_ERROR) Then
        'repeat the write because the USB handle was not valid, and now it is (otherwise we would still be in checkI2Cstatus), but there may still be an I2C address error
        writeI2Cvalidate = writeI2Cvalidate(deviceAddress, numDataBytes, numRegBytes, data, reg, ignoreNACK)
    Else
        writeI2Cvalidate = Status 'writeI2Cvalidate will return either I2C_SUCCESS or I2C_NACK_ERROR
    End If
End Function

Public Function writeI2C(ByVal deviceAddress As Byte, ByVal numDataBytes As Byte, numRegBytes, data() As Byte, reg() As Byte) As Integer
'returns status
    Dim BytesSucceed As Long
    Dim i As Byte
    Dim api_status As Long
    Dim try As Long

    If deviceAddress = 0 Then Exit Function

    For try = nTrys To 0 Step -1

        BytesSucceed = 0
        
        Call MemSet(0)
        
        Call reportID
        IOBuf(1) = 6    'I2C transaction
        IOBuf(2) = deviceAddress
        IOBuf(3) = numDataBytes
        IOBuf(4) = numRegBytes
        If numRegBytes > 0 Then
            For i = 0 To (numRegBytes - 1)
                IOBuf(i + 5) = reg(i)
            Next i
        End If
        For i = 0 To (numDataBytes - 1)
            IOBuf(i + 5 + numRegBytes) = data(i)
        Next i
    
        api_status = WriteFile(HIDhandle, IOBuf(0), REPORT_SIZE, BytesSucceed, 0)
    
        If (api_status = API_FAIL) Then 'USB error
            writeI2C = USB_WRITE_ERROR
            Exit Function
            
        End If
        
        writeI2C = checkNACK
        
        If writeI2C = I2C_SUCCESS Then try = 0

    Next try
    
    If writeI2C <> I2C_SUCCESS Then
        try = nTrys ' JWG trap here for failure
    End If

End Function

Private Function checkNACK() As Integer
'Check if I2C write was really succesful or a NACK occurred, since this is independent of USB success
'This function also reads all the data from the report. If NACK occured, the data is invalid.
    Dim BytesSucceed As Long
    Dim api_status As Long

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

Public Sub MemSet(value As Byte)
    Dim i As Integer
    
    For i = 0 To IOBufSize
        IOBuf(i) = value
    Next i
End Sub

Public Function ConvertToVBString(byteStr() As Byte) As String
    Dim NewString As String
    Dim i As Integer
    
    'for the received string array, loop until we get
    'a 0 char, or until the max length has been obtained
    'then add the ascii char value to a vb string
    i = 0
    NewString = ""
    Do While (i < 256) And (byteStr(i) <> 0)
        NewString = NewString + Chr$(byteStr(i))
        i = i + 1
    Loop
    
    ConvertToVBString = NewString
End Function

Public Function addByte(op1 As Byte, op2 As Integer) As Byte
'op2 must be an intger type since bytes cannot be negative, and we may pass in negative numbers

    addByte = CByte((CInt(op1) + op2) And 255)
End Function

Public Function hexpad(value As Byte) As String
    
    If (value < 16) Then
        hexpad = "0" & Hex(value)
    Else
        hexpad = Hex(value)
    End If
End Function

Public Sub closeHandles()
    Dim i As Integer
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

Public Function readPurge() As Integer
'If another GUI has read data from the HID, all GUIs will receive the data at the in endpoint. Hence, the next read for other GUIs will intitially have wrong data on the pipe.
'The proper way to fix this seems to be with HidD_FlushQueue, but it is returning "invlaid handle" and not flushing the pipe. As a temporary fix, before each write then read,
'do multiple reads-only to purge the pipe, then when the pipe is empty (timeout in the read), we can do the actual write then read.
    Dim BytesSucceed As Long
    Dim api_status As Long
    Dim Status As Integer
    
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
        IOBuf(0) = DEFAULT_REPORT_ID    'default report ID; this byte is dropped in transfer, so we don't really waste a byte transmitting it
    Else
        IOBuf(0) = SHORT_REPORT_ID      'explicit out report ID in HID's descriptor
    End If
End Sub
