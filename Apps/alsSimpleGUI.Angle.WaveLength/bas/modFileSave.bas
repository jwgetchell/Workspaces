Attribute VB_Name = "modFileSave"
Option Explicit

Enum fileType
    spectralResponse
    radiationPattern
End Enum

Public gFileType As fileType

Private sStart As Single, sStop As Single

Public Sub setSweepFileStart(value As Single)
    sStart = value
End Sub

Public Sub setSweepFileStop(value As Single)
    sStop = value
End Sub

Public Sub saveFile()
    Select Case gFileType
    Case spectralResponse: Call saveSpectralResponse
    Case radiationPattern:
    End Select
    

End Sub

Public Sub saveSpectralResponse()
    Dim i As Integer, step As Single: step = (sStop - sStart) / (gPlotSize - 1)
    Print #1, "nm,als,ir"
    For i = 0 To gPlotSize - 1
        Print #1, sStart + i * step, ",", pBuf0(2 * i + 1), ",", pBuf1(2 * i + 1)
    Next i
End Sub

