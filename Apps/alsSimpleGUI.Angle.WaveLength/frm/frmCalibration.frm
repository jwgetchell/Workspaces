VERSION 5.00
Begin VB.Form frmCalibration 
   Caption         =   "Intersil Power Calibration"
   ClientHeight    =   3075
   ClientLeft      =   165
   ClientTop       =   735
   ClientWidth     =   2385
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   ScaleHeight     =   3075
   ScaleWidth      =   2385
   StartUpPosition =   3  'Windows Default
   Begin VB.Timer tmrTestDUT 
      Enabled         =   0   'False
      Interval        =   100
      Left            =   1920
      Top             =   1680
   End
   Begin VB.CommandButton cmdTestDut 
      Caption         =   "DUT"
      Height          =   495
      Left            =   1800
      TabIndex        =   13
      Top             =   960
      Width           =   495
   End
   Begin VB.Frame fmCalTest 
      Caption         =   "Cal Test"
      Height          =   735
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   2295
      Begin VB.ComboBox cmbTestStep 
         Height          =   315
         ItemData        =   "frmCalibration.frx":0000
         Left            =   960
         List            =   "frmCalibration.frx":0019
         TabIndex        =   12
         Text            =   "11"
         Top             =   180
         Width           =   615
      End
      Begin VB.Timer tmrCalTest 
         Enabled         =   0   'False
         Interval        =   100
         Left            =   120
         Top             =   600
      End
      Begin VB.HScrollBar HScrCalTest 
         Height          =   135
         LargeChange     =   11
         Left            =   120
         Max             =   1023
         TabIndex        =   9
         Top             =   480
         Width           =   2055
      End
      Begin VB.CommandButton cmdCalTest 
         Caption         =   "Sweep"
         Height          =   255
         Left            =   1560
         TabIndex        =   10
         Top             =   180
         Width           =   675
      End
      Begin VB.Label lblCalTest 
         Caption         =   "0"
         Height          =   255
         Left            =   120
         TabIndex        =   11
         Top             =   240
         Width           =   615
      End
   End
   Begin VB.Frame fmOPM 
      Caption         =   "OPM"
      Height          =   615
      Left            =   120
      TabIndex        =   1
      Top             =   2400
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
      Left            =   120
      TabIndex        =   3
      Top             =   840
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
         Max             =   16000
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
      Left            =   120
      TabIndex        =   7
      Top             =   1680
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
Attribute VB_Name = "frmCalibration"
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
Dim vLED As Single

Dim pMono As ucMonochromator
Dim pDrv As ucALSusb

Dim average As Integer

Dim VLEDoffset As Single
Dim VLEDgain As Single
Dim VLEDstep As Single

Dim gCalLedVal(0) As Single, gCalFwVal(35) As Single

Const debugPrint_ As Boolean = True

Private Sub cmbTestStep_Click()
    
    '3*11*31
    '1*1023
    '3*341
    '11*93
    '31*33
    '33*31
    '93*11
    '341*3
    
    HScrCalTest.LargeChange = cmbTestStep.text

End Sub

Private Sub Form_Load()
    
    Call frmMonochromator.Show(0, frmMain)
    Set pMono = frmMonochromator.ucMonochromator1
    pMono.setValue (530)
    
    Set pDrv = frmMain.ucALSusb1
    
    Call frmPlot.Show(0, frmMain)
    pDrv.setI2cAddr &H88
    pDrv.dSetDevice 0
    
    average = 1
    gFilterWheelReady = False
    gVledReady = False

    VLEDgain = 3.2
    VLEDoffset = VLEDgain / 2 ' 0.3 ND range is 50%
    VLEDstep = 0.005
    
    HScrVLED.max = (VLEDgain - VLEDoffset) * 1000 'mv resolution

    'ReDim gCalLedVal(HScrVLED.max / 1000 / VLEDstep)
    
End Sub

Private Sub tmrOPM_Timer()
    Static wCount As Integer, vCount As Integer, aCount As Integer, value As Double
    
    Dim meas As Double
    Dim nMeas As Integer
    
    Const wCend As Integer = 50, vCend As Integer = 2
    
    If Not gFilterWheelReady Then
        If wCount < wCend Then
            wCount = wCount + 1
        Else
            gFilterWheelReady = True
        End If
    End If
    
    If Not gVledReady Then
        If vCount < vCend Then
            vCount = vCount + 1
        Else
            gVledReady = True
        End If
    End If
    
    meas = pMono.getPower
    
    If gFilterWheelReady And gVledReady Then
        If aCount < average Then
            value = value * aCount + meas
            aCount = aCount + 1
            value = value / aCount
            lblOPM.caption = value
        Else
            gOPMReady = True
            wCount = 0
            vCount = 0
        End If
    Else
        aCount = 0
        gOPMReady = False
    End If
    
End Sub

Private Sub HScrVLED_Change()

    lblVLED.caption = format(HScrVLED.value / HScrVLED.LargeChange / 100# + VLEDoffset, "#.000")
    
    frmEtIo.setLEDvolts 7, lblVLED.caption 'frmEtIo.AER.LED6500K
    'ucMonochromator1.setVolts (lblVLED.caption)
    
    gVledReady = False

End Sub

Private Sub cmdSweepVLED_Click()
    Call frmEtIo.Show(0, Me)
    ledIdx = 0
    HScrVLED.value = HScrVLED.min
    average = 10
    tmrSweepVLED.Enabled = True
End Sub

Private Sub tmrSweepVLED_Timer()
    Static initDone As Boolean
    Dim i As Integer, j As Integer
    
    ' :: initialize
    If Not initDone Then
        Call frmPlot.setPlotSize(pdAls, (HScrVLED.max - HScrVLED.min) / HScrVLED.LargeChange + 1)
        frmPlot.ucPlot1(0).caption = "Power vs. VLED"
        frmPlot.ucPlot1(0).XaxisDataMin = VLEDoffset
        frmPlot.ucPlot1(0).XaxisDataMax = (HScrVLED.max - HScrVLED.min) / 1000# + VLEDoffset
        frmPlot.ucPlot1(0).XaxisLabel = "Vled"
        initDone = True
    End If
    
    If gOPMReady Then
        ' :: record
        gCalLedVal(ledIdx) = val(lblOPM.caption)
        Call frmPlot.plotData(pdAls, gCalLedVal(ledIdx))
        gOPMReady = False
        
        ' :: increment
        If HScrVLED.value < HScrVLED.max Then
        
            If HScrVLED.value + HScrVLED.LargeChange <= HScrVLED.max Then
                HScrVLED.value = HScrVLED.value + HScrVLED.LargeChange
            Else
                HScrVLED.value = HScrVLED.max
            End If
            
            ledIdx = ledIdx + 1
        
        ' :: terminate
        Else
        
            j = UBound(gCalLedVal)
            For i = 0 To j
                gCalLedVal(i) = gCalLedVal(i) / gCalLedVal(j)
            Next i
            
            tmrSweepVLED.Enabled = False
            initDone = False
    
        End If
    End If
    
End Sub

Private Sub cmdSweepFW_Click()
    fwIdx = 0
    pMono.setFwIndex (0)
    average = 100
    gFilterWheelReady = False
    tmrSweepFW.Enabled = True
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
    
    If gOPMReady Then
        ' :: record
        gCalFwVal(fwIdx) = val(lblOPM.caption)
        Call frmPlot.plotData(pdProx, gCalFwVal(fwIdx))
        gOPMReady = False
        If fwIdx > 0 Then gCalFwVal(fwIdx) = gCalFwVal(fwIdx) / gCalFwVal(0)
        fwIdx = fwIdx + 1
        ' :: increment
        If fwIdx < 36 Then
            pMono.setFwIndex (fwIdx)
            gFilterWheelReady = False
        ' :: terminate
        Else
            gCalFwVal(0) = 1
            tmrSweepFW.Enabled = False
            initDone = False
        End If
    End If
    
End Sub

Private Sub HScrCalTest_Change()
    Dim attn As Single: attn = (HScrCalTest.max - HScrCalTest.value) / HScrCalTest.max
    Dim thisFW As Integer
    
    thisFW = getFWset(attn)
    If thisFW <> fwIdx Then
        pMono.setFwIndex thisFW
        fwIdx = thisFW
        gFilterWheelReady = False
    End If
    
    HScrVLED.value = getVLEDset(attn, HScrVLED.LargeChange) ' interpolate
    gVledReady = False
    
    lblCalTest.caption = HScrCalTest.value
    
End Sub

Private Sub cmdCalTest_Click()
    average = 5
    tmrCalTest.Enabled = True
End Sub

Private Sub tmrCalTest_Timer()
    Static initDone As Boolean
    
    ' :: initialize
    If Not initDone Then
        Call frmPlot.setPlotSize(pdAls, (HScrCalTest.max - HScrCalTest.min) / HScrCalTest.LargeChange + 1, 2)
        frmPlot.ucPlot1(2).caption = "Power"
        frmPlot.ucPlot1(2).XaxisDataMin = HScrCalTest.min
        frmPlot.ucPlot1(2).XaxisDataMax = HScrCalTest.max
        frmPlot.ucPlot1(2).XaxisLabel = "Code"
        initDone = True
    End If
    
    If gOPMReady Then
        ' :: record
        Call frmPlot.plotData(pdAls, lblOPM.caption, 2)
        gOPMReady = False
        
        If debugPrint_ Then
            Call debugPrint(fwIdx, lblVLED.caption, lblOPM.caption)
        End If
        
        ' :: increment
        If HScrCalTest.value < HScrCalTest.max Then
            If HScrCalTest.value + HScrCalTest.LargeChange < HScrCalTest.max Then
                HScrCalTest.value = HScrCalTest.value + HScrCalTest.LargeChange
            Else
                HScrCalTest.value = HScrCalTest.max
            End If
        Else
            ' :: terminate
            tmrCalTest.Enabled = False
            initDone = False
        End If
    End If
    
End Sub

Private Sub cmdTestDut_Click()
    tmrTestDUT.Enabled = True
End Sub


Private Sub tmrTestDUT_Timer()
    Static initDone As Boolean
    
    ' :: initialize
    If Not initDone Then
        Call frmPlot.setPlotSize(pdAls, (HScrCalTest.max - HScrCalTest.min) / HScrCalTest.LargeChange + 1, 3)
        frmPlot.ucPlot1(3).caption = "DUT Transfer"
        frmPlot.ucPlot1(3).XaxisDataMin = HScrCalTest.min
        frmPlot.ucPlot1(3).XaxisDataMax = HScrCalTest.max
        frmPlot.ucPlot1(3).XaxisLabel = "ATTN * 1024"
        initDone = True
    End If
    
    If frmMain.measLuxValid Then
        ' :: record
        Call frmPlot.plotData(pdAls, frmMain.measLux, 3)
        frmMain.measLuxValid = False
        If debugPrint_ Then
            Call debugPrint(fwIdx, lblVLED.caption, frmMain.measLux)
        End If
        ' :: increment
        If HScrCalTest.value < HScrCalTest.max Then
            If HScrCalTest.value + HScrCalTest.LargeChange < HScrCalTest.max Then
                HScrCalTest.value = HScrCalTest.value + HScrCalTest.LargeChange
            Else
                HScrCalTest.value = HScrCalTest.max
            End If
        Else
            ' :: terminate
            tmrTestDUT.Enabled = False
            initDone = False
        End If
    End If
    
End Sub
