VERSION 5.00
Begin VB.Form frmPwrCal 
   Caption         =   "Intersil Power Calibration"
   ClientHeight    =   2685
   ClientLeft      =   165
   ClientTop       =   735
   ClientWidth     =   1650
   Icon            =   "frmPwrCal.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   ScaleHeight     =   2685
   ScaleWidth      =   1650
   StartUpPosition =   3  'Windows Default
   Begin VB.PictureBox ucALSusb1 
      Height          =   4455
      Left            =   5280
      ScaleHeight     =   4395
      ScaleWidth      =   1755
      TabIndex        =   12
      Top             =   0
      Width           =   1815
   End
   Begin VB.Frame fmOPM 
      Caption         =   "OPM"
      Height          =   615
      Left            =   0
      TabIndex        =   1
      Top             =   0
      Width           =   1575
      Begin VB.Timer tmrOPM 
         Interval        =   100
         Left            =   600
         Top             =   120
      End
      Begin VB.Label lblOPM 
         Caption         =   "OPM"
         Height          =   255
         Left            =   120
         TabIndex        =   2
         Top             =   240
         Width           =   1095
      End
   End
   Begin VB.Frame fmVLED 
      Caption         =   "VLED"
      Height          =   735
      Left            =   0
      TabIndex        =   3
      Top             =   600
      Width           =   1575
      Begin VB.Timer tmrSweepVLED 
         Enabled         =   0   'False
         Interval        =   100
         Left            =   1080
         Top             =   120
      End
      Begin VB.CommandButton cmdSweepVLED 
         Caption         =   "Sweep"
         Height          =   255
         Left            =   720
         TabIndex        =   6
         Top             =   120
         Width           =   735
      End
      Begin VB.HScrollBar HScrVLED 
         Height          =   135
         LargeChange     =   100
         Left            =   120
         Max             =   20000
         TabIndex        =   4
         Top             =   480
         Value           =   350
         Width           =   1335
      End
      Begin VB.Label lblVLED 
         Caption         =   "1.5"
         Height          =   255
         Left            =   120
         TabIndex        =   5
         Top             =   240
         Width           =   1215
      End
   End
   Begin VB.Frame fmFW 
      Caption         =   "Filter Wheels"
      Height          =   615
      Left            =   0
      TabIndex        =   7
      Top             =   1320
      Width           =   1575
      Begin VB.Timer tmrSweepFW 
         Enabled         =   0   'False
         Interval        =   100
         Left            =   1080
         Top             =   120
      End
      Begin VB.CommandButton cmdSweepFW 
         Caption         =   "Sweep"
         Height          =   255
         Left            =   720
         TabIndex        =   8
         Top             =   240
         Width           =   735
      End
   End
   Begin VB.Frame fmCalTest 
      Caption         =   "Cal Test"
      Height          =   735
      Left            =   0
      TabIndex        =   0
      Top             =   1920
      Width           =   1575
      Begin VB.Timer tmrCalTest 
         Enabled         =   0   'False
         Interval        =   100
         Left            =   1080
         Top             =   120
      End
      Begin VB.HScrollBar HScrCalTest 
         Height          =   135
         LargeChange     =   10
         Left            =   120
         Max             =   1023
         TabIndex        =   9
         Top             =   480
         Width           =   1335
      End
      Begin VB.CommandButton cmdCalTest 
         Caption         =   "Sweep"
         Height          =   255
         Left            =   720
         TabIndex        =   10
         Top             =   120
         Width           =   735
      End
      Begin VB.Label lblCalTest 
         Caption         =   "1"
         Height          =   255
         Left            =   120
         TabIndex        =   11
         Top             =   240
         Width           =   615
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
   Begin VB.Menu mnuHelp 
      Caption         =   "&Help"
      Begin VB.Menu mnuAbout 
         Caption         =   "&About"
      End
   End
End
Attribute VB_Name = "frmPwrCal"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Option Explicit

Dim gFilterWheelReady As Boolean
Dim gVledReady As Boolean
Dim gOPMReady As Boolean

Dim ledIdx As Integer
Dim fwIdx As Integer


Const cVLEDoffset As Single = 1.5

Private Sub Form_Load()
    frmMonochromator.ucMonochromator1.setValue (555)
    Call frmPlot.Show(0, Me)
End Sub

Private Sub tmrOPM_Timer()
    Static wCount As Integer, vCount As Integer
    lblOPM.caption = frmMonochromator.ucMonochromator1.getPower
    
    If gFilterWheelReady Then
        If wCount Then wCount = wCount - 1
    Else
        wCount = 50
    End If
    
    If gVledReady Then
        If vCount Then vCount = vCount - 1
    Else
        vCount = 10
    End If
    
    gOPMReady = (wCount = 0) And (vCount = 0)
    
End Sub

Private Sub HScrVLED_Change()
    lblVLED.caption = HScrVLED.value / HScrVLED.LargeChange / 100# + cVLEDoffset
    frmMonochromator.ucMonochromator1.setVolts (lblVLED.caption)
End Sub

Private Sub cmdSweepVLED_Click()
    ledIdx = 0
    tmrSweepVLED.enabled = True
End Sub

Private Sub tmrSweepVLED_Timer()
    Static initDone As Boolean
    Dim i As Integer, j As Integer
    
    ' :: initialize
    If Not initDone Then
        Call frmPlot.setPlotSize(pdAls, HScrVLED.max / HScrVLED.LargeChange + 1)
        frmPlot.ucPlot1(0).caption = "Power vs. VLED"
        frmPlot.ucPlot1(0).XaxisDataMin = HScrVLED.min
        frmPlot.ucPlot1(0).XaxisDataMax = HScrVLED.max
        frmPlot.ucPlot1(0).XaxisLabel = "Vled (mv)"
        initDone = True
    End If
    
    ' :: record
    gCalLedVal(ledIdx) = val(lblOPM.caption)
    Call frmPlot.plotData(pdAls, gCalLedVal(ledIdx))
    ledIdx = ledIdx + 1
    
    ' :: increment
    If HScrVLED.value < HScrVLED.max Then
    
        If HScrVLED.value + HScrVLED.LargeChange < HScrVLED.max Then
            HScrVLED.value = HScrVLED.value + HScrVLED.LargeChange
        Else
            HScrVLED.value = HScrVLED.max
        End If
    
    ' :: terminate
    Else
    
        j = UBound(gCalLedVal)
        For i = 0 To j
            gCalLedVal(i) = gCalLedVal(i) / gCalLedVal(j)
        Next i
        
        tmrSweepVLED.enabled = False
        initDone = False

    End If
    
    
End Sub

Private Sub cmdSweepFW_Click()
    fwIdx = 0
    tmrSweepFW.enabled = True
End Sub

Private Sub tmrSweepFW_Timer()
    Static initDone As Boolean
    
    ' :: initialize
    If Not initDone Then
        Call frmPlot.setPlotSize(pdProx, 36)
        frmPlot.ucPlot1(1).caption = "Power vs. FW"
        frmPlot.ucPlot1(1).XaxisDataMin = 0
        frmPlot.ucPlot1(1).XaxisDataMax = 35
        frmPlot.ucPlot1(1).XaxisLabel = "FW Position"
        initDone = True
    End If
    
    ' :: record
    gCalFwVal(fwIdx) = val(lblOPM.caption)
    Call frmPlot.plotData(pdProx, gCalFwVal(fwIdx))
    If fwIdx > 0 Then gCalFwVal(fwIdx) = gCalFwVal(fwIdx) / gCalFwVal(0)
    fwIdx = fwIdx + 1
    ' :: increment
    If fwIdx < 36 Then
        frmMonochromator.ucMonochromator1.setFwIndex (fwIdx)
    ' :: terminate
    Else
        gCalFwVal(0) = 1
        tmrSweepFW.enabled = False
        initDone = False
    End If
    
End Sub

Private Sub HScrCalTest_Change()
    Dim attn As Single: attn = (HScrCalTest.max - HScrCalTest.value) / HScrCalTest.max
    gFilterWheelReady = False: gVledReady = False
    frmMonochromator.ucMonochromator1.setFwIndex (getFWset(attn))
    gFilterWheelReady = True
    
    HScrVLED.value = getVLEDset(attn, HScrVLED.LargeChange) ' interpolate
    
    gVledReady = True
    lblCalTest.caption = HScrCalTest.value
End Sub

Private Sub cmdCalTest_Click()
    tmrCalTest.enabled = True
End Sub

Private Sub tmrCalTest_Timer()
    Static initDone As Boolean
    If HScrCalTest.value < HScrCalTest.max Then
    
        If Not initDone Then
            Call frmPlot.setPlotSize(pdAls, HScrCalTest.max - HScrCalTest.value + 1)
            frmPlot.ucPlot1(0).caption = "Power"
            frmPlot.ucPlot1(0).XaxisDataMin = HScrCalTest.min
            frmPlot.ucPlot1(0).XaxisDataMax = HScrCalTest.max
            frmPlot.ucPlot1(0).XaxisLabel = "Code"
            initDone = True
        End If
        
        If gOPMReady Then
            Call frmPlot.plotData(pdAls, lblOPM.caption)
            HScrCalTest.value = HScrCalTest.value + 1
        End If
        
    Else
        tmrCalTest.enabled = False
        initDone = False
    End If
End Sub


