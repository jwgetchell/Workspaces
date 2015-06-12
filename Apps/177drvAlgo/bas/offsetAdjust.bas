Attribute VB_Name = "Module1"
Private Function adjustOffset(als As ucALSusb) As Double

    Static pTable(12) As Long
    Dim i As Long
    
    If pTable(0) = 0 Then
        pTable(i) = 30: i = i + 1: pTable(i) = 45: i = i + 1
        pTable(i) = 53: i = i + 1: pTable(i) = 58: i = i + 1
        pTable(i) = 63: i = i + 1: pTable(i) = 66: i = i + 1
        pTable(i) = 69: i = i + 1: pTable(i) = 72: i = i + 1
        pTable(i) = 74: i = i + 1: pTable(i) = 77: i = i + 1
        pTable(i) = 79: i = i + 1: pTable(i) = 81: i = i + 1
        pTable(i) = 82: i = i + 1
    End If

    Dim sleepTime As Long, pOffset As Long, prox As Double, pram As Long
            
    als.dGetSleep sleepTime
    als.dSetSleep 5
    als.dSetEnable 1, 1
    als.dSetProxOffset 0
    Sleep 25: DoEvents
    als.dGetProximity prox
    
    i = 0
    Do While prox > 0.5
        pOffset = pTable(i): pram = pOffset
        als.dSetProxOffset pram
        Sleep 25: DoEvents
        als.dGetProximity prox
        i = i + 1: If i > 12 Then Exit Do
    Loop
    
    Do While prox > 0.01
        pOffset = pOffset + 1: pram = pOffset
        als.dSetProxOffset pram
        Sleep 25: DoEvents
        als.dGetProximity prox
        If i > 92 Then Exit Do
    Loop
    
    Do While prox < 0.01
        pOffset = pOffset - 1: pram = pOffset
        als.dSetProxOffset pram
        Sleep 25: DoEvents
        als.dGetProximity prox
        If i = 0 Then Exit Do
    Loop
    
    adjustOffset = prox + pram / 255

End Function


