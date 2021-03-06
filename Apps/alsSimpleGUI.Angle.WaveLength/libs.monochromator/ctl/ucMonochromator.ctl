VERSION 5.00
Object = "{648A5603-2C6E-101B-82B6-000000000014}#1.1#0"; "MSCOMM32.OCX"
Begin VB.UserControl ucMonochromator 
   ClientHeight    =   6720
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   7965
   DrawMode        =   11  'Not Xor Pen
   ScaleHeight     =   6720
   ScaleWidth      =   7965
   Begin VB.CheckBox cbFWenable 
      Caption         =   "Disabled"
      Height          =   255
      Left            =   5760
      Style           =   1  'Graphical
      TabIndex        =   59
      Top             =   4080
      Width           =   975
   End
   Begin VB.Frame Frame1 
      Caption         =   "Chroma Meter"
      Height          =   1215
      Left            =   3240
      TabIndex        =   50
      Top             =   120
      Width           =   1335
      Begin VB.CheckBox cbCMrun 
         Caption         =   "Run"
         Height          =   255
         Left            =   60
         Style           =   1  'Graphical
         TabIndex        =   54
         Top             =   840
         Width           =   495
      End
      Begin VB.Timer tmrCM 
         Enabled         =   0   'False
         Interval        =   100
         Left            =   1440
         Top             =   240
      End
      Begin VB.CheckBox cbChromaEnable 
         Caption         =   "Disable"
         Height          =   255
         Left            =   120
         Style           =   1  'Graphical
         TabIndex        =   51
         Top             =   240
         Width           =   1095
      End
      Begin VB.Label lblMCcct 
         Alignment       =   1  'Right Justify
         Caption         =   "0000.0 K"
         Height          =   255
         Left            =   120
         TabIndex        =   53
         Top             =   840
         Width           =   1095
      End
      Begin VB.Label lblCMLux 
         Alignment       =   1  'Right Justify
         Caption         =   "00000.0 Lux"
         Height          =   255
         Left            =   120
         TabIndex        =   52
         Top             =   600
         Width           =   1095
      End
   End
   Begin VB.Frame fmPGDelay 
      Caption         =   "Pulse Generator: Width/Delay"
      Height          =   495
      Left            =   0
      TabIndex        =   46
      Top             =   6120
      Width           =   3135
      Begin VB.HScrollBar HScrPgWid 
         Height          =   135
         Left            =   120
         Max             =   40
         Min             =   1
         TabIndex        =   47
         Top             =   240
         Value           =   1
         Width           =   2535
      End
      Begin VB.Label lblPgWid 
         Alignment       =   1  'Right Justify
         Caption         =   "00"
         Height          =   255
         Left            =   2640
         TabIndex        =   48
         Top             =   180
         Width           =   375
      End
   End
   Begin VB.Frame fmFW 
      Caption         =   "#/Filter Wheels"
      Height          =   615
      Left            =   1320
      TabIndex        =   41
      Top             =   0
      Width           =   1215
      Begin VB.ComboBox cmbNfilterWheels 
         Height          =   315
         ItemData        =   "ucMonochromator.ctx":0000
         Left            =   120
         List            =   "ucMonochromator.ctx":0010
         TabIndex        =   60
         Text            =   "0"
         Top             =   240
         Width           =   975
      End
   End
   Begin VB.Frame fmGPIB 
      Caption         =   "GPIB"
      Height          =   615
      Left            =   0
      TabIndex        =   39
      Top             =   0
      Width           =   1215
      Begin VB.ComboBox cmbGPIB 
         Height          =   315
         ItemData        =   "ucMonochromator.ctx":0024
         Left            =   120
         List            =   "ucMonochromator.ctx":0034
         TabIndex        =   40
         Text            =   "None"
         Top             =   240
         Width           =   975
      End
   End
   Begin VB.Frame fmDPS 
      Caption         =   "DPS"
      Height          =   495
      Left            =   0
      TabIndex        =   38
      Top             =   5040
      Width           =   3135
      Begin VB.HScrollBar HScrDPS 
         Height          =   135
         LargeChange     =   100
         Left            =   120
         Max             =   25000
         Min             =   -25000
         TabIndex        =   44
         Top             =   240
         Value           =   -25000
         Width           =   2295
      End
      Begin VB.Label lblDPS 
         Alignment       =   1  'Right Justify
         Caption         =   "0.0000"
         Height          =   255
         Left            =   2520
         TabIndex        =   45
         Top             =   180
         Width           =   495
      End
   End
   Begin VB.Frame fmPG 
      Caption         =   "Pulse Generator: VIH"
      Height          =   495
      Left            =   0
      TabIndex        =   37
      Top             =   5640
      Width           =   3135
      Begin VB.HScrollBar HScrPgVih 
         Height          =   135
         LargeChange     =   10
         Left            =   120
         Max             =   800
         TabIndex        =   42
         Top             =   240
         Width           =   2535
      End
      Begin VB.Label lblPgVih 
         Alignment       =   1  'Right Justify
         Caption         =   "0.00"
         Height          =   255
         Left            =   2520
         TabIndex        =   43
         Top             =   180
         Width           =   495
      End
   End
   Begin MSCommLib.MSComm MSComm1 
      Index           =   0
      Left            =   5280
      Top             =   120
      _ExtentX        =   1005
      _ExtentY        =   1005
      _Version        =   393216
      CommPort        =   3
      DTREnable       =   -1  'True
      BaudRate        =   115200
   End
   Begin VB.Frame fmMonochromater 
      Caption         =   "Monochromater"
      Height          =   2175
      Left            =   0
      TabIndex        =   0
      Top             =   600
      Width           =   3135
      Begin VB.Frame fmParams 
         Caption         =   "Stop"
         Height          =   615
         Index           =   1
         Left            =   840
         TabIndex        =   7
         Top             =   240
         Width           =   735
         Begin VB.TextBox tbParams 
            Alignment       =   1  'Right Justify
            Height          =   285
            Index           =   1
            Left            =   120
            MultiLine       =   -1  'True
            TabIndex        =   8
            Text            =   "ucMonochromator.ctx":0050
            Top             =   240
            Width           =   495
         End
      End
      Begin VB.Frame fmParams 
         Caption         =   "Start"
         Height          =   615
         Index           =   0
         Left            =   120
         TabIndex        =   5
         Top             =   240
         Width           =   735
         Begin VB.TextBox tbParams 
            Alignment       =   1  'Right Justify
            Height          =   285
            Index           =   0
            Left            =   120
            MultiLine       =   -1  'True
            TabIndex        =   6
            Text            =   "ucMonochromator.ctx":0057
            Top             =   240
            Width           =   495
         End
      End
      Begin VB.Frame fmWaveLength 
         Height          =   1215
         Left            =   120
         TabIndex        =   1
         Top             =   840
         Width           =   2895
         Begin VB.TextBox tbWaveLength 
            Alignment       =   2  'Center
            Height          =   285
            Left            =   240
            MultiLine       =   -1  'True
            TabIndex        =   2
            Text            =   "ucMonochromator.ctx":005B
            Top             =   360
            Width           =   1215
         End
         Begin VB.PictureBox pbWavelength 
            Appearance      =   0  'Flat
            ForeColor       =   &H80000008&
            Height          =   855
            Left            =   120
            ScaleHeight     =   825
            ScaleWidth      =   2625
            TabIndex        =   3
            Top             =   240
            Width           =   2655
            Begin VB.HScrollBar sldrWaveLength 
               Height          =   375
               Left            =   0
               TabIndex        =   68
               Top             =   480
               Width           =   2535
            End
            Begin VB.Label lblOPM 
               Alignment       =   1  'Right Justify
               Height          =   255
               Left            =   1320
               TabIndex        =   12
               Top             =   120
               Width           =   1215
            End
         End
      End
      Begin VB.CheckBox cbEnable 
         Caption         =   "Arm"
         Height          =   375
         Left            =   2280
         Style           =   1  'Graphical
         TabIndex        =   4
         Top             =   480
         Width           =   735
      End
      Begin VB.CheckBox cbOn 
         Caption         =   "On"
         Height          =   375
         Left            =   2280
         Style           =   1  'Graphical
         TabIndex        =   11
         Top             =   120
         Width           =   735
      End
      Begin VB.Frame fmParams 
         Caption         =   "Step"
         Height          =   615
         Index           =   2
         Left            =   1560
         TabIndex        =   9
         Top             =   240
         Width           =   735
         Begin VB.TextBox tbParams 
            Alignment       =   1  'Right Justify
            Height          =   285
            Index           =   2
            Left            =   120
            MultiLine       =   -1  'True
            TabIndex        =   10
            Text            =   "ucMonochromator.ctx":0061
            Top             =   240
            Width           =   495
         End
      End
   End
   Begin MSCommLib.MSComm MSComm1 
      Index           =   1
      Left            =   5280
      Top             =   720
      _ExtentX        =   1005
      _ExtentY        =   1005
      _Version        =   393216
      CommPort        =   2
      DTREnable       =   -1  'True
      BaudRate        =   115200
   End
   Begin MSCommLib.MSComm MSComm1 
      Index           =   2
      Left            =   5280
      Top             =   1320
      _ExtentX        =   1005
      _ExtentY        =   1005
      _Version        =   393216
      CommPort        =   4
      DTREnable       =   -1  'True
      Handshaking     =   1
      InputLen        =   29
      RThreshold      =   29
      RTSEnable       =   -1  'True
      DataBits        =   7
   End
   Begin VB.Frame fmFilterWheels 
      Caption         =   "Filter Wheels"
      Enabled         =   0   'False
      Height          =   2175
      Left            =   0
      TabIndex        =   13
      Top             =   2760
      Width           =   3855
      Begin VB.Frame fmWheel 
         Caption         =   "FW2"
         Enabled         =   0   'False
         Height          =   1815
         Index           =   2
         Left            =   1560
         TabIndex        =   61
         Top             =   240
         Width           =   615
         Begin VB.OptionButton opFw 
            Caption         =   "6"
            Height          =   255
            Index           =   17
            Left            =   120
            TabIndex        =   67
            Top             =   1440
            Width           =   375
         End
         Begin VB.OptionButton opFw 
            Caption         =   "5"
            Height          =   255
            Index           =   16
            Left            =   120
            TabIndex        =   66
            Top             =   1200
            Width           =   375
         End
         Begin VB.OptionButton opFw 
            Caption         =   "4"
            Height          =   255
            Index           =   15
            Left            =   120
            TabIndex        =   65
            Top             =   960
            Width           =   375
         End
         Begin VB.OptionButton opFw 
            Caption         =   "3"
            Height          =   255
            Index           =   14
            Left            =   120
            TabIndex        =   64
            Top             =   720
            Width           =   375
         End
         Begin VB.OptionButton opFw 
            Caption         =   "2"
            Height          =   255
            Index           =   13
            Left            =   120
            TabIndex        =   63
            Top             =   480
            Width           =   375
         End
         Begin VB.OptionButton opFw 
            Caption         =   "1"
            Height          =   255
            Index           =   12
            Left            =   120
            TabIndex        =   62
            Top             =   240
            Value           =   -1  'True
            Width           =   375
         End
      End
      Begin VB.TextBox tbLux 
         Height          =   315
         Left            =   2640
         MultiLine       =   -1  'True
         TabIndex        =   32
         Text            =   "ucMonochromator.ctx":0065
         Top             =   720
         Width           =   855
      End
      Begin VB.ComboBox cmbLux 
         Height          =   315
         ItemData        =   "ucMonochromator.ctx":006E
         Left            =   2640
         List            =   "ucMonochromator.ctx":00DE
         TabIndex        =   31
         Text            =   "20000.00"
         Top             =   720
         Width           =   1095
      End
      Begin VB.VScrollBar vscrFwIndex 
         Height          =   1815
         Left            =   2280
         Max             =   35
         TabIndex        =   29
         Top             =   240
         Width           =   255
      End
      Begin VB.Frame fmWheel 
         Caption         =   "FW1"
         Height          =   1815
         Index           =   1
         Left            =   840
         TabIndex        =   21
         Top             =   240
         Width           =   615
         Begin VB.OptionButton opFw 
            Caption         =   "1"
            Height          =   255
            Index           =   6
            Left            =   120
            TabIndex        =   27
            Top             =   240
            Value           =   -1  'True
            Width           =   375
         End
         Begin VB.OptionButton opFw 
            Caption         =   "2"
            Height          =   255
            Index           =   7
            Left            =   120
            TabIndex        =   26
            Top             =   480
            Width           =   375
         End
         Begin VB.OptionButton opFw 
            Caption         =   "3"
            Height          =   255
            Index           =   8
            Left            =   120
            TabIndex        =   25
            Top             =   720
            Width           =   375
         End
         Begin VB.OptionButton opFw 
            Caption         =   "4"
            Height          =   255
            Index           =   9
            Left            =   120
            TabIndex        =   24
            Top             =   960
            Width           =   375
         End
         Begin VB.OptionButton opFw 
            Caption         =   "5"
            Height          =   255
            Index           =   10
            Left            =   120
            TabIndex        =   23
            Top             =   1200
            Width           =   375
         End
         Begin VB.OptionButton opFw 
            Caption         =   "6"
            Height          =   255
            Index           =   11
            Left            =   120
            TabIndex        =   22
            Top             =   1440
            Width           =   375
         End
      End
      Begin VB.Frame fmWheel 
         Caption         =   "FW0"
         Height          =   1815
         Index           =   0
         Left            =   120
         TabIndex        =   14
         Top             =   240
         Width           =   615
         Begin VB.OptionButton opFw 
            Caption         =   "6"
            Height          =   255
            Index           =   5
            Left            =   120
            TabIndex        =   20
            Top             =   1440
            Width           =   375
         End
         Begin VB.OptionButton opFw 
            Caption         =   "5"
            Height          =   255
            Index           =   4
            Left            =   120
            TabIndex        =   19
            Top             =   1200
            Width           =   375
         End
         Begin VB.OptionButton opFw 
            Caption         =   "4"
            Height          =   255
            Index           =   3
            Left            =   120
            TabIndex        =   18
            Top             =   960
            Width           =   375
         End
         Begin VB.OptionButton opFw 
            Caption         =   "3"
            Height          =   255
            Index           =   2
            Left            =   120
            TabIndex        =   17
            Top             =   720
            Width           =   375
         End
         Begin VB.OptionButton opFw 
            Caption         =   "2"
            Height          =   255
            Index           =   1
            Left            =   120
            TabIndex        =   16
            Top             =   480
            Width           =   375
         End
         Begin VB.OptionButton opFw 
            Caption         =   "1"
            Height          =   255
            Index           =   0
            Left            =   120
            TabIndex        =   15
            Top             =   240
            Value           =   -1  'True
            Width           =   375
         End
      End
      Begin VB.Label lblNd 
         Caption         =   "ND:0"
         Height          =   255
         Left            =   2640
         TabIndex        =   30
         Top             =   480
         Width           =   1095
      End
      Begin VB.Label lblFwIndex 
         Caption         =   "0"
         Height          =   255
         Left            =   2640
         TabIndex        =   28
         Top             =   240
         Width           =   255
      End
   End
   Begin MSCommLib.MSComm MSComm1 
      Index           =   3
      Left            =   5280
      Top             =   1920
      _ExtentX        =   1005
      _ExtentY        =   1005
      _Version        =   393216
      CommPort        =   6
      DTREnable       =   -1  'True
      InputLen        =   29
      ParityReplace   =   0
      RThreshold      =   29
      RTSEnable       =   -1  'True
      BaudRate        =   115200
   End
   Begin MSCommLib.MSComm MSComm1 
      Index           =   4
      Left            =   5280
      Top             =   2520
      _ExtentX        =   1005
      _ExtentY        =   1005
      _Version        =   393216
      CommPort        =   7
      DTREnable       =   -1  'True
      InputLen        =   29
      ParityReplace   =   0
      RThreshold      =   29
      RTSEnable       =   -1  'True
      BaudRate        =   115200
   End
   Begin VB.Frame Frame2 
      Caption         =   "Lux Meter"
      Height          =   1215
      Left            =   3240
      TabIndex        =   55
      Top             =   1320
      Width           =   1335
      Begin VB.Timer tmrLM 
         Enabled         =   0   'False
         Interval        =   100
         Left            =   1440
         Top             =   240
      End
      Begin VB.CheckBox cbLMrun 
         Caption         =   "Run"
         Height          =   255
         Left            =   60
         Style           =   1  'Graphical
         TabIndex        =   58
         Top             =   840
         Visible         =   0   'False
         Width           =   495
      End
      Begin VB.CheckBox cbLuxEnable 
         Caption         =   "Enable"
         Height          =   255
         Left            =   120
         Style           =   1  'Graphical
         TabIndex        =   56
         Top             =   240
         Width           =   1095
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "00000.0 Lux"
         Height          =   255
         Left            =   120
         TabIndex        =   57
         Top             =   600
         Width           =   1095
      End
   End
   Begin VB.Label lblComm 
      Caption         =   "Chroma Meter COM7"
      Height          =   255
      Index           =   4
      Left            =   6000
      TabIndex        =   49
      Top             =   2520
      Width           =   1815
   End
   Begin VB.Label lblComm 
      Caption         =   "Prologix COM6"
      Height          =   255
      Index           =   3
      Left            =   6000
      TabIndex        =   36
      Top             =   1920
      Width           =   1815
   End
   Begin VB.Label lblComm 
      Caption         =   "Luxmeter COM4"
      Height          =   255
      Index           =   2
      Left            =   6000
      TabIndex        =   35
      Top             =   1320
      Width           =   1815
   End
   Begin VB.Label lblComm 
      Caption         =   "FW1 COM2 Back High"
      Height          =   255
      Index           =   1
      Left            =   6000
      TabIndex        =   34
      Top             =   720
      Width           =   1815
   End
   Begin VB.Label lblComm 
      Caption         =   "FW0 COM3 Front Low"
      Height          =   255
      Index           =   0
      Left            =   6000
      TabIndex        =   33
      Top             =   240
      Width           =   1815
   End
End
Attribute VB_Name = "ucMonochromator"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Dim gpib As clsGPIB

Dim m_rm As IResourceManager ' VISA, single instance

' NI/HP GPIB Switch
'Dim m_msg As Object ' monochromator
Dim m_opm As Object ' Optical Power Meter
Dim m_vi As Object ' Keithley 2400 SourceMeter
Dim m_vi3631 As Object ' HP 3631 Power Supply

' NIGPIB
Dim m_msg As IMessage ' monochromator
'Dim m_opm As IMessage ' Optical Power Meter
'Dim m_vi As IMessage ' Keithley 2400 SourceMeter
'Dim m_vi3631 As IMessage ' HP 3631 Power Supply

' HPGPIB
'Dim m_msg As VisaComLib.FormattedIO488   ' monochromator
'Dim m_opm As VisaComLib.FormattedIO488 ' Optical Power Meter
'Dim m_vi As VisaComLib.FormattedIO488 ' Keithley 2400 SourceMeter
'Dim m_vi3631 As VisaComLib.FormattedIO488 ' HP 3631 Power Supply

Dim m_TLopm As IMessage

Const gGPIBaddr As Integer = 4
Const gGPIBaddrVI As Integer = 18
Const gGPIBaddr3631 As Integer = 20
Const gGPIBaddrPG As Integer = 26
Const gTLopmStr As String = "USB0::0x1313::0x8072::P2000042::INSTR"
Const gTLopmStr1 As String = "USB0::0x1313::0x8072::P2001137::INSTR"

Dim m_FVmode As Boolean
Dim m_fv As Double, m_fi As Double

Dim gUsingHPIB As Boolean
Dim gUsingFW As Boolean

Dim gOpmDetected As Boolean
Dim gTLopmDetected As Boolean
Dim gMonoDetected As Boolean
Dim gViDetected As Boolean
Dim gVi3631Detected As Boolean
Dim gPgDetected As Boolean
Dim gFwDetected As Boolean

Dim gWaveLength As Single
Const m_dprintGpib As Boolean = True

Dim gLoopEnabled As Boolean
Dim gLoopCount As Integer

Enum wlParams
    eStart
    eStop
    eStep
End Enum



Dim params(2) As Single

Dim fw2idx(5, 5, 5) As Integer
Dim idx2fw(215, 2) As Integer
Dim fwAttn(215) As Double
Dim gFwPos(2) As Long
Dim gFwIdx As Integer
Dim gFwAttn As Double
Dim gFwChange As Boolean
Dim nFilterWheels As Integer
Dim gLuxMax As Double

Const debugPrint_ As Boolean = False

Private Declare Sub Sleep Lib "kernel32" (ByVal dwMilliseconds As Long)

'Event Declarations:
Event Click() 'MappingInfo=cbOn,cbOn,-1,Click

' Interfaces
Public pOPM As clsPowerMeter
Public pLM As clsLuxMeter
Public pCM As clsChromaMeter
Public pDVM As clsDVM

Public Function sId() As String
    sId = "ucMonochromator"
End Function

Private Sub cbChromaEnable_Click()

    If cbChromaEnable.value = vbChecked Then
        cbChromaEnable.caption = "Enabled"
        cbCMrun.Visible = True
    Else
        cbChromaEnable.caption = "Disabled"
        cbCMrun.value = vbChecked
        cbCMrun.Visible = False
    End If
    
    cbCMrun_Click
    
End Sub

Private Sub cbCMrun_Click()
    
    If cbCMrun.value = vbChecked Then
        cbCMrun.caption = "Off"
        tmrCM.enabled = False
    Else
        cbCMrun.caption = "Run"
        tmrCM.enabled = True
    End If

End Sub

Private Sub tmrCM_Timer()

    Dim cct As Single, lux As Single
    GetCCTlux cct, lux
    lblCMLux.caption = format(lux, "0.0") & " Lux"
    lblMCcct.caption = format(cct, "0.0") & " K"
    
End Sub

Private Sub cbLuxEnable_Click()
    
    If cbLuxEnable.value = vbChecked Then
        cbLuxEnable.caption = "Enabled"
        cbLMrun.Visible = True
    Else
        cbLuxEnable.caption = "Disabled"
        cbLMrun.value = vbChecked
        cbLMrun.Visible = False
    End If
    
    cbLMrun_Click
    
End Sub

Private Sub cbLMrun_Click()
    
    If cbLMrun.value = vbChecked Then
        cbLMrun.caption = "Off"
        tmrLM.enabled = False
    Else
        cbLMrun.caption = "Run"
        tmrLM.enabled = True
    End If

End Sub

Private Sub tmrLM_Timer()

    Dim lux As Single
    lux = getLux
    lblLux.caption = format(lux, "0.0") & " Lux"
    
End Sub

Private Sub UserControl_Initialize()

    Set pOPM = New clsPowerMeter
    Set pLM = New clsLuxMeter
    Set pCM = New clsChromaMeter
    Set pDVM = New clsDVM
    
    ChromaMeterCom.init = False

End Sub

Private Sub GPIB_Initialize()
    Dim v As Double, a As Double
    Set m_rm = CreateObject("VISA.GlobalRM")
    
    'gUsingHPIB = False
    
    On Error GoTo mono
    
    ' HP8116A PG
    If gpib.GPIBopen(gGPIBaddrPG, pg) Then
        gPgDetected = True
        If 0 Then ' test
            gPgDetected = False
            End
        End If
    End If
    
mono: On Error GoTo opm
    
    ' monochromator
    If gpib.GPIBopen(gGPIBaddr, mc) Then
        gMonoDetected = True
        If getValue = 0 Then ' test
            gMonoDetected = False
            fmWaveLength.BackColor = vbRed
            gWaveLength = 550
        Else
            fmWaveLength.BackColor = vbGreen
        End If
    End If
    
opm: On Error GoTo tlopm:
    
    If gpib.GPIBopen(gGPIBaddr + 1, OM) Then
        gOpmDetected = True
        If getPower = 0 Then ' test
            gOpmDetected = False
        Else
            Call gpib.GPIBwrite("*CLS", OM)
            Call gpib.GPIBwrite("TIME 10", OM)
            Call gpib.GPIBread("TIME?", OM)
            Call gpib.GPIBwrite("PWON", OM)
            Call gpib.GPIBwrite("FLON", OM)
            Call gpib.GPIBwrite("LINE", OM)
        End If
    End If
    
tlopm: On Error GoTo tlopm1
    
    ' Optical power meter (Thorlabs)
    Set m_TLopm = m_rm.Open(gTLopmStr)
    gTLopmDetected = True
    GoTo testIDN
tlopm1:
    On Error GoTo vi
    'Set m_TLopm = m_rm.Open(gTLopmStr1)
testIDN:
    'm_TLopm.WriteString ("*IDN?")
    'If 33 = Len(m_TLopm.ReadString(100)) Then gTLopmDetected = True

vi: On Error GoTo hpvi: 'GoTo hpvi
    
    ' Keithley 2400 SourceMeter
    
    If gpib.GPIBopen(gGPIBaddrVI, vi) Then
        gViDetected = True
        setVolts (0#) ' test
        Call readVI(v, a)
        If (v = 0) And (a = 0) Then
            gViDetected = False
        Else ' set defaults
        End If
    End If
    
hpvi: On Error GoTo noGpib
    
    ' HP 3631 Power Supply
    If gpib.GPIBopen(gGPIBaddr3631, VI3631) Then
        gVi3631Detected = True
        'Call gpib.GPIBwrite("*RST", VI3631)
        Call setVolts(0#, VI3631)
        Call readVI(v, a, VI3631)
        If (v = 0) And (a = 0) Then ' test
            gVi3631Detected = False
        End If
    End If

noGpib:
End Sub


Private Sub cbOn_Click()
    RaiseEvent Click
    If cbOn.value = vbChecked Then
        If gMonoDetected Then gpib.GPIBwrite "SHUTTER C", mc
        cbOn.caption = "Off"
    Else
        cbOn.caption = "On"
        If gMonoDetected Then gpib.GPIBwrite "SHUTTER O", mc
    End If
End Sub

Private Sub tbParams_Change(Index As Integer)
    Dim param As Single
    On Error GoTo errorExit
    If enterText(tbParams(Index).text) Then
        param = tbParams(Index).text
        params(Index) = param
        tbParams(Index).text = param
    End If
    GoTo successExit
errorExit:
    tbParams(Index).text = params(Index)
successExit:
End Sub

Private Sub NIGPIB_Initialize()
    Dim v As Double, a As Double
    Set m_rm = CreateObject("VISA.GlobalRM")
    
    gUsingHPIB = False
    
    On Error GoTo noGpib
    
    ' monochromator
    If gpib.GPIBopen(gGPIBaddr, mc) Then
        gMonoDetected = True
        If getValue = 0 Then ' test
            gMonoDetected = False
            fmWaveLength.BackColor = vbRed
            gWaveLength = 550
        End If
    End If
    
    ' Optical power meter (Newport)
    'Set m_opm = m_rm.Open("GPIB0::" & gGPIBaddr + 1 & "::INSTR")
    'm_opm.TerminationCharacter = m_msg.TerminationCharacter
    'm_opm.TerminationCharacterEnabled = m_msg.TerminationCharacterEnabled
    If gpib.GPIBopen(gGPIBaddr + 1, OM) Then
        gOpmDetected = True
        If getPower = 0 Then ' test
            gOpmDetected = False
        Else
            Call gpib.GPIBwrite("*CLS", OM)
            Call gpib.GPIBwrite("TIME 10", OM)
            Call gpib.GPIBread("TIME?", OM)
            Call gpib.GPIBwrite("PWON", OM)
            Call gpib.GPIBwrite("FLON", OM)
            Call gpib.GPIBwrite("LINE", OM)
        End If
    End If
    
    ' Keithley 2400 SourceMeter
    Set m_vi = m_rm.Open("GPIB0::" & gGPIBaddrVI & "::INSTR")
    'm_vi.TerminationCharacter = m_msg.TerminationCharacter
    'm_vi.TerminationCharacterEnabled = m_msg.TerminationCharacterEnabled
    gViDetected = True
    setVolts (0#)
    Call readVI(v, a)
    If (v = 0) And (a = 0) Then ' test
        gViDetected = False
    End If

    ' HP 3631 Power Supply
    Set m_vi3631 = m_rm.Open("GPIB0::" & gGPIBaddr3631 & "::INSTR")
    'm_vi.TerminationCharacter = m_msg.TerminationCharacter
    'm_vi.TerminationCharacterEnabled = m_msg.TerminationCharacterEnabled
    gVi3631Detected = True
    Call gpib.GPIBwrite("*RST", VI3631)
    Call setVolts(0#, VI3631)
    Call readVI(v, a, VI3631)
    If (v = 0) And (a = 0) Then ' test
        gVi3631Detected = False
    End If

noGpib:
End Sub

Private Sub HPIB_Initialize()
    Dim v As Double, a As Double
    Set m_rm = New VisaComLib.ResourceManager
    
    gUsingHPIB = True
    
    On Error GoTo opm
    
    ' monochromator
    Set m_msg = New VisaComLib.FormattedIO488
    'Set m_msg.IO = m_rm.Open("GPIB::" & gGPIBaddr)
    'm_msg.TerminationCharacter = 10
    'm_msg.TerminationCharacterEnabled = True
    gMonoDetected = True
    If getValue = 0 Then ' test
        gMonoDetected = False
        fmWaveLength.BackColor = vbRed
        gWaveLength = 550
    End If
    
opm: On Error GoTo vi: 'GoTo tlopm
    
    ' Optical power meter (Newport)
    Set m_opm = New VisaComLib.FormattedIO488
    Set m_opm.IO = m_rm.Open("GPIB0::" & gGPIBaddr + 1 & "::INSTR")
    'm_opm.TerminationCharacter = m_msg.TerminationCharacter
    'm_opm.TerminationCharacterEnabled = m_msg.TerminationCharacterEnabled
    gOpmDetected = True
    If getPower = 0 Then ' test
        gOpmDetected = False
    Else
        'Call GPIBwrite("*CLS", OM)
        'Call GPIBwrite("TIME 10", OM)
        'Call GPIBread("TIME?", OM)
        'Call GPIBwrite("PWON", OM)
        'Call GPIBwrite("FLON", OM)
        'Call GPIBwrite("LINE", OM)
    End If
    
tlopm: On Error GoTo vi: GoTo vi
    
    ' Optical power meter (Thorlabs)
    Set m_TLopm = m_rm.Open(gTLopmStr)
    m_TLopm.WriteString ("*IDN?")
    If 33 = Len(m_TLopm.ReadString(100)) Then gTLopmDetected = True

vi: On Error GoTo noGpib
    
    ' Keithley 2400 SourceMeter
    Set m_vi = New VisaComLib.FormattedIO488
    Set m_vi.IO = m_rm.Open("GPIB::" & gGPIBaddrVI & "::INSTR")
    'm_vi.TerminationCharacter = m_msg.TerminationCharacter
    'm_vi.TerminationCharacterEnabled = m_msg.TerminationCharacterEnabled
    gViDetected = True
    Call readVI(v, a)
    If (v = 0) And (a = 0) Then ' test
        gViDetected = False
    End If

noGpib:
End Sub

Private Sub cmbGPIB_Click()

    Set gpib = New clsGPIB

    Select Case cmbGPIB.ListIndex
        Case 1, 2: gpib.GPIBinitSelect cmbGPIB.ListIndex
        Case 3: Call gpib.GPIBinitSelect(cmbGPIB.ListIndex, MSComm1(comDev.Prologix))
    End Select
    
    If cmbGPIB.ListIndex Then
    
        GPIB_Initialize
        
        tbWaveLength.text = getValue
        sldrWaveLength.value = tbWaveLength.text
        
        params(wlParams.eStart) = tbParams(wlParams.eStart).text
        params(wlParams.eStop) = tbParams(wlParams.eStop).text
        params(wlParams.eStep) = tbParams(wlParams.eStep).text
    End If
    
End Sub












Private Sub cmbNfilterWheels_Click()
    nFilterWheels = cmbNfilterWheels.ListIndex
    If nFilterWheels Then
        EnableFW = True
        gLuxMax = 10000: loadFwTables
    Else
        fmFilterWheels.enabled = False
    End If
End Sub

Private Sub cbFWenable_Click()
    If cbFWenable.value = vbChecked Then
        cbFWenable.caption = "Enabled"
        EnableFW = True
        gLuxMax = 15280: loadFwTables
    Else
        cbFWenable.caption = "disabled"
        fmFilterWheels.enabled = False
    End If
End Sub











Private Sub setPanelEnable(enable As Boolean)
    fmWaveLength.enabled = enable
    fmParams(0).enabled = enable
    fmParams(1).enabled = enable
    fmParams(2).enabled = enable
    gLoopEnabled = Not enable
End Sub



Private Sub cbEnable_Click()
    If cbEnable.value = vbChecked Then
        gLoopCount = 0
        cbEnable.caption = "Halt"
        startSweep
    Else
        setPanelEnable (True)
        cbEnable.caption = "Arm"
    End If
End Sub

Private Sub UserControl_Terminate()
    'If gMonoDetected Then m_msg.Close
    'If gOpmDetected Then m_opm.Close
End Sub

Private Sub GPIBwrite_(msg As String, i As instr)
    On Error GoTo errorExit
    Select Case i
    Case mc: If gMonoDetected Then m_msg.WriteString msg & Chr$(10)
    Case OM: If gOpmDetected Then m_opm.WriteString msg & Chr$(10)
    Case vi: If gViDetected Then m_vi.WriteString msg & Chr$(10)
    Case VI3631: If gVi3631Detected Then m_vi3631.WriteString msg & Chr$(10)
    End Select
errorExit:
    If m_dprintGpib Then debugPrint msg
End Sub

Private Function GPIBread_(msg As String, i As instr) As String
    On Error GoTo errorExit
    If msg <> "" Then Call GPIBwrite_(msg, i)
    
    If gUsingHPIB Then
    
        Select Case i
        'Case MC: If gMonoDetected Then GPIBread = m_msg.ReadString '(1000)
        'Case OM: If gOpmDetected Then GPIBread = m_opm.ReadString '(1000)
        'Case vi: If gViDetected Then GPIBread = m_vi.ReadString '(1000)
        'Case VI3631: If gVi3631Detected Then GPIBread = m_vi3631.ReadString '(1000)
        End Select
    
    Else
    
        Select Case i
        'Case MC: If gMonoDetected Then GPIBread = m_msg.ReadString '(1000)
        'Case OM: If gOpmDetected Then GPIBread = m_opm.ReadString '(1000)
        'Case vi: If gViDetected Then GPIBread = m_vi.ReadString '(1000)
        'Case VI3631: If gVi3631Detected Then GPIBread = m_vi3631.ReadString '(1000)
        End Select
    
    End If
    
    If m_dprintGpib Then debugPrint msg
    'If m_dprintGpib Then debugPrint GPIBread
errorExit:
End Function

Private Sub setRGB(wavelength As Single)
    Dim wl As Integer: wl = wavelength
    Dim R As Single, G As Single, B As Single
    Dim hi As Single, lo As Single
    Dim gain As Single: gain = 1#
    Dim Gamma As Single: Gamma = 0.8
    
    'On Error GoTo exitSub
    
    lo = 350: hi = 440: If (lo <= wl) And (wl < hi) Then R = -1# * (wl - hi) / (hi - lo): G = 0: B = 1
    lo = hi: hi = 490: If (lo <= wl) And (wl < hi) Then R = 0: G = 1# * (wl - lo) / (hi - lo): B = 1
    lo = hi: hi = 510: If (lo <= wl) And (wl < hi) Then R = 0: G = 1: B = -1# * (wl - hi) / (hi - lo)
    lo = hi: hi = 580: If (lo <= wl) And (wl < hi) Then R = 1# * (wl - lo) / (hi - lo): G = 1: B = 0
    lo = hi: hi = 645: If (lo <= wl) And (wl < hi) Then R = 1: G = -1# * (wl - hi) / (hi - lo): B = 0
    lo = hi: hi = 780: If (lo <= wl) And (wl < hi) Then R = 1: G = 0: B = 0
        
    If wl < 350 Then gain = 0#
    If (350 <= wl) And (wl < 420) Then gain = 0.3 + 0.7 * (wl - 350#) / (420# - 350#)
    If (700 <= wl) And (wl < 780) Then gain = 0.3 + 0.7 * (780# - wl) / (780# - 700#)
    If 780 < wl Then gain = 0#
    
    'gain = 255 * gain
    
    R = (gain * R) ^ Gamma: G = (gain * G) ^ Gamma: B = (gain * B) ^ Gamma
    R = Int(255 * R): G = Int(255 * G): B = Int(255 * B)
    
    pbWavelength.BackColor = R * &H1 + G * &H100 + B * &H10000
exitSub:
End Sub




'_______________________
' === Public Methods ===
'_______________________

Public Function getStart() As Single: getStart = params(wlParams.eStart): End Function
Public Sub setStart(value As Single)
    params(wlParams.eStart) = value
    tbParams(wlParams.eStart).text = value
    If m_dprintGpib Then debugPrint "START"
End Sub

Public Function getStop() As Single: getStop = params(wlParams.eStop): End Function
Public Sub setStop(value As Single): params(wlParams.eStop) = value: tbParams(wlParams.eStop).text = value: End Sub

Public Function getStep() As Single: getStep = params(wlParams.eStep): End Function
Public Sub setStep(value As Single): params(wlParams.eStep) = value: tbParams(wlParams.eStep).text = value: End Sub





Private Sub sldrWaveLength_MouseUp(Button As Integer, shift As Integer, x As Single, y As Single)
    tbWaveLength.text = sldrWaveLength.value & Chr$(13)
End Sub

Private Sub sldrWaveLength_Change()
    tbWaveLength.text = sldrWaveLength.value ' & Chr$(13) JWG broken for now
End Sub

Private Sub sldrWaveLength_MouseMove(Button As Integer, shift As Integer, x As Single, y As Single)
    tbWaveLength.text = sldrWaveLength.value: setRGB (tbWaveLength.text)
End Sub

Private Sub tbWaveLength_Change()
    Static lastSet As Integer
    Dim wavelength As Integer
    
    On Error GoTo errorExit
    If enterText(tbWaveLength.text) Then
    
        wavelength = tbWaveLength.text
        
        If lastSet <> wavelength Then
            setValue wavelength
            lastSet = wavelength
            gWaveLength = getValue
        End If
        
errorExit:
        tbWaveLength.text = gWaveLength
        sldrWaveLength.value = gWaveLength
    End If
End Sub

Public Sub setValue(ByVal wl As Integer)
    Dim i As Integer: Const wait As Integer = 300
    Static lastValue As Integer
    
    If wl <> lastValue Then
        If wl < 300 Then
            wl = 300
        Else
            If wl > 1100 Then
                wl = 1100
            End If
        End If
        
        If debugPrint_ Then debugPrint "setValue=" & wl
        
        If gOpmDetected Then
            Call gpib.GPIBwrite("WAVE " & wl, OM)
        Else
            If gTLopmDetected Then
                If wl > 410 Then
                    m_TLopm.WriteString ("CORR:WAV " & wl)
                Else
                    m_TLopm.WriteString ("CORR:WAV 410")
                End If
            End If
        End If
        
        If gMonoDetected Then
            Call gpib.GPIBwrite("GOWAVE " & wl, mc)
        End If
        gWaveLength = wl
        
        If gMonoDetected And (gOpmDetected Or gTLopmDetected) Then
            For i = 1 To wait / 20
                Sleep (20): DoEvents
            Next i
        End If
        
        lastValue = wl
        
        sldrWaveLength.value = lastValue
        
    End If
    
End Sub

Public Function getValue() As Integer
    Dim valStr As String, valInt As Integer
    On Error GoTo errorExit
    
    If gMonoDetected And gWaveLength = 0 Then
        valStr = gpib.GPIBread("WAVE?", mc)
        valInt = val(valStr)
        getValue = valInt
        gWaveLength = getValue
    Else
        getValue = gWaveLength
    End If
    
    If debugPrint_ Then debugPrint "getValue=" & getValue
    
    'sldrWaveLength.value = getValue
    setRGB (getValue)
errorExit:
End Function

Public Function getPower() As Single
    On Error GoTo errorExit
    If gOpmDetected Then
        getPower = gpib.GPIBread("DATA?", OM)
    Else
        If gTLopmDetected Then
            m_TLopm.WriteString ("READ?")
            getPower = m_TLopm.ReadString(100)
        Else
            getPower = gWaveLength * 0.000000001
        End If
    End If
    lblOPM.caption = getPower & "W  "
errorExit:
End Function

Public Function getIndex() As Integer: getIndex = gLoopCount: End Function
Public Sub setIndex(value As Single): gLoopCount = value: End Sub

Public Sub arm(): startSweep: End Sub
Public Sub startSweep()
    If m_dprintGpib Then debugPrint "START"
    setPanelEnable (False)
    setValue params(wlParams.eStart)
    gLoopCount = (params(wlParams.eStop) - params(wlParams.eStart)) / params(wlParams.eStep)
End Sub
Public Sub stopSweep(): cbEnable.value = vbUnchecked: cbEnable_Click: End Sub

Public Function done() As Boolean: done = Not gLoopEnabled: End Function

Public Sub nextStep()
    If gLoopEnabled Then
        If gLoopCount Then
            If m_dprintGpib Then debugPrint "NEXT"
            gLoopCount = gLoopCount - 1
            setValue params(wlParams.eStop) - gLoopCount * params(wlParams.eStep)
        Else
            stopSweep
        End If
    End If
End Sub




' ___
' VIs
' ===
Private Function getVIinstr(i As instr) As instr
    If i = vi Then
        If gViDetected Then
            getVIinstr = i
        Else
            getVIinstr = VI3631
        End If
    Else
        If gVi3631Detected Then
            getVIinstr = i
        Else
            getVIinstr = vi
        End If
    End If
End Function
Public Sub setVolts(volts As Double, Optional i As instr = vi)
    i = getVIinstr(i)
    If (gViDetected Or gVi3631Detected) Then
        If i = VI3631 Then gpib.GPIBwrite ":INST:SEL P6V", i
        
        If m_FVmode = False Then
            gpib.GPIBwrite ":SOUR:VOLT:RANG:AUTO ON", i
            gpib.GPIBwrite ":SOUR:FUNC:MODE VOLT", i
            gpib.GPIBwrite ":FORM:ELEM CURR", i
            
            gpib.GPIBwrite ":SENS:FUNC:ON 'CURR'", i
            gpib.GPIBwrite ":CONF:CURR", i
            gpib.GPIBwrite ":SENS:CURR:PROT 1.0", i
            m_FVmode = True
        End If
        gpib.GPIBwrite ":SOUR:VOLT " & volts, i
        m_fv = volts
    End If
End Sub

Public Function getVolts(Optional i As instr = vi) As Double
    Dim rd As String
    
    i = getVIinstr(i)
    
    On Error GoTo errorExit
    
    If (gViDetected Or gVi3631Detected) Then
        
        If i = VI3631 Then
            rd = gpib.GPIBread("OUTPUT:STAT ON;:MEAS:VOLT?", i)
        Else
            rd = gpib.GPIBread(":OUTP ON;:READ?", i)
        End If
        
        getVolts = val(rd)
        
    End If

errorExit:
End Function

Public Sub setCurrent(amps As Double, Optional i As instr = vi)
    i = getVIinstr(i)
    If (gViDetected Or gVi3631Detected) Then
        If m_FVmode Then
            gpib.GPIBwrite ":SOUR:CURR:RANG:AUTO ON", i
            gpib.GPIBwrite ":SOUR:FUNC:MODE CURR", i
            gpib.GPIBwrite ":FORM:ELEM VOLT", i
                
            gpib.GPIBwrite ":SENS:FUNC:ON 'VOLT'", i
            gpib.GPIBwrite ":CONF:VOLT", i
            gpib.GPIBwrite ":SENS:VOLT:PROT 10.0", i
            m_FVmode = False
        End If
        gpib.GPIBwrite ":SOUR:CURR " & amps, i
    End If
    m_fi = amps
End Sub

Public Sub readVI(volts As Double, amps As Double, Optional i As instr = vi)
    Dim rd As String, comma1 As Integer, comma2 As Integer
    volts = 0: amps = 0
    i = getVIinstr(i)
    On Error GoTo errorExit
    If (gViDetected Or gVi3631Detected) Then
        If 0 Then
            If m_FVmode Then
                gpib.GPIBwrite ":SENS:FUNC 'CURR'", i
                gpib.GPIBwrite ":SENS:CURR:PROT 0.8", i
                volts = m_fv
            Else
                gpib.GPIBwrite ":SENS:FUNC 'VOLT'", i
                gpib.GPIBwrite ":SENS:VOLT:PROT 10.0", i
                amps = m_fi
            End If
        End If
        
        If i = VI3631 Then
            If m_FVmode Then
                rd = gpib.GPIBread("OUTPUT:STAT ON;:MEAS:CURR?", i)
            Else
                rd = gpib.GPIBread("OUTPUT:STAT ON;:MEAS:VOLT?", i)
            End If
        Else
            rd = gpib.GPIBread(":OUTP ON;:READ?", i)
        End If
        
        If 1 Then
            If m_FVmode Then
                amps = val(rd): volts = m_fv
            Else
                volts = val(rd): amps = m_fi
                If volts = 0 And Len(rd) > 10 Then volts = 0.000001
            End If
        Else
            comma1 = InStr(rd, ",")
            volts = Mid(rd, 1, comma1 - 1)
            comma2 = InStr(Mid(rd, comma1 + 1, 1000), ",")
            amps = Mid(rd, comma1 + 1, comma2 - 1)
        End If
    End If
errorExit:
End Sub















' _____________
' Filter Wheels
' =============

Public Function fwReady() As Boolean
    fwReady = fmFilterWheels.enabled
End Function

Public Sub setFwLux(lux As Double)
    Dim i
    For i = 0 To 35
        If cmbLux.list(i) < lux Then
            vscrFwIndex.value = i
            lux = cmbLux.list(i)
            i = 35
        End If
    Next i
End Sub

Public Sub setFwMaxLux(lux As Double)
    tbLux.text = lux & Chr$(13)
End Sub

Public Function getFwMaxLux() As Double
    getFwMaxLux = cmbLux.list(0)
End Function

Public Function getFwLux() As Double
    getFwLux = cmbLux.list(vscrFwIndex.value)
End Function

Public Sub setFwIndex(Index As Integer)
    vscrFwIndex.value = Index
End Sub

Public Function getFwIndex() As Integer
    getFwIndex = vscrFwIndex.value
End Function

Private Sub cmbLux_Click()
    vscrFwIndex.value = cmbLux.ListIndex
End Sub

Private Sub tbLux_Change()
    Dim Number As Double
    On Error GoTo skip
    If enterText(tbLux.text) Then
        Number = tbLux.text
        gLuxMax = Number
        loadFwTables
        GoTo done:
skip:
done:
    tbLux.text = format(gLuxMax, "#.00")
    End If
End Sub

Private Sub vscrFwIndex_Change()
    If Not gFwChange Then
        gFwIdx = vscrFwIndex.value
        gFwAttn = fwAttn(gFwIdx)
        lblFwIndex.caption = gFwIdx
        lblNd.caption = "ND:" & format(gFwAttn, "0.#0")
        
        cmbLux.text = cmbLux.list(vscrFwIndex.value)
        tbLux.text = cmbLux.text
        
        gFwPos(0) = idx2fw(gFwIdx, 0)
        gFwPos(1) = idx2fw(gFwIdx, 1)
        gFwPos(2) = idx2fw(gFwIdx, 2)
        Call setFilterWheels(gFwPos(0), gFwPos(1), gFwPos(2))
        opFw(gFwPos(0)).value = True: opFw(gFwPos(1) + 6).value = True
        gFwChange = False
    Else
        gFwChange = True
    End If
End Sub

Private Sub opFw_Click(Index As Integer)
    If Not gFwChange Then
        If Index > 5 Then
            gFwPos(1) = Index - 6
        Else
            gFwPos(0) = Index
        End If
        vscrFwIndex.value = fw2idx(gFwPos(0), gFwPos(1), gFwPos(2))
    End If
End Sub

Public Sub setFilterWheels(ByVal pos0 As Long, ByVal pos1 As Long, ByVal pos2 As Long)
    Dim trys As Integer: trys = 100
    fmFilterWheels.enabled = False
    fmFilterWheels.caption = "Filter Wheels:Busy"
    If gFwDetected Then
        Do
            DoEvents
            Sleep (100)
            trys = trys - 1
        Loop Until (setFilterWheel(0, pos0) And setFilterWheel(1, pos1) And setFilterWheel(2, pos2)) Or trys = 0
        If trys > 0 Then
            fmFilterWheels.enabled = True
            fmFilterWheels.caption = "Filter Wheels:Ready"
        Else
            gFwDetected = False
        End If
    End If
End Sub

Public Sub getFilterWheels(pos0 As Long, pos1 As Long, pos2 As Long)

    Call getFilterWheel(0, pos0)
    If nFilterWheels > 1 Then Call getFilterWheel(1, pos1)
    If nFilterWheels > 2 Then Call getFilterWheel(2, pos2)
 
End Sub

Function getFilterWheel(ByVal wheel As Long, pos As Long) As Boolean

    Dim msg As String, trys As Integer: trys = 100
    On Error GoTo skip
    
    If (Not MSComm1(wheel).PortOpen) Then
       
        'If cbFWenable.value = vbUnchecked Then GoTo skip
        
        MSComm1(wheel).PortOpen = True
        MSComm1(wheel).Output = "pos?" & Chr$(13): Sleep (200)
        Do
            DoEvents
            msg = msg & MSComm1(wheel).Input
            trys = trys - 1
        Loop Until (InStr(msg, ">")) Or trys = 0
        If trys = 0 Then GoTo skip
        
        pos = val(Mid(msg, 5, Len(msg) - 4)) - 1
        
        MSComm1(wheel).PortOpen = False
        getFilterWheel = True
        GoTo done
skip:
        'MsgBox ("Filter Wheels not detected")
done:
    Else
        MSComm1(wheel).PortOpen = False
    End If
    
    
End Function

Function setFilterWheel(ByVal wheel As Long, ByVal inpos As Long) As Boolean
    Dim pos As Long, trys As Integer: trys = 100
    Dim msg As String
    On Error GoTo skip
    
    If wheel < nFilterWheels Then
    
        If (Not MSComm1(wheel).PortOpen) Then
            
            'If cbFWenable.value = vbUnchecked Then GoTo skip
            
            MSComm1(wheel).PortOpen = True
            MSComm1(wheel).Output = "pos=" & (inpos + 1) & Chr$(13): Sleep (100)
            MSComm1(wheel).PortOpen = False
            
            Do
                Sleep (100)
                DoEvents
                trys = trys - 1
            Loop Until getFilterWheel(wheel, pos) Or trys = 0 ' no error
            If trys = 0 Then GoTo skip
            
            If inpos = pos Then setFilterWheel = True
            
            GoTo done
skip:
done:
        Else
            MSComm1(wheel).PortOpen = False
        End If
    
    Else
        setFilterWheel = True
    End If
    
    
End Function

Sub writeCom(ByVal vbIndex As Integer, ByVal msg As String)
    
    If (Not MSComm1(vbIndex).PortOpen) Then
        On Error GoTo skip
        MSComm1(vbIndex).PortOpen = True
        MSComm1(vbIndex).Output = msg
        MSComm1(vbIndex).PortOpen = False
        debugPrint vbIndex, msg
skip:
    End If

End Sub

Sub readCom(ByVal vbIndex As Integer, msg As String)
    Dim flt As Single
    If (Not MSComm1(vbIndex).PortOpen) Then
        On Error GoTo skip
        MSComm1(vbIndex).PortOpen = True
        Do
            DoEvents
            'flt = MSComm1(vbIndex).Input
            msg = MSComm1(vbIndex).Input
        Loop Until (InStr(1, msg, Chr$(10)))
        
        flt = MSComm1(vbIndex).Input
        
        MSComm1(vbIndex).PortOpen = False
        debugPrint vbIndex, msg
skip:
    End If

End Sub

Sub loadFwTables()
    Dim i As Integer, j As Integer
    gFwDetected = True
    If nFilterWheels = 2 Then
        i = 0: idx2fw(i, 0) = 0: idx2fw(i, 1) = 0: fwAttn(i) = 0#
        i = 1: idx2fw(i, 0) = 0: idx2fw(i, 1) = 1: fwAttn(i) = 0.097
        i = 2: idx2fw(i, 0) = 0: idx2fw(i, 1) = 2: fwAttn(i) = 0.184
        i = 3: idx2fw(i, 0) = 0: idx2fw(i, 1) = 3: fwAttn(i) = 0.266
        i = 4: idx2fw(i, 0) = 0: idx2fw(i, 1) = 4: fwAttn(i) = 0.392
        i = 5: idx2fw(i, 0) = 0: idx2fw(i, 1) = 5: fwAttn(i) = 0.515
        i = 6: idx2fw(i, 0) = 1: idx2fw(i, 1) = 0: fwAttn(i) = 0.611
        i = 7: idx2fw(i, 0) = 1: idx2fw(i, 1) = 1: fwAttn(i) = 0.708
        i = 8: idx2fw(i, 0) = 1: idx2fw(i, 1) = 2: fwAttn(i) = 0.796
        i = 9: idx2fw(i, 0) = 1: idx2fw(i, 1) = 3: fwAttn(i) = 0.877
        i = 10: idx2fw(i, 0) = 1: idx2fw(i, 1) = 4: fwAttn(i) = 1.004
        i = 11: idx2fw(i, 0) = 2: idx2fw(i, 1) = 0: fwAttn(i) = 1.04
        i = 12: idx2fw(i, 0) = 1: idx2fw(i, 1) = 5: fwAttn(i) = 1.127
        i = 13: idx2fw(i, 0) = 2: idx2fw(i, 1) = 1: fwAttn(i) = 1.136
        i = 14: idx2fw(i, 0) = 2: idx2fw(i, 1) = 2: fwAttn(i) = 1.224
        i = 15: idx2fw(i, 0) = 2: idx2fw(i, 1) = 3: fwAttn(i) = 1.306
        i = 16: idx2fw(i, 0) = 2: idx2fw(i, 1) = 4: fwAttn(i) = 1.432
        i = 17: idx2fw(i, 0) = 2: idx2fw(i, 1) = 5: fwAttn(i) = 1.555
        i = 18: idx2fw(i, 0) = 3: idx2fw(i, 1) = 0: fwAttn(i) = 2.157
        i = 19: idx2fw(i, 0) = 3: idx2fw(i, 1) = 1: fwAttn(i) = 2.254
        i = 20: idx2fw(i, 0) = 3: idx2fw(i, 1) = 2: fwAttn(i) = 2.342
        i = 21: idx2fw(i, 0) = 3: idx2fw(i, 1) = 3: fwAttn(i) = 2.423
        i = 22: idx2fw(i, 0) = 3: idx2fw(i, 1) = 4: fwAttn(i) = 2.55
        i = 23: idx2fw(i, 0) = 3: idx2fw(i, 1) = 5: fwAttn(i) = 2.672
        i = 24: idx2fw(i, 0) = 4: idx2fw(i, 1) = 0: fwAttn(i) = 3.122
        i = 25: idx2fw(i, 0) = 4: idx2fw(i, 1) = 1: fwAttn(i) = 3.219
        i = 26: idx2fw(i, 0) = 4: idx2fw(i, 1) = 2: fwAttn(i) = 3.307
        i = 27: idx2fw(i, 0) = 4: idx2fw(i, 1) = 3: fwAttn(i) = 3.388
        i = 28: idx2fw(i, 0) = 4: idx2fw(i, 1) = 4: fwAttn(i) = 3.515
        i = 29: idx2fw(i, 0) = 4: idx2fw(i, 1) = 5: fwAttn(i) = 3.637
        i = 30: idx2fw(i, 0) = 5: idx2fw(i, 1) = 0: fwAttn(i) = 4.209
        i = 31: idx2fw(i, 0) = 5: idx2fw(i, 1) = 1: fwAttn(i) = 4.306
        i = 32: idx2fw(i, 0) = 5: idx2fw(i, 1) = 2: fwAttn(i) = 4.394
        i = 33: idx2fw(i, 0) = 5: idx2fw(i, 1) = 3: fwAttn(i) = 4.475
        i = 34: idx2fw(i, 0) = 5: idx2fw(i, 1) = 4: fwAttn(i) = 4.602
        i = 35: idx2fw(i, 0) = 5: idx2fw(i, 1) = 5: fwAttn(i) = 4.724
    Else
        If nFilterWheels = 1 Then
            i = 0: idx2fw(i, 0) = 0: fwAttn(i) = 0#
            i = 1: idx2fw(i, 0) = 1: fwAttn(i) = 0.277
            i = 2: idx2fw(i, 0) = 2: fwAttn(i) = 0.602
            i = 3: idx2fw(i, 0) = 3: fwAttn(i) = 1.12
            i = 4: idx2fw(i, 0) = 4: fwAttn(i) = 1.5
            i = 5: idx2fw(i, 0) = 5: fwAttn(i) = 1.845
            fmWheel(1).enabled = False: fmWheel(2).enabled = False
        Else
            If nFilterWheels = 3 Then
            End If
        End If
    End If
    
    For i = 0 To 35
        fw2idx(idx2fw(i, 0), idx2fw(i, 1), idx2fw(i, 2)) = i
        cmbLux.list(i) = format(gLuxMax / (10 ^ fwAttn(i)), "0.00")
    Next i
    
    Call getFilterWheels(gFwPos(0), gFwPos(1), gFwPos(2))
    Call setFilterWheels(gFwPos(0), gFwPos(1), gFwPos(2))
    vscrFwIndex.value = fw2idx(gFwPos(0), gFwPos(1), gFwPos(2))

End Sub

Private Sub HScrDPS_Change()
    Dim volts As Double: volts = HScrDPS.value: volts = (volts + 25000#) / 10000#
    lblDPS.caption = volts
    setVolts (volts)
End Sub

Private Sub HScrPgVih_Change()
    lblPgVih.caption = HScrPgVih.value / 100#
    Call gpib.GPIBwrite("HIL " & lblPgVih.caption & "V", pg)
End Sub

Public Sub setPgVih(ByVal vih As Double)

    If vih < 0 Then
        vih = 0
    Else
        If vih > 8 Then vih = 8
    End If
    
    HScrPgVih.value = vih * 100
    
End Sub

Private Sub HScrPgWid_Change()
    lblPgWid.caption = HScrPgWid.value
    Call gpib.GPIBwrite("WID " & lblPgWid.caption & "US", pg)
End Sub

Public Sub setPgWid(ByVal wid As Double)

    If wid < HScrPgWid.min Then
        wid = HScrPgWid.min
    Else
        If wid > HScrPgWid.max Then wid = HScrPgWid.max
    End If
    
    HScrPgWid.value = wid
    
End Sub

' +______________+
' | Chroma Meter |
' +ŻŻŻŻŻŻŻŻŻŻŻŻŻŻ+

Public Sub GetCCTlux(cct As Single, lux As Single)
    Dim RawLux As String
    Dim RawColorTemp As String
    Dim ColorTemp As String
    
    Enable_Measurement
    
    If ChromaMeterCom.init Then
        'Define LM communication
        ChromaMeterCom.Receptor(0) = &H30& ' ASCII 0
        ChromaMeterCom.Receptor(1) = &H30& ' ASCII 0
        ChromaMeterCom.Command(0) = &H30&  ' ASCII 0
        ChromaMeterCom.Command(1) = &H38&  ' ASCII 8
        ChromaMeterCom.Data4(0) = &H31&    ' ASCII 1
        ChromaMeterCom.Data4(1) = &H32&    ' ASCII 2
        ChromaMeterCom.Data4(2) = &H30&    ' ASCII 0
        ChromaMeterCom.Data4(3) = &H30&    ' ASCII 0
        ChromaMeterCom.ETX = &H3&
        ChromaMeterCom.CR = &HD&
        ChromaMeterCom.LF = &HA&
    
        CalcBCC ChromaMeterCom
        MSComm1(comDev.ChromaMeter).Output = LMSendCom(ChromaMeterCom)
        Sleep 100
        Buffer = MSComm1(comDev.ChromaMeter).Input
        RawColorTemp = Mid(Buffer, 16, 6)
        RawLux = Mid(Buffer, 10, 6)
        lux = 0: cct = 0: On Error GoTo done
        lux = val(Mid(RawLux, 2, 4)) * (10 ^ (val(Mid(RawLux, 6, 1) - 4)))
        cct = val(Mid(RawColorTemp, 2, 4)) * (10 ^ (val(Mid(RawColorTemp, 6, 1) - 4)))
done:
        lblCMLux.caption = format(lux, "0.0") & " Lux"
        lblMCcct.caption = format(cct, "0.0") & " K"
    Else
        InitChromaMeter
        EnableChromaMeter
        SetEXT
    End If
End Sub

Public Function InitChromaMeter() As Boolean

    If Not MSComm1(comDev.ChromaMeter).PortOpen Then
        MSComm1(comDev.ChromaMeter).CommPort = 7   'Port Number
        MSComm1(comDev.ChromaMeter).Settings = "9600,E,7,1" '9600 baud, even parity, 7 data, 1 stop bit
        MSComm1(comDev.ChromaMeter).InputLen = 0 'Read whole buffer when Input is used
        MSComm1(comDev.ChromaMeter).PortOpen = True 'Open the serial port
    End If
        
    'Define LM communication defaults
    ChromaMeterCom.STX = &H2&
    ChromaMeterCom.Receptor(0) = &H30& ' ASCII 0
    ChromaMeterCom.Receptor(1) = &H30& ' ASCII 0
    ChromaMeterCom.Command(0) = &H35&  ' ASCII 5
    ChromaMeterCom.Command(1) = &H34&  ' ASCII 4
    ChromaMeterCom.Data4(0) = &H31&    ' ASCII 1
    ChromaMeterCom.Data4(1) = &H20&    ' ASCII Space
    ChromaMeterCom.Data4(2) = &H20&    ' ASCII Space
    ChromaMeterCom.Data4(3) = &H20&    ' ASCII Space
    ChromaMeterCom.ETX = &H3&
    ChromaMeterCom.CR = &HD&
    ChromaMeterCom.LF = &HA&
    
    CalcBCC ChromaMeterCom
    MSComm1(comDev.ChromaMeter).Output = LMSendCom(ChromaMeterCom)
    Sleep 80
    Buffer = MSComm1(comDev.ChromaMeter).Input
    
    If Mid(Buffer, 2, 7) = "0054   " Then
        ChromaMeterCom.init = True
        'Text1.text = "Initialized"
        SimMode = False
    Else
        'Text1.text = "Could not Initialize"
        SimMode = True
    End If
    
End Function
Public Function EnableChromaMeter()
    'Define LM communication
    ChromaMeterCom.Receptor(0) = &H39& ' ASCII 9
    ChromaMeterCom.Receptor(1) = &H39& ' ASCII 9
    ChromaMeterCom.Command(0) = &H35&  ' ASCII 5
    ChromaMeterCom.Command(1) = &H35&  ' ASCII 5
    ChromaMeterCom.Data4(0) = &H31&    ' ASCII 1
    ChromaMeterCom.Data4(1) = &H20&    ' ASCII Space
    ChromaMeterCom.Data4(2) = &H20&    ' ASCII Space
    ChromaMeterCom.Data4(3) = &H30&    ' ASCII 0
    ChromaMeterCom.ETX = &H3&
    ChromaMeterCom.CR = &HD&
    ChromaMeterCom.LF = &HA&
    
    CalcBCC ChromaMeterCom
    MSComm1(comDev.ChromaMeter).Output = LMSendCom(ChromaMeterCom)
    Sleep 500
End Function
Public Function SetEXT()
    'Define LM communication
    ChromaMeterCom.Receptor(0) = &H30& ' ASCII 0
    ChromaMeterCom.Receptor(1) = &H30& ' ASCII 0
    ChromaMeterCom.Command(0) = &H34&  ' ASCII 4
    ChromaMeterCom.Command(1) = &H30&  ' ASCII 0
    ChromaMeterCom.Data4(0) = &H31&    ' ASCII 1
    ChromaMeterCom.Data4(1) = &H30&    ' ASCII 0
    ChromaMeterCom.Data4(2) = &H20&    ' ASCII Space
    ChromaMeterCom.Data4(3) = &H20&    ' ASCII Space
    ChromaMeterCom.ETX = &H3&
    ChromaMeterCom.CR = &HD&
    ChromaMeterCom.LF = &HA&
    
    CalcBCC ChromaMeterCom
    MSComm1(comDev.ChromaMeter).Output = LMSendCom(ChromaMeterCom)
    Sleep 175
    Buffer = MSComm1(comDev.ChromaMeter).Input
    
End Function

Public Function Enable_Measurement()
    If ChromaMeterCom.init Then
        'Define LM communication
        ChromaMeterCom.Receptor(0) = &H39& ' ASCII 9
        ChromaMeterCom.Receptor(1) = &H39& ' ASCII 9
        ChromaMeterCom.Command(0) = &H34&  ' ASCII 4
        ChromaMeterCom.Command(1) = &H30&  ' ASCII 0
        ChromaMeterCom.Data4(0) = &H32&    ' ASCII 1
        ChromaMeterCom.Data4(1) = &H31&    ' ASCII 1
        ChromaMeterCom.Data4(2) = &H20&    ' ASCII Space
        ChromaMeterCom.Data4(3) = &H20&    ' ASCII Space
        ChromaMeterCom.ETX = &H3&
        ChromaMeterCom.CR = &HD&
        ChromaMeterCom.LF = &HA&
    
        CalcBCC ChromaMeterCom
        MSComm1(comDev.ChromaMeter).Output = LMSendCom(ChromaMeterCom)
        Sleep 500
   End If
End Function


' +___________+
' | Lux Meter |
' +ŻŻŻŻŻŻŻŻŻŻŻ+

Public Function InitLuxMeter() As Boolean

    If Not MSComm1(2).PortOpen Then
        MSComm1(2).CommPort = 4   'Port Number
        MSComm1(2).Settings = "9600,E,7,1" '9600 baud, even parity, 7 data, 1 stop bit
        MSComm1(2).InputLen = 0 'Read whole buffer when Input is used
        MSComm1(2).PortOpen = True 'Open the serial port
    End If
        
    'Define LM communication defaults
    LuxMeterCom.STX = &H2&
    LuxMeterCom.Receptor(0) = &H30& ' ASCII 0
    LuxMeterCom.Receptor(1) = &H30& ' ASCII 0
    LuxMeterCom.Command(0) = &H35&  ' ASCII 5
    LuxMeterCom.Command(1) = &H34&  ' ASCII 4
    LuxMeterCom.Data4(0) = &H31&    ' ASCII 1
    LuxMeterCom.Data4(1) = &H20&    ' ASCII Space
    LuxMeterCom.Data4(2) = &H20&    ' ASCII Space
    LuxMeterCom.Data4(3) = &H20&    ' ASCII Space
    LuxMeterCom.ETX = &H3&
    LuxMeterCom.CR = &HD&
    LuxMeterCom.LF = &HA&
    
    CalcBCC LuxMeterCom
    MSComm1(comDev.luxMeter).Output = LMSendCom(LuxMeterCom)
    Sleep 80
    Buffer = MSComm1(comDev.luxMeter).Input
    
    If Mid(Buffer, 2, 7) = "0054   " Then
        LuxMeterCom.init = True
        SimMode = False
    Else
        SimMode = True
    End If

End Function

Public Function getLux() As Double
    Dim RawLux As String
    Dim lux As String
    
    If LuxMeterCom.init Then
        'Define LM communication
        LuxMeterCom.Receptor(0) = &H30& ' ASCII 0
        LuxMeterCom.Receptor(1) = &H30& ' ASCII 0
        LuxMeterCom.Command(0) = &H31&  ' ASCII 1
        LuxMeterCom.Command(1) = &H30&  ' ASCII 0
        LuxMeterCom.Data4(0) = &H30&    ' ASCII 0
        LuxMeterCom.Data4(1) = &H32&    ' ASCII 2
        LuxMeterCom.Data4(2) = &H30&    ' ASCII 0
        LuxMeterCom.Data4(3) = &H30&    ' ASCII 0
        LuxMeterCom.ETX = &H3&
        LuxMeterCom.CR = &HD&
        LuxMeterCom.LF = &HA&
    
        CalcBCC LuxMeterCom
        MSComm1(comDev.luxMeter).Output = LMSendCom(LuxMeterCom)
        Sleep 100
        Buffer = MSComm1(comDev.luxMeter).Input
        RawLux = Mid(Buffer, 10, 6)
        If RawLux <> "" Then
            lux = val(Mid(RawLux, 2, 5)) * (10 ^ (val(Mid(RawLux, 6, 1) - 5)))
        Else
            lux = 0
        End If
        getLux = lux
    Else
        InitLuxMeter
    End If
End Function

Function EnableLuxMeter()
    'Define LM communication
    LuxMeterCom.Receptor(0) = &H39& ' ASCII 9
    LuxMeterCom.Receptor(1) = &H39& ' ASCII 9
    LuxMeterCom.Command(0) = &H35&  ' ASCII 5
    LuxMeterCom.Command(1) = &H35&  ' ASCII 5
    LuxMeterCom.Data4(0) = &H30&    ' ASCII 0
    LuxMeterCom.Data4(1) = &H20&    ' ASCII Space
    LuxMeterCom.Data4(2) = &H20&    ' ASCII Space
    LuxMeterCom.Data4(3) = &H30&    ' ASCII 0
    LuxMeterCom.ETX = &H3&
    LuxMeterCom.CR = &HD&
    LuxMeterCom.LF = &HA&
    
    CalcBCC LuxMeterCom
    MSComm1(comDev.luxMeter).Output = LMSendCom(LuxMeterCom)
    Sleep 80
End Function








'WARNING! DO NOT REMOVE OR MODIFY THE FOLLOWING COMMENTED LINES!
'MappingInfo=fmMonochromater,fmMonochromater,-1,Caption
Public Property Get caption() As String
    caption = fmMonochromater.caption
End Property

Public Property Let caption(ByVal New_Caption As String)
    fmMonochromater.caption() = New_Caption
    PropertyChanged "Caption"
End Property

Public Property Get EnableFW() As Boolean
    EnableFW = gUsingFW
End Property

Public Property Let EnableFW(enable As Boolean)
    gUsingFW = enable
    PropertyChanged "EnableFW"
End Property

'Load property values from storage
Private Sub UserControl_ReadProperties(PropBag As PropertyBag)
    fmMonochromater.caption = PropBag.ReadProperty("Caption", "Monochromater")
    gUsingFW = PropBag.ReadProperty("EnableFW", False)
    If EnableFW Then gLuxMax = 15280: loadFwTables
End Sub

'Write property values to storage
Private Sub UserControl_WriteProperties(PropBag As PropertyBag)

    Call PropBag.WriteProperty("Caption", fmMonochromater.caption, "Monochromater")
    Call PropBag.WriteProperty("EnableFW", gUsingFW, False)
End Sub

' +_____________+
' | Script APIs |
' +ŻŻŻŻŻŻŻŻŻŻŻŻŻ+

Public Sub setGpib(gpib As String)
    Dim i
    
    For i = 0 To cmbGPIB.ListCount
        If gpib = cmbGPIB.list(i) Then
            cmbGPIB.ListIndex = i
            cmbGPIB_Click
            i = cmbGPIB.ListCount
        End If
    Next i
    
End Sub

Public Sub setFWenable(enable As Boolean)

    If enable Then
        cbFWenable.value = vbChecked
    Else
        cbFWenable.value = vbUnchecked
    End If
    
    cbFWenable_Click
    
End Sub




