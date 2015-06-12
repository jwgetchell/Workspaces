Option Strict Off
Option Explicit On
Friend Class clsEEprom
	Dim i2c As ucALSusb
	Dim addr As Integer
	
	Dim eeImg() As Byte
	Dim eeData As Object
	Dim eePromVersion As Short
	Dim size As Short
	'Dim tb() As TextBox
	Dim nTB As Short
	Dim byteAddr As Boolean
	
	Const drivername As String = "registerDriver.dll"
	'Const defaultFile As String = "C:\Documents and Settings\JGETCHEL\Desktop\eeprom.txt"
	Const defaultFile As String = "CCMfiles\default.txt"
	Const defaultFileNum As Short = 1
	
	Public Sub setAlsDrv(ByRef alsDrv As ucALSusb)
		i2c = alsDrv
	End Sub
	
	
	Public Sub setI2c(ByVal addrVal As modEEprom.eePromAddrs)
		
		If addrVal = modEEprom.eePromAddrs.evaluationCard Or addrVal = modEEprom.eePromAddrs.paletteCard Or addrVal = modEEprom.eePromAddrs.systemCard Or addrVal = 0 Then
			addr = addrVal
		Else
			MsgBox("Illegal I2C Address requested in clsEEprom.setI2c" & vbCrLf & "Value Ignored")
		End If
		
	End Sub
	
	Public Function getI2c() As Short
		getI2c = addr
	End Function
	
	Public Sub setTBobj(ByRef widget As System.Windows.Forms.TextBox, Optional ByRef Index As Short = 0)
		On Error Resume Next
		'UPGRADE_WARNING: Couldn't resolve default property of object eeData.setTBobj. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		eeData.setTBobj(widget, Index)
	End Sub
	
	'UPGRADE_NOTE: Class_Terminate was upgraded to Class_Terminate_Renamed. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="A9E4979A-37FA-4718-9994-97DD76ED70A7"'
	Private Sub Class_Terminate_Renamed()
		'UPGRADE_NOTE: Object eeData may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		eeData = Nothing
	End Sub
	Protected Overrides Sub Finalize()
		Class_Terminate_Renamed()
		MyBase.Finalize()
	End Sub
	
	Public Function newEEprom(ByRef version As Short) As Short
		
		Dim i As Short
		
		On Error Resume Next
		
		Select Case version
			Case 0 : Exit Function ' No EEprom detected (or it wasn't written)
			Case modEEprom.eePromRevs.S001 : eeData = New clsEEpromS001
			Case modEEprom.eePromRevs.E002 : eeData = New clsEEpromE002
			Case modEEprom.eePromRevs.E003 : eeData = New clsEEpromE003
			Case modEEprom.eePromRevs.E004 : eeData = New clsEEpromE004
			Case Else : MsgBox("unknown eeProm Rev in clsEEprom::newEEprom")
		End Select
		
		If version < modEEprom.eePromRevs.Last Then
			'UPGRADE_WARNING: Couldn't resolve default property of object eeData.setEEpromVersion. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
			eeData.setEEpromVersion(version)
			'UPGRADE_WARNING: Couldn't resolve default property of object eeData.getNrecords. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
			newEEprom = eeData.getNrecords
		End If
		
	End Function
	
	Public Sub setI2c2ByteAddr(ByRef byteAddrIn As Boolean)
		byteAddr = byteAddrIn
	End Sub
	
	Private Function readI2cPage(ByVal addr As Byte, ByVal intAddr As Integer, ByRef data() As Byte) As Integer
		
		If byteAddr Then
			readI2cPage = i2c.readI2cPage(addr, intAddr, data) ' byte address (2k prom)
		Else
			readI2cPage = i2c.readI2cPage(addr, intAddr, data, False) ' word address (>2k)
		End If
		
	End Function
	
	Private Function writeI2cPage(ByVal i2cAddr As Byte, ByVal intAddr As Integer, ByRef data() As Byte) As Integer
		
		If byteAddr Then
			writeI2cPage = i2c.writeI2cPage(addr, intAddr, data) ' byte address (2k prom)
		Else
			writeI2cPage = i2c.writeI2cPage(addr, intAddr, data, False) ' word address (>2k)
		End If
		
	End Function
	
	Public Sub getEEprom(Optional ByRef cbFrm As System.Windows.Forms.Form = Nothing)
		
		On Error GoTo endSub
		
		If addr > 0 Then
			ReDim eeImg(1) ' Read Version
			
			readI2cPage(addr, 0, eeImg)
			
			eePromVersion = eeImg(0) * 256 + eeImg(1)
			
			newEEprom(eePromVersion)
			
			'UPGRADE_WARNING: Couldn't resolve default property of object eeData.getSize. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
			size = eeData.getSize
			
			ReDim eeImg(size - 1)
			readI2cPage(addr, 0, eeImg)
			
			'UPGRADE_WARNING: Couldn't resolve default property of object eeData.getEEprom. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
			eeData.getEEprom(eeImg)
			
		End If
		
		'UPGRADE_ISSUE: Control setEEpromObjs could not be resolved because it was within the generic namespace Form. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="084D22AD-ECB1-400F-B4C7-418ECEC5E36E"'
		cbFrm.setEEpromObjs()
		
		'UPGRADE_WARNING: Couldn't resolve default property of object eeData.setTB. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		eeData.setTB()
		
endSub: 
	End Sub
	
	Public Sub setEEprom()
		
		If addr > 0 Then
			
			setHeader()
			
			'UPGRADE_WARNING: Couldn't resolve default property of object eeData.getSize. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
			size = eeData.getSize
			ReDim eeImg(size - 1)
			
			'UPGRADE_WARNING: Couldn't resolve default property of object eeData.setEEprom. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
			eeData.setEEprom(eeImg)
			writeI2cPage(addr, 0, eeImg)
			
		End If
		
	End Sub
	
	Public Sub setFile(Optional ByRef file As String = defaultFile)
		
		Dim j, i, k As Short
		
		On Error GoTo endSub
		
		FileOpen(defaultFileNum, file, OpenMode.Output)
		
		setHeader()
		'UPGRADE_WARNING: Couldn't resolve default property of object eeData.setFile. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		eeData.setFile(defaultFileNum)
		
endSub: FileClose(1)
	End Sub
	
	Public Sub getFile(Optional ByRef file As String = defaultFile, Optional ByRef cbFrm As System.Windows.Forms.Form = Nothing)
		
		On Error GoTo endSub
		
		Dim s As String
		Dim fileNum As Short : fileNum = defaultFileNum
		
		If file = "" Then file = defaultFile
		If file = defaultFile Then file = My.Application.Info.DirectoryPath & "\" & file
		
		FileOpen(fileNum, file, OpenMode.Input)
		
		Input(fileNum, s)
		Input(fileNum, eePromVersion)
		newEEprom(eePromVersion)
		'UPGRADE_ISSUE: Control setEEpromObjs could not be resolved because it was within the generic namespace Form. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="084D22AD-ECB1-400F-B4C7-418ECEC5E36E"'
		cbFrm.setEEpromObjs()
		'UPGRADE_WARNING: Couldn't resolve default property of object eeData.getFile. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		eeData.getFile(fileNum)
		
endSub: FileClose(fileNum)
	End Sub
	
	Private Function getExeDateTime(ByRef exe As String) As Date
		
		Dim file As String : file = My.Application.Info.DirectoryPath & "\" & exe
		
		'UPGRADE_WARNING: Dir has a new behavior. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="9B7D5ADD-D8FE-4819-A36C-6DEDAF088CC7"'
		If Dir(file) <> "" Then ' installer location
			getExeDateTime = FileDateTime(file)
		Else ' development location
			file = My.Application.Info.DirectoryPath & "\..\..\output\Debug\bin\" & exe
			'UPGRADE_WARNING: Dir has a new behavior. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="9B7D5ADD-D8FE-4819-A36C-6DEDAF088CC7"'
			If Dir(file) <> "" Then getExeDateTime = FileDateTime(file)
		End If
		
	End Function
	
	Public Function getNrecords() As Short
		On Error Resume Next
		'UPGRADE_WARNING: Couldn't resolve default property of object eeData.getNrecords. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		getNrecords = eeData.getNrecords
	End Function
	
	Public Sub getTBlines(ByRef lines() As Short)
		'UPGRADE_WARNING: Couldn't resolve default property of object eeData.getTBlines. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		eeData.getTBlines(lines)
	End Sub
	
	Private Sub setHeader()
		'UPGRADE_WARNING: App property App.EXEName has a new behavior. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6BA9B8D2-2A32-4B6E-8D36-44949974A5B4"'
		setExeRevDate(getExeDateTime(My.Application.Info.AssemblyName & ".exe"))
		setDllRevDate(getExeDateTime(drivername))
		setEEpromDate(Now)
	End Sub
	
	' ______________________________
	' ||||||||| INTERFACES |||||||||
	' ==============================
	' >>>>>>>>>>> HEADER <<<<<<<<<<<
	' ==============================
	Public Function getEEpromVersion() As Short
		On Error Resume Next
		'UPGRADE_WARNING: Couldn't resolve default property of object eeData.getEEpromVersion. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		getEEpromVersion = eeData.getEEpromVersion
	End Function
	Public Sub setEEpromVersion(ByVal value As Short)
		On Error Resume Next
		'UPGRADE_WARNING: Couldn't resolve default property of object eeData.setEEpromVersion. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		eeData.setEEpromVersion(value)
	End Sub
	' ==============================
	Public Function getExeRevDate() As Date
		On Error Resume Next
		'UPGRADE_WARNING: Couldn't resolve default property of object eeData.getExeRevDate. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		getExeRevDate = eeData.getExeRevDate
	End Function
	Public Sub setExeRevDate(ByVal value As Date)
		On Error Resume Next
		'UPGRADE_WARNING: Couldn't resolve default property of object eeData.setExeRevDate. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		eeData.setExeRevDate(value)
	End Sub
	' ==============================
	Public Function getDllRevDate() As Date
		On Error Resume Next
		'UPGRADE_WARNING: Couldn't resolve default property of object eeData.getDllRevDate. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		getDllRevDate = eeData.getDllRevDate
	End Function
	Public Sub setDllRevDate(ByVal value As Date)
		On Error Resume Next
		'UPGRADE_WARNING: Couldn't resolve default property of object eeData.setDllRevDate. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		eeData.setDllRevDate(value)
	End Sub
	' ==============================
	Public Function getEEpromDate() As Date
		On Error Resume Next
		'UPGRADE_WARNING: Couldn't resolve default property of object eeData.getEEpromDate. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		getEEpromDate = eeData.getEEpromDate
	End Function
	Public Sub setEEpromDate(ByVal value As Date)
		On Error Resume Next
		'UPGRADE_WARNING: Couldn't resolve default property of object eeData.setEEpromDate. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		eeData.setEEpromDate(value)
	End Sub
	' ==============================
	' >>>>>>>>> RGBEVALCAL <<<<<<<<<
	' ==============================
	Public Function getCompensation(ByRef p As Short) As Single
		On Error Resume Next
		'UPGRADE_WARNING: Couldn't resolve default property of object eeData.getCompensation. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		getCompensation = eeData.getCompensation(p)
	End Function
	Public Sub setCompensation(ByRef p As Short, ByVal value As Single)
		On Error Resume Next
		'UPGRADE_WARNING: Couldn't resolve default property of object eeData.setCompensation. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		eeData.setCompensation(p, value)
	End Sub
	' ==============================
	Public Function getCardGain(ByRef p As Short) As Single
		On Error GoTo error_Renamed
		'UPGRADE_WARNING: Couldn't resolve default property of object eeData.getCardGain. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		getCardGain = eeData.getCardGain(p)
		GoTo endFunction
error_Renamed: getCardGain = 0
endFunction: 
	End Function
	Public Sub setCardGain(ByRef p As Short, ByVal value As Single)
		On Error Resume Next
		'UPGRADE_WARNING: Couldn't resolve default property of object eeData.setCardGain. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		eeData.setCardGain(p, value)
	End Sub
	' ==============================
	Public Function getRange(ByRef p As Short, ByRef i As Short) As Single
		On Error Resume Next
		'UPGRADE_WARNING: Couldn't resolve default property of object eeData.getRange. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		getRange = eeData.getRange(p, i)
	End Function
	Public Sub setRange(ByRef p As Short, ByRef i As Short, ByVal value As Single)
		On Error Resume Next
		'UPGRADE_WARNING: Couldn't resolve default property of object eeData.setRange. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		eeData.setRange(p, i, value)
	End Sub
	' ==============================
	Public Function getTransform(ByRef p As Short, ByRef i As Short, ByRef j As Short) As Single
		On Error Resume Next
		'UPGRADE_WARNING: Couldn't resolve default property of object eeData.getTransform. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		getTransform = eeData.getTransform(p, i, j)
	End Function
	Public Sub setTransform(ByRef p As Short, ByRef i As Short, ByRef j As Short, ByVal value As Single)
		On Error Resume Next
		'UPGRADE_WARNING: Couldn't resolve default property of object eeData.setTransform. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		eeData.setTransform(p, i, j, value)
	End Sub
	' ==============================
End Class