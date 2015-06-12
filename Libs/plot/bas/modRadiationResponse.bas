Attribute VB_Name = "modRadiationResponse"
Option Explicit

Type vector
    start As Double
    stop_ As Double
    step As Double
    size As Double
End Type

Public colVec As vector
Public rowVec As vector

Public pnt() As Double

Public Sub openRadiationResponse(file)
On Error GoTo errorExit
    Dim x As Integer, y As Integer
    Dim str As String
    
    Open file For Input As #1
    '_________________________________
    'scan for #/columns (look for 'X')
    '=================================
    For x = 0 To 800 ' 300-1100, 1nm steps
        Input #1, str
        If str = "X" Then
            x = 800
        Else
            If x = 1 Then
                colVec.start = Val(str)
            Else
                colVec.stop_ = Val(str)
                colVec.size = x
                colVec.step = (colVec.stop_ - colVec.start) / (x - 1)
            End If
        End If
    Next x
    '_______________
    'scan for #/rows
    '===============
    For y = 0 To 181 ' -90-90, 1deg steps
        If EOF(1) Then
            rowVec.step = (rowVec.stop_ - rowVec.start) / (rowVec.size - 1)
            y = 181
        Else
            Input #1, str
            If y = 0 Then
                rowVec.start = Val(str)
            Else
                rowVec.stop_ = Val(str)
                rowVec.size = y + 1
            End If
            For x = 0 To colVec.size  'extra read for 'X'
                Input #1, str
            Next x
        End If
    Next y
    Close #1
    '_________
    'read data
    '=========
    Open file For Input As #1
    ReDim pnt(colVec.size - 1, rowVec.size - 1)
    For y = 0 To rowVec.size
        Input #1, str ' prefix - angle
        For x = 0 To colVec.size - 1
            Input #1, str
            If y > 0 Then
                pnt(x, y - 1) = Val(str)
            End If
        Next x
        Input #1, str ' read 'X'
    Next y
errorExit:
    Close #1
End Sub
