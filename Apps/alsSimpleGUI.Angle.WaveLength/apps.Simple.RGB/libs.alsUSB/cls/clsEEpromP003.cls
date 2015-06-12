VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsEEpromP003"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Const nCalStructs As Integer = 1
Const defaultFileNum As Integer = 1
Const nRecords As Integer = nCalStructs + 1 ' 1 more for header
Dim nLines As Integer, lines(nRecords) As Integer

Dim header As clsHeader000
Dim rgbEvalCal(nCalStructs - 1) As clsRGBevalCal000
Dim size As Integer
Dim dataTB As TextBox
Dim dataTBitems() As String

Private Sub Class_Initialize()

    Dim i As Integer, buf(1000) As Integer

    Set header = New clsHeader000
    size = header.getSize
    nLines = header.getNlines: lines(0) = nLines
    
    For i = 0 To nCalStructs - 1
        Set rgbEvalCal(i) = New clsRGBevalCal000
        size = size + rgbEvalCal(i).getSize
        lines(i + 1) = rgbEvalCal(i).getNlines
        nLines = nLines + lines(i + 1)
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

Sub setTBobj(fixed As TextBox, data As TextBox)

    Dim i As Integer

    Set dataTB = data
    header.setTBobj fixed
    For i = 0 To nCalStructs - 1
        If i = 0 Then
            rgbEvalCal(0).setTBobj data
        Else
            rgbEvalCal(1).setTBobj data, True
        End If
    Next i
    
End Sub

Sub getDataTBitems()

    dataTBitems = Split(dataTB.text, ",")

End Sub

Sub getEEprom(data() As Byte, Optional index As Integer = 0)

    index = header.getEEprom(data, index)
    index = rgbEvalCal(0).getEEprom(data, index)
    index = rgbEvalCal(1).getEEprom(data, index)
    
End Sub

Sub setEEprom(data() As Byte, Optional index As Integer = 0)

    Dim tbDataIdx As Integer, i As Integer

    index = header.setEEprom(data, index)
    
    ' load class from TextBox
    getDataTBitems
    
    For i = 0 To nCalStructs - 1
        If i = 0 Then
            tbDataIdx = rgbEvalCal(0).getTB(dataTBitems)
        Else
            rgbEvalCal(1).getTB dataTBitems, tbDataIdx
        End If
    Next i
    
    ' load image from class
    For i = 0 To nCalStructs - 1
        index = rgbEvalCal(0).setEEprom(data, index)
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

    Dim index As Integer
    
    header.setFile fileNum
    
    getDataTBitems
    
    index = rgbEvalCal(0).getTB(dataTBitems)
    rgbEvalCal(0).setFile fileNum
    
    rgbEvalCal(0).getTB dataTBitems, index
    rgbEvalCal(1).setFile fileNum
    
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
Public Function getCompensation(p As Integer) As Single
    On Error Resume Next
    getCompensation = rgbEvalCal(p).getCompensation
End Function
Public Sub setCompensation(p As Integer, ByVal value As Single)
    On Error Resume Next
    rgbEvalCal(p).setCompensation value
End Sub
' ==============================
Public Function getCardGain(p As Integer) As Single
    On Error Resume Next
    getCardGain = rgbEvalCal(p).getCardGain
End Function
Public Sub setCardGain(p As Integer, ByVal value As Single)
    On Error Resume Next
    rgbEvalCal(p).setCardGain value
End Sub
' ==============================
Public Function getRange(p As Integer, i As Integer) As Single
    On Error Resume Next
    getRange = rgbEvalCal(p).getRange(i)
End Function
Public Sub setRange(p As Integer, i As Integer, ByVal value As Single)
    On Error Resume Next
    rgbEvalCal(p).setRange i, value
End Sub
' ==============================
Public Function getTransform(p As Integer, i As Integer, j As Integer) As Single
    On Error Resume Next
    getTransform = rgbEvalCal(p).getTransform(i, j)
End Function
Public Sub setTransform(p As Integer, i As Integer, j As Integer, ByVal value As Single)
    On Error Resume Next
    rgbEvalCal(p).setTransform i, j, value
End Sub
' ==============================
