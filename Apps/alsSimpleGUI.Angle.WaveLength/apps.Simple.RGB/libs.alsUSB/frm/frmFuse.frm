VERSION 5.00
Object = "{DF4D7537-E39B-42CA-8758-7F08C33D9296}#1.0#0"; "monochromator.ocx"
Begin VB.Form frmFuse 
   Caption         =   "Fuses"
   ClientHeight    =   4935
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   8085
   Icon            =   "frmFuse.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   4935
   ScaleWidth      =   8085
   StartUpPosition =   3  'Windows Default
   Begin VB.CheckBox cbI2cAPItest 
      Caption         =   "i2c API"
      Height          =   375
      Left            =   4800
      Style           =   1  'Graphical
      TabIndex        =   33
      Top             =   2520
      Width           =   3135
   End
   Begin Monochromator.ucMonochromator ucMonochromator1 
      Height          =   4335
      Left            =   4680
      TabIndex        =   31
      Top             =   -2160
      Width           =   3375
      _ExtentX        =   5953
      _ExtentY        =   7646
   End
   Begin VB.Frame fmRegisters 
      Caption         =   "Field I/O"
      Height          =   1575
      Left            =   2880
      TabIndex        =   24
      Top             =   3000
      Width           =   1455
      Begin VB.CommandButton cmdClrShiftMask 
         Caption         =   "clear"
         Height          =   255
         Left            =   840
         TabIndex        =   22
         Top             =   120
         Width           =   495
      End
      Begin VB.TextBox txtIO 
         Height          =   285
         Index           =   0
         Left            =   120
         MultiLine       =   -1  'True
         TabIndex        =   28
         Text            =   "frmFuse.frx":0CCA
         Top             =   1200
         Width           =   615
      End
      Begin VB.ComboBox cmbIO 
         Height          =   315
         Index           =   0
         ItemData        =   "frmFuse.frx":0CD0
         Left            =   120
         List            =   "frmFuse.frx":0CEC
         TabIndex        =   27
         Text            =   "0"
         Top             =   600
         Width           =   615
      End
      Begin VB.ComboBox cmbIO 
         Height          =   315
         Index           =   1
         ItemData        =   "frmFuse.frx":0D08
         Left            =   720
         List            =   "frmFuse.frx":0D24
         TabIndex        =   26
         Text            =   "FF"
         Top             =   600
         Width           =   615
      End
      Begin VB.TextBox txtIO 
         Height          =   285
         Index           =   1
         Left            =   720
         MultiLine       =   -1  'True
         TabIndex        =   25
         Text            =   "frmFuse.frx":0D44
         Top             =   1200
         Width           =   615
      End
      Begin VB.Label lblAddrData 
         Caption         =   "  Addr      Data"
         Height          =   255
         Left            =   120
         TabIndex        =   30
         Top             =   960
         Width           =   1215
      End
      Begin VB.Label lblShiftMask 
         Caption         =   "  Shift      Mask"
         Height          =   255
         Left            =   120
         TabIndex        =   29
         Top             =   360
         Width           =   1215
      End
   End
   Begin VB.CheckBox cbWash 
      Caption         =   "Wash:Norm"
      Height          =   495
      Left            =   2760
      Style           =   1  'Graphical
      TabIndex        =   23
      Top             =   2280
      Width           =   1695
   End
   Begin VB.CommandButton cmdALSint 
      Caption         =   "ALS Int"
      Height          =   495
      Left            =   2760
      TabIndex        =   21
      Top             =   1800
      Width           =   1695
   End
   Begin VB.Frame fmTrim 
      Caption         =   "Trim"
      Height          =   2775
      Left            =   120
      TabIndex        =   7
      Top             =   1320
      Width           =   1815
      Begin VB.CommandButton cmdProg1s 
         Caption         =   "Prog FF"
         Height          =   255
         Left            =   120
         TabIndex        =   32
         Top             =   2400
         Width           =   855
      End
      Begin VB.CommandButton cmdDone 
         Caption         =   "Done"
         Enabled         =   0   'False
         Height          =   255
         Left            =   960
         TabIndex        =   19
         Top             =   2400
         Width           =   735
      End
      Begin VB.CommandButton cmdGolden 
         Caption         =   "Golden"
         Enabled         =   0   'False
         Height          =   255
         Left            =   960
         TabIndex        =   18
         Top             =   2160
         Width           =   735
      End
      Begin VB.CommandButton cmdProgram 
         Caption         =   "Program"
         Enabled         =   0   'False
         Height          =   255
         Left            =   120
         TabIndex        =   17
         Top             =   2160
         Width           =   855
      End
      Begin VB.Frame fmIrdrTrim 
         Caption         =   "Irdr"
         Height          =   615
         Left            =   120
         TabIndex        =   14
         Top             =   840
         Width           =   1575
         Begin VB.HScrollBar hscrIrdrTrim 
            Height          =   255
            Left            =   120
            Max             =   7
            TabIndex        =   15
            Top             =   240
            Width           =   855
         End
         Begin VB.Label lblIrdrTrim 
            Caption         =   "7"
            Height          =   255
            Left            =   1200
            TabIndex        =   16
            Top             =   240
            Width           =   255
         End
      End
      Begin VB.Frame fmProxTrim 
         Caption         =   "Prox"
         Height          =   615
         Left            =   120
         TabIndex        =   11
         Top             =   240
         Width           =   1575
         Begin VB.HScrollBar hscrProxTrim 
            Height          =   255
            Left            =   120
            Max             =   3
            TabIndex        =   12
            Top             =   240
            Width           =   855
         End
         Begin VB.Label lblProxTrim 
            Caption         =   "3"
            Height          =   255
            Left            =   1200
            TabIndex        =   13
            Top             =   240
            Width           =   255
         End
      End
      Begin VB.Frame fmAlsTrim 
         Caption         =   "Als"
         Height          =   615
         Left            =   120
         TabIndex        =   8
         Top             =   1440
         Width           =   1575
         Begin VB.HScrollBar hscrAlsTrim 
            Height          =   255
            Left            =   120
            Max             =   7
            TabIndex        =   9
            Top             =   240
            Width           =   855
         End
         Begin VB.Label lblAlsTrim 
            Caption         =   "7"
            Height          =   255
            Left            =   1200
            TabIndex        =   10
            Top             =   240
            Width           =   255
         End
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "OTP"
      Height          =   1455
      Left            =   2760
      TabIndex        =   2
      Top             =   120
      Width           =   1815
      Begin VB.ComboBox cmbRctrl 
         Height          =   315
         ItemData        =   "frmFuse.frx":0D4A
         Left            =   960
         List            =   "frmFuse.frx":0D5A
         TabIndex        =   20
         Text            =   "2k"
         Top             =   240
         Width           =   735
      End
      Begin VB.CommandButton cmdRead 
         Caption         =   "Read"
         Height          =   315
         Left            =   120
         TabIndex        =   6
         Top             =   240
         Width           =   855
      End
      Begin VB.Label lblGolden 
         Caption         =   "Golden="
         Height          =   255
         Left            =   120
         TabIndex        =   5
         Top             =   1080
         Width           =   1455
      End
      Begin VB.Label lblOTPDone 
         Caption         =   "OTP Done="
         Height          =   255
         Left            =   120
         TabIndex        =   4
         Top             =   840
         Width           =   1455
      End
      Begin VB.Label lblOTPdata 
         Caption         =   "OTP Data="
         Height          =   255
         Left            =   120
         TabIndex        =   3
         Top             =   600
         Width           =   1455
      End
   End
   Begin VB.CheckBox cbRegOtp 
      Caption         =   "OTP"
      Enabled         =   0   'False
      Height          =   495
      Left            =   120
      Style           =   1  'Graphical
      TabIndex        =   1
      Top             =   720
      Width           =   1455
   End
   Begin VB.CheckBox cbTestModeEnable 
      Caption         =   "Test Mode:Off"
      Height          =   495
      Left            =   120
      Style           =   1  'Graphical
      TabIndex        =   0
      Top             =   120
      Width           =   1455
   End
End
Attribute VB_Name = "frmFuse"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim pDrv As ucALSusb

Const enableFuse As Boolean = True

Dim ioReg As reg

Private Sub handleError(msg As String)

End Sub

Private Sub cbTestModeEnable_Click()
    Dim d As Long
    If cbTestModeEnable.value = vbChecked Then
        cbTestModeEnable.caption = "Test Mode:On"
        d = &H89: Call pDrv.dIO(w, &HE, d)
        cbRegOtp.Enabled = True
    Else
        cbTestModeEnable.caption = "Test Mode:Off"
        d = &H0: Call pDrv.dIO(w, &HE, d)
        cbRegOtp.Enabled = False
    End If
End Sub

Private Sub cbRegOtp_Click()
    If cbRegOtp.value = vbChecked Then
        cbRegOtp.caption = "Register"
        Call pDrv.dSetRegOtpSel(1)
        hscrProxTrim.Enabled = True
        hscrIrdrTrim.Enabled = True
        hscrAlsTrim.Enabled = True
    Else
        cbRegOtp.caption = "OTP"
        Call pDrv.dSetRegOtpSel(0)
        hscrProxTrim.Enabled = False
        hscrIrdrTrim.Enabled = False
        hscrAlsTrim.Enabled = False
    End If
End Sub

Public Sub powerOn()
    powerNormal
End Sub

Public Sub powerOff(Optional wait As Long = 1000)
    ucMonochromator1.setVolts (0#): Call pDrv.dPrintTrace("VDD to 0.0V")
    Sleep (wait)
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
    Dim d As Long
    d = cmbRctrl.ListIndex
    d = d * 2 ^ 3
    Call pDrv.dIO(w, &H12, d)
    cmdRead_Click
End Sub

Private Sub cmdALSint_Click()
    Dim i As Long, j As Long, k As Long
    Const l As Long = 10
    Call pDrv.dSetEnable(0, 0) ' als off
    Call pDrv.dSetEnable(1, 0) ' prox off
    Call pDrv.dSetThreshHi(0, 0) ' force als int
    Call pDrv.dSetEnable(0, 1) ' als on
    For i = 1 To 50 * l
        Call pDrv.dGetIntFlag(0, j): Sleep 20
        If j Then k = k + 1
        If k >= l Then i = 50 * l
    Next i
    Call pDrv.dSetEnable(0, 0) ' als off
End Sub

Private Sub cmdDone_Click()
    Dim d As Long
    
    Call pDrv.dPrintTrace("<<<< Program: Set Done >>>>")
    cbTestModeEnable.value = vbChecked ' test mode on
    cbRegOtp.value = vbUnchecked ' OTP
    d = 0: Call pDrv.dIO(w, &H4, d) ' clear IDD alarm
    
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
    Dim d As Long
    
    Call pDrv.dPrintTrace("<<<< Program: Set Golden >>>>")
    cbTestModeEnable.value = vbChecked ' test mode on
    cbRegOtp.value = vbUnchecked ' OTP
    d = 0: Call pDrv.dIO(w, &H4, d) ' clear IDD alarm
    
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
    Dim d As Long, b As Long, i As Integer
    
    lblOTPdata.caption = "IN PROGRESS": DoEvents
    
    Call pDrv.dPrintTrace("<<<< Program >>>>")
    cbRegOtp.value = vbChecked ' register
    Call pDrv.dIO(r, &H13, b)
    cbRegOtp.value = vbUnchecked ' OTP
    d = 0: Call pDrv.dIO(w, &H4, d) ' clear IDD alarm
    
If Not enableFuse Then GoTo testResults
    powerHi
    For i = 0 To 7
        If b And 1 Then
            Call pDrv.dSetFuseWrAddr(i + 1)
            Call pDrv.dSetFuseWrEn(1)
            Sleep (50)
            Call pDrv.dSetFuseWrEn(0)
            b = b - 1
        End If
        b = b / 2
    Next i
    
    powerNormal
    powerCycle
    
testResults: cmdRead_Click
End Sub


Private Sub cmdRead_Click()
    Dim i As Long, d As Long, b As Long
    Dim TestModeEnable As Integer, RegOtp As Integer
    
    Call pDrv.dPrintTrace("<<<< Read Fuses >>>>")
    
    TestModeEnable = cbTestModeEnable.value
    RegOtp = cbRegOtp.value
    
    cbTestModeEnable.value = vbChecked
    cbRegOtp.value = vbUnchecked
    
    b = 0
    For i = 0 To 7
        Call pDrv.dSetFuseWrAddr(i + 1)
        Call pDrv.dGetOtpData(d)
        If d Then b = b + 2 ^ i
    Next i
    lblOTPdata.caption = "OTP data=0x" & Hex(b)
    Call pDrv.dPrintTrace(lblOTPdata.caption)
    
    d = 0: Call pDrv.dIO(r, &H12, d)
    
    b = (d And 2 ^ 7) / 2 ^ 7
    lblOTPDone.caption = "OTP Done=" & b
    Call pDrv.dPrintTrace(lblOTPDone.caption)
    
    If b Then
        cmdProgram.Enabled = False
        cmdGolden.Enabled = False
        cmdDone.Enabled = False
    Else
        cmdProgram.Enabled = True
        cmdGolden.Enabled = True
        cmdDone.Enabled = True
    End If
    
    b = (d And 2 ^ 5) / 2 ^ 5
    lblGolden.caption = "Golden=" & b
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
    
    ioReg.s = cmbIO(0).text
    ioReg.m = "&H" & cmbIO(1).text

    txtIO(0).text = "0" & Chr$(13)

End Sub


Public Sub setPdrv()
    Set pDrv = frmMain.pDrv
End Sub

Private Sub Form_Activate()
    Static done As Boolean
    If Not done Then
        initValues
        done = True
    End If
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
    Case 0: ioReg.s = cmbIO(index).text
    Case 1: ioReg.m = "&H" & cmbIO(index).text
    End Select
End Sub

Private Sub cmdClrShiftMask_Click()
    cmbIO(0).text = "0" ' shift
    cmbIO(1).text = "FF" ' shift
End Sub

Private Sub txtIO_Change(index As Integer)
    Dim d As Byte
    
    If enterText(txtIO(index).text) Then
        If index Then ' write field on data change
            d = "&H" & txtIO(index).text
            Call pDrv.dWriteField(ioReg.a, ioReg.s, ioReg.m, d)
        Else          ' read field on address change
            ioReg.a = "&H" & txtIO(index).text
        End If
        
        Call pDrv.dReadField(ioReg.a, ioReg.s, ioReg.m, d)
        txtIO(0).text = Hex(ioReg.a)
        txtIO(1).text = Hex(d)
    
    End If
End Sub


Private Sub cbI2cAPItest_Click()

    If cbI2cAPItest.value = vbChecked Then
        cbI2cAPItest.caption = "Test:" & cbI2cAPItest.value
        Call pDrv.dWriteI2c(&H88, 2, 2 ^ 2 * cbI2cAPItest.value)
    Else
        cbI2cAPItest.caption = "Test:" & cbI2cAPItest.value
        Call pDrv.dWriteI2c(&H88, 2, 2 ^ 2 * cbI2cAPItest.value)
    End If
    
End Sub


