VERSION 5.00
Begin VB.Form frmHelp 
   Caption         =   "Setup Notes"
   ClientHeight    =   3195
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   4680
   Icon            =   "frmHelp.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   3195
   ScaleWidth      =   4680
   StartUpPosition =   3  'Windows Default
   Begin VB.TextBox tbSetupNotes 
      BeginProperty Font 
         Name            =   "Courier New"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   3015
      Left            =   120
      MultiLine       =   -1  'True
      TabIndex        =   0
      Text            =   "frmHelp.frx":0CCA
      Top             =   120
      Width           =   4455
   End
End
Attribute VB_Name = "frmHelp"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim tbSetupNotes_Width As Integer, tbSetupNotes_Height As Integer
Private Sub Form_Load()
    tbSetupNotes_Width = Width - tbSetupNotes.Width
    tbSetupNotes_Height = Height - tbSetupNotes.Height
    tbSetupNotes.text = "Setup Info"
    tbSetupNotes.text = tbSetupNotes.text & Chr$(13) & Chr$(10) & "----- ----"
    tbSetupNotes.text = tbSetupNotes.text & Chr$(13) & Chr$(10) & "Line2"
End Sub

Private Sub Form_Resize()
    tbSetupNotes.Width = Width - tbSetupNotes_Width
    tbSetupNotes.Height = Height - tbSetupNotes_Height
End Sub
