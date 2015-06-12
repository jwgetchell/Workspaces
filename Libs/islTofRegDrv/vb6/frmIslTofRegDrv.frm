VERSION 5.00
Begin VB.Form frmIslTofRegDrv 
   Caption         =   "Isl Tof Reg Drv"
   ClientHeight    =   2265
   ClientLeft      =   120
   ClientTop       =   465
   ClientWidth     =   4080
   LinkTopic       =   "Form1"
   ScaleHeight     =   2265
   ScaleWidth      =   4080
   StartUpPosition =   3  'Windows Default
   Begin VB.Frame Frame1 
      Caption         =   "Ambient Coefficients"
      Height          =   2175
      Left            =   2160
      TabIndex        =   9
      Top             =   0
      Width           =   1815
      Begin VB.Frame frAmbCoeff 
         Caption         =   "exponent"
         Height          =   615
         Index           =   0
         Left            =   120
         TabIndex        =   10
         Top             =   240
         Width           =   1575
         Begin VB.TextBox tbInput 
            Height          =   285
            Index           =   0
            Left            =   120
            MultiLine       =   -1  'True
            TabIndex        =   11
            Text            =   "frmIslTofRegDrv.frx":0000
            Top             =   240
            Width           =   735
         End
         Begin VB.Label lblReg 
            Caption         =   "0-255"
            Height          =   255
            Index           =   0
            Left            =   960
            TabIndex        =   12
            Top             =   240
            Width           =   495
         End
      End
      Begin VB.Frame frAmbCoeff 
         Caption         =   "C1"
         Height          =   615
         Index           =   1
         Left            =   120
         TabIndex        =   13
         Top             =   840
         Width           =   1575
         Begin VB.TextBox tbInput 
            Height          =   285
            Index           =   1
            Left            =   120
            MultiLine       =   -1  'True
            TabIndex        =   14
            Text            =   "frmIslTofRegDrv.frx":0005
            Top             =   240
            Width           =   735
         End
         Begin VB.Label lblReg 
            Caption         =   "0-255"
            Height          =   255
            Index           =   1
            Left            =   960
            TabIndex        =   15
            Top             =   240
            Width           =   495
         End
      End
      Begin VB.Frame frAmbCoeff 
         Caption         =   "C2"
         Height          =   615
         Index           =   2
         Left            =   120
         TabIndex        =   16
         Top             =   1440
         Width           =   1575
         Begin VB.TextBox tbInput 
            Height          =   285
            Index           =   2
            Left            =   120
            MultiLine       =   -1  'True
            TabIndex        =   17
            Text            =   "frmIslTofRegDrv.frx":000A
            Top             =   240
            Width           =   735
         End
         Begin VB.Label lblReg 
            Caption         =   "0-255"
            Height          =   255
            Index           =   2
            Left            =   960
            TabIndex        =   18
            Top             =   240
            Width           =   495
         End
      End
   End
   Begin VB.Frame frameRead 
      Caption         =   "AX read"
      Height          =   615
      Index           =   2
      Left            =   120
      TabIndex        =   6
      Top             =   1560
      Width           =   1935
      Begin VB.CommandButton cmdRead 
         Caption         =   "Read"
         Height          =   255
         Index           =   2
         Left            =   120
         TabIndex        =   7
         Top             =   240
         Width           =   735
      End
      Begin VB.Label lblValue 
         Caption         =   "Value"
         Height          =   255
         Index           =   2
         Left            =   960
         TabIndex        =   8
         Top             =   240
         Width           =   855
      End
   End
   Begin VB.Frame frameRead 
      Caption         =   "DLL read"
      Height          =   615
      Index           =   1
      Left            =   120
      TabIndex        =   3
      Top             =   840
      Width           =   1935
      Begin VB.CommandButton cmdRead 
         Caption         =   "Read"
         Height          =   255
         Index           =   1
         Left            =   120
         TabIndex        =   4
         Top             =   240
         Width           =   735
      End
      Begin VB.Label lblValue 
         Caption         =   "Value"
         Height          =   255
         Index           =   1
         Left            =   960
         TabIndex        =   5
         Top             =   240
         Width           =   855
      End
   End
   Begin VB.Frame frameRead 
      Caption         =   "HID read"
      Height          =   615
      Index           =   0
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   1935
      Begin VB.CommandButton cmdRead 
         Caption         =   "Read"
         Height          =   255
         Index           =   0
         Left            =   120
         TabIndex        =   2
         Top             =   240
         Width           =   735
      End
      Begin VB.Label lblValue 
         Caption         =   "Value"
         Height          =   255
         Index           =   0
         Left            =   960
         TabIndex        =   1
         Top             =   240
         Width           =   855
      End
   End
End
Attribute VB_Name = "frmIslTofRegDrv"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim tof As islTofRegDrv

Private Sub cmdRead_Click(Index As Integer)
    Dim result As Double, cResult As Byte
    
    Select Case frameRead(Index).Caption
    Case "HID read": result = WSF.readByte(0)
    Case "DLL read": result = WSF.readField(0, 0, &HFF)
    Case "AX read":  Call tof.readField(0, 0, &HFF, cResult): result = cResult
    End Select
    lblValue(Index).Caption = result

End Sub

Private Sub Form_Load()
    Set tof = New islTofRegDrv
    Set cb.islTofRegDrv = New clsIslTofRegDrv
    'cb.islTofRegDrv.init
End Sub

Private Sub tbInput_Change(Index As Integer)
    Static e As Long, c1 As Double, c2 As Double
    On Error GoTo onError
    If enterText(tbInput(Index).text) Then
        Select Case frAmbCoeff(Index).Caption
            Case "exponent": e = tbInput(Index).text: tbInput(Index).text = e
            Case "C1": c1 = tbInput(Index).text: tbInput(Index).text = c1
            Case "C2": c2 = tbInput(Index).text: tbInput(Index).text = c2
        End Select
        If e <> 0 Then
            islTofRegDrv.setAmbientCoeffs e, c1, c2
        End If
    End If
    lblReg(0).Caption = islTofRegDrv.readByte(&H33)
    lblReg(1).Caption = islTofRegDrv.readByte(&H36)
    lblReg(2).Caption = islTofRegDrv.readByte(&H3B)
    GoTo endSub
onError:
endSub: End Sub
