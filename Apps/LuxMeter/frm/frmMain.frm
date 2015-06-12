VERSION 5.00
Begin VB.Form frmMain 
   Caption         =   "Lux Meter"
   ClientHeight    =   3060
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   7725
   Icon            =   "frmMain.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   3060
   ScaleWidth      =   7725
   StartUpPosition =   3  'Windows Default
   Visible         =   0   'False
   Begin VB.CheckBox cbRunHold 
      Caption         =   "Run"
      Height          =   255
      Left            =   6600
      Style           =   1  'Graphical
      TabIndex        =   18
      Top             =   0
      Width           =   1095
   End
   Begin VB.Frame frmManual 
      Height          =   1935
      Left            =   2280
      TabIndex        =   5
      Top             =   1080
      Visible         =   0   'False
      Width           =   2775
      Begin VB.CheckBox cbGlass 
         Caption         =   "No Glass"
         Height          =   495
         Left            =   1320
         Style           =   1  'Graphical
         TabIndex        =   17
         Top             =   240
         Width           =   615
      End
      Begin VB.CheckBox cbLockRange 
         Caption         =   "Range:Auto"
         Height          =   495
         Left            =   120
         Style           =   1  'Graphical
         TabIndex        =   15
         Top             =   240
         Width           =   1095
      End
      Begin VB.TextBox tbCn 
         Height          =   285
         Index           =   3
         Left            =   1080
         MultiLine       =   -1  'True
         TabIndex        =   11
         Text            =   "frmMain.frx":44DDA
         ToolTipText     =   "HI:C1 value"
         Top             =   1560
         Width           =   855
      End
      Begin VB.TextBox tbCn 
         Height          =   285
         Index           =   2
         Left            =   1080
         MultiLine       =   -1  'True
         TabIndex        =   10
         Text            =   "frmMain.frx":44DE3
         ToolTipText     =   "HI:C0 value"
         Top             =   1200
         Width           =   855
      End
      Begin VB.TextBox tbCn 
         Height          =   285
         Index           =   1
         Left            =   120
         MultiLine       =   -1  'True
         TabIndex        =   9
         Text            =   "frmMain.frx":44DEB
         ToolTipText     =   "LO:C1 value"
         Top             =   1560
         Width           =   855
      End
      Begin VB.TextBox tbCn 
         Height          =   285
         Index           =   0
         Left            =   120
         MultiLine       =   -1  'True
         TabIndex        =   8
         Text            =   "frmMain.frx":44DF2
         ToolTipText     =   "LO:C0 value"
         Top             =   1200
         Width           =   855
      End
      Begin VB.ComboBox cmbRange 
         Height          =   315
         Left            =   1080
         TabIndex        =   7
         Text            =   "88888"
         ToolTipText     =   "Range Select"
         Top             =   840
         Width           =   855
      End
      Begin VB.CheckBox cbCompOFF 
         Caption         =   "Comp=ON"
         Height          =   255
         Left            =   120
         Style           =   1  'Graphical
         TabIndex        =   6
         ToolTipText     =   "Compensation"
         Top             =   840
         Width           =   855
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "Gain Adjust"
      Height          =   615
      Left            =   2280
      TabIndex        =   12
      Top             =   1080
      Width           =   5415
      Begin VB.HScrollBar HScrollGainAdjust 
         Height          =   255
         LargeChange     =   10
         Left            =   960
         Max             =   1000
         TabIndex        =   13
         Top             =   240
         Value           =   500
         Width           =   4335
      End
      Begin VB.Label lblGainAdjust 
         Alignment       =   1  'Right Justify
         Caption         =   "88.8%"
         Height          =   255
         Left            =   120
         TabIndex        =   14
         Top             =   240
         Width           =   615
      End
   End
   Begin VB.CheckBox cbAuto 
      Caption         =   "Auto (cal corrected)"
      Height          =   495
      Left            =   120
      Style           =   1  'Graphical
      TabIndex        =   4
      ToolTipText     =   "Auto/Manual Select"
      Top             =   1200
      Width           =   2055
   End
   Begin VB.Timer tmrMeas 
      Enabled         =   0   'False
      Interval        =   100
      Left            =   3480
      Top             =   6720
   End
   Begin LuxMeter.ucALSusb ucALSusb1 
      Height          =   495
      Left            =   1320
      TabIndex        =   0
      Top             =   6720
      Visible         =   0   'False
      Width           =   2055
      _ExtentX        =   3625
      _ExtentY        =   873
   End
   Begin VB.Label Label2 
      Caption         =   "FSR=888888.0"
      Height          =   255
      Left            =   120
      TabIndex        =   16
      Top             =   0
      Width           =   1215
   End
   Begin VB.Label Label1 
      Caption         =   "Loop Time"
      Height          =   255
      Left            =   2040
      TabIndex        =   3
      ToolTipText     =   "Measurement loop time"
      Top             =   0
      Width           =   1695
   End
   Begin VB.Label lblNewVal 
      Caption         =   "X"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   0
      TabIndex        =   2
      Top             =   480
      Width           =   135
   End
   Begin VB.Label lblLux 
      Caption         =   "8888.8 ± 000.0%"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   48
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   975
      Left            =   240
      TabIndex        =   1
      ToolTipText     =   "Lux ± stdev"
      Top             =   120
      Width           =   7455
   End
End
Attribute VB_Name = "frmMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Const luxSettledPercent As Double = 5#
Const rangeDownLow As Double = 0.2
Const rangeUpHigh As Double = 0.9
Const compSampleCount As Integer = 10

Const cC00 As Double = 1.13: Const cC01 As Double = 0.19 ' 35 deg, diffuser
Const cC10 As Double = 1.08: Const cC11 As Double = 0.04


Const gC00 As Double = 24.67: Const gC01 As Double = -0.71  ' 35 deg, 10x Glass
Const gC10 As Double = 23.03: Const gC11 As Double = -0.71

Dim C00 As Double, C01 As Double, C10 As Double, C11 As Double
Dim GainAdjust As Double

Const frmMainHeightAuto As Integer = 2145 + 200, frmMainWidthAuto As Integer = 7845 + 200
Const frmMainHeightManual As Integer = 3465 + 200, frmMainWidthManual As Integer = frmMainWidthAuto

Dim D1avg As clsMPA, D1mD2avg As clsMPA, LuxAvg As clsMPA, timeAvg As clsMPA
Const D1MPAsize As Integer = 32
Const D1mD2MPAsize As Integer = 32
Const LuxMPAsize As Integer = 32

Const tmrMeasInterval As Integer = 86 '100# * 1.6 / 1.8
Const nConvSwitchWait As Integer = 3

Dim loopValid As Integer

Dim d2d1Ratio As Double

Dim nRanges As Long, rangeN As Long
Dim fsLux As Double

Dim compOn As Boolean

Dim value As Double, mean As Double, rmsPercent As Double

Sub setComp(value As Boolean)
    
    If value Then
        als.dSetIRcomp 1
    Else
        als.dSetIRcomp 0
    End If
    
    tmrMeas.Interval = nConvSwitchWait * tmrMeasInterval
    
    compOn = value
    
End Sub

Private Sub cbAuto_Click()

    If cbAuto.value = vbChecked Then
        cbAuto.caption = "Manual (raw values)"
        frmManual.Visible = True
        Frame1.Visible = False
        Label1.Visible = False: Label2.Visible = False
        lblLux.BackColor = vbButtonFace
        cbCompOFF_Click
        Form_Resize
    Else
        cbAuto.caption = "Auto (cal corrected)"
        frmManual.Visible = False
        Frame1.Visible = True
        Label1.Visible = True: Label2.Visible = True
        Form_Resize
    End If
    
End Sub

Private Sub cbCompOFF_Click()
    
    If cbCompOFF.value = vbChecked Then
        cbCompOFF.caption = "Comp=OFF"
        setComp False
    Else
        cbCompOFF.caption = "Comp=ON"
        setComp True
    End If
    
End Sub

Private Sub cmbRange_Load()

    Dim i As Integer
    
    For i = 0 To nRanges - 1
        als.dSetRange i
        cmbRange.AddItem als.dGetRange(True)
    Next i
    
    als.dSetRange 0
    cmbRange.ListIndex = 0
    
End Sub

Private Sub cbGlass_Click()

    If cbGlass.value = vbChecked Then
        cbGlass.caption = "10x Glass"
    Else
        cbGlass.caption = "No Glass"
    End If
    
    loadCoefficients
    
End Sub

Private Sub cbLockRange_Click()

    If cbLockRange.value = vbChecked Then
        cbLockRange.caption = "Range:Fixed"
    Else
        cbLockRange.caption = "Range:Auto"
    End If
    
End Sub

Private Sub cbRunHold_Click()
    If cbRunHold.value = vbChecked Then
        cbRunHold.caption = "Hold"
        tmrMeas.Enabled = False
    Else
        cbRunHold.caption = "Run"
        tmrMeas.Enabled = True
    End If
End Sub

Private Sub cmbRange_Click()
    rangeN = cmbRange.ListIndex
    als.dSetRange rangeN
    fsLux = als.dGetRange(True)
End Sub

Private Sub loadCoefficients()
    If cbGlass.value = vbChecked Then
        C00 = gC00: C01 = gC01: tbCn(0).text = C00: tbCn(1).text = C01
        C10 = gC10: C11 = gC11: tbCn(2).text = C10: tbCn(3).text = C11
    Else
        C00 = cC00: C01 = cC01: tbCn(0).text = C00: tbCn(1).text = C01
        C10 = cC10: C11 = cC11: tbCn(2).text = C10: tbCn(3).text = C11
    End If
End Sub


Private Sub Form_Load()
    als.init
    
    Set D1avg = New clsMPA
    Set D1mD2avg = New clsMPA
    Set LuxAvg = New clsMPA
    Set timeAvg = New clsMPA
    
    clearMPA
    
    nRanges = als.dGetNrange
    rangeN = als.dGetRange
    fsLux = als.dGetRange(True)
    loopValid = compSampleCount
    compOn = True
    
    loadCoefficients
    cmbRange_Load
    HScrollGainAdjust_Change
    
    tmrMeas.Enabled = True
End Sub

Private Sub Form_Resize()

    If frmMain.WindowState = vbNormal Then
    
        If cbAuto.value = vbChecked Then            ' manual
            frmMain.Height = frmMainHeightManual
            frmMain.Width = frmMainWidthManual
        Else                                        ' auto
            frmMain.Height = frmMainHeightAuto
            frmMain.Width = frmMainWidthAuto
        End If
        
    Else
        If frmMain.WindowState = vbMaximized Then
            frmMain.WindowState = vbNormal
        End If
    End If
    
End Sub

Private Sub HScrollGainAdjust_Change()
    GainAdjust = (HScrollGainAdjust.value - 500) / 10#
    lblGainAdjust.caption = Format(GainAdjust, "#0.0") & "%"
    GainAdjust = (1 + GainAdjust / 100#)
End Sub

Private Sub tbCn_Click(Index As Integer)
    tbCn_Change Index
End Sub

Private Sub tbCn_Change(Index As Integer)
    Dim value As Double
    
    On Error GoTo badValue
    
    If enterText(tbCn(Index).text) Then
    
        value = tbCn(Index).text
        tbCn(Index).text = value
        
        Select Case Index
            Case 0: C00 = value
            Case 1: C01 = value
            Case 2: C10 = value
            Case 3: C11 = value
        End Select
                
    End If
    
    GoTo endSub
    
badValue: ' error has occured, restore to last value

        Select Case Index
            Case 0: tbCn(Index).text = C00
            Case 1: tbCn(Index).text = C01
            Case 2: tbCn(Index).text = C10
            Case 3: tbCn(Index).text = C11
        End Select
        
endSub: End Sub

Private Sub tmrMeas_Timer()
    Dim display As String, alarm As Boolean, tick As Long, timeSec As Double
    Static sampleCount As Integer, lastLux As Double, lastTick As Long
    
    On Error GoTo errorMsg
    
    value = als.dGetLux
    
    tmrMeas.Interval = tmrMeasInterval
    
    If cbAuto.value = vbChecked Then ' Manual
    
        checkMPA LuxAvg, value
        display = Format(value, "###0.0")
        display = display & " ± "
        display = display & Format(rmsPercent, "##0.0")
        display = display & "%"
        lblLux.caption = display
        
    Else
    
        If Not checkRange(sampleCount = compSampleCount) Then 'skip if a range switch was required
        
            'Debug.Print sampleCount, value,
            
            If sampleCount = compSampleCount Then                     ' measuring D1-D2
            
                tick = GetTickCount
                If lastTick > 0 Then
                    timeSec = (tick - lastTick) / 1000#
                    timeAvg.setValue timeSec, mean, rmsPercent
                    Label1.caption = "Loop=" & Format(mean, "##0.000")
                End If
                lastTick = tick
            
                setComp False
                
                If checkMPA(D1mD2avg, value) Then alarm = True
                
                d2d1Ratio = (lastLux - value) / lastLux
                
            Else                                                      ' measuring D1
            
                If sampleCount = 0 Then setComp True ' next measurement is D1-D2
            
                If checkMPA(D1avg, value) Then alarm = True
                
                lastLux = value
                
            End If
            
            'Debug.Print d2d1Ratio, value
            
            ' >>>>> DISPLAY <<<<<
            If rangeN > 1 Then                                ' correction
                value = C10 * (lastLux * (1 + d2d1Ratio * C11))
            Else
                value = C00 * (lastLux * (1 + d2d1Ratio * C01))
            End If
            
            If checkMPA(LuxAvg, value) Then alarm = True
            
            If Not alarm Then
                If loopValid = 0 Then
                
                    frmMain.Visible = True ' make visible after 1st valid measurement
                    lblLux.BackColor = vbButtonFace
                    display = Format(GainAdjust * value, "###0.0")
                    display = display & " ± "
                    display = display & Format(rmsPercent, "##0.0")
                    display = display & "%"
                    lblLux.caption = display
                    If lastLux <> 0 Then
                        Label2.caption = "FSR=" & Format(fsLux / lastLux * GainAdjust * value, "#####0.0")
                    End If
                    
                    If compOn Then
                        lblNewVal.BackColor = vbGreen
                    Else
                        lblNewVal.BackColor = vbButtonFace
                    End If
                    If lblNewVal.caption = "X" Then ' measure indicator
                        lblNewVal.caption = "+"
                    Else
                        lblNewVal.caption = "X"
                    End If
                    
                Else
                    loopValid = loopValid - 1
                End If
            Else
                lblLux.BackColor = vbRed
                'loopValid = compSampleCount
            End If
            
            ' >>>>> INCREMENT <<<<<
            If sampleCount > 0 Then
                sampleCount = sampleCount - 1
            Else
                sampleCount = compSampleCount
                'setComp True
            End If
            
        End If
    
    End If
    GoTo endSub
errorMsg:
    MsgBox ("Error Initializing, Terminating Program")
    End
endSub: End Sub

Function checkRange(Optional ByVal nEnable As Boolean = False) As Boolean

    If (Not nEnable) And (cbLockRange.value <> vbChecked) Then

        If rangeN > 0 And value < rangeDownLow * fsLux Then ' range down
            rangeN = rangeN - 1
            als.dSetRange rangeN
            fsLux = als.dGetRange(True)
            tmrMeas.Interval = nConvSwitchWait * tmrMeasInterval
            checkRange = True
            clearMPA
            cmbRange.ListIndex = rangeN
        Else
            If rangeN < nRanges - 1 And value > rangeUpHigh * fsLux Then ' range up
                rangeN = rangeN + 1
                als.dSetRange rangeN
                fsLux = als.dGetRange(True)
                tmrMeas.Interval = nConvSwitchWait * tmrMeasInterval
                checkRange = True
                clearMPA
                cmbRange.ListIndex = rangeN
            End If
        End If
    
    End If

End Function

Function checkMPA(valueMPA As clsMPA, value As Double) As Boolean

    On Error GoTo error

    valueMPA.setValue value, mean, rmsPercent
    
    If (rmsPercent < luxSettledPercent) And (0 <= rmsPercent) And (0 <= value) And (0 <= mean) Then
        value = mean
    End If
    GoTo endFunction
    
error:
    checkMPA = True
    valueMPA.setSize ' clear it
    value = 0
endFunction: End Function

Sub clearMPA()
    D1avg.setSize D1MPAsize
    D1mD2avg.setSize D1mD2MPAsize
    LuxAvg.setSize LuxMPAsize
End Sub

