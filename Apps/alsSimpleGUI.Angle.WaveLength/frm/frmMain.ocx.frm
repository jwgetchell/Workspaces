VERSION 5.00
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "comdlg32.ocx"
Object = "{5D35C988-162D-4A67-B49D-1E0874DC432F}#1.0#0"; "alsUSB.ocx"
Begin VB.Form frmMain 
   Caption         =   "Intersil ALS Angle & WaveLength"
   ClientHeight    =   7245
   ClientLeft      =   -15
   ClientTop       =   555
   ClientWidth     =   7005
   Icon            =   "frmMain.ocx.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   ScaleHeight     =   7245
   ScaleWidth      =   7005
   Begin alsUSB.ucALSusb ucALSusb1 
      Height          =   5895
      Left            =   0
      TabIndex        =   88
      Top             =   0
      Width           =   1815
      _ExtentX        =   3201
      _ExtentY        =   10398
   End
   Begin VB.CheckBox cbCompEnable 
      Caption         =   "Comp=ON"
      Height          =   255
      Left            =   4200
      Style           =   1  'Graphical
      TabIndex        =   87
      Top             =   6000
      Width           =   975
   End
   Begin VB.Frame fmRegisters 
      Caption         =   "Field I/O"
      Height          =   1695
      Left            =   5280
      TabIndex        =   78
      Top             =   5520
      Width           =   1455
      Begin VB.CheckBox cbEcho 
         Caption         =   "echo"
         Height          =   255
         Left            =   120
         TabIndex        =   86
         Top             =   240
         Value           =   1  'Checked
         Width           =   735
      End
      Begin VB.CommandButton cmdClrShiftMask 
         Caption         =   "clr"
         Height          =   255
         Left            =   960
         TabIndex        =   83
         Top             =   240
         Width           =   375
      End
      Begin VB.TextBox txtIO 
         Height          =   285
         Index           =   0
         Left            =   120
         MultiLine       =   -1  'True
         TabIndex        =   82
         Text            =   "frmMain.ocx.frx":0CCA
         Top             =   1320
         Width           =   615
      End
      Begin VB.ComboBox cmbIO 
         Height          =   315
         Index           =   0
         ItemData        =   "frmMain.ocx.frx":0CD0
         Left            =   120
         List            =   "frmMain.ocx.frx":0CEC
         TabIndex        =   81
         Text            =   "0"
         Top             =   720
         Width           =   615
      End
      Begin VB.ComboBox cmbIO 
         Height          =   315
         Index           =   1
         ItemData        =   "frmMain.ocx.frx":0D08
         Left            =   720
         List            =   "frmMain.ocx.frx":0D24
         TabIndex        =   80
         Text            =   "FF"
         Top             =   720
         Width           =   615
      End
      Begin VB.TextBox txtIO 
         Height          =   285
         Index           =   1
         Left            =   720
         MultiLine       =   -1  'True
         TabIndex        =   79
         Text            =   "frmMain.ocx.frx":0D44
         Top             =   1320
         Width           =   615
      End
      Begin VB.Label lblAddrData 
         Caption         =   "  Addr      Data"
         Height          =   255
         Left            =   120
         TabIndex        =   85
         Top             =   1080
         Width           =   1215
      End
      Begin VB.Label lblShiftMask 
         Caption         =   "  Shift      Mask"
         Height          =   255
         Left            =   120
         TabIndex        =   84
         Top             =   480
         Width           =   1215
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "LPT-8255"
      Height          =   1335
      Left            =   5400
      TabIndex        =   69
      Top             =   4080
      Width           =   1455
      Begin VB.CheckBox cbLPT 
         Caption         =   "7"
         Height          =   255
         Index           =   7
         Left            =   600
         TabIndex        =   77
         Top             =   960
         Width           =   375
      End
      Begin VB.CheckBox cbLPT 
         Caption         =   "6"
         Height          =   255
         Index           =   6
         Left            =   600
         TabIndex        =   76
         Top             =   720
         Width           =   375
      End
      Begin VB.CheckBox cbLPT 
         Caption         =   "5"
         Height          =   255
         Index           =   5
         Left            =   600
         TabIndex        =   75
         Top             =   480
         Width           =   375
      End
      Begin VB.CheckBox cbLPT 
         Caption         =   "4"
         Height          =   255
         Index           =   4
         Left            =   600
         TabIndex        =   74
         Top             =   240
         Width           =   375
      End
      Begin VB.CheckBox cbLPT 
         Caption         =   "3"
         Height          =   255
         Index           =   3
         Left            =   120
         TabIndex        =   73
         Top             =   960
         Width           =   375
      End
      Begin VB.CheckBox cbLPT 
         Caption         =   "2"
         Height          =   255
         Index           =   2
         Left            =   120
         TabIndex        =   72
         Top             =   720
         Width           =   375
      End
      Begin VB.CheckBox cbLPT 
         Caption         =   "1"
         Height          =   255
         Index           =   1
         Left            =   120
         TabIndex        =   71
         Top             =   480
         Width           =   375
      End
      Begin VB.CheckBox cbLPT 
         Caption         =   "0"
         Height          =   255
         Index           =   0
         Left            =   120
         TabIndex        =   70
         Top             =   240
         Width           =   375
      End
   End
   Begin VB.CommandButton cmdDefaultStartUpEnabled 
      Caption         =   "Default StartUp Enabled"
      Enabled         =   0   'False
      Height          =   495
      Left            =   5280
      TabIndex        =   68
      Top             =   3240
      Visible         =   0   'False
      Width           =   1695
   End
   Begin VB.CheckBox cbAvgIR 
      Caption         =   "Average"
      Height          =   255
      Left            =   5400
      Style           =   1  'Graphical
      TabIndex        =   67
      Top             =   3840
      Value           =   1  'Checked
      Width           =   1335
   End
   Begin VB.Frame fmTimers 
      Caption         =   "Timers"
      Height          =   3135
      Left            =   5280
      TabIndex        =   45
      Top             =   0
      Width           =   1695
      Begin VB.CheckBox cbTimers 
         Caption         =   "ProxOffset"
         Height          =   255
         Index           =   9
         Left            =   120
         TabIndex        =   56
         Top             =   2760
         Width           =   1095
      End
      Begin VB.CheckBox cbTimers 
         Caption         =   "PxArDly"
         Height          =   255
         Index           =   8
         Left            =   120
         TabIndex        =   55
         Top             =   2520
         Width           =   1095
      End
      Begin VB.CheckBox cbTimers 
         Caption         =   "AR"
         Height          =   255
         Index           =   7
         Left            =   120
         TabIndex        =   54
         Top             =   2280
         Width           =   1095
      End
      Begin VB.CheckBox cbTimers 
         Caption         =   "Comp"
         Height          =   255
         Index           =   6
         Left            =   120
         TabIndex        =   53
         Top             =   2040
         Width           =   1095
      End
      Begin VB.CheckBox cbTimers 
         Caption         =   "GlassAout"
         Height          =   255
         Index           =   5
         Left            =   120
         TabIndex        =   52
         Top             =   1680
         Width           =   1095
      End
      Begin VB.CheckBox cbTimers 
         Caption         =   "Sweep"
         Height          =   255
         Index           =   4
         Left            =   120
         TabIndex        =   51
         Top             =   1440
         Width           =   975
      End
      Begin VB.CheckBox cbTimers 
         Caption         =   "Plot"
         Height          =   255
         Index           =   3
         Left            =   120
         TabIndex        =   50
         Top             =   1200
         Width           =   975
      End
      Begin VB.CheckBox cbTimers 
         Caption         =   "Meas1"
         Height          =   255
         Index           =   2
         Left            =   120
         TabIndex        =   49
         Top             =   960
         Width           =   975
      End
      Begin VB.CheckBox cbTimers 
         Caption         =   "Meas0"
         Height          =   255
         Index           =   1
         Left            =   120
         TabIndex        =   48
         Top             =   720
         Width           =   975
      End
      Begin VB.CommandButton cmdTimersRead 
         Caption         =   "Read"
         Height          =   255
         Left            =   120
         TabIndex        =   47
         Top             =   240
         Width           =   975
      End
      Begin VB.CheckBox cbTimers 
         Caption         =   "Init"
         Height          =   255
         Index           =   0
         Left            =   120
         TabIndex        =   46
         Top             =   480
         Width           =   975
      End
      Begin VB.Label lblTimers 
         Alignment       =   1  'Right Justify
         Caption         =   "8888"
         Height          =   255
         Index           =   9
         Left            =   1200
         TabIndex        =   66
         Top             =   2760
         Width           =   375
      End
      Begin VB.Label lblTimers 
         Alignment       =   1  'Right Justify
         Caption         =   "8888"
         Height          =   255
         Index           =   8
         Left            =   1200
         TabIndex        =   65
         Top             =   2520
         Width           =   375
      End
      Begin VB.Label lblTimers 
         Alignment       =   1  'Right Justify
         Caption         =   "8888"
         Height          =   255
         Index           =   7
         Left            =   1200
         TabIndex        =   64
         Top             =   2280
         Width           =   375
      End
      Begin VB.Label lblTimers 
         Alignment       =   1  'Right Justify
         Caption         =   "8888"
         Height          =   255
         Index           =   6
         Left            =   1200
         TabIndex        =   63
         Top             =   2040
         Width           =   375
      End
      Begin VB.Label lblTimers 
         Alignment       =   1  'Right Justify
         Caption         =   "8888"
         Height          =   255
         Index           =   5
         Left            =   1200
         TabIndex        =   62
         Top             =   1680
         Width           =   375
      End
      Begin VB.Label lblTimers 
         Alignment       =   1  'Right Justify
         Caption         =   "8888"
         Height          =   255
         Index           =   4
         Left            =   1200
         TabIndex        =   61
         Top             =   1440
         Width           =   375
      End
      Begin VB.Label lblTimers 
         Alignment       =   1  'Right Justify
         Caption         =   "8888"
         Height          =   255
         Index           =   3
         Left            =   1200
         TabIndex        =   60
         Top             =   1200
         Width           =   375
      End
      Begin VB.Label lblTimers 
         Alignment       =   1  'Right Justify
         Caption         =   "8888"
         Height          =   255
         Index           =   2
         Left            =   1200
         TabIndex        =   59
         Top             =   960
         Width           =   375
      End
      Begin VB.Label lblTimers 
         Alignment       =   1  'Right Justify
         Caption         =   "8888"
         Height          =   255
         Index           =   1
         Left            =   1200
         TabIndex        =   58
         Top             =   720
         Width           =   375
      End
      Begin VB.Label lblTimers 
         Alignment       =   1  'Right Justify
         Caption         =   "8888"
         Height          =   255
         Index           =   0
         Left            =   1200
         TabIndex        =   57
         Top             =   480
         Width           =   375
      End
   End
   Begin VB.Frame fmRunControls 
      Caption         =   "Run Controls"
      Height          =   3495
      Left            =   1920
      TabIndex        =   25
      Top             =   0
      Width           =   1455
      Begin VB.Frame fmRunMode 
         Caption         =   "Mode"
         Height          =   1215
         Left            =   120
         TabIndex        =   29
         Top             =   240
         Width           =   1215
         Begin VB.CheckBox cbLoopRun 
            Caption         =   "LpRun:0"
            Height          =   255
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   30
            Top             =   720
            Width           =   975
         End
         Begin VB.HScrollBar HScrLoopRun 
            Height          =   255
            Left            =   -120
            Max             =   32
            TabIndex        =   31
            Top             =   840
            Width           =   1455
         End
         Begin VB.CommandButton cmdRun 
            Caption         =   "StartLoop"
            Height          =   255
            Left            =   120
            TabIndex        =   32
            Top             =   480
            Width           =   975
         End
         Begin VB.CheckBox cbRunStop 
            Caption         =   "Run"
            Height          =   255
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   33
            ToolTipText     =   "Run/Stop Measurements"
            Top             =   240
            Width           =   975
         End
      End
      Begin VB.Frame fmRunOptions 
         Caption         =   "Options"
         Height          =   855
         Left            =   120
         TabIndex        =   26
         Top             =   1440
         Width           =   1215
         Begin VB.CheckBox cbCycleIRDR 
            Caption         =   "IRDR:Static"
            Height          =   255
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   27
            Top             =   480
            Width           =   975
         End
         Begin VB.CheckBox cbCalLux 
            Caption         =   "Lux=Raw"
            Height          =   255
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   28
            ToolTipText     =   "Monochromator Cal Correction"
            Top             =   240
            Width           =   975
         End
      End
      Begin VB.Frame fmSpecialOptions 
         Caption         =   "Special Opt."
         Height          =   1095
         Left            =   120
         TabIndex        =   34
         Top             =   2280
         Width           =   1215
         Begin VB.Frame frmGlassAnalog 
            BorderStyle     =   0  'None
            Caption         =   "Frame1"
            Height          =   780
            Left            =   120
            TabIndex        =   35
            Top             =   240
            Width           =   975
            Begin VB.OptionButton opGlassAout 
               Caption         =   "Cal"
               Height          =   255
               Index           =   3
               Left            =   120
               TabIndex        =   39
               ToolTipText     =   "Monochromator Calibration Sweep"
               Top             =   0
               Width           =   735
            End
            Begin VB.OptionButton opGlassAout 
               Caption         =   "Aout"
               Height          =   255
               Index           =   2
               Left            =   120
               TabIndex        =   38
               ToolTipText     =   "Select to use DVM"
               Top             =   480
               Width           =   735
            End
            Begin VB.OptionButton opGlassAout 
               Caption         =   "Glass"
               Height          =   255
               Index           =   1
               Left            =   120
               TabIndex        =   37
               ToolTipText     =   "Monochromator Glass Sweep"
               Top             =   240
               Width           =   735
            End
            Begin VB.OptionButton opGlassAout 
               Caption         =   "Driver"
               Height          =   255
               Index           =   0
               Left            =   120
               TabIndex        =   36
               Top             =   960
               Value           =   -1  'True
               Width           =   735
            End
         End
      End
   End
   Begin VB.Frame frmDrivers 
      Caption         =   "Drivers"
      Height          =   1095
      Left            =   -1080
      TabIndex        =   0
      Top             =   6000
      Visible         =   0   'False
      Width           =   5175
      Begin VB.Timer tmrProxOffset 
         Enabled         =   0   'False
         Interval        =   500
         Left            =   3480
         Top             =   240
      End
      Begin VB.Timer tmrPxArDly 
         Enabled         =   0   'False
         Interval        =   500
         Left            =   3120
         Top             =   240
      End
      Begin VB.Timer tmrComp 
         Enabled         =   0   'False
         Interval        =   3000
         Left            =   2400
         Top             =   240
      End
      Begin VB.Timer tmrAR 
         Enabled         =   0   'False
         Interval        =   500
         Left            =   2760
         Top             =   240
      End
      Begin VB.Timer tmrGlassAout 
         Enabled         =   0   'False
         Interval        =   100
         Left            =   2040
         Top             =   240
      End
      Begin VB.Timer tmrSweep 
         Enabled         =   0   'False
         Interval        =   50
         Left            =   1680
         Top             =   240
      End
      Begin VB.Timer tmrPlot 
         Interval        =   50
         Left            =   1320
         Top             =   240
      End
      Begin VB.Timer tmrMeas 
         Enabled         =   0   'False
         Index           =   0
         Interval        =   15
         Left            =   960
         Top             =   240
      End
      Begin VB.Timer tmrInit 
         Interval        =   100
         Left            =   600
         Top             =   240
      End
      Begin MSComDlg.CommonDialog CommonDialog1 
         Left            =   120
         Top             =   240
         _ExtentX        =   847
         _ExtentY        =   847
         _Version        =   393216
      End
      Begin VB.Timer tmrMeas 
         Enabled         =   0   'False
         Index           =   1
         Interval        =   25
         Left            =   960
         Top             =   600
      End
   End
   Begin VB.Frame fmTests 
      Caption         =   "Tests"
      Height          =   2415
      Left            =   1920
      TabIndex        =   40
      Top             =   3480
      Width           =   1455
      Begin VB.CommandButton cmdStartProxOffset 
         Caption         =   "ProxOff"
         Height          =   255
         Left            =   120
         TabIndex        =   44
         Top             =   960
         Width           =   735
      End
      Begin VB.CommandButton cmdPxArDly 
         Caption         =   "ARDly"
         Enabled         =   0   'False
         Height          =   255
         Left            =   120
         TabIndex        =   41
         Top             =   720
         Width           =   735
      End
      Begin VB.CommandButton cmdStartAR 
         Caption         =   "Prox AR"
         Enabled         =   0   'False
         Height          =   255
         Left            =   120
         TabIndex        =   42
         Top             =   480
         Width           =   735
      End
      Begin VB.CommandButton cmdComp 
         Caption         =   "Comp"
         Enabled         =   0   'False
         Height          =   255
         Left            =   120
         TabIndex        =   43
         Top             =   240
         Width           =   735
      End
   End
   Begin VB.Frame fmTab 
      Height          =   5895
      Left            =   3360
      TabIndex        =   1
      Top             =   0
      Width           =   1815
      Begin VB.Frame frmDataStats 
         Caption         =   "Measure"
         Height          =   5655
         Left            =   120
         TabIndex        =   2
         Top             =   120
         Width           =   1575
         Begin VB.Frame fnSweep 
            Caption         =   "Sweep"
            Height          =   1335
            Left            =   120
            TabIndex        =   18
            Top             =   240
            Width           =   1335
            Begin VB.ComboBox cmbSweep 
               Height          =   315
               ItemData        =   "frmMain.ocx.frx":0D4A
               Left            =   120
               List            =   "frmMain.ocx.frx":0D5D
               TabIndex        =   19
               Text            =   "nm"
               Top             =   240
               Width           =   1095
            End
            Begin VB.Label lblElapseTime 
               Alignment       =   1  'Right Justify
               Caption         =   "0:00"
               Height          =   255
               Left            =   720
               TabIndex        =   23
               Top             =   1020
               Width           =   495
            End
            Begin VB.Label lblTimeLeft 
               Alignment       =   1  'Right Justify
               Caption         =   "0:00"
               Height          =   255
               Left            =   120
               TabIndex        =   22
               Top             =   1020
               Width           =   495
            End
            Begin VB.Label lblWaveLength 
               Caption         =   "550.0 nm"
               Height          =   255
               Left            =   120
               TabIndex        =   21
               Top             =   780
               Width           =   855
            End
            Begin VB.Label lblDegrees 
               Caption         =   "0.0 deg"
               Height          =   255
               Left            =   120
               TabIndex        =   20
               Top             =   540
               Width           =   855
            End
         End
         Begin VB.Frame frmMeas 
            Caption         =   "Proximity"
            Height          =   1335
            Index           =   1
            Left            =   120
            TabIndex        =   8
            Top             =   2880
            Width           =   1335
            Begin VB.Label lblDataStats 
               Caption         =   "Stdev"
               Height          =   255
               Index           =   7
               Left            =   120
               TabIndex        =   12
               Top             =   960
               Width           =   1155
            End
            Begin VB.Label lblDataStats 
               Caption         =   "Mean"
               Height          =   255
               Index           =   6
               Left            =   120
               TabIndex        =   11
               Top             =   720
               Width           =   1155
            End
            Begin VB.Label lblDataStats 
               Caption         =   "Value"
               Height          =   255
               Index           =   5
               Left            =   120
               TabIndex        =   10
               Top             =   480
               Width           =   1155
            End
            Begin VB.Label lblDataStats 
               Caption         =   "State"
               Height          =   255
               Index           =   4
               Left            =   120
               TabIndex        =   9
               Top             =   240
               Width           =   1155
            End
         End
         Begin VB.Frame frmMeas 
            Caption         =   "Lux"
            Height          =   1335
            Index           =   0
            Left            =   120
            TabIndex        =   3
            Top             =   1560
            Width           =   1335
            Begin VB.Label lblDataStats 
               Caption         =   "Stdev"
               Height          =   255
               Index           =   3
               Left            =   120
               TabIndex        =   7
               Top             =   960
               Width           =   1155
            End
            Begin VB.Label lblDataStats 
               Caption         =   "Mean"
               Height          =   255
               Index           =   2
               Left            =   120
               TabIndex        =   6
               Top             =   720
               Width           =   1155
            End
            Begin VB.Label lblDataStats 
               Caption         =   "Value"
               Height          =   255
               Index           =   1
               Left            =   120
               TabIndex        =   5
               Top             =   480
               Width           =   1155
            End
            Begin VB.Label lblDataStats 
               Caption         =   "State"
               Height          =   255
               Index           =   0
               Left            =   120
               TabIndex        =   4
               Top             =   240
               Width           =   1155
            End
         End
         Begin VB.Frame frmMeas 
            Caption         =   "IR"
            Height          =   1335
            Index           =   2
            Left            =   120
            TabIndex        =   13
            Top             =   4200
            Width           =   1335
            Begin VB.HScrollBar HScrIRoffset 
               Height          =   135
               Left            =   120
               Max             =   127
               TabIndex        =   24
               Top             =   240
               Value           =   15
               Width           =   1095
            End
            Begin VB.Label lblDataStats 
               Caption         =   "State"
               Height          =   255
               Index           =   8
               Left            =   120
               TabIndex        =   17
               Top             =   240
               Width           =   1155
            End
            Begin VB.Label lblDataStats 
               Caption         =   "Value"
               Height          =   255
               Index           =   9
               Left            =   120
               TabIndex        =   16
               Top             =   480
               Width           =   1155
            End
            Begin VB.Label lblDataStats 
               Caption         =   "Mean"
               Height          =   255
               Index           =   10
               Left            =   120
               TabIndex        =   15
               Top             =   720
               Width           =   1155
            End
            Begin VB.Label lblDataStats 
               Caption         =   "Stdev"
               Height          =   255
               Index           =   11
               Left            =   120
               TabIndex        =   14
               Top             =   960
               Width           =   1155
            End
         End
      End
   End
   Begin VB.Menu mnuFile 
      Caption         =   "&File"
      Begin VB.Menu mnuOpen 
         Caption         =   "&Open"
         Shortcut        =   ^O
      End
      Begin VB.Menu mnuOpenCal 
         Caption         =   "Open Cal File"
         Shortcut        =   ^L
      End
      Begin VB.Menu mnuSave 
         Caption         =   "&Save"
         Shortcut        =   ^S
      End
   End
   Begin VB.Menu mnuView 
      Caption         =   "&View"
      Begin VB.Menu mnuMonochromator 
         Caption         =   "Instruments"
      End
      Begin VB.Menu mnuThorlabsAPT 
         Caption         =   "ThorlabsAPT"
      End
      Begin VB.Menu mnuPlot 
         Caption         =   "Plot"
      End
      Begin VB.Menu mnuPwrCal 
         Caption         =   "Power Calibration"
      End
      Begin VB.Menu mnuTests 
         Caption         =   "Tests"
      End
      Begin VB.Menu mnu29038 
         Caption         =   "ISL29038"
      End
      Begin VB.Menu mnu2771 
         Caption         =   "TSL/TMD 2771"
      End
      Begin VB.Menu mnuETwindows 
         Caption         =   "ALS ET"
         Begin VB.Menu mnuAlsEt 
            Caption         =   "ALS ET"
         End
         Begin VB.Menu mnuEEprom 
            Caption         =   "EEprom"
         End
      End
      Begin VB.Menu mnuCalibration 
         Caption         =   "Calibration"
      End
      Begin VB.Menu mnuRGBscan 
         Caption         =   "RGB Scan"
      End
      Begin VB.Menu mnuRGBchromacity 
         Caption         =   "RGB Chromacity"
      End
   End
   Begin VB.Menu mnuHelp 
      Caption         =   "&Help"
      Begin VB.Menu mnuSetups 
         Caption         =   "&Setups"
      End
      Begin VB.Menu mnuAbout 
         Caption         =   "&About"
      End
   End
End
Attribute VB_Name = "frmMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Option Explicit

Private Declare Function inport Lib "inpout32.dll" Alias "Inp32" (ByVal a As Integer) As Integer
Private Declare Sub outport Lib "inpout32.dll" Alias "Out32" (ByVal a As Integer, ByVal D As Integer)

Private deviceSelected As Boolean
Private formLoaded As Boolean
Private ucPlot_Height As Long, ucPlot_Width As Long

Dim gI2cAddr As Long

Const LPT As Integer = &H37A ' base + 2 (Control)

Public pUsb As Object

Enum cmdInitIndex
    eInit
    eRun
    eStop
End Enum

Enum optGlassAout
    Device
    glass
    aout
End Enum

Dim IOreg As reg38 ' Field I/O

Dim gHeading As String
Dim gFastSweepEnabled As Boolean
Dim gFastSweep1stValueRecorded(2, 3) As Boolean

'Dim measureTrigger As Single

Public measLux As Double, measIR As Double ' measurements
Dim measProx() As Double
Public measSprox As Double
Public meanLux As Double, meanIR As Double, meanProx As Double

' Thread (timer) flags
Public measLuxValid As Boolean, measIRValid As Boolean
Dim measProxValid() As Boolean
Dim sweepValid As Boolean
Dim dataCaptured As Boolean
Dim testValid

Public irdr As Long, nIrdr As Long
Public incIRDR As Boolean ' cycle through irdr value (for proximity)

' for time left & fastsweep inc
Dim startTime As Long
Dim startLoop As Double
Dim stopLoop As Double
Dim stepLoop As Double
Dim posIndex As Double

Dim initScriptDone As Boolean

' _________
' Constants
' ¯¯¯¯¯¯¯¯¯

Const cAngleSweep As Integer = vbChecked
Const cMinMeasureInterval As Integer = 25
Const cAlsMeasureInterval As Integer = 100

Public Function getMeasProx(i As Integer) As Double
    getMeasProx = measProx(i)
End Function

Public Function getMeasProxValid(i As Integer) As Boolean
    getMeasProxValid = measProxValid(i)
End Function

Public Sub setMeasProxValid(i As Integer, val As Boolean)
    measProxValid(i) = val
End Sub

Private Sub cbAvgIR_Click()
    If cbAvgIR.value = vbChecked Then
        cbAvgIR.caption = "Average"
    Else
        cbAvgIR.caption = "Single"
    End If
End Sub

Private Sub cbCalLux_Click()
    Static caption As String, ToolTipText As String
    
    If caption = "" Then
        caption = cbCalLux.caption
        ToolTipText = cbCalLux.ToolTipText
    End If
    
    
    If cbCalLux.value = vbChecked Then
        cbCalLux.caption = "Lux=Cal"
        cbCalLux.ToolTipText = ToolTipText
    Else
        cbCalLux.caption = caption
        cbCalLux.ToolTipText = ToolTipText
    End If
End Sub

Private Sub cbCompEnable_Click()

    If cbCompEnable.value = vbChecked Then
        cbCompEnable.caption = "Comp=OFF"
        ucALSusb1.dSetIRcomp 0
    Else
        cbCompEnable.caption = "Comp=ON"
        ucALSusb1.dSetIRcomp 1
    End If
    
End Sub

Private Sub cbCycleIRDR_Click()
    If cbCycleIRDR.value Then
        cbCycleIRDR.caption = "IRDR:Cycle"
        incIRDR = True
    Else
        cbCycleIRDR.caption = "IRDR:Static"
        incIRDR = False
    End If
End Sub

Private Sub cbLPT_Click(Index As Integer)
    Const base As Integer = &H378
    Static data As Integer
    If cbLPT(Index) = vbChecked Then
        data = data Or 2 ^ Index
    Else
        data = data And (255 - 2 ^ Index)
    End If
    outport base, data
End Sub

Private Sub cbRunStop_Click()
    Static caption As String, ToolTipText As String
    
    If caption = "" Then
        caption = cbRunStop.caption
        ToolTipText = cbRunStop.ToolTipText
    End If
    
    Static tmrMeas0 As Boolean, tmrMeas1 As Boolean
    Static tmrPlot_ As Boolean, tmrSweep_ As Boolean
    If cbRunStop.value = vbChecked Then
        cbRunStop.caption = "Stopped"
        cmdRun.enabled = False
        tmrMeas0 = tmrMeas(0).enabled: tmrMeas(0).enabled = False
        tmrMeas1 = tmrMeas(1).enabled: tmrMeas(1).enabled = False
        tmrPlot_ = tmrPlot.enabled: tmrPlot.enabled = False
        tmrSweep_ = tmrSweep.enabled: tmrSweep.enabled = False
    Else
        cbRunStop.caption = caption
        cmdRun.enabled = True
        tmrMeas(0).enabled = tmrMeas0
        tmrMeas(1).enabled = tmrMeas1
        tmrPlot.enabled = tmrPlot_
        tmrSweep.enabled = tmrSweep_
    End If
End Sub

Public Sub cmbSweep_Click()

    sweepValid = False
    frmPlot.cbPlotOnOff.value = vbChecked ' turn plot off

    Call ucALSusb1.dGetPartFamily(gPartNumber)
    
    If gPartNumber <> 29038 And cmbSweep.ListIndex = nm_comp Then
        MsgBox ("No Comp for this device")
        GoTo errorExit
    Else
        gSweepType = cmbSweep.ListIndex
    End If
    
    If gSweepType = nm Or gSweepType = nm_deg Or gSweepType = nm_comp Then
        Call frmMonochromator.Show(0, Me)
    End If
    
    If gSweepType = deg Or gSweepType = mm Or gSweepType = nm_deg Then
        Call frmThorlabsAPT.Show(0, Me)
    End If
        
errorExit:
End Sub

Private Sub cmdTimersRead_Click()
    Dim i As Integer
    i = i + 0: If tmrInit.enabled Then cbTimers(i).value = vbChecked Else cbTimers(i).value = vbUnchecked
    i = i + 1: If tmrMeas(0).enabled Then cbTimers(i).value = vbChecked Else cbTimers(i).value = vbUnchecked
    i = i + 1: If tmrMeas(1).enabled Then cbTimers(i).value = vbChecked Else cbTimers(i).value = vbUnchecked
    i = i + 1: If tmrPlot.enabled Then cbTimers(i).value = vbChecked Else cbTimers(i).value = vbUnchecked
    i = i + 1: If tmrSweep.enabled Then cbTimers(i).value = vbChecked Else cbTimers(i).value = vbUnchecked
    i = i + 1: If tmrGlassAout.enabled Then cbTimers(i).value = vbChecked Else cbTimers(i).value = vbUnchecked
    
    i = i + 1: If tmrComp.enabled Then cbTimers(i).value = vbChecked Else cbTimers(i).value = vbUnchecked
    i = i + 1: If tmrAR.enabled Then cbTimers(i).value = vbChecked Else cbTimers(i).value = vbUnchecked
    i = i + 1: If tmrPxArDly.enabled Then cbTimers(i).value = vbChecked Else cbTimers(i).value = vbUnchecked
    i = i + 1: If tmrProxOffset.enabled Then cbTimers(i).value = vbChecked Else cbTimers(i).value = vbUnchecked
    i = 0
    i = i + 0: lblTimers(i) = tmrInit.Interval
    i = i + 1: lblTimers(i) = tmrMeas(0).Interval
    i = i + 1: lblTimers(i) = tmrMeas(1).Interval
    i = i + 1: lblTimers(i) = tmrPlot.Interval
    i = i + 1: lblTimers(i) = tmrSweep.Interval
    i = i + 1: lblTimers(i) = tmrGlassAout.Interval
    '6
    i = i + 1: lblTimers(i) = tmrComp.Interval
    i = i + 1: lblTimers(i) = tmrAR.Interval
    i = i + 1: lblTimers(i) = tmrPxArDly.Interval
    i = i + 1: lblTimers(i) = tmrProxOffset.Interval

End Sub

Private Sub cbTimers_Click(Index As Integer)
    
    Select Case Index
    
    Case 0: If cbTimers(Index).value = vbChecked Then tmrInit.enabled = True Else tmrInit.enabled = False
    Case 1: If cbTimers(Index).value = vbChecked Then tmrMeas(0).enabled = True Else tmrMeas(0).enabled = False
    Case 2: If cbTimers(Index).value = vbChecked Then tmrMeas(1).enabled = True Else tmrMeas(1).enabled = False
    Case 3: If cbTimers(Index).value = vbChecked Then tmrPlot.enabled = True Else tmrPlot.enabled = False
    Case 4: If cbTimers(Index).value = vbChecked Then tmrSweep.enabled = True Else tmrSweep.enabled = False
    Case 5: If cbTimers(Index).value = vbChecked Then tmrGlassAout.enabled = True Else tmrGlassAout.enabled = False
    
    Case 6: If cbTimers(Index).value = vbChecked Then tmrComp.enabled = True Else tmrComp.enabled = False
    Case 7: If cbTimers(Index).value = vbChecked Then tmrAR.enabled = True Else tmrAR.enabled = False
    Case 8: If cbTimers(Index).value = vbChecked Then tmrPxArDly.enabled = True Else tmrPxArDly.enabled = False
    Case 9: If cbTimers(Index).value = vbChecked Then tmrProxOffset.enabled = True Else tmrProxOffset.enabled = False
    
    End Select

End Sub

Private Sub Form_Load()

    Dim i As Integer
    
    'outport LPT, 4 ' Hi-Z

    If formLoaded = False Then
    
        ReDim measProx(0): ReDim measProxValid(0)
        
        For i = 0 To 3: frmPlot.ucPlot1(i).setPlotSize (100): Next i
    
        Call ucALSusb1.setHwnd(Me.hWnd)
    
        gHeading = caption
        
        formLoaded = True
        
        sweepValid = True
        
    End If
    
    'Call frmPlot.Show(0, Me)
    'Call frmDeviceEnable.Show(0, Me)
    
    initScript
    If scriptFileName <> "" Then script scriptFileName
    
    cmdTimersRead_Click
    
    txtIO(0).text = "0" & Chr$(13)
    
    'Load frmRGBscan
    
End Sub

Private Sub startUp()
    Static done As Boolean
    
    If Not done Then
        Call ucALSusb1.setI2cAddr(&H88)
        Call ucALSusb1.setDevice("ISL29038")
        Call frmEtIo.Show(0, Me)
        done = True
    End If
    
End Sub

Private Sub Form_Unload(Cancel As Integer)
    End
End Sub

Private Sub mnu2771_Click()
    Call frm2771.Show(0, Me)
End Sub

Private Sub mnu29038_Click()
    Call frm29038.Show(0, Me)
End Sub

Private Sub mnuAbout_Click()
    Call frmAbout.Show(0, Me)
End Sub

Public Sub mnuAlsEt_Click()
    Call frmEtIo.Show(0, Me)
End Sub

Private Sub mnuCalibration_Click()
    Call frmPwrCal.Show(0, Me)
End Sub

Private Sub mnuEEprom_Click()
    Call frmEEprom.Show(0, Me)
End Sub

Private Sub mnuOpen_Click()

    If Not initScriptDone Then initScript
    
    CommonDialog1.ShowOpen
    script CommonDialog1.fileName
    
End Sub

Public Sub initScript()

    Call modScript.initALS(ucALSusb1)
    Call modScript.initApp(Me)
    Call modScript.initTlb(frmThorlabsAPT)
    Call modScript.initPlt(frmPlot)
    Call modScript.initIns(frmMonochromator)
    Call modScript.initMsg(frmPrompt)
    Call modScript.initTst(frmTest)
    
    initScriptDone = True
End Sub

Private Sub mnuOpenCal_Click()
    CommonDialog1.ShowOpen
    readMonoCalFile CommonDialog1.fileName
End Sub

Public Sub mnuMonochromator_Click()
    Call frmMonochromator.Show(0, Me)
End Sub

Private Sub mnuPwrCal_Click()
    Call frmPwrCal.Show(0, Me)
End Sub

Private Sub mnuRGBchromacity_Click()
    Call frmSimpleRGB.Show(0, Me)
End Sub

Public Sub mnuRGBscan_Click()
    Call frmRGBscan.Show(0, Me)
End Sub

Private Sub mnuSetups_Click()
    Call frmHelp.Show(0, Me)
End Sub

Public Sub mnuTests_Click()
    Call frmTest.Show(0, Me)
End Sub

Private Sub mnuThorlabsAPT_Click()
    Call frmThorlabsAPT.Show(0, Me)
End Sub

Private Sub mnuPlot_Click()
    Call frmPlot.Show(0, Me)
End Sub

Private Sub tmrInit_Timer()

    Dim usb As String
    usb = ucALSusb1.getUSBcaption()
    
    If cmdDefaultStartUpEnabled.Visible = True Then startUp
    
    If usb <> "" Then
        caption = gHeading & " " & usb
        Call ucALSusb1.dGetPartFamily(gPartNumber)
        If (29000 <= gPartNumber And gPartNumber <= 29200) Or gPartNumber = 2771 Then
            tmrInit.enabled = False
            'tmrMeas(0).enabled = True: tmrMeas(1).enabled = True
            opGlassAout(0).value = True
            opGlassAout(1).enabled = False
            opGlassAout(2).enabled = False
            frmGlassAnalog.enabled = False
            
            If gPartNumber = 29038 Then Call frm29038.Show(0, Me)
            
            cmdTimersRead_Click
        
        Else
            gPartNumber = 0
        End If
        
        
    End If
    
End Sub

Private Sub opGlassAout_Click(Index As Integer)
    ucALSusb1.Visible = False
    tmrInit.enabled = False
    tmrGlassAout.enabled = True
End Sub

Private Sub tmrGlassAout_Timer()

    If opGlassAout(2).value = True Then 'Aout: use DVM
        measLux = 0
    Else ' must be OPM (1 or 3)
        measLux = frmMonochromator.ucMonochromator1.getPower
        If opGlassAout(1).value = True Then measLux = getCalibratedLux(measLux, False)
    End If
    
    measLuxValid = True ' use ALS plot
    measIRValid = True

End Sub

Private Sub tmrMeas_Timer(Index As Integer)
    Dim i As Integer
    Dim enable As Long
    Dim sidx As Long, nslp As Long, slist() As Long
    Dim m As Double, s As Double
    Dim fmt As String
    
    If gPartNumber > 0 Then
        If ucALSusb1.dGetEnable(Index, enable) Then
            GoTo errorSub
        Else
        End If
    End If
    If enable Then
    
        If Index Then
            
            If ucALSusb1.dGetNirdr(nIrdr) Then
                GoTo errorSub
            Else
                If UBound(measProx, 1) < nIrdr Then ReDim measProx(nIrdr): ReDim measProxValid(nIrdr)
                If ucALSusb1.dGetIrdr(irdr) Then
                    GoTo errorSub
                Else
                End If
            End If
        
            If ucALSusb1.dGetProximity(measProx(irdr)) Then
                GoTo errorSub
            Else
            
                measSprox = measProx(irdr) ' latest only
                
                If incIRDR Then
                    measProxValid(irdr) = True
                Else
                    For i = 0 To nIrdr - 1: measProxValid(i) = True: Next i
                End If
                lblDataStats(4 * Index + 1).caption = "Proximity=" & format(measProx(irdr), "0.000")
            End If
            
            ' ================
            ' 29030 IR/Washout
            ' ================
            If gPartNumber = 29030 Then
                If ucALSusb1.dGetProxIR(measIR) Then
                    GoTo errorSub
                Else
                    If cbCalLux.value Then
                        measIR = Abs(measIR - HScrIRoffset.value / HScrIRoffset.max)
                        measIR = getCalibratedLux(measIR)
                    End If
                    measIRValid = True
                    lblDataStats(4 * (Index + 1) + 0).caption = ""
                    lblDataStats(4 * (Index + 1) + 1).caption = getIRavg
                    lblDataStats(4 * (Index + 1) + 2).caption = ""
                    lblDataStats(4 * (Index + 1) + 3).caption = ""
                End If
            End If
            
            ' ================
            ' 29038 IR/Washout
            ' ================
            If gPartNumber = 29038 Then
                If ucALSusb1.dGetIR(measIR) Then
                    GoTo errorSub
                Else
                    If cbCalLux.value Then
                        measIR = Abs(measIR - HScrIRoffset.value / HScrIRoffset.max)
                        measIR = getCalibratedLux(measIR)
                    End If
                    measIRValid = True
                    lblDataStats(4 * (Index + 1) + 0).caption = ""
                    lblDataStats(4 * (Index + 1) + 1).caption = getIRavg
                    lblDataStats(4 * (Index + 1) + 2).caption = ""
                    lblDataStats(4 * (Index + 1) + 3).caption = ""
                End If
            End If
            
            ' increment irdr if needed
            If incIRDR Then
                irdr = irdr + 1
                If irdr >= nIrdr Then irdr = 0
                If ucALSusb1.dSetIrdr(irdr) Then
                    GoTo errorSub
                Else
                    If gPartNumber = 29038 Then
                        If ucALSusb1.dSetProxOffset(g38ProxOffset(irdr).maxVal) Then GoTo errorSub
                    End If
                End If
            End If
            
            ' ===================================
            ' Adjust timer interval to sleep time
            ' ===================================
            If ucALSusb1.dGetNsleep(nslp) Then
                GoTo errorSub
            Else
            End If
            
            ReDim slist(nslp) As Long
            If ucALSusb1.dGetSleep(sidx) Then
                GoTo errorSub
            Else
            End If
            
            ' adjust measure interval based on sleep time setting
            If ucALSusb1.dGetSleepList(slist(0)) Then
                GoTo errorSub
            Else
                If slist(sidx) > cMinMeasureInterval Then
                    tmrMeas(Index).Interval = slist(sidx)
                Else
                    tmrMeas(Index).Interval = cMinMeasureInterval
                End If
            End If
            
        Else
            ' Lux
            If ucALSusb1.dGetLux(measLux) Then
                GoTo errorSub
            Else
                measLuxValid = True
                
                If gPartNumber = 29038 Then
                    measLux = measLux * frm29038.alsMult
                    If frm29038.alsMult > 1 Then ' 8 bit mode
                        tmrMeas(Index).Interval = cMinMeasureInterval
                    Else
                        tmrMeas(Index).Interval = cAlsMeasureInterval
                    End If
                End If
                
                If cbCalLux.value Then measLux = getCalibratedLux(measLux)
                lblDataStats(4 * Index + 1).caption = "Lux=" & format(measLux, "0.000")
            End If
            
        End If
        
        
        ' mean stDev
        If ucALSusb1.dGetStats(Index * 2, m, s) Then
            GoTo errorSub
        Else
            lblDataStats(4 * Index + 0).caption = "" '"State="
            
            If Index Then
                fmt = "0.000"
            Else
                fmt = "0.0"
                
                If gPartNumber = 29038 Then
                    m = m * frm29038.alsMult
                    s = s * frm29038.alsMult
                End If
                
                If cbCalLux.value Then m = getCalibratedLux(m): s = getCalibratedLux(s)
            End If
            
            If m <> 0 Then
                lblDataStats(4 * Index + 0).caption = "Stdev(%)=" & format(s / m * 100#, "0.0")
                If (Abs(s / m * 100#) < 2) Or (Abs(s) < 0.008) Then
                    lblDataStats(4 * Index + 2).BackColor = vbGreen
                Else
                    lblDataStats(4 * Index + 2).BackColor = &H8000000F
                End If
            End If
            
            If Index Then
                meanProx = m
            Else
                meanLux = m
            End If
            
            lblDataStats(4 * Index + 2).caption = "Mean=" & format(m, fmt)
            lblDataStats(4 * Index + 3).caption = "Stdev=" & format(s, fmt)
            
        End If
    Else ' enable valid measurements for disabled channels to allow plot
        If Index Then
            measIRValid = True
            For i = 1 To nIrdr: measProxValid(i - 1) = True: Next i
        Else
            measLuxValid = True
            If gPartNumber <> 29038 Then measIRValid = True ' JWG kludge
        End If
    End If
    GoTo exitSub
errorSub:
exitSub:
End Sub

Function getIRavg() As String
    Const sz As Integer = 30
    Static meas(sz - 1) As Single, ptr As Integer, sum As Single
    
    sum = sum - meas(ptr) + measIR
    meas(ptr) = measIR
    ptr = (ptr + 1) Mod sz
        
    If cbAvgIR.value = vbChecked Then
        getIRavg = "IR=" & format(sum / sz, "0.000")
    Else
        getIRavg = "IR=" & format(measIR, "0.000")
    End If
    
End Function

Public Sub send2plot(ByVal pdt As plotDataType, ByVal value As Double, Optional ByVal instance As Integer = 1)

    Static lastVal(2, 3, 1) As Double 'plotDataType, instance, xy
    Static lastIndex(2, 3) As Integer
    Dim thisIndex As Integer
    Dim dY As Double, dX As Double, slp As Double
    
    If gFastSweepEnabled Then
    
        If gFastSweep1stValueRecorded(pdt, instance - 1) Then
        
            thisIndex = posIndex - (posIndex Mod 1)
            
            If thisIndex - lastIndex(pdt, instance - 1) > 0 Then ' transition
            
If thisIndex - lastIndex(pdt, instance - 1) > 1 Then
debugPrint thisIndex, thisIndex - lastIndex(pdt, instance - 1)
End If

                dY = value - lastVal(pdt, instance - 1, 1)
                dX = posIndex - lastVal(pdt, instance - 1, 0)
                slp = dY / dX
                dX = thisIndex - lastVal(pdt, instance - 1, 0)
                dY = slp * dX
                dY = dY + lastVal(pdt, instance - 1, 1)
                Call frmPlot.plotData(pdt, dY, instance)
                lastIndex(pdt, instance - 1) = thisIndex
            End If
            
        Else
            Call frmPlot.plotData(pdt, value, instance)
            lastIndex(pdt, instance - 1) = 0
            gFastSweep1stValueRecorded(pdt, instance - 1) = True
        End If
        
        lastIndex(pdt, instance - 1) = thisIndex
        lastVal(pdt, instance - 1, 0) = posIndex
        lastVal(pdt, instance - 1, 1) = value
        
    Else

        Call frmPlot.plotData(pdt, value, instance)
    
    End If
End Sub




Private Sub tmrPlot_Timer()
    Dim i As Integer, dataValid As Boolean
    
    dataValid = measLuxValid And measIRValid
    For i = 1 To nIrdr: dataValid = dataValid And measProxValid(i - 1): Next i
    dataValid = dataValid And (sweepValid Or Not tmrSweep.enabled)
    dataValid = dataValid And (testValid Or Not tmrAR.enabled)
    
    If dataValid Or 1 Then
        measLuxValid = False: measIRValid = False: sweepValid = False
        For i = 1 To nIrdr: measProxValid(i - 1) = False: Next i
        
        Call send2plot(pdALS, measLux)
        Call send2plot(pdIR, measIR)
        If incIRDR Then
            For i = 1 To nIrdr: Call send2plot(pdProx, measProx(nIrdr - i), i): Next i
        Else
            If testValid Then ' JWG kludge
                Call send2plot(pdProx, meanProx)
                testValid = False
            Else
                Call send2plot(pdProx, measProx(irdr))
            End If
        End If
        
        dataCaptured = True
    End If
End Sub

Private Sub updateElapseTime(sweepPositon As Single)
    Dim min As Long, sec As Long, Time As Long

    Time = GetTickCount - startTime
    sec = Time / 1000
    min = sec / 60 - 0.5: sec = sec - min * 60
    lblElapseTime.caption = min & ":" & format(sec, "00")
    If (sweepPositon - startLoop) <> 0 Then
        sec = (Time * (stopLoop - sweepPositon) / (sweepPositon - startLoop)) / 1000
        min = sec / 60 - 0.5: sec = sec - min * 60
        lblTimeLeft.caption = min & ":" & format(sec, "00")
    End If
End Sub


Private Sub startSingleSweep(Source As Object, XaxisLabel As String)
    startLoop = Source.getStart
    stopLoop = Source.getStop
    stepLoop = Source.getStep
    setPlotSize (stopLoop - startLoop) / stepLoop + 1
    Call setXlables(startLoop, stopLoop, XaxisLabel)
End Sub

Private Sub cmdRun_Click()
    Dim i As Integer, j As Integer
    
    startTime = GetTickCount
    
    Select Case gSweepType
    Case nm: Call startSingleSweep(frmMonochromator.ucMonochromator1, "nm")
    Case mm: Call startSingleSweep(frmThorlabsAPT.ucThorlabsAPT1(0), "mm")
    Case deg: Call startSingleSweep(frmThorlabsAPT.ucThorlabsAPT1(0), "deg")
    End Select

    If gSweepType = mm Or gSweepType = deg Then
        gFastSweepEnabled = frmThorlabsAPT.ucThorlabsAPT1(0).getFastSweepEnabled
    Else
        gFastSweepEnabled = False
    End If
    
    For i = 0 To 2: For j = 0 To 3
        gFastSweep1stValueRecorded(i, j) = False
    Next j: Next i
    
    frmPlot.cbPlotOnOff.value = vbUnchecked ' turn plot on
    sweepValid = True ' define arm position as valid
    tmrSweep.enabled = True
    
End Sub

Private Function incSweepValue(Source As Object, lbl As label, Unit As String) As Single

    If Not Source.done Then
            
        Source.nextStep
        incSweepValue = Source.getValue
        posIndex = (incSweepValue - startLoop) / stepLoop
                
        lbl.caption = format(incSweepValue, Unit)
                
        updateElapseTime (incSweepValue)
                
        sweepValid = True
    Else
        gFastSweepEnabled = False
        tmrSweep.enabled = False
        frmPlot.cbPlotOnOff.value = vbChecked ' turn plot off
    End If
    
End Function

Private Sub tmrSweep_Timer()
    Dim value As Single
    
    If dataCaptured Then
    
        Select Case gSweepType
        Case nm: gSetWaveLength = incSweepValue(frmMonochromator.ucMonochromator1, lblWaveLength, "#####.0 nm")
        Case mm: gSetDistance = incSweepValue(frmThorlabsAPT.ucThorlabsAPT1(0), lblDegrees, "###.0 mm")
        Case deg: gSetAngle = incSweepValue(frmThorlabsAPT.ucThorlabsAPT1(0), lblDegrees, "###.0 deg")
        End Select
        
        dataCaptured = False
        
        If cbLoopRun.value = vbChecked And tmrSweep.enabled = False And HScrLoopRun.value > HScrLoopRun.min Then
            HScrLoopRun.value = HScrLoopRun.value - 1
            Call frmPlot.cmdSend2Excel_Click
            
            If HScrLoopRun.value > 0 Then
            
                Select Case gSweepType
                Case nm: Call frmMonochromator.ucMonochromator1.startSweep
                Case mm, deg: Call frmThorlabsAPT.ucThorlabsAPT1(0).arm
                End Select
                
                cmdRun_Click
                
            End If
        End If
        
    End If

End Sub


' +______________+
' | TEST CLASSES |
' +¯¯¯¯¯¯¯¯¯¯¯¯¯¯+

Private Function nextDevice()
    
    Dim dnum As Integer
    
    dnum = frmEtIo.getNextEnabled(HScrLoopRun.max - HScrLoopRun.value)
    
    If dnum >= 0 Then
    
        HScrLoopRun.value = HScrLoopRun.max - dnum
        
        If frmThorlabsAPT.srEnabled Then If Not frmThorlabsAPT.done Then frmThorlabsAPT.nextSR dnum
        
        Call frmPlot.selectDevice(dnum)

        frmEtIo.selectDevice dnum
        
    End If
    
End Function

Private Sub HScrLoopRun_Change()
    cbLoopRun.caption = "LpRun:" & HScrLoopRun.value
    If HScrLoopRun.value = 0 Then cbLoopRun.value = vbUnchecked
End Sub

Function loopRun() As Boolean
    If cbLoopRun.value = vbChecked And tmrSweep.enabled = False And HScrLoopRun.value > HScrLoopRun.min Then
        HScrLoopRun.value = HScrLoopRun.value - 1
        ' send Device Rev Register
        Call frmPlot.cmdSend2Excel_Click
        If HScrLoopRun.value > 0 Then
            nextDevice
            loopRun = True
        End If
    End If
End Function


' +____________________+
' | GLASS COMPENSATION |
' +¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯+

Public Sub cmdComp_Click()

    Static initDone As Boolean
    
    If Not initDone Then Set testComp = New clsTestComp: initDone = True
    
    If Not tmrComp.enabled Then
        tmrComp.enabled = True
        testComp.arm
    End If

End Sub

Private Sub tmrComp_Timer()
    If testComp.done Then
        tmrComp.enabled = False
        If loopRun Then cmdComp_Click
    Else
        testComp.next_
    End If
End Sub

' +_____________________________+
' | PROXIMITY AMBIENT REJECTION |
' +¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯+

Public Sub cmdStartAR_Click()
    
    Static initDone As Boolean
    
    If Not initDone Then Set testProxAR = New clsTestProxAR: initDone = True
    
    If Not tmrAR.enabled Then
        tmrAR.enabled = True
        testProxAR.arm
    End If

End Sub

Private Sub tmrAR_Timer()
    If testProxAR.done Then
        tmrAR.enabled = False
        If loopRun Then cmdStartAR_Click
    Else
        testProxAR.next_
    End If
End Sub

' +__________________+
' | PROXIMITY OFFSET |
' +¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯+

Public Sub cmdStartProxOffset_Click()
    
    Static initDone As Boolean
    
    If Not initDone Then Set testProxOffset = New clsTestProxOffset: initDone = True
    
    If Not tmrProxOffset.enabled Then
        tmrProxOffset.enabled = True
        testProxOffset.arm
    End If

End Sub

Private Sub tmrProxOffset_Timer()
    If testProxOffset.done Then
        tmrProxOffset.enabled = False
        If loopRun Then cmdStartProxOffset_Click
    Else
        testProxOffset.next_
    End If
End Sub

' +____________________________________________+
' | PROXIMITY AMBIENT REJECTION vs. IRDR Delay |
' +¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯+

Public Sub cmdPxArDly_Click()
    
    Static initDone As Boolean
    
    If Not initDone Then Set testProxARdly = New clsTestProxARvsDelay: initDone = True
    
    If Not tmrPxArDly.enabled Then
        tmrPxArDly.enabled = True
        testProxARdly.arm
    End If

End Sub

Private Sub tmrPxArDly_Timer()
    If testProxARdly.done Then
        tmrPxArDly.enabled = False
        If loopRun Then cmdPxArDly_Click
    Else
        testProxARdly.next_
    End If
End Sub




' +___________+
' | Field I/O |
' +¯¯¯¯¯¯¯¯¯¯¯+
Private Sub cmbIO_Change(Index As Integer)
    cmbIO_Click Index
End Sub

Private Sub cmbIO_Click(Index As Integer)
    Select Case Index
    Case 0: IOreg.s = cmbIO(Index).text
    Case 1: IOreg.m = "&H" & cmbIO(Index).text
    End Select
End Sub

Private Sub cmdClrShiftMask_Click()
    cmbIO(0).text = "0" ' shift
    cmbIO(1).text = "FF" ' shift
End Sub

Private Sub txtIO_Change(Index As Integer)
    Dim D As Byte, readEn As Boolean
    
    On Error GoTo subExit
    
    If enterText(txtIO(Index).text) Then
        If Index Then ' write field on data change
            D = "&H" & txtIO(Index).text
            Call ucALSusb1.dWriteField(IOreg.a, IOreg.s, IOreg.m, D)
        Else          ' read field on address change
            IOreg.a = "&H" & txtIO(Index).text
            readEn = True
        End If
        
        IOreg.s = cmbIO(0).text: IOreg.m = "&H" & cmbIO(1).text
        
        If cbEcho.value Or readEn Then
            Call ucALSusb1.dReadField(IOreg.a, IOreg.s, IOreg.m, D)
        End If
            
        txtIO(0).text = Hex(IOreg.a)
        txtIO(1).text = Hex(D)
    
    End If
subExit:
End Sub


