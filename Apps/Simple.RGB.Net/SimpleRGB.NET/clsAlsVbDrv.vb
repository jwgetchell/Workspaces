Option Strict Off
Option Explicit On
Friend Class clsAlsVbDrv
	
	Private Structure BitField
		Dim addr As Short
		Dim mask As Short
		Dim shift As Short
	End Structure
	
	Private Enum eAddr
		rConfig = &H1
		rRange = 0 ' bit fields (addr 0x01)
		rResolution = 1
		rMode = 2
		rTmodes = &H1A
		r4xMode = eAddr.rMode + 1 ' bit fields (addr 0x1A)
		r8bitMode
		rNbitFields
		rComp = &H2 ' full byte
		rTM = &H0 ' full byte
		rGreen = &H9 ' full words
		rRed = &HB
		rBlue = &HD
	End Enum
	
	Private Enum RW
		eWbyte
		eRbyte
		eWword
		eRword
		eWaddr
		eRaddr
	End Enum
	
	'UPGRADE_NOTE: reg was upgraded to reg_Renamed. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="A9E4979A-37FA-4718-9994-97DD76ED70A7"'
	Dim reg_Renamed(eAddr.rNbitFields - 1) As BitField
	
	Dim image(255) As Short
	
	Dim ranges(2) As Double
	Dim resolutions(2) As Integer
	Dim rangeN As Short
	Dim resolutionN As Short
	Dim mode As Short
	
	Dim data As Integer
	
	'UPGRADE_NOTE: als was upgraded to als_Renamed. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="A9E4979A-37FA-4718-9994-97DD76ED70A7"'
	Dim als_Renamed As ucALSusb
	
	'UPGRADE_NOTE: Class_Initialize was upgraded to Class_Initialize_Renamed. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="A9E4979A-37FA-4718-9994-97DD76ED70A7"'
	Private Sub Class_Initialize_Renamed()
		
		reg_Renamed(eAddr.rMode).addr = eAddr.rConfig : reg_Renamed(eAddr.rMode).mask = 7 : reg_Renamed(eAddr.rMode).shift = 0
		reg_Renamed(eAddr.rRange).addr = eAddr.rConfig : reg_Renamed(eAddr.rRange).mask = 1 : reg_Renamed(eAddr.rRange).shift = 3
		reg_Renamed(eAddr.rResolution).addr = eAddr.rConfig : reg_Renamed(eAddr.rResolution).mask = 1 : reg_Renamed(eAddr.rResolution).shift = 4
		
		reg_Renamed(eAddr.r4xMode).addr = eAddr.rTmodes : reg_Renamed(eAddr.r4xMode).mask = 1 : reg_Renamed(eAddr.r4xMode).shift = 2
		reg_Renamed(eAddr.r8bitMode).addr = eAddr.rTmodes : reg_Renamed(eAddr.r8bitMode).mask = 1 : reg_Renamed(eAddr.r8bitMode).shift = 1
		
		ranges(0) = 375 : ranges(1) = 10250 : ranges(2) = 155
		resolutions(0) = 65535 : resolutions(1) = 4095 : resolutions(2) = 255
		
	End Sub
	Public Sub New()
		MyBase.New()
		Class_Initialize_Renamed()
	End Sub
	
	Private Sub enterTestMode()
		als_Renamed.ucHidDllCallBack(RW.eWbyte, eAddr.rTM, &H89)
		als_Renamed.ucHidDllCallBack(RW.eWbyte, eAddr.rTM, &HC9)
	End Sub
	
	Private Sub exitTestMode()
		als_Renamed.ucHidDllCallBack(RW.eWbyte, eAddr.rTM, &H0)
	End Sub
	
	Public Sub setAlsDll(ByRef dll As ucALSusb)
		als_Renamed = dll
	End Sub
	
	Public Sub setI2cAddr(ByRef addr As Integer)
		als_Renamed.ucHidDllCallBack(RW.eWaddr, addr, addr)
	End Sub
	
	Public Sub dGetRed(ByRef value As Double)
		als_Renamed.ucHidDllCallBack(RW.eRword, eAddr.rRed, data)
		data = data And resolutions(resolutionN)
		value = ranges(rangeN) * data / resolutions(resolutionN)
	End Sub
	
	Public Sub dGetGreen(ByRef value As Double)
		als_Renamed.ucHidDllCallBack(RW.eRword, eAddr.rGreen, data)
		data = data And resolutions(resolutionN)
		value = ranges(rangeN) * data / resolutions(resolutionN)
	End Sub
	
	Public Sub dGetBlue(ByRef value As Double)
		als_Renamed.ucHidDllCallBack(RW.eRword, eAddr.rBlue, data)
		data = data And resolutions(resolutionN)
		value = ranges(rangeN) * data / resolutions(resolutionN)
	End Sub
	
	Private Sub rmwConfig(ByRef regIn As BitField, ByRef value As Integer)
		Dim Config As Integer : Config = image(regIn.addr)
		Config = Config And (255 - regIn.mask * 2 ^ regIn.shift)
		value = value And regIn.mask
		Config = Config Or (value * 2 ^ regIn.shift)
		als_Renamed.ucHidDllCallBack(RW.eWbyte, regIn.addr, Config)
		image(regIn.addr) = Config
	End Sub
	
	Public Sub dSetInputSelect(ByVal chan As Integer, ByVal value As Integer)
		'UPGRADE_NOTE: val was upgraded to val_Renamed. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="A9E4979A-37FA-4718-9994-97DD76ED70A7"'
		Dim val_Renamed As Integer
		'value={OFF,ALS,RGB}
		val_Renamed = value : If value = 2 Then val_Renamed = 5
		rmwConfig(reg_Renamed(eAddr.rMode), val_Renamed)
	End Sub
	
	Public Sub dSetIRcomp(ByVal value As Integer)
		als_Renamed.ucHidDllCallBack(RW.eWbyte, eAddr.rComp, value And 255)
	End Sub
	Public Sub dGetIRcomp(ByRef value As Integer)
		als_Renamed.ucHidDllCallBack(RW.eRbyte, eAddr.rComp, value)
	End Sub
	
	Public Sub dSetRange(ByVal chan As Integer, ByVal value As Integer)
		
		If value < 2 Then
			rmwConfig(reg_Renamed(eAddr.rRange), value)
			enterTestMode()
			als_Renamed.ucHidDllCallBack(RW.eWbyte, &H1C, &H0) ' reset gain to 1
			als_Renamed.ucHidDllCallBack(RW.eWbyte, &H19, &H0) ' return to fuse mode
			exitTestMode()
		Else
			' |||| Test Mode ||||
			value = 2
			rmwConfig(reg_Renamed(eAddr.rRange), 0)
			enterTestMode()
			als_Renamed.ucHidDllCallBack(RW.eWbyte, &H19, &H40) ' switch to register mode
			als_Renamed.ucHidDllCallBack(RW.eWbyte, &H1C, &H2) ' set gain to Max (2.3)
			exitTestMode()
		End If
		
		rangeN = value
		
	End Sub
	
	Public Function dGetRange(ByVal chan As Integer, ByRef value As Integer) As Integer
		value = rangeN
	End Function
	
	Public Sub dSetResolution(ByVal chan As Integer, ByVal value As Integer)
		
		Static lastValue As Integer
		
		If value < 2 Then
			If lastValue = 2 Then
				enterTestMode()
				rmwConfig(reg_Renamed(eAddr.r8bitMode), 0)
				exitTestMode()
			End If
			
			rmwConfig(reg_Renamed(eAddr.rResolution), value)
			
		Else
			enterTestMode()
			rmwConfig(reg_Renamed(eAddr.r8bitMode), 1)
			exitTestMode()
			value = 2
		End If
		
		resolutionN = value
		lastValue = value
		
	End Sub
	
	Public Function dGetResolution(ByVal chan As Integer, ByRef value As Integer) As Integer
		value = resolutionN
	End Function
	
	Public Sub dEnable4x(ByRef value As Integer)
		enterTestMode()
		rmwConfig(reg_Renamed(eAddr.r4xMode), value)
		exitTestMode()
	End Sub
	Public Sub dEnable8bit(ByRef value As Integer)
		enterTestMode()
		rmwConfig(reg_Renamed(eAddr.r4xMode), 0)
		exitTestMode()
	End Sub
	
	
	
	
	Public Function dGetNrange(ByVal chan As Integer, ByRef value As Integer) As Integer
		Debug.Print("h")
		als_Renamed.dGetNrange(0, value)
	End Function
	Public Sub dGetRangeList(ByVal chan As Integer, ByRef list As Integer)
		als_Renamed.dGetRangeList(0, list)
	End Sub
	
	Public Function dGetNresolution(ByVal chan As Integer, ByRef value As Integer) As Integer
		als_Renamed.dGetNresolution(0, value)
	End Function
	Public Sub dGetResolutionList(ByVal chan As Integer, ByRef list As Integer)
		als_Renamed.dGetResolutionList(0, list)
	End Sub
	
	
	
	Public Function getEEpromObj() As clsEEprom
		getEEpromObj = als_Renamed.getEEpromObj
	End Function
	
	Public Sub dWriteField(ByVal a As Byte, ByVal s As Byte, ByVal m As Byte, ByVal D As Byte)
		Dim bVal As BitField
		Dim data As Integer : data = D
		bVal.addr = a : bVal.shift = s : bVal.mask = m
		rmwConfig(bVal, data)
		D = data And 255
	End Sub
	
	Public Sub dReadField(ByVal a As Byte, ByVal s As Byte, ByVal m As Byte, ByRef D As Byte)
		Dim data As Integer : data = D
		als_Renamed.ucHidDllCallBack(RW.eRbyte, a, data)
		D = (data * 2 ^ -s) And m
	End Sub
End Class