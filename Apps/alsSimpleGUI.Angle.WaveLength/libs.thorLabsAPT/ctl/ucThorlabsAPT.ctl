VERSION 5.00
Object = "{2A833923-9AA7-4C45-90AC-DA4F19DC24D1}#1.0#0"; "MG17MO~1.OCX"
Begin VB.UserControl ucThorlabsAPT 
   ClientHeight    =   4635
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   5130
   ScaleHeight     =   4635
   ScaleWidth      =   5130
   Begin VB.Frame fmSweep 
      BackColor       =   &H008080FF&
      Caption         =   "Sweep"
      Height          =   615
      Left            =   5760
      TabIndex        =   17
      Top             =   120
      Width           =   2295
      Begin VB.CommandButton cmdSweep 
         Caption         =   "Arm"
         Height          =   255
         Left            =   120
         MaskColor       =   &H8000000F&
         TabIndex        =   20
         Top             =   240
         Width           =   495
      End
      Begin VB.CheckBox cbSweepType 
         Caption         =   "Stepped"
         Height          =   255
         Left            =   600
         Style           =   1  'Graphical
         TabIndex        =   19
         Top             =   240
         Width           =   735
      End
      Begin VB.CommandButton cmdCalSweep 
         Caption         =   "Calibrate"
         Enabled         =   0   'False
         Height          =   255
         Left            =   1320
         TabIndex        =   18
         Top             =   240
         Width           =   855
      End
   End
   Begin VB.Timer tmrCalSweep 
      Interval        =   100
      Left            =   5280
      Top             =   600
   End
   Begin VB.Timer tmrGetPos 
      Enabled         =   0   'False
      Interval        =   500
      Left            =   5280
      Top             =   120
   End
   Begin VB.Frame frmSerNum 
      Caption         =   "Serial Number"
      Height          =   615
      Left            =   240
      TabIndex        =   0
      Top             =   120
      Width           =   1335
      Begin VB.TextBox tbSerNum 
         Height          =   315
         Left            =   120
         MultiLine       =   -1  'True
         TabIndex        =   3
         Text            =   "ucThorlabsAPT.ctx":0000
         Top             =   240
         Width           =   855
      End
      Begin VB.ComboBox cmbSerNum 
         Height          =   315
         ItemData        =   "ucThorlabsAPT.ctx":000B
         Left            =   120
         List            =   "ucThorlabsAPT.ctx":003F
         TabIndex        =   1
         Text            =   "83820779"
         Top             =   240
         Width           =   1095
      End
   End
   Begin MG17MotorLib.MG17Motor MG17Motor1 
      Height          =   3015
      Left            =   0
      TabIndex        =   2
      Top             =   1560
      Width           =   5055
      _Version        =   65536
      _ExtentX        =   8916
      _ExtentY        =   5318
      _StockProps     =   0
      HWSerialNum     =   83820779
      APTF1Help       =   1
   End
   Begin VB.Frame frmMG17Motor 
      Height          =   1455
      Left            =   0
      TabIndex        =   4
      Top             =   0
      Width           =   5055
      Begin VB.CheckBox cbBlocking 
         Caption         =   "Position: Non-Blocking"
         Height          =   255
         Left            =   2760
         Style           =   1  'Graphical
         TabIndex        =   21
         Top             =   180
         Width           =   1935
      End
      Begin VB.CommandButton cmdZeroHome 
         Caption         =   "Zero->Home"
         Height          =   255
         Left            =   1440
         TabIndex        =   11
         Top             =   180
         Width           =   1215
      End
      Begin VB.Frame frmMG17LoopParams 
         Caption         =   "Position"
         Height          =   615
         Index           =   4
         Left            =   1080
         TabIndex        =   15
         Top             =   720
         Width           =   975
         Begin VB.TextBox tbMG17LoopParams 
            Alignment       =   1  'Right Justify
            Enabled         =   0   'False
            Height          =   285
            Index           =   4
            Left            =   120
            MultiLine       =   -1  'True
            TabIndex        =   16
            Text            =   "ucThorlabsAPT.ctx":00E2
            Top             =   240
            Width           =   735
         End
      End
      Begin VB.Frame frmMG17LoopParams 
         Caption         =   "Offset"
         Height          =   615
         Index           =   3
         Left            =   120
         TabIndex        =   13
         Top             =   720
         Width           =   975
         Begin VB.TextBox tbMG17LoopParams 
            Alignment       =   1  'Right Justify
            Enabled         =   0   'False
            Height          =   285
            Index           =   3
            Left            =   120
            MultiLine       =   -1  'True
            TabIndex        =   14
            Text            =   "ucThorlabsAPT.ctx":00E4
            Top             =   240
            Width           =   735
         End
      End
      Begin VB.CommandButton cmdStoreZero 
         Caption         =   "StoreOffset"
         Height          =   255
         Left            =   1440
         TabIndex        =   12
         Top             =   420
         Width           =   1215
      End
      Begin VB.Frame frmMG17LoopParams 
         Caption         =   "Step"
         Height          =   615
         Index           =   2
         Left            =   3960
         TabIndex        =   9
         Top             =   720
         Width           =   975
         Begin VB.TextBox tbMG17LoopParams 
            Alignment       =   1  'Right Justify
            Height          =   285
            Index           =   2
            Left            =   120
            MultiLine       =   -1  'True
            TabIndex        =   10
            Text            =   "ucThorlabsAPT.ctx":00E6
            Top             =   240
            Width           =   735
         End
      End
      Begin VB.Frame frmMG17LoopParams 
         Caption         =   "Stop"
         Height          =   615
         Index           =   1
         Left            =   3000
         TabIndex        =   7
         Top             =   720
         Width           =   975
         Begin VB.TextBox tbMG17LoopParams 
            Alignment       =   1  'Right Justify
            Height          =   285
            Index           =   1
            Left            =   120
            MultiLine       =   -1  'True
            TabIndex        =   8
            Text            =   "ucThorlabsAPT.ctx":00E9
            Top             =   240
            Width           =   735
         End
      End
      Begin VB.Frame frmMG17LoopParams 
         Caption         =   "Start"
         Height          =   615
         Index           =   0
         Left            =   2040
         TabIndex        =   5
         Top             =   720
         Width           =   975
         Begin VB.TextBox tbMG17LoopParams 
            Alignment       =   1  'Right Justify
            Height          =   285
            Index           =   0
            Left            =   120
            MultiLine       =   -1  'True
            TabIndex        =   6
            Text            =   "ucThorlabsAPT.ctx":00EC
            Top             =   240
            Width           =   735
         End
      End
   End
End
Attribute VB_Name = "ucThorlabsAPT"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Enum loopParams
    eStart
    eStop
    eStep
    eOffset
    ePosition
End Enum

Dim me_height As Integer, me_width As Integer
Dim ltsEnabled As Boolean
Dim HWSerialNum As Long

Dim gLoopCount As Integer, gLoopEnd As Integer

Const ltsHWSerialNum As Long = 45839763 '45821356
Const rotHWSerialNum As Long = 83820662
Const cr1z7HWSerialNum As Long = 83820779
Const mts50z8HWSerialNum As Long = 83833260

Const cFastOvershoot As Single = 1.2

Const debugFlag As Boolean = False

Dim linearStage As Boolean
Dim fastSweepEnabled As Boolean

Dim gSweepStartTick As Long

Dim gAccn As Single, gSpeed As Single, gMinSpeed As Single, gMaxSpeed As Single, gMaxAccn As Single
Dim gSpeedRatio As Single

Dim ucThorlabsAPT1_Height As Integer, ucThorlabsAPT1_Width As Integer

Public pMG17Motor As MG17Motor

Sub SetAbsMovePos(ByVal pos As Single)

    If MG17Enabled Then
    
        pos = npos(pos + tbMG17LoopParams(eOffset).text)
        If pos > 50 And pos < 51 Then pos = 50
        Call MG17Motor1.SetAbsMovePos(CHAN1_ID, pos)
        
        If cbBlocking.value = vbChecked Then
            Call MG17Motor1.MoveAbsolute(CHAN1_ID, True) 'JWG True is blocking call
        Else
            Call MG17Motor1.MoveAbsolute(CHAN1_ID, False) 'JWG True is blocking call
        End If
        
        If debugFlag Then debugPrint pos
        
    End If
    
End Sub

Private Sub wait4done(fpos As Single)
    Dim pos(0) As Single, lpos As Single: lpos = -400
    Dim count As Integer: count = 3000
    Call moveTo(fpos, False)
    pos(0) = getValue(pos)
    
    While ((Abs(fpos - pos(0)) > 1) And count > 0)
        count = count - 1
        Sleep (20): DoEvents
        pos(0) = getValue(pos)
        
        If lpos <> -400 Then
            If pos(0) = lpos Then ' motor has stopped, resend move
                Call moveTo(fpos, False)
                Sleep (20): DoEvents
            End If
        End If
        lpos = pos(0)
        Debug.Print "set=" & fpos & " get=" & pos(0)
    Wend
    
    fpos = pos(0)

End Sub

Sub moveTo(ByVal pos As Single, Optional ByVal waitTilDone As Boolean = True)
    
    SetAbsMovePos (pos)
    If waitTilDone Then Call wait4done(pos)
    
    tbMG17LoopParams(ePosition).text = format(pos, "###.000")
    
End Sub

Private Sub MG17Motor_Initialize()
    Dim error As Long
    
    MG17Motor1.HWSerialNum = tbSerNum.text
    HWSerialNum = MG17Motor1.HWSerialNum
    error = MG17Motor1.StartCtrl
    error = MG17Motor1.EnableHWChannel(CHAN1_ID)
    
    If error Then
        MG17Enabled = False
    Else
        MG17Enabled = True
        frmSerNum.enabled = False
        linearStage = (HWSerialNum = ltsHWSerialNum)
        tmrGetPos.enabled = True
        
        Call MG17Motor1.GetVelParams(CHAN1_ID, gMinSpeed, gMaxAccn, gMaxSpeed)
        
        Select Case HWSerialNum
        Case ltsHWSerialNum: gMaxSpeed = 15: gMaxAccn = 5: setStart 0: setStop 160: setStep 2
        Case cr1z7HWSerialNum: gMaxSpeed = 6: gMaxAccn = 5: setStart -90: setStop 90: setStep 1
        Case Else: gMaxSpeed = 5: gMaxAccn = 5: setStart 0: setStop 30: setStep 6
        End Select
        
        Call MG17Motor1.SetVelParams(CHAN1_ID, gMinSpeed, gMaxAccn, gMaxSpeed)
        gSpeed = gMaxSpeed: gAccn = gMaxAccn
    
    End If
End Sub

Private Function npos(ByVal pos As Single) As Single
    Dim i As Integer
    
    If linearStage Then
        npos = 300 - pos
    Else
        i = pos / 180 - 0.5
        npos = pos - i * 180
        If i And 1 Then npos = npos - 180
    End If
    
End Function

Private Sub cbBlocking_Click()
    If cbBlocking.value = vbChecked Then
        cbBlocking.caption = "Position: Blocking"
    Else
        cbBlocking.caption = "Position: Non-Blocking"
    End If
End Sub

Private Sub cbSweepType_Click()
    If cbSweepType.value = vbChecked Then
        setFastSweepEnabled True
    Else
        setFastSweepEnabled False
    End If
End Sub

Public Sub setFastSweepEnabled(enabled As Boolean)
    If enabled Then
        cbSweepType.value = vbChecked
        cbSweepType.caption = "Fast"
        cmdCalSweep.Visible = True
    Else
        cbSweepType.value = vbUnchecked
        cbSweepType.caption = "Stepped"
        cmdCalSweep.Visible = False
    End If
    fastSweepEnabled = enabled
End Sub

Public Function getFastSweepEnabled() As Boolean
    getFastSweepEnabled = fastSweepEnabled
End Function


Public Sub setMotorSweepSpeed(Optional Ratio As Single = 1)

    Dim speed As Single, fMinVel As Single, fAccn As Single
    
    If Ratio > 1 Then
        Ratio = 1
    Else
        If Ratio < 0.05 Then
            Ratio = 0.05
        End If
    End If
        
    
    gSpeed = Ratio * gMaxSpeed
    If gSpeed > gMaxSpeed Then gSpeed = gMaxSpeed
    
    Call MG17Motor1.SetVelParams(CHAN1_ID, gMinSpeed, gAccn, gSpeed)
    DoEvents
    
End Sub

Private Sub cmbSamplePeriod_Change()

End Sub

Private Sub cmdSweep_Click()
    fmSweep.BackColor = &H80FF80 'pale green
    arm
    If cbSweepType.caption = "Fast" Then
        setMotorSweepSpeed gSpeedRatio
    End If
End Sub

Private Sub tmrGetPos_Timer()
    Dim value(0) As Single
    getValue value
End Sub

Private Sub UserControl_Initialize()
    'Dim i As Integer
    ucThorlabsAPT1_Height = UserControl.Height - MG17Motor1.Height
    ucThorlabsAPT1_Width = UserControl.Width - MG17Motor1.Width
    Set pMG17Motor = MG17Motor1
    tbSerNum.text = cmbSerNum.text
    HWSerialNum = tbSerNum.text
    gSpeedRatio = 1
End Sub

Private Sub UserControl_Resize()
    If (UserControl.Height - ucThorlabsAPT1_Height) > 0 Then MG17Motor1.Height = UserControl.Height - ucThorlabsAPT1_Height
    If (UserControl.Width - ucThorlabsAPT1_Width) > 0 Then MG17Motor1.Width = UserControl.Width - ucThorlabsAPT1_Width
End Sub

Private Sub tbSerNum_Change()
    Dim serNum As Long
    On Error GoTo errorExit
    If enterText(tbSerNum.text) Then
        serNum = tbSerNum.text
        tbSerNum.text = serNum
        MG17Motor_Initialize
    End If
    GoTo sucessExit
errorExit:
    tbSerNum.text = HWSerialNum
sucessExit:
End Sub

Private Sub cmbSerNum_Click()
    tbSerNum.text = cmbSerNum.text & Chr$(13)
End Sub

Private Sub cmdZeroHome_Click()
    moveTo (-tbMG17LoopParams(eOffset).text)
    Sleep (1000)
    Call MG17Motor1.MoveHome(CHAN1_ID, True)
End Sub

Private Sub cmdStoreZero_Click()
    Dim Position As Single
    Call MG17Motor1.getPosition(CHAN1_ID, Position)
    tbMG17LoopParams(eOffset).text = format(npos(Position), "###.000")
End Sub











Private Sub tbMG17LoopParams_Change(Index As Integer)
    Dim test As Double
    On Error GoTo errorExit
    If enterText(tbMG17LoopParams(Index).text) Then
        test = tbMG17LoopParams(Index).text
        tbMG17LoopParams(Index).text = test
    End If
    GoTo sucessExit
errorExit:
    tbSerNum.text = HWSerialNum
sucessExit:
End Sub

'Private Function enterText(ByRef text As String) As Integer
'    ' strip [cr] & [lf], return > 0
'    enterText = InStr(text, Chr(13))
'    If (enterText) Then
'        text = Mid(text, 1, enterText - 1)
'    End If
'End Function






Private Function getLoopParam(param As Integer) As Single
    getLoopParam = tbMG17LoopParams(param).text
End Function
Private Sub setLoopParam(param As Integer, val As Single)
    tbMG17LoopParams(param).text = val & Chr$(13)
End Sub

Public Function getStart() As Single: getStart = getLoopParam(eStart): End Function
Public Sub setStart(val As Single): Call setLoopParam(eStart, val): End Sub

Public Function getStop() As Single: getStop = getLoopParam(eStop): End Function
Public Sub setStop(val As Single): Call setLoopParam(eStop, val): End Sub

Public Function getStep() As Single: getStep = getLoopParam(eStep): End Function
Public Sub setStep(val As Single): Call setLoopParam(eStep, val): End Sub

Public Function getOffset() As Single: getOffset = getLoopParam(eOffset): End Function
Public Sub setOffset(val As Single): Call setLoopParam(eOffset, val): End Sub




Public Function getHWSerialNum() As Long: getHWSerialNum = HWSerialNum: End Function
Public Sub setHWSerialNum(serNum As Long): tbSerNum.text = serNum & Chr$(13): End Sub




Public Function getValue(value() As Single) As Single

    If MG17Enabled Then
        Call MG17Motor1.getPosition(CHAN1_ID, getValue)
        getValue = npos(getValue - val(tbMG17LoopParams(eOffset).text))
        tbMG17LoopParams(ePosition).text = format(getValue, "###.000")
    End If
    
    value(0) = getValue
    
End Function

Public Sub setPosition(pos As Single)
    Call moveTo(pos)
End Sub

Public Sub arm()
    gLoopCount = 0
    gLoopEnd = (tbMG17LoopParams(eStop).text - tbMG17LoopParams(eStart).text) / tbMG17LoopParams(eStep).text + 1
    next_
End Sub

Public Sub next_()
    If gLoopCount Then
        If fastSweepEnabled Then
            If gLoopCount = 1 Then
                tmrGetPos.enabled = False
                Call moveTo(tbMG17LoopParams(eStop).text, False)
            End If
        Else
            If done = False Then
                moveTo (tbMG17LoopParams(eStart).text + gLoopCount * tbMG17LoopParams(eStep).text)
            End If
        End If
    Else ' arm
        setMotorSweepSpeed 1
        Call moveTo(tbMG17LoopParams(eStart).text)
        setMotorSweepSpeed gSpeedRatio
    End If
    
    gLoopCount = gLoopCount + 1
    
End Sub

Public Function done() As Boolean
    Dim value(0) As Single
    If fastSweepEnabled Then
        If (Abs(tbMG17LoopParams(eStop).text - getValue(value)) < 0.01) Then
            done = True
            setMotorSweepSpeed 0
            gSpeedRatio = gSpeedRatio * gLoopCount / cFastOvershoot / gLoopEnd
        Else
            done = False
        End If
    Else
        done = (gLoopCount >= gLoopEnd)
    End If
    
    If done Then
        fmSweep.BackColor = &H8080FF ' pale red
        tmrGetPos.enabled = True
    End If

End Function

Private Sub cmdCalSweep_Click()
    tmrCalSweep.enabled = True
    gSweepStartTick = GetTickCount
    fastSweepEnabled = getFastSweepEnabled
End Sub

Private Sub tmrCalSweep_Timer()
    Static tmrCounts As Long, lpos As Single
    Dim pos(0) As Single, ticks As Single, msPerStep As Single
    Dim timerSubTime As Single, loopTime As Single, newTime As Single
    
    If fastSweepEnabled Then
        If done Then
        
            gSweepStartTick = GetTickCount - gSweepStartTick
            ticks = (getStop - getStart) / getStep + 1
            
            loopTime = gSweepStartTick / tmrCounts
            timerSubTime = loopTime - tmrCalSweep.Interval
            newTime = loopTime * tmrCounts / ticks
            If (newTime - timerSubTime) > 100 Then
                tmrCalSweep.Interval = newTime - timerSubTime
            Else
                setMotorSweepSpeed (tmrCounts / ticks)
            End If
            
            tmrCalSweep.enabled = False
            tmrCounts = 0
        Else
            pos(0) = getValue(pos)
            If tmrCounts = 0 Then
                next_
            Else
                debugPrint pos(0) - lpos
            End If
            tmrCounts = tmrCounts + 1
            lpos = pos(0)
        End If
    Else
         tmrCalSweep.enabled = False
         tmrCounts = 0
    End If
End Sub


