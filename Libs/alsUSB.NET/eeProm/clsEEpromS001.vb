Option Strict Off
Option Explicit On
Friend Class clsEEpromS001
	Dim header As clsHeader000
	Dim sysCardCal As clsSysCardCal000
	Dim size As Short
	
	Dim tb(1) As System.Windows.Forms.TextBox
	
	Public Sub setTBobj(ByRef tb0 As System.Windows.Forms.TextBox, ByRef tb1 As System.Windows.Forms.TextBox)
		tb(0) = tb0
		tb(1) = tb1
	End Sub
	
	Function getSize() As Short
		getSize = size
	End Function
	
	'UPGRADE_NOTE: Class_Initialize was upgraded to Class_Initialize_Renamed. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="A9E4979A-37FA-4718-9994-97DD76ED70A7"'
	Private Sub Class_Initialize_Renamed()
		header = New clsHeader000
		sysCardCal = New clsSysCardCal000
		
		size = header.getSize
		size = size + sysCardCal.getSize
	End Sub
	Public Sub New()
		MyBase.New()
		Class_Initialize_Renamed()
	End Sub
End Class