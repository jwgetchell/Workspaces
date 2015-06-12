VERSION 5.00
Object = "{648A5603-2C6E-101B-82B6-000000000014}#1.1#0"; "MSCOMM32.OCX"
Begin VB.Form Form1 
   Caption         =   "Form1"
   ClientHeight    =   2280
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   3195
   LinkTopic       =   "Form1"
   ScaleHeight     =   2280
   ScaleWidth      =   3195
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton Command1 
      Caption         =   "GetLux"
      Height          =   495
      Left            =   600
      TabIndex        =   2
      Top             =   840
      Width           =   1575
   End
   Begin VB.TextBox Text1 
      Alignment       =   1  'Right Justify
      Appearance      =   0  'Flat
      Height          =   495
      Left            =   600
      TabIndex        =   1
      Text            =   "Lux Reading"
      Top             =   1560
      Width           =   1575
   End
   Begin MSCommLib.MSComm MSComm1 
      Left            =   0
      Top             =   120
      _ExtentX        =   1005
      _ExtentY        =   1005
      _Version        =   393216
      DTREnable       =   -1  'True
   End
   Begin VB.CommandButton Initialize_Comm 
      Caption         =   "Initialize Comm"
      Height          =   495
      Left            =   600
      TabIndex        =   0
      Top             =   240
      Width           =   1575
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim LM As clsMSComm
Dim useClass As Boolean

Public Function EnableLuxMeter()
    'Define LM communication
    LuxMeterCom.Receptor(0) = &H39& ' ASCII 9
    LuxMeterCom.Receptor(1) = &H39& ' ASCII 9
    LuxMeterCom.Command(0) = &H35&  ' ASCII 5
    LuxMeterCom.Command(1) = &H35&  ' ASCII 5
    LuxMeterCom.DATA4(0) = &H30&    ' ASCII 0
    LuxMeterCom.DATA4(1) = &H20&    ' ASCII Space
    LuxMeterCom.DATA4(2) = &H20&    ' ASCII Space
    LuxMeterCom.DATA4(3) = &H30&    ' ASCII 0
    LuxMeterCom.ETX = &H3&
    LuxMeterCom.CR = &HD&
    LuxMeterCom.LF = &HA&
    
    CalcBCC
    LMSendCom
    Sleep 80
End Function


Public Function GetLux()
    Dim RawLux As String
    Dim Lux As String
    'Define LM communication
    LuxMeterCom.Receptor(0) = &H30& ' ASCII 0
    LuxMeterCom.Receptor(1) = &H30& ' ASCII 0
    LuxMeterCom.Command(0) = &H31&  ' ASCII 1
    LuxMeterCom.Command(1) = &H30&  ' ASCII 0
    LuxMeterCom.DATA4(0) = &H30&    ' ASCII 0
    LuxMeterCom.DATA4(1) = &H32&    ' ASCII 2
    LuxMeterCom.DATA4(2) = &H30&    ' ASCII 0
    LuxMeterCom.DATA4(3) = &H30&    ' ASCII 0
    LuxMeterCom.ETX = &H3&
    LuxMeterCom.CR = &HD&
    LuxMeterCom.LF = &HA&
    
    CalcBCC
    LMSendCom
    Sleep 100
    LMRecvCom
    RawLux = Mid(Buffer, 10, 6)
    Lux = Val(Mid(RawLux, 2, 4)) * (10 ^ (Val(Mid(RawLux, 6, 1) - 4)))
    Text1.Text = Lux + " Lx"
End Function


Public Function LMSendCom()
    Buffer = Chr(LuxMeterCom.STX) + Chr(LuxMeterCom.Receptor(0)) + Chr(LuxMeterCom.Receptor(1)) + Chr(LuxMeterCom.Command(0)) + _
        Chr(LuxMeterCom.Command(1)) + Chr(LuxMeterCom.DATA4(0)) + Chr(LuxMeterCom.DATA4(1)) + Chr(LuxMeterCom.DATA4(2)) + Chr(LuxMeterCom.DATA4(3)) + _
        Chr(LuxMeterCom.ETX) + LuxMeterCom.BCC + Chr(LuxMeterCom.CR) + Chr(LuxMeterCom.LF)
    
    If useClass Then
        LM.writeComm Buffer
    Else
        MSComm1.Output = Buffer
    End If
    
End Function

Public Function LMRecvCom() As String
    If useClass Then
        Buffer = LM.readComm
    Else
        Buffer = MSComm1.Input
    End If
End Function
    
Public Function InitLuxMeter()

    If Not MSComm1.PortOpen And Not useClass Then
        MSComm1.CommPort = 4   'Port Number
        MSComm1.Settings = "9600,E,7,1" '9600 baud, even parity, 8 data, 1 stop bit
        MSComm1.InputLen = 0 'Read whole buffer when Input is used
        MSComm1.PortOpen = True 'Open the serial port
    End If
        
    'Define LM communication defaults
    LuxMeterCom.STX = &H2&
    LuxMeterCom.Receptor(0) = &H30& ' ASCII 0
    LuxMeterCom.Receptor(1) = &H30& ' ASCII 0
    LuxMeterCom.Command(0) = &H35&  ' ASCII 5
    LuxMeterCom.Command(1) = &H34&  ' ASCII 4
    LuxMeterCom.DATA4(0) = &H31&    ' ASCII 1
    LuxMeterCom.DATA4(1) = &H20&    ' ASCII Space
    LuxMeterCom.DATA4(2) = &H20&    ' ASCII Space
    LuxMeterCom.DATA4(3) = &H20&    ' ASCII Space
    LuxMeterCom.ETX = &H3&
    LuxMeterCom.CR = &HD&
    LuxMeterCom.LF = &HA&
    
    CalcBCC
    LMSendCom
    Sleep 80
    LMRecvCom
    
    If Mid(Buffer, 2, 7) = "0054   " Then
        MsgBox ("Connection initialized")
    Else
        MsgBox ("Could not initialize")
    End If
    
End Function



Private Sub Command1_Click()
    GetLux
End Sub

Private Sub Form_Load()
    useClass = True
    If useClass Then
        Set LM = New clsMSComm
        LM.setPort 4
    End If
End Sub

Private Sub Initialize_Comm_Click()
    Dim i As Integer
    InitLuxMeter
    EnableLuxMeter
    
End Sub


