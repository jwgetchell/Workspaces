VERSION 5.00
Object = "{648A5603-2C6E-101B-82B6-000000000014}#1.1#0"; "MSCOMM32.ocx"
Begin VB.UserControl IslMSCommWrapper 
   ClientHeight    =   1785
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   3225
   ScaleHeight     =   1785
   ScaleWidth      =   3225
   Begin MSCommLib.MSComm MSComm1 
      Left            =   0
      Top             =   0
      _ExtentX        =   1005
      _ExtentY        =   1005
      _Version        =   393216
      DTREnable       =   -1  'True
   End
End
Attribute VB_Name = "IslMSCommWrapper"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Dim objMSCOMM As MSComm

Public Sub init(comportN As Integer)
    objMSCOMM.CommPort = comportN
    objMSCOMM.PortOpen = True
End Sub

Public Function readComm() As String
    read = objMSCOMM.Input
End Function

Public Sub writeComm(str As String)
    objMSCOMM.Output = str & Chr$(13)
End Sub

Private Sub UserControl_Initialize()
    Set objMSCOMM = Form1.MSComm1
End Sub

Private Sub UserControl_Terminate()
    objMSCOMM.PortOpen = False
End Sub
