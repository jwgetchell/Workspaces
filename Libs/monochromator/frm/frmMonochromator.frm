VERSION 5.00
Begin VB.Form frmMonochromator 
   Caption         =   "Instruments"
   ClientHeight    =   6660
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   4635
   Icon            =   "frmMonochromator.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   ScaleHeight     =   6660
   ScaleWidth      =   4635
   StartUpPosition =   3  'Windows Default
   Begin VB.Timer tmrSetWaveLength 
      Enabled         =   0   'False
      Interval        =   1000
      Left            =   4080
      Top             =   1440
   End
   Begin VB.CheckBox cbPoll 
      Caption         =   "ON"
      Height          =   495
      Left            =   2640
      Style           =   1  'Graphical
      TabIndex        =   1
      Top             =   120
      Width           =   495
   End
   Begin Application.ucMonochromator ucMonochromator1 
      Height          =   6735
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   4695
      _ExtentX        =   8281
      _ExtentY        =   11880
   End
End
Attribute VB_Name = "frmMonochromator"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim gHeight As Integer, gWidth As Integer

Public pOPM As clsPowerMeter

Public Function fwReady() As Boolean
    fwReady = ucMonochromator1.fwReady
End Function


Private Sub cbPoll_Click()
    If cbPoll.value = vbChecked Then
        cbPoll.caption = "OFF"
        tmrSetWaveLength.enabled = False
    Else
        cbPoll.caption = "ON"
        tmrSetWaveLength.enabled = True
    End If
End Sub

Private Sub Form_Activate()
    tmrSetWaveLength.enabled = False
End Sub

Private Sub Form_Deactivate()
    tmrSetWaveLength.enabled = True
End Sub

Private Sub Form_Load()
    gHeight = Height
    gWidth = Width
    ucMonochromator1.setStart (300)
    ucMonochromator1.setStop (1100)
    Set pOPM = New clsPowerMeter
End Sub

Private Sub Form_Resize()
    If WindowState <> vbMinimized Then
        Height = gHeight
        Width = gWidth
    End If
End Sub

Private Sub tmrSetWaveLength_Timer()
    gSetWaveLength = ucMonochromator1.getValue
End Sub

' +________+
' | Script |
' +¯¯¯¯¯¯¯¯+

Public Sub script(value As String)
    Dim widget As String
    Dim error As Long, iVal As Long
    Dim idx As Integer
    Dim dval As Double
        
repeat:    widget = lineArgs(value)
        
    Select Case widget
    
    Case "Gpib": ucMonochromator1.setGpib value
    Case "FWenable": ucMonochromator1.setFWenable value = 1
    Case "Dps": dval = value: ucMonochromator1.setVolts dval
    
    Case "", "#":
    Case Else: MsgBox ("??Script: ThorlabsAPT " & widget & " " & value)
    
    End Select
    
End Sub

