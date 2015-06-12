VERSION 5.00
Object = "{648A5603-2C6E-101B-82B6-000000000014}#1.1#0"; "MSCOMM32.OCX"
Begin VB.UserControl ctrlChromaMeter 
   ClientHeight    =   2595
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   6315
   ScaleHeight     =   2595
   ScaleWidth      =   6315
   Begin VB.TextBox Text2 
      Alignment       =   2  'Center
      Height          =   495
      Left            =   240
      TabIndex        =   3
      Text            =   "Color Temperature"
      Top             =   1920
      Width           =   1575
   End
   Begin VB.CommandButton Initialize_Comm 
      Caption         =   "Initialize Comm"
      Height          =   495
      Left            =   240
      TabIndex        =   2
      Top             =   120
      Width           =   1575
   End
   Begin VB.TextBox Text1 
      Alignment       =   2  'Center
      Appearance      =   0  'Flat
      Height          =   495
      Left            =   240
      TabIndex        =   1
      Text            =   "Lux Reading"
      Top             =   1320
      Width           =   1575
   End
   Begin VB.CommandButton GetLux_Button 
      Caption         =   "GetLux"
      Height          =   495
      Left            =   240
      TabIndex        =   0
      Top             =   720
      Width           =   1575
   End
   Begin MSCommLib.MSComm MSComm1 
      Left            =   2640
      Top             =   240
      _ExtentX        =   1005
      _ExtentY        =   1005
      _Version        =   393216
      CommPort        =   9
      DTREnable       =   -1  'True
   End
End
Attribute VB_Name = "ctrlChromaMeter"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Private Const CommPort As Integer = 7

Public Function EnableChromaMeter()
    'Define LM communication
    ChromaMeterCom.Receptor(0) = &H39& ' ASCII 9
    ChromaMeterCom.Receptor(1) = &H39& ' ASCII 9
    ChromaMeterCom.Command(0) = &H35&  ' ASCII 5
    ChromaMeterCom.Command(1) = &H35&  ' ASCII 5
    ChromaMeterCom.DATA4(0) = &H31&    ' ASCII 1
    ChromaMeterCom.DATA4(1) = &H20&    ' ASCII Space
    ChromaMeterCom.DATA4(2) = &H20&    ' ASCII Space
    ChromaMeterCom.DATA4(3) = &H30&    ' ASCII 0
    ChromaMeterCom.ETX = &H3&
    ChromaMeterCom.CR = &HD&
    ChromaMeterCom.LF = &HA&
    
    CalcBCC
    LMSendCom
    Sleep 500
End Function
Public Function SetEXT()
    'Define LM communication
    ChromaMeterCom.Receptor(0) = &H30& ' ASCII 0
    ChromaMeterCom.Receptor(1) = &H30& ' ASCII 0
    ChromaMeterCom.Command(0) = &H34&  ' ASCII 4
    ChromaMeterCom.Command(1) = &H30&  ' ASCII 0
    ChromaMeterCom.DATA4(0) = &H31&    ' ASCII 1
    ChromaMeterCom.DATA4(1) = &H30&    ' ASCII 0
    ChromaMeterCom.DATA4(2) = &H20&    ' ASCII Space
    ChromaMeterCom.DATA4(3) = &H20&    ' ASCII Space
    ChromaMeterCom.ETX = &H3&
    ChromaMeterCom.CR = &HD&
    ChromaMeterCom.LF = &HA&
    
    CalcBCC
    LMSendCom
    Sleep 175
    LMRecvCom
    
End Function

Public Function Enable_Measurement()
    If ChromaMeterCom.Init Then
        'Define LM communication
        ChromaMeterCom.Receptor(0) = &H39& ' ASCII 9
        ChromaMeterCom.Receptor(1) = &H39& ' ASCII 9
        ChromaMeterCom.Command(0) = &H34&  ' ASCII 4
        ChromaMeterCom.Command(1) = &H30&  ' ASCII 0
        ChromaMeterCom.DATA4(0) = &H32&    ' ASCII 1
        ChromaMeterCom.DATA4(1) = &H31&    ' ASCII 1
        ChromaMeterCom.DATA4(2) = &H20&    ' ASCII Space
        ChromaMeterCom.DATA4(3) = &H20&    ' ASCII Space
        ChromaMeterCom.ETX = &H3&
        ChromaMeterCom.CR = &HD&
        ChromaMeterCom.LF = &HA&
    
        CalcBCC
        LMSendCom
        Sleep 500
   End If
End Function
Public Function GetLux() As Variant
    Dim RawLux As String
    Dim RawColorTemp As String
    Dim Lux As String
    Dim ColorTemp As String
    Dim RetVar As Variant
    ReDim RetVar(0 To 1)
    
    Enable_Measurement
    
    If ChromaMeterCom.Init Then
        'Define LM communication
        ChromaMeterCom.Receptor(0) = &H30& ' ASCII 0
        ChromaMeterCom.Receptor(1) = &H30& ' ASCII 0
        ChromaMeterCom.Command(0) = &H30&  ' ASCII 0
        ChromaMeterCom.Command(1) = &H38&  ' ASCII 8
        ChromaMeterCom.DATA4(0) = &H31&    ' ASCII 1
        ChromaMeterCom.DATA4(1) = &H32&    ' ASCII 2
        ChromaMeterCom.DATA4(2) = &H30&    ' ASCII 0
        ChromaMeterCom.DATA4(3) = &H30&    ' ASCII 0
        ChromaMeterCom.ETX = &H3&
        ChromaMeterCom.CR = &HD&
        ChromaMeterCom.LF = &HA&
    
        CalcBCC
        LMSendCom
        Sleep 100
        LMRecvCom
        RawColorTemp = Mid(Buffer, 16, 6)
        RawLux = Mid(Buffer, 10, 6)
        RetVar(0) = Val(Mid(RawLux, 2, 4)) * (10 ^ (Val(Mid(RawLux, 6, 1) - 4)))
        RetVar(1) = Val(Mid(RawColorTemp, 2, 4)) * (10 ^ (Val(Mid(RawColorTemp, 6, 1) - 4)))
        Text1.Text = CStr(RetVar(0)) + " Lx"
        Text2.Text = CStr(RetVar(1)) + " K"
        GetLux = RetVar
    Else
        Text1.Text = "Initialize Lux Meter"
    End If
End Function


Public Function LMSendCom()
    Buffer = Chr(ChromaMeterCom.STX) + Chr(ChromaMeterCom.Receptor(0)) + Chr(ChromaMeterCom.Receptor(1)) + Chr(ChromaMeterCom.Command(0)) + _
        Chr(ChromaMeterCom.Command(1)) + Chr(ChromaMeterCom.DATA4(0)) + Chr(ChromaMeterCom.DATA4(1)) + Chr(ChromaMeterCom.DATA4(2)) + Chr(ChromaMeterCom.DATA4(3)) + _
        Chr(ChromaMeterCom.ETX) + ChromaMeterCom.BCC + Chr(ChromaMeterCom.CR) + Chr(ChromaMeterCom.LF)
    
    MSComm1.Output = Buffer
    
End Function

Public Function LMRecvCom() As String
    Buffer = MSComm1.Input
End Function
    
Public Function InitChromaMeter() As Boolean

    If Not MSComm1.PortOpen Then
        MSComm1.CommPort = CommPort   'Port Number
        MSComm1.Settings = "9600,E,7,1" '9600 baud, even parity, 7 data, 1 stop bit
        MSComm1.InputLen = 0 'Read whole buffer when Input is used
        MSComm1.PortOpen = True 'Open the serial port
    End If
        
    'Define LM communication defaults
    ChromaMeterCom.STX = &H2&
    ChromaMeterCom.Receptor(0) = &H30& ' ASCII 0
    ChromaMeterCom.Receptor(1) = &H30& ' ASCII 0
    ChromaMeterCom.Command(0) = &H35&  ' ASCII 5
    ChromaMeterCom.Command(1) = &H34&  ' ASCII 4
    ChromaMeterCom.DATA4(0) = &H31&    ' ASCII 1
    ChromaMeterCom.DATA4(1) = &H20&    ' ASCII Space
    ChromaMeterCom.DATA4(2) = &H20&    ' ASCII Space
    ChromaMeterCom.DATA4(3) = &H20&    ' ASCII Space
    ChromaMeterCom.ETX = &H3&
    ChromaMeterCom.CR = &HD&
    ChromaMeterCom.LF = &HA&
    
    CalcBCC
    LMSendCom
    Sleep 80
    LMRecvCom
    
    If Mid(Buffer, 2, 7) = "0054   " Then
        ChromaMeterCom.Init = True
        Text1.Text = "Initialized"
        SimMode = False
    Else
        Text1.Text = "Could not Initialize"
        SimMode = True
    End If
    
End Function


Private Sub GetLux_Button_Click()
    Dim LuxVal As Variant
    ReDim LuxVal(0 To 1)
    
    LuxVal = GetLux
    'MsgBox (LuxVal(0))
    'MsgBox (LuxVal(1))
    
End Sub

Private Sub Initialize_Comm_Click()
    InitChromaMeter
    EnableChromaMeter
    SetEXT
End Sub





Private Sub UserControl_Initialize()
    ChromaMeterCom.Init = False
End Sub
