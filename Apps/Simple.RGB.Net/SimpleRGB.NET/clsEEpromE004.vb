Option Strict Off
Option Explicit On
Friend Class clsEEpromE004
	Const nCalStructs As Short = 1 ' <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
	Const defaultFileNum As Short = 1
	Const nRecords As Short = nCalStructs + 1 ' 1 more for header
	Dim nLines As Short
	Dim lines(nRecords) As Short
	
	' ==== Structs ====================================
	Dim header As clsHeader001 ' <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
	Dim rgbEvalCal(nCalStructs - 1) As clsRGBevalCal001 ' <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
	' =================================================
	
	Dim size As Short
	Dim dataTBitems() As String
	
	'UPGRADE_NOTE: Class_Initialize was upgraded to Class_Initialize_Renamed. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="A9E4979A-37FA-4718-9994-97DD76ED70A7"'
	Private Sub Class_Initialize_Renamed()
		
		Dim i As Short
		Dim buf(1000) As Short
		
		header = New clsHeader001 ' <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
		size = header.getSize
		nLines = header.getNlines : lines(0) = nLines
		
		For i = 0 To nCalStructs - 1
			rgbEvalCal(i) = New clsRGBevalCal001 ' <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
			size = size + rgbEvalCal(i).getSize
			lines(i + 1) = rgbEvalCal(i).getNlines
			nLines = nLines + lines(i + 1)
		Next i
		
	End Sub
	Public Sub New()
		MyBase.New()
		Class_Initialize_Renamed()
	End Sub
	
	'UPGRADE_NOTE: Class_Terminate was upgraded to Class_Terminate_Renamed. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="A9E4979A-37FA-4718-9994-97DD76ED70A7"'
	Private Sub Class_Terminate_Renamed()
		Dim i As Object
		'UPGRADE_NOTE: Object header may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		header = Nothing
		For i = 0 To nCalStructs - 1
			'UPGRADE_WARNING: Couldn't resolve default property of object i. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
			'UPGRADE_NOTE: Object rgbEvalCal() may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
			rgbEvalCal(i) = Nothing
		Next i
	End Sub
	Protected Overrides Sub Finalize()
		Class_Terminate_Renamed()
		MyBase.Finalize()
	End Sub
	
	Public Sub getTBlines(ByRef Item() As Short)
		Dim i As Short
		For i = 0 To nRecords - 1
			Item(i) = lines(i)
		Next i
	End Sub
	
	Function getNrecords() As Short
		getNrecords = nRecords
	End Function
	
	Function getNlines() As Short
		getNlines = nLines
	End Function
	
	Function getSize() As Short
		getSize = size
	End Function
	
	Sub setTBobj(ByRef widget As System.Windows.Forms.TextBox, Optional ByRef Index As Short = 0)
		
		Dim i As Short
		
		If Index > 0 Then
			If Index <= nCalStructs Then
				rgbEvalCal(Index - 1).setTBobj(widget)
			End If
		Else
			header.setTBobj(widget)
		End If
		
	End Sub
	
	Sub getEEprom(ByRef data() As Byte, Optional ByRef Index As Short = 0)
		
		Dim i As Short
		
		Index = header.getEEprom(data, Index)
		For i = 0 To nCalStructs - 1
			Index = rgbEvalCal(i).getEEprom(data, Index)
		Next i
		
	End Sub
	
	Sub setEEprom(ByRef data() As Byte)
		
		Dim i, Index As Short : Index = 0
		
		Index = header.setEEprom(data, Index)
		
		' load image from class
		For i = 0 To nCalStructs - 1
			Index = rgbEvalCal(i).setEEprom(data, Index)
		Next i
		
	End Sub
	
	Sub getFile(ByVal fileNum As Short)
		
		Dim i As Short
		
		header.getFile(fileNum)
		
		For i = 0 To nCalStructs - 1
			rgbEvalCal(i).getFile(fileNum)
		Next i
		
endSub: FileClose(fileNum)
	End Sub
	
	Sub setFile(ByVal fileNum As Short)
		
		Dim Index, i As Short
		
		header.setFile(fileNum)
		
		For i = 0 To nCalStructs - 1
			rgbEvalCal(i).setFile(fileNum)
		Next i
		
endSub: FileClose(fileNum)
	End Sub
	
	Sub setTB()
		Dim i As Short
		
		header.setTB()
		For i = 0 To nCalStructs - 1
			rgbEvalCal(i).setTB()
		Next i
		
	End Sub
	
	
	' ______________________________
	' ||||||||| INTERFACES |||||||||
	' ==============================
	' >>>>>>>>>>> HEADER <<<<<<<<<<<
	' ==============================
	Public Function getEEpromVersion() As Short
		On Error Resume Next
		getEEpromVersion = header.getEEpromVersion
	End Function
	Public Sub setEEpromVersion(ByVal value As Short)
		On Error Resume Next
		header.setEEpromVersion(value)
	End Sub
	' ==============================
	Public Function getExeRevDate() As Date
		On Error Resume Next
		getExeRevDate = header.getExeRevDate
	End Function
	Public Sub setExeRevDate(ByVal value As Date)
		On Error Resume Next
		header.setExeRevDate(value)
	End Sub
	' ==============================
	Public Function getDllRevDate() As Date
		On Error Resume Next
		getDllRevDate = header.getDllRevDate
	End Function
	Public Sub setDllRevDate(ByVal value As Date)
		On Error Resume Next
		header.setDllRevDate(value)
	End Sub
	' ==============================
	Public Function getEEpromDate() As Date
		On Error Resume Next
		getEEpromDate = header.getEEpromDate
	End Function
	Public Sub setEEpromDate(ByVal value As Date)
		On Error Resume Next
		header.setEEpromDate(value)
	End Sub
	' ==============================
	' >>>>>>>>> RGBEVALCAL <<<<<<<<<
	' ==============================
	Public Function getCompensation(ByVal p As Short) As Single
		On Error Resume Next
		If p > nCalStructs - 1 Then p = nCalStructs - 1
		getCompensation = rgbEvalCal(p).getCompensation
	End Function
	Public Sub setCompensation(ByVal p As Short, ByVal value As Single)
		On Error Resume Next
		If p > nCalStructs - 1 Then p = nCalStructs - 1
		rgbEvalCal(p).setCompensation(value)
	End Sub
	' ==============================
	Public Function getCardGain(ByVal p As Short) As Single
		On Error Resume Next
		getCardGain = rgbEvalCal(0).getCardGain(p)
	End Function
	Public Sub setCardGain(ByVal p As Short, ByVal value As Single)
		On Error Resume Next
		If p > nCalStructs - 1 Then p = nCalStructs - 1
		rgbEvalCal(0).setCardGain(p, value)
	End Sub
	' ==============================
	Public Function getRange(ByVal p As Short, ByRef i As Short) As Single
		On Error Resume Next
		If p > nCalStructs - 1 Then p = nCalStructs - 1
		getRange = rgbEvalCal(p).getRange(i)
	End Function
	Public Sub setRange(ByVal p As Short, ByRef i As Short, ByVal value As Single)
		On Error Resume Next
		If p > nCalStructs - 1 Then p = nCalStructs - 1
		rgbEvalCal(p).setRange(i, value)
	End Sub
	' ==============================
	Public Function getTransform(ByVal p As Short, ByRef i As Short, ByRef j As Short) As Single
		On Error Resume Next
		getTransform = rgbEvalCal(0).getTransform(p, i, j)
	End Function
	Public Sub setTransform(ByVal p As Short, ByRef i As Short, ByRef j As Short, ByVal value As Single)
		On Error Resume Next
		rgbEvalCal(0).setTransform(p, i, j, value)
	End Sub
	' ==============================
End Class