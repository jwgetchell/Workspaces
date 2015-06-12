VERSION 5.00
Begin VB.UserControl ucPlot 
   ClientHeight    =   3810
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   5010
   Picture         =   "ucPlot.ctx":0000
   ScaleHeight     =   3810
   ScaleWidth      =   5010
   Begin VB.Frame fPlot 
      Caption         =   "Plot Captions"
      Height          =   3735
      Left            =   0
      TabIndex        =   1
      Top             =   0
      Width           =   4935
      Begin VB.PictureBox pbPlotFrame 
         AutoRedraw      =   -1  'True
         BackColor       =   &H00000000&
         Height          =   2535
         Index           =   0
         Left            =   840
         ScaleHeight     =   2475
         ScaleWidth      =   3555
         TabIndex        =   2
         Top             =   360
         Width           =   3615
      End
      Begin VB.PictureBox pbPlotFrame 
         AutoRedraw      =   -1  'True
         BackColor       =   &H00000000&
         Height          =   2535
         Index           =   1
         Left            =   840
         ScaleHeight     =   2475
         ScaleWidth      =   3555
         TabIndex        =   9
         Top             =   360
         Width           =   3615
      End
      Begin VB.Label lblXaxisLbl 
         Alignment       =   2  'Center
         Caption         =   "nm"
         Height          =   255
         Left            =   1920
         TabIndex        =   8
         Top             =   3360
         Width           =   1095
      End
      Begin VB.Label lblYval 
         Alignment       =   1  'Right Justify
         Caption         =   "8.88"
         Height          =   255
         Index           =   2
         Left            =   120
         TabIndex        =   7
         Top             =   240
         Width           =   615
      End
      Begin VB.Label lblYval 
         Alignment       =   1  'Right Justify
         Caption         =   "8.88"
         Height          =   255
         Index           =   1
         Left            =   120
         TabIndex        =   6
         Top             =   1440
         Width           =   615
      End
      Begin VB.Label lblYval 
         Alignment       =   1  'Right Justify
         Caption         =   "0.00"
         Height          =   255
         Index           =   0
         Left            =   120
         TabIndex        =   0
         Top             =   2760
         Width           =   615
      End
      Begin VB.Label lblXval 
         Alignment       =   2  'Center
         Caption         =   "1100"
         Height          =   255
         Index           =   2
         Left            =   4200
         TabIndex        =   5
         Top             =   3000
         Width           =   375
      End
      Begin VB.Label lblXval 
         Alignment       =   2  'Center
         Caption         =   "700"
         Height          =   255
         Index           =   1
         Left            =   2280
         TabIndex        =   4
         Top             =   3000
         Width           =   375
      End
      Begin VB.Label lblXval 
         Alignment       =   2  'Center
         Caption         =   "300"
         Height          =   255
         Index           =   0
         Left            =   600
         TabIndex        =   3
         Top             =   3000
         Width           =   375
      End
   End
End
Attribute VB_Name = "ucPlot"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

' _______________
' Graphics sizing
' ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
Dim fPlot_Width As Integer, fPlot_Height As Integer
Dim pbPlot_Width As Integer, pbPlot_Height As Integer
Dim lblXval_Top As Integer, lblYval_Top As Integer, lblXval_Left As Integer
Dim lblXaxisLbl_Left As Integer, lblXaxisLbl_Top As Integer

Private m_dataSize As Integer
Private m_yAxisRange As Double

Private gXaxisDataFormat As String

Private gYaxisDataFormat As String
Private gYaxisLabel As String

Private Type t_dataInfo
    dMin As Double
    dMax As Double
    pMin As Long
    pMax As Long
    m As Double
    B As Double
End Type

Private Type t_axisInfo
    x As t_dataInfo
    y As t_dataInfo
End Type

Public Enum e_scroll
    scrollNone
    scrollRight
    scrollLeft
End Enum

Dim m_scroll As e_scroll

Dim m_dataInfo As t_axisInfo
Dim m_dataSet As Boolean
Dim m_event As String
Dim m_index As Integer
Dim m_thisIndex As Integer
Dim m_aryBuf() As Double

Dim dPtr As Long

Dim gWavelengthSum As Double
Dim gWavelengthCenter As Double
Dim gAngleSum As Double

Private Declare Sub memcpy Lib "kernel32" Alias "RtlMoveMemory" ( _
                   ByRef hpvDest As Any, _
                   ByRef hpvSource As Any, _
                   ByVal cbCopy As Long)

Private Declare Sub Sleep Lib "kernel32" (ByVal dwMilliseconds As Long)

Public Enum fileType
    spectralResponse
    radiationPattern
    radiationResponse
End Enum

Private gFileType As fileType

Private gStart As Single
Private gStop As Single
Private gStep As Single

Private gXstart As Single
Private gXstop As Single
Private gXstep As Single

Private gPrompt4device As Boolean
Private gDirectory As String
Private gFile As String
Private gDirectoryFile As String

Private gInputFileNum As Integer
Private gOutputFileNum As Integer

Private gSheetName As String

Public Sub setExcelSheetName(sheetName As String)
    gSheetName = sheetName
End Sub


Public Sub resync()
    m_index = 0: dPtr = 0
End Sub
Sub initExcel()
    On Error GoTo newObject
    If oExcel Is Nothing Then
        Set oExcel = CreateObject("Excel.Application")
    Else
    End If
    'If oExcel.Name = "Microsoft Excel" Then GoTo exitSub
newObject:
    'Set oExcel = CreateObject("Excel.Application")
exitSub:
End Sub

Public Sub setExcelDeviceNumber(deviceNumber As Integer)
    gDeviceNumber = deviceNumber
End Sub

Public Sub setExcelColNumber(col As Integer)
    gExcelLeft = col
End Sub

Public Sub setExcelRowNumber(row As Integer)
    gExcelTop = row
End Sub

Public Sub openExcelFile(fileName As String)
Static lastFileName As String
On Error GoTo errorExit

    If gExcelFile = lastFileName And lastFileName <> "" Then
        GoTo normalExit
    End If
    
    initExcel
    Set oBook = oExcel.Workbooks.Open(fileName)
    oExcel.Application.Visible = True
    gExcelFile = fileName
    
    GoTo normalExit
errorExit:
    MsgBox ("Error opening/initializing Excel File")
normalExit:
    lastFileName = fileName
End Sub

Public Sub writeExcel(sheetN As Integer)
    Dim i As Integer, col As Integer, A0 As Integer, A1 As Integer
    Dim cell As String
    
    If gExcelFile <> "" Then
    
        Set oSheet = oBook.Worksheets(gSheetName & sheetN)
        
        For i = 0 To m_dataSize - 1
            col = gExcelLeft + gDeviceNumber
            If col < 26 Then
                cell = Chr$(Asc("A") + col) & (1 + i + gExcelTop)
            Else
                A0 = col Mod 26
                A1 = (col - A0) / 26 - 1
                cell = Chr$(Asc("A") + A1) & Chr$(Asc("A") + A0) & (1 + i + gExcelTop)
            End If
            oSheet.range(cell).value = m_aryBuf(i * 2 + 1)
        Next i
        
        oBook.Worksheets.Application.Calculate
        oBook.Save
        
    End If

GoTo skip
    oBook.Save
    oBook.Close
    oExcel.Quit
skip:
End Sub

Public Sub plot(ByVal p As Double)

    m_aryBuf(2 * m_index + 1) = p
    
    Select Case m_scroll
    Case scrollRight: dPtr = (dPtr - 1) Mod m_dataSize
    Case scrollLeft: dPtr = (dPtr + 1) Mod m_dataSize
    End Select
    
    If dPtr < 0 Then dPtr = m_dataSize - 1
    
    setData
    draw
    'm_index = (m_index + 1) Mod m_dataSize
    
    Select Case m_scroll
    Case scrollRight: m_index = (m_index - 1) Mod m_dataSize
    Case Else: m_index = (m_index + 1) Mod m_dataSize
    End Select
    
    If m_index < 0 Then m_index = m_dataSize - 1
    
End Sub

Public Sub setScrollType(scrollType As e_scroll)
    m_scroll = scrollType
End Sub

Public Function getScrollType() As e_scroll
    getScrollType = m_scroll
End Function

Public Sub setPlotSize(ByVal size As Integer)
    Dim i As Integer
    ReDim m_aryBuf(2 * size - 1)
    For i = 0 To size - 1
        m_aryBuf(2 * i) = i
    Next i
    m_dataSize = size
    m_index = 0
    dPtr = 0
End Sub

Public Function getPlotSize() As Integer
    getPlotSize = m_dataSize
End Function

Private Sub setStartStep()
    If gStep = 0 Then
        If gStop = 0 Then
            gStop = m_dataSize - 1
        End If
        gStep = (gStop - gStep) / (m_dataSize - 1)
    End If
    If gXstep = 0 Then
        If gXstop = 0 Then
            gXstop = m_dataSize - 1
        End If
        gXstep = (gXstop - gXstep) / (m_dataSize - 1)
    End If
End Sub


Private Sub YaxisMax(ByVal max As Double)

    Dim exp As Integer
    m_yAxisRange = 1
    If max = 0 Then max = 1
    
    If max < 1# Then
        Do
            max = max * 1000#
            exp = exp - 1
        Loop Until max > 1#
    Else
        If max > 1000# Then
            Do
                max = max / 1000#
                exp = exp + 1
            Loop Until max < 1000#
        End If
    End If
    
    exp = 3 * exp
    
    If max > 500 Then
            m_yAxisRange = 1000# * m_yAxisRange: gYaxisDataFormat = "000"
        Else
        If max > 200 Then
            m_yAxisRange = 500# * m_yAxisRange: gYaxisDataFormat = "000"
        Else
        If max > 100 Then
            m_yAxisRange = 200# * m_yAxisRange: gYaxisDataFormat = "000"
        Else
        If max > 50 Then
            m_yAxisRange = 100# * m_yAxisRange: gYaxisDataFormat = "00.0"
        Else
        If max > 20 Then
            m_yAxisRange = 50# * m_yAxisRange: gYaxisDataFormat = "00.0"
        Else
        If max > 10 Then
            m_yAxisRange = 20# * m_yAxisRange: gYaxisDataFormat = "00.0"
        Else
        If max > 5 Then
            m_yAxisRange = 10# * m_yAxisRange: gYaxisDataFormat = "0.00"
        Else
        If max > 2 Then
            m_yAxisRange = 5# * m_yAxisRange: gYaxisDataFormat = "0.00"
        Else
            m_yAxisRange = 2# * m_yAxisRange: gYaxisDataFormat = "0.00"
    End If: End If: End If: End If: End If: End If: End If: End If
    
    Select Case exp
    Case -15: gYaxisDataFormat = gYaxisDataFormat & "f"
    Case -12: gYaxisDataFormat = gYaxisDataFormat & "p"
    Case -9: gYaxisDataFormat = gYaxisDataFormat & "n"
    Case -6: gYaxisDataFormat = gYaxisDataFormat & "u"
    Case -3: gYaxisDataFormat = gYaxisDataFormat & "m"
    Case 3: gYaxisDataFormat = gYaxisDataFormat & "k"
    Case 6: gYaxisDataFormat = gYaxisDataFormat & "M"
    Case 9: gYaxisDataFormat = gYaxisDataFormat & "G"
    Case 12: gYaxisDataFormat = gYaxisDataFormat & "T"
    End Select
    
    lblYval(2).caption = format(m_yAxisRange, gYaxisDataFormat)
    lblYval(1).caption = format(m_yAxisRange / 2, gYaxisDataFormat)
    lblYval(0).caption = format(0#, gYaxisDataFormat)
    
    m_yAxisRange = m_yAxisRange * 10 ^ exp

End Sub

Private Sub UserControl_Initialize()

    m_thisIndex = gNplots: gNplots = gNplots + 1
    
    fPlot_Width = Width - fPlot.Width: fPlot_Height = Height - fPlot.Height
    
    pbPlot_Width = fPlot.Width - pbPlotFrame(0).Width: pbPlot_Height = fPlot.Height - pbPlotFrame(0).Height
    
    lblXval_Left = fPlot.Width - lblXval(2).Left
    lblXval_Top = fPlot.Height - lblXval(0).Top
    
    lblYval_Top = fPlot.Height - lblYval(0).Top
    
    Dim i As Integer
    For i = 1 To 2: lblXval(i).Top = lblXval(0).Top: Next i
    For i = 1 To 2: lblYval(i).Left = lblYval(0).Left: Next i
    
    lblXval(1).Left = (lblXval(2).Left + lblXval(0).Left) / 2
    lblYval(1).Top = (lblYval(2).Top + lblYval(0).Top) / 2
    
    lblXaxisLbl_Left = lblXval(1).Left - lblXaxisLbl.Left
    lblXaxisLbl_Top = lblXval(1).Top - lblXaxisLbl.Top
    
    gXaxisDataFormat = "0"
    
    setPlotSize (100)
    
    setFileType (spectralResponse)
    
    gExcelLeft = cExcelLeft
    gExcelTop = cExcelTop
    
    gSheetName = "data"
    
End Sub




Private Sub UserControl_Resize()

    If Width > fPlot_Width Then fPlot.Width = Width - fPlot_Width
    If Height > fPlot_Height Then fPlot.Height = Height - fPlot_Height
    
    If fPlot.Width > pbPlot_Width Then pbPlotFrame(0).Width = fPlot.Width - pbPlot_Width
    If fPlot.Height > pbPlot_Height Then pbPlotFrame(0).Height = fPlot.Height - pbPlot_Height
    pbPlotFrame(1).Width = pbPlotFrame(0).Width: pbPlotFrame(1).Height = pbPlotFrame(0).Height
    
    If fPlot.Width > lblXval_Left Then lblXval(2).Left = fPlot.Width - lblXval_Left
    If fPlot.Height > lblXval_Top Then lblXval(0).Top = fPlot.Height - lblXval_Top
    
    If fPlot.Height > lblYval_Top Then lblYval(0).Top = fPlot.Height - lblYval_Top
    
    lblXval(1).Left = (lblXval(2).Left + lblXval(0).Left) / 2
    lblYval(1).Top = (lblYval(2).Top + lblYval(0).Top) / 2
    
    Dim i As Integer
    For i = 1 To 2: lblXval(i).Top = lblXval(0).Top: Next i
    
    If lblXval(1).Left > lblXaxisLbl_Left Then lblXaxisLbl.Left = lblXval(1).Left - lblXaxisLbl_Left
    If lblXval(1).Top > lblXaxisLbl_Top Then lblXaxisLbl.Top = lblXval(1).Top - lblXaxisLbl_Top
    
    draw
    
End Sub

Private Sub setData()

    Dim i As Long
    
    ' x values are ordered
    m_dataInfo.x.dMin = m_aryBuf(2 * 0 + 0)
    m_dataInfo.x.dMax = m_aryBuf(2 * (m_dataSize - 1) + 0)
    
    m_dataInfo.y.dMin = m_aryBuf(2 * 0 + 1)
    m_dataInfo.y.dMax = m_aryBuf(2 * 0 + 1)
    
    For i = 1 To m_dataSize - 1
        If (m_dataInfo.y.dMin > m_aryBuf(2 * i + 1)) Then
            m_dataInfo.y.dMin = m_aryBuf(2 * i + 1)
        Else
            If (m_dataInfo.y.dMax < m_aryBuf(2 * i + 1)) Then
                m_dataInfo.y.dMax = m_aryBuf(2 * i + 1)
            End If
        End If
    Next i
    
    YaxisMax (m_dataInfo.y.dMax)
    
    m_dataSet = True
    
End Sub

Private Sub draw(Optional chart As Boolean = False)
    Static active As Boolean
    
    If active Then
        Call drawPlot(pbPlotFrame(1), chart)
        Call pbPlotFrame(1).ZOrder
        active = False
    Else
        Call drawPlot(pbPlotFrame(0), chart)
        Call pbPlotFrame(0).ZOrder
        active = True
    End If

End Sub

Private Sub drawPlot(pbPlot As PictureBox, Optional chart As Boolean = False)

    Dim i As Long, x As Single, y As Single
    
    If m_dataSet Then

        m_dataInfo.y.pMin = 0
        m_dataInfo.y.pMax = pbPlot.ScaleHeight
        
        m_dataInfo.y.dMin = 0 ' force y scale to 0-1
        m_dataInfo.y.dMax = 1
        
        m_dataInfo.y.m = ((m_dataInfo.y.pMax - m_dataInfo.y.pMin) _
                       / (m_dataInfo.y.dMax - m_dataInfo.y.dMin))
                      
        m_dataInfo.y.B = m_dataInfo.y.pMax - m_dataInfo.y.m * m_dataInfo.y.dMax
        
        m_dataInfo.x.pMin = 0
        m_dataInfo.x.pMax = pbPlot.ScaleWidth
        
        m_dataInfo.x.m = ((m_dataInfo.x.pMax - m_dataInfo.x.pMin) _
                       / (m_dataInfo.x.dMax - m_dataInfo.x.dMin))
        
        m_dataInfo.x.B = m_dataInfo.x.pMax - m_dataInfo.x.m * m_dataInfo.x.dMax
        
        pbPlot.Cls
        pbPlot.Refresh
        
        pbPlot.ForeColor = vbGreen
        pbPlot.DrawWidth = 2
        pbPlot.ScaleMode = 3
        
        Dim x0 As Single, y0 As Single
        
        For i = 0 To m_dataSize - 1
            x = (i + dPtr) Mod (m_dataSize - 1)
            x = x * 2: y = x + 1
            x = m_aryBuf(i * 2) * m_dataInfo.x.m + m_dataInfo.x.B
            y = m_aryBuf(y) / m_yAxisRange * m_dataInfo.y.m + m_dataInfo.y.B
            y = m_dataInfo.y.pMax - y ' origin is top
            If i Then
                pbPlot.Line (x0, y0)-(x, y)
            Else
                pbPlot.PSet (x, y)
            End If
            x0 = x: y0 = y
        Next i
    
        ' Draw Grid
        pbPlot.ForeColor = vbWhite
        pbPlot.DrawWidth = 1
        For i = 1 To 9 ' Y axis
            y = i * pbPlot.ScaleHeight / 10
            pbPlot.Line (0, y)-(pbPlot.Width, y)
        Next i
    
        For i = 1 To 7 ' Y axis
            x = i * pbPlot.ScaleWidth / 8
            pbPlot.Line (x, 0)-(x, pbPlot.Height)
        Next i
        
    End If
    
End Sub

'________________________________________
'||||||||||| Public Properties ||||||||||
'========================================

Public Property Get caption() As String
    caption = fPlot.caption
End Property
Public Property Let caption(ByVal newCaption As String)
    fPlot.caption = newCaption
    PropertyChanged "Caption"
End Property



Public Property Get XaxisLabel() As String
    XaxisLabel = lblXaxisLbl.caption
End Property
Public Property Let XaxisLabel(ByVal newXaxisLabel As String)
    lblXaxisLbl.caption = newXaxisLabel
    PropertyChanged "XaxisLabel"
End Property
Public Property Get XaxisDataFormat() As String
    XaxisDataFormat = gXaxisDataFormat
    lblXval(0).caption = format(lblXval(0).caption, gXaxisDataFormat)
    lblXval(1).caption = format((val(lblXval(2).caption) + val(lblXval(0).caption)) / 2, gXaxisDataFormat)
    lblXval(2).caption = format(lblXval(2).caption, gXaxisDataFormat)
End Property
Public Property Let XaxisDataFormat(format As String)
    gXaxisDataFormat = format
End Property
Public Property Get XaxisDataMin() As Single
    XaxisDataMin = lblXval(0).caption
End Property
Public Property Let XaxisDataMin(data As Single)
    lblXval(0).caption = format(data, gXaxisDataFormat)
    lblXval(1).caption = format((val(lblXval(2).caption) + val(lblXval(0).caption)) / 2, gXaxisDataFormat)
End Property
Public Property Get XaxisDataMax() As Single
    XaxisDataMax = lblXval(2).caption
End Property
Public Property Let XaxisDataMax(data As Single)
    lblXval(2).caption = format(data, gXaxisDataFormat)
    lblXval(1).caption = format((val(lblXval(2).caption) + val(lblXval(0).caption)) / 2, gXaxisDataFormat)
End Property

Public Sub setFileType(fType As fileType)
    gFileType = fType
End Sub

Public Function getFileType() As fileType
    getFileType = gFileType
End Function

Public Sub setStart(value As Single)
    gStart = value
End Sub

Public Sub setStop(value As Single)
    gStop = value
End Sub

Public Sub setStep(value As Single)
    gStep = value
End Sub

Public Sub setXstart(value As Single)
    gXstart = value
End Sub

Public Sub setXstop(value As Single)
    gXstop = value
End Sub

Public Sub setXstep(value As Single)
    gXstep = value
End Sub

Public Sub setPromptEnable(enable As Boolean)
    gPrompt4device = enable
End Sub

Public Sub setFile(file As String)
    Dim i As Integer: i = 1
    While i
        i = InStr(i + 1, file, "\")
        If i Then
            gDirectory = Mid(file, 1, i)
            gFile = Mid(file, i + 1, Len(file))
        End If
    Wend
    
    'lblDirectory.Caption = gDirectory
    'lblFile.Caption = gFile
    gDirectoryFile = gDirectory & gFile
End Sub

Public Function getFile() As String
    getFile = gDirectory & gFile
End Function

Public Function getCaption() As String
    getCaption = gFile
End Function

Public Sub saveFile()
    
    gOutputFileNum = 1: Open gDirectoryFile For Output As gOutputFileNum
    
    setStartStep
    
    Select Case gFileType
    Case spectralResponse: Call saveDevicePlot("nm")
    Case radiationPattern: Call saveDevicePlot("deg")
    Case radiationResponse: Call saveXYplots
    End Select
    
    Close gOutputFileNum: gOutputFileNum = 0

End Sub

Public Sub appendFile()
    
    Select Case gFileType
    Case spectralResponse: Call appendDevicePlot
    Case radiationPattern: Call appendDevicePlot
    Case radiationResponse: Call appendXYplots
    End Select

End Sub

Private Sub delRename(fName As String, sName As String)

    Shell ("cmd /c del " & fName)
    Do
        DoEvents
    Loop Until dIR(fName) = ""
    
    Shell ("cmd /c rename " & fName & ".csv " & sName)
    Do
        DoEvents
    Loop Until dIR(fName & ".csv ") = ""
    
End Sub


Private Sub appendDevicePlot()
    Const labelLen As Integer = 7
    Dim i As Integer, j As Integer, k As Integer
    Dim s As String, labels(labelLen) As String
    Dim als() As Single
    Dim aSum As Single, aSum2 As Single, aMin As Single, aMax As Single
    
    gInputFileNum = 1: Open gDirectoryFile For Input As gInputFileNum
    gOutputFileNum = 2: Open gDirectoryFile & ".csv" For Output As gOutputFileNum
    
    For i = 0 To labelLen: Input #gInputFileNum, labels(i): Next i: Input #gInputFileNum, s
    
    i = 0
    Do
        Input #gInputFileNum, s: i = i + 1
    Loop While s <> "X"
    
    i = i: ReDim als(i)
    
    Print #gOutputFileNum, labels(0),
    For j = 1 To labelLen: Print #gOutputFileNum, "," & labels(j),: Next j
    
    For j = 0 To i: Print #gOutputFileNum, "," & j,: Next j
    Print #gOutputFileNum, ",X"
    
    For j = 0 To m_dataSize - 1
        Input #gInputFileNum, s: Print #gOutputFileNum, s,
        For k = 1 To labelLen: Input #gInputFileNum, s: Next k
        
        als(0) = m_aryBuf(j * 2 + 1): aSum = als(0): aSum2 = als(0) * als(0): aMin = als(0): aMax = als(0)
        For k = 1 To i
            Input #gInputFileNum, als(k)
            If aMin > als(k) Then aMin = als(k)
            If aMax < als(k) Then aMax = als(k)
            aSum = aSum + als(k)
            aSum2 = aSum2 + als(k) * als(k)
        Next k
        aSum = aSum / (1 + i): aSum2 = (Abs(aSum2 / (1 + i) - aSum * aSum)) ^ 0.5
        
        Input #gInputFileNum, s
        
        Print #gOutputFileNum, ",", aMin, ",", aSum, ",", aMax, ",", aSum2,
        Print #gOutputFileNum, ",", aSum - 3 * aSum2, ",", aSum, ",", aSum + 3 * aSum2,
        For k = 0 To i: Print #gOutputFileNum, ",", als(k),: Next k
        Print #gOutputFileNum, ",X"
    
    Next j
    
    closeFiles
    
    Call delRename(gDirectoryFile, gFile)
    
End Sub

Private Sub appendXYplots()
    Dim i As Integer, j As Integer, k As Integer
    Dim s As String
    Dim ir() As Single
    
    gInputFileNum = 1: Open gDirectoryFile For Input As gInputFileNum
    gOutputFileNum = 2: Open gDirectoryFile & ".csv" For Output As gOutputFileNum
    
    i = 0
    Do
        Input #gInputFileNum, s: i = i + 1
    Loop While s <> "X"
    
    i = (i - 2): ReDim ir(i)
    
    Print #gOutputFileNum, "deg",
    
    For j = 0 To i: Print #gOutputFileNum, "," & gXstart + j * gXstep & "nm",: Next j
    Print #gOutputFileNum, ",X"
    
    For j = 0 To m_dataSize - 1
    
        Input #gInputFileNum, s: Print #gOutputFileNum, s,
        
        ir(i) = m_aryBuf(j * 2 + 1)
        For k = 0 To i - 1
            Input #gInputFileNum, ir(k)
        Next k
        
        Input #gInputFileNum, s
        
        For k = 0 To i: Print #gOutputFileNum, ",", ir(k),: Next k
        Print #gOutputFileNum, ",X"
    
    Next j
    
    closeFiles
    
    Call delRename(gDirectoryFile, gFile)
    
End Sub

Private Sub saveDevicePlot(xlabel As String)
    Dim i As Integer, j As Integer
    Dim x As Single, v As Single
    
    Print #gOutputFileNum, xlabel,
    Print #gOutputFileNum, ",Min,Mean,Max,alsStd",
    Print #gOutputFileNum, ",Mean-3s,Mean,Mean+3s,0,X"
    
    For i = 0 To m_dataSize - 1
        x = gStart + i * gStep: j = 2 * i + 1
        v = m_aryBuf(j)
        Print #gOutputFileNum, x, ",",
        Print #gOutputFileNum, v, ",", v, ",", v, ",", 0, ",",
        Print #gOutputFileNum, v, ",", v, ",", v, ",", v, ",X"
    Next i
    
End Sub

Private Sub saveXYplots()
    Dim i As Integer, j As Integer
    Dim x As Single, v As Single
    
    Print #gOutputFileNum, "deg",
    Print #gOutputFileNum, "," & gXstart & "nm", ",X"
    
    For i = 0 To m_dataSize - 1
        x = gStart + i * gStep: j = 2 * i + 1
        v = m_aryBuf(j)
        Print #gOutputFileNum, x, ",", v, ",X"
    Next i
    
End Sub

Public Function openFile(file As String) As Integer
    Select Case gFileType
        Case radiationResponse: openRadiationResponse (file)
        Case Else: openXY (file)
    End Select
End Function

Public Sub closeFiles(Optional fileNum As Integer = 0)
    If fileNum Then
        Close #fileNum
        Select Case fileNum
        Case 1: gInputFileNum = 0
        Case 2: gOutputFileNum = 0
        End Select
    Else
        If gInputFileNum Then Close gInputFileNum: gInputFileNum = 0
        If gOutputFileNum Then Close gOutputFileNum: gOutputFileNum = 0
    End If
End Sub


' ___________________________
' Radiation Response Data I/O
' ===========================
Public Function getWavelengthMin() As Double
    getWavelengthMin = colVec.start
End Function
Public Function getWavelengthMax() As Double
    getWavelengthMax = colVec.stop_
End Function
Public Function getWavelengthStep() As Double
    getWavelengthStep = colVec.step
End Function
Public Function getWavelengthSize() As Double
    getWavelengthSize = colVec.size
End Function
Public Sub getWavelengthSweep(ByVal i As Integer)
    Dim j As Integer
    If i >= 0 And i < colVec.size Then
        setPlotSize colVec.size
        gWavelengthSum = 0: gWavelengthCenter = 0
        For j = 0 To colVec.size - 1
            plot pnt(j, i)
            gWavelengthSum = gWavelengthSum + pnt(j, i)
        Next j
        For j = 0 To colVec.size - 1
            gWavelengthCenter = gWavelengthCenter + pnt(j, i)
            If gWavelengthCenter > gWavelengthSum / 2 Then
                gWavelengthCenter = j + (gWavelengthCenter - gWavelengthSum / 2) / pnt(j, i)
                gWavelengthCenter = colVec.start + gWavelengthCenter * colVec.step
                j = colVec.size - 1
            End If
        Next j
    End If
End Sub
Public Function getWavelengthSum() As Double
    getWavelengthSum = gWavelengthSum
End Function
Public Function getWavelengthCenter() As Double
    getWavelengthCenter = gWavelengthCenter
End Function




Public Function getAngleMin() As Double
    getAngleMin = rowVec.start
End Function
Public Function getAngleMax() As Double
    getAngleMax = rowVec.stop_
End Function
Public Function getAngleStep() As Double
    getAngleStep = rowVec.step
End Function
Public Function getAngleSize() As Double
    getAngleSize = rowVec.size
End Function
Public Sub getAngleSweep(ByVal i As Integer)
    Dim j As Integer
    If i >= 0 And i < rowVec.size Then
        setPlotSize rowVec.size
        gAngleSum = 0
        For j = 0 To rowVec.size - 1
            plot pnt(i, j)
            gAngleSum = gAngleSum + pnt(j, i)
        Next j
    End If
End Sub
Public Function getAngleSum() As Double
    getAngleSum = gAngleSum
End Function




















Private Sub UserControl_Terminate()
    closeFiles
End Sub



Private Sub UserControl_ReadProperties(PropBag As PropertyBag)

    fPlot.caption = PropBag.ReadProperty("Caption", "Plot Captions")
    
    lblXaxisLbl = PropBag.ReadProperty("XaxisLabel", lblXaxisLbl.caption)
    gXaxisDataFormat = PropBag.ReadProperty("XaxisDataFormat", "0")
    lblXval(0).caption = format(PropBag.ReadProperty("XaxisDataMin"), gXaxisDataFormat)
    lblXval(2).caption = format(PropBag.ReadProperty("XaxisDataMax"), gXaxisDataFormat)
    lblXval(1).caption = format((val(lblXval(2).caption) + val(lblXval(0).caption)) / 2, gXaxisDataFormat)
    
End Sub
Private Sub UserControl_WriteProperties(PropBag As PropertyBag)
    Call PropBag.WriteProperty("Caption", fPlot.caption)
    
    Call PropBag.WriteProperty("XaxisLabel", lblXaxisLbl.caption)
    Call PropBag.WriteProperty("XaxisDataFormat", gXaxisDataFormat)
    Call PropBag.WriteProperty("XaxisDataMin", lblXval(0).caption)
    Call PropBag.WriteProperty("XaxisDataMax", lblXval(2).caption)
    
End Sub


