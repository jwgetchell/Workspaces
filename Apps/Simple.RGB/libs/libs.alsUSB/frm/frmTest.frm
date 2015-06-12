VERSION 5.00
Begin VB.Form frmTest 
   Caption         =   "Test"
   ClientHeight    =   4095
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   3615
   Icon            =   "frmTest.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   4095
   ScaleWidth      =   3615
   StartUpPosition =   3  'Windows Default
   Begin VB.Timer tmrReadAlsPrx 
      Enabled         =   0   'False
      Interval        =   100
      Left            =   2160
      Top             =   3240
   End
   Begin alsUSB.ucALSusb ucALSusb1 
      Height          =   4095
      Left            =   0
      TabIndex        =   2
      Top             =   0
      Width           =   1935
      _ExtentX        =   3413
      _ExtentY        =   7223
   End
   Begin VB.Frame frmAddr 
      Caption         =   "Address"
      Height          =   1215
      Left            =   2160
      TabIndex        =   0
      Top             =   0
      Width           =   1215
      Begin VB.CheckBox cbPoll 
         Caption         =   "Poll"
         Height          =   255
         Left            =   600
         Style           =   1  'Graphical
         TabIndex        =   10
         Top             =   840
         Width           =   495
      End
      Begin VB.OptionButton rbAddr 
         Caption         =   "8A"
         Height          =   195
         Index           =   1
         Left            =   120
         TabIndex        =   8
         Top             =   840
         Width           =   495
      End
      Begin VB.OptionButton rbAddr 
         Caption         =   "88"
         Height          =   195
         Index           =   0
         Left            =   120
         TabIndex        =   7
         Top             =   600
         Width           =   495
      End
      Begin VB.CheckBox cbAddr 
         Caption         =   "0x88"
         Enabled         =   0   'False
         Height          =   255
         Left            =   120
         Style           =   1  'Graphical
         TabIndex        =   1
         Top             =   240
         Width           =   495
      End
   End
   Begin VB.Timer tmrReadPanel 
      Enabled         =   0   'False
      Interval        =   100
      Left            =   2160
      Top             =   2760
   End
   Begin VB.Frame fmMeasure 
      Caption         =   "Measure"
      Height          =   1335
      Left            =   2160
      TabIndex        =   3
      Top             =   1320
      Width           =   1455
      Begin VB.CheckBox cbStateOff 
         Caption         =   "State:ON"
         Height          =   255
         Left            =   120
         Style           =   1  'Graphical
         TabIndex        =   6
         Top             =   240
         Width           =   975
      End
      Begin VB.Label lblData 
         Caption         =   "lblData"
         Height          =   255
         Left            =   120
         TabIndex        =   9
         Top             =   960
         Width           =   1215
      End
      Begin VB.Label lblLux 
         Caption         =   "lblLux"
         Height          =   255
         Left            =   120
         TabIndex        =   5
         Top             =   480
         Width           =   1215
      End
      Begin VB.Label lblProximity 
         Caption         =   "lblProximity"
         Height          =   255
         Left            =   120
         TabIndex        =   4
         Top             =   720
         Width           =   1215
      End
   End
End
Attribute VB_Name = "frmTest"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim i2cAddr As Long

Private Sub cbAddr_Click()
    If cbAddr.value = vbChecked Then
        cbAddr.caption = "0x8A": i2cAddr = &H8A
    Else
        cbAddr.caption = "0x88": i2cAddr = &H88
    End If
End Sub

Private Sub cbPoll_Click()
    If cbPoll.value = vbChecked Then
        cbPoll.caption = "nPoll"
    Else
        cbPoll.caption = "Poll"
    End If

End Sub

Private Sub rbAddr_Click(Index As Integer)
        Call ucALSusb1.setHwnd(Me.hWnd)
        Call ucALSusb1.setI2cAddr(&H88 + 2 * Index)
        Me.caption = ucALSusb1.getUSBcaption()
        tmrReadPanel.Enabled = True
End Sub

Private Sub cbStateOff_Click()
    If cbStateOff.value Then
        cbStateOff.caption = "State:OFF"
        tmrReadPanel.Enabled = True
        tmrReadAlsPrx.Enabled = False
    Else
        cbStateOff.caption = "State:ON"
        tmrReadPanel.Enabled = False
        tmrReadAlsPrx.Enabled = True
    End If
End Sub

Private Sub handleError(error As String)
    Static errorCount As Integer
    MsgBox (error)
    errorCount = errorCount + 1
    If errorCount >= 5 Then End
End Sub

Private Sub Form_Load()
    cbAddr_Click
    Call ucALSusb1.setHwnd(Me.hWnd)
End Sub

Private Sub getProximity()
    Dim proximity As Double, data As Long
    
    On Error GoTo errorExit
    If ucALSusb1.CdllGetProximity(proximity) Then
        handleError (ucALSusb1.getError())
        lblProximity.caption = "Proximity=ERROR"
        GoTo errorExit
    Else
        lblProximity.caption = "Proximity=" & Format(proximity, "##0.000")
    End If
        
    If ucALSusb1.CdllGetData(0, data) Then
        handleError (ucALSusb1.getError())
        lblData.caption = "Data=ERROR"
        GoTo errorExit
    Else
        lblData.caption = "Data=" & Format(data, "####0")
    End If
errorExit:
End Sub

Private Sub tmrReadAlsPrx_Timer()
    Dim lux As Double
    Dim data As Long
    
    On Error GoTo errorExit
    'GoTo getProx
    If ucALSusb1.CdllGetLux(lux) Then
        handleError (ucALSusb1.getError())
        lblLux.caption = "Lux=ERROR"
        GoTo errorExit
    Else
        lblLux.caption = "Lux=" & Format(lux, "####0.0")
    End If
getProx:
    getProximity
                
    If cbPoll.value = vbUnchecked Then ucALSusb1.update
    
errorExit:
End Sub

Private Sub tmrReadPanel_Timer()
    Dim lux As Double, proximity As Double
    Dim enable As Long, nChan As Long, Ndevices As Long, deviceN As Long
    Dim data As Long, resolution As Long, ambRej As Long
    
    On Error GoTo errorExit
    
    ' check for loaded device
    If ucALSusb1.CdllGetNdevice(Ndevices) Then handleError (ucALSusb1.getError()): GoTo errorExit
    If ucALSusb1.CdllGetDevice(deviceN) Then handleError (ucALSusb1.getError()): GoTo errorExit
    If deviceN = Ndevices Then GoTo exitSub
    
    ' get enable chan0
    If ucALSusb1.CdllGetEnable(0, enable) Then handleError (ucALSusb1.getError()): GoTo errorExit
    
    If enable Then
        If cbStateOff.value Then
            lux = 0
        Else
            If ucALSusb1.CdllGetLux(lux) Then handleError (ucALSusb1.getError()): GoTo errorExit
        End If
        
        lblLux.caption = "Lux=" & Format(lux, "####0.0")
        tmrReadPanel.Interval = 100
    Else
        lblLux.caption = ""
        tmrReadPanel.Interval = 20
    End If
    
    ' get #/channels
    If ucALSusb1.CdllGetNchannel(nChan) Then handleError (ucALSusb1.getError()): GoTo errorExit
    
    If nChan = 2 Then

        ' get enable chan1
        If ucALSusb1.CdllGetEnable(1, enable) Then handleError (ucALSusb1.getError()): GoTo errorExit
        
        If enable Then ' include 29011
            If cbStateOff.value Then
                If ucALSusb1.CdllGetData(0, data) Then handleError (ucALSusb1.getError()): GoTo errorExit
                proximity = 2# * data / 65535 - 1#
                lblData.caption = "Data=" & Format(data, "####0")
            Else
                If ucALSusb1.CdllGetProximity(proximity) Then handleError (ucALSusb1.getError()): GoTo errorExit
            End If
            lblProximity.caption = "Proximity=" & Format(proximity, "##0.000")
        Else
            lblProximity.caption = ""
        End If
        
    Else
        If deviceN = 0 Then ' x11
            If cbStateOff.value Then
                If ucALSusb1.CdllGetData(0, data) Then handleError (ucALSusb1.getError()): GoTo errorExit
                If ucALSusb1.CdllGetResolution(0, resolution) Then handleError (ucALSusb1.getError()): GoTo errorExit
                If ucALSusb1.CdllGetProxAmbRej(ambRej) Then handleError (ucALSusb1.getError()): GoTo errorExit
                lblData.caption = "Data=" & Format(data, "####0")
                If ambRej Then
                    proximity = 2# * data / 16 ^ (4 - resolution) - 1#
                Else
                    proximity = data / 16 ^ (4 - resolution)
                End If
            Else
                If ucALSusb1.CdllGetProximity(proximity) Then handleError (ucALSusb1.getError()): GoTo errorExit
            End If
            lblProximity.caption = "Proximity=" & Format(proximity, "##0.000")
        Else
            lblProximity.caption = ""
        End If
    End If
    
    GoTo exitSub
    
errorExit:
    handleError ("Error in frmTest.Timer1_Timer")
exitSub:
    ucALSusb1.update
End Sub
