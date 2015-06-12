Attribute VB_Name = "modFunctions"

Dim noCr As Boolean

Public Sub dpNoCr()
    noCr = True
End Sub

Public Sub debugPrint(Optional ByVal s0 As String _
, Optional ByVal s1 As String = "" _
, Optional ByVal s2 As String = "" _
, Optional ByVal s3 As String = "" _
, Optional ByVal s4 As String = "" _
, Optional ByVal s5 As String = "" _
)
    If s5 <> "" Then
        Debug.Print s0, s1, s2, s3, s4, s5,
    Else
        If s4 <> "" Then
            Debug.Print s0, s1, s2, s3, s4,
        Else
            If s3 <> "" Then
                Debug.Print s0, s1, s2, s3,
            Else
                If s2 <> "" Then
                    Debug.Print s0, s1, s2,
                Else
                    If s1 <> "" Then
                        Debug.Print s0, s1,
                    Else
                        Debug.Print s0,
                    End If
                End If
            End If
        End If
    End If
    
    If Not noCr Then
        Debug.Print
    Else
        noCr = False
    End If
    
End Sub
