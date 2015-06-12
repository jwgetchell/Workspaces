VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsHPIB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Dim m_rm As VisaComLib.ResourceManager
Dim m_devs(32) As VisaComLib.FormattedIO488
Dim m_devDetected(32) As Boolean
Const cTerminationCharacter As Integer = 10

Function GPIBopen(dev As Integer, ins As instr, Optional cp As MSComm)
    On Error GoTo subExit
    
    Set m_devs(ins) = New VisaComLib.FormattedIO488
    Set m_devs(ins).IO = m_rm.Open("GPIB0::" & dev & "::INSTR")
    
    m_devs(ins).IO.TerminationCharacter = cTerminationCharacter
    m_devs(ins).IO.TerminationCharacterEnabled = True
        
    GPIBopen = True: m_devDetected(ins) = True
    
subExit:
End Function

Sub GPIBclose(ins As instr)
    On Error GoTo subExit
subExit:
End Sub

Sub GPIBwrite(msg As String, ins As instr)
    On Error GoTo subExit
    If m_devDetected(ins) Then m_devs(ins).WriteString (msg & Chr$(cTerminationCharacter))
subExit:
End Sub

Function GPIBread(msg As String, ins As instr) As String
    On Error GoTo subExit
    If msg <> "" Then Call GPIBwrite(msg, ins)
    If m_devDetected(ins) Then GPIBread = m_devs(ins).ReadString
subExit:
End Function


Private Sub Class_Initialize()
    Set m_rm = New VisaComLib.ResourceManager
End Sub
