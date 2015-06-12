VERSION 5.00
Begin VB.UserControl ucFileSave 
   ClientHeight    =   1410
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   5550
   ScaleHeight     =   1410
   ScaleWidth      =   5550
   Begin VB.Frame fmFileSave 
      Height          =   1455
      Left            =   0
      TabIndex        =   0
      Top             =   -60
      Width           =   5535
      Begin VB.Label lblFile 
         Alignment       =   1  'Right Justify
         Caption         =   "File"
         Height          =   255
         Left            =   120
         TabIndex        =   2
         Top             =   360
         Width           =   5295
      End
      Begin VB.Label lblDirectory 
         Alignment       =   1  'Right Justify
         Caption         =   "Directory"
         Height          =   255
         Left            =   120
         TabIndex        =   1
         Top             =   120
         Width           =   5295
      End
   End
End
Attribute VB_Name = "ucFileSave"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Private Declare Sub Sleep Lib "kernel32" (ByVal dwMilliseconds As Long)

Public Enum fileType
    spectralResponse
    radiationPattern
End Enum

Private gFileType As fileType

Private gStart As Single
Private gStop As Single
Private gStep As Single

Private gPrompt4device As Boolean
Private gDirectory As String
Private gFile As String
Private gDirectoryFile As String

Private gInputFileNum As Integer
Private gOutputFileNum As Integer

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
    gStep = step
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
    lblDirectory.Caption = gDirectory
    lblFile.Caption = gFile
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
    
    Select Case gFileType
    Case spectralResponse: Call save2Plots("nm")
    Case radiationPattern: Call save2Plots("deg")
    End Select
    
    Close gOutputFileNum: gOutputFileNum = 0

End Sub

Public Sub appendFile()
    
    Select Case gFileType
    Case spectralResponse: Call append2plots
    Case radiationPattern: Call append2plots
    End Select

End Sub

Private Sub append2plots()
    Dim i As Integer, j As Integer, k As Integer
    Dim s As String, labels(8) As String
    Dim als() As Single, ir() As Single
    Dim aSum As Single, aSum2 As Single, aMin As Single, aMax As Single
    Dim iSum As Single, iSum2 As Single, iMin As Single, iMax As Single
    
    gInputFileNum = 1: Open gDirectoryFile For Input As gInputFileNum
    gOutputFileNum = 2: Open gDirectoryFile & ".csv" For Output As gOutputFileNum
    
    For i = 0 To 8: Input #gInputFileNum, labels(i): Next i: Input #gInputFileNum, s
    
    i = 0
    Do
        Input #gInputFileNum, s: i = i + 1
    Loop While s <> "X"
    
    i = i / 2: ReDim als(i), ir(i)
    
    Print #gOutputFileNum, labels(0),
    For j = 1 To 8: Print #gOutputFileNum, "," & labels(j),: Next j
    
    For j = 0 To i: Print #gOutputFileNum, "," & j & "als",: Next j
    For j = 0 To i: Print #gOutputFileNum, "," & j & "ir",: Next j
    Print #gOutputFileNum, ",X"
    
    For j = 0 To gPlotSize - 1
        Input #gInputFileNum, s: Print #gOutputFileNum, s,
        For k = 1 To 8: Input #gInputFileNum, s: Next k
        
        als(0) = pBuf0(j * 2 + 1): aSum = als(0): aSum2 = als(0) * als(0): aMin = als(0): aMax = als(0)
        For k = 1 To i
            Input #gInputFileNum, als(k)
            If aMin > als(k) Then aMin = als(k)
            If aMax < als(k) Then aMax = als(k)
            aSum = aSum + als(k)
            aSum2 = aSum2 + als(k) * als(k)
        Next k
        aSum = aSum / (1 + i): aSum2 = (Abs(aSum2 / (1 + i) - aSum * aSum)) ^ 0.5
        
        ir(0) = pBuf1(j * 2 + 1): iSum = ir(0): iSum2 = ir(0) * ir(0): iMin = ir(0): iMax = ir(0)
        For k = 1 To i
            Input #gInputFileNum, ir(k)
            If iMin > ir(k) Then iMin = ir(k)
            If iMax < ir(k) Then iMax = ir(k)
            iSum = iSum + ir(k)
            iSum2 = iSum2 + ir(k) * ir(k)
        Next k
        iSum = iSum / (1 + i): iSum2 = (Abs(iSum2 / (1 + i) - iSum * iSum)) ^ 0.5
        
        Input #gInputFileNum, s
        
        Print #gOutputFileNum, ",", aMin, ",", aSum, ",", aMax, ",", aSum2,
        Print #gOutputFileNum, ",", iMin, ",", iSum, ",", iMax, ",", iSum2,
        For k = 0 To i: Print #gOutputFileNum, ",", als(k),: Next k
        For k = 0 To i: Print #gOutputFileNum, ",", ir(k),: Next k
        Print #gOutputFileNum, ",X"
    
    Next j
    
    closeFiles
    
    Shell ("cmd /c del " & gDirectoryFile): Sleep (1000)
    Shell ("cmd /c rename " & gDirectoryFile & ".csv " & gFile): Sleep (1000)
    
End Sub

Public Sub save2Plots(xlabel As String)
    Dim i As Integer, j As Integer
    Dim step As Single: step = (gStop - gStart) / (gPlotSize - 1)
    Dim x As Single, v0 As Single, v1 As Single
    
    Print #gOutputFileNum, xlabel,
    Print #gOutputFileNum, ",alsMin,alsMean,alsMax,alsStd",
    Print #gOutputFileNum, ",irMin,irMean,irMax,irStd",
    Print #gOutputFileNum, ",0als", ",0ir", ",X"
    
    For i = 0 To gPlotSize - 1
        x = gStart + i * step: j = 2 * i + 1
        v0 = pBuf0(j): v1 = pBuf1(j)
        Print #gOutputFileNum, x, ",",
        Print #gOutputFileNum, v0, ",", v0, ",", v0, ",", 0, ",",
        Print #gOutputFileNum, v1, ",", v1, ",", v1, ",", 0, ",",
        Print #gOutputFileNum, v0, ",", v1, ",X"
    Next i
    
End Sub

Private Function initOpenFile(file As String) As Integer
    On Error GoTo errorFile
    GoTo openFileExit
errorFile:
openFileExit:
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

Private Sub UserControl_Initialize()
    setFileType (spectralResponse)
End Sub

Private Sub UserControl_Terminate()
    closeFiles
End Sub
