VERSION 5.00
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "comdlg32.ocx"
Begin VB.Form frmTest 
   Caption         =   "Plot"
   ClientHeight    =   5970
   ClientLeft      =   165
   ClientTop       =   735
   ClientWidth     =   7080
   Icon            =   "frmPlot.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   5970
   ScaleWidth      =   7080
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton Command1 
      Caption         =   "Command1"
      Height          =   255
      Left            =   5640
      TabIndex        =   21
      Top             =   480
      Width           =   1095
   End
   Begin plot.ucPlot ucPlot1 
      Height          =   2535
      Index           =   0
      Left            =   1680
      TabIndex        =   19
      Top             =   840
      Width           =   5295
      _ExtentX        =   9340
      _ExtentY        =   4471
      Caption         =   "Plot Captions"
      XaxisLabel      =   "nm"
      XaxisDataFormat =   "0"
      XaxisDataMin    =   "300"
      XaxisDataMax    =   "1100"
   End
   Begin VB.VScrollBar VScrAngle 
      Height          =   2175
      Left            =   120
      Max             =   50
      TabIndex        =   14
      Top             =   3600
      Width           =   255
   End
   Begin VB.VScrollBar VScrWaveLength 
      Height          =   2295
      Left            =   120
      Max             =   80
      TabIndex        =   12
      Top             =   960
      Width           =   255
   End
   Begin MSComDlg.CommonDialog CommonDialog1 
      Left            =   6000
      Top             =   0
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
   End
   Begin VB.CommandButton cmdLoop 
      Caption         =   "Loop:10"
      Enabled         =   0   'False
      Height          =   255
      Left            =   4560
      TabIndex        =   11
      Top             =   480
      Width           =   855
   End
   Begin VB.CommandButton cmdAppend 
      Caption         =   "Append"
      Enabled         =   0   'False
      Height          =   255
      Left            =   4560
      TabIndex        =   10
      Top             =   240
      Width           =   855
   End
   Begin VB.CommandButton cmdSave 
      Caption         =   "Save"
      Enabled         =   0   'False
      Height          =   255
      Left            =   4560
      TabIndex        =   9
      Top             =   0
      Width           =   855
   End
   Begin VB.Frame fmFileType 
      Caption         =   "FileType"
      Height          =   735
      Left            =   3360
      TabIndex        =   7
      Top             =   0
      Width           =   1215
      Begin VB.ComboBox cmbFileType 
         Height          =   315
         ItemData        =   "frmPlot.frx":6CFA
         Left            =   120
         List            =   "frmPlot.frx":6D07
         TabIndex        =   8
         Text            =   "nm"
         Top             =   360
         Width           =   975
      End
   End
   Begin VB.Frame fmScroll 
      Caption         =   "Scroll"
      Height          =   735
      Left            =   1920
      TabIndex        =   4
      Top             =   0
      Width           =   1335
      Begin VB.CheckBox cbRun 
         Caption         =   "Stop"
         Height          =   255
         Left            =   600
         Style           =   1  'Graphical
         TabIndex        =   6
         Top             =   120
         Width           =   615
      End
      Begin VB.ComboBox cmbScroll 
         Height          =   315
         ItemData        =   "frmPlot.frx":6D1E
         Left            =   240
         List            =   "frmPlot.frx":6D2B
         TabIndex        =   5
         Text            =   "None"
         Top             =   360
         Width           =   975
      End
   End
   Begin VB.Timer tmrPlot 
      Enabled         =   0   'False
      Interval        =   100
      Left            =   5520
      Top             =   0
   End
   Begin VB.Frame Frame2 
      Caption         =   "mant"
      Height          =   615
      Left            =   840
      TabIndex        =   2
      Top             =   0
      Width           =   975
      Begin VB.ComboBox cmbMant 
         Height          =   315
         ItemData        =   "frmPlot.frx":6D45
         Left            =   120
         List            =   "frmPlot.frx":6D6D
         TabIndex        =   3
         Text            =   "1"
         Top             =   240
         Width           =   735
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "exp"
      Height          =   615
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   735
      Begin VB.ComboBox cmbExp 
         Height          =   315
         ItemData        =   "frmPlot.frx":6D95
         Left            =   120
         List            =   "frmPlot.frx":6DBA
         TabIndex        =   1
         Top             =   240
         Width           =   495
      End
   End
   Begin plot.ucPlot ucPlot1 
      Height          =   2535
      Index           =   1
      Left            =   1680
      TabIndex        =   20
      Top             =   3360
      Width           =   5295
      _ExtentX        =   9340
      _ExtentY        =   4471
      Caption         =   "Plot Captions"
      XaxisLabel      =   "nm"
      XaxisDataFormat =   "0"
      XaxisDataMin    =   "300"
      XaxisDataMax    =   "1100"
   End
   Begin VB.Label lblWavelengthCenter 
      Caption         =   "Center="
      Height          =   255
      Left            =   480
      TabIndex        =   18
      Top             =   960
      Width           =   1215
   End
   Begin VB.Label lblAngleSum 
      Caption         =   "Sum="
      Height          =   255
      Left            =   480
      TabIndex        =   17
      Top             =   3360
      Width           =   1095
   End
   Begin VB.Label lblWavelengthSum 
      Caption         =   "Sum="
      Height          =   255
      Left            =   480
      TabIndex        =   16
      Top             =   720
      Width           =   975
   End
   Begin VB.Label lblAngle 
      Alignment       =   1  'Right Justify
      Caption         =   "-90"
      Height          =   255
      Left            =   0
      TabIndex        =   15
      Top             =   3360
      Width           =   375
   End
   Begin VB.Label lblWaveLength 
      Alignment       =   1  'Right Justify
      Caption         =   "1100"
      Height          =   255
      Left            =   0
      TabIndex        =   13
      Top             =   720
      Width           =   375
   End
   Begin VB.Menu mnuFile 
      Caption         =   "&File"
      Begin VB.Menu mnuOpen 
         Caption         =   "&Open"
         Shortcut        =   ^O
      End
      Begin VB.Menu mnuSave 
         Caption         =   "&Save"
         Shortcut        =   ^S
      End
      Begin VB.Menu mnuLoadCal 
         Caption         =   "&Load Cal"
         Shortcut        =   ^L
      End
   End
   Begin VB.Menu mnuHelp 
      Caption         =   "&Help"
      Begin VB.Menu mnuAbout 
         Caption         =   "&About"
      End
   End
End
Attribute VB_Name = "frmTest"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Option Explicit

Dim ucPlot_Width As Integer, ucPlot_Height As Integer

Dim minWidth As Integer, minHeight As Integer


Const pi2 As Double = 6.28318530717959

Const plotSize As Integer = 9 * 9
Dim Index As Integer
Dim plot0(1, plotSize - 1) As Double

Dim gScale As Double

Dim gFile As String

Const loopLen As Integer = 10
Dim gLoop
Dim loopEnabled As Boolean

Private Type pnt
    x As Double
    y As Double
End Type

Private Sub setScale()
    Dim exp As Double, mant As Double
    If (cmbExp.ListIndex >= 0) And (cmbMant.ListIndex >= 0) Then
        exp = cmbExp.ItemData(cmbExp.ListIndex): exp = 10# ^ exp
        mant = cmbMant.ItemData(cmbMant.ListIndex)
    gScale = exp * mant
    Else
        gScale = 1
    End If
    gScale = 0.99 * gScale
End Sub

Private Sub setPlotSize()
    ucPlot1(0).setPlotSize plotSize
    ucPlot1(1).setPlotSize plotSize
End Sub

Private Sub cbRun_Click()
    If cbRun.value = vbChecked Then
        cbRun.Caption = "Run"
        Index = 0
        setPlotSize
        tmrPlot.Enabled = True
    Else
        cbRun.Caption = "Stop"
        tmrPlot.Enabled = False
    End If
End Sub

Private Sub cmbExp_Click()
    setScale
End Sub

Private Sub cmbFileType_Click()
    Select Case cmbFileType.ListIndex
        Case 0: ucPlot1(0).setFileType (spectralResponse): ucPlot1(1).setFileType (spectralResponse)
        Case 1: ucPlot1(0).setFileType (radiationPattern): ucPlot1(1).setFileType (radiationPattern)
        Case 2: ucPlot1(0).setFileType (radiationResponse): ucPlot1(1).setFileType (radiationResponse)
    End Select
End Sub

Private Sub cmbMant_Click()
    setScale
End Sub

Private Sub cmbScroll_Click()
    Select Case cmbScroll.ListIndex
        Case 0: ucPlot1(0).setScrollType (scrollNone): ucPlot1(1).setScrollType (scrollNone)
        Case 1: ucPlot1(0).setScrollType (scrollRight): ucPlot1(1).setScrollType (scrollRight)
        Case 2: ucPlot1(0).setScrollType (scrollLeft): ucPlot1(1).setScrollType (scrollLeft)
    End Select
End Sub

Private Sub cmdLoop_Click()
    loopEnabled = True
    gLoop = loopLen
End Sub

Private Sub cmdSave_Click()
    ucPlot1(0).saveFile: ucPlot1(1).saveFile
End Sub

Private Sub cmdAppend_Click()
    ucPlot1(0).appendFile: ucPlot1(1).appendFile
End Sub

Private Sub Command1_Click()
    ucPlot1(0).writeExcel
End Sub

Private Sub Form_Load()
    Dim i As Integer
    ucPlot_Width = Width - ucPlot1(0).Width
    ucPlot_Height = Height - 2 * ucPlot1(0).Height
    minWidth = Width: minHeight = 5610
    
    For i = 0 To plotSize - 1
        plot0(0, i) = Cos((i - plotSize / 2) / plotSize * pi2 / 2)
        plot0(1, i) = (1# + Sin(11 * i / plotSize * pi2)) / 2
    Next i
    
    cmbExp.ListIndex = 4: cmbMant.ListIndex = 0: setScale
    
    tmrPlot.Interval = 100 * 9 / plotSize
    If tmrPlot.Interval < 1 Then tmrPlot.Interval = 1
    
    cmdLoop.Caption = "Loop: " & loopLen + 1
    
End Sub

Private Sub Form_Resize()
    If WindowState <> vbMinimized Then
        If Width < minWidth Then Width = minWidth
        If Height < minHeight Then Height = minHeight
        If Width > ucPlot_Width Then ucPlot1(0).Width = Width - ucPlot_Width
        If Height > ucPlot_Height Then ucPlot1(0).Height = (Height - ucPlot_Height) / 2
        ucPlot1(1).Top = ucPlot1(0).Top + ucPlot1(0).Height
        ucPlot1(1).Width = ucPlot1(0).Width: ucPlot1(1).Height = ucPlot1(0).Height
        lblAngle.Top = ucPlot1(1).Top
        VScrAngle.Top = ucPlot1(1).Top - (3360 - 3600)
        VScrAngle.Height = ucPlot1(1).Height - (2655 - 2295)
        VScrWaveLength.Height = VScrAngle.Height
    End If
End Sub

Private Sub mnuAbout_Click()
    frmAbout.Show
End Sub

Private Sub mnuOpen_Click()
    CommonDialog1.ShowOpen
    ucPlot1(0).openFile CommonDialog1.fileName
    
    ucPlot1(0).Caption = "Optical Response"
    ucPlot1(0).XaxisLabel = "nm"
    ucPlot1(0).XaxisDataMin = ucPlot1(0).getWavelengthMin
    ucPlot1(0).XaxisDataMax = ucPlot1(0).getWavelengthMax
    VScrWaveLength.max = ucPlot1(0).getAngleSize - 1
    VScrWaveLength.value = VScrWaveLength.max / 2
    
    ucPlot1(1).Caption = "Radial Response"
    ucPlot1(1).XaxisLabel = "degrees"
    ucPlot1(1).XaxisDataMin = ucPlot1(1).getAngleMin
    ucPlot1(1).XaxisDataMax = ucPlot1(1).getAngleMax
    VScrAngle.max = ucPlot1(0).getWavelengthSize - 1
    VScrAngle.value = VScrAngle.max / 2

End Sub
Private Sub mnuSave_Click()
    On Error GoTo errorExit
    CommonDialog1.ShowSave
    gFile = ""
    Open CommonDialog1.fileName For Output As #1
    Close #1
    gFile = CommonDialog1.fileName
    Caption = "Plot: " & gFile
    ucPlot1(0).setFile (gFile & "0.csv")
    ucPlot1(1).setFile (gFile & "1.csv")
    cmdSave.Enabled = True
    cmdAppend.Enabled = True
    cmdLoop.Enabled = True
End Sub

Private Sub tmrPlot_Timer()
    
    Dim idx As Integer: idx = (Index + gLoop) Mod (plotSize - 1): If idx < 0 Then idx = 0
    
    ucPlot1(0).plot gScale * plot0(0, idx)
    ucPlot1(1).plot gScale * plot0(1, idx) * plot0(0, idx)
        
    If loopEnabled Then
        If gLoop < 0 Then
            gLoop = 0
            loopEnabled = False
        Else
            If Index = (plotSize - 1) Then
                If gLoop = loopLen Then
                    ucPlot1(0).saveFile
                    ucPlot1(1).saveFile
                Else
                    ucPlot1(0).appendFile
                    ucPlot1(1).appendFile
                End If
                gLoop = gLoop - 1
                cmdLoop.Caption = "Loop: " & gLoop + 1
            End If
        End If
    End If

    Index = (Index + 1) Mod plotSize

End Sub

Private Sub VScrWaveLength_Click()
    VScrWaveLength_Change
End Sub
Private Sub VScrWaveLength_Change()
    lblWaveLength.Caption = VScrWaveLength.value * ucPlot1(0).getAngleStep + ucPlot1(0).getAngleMin
    ucPlot1(0).getWavelengthSweep (VScrWaveLength.value)
    lblWavelengthSum.Caption = "Sum=" & format(ucPlot1(0).getWavelengthSum, "0.0")
    lblWavelengthCenter.Caption = "Center=" & format(ucPlot1(0).getWavelengthCenter, "0.0")
End Sub

Private Sub VScrAngle_Click()
    VScrAngle_Change
End Sub
Private Sub VScrAngle_Change()
    lblAngle.Caption = VScrAngle.value * ucPlot1(0).getWavelengthStep + ucPlot1(0).getWavelengthMin
    ucPlot1(1).getAngleSweep (VScrAngle.value)
    lblAngleSum.Caption = "Sum=" & format(ucPlot1(1).getAngleSum, "0.0")
End Sub

