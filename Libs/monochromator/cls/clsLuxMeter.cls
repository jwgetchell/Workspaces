VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsLuxMeter"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Dim pObj As Object
Dim enableError As Boolean
Const sId As String = "ucMonochromator::clsLuxMeter"

Dim initDone As Boolean

Sub setErrorOn(enabled As Boolean)
    enableError = enabled
End Sub

Sub errorMsg(error As String)
    If enableError Then MsgBox error
End Sub

Private Sub Class_Initialize()
    enableError = True
End Sub

' +______________________+
' | Standard Public APIs |
' +¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯+

Public Function getValue(value() As Single, ByVal id As Integer) As Boolean
    Dim m(19) As Single, a As Single, n As Integer, i As Integer, j As Integer
    n = UBound(m) + 1
    Dim min As Single, max As Single
    
    On Error GoTo error
    
    If Not initDone Then
        frmMonochromator.ucMonochromator1.InitLuxMeter
        initDone = True
    End If
    
    getValue = True
    
    ' average n measurements
    a = 0
    For i = 0 To n - 1
        m(i) = frmMonochromator.ucMonochromator1.GetLux
        a = a + m(i)
        If i = 0 Then
            min = m(0): max = m(0)
        Else
            If max < m(i) Then
                max = m(i)
            Else
                If min > m(i) Then min = m(i)
            End If
        End If
    Next i
    a = a / n
    
    ' throw out fliers (min/max)
    If (max - min) > 0.1 * a Then
        Do
            a = 0: j = 0
            For i = 0 To n - 1 ' remove min & max
                If max > 1.05 * a Then
                    If m(i) = max Then m(i) = 0
                End If
                If min < 0.95 * a Then
                    If m(i) = min Then m(i) = 0
                End If
            Next i
            
            For i = 0 To n - 1
                If m(i) <> 0 Then
                    If j = 0 Then
                        max = m(i): min = m(i)
                    End If
                    If max < m(i) Then
                        max = m(i)
                    Else
                        If min > m(i) Then min = m(i)
                    End If
                    a = a + m(i): j = j + 1
                End If
            Next i
            a = a / j
        Loop Until (max - min) < 0.1 * a
    End If
    
    value(0) = a
    Debug.Print value(0)
    GoTo end_
error:
    errorMsg "Error in " & sId & ":getValue"
end_:
End Function


