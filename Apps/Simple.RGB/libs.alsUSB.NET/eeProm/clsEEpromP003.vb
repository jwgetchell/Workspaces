Option Strict Off
Option Explicit On
Friend Class clsEEpromP003
	Const nCalStructs As Short = 1
	Const defaultFileNum As Short = 1
	Const nRecords As Short = nCalStructs + 1 ' 1 more for header
	Dim nLines As Short
	Dim lines(nRecords) As Short
	
	Dim header As clsHeader000
	Dim rgbEvalCal(nCalStructs - 1) As clsRGBevalCal000
	Dim size As Short
	Dim dataTB As System.Windows.Forms.TextBox
	Dim dataTBitems() As String
	
	'UPGRADE_NOTE: Class_Initialize was upgraded to Class_Initialize_Renamed. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="A9E4979A-37FA-4718-9994-97DD76ED70A7"'
	Private Sub Class_Initialize_Renamed()
		
		Dim i As Short
		Dim buf(1000) As Short
		
		header = New clsHeader000
		size = header.getSize
		nLines = header.getNlines : lines(0) = nLines
		
		For i = 0 To nCalStructs - 1
			rgbEvalCal(i) = New clsRGBevalCal000
			size = size + rgbEvalCal(i).getSize
			lines(i + 1) = rgbEvalCal(i).getNlines
			nLines = nLines + lines(i + 1)
		Next i
		
	End Sub
	Public Sub New()
		MyBase.New()
		Class_Initialize_Renamed()
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
	
	Sub setTBobj(ByRef fixed As System.Windows.Forms.TextBox, ByRef data As System.Windows.Forms.TextBox)
		
		'    Dim i As Integer
		'
		'    Set dataTB = data
		'    header.setTBobj fixed
		'    For i = 0 To nCalStructs - 1
		'        If i = 0 Then
		'            rgbEvalCal(0).setTBobj data
		'        Else
		'            rgbEvalCal(1).setTBobj data, True
		'        End If
		'    Next i
		
	End Sub
	
	Sub getDataTBitems()
		
		dataTBitems = Split(dataTB.Text, ",")
		
	End Sub
	
	Sub getEEprom(ByRef data() As Byte, Optional ByRef index As Short = 0)
		
		index = header.getEEprom(data, index)
		index = rgbEvalCal(0).getEEprom(data, index)
		index = rgbEvalCal(1).getEEprom(data, index)
		
	End Sub
	
	Sub setEEprom(ByRef data() As Byte, Optional ByRef index As Short = 0)
		
		Dim tbDataIdx, i As Short
		
		index = header.setEEprom(data, index)
		
		' load class from TextBox
		getDataTBitems()
		
		For i = 0 To nCalStructs - 1
			If i = 0 Then
				tbDataIdx = rgbEvalCal(0).getTB(dataTBitems)
			Else
				'rgbEvalCal(1).getTB dataTBitems, tbDataIdx
			End If
		Next i
		
		' load image from class
		For i = 0 To nCalStructs - 1
			index = rgbEvalCal(0).setEEprom(data, index)
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
		
		Dim index As Short
		
		header.setFile(fileNum)
		
		getDataTBitems()
		
		index = rgbEvalCal(0).getTB(dataTBitems)
		rgbEvalCal(0).setFile(fileNum)
		
		'JWG rgbEvalCal(0).getTB dataTBitems, Index
		rgbEvalCal(1).setFile(fileNum)
		
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
	Public Function getCompensation(ByRef p As Short) As Single
		On Error Resume Next
		getCompensation = rgbEvalCal(p).getCompensation
	End Function
	Public Sub setCompensation(ByRef p As Short, ByVal value As Single)
		On Error Resume Next
		rgbEvalCal(p).setCompensation(value)
	End Sub
	' ==============================
	Public Function getCardGain(ByRef p As Short) As Single
		On Error Resume Next
		getCardGain = rgbEvalCal(p).getCardGain
	End Function
	Public Sub setCardGain(ByRef p As Short, ByVal value As Single)
		On Error Resume Next
		rgbEvalCal(p).setCardGain(value)
	End Sub
	' ==============================
	Public Function getRange(ByRef p As Short, ByRef i As Short) As Single
		On Error Resume Next
		getRange = rgbEvalCal(p).getRange(i)
	End Function
	Public Sub setRange(ByRef p As Short, ByRef i As Short, ByVal value As Single)
		On Error Resume Next
		rgbEvalCal(p).setRange(i, value)
	End Sub
	' ==============================
	Public Function getTransform(ByRef p As Short, ByRef i As Short, ByRef j As Short) As Single
		On Error Resume Next
		getTransform = rgbEvalCal(p).getTransform(i, j)
	End Function
	Public Sub setTransform(ByRef p As Short, ByRef i As Short, ByRef j As Short, ByVal value As Single)
		On Error Resume Next
		rgbEvalCal(p).setTransform(i, j, value)
	End Sub
	' ==============================
End Class