VERSION 5.00
Begin VB.Form frmTest 
   Caption         =   "Tests"
   ClientHeight    =   6765
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   6015
   Icon            =   "frmTest.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   6765
   ScaleWidth      =   6015
   StartUpPosition =   3  'Windows Default
   Begin VB.Frame frmParams 
      Caption         =   "Params"
      Height          =   1215
      Left            =   4080
      TabIndex        =   70
      Top             =   120
      Width           =   1815
      Begin VB.CheckBox cbSingleDevice 
         Caption         =   "Palette Card"
         Height          =   255
         Left            =   120
         Style           =   1  'Graphical
         TabIndex        =   72
         Top             =   480
         Width           =   1575
      End
      Begin VB.CheckBox cb38PoffAdjEn 
         Caption         =   "38-Poff:On"
         Height          =   255
         Left            =   120
         Style           =   1  'Graphical
         TabIndex        =   71
         Top             =   240
         Value           =   1  'Checked
         Width           =   1575
      End
   End
   Begin VB.Frame Frame4 
      Caption         =   "Y-Axis Input"
      Height          =   2055
      Left            =   2040
      TabIndex        =   43
      Top             =   1440
      Width           =   3855
      Begin VB.OptionButton optMeas 
         Caption         =   "RGB"
         Height          =   255
         Index           =   5
         Left            =   840
         TabIndex        =   75
         Top             =   240
         Width           =   735
      End
      Begin VB.OptionButton optMeas 
         Caption         =   "CM"
         Height          =   255
         Index           =   4
         Left            =   3120
         TabIndex        =   74
         Top             =   600
         Width           =   615
      End
      Begin VB.OptionButton optMeas 
         Caption         =   "LM"
         Height          =   255
         Index           =   3
         Left            =   3120
         TabIndex        =   62
         Top             =   240
         Width           =   615
      End
      Begin VB.Frame frmMeasDut 
         Height          =   1455
         Left            =   120
         TabIndex        =   47
         Top             =   480
         Visible         =   0   'False
         Width           =   2895
         Begin VB.Frame Frame6 
            Caption         =   "Cycle Range"
            Height          =   1215
            Left            =   960
            TabIndex        =   52
            Top             =   120
            Width           =   1815
            Begin VB.CheckBox cbRngCycle 
               Caption         =   "R0:n"
               Height          =   255
               Index           =   3
               Left            =   960
               TabIndex        =   56
               Top             =   840
               Width           =   735
            End
            Begin VB.CheckBox cbRngCycle 
               Caption         =   "R0:n"
               Height          =   255
               Index           =   2
               Left            =   120
               TabIndex        =   55
               Top             =   840
               Width           =   735
            End
            Begin VB.CheckBox cbRngCycle 
               Caption         =   "R0:n"
               Height          =   255
               Index           =   1
               Left            =   120
               TabIndex        =   54
               Top             =   600
               Width           =   735
            End
            Begin VB.CheckBox cbRngCycle 
               Caption         =   "R0:n"
               Height          =   255
               Index           =   0
               Left            =   120
               TabIndex        =   53
               Top             =   360
               Width           =   735
            End
            Begin VB.Label Label1 
               Caption         =   "IRDR"
               Height          =   255
               Left            =   960
               TabIndex        =   57
               Top             =   600
               Width           =   615
            End
         End
         Begin VB.CheckBox cbDutMeas 
            Caption         =   "PRX30"
            Height          =   255
            Index           =   3
            Left            =   120
            TabIndex        =   51
            Top             =   240
            Width           =   855
         End
         Begin VB.CheckBox cbDutMeas 
            Caption         =   "PRX"
            Height          =   255
            Index           =   2
            Left            =   120
            TabIndex        =   50
            Top             =   960
            Width           =   855
         End
         Begin VB.CheckBox cbDutMeas 
            Caption         =   "IR"
            Height          =   255
            Index           =   1
            Left            =   120
            TabIndex        =   49
            Top             =   720
            Width           =   855
         End
         Begin VB.CheckBox cbDutMeas 
            Caption         =   "ALS"
            Height          =   255
            Index           =   0
            Left            =   120
            TabIndex        =   48
            Top             =   480
            Width           =   855
         End
      End
      Begin VB.OptionButton optMeas 
         Caption         =   "OPM"
         Height          =   255
         Index           =   2
         Left            =   2280
         TabIndex        =   46
         Top             =   240
         Width           =   735
      End
      Begin VB.OptionButton optMeas 
         Caption         =   "DVM"
         Height          =   255
         Index           =   1
         Left            =   1560
         TabIndex        =   45
         Top             =   240
         Width           =   735
      End
      Begin VB.OptionButton optMeas 
         Caption         =   "DUT"
         Height          =   255
         Index           =   0
         Left            =   120
         TabIndex        =   44
         Top             =   240
         Width           =   735
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "X-Axis Input"
      Height          =   2295
      Left            =   120
      TabIndex        =   36
      Top             =   1200
      Width           =   1815
      Begin VB.OptionButton optSrc 
         Caption         =   "Angle: 3d"
         Height          =   255
         Index           =   7
         Left            =   120
         TabIndex        =   69
         ToolTipText     =   "Large Palette Angle"
         Top             =   1200
         Width           =   1455
      End
      Begin VB.OptionButton optSrc 
         Caption         =   "Angle: NpXps"
         Height          =   255
         Index           =   6
         Left            =   120
         TabIndex        =   58
         ToolTipText     =   "Large Palette Angle"
         Top             =   960
         Width           =   1455
      End
      Begin VB.OptionButton optSrc 
         Caption         =   "XY pos"
         Enabled         =   0   'False
         Height          =   255
         Index           =   5
         Left            =   120
         TabIndex        =   42
         ToolTipText     =   "Aperature Test"
         Top             =   1920
         Width           =   855
      End
      Begin VB.OptionButton optSrc 
         Caption         =   "CT"
         Enabled         =   0   'False
         Height          =   255
         Index           =   4
         Left            =   120
         TabIndex        =   41
         Top             =   1680
         Width           =   855
      End
      Begin VB.OptionButton optSrc 
         Caption         =   "Power"
         Enabled         =   0   'False
         Height          =   255
         Index           =   3
         Left            =   120
         TabIndex        =   40
         ToolTipText     =   "Light Table LED Power"
         Top             =   1440
         Width           =   855
      End
      Begin VB.OptionButton optSrc 
         Caption         =   "Wavelength"
         Height          =   255
         Index           =   2
         Left            =   120
         TabIndex        =   39
         ToolTipText     =   "Monochromator"
         Top             =   480
         Width           =   1335
      End
      Begin VB.OptionButton optSrc 
         Caption         =   "Distance"
         Height          =   255
         Index           =   1
         Left            =   120
         TabIndex        =   38
         ToolTipText     =   "Proximity"
         Top             =   240
         Width           =   1095
      End
      Begin VB.OptionButton optSrc 
         Caption         =   "Angle: Thorlabs"
         Height          =   255
         Index           =   0
         Left            =   120
         TabIndex        =   37
         ToolTipText     =   "Small Single Dut Angle"
         Top             =   720
         Width           =   1575
      End
   End
   Begin VB.CommandButton cmdNextDutClk 
      Caption         =   "Next"
      Height          =   315
      Left            =   3480
      TabIndex        =   18
      Top             =   120
      Width           =   495
   End
   Begin VB.ComboBox cmbDutClk 
      Height          =   315
      ItemData        =   "frmTest.frx":0CCA
      Left            =   2880
      List            =   "frmTest.frx":0D2E
      TabIndex        =   17
      Text            =   "0"
      Top             =   120
      Width           =   615
   End
   Begin VB.CheckBox cbPaletteEnable 
      Caption         =   "Single DUT"
      Height          =   315
      Left            =   1800
      Style           =   1  'Graphical
      TabIndex        =   12
      Top             =   120
      Width           =   1095
   End
   Begin VB.Frame frmTest 
      Caption         =   "Test Select"
      Height          =   3255
      Left            =   120
      TabIndex        =   1
      Top             =   3480
      Width           =   5775
      Begin VB.OptionButton optTest 
         Caption         =   "88888888888"
         Height          =   255
         Index           =   42
         Left            =   4320
         TabIndex        =   90
         Top             =   1680
         Visible         =   0   'False
         Width           =   1335
      End
      Begin VB.OptionButton optTest 
         Caption         =   "88888888888"
         Height          =   255
         Index           =   41
         Left            =   4320
         TabIndex        =   89
         Top             =   1440
         Visible         =   0   'False
         Width           =   1335
      End
      Begin VB.OptionButton optTest 
         Caption         =   "88888888888"
         Height          =   255
         Index           =   40
         Left            =   4320
         TabIndex        =   88
         Top             =   1200
         Visible         =   0   'False
         Width           =   1335
      End
      Begin VB.OptionButton optTest 
         Caption         =   "88888888888"
         Height          =   255
         Index           =   39
         Left            =   4320
         TabIndex        =   87
         Top             =   960
         Visible         =   0   'False
         Width           =   1335
      End
      Begin VB.OptionButton optTest 
         Caption         =   "88888888888"
         Height          =   255
         Index           =   38
         Left            =   4320
         TabIndex        =   86
         Top             =   720
         Visible         =   0   'False
         Width           =   1335
      End
      Begin VB.OptionButton optTest 
         Caption         =   "88888888888"
         Height          =   255
         Index           =   37
         Left            =   4320
         TabIndex        =   85
         Top             =   480
         Visible         =   0   'False
         Width           =   1335
      End
      Begin VB.OptionButton optTest 
         Caption         =   "88888888888"
         Height          =   255
         Index           =   36
         Left            =   4320
         TabIndex        =   84
         Top             =   240
         Visible         =   0   'False
         Width           =   1335
      End
      Begin VB.OptionButton optTest 
         Caption         =   "88888888888"
         Height          =   255
         Index           =   35
         Left            =   3000
         TabIndex        =   83
         Top             =   2880
         Visible         =   0   'False
         Width           =   1335
      End
      Begin VB.OptionButton optTest 
         Caption         =   "88888888888"
         Height          =   255
         Index           =   34
         Left            =   3000
         TabIndex        =   82
         Top             =   2640
         Visible         =   0   'False
         Width           =   1335
      End
      Begin VB.OptionButton optTest 
         Caption         =   "88888888888"
         Height          =   255
         Index           =   33
         Left            =   3000
         TabIndex        =   81
         Top             =   2400
         Visible         =   0   'False
         Width           =   1335
      End
      Begin VB.OptionButton optTest 
         Caption         =   "88888888888"
         Height          =   255
         Index           =   32
         Left            =   3000
         TabIndex        =   80
         Top             =   2160
         Visible         =   0   'False
         Width           =   1335
      End
      Begin VB.OptionButton optTest 
         Caption         =   "88888888888"
         Height          =   255
         Index           =   31
         Left            =   3000
         TabIndex        =   79
         Top             =   1920
         Visible         =   0   'False
         Width           =   1335
      End
      Begin VB.OptionButton optTest 
         Caption         =   "88888888888"
         Height          =   255
         Index           =   30
         Left            =   3000
         TabIndex        =   78
         Top             =   1680
         Visible         =   0   'False
         Width           =   1335
      End
      Begin VB.Frame Frame3 
         Caption         =   "Remaining"
         Height          =   615
         Left            =   4440
         TabIndex        =   13
         Top             =   2520
         Width           =   975
         Begin VB.Label lblTimeLeft 
            Alignment       =   1  'Right Justify
            Caption         =   "00:00"
            Height          =   255
            Index           =   0
            Left            =   360
            TabIndex        =   15
            Top             =   240
            Width           =   495
         End
      End
      Begin VB.Frame Frame2 
         Caption         =   "Elapse"
         Height          =   615
         Left            =   4440
         TabIndex        =   14
         Top             =   1920
         Width           =   975
         Begin VB.Label lblElapseTime 
            Alignment       =   1  'Right Justify
            Caption         =   "00:00"
            Height          =   255
            Index           =   0
            Left            =   360
            TabIndex        =   16
            Top             =   240
            Width           =   495
         End
      End
      Begin VB.OptionButton optTest 
         Caption         =   "88888888888"
         Height          =   255
         Index           =   29
         Left            =   3000
         TabIndex        =   77
         Top             =   1440
         Visible         =   0   'False
         Width           =   1335
      End
      Begin VB.OptionButton optTest 
         Caption         =   "88888888888"
         Height          =   255
         Index           =   28
         Left            =   3000
         TabIndex        =   76
         Top             =   1200
         Visible         =   0   'False
         Width           =   1335
      End
      Begin VB.OptionButton optTest 
         Caption         =   "88888888888"
         Height          =   255
         Index           =   27
         Left            =   3000
         TabIndex        =   73
         Top             =   960
         Visible         =   0   'False
         Width           =   1335
      End
      Begin VB.OptionButton optTest 
         Caption         =   "88888888888"
         Height          =   255
         Index           =   26
         Left            =   3000
         TabIndex        =   68
         Top             =   720
         Visible         =   0   'False
         Width           =   1335
      End
      Begin VB.OptionButton optTest 
         Caption         =   "88888888888"
         Height          =   255
         Index           =   25
         Left            =   3000
         TabIndex        =   67
         Top             =   480
         Visible         =   0   'False
         Width           =   1335
      End
      Begin VB.OptionButton optTest 
         Caption         =   "88888888888"
         Height          =   255
         Index           =   24
         Left            =   3000
         TabIndex        =   66
         Top             =   240
         Visible         =   0   'False
         Width           =   1335
      End
      Begin VB.OptionButton optTest 
         Caption         =   "88888888888"
         Height          =   255
         Index           =   23
         Left            =   1560
         TabIndex        =   65
         Top             =   2880
         Visible         =   0   'False
         Width           =   1335
      End
      Begin VB.OptionButton optTest 
         Caption         =   "88888888888"
         Height          =   255
         Index           =   22
         Left            =   1560
         TabIndex        =   64
         Top             =   2640
         Visible         =   0   'False
         Width           =   1335
      End
      Begin VB.OptionButton optTest 
         Caption         =   "88888888888"
         Height          =   255
         Index           =   21
         Left            =   1560
         TabIndex        =   63
         Top             =   2400
         Visible         =   0   'False
         Width           =   1335
      End
      Begin VB.OptionButton optTest 
         Caption         =   "88888888888"
         Height          =   255
         Index           =   20
         Left            =   1560
         TabIndex        =   61
         Top             =   2160
         Visible         =   0   'False
         Width           =   1335
      End
      Begin VB.OptionButton optTest 
         Caption         =   "88888888888"
         Height          =   255
         Index           =   19
         Left            =   1560
         TabIndex        =   60
         Top             =   1920
         Visible         =   0   'False
         Width           =   1335
      End
      Begin VB.OptionButton optTest 
         Caption         =   "88888888888"
         Height          =   255
         Index           =   18
         Left            =   1560
         TabIndex        =   59
         Top             =   1680
         Visible         =   0   'False
         Width           =   1335
      End
      Begin VB.OptionButton optTest 
         Caption         =   "88888888888"
         Height          =   255
         Index           =   17
         Left            =   1560
         TabIndex        =   35
         Top             =   1440
         Visible         =   0   'False
         Width           =   1335
      End
      Begin VB.OptionButton optTest 
         Caption         =   "88888888888"
         Height          =   255
         Index           =   16
         Left            =   1560
         TabIndex        =   34
         Top             =   1200
         Visible         =   0   'False
         Width           =   1335
      End
      Begin VB.OptionButton optTest 
         Caption         =   "88888888888"
         Height          =   255
         Index           =   15
         Left            =   1560
         TabIndex        =   33
         Top             =   960
         Visible         =   0   'False
         Width           =   1335
      End
      Begin VB.OptionButton optTest 
         Caption         =   "88888888888"
         Height          =   255
         Index           =   14
         Left            =   1560
         TabIndex        =   32
         Top             =   720
         Visible         =   0   'False
         Width           =   1335
      End
      Begin VB.OptionButton optTest 
         Caption         =   "88888888888"
         Height          =   255
         Index           =   13
         Left            =   1560
         TabIndex        =   31
         Top             =   480
         Visible         =   0   'False
         Width           =   1335
      End
      Begin VB.OptionButton optTest 
         Caption         =   "88888888888"
         Height          =   255
         Index           =   12
         Left            =   1560
         TabIndex        =   30
         Top             =   240
         Visible         =   0   'False
         Width           =   1335
      End
      Begin VB.OptionButton optTest 
         Caption         =   "88888888888"
         Height          =   255
         Index           =   11
         Left            =   120
         TabIndex        =   29
         Top             =   2880
         Visible         =   0   'False
         Width           =   1335
      End
      Begin VB.OptionButton optTest 
         Caption         =   "88888888888"
         Height          =   255
         Index           =   10
         Left            =   120
         TabIndex        =   28
         Top             =   2640
         Visible         =   0   'False
         Width           =   1335
      End
      Begin VB.OptionButton optTest 
         Caption         =   "88888888888"
         Height          =   255
         Index           =   9
         Left            =   120
         TabIndex        =   27
         Top             =   2400
         Visible         =   0   'False
         Width           =   1335
      End
      Begin VB.OptionButton optTest 
         Caption         =   "88888888888"
         Height          =   255
         Index           =   8
         Left            =   120
         TabIndex        =   10
         Top             =   2160
         Visible         =   0   'False
         Width           =   1335
      End
      Begin VB.OptionButton optTest 
         Caption         =   "88888888888"
         Height          =   255
         Index           =   7
         Left            =   120
         TabIndex        =   9
         Top             =   1920
         Visible         =   0   'False
         Width           =   1335
      End
      Begin VB.OptionButton optTest 
         Caption         =   "88888888888"
         Height          =   255
         Index           =   6
         Left            =   120
         TabIndex        =   8
         Top             =   1680
         Visible         =   0   'False
         Width           =   1335
      End
      Begin VB.OptionButton optTest 
         Caption         =   "88888888888"
         Height          =   255
         Index           =   5
         Left            =   120
         TabIndex        =   7
         Top             =   1440
         Visible         =   0   'False
         Width           =   1335
      End
      Begin VB.OptionButton optTest 
         Caption         =   "88888888888"
         Height          =   255
         Index           =   4
         Left            =   120
         TabIndex        =   6
         Top             =   1200
         Visible         =   0   'False
         Width           =   1335
      End
      Begin VB.OptionButton optTest 
         Caption         =   "88888888888"
         Height          =   255
         Index           =   3
         Left            =   120
         TabIndex        =   5
         Top             =   960
         Visible         =   0   'False
         Width           =   1335
      End
      Begin VB.OptionButton optTest 
         Caption         =   "88888888888"
         Height          =   255
         Index           =   2
         Left            =   120
         TabIndex        =   4
         Top             =   720
         Visible         =   0   'False
         Width           =   1335
      End
      Begin VB.OptionButton optTest 
         Caption         =   "88888888888"
         Height          =   255
         Index           =   1
         Left            =   120
         TabIndex        =   3
         Top             =   480
         Visible         =   0   'False
         Width           =   1335
      End
      Begin VB.OptionButton optTest 
         Caption         =   "88888888888"
         Height          =   255
         Index           =   0
         Left            =   120
         TabIndex        =   2
         Top             =   240
         Visible         =   0   'False
         Width           =   1335
      End
      Begin VB.Timer tmrTest 
         Enabled         =   0   'False
         Interval        =   100
         Left            =   600
         Top             =   3120
      End
      Begin VB.Timer tmrSR 
         Enabled         =   0   'False
         Interval        =   100
         Left            =   120
         Top             =   3120
      End
   End
   Begin VB.CommandButton cmdStop 
      Caption         =   "Stop"
      Height          =   375
      Left            =   120
      TabIndex        =   0
      Top             =   480
      Width           =   975
   End
   Begin VB.CommandButton cmdTest 
      Caption         =   "Start Test"
      Enabled         =   0   'False
      Height          =   375
      Left            =   120
      TabIndex        =   11
      Top             =   120
      Width           =   975
   End
   Begin VB.Frame fmSRControls 
      BorderStyle     =   0  'None
      Height          =   975
      Left            =   1800
      TabIndex        =   19
      Top             =   360
      Visible         =   0   'False
      Width           =   2175
      Begin VB.CheckBox cbSRenable 
         Caption         =   "S+R:Off"
         Height          =   315
         Left            =   0
         Style           =   1  'Graphical
         TabIndex        =   24
         Top             =   120
         Width           =   1095
      End
      Begin VB.CheckBox cbSRLockEnable 
         Caption         =   "S+R Lock:Off"
         Height          =   315
         Left            =   0
         Style           =   1  'Graphical
         TabIndex        =   23
         Top             =   480
         Width           =   1095
      End
      Begin VB.Frame fmSRinc 
         BorderStyle     =   0  'None
         Enabled         =   0   'False
         Height          =   495
         Left            =   1080
         TabIndex        =   20
         Top             =   0
         Visible         =   0   'False
         Width           =   1095
         Begin VB.ComboBox cmbDutPos 
            Height          =   315
            ItemData        =   "frmTest.frx":0DA8
            Left            =   0
            List            =   "frmTest.frx":0E0C
            TabIndex        =   22
            Text            =   "0"
            Top             =   120
            Width           =   615
         End
         Begin VB.CommandButton cmdNextDutPos 
            Caption         =   "Next"
            Height          =   315
            Left            =   600
            TabIndex        =   21
            Top             =   120
            Width           =   495
         End
      End
      Begin VB.Label lblTimeLeft 
         Alignment       =   1  'Right Justify
         Caption         =   "00:00"
         Height          =   375
         Index           =   1
         Left            =   1560
         TabIndex        =   26
         Top             =   720
         Width           =   495
      End
      Begin VB.Label lblElapseTime 
         Alignment       =   1  'Right Justify
         Caption         =   "00:00"
         Height          =   255
         Index           =   1
         Left            =   1560
         TabIndex        =   25
         Top             =   480
         Width           =   495
      End
   End
End
Attribute VB_Name = "frmTest"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

              ' +_______________________+
              ' | Test Class Definition |
Enum testList ' +¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯+
    'proxAR0
    'proxAR1
    'proxAR2
    'reg38
    'bbXfer
    'prxTransfer
    'taosXfer
    
    proxAR
    proxAR28
    proxAR177
    prxArCEC
    prxAr28CEC
    alsComp
    alsLS2LS
    alsLS2LS4R
    alsLS2LSEEC
    proxSweep
    proxSweepOffset
    alsRespSweep
    
    spectralAngle
    rgbLS2LS
    RGBbulbs
    RGBsweep
    RGBpwrSweep
    RGBfsSweep
    RGBleds
    alsAngSweep
    pwrAngSweep
    alsPwrSweep
    rotation3d
    aOutSweep
    
    alsRanges
    winScan
    alsSettling
    rgbDrift
    ProxXtalk177
    
    nTests
End Enum

Enum eSource
    sAngleThorlabs
    sDistance
    sWavelength
    sPower
    sCT
    sXYpos
    sAngleNpXps
    sAngle3d
End Enum

Enum eMeasDut
    mALS
    mIR
    mPRX
    mPRX30
End Enum

Enum eMeasCyc
    mALSdyn
    mIRdyn
    mPRXdyn
    mIRDRdyn
End Enum

Dim initDone(nTests) As Boolean
Dim pTestClass As clsIloop

Public pSource As clsIloop
Public pSource1 As clsIloop
Public pMeasure As clsIloop

Dim startTime(1) As Long
Dim justArmed(1) As Boolean
Dim testSelected As Integer

Dim pSR As clsLoopSR
Dim pDUT As clsLoopETclk

Dim pPlt As frmPlot
Dim pXY As frmThorlabsAPT
Dim als As ucALSusb

Dim srInitDone As Boolean
Dim lotSize As Integer
Dim dCount As Integer
Dim dnum As Integer

Const maxDnum As Integer = 31

Dim abort As Boolean


Dim xOffset As Single ' Read from Excel
Dim yOffset As Single

Public Function getDnum() As Integer
    getDnum = dnum
End Function

Public Sub runTest()
    start
End Sub

Public Function testDone() As Boolean
    On Error GoTo endFunction
    
    If testSelected > 0 Then
        testDone = pTestClass.done
    End If
    
endFunction:

End Function

Private Sub cbSingleDevice_Click()
    If cbSingleDevice.value = vbChecked Then
        cbSingleDevice.caption = "Single DUT"
    Else
        cbSingleDevice.caption = "Palette Card"
    End If
End Sub

Public Function getSingleDUT() As Boolean
    getSingleDUT = cbSingleDevice.value = vbChecked
End Function

Private Sub cb38PoffAdjEn_Click()
    If cb38PoffAdjEn.value = vbChecked Then
        cb38PoffAdjEn.caption = "38-Poff:On"
    Else
        cb38PoffAdjEn.caption = "38-Poff:Off"
    End If
End Sub

Public Function getPoffEn() As Boolean
    getPoffEn = cb38PoffAdjEn.value = vbChecked
End Function

Private Sub Form_Load()
    Dim i As Integer: i = 0
    On Error GoTo error
    
'    optTest(i).caption = "proxAR0": i = i + 1
'    optTest(i).caption = "proxAR1": i = i + 1
'    optTest(i).caption = "proxAR2": i = i + 1
'    optTest(i).caption = "38reg": i = i + 1
'    optTest(i).caption = "bbXfer": i = i + 1
'    optTest(i).caption = "prxXfer": i = i + 1
'    optTest(i).caption = "taosXfer": i = i + 1
    
                                  ' +___________________+
                                  ' | Define Test Names |
                                  ' +¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯+
    optTest(i).caption = "proxAR":        i = i + 1
    optTest(i).caption = "proxAR28":      i = i + 1
    optTest(i).caption = "proxAR177":     i = i + 1
    optTest(i).caption = "prxArCEC":      i = i + 1
    optTest(i).caption = "prxAr28CEC":    i = i + 1
    optTest(i).caption = "alsComp":       i = i + 1
    optTest(i).caption = "alsLS2LS":      i = i + 1
    optTest(i).caption = "alsLS2LS4R":    i = i + 1
    optTest(i).caption = "alsLS2LSEEC":   i = i + 1
    optTest(i).caption = "proxSwp":       i = i + 1
    optTest(i).caption = "proxSwpOff":    i = i + 1
    optTest(i).caption = "alsRespSwp":    i = i + 1
    
    optTest(i).caption = "spectralAngle": i = i + 1
    optTest(i).caption = "RBGls2ls":      i = i + 1
    optTest(i).caption = "RGBbulbs":      i = i + 1
    optTest(i).caption = "RGBsweep":      i = i + 1
    optTest(i).caption = "RGBpwrSwp":     i = i + 1
    optTest(i).caption = "RGBfsSwp":      i = i + 1
    optTest(i).caption = "RGBleds":       i = i + 1
    optTest(i).caption = "alsAngSwp":     i = i + 1
    optTest(i).caption = "pwrAngSwp":     i = i + 1
    optTest(i).caption = "alsPwrSweep":   i = i + 1
    optTest(i).caption = "rotation3d":    i = i + 1
    optTest(i).caption = "aOutSweep":     i = i + 1
    
    optTest(i).caption = "alsRanges":     i = i + 1
    optTest(i).caption = "winScan":       i = i + 1
    optTest(i).caption = "alsSettling":   i = i + 1
    optTest(i).caption = "RGBdrift":      i = i + 1
    optTest(i).caption = "ProxXtalk177":  i = i + 1
    
    
    For i = 0 To nTests - 1
        optTest(i).Visible = True
    Next i
    
    testSelected = 0

    Set pPlt = frmPlot
    Set pDUT = New clsLoopETclk
    Set pXY = frmThorlabsAPT
    Set als = frmMain.ucALSusb1
    
    Call pXY.Show(0, frmMain)
    Set pSR = pXY.pSR
    
    GoTo endSub
error:
    MsgBox ("Error: frmTest:Form_Load")
endSub:
End Sub


' +______________________+
' | Generic Test Control |
' +¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯+

Private Sub start(Optional Index As Integer = -1)
    Dim i As Integer, partNumber As Long
    
    If Index = -1 Then Index = testSelected - 1
    
    If testSelected > 0 Then
    
        If Index < testList.nTests Then
        
            als.dGetPartNumber partNumber
                                              ' +_____________________+
            If Not initDone(Index) Then       ' | Test Class Creation |
                Set pTestClass = New clsIloop ' +¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯+
                
'                Case testList.proxAR0: Call pTestClass.init(New clsTestProxAR0, "clsTestProxAR0")
'                Case testList.proxAR1: Call pTestClass.init(New clsTestProxAR1, "clsTestProxAR1")
'                Case testList.proxAR2: Call pTestClass.init(New clsTestProxAR2, "clsTestProxAR2")
'                Case testList.reg38: Call pTestClass.init(New clsTest38reg, "clsTest38reg")
'                Case testList.bbXfer: Call pTestClass.init(New clsTestBBxfer, "clsTestBBxfer")
'                Case testList.prxTransfer: Call pTestClass.init(New clsTestPrxTransfer, "clsTestPrxTransfer")
'                Case testList.taosXfer: Call pTestClass.init(New clsTestTaosXfer, "clsTestTaosXfer")
                
                Select Case Index
                
                Case testList.proxAR:      pTestClass.init New clsTestProxAR, "clsTestProxAR"
                Case testList.proxAR28:    pTestClass.init New clsTestProxAR28, "clsTestProxAR28"
                Case testList.proxAR177:   pTestClass.init New clsTestProxAR177, "clsTestProxAR177"
                Case testList.prxArCEC:    pTestClass.init New clsTestPrxArCEC, "clsTestPrxArCEC"
                Case testList.prxAr28CEC:  pTestClass.init New clsTestPrxAr28CEC, "clsTestPrxAr28CEC"
                Case testList.alsComp:     pTestClass.init New clsTestComp, "clsTestComp"
                Case testList.alsLS2LS:    pTestClass.init New clsTestLS2LS, "clsTestLS2LS"
                Case testList.alsLS2LS4R:  pTestClass.init New clsTestLS2LS4R, "clsTestLS2LS4R"
                Case testList.alsLS2LSEEC: pTestClass.init New clsTestLS2LSEEC, "clsTestLS2LSEEC"
                Case testList.proxSweep:
                    If partNumber <> 29177 Then
                                           pTestClass.init New clsProxSweep, "clsProxSweep"
                    Else
'                                           pTestClass.init New clsProxSweep177, "clsProxSweep177"
                    End If
                Case testList.proxSweepOffset: pTestClass.init New clsProxSweepOffset, "clsProxSweepOffset"
                Case testList.alsRespSweep:    pTestClass.init New clsAlsSweep, "clsAlsSweep"
                '=========
                Case testList.spectralAngle:   pTestClass.init New clsTestSpectralAngle, "clsTestSpectralAngle"
                Case testList.rgbLS2LS:        pTestClass.init New clsTestRgbLS2LS, "clsTestRgbLS2LS"
                Case testList.RGBbulbs: Load frmRGBscan
                                               pTestClass.init New clsTestRGBbulbs, "clsTestRGBbulbs"
                Case testList.RGBsweep:        pTestClass.init New clsTestRGBsweep, "clsTestRGBsweep"
                Case testList.RGBpwrSweep:     pTestClass.init New clsTestRGBpwrSweep, "clsTestRGBpwrSweep"
                Case testList.RGBfsSweep:      pTestClass.init New clsTestrgbFSsweep, "clsTestrgbFSsweep"
                Case testList.RGBleds: Load frmRGBscan
                                               pTestClass.init New clsTestRGBleds, "clsTestRGBleds"
                Case testList.alsAngSweep:     pTestClass.init New clsAngleSweep, "clsAngleSweep"
                Case testList.pwrAngSweep:     pTestClass.init New clsTestPwrAngle, "clsTestPwrAngle"
                Case testList.alsPwrSweep:     pTestClass.init New clsTestAlsPwrSweep, "clsTestAlsPwrSweep"
                Case testList.rotation3d:      pTestClass.init New clsTestRotation3d, "clsTestRotation3d"
                Case testList.aOutSweep:       pTestClass.init New clsAoutSweep, "clsAoutSweep"
                '=========
                Case testList.alsRanges:       pTestClass.init New clsAlsRanges, "clsAlsRanges"
                Case testList.winScan:         pTestClass.init New clsTestWinScan, "clsTestWinScan"
                Case testList.alsSettling:     pTestClass.init New clsTestAlsSettling, "clsTestAlsSettling"
                Case testList.rgbDrift:        pTestClass.init New clsTestRGBdrift, "clsTestRGBdrift"
                Case testList.ProxXtalk177:    pTestClass.init New clsProxXtalk177, "clsProxXtalk177"
                
                End Select
                
                initDone(Index) = True
                
            End If
            
            If cmdTest.enabled Then
            
                startTime(0) = GetTickCount
                justArmed(0) = True
                
                cmdTest.enabled = False
                pTestClass.arm
                
                tmrTest.Interval = pTestClass.getInterval
                tmrTest.enabled = True
                testSelected = Index + 1
            End If
            
        End If
    
    End If
    
End Sub

Public Sub cmdTest_Click()

    Dim prompt As String

    If frmPlot.lblExcelFile = "FileName" Then
        MsgBox ("Select Excel Template File in Plot Window")
    Else
    
    xOffset = modDSP.getExcelName("xOffset")
    yOffset = modDSP.getExcelName("yOffset")

        If srInitDone Then
        
            dCount = 1
            justArmed(1) = True
            startTime(1) = GetTickCount
            Call updateElapseTime(0, 1)
            
            Call pXY.setXYoffset(xOffset, yOffset)
            lotSize = pDUT.arm
            
            pSR.init
            
        End If
        
        abort = False
        'pTestClass.arm
        'cmdTest.enabled = True
        start
        
        prompt = pTestClass.getPreTestPrompt
        If prompt <> "" Then MsgBox prompt
    
    End If
    
End Sub

Public Sub rePositionDUT()
    pSR.next_ dnum
End Sub

Public Sub send2excel(Optional sheet As Integer = -1)
    If sheet > -1 Then
        If optSrc(eSource.sAngle3d).value Then
            Call pPlt.send2excel(dnum, pSource1.getIndex)
        Else
            pPlt.send2excel dnum
        End If
    Else
        Call pPlt.send2excel(dnum, sheet)
    End If
End Sub

Private Sub tmrTest_Timer()

    Dim nextDut As Integer, elapseTime As Single

    If pTestClass.done Or abort Then
    
        If abort Then
        
            If cbSRLockEnable.value = vbChecked Then
                pSR.next_ maxDnum
                pSR.next_
                cbSRLockEnable.value = vbUnchecked
            Else
                tmrTest.enabled = False
                cmdTest.enabled = True
            End If
        
        Else
        
            If cbPaletteEnable = vbChecked Then 'cbSRLockEnable = vbChecked
            
                If optSrc(eSource.sAngle3d).value Then
                    Call pPlt.send2excel(dnum, pSource1.getIndex)
                Else
                    pPlt.send2excel dnum
                End If
                
                If 0 Then
                    If Not pSR.done Then
                        cmdNextDutClk_Click
                        dCount = dCount + 1: Call updateElapseTime(dCount / lotSize, 1)
                        cmdTest.enabled = True
                        start
                    Else
                        tmrTest.enabled = False
                        cmdTest.enabled = True
                    End If
                Else
                    If pDUT.done Then
                        tmrTest.enabled = False
                        cmdTest.enabled = True
                    Else
                        pDUT.next_: ' cmdNextDutClk_Click
                        dCount = dCount + 1: Call updateElapseTime(dCount / lotSize, 1)
                        cmdTest.enabled = True
                        start
                    End If
                End If
                
            Else
                tmrTest.enabled = False
                cmdTest.enabled = True
            End If
            
        End If
        
    Else
        ' Use hierarchy for now, No cycle...
        If optMeas(eMeasure.mDUT) Then
            If cbDutMeas(eMeasure.mALS - 6).value Then
                elapseTime = pTestClass.next_(eMeasure.mALS)
            Else
                If cbDutMeas(eMeasure.mIR - 6).value Then
                    elapseTime = pTestClass.next_(eMeasure.mIR)
                Else
                    If cbDutMeas(eMeasure.mProx - 6).value Then
                        elapseTime = pTestClass.next_(eMeasure.mProx)
                    Else
                        If cbDutMeas(eMeasure.mProx30 - 6).value Then
                            elapseTime = pTestClass.next_(eMeasure.mProx30)
                        Else
                            ' Something should be selected
                        End If
                    End If
                End If
            End If
        End If
        
        If optMeas(eMeasure.mDVM) Then
            elapseTime = pTestClass.next_
        End If
        
        If optMeas(eMeasure.mOPM) Then
            elapseTime = pTestClass.next_
        End If
        
        If optMeas(eMeasure.mLM) Then
            elapseTime = pTestClass.next_(eMeasure.mLM)
        End If
        
        If optMeas(eMeasure.mCM) Then
            elapseTime = pTestClass.next_(eMeasure.mCM)
        End If
        
        If optMeas(eMeasure.mRBG) Then
            elapseTime = pTestClass.next_(eMeasure.mRBG)
        End If
        
        updateElapseTime elapseTime
        
    End If

End Sub

Private Sub updateElapseTime(ByVal amountDone As Single, Optional idx As Integer = 0)
    Dim min As Long, sec As Long, time As Long
    Static armTime(1) As Long
    
    If justArmed(idx) Then
        justArmed(idx) = False
        armTime(idx) = (GetTickCount - startTime(idx)) / 1000
    End If

    time = GetTickCount - startTime(idx): time = time / 1000
    sec = time Mod 60: min = (time - sec) / 60
    lblElapseTime(idx).caption = min & ":" & format(sec, "00")
    
    If amountDone > 0 Then
        time = (time - armTime(idx)) * (1# - amountDone) / amountDone
        sec = time Mod 60: min = (time - sec) / 60
        lblTimeLeft(idx).caption = min & ":" & format(sec, "00")
    End If
End Sub


Private Sub optTest_Click(Index As Integer)
    cmdTest.enabled = True
    'frmTest.enabled = False
    testSelected = Index + 1
End Sub

Private Sub cmdStop_Click()
    abort = True
    cmdTest.enabled = True
End Sub

' +__________________+
' | Palette Controls |
' +¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯+

Public Function setDevice(Dev As Integer)
    cmbDutClk.ListIndex = Dev
    cmbDutClk_Click
    dnum = cmbDutClk.ListIndex
    setDevice = dnum
End Function

Private Sub setVisible()
    
    fmSRControls.Visible = (cbPaletteEnable.value = vbChecked)
    cmbDutClk.Visible = fmSRControls.Visible
    cmdNextDutClk.Visible = fmSRControls.Visible
    
    fmSRinc.Visible = (cbSRenable.value = vbChecked)
    cbSRLockEnable.Visible = fmSRinc.Visible
    fmSRinc.enabled = (cbSRLockEnable.value <> vbChecked)

End Sub

Private Function nextDut(ByVal thisDut As Integer) As Integer
    nextDut = frmEtIo.getNextEnabled(thisDut)
End Function

Private Sub cbPaletteEnable_Click()
    If cbPaletteEnable.value = vbChecked Then
    
        cbPaletteEnable.caption = "Palette"
        
        If Not srInitDone Then
            Call frmThorlabsAPT.Show(0, Me)
            Set pSR = frmThorlabsAPT.pSR
            srInitDone = True
        End If
        
    Else
        cbPaletteEnable.caption = "Single DUT"
        srInitDone = False
    End If
    
    setVisible
End Sub

Private Sub cbSRenable_Click()
    If cbSRenable.value = vbChecked Then
        cbSRenable.caption = "S+R:On"
    Else
        cbSRenable.caption = "S+R:Off"
    End If
    setVisible
End Sub

Private Sub cbSRLockEnable_Click()
    If cbSRLockEnable.value = vbChecked Then
        cbSRLockEnable.caption = "S+R Lock:On"
    Else
        cbSRLockEnable.caption = "S+R Lock:Off"
    End If
    setVisible
End Sub

Private Sub cmbDutClk_Click()
    cmbDutClk.ListIndex = nextDut(cmbDutClk.ListIndex - 1)
    dnum = cmbDutClk.ListIndex
    frmEtIo.selectDevice dnum
    If cbSRLockEnable.value = vbChecked Then
        cmbDutPos.ListIndex = dnum
        cmbDutPos_Click
    End If
End Sub

Private Sub cmbDutPos_Click()
    cmbDutPos.ListIndex = nextDut(cmbDutPos.ListIndex - 1)
    frmThorlabsAPT.nextSR cmbDutPos.ListIndex
End Sub



Public Sub cmdNextDutClk_Click()
    cmbDutClk.ListIndex = (cmbDutClk.ListIndex + 1) Mod cmbDutClk.ListCount
    cmbDutClk_Click
End Sub

Private Sub cmdNextDutPos_Click()
    cmbDutPos.ListIndex = (cmbDutPos.ListIndex + 1) Mod cmbDutPos.ListCount
    cmbDutPos_Click
End Sub



' +_____________________+
' | Source/Measure Init |
' +¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯+

Private Sub optSrc_Click(Index As Integer)
    
    Select Case Index
    Case eSource.sAngleNpXps: Set pSource = New clsIloop: Call pSource.init(frmThorlabsAPT.ucNPXPS1, "frmThorlabsAPT.ucNPXPS1")
    Case eSource.sAngle3d: Set pSource = New clsIloop: Call pSource.init(frmThorlabsAPT.ucNPXPS1, "frmThorlabsAPT.ucNPXPS1")
    Case eSource.sWavelength: Set pSource = New clsIloop: Call pSource.init(frmMonochromator.ucMonochromator1, "frmMonochromator.ucMonochromator1")
    End Select
    
    Select Case Index
    Case eSource.sAngle3d: Set pSource1 = New clsIloop: Call pSource1.init(frmThorlabsAPT.ucThorlabsAPT1(0), "frmThorlabsAPT.ucThorlabsAPT1(0)")
    End Select
    
End Sub



Public Function measuringDUT() As Boolean
    measuringDUT = optMeas(eMeasure.mDUT).value Or optMeas(eMeasure.mRBG).value
End Function

Private Sub optMeas_Click(Index As Integer)
    
    If Index = eMeasure.mDUT Then
        frmMeasDut.Visible = True
        Set pMeasure = New clsIloop: Call pMeasure.init(New clsDutMeasure, "frmTest.clsDutMeasure")
    Else
        frmMeasDut.Visible = False
    End If
    
    Select Case Index
    Case eMeasure.mRBG: Set pMeasure = New clsIloop: Call pMeasure.init(frmRGBscan.pRGB, "frmRGBscan.pRGB")
    Case eMeasure.mOPM: Set pMeasure = New clsIloop: Call pMeasure.init(frmMonochromator.ucMonochromator1.pOPM, "frmMonochromator.ucMonochromator1.pOPM")
    Case eMeasure.mLM: Set pMeasure = New clsIloop: Call pMeasure.init(frmMonochromator.ucMonochromator1.pLM, "frmMonochromator.ucMonochromator1.pLM")
    Case eMeasure.mCM: Set pMeasure = New clsIloop: Call pMeasure.init(frmMonochromator.ucMonochromator1.pCM, "frmMonochromator.ucMonochromator1.pCM")
    Case eMeasure.mDVM: Set pMeasure = New clsIloop: Call pMeasure.init(frmMonochromator.ucMonochromator1.pDVM, "frmMonochromator.ucMonochromator1.pDVM")
    End Select
    
    If Index = eMeasure.mDVM Then
        frmMonochromator.ucMonochromator1.setCurrent 0
    End If

End Sub

Private Sub measDynCtrl(ByVal measDut As eMeasDut, ByVal measCyc As eMeasCyc)

    If cbDutMeas(measDut).value Then
        cbRngCycle(measCyc).Visible = True
    Else
        cbRngCycle(measCyc).value = 0
        cbRngCycle(measCyc).Visible = False
    End If
    
End Sub

Private Sub cbDutMeas_Click(Index As Integer)

    Dim measCyc As eMeasCyc
    
    If Index = eMeasDut.mPRX30 Then
    Else

        Select Case Index
        Case eMeasDut.mALS: measCyc = mALSdyn
        Case eMeasDut.mIR: measCyc = mIRdyn
        Case eMeasDut.mPRX: measCyc = mPRXdyn
        End Select
        
        measDynCtrl Index, measCyc
        
        If Index = eMeasDut.mPRX Then measDynCtrl Index, eMeasCyc.mIRDRdyn
    
    End If
    
End Sub

' +________+
' | Script |
' +¯¯¯¯¯¯¯¯+

Public Sub script(value As String)
    Dim widget As String
    Dim error As Long, iVal As Long
    Dim idx As Integer
    Dim dval As Double
        
repeat:    widget = lineArgs(value)
        
    Select Case widget
    
    Case "ProxAR": 'cmdStart_Click (testList.proxAR)
    Case "AlsComp": 'cmdStart_Click (testList.alsComp)
    
    Case "", "#":
    Case Else: MsgBox ("??Script: Tests " & widget & " " & value)
    
    End Select
    
End Sub


