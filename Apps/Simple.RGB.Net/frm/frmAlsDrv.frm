VERSION 5.00
Begin VB.Form frmAlsDrv 
   Caption         =   "AlsDrv"
   ClientHeight    =   4095
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   2580
   LinkTopic       =   "Form1"
   ScaleHeight     =   4095
   ScaleWidth      =   2580
   StartUpPosition =   3  'Windows Default
   Visible         =   0   'False
   WindowState     =   1  'Minimized
   Begin SimpleRGB.ucALSusb ucALSusb1 
      Height          =   3975
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   2415
      _ExtentX        =   4260
      _ExtentY        =   7011
   End
End
Attribute VB_Name = "frmAlsDrv"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public enableInvert As Integer

Private Sub Form_Load()
    'als.invertCompMSB = enableInvert * &H40
End Sub

