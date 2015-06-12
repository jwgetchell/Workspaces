Option Strict Off
Option Explicit On
Friend Class clsRGBevalCal001
	'||==================================================================||
	'||                                                                  ||
	'|| Data class for RGB Evaluation Card compensation,gain & transform ||
	'||                                                                  ||
	'||==================================================================||
	
	Dim size As Short
	
	Private Structure rgbEvalCalStruct
		Dim compensation As Single
		<VBFixedArray(2)> Dim cardGain() As Single
		<VBFixedArray(2)> Dim range() As Single ' 3 ranges
        <VBFixedArray(8)> Dim transform(,,) As Single ' 3 Range + 3x3 (no dIR)' JWG 2, 2, 2
		
		'UPGRADE_TODO: "Initialize" must be called to initialize instances of this structure. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="B4BFF9E0-8631-45CF-910E-62AB3970F27B"'
		Public Sub Initialize()
			ReDim cardGain(2)
			ReDim range(2)
			ReDim transform(2, 2, 2)
		End Sub
	End Structure
	
	'UPGRADE_WARNING: Arrays in structure rgbEvalCal may need to be initialized before they can be used. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="814DF224-76BD-4BB4-BFFB-EA359CB9FC48"'
	Dim rgbEvalCal As rgbEvalCalStruct
	
	Dim tb As System.Windows.Forms.TextBox
	
	Const nLines As Short = 13
	
	Public Function getNlines() As Short
		getNlines = nLines
	End Function
	
	Public Sub setTBobj(ByRef value As System.Windows.Forms.TextBox)
		tb = value
		setTB()
	End Sub
	
	'UPGRADE_NOTE: Class_Initialize was upgraded to Class_Initialize_Renamed. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="A9E4979A-37FA-4718-9994-97DD76ED70A7"'
	Private Sub Class_Initialize_Renamed()
		size = Len(rgbEvalCal)
	End Sub
	Public Sub New()
		MyBase.New()
		Class_Initialize_Renamed()
	End Sub
	
	Function getSize() As Short
		getSize = size
	End Function
	
	Sub clear()
		Dim j, i, p As Short
		
		rgbEvalCal.compensation = 0
		
		For i = 0 To UBound(rgbEvalCal.cardGain)
			rgbEvalCal.cardGain(i) = 0
		Next i
		
		For i = 0 To UBound(rgbEvalCal.range)
			rgbEvalCal.range(i) = 0
		Next i
		
		For p = 0 To UBound(rgbEvalCal.transform)
			For i = 0 To UBound(rgbEvalCal.transform, 2) : For j = 0 To UBound(rgbEvalCal.transform, 3)
					rgbEvalCal.transform(9, i, j) = 0
				Next j : Next i
		Next p
	End Sub
	
	'UPGRADE_NOTE: default was upgraded to default_Renamed. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="A9E4979A-37FA-4718-9994-97DD76ED70A7"'
	Sub default_Renamed()
		Dim j, i, p As Short
		
		rgbEvalCal.compensation = 0
		
		For i = 0 To UBound(rgbEvalCal.cardGain)
			rgbEvalCal.cardGain(i) = 1
		Next i
		
		For i = 0 To UBound(rgbEvalCal.range)
			rgbEvalCal.range(i) = 1
		Next i
		
		For p = 0 To UBound(rgbEvalCal.transform)
			For i = 0 To UBound(rgbEvalCal.transform, 2) : For j = 0 To UBound(rgbEvalCal.transform, 3)
					If i = j Then
						rgbEvalCal.transform(p, i, j) = 1
					Else
						rgbEvalCal.transform(p, i, j) = 0
					End If
				Next j : Next i
		Next p
		
	End Sub
	
	
	'||==================||
	'|| Data pack/unpack ||
	'||==================||
	Public Function getEEprom(ByRef data() As Byte, Optional ByVal Index As Short = 0) As Short
		Dim j, i, p As Short
		
		Index = byte2single(data, rgbEvalCal.compensation, Index)
		
		For i = 0 To UBound(rgbEvalCal.cardGain)
			Index = byte2single(data, rgbEvalCal.cardGain(i), Index)
		Next i
		
		For i = 0 To UBound(rgbEvalCal.range)
			Index = byte2single(data, rgbEvalCal.range(i), Index)
		Next i
		
		For p = 0 To UBound(rgbEvalCal.transform)
			For i = 0 To UBound(rgbEvalCal.transform, 2) : For j = 0 To UBound(rgbEvalCal.transform, 3)
					Index = byte2single(data, rgbEvalCal.transform(p, i, j), Index)
				Next j : Next i
		Next p
		
		getEEprom = Index
		
		setTB()
		
	End Function
	
	Public Function setEEprom(ByRef data() As Byte, Optional ByVal Index As Short = 0) As Short
		Dim j, i, p As Short
		
		Dim items() As String
		items = Split(tb.Text, ",")
		getTB(items)
		
		Index = single2byte(rgbEvalCal.compensation, data, Index)
		
		For i = 0 To UBound(rgbEvalCal.cardGain)
			Index = single2byte(rgbEvalCal.cardGain(i), data, Index)
		Next i
		
		For i = 0 To UBound(rgbEvalCal.range)
			Index = single2byte(rgbEvalCal.range(i), data, Index)
		Next i
		
		For p = 0 To UBound(rgbEvalCal.transform)
			For i = 0 To UBound(rgbEvalCal.transform, 2) : For j = 0 To UBound(rgbEvalCal.transform, 3)
					Index = single2byte(rgbEvalCal.transform(p, i, j), data, Index)
				Next j : Next i
		Next p
		
		setEEprom = Index
		
	End Function
	
	
	'||==========||
	'|| File I/O ||
	'||==========||
	Public Sub getFile(ByRef N As Short)
		
		Dim j, p, i, k As Short
		Dim s As String
		Dim F As Single
		
		On Error Resume Next
		
		Input(N, s)
		Input(N, s)
		Input(N, F) : setCompensation(F)
		
		Input(N, s)
		Input(N, s)
		For i = 0 To UBound(rgbEvalCal.range)
			Input(N, F) : setCardGain(i, F)
		Next i
		
		Input(N, s)
		Input(N, s)
		For i = 0 To UBound(rgbEvalCal.range)
			Input(N, F) : setRange(i, F)
		Next i
		
		Input(N, s)
		Input(N, s)
		For p = 0 To UBound(rgbEvalCal.transform)
			For i = 0 To UBound(rgbEvalCal.transform, 2) : Input(N, s) : For j = 0 To UBound(rgbEvalCal.transform, 3)
					Input(N, F) : setTransform(p, i, j, F)
				Next j : Next i
		Next p
		
		setTB()
		
	End Sub
	
	Public Sub setFile(ByRef N As Short)
		
		Dim j, i, p As Short
		
		Dim items() As String
		items = Split(tb.Text, ",")
		getTB(items)
		
		Write(N, "Compensation", getCompensation) : PrintLine(N, "")
		
		Write(N, "CardGain")
		For i = 0 To UBound(rgbEvalCal.cardGain)
			Write(N, getCardGain(i))
		Next i
		PrintLine(N, "")
		
		Write(N, "Range")
		For i = 0 To UBound(rgbEvalCal.range)
			Write(N, getRange(i))
		Next i
		PrintLine(N, "")
		
		
		Write(N, "CCM") : PrintLine(N, "")
		For p = 0 To UBound(rgbEvalCal.transform)
			For i = 0 To UBound(rgbEvalCal.transform, 2) : For j = 0 To UBound(rgbEvalCal.transform, 3)
					Write(N, getTransform(p, i, j))
				Next j : PrintLine(N, "") : Next i
		Next p
		
		
	End Sub
	
	Public Sub setTB()
		Dim append As Object
		
		Dim j, i, p As Short
		
		On Error Resume Next
		
		If Not (tb Is Nothing) Then
			If Not append Then tb.Text = ""
			tb.Text = tb.Text & Chr(&H22) & "Compensation" & Chr(&H22) & ","
			tb.Text = tb.Text & getCompensation & "," & vbCrLf
			
			tb.Text = tb.Text & Chr(&H22) & "CardGain" & Chr(&H22) & ","
			For i = 0 To UBound(rgbEvalCal.cardGain)
				tb.Text = tb.Text & getCardGain(i) & ","
			Next i : tb.Text = tb.Text & vbCrLf
			'tb.text = tb.text & getCardGain & "," & vbCrLf
			
			tb.Text = tb.Text & Chr(&H22) & "Range" & Chr(&H22) & ","
			For i = 0 To UBound(rgbEvalCal.range)
				tb.Text = tb.Text & getRange(i) & ","
			Next i : tb.Text = tb.Text & vbCrLf
			
			tb.Text = tb.Text & Chr(&H22) & "CCM" & Chr(&H22) & "," & vbCrLf
			For p = 0 To UBound(rgbEvalCal.transform)
				For i = 0 To UBound(rgbEvalCal.transform, 2) : For j = 0 To UBound(rgbEvalCal.transform, 3)
						tb.Text = tb.Text & getTransform(p, i, j) & ","
					Next j : tb.Text = tb.Text & vbCrLf : Next i
			Next p
			
		End If
	End Sub
	
	Public Function getTB(ByRef items() As String) As Short
		Dim k, p, j, i As Short : i = 1
		
		setCompensation(CSng(items(i))) : i = i + 2
		
		For j = 0 To UBound(rgbEvalCal.cardGain)
			setCardGain(j, CSng(items(i))) : i = i + 1
		Next j
		
		i = i + 1
		For j = 0 To UBound(rgbEvalCal.range)
			setRange(j, CSng(items(i))) : i = i + 1
		Next j
		
		i = i + 1
		For p = 0 To UBound(rgbEvalCal.transform)
			For j = 0 To UBound(rgbEvalCal.transform, 2) : For k = 0 To UBound(rgbEvalCal.transform, 3)
					setTransform(p, j, k, CSng(items(i))) : i = i + 1
				Next k : Next j
		Next p
		
		getTB = i + 1
		
	End Function
	
	' ______________________________
	' ||||||||| INTERFACES |||||||||
	' ==============================
	Public Function getCompensation() As Single
		On Error Resume Next
		getCompensation = rgbEvalCal.compensation
	End Function
	Public Sub setCompensation(ByVal value As Single)
		On Error Resume Next
		rgbEvalCal.compensation = value
	End Sub
	' ==============================
	Public Function getCardGain(ByVal i As Short) As Single
		On Error Resume Next
		getCardGain = rgbEvalCal.cardGain(i)
	End Function
	Public Sub setCardGain(ByVal i As Short, ByVal value As Single)
		On Error Resume Next
		rgbEvalCal.cardGain(i) = value
	End Sub
	' ==============================
	Public Function getRange(ByRef i As Short) As Single
		On Error Resume Next
		getRange = rgbEvalCal.range(i)
	End Function
	Public Sub setRange(ByVal i As Short, ByVal value As Single)
		On Error Resume Next
		rgbEvalCal.range(i) = value
	End Sub
	' ==============================
	Public Function getTransform(ByVal p As Short, ByRef i As Short, ByRef j As Short) As Single
		On Error Resume Next
		getTransform = rgbEvalCal.transform(p, i, j)
	End Function
	Public Sub setTransform(ByVal p As Short, ByVal i As Short, ByVal j As Short, ByVal value As Single)
		On Error Resume Next
		rgbEvalCal.transform(p, i, j) = value
	End Sub
	' ==============================
End Class