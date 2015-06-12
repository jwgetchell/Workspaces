VERSION 5.00
Begin VB.Form frmMain 
   Caption         =   "177drvAlgo"
   ClientHeight    =   3795
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   4245
   Icon            =   "frmMain.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   ScaleHeight     =   3795
   ScaleWidth      =   4245
   StartUpPosition =   3  'Windows Default
   Begin VB.Timer tmrMeasBase 
      Enabled         =   0   'False
      Interval        =   15
      Left            =   960
      Top             =   0
   End
   Begin VB.Timer tmrRunTime 
      Enabled         =   0   'False
      Interval        =   100
      Left            =   1440
      Top             =   0
   End
   Begin drvAlgo177.ucALSusb ucALSusb1 
      Height          =   30
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Visible         =   0   'False
      Width           =   30
      _ExtentX        =   53
      _ExtentY        =   53
   End
   Begin VB.Timer tmrInit 
      Enabled         =   0   'False
      Interval        =   100
      Left            =   0
      Top             =   0
   End
   Begin VB.Timer tmrXtalkAdj 
      Enabled         =   0   'False
      Interval        =   15
      Left            =   480
      Top             =   0
   End
   Begin VB.Frame frameDefaults 
      Height          =   3735
      Left            =   0
      TabIndex        =   1
      Top             =   0
      Width           =   4215
      Begin VB.Frame fmAdjustTime 
         Caption         =   "Adj. Time (ms)"
         Height          =   615
         Left            =   120
         TabIndex        =   44
         Top             =   3000
         Width           =   1215
         Begin VB.Label lblAdjustTime 
            Alignment       =   2  'Center
            Caption         =   "8888"
            Height          =   255
            Left            =   120
            TabIndex        =   45
            Top             =   240
            Width           =   975
         End
      End
      Begin VB.Frame fmInt 
         Caption         =   "pFlag"
         Height          =   615
         Left            =   1440
         TabIndex        =   39
         Top             =   2400
         Width           =   1095
         Begin VB.CheckBox cbIntEn 
            Height          =   255
            Left            =   720
            Style           =   1  'Graphical
            TabIndex        =   43
            Top             =   240
            Width           =   255
         End
         Begin VB.CommandButton cmdIntClr 
            Height          =   255
            Left            =   480
            TabIndex        =   41
            Top             =   240
            Width           =   255
         End
         Begin VB.Label lblIntChg 
            Caption         =   "X"
            Height          =   255
            Left            =   360
            TabIndex        =   42
            Top             =   240
            Width           =   135
         End
         Begin VB.Label lblInt 
            Alignment       =   1  'Right Justify
            Caption         =   "0"
            Height          =   255
            Left            =   120
            TabIndex        =   40
            Top             =   240
            Width           =   135
         End
      End
      Begin VB.Frame fmProximity 
         Caption         =   "Proximity"
         Height          =   2655
         Left            =   2640
         TabIndex        =   20
         Top             =   240
         Width           =   1455
         Begin VB.Line Line2 
            BorderColor     =   &H80000005&
            X1              =   120
            X2              =   1200
            Y1              =   500
            Y2              =   500
         End
         Begin VB.Line Line1 
            X1              =   120
            X2              =   1200
            Y1              =   480
            Y2              =   480
         End
         Begin VB.Label lblProximity 
            Caption         =   "xTalk:"
            Height          =   255
            Index           =   8
            Left            =   120
            TabIndex        =   38
            Top             =   2280
            Width           =   495
         End
         Begin VB.Label lblProxVal 
            Alignment       =   1  'Right Justify
            Caption         =   "8.88"
            Height          =   315
            Index           =   8
            Left            =   600
            TabIndex        =   37
            Top             =   2280
            Width           =   615
         End
         Begin VB.Label lblProxVal 
            Alignment       =   1  'Right Justify
            Caption         =   "8.88"
            Height          =   255
            Index           =   7
            Left            =   840
            TabIndex        =   36
            Top             =   2040
            Width           =   375
         End
         Begin VB.Label lblProximity 
            Caption         =   "Pk-Pk:"
            Height          =   255
            Index           =   7
            Left            =   120
            TabIndex        =   35
            Top             =   2040
            Width           =   735
         End
         Begin VB.Label lblProxVal 
            Alignment       =   1  'Right Justify
            Caption         =   "8.88"
            Height          =   255
            Index           =   6
            Left            =   840
            TabIndex        =   34
            Top             =   1800
            Width           =   375
         End
         Begin VB.Label lblProxVal 
            Alignment       =   1  'Right Justify
            Caption         =   "8.88"
            Height          =   255
            Index           =   5
            Left            =   840
            TabIndex        =   33
            Top             =   1560
            Width           =   375
         End
         Begin VB.Label lblProxVal 
            Alignment       =   1  'Right Justify
            Caption         =   "8.88"
            Height          =   255
            Index           =   4
            Left            =   840
            TabIndex        =   32
            Top             =   1320
            Width           =   375
         End
         Begin VB.Label lblProxVal 
            Alignment       =   1  'Right Justify
            Caption         =   "8.88"
            Height          =   255
            Index           =   3
            Left            =   840
            TabIndex        =   31
            Top             =   1080
            Width           =   375
         End
         Begin VB.Label lblProxVal 
            Alignment       =   1  'Right Justify
            Caption         =   "8.88"
            Height          =   255
            Index           =   2
            Left            =   840
            TabIndex        =   30
            Top             =   240
            Width           =   375
         End
         Begin VB.Label lblProxVal 
            Alignment       =   1  'Right Justify
            Caption         =   "8.88"
            Height          =   255
            Index           =   1
            Left            =   840
            TabIndex        =   29
            Top             =   840
            Width           =   375
         End
         Begin VB.Label lblProxVal 
            Alignment       =   1  'Right Justify
            Caption         =   "8.88"
            Height          =   255
            Index           =   0
            Left            =   840
            TabIndex        =   28
            Top             =   600
            Width           =   375
         End
         Begin VB.Label lblProximity 
            Caption         =   "Rms:"
            Height          =   255
            Index           =   6
            Left            =   120
            TabIndex        =   27
            Top             =   1800
            Width           =   735
         End
         Begin VB.Label lblProximity 
            Caption         =   "Min:"
            Height          =   255
            Index           =   5
            Left            =   120
            TabIndex        =   26
            Top             =   1560
            Width           =   735
         End
         Begin VB.Label lblProximity 
            Caption         =   "Mean:"
            Height          =   255
            Index           =   4
            Left            =   120
            TabIndex        =   25
            Top             =   1320
            Width           =   735
         End
         Begin VB.Label lblProximity 
            Caption         =   "Max:"
            Height          =   255
            Index           =   3
            Left            =   120
            TabIndex        =   24
            Top             =   1080
            Width           =   735
         End
         Begin VB.Label lblProximity 
            Caption         =   "Raw:"
            Height          =   255
            Index           =   2
            Left            =   120
            TabIndex        =   23
            Top             =   600
            Width           =   735
         End
         Begin VB.Label lblProximity 
            Caption         =   "Baseline:"
            Height          =   255
            Index           =   1
            Left            =   120
            TabIndex        =   22
            Top             =   840
            Width           =   735
         End
         Begin VB.Label lblProximity 
            Caption         =   "Relative:"
            Height          =   255
            Index           =   0
            Left            =   120
            TabIndex        =   21
            Top             =   240
            Width           =   735
         End
      End
      Begin VB.CheckBox cbDutyCycle 
         Caption         =   "30%"
         Height          =   255
         Left            =   240
         Style           =   1  'Graphical
         TabIndex        =   19
         Top             =   600
         Width           =   975
      End
      Begin VB.Frame Frame2 
         Caption         =   "State"
         Height          =   615
         Left            =   120
         TabIndex        =   15
         Top             =   960
         Width           =   1215
         Begin VB.Label lblState 
            Alignment       =   2  'Center
            Caption         =   "State"
            Height          =   255
            Left            =   120
            TabIndex        =   16
            Top             =   240
            Width           =   975
         End
      End
      Begin VB.Frame Frame1 
         Caption         =   "Sequence"
         Height          =   615
         Left            =   120
         TabIndex        =   13
         Top             =   2400
         Width           =   1215
         Begin VB.Label lblSeq 
            Alignment       =   2  'Center
            Caption         =   "Sequence"
            Height          =   255
            Left            =   120
            TabIndex        =   14
            Top             =   240
            Width           =   975
         End
      End
      Begin VB.Frame frameMeasure 
         Caption         =   "Thesh Hi"
         Height          =   615
         Index           =   4
         Left            =   2640
         TabIndex        =   11
         Top             =   3000
         Width           =   1095
         Begin VB.TextBox tbThresh 
            Height          =   315
            Index           =   1
            Left            =   120
            MultiLine       =   -1  'True
            TabIndex        =   12
            Text            =   "frmMain.frx":0ECA
            Top             =   240
            Width           =   855
         End
      End
      Begin VB.Frame frameMeasure 
         Caption         =   "Thesh Lo"
         Height          =   615
         Index           =   3
         Left            =   1440
         TabIndex        =   9
         Top             =   3000
         Width           =   1095
         Begin VB.TextBox tbThresh 
            Height          =   315
            Index           =   0
            Left            =   120
            MultiLine       =   -1  'True
            TabIndex        =   10
            Text            =   "frmMain.frx":0ED0
            Top             =   240
            Width           =   855
         End
      End
      Begin VB.CommandButton cmdReset 
         Caption         =   "Reset"
         Height          =   255
         Left            =   240
         TabIndex        =   8
         Top             =   360
         Width           =   975
      End
      Begin VB.Frame frameBitField 
         Caption         =   "Sleep Time"
         Height          =   615
         Index           =   2
         Left            =   1440
         TabIndex        =   6
         Top             =   1680
         Width           =   1095
         Begin VB.ComboBox cmbBitField 
            Height          =   315
            Index           =   2
            ItemData        =   "frmMain.frx":0ED6
            Left            =   120
            List            =   "frmMain.frx":0EF5
            TabIndex        =   7
            Text            =   "SLEEP"
            Top             =   240
            Width           =   855
         End
      End
      Begin VB.Frame frameBitField 
         Caption         =   "IRDR"
         Height          =   615
         Index           =   1
         Left            =   1440
         TabIndex        =   4
         Top             =   960
         Width           =   1095
         Begin VB.ComboBox cmbBitField 
            Height          =   315
            Index           =   1
            ItemData        =   "frmMain.frx":0F20
            Left            =   120
            List            =   "frmMain.frx":0F3C
            TabIndex        =   5
            Text            =   "IRDR"
            Top             =   240
            Width           =   855
         End
      End
      Begin VB.Frame frameBitField 
         Caption         =   "Persistence"
         Height          =   615
         Index           =   0
         Left            =   1440
         TabIndex        =   2
         Top             =   240
         Width           =   1095
         Begin VB.ComboBox cmbBitField 
            Height          =   315
            Index           =   0
            ItemData        =   "frmMain.frx":0F6A
            Left            =   120
            List            =   "frmMain.frx":0F7A
            TabIndex        =   3
            Text            =   "Persistance"
            Top             =   240
            Width           =   855
         End
      End
      Begin VB.Frame Frame3 
         Caption         =   "Light"
         Height          =   615
         Left            =   120
         TabIndex        =   17
         Top             =   1680
         Width           =   1215
         Begin VB.Label lblLight 
            Alignment       =   2  'Center
            Caption         =   "Light"
            Height          =   255
            Left            =   120
            TabIndex        =   18
            Top             =   240
            Width           =   975
         End
      End
   End
End
Attribute VB_Name = "frmMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'Dim als As ucALSusb
'Dim bits As clsBitDefs
Dim drv As ucALSusb
Dim als As clsBitDefs
Dim baseline As Double
Dim dataValid As Boolean
Dim threshHi As Integer
Dim threshLo As Integer
Dim washThresh As Integer
Dim sleepTime As Long
Dim stGUIactive As Boolean
Dim useInterrupt As Boolean
Dim frmMain_Width As Integer, frmMain_Height As Integer

Const pFlagVisible As Boolean = False

Private Enum mN
    pRaw_
    base_
    prox_
    pMax_
    mean_
    pMin_
    pRms_
    pKpK_
    xTalk_
End Enum

Dim proxVal As clsMPA

Private Enum state
    stInit
    stXtalkAdj
    stMeasBase
    stRuntime
End Enum


Private Sub cbIntEn_Click()
    If cbIntEn.value = vbChecked Then
        useInterrupt = True
    Else
        useInterrupt = False
    End If
End Sub

Private Sub cmdIntClr_Click()
    lblIntChg.caption = "-"
End Sub

Private Sub Form_Load()

    Set drv = ucALSusb1
    Set als = New clsBitDefs: als.setAlsDrv drv
    
    Set proxVal = New clsMPA
    
    loadDriver
    
    washThresh = washInitThresh
    
    frmMain_Width = frmMain.Width: frmMain_Height = frmMain.Height
    
    fmInt.Visible = pFlagVisible
    
    
    frmMain.caption = "ISL29177 Drv Algo Ver: " & App.Major & "." & App.Minor & "." & App.Revision
    
    gotoState (state.stInit)
    
End Sub

Private Sub cbDutyCycle_Click()
    If cbDutyCycle.value = vbChecked Then
        cbDutyCycle.caption = "20%"
        als.writeField BF.XPLS_, 0
    Else
        cbDutyCycle.caption = "30%"
        als.writeField BF.XPLS_, 1
    End If
    gotoState state.stXtalkAdj
    frmMain.SetFocus
End Sub

Private Sub cmbBitField_GotFocus(Index As Integer)

    If Index = BF.SLEP_ Then
        stGUIactive = True
    End If

End Sub

Private Sub cmbBitField_Click(Index As Integer)

    Static lastIrdrListIndex

    als.writeField Index, cmbBitField(Index).ListIndex
    
    If Index = BF.SLEP_ Then
        
        If stGUIactive Then
            sleepTime = cmbBitField(Index).ListIndex
            stGUIactive = False
            SendKeys "{TAB}"
        End If
    
        If cmbBitField(Index).ListIndex > 3 Then
            runtimeTimerMult = 1
        Else
            runtimeTimerMult = 2 ^ (4 - cmbBitField(Index).ListIndex)
        End If
        
        tmrRunTime.Interval = 25 * runtimeTimerMult
        
    End If
    
    If Index = BF.IRDR_ Then
        gotoState state.stXtalkAdj
        frmMain.SetFocus
    End If
    
End Sub

Private Sub loadDriver()
    ucALSusb1.setI2cAddr i2cAddr
    ucALSusb1.setDevice Device
End Sub

Private Function getLutIndex() As Long
    getLutIndex = 0
End Function

Private Sub setBaseline(Optional ByVal prox As Integer = 0)
    Dim value As Long
    If prox > 0 And prox < maxBaseline Then
    
        baseline = prox
        
        value = baseline + threshLo
        If value < 0 Then
            value = 0
        Else
            If value > 255 Then value = 255
        End If
        
        threshLo = value - baseline
        
        als.writeField BF.TRLO_, value
        
        value = baseline + threshHi
        If value < 0 Then
            value = 0
        Else
            If value > 255 Then value = 255
        End If
        
        threshHi = value - baseline
        
        als.writeField BF.TRHI_, value
    End If
End Sub



Private Sub cmdReset_Click()
    tmrRunTime.Enabled = False
    tmrMeasBase.Enabled = False
    tmrInit.Enabled = True
    frmMain.SetFocus
End Sub

Private Sub tbThresh_Change(Index As Integer)
    Dim value As Integer
    
    
    If enterText(tbThresh(Index).text) Then
    
        On Error GoTo error
        
        value = Int(val(tbThresh(Index).text))
        
        If value < 0 - baseline Then
            value = 0 - baseline
        Else
            If value > 255 - baseline Then
                value = 255 - baseline
            End If
        End If
        
        tbThresh(Index).text = Str(value)
    
        Select Case Index
            Case 0: threshLo = value
            Case 1: threshHi = value
        End Select
        
        setBaseline baseline
    
        GoTo endSub
    
error:

        Select Case Index
            Case 0: value = threshLo
            Case 1: value = threshHi
        End Select
        
        tbThresh(Index).text = value
    
endSub:

        tbThresh(0).text = threshLo
        tbThresh(1).text = threshHi
    
    End If
    
End Sub

Private Sub updateProx(prox As Double, ByVal nearFar As Integer)

    If dataValid Then

        If nearFar > 0 Then
            lblState.BackColor = vbRed: lblState.caption = "NEAR"
        Else
            lblState.BackColor = vbGreen: lblState.caption = "FAR"
        End If
    
        display mN.prox_, prox
    
    End If

End Sub

Private Sub Form_Resize()
    If frmMain.WindowState = vbNormal Then
        frmMain.Width = frmMain_Width: frmMain.Height = frmMain_Height
    End If
End Sub

Private Sub display(ByVal Item As mN, ByVal val As Double)
    Dim sVal As String, mean As Double, rms As Double
    On Error Resume Next
    
    Select Case Item
    Case mN.xTalk_: sVal = Format(val, "0.00")
    Case mN.mean_, mN.pRms_: sVal = Format(val, "0.0")
    Case Else: sVal = Str(val)
    End Select
    
    'lblMeasure(Item).caption = sVal
    lblProxVal(Item).caption = sVal
    
    If Item = mN.pRaw_ Then
        proxVal.setValue val, mean, rms
        rms = rms / 100 * mean: mean = mean - baseline
        display mN.mean_, mean
        display mN.pRms_, rms
        display mN.pMin_, proxVal.getMin - baseline
        display mN.pMax_, proxVal.getMax - baseline
        display mN.pKpK_, proxVal.getPkPk
    End If
    
End Sub

Private Sub gotoState(st As state)

    tmrInit.Enabled = False
    tmrXtalkAdj.Enabled = False
    tmrMeasBase.Enabled = False
    tmrRunTime.Enabled = False
    
    If st = state.stRuntime Then
        cmbBitField(BF.SLEP_).ListIndex = sleepTime
        lblSeq.BackColor = vbGreen
        proxVal.setSize ' no value clears MPA
        lblAdjustTime.caption = sinceLastTime
    Else
        cmbBitField(BF.SLEP_).ListIndex = sleepFast
        lblSeq.BackColor = vbButtonFace
        sinceLastTime
    End If
    
    Select Case st
        Case state.stInit:     tmrInit.Enabled = True
        Case state.stXtalkAdj: tmrXtalkAdj.Enabled = True
        Case state.stMeasBase: tmrMeasBase.Enabled = True
        Case state.stRuntime:  tmrRunTime.Enabled = True
    End Select

End Sub

Private Sub tmrInit_Timer()

    Static primed As Boolean ' start on 2nd call
    Dim dummy As Byte ' clear status register

    If primed Then
    
        lblSeq.caption = "INIT"
        
        cmbBitField(BF.PRST_).ListIndex = persistance
        'cmbBitField(BF.IRDR_).ListIndex = irdr
        cmbBitField(BF.SLEP_).ListIndex = sleepFastInit
        
        cbDutyCycle.value = vbChecked: cbDutyCycle_Click ' 30/20% Duty cycle: 0: 2 pulses; 1: 3 pulses
        cbDutyCycle.Enabled = False: cbDutyCycle.Visible = False
        
        tbThresh(0).text = tLo & vbCr
        tbThresh(1).text = tHi & vbCr
        drv.dSetEnable 1, 1    ' enable prox
        als.writeField BF.PXEN_, 1  ' enable prox int
        
        primed = False: gotoState state.stXtalkAdj
    
    Else
        primed = True
        als.readField BF.STTS_, dummy ' clear status register
        sleepTime = sleepTimeInit
    End If

End Sub

Private Sub tmrXtalkAdj_Timer()

    Dim xTalk As Double, done As Boolean, prox As Double
    
    Static primed As Boolean ' start on 2nd call

    lblSeq.caption = "xTalkAdj"
        
    If primed Then
    
        If als.GetProximity(prox) Then ' PROX_DONE
        
            done = adjustOffset(drv, prox, xTalk)
            
        Else
        
            If als.getInitNeeded Then ' reset sequence (brown out)
                primed = False
                gotoState state.stInit
            End If
            
            Exit Sub
            
        End If
    
        display mN.xTalk_, xTalk
        
        If done Then ' next sequence
            primed = False: gotoState state.stMeasBase
        End If

    Else
        primed = True
    End If

End Sub

Private Sub tmrMeasBase_Timer()
    Dim prox As Double, xTalk As Double
    Static count As Integer, zeroCount As Integer, offsetLSBs As Long
    
    Const maxZeroCount As Integer = 2
    
    Static primed As Boolean ' start on 2nd call
    
    lblSeq.caption = "MEASBASE"

    If primed Then
    
        If als.GetProximity(prox) Then ' PROX_DONE
        
            prox = Int(prox * 255)
            
        Else
        
            If als.getInitNeeded Then ' reset sequence (brown out)
                primed = False
                gotoState state.stInit
            End If
            
            Exit Sub
            
        End If
    
        If prox > maxBaseline Then ' baseline is to high, readjust offset
            count = 0: zeroCount = 0: lastProx = 0
            gotoState state.stXtalkAdj
        Else
        
'            ' ================================================================
'            ' check for consecutive zeros, decrease offset & restart if needed
'            If prox = 0 Then
'                zeroCount = zeroCount + 1
'                If zeroCount >= maxZeroCount Then ' decrease offset, repeat
'                    drv.dGetProxOffset offsetLSBs
'                    If offsetLSBs > 0 Then offsetLSBs = offsetLSBs - 1
'                    drv.dSetProxOffset offsetLSBs
'                    count = 0: zeroCount = 0: lastProx = 0: primed = False
'                End If
'            Else
'                zeroCount = 0
'            End If
'            ' ================================================================
            
            If count = 0 Then
                baseline = getBaseline(prox, True)
            Else
                baseline = getBaseline(prox)
            End If
            
            display mN.base_, baseline
            xTalk = (baseline + offsetLSBs) / 255
            display mN.xTalk_, xTalk
            
            count = count + 1
            
            If count >= blMemSize Or zeroCount >= maxZeroCount Then ' done
                count = 0: zeroCount = 0: lastProx = 0
                primed = False: gotoState state.stRuntime
            End If
            
        End If
    
    Else
        count = 0: zeroCount = 0
        drv.dGetProxOffset offsetLSBs ' LUT index
        drv.dSetProxOffset offsetLSBs ' sets LUT index, returns xTalk in LSBs
        primed = True
    End If

End Sub

Private Sub tmrRunTime_Timer()
    Dim prox As Double, wash As Byte, offset As Long, pFlag As Boolean, np As Byte, pram As Long
    Static nearFar As Byte, lastProx As Double, lastBase As Double, lPflag As Boolean
    
    Static offsetReduce As Boolean      ' done already, remeasure xTalk
    Static offsetReductionCount As Long
    
    Static baseLinePersistCount As Long
    Static driftCounter As Long
    '
    ' This routine contains 3 possible state changes
    '   1) Init: if "brown out" detected (initNeeded)
    '   2) measBase: if prox = 0 for consecutive offsetPersist cycles (offsetReductionCount)
    '   3) xTalkAdj: is offset has been adjusted already but is still 0

    Static primed As Boolean ' start on 2nd call

    If primed Then
    
        If als.GetProximity(prox) Then ' PROX_DONE
        
            prox = Int(prox * 255)
            
            ' ===========================================================
            ' occasionally remeasure the baseline to compensate for drift
            ' ===========================================================
            driftCounter = driftCounter + 1
            If driftCounter > 593 * measBaseTime / (tmrRunTime.Interval) And prox < threshLo + baseline Then
                primed = False: gotoState state.stMeasBase
                Debug.Print sinceLastTime(1) / 1000#
            End If
        
        Else
        
            ' =====================
            ' check for power fault
            ' =====================
            If als.getInitNeeded Then ' reset sequence (brown out)
                primed = False: gotoState state.stInit
            End If
            
            Exit Sub
            
        End If
    
        ' ==================================================
        ' monitor the 2/3 pulse bit (for debug/testing only)
        als.readField BF.XPLS_, np
        lblSeq.caption = "RUNTIME:" & Str(np)
        ' ==================================================
        
        pFlag = als.getPflag
        If pFlag Then
            lblInt.caption = "1"
        Else
            lblInt.caption = "0"
        End If
        
        If pFlag <> lPflag Then
            lPflag = pFlag ' break here for flag change
            lblIntChg.caption = "X"
        End If
        
        If Not useInterrupt Or pFlag Then ' Poll/Interupt
            
                             ' XXXXXXXXXXXXXXXXXXXXXXXXXXXXX
            dataValid = True ' unless offset too high REMOVE
                             ' XXXXXXXXXXXXXXXXXXXXXXXXXXXXX
            
            ' ===========================
            ' washout detection/ tracking
            'als.GetProximity prox: prox = Int(prox * 255)
            als.readField BF.WASH_, wash
            If washThresh > wash Then washThresh = wash ' new washout detect value
            If wash > washThresh + 1 Then ' guardband threshold by 1 LSB
                prox = 0 ' bright light detected, force to zero
                nearFar = 0
                lblLight.caption = "BRIGHT"
            ' ===========================
            Else
                lblLight.caption = "DIM"
                
                ' ================================================================
                ' check if offset is too high, drop value by 1, remeasure baseline
                ' if has already been reduced once, readjust offset  [PC]
                If prox = 0 Then
                    offsetReductionCount = offsetReductionCount + 1
                Else
                    offsetReductionCount = 0
                    offsetReduce = False
                End If
                
                If offsetReductionCount >= offsetPersist Then
                
                    If offsetReduce Then            ' if drop by 1 didn't work, readjust offset
                        primed = False: gotoState state.stXtalkAdj
                    Else                            ' drop by offset by 1, remeasure baseline
                        offsetReduce = True
                        drv.dGetProxOffset pram 'returns LUT index in pram
                        If pram > 0 Then pram = pram - 1
                        drv.dSetProxOffset pram ' pram sets LUT index, returns offset in LSBs
                        primed = False: gotoState state.stMeasBase
                    End If
                ' ================================================================
                Else
                
                    ' =============================
                    ' check for baseline level [PC]
                    display mN.pRaw_, prox
                    prox = prox - baseline
                    If prox < 0 Then
                        If prox < baseLineThresh Then baseLinePersistCount = baseLinePersistCount + 1
                        prox = 0
                        If baseLinePersistCount >= baseLinePersist Then
                            baseLinePersistCount = 0
                            primed = False: gotoState state.stMeasBase ' remeasure baseline
'                        Else
'                            baseLinePersistCount = 0
                        End If
                    End If
                    ' ========================
                        
                        
                        ' ==================
                        ' determine Near/Far
                        If 0 Then ' Near/Far 0: use prox value; 1: use Prox Int Flag
                            nearFar = pFlag
                        Else ' set to 1 for Motorola Logic
                        
                            If prox > threshHi Then
                                nearFar = 1 ' Near
                                If useInterrupt Then
                                    'disable hi, enable lo
                                    tbThresh(0).text = tbThresh(0).text & vbCr
                                    als.writeField BF.TRHI_, 255
                                End If
                            Else
                                If prox < threshLo Then
                                    nearFar = 0 ' Far
                                    If useInterrupt Then
                                        'disable lo, enable hi
                                        tbThresh(1).text = tbThresh(1).text & vbCr
                                        als.writeField BF.TRLO_, 0
                                    End If
                                Else
                                    'in hysterisis band, use last value
                                End If
                            End If
                            
                        End If
                        ' ==================
                        
                End If
                
            End If ' wash/not
            
            updateProx prox, nearFar
        
        End If ' interrupt/poll loop

    Else
        driftCounter = 0: sinceLastTime 1
        baseLinePersistCount = 0
        primed = True
    End If

End Sub

