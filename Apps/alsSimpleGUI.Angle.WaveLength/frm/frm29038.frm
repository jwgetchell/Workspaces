VERSION 5.00
Begin VB.Form frm29038 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "ISL29038"
   ClientHeight    =   5505
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   4320
   Icon            =   "frm29038.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   ScaleHeight     =   5505
   ScaleWidth      =   4320
   StartUpPosition =   3  'Windows Default
   Begin VB.CheckBox cbALSres 
      Caption         =   "ALS:12"
      Height          =   495
      Left            =   1320
      Style           =   1  'Graphical
      TabIndex        =   50
      Top             =   600
      Width           =   735
   End
   Begin VB.CommandButton cmdReset 
      Caption         =   "Reset"
      Height          =   495
      Left            =   720
      TabIndex        =   49
      Top             =   600
      Width           =   615
   End
   Begin VB.HScrollBar HScrOnOff 
      Height          =   255
      Left            =   3240
      Max             =   1000
      TabIndex        =   48
      Top             =   1800
      Value           =   1000
      Width           =   975
   End
   Begin VB.Timer tmrOnOff 
      Enabled         =   0   'False
      Interval        =   1000
      Left            =   3840
      Top             =   1080
   End
   Begin VB.CheckBox cbOnOff 
      Caption         =   "Cycle"
      Height          =   255
      Left            =   3240
      Style           =   1  'Graphical
      TabIndex        =   47
      Top             =   1560
      Width           =   975
   End
   Begin VB.CheckBox cbRegOtp 
      Caption         =   "OTP"
      Enabled         =   0   'False
      Height          =   495
      Left            =   120
      Style           =   1  'Graphical
      TabIndex        =   43
      Top             =   600
      Width           =   615
   End
   Begin VB.CheckBox cbWash 
      Caption         =   "Wash:Norm"
      Height          =   255
      Left            =   2040
      Style           =   1  'Graphical
      TabIndex        =   21
      Top             =   1800
      Width           =   1215
   End
   Begin VB.CheckBox cbTestModeEnable 
      Caption         =   "Test Mode:Off"
      Height          =   495
      Left            =   120
      Style           =   1  'Graphical
      TabIndex        =   44
      Top             =   120
      Width           =   1935
   End
   Begin VB.Frame Frame1 
      Caption         =   "OTP"
      Height          =   1455
      Left            =   2040
      TabIndex        =   37
      Top             =   0
      Width           =   1815
      Begin VB.CommandButton cmdRead 
         Caption         =   "Read"
         Height          =   315
         Left            =   120
         TabIndex        =   39
         Top             =   240
         Width           =   855
      End
      Begin VB.ComboBox cmbRctrl 
         Height          =   315
         ItemData        =   "frm29038.frx":0CCA
         Left            =   960
         List            =   "frm29038.frx":0CDA
         TabIndex        =   38
         Text            =   "2k"
         Top             =   240
         Width           =   735
      End
      Begin VB.Label lblOTPdata 
         Caption         =   "OTP Data="
         Height          =   255
         Left            =   120
         TabIndex        =   42
         Top             =   600
         Width           =   1455
      End
      Begin VB.Label lblOTPDone 
         Caption         =   "OTP Done="
         Height          =   255
         Left            =   120
         TabIndex        =   41
         Top             =   840
         Width           =   1455
      End
      Begin VB.Label lblGolden 
         Caption         =   "Golden="
         Height          =   255
         Left            =   120
         TabIndex        =   40
         Top             =   1080
         Width           =   1455
      End
   End
   Begin VB.Frame fmTrim 
      Caption         =   "Trim"
      Height          =   2775
      Left            =   120
      TabIndex        =   23
      Top             =   1080
      Width           =   1815
      Begin VB.CommandButton cmdDone 
         Caption         =   "Done"
         Enabled         =   0   'False
         Height          =   255
         Left            =   960
         TabIndex        =   25
         Top             =   2400
         Width           =   735
      End
      Begin VB.CommandButton cmdGolden 
         Caption         =   "Golden"
         Enabled         =   0   'False
         Height          =   255
         Left            =   960
         TabIndex        =   26
         Top             =   2160
         Width           =   735
      End
      Begin VB.CommandButton cmdProg1s 
         Caption         =   "Prog FF"
         Height          =   255
         Left            =   120
         TabIndex        =   24
         Top             =   2400
         Width           =   855
      End
      Begin VB.Frame fmAlsTrim 
         Caption         =   "Als"
         Height          =   615
         Left            =   120
         TabIndex        =   34
         Top             =   1440
         Width           =   1575
         Begin VB.HScrollBar hscrAlsTrim 
            Height          =   255
            Left            =   120
            Max             =   7
            TabIndex        =   35
            Top             =   240
            Width           =   855
         End
         Begin VB.Label lblAlsTrim 
            Caption         =   "7"
            Height          =   255
            Left            =   1200
            TabIndex        =   36
            Top             =   240
            Width           =   255
         End
      End
      Begin VB.Frame fmProxTrim 
         Caption         =   "Prox"
         Height          =   615
         Left            =   120
         TabIndex        =   31
         Top             =   240
         Width           =   1575
         Begin VB.HScrollBar hscrProxTrim 
            Height          =   255
            Left            =   120
            Max             =   3
            TabIndex        =   32
            Top             =   240
            Width           =   855
         End
         Begin VB.Label lblProxTrim 
            Caption         =   "3"
            Height          =   255
            Left            =   1200
            TabIndex        =   33
            Top             =   240
            Width           =   255
         End
      End
      Begin VB.Frame fmIrdrTrim 
         Caption         =   "Irdr"
         Height          =   615
         Left            =   120
         TabIndex        =   28
         Top             =   840
         Width           =   1575
         Begin VB.HScrollBar hscrIrdrTrim 
            Height          =   255
            Left            =   120
            Max             =   7
            TabIndex        =   29
            Top             =   240
            Width           =   855
         End
         Begin VB.Label lblIrdrTrim 
            Caption         =   "7"
            Height          =   255
            Left            =   1200
            TabIndex        =   30
            Top             =   240
            Width           =   255
         End
      End
      Begin VB.CommandButton cmdProgram 
         Caption         =   "Program"
         Enabled         =   0   'False
         Height          =   255
         Left            =   120
         TabIndex        =   27
         Top             =   2160
         Width           =   855
      End
   End
   Begin VB.CommandButton cmdALSint 
      Caption         =   "ALS Int"
      Height          =   255
      Left            =   2040
      TabIndex        =   22
      Top             =   1560
      Width           =   1215
   End
   Begin VB.Frame fmRegisters 
      Caption         =   "Field I/O"
      Height          =   1575
      Left            =   120
      TabIndex        =   13
      Top             =   3840
      Width           =   1455
      Begin VB.TextBox txtIO 
         Height          =   285
         Index           =   1
         Left            =   720
         MultiLine       =   -1  'True
         TabIndex        =   18
         Text            =   "frm29038.frx":0CEF
         Top             =   1200
         Width           =   615
      End
      Begin VB.ComboBox cmbIO 
         Height          =   315
         Index           =   1
         ItemData        =   "frm29038.frx":0CF5
         Left            =   720
         List            =   "frm29038.frx":0D11
         TabIndex        =   17
         Text            =   "FF"
         Top             =   600
         Width           =   615
      End
      Begin VB.ComboBox cmbIO 
         Height          =   315
         Index           =   0
         ItemData        =   "frm29038.frx":0D31
         Left            =   120
         List            =   "frm29038.frx":0D4D
         TabIndex        =   16
         Text            =   "0"
         Top             =   600
         Width           =   615
      End
      Begin VB.TextBox txtIO 
         Height          =   285
         Index           =   0
         Left            =   120
         MultiLine       =   -1  'True
         TabIndex        =   15
         Text            =   "frm29038.frx":0D69
         Top             =   1200
         Width           =   615
      End
      Begin VB.CommandButton cmdClrShiftMask 
         Caption         =   "clear"
         Height          =   255
         Left            =   840
         TabIndex        =   14
         Top             =   120
         Width           =   495
      End
      Begin VB.Label lblShiftMask 
         Caption         =   "  Shift      Mask"
         Height          =   255
         Left            =   120
         TabIndex        =   20
         Top             =   360
         Width           =   1215
      End
      Begin VB.Label lblAddrData 
         Caption         =   "  Addr      Data"
         Height          =   255
         Left            =   120
         TabIndex        =   19
         Top             =   960
         Width           =   1215
      End
   End
   Begin VB.Frame fmIRDRprxOffset 
      Caption         =   "Prox Offset"
      Height          =   2775
      Left            =   2040
      TabIndex        =   0
      Top             =   2040
      Width           =   2175
      Begin VB.Frame fmProxOffset 
         Caption         =   "55ma"
         Height          =   615
         Index           =   1
         Left            =   120
         TabIndex        =   10
         Top             =   840
         Width           =   1935
         Begin VB.HScrollBar hscrProxOffset 
            Height          =   255
            Index           =   1
            Left            =   120
            Max             =   15
            TabIndex        =   11
            Top             =   240
            Width           =   1335
         End
         Begin VB.Label lblProxOffset 
            Alignment       =   1  'Right Justify
            Caption         =   "0"
            Height          =   255
            Index           =   1
            Left            =   1560
            TabIndex        =   12
            Top             =   240
            Width           =   255
         End
      End
      Begin VB.Frame fmProxOffset 
         Caption         =   "27ma"
         Height          =   615
         Index           =   0
         Left            =   120
         TabIndex        =   7
         Top             =   240
         Width           =   1935
         Begin VB.HScrollBar hscrProxOffset 
            Height          =   255
            Index           =   0
            Left            =   120
            Max             =   15
            TabIndex        =   8
            Top             =   240
            Width           =   1335
         End
         Begin VB.Label lblProxOffset 
            Alignment       =   1  'Right Justify
            Caption         =   "0"
            Height          =   255
            Index           =   0
            Left            =   1560
            TabIndex        =   9
            Top             =   240
            Width           =   255
         End
      End
      Begin VB.Frame fmProxOffset 
         Caption         =   "110ma"
         Height          =   615
         Index           =   2
         Left            =   120
         TabIndex        =   4
         Top             =   1440
         Width           =   1935
         Begin VB.HScrollBar hscrProxOffset 
            Height          =   255
            Index           =   2
            Left            =   120
            Max             =   15
            TabIndex        =   5
            Top             =   240
            Width           =   1335
         End
         Begin VB.Label lblProxOffset 
            Alignment       =   1  'Right Justify
            Caption         =   "0"
            Height          =   255
            Index           =   2
            Left            =   1560
            TabIndex        =   6
            Top             =   240
            Width           =   255
         End
      End
      Begin VB.Frame fmProxOffset 
         Caption         =   "220ma"
         Height          =   615
         Index           =   3
         Left            =   120
         TabIndex        =   1
         Top             =   2040
         Width           =   1935
         Begin VB.HScrollBar hscrProxOffset 
            Height          =   255
            Index           =   3
            Left            =   120
            Max             =   15
            TabIndex        =   2
            Top             =   240
            Width           =   1335
         End
         Begin VB.Label lblProxOffset 
            Alignment       =   1  'Right Justify
            Caption         =   "0"
            Height          =   255
            Index           =   3
            Left            =   1560
            TabIndex        =   3
            Top             =   240
            Width           =   255
         End
      End
   End
   Begin VB.Frame fmRevOptions 
      Caption         =   "Rev Option"
      Height          =   615
      Left            =   1680
      TabIndex        =   45
      Top             =   4800
      Width           =   2535
      Begin VB.Label lblRevOptions 
         Caption         =   "Label1"
         Height          =   255
         Left            =   120
         TabIndex        =   46
         Top             =   240
         Width           =   2295
      End
   End
End
Attribute VB_Name = "frm29038"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim pDrv As ucALSusb

Const enableFuse As Boolean = True

Const W As Integer = 1 ' JWG
Const R As Integer = 0 ' JWG

Dim IOreg As reg38

Public alsCompMax As Double
Public alsCompMin As Double
Public proxRej As Double
Public proxDebug As Integer
Public alsMult As Double

Dim ucMonochromator1 As ucMonochromator

Dim formActivated As Boolean

Dim otpData As String, otpData0 As String

Private Sub cbALSres_Click()
    Dim cbTestModeEnable_Value As Integer
    cbTestModeEnable_Value = cbTestModeEnable.value
    cbTestModeEnable.value = vbChecked
    
    If cbALSres.value = vbChecked Then
        cbALSres.caption = "ALS:8"
        Call pDrv.dWriteField(&H10, 2, 3, 1)
        alsMult = 16
    Else
        cbALSres.caption = "ALS:12"
        Call pDrv.dWriteField(&H10, 2, 3, 0)
        alsMult = 1
    End If
    
    cbTestModeEnable.value = cbTestModeEnable_Value
End Sub

Private Sub cmdReset_Click()
    cbTestModeEnable.value = vbChecked: cbTestModeEnable_Click
    Call pDrv.dWriteField(&HE, 0, &HFF, &H38)   'lAddr, bShift, bMask, bData
    cbTestModeEnable.value = vbUnchecked: cbTestModeEnable_Click
End Sub

Private Sub fmRevOptions_DblClick()
    readRevOption
End Sub

Public Function readRevOption() As Byte
    'Dim d As Byte
    
    On Error GoTo endSub
    
    IOreg.a = 0: IOreg.s = 0: IOreg.m = 7
    Call pDrv.dReadField(IOreg.a, IOreg.s, IOreg.m, readRevOption)

    alsCompMax = 5.2

    Select Case readRevOption
    Case 1: alsCompMin = 3.2: proxRej = 40: proxDebug = 0
    Case 2: alsCompMin = 0: proxRej = 60: proxDebug = 1
    Case 3: alsCompMin = 2.1: proxRej = 40: proxDebug = 0
    Case 4: alsCompMin = 3.2: proxRej = 60: proxDebug = 0
    Case 5: alsCompMin = 2.1: proxRej = 60: proxDebug = 0
    Case 6: alsCompMin = 0: proxRej = 60: proxDebug = 2
    Case Else: alsCompMin = 4.8: alsCompMax = 8#: proxRej = 40: proxDebug = 0
    End Select
    
    lblRevOptions.caption = "C" & readRevOption & ": " & alsCompMin & "-" & alsCompMax & "% Amb. Rej.=" & proxRej & "kLux"
    If proxDebug Then lblRevOptions.caption = lblRevOptions.caption & " D=" & proxDebug
endSub: 'If Not formActivated Then Form_Load
End Function

Private Sub HScrOnOff_Change()
    If cbOnOff.value = vbChecked Then
        cbOnOff.caption = "Run:" & HScrOnOff.value
    Else
        cbOnOff.caption = "Start:" & HScrOnOff.value
    End If
End Sub

Private Sub cbOnOff_Click()
    If cbOnOff.value = vbChecked Then
        cbOnOff.caption = "Run:" & HScrOnOff.value
        cmdRead_Click
        otpData0 = otpData
        tmrOnOff.enabled = True
    Else
        cbOnOff.caption = "Start:" & HScrOnOff.value
        tmrOnOff.enabled = False
    End If
End Sub

Private Sub tmrOnOff_Timer()
    If HScrOnOff.value > 0 Then
        powerCycle
        HScrOnOff.value = HScrOnOff.value - 1
        cbOnOff_Click
        cmdRead_Click
        If (otpData <> otpData0) Then MsgBox ("Fuse Read Error")
    Else
        tmrOnOff.enabled = False
        cbOnOff.value = vbUnchecked
        MsgBox ("Fuse Testing Done")
    End If
End Sub

Private Sub hscrProxOffset_Change(index As Integer)
    lblProxOffset(index).caption = hscrProxOffset(index).value
    g38ProxOffset(index).maxVal = hscrProxOffset(index).value
End Sub

Private Sub handleError(msg As String)

End Sub

Private Sub cbTestModeEnable_Click()
    Dim D As Long
    On Error GoTo exitSub
    If cbTestModeEnable.value = vbChecked Then
        cbTestModeEnable.caption = "Test Mode:On"
        D = &H89: Call pDrv.dIO(W, &HE, D)
        cbRegOtp.enabled = True
    Else
        cbTestModeEnable.caption = "Test Mode:Off"
        D = &H0: Call pDrv.dIO(W, &HE, D)
        cbRegOtp.enabled = False
    End If
exitSub:
End Sub

Private Sub cbRegOtp_Click()
    If cbRegOtp.value = vbChecked Then
        cbRegOtp.caption = "Register"
        Call pDrv.dSetRegOtpSel(1)
        hscrProxTrim.enabled = True
        hscrIrdrTrim.enabled = True
        hscrAlsTrim.enabled = True
    Else
        cbRegOtp.caption = "OTP"
        Call pDrv.dSetRegOtpSel(0)
        hscrProxTrim.enabled = False
        hscrIrdrTrim.enabled = False
        hscrAlsTrim.enabled = False
    End If
End Sub

Public Sub powerOn()
    powerNormal
End Sub

Public Sub powerOff(Optional wait As Long = 1000)
    On Error GoTo subExit
    ucMonochromator1.setVolts (0#): Call pDrv.dPrintTrace("VDD to 0.0V")
    Sleep (wait)
subExit:
End Sub

Private Sub powerHi(Optional wait As Long = 1000)
    ucMonochromator1.setVolts (4.5): Call pDrv.dPrintTrace("VDD to 4.5V")
    Sleep (wait)
End Sub

Private Sub powerNormal(Optional wait As Long = 1000)
    On Error GoTo skipDrvCall
    ucMonochromator1.setVolts (3.3): Call pDrv.dPrintTrace("VDD to 3.3V")
skipDrvCall:
    Sleep (wait)
End Sub

Private Sub powerCycle()
    powerOff
    powerOn
End Sub

Private Sub cbWash_Click()
    If cbWash.value = vbChecked Then
        cbWash.caption = "Wash:1/2"
        Call pDrv.dWriteField(&H10, 0, 3, 1)
    Else
        cbWash.caption = "Wash:Norm"
        Call pDrv.dWriteField(&H10, 0, 3, 0)
    End If
End Sub

Private Sub cmbRctrl_Click()
    Dim D As Long
    D = cmbRctrl.ListIndex
    D = D * 2 ^ 3
    Call pDrv.dIO(W, &H12, D)
    cmdRead_Click
End Sub

Private Sub cmdALSint_Click()
    Dim i As Long, j As Long, k As Long
    Const L As Long = 10
    Call pDrv.dSetEnable(0, 0) ' als off
    Call pDrv.dSetEnable(1, 0) ' prox off
    Call pDrv.dSetThreshHi(0, 0) ' force als int
    Call pDrv.dSetEnable(0, 1) ' als on
    For i = 1 To 50 * L
        Call pDrv.dGetIntFlag(0, j): Sleep 20
        If j Then k = k + 1
        If k >= L Then i = 50 * L
    Next i
    Call pDrv.dSetEnable(0, 0) ' als off
End Sub

Private Sub cmdDone_Click()
    Dim D As Long
    
    Call pDrv.dPrintTrace("<<<< Program: Set Done >>>>")
    cbTestModeEnable.value = vbChecked ' test mode on
    cbRegOtp.value = vbUnchecked ' OTP
    D = 0: Call pDrv.dIO(W, &H4, D) ' clear IDD alarm
    
If Not enableFuse Then GoTo testResults
    powerHi
    Call pDrv.dSetFuseWrAddr(&HF)
    Call pDrv.dSetFuseWrEn(1)
    Sleep (50)
    powerNormal
    Call pDrv.dSetFuseWrEn(0)
    powerCycle
    
testResults: cmdRead_Click
End Sub

Private Sub cmdGolden_Click()
    Dim D As Long
    
    Call pDrv.dPrintTrace("<<<< Program: Set Golden >>>>")
    cbTestModeEnable.value = vbChecked ' test mode on
    cbRegOtp.value = vbUnchecked ' OTP
    D = 0: Call pDrv.dIO(W, &H4, D) ' clear IDD alarm
    
If Not enableFuse Then GoTo testResults
    powerHi
    Call pDrv.dSetFuseWrAddr(&HE)
    Call pDrv.dSetFuseWrEn(1)
    Sleep (50)
    powerNormal
    Call pDrv.dSetFuseWrEn(0)
    powerCycle
    
testResults: cmdRead_Click
End Sub

Private Sub cmdProg1s_Click()
    cbTestModeEnable.value = vbChecked: DoEvents
    cbRegOtp.value = vbUnchecked: DoEvents
    cbTestModeEnable.value = vbUnchecked: DoEvents
    cbTestModeEnable.value = vbChecked: DoEvents
    cbRegOtp.value = vbChecked: DoEvents
    hscrProxTrim.value = 0: DoEvents
    hscrProxTrim.value = 3: DoEvents
    hscrIrdrTrim.value = 0: DoEvents
    hscrIrdrTrim.value = 7: DoEvents
    hscrAlsTrim.value = 0: DoEvents
    hscrAlsTrim.value = 7: DoEvents
    cmdProgram_Click
    cbTestModeEnable.value = vbChecked: DoEvents
    cbRegOtp.value = vbUnchecked: DoEvents
    cbTestModeEnable.value = vbUnchecked: DoEvents
    cbTestModeEnable.value = vbChecked: DoEvents
    cbRegOtp.value = vbChecked: DoEvents
    cmdGolden_Click
    cbTestModeEnable.value = vbUnchecked: DoEvents
    cbTestModeEnable.value = vbChecked: DoEvents
    cmdRead_Click
End Sub

Private Sub cmdProgram_Click()
    Dim D As Long, B As Long, i As Integer
    
    lblOTPdata.caption = "IN PROGRESS": DoEvents
    
    Call pDrv.dPrintTrace("<<<< Program >>>>")
    cbRegOtp.value = vbChecked ' register
    Call pDrv.dIO(R, &H13, B)
    cbRegOtp.value = vbUnchecked ' OTP
    D = 0: Call pDrv.dIO(W, &H4, D) ' clear IDD alarm
    
    MsgBox ("add jumper")
    
If Not enableFuse Then GoTo testResults
    For i = 0 To 7
        If B And 1 Then
            Call pDrv.dSetFuseWrAddr(i + 1)
            Call pDrv.dSetFuseWrEn(1)
            powerHi
            MsgBox ("remove jumper")
            Sleep (50)
            powerNormal
            MsgBox ("power now @ 3.3V")
            Call pDrv.dSetFuseWrEn(0)
            MsgBox ("add jumper")
            B = B - 1
        End If
        B = B / 2
    Next i
    
    MsgBox ("DONE: remove jumper")
    powerNormal
    powerCycle
    
testResults: cmdRead_Click
End Sub

Private Sub cmdProgram_Click_()
    Dim D As Long, B As Long, i As Integer
    
    lblOTPdata.caption = "IN PROGRESS": DoEvents
    
    Call pDrv.dPrintTrace("<<<< Program >>>>")
    cbRegOtp.value = vbChecked ' register
    Call pDrv.dIO(R, &H13, B)
    cbRegOtp.value = vbUnchecked ' OTP
    D = 0: Call pDrv.dIO(W, &H4, D) ' clear IDD alarm
    
If Not enableFuse Then GoTo testResults
    powerHi
    For i = 0 To 7
        If B And 1 Then
            Call pDrv.dSetFuseWrAddr(i + 1)
            Call pDrv.dSetFuseWrEn(1)
            'Sleep (50)
            MsgBox ("ready for disable")
            Call pDrv.dSetFuseWrEn(0)
            B = B - 1
        End If
        B = B / 2
    Next i
    
    powerNormal
    powerCycle
    
testResults: cmdRead_Click
End Sub


Private Sub cmdRead_Click()
    Dim i As Long, D As Long, B As Long
    Dim TestModeEnable As Integer, RegOtp As Integer
    
    Call pDrv.dPrintTrace("<<<< Read Fuses >>>>")
    
    TestModeEnable = cbTestModeEnable.value
    RegOtp = cbRegOtp.value
    
    cbTestModeEnable.value = vbChecked
    cbRegOtp.value = vbUnchecked
    
    B = 0
    For i = 0 To 7
        Call pDrv.dSetFuseWrAddr(i + 1)
        Call pDrv.dGetOtpData(D)
        If D Then B = B + 2 ^ i
    Next i
    otpData = Hex(B)
    lblOTPdata.caption = "OTP data=0x" & otpData
    Call pDrv.dPrintTrace(lblOTPdata.caption)
    
    D = 0: Call pDrv.dIO(R, &H12, D)
    
    B = (D And 2 ^ 7) / 2 ^ 7
    lblOTPDone.caption = "OTP Done=" & B
    Call pDrv.dPrintTrace(lblOTPDone.caption)
    
    If B Then
        cmdProgram.enabled = False
        cmdGolden.enabled = False
        cmdDone.enabled = False
    Else
        cmdProgram.enabled = True
        cmdGolden.enabled = True
        cmdDone.enabled = True
    End If
    
    B = (D And 2 ^ 5) / 2 ^ 5
    lblGolden.caption = "Golden=" & B
    Call pDrv.dPrintTrace(lblGolden.caption)

    cbTestModeEnable.value = TestModeEnable
    cbRegOtp.value = RegOtp
    
End Sub

Public Sub initValues()
    Dim value As Long
        
    cbTestModeEnable.value = vbChecked
    cbRegOtp.value = vbChecked
    
    If pDrv.dGetProxTrim(value) Then
        handleError ("dGetProxTrim: " & pDrv.getError())
    Else
        hscrProxTrim.value = value: lblProxTrim.caption = value
    End If
        
    If pDrv.dGetIrdrTrim(value) Then
        handleError ("dGetIrdrTrim: " & pDrv.getError())
    Else
        hscrIrdrTrim.value = value: lblIrdrTrim.caption = value
    End If
        
    If pDrv.dGetAlsTrim(value) Then
        handleError ("dGetAlsTrim: " & pDrv.getError())
    Else
        hscrAlsTrim.value = value: lblAlsTrim.caption = value
    End If
    
    cbRegOtp.value = vbUnchecked
    cmdRead_Click
    cbTestModeEnable.value = vbUnchecked
    
    IOreg.s = cmbIO(0).text
    IOreg.m = "&H" & cmbIO(1).text

    txtIO(0).text = "0" & Chr$(13)

End Sub

Public Sub setPdrv()
    Set pDrv = frmMain.ucALSusb1
End Sub

Private Sub Form_Load()
    On Error GoTo exitSub
    alsMult = 1
    
    'If Not formActivated Then
        setPdrv
        initValues
    'End If
    
    'formActivated = True
    
    readRevOption
    
    'If Not formActivated Then Set ucMonochromator1 = frmMonochromator.ucMonochromator1
    Set ucMonochromator1 = frmMonochromator.ucMonochromator1
    
exitSub:
End Sub

Private Sub hscrProxTrim_Change()
    If pDrv.dSetProxTrim(hscrProxTrim.value) Then
        handleError ("hscrProxTrim_Change: " & pDrv.getError())
    Else
        lblProxTrim.caption = hscrProxTrim.value
    End If
End Sub

Private Sub hscrIrdrTrim_Change()
    If pDrv.dSetIrdrTrim(hscrIrdrTrim.value) Then
        handleError ("hscrIrdrTrim_Change: " & pDrv.getError())
    Else
        lblIrdrTrim.caption = hscrIrdrTrim.value
    End If
End Sub

Private Sub hscrAlsTrim_Change()
    If pDrv.dSetAlsTrim(hscrAlsTrim.value) Then
        handleError ("hscrAlsTrim_Change: " & pDrv.getError())
    Else
        lblAlsTrim.caption = hscrAlsTrim.value
    End If
End Sub








Private Sub cmbIO_Change(index As Integer)
    cmbIO_Click index
End Sub

Private Sub cmbIO_Click(index As Integer)
    Select Case index
    Case 0: IOreg.s = cmbIO(index).text
    Case 1: IOreg.m = "&H" & cmbIO(index).text
    End Select
End Sub

Private Sub cmdClrShiftMask_Click()
    cmbIO(0).text = "0" ' shift
    cmbIO(1).text = "FF" ' shift
End Sub

Private Sub txtIO_Change(index As Integer)
    Dim D As Byte
    
    On Error GoTo subExit
    
    If enterText(txtIO(index).text) Then
        If index Then ' write field on data change
            D = "&H" & txtIO(index).text
            Call pDrv.dWriteField(IOreg.a, IOreg.s, IOreg.m, D)
        Else          ' read field on address change
            IOreg.a = "&H" & txtIO(index).text
        End If
        
        IOreg.s = cmbIO(0).text: IOreg.m = "&H" & cmbIO(1).text
        
        Call pDrv.dReadField(IOreg.a, IOreg.s, IOreg.m, D)
        txtIO(0).text = Hex(IOreg.a)
        txtIO(1).text = Hex(D)
    
    End If
subExit:
End Sub

