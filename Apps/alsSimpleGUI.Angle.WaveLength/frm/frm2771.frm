VERSION 5.00
Begin VB.Form frm2771 
   Caption         =   "TSL/TMD 2771"
   ClientHeight    =   2040
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   2760
   Icon            =   "frm2771.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   2040
   ScaleWidth      =   2760
   StartUpPosition =   3  'Windows Default
   Begin VB.Frame fmDiode 
      Caption         =   "Diode(s)"
      Height          =   615
      Left            =   1440
      TabIndex        =   7
      Top             =   0
      Width           =   1215
      Begin VB.CheckBox cbDiode 
         Caption         =   "1"
         Height          =   255
         Index           =   1
         Left            =   600
         TabIndex        =   9
         Top             =   240
         Width           =   495
      End
      Begin VB.CheckBox cbDiode 
         Caption         =   "0"
         Height          =   255
         Index           =   0
         Left            =   120
         TabIndex        =   8
         Top             =   240
         Width           =   495
      End
   End
   Begin VB.CommandButton cmdReset 
      Caption         =   "Reset"
      Height          =   495
      Left            =   120
      TabIndex        =   3
      Top             =   120
      Width           =   1215
   End
   Begin VB.Frame fmRegister 
      Caption         =   "Pulse Count"
      Height          =   615
      Index           =   0
      Left            =   120
      TabIndex        =   0
      Top             =   720
      Width           =   2535
      Begin VB.HScrollBar HScrRegister 
         Height          =   255
         Index           =   0
         Left            =   120
         Max             =   32
         Min             =   1
         TabIndex        =   1
         Top             =   240
         Value           =   1
         Width           =   1815
      End
      Begin VB.Label lblRegister 
         Alignment       =   1  'Right Justify
         Caption         =   "1"
         Height          =   255
         Index           =   0
         Left            =   2040
         TabIndex        =   2
         Top             =   240
         Width           =   375
      End
   End
   Begin VB.Frame fmRegister 
      Caption         =   "IRDR"
      Height          =   615
      Index           =   1
      Left            =   120
      TabIndex        =   4
      Top             =   1320
      Width           =   2535
      Begin VB.HScrollBar HScrRegister 
         Height          =   255
         Index           =   1
         Left            =   120
         Max             =   3
         TabIndex        =   5
         Top             =   240
         Width           =   1815
      End
      Begin VB.Label lblRegister 
         Alignment       =   1  'Right Justify
         Caption         =   "0"
         Height          =   255
         Index           =   1
         Left            =   2040
         TabIndex        =   6
         Top             =   240
         Width           =   375
      End
   End
End
Attribute VB_Name = "frm2771"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim pDrv As ucALSusb

Private Sub cmdReset_Click()
    reset
End Sub

Private Sub Form_Load()
    Dim a As Long, s As Long, m As Long, d As Long
    
    Set pDrv = frmMain.ucALSusb1
    
    'Call pDrv.dWriteField(a, s, m, d)
    
End Sub

Sub reset()
    Call pDrv.dWriteField(&H0, 0, &HFF, &HF)  ' 0x00 enable
    Call pDrv.dWriteField(&H2, 0, &HFF, &HFF) ' 0x02 prox int time
    Call pDrv.dWriteField(&HD, 0, &HFF, &H0)  ' 0x0D long wait (x12)
    Call pDrv.dWriteField(&H3, 0, &HFF, &HFF) ' 0x03 wait (sleep) time
    
    Call pDrv.dWriteField(&HE, 0, &HFF, &H20) ' 0x0E pulse count
    Call pDrv.dWriteField(&HF, 0, &HFF, &H30) ' 0x0F irdr, diode 0&1

End Sub

Private Sub HScrRegister_Change(Index As Integer)

    Dim a As Long, s As Long, m As Long, d As Long
    
    If Index = 0 Then a = &HE: s = 0: m = &HFF
    If Index = 1 Then a = &HF: s = 6: m = &H3
    
    d = HScrRegister(Index).value
    lblRegister(Index).caption = d
    
    Call pDrv.dWriteField(a, s, m, d)
    
End Sub

Private Sub cbDiode_Click(Index As Integer)
    
    Dim a As Long, s As Long, m As Long, d As Long
    
    a = &HF
    s = Index + 4
    m = 1
    d = cbDiode(Index).value
    
    Call pDrv.dWriteField(a, s, m, d)

End Sub


