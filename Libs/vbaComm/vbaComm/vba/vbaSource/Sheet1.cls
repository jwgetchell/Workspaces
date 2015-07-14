VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Sheet1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True
Dim fw(1) As clsFW

Public Sub getPort()
Attribute getPort.VB_ProcData.VB_Invoke_Func = "Z\n14"

    Dim i As Integer, j As Integer
    
    If fw(0) Is Nothing Then Set fw(0) = New clsFW: fw(0).openPort 3
    If fw(1) Is Nothing Then Set fw(1) = New clsFW: fw(1).openPort 2
    
    Dim pos As Integer
    
    For j = 1 To 4
    
        For i = 0 To 1
        
            pos = fw(i).getPos
            
            If pos = 1 + i Then
                fw(i).setPos 3 + i ' 3,4
            Else
                fw(i).setPos 1 + i ' 1,2
            End If
        
        Next i
        
    Next j
    
End Sub
