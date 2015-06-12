VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsMPA"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False

Dim size As Integer
Const defaultSize As Integer = 32

Dim sumArray() As Double
Dim sum2Array() As Double
Dim sum As Double, sum2 As Double
Dim iMax As Integer, iMin As Integer
Dim count As Integer
Dim countTerminated As Boolean
Dim resetTrip As Double

Private Sub Class_Initialize()
    setSize defaultSize
    resetAvgTrip
End Sub

Public Sub setAvgTrip(trip As Double)

    If trip < 2 Then
        resetTrip = 2
    Else
        If trip > 20 Then
            resetTrip = 20
        Else
            resetTrip = trip
        End If
    End If
        
End Sub

Public Sub resetAvgTrip()
    resetTrip = 2
End Sub

Public Function getMin() As Double
    getMin = sumArray(iMin)
End Function

Public Function getMax() As Double
    getMax = sumArray(iMax)
End Function

Public Function getPkPk() As Double
    getPkPk = sumArray(iMax) - sumArray(iMin)
End Function

Public Sub setSize(Optional ByVal value As Integer = 0)

    ' value of 0 (or none) clears MPA

    If value > 0 Then size = value
    
    If size > 0 Then
        ReDim sumArray(size - 1), sum2Array(size - 1)
        
        count = 0: sum = 0: sum2 = 0: iMin = 0: iMax = 0
        countTerminated = False
    End If
    
End Sub

Private Sub lookForMin()
    Dim i As Integer
    iMin = 0
    For i = 1 To size - 1
        If sumArray(iMin) > sumArray(i) Then iMin = i
    Next i
End Sub

Private Sub lookForMax()
    Dim i As Integer
    iMax = 0
    For i = 1 To size - 1
        If sumArray(iMax) < sumArray(i) Then iMax = i
    Next i
End Sub


Public Sub setValue(ByVal value As Single, Optional mean As Double, Optional rmsPercent As Double)

    On Error Resume Next

    sum = sum - sumArray(count) + value
    sum2 = sum2 - sum2Array(count) + value * value
    sumArray(count) = value
    sum2Array(count) = value * value
    
    If countTerminated Then
        If count = iMin Then lookForMin
        If count = iMax Then lookForMax
    End If
    
    If sumArray(iMax) < value Then iMax = count
    If value < sumArray(iMin) Then iMin = count
    
    count = count + 1
    
    If count >= size Then
        count = 0
        countTerminated = True
    End If
    
    If countTerminated Then
        mean = sum / size
        If mean <> 0 Then rmsPercent = 100# * ((sum2 / size - mean * mean) ^ 0.5) / mean
    Else
        mean = sum / count
        If mean <> 0 Then rmsPercent = 100# * ((sum2 / count - mean * mean) ^ 0.5) / mean
    End If
    
    If rmsPercent < 0 Then
        Debug.Print "problem with clsMPA"
    Else
        If rmsPercent > resetTrip Then
            setSize
        End If
    End If

End Sub


