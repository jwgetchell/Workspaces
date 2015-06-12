VERSION 5.00
Begin VB.UserControl ucNPXPS 
   ClientHeight    =   2940
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   1320
   ScaleHeight     =   2940
   ScaleWidth      =   1320
   Begin VB.CommandButton cmdArm 
      Caption         =   "Arm"
      Height          =   255
      Left            =   0
      TabIndex        =   8
      Top             =   2640
      Width           =   1215
   End
   Begin VB.Frame fmValue 
      Caption         =   "Value"
      Height          =   615
      Index           =   0
      Left            =   0
      TabIndex        =   0
      Top             =   240
      Width           =   1215
      Begin VB.TextBox tbValue 
         Height          =   285
         Index           =   0
         Left            =   120
         MultiLine       =   -1  'True
         TabIndex        =   1
         Top             =   240
         Width           =   975
      End
   End
   Begin VB.Frame fmValue 
      Caption         =   "Value"
      Height          =   615
      Index           =   1
      Left            =   0
      TabIndex        =   2
      Top             =   840
      Width           =   1215
      Begin VB.TextBox tbValue 
         Height          =   285
         Index           =   1
         Left            =   120
         MultiLine       =   -1  'True
         TabIndex        =   3
         Top             =   240
         Width           =   975
      End
   End
   Begin VB.Frame fmValue 
      Caption         =   "Value"
      Height          =   615
      Index           =   2
      Left            =   0
      TabIndex        =   4
      Top             =   1440
      Width           =   1215
      Begin VB.TextBox tbValue 
         Height          =   285
         Index           =   2
         Left            =   120
         MultiLine       =   -1  'True
         TabIndex        =   5
         Top             =   240
         Width           =   975
      End
   End
   Begin VB.Frame fmValue 
      Caption         =   "Value"
      Height          =   615
      Index           =   3
      Left            =   0
      TabIndex        =   6
      Top             =   2040
      Width           =   1215
      Begin VB.TextBox tbValue 
         Height          =   285
         Index           =   3
         Left            =   120
         MultiLine       =   -1  'True
         TabIndex        =   7
         Top             =   240
         Width           =   975
      End
   End
   Begin VB.CheckBox cbEnable 
      Caption         =   "Disabled"
      Height          =   255
      Left            =   0
      Style           =   1  'Graphical
      TabIndex        =   9
      Top             =   0
      Width           =   1215
   End
End
Attribute VB_Name = "ucNPXPS"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit


' Hard definitions
Const IPAddress As String = "192.168.0.254"
Const IPPort As Integer = 5001
Const GroupName As String = "GROUP1"
Const GroupNum As Long = 1

Private SocketID As Integer
Private firmwareRead As Boolean

' defaults
Const start___ As Single = -90
Const stop___ As Single = 90
Const step___ As Single = 1

Const maxAngle As Single = 90
Const minAngle As Single = -90
Const maxStep As Single = 90
Const minStep As Single = 0.1

Private valN As Integer, nVal As Integer

Const fmt As String = "#0.0"

Enum value
    value__
    start__
    stop__
    step__
    nValues
End Enum

Private doneLatch As Boolean
Public enabled As Boolean

Dim lastText(nValues - 1) As String

Private Sub cbEnable_Click()
    If cbEnable.value = vbChecked Then
        cbEnable.caption = "Enabled"
        enabled = True
    Else
        cbEnable.caption = "Disabled"
        enabled = False
    End If
End Sub

Private Sub cmdArm_Click()
    If done Then
        arm
    End If
End Sub

Private Sub UserControl_Initialize()
    Dim value As Double, i As Integer
    
    SocketID = -1
    SocketID = modNpXps.TCP_ConnectToServer(IPAddress, IPPort, 10)
    
    If SocketID = 0 Then
        cbEnable.value = vbChecked: cbEnable_Click
        fmValue(value__).caption = "Value"
        fmValue(start__).caption = "Start"
        fmValue(stop__).caption = "Stop"
        fmValue(step__).caption = "Step"
        
        If getPosition(value) Then setValue value ' initialize value text box
        For i = start__ To stop__: tbValue(i).text = 1: Next i
        setStart (start___)
        setStop (stop___)
        setStep (step___)
        
        doneLatch = True
    Else
        cbEnable.value = vbUnchecked: cbEnable_Click
    End If
    

End Sub

Private Sub UserControl_Terminate()
    modNpXps.TCP_CloseSocket (SocketID)
    SocketID = -1
End Sub

Private Sub errorMsg(error As Integer)
    Dim Buffer As String: Buffer = String(512 + 1, 0)
    error = modNpXps.ErrorStringGet(SocketID, error, ByVal Buffer)
    MsgBox Buffer
End Sub

'Private Function enterText(ByRef text As String) As Integer
'    ' strip [cr] & [lf], return > 0
'    enterText = InStr(text, Chr(13))
'    If (enterText) Then
'        text = Mid(text, 1, enterText - 1)
'    End If
'End Function


Private Function setPosition(value As Double) As Boolean

    'return true on success
    
    Dim error As Integer
    
    error = modNpXps.GroupMoveAbsolute(SocketID, "GROUP1", GroupNum, value)
    If error <> 0 Then
        'errorMsg error
    Else
        setPosition = True
    End If
    
End Function

Private Function getPosition(value As Double) As Boolean

    'return true on success
    
    Dim error As Integer
    
    error = modNpXps.GroupPositionCurrentGet(SocketID, GroupName, GroupNum, value)
    If error <> 0 Then
        errorMsg error
    Else
        getPosition = True
    End If
    
End Function

Private Sub updateLoopParams()

    If val(tbValue(stop__).text) > maxAngle Then
        tbValue(stop__).text = maxAngle
    Else
        If val(tbValue(stop__).text) < minAngle Then tbValue(stop__).text = minAngle
    End If
    
    If val(tbValue(start__).text) > maxAngle Then
        tbValue(start__).text = maxAngle
    Else
        If val(tbValue(start__).text) < minAngle Then tbValue(start__).text = minAngle
    End If
    
    If val(tbValue(step__).text) > maxStep Then
        tbValue(step__).text = maxStep
    Else
        If val(tbValue(step__).text) < minStep Then tbValue(step__).text = minStep
    End If
    
    tbValue(stop__).text = format(tbValue(stop__).text, fmt)
    tbValue(start__).text = format(tbValue(start__).text, fmt)
    tbValue(step__).text = format(tbValue(step__).text, fmt)
    
    nVal = (tbValue(stop__).text - tbValue(start__).text) / tbValue(step__).text
    tbValue(step__).text = (tbValue(stop__).text - tbValue(start__).text) / nVal
    tbValue(step__).text = format(tbValue(step__).text, fmt)
    
End Sub

Private Sub tbValue_Change(Index As Integer)
    Dim value As Single
    On Error GoTo endSub
    
    If enterText(tbValue(Index).text) Then
        value = val(tbValue(Index).text)
        Select Case Index
            Case start__: setStart (value)
            Case stop__: setStop (value)
            Case step__: setStep (value)
            Case value__: setValue (value)
        End Select
        lastText(Index) = format(value, fmt)
    End If
    
    GoTo endSub
    
errorSub:
    tbValue(Index).text = lastText(Index) ' if error return to last value
endSub:

End Sub

Public Sub setValue(value As Double)
    Static lastValue As Single
    
    If lastValue <> value Then
        If setPosition(value) Then lastValue = value
    End If
    
    tbValue(value__).text = format(lastValue, fmt)
    
End Sub

Public Function getValue() As Double
    getValue = val(tbValue(value__).text)
End Function

Private Function setParams(param As Integer, value As Double) As Double
    tbValue(param).text = format(value, fmt)
    updateLoopParams
    setParams = tbValue(param).text
End Function

Public Sub setStart(value As Double)
    Static lastValue As Double
    If lastValue <> value Then lastValue = setParams(start__, value)
End Sub

Public Function getStart() As Double
    getStart = val(tbValue(start__).text)
End Function

Public Sub setStop(value As Double)
    Static lastValue As Double
    If lastValue <> value Then lastValue = setParams(stop__, value)
End Sub

Public Function getStop() As Double
    getStop = val(tbValue(stop__).text)
End Function

Public Sub setStep(value As Double)
    Static lastValue As Double
    If lastValue <> value Then lastValue = setParams(step__, value)
End Sub

Public Function getStep() As Double
    getStep = val(tbValue(step__).text)
End Function

Public Sub arm()
    valN = 0
    setValue (getStart)
    cmdArm.BackColor = vbGreen
    cmdArm.enabled = False
    doneLatch = False
End Sub

Public Sub next_()
    If Not done Then
        valN = valN + 1
        setValue (getValue + getStep)
    End If
End Sub

Public Function done() As Boolean
    doneLatch = (getValue >= getStop) Or doneLatch
    done = doneLatch
    If done Then
        cmdArm.BackColor = vbRed
        cmdArm.enabled = True
    End If
End Function

