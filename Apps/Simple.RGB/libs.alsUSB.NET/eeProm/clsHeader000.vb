Option Strict Off
Option Explicit On
Friend Class clsHeader000
	'||==============================================================||
	'||                                                              ||
	'|| Header class for System, Palette & Customer Evaluation Cards ||
	'||                                                              ||
	'||==============================================================||
	
	Dim size As Short
	
	Private Structure headerStruct
		Dim eePromVersion As Short ' selects struct version
		'    exeRevDate As Date
		'    dllRevDate As Date
		'    EEpromDate As Date
	End Structure
	
	Dim header As headerStruct
	
	Dim tb As System.Windows.Forms.TextBox
	
	Const nLines As Short = 1
	
	Public Function getNlines() As Short
		getNlines = nLines
	End Function
	
	Public Sub setTBobj(ByRef value As System.Windows.Forms.TextBox)
		tb = value
		setTB()
	End Sub
	
	'UPGRADE_NOTE: Class_Initialize was upgraded to Class_Initialize_Renamed. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="A9E4979A-37FA-4718-9994-97DD76ED70A7"'
	Private Sub Class_Initialize_Renamed()
		size = Len(header)
	End Sub
	Public Sub New()
		MyBase.New()
		Class_Initialize_Renamed()
	End Sub
	
	Function getSize() As Short
		getSize = size
	End Function
	
	
	'||==================||
	'|| Data pack/unpack ||
	'||==================||
	Function getEEprom(ByRef data() As Byte, Optional ByVal Index As Short = 0) As Short
		'Dim s As Single: s = Len(header.exeRevDate)
		
		header.eePromVersion = data(Index) * 256 + data(Index + 1) : Index = Index + 2
		
		'    index = byte2date(data, header.exeRevDate, index)
		'    index = byte2date(data, header.dllRevDate, index)
		'    index = byte2date(data, header.EEpromDate, index)
		
		getEEprom = Index
		
		setTB()
		
	End Function
	
	Function setEEprom(ByRef data() As Byte, Optional ByVal Index As Short = 0) As Short
		'Dim s As Single: s = Len(header.exeRevDate)
		
		data(Index) = CShort(header.eePromVersion And &HFF00) / 256 : Index = Index + 1
		data(Index) = (header.eePromVersion And &HFF) : Index = Index + 1
		
		'    index = date2byte(header.exeRevDate, data, index)
		'    index = date2byte(header.dllRevDate, data, index)
		'    index = date2byte(header.EEpromDate, data, index)
		
		setTB()
		
		setEEprom = Index
	End Function
	
	
	'||==========||
	'|| File I/O ||
	'||==========||
	Public Sub getFile(ByRef N As Short)
		
		Dim s As String
		Dim D As Date
		
		On Error GoTo EndFunction
		
		' Starts AFTER EEpromVersion
		'    Input #N, s, s, D: setExeRevDate D
		'    Input #N, s, s, D: setDllRevDate D
		'    Input #N, s, s, D: setEEpromDate D
		
		setTB()
		
EndFunction: 
	End Sub
	
	Public Sub setFile(ByRef N As Short)
		
		Write(N, "EEpromVersion", getEEpromVersion) : PrintLine(N, "")
		'    Write #N, "ExeRevDate", getExeRevDate,: Print #N, ""
		'    Write #N, "DllRevDate", getDllRevDate,: Print #N, ""
		'    Write #N, "EEpromDate", getEEpromDate,: Print #N, ""
		
		setTB()
		
	End Sub
	
	Public Sub setTB()
		On Error Resume Next
		If Not (tb Is Nothing) Then
			tb.Text = Chr(&H22) & "EEpromVersion" & Chr(&H22) & Chr(&H2C)
			tb.Text = tb.Text & getEEpromVersion & vbCrLf
			
			tb.Text = tb.Text & Chr(&H22) & "ExeRevDate" & Chr(&H22) & Chr(&H2C)
			tb.Text = tb.Text & "#" & getExeRevDate & "#" & vbCrLf
			
			tb.Text = tb.Text & Chr(&H22) & "DllRevDate" & Chr(&H22) & Chr(&H2C)
			tb.Text = tb.Text & "#" & getDllRevDate & "#" & vbCrLf
			
			tb.Text = tb.Text & Chr(&H22) & "EEpromDate" & Chr(&H22) & Chr(&H2C)
			tb.Text = tb.Text & "#" & getEEpromDate & "#" & vbCrLf
		End If
	End Sub
	
	
	
	' ______________________________
	' ||||||||| INTERFACES |||||||||
	Public Function getEEpromVersion() As Short
		On Error Resume Next
		getEEpromVersion = header.eePromVersion
	End Function
	Public Sub setEEpromVersion(ByVal value As Short)
		On Error Resume Next
		header.eePromVersion = value
	End Sub
	' ==============================
	Public Function getExeRevDate() As Date
		On Error Resume Next
		'getExeRevDate = header.exeRevDate
	End Function
	Public Sub setExeRevDate(ByVal value As Date)
		On Error Resume Next
		'header.exeRevDate = value
	End Sub
	' ==============================
	Public Function getDllRevDate() As Date
		On Error Resume Next
		'getDllRevDate = header.dllRevDate
	End Function
	Public Sub setDllRevDate(ByVal value As Date)
		On Error Resume Next
		'header.dllRevDate = value
	End Sub
	' ==============================
	Public Function getEEpromDate() As Date
		On Error Resume Next
		'getEEpromDate = header.EEpromDate
	End Function
	Public Sub setEEpromDate(ByVal value As Date)
		On Error Resume Next
		'header.EEpromDate = value
	End Sub
	' ==============================
End Class