Option Strict Off
Option Explicit On
Module als
	'Option Explicit
	
	'UPGRADE_NOTE: als was upgraded to als_Renamed. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="A9E4979A-37FA-4718-9994-97DD76ED70A7"'
	Dim als_Renamed As Object 'ucALSusb
	Public gRGBdev As String
	
	Public invertCompMSB As Short
	
	Dim EEprom As clsEEprom
	
	Const dllLimit As Short = 32
	
	Public Sub init()
		Dim frmMain As Object
		Dim frmSimpleRGB As Object
		
		On Error GoTo tryAgain
		als_Renamed = frmAlsDrv.ucALSusb1
		'UPGRADE_WARNING: Couldn't resolve default property of object frmSimpleRGB.hideDebug. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		frmSimpleRGB.hideDebug = True
		GoTo success
tryAgain: 
		'UPGRADE_WARNING: Couldn't resolve default property of object frmMain.ucALSusb1. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		als_Renamed = frmMain.ucALSusb1
success: 
		
		'UPGRADE_WARNING: Couldn't resolve default property of object als_Renamed.setI2cAddr. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		als_Renamed.setI2cAddr(&H88)
		'UPGRADE_WARNING: Couldn't resolve default property of object als_Renamed.setDevice. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		als_Renamed.setDevice("ISL29125")
		
		If setOSintSize > dllLimit Then
			als_Renamed = New clsAlsVbDrv
			'UPGRADE_WARNING: Couldn't resolve default property of object als_Renamed.setI2cAddr. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
			als_Renamed.setI2cAddr(&H88) ' 125 driver is embedded
			'UPGRADE_WARNING: Couldn't resolve default property of object als_Renamed.setAlsDll. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
			als_Renamed.setAlsDll(frmAlsDrv.ucALSusb1)
		Else
			'UPGRADE_WARNING: Couldn't resolve default property of object als_Renamed.setI2cAddr. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
			als_Renamed.setI2cAddr(&H88)
			'UPGRADE_WARNING: Couldn't resolve default property of object als_Renamed.setDevice. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
			als_Renamed.setDevice("ISL29125")
		End If
		
	End Sub
	
	Public Sub dGetRed(ByRef value As Double)
		'UPGRADE_WARNING: Couldn't resolve default property of object als_Renamed.dGetRed. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		als_Renamed.dGetRed(value)
	End Sub
	
	Public Sub dGetGreen(ByRef value As Double)
		'UPGRADE_WARNING: Couldn't resolve default property of object als_Renamed.dGetGreen. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		als_Renamed.dGetGreen(value)
	End Sub
	
	Public Sub dGetBlue(ByRef value As Double)
		'UPGRADE_WARNING: Couldn't resolve default property of object als_Renamed.dGetBlue. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		als_Renamed.dGetBlue(value)
	End Sub
	
	Public Sub dSetRange(ByVal value As Integer)
		'UPGRADE_WARNING: Couldn't resolve default property of object als_Renamed.dSetRange. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		als_Renamed.dSetRange(0, value)
	End Sub
	
	Public Sub dSetInputSelect(ByVal value As Integer)
		'value={OFF,ALS,RGB}
		'UPGRADE_WARNING: Couldn't resolve default property of object als_Renamed.dSetInputSelect. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		als_Renamed.dSetInputSelect(0, value)
	End Sub
	
	Public Sub dSetIRcomp(ByVal value As Integer)
		'UPGRADE_WARNING: Couldn't resolve default property of object als_Renamed.dSetIRcomp. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		als_Renamed.dSetIRcomp(value Xor invertCompMSB)
	End Sub
	
	Public Sub dGetIRcomp(ByRef value As Integer)
		'UPGRADE_WARNING: Couldn't resolve default property of object als_Renamed.dGetIRcomp. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		als_Renamed.dGetIRcomp(value)
	End Sub
	Public Sub dEnable4x(ByRef value As Integer)
		'UPGRADE_WARNING: Couldn't resolve default property of object als_Renamed.dEnable4x. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		als_Renamed.dEnable4x(value)
	End Sub
	Public Sub dEnable8bit(ByRef value As Integer)
		'UPGRADE_WARNING: Couldn't resolve default property of object als_Renamed.dEnable8bit. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		als_Renamed.dEnable8bit(value)
	End Sub
	Public Sub dSetResolution(ByRef value As Integer)
		'UPGRADE_WARNING: Couldn't resolve default property of object als_Renamed.dSetResolution. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		als_Renamed.dSetResolution(0, value)
	End Sub
	
	
	
	Public Function dGetRange() As Integer
		'UPGRADE_WARNING: Couldn't resolve default property of object als_Renamed.dGetRange. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		als_Renamed.dGetRange(0, dGetRange)
	End Function
	Public Function dGetResolution() As Integer
		'UPGRADE_WARNING: Couldn't resolve default property of object als_Renamed.dGetResolution. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		als_Renamed.dGetResolution(0, dGetResolution)
	End Function
	
	
	
	Public Function dGetNrange() As Integer
		'UPGRADE_WARNING: Couldn't resolve default property of object als_Renamed.dGetNrange. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		als_Renamed.dGetNrange(0, dGetNrange)
	End Function
	Public Sub dGetRangeList(ByRef list As Integer)
		'UPGRADE_WARNING: Couldn't resolve default property of object als_Renamed.dGetRangeList. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		als_Renamed.dGetRangeList(0, list)
	End Sub
	
	Public Function dGetNresolution() As Integer
		'UPGRADE_WARNING: Couldn't resolve default property of object als_Renamed.dGetNresolution. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		als_Renamed.dGetNresolution(0, dGetNresolution)
	End Function
	Public Sub dGetResolutionList(ByRef list As Integer)
		'UPGRADE_WARNING: Couldn't resolve default property of object als_Renamed.dGetResolutionList. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		als_Renamed.dGetResolutionList(0, list)
	End Sub
	
	
	
	Public Function getEEpromObj() As clsEEprom
		'UPGRADE_WARNING: Couldn't resolve default property of object als_Renamed.getEEpromObj. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		getEEpromObj = als_Renamed.getEEpromObj
	End Function
	
	Public Sub writeField(ByVal a As Byte, ByVal s As Byte, ByVal m As Byte, ByVal D As Byte)
		'UPGRADE_WARNING: Couldn't resolve default property of object als_Renamed.dWriteField. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		als_Renamed.dWriteField(a, s, m, D)
	End Sub
	
	Public Function readField(ByVal a As Byte, ByVal s As Byte, ByVal m As Byte) As Byte
		'UPGRADE_WARNING: Couldn't resolve default property of object als_Renamed.dReadField. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		als_Renamed.dReadField(a, s, m, readField)
	End Function
End Module