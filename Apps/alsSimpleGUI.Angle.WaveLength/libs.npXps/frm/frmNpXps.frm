VERSION 5.00
Begin VB.Form frmNpXps 
   Caption         =   "Newport XPS"
   ClientHeight    =   3600
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   1560
   Icon            =   "frmNpXps.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   3600
   ScaleWidth      =   1560
   StartUpPosition =   3  'Windows Default
   Begin VB.CheckBox cbLoop 
      Caption         =   "Loop:Paused"
      Height          =   375
      Left            =   120
      Style           =   1  'Graphical
      TabIndex        =   1
      Top             =   3120
      Width           =   1215
   End
   Begin VB.Timer tmrLoop 
      Enabled         =   0   'False
      Interval        =   200
      Left            =   1680
      Top             =   240
   End
   Begin npXps.ucNPXPS ucNPXPS1 
      Height          =   2895
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   1335
      _ExtentX        =   2355
      _ExtentY        =   5106
   End
End
Attribute VB_Name = "frmNpXps"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub cbLoop_Click()
    If cbLoop.value = vbChecked Then
        cbLoop.Caption = "Loop:Running"
        tmrLoop.Enabled = True
    Else
        cbLoop.Caption = "Loop:Paused"
        tmrLoop.Enabled = False
    End If
End Sub

Private Sub tmrLoop_Timer()
    If ucNPXPS1.done Then
        tmrLoop.Enabled = False
        cbLoop.value = vbUnchecked
        cbLoop.Caption = "Loop:Done"
    Else
        ucNPXPS1.nextValue
    End If
End Sub
