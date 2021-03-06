Option Strict Off
Option Explicit On

Imports System.Runtime.InteropServices
Imports System.Text
Imports System.IO
Imports System.Reflection
Imports Microsoft.Win32
Imports System
Imports System.Threading
Imports System.Math

<ComClass(ucALSusb.ClassId, _
ucALSusb.InterfaceId, _
ucALSusb.EventsId)> _
Public Class ucALSusb

    Inherits System.Windows.Forms.UserControl

#Region "COM GUIDs"
    ' These GUIDs provide the COM identity for this class
    ' and its COM interfaces. If you change them, existing
    ' clients will no longer be able to access the class.
    'You should create your own 3 GUIDS using GuidGen
    Public Const ClassId As String = "AF7B143A-E96D-4f4d-BA31-304BA07E1870"
    Public Const InterfaceId As String = "4E66B0ED-2728-4790-9373-21DF8098310C"
    Public Const EventsId As String = "9B2D65C0-6E46-452d-9110-224FD13DC41D"
#End Region

#Region "REQUIRED FOR ACTIVEX"
    ' This function is called when registered (no need to change it)
    <ComRegisterFunction()> _
    Private Shared Sub ComRegister(ByVal t As Type)
        Dim keyName As String = "CLSID\\" & t.GUID.ToString("B")
        Dim key As RegistryKey = Registry.ClassesRoot.OpenSubKey(keyName, True)

        key.CreateSubKey("Control").Close()
        Dim subkey As RegistryKey = key.CreateSubKey("MiscStatus")
        subkey.SetValue("", "131201")
        subkey = key.CreateSubKey("TypeLib")
        Dim libid As GUID = Marshal.GetTypeLibGuidForAssembly(t.Assembly)
        subkey.SetValue("", libid.ToString("B"))
        subkey = key.CreateSubKey("Version")
        Dim ver As Version = t.Assembly.GetName().Version
        Dim version As String = String.Format("{0}.{1}", ver.Major, ver.Minor)
        If version = "0.0" Then version = "1.0"
        subkey.SetValue("", version)

    End Sub

    ' This is called when unregistering (no need to change it)
    <ComUnregisterFunction()> _
    Private Shared Sub ComUnregister(ByVal t As Type)
        ' Delete entire CLSID�{clsid} subtree
        Dim keyName As String = "CLSID\\" & _
            t.GUID.ToString("B")
        Registry.ClassesRoot.DeleteSubKeyTree(keyName)
    End Sub

#End Region

    '<System.Runtime.InteropServices.ProgId("ucALSusb_NET.ucALSusb")> Public Class ucALSusb

    Dim ucJungoUsb1 As ucJungoUsb
    Dim ucHIDusb1 As ucHIDUsb
    Dim ucEmuUsb1 As ucEmuUsb
    Dim ADBUsb1 As ADBUsb
    Dim pTempDrv As clsAlsRgbDrv

    Private cerror As String
    Private loadDone As Boolean
    Private EEprom As clsEEprom

    Const frmDevice_Width As Short = 1815
    Const frmX11_Top As Short = 2520 + 240
    Const frmX28_Top As Short = 2400 + 240
    Const frmX38_Top As Short = 3960 + 240


    ' >>>>>>>>>>>>> TEMP
    Const useDllIO As Boolean = True

    ' <<<<<<<<<<<<< TEMP

    Public Enum cmd
        w
        R
        WW
        RW
        WA
        RA
        callBackOk = 71077345
    End Enum

    'Private Const base = &H80
    'Private Const addrDefault = &H88
    'Private rMap(&H19) As Long

    Private X28 As Boolean
    Private X38 As Boolean
    Private ALSonly As Boolean
    Private PRXonly As Boolean
    Private gI2cAddr As Integer
    Private gDUTi2cAddr As Integer
    Private gPartNumber As Integer
    Private gPartFamily As Integer

    Const nOptAddr As Short = 4

    Dim HIDport(2) As Short


    Private Declare Function GetTickCount Lib "kernel32" () As Integer

    Private Declare Function cGetByteIoOnly Lib "registerDriver" (ByRef E As Integer) As Integer
    Private Declare Function cGetData Lib "registerDriver" (ByVal i As Integer, ByRef R As Integer) As Integer
    Private Declare Function cGetDevice Lib "registerDriver" (ByRef v As Integer) As Integer
    Private Declare Function cGetDeviceList Lib "registerDriver" (ByVal c As String) As Integer
    Private Declare Function cGetEnable Lib "registerDriver" (ByVal i As Integer, ByRef m As Integer) As Integer
    Private Declare Function cGeterror Lib "registerDriver" (ByVal N As Integer, ByVal E As String) As Integer
    Private Declare Function cGetInputSelect Lib "registerDriver" (ByVal i As Integer, ByRef R As Integer) As Integer
    Private Declare Function cGetInputSelectList Lib "registerDriver" (ByVal c As Integer, ByVal v As String) As Integer
    Private Declare Function cGetIntFlag Lib "registerDriver" (ByVal i As Integer, ByRef R As Integer) As Integer
    Private Declare Function cGetIntLogic Lib "registerDriver" (ByRef m As Integer) As Integer
    Private Declare Function cGetIntPersist Lib "registerDriver" (ByVal c As Integer, ByRef m As Integer) As Integer
    Private Declare Function cGetIntPersistList Lib "registerDriver" (ByVal c As Integer, ByRef m As Integer) As Integer
    Private Declare Function cGetIR Lib "registerDriver" (ByRef R As Double) As Integer
    Private Declare Function cGetIrdr Lib "registerDriver" (ByRef R As Integer) As Integer
    Private Declare Function cGetIrdrFreq Lib "registerDriver" (ByRef m As Integer) As Integer
    Private Declare Function cGetIrdrList Lib "registerDriver" (ByRef R As Integer) As Integer
    Private Declare Function cGetIRState Lib "registerDriver" (ByRef R As Integer) As Integer
    Private Declare Function cGetLux Lib "registerDriver" (ByRef R As Double) As Integer
    Private Declare Function cGetLuxState Lib "registerDriver" (ByRef R As Integer) As Integer
    Private Declare Function cGetMPAprimed Lib "registerDriver" (ByVal c As Integer, ByRef v As Integer) As Integer
    Private Declare Function cGetNchannel Lib "registerDriver" (ByRef N As Integer) As Integer
    Private Declare Function cGetNdevice Lib "registerDriver" (ByRef N As Integer) As Integer
    Private Declare Function cGetNinputSelect Lib "registerDriver" (ByVal c As Integer, ByRef v As Integer) As Integer
    Private Declare Function cGetNintPersist Lib "registerDriver" (ByVal c As Integer, ByRef v As Integer) As Integer
    Private Declare Function cGetNirdr Lib "registerDriver" (ByRef R As Integer) As Integer
    Private Declare Function cGetNrange Lib "registerDriver" (ByVal c As Integer, ByRef v As Integer) As Integer
    Private Declare Function cGetNresolution Lib "registerDriver" (ByVal c As Integer, ByRef v As Integer) As Integer
    Private Declare Function cGetNsleep Lib "registerDriver" (ByRef v As Integer) As Integer
    Private Declare Function cGetProxAmbRej Lib "registerDriver" (ByRef m As Integer) As Integer
    Private Declare Function cGetProxFlag Lib "registerDriver" (ByRef m As Integer) As Integer
    Private Declare Function cGetProxIR Lib "registerDriver" (ByRef m As Double, ByRef F As Integer) As Integer
    Private Declare Function cGetProximity Lib "registerDriver" (ByRef m As Double) As Integer
    Private Declare Function cGetProximityState Lib "registerDriver" (ByRef m As Integer) As Integer
    Private Declare Function cGetProxPersist Lib "registerDriver" (ByRef m As Integer) As Integer
    Private Declare Function cGetRange Lib "registerDriver" (ByVal c As Integer, ByRef v As Integer) As Integer
    Private Declare Function cGetRangeList Lib "registerDriver" (ByVal c As Integer, ByRef v As Integer) As Integer
    Private Declare Function cGetResolution Lib "registerDriver" (ByVal i As Integer, ByRef R As Integer) As Integer
    Private Declare Function cGetResolutionList Lib "registerDriver" (ByVal c As Integer, ByRef v As Integer) As Integer
    Private Declare Function cGetRunMode Lib "registerDriver" (ByRef m As Integer) As Integer
    Private Declare Function cGetSleep Lib "registerDriver" (ByRef v As Integer) As Integer
    Private Declare Function cGetSleepList Lib "registerDriver" (ByRef v As Integer) As Integer
    Private Declare Function cGetStats Lib "registerDriver" (ByVal i As Integer, ByRef m As Double, ByRef s As Double) As Integer
    Private Declare Function cGetStateMachineEnable Lib "registerDriver" (ByRef E As Integer) As Integer
    Private Declare Function cGetThreshHi Lib "registerDriver" (ByVal i As Integer, ByRef R As Double) As Integer
    Private Declare Function cGetThreshLo Lib "registerDriver" (ByVal i As Integer, ByRef R As Double) As Integer
    Private Declare Function cInitDriver Lib "registerDriver" () As Integer
    Private Declare Function cPoll Lib "registerDriver" (ByRef v As Integer) As Integer
    Private Declare Function cPrintTrace Lib "registerDriver" (ByVal v As String) As Integer
    Private Declare Function cResetDevice Lib "registerDriver" () As Integer

    Private Declare Function cSetByteIoOnly Lib "registerDriver" (ByVal E As Integer) As Integer
    Private Declare Function cSetDevice Lib "registerDriver" (ByVal v As Integer) As Integer
    Private Declare Function cSetDrvApi Lib "registerDriver" (ByVal N As Integer) As Integer
    Private Declare Function cSetEnable Lib "registerDriver" (ByVal i As Integer, ByVal m As Integer) As Integer
    Private Declare Function cSetInputSelect Lib "registerDriver" (ByVal i As Integer, ByVal R As Integer) As Integer
    Private Declare Function cSetIntLogic Lib "registerDriver" (ByVal m As Integer) As Integer
    Private Declare Function cSetIntPersist Lib "registerDriver" (ByVal c As Integer, ByVal m As Integer) As Integer
    Private Declare Function cSetIrdr Lib "registerDriver" (ByVal R As Integer) As Integer
    Private Declare Function cSetIrdrFreq Lib "registerDriver" (ByVal m As Integer) As Integer
    Private Declare Function cSetLux Lib "registerDriver" (ByVal R As Double) As Integer
    Private Declare Function cSetMPAsize Lib "registerDriver" (ByVal i As Integer, ByVal m As Integer) As Integer
    Private Declare Function cSetProxAmbRej Lib "registerDriver" (ByVal m As Integer) As Integer
    Private Declare Function cSetPWMen Lib "registerDriver" (ByVal m As Integer) As Integer
    Private Declare Function cSetRange Lib "registerDriver" (ByVal c As Integer, ByVal v As Integer) As Integer
    Private Declare Function cSetResolution Lib "registerDriver" (ByVal i As Integer, ByVal R As Integer) As Integer
    Private Declare Function cSetRunMode Lib "registerDriver" (ByVal m As Integer) As Integer
    Private Declare Function cSetSleep Lib "registerDriver" (ByVal v As Integer) As Integer
    Private Declare Function cSetStateMachineEnable Lib "registerDriver" (ByVal E As Integer) As Integer
    Private Declare Function cSetThreshHi Lib "registerDriver" (ByVal i As Integer, ByVal R As Double) As Integer
    Private Declare Function cSetThreshLo Lib "registerDriver" (ByVal i As Integer, ByVal R As Double) As Integer
    Private Declare Function cTest Lib "registerDriver" (ByVal t As Integer) As Integer

    Private Declare Function cIO Lib "registerDriver" (ByVal c As Integer, ByVal a As Integer, ByRef D As Integer) As Integer
    Private Declare Function cWriteField Lib "registerDriver" (ByVal a As Integer, ByVal s As Byte, ByVal m As Byte, ByVal D As Byte) As Integer
    Private Declare Function cReadField Lib "registerDriver" (ByVal a As Integer, ByVal s As Byte, ByVal m As Byte, ByRef D As Byte) As Integer
    Private Declare Function cWriteI2c Lib "registerDriver" (ByVal i2cAddr As Integer, ByVal addr As Integer, ByVal data As Byte) As Integer
    Private Declare Function cReadI2c Lib "registerDriver" (ByVal i2cAddr As Integer, ByVal addr As Integer, ByRef data As Byte) As Integer
    Private Declare Function cWriteI2cWord Lib "registerDriver" (ByVal i2cAddr As Integer, ByVal addr As Integer, ByVal data As Integer) As Integer
    Private Declare Function cReadI2cWord Lib "registerDriver" (ByVal i2cAddr As Integer, ByVal addr As Integer, ByRef data As Integer) As Integer

    Private Declare Function cGetConversionTime Lib "registerDriver" (ByVal i As Integer, ByRef R As Integer) As Integer
    Private Declare Function cSetConversionTime Lib "registerDriver" (ByVal i As Integer, ByVal R As Integer) As Integer

    Private Declare Function cMeasureConversionTime Lib "registerDriver" (ByRef R As Integer) As Integer
    Private Declare Function cGetPartNumber Lib "registerDriver" (ByRef R As Integer) As Integer
    Private Declare Function cGetPartFamily Lib "registerDriver" (ByRef R As Integer) As Integer

    ' 29038
    Private Declare Function cSetProxIntEnable Lib "registerDriver" (ByVal x As Integer) As Integer
    Private Declare Function cGetProxIntEnable Lib "registerDriver" (ByRef x As Integer) As Integer
    Private Declare Function cSetProxOffset Lib "registerDriver" (ByVal x As Integer) As Integer
    Private Declare Function cGetProxOffset Lib "registerDriver" (ByRef x As Integer) As Integer
    Private Declare Function cSetIRcomp Lib "registerDriver" (ByVal x As Integer) As Integer
    Private Declare Function cGetIRcomp Lib "registerDriver" (ByRef x As Integer) As Integer
    Private Declare Function cGetProxAlrm Lib "registerDriver" (ByRef i As Integer) As Integer
    Private Declare Function cSetVddAlrm Lib "registerDriver" (ByVal x As Integer) As Integer
    Private Declare Function cGetVddAlrm Lib "registerDriver" (ByRef x As Integer) As Integer

    ' 29038 trim
    Private Declare Function cSetProxTrim Lib "registerDriver" (ByVal x As Integer) As Integer
    Private Declare Function cGetProxTrim Lib "registerDriver" (ByRef x As Integer) As Integer
    Private Declare Function cSetIrdrTrim Lib "registerDriver" (ByVal x As Integer) As Integer
    Private Declare Function cGetIrdrTrim Lib "registerDriver" (ByRef x As Integer) As Integer
    Private Declare Function cSetAlsTrim Lib "registerDriver" (ByVal x As Integer) As Integer
    Private Declare Function cGetAlsTrim Lib "registerDriver" (ByRef x As Integer) As Integer

    Private Declare Function cSetRegOtpSel Lib "registerDriver" (ByVal x As Integer) As Integer
    Private Declare Function cGetRegOtpSel Lib "registerDriver" (ByRef x As Integer) As Integer
    Private Declare Function cSetOtpData Lib "registerDriver" (ByVal x As Integer) As Integer
    Private Declare Function cGetOtpData Lib "registerDriver" (ByRef x As Integer) As Integer
    Private Declare Function cSetFuseWrEn Lib "registerDriver" (ByVal x As Integer) As Integer
    Private Declare Function cGetFuseWrEn Lib "registerDriver" (ByRef x As Integer) As Integer
    Private Declare Function cSetFuseWrAddr Lib "registerDriver" (ByVal x As Integer) As Integer
    Private Declare Function cGetFuseWrAddr Lib "registerDriver" (ByRef x As Integer) As Integer

    Private Declare Function cGetOptDone Lib "registerDriver" (ByRef x As Integer) As Integer
    Private Declare Function cSetIrdrDcPulse Lib "registerDriver" (ByVal x As Integer) As Integer
    Private Declare Function cGetIrdrDcPulse Lib "registerDriver" (ByRef x As Integer) As Integer
    Private Declare Function cGetGolden Lib "registerDriver" (ByRef x As Integer) As Integer
    Private Declare Function cSetOtpRes Lib "registerDriver" (ByVal x As Integer) As Integer
    Private Declare Function cGetOtpRes Lib "registerDriver" (ByRef x As Integer) As Integer
    Private Declare Function cSetIntTest Lib "registerDriver" (ByVal x As Integer) As Integer
    Private Declare Function cGetIntTest Lib "registerDriver" (ByRef x As Integer) As Integer

    ' RGB
    Private Declare Function cGetRed Lib "registerDriver" (ByRef x As Double) As Integer
    Private Declare Function cGetGreen Lib "registerDriver" (ByRef x As Double) As Integer
    Private Declare Function cGetBlue Lib "registerDriver" (ByRef x As Double) As Integer
    Private Declare Function cGetCCT Lib "registerDriver" (ByRef x As Double) As Integer

    Private Declare Function cGetRgbCoeffEnable Lib "registerDriver" (ByRef x As Integer) As Integer
    Private Declare Function cSetRgbCoeffEnable Lib "registerDriver" (ByVal x As Integer) As Integer

    Private Declare Function cLoadRgbCoeff Lib "registerDriver" (ByRef x As Double) As Integer
    Private Declare Function cClearRgbCoeff Lib "registerDriver" () As Integer
    Private Declare Function cEnable4x Lib "registerDriver" (ByVal m As Integer) As Integer
    Private Declare Function cEnable8bit Lib "registerDriver" (ByVal m As Integer) As Integer

    ' vb.Net Interface to dll without object??
    Public Declare Function cFloat2CharAry Lib "registerDriver" (ByVal f As Single, ByRef ca() As Byte) As Integer
    Public Declare Function cCharAry2Float Lib "registerDriver" (ByRef ca() As Byte, ByRef f As Single) As Integer
    Public Declare Function cDouble2CharAry Lib "registerDriver" (ByVal d As Double, ByRef ca() As Byte) As Integer
    Public Declare Function cCharAry2Double Lib "registerDriver" (ByRef ca() As Byte, ByRef d As Double) As Integer
    Public Declare Function cDate2CharAry Lib "registerDriver" (ByVal d As Date, ByRef ca() As Byte) As Integer
    Public Declare Function cCharAry2Date Lib "registerDriver" (ByRef ca() As Byte, ByRef d As Date) As Integer

    Public Declare Function LenB Lib "registerDriver" (ByRef s As Object) As Long ' JWG temp stub
    Public Declare Function Str2Unicode Lib "registerDriver" (ByRef s As String) As Long ' JWG temp stub
    Public Function _AddressOf(ByVal f As Long) As Long ' JWG temp stub
        _AddressOf = f
    End Function

    Private Declare Function VarPtr_ Lib "registerDriver" (ByRef s As Byte) As Integer
    Private Declare Function memcpy_ Lib "registerDriver" (ByRef o As Byte, ByRef i As Integer, ByVal nBytes As Integer) As Integer
    Private Declare Function cpyAddr2byte_ Lib "registerDriver" (ByRef o As Byte, ByVal i As Integer) As Integer
    Private Declare Function strcpy_ Lib "registerDriver" (ByRef o As String, ByRef i As Byte) As Integer









    Public pUsb As Object
    Private usbCaption As String
    Private gHwnd As Integer
    Private gDevLoaded As Boolean

    Public Shared Function VarPtr(ByRef s As Byte) As Integer
        'MsgBox("calling VarPtr")
        VarPtr = VarPtr_(s)
    End Function
    Public Shared Function memcpy(ByRef o As Byte, ByRef i As Integer, ByVal nBytes As Integer) As Integer
        'MsgBox("calling memcpy")
        memcpy = memcpy_(o, i, nBytes)
    End Function
    Public Shared Function cpyAddr2byte(ByRef o As Byte, ByVal i As Integer) As Integer
        'MsgBox("calling cpyAddr2byte")
        cpyAddr2byte = cpyAddr2byte_(o, i)
    End Function
    Public Shared Function strcpy(ByRef o As String, ByRef i As Byte) As Integer
        'MsgBox("calling strcpy")
        strcpy = strcpy_(o, i)
    End Function

    ' Temp Bypass API

    Public Sub writeByte(ByVal addr As Integer, ByVal data As Integer)
        Dim dataIn As Integer : dataIn = data
        cbIO(cmd.w, addr, dataIn)
    End Sub
    Public Sub writeWord(ByVal addr As Integer, ByVal data As Integer)
        Dim dataIn As Integer : dataIn = data
        cbIO(cmd.WW, addr, dataIn)
    End Sub
    Public Function readByte(ByVal addr As Integer) As Integer
        cbIO(cmd.R, addr, readByte)
    End Function
    Public Function readWord(ByVal addr As Integer) As Integer
        cbIO(cmd.RW, addr, readWord)
    End Function
    Private Sub cbIO(ByVal RW As Integer, ByVal addr As Integer, ByRef data As Integer)
        Call DllCallBack(RW, addr, data)
    End Sub

    ' ______________
    ' error Handling
    ' ��������������
    'UPGRADE_NOTE: error was upgraded to error_Renamed. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="A9E4979A-37FA-4718-9994-97DD76ED70A7"'
    Private Sub cSeterror(ByVal error_Renamed As dllCallBackFunction.status, Optional ByVal msg As String = "")

        If error_Renamed Then
            cerror = "                                    " ' initial allocation
            Call cGeterror(error_Renamed, cerror)
            cerror = Mid(cerror, 1, InStr(1, cerror, Chr(0)) - 1)
            If msg <> "" Then cerror = msg & " " & cerror
        Else
            msg = ""
        End If

    End Sub

    Public Function geterror() As String
        geterror = cerror
        cerror = "" ' clear on read
    End Function


    ' ________
    ' Wrappers
    ' ��������

    Public Function dGetData(ByVal c As Integer, ByRef v As Integer) As Integer
        dGetData = cGetData(c, v) : If dGetData Then Call cSeterror(dGetData, "dGetData:" & c & ":" & v)
    End Function
    Public Function dGetDevice(ByRef v As Integer) As Integer
        dGetDevice = cGetDevice(v) : If dGetDevice Then Call cSeterror(dGetDevice, "dGetDevice")
    End Function
    Public Function dGetDeviceList(ByRef Device As String) As Integer
        dGetDeviceList = cGetDeviceList(Device) : If dGetDeviceList Then Call cSeterror(dGetDeviceList, "dGetDeviceList")
    End Function
    Public Function dGetEnable(ByVal c As Integer, ByRef v As Integer) As Object
        dGetEnable = cGetEnable(c, v)
        'UPGRADE_WARNING: Couldn't resolve default property of object dGetEnable. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
        If dGetEnable Then Call cSeterror(dGetEnable, "dGetEnable:" & c & ":" & v)
    End Function
    Public Function dGetInputSelect(ByVal c As Integer, ByRef v As Integer) As Object
        dGetInputSelect = cGetInputSelect(c, v)
        'UPGRADE_WARNING: Couldn't resolve default property of object dGetInputSelect. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
        If dGetInputSelect Then Call cSeterror(dGetInputSelect, "dGetInputSelect:" & c & ":" & v)
    End Function
    Public Function dGetInputSelectList(ByRef c As Integer, ByRef v As String) As Object
        dGetInputSelectList = cGetInputSelectList(c, v)
        'UPGRADE_WARNING: Couldn't resolve default property of object dGetInputSelectList. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
        If dGetInputSelectList Then Call cSeterror(dGetInputSelectList, "dGetInputSelectList:" & c & ":" & v)
    End Function
    Public Function dGetIntFlag(ByVal c As Integer, ByRef v As Integer) As Object
        dGetIntFlag = cGetIntFlag(c, v)
        'UPGRADE_WARNING: Couldn't resolve default property of object dGetIntFlag. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
        If dGetIntFlag Then Call cSeterror(dGetIntFlag, "dGetIntFlag:" & c & ":" & v)
    End Function
    Public Function dGetIntLogic(ByRef E As Integer) As Object
        dGetIntLogic = cGetIntLogic(E)
        'UPGRADE_WARNING: Couldn't resolve default property of object dGetIntLogic. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
        If dGetIntLogic Then Call cSeterror(dGetIntLogic, "dGetIntLogic:" & E)
    End Function
    Public Function dGetIntPersist(ByVal c As Integer, ByRef m As Integer) As Object
        dGetIntPersist = cGetIntPersist(c, m)
        'UPGRADE_WARNING: Couldn't resolve default property of object dGetIntPersist. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
        If dGetIntPersist Then Call cSeterror(dGetIntPersist, "dGetIntPersist:" & c & ":" & m)
    End Function
    Public Function dGetIR(ByRef m As Double) As Object
        dGetIR = cGetIR(m)
        'UPGRADE_WARNING: Couldn't resolve default property of object dGetIR. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
        If dGetIR Then Call cSeterror(dGetIR, "dGetIR:" & m)
    End Function
    Public Function dGetIRState(ByRef m As Integer) As Object
        dGetIRState = cGetIRState(m)
        'UPGRADE_WARNING: Couldn't resolve default property of object dGetIRState. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
        If dGetIRState Then Call cSeterror(dGetIRState, "dGetIRState:" & m)
    End Function
    Public Function dGetIrdr(ByRef R As Integer) As Object
        dGetIrdr = cGetIrdr(R)
        'UPGRADE_WARNING: Couldn't resolve default property of object dGetIrdr. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
        If dGetIrdr Then Call cSeterror(dGetIrdr, "dGetIrdr:" & R)
    End Function
    Public Function dGetIrdrList(ByRef R As Integer) As Object
        dGetIrdrList = cGetIrdrList(R)
        'UPGRADE_WARNING: Couldn't resolve default property of object dGetIrdrList. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
        If dGetIrdrList Then Call cSeterror(dGetIrdrList, "dGetIrdrList:" & R)
    End Function
    Public Function dGetLux(ByRef v As Double) As Object
        dGetLux = cGetLux(v)
        'UPGRADE_WARNING: Couldn't resolve default property of object dGetLux. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
        If dGetLux Then Call cSeterror(dGetLux, "dGetLux:" & v)
    End Function
    Public Function dGetLuxState(ByRef v As Integer) As Object
        dGetLuxState = cGetLuxState(v)
        'UPGRADE_WARNING: Couldn't resolve default property of object dGetLuxState. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
        If dGetLuxState Then Call cSeterror(dGetLuxState, "dGetLuxState:" & v)
    End Function



    Public Function dGetNdevice(ByRef Ndevices As Integer) As Integer
        dGetNdevice = cGetNdevice(Ndevices) : If dGetNdevice Then Call cSeterror(dGetNdevice, "dGetNdevice")
    End Function
    Public Function dGetNchannel(ByRef v As Integer) As Object
        dGetNchannel = cGetNchannel(v)
        'UPGRADE_WARNING: Couldn't resolve default property of object dGetNchannel. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
        If dGetNchannel Then Call cSeterror(dGetNchannel, "dGetNchannel:" & v)
    End Function
    Public Function dGetNinputSelect(ByVal c As Integer, ByRef v As Integer) As Object
        dGetNinputSelect = cGetNinputSelect(c, v)
        'UPGRADE_WARNING: Couldn't resolve default property of object dGetNinputSelect. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
        If dGetNinputSelect Then Call cSeterror(dGetNinputSelect, "dGetNinputSelect:" & c & ":" & v)
    End Function
    Public Function dGetNrange(ByVal c As Integer, ByRef v As Integer) As Object
        dGetNrange = cGetNrange(c, v)
        'UPGRADE_WARNING: Couldn't resolve default property of object dGetNrange. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
        If dGetNrange Then Call cSeterror(dGetNrange, "dGetNrange:" & c & ":" & v)
    End Function
    Public Function dGetNresolution(ByVal c As Integer, ByRef v As Integer) As Object
        dGetNresolution = cGetNresolution(c, v)
        'UPGRADE_WARNING: Couldn't resolve default property of object dGetNresolution. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
        If dGetNresolution Then Call cSeterror(dGetNresolution, "dGetNresolution:" & c & ":" & v)
    End Function
    Public Function dGetNirdr(ByRef R As Integer) As Object
        dGetNirdr = cGetNirdr(R)
        'UPGRADE_WARNING: Couldn't resolve default property of object dGetNirdr. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
        If dGetNirdr Then Call cSeterror(dGetNirdr, "dGetNirdr:" & R)
    End Function
    Public Function dGetNintPersist(ByVal c As Integer, ByRef v As Integer) As Object
        dGetNintPersist = cGetNintPersist(c, v)
        'UPGRADE_WARNING: Couldn't resolve default property of object dGetNintPersist. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
        If dGetNintPersist Then Call cSeterror(dGetNintPersist, "dGetNintPersist:" & c & ":" & v)
    End Function
    Public Function dGetNsleep(ByRef v As Integer) As Object
        dGetNsleep = cGetNsleep(v)
        'UPGRADE_WARNING: Couldn't resolve default property of object dGetNsleep. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
        If dGetNsleep Then Call cSeterror(dGetNsleep, "dGetNsleep:" & v)
    End Function


    Public Function dGetProxAmbRej(ByRef E As Integer) As Object
        dGetProxAmbRej = cGetProxAmbRej(E)
        'UPGRADE_WARNING: Couldn't resolve default property of object dGetProxAmbRej. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
        If dGetProxAmbRej Then Call cSeterror(dGetProxAmbRej, "dGetProxAmbRej:" & E)
    End Function
    Public Function dGetProximity(ByRef E As Double) As Object
        dGetProximity = cGetProximity(E)
        'UPGRADE_WARNING: Couldn't resolve default property of object dGetProximity. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
        If dGetProximity Then Call cSeterror(dGetProximity, "dGetProximity:" & E)
    End Function
    Public Function dGetProxIR(ByRef E As Double) As Object
        Dim iFlag As Integer
        dGetProxIR = cGetProxIR(E, iFlag)
        'UPGRADE_WARNING: Couldn't resolve default property of object dGetProxIR. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
        If dGetProxIR Then Call cSeterror(dGetProxIR, "dGetProxIR:" & E)
    End Function
    Public Function dGetProxAlrm(ByRef a As Integer) As Object
        dGetProxAlrm = cGetProxAlrm(a)
        'UPGRADE_WARNING: Couldn't resolve default property of object dGetProxAlrm. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
        If dGetProxAlrm Then Call cSeterror(dGetProxAlrm, "dGetProxAlrm:" & a)
    End Function
    Public Function dGetProximityState(ByRef E As Integer) As Object
        dGetProximityState = cGetProximityState(E)
        'UPGRADE_WARNING: Couldn't resolve default property of object dGetProximityState. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
        If dGetProximityState Then Call cSeterror(dGetProximityState, "dGetProximityState:" & E)
    End Function
    Public Function dGetProxPersist(ByRef m As Integer) As Object
        dGetProxPersist = cGetProxPersist(m)
        'UPGRADE_WARNING: Couldn't resolve default property of object dGetProxPersist. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
        If dGetProxPersist Then Call cSeterror(dGetProxPersist, "dGetProxPersist:" & m)
    End Function
    Public Function dGetRange(ByVal c As Integer, ByRef v As Integer) As Object
        dGetRange = cGetRange(c, v)
        'UPGRADE_WARNING: Couldn't resolve default property of object dGetRange. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
        If dGetRange Then Call cSeterror(dGetRange, "dGetRange:" & c & ":" & v)
    End Function

    Public Function dGetStateMachineEnable(ByRef E As Integer) As Integer
        dGetStateMachineEnable = cGetStateMachineEnable(E) : If dGetStateMachineEnable Then Call cSeterror(dGetStateMachineEnable, "dGetStateMachineEnable")
    End Function

    Public Function dSetStateMachineEnable(ByVal E As Integer) As Integer
        dSetStateMachineEnable = cSetStateMachineEnable(E) : If dSetStateMachineEnable Then Call cSeterror(dSetStateMachineEnable, "dSetStateMachineEnable")
    End Function



    Public Function dGetByteIoOnly(ByRef E As Integer) As Integer
        dGetByteIoOnly = cGetByteIoOnly(E) : If dGetByteIoOnly Then Call cSeterror(dGetByteIoOnly, "dGetByteIoOnly")
    End Function

    Public Function dSetByteIoOnly(ByVal E As Integer) As Integer
        dSetByteIoOnly = cSetByteIoOnly(E) : If dSetByteIoOnly Then Call cSeterror(dSetByteIoOnly, "dSetByteIoOnly")
    End Function



    Public Function dGetStats(ByRef i As Integer, ByRef m As Double, ByRef s As Double) As Integer
        dGetStats = cGetStats(i, m, s) : If dGetStats Then Call cSeterror(dGetStats, "dGetStats")
    End Function



    ' ________
    ' Pre-sort
    ' ��������

    Public Function dSetThreshHi(ByVal c As Integer, ByRef v As Double) As Object
        dSetThreshHi = cSetThreshHi(c, v)
        'UPGRADE_WARNING: Couldn't resolve default property of object dSetThreshHi. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
        If dSetThreshHi Then Call cSeterror(dSetThreshHi, "dSetThreshHi:" & c & ":" & v)
    End Function
    Public Function dGetThreshHi(ByVal c As Integer, ByRef v As Double) As Object
        dGetThreshHi = cGetThreshHi(c, v)
        'UPGRADE_WARNING: Couldn't resolve default property of object dGetThreshHi. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
        If dGetThreshHi Then Call cSeterror(dGetThreshHi, "dGetThreshHi:" & c & ":" & v)
    End Function
    Public Function dSetThreshLo(ByVal c As Integer, ByRef v As Double) As Object
        dSetThreshLo = cSetThreshLo(c, v)
        'UPGRADE_WARNING: Couldn't resolve default property of object dSetThreshLo. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
        If dSetThreshLo Then Call cSeterror(dSetThreshLo, "dSetThreshLo:" & c & ":" & v)
    End Function
    Public Function dGetThreshLo(ByVal c As Integer, ByRef v As Double) As Object
        dGetThreshLo = cGetThreshLo(c, v)
        'UPGRADE_WARNING: Couldn't resolve default property of object dGetThreshLo. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
        If dGetThreshLo Then Call cSeterror(dGetThreshLo, "dGetThreshLo:" & c & ":" & v)
    End Function
    Public Function dGetIrdrFreq(ByRef E As Integer) As Object
        dGetIrdrFreq = cGetIrdrFreq(E)
        'UPGRADE_WARNING: Couldn't resolve default property of object dGetIrdrFreq. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
        If dGetIrdrFreq Then Call cSeterror(dGetIrdrFreq, "dGetIrdrFreq:" & E)
    End Function






    Public Function dSetRunMode(ByRef m As Integer) As Object
        dSetRunMode = cSetRunMode(m)
        'UPGRADE_WARNING: Couldn't resolve default property of object dSetRunMode. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
        If dSetRunMode Then Call cSeterror(dSetRunMode, "dSetRunMode:" & m)
    End Function
    Public Function dGetRunMode(ByRef m As Integer) As Object
        dGetRunMode = cGetRunMode(m)
        'UPGRADE_WARNING: Couldn't resolve default property of object dGetRunMode. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
        If dGetRunMode Then Call cSeterror(dGetRunMode, "dGetRunMode:" & m)
    End Function


    Public Function dSetEnable(ByVal c As Integer, ByRef v As Integer) As Object
        dSetEnable = cSetEnable(c, v)
        'UPGRADE_WARNING: Couldn't resolve default property of object dSetEnable. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
        If dSetEnable Then Call cSeterror(dSetEnable, "dSetEnable:" & c & ":" & v)
    End Function


    Public Function dGetProxFlag(ByRef E As Integer) As Object
        dGetProxFlag = cGetProxFlag(E)
        'UPGRADE_WARNING: Couldn't resolve default property of object dGetProxFlag. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
        If dGetProxFlag Then Call cSeterror(dGetProxFlag, "dGetEnable:" & E)
    End Function

    Public Function dSetIntLogic(ByRef E As Integer) As Object
        dSetIntLogic = cSetIntLogic(E)
        'UPGRADE_WARNING: Couldn't resolve default property of object dSetIntLogic. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
        If dSetIntLogic Then Call cSeterror(dSetIntLogic, "dSetIntLogic:" & E)
    End Function



    Public Function dSetIntPersist(ByRef c As Integer, ByRef m As Integer) As Object
        dSetIntPersist = cSetIntPersist(c, m)
        'UPGRADE_WARNING: Couldn't resolve default property of object dSetIntPersist. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
        If dSetIntPersist Then Call cSeterror(dSetIntPersist, "dSetIntPersist:" & c & ":" & m)
    End Function

    Public Function dSetProxAmbRej(ByRef E As Integer) As Object
        dSetProxAmbRej = cSetProxAmbRej(E)
        'UPGRADE_WARNING: Couldn't resolve default property of object dSetProxAmbRej. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
        If dSetProxAmbRej Then Call cSeterror(dSetProxAmbRej, "dSetProxAmbRej:" & E)
    End Function

    Public Function dSetIrdrFreq(ByRef E As Integer) As Object
        dSetIrdrFreq = cSetIrdrFreq(E)
        'UPGRADE_WARNING: Couldn't resolve default property of object dSetIrdrFreq. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
        If dSetIrdrFreq Then Call cSeterror(dSetIrdrFreq, "dSetIrdrFreq:" & E)
    End Function

    Public Function dSetPWMen(ByRef E As Integer) As Object
        dSetPWMen = cSetPWMen(E)
        'UPGRADE_WARNING: Couldn't resolve default property of object dSetPWMen. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
        If dSetPWMen Then Call cSeterror(dSetPWMen, "dSetPWMen:" & E)
    End Function


    Public Function dSetIrdr(ByVal R As Integer) As Object
        dSetIrdr = cSetIrdr(R)
        'UPGRADE_WARNING: Couldn't resolve default property of object dSetIrdr. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
        If dSetIrdr Then Call cSeterror(dSetIrdr, "dSetIrdr:" & R)
    End Function




    Public Function dSetResolution(ByVal c As Integer, ByVal v As Integer) As Object
        pTempDrv.dSetResolution(c, v)
        'dSetResolution = cSetResolution(c, v)
        ''UPGRADE_WARNING: Couldn't resolve default property of object dSetResolution. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
        'If dSetResolution Then Call cSeterror(dSetResolution, "dSetResolution:" & c & ":" & v)
    End Function
    Public Function dGetResolution(ByVal c As Integer, ByRef v As Integer) As Object
        dGetResolution = cGetResolution(c, v)
        'UPGRADE_WARNING: Couldn't resolve default property of object dGetResolution. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
        If dGetResolution Then Call cSeterror(dGetResolution, "dGetResolution:" & c & ":" & v)
    End Function







    Public Function dGetRangeList(ByVal c As Integer, ByRef v As Integer) As Object
        dGetRangeList = cGetRangeList(c, v)
        'UPGRADE_WARNING: Couldn't resolve default property of object dGetRangeList. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
        If dGetRangeList Then Call cSeterror(dGetRangeList, "dGetRangeList:" & c & ":" & v)
    End Function
    Public Function dGetResolutionList(ByRef c As Integer, ByRef v As Integer) As Object
        dGetResolutionList = cGetResolutionList(c, v)
        'UPGRADE_WARNING: Couldn't resolve default property of object dGetResolutionList. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
        If dGetResolutionList Then Call cSeterror(dGetResolutionList, "dGetResolutionList:" & c & ":" & v)
    End Function
    Public Function dGetIntPersistList(ByRef c As Integer, ByRef v As Integer) As Object
        dGetIntPersistList = cGetIntPersistList(c, v)
        'UPGRADE_WARNING: Couldn't resolve default property of object dGetIntPersistList. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
        If dGetIntPersistList Then Call cSeterror(dGetIntPersistList, "dGetIntPersistList:" & c & ":" & v)
    End Function
    Public Function dGetSleepList(ByRef v As Integer) As Object
        dGetSleepList = cGetSleepList(v)
        'UPGRADE_WARNING: Couldn't resolve default property of object dGetSleepList. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
        If dGetSleepList Then Call cSeterror(dGetSleepList, "dGetSleepList:" & v)
    End Function





    Public Function dSetRange(ByVal c As Integer, ByVal v As Integer) As Object
        pTempDrv.dSetRange(c, v)
        'dSetRange = cSetRange(c, v)
        ''UPGRADE_WARNING: Couldn't resolve default property of object dSetRange. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
        'If dSetRange Then Call cSeterror(dSetRange, "dSetRange:" & c & ":" & v)
    End Function

    Public Function dSetSleep(ByRef v As Integer) As Object
        dSetSleep = cSetSleep(v)
        'UPGRADE_WARNING: Couldn't resolve default property of object dSetSleep. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
        If dSetSleep Then Call cSeterror(dSetSleep, "dSetSleep:" & v)
    End Function
    Public Function dGetSleep(ByRef v As Integer) As Object
        dGetSleep = cGetSleep(v)
        'UPGRADE_WARNING: Couldn't resolve default property of object dGetSleep. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
        If dGetSleep Then Call cSeterror(dGetSleep, "dGetSleep:" & v)
    End Function






    Public Function dSetInputSelect(ByVal c As Integer, ByVal v As Integer) As Object
        pTempDrv.dSetInputSelect(c, v)
        'dSetInputSelect = cSetInputSelect(c, v)
        ''UPGRADE_WARNING: Couldn't resolve default property of object dSetInputSelect. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
        'If dSetInputSelect Then Call cSeterror(dSetInputSelect, "dSetInputSelect:" & c & ":" & v)
    End Function



    ' ____
    ' Data
    ' ����
    Public Function dSetMPAsize(ByVal c As Integer, ByRef v As Integer) As Object
        dSetMPAsize = cSetMPAsize(c, v)
        'UPGRADE_WARNING: Couldn't resolve default property of object dSetMPAsize. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
        If dSetMPAsize Then Call cSeterror(dSetMPAsize, "dSetMPAsize:" & c & ":" & v)
    End Function
    Public Function dGetMPAprimed(ByVal c As Integer, ByRef v As Integer) As Object
        dGetMPAprimed = cGetMPAprimed(c, v)
        'UPGRADE_WARNING: Couldn't resolve default property of object dGetMPAprimed. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
        If dGetMPAprimed Then Call cSeterror(dGetMPAprimed, "dGetMPAprimed:" & c & ":" & v)
    End Function

    ' _________________
    ' Pass Callback sub
    ' �����������������
    Public Function dSetDrvApi(ByVal pFunc As Integer) As Integer
        'dSetDrvApi = cSetDrvApi(pFunc)
        'If dSetDrvApi Then Call cSeterror(dSetDrvApi, "dSetCallBack")
    End Function
    Public Function dInitDriver() As Integer
        dInitDriver = cInitDriver()
        If dInitDriver Then Call cSeterror(dInitDriver, "dInitDriver")
    End Function
    ' ________________
    ' Resource Manager
    ' ����������������


    Public Function dSetDevice(ByVal v As Integer) As Integer
        dSetDevice = cSetDevice(v)
        If dSetDevice Then Call cSeterror(dSetDevice, "dSetDevice")
    End Function




    Public Function dTest(ByRef t As Integer) As Integer
        dTest = cTest(t)
        If dTest Then Call cSeterror(dTest, "dTest")
    End Function


    Public Function dIO(ByVal c As Integer, ByVal a As Integer, ByRef D As Integer) As Integer
        dIO = cIO(c, a, D)
        If dIO Then Call cSeterror(dIO, "dIO")
    End Function

    Public Function dWriteField(ByVal a As Integer, ByVal s As Byte, ByVal m As Byte, ByVal D As Byte) As Integer
        dWriteField = cWriteField(a, s, m, D)
        If dWriteField Then Call cSeterror(dWriteField, "dWriteField")
    End Function

    Public Function dReadField(ByVal a As Integer, ByVal s As Byte, ByVal m As Byte, ByRef D As Byte) As Integer
        dReadField = cReadField(a, s, m, D)
        If dReadField Then Call cSeterror(dReadField, "dReadField")
    End Function





    Public Function dWriteI2c(ByVal i2cAddr As Integer, ByVal addr As Integer, ByVal data As Byte) As Object
        Dim ldata As Integer : ldata = data
        Dim lI2cAddr As Integer : lI2cAddr = i2cAddr

        If useDllIO Then
            dWriteI2c = cWriteI2c(i2cAddr, addr, ldata)
            'UPGRADE_WARNING: Couldn't resolve default property of object dWriteI2c. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
            If dWriteI2c Then Call cSeterror(dWriteI2c, "dWriteI2c")
        Else
            Call DllCallBack(cmd.WA, lI2cAddr, lI2cAddr)
            Call DllCallBack(cmd.w, addr, ldata)
        End If

        Call DllCallBack(cmd.WA, gI2cAddr, gI2cAddr)

    End Function

    Public Function dWriteI2cWord(ByVal i2cAddr As Integer, ByVal addr As Byte, ByVal data As Integer) As Object
        Dim ldata As Integer : ldata = data
        Dim lI2cAddr As Integer : lI2cAddr = i2cAddr

        If useDllIO Then
            dWriteI2cWord = cWriteI2cWord(i2cAddr, addr, ldata)
            'UPGRADE_WARNING: Couldn't resolve default property of object dWriteI2cWord. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
            If dWriteI2cWord Then Call cSeterror(dWriteI2cWord, "dWriteI2cWord")
        Else
            Call DllCallBack(cmd.WA, lI2cAddr, lI2cAddr)
            Call DllCallBack(cmd.WW, addr, ldata)
        End If

        Call DllCallBack(cmd.WA, gI2cAddr, gI2cAddr)

    End Function

    Public Function dReadI2c(ByVal i2cAddr As Integer, ByVal addr As Byte, ByRef data As Byte) As Object
        Dim ldata As Integer : ldata = data
        Dim lI2cAddr As Integer : lI2cAddr = i2cAddr

        If useDllIO Then
            dReadI2c = cReadI2c(i2cAddr, addr, data)
            'UPGRADE_WARNING: Couldn't resolve default property of object dReadI2c. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
            If dReadI2c Then Call cSeterror(dReadI2c, "dReadI2c")
        Else
            Call DllCallBack(cmd.WA, lI2cAddr, lI2cAddr)
            Call DllCallBack(cmd.R, addr, ldata)
            ldata = ldata And &HFF : data = ldata
        End If

        Call DllCallBack(cmd.WA, gI2cAddr, gI2cAddr)

    End Function

    Public Function dReadI2cWord(ByVal i2cAddr As Integer, ByVal addr As Byte, ByRef data As Integer) As Object
        Dim lI2cAddr As Integer : lI2cAddr = i2cAddr

        If useDllIO Then
            dReadI2cWord = cReadI2cWord(i2cAddr, addr, data)
            'UPGRADE_WARNING: Couldn't resolve default property of object dReadI2cWord. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
            If dReadI2cWord Then Call cSeterror(dReadI2cWord, "dReadI2cWord")
        Else
            Call DllCallBack(cmd.WA, lI2cAddr, lI2cAddr)
            Call DllCallBack(cmd.RW, addr, data)
        End If

        Call DllCallBack(cmd.WA, gI2cAddr, gI2cAddr)

    End Function









    Public Function dPoll(ByRef t As Integer) As Integer
        dPoll = cPoll(t)
        If dPoll Then Call cSeterror(dPoll, "dPoll")
    End Function

    Public Function dPrintTrace(ByRef t As String) As Integer
        dPrintTrace = cPrintTrace(t)
        If dPrintTrace Then Call cSeterror(dPrintTrace, "dPrintTrace")
    End Function

    Public Function dResetDevice() As Integer
        dResetDevice = cResetDevice()
        If dResetDevice Then Call cSeterror(dResetDevice, "dResetDevice")
    End Function


    Public Function dGetConversionTime(ByVal c As Integer, ByRef v As Integer) As Object
        dGetConversionTime = cGetConversionTime(c, v)
        'UPGRADE_WARNING: Couldn't resolve default property of object dGetConversionTime. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
        If dGetConversionTime Then Call cSeterror(dGetConversionTime, "dGetConversionTime:" & c & ":" & v)
    End Function

    Public Function dSetConversionTime(ByVal c As Integer, ByVal v As Integer) As Object
        dSetConversionTime = cSetConversionTime(c, v)
        'UPGRADE_WARNING: Couldn't resolve default property of object dSetConversionTime. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
        If dSetConversionTime Then Call cSeterror(dSetConversionTime, "dSetConversionTime:" & c & ":" & v)
    End Function

    Public Function dMeasureConversionTime(ByRef v As Integer) As Object
        dMeasureConversionTime = cMeasureConversionTime(v)
        'UPGRADE_WARNING: Couldn't resolve default property of object dMeasureConversionTime. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
        If dMeasureConversionTime Then Call cSeterror(dMeasureConversionTime, "dMeasureConversionTime:" & v)
    End Function

    Public Function dGetPartNumber(ByRef v As Integer) As Object
        dGetPartNumber = cGetPartNumber(v)
        'UPGRADE_WARNING: Couldn't resolve default property of object dGetPartNumber. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
        If dGetPartNumber Then Call cSeterror(dGetPartNumber, "dGetPartNumber:" & v)
    End Function
    Public Function dGetPartFamily(ByRef v As Integer) As Object
        dGetPartFamily = cGetPartFamily(v)
        'UPGRADE_WARNING: Couldn't resolve default property of object dGetPartFamily. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
        If dGetPartFamily Then Call cSeterror(dGetPartFamily, "dGetPartFamily:" & v)
    End Function



    ' _____
    ' 29038
    ' �����
    Public Function dSetProxIntEnable(ByVal x As Integer) As Integer
        dSetProxIntEnable = cSetProxIntEnable(x)
        If dSetProxIntEnable Then Call cSeterror(dSetProxIntEnable, "dSetProxIntEnable")
    End Function
    Public Function dGetProxIntEnable(ByRef x As Integer) As Integer
        dGetProxIntEnable = cGetProxIntEnable(x)
        If dGetProxIntEnable Then Call cSeterror(dGetProxIntEnable, "dGetProxIntEnable")
    End Function

    Public Function dSetProxOffset(ByVal x As Integer) As Integer
        dSetProxOffset = cSetProxOffset(x)
        If dSetProxOffset Then Call cSeterror(dSetProxOffset, "dSetProxOffset")
    End Function
    Public Function dGetProxOffset(ByRef x As Integer) As Integer
        dGetProxOffset = cGetProxOffset(x)
        If dGetProxOffset Then Call cSeterror(dGetProxOffset, "dGetProxOffset")
    End Function

    Public Function dSetIRcomp(ByVal x As Integer) As Integer
        dSetIRcomp = cSetIRcomp(x)
        If dSetIRcomp Then Call cSeterror(dSetIRcomp, "dSetIRcomp")
    End Function
    Public Function dGetIRcomp(ByRef x As Integer) As Integer
        dGetIRcomp = cGetIRcomp(x)
        If dGetIRcomp Then Call cSeterror(dGetIRcomp, "dGetIRcomp")
    End Function

    Public Function dSetVddAlrm(ByVal x As Integer) As Integer
        dSetVddAlrm = cSetVddAlrm(x)
        If dSetVddAlrm Then Call cSeterror(dSetVddAlrm, "dSetVddAlrm")
    End Function
    Public Function dGetVddAlrm(ByRef x As Integer) As Integer
        dGetVddAlrm = cGetVddAlrm(x)
        If dGetVddAlrm Then Call cSeterror(dGetVddAlrm, "dGetVddAlrm")
    End Function

    ' __________
    ' 29038 Trim
    ' ����������
    Public Function dSetProxTrim(ByVal x As Integer) As Integer
        dSetProxTrim = cSetProxTrim(x)
        If dSetProxTrim Then Call cSeterror(dSetProxTrim, "dSetProxTrim")
    End Function
    Public Function dGetProxTrim(ByRef x As Integer) As Integer
        dGetProxTrim = cGetProxTrim(x)
        If dGetProxTrim Then Call cSeterror(dGetProxTrim, "dGetProxTrim")
    End Function

    Public Function dSetIrdrTrim(ByVal x As Integer) As Integer
        dSetIrdrTrim = cSetIrdrTrim(x)
        If dSetIrdrTrim Then Call cSeterror(dSetIrdrTrim, "dSetIrdrTrim")
    End Function
    Public Function dGetIrdrTrim(ByRef x As Integer) As Integer
        dGetIrdrTrim = cGetIrdrTrim(x)
        If dGetIrdrTrim Then Call cSeterror(dGetIrdrTrim, "dGetIrdrTrim")
    End Function

    Public Function dSetAlsTrim(ByVal x As Integer) As Integer
        dSetAlsTrim = cSetAlsTrim(x)
        If dSetAlsTrim Then Call cSeterror(dSetAlsTrim, "dSetAlsTrim")
    End Function
    Public Function dGetAlsTrim(ByRef x As Integer) As Integer
        dGetAlsTrim = cGetAlsTrim(x)
        If dGetAlsTrim Then Call cSeterror(dGetAlsTrim, "dGetAlsTrim")
    End Function


    Public Function dSetRegOtpSel(ByVal x As Integer) As Integer
        dSetRegOtpSel = cSetRegOtpSel(x)
        If dSetRegOtpSel Then Call cSeterror(dSetRegOtpSel, "dSetRegOtpSel")
    End Function
    Public Function dGetRegOtpSel(ByRef x As Integer) As Integer
        dGetRegOtpSel = cGetRegOtpSel(x)
        If dGetRegOtpSel Then Call cSeterror(dGetRegOtpSel, "dGetRegOtpSel")
    End Function


    Public Function dSetOtpData(ByVal x As Integer) As Integer
        dSetOtpData = cSetOtpData(x)
        If dSetOtpData Then Call cSeterror(dSetOtpData, "dSetOtpData")
    End Function
    Public Function dGetOtpData(ByRef x As Integer) As Integer
        dGetOtpData = cGetOtpData(x)
        If dGetOtpData Then Call cSeterror(dGetOtpData, "dGetOtpData")
    End Function

    Public Function dSetFuseWrEn(ByVal x As Integer) As Integer
        dSetFuseWrEn = cSetFuseWrEn(x)
        If dSetFuseWrEn Then Call cSeterror(dSetFuseWrEn, "dSetFuseWrEn")
    End Function
    Public Function dGetFuseWrEn(ByRef x As Integer) As Integer
        dGetFuseWrEn = cGetFuseWrEn(x)
        If dGetFuseWrEn Then Call cSeterror(dGetFuseWrEn, "dGetFuseWrEn")
    End Function

    Public Function dSetFuseWrAddr(ByVal x As Integer) As Integer
        dSetFuseWrAddr = cSetFuseWrAddr(x)
        If dSetFuseWrAddr Then Call cSeterror(dSetFuseWrAddr, "dSetFuseWrAddr")
    End Function
    Public Function dGetFuseWrAddr(ByRef x As Integer) As Integer
        dGetFuseWrAddr = cGetFuseWrAddr(x)
        If dGetFuseWrAddr Then Call cSeterror(dGetFuseWrAddr, "dGetFuseWrAddr")
    End Function


    Public Function dGetOptDone(ByRef x As Integer) As Integer
        dGetOptDone = cGetOptDone(x)
        If dGetOptDone Then Call cSeterror(dGetOptDone, "dGetOptDone")
    End Function

    Public Function dSetIrdrDcPulse(ByVal x As Integer) As Integer
        dSetIrdrDcPulse = cSetIrdrDcPulse(x)
        If dSetIrdrDcPulse Then Call cSeterror(dSetIrdrDcPulse, "dSetIrdrDcPulse")
    End Function
    Public Function dGetIrdrDcPulse(ByRef x As Integer) As Integer
        dGetIrdrDcPulse = cGetIrdrDcPulse(x)
        If dGetIrdrDcPulse Then Call cSeterror(dGetIrdrDcPulse, "dGetIrdrDcPulse")
    End Function

    Public Function dGetGolden(ByRef x As Integer) As Integer
        dGetGolden = cGetGolden(x)
        If dGetGolden Then Call cSeterror(dGetGolden, "dGetGolden")
    End Function

    Public Function dSetOtpRes(ByVal x As Integer) As Integer
        dSetOtpRes = cSetOtpRes(x)
        If dSetOtpRes Then Call cSeterror(dSetOtpRes, "dSetOtpRes")
    End Function
    Public Function dGetOtpRes(ByRef x As Integer) As Integer
        dGetOtpRes = cGetOtpRes(x)
        If dGetOtpRes Then Call cSeterror(dGetOtpRes, "dGetOtpRes")
    End Function

    Public Function dSetIntTest(ByVal x As Integer) As Integer
        dSetIntTest = cSetIntTest(x)
        If dSetIntTest Then Call cSeterror(dSetIntTest, "dSetIntTest")
    End Function
    Public Function dGetIntTest(ByRef x As Integer) As Integer
        dGetIntTest = cGetIntTest(x)
        If dGetIntTest Then Call cSeterror(dGetIntTest, "dGetIntTest")
    End Function


    ' RGB
    Public Function dGetRed(ByRef x As Double) As Integer
        pTempDrv.dGetRed(x)
        'dGetRed = cGetRed(x)
        'If dGetRed Then Call cSeterror(dGetRed, "dGetRed")
    End Function
    Public Function dGetGreen(ByRef x As Double) As Integer
        pTempDrv.dGetGreen(x)
        'dGetGreen = cGetGreen(x)
        'If dGetGreen Then Call cSeterror(dGetGreen, "dGetGreen")
    End Function
    Public Function dGetBlue(ByRef x As Double) As Integer
        pTempDrv.dGetBlue(x)
        'dGetBlue = cGetBlue(x)
        'If dGetBlue Then Call cSeterror(dGetBlue, "dGetBlue")
    End Function
    Public Function dGetCCT(ByRef x As Double) As Integer
        dGetCCT = cGetCCT(x)
        If dGetCCT Then Call cSeterror(dGetCCT, "dGetCCT")
    End Function
    Public Function dGetRgbCoeffEnable(ByRef x As Integer) As Integer
        dGetRgbCoeffEnable = cGetRgbCoeffEnable(x)
        If dGetRgbCoeffEnable Then Call cSeterror(dGetRgbCoeffEnable, "dGetRgbCoeffEnable")
    End Function
    Public Function dSetRgbCoeffEnable(ByVal x As Integer) As Integer
        dSetRgbCoeffEnable = cSetRgbCoeffEnable(x)
        If dSetRgbCoeffEnable Then Call cSeterror(dSetRgbCoeffEnable, "dSetRgbCoeffEnable")
    End Function
    Public Function dLoadRgbCoeff(ByRef x() As Double) As Integer
        dLoadRgbCoeff = cLoadRgbCoeff(x(0))
        If dLoadRgbCoeff Then Call cSeterror(dLoadRgbCoeff, "dLoadRgbCoeff")
    End Function
    Public Function dClearRgbCoeff() As Integer
        dClearRgbCoeff = cClearRgbCoeff()
        If dClearRgbCoeff Then Call cSeterror(dClearRgbCoeff, "dClearRgbCoeff")
    End Function
    Public Function dEnable4x(ByVal x As Integer) As Integer
        dEnable4x = cEnable4x(x)
        If dEnable4x Then Call cSeterror(dEnable4x, "dEnable4x")
    End Function
    Public Function dEnable8bit(ByVal x As Integer) As Integer
        dEnable8bit = cEnable8bit(x)
        If dEnable8bit Then Call cSeterror(dEnable8bit, "dEnable8bit")
    End Function











    Private Sub loadCmbList(ByRef cmbIn As System.Windows.Forms.ComboBox, ByRef nDev As Integer, ByRef devList As String)
        Dim i, j As Integer
        Dim Dev As String
        cmbIn.Items.Clear()
        For i = 0 To nDev - 1
            Dev = Mid(devList, j + 1, InStr(j + 1, devList, Chr(0)) - (j + 1))
            j = j + Len(Dev) + 1 ' jump NULL
            cmbIn.Items.Add((Dev))
        Next i
    End Sub

    Private Sub LoadDevice()
        ' ___________________________________
        ' Load Supported Device List from DLL
        ' �����������������������������������
        Dim Ndevices As Integer

        Dim devs, Dev As String
        Dim i, j, err As Integer

        err = dGetNdevice(Ndevices)
        If err Then
            handleerror(("LoadDevice: " & modHIDusb.getError(err)))
        Else : j = 0
            devs = " " : For i = 0 To 10 : devs = devs & devs : Next i

            err = dGetDeviceList(devs)
            If err Then
                handleerror(("LoadDevice: " & modHIDusb.getError(err)))
            Else ' get single dev from devs list separated by NULL

                Call loadCmbList(cmbDevice, Ndevices, devs)

                Call dGetDevice((cmbDevice.SelectedIndex))

            End If

        End If

    End Sub

    Private Sub LoadInputSelect(Optional ByRef channel As Integer = 0)
        ' __________________________________
        ' Load Input Selection List from DLL
        ' ����������������������������������
        Dim devs As String
        Dim nInputSelect, i, inputSelect, err As Integer

        If gDevLoaded Then
            'UPGRADE_WARNING: Couldn't resolve default property of object dGetInputSelect(channel, inputSelect). Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
            err = dGetInputSelect(channel, inputSelect)
            If err Then
                handleerror(("LoadInputSelect: " & modHIDusb.getError(err)))
            Else
                cmbInputSelect.SelectedIndex = inputSelect
            End If
        Else
            'UPGRADE_WARNING: Couldn't resolve default property of object dGetNinputSelect(channel, nInputSelect). Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
            err = dGetNinputSelect(channel, nInputSelect)
            If err Then
                handleerror(("LoadInputSelect: " & modHIDusb.getError(err)))
            Else
                'Dim devs As String, Dev As String, i As Long, j As Long: j = 0
                devs = " " : For i = 0 To 10 : devs = devs & devs : Next i : devs = devs & Chr(0)

                'UPGRADE_WARNING: Couldn't resolve default property of object dGetInputSelectList(channel, devs). Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
                err = dGetInputSelectList(channel, devs)
                If err Then
                    handleerror(("LoadInputSelect: " & modHIDusb.getError(err)))
                Else ' get single dev from devs list separated by NULL
                    Call loadCmbList(cmbInputSelect, nInputSelect, devs)
                End If

            End If

            If nInputSelect > 0 Then

                'UPGRADE_WARNING: Couldn't resolve default property of object dGetInputSelect(channel, i). Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
                err = dGetInputSelect(channel, i)
                If err Then
                    handleerror(("LoadInputSelect: " & modHIDusb.getError(err)))
                Else
                    cmbInputSelect.Visible = True
                    cmbInputSelect.SelectedIndex = i
                End If

            Else
                cmbInputSelect.Visible = False
            End If

            lblInputSelect.Visible = cmbInputSelect.Visible

        End If

    End Sub

    Private Sub LoadRange(Optional ByRef channel As Integer = 0)
        ' ____________________
        ' Load Range Selection
        ' ��������������������
        Dim nRanges, i, range, err As Integer

        If gDevLoaded Then
            'UPGRADE_WARNING: Couldn't resolve default property of object dGetRange(channel, range). Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
            err = dGetRange(channel, range)
            If err Then
                handleerror(("LoadRange: " & modHIDusb.getError(err)))
            Else
                cmbRange.SelectedIndex = range
            End If
        Else
            'UPGRADE_WARNING: Couldn't resolve default property of object dGetNrange(channel, nRanges). Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
            err = dGetNrange(channel, nRanges)
            If err Then
                handleerror(("LoadRange: " & modHIDusb.getError(err)))
            Else

                Dim rngs(nRanges - 1) As Integer

                'UPGRADE_WARNING: Couldn't resolve default property of object dGetRangeList(channel, rngs(0)). Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
                err = dGetRangeList(channel, rngs(0))
                If err Then
                    handleerror(("LoadRange: " & modHIDusb.getError(err)))
                Else
                    cmbRange.Items.Clear()
                    For i = 0 To nRanges - 1
                        cmbRange.Items.Add(CStr(rngs(i)))
                    Next i
                    cmbRange.SelectedIndex = 0

                End If
            End If

            'UPGRADE_WARNING: Couldn't resolve default property of object dGetRange(channel, i). Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
            err = dGetRange(channel, i)
            If err Then
                handleerror(("LoadRange: " & modHIDusb.getError(err)))
            Else
                cmbRange.SelectedIndex = i
            End If
        End If

    End Sub

    Private Sub LoadResolution(Optional ByRef channel As Integer = 0)
        ' ___________________________________
        ' Load Full Scale Code List from DLL
        ' �����������������������������������
        Dim nRes, i, resolution, err As Integer

        If gDevLoaded Then
            'UPGRADE_WARNING: Couldn't resolve default property of object dGetResolution(channel, resolution). Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
            err = dGetResolution(channel, resolution)
            If err Then
                handleerror(("LoadResolution: " & modHIDusb.getError(err)))
            Else
                cmbResolution.SelectedIndex = resolution
            End If
        Else
            'UPGRADE_WARNING: Couldn't resolve default property of object dGetNresolution(channel, nRes). Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
            err = dGetNresolution(channel, nRes)
            If err Then
                handleerror(("LoadResolution: " & modHIDusb.getError(err)))
            Else
                Dim rngs(nRes - 1) As Integer

                'UPGRADE_WARNING: Couldn't resolve default property of object dGetResolutionList(channel, rngs(0)). Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
                err = dGetResolutionList(channel, rngs(0))
                If err Then
                    handleerror(("LoadResolution: " & modHIDusb.getError(err)))
                Else
                    cmbResolution.Items.Clear()
                    For i = 0 To nRes - 1
                        cmbResolution.Items.Add(CStr(rngs(i)))
                    Next i
                    cmbResolution.SelectedIndex = 0
                End If

            End If

            'UPGRADE_WARNING: Couldn't resolve default property of object dGetResolution(channel, i). Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
            err = dGetResolution(channel, i)
            If err Then
                handleerror(("LoadResolution: " & modHIDusb.getError(err)))
            Else
                cmbResolution.SelectedIndex = i
            End If
        End If

    End Sub

    'UPGRADE_NOTE: size was upgraded to size_Renamed. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="A9E4979A-37FA-4718-9994-97DD76ED70A7"'
    Public Function writeI2cPage(ByVal i2cAddr As Byte, ByVal intAddr As Integer, ByRef data() As Byte, Optional ByRef byteMode As Boolean = True, Optional ByRef size_Renamed As Short = -1) As Integer

        Dim i As Short
        Dim addr As Integer : addr = intAddr
        Dim numDataBytes As Byte
        Dim numberSent, maxBufsz As Short
        Dim buf(15) As Byte : maxBufsz = UBound(buf) + 1

        Dim regAddr(1) As Byte
        If size_Renamed < 0 Then size_Renamed = UBound(data) + 1

        If size_Renamed > 256 And byteMode Then Exit Function ' byte mode is only good for 256 bytes

        While (numberSent < size_Renamed)
            If (size_Renamed - numberSent) > maxBufsz Then
                numDataBytes = maxBufsz
            Else
                numDataBytes = size_Renamed - numberSent
            End If

            For i = 0 To numDataBytes - 1 : buf(i) = data(numberSent + i) : Next i

            If byteMode Then
                regAddr(0) = (addr And &HFF)
                writeI2C(i2cAddr, numDataBytes, 1, buf, regAddr)
            Else
                regAddr(0) = CShort(addr And &HFF00) / 256 : regAddr(1) = (addr And &HFF) ' MSB 1st
                writeI2C(i2cAddr, numDataBytes, 2, buf, regAddr)
            End If
            numberSent = numberSent + numDataBytes
            addr = addr + numberSent
        End While

    End Function

    'UPGRADE_NOTE: size was upgraded to size_Renamed. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="A9E4979A-37FA-4718-9994-97DD76ED70A7"'
    Public Function readI2cPage(ByVal i2cAddr As Byte, ByVal intAddr As Integer, ByRef data() As Byte, Optional ByRef byteMode As Boolean = True, Optional ByRef size_Renamed As Short = -1) As Integer

        Dim i As Short
        Dim addr As Integer : addr = intAddr
        Dim numDataBytes As Byte
        Dim numberreceived, maxBufsz As Short
        Dim buf(15) As Byte : maxBufsz = UBound(buf) + 1

        Dim regAddr(1) As Byte
        If size_Renamed < 0 Then size_Renamed = UBound(data) + 1

        If size_Renamed > 256 And byteMode Then Exit Function ' byte mode is only good for 256 bytes

        While (numberreceived < size_Renamed)
            If (size_Renamed - numberreceived) > maxBufsz Then
                numDataBytes = maxBufsz
            Else
                numDataBytes = size_Renamed - numberreceived
            End If

            If byteMode Then
                regAddr(0) = (addr And &HFF)
                readI2C(i2cAddr, numDataBytes, 1, buf, regAddr)
            Else
                regAddr(0) = CShort(addr And &HFF00) / 256 : regAddr(1) = (addr And &HFF) ' MSB 1st
                readI2C(i2cAddr, numDataBytes, 2, buf, regAddr)
            End If
            For i = 0 To numDataBytes - 1 : data(numberreceived + i) = buf(i) : Next i
            numberreceived = numberreceived + numDataBytes
            addr = addr + numberreceived
        End While

    End Function


    Private Sub setALSonly(ByRef flag As Boolean)
        Dim Nflag As Boolean : Nflag = Not flag
        ALSonly = flag

        cmbIrdr.Visible = Nflag
        lblIrdr.Visible = Nflag
        If X28 = False Then
            cbIrdrFreq.Visible = Nflag
            cbProxAmbRej.Visible = Nflag
        End If
    End Sub


    Private Sub LoadIrdr()
        ' __________________________________
        ' Load Input Selection List from DLL
        ' ����������������������������������
        Dim nIrdr, i, irdr, err As Integer

        If gDevLoaded Then
            'UPGRADE_WARNING: Couldn't resolve default property of object dGetIrdr(irdr). Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
            err = dGetIrdr(irdr)
            If err Then
                handleerror(("LoadIrdr: " & modHIDusb.getError(err)))
                ALSonly = True
            Else
                cmbIrdr.SelectedIndex = irdr
            End If
        Else
            'UPGRADE_WARNING: Couldn't resolve default property of object dGetNirdr(nIrdr). Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
            err = dGetNirdr(nIrdr)
            If err Then
                handleerror(("LoadIrdr: " & modHIDusb.getError(err)))
            Else
                If nIrdr Then

                    Dim devs(nIrdr - 1) As Integer

                    setALSonly(False)

                    'UPGRADE_WARNING: Couldn't resolve default property of object dGetIrdrList(devs(0)). Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
                    err = dGetIrdrList(devs(0))
                    If err Then
                        handleerror(("LoadIrdr: " & modHIDusb.getError(err)))
                    Else
                        cmbIrdr.Items.Clear()

                        For i = 0 To nIrdr - 1
                            cmbIrdr.Items.Add(CStr(devs(i)))
                        Next i
                        cmbIrdr.Text = CStr(devs(0))

                        'UPGRADE_WARNING: Couldn't resolve default property of object dGetIrdr(i). Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
                        err = dGetIrdr(i)
                        If err Then
                            handleerror(("LoadIrdr: " & modHIDusb.getError(err)))
                        Else
                            cmbIrdr.SelectedIndex = i
                        End If

                    End If
                Else
                    setALSonly(True)
                End If

            End If
        End If

    End Sub

    Private Sub LoadIntPersist(Optional ByRef channel As Integer = 0)
        ' _____________________________
        ' Load IntPersist List from DLL
        ' �����������������������������
        Dim nPrt, i, intPesisist, err As Integer

        If gDevLoaded Then
            'UPGRADE_WARNING: Couldn't resolve default property of object dGetIntPersist(channel, intPesisist). Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
            err = dGetIntPersist(channel, intPesisist)
            If err Then
                handleerror(("LoadIntPersist: " & modHIDusb.getError(err)))
            Else
                cmbIntPersist(channel).SelectedIndex = intPesisist
            End If
        Else
            'UPGRADE_WARNING: Couldn't resolve default property of object dGetNintPersist(channel, nPrt). Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
            err = dGetNintPersist(channel, nPrt)
            If err Then
                handleerror(("LoadIntPersist: " & modHIDusb.getError(err)))
            Else
                Dim rngs(nPrt - 1) As Integer

                'UPGRADE_WARNING: Couldn't resolve default property of object dGetIntPersistList(channel, rngs(0)). Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
                err = dGetIntPersistList(channel, rngs(0))
                If err Then
                    handleerror(("LoadIntPersist: " & modHIDusb.getError(err)))
                Else
                    cmbIntPersist(channel).Items.Clear()
                    For i = 0 To nPrt - 1
                        cmbIntPersist(channel).Items.Add(CStr(rngs(i)))
                    Next i
                    cmbIntPersist(channel).SelectedIndex = 0
                End If

            End If

            'UPGRADE_WARNING: Couldn't resolve default property of object dGetIntPersist(channel, i). Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
            err = dGetIntPersist(channel, i)
            If err Then
                handleerror(("LoadIntPersist: " & modHIDusb.getError(err)))
            Else
                cmbIntPersist(channel).SelectedIndex = i
            End If
        End If

    End Sub

    Private Sub LoadSleep()
        ' ________________________
        ' Load Sleep List from DLL
        ' ������������������������
        Dim i, nslp, err As Integer

        'UPGRADE_WARNING: Couldn't resolve default property of object dGetNsleep(nslp). Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
        err = dGetNsleep(nslp)
        If err Then
            handleerror(("LoadSleep: " & modHIDusb.getError(err)))
        Else
            Dim slps(nslp - 1) As Integer

            'UPGRADE_WARNING: Couldn't resolve default property of object dGetSleepList(slps(0)). Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
            err = dGetSleepList(slps(0))
            If err Then
                handleerror(("LoadSleep: " & modHIDusb.getError(err)))
            Else
                cmbSleep.Items.Clear()
                For i = 0 To nslp - 1
                    cmbSleep.Items.Add(CStr(slps(i)))
                Next i
                cmbSleep.Text = CStr(slps(0))
            End If

        End If

        'UPGRADE_WARNING: Couldn't resolve default property of object dGetSleep(i). Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
        err = dGetSleep(i)
        If err Then
            handleerror(("LoadSleep: " & modHIDusb.getError(err)))
        Else
            cmbSleep.SelectedIndex = i
        End If

    End Sub

    Private Sub updateBoth()

        Dim ci As Short
        Dim c, v, err As Integer : c = 0 : ci = c

        If loadDone = True Then
            LoadRange()
            LoadIntPersist()
            LoadInputSelect()
            If Not ALSonly Then LoadIrdr()

            'UPGRADE_WARNING: Couldn't resolve default property of object dGetEnable(c, v). Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
            err = dGetEnable(c, v)
            If dGetEnable(c, v) Then
                handleerror((modHIDusb.getError(err)))
            Else

                If v Then
                    cbEnable(c).CheckState = System.Windows.Forms.CheckState.Unchecked
                Else
                    cbEnable(c).CheckState = System.Windows.Forms.CheckState.Checked
                End If

                Call cbEnable_CheckStateChanged(cbEnable.Item(ci), New System.EventArgs())

            End If

            'UPGRADE_WARNING: Couldn't resolve default property of object dGetIntFlag(c, v). Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
            err = dGetIntFlag(c, v)
            If err Then
                handleerror((modHIDusb.getError(err)))
            Else
                optInt.Checked = (v = 1)
            End If

        End If
    End Sub

    Private Sub setWidgetsVisible()
        frmX11.Visible = False
        frmX28.Visible = False
        frmX38.Visible = False

        Select Case gPartFamily
            Case 29011 : frmX11.Visible = True
            Case 29028 : frmX28.Visible = True
            Case 29038 : frmX38.Visible = True
            Case 29125 : frmX38.Visible = True
        End Select
    End Sub
    Private Sub updateX11()

        Dim v, err As Integer

        If loadDone = True Then

            setWidgetsVisible()

            LoadResolution()

            If ALSonly = False Then

                'UPGRADE_WARNING: Couldn't resolve default property of object dGetIrdrFreq(v). Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
                err = dGetIrdrFreq(v)
                If err Then
                    handleerror((modHIDusb.getError(err)))
                Else

                    If v Then
                        cbIrdrFreq.CheckState = System.Windows.Forms.CheckState.Checked
                    Else
                        cbIrdrFreq.CheckState = System.Windows.Forms.CheckState.Unchecked
                    End If

                    cbIrdrFreq_CheckStateChanged(cbIrdrFreq, New System.EventArgs())

                End If

                'UPGRADE_WARNING: Couldn't resolve default property of object dGetProxAmbRej(v). Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
                err = dGetProxAmbRej(v)
                If err Then
                    handleerror((modHIDusb.getError(err)))
                Else

                    If v Then
                        cbProxAmbRej.CheckState = System.Windows.Forms.CheckState.Unchecked
                    Else
                        cbProxAmbRej.CheckState = System.Windows.Forms.CheckState.Checked
                    End If

                    cbProxAmbRej_CheckStateChanged(cbProxAmbRej, New System.EventArgs())

                End If

            End If

        End If
    End Sub
    Private Sub updateX28()

        Dim ci As Short
        Dim c, v, err As Integer : c = 1 : ci = c

        If loadDone = True Then
            frmX28.Visible = True
            frmX11.Visible = False

            If X38 Then
                frmX38.Visible = True
            Else
                frmX38.Visible = False
            End If

            LoadIntPersist(1)
            LoadSleep()

            'UPGRADE_WARNING: Couldn't resolve default property of object dGetEnable(c, v). Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
            err = dGetEnable(c, v)
            If err Then
                handleerror((modHIDusb.getError(err)))
            Else

                If v Then
                    cbEnable(c).CheckState = System.Windows.Forms.CheckState.Unchecked
                Else
                    cbEnable(c).CheckState = System.Windows.Forms.CheckState.Checked
                End If

                Call cbEnable_CheckStateChanged(cbEnable.Item(ci), New System.EventArgs())

            End If
            err = cGetIntLogic(v)
            If err Then
                handleerror((modHIDusb.getError(err)))
            Else

                If v Then
                    cbIntLogic.CheckState = System.Windows.Forms.CheckState.Checked
                Else
                    cbIntLogic.CheckState = System.Windows.Forms.CheckState.Unchecked
                End If

                cbIntLogic_CheckStateChanged(cbIntLogic, New System.EventArgs())

            End If

        End If
    End Sub

    Sub updateX38()
        Dim value, err As Integer
        If loadDone Then

            err = dGetProxOffset(value)
            If err Then
                handleerror(("dGetProxOffset: " & modHIDusb.getError(err)))
            Else
                hscrProxOffset.Value = value : lblProxOffset.Text = CStr(value)
            End If

            err = dGetIRcomp(value)
            If err Then
                handleerror(("dGetIRcomp: " & modHIDusb.getError(err)))
            Else
                hscrIRcomp.Value = value : lblIRcomp.Text = CStr(value)
            End If

        End If
    End Sub

    Public Shadows Sub update()
        If loadDone Then
            updateBoth()
            If X28 Then
                updateX28()
                If X38 Then updateX38()
            Else
                updateX11()
            End If
        End If
    End Sub

    'UPGRADE_WARNING: Event cbIntLogic.CheckStateChanged may fire when form is initialized. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="88B12AE1-6DE0-48A0-86F1-60C0686C026A"'
    Private Sub cbIntLogic_CheckStateChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cbIntLogic.CheckStateChanged

        Dim v, err As Integer

        If cbIntLogic.CheckState = System.Windows.Forms.CheckState.Checked Then
            v = 1 : cbIntLogic.Text = "IntLogic: AND"
        Else
            v = 0 : cbIntLogic.Text = "IntLogic: OR"
        End If

        'UPGRADE_WARNING: Couldn't resolve default property of object dSetIntLogic(v). Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
        err = dSetIntLogic(v)
        If err Then
            handleerror(("cbIntLogic_Click: " & modHIDusb.getError(err)))
        End If

    End Sub

    'UPGRADE_WARNING: Event cbPoll.CheckStateChanged may fire when form is initialized. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="88B12AE1-6DE0-48A0-86F1-60C0686C026A"'
    Private Sub cbPoll_CheckStateChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cbPoll.CheckStateChanged
        If cbPoll.CheckState = System.Windows.Forms.CheckState.Checked Then
            cbPoll.Text = "Poll"
            tmrPoll.Enabled = True
        Else
            cbPoll.Text = "nPoll"
            tmrPoll.Enabled = False
        End If
    End Sub

    'UPGRADE_WARNING: Event cmbDevice.SelectedIndexChanged may fire when form is initialized. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="88B12AE1-6DE0-48A0-86F1-60C0686C026A"'
    Private Sub cmbDevice_SelectedIndexChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmbDevice.SelectedIndexChanged
        Dim t, nChan, nIrdr, err As Integer

        loadDone = False
        cmdConversionTime.Text = "Conv. = 0ms" : System.Windows.Forms.Application.DoEvents()

        err = dSetDevice(cmbDevice.SelectedIndex)
        If err Then
            handleerror((modHIDusb.getError(err)))
        Else
            setI2cAddr(gI2cAddr)

            Call dGetPartNumber(gPartNumber)
            Call dGetPartFamily(gPartFamily)

            If gPartNumber = 29125 Then
                cbPoll.Enabled = False
            Else
                cbPoll.Enabled = True
            End If

            If gPartFamily = 29038 Or gPartFamily = 29125 Then
                frmX38.Top = VB6.TwipsToPixelsY(frmX38_Top)
                frmX38.Visible = True
                If gPartFamily = 29125 Then
                    fmProxOffset.Visible = False
                    hscrIRcomp.Maximum = (127 + hscrIRcomp.LargeChange - 1)
                End If
            Else
                frmX38.Visible = False
            End If

            'UPGRADE_WARNING: Couldn't resolve default property of object dGetNchannel(nChan). Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
            err = dGetNchannel(nChan)
            If err Then
                handleerror(("cmbDevice_Click: " & modHIDusb.getError(err)))
            Else
                If nChan = 2 Then
                    X28 = True
                    'UPGRADE_WARNING: Couldn't resolve default property of object dGetNirdr(nIrdr). Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
                    err = dGetNirdr(nIrdr)
                    If err Then
                        handleerror(("LoadIrdr: " & modHIDusb.getError(err)))
                    Else
                        If nIrdr > 2 And gI2cAddr <> &H72 Then ' H72 is TSL2771
                            X38 = True
                        Else
                            X38 = False
                        End If
                    End If
                Else
                    X28 = False
                    X38 = False
                End If

                If X28 Then

                    frmX28.Top = VB6.TwipsToPixelsY(frmX28_Top)
                    frmX11.Visible = False : frmX28.Visible = True

                    '                If X38 Then
                    '                    frmX38.Top = frmX38_Top: frmX38.Visible = True
                    '                Else
                    '                     frmX38.Visible = False
                    '                End If
                Else
                    If gPartFamily = 29011 Then
                        frmX11.Top = VB6.TwipsToPixelsY(frmX11_Top)
                        frmX11.Visible = True : frmX28.Visible = False : frmX38.Visible = False
                    End If
                End If

                'UPGRADE_WARNING: Couldn't resolve default property of object dGetConversionTime(0, t). Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
                err = dGetConversionTime(0, t)
                If err Then
                    handleerror(("cmbDevice_Click: " & modHIDusb.getError(err)))
                Else
                    cmdConversionTime.Text = "Conv. = " & t & "ms"
                    loadDone = True
                    gDevLoaded = False
                    update()
                    gDevLoaded = True
                End If

            End If
            'loadDone = True
        End If
    End Sub

    'UPGRADE_WARNING: Event cbEnable.CheckStateChanged may fire when form is initialized. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="88B12AE1-6DE0-48A0-86F1-60C0686C026A"'
    Private Sub cbEnable_CheckStateChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cbEnable.CheckStateChanged
        Dim Index As Short = cbEnable.GetIndex(eventSender)

        Dim v, err As Integer

        If cbEnable(Index).CheckState = System.Windows.Forms.CheckState.Checked Then
            v = 0 : cbEnable(Index).Text = "Disabled"
        Else
            v = 1 : cbEnable(Index).Text = "Enabled"
        End If

        'UPGRADE_WARNING: Couldn't resolve default property of object dSetEnable(Index, v). Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
        err = dSetEnable(Index, v)
        If err Then
            handleerror(("cbEnable_Click: " & modHIDusb.getError(err)))
        End If

    End Sub

    'UPGRADE_WARNING: Event cmbIntPersist.SelectedIndexChanged may fire when form is initialized. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="88B12AE1-6DE0-48A0-86F1-60C0686C026A"'
    Private Sub cmbIntPersist_SelectedIndexChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmbIntPersist.SelectedIndexChanged
        Dim Index As Short = cmbIntPersist.GetIndex(eventSender)
        Dim chan As Integer : chan = Index
        On Error GoTo subExit
        'UPGRADE_WARNING: Couldn't resolve default property of object dSetIntPersist(chan, cmbIntPersist(chan).ListIndex). Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
        If dSetIntPersist(chan, cmbIntPersist(chan).SelectedIndex) Then Call handleerror("cmbIntPersist_Click")
subExit:
    End Sub

    'UPGRADE_WARNING: Event cmbRange.SelectedIndexChanged may fire when form is initialized. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="88B12AE1-6DE0-48A0-86F1-60C0686C026A"'
    Private Sub cmbRange_SelectedIndexChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmbRange.SelectedIndexChanged
        On Error GoTo subExit
        'UPGRADE_WARNING: Couldn't resolve default property of object dSetRange(0, cmbRange.ListIndex). Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
        If dSetRange(0, cmbRange.SelectedIndex) Then Call handleerror("cmbRange_Click")
subExit:
    End Sub

    'UPGRADE_WARNING: Event cmbInputSelect.SelectedIndexChanged may fire when form is initialized. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="88B12AE1-6DE0-48A0-86F1-60C0686C026A"'
    Private Sub cmbInputSelect_SelectedIndexChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmbInputSelect.SelectedIndexChanged
        On Error GoTo subExit
        'UPGRADE_WARNING: Couldn't resolve default property of object dSetInputSelect(0, cmbInputSelect.ListIndex). Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
        If dSetInputSelect(0, cmbInputSelect.SelectedIndex) Then Call handleerror("cmbInputSelect_Click")
subExit:
    End Sub

    'UPGRADE_WARNING: Event cmbIrdr.SelectedIndexChanged may fire when form is initialized. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="88B12AE1-6DE0-48A0-86F1-60C0686C026A"'
    Private Sub cmbIrdr_SelectedIndexChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmbIrdr.SelectedIndexChanged
        On Error GoTo subExit
        'UPGRADE_WARNING: Couldn't resolve default property of object dSetIrdr(cmbIrdr.ListIndex). Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
        If dSetIrdr(cmbIrdr.SelectedIndex) Then Call handleerror("cmbIrdr_Click")
subExit:
    End Sub

    'UPGRADE_WARNING: Event cmbResolution.SelectedIndexChanged may fire when form is initialized. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="88B12AE1-6DE0-48A0-86F1-60C0686C026A"'
    Private Sub cmbResolution_SelectedIndexChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmbResolution.SelectedIndexChanged
        On Error GoTo subExit
        'UPGRADE_WARNING: Couldn't resolve default property of object dSetResolution(0, cmbResolution.ListIndex). Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
        If dSetResolution(0, (cmbResolution.SelectedIndex)) Then Call handleerror("cmbResolution_Click")
subExit:
    End Sub

    'UPGRADE_WARNING: Event cmbSleep.SelectedIndexChanged may fire when form is initialized. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="88B12AE1-6DE0-48A0-86F1-60C0686C026A"'
    Private Sub cmbSleep_SelectedIndexChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmbSleep.SelectedIndexChanged
        On Error GoTo subExit
        'UPGRADE_WARNING: Couldn't resolve default property of object dSetSleep(cmbSleep.ListIndex). Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
        If dSetSleep((cmbSleep.SelectedIndex)) Then Call handleerror("cmbSleep_Click")
subExit:
    End Sub

    'UPGRADE_WARNING: Event cbIrdrFreq.CheckStateChanged may fire when form is initialized. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="88B12AE1-6DE0-48A0-86F1-60C0686C026A"'
    Private Sub cbIrdrFreq_CheckStateChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cbIrdrFreq.CheckStateChanged

        Dim v, err As Integer

        If cbIrdrFreq.CheckState = System.Windows.Forms.CheckState.Unchecked Then
            v = 0 : cbIrdrFreq.Text = "Freq: DC"
        Else
            v = 1 : cbIrdrFreq.Text = "Freq: 360k"
        End If

        'UPGRADE_WARNING: Couldn't resolve default property of object dSetIrdrFreq(v). Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
        err = dSetIrdrFreq(v)
        If err Then
            handleerror(("cbIrdrFreq_Click: " & modHIDusb.getError(err)))
        End If

    End Sub

    'UPGRADE_WARNING: Event cbProxAmbRej.CheckStateChanged may fire when form is initialized. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="88B12AE1-6DE0-48A0-86F1-60C0686C026A"'
    Private Sub cbProxAmbRej_CheckStateChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cbProxAmbRej.CheckStateChanged

        Dim v, err As Integer

        If cbProxAmbRej.CheckState = System.Windows.Forms.CheckState.Checked Then
            v = 0 : cbProxAmbRej.Text = "AmbRej: OFF"
        Else
            v = 1 : cbProxAmbRej.Text = "AmbRej: ON"
        End If

        'UPGRADE_WARNING: Couldn't resolve default property of object dSetProxAmbRej(v). Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
        err = dSetProxAmbRej(v)
        If err Then
            handleerror(("cbProxAmbRej_Click: " & modHIDusb.getError(err)))
        End If

    End Sub

    Private Sub cmdConversionTime_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdConversionTime.Click
        Dim ct, err As Integer
        cmdConversionTime.Text = "Conv. = " & ct & "ms"
        'UPGRADE_WARNING: Couldn't resolve default property of object dMeasureConversionTime(ct). Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
        err = dMeasureConversionTime(ct)
        If err Then
            handleerror(("cmdConversionTime_Click: " & modHIDusb.getError(err)))
        Else
            cmdConversionTime.Text = "Conv. = " & ct & "ms"
        End If
    End Sub

    'UPGRADE_NOTE: hscrProxOffset.Change was changed from an event to a procedure. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="4E2DC008-5EDA-4547-8317-C9316952674F"'
    'UPGRADE_WARNING: HScrollBar event hscrProxOffset.Change has a new behavior. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6BA9B8D2-2A32-4B6E-8D36-44949974A5B4"'
    Private Sub hscrProxOffset_Change(ByVal newScrollValue As Integer)
        Dim err As Integer

        err = dSetProxOffset(newScrollValue)
        If err Then
            handleerror(("hscrProxOffset_Change: " & modHIDusb.getError(err)))
        Else
            lblProxOffset.Text = CStr(newScrollValue)
        End If
    End Sub

    'UPGRADE_NOTE: hscrIRcomp.Change was changed from an event to a procedure. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="4E2DC008-5EDA-4547-8317-C9316952674F"'
    'UPGRADE_WARNING: HScrollBar event hscrIRcomp.Change has a new behavior. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6BA9B8D2-2A32-4B6E-8D36-44949974A5B4"'
    Private Sub hscrIRcomp_Change(ByVal newScrollValue As Integer)
        Dim err As Integer
        err = dSetIRcomp(newScrollValue)
        If err Then
            handleerror(("hscrIRcomp_Change: " & modHIDusb.getError(err)))
        Else
            lblIRcomp.Text = CStr(newScrollValue)
        End If
    End Sub

    'UPGRADE_WARNING: Event optAddr.CheckedChanged may fire when form is initialized. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="88B12AE1-6DE0-48A0-86F1-60C0686C026A"'
    Private Sub optAddr_CheckedChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles optAddr.CheckedChanged
        If eventSender.Checked Then
            Dim Index As Short = optAddr.GetIndex(eventSender)
            If optAddr(Index).Checked And gHwnd Then
                GoTo skip
                Select Case Index
                    Case 1 : gI2cAddr = &H88
                    Case 2 : gI2cAddr = &H8A
                    Case 3 : gI2cAddr = &H8C
                    Case 4 : gI2cAddr = &HA0
                End Select
skip:
                gDUTi2cAddr = CInt("&H" & optAddr(Index).Text)
                setI2cAddr(gDUTi2cAddr)
            End If
        End If
    End Sub

    Public Function getDUTi2c() As Integer
        getDUTi2c = gDUTi2cAddr
    End Function

    Private Sub tmrPoll_Tick(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles tmrPoll.Tick
        update()
    End Sub

    Private Sub UserControl_Initialize()
        ucJungoUsb1 = New ucJungoUsb
        ucHIDusb1 = New ucHIDUsb
        ADBUsb1 = New ADBUsb
        ucEmuUsb1 = New ucEmuUsb
        'LoadDevice()
        frmDevice.Enabled = False

        frmDevice.Width = VB6.TwipsToPixelsX(frmDevice_Width)
        frmX11.Top = VB6.TwipsToPixelsY(frmX11_Top)
        frmX11.Left = frmDevice.Left
        frmX28.Top = VB6.TwipsToPixelsY(frmX28_Top)
        frmX28.Left = frmDevice.Left
        frmX38.Top = VB6.TwipsToPixelsY(frmX38_Top)
        frmX38.Left = frmDevice.Left
        Width = VB6.TwipsToPixelsX(1815)
        'Height = 5640
        'UPGRADE_ISSUE: Frame property frmDevice.BorderStyle was not upgraded. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="CC4C7EC0-C903-48FC-ACCC-81861D12DA4A"'
        'JWG frmDevice.BorderStyle = 0
        'UPGRADE_ISSUE: Frame property fmBoth.BorderStyle was not upgraded. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="CC4C7EC0-C903-48FC-ACCC-81861D12DA4A"'
        'JWG fmBoth.BorderStyle = 0
        'UPGRADE_ISSUE: Frame property frmX11.BorderStyle was not upgraded. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="CC4C7EC0-C903-48FC-ACCC-81861D12DA4A"'
        'JWG frmX11.BorderStyle = 0
        'UPGRADE_ISSUE: Frame property frmX28.BorderStyle was not upgraded. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="CC4C7EC0-C903-48FC-ACCC-81861D12DA4A"'
        'JWG frmX28.BorderStyle = 0
        'UPGRADE_ISSUE: Frame property frmX38.BorderStyle was not upgraded. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="CC4C7EC0-C903-48FC-ACCC-81861D12DA4A"'
        'JWG frmX38.BorderStyle = 0

    End Sub



    'UPGRADE_NOTE: error was upgraded to error_Renamed. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="A9E4979A-37FA-4718-9994-97DD76ED70A7"'
    Private Sub handleerror(ByRef error_Renamed As String)
        Static errorCount As Short
        If errorCount < 5 Then MsgBox(error_Renamed)
        errorCount = errorCount + 1
        'If errorCount >= 5 Then End
    End Sub

    Public Sub setHwnd(ByRef hWnd As Integer)
        Dim i As Short
        gHwnd = hWnd

        For i = 1 To nOptAddr
            optAddr(i).Enabled = True
        Next i

    End Sub

    Public Sub setI2cAddr(ByVal i2cAddr As Integer)
        Dim i As Short
        'UPGRADE_WARNING: Add a delegate for AddressOf DllCallBack Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="E9E157F7-EF0C-4016-87B7-7D7FBBC6EE08"'
        If (dSetDrvApi(_AddressOf(0))) Then ' JWG AddressOf(DllCallBack)
            Call handleerror("setI2cAddr")
        Else
            pUsb = getUsb(Me)
            Call DllCallBack(cmd.WA, i2cAddr, i2cAddr) : gI2cAddr = i2cAddr
            frmDevice.Enabled = True
        End If

        GoTo skip
        Select Case i2cAddr
            Case &H88 : optAddr(1).Checked = True
            Case &H8A : optAddr(2).Checked = True
            Case &H8C : optAddr(3).Checked = True
            Case &HA0 : optAddr(4).Checked = True
        End Select
skip:
        For i = 1 To nOptAddr
            If i2cAddr = CDbl("&H" & optAddr(i).Text) Then optAddr(i).Checked = True
        Next i

    End Sub

    Public Function getI2cAddr() As Integer
        getI2cAddr = gI2cAddr
    End Function

    Private Function testUsb(ByRef Main As ucALSusb) As Boolean
        Dim data As Integer : data = 0
        testUsb = True
        Call DllCallBack(cmd.R, 0, data)
        'UPGRADE_WARNING: Couldn't resolve default property of object Main.pUsb.noUsb. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
        If Main.pUsb.noUsb Then
            testUsb = False
        ElseIf usbCaption <> "ADB" Then
            setI2CclkMult()
        End If
    End Function

    Private Function getUsb(ByRef Main As ucALSusb) As cUsb2I2c
        On Error GoTo tryADBUsb
        getUsb = ucHIDusb1 : gUsb = getUsb : usbCaption = "HID"
        'getUsb.setHwnd (Me.hWnd)
        Main.pUsb = getUsb
        If testUsb(Main) Then GoTo exitGetUSB
tryADBUsb:
        On Error GoTo tryjungo
        getUsb = ADBUsb1 : gUsb = getUsb : usbCaption = "ADB"
        'getUsb.setHwnd (Me.hWnd)
        Main.pUsb = getUsb
        If testUsb(Main) Then GoTo exitGetUSB
tryjungo: gNoUsb = False
        On Error GoTo emulation
        getUsb = ucJungoUsb1 : gUsb = getUsb : usbCaption = "Jungo"
        'UPGRADE_WARNING: Couldn't resolve default property of object getUsb.setHwnd. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
        getUsb.setHwnd(gHwnd)
        Main.pUsb = getUsb
        If testUsb(Main) Then GoTo exitGetUSB
emulation:
        On Error GoTo emulation
        getUsb = ucEmuUsb1 : gUsb = getUsb : usbCaption = "Emulation"
        'getUsb.setHwnd (main.hWnd)
        Main.pUsb = getUsb
        If testUsb(Main) Then GoTo exitGetUSB
noObject:
        usbCaption = "No Driver"
exitGetUSB:
        gUsb = getUsb
        pTempDrv = New clsAlsRgbDrv
        pTempDrv.setAlsDll(gUsb, Main)
    End Function

    Public Function getUSBcaption() As String
        getUSBcaption = usbCaption
    End Function

    'Function enterText(ByRef text As String) As Integer
    '    ' strip [cr] & [lf], return > 0
    '    enterText = InStr(text, Chr(13))
    '    If (enterText) Then
    '        text = Mid(text, 1, enterText - 1)
    '    End If
    'End Function



    ' +________+
    ' | Script |
    ' +��������+

    Public Sub script(ByRef value As String)
        Dim widget As String
        'UPGRADE_NOTE: error was upgraded to error_Renamed. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="A9E4979A-37FA-4718-9994-97DD76ED70A7"'
        Dim error_Renamed As Integer
        Dim iVal As Integer

        widget = lineArgs(value)

        Select Case widget
            Case "Address" : iVal = CInt("&H" & value) : setI2cAddr((iVal))
            Case "Part" : setDevice((value))
            Case "Range" : setRange((value))
            Case "Irdr" : setIrdr((value))
            Case "Sleep" : setSleep((value))
            Case "EnableAls" : iVal = CInt(value)
                'UPGRADE_WARNING: Couldn't resolve default property of object dSetEnable(). Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
                error_Renamed = dSetEnable(0, iVal)
            Case "EnableProx" : iVal = CInt(value)
                'UPGRADE_WARNING: Couldn't resolve default property of object dSetEnable(). Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
                error_Renamed = dSetEnable(1, iVal)
            Case "Poll" : iVal = CInt(value) : cbPoll.CheckState = CShort(value)
            Case Else : MsgBox("??Script: Als " & widget & " " & value)
        End Select

    End Sub

    Private Function lineArgs(ByRef line As String) As String
        Dim spacePos As Short
        spacePos = InStr(line, " ")
        If (spacePos) Then
            lineArgs = Mid(line, 1, spacePos - 1)
            line = Mid(line, spacePos + 1, Len(line))
        End If
    End Function

    Private Function setCmb(ByRef cmb As System.Windows.Forms.ComboBox, ByRef value As String) As Boolean
        Dim i As Short

        For i = 0 To cmb.Items.Count
            If value = VB6.GetItemString(cmb, i) Then
                cmb.SelectedIndex = i
                i = cmb.Items.Count
                setCmb = True
            End If
        Next i

        If Not setCmb Then MsgBox("value=" & value & " not found")

    End Function

    Sub setDevice(ByVal value As String)
        If setCmb(cmbDevice, value) Then cmbDevice_SelectedIndexChanged(cmbDevice, New System.EventArgs())
    End Sub
    Sub setRange(ByRef value As String)
        If setCmb(cmbRange, value) Then cmbRange_SelectedIndexChanged(cmbRange, New System.EventArgs())
    End Sub
    Sub setIrdr(ByRef value As String)
        If setCmb(cmbIrdr, value) Then cmbIrdr_SelectedIndexChanged(cmbIrdr, New System.EventArgs())
    End Sub
    Sub setSleep(ByRef value As String)
        If setCmb(cmbSleep, value) Then cmbSleep_SelectedIndexChanged(cmbSleep, New System.EventArgs())
    End Sub

    Private Sub configureGPIO2pushPull()
        Dim BytesSucceed As Integer
        Dim api_status As Integer

        Call MemSet(0)
        Call reportID()
        IOBuf(0) = 1
        IOBuf(1) = 2 'GPIO configuration
        IOBuf(2) = 0 'write
        IOBuf(3) = 1 'P1: Push-Pull
        IOBuf(4) = 1 'P2: Push-Pull
        IOBuf(5) = 0 'Week pull ups enabled
        BytesSucceed = 0

        api_status = WriteFile(HIDhandle, IOBuf(0), REPORT_SIZE, BytesSucceed, 0)
        Call checkStatus(api_status)

    End Sub

    Public Sub writeHIDuCportBit(ByVal port As Short, ByVal bit As Short, ByVal value As Short)

        'JWG quick hack for Thao

        Dim BytesSucceed As Integer
        Dim api_status As Integer
        GoTo skip
        Static configDone As Boolean

        If Not configDone Then
            configureGPIO2pushPull()
            configDone = True
        End If
skip:
        If 0 <= port And port <= 2 Then
            If 0 <= bit And bit <= 7 Then
                Call MemSet(0)
                Call reportID()
                IOBuf(0) = 1
                IOBuf(1) = port + 1 ' (1 based in code)
                IOBuf(2) = 0 'write
                IOBuf(3) = value * 2 ^ (7 - bit) ' uC Bits are reversed relative to Schematic
                BytesSucceed = 0

                api_status = WriteFile(HIDhandle, IOBuf(0), REPORT_SIZE, BytesSucceed, 0)
                Call checkStatus(api_status)
            End If
        End If
    End Sub

    Public Function readHIDuCportBit(ByVal port As Short, ByVal bit As Short) As Short
        Dim BytesSucceed As Integer
        Dim api_status As Integer
        'UPGRADE_NOTE: status was upgraded to status_Renamed. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="A9E4979A-37FA-4718-9994-97DD76ED70A7"'
        Dim status_Renamed As Short
        Dim i As Short

        If (1 <= port) And (port <= 2) And (0 <= bit) And (bit <= 7) Then

            Call readPurge()

            Call MemSet(0)

            Call reportID()
            IOBuf(1) = 3 'GP value
            IOBuf(2) = 1 'read
            IOBuf(3) = 0 'chkWeakPullUpEnableOnRead.value

            BytesSucceed = 0

            api_status = WriteFile(HIDhandle, IOBuf(0), REPORT_SIZE, BytesSucceed, 0)
            'endpoint in interrupt at uC occurs after this WriteFile call since the in data is ready and the host takes it; endpoint in interrupt does not occur after ReadFile call

            status_Renamed = checkStatus(api_status)
            'if WriteFile failed, then checkStatus would cause connect (and hence checkGPstate) to be called, and hence eliminate the need to do the following ReadFile

            If status_Renamed = GP_SUCCESS Then
                Call MemSet(0)

                BytesSucceed = 0

                api_status = ReadFile(ReadHandle, IOBuf(0), REPORT_SIZE, BytesSucceed, HIDOverlapped) 'this read should not happen if an error occured at writefile, since the read would have happened there; ' BytesSucceed is not reliable in overlapped IO

                api_status = WaitForSingleObject(EventObject, 6000)

                Call ResetEvent(EventObject)

                If (api_status <> WAIT_OBJECT_0) Then Call checkStatus(API_FAIL) 'status of WaitForSingleObject, but called ResetEvent before, since otherwise we would have to put two lines of code for it

            End If

            readHIDuCportBit = CShort(IOBuf(port + 1) And 2 ^ bit) / 2 ^ bit

        End If
    End Function

    Public Sub setI2CclkMult(Optional ByRef clkMult As Short = 1)
        Dim BytesSucceed As Integer
        Dim api_status As Integer
        'UPGRADE_NOTE: status was upgraded to status_Renamed. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="A9E4979A-37FA-4718-9994-97DD76ED70A7"'
        Dim status_Renamed As Short
        Dim i As Short

        Call readPurge()

        Call MemSet(0)

        Call reportID()
        IOBuf(1) = 5 'I2C clock rate
        IOBuf(2) = 1 'read

        BytesSucceed = 0

        api_status = WriteFile(HIDhandle, IOBuf(0), REPORT_SIZE, BytesSucceed, 0)
        'endpoint in interrupt at uC occurs after this WriteFile call since the in data is ready and the host takes it; endpoint in interrupt does not occur after ReadFile call

        status_Renamed = checkStatus(api_status)
        'if WriteFile failed, then checkStatus would cause connect (and hence checkGPstate) to be called, and hence eliminate the need to do the following ReadFile

        If status_Renamed = GP_SUCCESS Then
            Call MemSet(0)

            BytesSucceed = 0

            api_status = ReadFile(ReadHandle, IOBuf(0), REPORT_SIZE, BytesSucceed, HIDOverlapped) 'this read should not happen if an error occured at writefile, since the read would have happened there; ' BytesSucceed is not reliable in overlapped IO

            api_status = WaitForSingleObject(EventObject, 6000)

            Call ResetEvent(EventObject)

            If (api_status <> WAIT_OBJECT_0) Then Call checkStatus(API_FAIL) 'status of WaitForSingleObject, but called ResetEvent before, since otherwise we would have to put two lines of code for it

        End If


        Call readPurge()

        Call MemSet(0)

        Call reportID()
        IOBuf(1) = 5 'I2C clock rate
        IOBuf(2) = 0 'write

        IOBuf(3) = 20 / clkMult ' normally 20

        BytesSucceed = 0

        api_status = WriteFile(HIDhandle, IOBuf(0), REPORT_SIZE, BytesSucceed, 0)
        'endpoint in interrupt at uC occurs after this WriteFile call since the in data is ready and the host takes it; endpoint in interrupt does not occur after ReadFile call

        status_Renamed = checkStatus(api_status)

    End Sub

    Public Function getEEpromObj() As clsEEprom

        If EEprom Is Nothing Then
            EEprom = New clsEEprom
            EEprom.setAlsDrv(Me)
        End If

        getEEpromObj = EEprom

    End Function
    Private Sub hscrProxOffset_Scroll(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.ScrollEventArgs) Handles hscrProxOffset.Scroll
        Select Case eventArgs.Type
            Case System.Windows.Forms.ScrollEventType.EndScroll
                hscrProxOffset_Change(eventArgs.NewValue)
        End Select
    End Sub
    Private Sub hscrIRcomp_Scroll(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.ScrollEventArgs) Handles hscrIRcomp.Scroll
        Select Case eventArgs.Type
            Case System.Windows.Forms.ScrollEventType.EndScroll
                hscrIRcomp_Change(eventArgs.NewValue)
        End Select
    End Sub

    ' vb.NET
    'Public Function dFloat2CharAry(ByVal f As Integer, ByVal ca() As Byte) As Integer
    '    dFloat2CharAry = cFloat2CharAry(x, ca)
    '    If dFloat2CharAry Then Call cSeterror(dFloat2CharAry, "dFloat2CharAry")
    'End Function





End Class