VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "ADBUsb"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit
Private Declare Sub Sleep Lib "kernel32" (ByVal dwMilliseconds As Long)

Private connected As Boolean
Private i2cAddr As Byte
Private gNoUsb As Boolean
Private gHwnd As Long
Private wsh As New WshShell
Private exec As WshExec
Private cmdOut As String
Private intMBError As Integer

Public Function noUsb() As Boolean
    noUsb = gNoUsb
End Function

Public Sub getUcCodeCaption(ByRef caption As String)
    caption = caption & "ADB"
End Sub

Public Sub setHwnd(hWnd As Long)
    gHwnd = hWnd
End Sub

'Public Function DllCallBack(ByVal RW As Long, ByVal addr As Long, data As Long) As Long
'    DllCallBack = ucHidDllCallBack(RW, addr, data)
'End Function

Private Sub Class_Initialize()
    gNoUsb = False
    connected = False
End Sub

Private Sub Class_Terminate()
    If connected Then
        Call exec.StdIn.WriteLine("exit")
        connected = False
    End If
End Sub



Public Function DllCallBack(ByVal RW As Long, ByVal addr As Long, data As Long) As Long

    Dim baddr As Byte: baddr = &HFF And addr

    If connected = False Then openDevice
    If connected = False Then
        gNoUsb = True
    Else
        gNoUsb = False
    End If

    If gNoUsb = False Then
        Select Case (RW)
            Case 0: Call i2cWrite(baddr, data)
            Case 1: data = i2cRead(baddr)
            Case 2: Call i2cWriteWord(baddr, data)
            Case 3: data = i2cReadWord(baddr)
            Case 4: i2cAddr = addr
            Case 5: data = i2cAddr
        End Select
        DllCallBack = 71077345
    Else: DllCallBack = 4
    End If
End Function

Sub i2cWrite(ByVal addr As Byte, ByVal data As Integer)
    Call exec.StdIn.WriteLine("./data/i2cset -y 4 0x44 " & addr & " " & data & " b")
    Call flushStdOut("./data/i2cset -y 4 0x44 " & addr & " " & data & " b")
    'exec.StdOut.SkipLine
End Sub

Sub i2cWriteWord(ByVal addr As Byte, ByVal data As Long)
    Call exec.StdIn.WriteLine("./data/i2cset -y 4 0x44 " & addr & " " & data & " w")
    Call flushStdOut("./data/i2cset -y 4 0x44 " & addr & " " & data & " w")
    'exec.StdOut.SkipLine
End Sub


Function i2cReadWord(ByVal addr As Byte) As Long
    Dim reg_data As String
    
    Call exec.StdIn.WriteLine("./data/i2cget -y 4 0x44 " & addr & " w")
    Call flushStdOut("./data/i2cget -y 4 0x44 " & addr & " w")
    'exec.StdOut.SkipLine
    'exec.StdOut.SkipLine
    reg_data = exec.StdOut.ReadLine
    While InStr(reg_data, "i2c") <> 0
        reg_data = exec.StdOut.ReadLine
    Wend
    reg_data = "&H" & Mid(reg_data, 3, 2) & Mid(reg_data, 5, 2) 'Replace(reg_data, "0x", "&H")
    i2cReadWord = CInt(reg_data)

End Function

Function i2cRead(ByVal addr As Byte) As Byte
    Dim reg_data As String
    
    Call exec.StdIn.WriteLine("./data/i2cget -y 4 0x44 " & addr & " b")
    Call flushStdOut("./data/i2cget -y 4 0x44 " & addr & " b")
    'exec.StdOut.SkipLine

    reg_data = exec.StdOut.ReadLine
    While InStr(reg_data, "i2c") <> 0
        reg_data = exec.StdOut.ReadLine
    Wend
    reg_data = Replace(reg_data, "0x", "&H")
    i2cRead = CByte(reg_data)
End Function

Private Sub setError(error As String)
    'debugWrite error
    MsgBox (error)
    If error = "Device not found" Then gNoUsb = True
    If error = "Timeout expired" Then gNoUsb = True
End Sub

Public Function getError(ErrorCode As Long) As Long

    Dim error As String
    
    If (ErrorCode) Then
        error = 99 'Stat2Str(errorCode) ' JWG Breakpoint: USB transfer errors
        setError (error)
    End If
    getError = ErrorCode
End Function

Private Function openDevice() As Boolean
    intMBError = vbOK
    On Error GoTo noAndroid
    While (Not connected And Not (intMBError = vbCancel))
            Set exec = wsh.exec("C:\Program Files\Android\android-sdk\platform-tools\adb.exe shell")
            Sleep (5)
            connected = Not exec.StdOut.AtEndOfStream
            
            If Not connected Then
                intMBError = MsgBox("Phone not detected. Make sure it\nis connected and debug enabled.", vbRetryCancel)
            End If
    Wend
    openDevice = connected

noAndroid:
    
    If connected Then
        'Disable Driver to allow I2C comm
        Call exec.StdIn.WriteLine("echo 4-0044> /sys/bus/i2c/drivers/isl29044/unbind")
        'Enable I2Ctools
        Call exec.StdIn.WriteLine("busybox cp /mnt/sdcard/i2ctools/i2cget /data/i2cget")
        Call exec.StdIn.WriteLine("chmod 777 /data/i2cget")
        Call exec.StdIn.WriteLine("busybox cp /mnt/sdcard/i2ctools/i2cset /data/i2cset")
        Call exec.StdIn.WriteLine("chmod 777 /data/i2cset")
        Call flushStdOut("chmod 777 /data/i2cset")
    End If
    
End Function

Private Sub flushStdOut(last_cmd As String)
    Dim Shell_out As String
    Shell_out = "None"
    
    While InStr(Shell_out, last_cmd) = 0
        Shell_out = exec.StdOut.ReadLine
    Wend
    
End Sub


