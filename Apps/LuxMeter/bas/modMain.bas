Attribute VB_Name = "modMain"

' +______+
' | Main |
' +¯¯¯¯¯¯+
Sub Main()
   Dim a_strArgs() As String
   Dim blnDebug As Boolean
   
   Dim i As Integer
   
   a_strArgs = Split(Command$, " ")
   For i = LBound(a_strArgs) To UBound(a_strArgs)
      Select Case LCase(a_strArgs(i))
      Case "-d", "/d" ' device
         
         If i = UBound(a_strArgs) Then
            MsgBox "Filename not specified."
         Else
            i = i + 1
         End If
         If Left(a_strArgs(i), 1) = "-" Or Left(a_strArgs(i), 1) = "/" Then
            MsgBox "Invalid filename."
         Else
            gRGBdev = a_strArgs(i)
         End If
      
      Case "-wa", "/wa" ' device
        frmAlsDrv.enableInvert = 1
      Case Else
         MsgBox "Invalid argument: " & a_strArgs(i)
      End Select
      
   Next i
   
   Load frmAlsDrv
   frmSimpleRGB.Show
   
End Sub

