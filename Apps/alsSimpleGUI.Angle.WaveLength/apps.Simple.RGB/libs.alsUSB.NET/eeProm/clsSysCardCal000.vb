Option Strict Off
Option Explicit On
Friend Class clsSysCardCal000
	Dim size As Short
	
	Private Structure linearEqStruct
		Dim m As Single
		Dim B As Single
	End Structure
	
	Private Structure sysCardCalStruct
		<VBFixedArray(9)> Dim dac() As linearEqStruct
		
		'UPGRADE_TODO: "Initialize" must be called to initialize instances of this structure. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="B4BFF9E0-8631-45CF-910E-62AB3970F27B"'
		Public Sub Initialize()
			ReDim dac(9)
		End Sub
	End Structure
	
	'UPGRADE_WARNING: Arrays in structure sysCardCal may need to be initialized before they can be used. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="814DF224-76BD-4BB4-BFFB-EA359CB9FC48"'
	Dim sysCardCal As sysCardCalStruct
	
	'UPGRADE_NOTE: Class_Initialize was upgraded to Class_Initialize_Renamed. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="A9E4979A-37FA-4718-9994-97DD76ED70A7"'
	Private Sub Class_Initialize_Renamed()
		size = Len(sysCardCal)
	End Sub
	Public Sub New()
		MyBase.New()
		Class_Initialize_Renamed()
	End Sub
	
	Function getSize() As Short
		getSize = size
	End Function
End Class