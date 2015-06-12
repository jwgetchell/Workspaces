VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsHeader002"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
'||==============================================================||
'||                                                              ||
'|| Header class for System, Palette & Customer Evaluation Cards ||
'||                                                              ||
'||==============================================================||

Dim size As Integer

Private Type headerStruct
    eePromVersion As Integer ' selects struct version
    pad(5) As Byte
    exeRevDate As Date
    dllRevDate As Date
    EEpromDate As Date
End Type

Dim header As headerStruct

Dim tb As TextBox

Const nLines As Integer = 4

Public Function getNlines() As Integer
    getNlines = nLines
End Function

Public Sub setTBobj(value As TextBox)
    Set tb = value
End Sub

Private Sub Class_Initialize()
    size = Len(header)
End Sub

Function getSize() As Integer
    getSize = size
End Function


'||==================||
'|| Data pack/unpack ||
'||==================||
Function getEEprom(data() As Byte, Optional ByVal Index As Integer = 0) As Integer
    Dim s As Single: s = Len(header.exeRevDate)
    
    header.eePromVersion = data(Index) * 256 + data(Index + 1): Index = Index + 2
    
    Index = 8
    
    Index = byte2date(data, header.exeRevDate, Index)
    Index = byte2date(data, header.dllRevDate, Index)
    Index = byte2date(data, header.EEpromDate, Index)
    
    getEEprom = Index
    
    setTB
    
End Function

Function setEEprom(data() As Byte, Optional ByVal Index As Integer = 0) As Integer
    Dim s As Single: s = Len(header.exeRevDate)
    
    data(Index) = (header.eePromVersion And &HFF00) / 256: Index = Index + 1
    data(Index) = (header.eePromVersion And &HFF): Index = Index + 1
    
    Index = 8
    
    Index = date2byte(header.exeRevDate, data, Index)
    Index = date2byte(header.dllRevDate, data, Index)
    Index = date2byte(header.EEpromDate, data, Index)
    
    setTB
    
    setEEprom = Index
End Function


'||==========||
'|| File I/O ||
'||==========||
Public Sub getFile(n As Integer)

    Dim s As String, d As Date
    
    On Error GoTo endFunction
    
    ' Starts AFTER EEpromVersion
    Input #n, s, s, d: setExeRevDate d
    Input #n, s, s, d: setDllRevDate d
    Input #n, s, s, d: setEEpromDate d
    
    setTB
        
endFunction: End Sub

Public Sub setFile(n As Integer)

    Write #n, "EEpromVersion", getEEpromVersion,: Print #n, ""
    Write #n, "ExeRevDate", getExeRevDate,: Print #n, ""
    Write #n, "DllRevDate", getDllRevDate,: Print #n, ""
    Write #n, "EEpromDate", getEEpromDate,: Print #n, ""
    
    setTB
    
End Sub

Public Sub setTB()
    If Not (tb Is Nothing) Then
        tb.text = Chr(&H22) & "EEpromVersion" & Chr(&H22) & Chr(&H2C)
        tb.text = tb.text & getEEpromVersion & vbCrLf
        
        tb.text = tb.text & Chr(&H22) & "ExeRevDate" & Chr(&H22) & Chr(&H2C)
        tb.text = tb.text & "#" & getExeRevDate & "#" & vbCrLf
        
        tb.text = tb.text & Chr(&H22) & "DllRevDate" & Chr(&H22) & Chr(&H2C)
        tb.text = tb.text & "#" & getDllRevDate & "#" & vbCrLf
        
        tb.text = tb.text & Chr(&H22) & "EEpromDate" & Chr(&H22) & Chr(&H2C)
        tb.text = tb.text & "#" & getEEpromDate & "#" & vbCrLf
    End If
End Sub



' ______________________________
' ||||||||| INTERFACES |||||||||
Public Function getEEpromVersion() As Integer
    On Error Resume Next
    getEEpromVersion = header.eePromVersion
End Function
Public Sub setEEpromVersion(ByVal value As Integer)
    On Error Resume Next
    header.eePromVersion = value
End Sub
' ==============================
Public Function getExeRevDate() As Date
    On Error Resume Next
    getExeRevDate = header.exeRevDate
End Function
Public Sub setExeRevDate(ByVal value As Date)
    On Error Resume Next
    header.exeRevDate = value
End Sub
' ==============================
Public Function getDllRevDate() As Date
    On Error Resume Next
    getDllRevDate = header.dllRevDate
End Function
Public Sub setDllRevDate(ByVal value As Date)
    On Error Resume Next
    header.dllRevDate = value
End Sub
' ==============================
Public Function getEEpromDate() As Date
    On Error Resume Next
    getEEpromDate = header.EEpromDate
End Function
Public Sub setEEpromDate(ByVal value As Date)
    On Error Resume Next
    header.EEpromDate = value
End Sub
' ==============================



