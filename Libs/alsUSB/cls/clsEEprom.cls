VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsEEprom"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Dim i2c As ucALSusb
Dim addr As Long

Dim eeImg() As Byte
Dim eeData As Object
Dim eePromVersion As Integer
Dim size As Integer
'Dim tb() As TextBox
Dim nTB As Integer
Dim byteAddr As Boolean

Const drivername As String = "registerDriver.dll"
'Const defaultFile As String = "C:\Documents and Settings\JGETCHEL\Desktop\eeprom.txt"
Const defaultFile As String = "CCMfiles\default.txt"
Const defaultFileNum As Integer = 1

Public Sub setAlsDrv(alsDrv As ucALSusb)
    Set i2c = alsDrv
End Sub


Public Sub setI2c(ByVal addrVal As eePromAddrs)
    
    If addrVal = eePromAddrs.evaluationCard Or _
        addrVal = eePromAddrs.paletteCard Or _
        addrVal = eePromAddrs.systemCard Or _
        addrVal = 0 _
    Then
        addr = addrVal
    Else
        MsgBox ("Illegal I2C Address requested in clsEEprom.setI2c" & vbCrLf & "Value Ignored")
    End If
    
End Sub

Public Function getI2c() As Integer
    getI2c = addr
End Function

Public Sub setTBobj(widget As TextBox, Optional Index As Integer = 0)
    On Error Resume Next
    eeData.setTBobj widget, Index
End Sub

Private Sub Class_Terminate()
    Set eeData = Nothing
End Sub

Public Function newEEprom(version As Integer) As Integer

    Dim i As Integer

    On Error Resume Next

    Select Case version
        Case 0: Exit Function ' No EEprom detected (or it wasn't written)
        Case eePromRevs.S001: Set eeData = New clsEEpromS001
        Case eePromRevs.E002: Set eeData = New clsEEpromE002
        Case eePromRevs.E003: Set eeData = New clsEEpromE003
        Case eePromRevs.E004: Set eeData = New clsEEpromE004
        Case eePromRevs.E005: Set eeData = New clsEEpromE005
        Case Else: MsgBox "unknown eeProm Rev in clsEEprom::newEEprom"
    End Select
    
    If version < eePromRevs.Last Then
        eeData.setEEpromVersion version
        newEEprom = eeData.getNrecords
    End If
    
End Function

Public Sub setI2c2ByteAddr(byteAddrIn As Boolean)
    byteAddr = byteAddrIn
End Sub

Private Function readI2cPage(ByVal addr As Byte, ByVal intAddr As Long, data() As Byte) As Long

    If byteAddr Then
        i2c.setI2cAddr addr
        readI2cPage = i2c.readI2cPage(intAddr, data)         ' byte address (2k prom)
    Else
        i2c.setI2cAddr addr
        readI2cPage = i2c.readI2cPage(intAddr, data, False)  ' word address (>2k)
    End If
    
End Function

Private Function writeI2cPage(ByVal i2cAddr As Byte, ByVal intAddr As Long, data() As Byte) As Long

    If byteAddr Then
        i2c.setI2cAddr addr
        writeI2cPage = i2c.writeI2cPage(intAddr, data)         ' byte address (2k prom)
    Else
        i2c.setI2cAddr addr
        writeI2cPage = i2c.writeI2cPage(intAddr, data, False)  ' word address (>2k)
    End If
    
End Function

Public Sub getEEprom(Optional cbFrm As Form = Nothing)

    On Error GoTo endSub

    If addr > 0 Then
        ReDim eeImg(1)                  ' Read Version
        
        readI2cPage addr, 0, eeImg
        
        eePromVersion = eeImg(0) * 256 + eeImg(1)
        
        newEEprom eePromVersion
        
        size = eeData.getSize
        
        ReDim eeImg(size - 1)
        
        If eePromVersion < 5 Then ' keep older versions using fragmented addressing
            modHIDusb.setPageFragmentAddr True
        Else
            modHIDusb.setPageFragmentAddr False
        End If
        
        readI2cPage addr, 0, eeImg
        
        eeData.getEEprom eeImg
            
    End If
    
    cbFrm.setEEpromObjs
    
    eeData.setTB

endSub: End Sub

Public Sub setEEprom()

    If addr > 0 Then
    
        setHeader

        size = eeData.getSize
        ReDim eeImg(size - 1)
        
        eeData.setEEprom eeImg
        writeI2cPage addr, 0, eeImg
        
    End If

End Sub

Public Sub setFile(Optional file As String = defaultFile)

    Dim i As Integer, j As Integer, k As Integer
    
    On Error GoTo endSub
    
    Open file For Output As #defaultFileNum
    
    setHeader
    eeData.setFile defaultFileNum
    
endSub: Close #1: End Sub

Public Sub getFile(Optional file As String = defaultFile, Optional cbFrm As Form = Nothing)

    On Error GoTo endSub

    Dim s As String
    Dim fileNum As Integer: fileNum = defaultFileNum
    
    If file = "" Then file = defaultFile
    If file = defaultFile Then file = App.Path & "\" & file
    
    Open file For Input As #fileNum
    
    Input #fileNum, s, eePromVersion
    newEEprom eePromVersion
    cbFrm.setEEpromObjs
    eeData.getFile fileNum

endSub: Close #fileNum: End Sub

Private Function getExeDateTime(exe As String) As Date

    Dim file As String: file = App.Path & "\" & exe
    
    If dIR(file) <> "" Then ' installer location
        getExeDateTime = FileDateTime(file)
    Else ' development location
        file = App.Path & "\..\..\output\Debug\bin\" & exe
        If dIR(file) <> "" Then getExeDateTime = FileDateTime(file)
    End If

End Function

Public Function getNrecords() As Integer
    On Error Resume Next
    getNrecords = eeData.getNrecords
End Function

Public Sub getTBlines(lines() As Integer)
    eeData.getTBlines lines
End Sub

Private Sub setHeader()
    setExeRevDate getExeDateTime(App.EXEName & ".exe")
    setDllRevDate getExeDateTime(drivername)
    setEEpromDate Now()
End Sub

' ______________________________
' ||||||||| INTERFACES |||||||||
' ==============================
' >>>>>>>>>>> HEADER <<<<<<<<<<<
' ==============================
Public Function getEEpromVersion() As Integer
    On Error Resume Next
    getEEpromVersion = eeData.getEEpromVersion
End Function
Public Sub setEEpromVersion(ByVal value As Integer)
    On Error Resume Next
    eeData.setEEpromVersion value
End Sub
' ==============================
Public Function getExeRevDate() As Date
    On Error Resume Next
    getExeRevDate = eeData.getExeRevDate
End Function
Public Sub setExeRevDate(ByVal value As Date)
    On Error Resume Next
    eeData.setExeRevDate value
End Sub
' ==============================
Public Function getDllRevDate() As Date
    On Error Resume Next
    getDllRevDate = eeData.getDllRevDate
End Function
Public Sub setDllRevDate(ByVal value As Date)
    On Error Resume Next
    eeData.setDllRevDate value
End Sub
' ==============================
Public Function getEEpromDate() As Date
    On Error Resume Next
    getEEpromDate = eeData.getEEpromDate
End Function
Public Sub setEEpromDate(ByVal value As Date)
    On Error Resume Next
    eeData.setEEpromDate value
End Sub
' ==============================
' >>>>>>>>> RGBEVALCAL <<<<<<<<<
' ==============================
Public Function getCompensation(p As Integer) As Single
    On Error Resume Next
    getCompensation = eeData.getCompensation(p)
End Function
Public Sub setCompensation(p As Integer, ByVal value As Single)
    On Error Resume Next
    eeData.setCompensation p, value
End Sub
' ==============================
Public Function getCardGain(p As Integer) As Single
    On Error GoTo error
    getCardGain = eeData.getCardGain(p)
    GoTo endFunction
error:    getCardGain = 0
endFunction: End Function
Public Sub setCardGain(p As Integer, ByVal value As Single)
    On Error Resume Next
    eeData.setCardGain p, value
End Sub
' ==============================
Public Function getRange(p As Integer, i As Integer) As Single
    On Error Resume Next
    getRange = eeData.getRange(p, i)
End Function
Public Sub setRange(p As Integer, i As Integer, ByVal value As Single)
    On Error Resume Next
    eeData.setRange p, i, value
End Sub
' ==============================
Public Function getTransform(p As Integer, i As Integer, j As Integer) As Single
    On Error Resume Next
    getTransform = eeData.getTransform(p, i, j)
End Function
Public Sub setTransform(p As Integer, i As Integer, j As Integer, ByVal value As Single)
    On Error Resume Next
    eeData.setTransform p, i, j, value
End Sub
' ==============================

