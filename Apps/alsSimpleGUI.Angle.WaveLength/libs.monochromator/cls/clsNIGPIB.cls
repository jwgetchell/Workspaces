VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsNIGPIB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Dim m_mcm As IMessage ' monochromator
Dim m_opm As IMessage ' Newport Optical Power Meter
Dim m_vi As IMessage ' Keithley 2400 SourceMeter
Dim m_vi3631 As IMessage ' HP 3631 Power Supply

Dim m_rm As IResourceManager
Dim m_devs(32) As IMessage
Dim m_devDetected(32) As Boolean
Const cReadString As Integer = 1000
Const cTerminationCharacter As Integer = 10

Function GPIBopen(dev As Integer, ins As instr, Optional cp As MSComm) As Boolean
    On Error GoTo subExit
    
    Dim hImessage As IMessage
    Set hImessage = m_rm.Open("GPIB0::" & dev & "::INSTR")
    Set m_devs(ins) = hImessage
    
    m_devs(ins).TerminationCharacter = cTerminationCharacter
    m_devs(ins).TerminationCharacterEnabled = True
    
    GPIBopen = True: m_devDetected(ins) = True
    
subExit:
End Function

Sub GPIBclose(ins As instr)
    On Error GoTo subExit
    m_devs(ins).Close
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
    If m_devDetected(ins) Then GPIBread = m_devs(ins).ReadString(cReadString)
subExit:
End Function



Private Sub Class_Initialize()
    Set m_rm = CreateObject("VISA.GlobalRM")
End Sub
