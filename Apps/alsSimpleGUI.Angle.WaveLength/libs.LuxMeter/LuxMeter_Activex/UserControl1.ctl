VERSION 5.00
Object = "{648A5603-2C6E-101B-82B6-000000000014}#1.1#0"; "MSCOMM32.OCX"
Begin VB.UserControl UserControl1 
   ClientHeight    =   2025
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   2070
   ScaleHeight     =   2025
   ScaleWidth      =   2070
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
      DTREnable       =   -1  'True
   End
End
Attribute VB_Name = "UserControl1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
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


Public Function GetLux() As Double
    Dim RawLux As String
    Dim Lux As String
    
    If LuxMeterCom.Init Then
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
        GetLux = Lux
    Else
        Text1.Text = "Initialize Lux Meter"
    End If
End Function


Public Function LMSendCom()
    Buffer = Chr(LuxMeterCom.STX) + Chr(LuxMeterCom.Receptor(0)) + Chr(LuxMeterCom.Receptor(1)) + Chr(LuxMeterCom.Command(0)) + _
        Chr(LuxMeterCom.Command(1)) + Chr(LuxMeterCom.DATA4(0)) + Chr(LuxMeterCom.DATA4(1)) + Chr(LuxMeterCom.DATA4(2)) + Chr(LuxMeterCom.DATA4(3)) + _
        Chr(LuxMeterCom.ETX) + LuxMeterCom.BCC + Chr(LuxMeterCom.CR) + Chr(LuxMeterCom.LF)
    
    MSComm1.Output = Buffer
    
End Function

Public Function LMRecvCom() As String
    Buffer = MSComm1.Input
End Function
    
Public Function InitLuxMeter() As Boolean

    If Not MSComm1.PortOpen Then
        MSComm1.CommPort = 4   'Port Number
        MSComm1.Settings = "9600,E,7,1" '9600 baud, even parity, 7 data, 1 stop bit
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
        LuxMeterCom.Init = True
        Text1.Text = "Initialized"
        SimMode = False
    Else
        Text1.Text = "Could not Initialize"
        SimMode = True
    End If
    
End Function


Private Sub GetLux_Button_Click()
    Dim LuxVal As Long
    LuxVal = GetLux
    MsgBox (LuxVal)
End Sub

Private Sub Initialize_Comm_Click()
    InitLuxMeter
    EnableLuxMeter
End Sub

Private Sub UserControl_Initialize()
    LuxMeterCom.Init = False
End Sub
