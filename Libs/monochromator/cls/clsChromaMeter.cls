VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsChromaMeter"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Dim pObj As Object
Dim enableError As Boolean
Const sId As String = "ucMonochromator::clsChromaMeter"

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
    Dim m(0, 1) As Single, a(1) As Single, n As Integer, i As Integer, j As Integer, k As Integer
    n = UBound(m, 1) + 1
    Dim min(1) As Single, max(1) As Single
    
    On Error GoTo error
    
    Call frmMonochromator.ucMonochromator1.GetCCTlux(value(1), value(0))
    ' average n measurements
    a(0) = 0: a(1) = 0
    For i = 0 To n - 1
    
        Sleep 100
        Call frmMonochromator.ucMonochromator1.GetCCTlux(m(i, 1), m(i, 0))
        a(0) = a(0) + m(i, 0): a(1) = a(1) + m(i, 1)
        
        If i = 0 Then
            min(0) = m(0, 0): max(0) = m(0, 0)
            min(1) = m(0, 1): max(1) = m(0, 1)
        Else
            If max(0) < m(i, 0) Then
                max(0) = m(i, 0)
            Else
                If min(0) > m(i, 0) Then min(0) = m(i, 0)
            End If
            
            If max(1) < m(i, 1) Then
                max(1) = m(i, 1)
            Else
                If min(1) > m(i, 1) Then min(1) = m(i, 1)
            End If
            
        End If
        
    Next i
    a(0) = a(0) / n: a(1) = a(1) / n
    
    
    For k = 0 To 1
        ' throw out fliers (min/max) [0]
        If (max(k) - min(k)) > 0.1 * a(k) Then
            Do
                a(k) = 0: j = 0
                For i = 0 To n - 1 ' remove min & max
                    If max(k) > 1.05 * a(k) Then
                        If m(i, k) = max(k) Then m(i, k) = 0
                    End If
                    If min(k) < 0.95 * a(k) Then
                        If m(i, k) = min(k) Then m(i, k) = 0
                    End If
                Next i
                
                For i = 0 To n - 1
                    If m(i, k) <> 0 Then
                        If j = 0 Then
                            max(k) = m(i, k): min(k) = m(i, k)
                        End If
                        If max(k) < m(i, k) Then
                            max(k) = m(i, k)
                        Else
                            If min(k) > m(i, k) Then min(k) = m(i, k)
                        End If
                        a(k) = a(k) + m(i, k): j = j + 1
                    End If
                Next i
                If j > 0 Then a(k) = a(k) / j
            Loop Until ((max(k) - min(k)) < 0.1 * a(k)) Or j = 0
        End If
        
        value(k) = a(k)
        
    Next k
    
    
    getValue = True
    GoTo end_
error:
    errorMsg "Error in " & sId & ":getValue"
end_:
End Function


