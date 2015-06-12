Attribute VB_Name = "modTestDefs"
' +______________+
' | Test classes |
' +¯¯¯¯¯¯¯¯¯¯¯¯¯¯+

Type tTestComp
    FW As Integer
    als As Double
    ir As Double
    led As Boolean
    irLed As Boolean
    qth As Boolean
    comp As Integer
    rng As Integer
    alsInp As Boolean
    cTemp As ColorTemp
End Type

Type tTestProxAR
    FW As Integer
    wid As Double
    vih As Double
    prox As Double
    off As Long
    irdr As Long
    ir As Double
End Type

Public testComp As clsTestComp
Public testProxAR As clsTestProxAR
Public testProxARdly As clsTestProxARvsDelay
Public testProxOffset As clsTestProxOffset

