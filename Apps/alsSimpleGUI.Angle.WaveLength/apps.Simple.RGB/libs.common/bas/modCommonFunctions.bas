Attribute VB_Name = "modCommonFunctions"
Private Type doublePrecision
    data As Double
End Type

Private Type float
    data As Single
End Type

Private Type dateType
    data As Date
End Type

Private Type char
    data(7) As Byte
End Type

'|||||||||||||||||||||||||||||


Public Function enterText(ByRef text As String) As Integer
    ' strip [cr] & [lf], return > 0
    enterText = InStr(text, Chr(13))
    If (enterText) Then
        text = Mid(text, 1, enterText - 1)
    End If
End Function

Public Sub matrixMultiply(row() As Single, col() As Single, matrix() As Single)

    Dim R As Integer, c As Integer, nr As Integer, nc As Integer
    
    nr = UBound(row): nc = UBound(col) + 1 ' added intercept for monitor
    
    For R = 0 To nr
        row(R) = matrix(R, nc)
        For c = 0 To nc - 1
            row(R) = row(R) + col(c) * matrix(R, c)
        Next c
    Next R
    
End Sub

Public Function sinceLastTime(Optional tmrNum As Integer = 0) As Long

    Dim thisTime As Long
    Static lastTime(9) As Long
    
    If tmrNum < 0 Then
        trmnum = 0
    Else
        If tmrNum > 9 Then tmrNum = 9
    End If
    
    thisTime = GetTickCount
    
    If thisTime > lastTime(tmrNum) Then sinceLastTime = thisTime - lastTime(tmrNum)
    
    lastTime(tmrNum) = thisTime
    
End Function


'======================================================
Public Function single2byte(real As Single, bits() As Byte, Optional ByVal Index As Integer = 0) As Integer

    Dim i As Integer, indata As float, outData As char
    
    indata.data = real
    LSet outData = indata
    
    For i = 0 To Len(real) - 1
        bits(i + Index) = outData.data(i)
    Next i
    
    single2byte = Index + i
    
End Function
'------------------------------------------------------
Public Function byte2single(bits() As Byte, real As Single, Optional ByVal Index As Integer = 0) As Integer

    Dim i As Integer, indata As char, outData As float
    
    For i = 0 To Len(real) - 1
        indata.data(i) = bits(i + Index)
    Next i

    LSet outData = indata
    real = outData.data
    
    byte2single = Index + i

End Function
'======================================================


'======================================================
Public Function double2byte(real As Double, bits() As Byte, Optional ByVal Index As Integer = 0) As Integer

    Dim i As Integer, indata As doublePrecision, outData As char
    
    indata.data = real
    LSet outData = indata
    
    For i = 0 To Len(real) - 1
        bits(i + Index) = outData.data(i)
    Next i

    double2byte = Index + i

End Function
'------------------------------------------------------
Public Function byte2double(bits() As Byte, real As Double, Optional ByVal Index As Integer = 0) As Integer

    Dim i As Integer, indata As char, outData As doublePrecision
    
    For i = 0 To Len(real) - 1
        indata.data(i) = bits(i + Index)
    Next i

    LSet outData = indata
    real = outData.data
    
    byte2double = Index + i

End Function
'======================================================


'======================================================
Public Function date2byte(real As Date, bits() As Byte, Optional ByVal Index As Integer = 0) As Integer

    Dim i As Integer, indata As dateType, outData As char
    
    On Error Resume Next
    
    indata.data = real
    LSet outData = indata
    
    For i = 0 To Len(real) - 1
        bits(i + Index) = outData.data(i)
    Next i

    date2byte = Index + i

End Function
'------------------------------------------------------
Public Function byte2date(bits() As Byte, real As Date, Optional ByVal Index As Integer = 0) As Integer

    Dim i As Integer, indata As char, outData As dateType
    
    On Error Resume Next
    
    For i = 0 To Len(real) - 1
        indata.data(i) = bits(i + Index)
    Next i

    LSet outData = indata
    real = outData.data
    
    byte2date = Index + i

End Function
'======================================================


Public Function getExeDateTime(exe As String) As Date

    Dim file As String: file = App.Path & "\" & exe
    
    If dIR(file) <> "" Then ' installer location
        getExeDateTime = FileDateTime(file)
    Else ' development location
        file = App.Path & "\..\..\output\Debug\bin\" & exe
        If dIR(file) <> "" Then getExeDateTime = FileDateTime(file)
    End If

End Function


