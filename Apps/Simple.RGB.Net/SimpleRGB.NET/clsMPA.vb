Option Strict Off
Option Explicit On
Friend Class clsMPA
	
	Dim size As Short
	Const defaultSize As Short = 32
	
	Dim sumArray() As Double
	Dim sum2Array() As Double
	Dim sum, sum2 As Double
	Dim count As Short
	Dim countTerminated As Boolean
	
	'UPGRADE_NOTE: Class_Initialize was upgraded to Class_Initialize_Renamed. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="A9E4979A-37FA-4718-9994-97DD76ED70A7"'
	Private Sub Class_Initialize_Renamed()
		setSize(defaultSize)
	End Sub
	Public Sub New()
		MyBase.New()
		Class_Initialize_Renamed()
	End Sub
	
	Public Sub setSize(Optional ByVal value As Short = 0)
		
		' value of 0 (or none) clears MPA
		
		If value > 0 Then size = value
		
		If size > 0 Then
			ReDim sumArray(size - 1)
			ReDim sum2Array(size - 1)
			
			count = 0 : sum = 0 : sum2 = 0
			countTerminated = False
		End If
		
	End Sub
	
	Public Sub setValue(ByVal value As Single, Optional ByRef mean As Double = 0, Optional ByRef rmsPercent As Double = 0)
		
		On Error Resume Next
		
		sum = sum - sumArray(count) + value
		sum2 = sum2 - sum2Array(count) + value * value
		sumArray(count) = value
		sum2Array(count) = value * value
		
		count = count + 1
		
		If count >= size Then
			count = 0
			countTerminated = True
		End If
		
		If countTerminated Then
			mean = sum / size
			rmsPercent = 100# * ((sum2 / size - mean * mean) ^ 0.5) / mean
		Else
			mean = sum / count
			rmsPercent = 100# * ((sum2 / count - mean * mean) ^ 0.5) / mean
		End If
		
		If rmsPercent < 0 Then
			Debug.Print("problem")
		End If
		
	End Sub
End Class