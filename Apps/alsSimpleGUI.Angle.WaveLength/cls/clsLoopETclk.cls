VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsLoopETclk"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Dim pET As frmEtIo
Dim pT As frmTest

Dim initOK As Boolean
Dim dnum As Integer

Dim nDut As Integer
Dim dCount As Integer

Dim dFlag As Boolean

Const maxDnum As Integer = 31

' +________________+
' | Standard APIs |
' +¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯+

Public Function arm(Optional Dev As Integer = -1) As Integer
    Dim i As Integer
    
    If initOK Then
    
        dFlag = False
    
        ' count #/devices
        nDut = 1
        For i = getNextDut(maxDnum) To maxDnum
            arm = getNextDut(i)
            If arm >= i Then
                nDut = nDut + 1 ' another dut
                i = arm - 1
            Else
                i = maxDnum ' terminate count
            End If
        Next i
        
        arm = getNextDut(maxDnum) ' 1st device
    
        If Dev > 0 And Dev <= maxDnum Then
            arm = getNextDut(Dev - 1)
        End If
    
        dCount = 1
        setDnum arm
        arm = nDut
        
    End If
End Function

Public Function next_(Optional Dev As Integer = -1) As Integer
    
    If initOK Then
        If Not done Then
        
            If Dev >= 0 Then
                If Dev = 0 Then
                    nDut = getNextDut(maxDnum)
                Else
                    nDut = getNextDut(Dev - 1)
                End If
            Else
                nDut = getNextDut(dnum)
            End If
            
            If nDut >= dnum Then
                setDnum nDut
            Else
                dFlag = True
                dnum = maxDnum
            End If
        End If
    End If
    
    next_ = dnum
    
End Function

Public Function done() As Boolean
    If initOK Then
        done = (getNextDut(dnum) < dnum)
    Else
        done = True
    End If
End Function

' +________________+
' | External Calls |
' +¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯+

Private Sub setDnum(Dev As Integer)
    dnum = pT.setDevice(Dev)
End Sub

Private Function getNextDut(thisDut As Integer) As Integer
    getNextDut = pET.getNextEnabled(thisDut)
End Function

Private Sub Class_Initialize()
    On Error GoTo error
    
    Set pET = frmEtIo
    Set pT = frmTest
    
    initOK = True
    
    GoTo endSub
    
error:
    MsgBox ("ERROR initializing clsSRloop")
endSub:

End Sub
