VERSION 5.00
Begin VB.UserControl ucALSusb 
   BorderStyle     =   1  'Fixed Single
   ClientHeight    =   6450
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   4365
   ScaleHeight     =   6450
   ScaleWidth      =   4365
   Begin VB.OptionButton optAddr 
      Caption         =   "72"
      Enabled         =   0   'False
      Height          =   255
      Index           =   4
      Left            =   1440
      TabIndex        =   40
      Top             =   0
      Width           =   735
   End
   Begin VB.OptionButton optAddr 
      Caption         =   "8C"
      Enabled         =   0   'False
      Height          =   255
      Index           =   3
      Left            =   960
      TabIndex        =   39
      Top             =   0
      Width           =   735
   End
   Begin VB.OptionButton optAddr 
      Caption         =   "8A"
      Enabled         =   0   'False
      Height          =   255
      Index           =   2
      Left            =   480
      TabIndex        =   28
      Top             =   0
      Width           =   735
   End
   Begin VB.OptionButton optAddr 
      Caption         =   "88"
      Enabled         =   0   'False
      Height          =   255
      Index           =   1
      Left            =   0
      TabIndex        =   29
      Top             =   0
      Width           =   735
   End
   Begin VB.Frame frmDevice 
      Caption         =   "Device"
      Height          =   6975
      Left            =   0
      TabIndex        =   0
      Top             =   240
      Width           =   4215
      Begin VB.CommandButton cmdConversionTime 
         Caption         =   "Conv. = 0 ms"
         Height          =   315
         Left            =   120
         TabIndex        =   38
         Top             =   120
         Width           =   1575
      End
      Begin VB.Frame fmBoth 
         Caption         =   "Both"
         Height          =   2535
         Left            =   120
         TabIndex        =   14
         Top             =   360
         Width           =   1575
         Begin VB.CheckBox cbPoll 
            Caption         =   "nPoll"
            Height          =   255
            Left            =   720
            Style           =   1  'Graphical
            TabIndex        =   27
            Top             =   120
            Width           =   855
         End
         Begin VB.OptionButton optInt 
            Caption         =   "Int"
            Height          =   255
            Left            =   0
            TabIndex        =   26
            Top             =   120
            Width           =   495
         End
         Begin VB.ComboBox cmbDevice 
            Height          =   315
            Left            =   0
            TabIndex        =   20
            Text            =   "Device"
            Top             =   360
            Width           =   1575
         End
         Begin VB.CheckBox cbEnable 
            Caption         =   "Enabled"
            Height          =   255
            Index           =   0
            Left            =   600
            Style           =   1  'Graphical
            TabIndex        =   19
            Top             =   720
            Width           =   975
         End
         Begin VB.ComboBox cmbIntPersist 
            Height          =   315
            Index           =   0
            Left            =   840
            TabIndex        =   18
            Text            =   "IntPersist"
            Top             =   1080
            Width           =   735
         End
         Begin VB.ComboBox cmbRange 
            Height          =   315
            Left            =   600
            TabIndex        =   17
            Text            =   "Range"
            Top             =   1440
            Width           =   975
         End
         Begin VB.ComboBox cmbInputSelect 
            Height          =   315
            Left            =   480
            TabIndex        =   16
            Text            =   "InputSelect"
            Top             =   1800
            Width           =   1095
         End
         Begin VB.ComboBox cmbIrdr 
            Height          =   315
            Left            =   360
            TabIndex        =   15
            Text            =   "Irdr"
            Top             =   2160
            Width           =   1215
         End
         Begin VB.Label lblEnable 
            Caption         =   "Chan0:"
            Height          =   255
            Index           =   0
            Left            =   0
            TabIndex        =   25
            Top             =   720
            Width           =   975
         End
         Begin VB.Label lblIntPersist 
            Caption         =   "IntPersist0:"
            Height          =   255
            Index           =   0
            Left            =   0
            TabIndex        =   24
            Top             =   1080
            Width           =   855
         End
         Begin VB.Label lblRange 
            Caption         =   "Range:"
            Height          =   255
            Left            =   0
            TabIndex        =   23
            Top             =   1440
            Width           =   615
         End
         Begin VB.Label lblInputSelect 
            Caption         =   "Input:"
            Height          =   255
            Left            =   0
            TabIndex        =   22
            Top             =   1800
            Width           =   495
         End
         Begin VB.Label lblIrdr 
            Caption         =   "Irdr:"
            Height          =   255
            Left            =   0
            TabIndex        =   21
            Top             =   2160
            Width           =   375
         End
      End
      Begin VB.Frame frmX11 
         Caption         =   "x11"
         Height          =   1575
         Left            =   1800
         TabIndex        =   1
         Top             =   480
         Visible         =   0   'False
         Width           =   1815
         Begin VB.Timer tmrPoll 
            Enabled         =   0   'False
            Interval        =   100
            Left            =   120
            Top             =   1080
         End
         Begin VB.ComboBox cmbResolution 
            Height          =   315
            Left            =   480
            TabIndex        =   13
            Text            =   "Resolution"
            Top             =   120
            Width           =   1215
         End
         Begin VB.CheckBox cbProxAmbRej 
            Caption         =   "AmbRej: ON"
            Height          =   255
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   11
            Top             =   720
            Width           =   1575
         End
         Begin VB.CheckBox cbIrdrFreq 
            Caption         =   "Freq: DC"
            Height          =   255
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   10
            Top             =   480
            Width           =   1575
         End
         Begin VB.Label lblResolution 
            Caption         =   "Res:"
            Height          =   255
            Left            =   120
            TabIndex        =   12
            Top             =   120
            Width           =   495
         End
      End
      Begin VB.Frame frmX28 
         Caption         =   "x28"
         Height          =   1695
         Left            =   120
         TabIndex        =   2
         Top             =   3000
         Visible         =   0   'False
         Width           =   1815
         Begin VB.ComboBox cmbSleep 
            Height          =   315
            Left            =   600
            TabIndex        =   8
            Text            =   "800"
            Top             =   1320
            Width           =   1095
         End
         Begin VB.CheckBox cbIntLogic 
            Caption         =   "IntLogic: OR"
            Height          =   255
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   7
            Top             =   960
            Width           =   1575
         End
         Begin VB.ComboBox cmbIntPersist 
            Height          =   315
            Index           =   1
            Left            =   960
            TabIndex        =   5
            Text            =   "IntPersist"
            Top             =   600
            Width           =   735
         End
         Begin VB.CheckBox cbEnable 
            Caption         =   "Enabled"
            Height          =   255
            Index           =   1
            Left            =   720
            Style           =   1  'Graphical
            TabIndex        =   4
            Top             =   240
            Width           =   975
         End
         Begin VB.Label lblSleep 
            Caption         =   "Sleep:"
            Height          =   255
            Left            =   120
            TabIndex        =   9
            Top             =   1320
            Width           =   495
         End
         Begin VB.Label lblIntPersist 
            Caption         =   "IntPersist1:"
            Height          =   255
            Index           =   1
            Left            =   120
            TabIndex        =   6
            Top             =   600
            Width           =   855
         End
         Begin VB.Label lblEnable 
            Caption         =   "Chan1:"
            Height          =   255
            Index           =   1
            Left            =   120
            TabIndex        =   3
            Top             =   240
            Width           =   495
         End
      End
      Begin VB.Frame frmX38 
         Caption         =   "Frame1"
         Height          =   1455
         Left            =   120
         TabIndex        =   31
         Top             =   4560
         Visible         =   0   'False
         Width           =   1815
         Begin VB.Frame fmProxOffset 
            Caption         =   "Prox Offset"
            Height          =   615
            Left            =   120
            TabIndex        =   32
            Top             =   120
            Width           =   1575
            Begin VB.HScrollBar hscrProxOffset 
               Height          =   255
               Left            =   120
               Max             =   15
               TabIndex        =   33
               Top             =   240
               Width           =   855
            End
            Begin VB.Label lblProxOffset 
               Alignment       =   1  'Right Justify
               Caption         =   "0"
               Height          =   255
               Left            =   1080
               TabIndex        =   34
               Top             =   240
               Width           =   375
            End
         End
         Begin VB.Frame fmIRcomp 
            Caption         =   "IR Comp"
            Height          =   615
            Left            =   120
            TabIndex        =   35
            Top             =   720
            Width           =   1575
            Begin VB.HScrollBar hscrIRcomp 
               Height          =   255
               Left            =   120
               Max             =   31
               TabIndex        =   36
               Top             =   240
               Width           =   855
            End
            Begin VB.Label lblIRcomp 
               Alignment       =   1  'Right Justify
               Caption         =   "0"
               Height          =   255
               Left            =   1200
               TabIndex        =   37
               Top             =   240
               Width           =   255
            End
         End
      End
   End
   Begin VB.OptionButton optAddr 
      Caption         =   "None"
      Height          =   255
      Index           =   0
      Left            =   960
      TabIndex        =   30
      Top             =   360
      Value           =   -1  'True
      Width           =   735
   End
End
Attribute VB_Name = "ucALSusb"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Dim ucJungoUsb1 As ucJungoUsb
Dim ucHIDusb1 As ucHIDUsb
Dim ucEmuUsb1 As ucEmuUsb
Dim ADBUsb1 As ADBUsb

Private cError As String
Private loadDone As Boolean
Private EEprom As clsEEprom
Private UserControl_InitializeDone As Boolean

Const frmDevice_Width As Integer = 1815
Const frmX11_Top As Integer = 2520 + 240
Const frmX28_Top As Integer = 2400 + 240
Const frmX38_Top As Integer = 3960 + 240


' >>>>>>>>>>>>> TEMP
Const useDllIO As Boolean = True

' <<<<<<<<<<<<< TEMP

'Public Enum cmd
'    w
'    r
'    WW
'    RW
'    WA
'    RA
'    callBackOk = 71077345
'End Enum

'Private Const base = &H80
'Private Const addrDefault = &H88
'Private rMap(&H19) As Long

Private X28 As Boolean
Private X38 As Boolean
Private ALSonly As Boolean
Private PRXonly As Boolean
Private gI2cAddr As Long
Private gDUTi2cAddr As Long
Private gPartNumber As Long
Private gPartFamily As Long

Const nOptAddr As Integer = 4

Dim HIDport(2) As Integer


Private Declare Function GetTickCount Lib "kernel32" () As Long

Private Declare Function cGetByteIoOnly Lib "registerDriver" (E As Long) As Long
Private Declare Function cGetData Lib "registerDriver" (ByVal i As Long, r As Long) As Long
Private Declare Function cGetDevice Lib "registerDriver" (v As Long) As Long
Private Declare Function cGetDeviceList Lib "registerDriver" (ByVal c As String) As Long
Private Declare Function cGetEnable Lib "registerDriver" (ByVal i As Long, m As Long) As Long
Private Declare Function cGetError Lib "registerDriver" (ByVal n As Long, ByVal E As String) As Long
Private Declare Function cGetInputSelect Lib "registerDriver" (ByVal i As Long, r As Long) As Long
Private Declare Function cGetInputSelectList Lib "registerDriver" (ByVal c As Long, ByVal v As String) As Long
Private Declare Function cGetIntFlag Lib "registerDriver" (ByVal i As Long, r As Long) As Long
Private Declare Function cGetIntLogic Lib "registerDriver" (m As Long) As Long
Private Declare Function cGetIntPersist Lib "registerDriver" (ByVal c As Long, m As Long) As Long
Private Declare Function cGetIntPersistList Lib "registerDriver" (ByVal c As Long, m As Long) As Long
Private Declare Function cGetIR Lib "registerDriver" (r As Double) As Long
Private Declare Function cGetIrdr Lib "registerDriver" (r As Long) As Long
Private Declare Function cGetIrdrFreq Lib "registerDriver" (m As Long) As Long
Private Declare Function cGetIrdrList Lib "registerDriver" (r As Long) As Long
Private Declare Function cGetIRState Lib "registerDriver" (r As Long) As Long
Private Declare Function cGetLux Lib "registerDriver" (r As Double) As Long
Private Declare Function cGetLuxState Lib "registerDriver" (r As Long) As Long
Private Declare Function cGetMPAprimed Lib "registerDriver" (ByVal c As Long, v As Long) As Long
Private Declare Function cGetNchannel Lib "registerDriver" (n As Long) As Long
Private Declare Function cGetNdevice Lib "registerDriver" (n As Long) As Long
Private Declare Function cGetNinputSelect Lib "registerDriver" (ByVal c As Long, v As Long) As Long
Private Declare Function cGetNintPersist Lib "registerDriver" (ByVal c As Long, v As Long) As Long
Private Declare Function cGetNirdr Lib "registerDriver" (r As Long) As Long
Private Declare Function cGetNrange Lib "registerDriver" (ByVal c As Long, v As Long) As Long
Private Declare Function cGetNresolution Lib "registerDriver" (ByVal c As Long, v As Long) As Long
Private Declare Function cGetNsleep Lib "registerDriver" (v As Long) As Long
Private Declare Function cGetProxAmbRej Lib "registerDriver" (m As Long) As Long
Private Declare Function cGetProxFlag Lib "registerDriver" (m As Long) As Long
Private Declare Function cGetProxIR Lib "registerDriver" (m As Double, F As Long) As Long
Private Declare Function cGetProximity Lib "registerDriver" (m As Double) As Long
Private Declare Function cGetProximityState Lib "registerDriver" (m As Long) As Long
Private Declare Function cGetProxPersist Lib "registerDriver" (m As Long) As Long
Private Declare Function cGetRange Lib "registerDriver" (ByVal c As Long, v As Long) As Long
Private Declare Function cGetRangeList Lib "registerDriver" (ByVal c As Long, v As Long) As Long
Private Declare Function cGetResolution Lib "registerDriver" (ByVal i As Long, r As Long) As Long
Private Declare Function cGetResolutionList Lib "registerDriver" (ByVal c As Long, v As Long) As Long
Private Declare Function cGetRunMode Lib "registerDriver" (m As Long) As Long
Private Declare Function cGetSleep Lib "registerDriver" (v As Long) As Long
Private Declare Function cGetSleepList Lib "registerDriver" (v As Long) As Long
Private Declare Function cGetStats Lib "registerDriver" (ByVal i As Long, m As Double, s As Double) As Long
Private Declare Function cGetStateMachineEnable Lib "registerDriver" (E As Long) As Long
Private Declare Function cGetThreshHi Lib "registerDriver" (ByVal i As Long, r As Double) As Long
Private Declare Function cGetThreshLo Lib "registerDriver" (ByVal i As Long, r As Double) As Long
Private Declare Function cInitDriver Lib "registerDriver" () As Long
Private Declare Function cPoll Lib "registerDriver" (v As Long) As Long
Private Declare Function cPrintTrace Lib "registerDriver" (ByVal v As String) As Long
Private Declare Function cResetDevice Lib "registerDriver" () As Long

Private Declare Function cSetByteIoOnly Lib "registerDriver" (ByVal E As Long) As Long
Private Declare Function cSetDevice Lib "registerDriver" (ByVal v As Long) As Long
Private Declare Function cSetDrvApi Lib "registerDriver" (ByVal n As Long) As Long
Private Declare Function cSetEnable Lib "registerDriver" (ByVal i As Long, ByVal m As Long) As Long
Private Declare Function cSetInputSelect Lib "registerDriver" (ByVal i As Long, ByVal r As Long) As Long
Private Declare Function cSetIntLogic Lib "registerDriver" (ByVal m As Long) As Long
Private Declare Function cSetIntPersist Lib "registerDriver" (ByVal c As Long, ByVal m As Long) As Long
Private Declare Function cSetIrdr Lib "registerDriver" (ByVal r As Long) As Long
Private Declare Function cSetIrdrFreq Lib "registerDriver" (ByVal m As Long) As Long
Private Declare Function cSetLux Lib "registerDriver" (ByVal r As Double) As Long
Private Declare Function cSetMPAsize Lib "registerDriver" (ByVal i As Long, ByVal m As Long) As Long
Private Declare Function cSetProxAmbRej Lib "registerDriver" (ByVal m As Long) As Long
Private Declare Function cSetPWMen Lib "registerDriver" (ByVal m As Long) As Long
Private Declare Function cSetRange Lib "registerDriver" (ByVal c As Long, ByVal v As Long) As Long
Private Declare Function cSetResolution Lib "registerDriver" (ByVal i As Long, ByVal r As Long) As Long
Private Declare Function cSetRunMode Lib "registerDriver" (ByVal m As Long) As Long
Private Declare Function cSetSleep Lib "registerDriver" (ByVal v As Long) As Long
Private Declare Function cSetStateMachineEnable Lib "registerDriver" (ByVal E As Long) As Long
Private Declare Function cSetThreshHi Lib "registerDriver" (ByVal i As Long, ByVal r As Double) As Long
Private Declare Function cSetThreshLo Lib "registerDriver" (ByVal i As Long, ByVal r As Double) As Long
Private Declare Function cTest Lib "registerDriver" (ByVal t As Long) As Long

Private Declare Function cIO Lib "registerDriver" (ByVal c As Long, ByVal a As Long, d As Long) As Long
Private Declare Function cWriteField Lib "registerDriver" (ByVal a As Long, ByVal s As Byte, ByVal m As Byte, ByVal d As Byte) As Long
Private Declare Function cReadField Lib "registerDriver" (ByVal a As Long, ByVal s As Byte, ByVal m As Byte, d As Byte) As Long
Private Declare Function cWriteI2c Lib "registerDriver" (ByVal i2cAddr As Long, ByVal addr As Long, ByVal data As Byte) As Long
Private Declare Function cReadI2c Lib "registerDriver" (ByVal i2cAddr As Long, ByVal addr As Long, data As Byte) As Long
Private Declare Function cWriteI2cWord Lib "registerDriver" (ByVal i2cAddr As Long, ByVal addr As Long, ByVal data As Long) As Long
Private Declare Function cReadI2cWord Lib "registerDriver" (ByVal i2cAddr As Long, ByVal addr As Long, data As Long) As Long

Private Declare Function cGetConversionTime Lib "registerDriver" (ByVal i As Long, r As Long) As Long
Private Declare Function cSetConversionTime Lib "registerDriver" (ByVal i As Long, ByVal r As Long) As Long

Private Declare Function cMeasureConversionTime Lib "registerDriver" (r As Long) As Long
Private Declare Function cGetPartNumber Lib "registerDriver" (r As Long) As Long
Private Declare Function cGetPartFamily Lib "registerDriver" (r As Long) As Long

' 29038
Private Declare Function cSetProxIntEnable Lib "registerDriver" (ByVal x As Long) As Long
Private Declare Function cGetProxIntEnable Lib "registerDriver" (x As Long) As Long
Private Declare Function cSetProxOffset Lib "registerDriver" (x As Long) As Long
Private Declare Function cGetProxOffset Lib "registerDriver" (x As Long) As Long
Private Declare Function cSetIRcomp Lib "registerDriver" (ByVal x As Long) As Long
Private Declare Function cGetIRcomp Lib "registerDriver" (x As Long) As Long
Private Declare Function cGetProxAlrm Lib "registerDriver" (i As Long) As Long
Private Declare Function cSetVddAlrm Lib "registerDriver" (ByVal x As Long) As Long
Private Declare Function cGetVddAlrm Lib "registerDriver" (x As Long) As Long

' 29038 trim
Private Declare Function cSetProxTrim Lib "registerDriver" (ByVal x As Long) As Long
Private Declare Function cGetProxTrim Lib "registerDriver" (x As Long) As Long
Private Declare Function cSetIrdrTrim Lib "registerDriver" (ByVal x As Long) As Long
Private Declare Function cGetIrdrTrim Lib "registerDriver" (x As Long) As Long
Private Declare Function cSetAlsTrim Lib "registerDriver" (ByVal x As Long) As Long
Private Declare Function cGetAlsTrim Lib "registerDriver" (x As Long) As Long

Private Declare Function cSetRegOtpSel Lib "registerDriver" (ByVal x As Long) As Long
Private Declare Function cGetRegOtpSel Lib "registerDriver" (x As Long) As Long
Private Declare Function cSetOtpData Lib "registerDriver" (ByVal x As Long) As Long
Private Declare Function cGetOtpData Lib "registerDriver" (x As Long) As Long
Private Declare Function cSetFuseWrEn Lib "registerDriver" (ByVal x As Long) As Long
Private Declare Function cGetFuseWrEn Lib "registerDriver" (x As Long) As Long
Private Declare Function cSetFuseWrAddr Lib "registerDriver" (ByVal x As Long) As Long
Private Declare Function cGetFuseWrAddr Lib "registerDriver" (x As Long) As Long

Private Declare Function cGetOptDone Lib "registerDriver" (x As Long) As Long
Private Declare Function cSetIrdrDcPulse Lib "registerDriver" (ByVal x As Long) As Long
Private Declare Function cGetIrdrDcPulse Lib "registerDriver" (x As Long) As Long
Private Declare Function cGetGolden Lib "registerDriver" (x As Long) As Long
Private Declare Function cSetOtpRes Lib "registerDriver" (ByVal x As Long) As Long
Private Declare Function cGetOtpRes Lib "registerDriver" (x As Long) As Long
Private Declare Function cSetIntTest Lib "registerDriver" (ByVal x As Long) As Long
Private Declare Function cGetIntTest Lib "registerDriver" (x As Long) As Long

' RGB
Private Declare Function cGetRed Lib "registerDriver" (x As Double) As Long
Private Declare Function cGetGreen Lib "registerDriver" (x As Double) As Long
Private Declare Function cGetBlue Lib "registerDriver" (x As Double) As Long
Private Declare Function cGetCCT Lib "registerDriver" (x As Double) As Long

Private Declare Function cGetRgbCoeffEnable Lib "registerDriver" (x As Long) As Long
Private Declare Function cSetRgbCoeffEnable Lib "registerDriver" (ByVal x As Long) As Long

Private Declare Function cLoadRgbCoeff Lib "registerDriver" (x As Double) As Long
Private Declare Function cClearRgbCoeff Lib "registerDriver" () As Long
Private Declare Function cEnable4x Lib "registerDriver" (ByVal m As Long) As Long
Private Declare Function cEnable8bit Lib "registerDriver" (ByVal m As Long) As Long

' 177

Private Declare Function cSetPrxRngOffCmpEn Lib "registerDriver" (ByVal x As Long) As Long
Private Declare Function cGetPrxRngOffCmpEn Lib "registerDriver" (x As Long) As Long
Private Declare Function cSetIrdrMode Lib "registerDriver" (ByVal x As Long) As Long
Private Declare Function cGetIrdrMode Lib "registerDriver" (x As Long) As Long

Public pUsb As Object
Private usbCaption As String
Private gHwnd As Long
Private gDevLoaded As Boolean

' ______________
' Error Handling
' ¯¯¯¯¯¯¯¯¯¯¯¯¯¯
Private Sub cSetError(ByVal error As Status, Optional ByVal msg As String = "")
    
    If error Then
        cError = "                                    " ' initial allocation
        Call cGetError(error, cError)
        cError = Mid(cError, 1, InStr(1, cError, Chr$(0)) - 1)
        If msg <> "" Then cError = msg & " " & cError
    Else
        msg = ""
    End If

End Sub

Public Function getError() As String
    getError = cError
    cError = "" ' clear on read
End Function


' ________
' Wrappers
' ¯¯¯¯¯¯¯¯

Public Function dGetData(ByVal c As Long, v As Long) As Long
    dGetData = cGetData(c, v): If dGetData Then Call cSetError(dGetData, "dGetData:" & c & ":" & v)
End Function
Public Function dGetDevice(v As Long) As Long
    dGetDevice = cGetDevice(v): If dGetDevice Then Call cSetError(dGetDevice, "dGetDevice")
End Function
Public Function dGetDeviceList(Device As String) As Long
    dGetDeviceList = cGetDeviceList(Device): If dGetDeviceList Then Call cSetError(dGetDeviceList, "dGetDeviceList")
End Function
Public Function dGetEnable(ByVal c As Long, v As Long)
    dGetEnable = cGetEnable(c, v): If dGetEnable Then Call cSetError(dGetEnable, "dGetEnable:" & c & ":" & v)
End Function
Public Function dGetInputSelect(ByVal c As Long, v As Long)
    dGetInputSelect = cGetInputSelect(c, v): If dGetInputSelect Then Call cSetError(dGetInputSelect, "dGetInputSelect:" & c & ":" & v)
End Function
Public Function dGetInputSelectList(c As Long, v As String)
    dGetInputSelectList = cGetInputSelectList(c, v): If dGetInputSelectList Then Call cSetError(dGetInputSelectList, "dGetInputSelectList:" & c & ":" & v)
End Function
Public Function dGetIntFlag(ByVal c As Long, v As Long)
    dGetIntFlag = cGetIntFlag(c, v): If dGetIntFlag Then Call cSetError(dGetIntFlag, "dGetIntFlag:" & c & ":" & v)
End Function
Public Function dGetIntLogic(E As Long)
    dGetIntLogic = cGetIntLogic(E): If dGetIntLogic Then Call cSetError(dGetIntLogic, "dGetIntLogic:" & E)
End Function
Public Function dGetIntPersist(ByVal c As Long, m As Long)
    dGetIntPersist = cGetIntPersist(c, m): If dGetIntPersist Then Call cSetError(dGetIntPersist, "dGetIntPersist:" & c & ":" & m)
End Function
Public Function dGetIR(m As Double)
    dGetIR = cGetIR(m): If dGetIR Then Call cSetError(dGetIR, "dGetIR:" & m)
End Function
Public Function dGetIRState(m As Long)
    dGetIRState = cGetIRState(m): If dGetIRState Then Call cSetError(dGetIRState, "dGetIRState:" & m)
End Function
Public Function dGetIrdr(r As Long)
    dGetIrdr = cGetIrdr(r): If dGetIrdr Then Call cSetError(dGetIrdr, "dGetIrdr:" & r)
End Function
Public Function dGetIrdrList(r As Long)
    dGetIrdrList = cGetIrdrList(r): If dGetIrdrList Then Call cSetError(dGetIrdrList, "dGetIrdrList:" & r)
End Function
Public Function dGetLux(v As Double)
    dGetLux = cGetLux(v): If dGetLux Then Call cSetError(dGetLux, "dGetLux:" & v)
End Function
Public Function dGetLuxState(v As Long)
    dGetLuxState = cGetLuxState(v): If dGetLuxState Then Call cSetError(dGetLuxState, "dGetLuxState:" & v)
End Function



Public Function dGetNdevice(Ndevices As Long) As Long
    dGetNdevice = cGetNdevice(Ndevices): If dGetNdevice Then Call cSetError(dGetNdevice, "dGetNdevice")
End Function
Public Function dGetNchannel(v As Long)
    dGetNchannel = cGetNchannel(v): If dGetNchannel Then Call cSetError(dGetNchannel, "dGetNchannel:" & v)
End Function
Public Function dGetNinputSelect(ByVal c As Long, v As Long)
    dGetNinputSelect = cGetNinputSelect(c, v): If dGetNinputSelect Then Call cSetError(dGetNinputSelect, "dGetNinputSelect:" & c & ":" & v)
End Function
Public Function dGetNrange(ByVal c As Long, v As Long)
    dGetNrange = cGetNrange(c, v): If dGetNrange Then Call cSetError(dGetNrange, "dGetNrange:" & c & ":" & v)
End Function
Public Function dGetNresolution(ByVal c As Long, v As Long)
    dGetNresolution = cGetNresolution(c, v): If dGetNresolution Then Call cSetError(dGetNresolution, "dGetNresolution:" & c & ":" & v)
End Function
Public Function dGetNirdr(r As Long)
    dGetNirdr = cGetNirdr(r): If dGetNirdr Then Call cSetError(dGetNirdr, "dGetNirdr:" & r)
End Function
Public Function dGetNintPersist(ByVal c As Long, v As Long)
    dGetNintPersist = cGetNintPersist(c, v): If dGetNintPersist Then Call cSetError(dGetNintPersist, "dGetNintPersist:" & c & ":" & v)
End Function
Public Function dGetNsleep(v As Long)
    dGetNsleep = cGetNsleep(v): If dGetNsleep Then Call cSetError(dGetNsleep, "dGetNsleep:" & v)
End Function


Public Function dGetProxAmbRej(E As Long)
    dGetProxAmbRej = cGetProxAmbRej(E): If dGetProxAmbRej Then Call cSetError(dGetProxAmbRej, "dGetProxAmbRej:" & E)
End Function
Public Function dGetProximity(E As Double)
    dGetProximity = cGetProximity(E): If dGetProximity Then Call cSetError(dGetProximity, "dGetProximity:" & E)
End Function
Public Function dGetProxIR(E As Double)
    Dim iFlag As Long
    dGetProxIR = cGetProxIR(E, iFlag): If dGetProxIR Then Call cSetError(dGetProxIR, "dGetProxIR:" & E)
End Function
Public Function dGetProxAlrm(a As Long)
    dGetProxAlrm = cGetProxAlrm(a): If dGetProxAlrm Then Call cSetError(dGetProxAlrm, "dGetProxAlrm:" & a)
End Function
Public Function dGetProximityState(E As Long)
    dGetProximityState = cGetProximityState(E): If dGetProximityState Then Call cSetError(dGetProximityState, "dGetProximityState:" & E)
End Function
Public Function dGetProxPersist(m As Long)
    dGetProxPersist = cGetProxPersist(m): If dGetProxPersist Then Call cSetError(dGetProxPersist, "dGetProxPersist:" & m)
End Function
Public Function dGetRange(ByVal c As Long, v As Long)
    dGetRange = cGetRange(c, v): If dGetRange Then Call cSetError(dGetRange, "dGetRange:" & c & ":" & v)
End Function

Public Function dGetStateMachineEnable(E As Long) As Long
    dGetStateMachineEnable = cGetStateMachineEnable(E): If dGetStateMachineEnable Then Call cSetError(dGetStateMachineEnable, "dGetStateMachineEnable")
End Function

Public Function dSetStateMachineEnable(ByVal E As Long) As Long
    dSetStateMachineEnable = cSetStateMachineEnable(E): If dSetStateMachineEnable Then Call cSetError(dSetStateMachineEnable, "dSetStateMachineEnable")
End Function



Public Function dGetByteIoOnly(E As Long) As Long
    dGetByteIoOnly = cGetByteIoOnly(E): If dGetByteIoOnly Then Call cSetError(dGetByteIoOnly, "dGetByteIoOnly")
End Function

Public Function dSetByteIoOnly(ByVal E As Long) As Long
    dSetByteIoOnly = cSetByteIoOnly(E): If dSetByteIoOnly Then Call cSetError(dSetByteIoOnly, "dSetByteIoOnly")
End Function



Public Function dGetStats(i As Long, m As Double, s As Double) As Long
    dGetStats = cGetStats(i, m, s): If dGetStats Then Call cSetError(dGetStats, "dGetStats")
End Function



' ________
' Pre-sort
' ¯¯¯¯¯¯¯¯

Public Function dSetThreshHi(ByVal c As Long, v As Double)
    dSetThreshHi = cSetThreshHi(c, v)
    If dSetThreshHi Then Call cSetError(dSetThreshHi, "dSetThreshHi:" & c & ":" & v)
End Function
Public Function dGetThreshHi(ByVal c As Long, v As Double)
    dGetThreshHi = cGetThreshHi(c, v)
    If dGetThreshHi Then Call cSetError(dGetThreshHi, "dGetThreshHi:" & c & ":" & v)
End Function
Public Function dSetThreshLo(ByVal c As Long, v As Double)
    dSetThreshLo = cSetThreshLo(c, v)
    If dSetThreshLo Then Call cSetError(dSetThreshLo, "dSetThreshLo:" & c & ":" & v)
End Function
Public Function dGetThreshLo(ByVal c As Long, v As Double)
    dGetThreshLo = cGetThreshLo(c, v)
    If dGetThreshLo Then Call cSetError(dGetThreshLo, "dGetThreshLo:" & c & ":" & v)
End Function
Public Function dGetIrdrFreq(E As Long)
    dGetIrdrFreq = cGetIrdrFreq(E): If dGetIrdrFreq Then Call cSetError(dGetIrdrFreq, "dGetIrdrFreq:" & E)
End Function






Public Function dSetRunMode(m As Long)
    dSetRunMode = cSetRunMode(m)
    If dSetRunMode Then Call cSetError(dSetRunMode, "dSetRunMode:" & m)
End Function
Public Function dGetRunMode(m As Long)
    dGetRunMode = cGetRunMode(m)
    If dGetRunMode Then Call cSetError(dGetRunMode, "dGetRunMode:" & m)
End Function


Public Function dSetEnable(ByVal c As Long, v As Long)
    dSetEnable = cSetEnable(c, v)
    If dSetEnable Then Call cSetError(dSetEnable, "dSetEnable:" & c & ":" & v)
End Function


Public Function dGetProxFlag(E As Long)
    dGetProxFlag = cGetProxFlag(E)
    If dGetProxFlag Then Call cSetError(dGetProxFlag, "dGetEnable:" & E)
End Function

Public Function dSetIntLogic(E As Long)
    dSetIntLogic = cSetIntLogic(E)
    If dSetIntLogic Then Call cSetError(dSetIntLogic, "dSetIntLogic:" & E)
End Function



Public Function dSetIntPersist(c As Long, m As Long)
    dSetIntPersist = cSetIntPersist(c, m)
    If dSetIntPersist Then Call cSetError(dSetIntPersist, "dSetIntPersist:" & c & ":" & m)
End Function

Public Function dSetProxAmbRej(E As Long)
    dSetProxAmbRej = cSetProxAmbRej(E)
    If dSetProxAmbRej Then Call cSetError(dSetProxAmbRej, "dSetProxAmbRej:" & E)
End Function

Public Function dSetIrdrFreq(E As Long)
    dSetIrdrFreq = cSetIrdrFreq(E)
    If dSetIrdrFreq Then Call cSetError(dSetIrdrFreq, "dSetIrdrFreq:" & E)
End Function

Public Function dSetPWMen(E As Long)
    dSetPWMen = cSetPWMen(E)
    If dSetPWMen Then Call cSetError(dSetPWMen, "dSetPWMen:" & E)
End Function


Public Function dSetIrdr(ByVal r As Long)
    dSetIrdr = cSetIrdr(r)
    If dSetIrdr Then Call cSetError(dSetIrdr, "dSetIrdr:" & r)
End Function




Public Function dSetResolution(ByVal c As Long, v As Long)
    dSetResolution = cSetResolution(c, v)
    If dSetResolution Then Call cSetError(dSetResolution, "dSetResolution:" & c & ":" & v)
End Function
Public Function dGetResolution(ByVal c As Long, v As Long)
    dGetResolution = cGetResolution(c, v)
    If dGetResolution Then Call cSetError(dGetResolution, "dGetResolution:" & c & ":" & v)
End Function







Public Function dGetRangeList(ByVal c As Long, v As Long)
    dGetRangeList = cGetRangeList(c, v)
    If dGetRangeList Then Call cSetError(dGetRangeList, "dGetRangeList:" & c & ":" & v)
End Function
Public Function dGetResolutionList(c As Long, v As Long)
    dGetResolutionList = cGetResolutionList(c, v)
    If dGetResolutionList Then Call cSetError(dGetResolutionList, "dGetResolutionList:" & c & ":" & v)
End Function
Public Function dGetIntPersistList(c As Long, v As Long)
    dGetIntPersistList = cGetIntPersistList(c, v)
    If dGetIntPersistList Then Call cSetError(dGetIntPersistList, "dGetIntPersistList:" & c & ":" & v)
End Function
Public Function dGetSleepList(v As Long)
    dGetSleepList = cGetSleepList(v)
    If dGetSleepList Then Call cSetError(dGetSleepList, "dGetSleepList:" & v)
End Function





Public Function dSetRange(ByVal c As Long, ByVal v As Long)
    dSetRange = cSetRange(c, v)
    If dSetRange Then Call cSetError(dSetRange, "dSetRange:" & c & ":" & v)
End Function

Public Function dSetSleep(v As Long)
    dSetSleep = cSetSleep(v)
    If dSetSleep Then Call cSetError(dSetSleep, "dSetSleep:" & v)
End Function
Public Function dGetSleep(v As Long)
    dGetSleep = cGetSleep(v)
    If dGetSleep Then Call cSetError(dGetSleep, "dGetSleep:" & v)
End Function






Public Function dSetInputSelect(ByVal c As Long, ByVal v As Long)
    dSetInputSelect = cSetInputSelect(c, v)
    If dSetInputSelect Then Call cSetError(dSetInputSelect, "dSetInputSelect:" & c & ":" & v)
End Function



' ____
' Data
' ¯¯¯¯
Public Function dSetMPAsize(ByVal c As Long, v As Long)
    dSetMPAsize = cSetMPAsize(c, v)
    If dSetMPAsize Then Call cSetError(dSetMPAsize, "dSetMPAsize:" & c & ":" & v)
End Function
Public Function dGetMPAprimed(ByVal c As Long, v As Long)
    dGetMPAprimed = cGetMPAprimed(c, v)
    If dGetMPAprimed Then Call cSetError(dGetMPAprimed, "dGetMPAprimed:" & c & ":" & v)
End Function

' _________________
' Pass Callback sub
' ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
Public Function dSetDrvApi(ByVal pFunc As Long) As Long
    dSetDrvApi = cSetDrvApi(ByVal pFunc)
    If dSetDrvApi Then Call cSetError(dSetDrvApi, "dSetCallBack")
End Function
Public Function dInitDriver() As Long
    dInitDriver = cInitDriver()
    If dInitDriver Then Call cSetError(dInitDriver, "dInitDriver")
End Function
' ________________
' Resource Manager
' ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯


Public Function dSetDevice(ByVal v As Long) As Long
    dSetDevice = cSetDevice(v)
    If dSetDevice Then Call cSetError(dSetDevice, "dSetDevice")
End Function




Public Function dTest(t As Long) As Long
    dTest = cTest(t)
    If dTest Then Call cSetError(dTest, "dTest")
End Function


Public Function dIO(ByVal c As Long, ByVal a As Long, d As Long) As Long
    dIO = cIO(c, a, d)
    If dIO Then Call cSetError(dIO, "dIO")
End Function

Public Function dWriteField(ByVal a As Long, ByVal s As Byte, ByVal m As Byte, ByVal d As Byte) As Long
    dWriteField = cWriteField(a, s, m, d)
    If dWriteField Then Call cSetError(dWriteField, "dWriteField")
End Function

Public Function dReadField(ByVal a As Long, ByVal s As Byte, ByVal m As Byte, d As Byte) As Long
    dReadField = cReadField(a, s, m, d)
    If dReadField Then Call cSetError(dReadField, "dReadField")
End Function





Public Function dWriteI2c(ByVal i2cAddr As Long, ByVal addr As Long, ByVal data As Byte)

    Dim ldata As Long: ldata = data
    Dim li2cAddr As Long: li2cAddr = i2cAddr
    
    If useDllIO Then
        dWriteI2c = cWriteI2c(i2cAddr, addr, data)
        If dWriteI2c Then Call cSetError(dWriteI2c, "dWriteI2c")
    Else
        DllCallBack CBcmds.eWaddr, i2cAddr, li2cAddr, 1
        DllCallBack CBcmds.eWbyte, addr, ldata, 1
    End If
    
    li2cAddr = gI2cAddr
    DllCallBack CBcmds.eWaddr, li2cAddr, li2cAddr, 1
    
End Function

Public Function dWriteI2cWord(ByVal i2cAddr As Long, ByVal addr As Byte, ByVal data As Long)
    Dim ldata(0) As Long: ldata(0) = data
    Dim li2cAddr(0) As Long: li2cAddr(0) = i2cAddr
    
    If useDllIO Then
        dWriteI2cWord = cWriteI2cWord(i2cAddr, addr, ldata(0))
        If dWriteI2cWord Then Call cSetError(dWriteI2cWord, "dWriteI2cWord")
    Else
        DllCallBack CBcmds.eWaddr, li2cAddr(0), li2cAddr(0), 1
        DllCallBack CBcmds.eWword, addr, ldata(0), 1
    End If
    
    li2cAddr(0) = gI2cAddr
    DllCallBack CBcmds.eWaddr, li2cAddr(0), li2cAddr(0), 1
    
End Function

Public Function dReadI2c(ByVal i2cAddr As Long, ByVal addr As Byte, data As Byte)
    Dim ldata(0) As Long: ldata(0) = data
    Dim li2cAddr(0) As Long: li2cAddr(0) = i2cAddr
    
    If useDllIO Then
        dReadI2c = cReadI2c(i2cAddr, addr, data)
        If dReadI2c Then Call cSetError(dReadI2c, "dReadI2c")
    Else
        Call DllCallBack(CBcmds.eWaddr, li2cAddr(0), li2cAddr(0), 1)
        Call DllCallBack(CBcmds.eRbyte, addr, ldata(0), 1)
        ldata(0) = ldata(0) And &HFF: data = ldata(0)
    End If
    
    li2cAddr(0) = gI2cAddr
    Call DllCallBack(CBcmds.eWaddr, gI2cAddr, li2cAddr(0), 1)
    
End Function

Public Function dReadI2cWord(ByVal i2cAddr As Long, ByVal addr As Byte, data As Long)
    Dim li2cAddr(0) As Long: li2cAddr(0) = i2cAddr
    Dim vData(0) As Long
    
    If useDllIO Then
        dReadI2cWord = cReadI2cWord(i2cAddr, addr, data)
        If dReadI2cWord Then Call cSetError(dReadI2cWord, "dReadI2cWord")
    Else
        Call DllCallBack(CBcmds.eWaddr, li2cAddr(0), li2cAddr(0), 1)
        Call DllCallBack(CBcmds.eRword, addr, vData(0), 1): data = vData(0)
    End If
    
    li2cAddr(0) = gI2cAddr
    Call DllCallBack(CBcmds.eWaddr, gI2cAddr, li2cAddr(0), 1)
    
End Function









Public Function dPoll(t As Long) As Long
    dPoll = cPoll(t)
    If dPoll Then Call cSetError(dPoll, "dPoll")
End Function

Public Function dPrintTrace(t As String) As Long
    dPrintTrace = cPrintTrace(t)
    If dPrintTrace Then Call cSetError(dPrintTrace, "dPrintTrace")
End Function

Public Function dResetDevice() As Long
    dResetDevice = cResetDevice()
    If dResetDevice Then Call cSetError(dResetDevice, "dResetDevice")
End Function


Public Function dGetConversionTime(ByVal c As Long, v As Long)
    dGetConversionTime = cGetConversionTime(c, v)
    If dGetConversionTime Then Call cSetError(dGetConversionTime, "dGetConversionTime:" & c & ":" & v)
End Function

Public Function dSetConversionTime(ByVal c As Long, ByVal v As Long)
    dSetConversionTime = cSetConversionTime(c, v)
    If dSetConversionTime Then Call cSetError(dSetConversionTime, "dSetConversionTime:" & c & ":" & v)
End Function

Public Function dMeasureConversionTime(v As Long)
    dMeasureConversionTime = cMeasureConversionTime(v)
    If dMeasureConversionTime Then Call cSetError(dMeasureConversionTime, "dMeasureConversionTime:" & v)
End Function

Public Function dGetPartNumber(v As Long)
    dGetPartNumber = cGetPartNumber(v)
    If dGetPartNumber Then Call cSetError(dGetPartNumber, "dGetPartNumber:" & v)
End Function
Public Function dGetPartFamily(v As Long)
    dGetPartFamily = cGetPartFamily(v)
    If dGetPartFamily Then Call cSetError(dGetPartFamily, "dGetPartFamily:" & v)
End Function



' _____
' 29038
' ¯¯¯¯¯
Public Function dSetProxIntEnable(ByVal x As Long) As Long
    dSetProxIntEnable = cSetProxIntEnable(x)
    If dSetProxIntEnable Then Call cSetError(dSetProxIntEnable, "dSetProxIntEnable")
End Function
Public Function dGetProxIntEnable(x As Long) As Long
    dGetProxIntEnable = cGetProxIntEnable(x)
    If dGetProxIntEnable Then Call cSetError(dGetProxIntEnable, "dGetProxIntEnable")
End Function

Public Function dSetProxOffset(x As Long) As Long
    dSetProxOffset = cSetProxOffset(x)
    If dSetProxOffset Then Call cSetError(dSetProxOffset, "dSetProxOffset")
End Function
Public Function dGetProxOffset(x As Long) As Long
    dGetProxOffset = cGetProxOffset(x)
    If dGetProxOffset Then Call cSetError(dGetProxOffset, "dGetProxOffset")
End Function

Public Function dSetIRcomp(ByVal x As Long) As Long
    dSetIRcomp = cSetIRcomp(x)
    If dSetIRcomp Then Call cSetError(dSetIRcomp, "dSetIRcomp")
End Function
Public Function dGetIRcomp(x As Long) As Long
    dGetIRcomp = cGetIRcomp(x)
    If dGetIRcomp Then Call cSetError(dGetIRcomp, "dGetIRcomp")
End Function

Public Function dSetVddAlrm(ByVal x As Long) As Long
    dSetVddAlrm = cSetVddAlrm(x)
    If dSetVddAlrm Then Call cSetError(dSetVddAlrm, "dSetVddAlrm")
End Function
Public Function dGetVddAlrm(x As Long) As Long
    dGetVddAlrm = cGetVddAlrm(x)
    If dGetVddAlrm Then Call cSetError(dGetVddAlrm, "dGetVddAlrm")
End Function

' __________
' 29038 Trim
' ¯¯¯¯¯¯¯¯¯¯
Public Function dSetProxTrim(ByVal x As Long) As Long
    dSetProxTrim = cSetProxTrim(x)
    If dSetProxTrim Then Call cSetError(dSetProxTrim, "dSetProxTrim")
End Function
Public Function dGetProxTrim(x As Long) As Long
    dGetProxTrim = cGetProxTrim(x)
    If dGetProxTrim Then Call cSetError(dGetProxTrim, "dGetProxTrim")
End Function

Public Function dSetIrdrTrim(ByVal x As Long) As Long
    dSetIrdrTrim = cSetIrdrTrim(x)
    If dSetIrdrTrim Then Call cSetError(dSetIrdrTrim, "dSetIrdrTrim")
End Function
Public Function dGetIrdrTrim(x As Long) As Long
    dGetIrdrTrim = cGetIrdrTrim(x)
    If dGetIrdrTrim Then Call cSetError(dGetIrdrTrim, "dGetIrdrTrim")
End Function

Public Function dSetAlsTrim(ByVal x As Long) As Long
    dSetAlsTrim = cSetAlsTrim(x)
    If dSetAlsTrim Then Call cSetError(dSetAlsTrim, "dSetAlsTrim")
End Function
Public Function dGetAlsTrim(x As Long) As Long
    dGetAlsTrim = cGetAlsTrim(x)
    If dGetAlsTrim Then Call cSetError(dGetAlsTrim, "dGetAlsTrim")
End Function


Public Function dSetRegOtpSel(ByVal x As Long) As Long
    dSetRegOtpSel = cSetRegOtpSel(x)
    If dSetRegOtpSel Then Call cSetError(dSetRegOtpSel, "dSetRegOtpSel")
End Function
Public Function dGetRegOtpSel(x As Long) As Long
    dGetRegOtpSel = cGetRegOtpSel(x)
    If dGetRegOtpSel Then Call cSetError(dGetRegOtpSel, "dGetRegOtpSel")
End Function


Public Function dSetOtpData(ByVal x As Long) As Long
    dSetOtpData = cSetOtpData(x)
    If dSetOtpData Then Call cSetError(dSetOtpData, "dSetOtpData")
End Function
Public Function dGetOtpData(x As Long) As Long
    dGetOtpData = cGetOtpData(x)
    If dGetOtpData Then Call cSetError(dGetOtpData, "dGetOtpData")
End Function

Public Function dSetFuseWrEn(ByVal x As Long) As Long
    dSetFuseWrEn = cSetFuseWrEn(x)
    If dSetFuseWrEn Then Call cSetError(dSetFuseWrEn, "dSetFuseWrEn")
End Function
Public Function dGetFuseWrEn(x As Long) As Long
    dGetFuseWrEn = cGetFuseWrEn(x)
    If dGetFuseWrEn Then Call cSetError(dGetFuseWrEn, "dGetFuseWrEn")
End Function

Public Function dSetFuseWrAddr(ByVal x As Long) As Long
    dSetFuseWrAddr = cSetFuseWrAddr(x)
    If dSetFuseWrAddr Then Call cSetError(dSetFuseWrAddr, "dSetFuseWrAddr")
End Function
Public Function dGetFuseWrAddr(x As Long) As Long
    dGetFuseWrAddr = cGetFuseWrAddr(x)
    If dGetFuseWrAddr Then Call cSetError(dGetFuseWrAddr, "dGetFuseWrAddr")
End Function


Public Function dGetOptDone(x As Long) As Long
    dGetOptDone = cGetOptDone(x)
    If dGetOptDone Then Call cSetError(dGetOptDone, "dGetOptDone")
End Function

Public Function dSetIrdrDcPulse(ByVal x As Long) As Long
    dSetIrdrDcPulse = cSetIrdrDcPulse(x)
    If dSetIrdrDcPulse Then Call cSetError(dSetIrdrDcPulse, "dSetIrdrDcPulse")
End Function
Public Function dGetIrdrDcPulse(x As Long) As Long
    dGetIrdrDcPulse = cGetIrdrDcPulse(x)
    If dGetIrdrDcPulse Then Call cSetError(dGetIrdrDcPulse, "dGetIrdrDcPulse")
End Function

Public Function dGetGolden(x As Long) As Long
    dGetGolden = cGetGolden(x)
    If dGetGolden Then Call cSetError(dGetGolden, "dGetGolden")
End Function

Public Function dSetOtpRes(ByVal x As Long) As Long
    dSetOtpRes = cSetOtpRes(x)
    If dSetOtpRes Then Call cSetError(dSetOtpRes, "dSetOtpRes")
End Function
Public Function dGetOtpRes(x As Long) As Long
    dGetOtpRes = cGetOtpRes(x)
    If dGetOtpRes Then Call cSetError(dGetOtpRes, "dGetOtpRes")
End Function

Public Function dSetIntTest(ByVal x As Long) As Long
    dSetIntTest = cSetIntTest(x)
    If dSetIntTest Then Call cSetError(dSetIntTest, "dSetIntTest")
End Function
Public Function dGetIntTest(x As Long) As Long
    dGetIntTest = cGetIntTest(x)
    If dGetIntTest Then Call cSetError(dGetIntTest, "dGetIntTest")
End Function


' RGB
Public Function dGetRed(x As Double) As Long
    dGetRed = cGetRed(x)
    If dGetRed Then Call cSetError(dGetRed, "dGetRed")
End Function
Public Function dGetGreen(x As Double) As Long
    dGetGreen = cGetGreen(x)
    If dGetGreen Then Call cSetError(dGetGreen, "dGetGreen")
End Function
Public Function dGetBlue(x As Double) As Long
    dGetBlue = cGetBlue(x)
    If dGetBlue Then Call cSetError(dGetBlue, "dGetBlue")
End Function
Public Function dGetCCT(x As Double) As Long
    dGetCCT = cGetCCT(x)
    If dGetCCT Then Call cSetError(dGetCCT, "dGetCCT")
End Function
Public Function dGetRgbCoeffEnable(x As Long) As Long
    dGetRgbCoeffEnable = cGetRgbCoeffEnable(x)
    If dGetRgbCoeffEnable Then Call cSetError(dGetRgbCoeffEnable, "dGetRgbCoeffEnable")
End Function
Public Function dSetRgbCoeffEnable(ByVal x As Long) As Long
    dSetRgbCoeffEnable = cSetRgbCoeffEnable(x)
    If dSetRgbCoeffEnable Then Call cSetError(dSetRgbCoeffEnable, "dSetRgbCoeffEnable")
End Function
Public Function dLoadRgbCoeff(x() As Double) As Long
    dLoadRgbCoeff = cLoadRgbCoeff(x(0))
    If dLoadRgbCoeff Then Call cSetError(dLoadRgbCoeff, "dLoadRgbCoeff")
End Function
Public Function dClearRgbCoeff() As Long
    dClearRgbCoeff = cClearRgbCoeff()
    If dClearRgbCoeff Then Call cSetError(dClearRgbCoeff, "dClearRgbCoeff")
End Function
Public Function dEnable4x(ByVal x As Long) As Long
    dEnable4x = cEnable4x(x)
    If dEnable4x Then Call cSetError(dEnable4x, "dEnable4x")
End Function
Public Function dEnable8bit(ByVal x As Long) As Long
    dEnable8bit = cEnable8bit(x)
    If dEnable8bit Then Call cSetError(dEnable8bit, "dEnable8bit")
End Function


' 177
Public Function dSetPrxRngOffCmpEn(ByVal x As Long) As Long
    dSetPrxRngOffCmpEn = cSetPrxRngOffCmpEn(x)
    If dSetPrxRngOffCmpEn Then Call cSetError(dSetPrxRngOffCmpEn, "dSetPrxRngOffCmpEn")
End Function
Public Function dGetPrxRngOffCmpEn(x As Long) As Long
    dGetPrxRngOffCmpEn = cGetPrxRngOffCmpEn(x)
    If dGetPrxRngOffCmpEn Then Call cSetError(dGetPrxRngOffCmpEn, "dGetPrxRngOffCmpEn")
End Function
Public Function dSetIrdrMode(ByVal x As Long) As Long
    dSetIrdrMode = cSetIrdrMode(x)
    If dSetIrdrMode Then Call cSetError(dSetIrdrMode, "dSetIrdrMode")
End Function
Public Function dGetIrdrMode(x As Long) As Long
    dGetIrdrMode = cGetIrdrMode(x)
    If dGetIrdrMode Then Call cSetError(dGetIrdrMode, "dGetIrdrMode")
End Function







Private Sub loadCmbList(cmbIn As ComboBox, nDev As Long, devList As String)
    Dim i As Long, j As Long, Dev As String
    cmbIn.clear
    For i = 0 To nDev - 1
        Dev = Mid(devList, j + 1, InStr(j + 1, devList, Chr$(0)) - (j + 1))
        j = j + Len(Dev) + 1 ' jump NULL
        cmbIn.AddItem (Dev)
    Next i
End Sub

Private Sub LoadDevice()
    ' ___________________________________
    ' Load Supported Device List from DLL
    ' ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
    Dim Ndevices As Long
    
    If dGetNdevice(Ndevices) Then
        handleError ("LoadDevice: " & getError())
    Else
        Dim devs As String, Dev As String, i As Long, j As Long: j = 0
        devs = " ": For i = 0 To 10: devs = devs & devs: Next i
        
        If dGetDeviceList(devs) Then
            handleError ("LoadDevice: " & getError())
        Else ' get single dev from devs list separated by NULL
            
            Call loadCmbList(cmbDevice, Ndevices, devs)
            
            Call dGetDevice(cmbDevice.ListIndex)
        
        End If
        
    End If
    
End Sub

Private Sub LoadInputSelect(Optional channel As Long = 0)
    ' __________________________________
    ' Load Input Selection List from DLL
    ' ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
    Dim devs As String, i As Long, nInputSelect As Long, inputSelect As Long
    
    If gDevLoaded Then
        If dGetInputSelect(channel, inputSelect) Then
            handleError ("LoadInputSelect: " & getError())
        Else
            cmbInputSelect.ListIndex = inputSelect
        End If
    Else
        If dGetNinputSelect(channel, nInputSelect) Then
            handleError ("LoadInputSelect: " & getError())
        Else
            'Dim devs As String, Dev As String, i As Long, j As Long: j = 0
            devs = " ": For i = 0 To 10: devs = devs & devs: Next i: devs = devs & Chr$(0)
            
            If dGetInputSelectList(channel, devs) Then
                handleError ("LoadInputSelect: " & getError())
            Else ' get single dev from devs list separated by NULL
                Call loadCmbList(cmbInputSelect, nInputSelect, devs)
            End If
            
        End If
        
        If nInputSelect > 0 Then
        
            If dGetInputSelect(channel, i) Then
                handleError ("LoadInputSelect: " & getError())
            Else
                cmbInputSelect.Visible = True
                cmbInputSelect.ListIndex = i
            End If
            
        Else
            cmbInputSelect.Visible = False
        End If
        
        lblInputSelect.Visible = cmbInputSelect.Visible
        
    End If
    
End Sub

Private Sub LoadRange(Optional channel As Long = 0)
    ' ____________________
    ' Load Range Selection
    ' ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
    Dim i As Long, nRanges As Long, range As Long
    
    If gDevLoaded Then
        If dGetRange(channel, range) Then
            handleError ("LoadRange: " & getError())
        Else
            cmbRange.ListIndex = range
        End If
    Else
        If dGetNrange(channel, nRanges) Then
            handleError ("LoadRange: " & getError())
        Else
        
            ReDim rngs(nRanges - 1) As Long
            
            If dGetRangeList(channel, rngs(0)) Then
                handleError ("LoadRange: " & getError())
            Else
                cmbRange.clear
                For i = 0 To nRanges - 1
                    cmbRange.AddItem rngs(i)
                Next i
                cmbRange.ListIndex = 0
                
            End If
        End If
        
        If dGetRange(channel, i) Then
            handleError ("LoadRange: " & getError())
        Else
            cmbRange.ListIndex = i
        End If
    End If
    
End Sub

Private Sub LoadResolution(Optional channel As Long = 0)
    ' ___________________________________
    ' Load Full Scale Code List from DLL
    ' ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
    Dim i As Long, nRes As Long, resolution As Long
    
    If gDevLoaded Then
        If dGetResolution(channel, resolution) Then
            handleError ("LoadResolution: " & getError())
        Else
            cmbResolution.ListIndex = resolution
        End If
    Else
        If dGetNresolution(channel, nRes) Then
            handleError ("LoadResolution: " & getError())
        Else
            ReDim rngs(nRes - 1) As Long
            
            If dGetResolutionList(channel, rngs(0)) Then
                handleError ("LoadResolution: " & getError())
            Else
                cmbResolution.clear
                For i = 0 To nRes - 1
                    cmbResolution.AddItem rngs(i)
                Next i
                cmbResolution.ListIndex = 0
            End If
            
        End If
        
        If dGetResolution(channel, i) Then
            handleError ("LoadResolution: " & getError())
        Else
            cmbResolution.ListIndex = i
        End If
    End If
    
End Sub

Public Function writeI2cPage(ByVal intAddr As Long, data() As Byte, Optional byteMode As Boolean = True, Optional size As Integer = -1) As Long
    
    writeI2cPage = modHIDusb.writeI2cPage(intAddr, data, byteMode)
    
End Function

Public Function readI2cPage(ByVal intAddr As Long, data() As Byte, Optional byteMode As Boolean = True, Optional size As Integer = -1) As Long

    readI2cPage = modHIDusb.readI2cPage(intAddr, data, byteMode)
    
End Function


Private Sub setALSonly(flag As Boolean)
    Dim Nflag As Boolean: Nflag = Not flag
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
    ' ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
    Dim i As Long, nIrdr As Long, irdr As Long
    
    If gDevLoaded Then
        If dGetIrdr(irdr) Then
            handleError ("LoadIrdr: " & getError())
            ALSonly = True
        Else
            cmbIrdr.ListIndex = irdr
        End If
    Else
        If dGetNirdr(nIrdr) Then
            handleError ("LoadIrdr: " & getError())
        Else
            If nIrdr Then
                
                ReDim devs(nIrdr - 1) As Long
                
                setALSonly False
                
                If dGetIrdrList(devs(0)) Then
                    handleError ("LoadIrdr: " & getError())
                Else
                    cmbIrdr.clear
                    
                    For i = 0 To nIrdr - 1
                        cmbIrdr.AddItem devs(i)
                    Next i
                    cmbIrdr.text = devs(0)
        
                    If dGetIrdr(i) Then
                        handleError ("LoadIrdr: " & getError())
                    Else
                        cmbIrdr.ListIndex = i
                    End If
        
                End If
            Else
                setALSonly True
            End If
            
        End If
    End If
       
End Sub

Private Sub LoadIntPersist(Optional channel As Long = 0)
    ' _____________________________
    ' Load IntPersist List from DLL
    ' ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
    Dim i As Long, nPrt As Long, intPesisist As Long
    
    If gDevLoaded Then
        If dGetIntPersist(channel, intPesisist) Then
            handleError ("LoadIntPersist: " & getError())
        Else
            cmbIntPersist(channel).ListIndex = intPesisist
        End If
    Else
        If dGetNintPersist(channel, nPrt) Then
            handleError ("LoadIntPersist: " & getError())
        Else
            ReDim rngs(nPrt - 1) As Long
            
            If dGetIntPersistList(channel, rngs(0)) Then
                handleError ("LoadIntPersist: " & getError())
            Else
                cmbIntPersist(channel).clear
                For i = 0 To nPrt - 1
                    cmbIntPersist(channel).AddItem rngs(i)
                Next i
                cmbIntPersist(channel).ListIndex = 0
            End If
            
        End If
    
        If dGetIntPersist(channel, i) Then
            handleError ("LoadIntPersist: " & getError())
        Else
            cmbIntPersist(channel).ListIndex = i
        End If
    End If

End Sub

Private Sub LoadSleep()
    ' ________________________
    ' Load Sleep List from DLL
    ' ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
    Dim i As Long, nslp As Long
    
    If dGetNsleep(nslp) Then
        handleError ("LoadSleep: " & getError())
    Else
        ReDim slps(nslp - 1) As Long
        
        If dGetSleepList(slps(0)) Then
            handleError ("LoadSleep: " & getError())
        Else
            cmbSleep.clear
            For i = 0 To nslp - 1
                cmbSleep.AddItem slps(i)
            Next i
            cmbSleep.text = slps(0)
        End If
        
    End If

    If dGetSleep(i) Then
        handleError ("LoadSleep: " & getError())
    Else
        cmbSleep.ListIndex = i
    End If

End Sub

Private Sub updateBoth()

    Dim ci As Integer, c As Long, v As Long: c = 0: ci = c

    If loadDone = True Then
        LoadRange
        LoadIntPersist
        LoadInputSelect
        If Not ALSonly Then LoadIrdr
    
        If dGetEnable(c, v) Then
            handleError (getError())
        Else
        
            If v Then
                cbEnable(c).value = vbUnchecked
            Else
                cbEnable(c).value = vbChecked
            End If
            
            Call cbEnable_Click(ci)
            
        End If
        
        If dGetIntFlag(c, v) Then
            handleError (getError())
        Else
            optInt.value = (v = 1)
        End If
    
    End If
End Sub

Private Sub setWidgetsVisible()
    frmX11.Visible = False
    frmX28.Visible = False
    frmX38.Visible = False
    
    Select Case gPartFamily
        Case 29011: frmX11.Visible = True
        Case 29028: frmX28.Visible = True
        Case 29038: frmX38.Visible = True
        Case 29125: frmX38.Visible = True
    End Select
End Sub
Private Sub updateX11()

    Dim v As Long

    If loadDone = True Then
    
        setWidgetsVisible
        
        LoadResolution
    
        If ALSonly = False Then
    
            If dGetIrdrFreq(v) Then
                handleError (getError())
            Else
            
                If v Then
                    cbIrdrFreq.value = vbChecked
                Else
                    cbIrdrFreq.value = vbUnchecked
                End If
                
                cbIrdrFreq_Click
                
            End If
    
            If dGetProxAmbRej(v) Then
                handleError (getError())
            Else
            
                If v Then
                    cbProxAmbRej.value = vbUnchecked
                Else
                    cbProxAmbRej.value = vbChecked
                End If
                
                cbProxAmbRej_Click
                
            End If
        
        End If
        
    End If
End Sub
Private Sub updateX28()

    Dim ci As Integer, c As Long, v As Long: c = 1: ci = c

    If loadDone = True Then
        frmX28.Visible = True
        frmX11.Visible = False
        
        If X38 Then
            frmX38.Visible = True
        Else
            frmX38.Visible = False
        End If
        
        LoadIntPersist 1
        LoadSleep
    
        If dGetEnable(c, v) Then
            handleError (getError())
        Else
        
            If v Then
                cbEnable(c).value = vbUnchecked
            Else
                cbEnable(c).value = vbChecked
            End If
            
            Call cbEnable_Click(ci)
            
        End If
        
        If cGetIntLogic(v) Then
            handleError (getError())
        Else
        
            If v Then
                cbIntLogic.value = vbChecked
            Else
                cbIntLogic.value = vbUnchecked
            End If
            
            cbIntLogic_Click
            
        End If
        
    End If
End Sub

Sub updateX38()
    Dim value As Long
    If loadDone Then
    
        If dGetProxOffset(value) Then
            handleError ("dGetProxOffset: " & getError())
        Else
            hscrProxOffset.value = value: lblProxOffset.caption = value
        End If
        
        If dGetIRcomp(value) Then
            handleError ("dGetIRcomp: " & getError())
        Else
            hscrIRcomp.value = value: lblIRcomp.caption = value
        End If
                
    End If
End Sub

Public Sub update()
    If loadDone Then
        updateBoth
        If X28 Then
            updateX28
            If X38 Then updateX38
        Else
            updateX11
        End If
    End If
End Sub

Private Sub cbIntLogic_Click()
    
    Dim v As Long
    
    If cbIntLogic.value = vbChecked Then
        v = 1: cbIntLogic.caption = "IntLogic: AND"
    Else
        v = 0: cbIntLogic.caption = "IntLogic: OR"
    End If
    
    If dSetIntLogic(v) Then
        handleError ("cbIntLogic_Click: " & getError())
    End If
    
End Sub

Private Sub cbPoll_Click()
    If cbPoll.value = vbChecked Then
        cbPoll.caption = "Poll"
        tmrPoll.enabled = True
    Else
        cbPoll.caption = "nPoll"
        tmrPoll.enabled = False
    End If
End Sub

Private Sub cmbDevice_Click()
    Dim nChan As Long, t As Long, nIrdr As Long, irdrOffset As Long
    
    loadDone = False
    cmdConversionTime.caption = "Conv. = 0ms": DoEvents
    
    If dSetDevice(cmbDevice.ListIndex) Then
        handleError (getError())
    Else
        setI2cAddr gI2cAddr
        
        dGetPartNumber gPartNumber
        dGetPartFamily gPartFamily
        
        If gPartNumber = 29177 Then
            irdrOffset = 1000
            Me.dSetProxOffset irdrOffset
            Me.dGetProxOffset irdrOffset
            hscrProxOffset.max = irdrOffset
        End If
        
        If gPartNumber = 29125 Then
            cbPoll.enabled = False
        Else
            cbPoll.enabled = True
        End If

        If gPartFamily = 29038 Or gPartFamily = 29125 Then
            frmX38.Top = frmX38_Top
            frmX38.Visible = True
            If gPartFamily = 29125 Then
                fmProxOffset.Visible = False
                hscrIRcomp.max = 127
            End If
        Else
             frmX38.Visible = False
        End If
        
        If dGetNchannel(nChan) Then
            handleError ("cmbDevice_Click: " & getError())
        Else
            If nChan = 2 Then
                X28 = True
                If dGetNirdr(nIrdr) Then
                    handleError ("LoadIrdr: " & getError())
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
            
                frmX28.Top = frmX28_Top
                frmX11.Visible = False: frmX28.Visible = True
                
'                If X38 Then
'                    frmX38.Top = frmX38_Top: frmX38.Visible = True
'                Else
'                     frmX38.Visible = False
'                End If
            Else
                If gPartFamily = 29011 Then
                    frmX11.Top = frmX11_Top
                    frmX11.Visible = True: frmX28.Visible = False: frmX38.Visible = False
                End If
            End If
            
            If dGetConversionTime(0, t) Then
                handleError ("cmbDevice_Click: " & getError())
            Else
                cmdConversionTime.caption = "Conv. = " & t & "ms"
                loadDone = True
                gDevLoaded = False
                update
                gDevLoaded = True
            End If
            
        End If
        'loadDone = True
    End If
End Sub

Private Sub cbEnable_Click(Index As Integer)

    Dim v As Long
    
    If cbEnable(Index).value = vbChecked Then
        v = 0: cbEnable(Index).caption = "Disabled"
    Else
        v = 1: cbEnable(Index).caption = "Enabled"
    End If
    
    If dSetEnable(Index, v) Then
        handleError ("cbEnable_Click: " & getError())
    End If

End Sub

Private Sub cmbIntPersist_Click(Index As Integer)
Dim chan As Long: chan = Index
On Error GoTo subExit
    If dSetIntPersist(chan, cmbIntPersist(chan).ListIndex) Then Call handleError("cmbIntPersist_Click")
subExit:
End Sub

Private Sub cmbRange_Click()
On Error GoTo subExit
    If dSetRange(0, cmbRange.ListIndex) Then Call handleError("cmbRange_Click")
subExit:
End Sub

Private Sub cmbInputSelect_Click()
On Error GoTo subExit
    If dSetInputSelect(0, cmbInputSelect.ListIndex) Then Call handleError("cmbInputSelect_Click")
subExit:
End Sub

Private Sub cmbIrdr_Click()
On Error GoTo subExit
    If dSetIrdr(cmbIrdr.ListIndex) Then Call handleError("cmbIrdr_Click")
subExit:
End Sub

Private Sub cmbResolution_Click()
On Error GoTo subExit
    If dSetResolution(0, cmbResolution.ListIndex) Then Call handleError("cmbResolution_Click")
subExit:
End Sub

Private Sub cmbSleep_Click()
On Error GoTo subExit
    If dSetSleep(cmbSleep.ListIndex) Then Call handleError("cmbSleep_Click")
subExit:
End Sub

Private Sub cbIrdrFreq_Click()
    
    Dim v As Long
    
    If cbIrdrFreq.value = vbUnchecked Then
        v = 0: cbIrdrFreq.caption = "Freq: DC"
    Else
        v = 1: cbIrdrFreq.caption = "Freq: 360k"
    End If
    
    If dSetIrdrFreq(v) Then
        handleError ("cbIrdrFreq_Click: " & getError())
    End If
    
End Sub

Private Sub cbProxAmbRej_Click()
    
    Dim v As Long
    
    If cbProxAmbRej.value = vbChecked Then
        v = 0: cbProxAmbRej.caption = "AmbRej: OFF"
    Else
        v = 1: cbProxAmbRej.caption = "AmbRej: ON"
    End If
    
    If dSetProxAmbRej(v) Then
        handleError ("cbProxAmbRej_Click: " & getError())
    End If
    
End Sub

Private Sub cmdConversionTime_Click()
    Dim ct As Long
    cmdConversionTime.caption = "Conv. = " & ct & "ms"
    If dMeasureConversionTime(ct) Then
        handleError ("cmdConversionTime_Click: " & getError())
    Else
        cmdConversionTime.caption = "Conv. = " & ct & "ms"
    End If
End Sub

Private Sub hscrProxOffset_Change()
    Dim ignoreError As Boolean
    Dim value As Long: value = hscrProxOffset.value
    If value = 1000 Then ignoreError = True
    If dSetProxOffset(value) Then
        If Not ignoreError Then handleError ("hscrProxOffset_Change: " & getError())
    Else
        lblProxOffset.caption = value
    End If
End Sub

Private Sub hscrIRcomp_Change()
    If dSetIRcomp(hscrIRcomp.value) Then
        handleError ("hscrIRcomp_Change: " & getError())
    Else
        lblIRcomp.caption = hscrIRcomp.value
    End If
End Sub

Private Sub optAddr_Click(Index As Integer)
    If optAddr(Index).value And gHwnd Then
GoTo skip
        Select Case Index
            Case 1: gI2cAddr = &H88
            Case 2: gI2cAddr = &H8A
            Case 3: gI2cAddr = &H8C
            Case 4: gI2cAddr = &HA0
        End Select
skip:
        gDUTi2cAddr = "&H" & optAddr(Index).caption
        setI2cAddr gDUTi2cAddr
    End If
End Sub

Public Function getDUTi2c() As Long
    getDUTi2c = gDUTi2cAddr
End Function

Private Sub tmrPoll_Timer()
    update
End Sub

Private Sub UserControl_Initialize()
    Set ucJungoUsb1 = New ucJungoUsb
    Set ucHIDusb1 = New ucHIDUsb
    Set ADBUsb1 = New ADBUsb
    Set ucEmuUsb1 = New ucEmuUsb
    LoadDevice
    frmDevice.enabled = False
    
    frmDevice.Width = frmDevice_Width
    frmX11.Top = frmX11_Top
    frmX11.Left = frmDevice.Left
    frmX28.Top = frmX28_Top
    frmX28.Left = frmDevice.Left
    frmX38.Top = frmX38_Top
    frmX38.Left = frmDevice.Left
    Width = 1815
    'Height = 5640
    frmDevice.BorderStyle = 0
    fmBoth.BorderStyle = 0
    frmX11.BorderStyle = 0
    frmX28.BorderStyle = 0
    frmX38.BorderStyle = 0
    UserControl_InitializeDone = True
End Sub



Private Sub handleError(error As String)
    Static errorCount As Integer
    If errorCount < 5 Then MsgBox (error)
    errorCount = errorCount + 1
    'If errorCount >= 5 Then End
End Sub

Public Sub setHwnd(hWnd As Long)
    Dim i As Integer
    gHwnd = hWnd
    
    For i = 1 To nOptAddr
        optAddr(i).enabled = True
    Next i
    
End Sub

Public Sub setI2cAddr(ByVal i2cAddr As Long)
    Dim i As Integer
    Dim data(0) As Long: data(0) = i2cAddr
    
    If Not UserControl_InitializeDone Then UserControl_Initialize
    
    If (dSetDrvApi(AddressOf DllCallBack)) Then
        Call handleError("setI2cAddr")
    Else
        Set pUsb = getUsb(Me)
        Call DllCallBack(CBcmds.eWaddr, i2cAddr, data(0), 1): gI2cAddr = i2cAddr
        frmDevice.enabled = True
    End If
    
GoTo skip
    Select Case i2cAddr
    Case &H88: optAddr(1).value = True
    Case &H8A: optAddr(2).value = True
    Case &H8C: optAddr(3).value = True
    Case &HA0: optAddr(4).value = True
    End Select
skip:
    For i = 1 To nOptAddr
        If i2cAddr = "&H" & optAddr(i).caption Then optAddr(i).value = True
    Next i
    
End Sub

Public Function getI2cAddr() As Long
    getI2cAddr = gI2cAddr
End Function

Private Function testUsb(Main As ucALSusb) As Boolean
    Dim data(0) As Long: data(0) = 0
    testUsb = True
    Call DllCallBack(CBcmds.eRbyte, 0, data(0), 1)
    If Main.pUsb.noUsb Then
        testUsb = False
    ElseIf usbCaption <> "ADB" Then
        setI2CclkMult
    End If
End Function

Private Function getUsb(Main As ucALSusb) As Object
On Error GoTo tryADBUsb
    Set getUsb = ucHIDusb1: Set gUsb = getUsb: usbCaption = "HID"
    'getUsb.setHwnd (Me.hWnd)
    Set Main.pUsb = getUsb
    If testUsb(Main) Then GoTo exitGetUSB
tryADBUsb:
On Error GoTo tryjungo
    Set getUsb = ADBUsb1: Set gUsb = getUsb: usbCaption = "ADB"
    'getUsb.setHwnd (Me.hWnd)
    Set Main.pUsb = getUsb
    If testUsb(Main) Then GoTo exitGetUSB
tryjungo:     gNoUsb = False
    Set getUsb = ucJungoUsb1: Set gUsb = getUsb: usbCaption = "Jungo"
    getUsb.setHwnd (gHwnd)
    Set Main.pUsb = getUsb
    If testUsb(Main) Then GoTo exitGetUSB
emulation:
    Set getUsb = ucEmuUsb1: Set gUsb = getUsb: usbCaption = "Emulation"
    'getUsb.setHwnd (main.hWnd)
    Set Main.pUsb = getUsb
    If testUsb(Main) Then GoTo exitGetUSB
exitGetUSB:
    Set gUsb = getUsb
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
' +¯¯¯¯¯¯¯¯+

Public Sub script(value As String)
    Dim widget As String
    Dim error As Long
    Dim iVal As Long
        
    widget = lineArgs(value)
        
    Select Case widget
    Case "Address": iVal = "&H" & value: setI2cAddr (iVal)
    Case "Part": setDevice (value)
    Case "Range": setRange (value)
    Case "Irdr": setIrdr (value)
    Case "Sleep": setSleep (value)
    Case "EnableAls": iVal = value: error = dSetEnable(0, iVal)
    Case "EnableProx": iVal = value: error = dSetEnable(1, iVal)
    Case "Poll": iVal = value: cbPoll.value = value
    Case Else: MsgBox ("??Script: Als " & widget & " " & value)
    End Select
    
End Sub

Private Function lineArgs(line As String) As String
    Dim spacePos As Integer
    spacePos = InStr(line, " ")
    If (spacePos) Then
        lineArgs = Mid(line, 1, spacePos - 1)
        line = Mid(line, spacePos + 1, Len(line))
    End If
End Function

Private Function setCmb(cmb As ComboBox, value As String) As Boolean
    Dim i As Integer
    
    For i = 0 To cmb.ListCount
        If value = cmb.list(i) Then
            cmb.ListIndex = i
            i = cmb.ListCount
            setCmb = True
        End If
    Next i
    
    If Not setCmb Then MsgBox ("value=" & value & " not found")

End Function

Sub setDevice(value As String)
    If setCmb(cmbDevice, value) Then cmbDevice_Click
End Sub
Sub setRange(value As String)
    If setCmb(cmbRange, value) Then cmbRange_Click
End Sub
Sub setIrdr(value As String)
    If setCmb(cmbIrdr, value) Then cmbIrdr_Click
End Sub
Sub setSleep(value As String)
    If setCmb(cmbSleep, value) Then cmbSleep_Click
End Sub

Private Sub configureGPIO2pushPull()
    Dim BytesSucceed As Long
    Dim api_status As Long

    Call MemSet(0)
    Call reportID
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

Public Sub writeHIDuCportBit(ByVal port As Integer, ByVal bit As Integer, ByVal value As Integer)
    
    'JWG quick hack for Thao
    
    Dim BytesSucceed As Long
    Dim api_status As Long
    GoTo skip
    Static configDone As Boolean
    
    If Not configDone Then
        configureGPIO2pushPull
        configDone = True
    End If
skip:
    If 0 <= port And port <= 2 Then
        If 0 <= bit And bit <= 7 Then
            Call MemSet(0)
            Call reportID
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

Public Function readHIDuCportBit(ByVal port As Integer, ByVal bit As Integer) As Integer
    Dim BytesSucceed As Long
    Dim api_status As Long
    Dim Status As Integer
    Dim i As Integer
    
    If (1 <= port) And (port <= 2) And (0 <= bit) And (bit <= 7) Then
    
        Call readPurge
        
        Call MemSet(0)
        
        Call reportID
        IOBuf(1) = 3 'GP value
        IOBuf(2) = 1 'read
        IOBuf(3) = 0 'chkWeakPullUpEnableOnRead.value
        
        BytesSucceed = 0
        
        api_status = WriteFile(HIDhandle, IOBuf(0), REPORT_SIZE, BytesSucceed, 0)
        'endpoint in interrupt at uC occurs after this WriteFile call since the in data is ready and the host takes it; endpoint in interrupt does not occur after ReadFile call
        
        Status = checkStatus(api_status)
        'if WriteFile failed, then checkStatus would cause connect (and hence checkGPstate) to be called, and hence eliminate the need to do the following ReadFile
        
        If Status = GP_SUCCESS Then
            Call MemSet(0)
            
            BytesSucceed = 0
            
            api_status = ReadFile(ReadHandle, IOBuf(0), REPORT_SIZE, BytesSucceed, HIDOverlapped) 'this read should not happen if an error occured at writefile, since the read would have happened there; ' BytesSucceed is not reliable in overlapped IO
            
            api_status = WaitForSingleObject(EventObject, 6000)
            
            Call ResetEvent(EventObject)
            
            If (api_status <> WAIT_OBJECT_0) Then Call checkStatus(API_FAIL) 'status of WaitForSingleObject, but called ResetEvent before, since otherwise we would have to put two lines of code for it
        
        End If
        
        readHIDuCportBit = (IOBuf(port + 1) And 2 ^ bit) / 2 ^ bit
    
    End If
End Function

Public Sub setI2CclkMult(Optional clkMult As Integer = 1)
    Dim BytesSucceed As Long
    Dim api_status As Long
    Dim Status As Integer
    Dim i As Integer
    
    Call readPurge
    
    Call MemSet(0)
    
    Call reportID
    IOBuf(1) = 5 'I2C clock rate
    IOBuf(2) = 1 'read
    
    BytesSucceed = 0
    
    api_status = WriteFile(HIDhandle, IOBuf(0), REPORT_SIZE, BytesSucceed, 0)
    'endpoint in interrupt at uC occurs after this WriteFile call since the in data is ready and the host takes it; endpoint in interrupt does not occur after ReadFile call
    
    Status = checkStatus(api_status)
    'if WriteFile failed, then checkStatus would cause connect (and hence checkGPstate) to be called, and hence eliminate the need to do the following ReadFile
    
    If Status = GP_SUCCESS Then
        Call MemSet(0)
        
        BytesSucceed = 0
        
        api_status = ReadFile(ReadHandle, IOBuf(0), REPORT_SIZE, BytesSucceed, HIDOverlapped) 'this read should not happen if an error occured at writefile, since the read would have happened there; ' BytesSucceed is not reliable in overlapped IO
        
        api_status = WaitForSingleObject(EventObject, 6000)
        
        Call ResetEvent(EventObject)
        
        If (api_status <> WAIT_OBJECT_0) Then Call checkStatus(API_FAIL) 'status of WaitForSingleObject, but called ResetEvent before, since otherwise we would have to put two lines of code for it
    
    End If
        
    
    Call readPurge
    
    Call MemSet(0)
    
    Call reportID
    IOBuf(1) = 5 'I2C clock rate
    IOBuf(2) = 0 'write
    
    IOBuf(3) = 20 / clkMult ' normally 20
    
    BytesSucceed = 0
    
    api_status = WriteFile(HIDhandle, IOBuf(0), REPORT_SIZE, BytesSucceed, 0)
    'endpoint in interrupt at uC occurs after this WriteFile call since the in data is ready and the host takes it; endpoint in interrupt does not occur after ReadFile call
    
    Status = checkStatus(api_status)

End Sub

Public Function getEEpromObj() As clsEEprom

    If EEprom Is Nothing Then
        Set EEprom = New clsEEprom
        EEprom.setAlsDrv Me
    End If
    
    Set getEEpromObj = EEprom

End Function

