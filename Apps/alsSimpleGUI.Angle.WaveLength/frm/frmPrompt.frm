VERSION 5.00
Begin VB.Form frmPrompt 
   BorderStyle     =   3  'Fixed Dialog
   ClientHeight    =   1125
   ClientLeft      =   2760
   ClientTop       =   3750
   ClientWidth     =   6030
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   1125
   ScaleWidth      =   6030
   ShowInTaskbar   =   0   'False
   Begin VB.CommandButton CancelButton 
      Caption         =   "Cancel"
      Height          =   375
      Left            =   4680
      TabIndex        =   2
      Top             =   600
      Width           =   1215
   End
   Begin VB.CommandButton OKButton 
      Caption         =   "OK"
      Height          =   375
      Left            =   4680
      TabIndex        =   0
      Top             =   120
      Width           =   1215
   End
   Begin VB.Label lblPrompt 
      Height          =   855
      Left            =   240
      TabIndex        =   1
      Top             =   120
      Width           =   4335
   End
End
Attribute VB_Name = "frmPrompt"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Option Explicit

Dim done As Boolean

Private Sub OKButton_Click()
    done = True
    Hide
End Sub

Public Sub message(msg As String)
    If msg <> "" Then
        lblPrompt.Caption = msg
        Show
        done = False
        While Not done
            DoEvents
        Wend
    End If
End Sub
