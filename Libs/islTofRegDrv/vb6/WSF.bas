Attribute VB_Name = "WSF"
Function readByte(addr As Long) As Long
 
    If cb.islTofRegDrv Is Nothing Then cb.islTofRegDrv = New clsIslTofRegDrv 'cb.newIslTofRegDrv
    readByte = cb.islTofRegDrv.readByte(addr)
End Function

Function readField(ByVal a As Long, ByVal s As Byte, ByVal m As Byte) As Long
    If cb.islTofRegDrv Is Nothing Then cb.islTofRegDrv = New clsIslTofRegDrv 'cb.newIslTofRegDrv
    readField = cb.islTofRegDrv.readField_(a, s, m)
End Function
