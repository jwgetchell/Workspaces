VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsEEpromE003"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Const nCalStructs As Integer = 1                    ' <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
Const defaultFileNum As Integer = 1
Const nRecords As Integer = nCalStructs + 1 ' 1 more for header
Dim nLines As Integer, lines(nRecords) As Integer

' ==== Structs ====================================
Dim header As clsHeader000                          ' <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
Dim rgbEvalCal(nCalStructs - 1) As clsRGBevalCal001 ' <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
' =================================================

Dim size As Integer
'Dim dataTB As TextBox
Dim dataTBitems() As String

Private Sub Class_Initialize()

    Dim i As Integer, buf(1000) As Integer

    Set header = New clsHeader000                   ' <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    size = header.getSize
    nLines = header.getNlines: lines(0) = nLines
    
    For i = 0 To nCalStructs - 1
        Set rgbEvalCal(i) = New clsRGBevalCal001    ' <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
        size = size + rgbEvalCal(i).getSize
        lines(i + 1) = rgbEvalCal(i).getNlines
        nLines = nLines + lines(i + 1)
    Next i
    
End Sub

Private Sub Class_Terminate()
    Set header = Nothing
    For i = 0 To nCalStructs - 1
        Set rgbEvalCal(i) = Nothing
    Next i
End Sub

Public Sub getTBlines(Item() As Integer)
    Dim i As Integer
    For i = 0 To nRecords - 1
        Item(i) = lines(i)
    Next i
End Sub

Function getNrecords() As Integer
    getNrecords = nRecords
End Function

Function getNlines() As Integer
    getNlines = nLines
End Function

Function getSize() As Integer
    getSize = size
End Function

Sub setTBobj(widget As TextBox, Optional Index As Integer = 0)

    Dim i As Integer
    
    If Index > 0 Then
        If Index <= nCalStructs Then
            rgbEvalCal(Index - 1).setTBobj widget
        End If
    Else
        header.setTBobj widget
    End If

'    Set dataTB = data
'    header.setTBobj fixed
'    For i = 0 To nCalStructs - 1
'        If i = 0 Then
'            rgbEvalCal(0).setTBobj data
'        Else
'            rgbEvalCal(1).setTBobj data, True
'        End If
'    Next i
    
End Sub

'Sub getDataTBitems()
'
'    dataTBitems = Split(dataTB.text, ",")
'
'End Sub

Sub getEEprom(data() As Byte, Optional Index As Integer = 0)

    Dim i As Integer
    
    Index = header.getEEprom(data, Index)
    For i = 0 To nCalStructs - 1
        Index = rgbEvalCal(i).getEEprom(data, Index)
    Next i
    
End Sub

Sub setEEprom(data() As Byte)

    Dim i As Integer, Index As Integer: Index = 0

    Index = header.setEEprom(data, Index)
    
    ' load class from TextBox
    'getDataTBitems
    
    For i = 0 To nCalStructs - 1
        If i = 0 Then
            'rgbEvalCal(0).getTB (dataTBitems)
        Else
            'rgbEvalCal(1).getTB dataTBitems, tbDataIdx
        End If
    Next i
    
    ' load image from class
    For i = 0 To nCalStructs - 1
        Index = rgbEvalCal(i).setEEprom(data, Index)
    Next i
    
End Sub

Sub getFile(ByVal fileNum As Integer)

    Dim i As Integer

    header.getFile fileNum
    
    For i = 0 To nCalStructs - 1
        rgbEvalCal(i).getFile fileNum
    Next i
    
endSub: Close #fileNum: End Sub

Sub setFile(ByVal fileNum As Integer)

    Dim Index As Integer, i As Integer
    
    header.setFile fileNum
    
'    getDataTBitems
'
'    Index = rgbEvalCal(0).getTB(dataTBitems)
'    rgbEvalCal(0).setFile fileNum
    
    For i = 0 To nCalStructs - 1
'        If i = 0 Then
'            'rgbEvalCal(i).getTB dataTBitems, index
'        Else
            rgbEvalCal(i).setFile fileNum
'        End If
    Next i
    
endSub: Close #fileNum: End Sub

Sub setTB()
    Dim i As Integer
    
    header.setTB
    For i = 0 To nCalStructs - 1
        rgbEvalCal(i).setTB
    Next i

End Sub


' ______________________________
' ||||||||| INTERFACES |||||||||
' ==============================
' >>>>>>>>>>> HEADER <<<<<<<<<<<
' ==============================
Public Function getEEpromVersion() As Integer
    On Error Resume Next
    getEEpromVersion = header.getEEpromVersion
End Function
Public Sub setEEpromVersion(ByVal value As Integer)
    On Error Resume Next
    header.setEEpromVersion value
End Sub
' ==============================
Public Function getExeRevDate() As Date
    On Error Resume Next
    getExeRevDate = header.getExeRevDate
End Function
Public Sub setExeRevDate(ByVal value As Date)
    On Error Resume Next
    header.setExeRevDate value
End Sub
' ==============================
Public Function getDllRevDate() As Date
    On Error Resume Next
    getDllRevDate = header.getDllRevDate
End Function
Public Sub setDllRevDate(ByVal value As Date)
    On Error Resume Next
    header.setDllRevDate value
End Sub
' ==============================
Public Function getEEpromDate() As Date
    On Error Resume Next
    getEEpromDate = header.getEEpromDate
End Function
Public Sub setEEpromDate(ByVal value As Date)
    On Error Resume Next
    header.setEEpromDate value
End Sub
' ==============================
' >>>>>>>>> RGBEVALCAL <<<<<<<<<
' ==============================
Public Function getCompensation(ByVal p As Integer) As Single
    On Error Resume Next
    If p > nCalStructs - 1 Then p = nCalStructs - 1
    getCompensation = rgbEvalCal(p).getCompensation
End Function
Public Sub setCompensation(ByVal p As Integer, ByVal value As Single)
    On Error Resume Next
    If p > nCalStructs - 1 Then p = nCalStructs - 1
    rgbEvalCal(p).setCompensation value
End Sub
' ==============================
Public Function getCardGain(ByVal p As Integer) As Single
    On Error Resume Next
    'If p > nCalStructs - 1 Then p = nCalStructs - 1
    getCardGain = rgbEvalCal(0).getCardGain(p)
End Function
Public Sub setCardGain(ByVal p As Integer, ByVal value As Single)
    On Error Resume Next
    If p > nCalStructs - 1 Then p = nCalStructs - 1
    rgbEvalCal(0).setCardGain p, value
End Sub
' ==============================
Public Function getRange(ByVal p As Integer, i As Integer) As Single
    On Error Resume Next
    If p > nCalStructs - 1 Then p = nCalStructs - 1
    getRange = rgbEvalCal(p).getRange(i)
End Function
Public Sub setRange(ByVal p As Integer, i As Integer, ByVal value As Single)
    On Error Resume Next
    If p > nCalStructs - 1 Then p = nCalStructs - 1
    rgbEvalCal(p).setRange i, value
End Sub
' ==============================
Public Function getTransform(ByVal p As Integer, i As Integer, j As Integer) As Single
    On Error Resume Next
    'If p > nCalStructs - 1 Then p = nCalStructs - 1
    getTransform = rgbEvalCal(0).getTransform(p, i, j)
End Function
Public Sub setTransform(ByVal p As Integer, i As Integer, j As Integer, ByVal value As Single)
    On Error Resume Next
    'If p > nCalStructs - 1 Then p = nCalStructs - 1
    rgbEvalCal(0).setTransform p, i, j, value
End Sub
' ==============================


