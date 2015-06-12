Attribute VB_Name = "modScript"
Option Explicit

Dim pAls As ucALSusb, initALSdone As Boolean
Dim pApp As Form, initAppDone As Boolean
Dim pTlb As Form, initTlbDone As Boolean
Dim pPlt As Form, initPltDone As Boolean
Dim pIns As Form, initInsDone As Boolean
Dim pMsg As Form, initMsgDone As Boolean
Dim pTst As Form, initTstDone As Boolean

Public scriptFileName As String

Sub msg(msg As String)
    If initMsgDone Then
        pMsg.message (msg)
    Else
        MsgBox ("Msg not initialized")
    End If
End Sub

Sub setDevice(value As String)
    If setCmb(pApp.cmbDevice, value) Then pApp.cmbDevice_Click
End Sub

Public Sub script(fileName As String)
    Dim line As String, target As String
    Static fileNum As Integer: If fileNum < 10 Then fileNum = 10
    On Error GoTo endSub
    fileNum = fileNum + 1: Open fileName For Input As #fileNum
    While Not EOF(fileNum)
        Input #fileNum, line
repeat:        target = lineArgs(line)
        Select Case target
        
        ' Windows
        Case "Als": If initALSdone Then pAls.script line
        Case "ThorlabsAPT": If initTlbDone Then pTlb.script line
        Case "Plot": If initPltDone Then pPlt.script line
        Case "Ins": If initInsDone Then pIns.script line
        Case "Tests": If initTstDone Then pTst.script line
        
        ' App
        Case "IrdrCycle": If initAppDone Then pApp.cbCycleIRDR.value = val(line)
        Case "Sweep": If initAppDone Then If setCmb(pApp.cmbSweep, line) Then pApp.cmbSweep_Click
        Case "ViewIns": If initAppDone Then pApp.mnuMonochromator_Click
        Case "ViewTests": If initAppDone Then pApp.mnuTests_Click
        
        Case "ViewAlsEt": If initAppDone Then pApp.mnuAlsEt_Click
        Case "ViewRgbScan": If initAppDone Then pApp.mnuRGBscan_Click
        
        Case "Script": script line
        Case "LpRun": pApp.HScrLoopRun.value = line: pApp.cbLoopRun.value = vbChecked
        Case "TmrOff": pApp.cbTimers(line).value = vbUnchecked: pApp.cbTimers_Click (line)
        Case "TmrOn": pApp.cbTimers(line).value = vbChecked: pApp.cbTimers_Click (line)
        Case "Msg": msg (line)
        
        ' ===
        Case "App": GoTo repeat
        Case "", "#":
        Case Else: MsgBox ("??Script: " & target & " " & line)
        
        End Select
    Wend
    GoTo endSub
    MsgBox ("Error opening " & fileName)
endSub:
    Close #fileNum: fileNum = fileNum - 1
End Sub


' +______+
' | pXXX |
' +¯¯¯¯¯¯+
Public Sub initALS(als As ucALSusb): Set pAls = als: initALSdone = True: End Sub
Public Sub initApp(frm As Form): Set pApp = frm: initAppDone = True: End Sub
Public Sub initTlb(frm As Form): Set pTlb = frm: initTlbDone = True: End Sub
Public Sub initPlt(frm As Form): Set pPlt = frm: initPltDone = True: End Sub
Public Sub initIns(frm As Form): Set pIns = frm: initInsDone = True: End Sub
Public Sub initMsg(frm As Form): Set pMsg = frm: initMsgDone = True: End Sub
Public Sub initTst(frm As Form): Set pTst = frm: initTstDone = True: End Sub

Public Function lineArgs(line As String) As String
    Dim spacePos As Integer
    spacePos = InStr(line, " ")
    If (spacePos) Then
        lineArgs = Mid(line, 1, spacePos - 1)
        line = Mid(line, spacePos + 1, Len(line))
    End If
    If lineArgs = "" Then lineArgs = line
End Function

Public Function setCmb(cmb As ComboBox, value As String) As Boolean
    Dim i As Integer
    
    For i = 0 To cmb.ListCount
        If value = cmb.list(i) Then
            cmb.ListIndex = i
            i = cmb.ListCount
            setCmb = True
        End If
    Next i
    
    If Not setCmb Then MsgBox ("value=" & value & " not found")

End Function


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
      Case "-d", "/d"
      ' debug mode
         blnDebug = True
      Case "-f", "/f"
      ' filename specified
         If i = UBound(a_strArgs) Then
            MsgBox "Filename not specified."
         Else
            i = i + 1
         End If
         If Left(a_strArgs(i), 1) = "-" Or Left(a_strArgs(i), 1) = "/" Then
            MsgBox "Invalid filename."
         Else
            scriptFileName = a_strArgs(i)
         End If
      Case Else
         MsgBox "Invalid argument: " & a_strArgs(i)
      End Select
      
   Next i
   
   frmMain.Show
   
End Sub

