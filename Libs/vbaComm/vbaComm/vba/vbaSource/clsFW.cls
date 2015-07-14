VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "clsFW"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Private cp As Ax_vbaComm.IvbaComm
Private port As Integer

Public Sub setPos(ByVal pos As Integer)
    Dim ack As String
    Static lPos As Integer
    
    Debug.Print "set:port=" & port & " pos=" & pos
    cp.WriteLine "pos=" & pos
    Sleep 1000 * Abs(pos - lPos)
    pos = getPos
    lPos = pos
End Sub

Public Function getPos() As Integer
    Dim sBuf As String, j As Integer: j = 10
    
    cp.WriteLine "pos?"
    
    Do
        sBuf = cp.ReadLine: j = j - 1
        Debug.Print "get:port=" & port & sBuf
        If Len(sBuf) = 1 Then j = 0
    Loop While j > 0
    
    getPos = sBuf
    
End Function

Public Sub openPort(portIn As Integer)
    port = portIn
    Set cp = New Ax_vbaComm.vbaComm
    cp.Open port, 115200, 0, 8, 1, vbCr
End Sub


Public Sub closePort()
    cp.Close
    Set cp = Nothing
End Sub
