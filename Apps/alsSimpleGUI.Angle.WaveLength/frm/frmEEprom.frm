VERSION 5.00
Begin VB.Form frmEEprom 
   Caption         =   "EEprom"
   ClientHeight    =   1860
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   2250
   Icon            =   "frmEEprom.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   1860
   ScaleWidth      =   2250
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton cmdRdEEprom 
      Caption         =   "R"
      Height          =   255
      Left            =   1800
      TabIndex        =   36
      Top             =   120
      Width           =   375
   End
   Begin VB.CommandButton cmdWrtEEprom 
      Caption         =   "W"
      Height          =   255
      Left            =   1440
      TabIndex        =   35
      Top             =   120
      Width           =   375
   End
   Begin VB.ComboBox cmbMask 
      Height          =   315
      ItemData        =   "frmEEprom.frx":30BA
      Left            =   600
      List            =   "frmEEprom.frx":30D0
      TabIndex        =   33
      Text            =   "LFC1"
      Top             =   120
      Width           =   735
   End
   Begin VB.Frame fmCompensation 
      Caption         =   "Compensation"
      Height          =   1335
      Left            =   0
      TabIndex        =   0
      Top             =   480
      Width           =   2175
      Begin VB.Label lblComp 
         Caption         =   "88"
         Height          =   255
         Index           =   31
         Left            =   1800
         TabIndex        =   32
         Top             =   960
         Width           =   255
      End
      Begin VB.Label lblComp 
         Caption         =   "88"
         Height          =   255
         Index           =   30
         Left            =   1560
         TabIndex        =   31
         Top             =   960
         Width           =   255
      End
      Begin VB.Label lblComp 
         Caption         =   "88"
         Height          =   255
         Index           =   29
         Left            =   1320
         TabIndex        =   30
         Top             =   960
         Width           =   255
      End
      Begin VB.Label lblComp 
         Caption         =   "88"
         Height          =   255
         Index           =   28
         Left            =   1080
         TabIndex        =   29
         Top             =   960
         Width           =   255
      End
      Begin VB.Label lblComp 
         Caption         =   "88"
         Height          =   255
         Index           =   27
         Left            =   840
         TabIndex        =   28
         Top             =   960
         Width           =   255
      End
      Begin VB.Label lblComp 
         Caption         =   "88"
         Height          =   255
         Index           =   26
         Left            =   600
         TabIndex        =   27
         Top             =   960
         Width           =   255
      End
      Begin VB.Label lblComp 
         Caption         =   "88"
         Height          =   255
         Index           =   25
         Left            =   360
         TabIndex        =   26
         Top             =   960
         Width           =   255
      End
      Begin VB.Label lblComp 
         Caption         =   "88"
         Height          =   255
         Index           =   24
         Left            =   120
         TabIndex        =   25
         Top             =   960
         Width           =   255
      End
      Begin VB.Label lblComp 
         Caption         =   "88"
         Height          =   255
         Index           =   23
         Left            =   1800
         TabIndex        =   24
         Top             =   720
         Width           =   255
      End
      Begin VB.Label lblComp 
         Caption         =   "88"
         Height          =   255
         Index           =   22
         Left            =   1560
         TabIndex        =   23
         Top             =   720
         Width           =   255
      End
      Begin VB.Label lblComp 
         Caption         =   "88"
         Height          =   255
         Index           =   21
         Left            =   1320
         TabIndex        =   22
         Top             =   720
         Width           =   255
      End
      Begin VB.Label lblComp 
         Caption         =   "88"
         Height          =   255
         Index           =   20
         Left            =   1080
         TabIndex        =   21
         Top             =   720
         Width           =   255
      End
      Begin VB.Label lblComp 
         Caption         =   "88"
         Height          =   255
         Index           =   19
         Left            =   840
         TabIndex        =   20
         Top             =   720
         Width           =   255
      End
      Begin VB.Label lblComp 
         Caption         =   "88"
         Height          =   255
         Index           =   18
         Left            =   600
         TabIndex        =   19
         Top             =   720
         Width           =   255
      End
      Begin VB.Label lblComp 
         Caption         =   "88"
         Height          =   255
         Index           =   17
         Left            =   360
         TabIndex        =   18
         Top             =   720
         Width           =   255
      End
      Begin VB.Label lblComp 
         Caption         =   "88"
         Height          =   255
         Index           =   16
         Left            =   120
         TabIndex        =   17
         Top             =   720
         Width           =   255
      End
      Begin VB.Label lblComp 
         Caption         =   "88"
         Height          =   255
         Index           =   15
         Left            =   1800
         TabIndex        =   16
         Top             =   480
         Width           =   255
      End
      Begin VB.Label lblComp 
         Caption         =   "88"
         Height          =   255
         Index           =   14
         Left            =   1560
         TabIndex        =   15
         Top             =   480
         Width           =   255
      End
      Begin VB.Label lblComp 
         Caption         =   "88"
         Height          =   255
         Index           =   13
         Left            =   1320
         TabIndex        =   14
         Top             =   480
         Width           =   255
      End
      Begin VB.Label lblComp 
         Caption         =   "88"
         Height          =   255
         Index           =   12
         Left            =   1080
         TabIndex        =   13
         Top             =   480
         Width           =   255
      End
      Begin VB.Label lblComp 
         Caption         =   "88"
         Height          =   255
         Index           =   11
         Left            =   840
         TabIndex        =   12
         Top             =   480
         Width           =   255
      End
      Begin VB.Label lblComp 
         Caption         =   "88"
         Height          =   255
         Index           =   10
         Left            =   600
         TabIndex        =   11
         Top             =   480
         Width           =   255
      End
      Begin VB.Label lblComp 
         Caption         =   "88"
         Height          =   255
         Index           =   9
         Left            =   360
         TabIndex        =   10
         Top             =   480
         Width           =   255
      End
      Begin VB.Label lblComp 
         Caption         =   "88"
         Height          =   255
         Index           =   8
         Left            =   120
         TabIndex        =   9
         Top             =   480
         Width           =   255
      End
      Begin VB.Label lblComp 
         Caption         =   "88"
         Height          =   255
         Index           =   7
         Left            =   1800
         TabIndex        =   8
         Top             =   240
         Width           =   255
      End
      Begin VB.Label lblComp 
         Caption         =   "88"
         Height          =   255
         Index           =   6
         Left            =   1560
         TabIndex        =   7
         Top             =   240
         Width           =   255
      End
      Begin VB.Label lblComp 
         Caption         =   "88"
         Height          =   255
         Index           =   5
         Left            =   1320
         TabIndex        =   6
         Top             =   240
         Width           =   255
      End
      Begin VB.Label lblComp 
         Caption         =   "88"
         Height          =   255
         Index           =   4
         Left            =   1080
         TabIndex        =   5
         Top             =   240
         Width           =   255
      End
      Begin VB.Label lblComp 
         Caption         =   "88"
         Height          =   255
         Index           =   3
         Left            =   840
         TabIndex        =   4
         Top             =   240
         Width           =   255
      End
      Begin VB.Label lblComp 
         Caption         =   "88"
         Height          =   255
         Index           =   2
         Left            =   600
         TabIndex        =   3
         Top             =   240
         Width           =   255
      End
      Begin VB.Label lblComp 
         Caption         =   "88"
         Height          =   255
         Index           =   1
         Left            =   360
         TabIndex        =   2
         Top             =   240
         Width           =   255
      End
      Begin VB.Label lblComp 
         Caption         =   "88"
         Height          =   255
         Index           =   0
         Left            =   120
         TabIndex        =   1
         Top             =   240
         Width           =   255
      End
   End
   Begin VB.Label lblMask 
      Caption         =   "Mask"
      Height          =   255
      Left            =   120
      TabIndex        =   34
      Top             =   180
      Width           =   495
   End
End
Attribute VB_Name = "frmEEprom"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Const envVar As String = "ISLEEprom"
Const maxDev As Integer = 31
Const maxCmp As Integer = 31
Const noDev As Integer = -1
Const noDevLbl As String = "88"

Dim directory As String

Dim cmpVal(maxDev) As Long


Dim i2c As ucALSusb

Public Function getCmpVal(Dev As Integer) As Long
    getCmpVal = noDev
    If 0 <= Dev And Dev <= maxDev Then
        getCmpVal = cmpVal(Dev)
    End If
End Function

Private Sub cmbMask_Click()
    On Error GoTo endSub
    Dim fileName As String, Dev As String, cmp As String
    Dim i As Integer
    
    fileName = directory & cmbMask.list(cmbMask.ListIndex) & ".txt"
    debugPrint fileName
    Open fileName For Input As 1
    
    For i = 0 To maxDev
        cmpVal(i) = noDev
    Next i
    
    While (Not EOF(1))
        Input #1, Dev, cmp
        Dev = Int(val(Dev))
        cmp = Int(val(cmp))
        
        debugPrint Dev, cmp
        
        If 0 <= Dev And Dev <= maxDev Then
            If 0 <= cmp And cmp <= maxCmp Then
                cmpVal(Dev) = cmp
            Else
                If cmp > maxCmp Then
                    cmpVal(Dev) = maxCmp
                Else
                    If cmp < 0 Then
                        cmpVal(Dev) = 0
                    End If
                End If
            End If
        End If
        
    Wend
    
    For i = 0 To maxDev
        If cmpVal(i) = noDev Then
            lblComp(i).caption = noDevLbl
        Else
            lblComp(i).caption = format(cmpVal(i), "00")
        End If
    Next i

endSub:
    Close #1
End Sub

Private Sub cmdRdEEprom_Click()
'    Dim eeData As eePromStruct, char() As Byte: ReDim char(Len(eeData) - 1) As Byte
'
'    i2c.readI2cPage eePromAddrs.systemCard, 0, char
'
'    byte2eeProm char, eeData
    
End Sub

Private Sub cmdWrtEEprom_Click()

'    Dim eeData As eePromStruct, char() As Byte
'
'    eeData.rev.size = Len(eeData)
'
'    ReDim char(eeData.rev.size - 1) As Byte
'
'    eeData.rev.eePromVersion = 29000.0001
'    eeData.rev.size = Len(eeData) - 1
'    eeData.rev.exe = getExeDateTime(App.EXEName & ".exe")
'    eeData.rev.dll = getExeDateTime("registerDriver.dll")
'    eeData.rev.EEprom = now
'    eeData.factoryCalibration(0).cardGain = 1
'    eeData.factoryCalibration(0).range(0) = 1
'    eeData.factoryCalibration(0).range(1) = 1
'    eeData.factoryCalibration(0).compensation = 0
'    eeData.factoryCalibration(0).transform(0, 0) = 1
'    eeData.factoryCalibration(0).transform(1, 1) = 1
'    eeData.factoryCalibration(0).transform(2, 2) = 1
'
'    eeProm2byte eeData, char
'
'    i2c.writeI2cPage eePromAddrs.systemCard, 0, char
'
'    byte2eeProm char, eeData
    
End Sub

Private Sub Form_Load()
    directory = Environ(envVar)
    Set i2c = frmMain.ucALSusb1
End Sub
