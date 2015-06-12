VERSION 5.00
Begin VB.Form frmMain 
   Caption         =   "Test"
   ClientHeight    =   6075
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   3690
   Icon            =   "frmMain.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   6075
   ScaleWidth      =   3690
   StartUpPosition =   3  'Windows Default
   Begin VB.OptionButton optPrxAlrm 
      Caption         =   "Option1"
      Height          =   255
      Left            =   3480
      TabIndex        =   11
      Top             =   3840
      Width           =   255
   End
   Begin alsUSB.ucALSusb ucALSusb1 
      Height          =   5895
      Left            =   120
      TabIndex        =   9
      Top             =   120
      Width           =   1815
      _ExtentX        =   3201
      _ExtentY        =   10398
   End
   Begin VB.Timer tmrRun 
      Enabled         =   0   'False
      Interval        =   100
      Left            =   2040
      Top             =   5520
   End
   Begin VB.CheckBox cbRun 
      Caption         =   "Off"
      Height          =   375
      Left            =   2040
      Style           =   1  'Graphical
      TabIndex        =   7
      Top             =   2520
      Width           =   1575
   End
   Begin VB.Frame fmtest 
      BorderStyle     =   0  'None
      Caption         =   "Frame1"
      Enabled         =   0   'False
      Height          =   2415
      Left            =   2040
      TabIndex        =   0
      Top             =   0
      Width           =   1695
      Begin VB.CommandButton cmdSeqBad 
         Caption         =   "SeqBad"
         Height          =   375
         Left            =   0
         TabIndex        =   5
         Top             =   960
         Width           =   1575
      End
      Begin VB.CommandButton cmdInit 
         Caption         =   "Init"
         Height          =   375
         Left            =   0
         TabIndex        =   4
         Top             =   480
         Width           =   1575
      End
      Begin VB.CommandButton cmdSeqFixed 
         Caption         =   "SeqFixed"
         Height          =   375
         Left            =   0
         TabIndex        =   3
         Top             =   1440
         Width           =   1575
      End
      Begin VB.CommandButton cmdBetter 
         Caption         =   "Better"
         Height          =   375
         Left            =   0
         TabIndex        =   2
         Top             =   1920
         Width           =   1575
      End
      Begin VB.ComboBox cmbPersist 
         Height          =   315
         ItemData        =   "frmMain.frx":0CCA
         Left            =   0
         List            =   "frmMain.frx":0CDA
         TabIndex        =   1
         Text            =   "Persist=1"
         Top             =   0
         Width           =   1575
      End
   End
   Begin VB.Timer tmrWaitForUsb 
      Enabled         =   0   'False
      Interval        =   100
      Left            =   2520
      Top             =   5520
   End
   Begin VB.Label lblProx 
      Caption         =   "Prox Stdev"
      Height          =   255
      Index           =   2
      Left            =   2040
      TabIndex        =   15
      Top             =   4680
      Width           =   1575
   End
   Begin VB.Label lblProx 
      Caption         =   "Prox Mean"
      Height          =   255
      Index           =   1
      Left            =   2040
      TabIndex        =   14
      Top             =   4440
      Width           =   1575
   End
   Begin VB.Label lblLux 
      Caption         =   "Lux Stdev"
      Height          =   255
      Index           =   2
      Left            =   2040
      TabIndex        =   13
      Top             =   3480
      Width           =   1575
   End
   Begin VB.Label lblLux 
      Caption         =   "Lux Mean"
      Height          =   255
      Index           =   1
      Left            =   2040
      TabIndex        =   12
      Top             =   3240
      Width           =   1575
   End
   Begin VB.Label lblIR 
      Caption         =   "IR"
      Height          =   255
      Left            =   2040
      TabIndex        =   10
      Top             =   3840
      Width           =   1215
   End
   Begin VB.Label lblProx 
      Caption         =   "Prox"
      Height          =   255
      Index           =   0
      Left            =   2040
      TabIndex        =   6
      Top             =   4200
      Width           =   1575
   End
   Begin VB.Label lblLux 
      Caption         =   "Lux"
      Height          =   255
      Index           =   0
      Left            =   2040
      TabIndex        =   8
      Top             =   3000
      Width           =   1575
   End
End
Attribute VB_Name = "frmMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Option Explicit

Public pDrv As ucALSusb

' IO cmd = {w,r,WW,RW,WA}

Dim persist As Long

Private Sub cbRun_Click()
    If cbRun.value = vbChecked Then
        tmrRun.Enabled = True
        cbRun.caption = "On"
    Else
        tmrRun.Enabled = False
        cbRun.caption = "Off"
    End If
End Sub

Private Sub cmbPersist_Click()
    persist = cmbPersist.ListIndex
End Sub

Private Sub cmdInit_Click()
    Dim d As Long, a As Long
    
    Call pDrv.dPrintTrace("<<<< Init >>>>")
    
    d = 0
    For a = 0 To 5
        Call pDrv.dIO(w, a, d)
    Next a
    
    d = &HFF
    For a = 6 To 7
        Call pDrv.dIO(w, a, d)
    Next a
    
End Sub

Private Sub cmdSeqBad_Click()
    Dim d As Long
    
    Call pDrv.dPrintTrace("<<<< SeqBad >>>>")
    
    d = &HA0: Call pDrv.dIO(w, 0, d)
    Call pDrv.dIO(r, 0, d)
    d = &H0: Call pDrv.dIO(w, 0, d)
    d = &H800: Call pDrv.dIO(WW, 4, d)
    d = &H7FF: Call pDrv.dIO(WW, 6, d)
    d = &HC4: Call pDrv.dIO(w, 1, d)
    d = &H0: Call pDrv.dIO(w, 0, d)
    Call pDrv.dIO(r, 0, d)
    d = &HE0 + persist: Call pDrv.dIO(w, 0, d)
    Sleep 100
    Call pDrv.dIO(r, 0, d)

    cmdInit_Click
End Sub

Private Sub cmdSeqFixed_Click()
    Dim d As Long
    
    Call pDrv.dPrintTrace("<<<< SeqFixed >>>>")
    
    d = &HA0: Call pDrv.dIO(w, 0, d)
    Call pDrv.dIO(r, 0, d)
    d = &H0: Call pDrv.dIO(w, 0, d)
    d = &H800: Call pDrv.dIO(WW, 4, d)
    d = &H7FF: Call pDrv.dIO(WW, 6, d)
    d = &HC4: Call pDrv.dIO(w, 1, d)
    d = &H0: Call pDrv.dIO(w, 0, d)
    Call pDrv.dIO(r, 0, d)
    d = persist: Call pDrv.dIO(w, 0, d) ' FIX
    d = &HE0 + persist: Call pDrv.dIO(w, 0, d)
    Sleep 100
    Call pDrv.dIO(r, 0, d)

    cmdInit_Click
End Sub

Private Sub cmdBetter_Click()
    Dim d As Long
    
    Call pDrv.dPrintTrace("<<<< SeqBetter >>>>")
    
    d = &HA0: Call pDrv.dIO(w, 0, d)
    Call pDrv.dIO(r, 0, d)
    d = &H0: Call pDrv.dIO(w, 0, d)
    d = &H800: Call pDrv.dIO(WW, 4, d)
    d = &H7FF: Call pDrv.dIO(WW, 6, d)
    d = &HC4: Call pDrv.dIO(w, 1, d)
    d = &H0 + persist: Call pDrv.dIO(w, 0, d) ' FIX
    'Call pDrv.dIO(r, 0, d)
    d = &HE2: Call pDrv.dIO(w, 0, d)
    Sleep 100
    Call pDrv.dIO(r, 0, d)

    cmdInit_Click
End Sub

Private Sub Form_Load()
    frmFuse.powerOn
    Set pDrv = ucALSusb1
    pDrv.setHwnd (Me.hWnd)
    frmFuse.setPdrv
    persist = 0
    tmrWaitForUsb.Enabled = True
End Sub

Private Sub Form_Unload(Cancel As Integer)
    frmFuse.powerOff
    frmFuse.Hide
    End
End Sub

Private Sub tmrRun_Timer()
    Dim lux As Double, prox As Double, ir As Double, prxAlrm As Long
    Dim m As Double, s As Double
    
    Call pDrv.dGetLux(lux): Call pDrv.dGetStats(0, m, s)
    lblLux(0).caption = "Lux= " & Format(lux, "0.0")
    lblLux(1).caption = "Lux Mean= " & Format(m, "0.0")
    lblLux(2).caption = "Lux Stdev= " & Format(s, "0.0")
    
    Call pDrv.dGetIR(ir)
    lblIR.caption = Format(ir, "IR=0.000")
    
    Call pDrv.dGetProxAlrm(prxAlrm)
    If prxAlrm Then
        optPrxAlrm.value = True
    Else
        optPrxAlrm.value = False
    End If

    Call pDrv.dGetProximity(prox): Call pDrv.dGetStats(2, m, s)
    lblProx(0).caption = "Prox= " & Format(prox, "0.000")
    lblProx(1).caption = "Prox Mean= " & Format(m, "0.000")
    lblProx(2).caption = "Prox Stdev= " & Format(s, "0.000")

End Sub

Private Sub tmrWaitForUsb_Timer()
    Dim n As Long, d As Long
    Me.caption = pDrv.getUSBcaption
    If Me.caption <> "" Then
        Call pDrv.dGetNdevice(n)
        Call pDrv.dGetDevice(d)
        If n <> d Then
            tmrWaitForUsb.Enabled = False
            fmtest.Enabled = True
            Call pDrv.dGetPartNumber(d)
            If d = 29038 Then frmFuse.Show
        End If
    End If
End Sub

