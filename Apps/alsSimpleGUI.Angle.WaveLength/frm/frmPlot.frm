VERSION 5.00
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "comdlg32.ocx"
Begin VB.Form frmPlot 
   Caption         =   "Plots"
   ClientHeight    =   10005
   ClientLeft      =   7350
   ClientTop       =   705
   ClientWidth     =   5220
   Icon            =   "frmPlot.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   10005
   ScaleWidth      =   5220
   Begin VB.Frame fmPlot 
      Caption         =   "Data:Sheet"
      Height          =   2175
      Index           =   3
      Left            =   0
      TabIndex        =   37
      Top             =   7800
      Width           =   5175
      Begin VB.Frame frmExcelExport 
         Caption         =   "X Sheet"
         Height          =   1095
         Index           =   3
         Left            =   120
         TabIndex        =   40
         Top             =   240
         Width           =   975
         Begin VB.VScrollBar VScrExcelDataSheetIndex 
            Height          =   255
            Index           =   3
            Left            =   120
            Max             =   300
            TabIndex        =   43
            Top             =   240
            Width           =   135
         End
         Begin VB.VScrollBar VScrExcelCol 
            Height          =   255
            Index           =   3
            Left            =   120
            Max             =   10
            Min             =   1
            TabIndex        =   42
            Top             =   720
            Value           =   1
            Width           =   135
         End
         Begin VB.VScrollBar VScrExcelRow 
            Height          =   255
            Index           =   3
            Left            =   120
            Min             =   1
            TabIndex        =   41
            Top             =   480
            Value           =   1
            Width           =   135
         End
         Begin VB.Label LblExcelDataSheetIndex 
            Caption         =   "data0"
            Height          =   255
            Index           =   3
            Left            =   360
            TabIndex        =   46
            Top             =   240
            Width           =   495
         End
         Begin VB.Label LblExcelCol 
            Caption         =   "col1"
            Height          =   255
            Index           =   3
            Left            =   360
            TabIndex        =   45
            Top             =   720
            Width           =   375
         End
         Begin VB.Label LblExcelRow 
            Caption         =   "row1"
            Height          =   255
            Index           =   3
            Left            =   360
            TabIndex        =   44
            Top             =   480
            Width           =   495
         End
      End
      Begin VB.Frame fmInput 
         Caption         =   "Input"
         Height          =   615
         Index           =   3
         Left            =   120
         TabIndex        =   38
         Top             =   1320
         Width           =   975
         Begin VB.ComboBox cmbInput 
            Height          =   315
            Index           =   3
            ItemData        =   "frmPlot.frx":6CFA
            Left            =   120
            List            =   "frmPlot.frx":6D07
            TabIndex        =   39
            Text            =   "ALS"
            Top             =   240
            Width           =   735
         End
      End
      Begin Application.ucPlot ucPlot1 
         Height          =   1815
         Index           =   3
         Left            =   1200
         TabIndex        =   50
         Top             =   240
         Width           =   3855
         _ExtentX        =   6800
         _ExtentY        =   3201
         Caption         =   "Plot Captions"
         XaxisLabel      =   "nm"
         XaxisDataFormat =   "0"
         XaxisDataMin    =   "300"
         XaxisDataMax    =   "1100"
      End
   End
   Begin VB.Frame fmPlot 
      Caption         =   "Data:Sheet"
      Height          =   2175
      Index           =   2
      Left            =   0
      TabIndex        =   27
      Top             =   5520
      Width           =   5175
      Begin VB.Frame fmInput 
         Caption         =   "Input"
         Height          =   615
         Index           =   2
         Left            =   120
         TabIndex        =   35
         Top             =   1320
         Width           =   975
         Begin VB.ComboBox cmbInput 
            Height          =   315
            Index           =   2
            ItemData        =   "frmPlot.frx":6D1A
            Left            =   120
            List            =   "frmPlot.frx":6D27
            TabIndex        =   36
            Text            =   "ALS"
            Top             =   240
            Width           =   735
         End
      End
      Begin VB.Frame frmExcelExport 
         Caption         =   "X Sheet"
         Height          =   1095
         Index           =   2
         Left            =   120
         TabIndex        =   28
         Top             =   240
         Width           =   975
         Begin VB.VScrollBar VScrExcelRow 
            Height          =   255
            Index           =   2
            Left            =   120
            Min             =   1
            TabIndex        =   31
            Top             =   480
            Value           =   1
            Width           =   135
         End
         Begin VB.VScrollBar VScrExcelCol 
            Height          =   255
            Index           =   2
            Left            =   120
            Max             =   10
            Min             =   1
            TabIndex        =   30
            Top             =   720
            Value           =   1
            Width           =   135
         End
         Begin VB.VScrollBar VScrExcelDataSheetIndex 
            Height          =   255
            Index           =   2
            Left            =   120
            Max             =   300
            TabIndex        =   29
            Top             =   240
            Width           =   135
         End
         Begin VB.Label LblExcelRow 
            Caption         =   "row1"
            Height          =   255
            Index           =   2
            Left            =   360
            TabIndex        =   34
            Top             =   480
            Width           =   495
         End
         Begin VB.Label LblExcelCol 
            Caption         =   "col1"
            Height          =   255
            Index           =   2
            Left            =   360
            TabIndex        =   33
            Top             =   720
            Width           =   375
         End
         Begin VB.Label LblExcelDataSheetIndex 
            Caption         =   "data0"
            Height          =   255
            Index           =   2
            Left            =   360
            TabIndex        =   32
            Top             =   240
            Width           =   495
         End
      End
      Begin Application.ucPlot ucPlot1 
         Height          =   1815
         Index           =   2
         Left            =   1200
         TabIndex        =   49
         Top             =   240
         Width           =   3855
         _ExtentX        =   6800
         _ExtentY        =   3201
         Caption         =   "Plot Captions"
         XaxisLabel      =   "nm"
         XaxisDataFormat =   "0"
         XaxisDataMin    =   "300"
         XaxisDataMax    =   "1100"
      End
   End
   Begin VB.Frame fmPlot 
      Caption         =   "Data:Sheet"
      Height          =   2175
      Index           =   1
      Left            =   0
      TabIndex        =   17
      Top             =   3240
      Width           =   5175
      Begin VB.Frame frmExcelExport 
         Caption         =   "X Sheet"
         Height          =   1095
         Index           =   1
         Left            =   120
         TabIndex        =   20
         Top             =   240
         Width           =   975
         Begin VB.VScrollBar VScrExcelDataSheetIndex 
            Height          =   255
            Index           =   1
            Left            =   120
            Max             =   300
            TabIndex        =   23
            Top             =   240
            Width           =   135
         End
         Begin VB.VScrollBar VScrExcelCol 
            Height          =   255
            Index           =   1
            Left            =   120
            Max             =   10
            Min             =   1
            TabIndex        =   22
            Top             =   720
            Value           =   1
            Width           =   135
         End
         Begin VB.VScrollBar VScrExcelRow 
            Height          =   255
            Index           =   1
            Left            =   120
            Min             =   1
            TabIndex        =   21
            Top             =   480
            Value           =   1
            Width           =   135
         End
         Begin VB.Label LblExcelDataSheetIndex 
            Caption         =   "data0"
            Height          =   255
            Index           =   1
            Left            =   360
            TabIndex        =   26
            Top             =   240
            Width           =   495
         End
         Begin VB.Label LblExcelCol 
            Caption         =   "col1"
            Height          =   255
            Index           =   1
            Left            =   360
            TabIndex        =   25
            Top             =   720
            Width           =   375
         End
         Begin VB.Label LblExcelRow 
            Caption         =   "row1"
            Height          =   255
            Index           =   1
            Left            =   360
            TabIndex        =   24
            Top             =   480
            Width           =   495
         End
      End
      Begin VB.Frame fmInput 
         Caption         =   "Input"
         Height          =   615
         Index           =   1
         Left            =   120
         TabIndex        =   18
         Top             =   1320
         Width           =   975
         Begin VB.ComboBox cmbInput 
            Height          =   315
            Index           =   1
            ItemData        =   "frmPlot.frx":6D3A
            Left            =   120
            List            =   "frmPlot.frx":6D47
            TabIndex        =   19
            Text            =   "ALS"
            Top             =   240
            Width           =   735
         End
      End
      Begin Application.ucPlot ucPlot1 
         Height          =   1815
         Index           =   1
         Left            =   1200
         TabIndex        =   48
         Top             =   240
         Width           =   3855
         _ExtentX        =   6800
         _ExtentY        =   3201
         Caption         =   "Plot Captions"
         XaxisLabel      =   "nm"
         XaxisDataFormat =   "0"
         XaxisDataMin    =   "300"
         XaxisDataMax    =   "1100"
      End
   End
   Begin VB.Frame fmPlot 
      Caption         =   "Data:Sheet"
      Height          =   2175
      Index           =   0
      Left            =   0
      TabIndex        =   3
      Top             =   960
      Width           =   5175
      Begin Application.ucPlot ucPlot1 
         Height          =   1815
         Index           =   0
         Left            =   1200
         TabIndex        =   47
         Top             =   240
         Width           =   3855
         _ExtentX        =   6800
         _ExtentY        =   3201
         Caption         =   "Plot Captions"
         XaxisLabel      =   "nm"
         XaxisDataFormat =   "0"
         XaxisDataMin    =   "300"
         XaxisDataMax    =   "1100"
      End
      Begin VB.Frame fmInput 
         Caption         =   "Input"
         Height          =   615
         Index           =   0
         Left            =   120
         TabIndex        =   15
         Top             =   1320
         Width           =   975
         Begin VB.ComboBox cmbInput 
            Height          =   315
            Index           =   0
            ItemData        =   "frmPlot.frx":6D5A
            Left            =   120
            List            =   "frmPlot.frx":6D67
            TabIndex        =   16
            Text            =   "ALS"
            Top             =   240
            Width           =   735
         End
      End
      Begin VB.Frame frmExcelExport 
         Caption         =   "X Sheet"
         Height          =   1095
         Index           =   0
         Left            =   120
         TabIndex        =   8
         Top             =   240
         Width           =   975
         Begin VB.VScrollBar VScrExcelRow 
            Height          =   255
            Index           =   0
            Left            =   120
            Min             =   1
            TabIndex        =   11
            Top             =   480
            Value           =   1
            Width           =   135
         End
         Begin VB.VScrollBar VScrExcelCol 
            Height          =   255
            Index           =   0
            Left            =   120
            Max             =   10
            Min             =   1
            TabIndex        =   10
            Top             =   720
            Value           =   1
            Width           =   135
         End
         Begin VB.VScrollBar VScrExcelDataSheetIndex 
            Height          =   255
            Index           =   0
            Left            =   120
            Max             =   300
            TabIndex        =   9
            Top             =   240
            Width           =   135
         End
         Begin VB.Label LblExcelRow 
            Caption         =   "row1"
            Height          =   255
            Index           =   0
            Left            =   360
            TabIndex        =   14
            Top             =   480
            Width           =   495
         End
         Begin VB.Label LblExcelCol 
            Caption         =   "col1"
            Height          =   255
            Index           =   0
            Left            =   360
            TabIndex        =   13
            Top             =   720
            Width           =   375
         End
         Begin VB.Label LblExcelDataSheetIndex 
            Caption         =   "data0"
            Height          =   255
            Index           =   0
            Left            =   360
            TabIndex        =   12
            Top             =   240
            Width           =   495
         End
      End
   End
   Begin VB.Frame fmPlots 
      Height          =   855
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   5175
      Begin VB.Frame fmScroll 
         Caption         =   "Scroll"
         Height          =   615
         Left            =   1080
         TabIndex        =   51
         Top             =   120
         Width           =   1095
         Begin VB.ComboBox cmbScroll 
            Height          =   315
            ItemData        =   "frmPlot.frx":6D7A
            Left            =   120
            List            =   "frmPlot.frx":6D87
            TabIndex        =   52
            Text            =   "None"
            Top             =   240
            Width           =   855
         End
      End
      Begin VB.VScrollBar VScrDevice 
         Height          =   255
         Left            =   3480
         TabIndex        =   6
         Top             =   480
         Width           =   135
      End
      Begin VB.Frame fmNplots 
         Caption         =   "#/Plots"
         Height          =   615
         Left            =   120
         TabIndex        =   1
         Top             =   120
         Width           =   855
         Begin VB.ComboBox cmdNplots 
            Height          =   315
            ItemData        =   "frmPlot.frx":6DA1
            Left            =   120
            List            =   "frmPlot.frx":6DB1
            TabIndex        =   2
            Text            =   "4"
            Top             =   240
            Width           =   615
         End
      End
      Begin MSComDlg.CommonDialog CommonDialog1 
         Left            =   4560
         Top             =   240
         _ExtentX        =   847
         _ExtentY        =   847
         _Version        =   393216
      End
      Begin VB.CommandButton cmdSend2Excel 
         Caption         =   "Send 2 Excel"
         Height          =   255
         Left            =   2280
         TabIndex        =   5
         Top             =   480
         Width           =   1095
      End
      Begin VB.CheckBox cbPlotOnOff 
         Caption         =   "On"
         Height          =   255
         Left            =   2880
         Style           =   1  'Graphical
         TabIndex        =   54
         Top             =   240
         Width           =   495
      End
      Begin VB.CommandButton cmdSync 
         Caption         =   "Sync"
         Height          =   255
         Left            =   2280
         TabIndex        =   53
         Top             =   240
         Width           =   615
      End
      Begin VB.Label lblDevice 
         Caption         =   "dev0"
         Height          =   255
         Left            =   3720
         TabIndex        =   7
         Top             =   480
         Width           =   495
      End
      Begin VB.Label lblExcelFile 
         Alignment       =   1  'Right Justify
         Caption         =   "FileName"
         Height          =   255
         Left            =   1080
         TabIndex        =   4
         Top             =   240
         Width           =   3975
      End
   End
   Begin VB.Menu mnuFile 
      Caption         =   "&File"
   End
End
Attribute VB_Name = "frmPlot"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim frmPlot_width As Integer
Dim frmPlot_height As Integer

Dim fmPlots_width As Integer
Dim lblExcelFile_width As Integer

Dim fmPlot_height As Integer
Dim fmPlot_top As Integer

Dim ucPlot1_width As Integer
Dim ucPlot1_height As Integer

Dim nPlots As Integer
Const maxPlot As Integer = 4
Dim clampProxPlot As Boolean

Public Function getDnum() As Long
    getDnum = VScrDevice.value
End Function

Public Sub resync()
    Dim i As Integer
    For i = 0 To nPlots - 1
        ucPlot1(i).resync
    Next i
End Sub

Public Sub setPlotSize(ByVal dataType As plotDataType, ByVal data As Integer, Optional ByVal instance As Integer = 1)
    Dim i As Integer, j As Integer
    For i = 0 To nPlots - 1
        If dataType = cmbInput(i).ListIndex Then
            j = j + 1
            If instance = j Then ucPlot1(i).setPlotSize data
        End If
    Next i
End Sub

Public Sub setProxPlotClampEnable(enable As Boolean)
    clampProxPlot = enable
End Sub

Public Sub plotData(dataType As plotDataType, ByVal data As Double, Optional instance As Integer = 1)
    Dim i As Integer, j As Integer
    If Not cbPlotOnOff.value = vbChecked Then
        For i = 0 To nPlots - 1
            If dataType = cmbInput(i).ListIndex Then
                j = j + 1
                If instance = j Then
                    If dataType = pdProx And clampProxPlot Then
                        If data >= 1 Then data = 0.999
                    End If
                    ucPlot1(i).plot data
                End If
            End If
        Next i
    End If
End Sub

Private Sub cbPlotOnOff_Click()
    If cbPlotOnOff.value Then
        cbPlotOnOff.caption = "Off"
    Else
        cbPlotOnOff.caption = "On"
    End If
    resync
End Sub

Private Sub cmbScroll_Click()
    Dim i As Integer
    
    For i = 0 To nPlots - 1: ucPlot1(i).setScrollType cmbScroll.ListIndex: Next i
    resync
End Sub

Private Sub cmdSync_Click()
    resync
End Sub

Private Sub Form_Load()
    Dim i As Integer
    
    setProxPlotClampEnable True

    frmPlot_width = Width
    frmPlot_height = Height / maxPlot
    
    nPlots = maxPlot
    
    fmPlots_width = Width - fmPlots.Width
    lblExcelFile_width = fmPlots.Width - lblExcelFile.Width
    fmPlot_height = Height - nPlots * fmPlot(0).Height
    
    ucPlot1_width = fmPlots.Width - ucPlot1(0).Width
    ucPlot1_height = fmPlot(0).Height - ucPlot1(0).Height
    
    Width = 2 * Width
    
    'setup defaults
    cmdNplots.ListIndex = 1
    cmbInput(0).ListIndex = 0
    For i = 1 To 3
        cmbInput(i).ListIndex = 2
        VScrExcelDataSheetIndex(i).value = i
    Next i
    
End Sub

Private Sub Form_Resize()
    Dim i As Integer
    If WindowState <> vbMinimized Then
    
        If Width < frmPlot_width Then Width = frmPlot_width
        If Height < frmPlot_height * nPlots Then Height = frmPlot_height * nPlots
        
        fmPlots.Width = Width - fmPlots_width
        lblExcelFile.Width = fmPlots.Width - lblExcelFile_width
        
        For i = 0 To maxPlot - 1
            fmPlot(i).Visible = (i < nPlots)
        Next i
        
        For i = 0 To nPlots - 1
            fmPlot(i).Width = fmPlots.Width
            fmPlot(i).Height = (Height - fmPlot_height) / nPlots
            If i > 0 Then
                fmPlot(i).Top = fmPlot(i - 1).Top + fmPlot(i - 1).Height
            End If
            ucPlot1(i).Width = fmPlot(i).Width - ucPlot1_width
            ucPlot1(i).Height = fmPlot(i).Height - ucPlot1_height
        Next i
        
    End If
End Sub

Private Sub cmdNplots_Click()
    Dim i As Integer
    nPlots = cmdNplots.ListIndex + 1
    Form_Resize
    resync
End Sub

Public Sub send2excel(Optional dnum As Integer = -1, Optional sheet As Integer = -1)
    If sheet > -1 Then VScrExcelDataSheetIndex(0).value = sheet
    If dnum >= 0 Then VScrDevice.value = dnum
    cmdSend2Excel_Click
End Sub

Public Sub setSheetNumber(plotN As Integer, sheetN As Integer)
    VScrExcelDataSheetIndex(plotN).value = sheetN
End Sub

Public Sub cmdSend2Excel_Click()
    Dim i As Integer
    
    ucPlot1(0).openExcelFile (lblExcelFile.caption)
    ucPlot1(0).setExcelDeviceNumber (VScrDevice.value)
    ucPlot1(0).setExcelColNumber (VScrExcelCol(0).value) ' JWG kludge
    ucPlot1(0).setExcelRowNumber (VScrExcelRow(0).value)
    
    For i = 0 To nPlots - 1
        ucPlot1(i).writeExcel (VScrExcelDataSheetIndex(i).value)
    Next i
    
    VScrDevice.value = VScrDevice.value + 1
    
End Sub

Private Sub mnuFile_Click()
    CommonDialog1.ShowOpen
    lblExcelFile.caption = CommonDialog1.fileName
    gExcelFile = ""
    ucPlot1(0).openExcelFile (lblExcelFile.caption)
End Sub

Public Sub selectDevice(dut As Integer)
    VScrDevice.value = dut
End Sub

Private Sub VScrDevice_Change()
    lblDevice.caption = "dev" & VScrDevice.value
End Sub

Private Sub VScrExcelDataSheetIndex_Change(Index As Integer)
    LblExcelDataSheetIndex(Index).caption = "data" & VScrExcelDataSheetIndex(Index).value
End Sub

Private Sub VScrExcelCol_Change(Index As Integer)
    VScrExcelCol(Index).max = 1000
    LblExcelCol(Index).caption = "col" & VScrExcelCol(Index).value
End Sub

Private Sub VScrExcelRow_Change(Index As Integer)
    VScrExcelRow(Index).max = 32767
    LblExcelRow(Index).caption = "row" & VScrExcelRow(Index).value
End Sub

' +________+
' | Script |
' +¯¯¯¯¯¯¯¯+

Public Sub script(value As String)
    Dim widget As String
    Dim error As Long, iVal As Long
    Dim idx As Integer
        
repeat:    widget = lineArgs(value)
        
    Select Case widget
    
    Case "Nplots": If setCmb(cmdNplots, value) Then cmdNplots_Click
    Case "Device": VScrDevice.value = value
    
    Case "0", "1", "3": idx = widget
    
    Case "Input": If setCmb(cmbInput(idx), value) Then cmdNplots_Click
    Case "Data": VScrExcelDataSheetIndex(idx).value = value
    Case "Row": VScrExcelRow(idx).value = value
    Case "Col": VScrExcelCol(idx).value = value
    
    Case "FileOpen": lblExcelFile.caption = Environ$("VBscriptDIR") & "\" & value
    
    Case "", "#":
    Case Else: MsgBox ("??Script: Plot " & widget & " " & value)
    
    End Select
    
End Sub

