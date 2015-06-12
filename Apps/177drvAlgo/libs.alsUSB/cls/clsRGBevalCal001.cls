VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsRGBevalCal001"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
'||==================================================================||
'||                                                                  ||
'|| Data class for RGB Evaluation Card compensation,gain & transform ||
'||                                                                  ||
'||==================================================================||

Dim size As Integer

Private Type rgbEvalCalStruct
    compensation As Single
    cardGain(2) As Single
    range(2) As Single        ' 3 ranges
    transform(2, 2, 2) As Single ' 3 Range + 3x3 (no dIR)
End Type

Dim rgbEvalCal As rgbEvalCalStruct

Dim tb As TextBox

Const nLines As Integer = 13

Public Function getNlines() As Integer
    getNlines = nLines
End Function

Public Sub setTBobj(value As TextBox)
    Set tb = value
    setTB
End Sub

Private Sub Class_Initialize()
    size = Len(rgbEvalCal)
End Sub

Function getSize() As Integer
    getSize = size
End Function

Sub clear()
    Dim i As Integer, j As Integer, p As Integer
    
    rgbEvalCal.compensation = 0
    
    For i = 0 To UBound(rgbEvalCal.cardGain)
        rgbEvalCal.cardGain(i) = 0
    Next i
    
    For i = 0 To UBound(rgbEvalCal.range)
        rgbEvalCal.range(i) = 0
    Next i
    
    For p = 0 To UBound(rgbEvalCal.transform)
    For i = 0 To UBound(rgbEvalCal.transform, 2): For j = 0 To UBound(rgbEvalCal.transform, 3)
        rgbEvalCal.transform(9, i, j) = 0
    Next j: Next i
    Next p
End Sub

Sub default()
    Dim i As Integer, j As Integer, p As Integer
    
    rgbEvalCal.compensation = 0
    
    For i = 0 To UBound(rgbEvalCal.cardGain)
        rgbEvalCal.cardGain(i) = 1
    Next i
    
    For i = 0 To UBound(rgbEvalCal.range)
        rgbEvalCal.range(i) = 1
    Next i
    
    For p = 0 To UBound(rgbEvalCal.transform)
    For i = 0 To UBound(rgbEvalCal.transform, 2): For j = 0 To UBound(rgbEvalCal.transform, 3)
        If i = j Then
            rgbEvalCal.transform(p, i, j) = 1
        Else
            rgbEvalCal.transform(p, i, j) = 0
        End If
    Next j: Next i
    Next p
    
End Sub


'||==================||
'|| Data pack/unpack ||
'||==================||
Public Function getEEprom(data() As Byte, Optional ByVal Index As Integer = 0) As Integer
    Dim i As Integer, j As Integer, p As Integer
    
    Index = byte2single(data, rgbEvalCal.compensation, Index)
    
    For i = 0 To UBound(rgbEvalCal.cardGain)
        Index = byte2single(data, rgbEvalCal.cardGain(i), Index)
    Next i
    
    For i = 0 To UBound(rgbEvalCal.range)
        Index = byte2single(data, rgbEvalCal.range(i), Index)
    Next i
    
    For p = 0 To UBound(rgbEvalCal.transform)
    For i = 0 To UBound(rgbEvalCal.transform, 2): For j = 0 To UBound(rgbEvalCal.transform, 3)
        Index = byte2single(data, rgbEvalCal.transform(p, i, j), Index)
    Next j: Next i
    Next p
    
    getEEprom = Index
    
    setTB
    
End Function

Public Function setEEprom(data() As Byte, Optional ByVal Index As Integer = 0) As Integer
    Dim i As Integer, j As Integer, p As Integer
    
    Dim items() As String
    items = Split(tb.text, ",")
    getTB items

    Index = single2byte(rgbEvalCal.compensation, data, Index)
    
    For i = 0 To UBound(rgbEvalCal.cardGain)
        Index = single2byte(rgbEvalCal.cardGain(i), data, Index)
    Next i
    
    For i = 0 To UBound(rgbEvalCal.range)
        Index = single2byte(rgbEvalCal.range(i), data, Index)
    Next i
    
    For p = 0 To UBound(rgbEvalCal.transform)
    For i = 0 To UBound(rgbEvalCal.transform, 2): For j = 0 To UBound(rgbEvalCal.transform, 3)
        Index = single2byte(rgbEvalCal.transform(p, i, j), data, Index)
    Next j: Next i
    Next p
    
    setEEprom = Index
    
End Function


'||==========||
'|| File I/O ||
'||==========||
Public Sub getFile(N As Integer)

    Dim p As Integer, i As Integer, j As Integer, k As Integer, s As String
    Dim F As Single
    
    On Error Resume Next
    
    Input #N, s, s, F: setCompensation F
    
    Input #N, s, s
    For i = 0 To UBound(rgbEvalCal.range)
        Input #N, F: setCardGain i, F
    Next i
    
    Input #N, s, s
    For i = 0 To UBound(rgbEvalCal.range)
        Input #N, F: setRange i, F
    Next i
    
    Input #N, s, s
    For p = 0 To UBound(rgbEvalCal.transform)
    For i = 0 To UBound(rgbEvalCal.transform, 2): Input #N, s: For j = 0 To UBound(rgbEvalCal.transform, 3)
        Input #N, F: setTransform p, i, j, F
    Next j: Next i
    Next p
    
    setTB
    
End Sub

Public Sub setFile(N As Integer)

    Dim i As Integer, j As Integer, p As Integer
    
    Dim items() As String
    items = Split(tb.text, ",")
    getTB items
    
    Write #N, "Compensation", getCompensation,: Print #N, ""
    
    Write #N, "CardGain",
    For i = 0 To UBound(rgbEvalCal.cardGain)
        Write #N, getCardGain(i),
    Next i
    Print #N, ""

    Write #N, "Range",
    For i = 0 To UBound(rgbEvalCal.range)
        Write #N, getRange(i),
    Next i
    Print #N, ""

    
    Write #N, "CCM",: Print #N, ""
    For p = 0 To UBound(rgbEvalCal.transform)
    For i = 0 To UBound(rgbEvalCal.transform, 2): For j = 0 To UBound(rgbEvalCal.transform, 3)
        Write #N, getTransform(p, i, j),
    Next j: Print #N, "": Next i
    Next p
    
    
End Sub

Public Sub setTB()

    Dim i As Integer, j As Integer, p As Integer
    
    On Error Resume Next

    If Not (tb Is Nothing) Then
        If Not append Then tb.text = ""
        tb.text = tb.text & Chr(&H22) & "Compensation" & Chr(&H22) & ","
        tb.text = tb.text & getCompensation & "," & vbCrLf
        
        tb.text = tb.text & Chr(&H22) & "CardGain" & Chr(&H22) & ","
        For i = 0 To UBound(rgbEvalCal.cardGain)
            tb.text = tb.text & getCardGain(i) & ","
        Next i: tb.text = tb.text & vbCrLf
        'tb.text = tb.text & getCardGain & "," & vbCrLf
        
        tb.text = tb.text & Chr(&H22) & "Range" & Chr(&H22) & ","
        For i = 0 To UBound(rgbEvalCal.range)
            tb.text = tb.text & getRange(i) & ","
        Next i: tb.text = tb.text & vbCrLf
        
        tb.text = tb.text & Chr(&H22) & "CCM" & Chr(&H22) & "," & vbCrLf
        For p = 0 To UBound(rgbEvalCal.transform)
        For i = 0 To UBound(rgbEvalCal.transform, 2): For j = 0 To UBound(rgbEvalCal.transform, 3)
            tb.text = tb.text & getTransform(p, i, j) & ","
        Next j: tb.text = tb.text & vbCrLf: Next i
        Next p
        
    End If
End Sub

Public Function getTB(items() As String) As Integer
    Dim p As Integer, j As Integer, k As Integer, i As Integer: i = 1
    
    setCompensation items(i): i = i + 2
    
    For j = 0 To UBound(rgbEvalCal.cardGain)
        setCardGain j, items(i): i = i + 1
    Next j
    
    i = i + 1
    For j = 0 To UBound(rgbEvalCal.range)
        setRange j, items(i): i = i + 1
    Next j
    
    i = i + 1
    For p = 0 To UBound(rgbEvalCal.transform)
    For j = 0 To UBound(rgbEvalCal.transform, 2): For k = 0 To UBound(rgbEvalCal.transform, 3)
        setTransform p, j, k, items(i): i = i + 1
    Next k: Next j
    Next p
    
    getTB = i + 1
    
End Function

' ______________________________
' ||||||||| INTERFACES |||||||||
' ==============================
Public Function getCompensation() As Single
    On Error Resume Next
    getCompensation = rgbEvalCal.compensation
End Function
Public Sub setCompensation(ByVal value As Single)
    On Error Resume Next
    rgbEvalCal.compensation = value
End Sub
' ==============================
Public Function getCardGain(ByVal i As Integer) As Single
    On Error Resume Next
    getCardGain = rgbEvalCal.cardGain(i)
End Function
Public Sub setCardGain(ByVal i As Integer, ByVal value As Single)
    On Error Resume Next
    rgbEvalCal.cardGain(i) = value
End Sub
' ==============================
Public Function getRange(i As Integer) As Single
    On Error Resume Next
    getRange = rgbEvalCal.range(i)
End Function
Public Sub setRange(ByVal i As Integer, ByVal value As Single)
    On Error Resume Next
    rgbEvalCal.range(i) = value
End Sub
' ==============================
Public Function getTransform(ByVal p As Integer, i As Integer, j As Integer) As Single
    On Error Resume Next
    getTransform = rgbEvalCal.transform(p, i, j)
End Function
Public Sub setTransform(ByVal p As Integer, ByVal i As Integer, ByVal j As Integer, ByVal value As Single)
    On Error Resume Next
    rgbEvalCal.transform(p, i, j) = value
End Sub
' ==============================


