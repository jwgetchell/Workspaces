Attribute VB_Name = "modAdjustOffset"
Public Const i2cAddr As Long = &H88
Public Const Device As String = "ISL29177"

' user definitions
Public Const measBaseTime As Double = 10 ' time in seconds to remeasure baseline
Public Const baselineTarget As Long = 20
Public Const washInitThresh As Long = 26

Public Const persistance As Long = 2 ' 4 from {1,2,4,8} consecutive conversions
Public Const baseLinePersist As Long = 5 'consecutive conversions
Public Const baseLineThresh As Long = -5 'trip point for persistence
Public Const offsetPersist As Long = 2   'consecutive conversions

Public Const irdr As Long = 7 ' 20ma
Public Const sleepTimeInit As Long = 2 ' Index:100ms from {400, 200, 100, 50, 25 ..}
Public Const sleepFast As Long = 4     ' Index:25ms
Public Const tHi As Long = 25
Public Const tLo As Long = tHi - 5

' driver constants
Public Const maxBaseline As Long = 100
Public Const lutSize As Integer = 92
Public Const lutIndexBits As Integer = 7
Public Const blMemSize As Integer = 8

Public Function getBaseline(ByVal valueIn As Integer, Optional ByVal clearBuffer As Boolean = False) As Integer
    Static blMem(blMemSize - 1) As Integer
    Static blSum As Integer
    Static blPtr As Integer
    Static bufFilled As Boolean
    
    If clearBuffer Then
        For blPtr = 0 To blMemSize - 1
            blMem(blPtr) = 0
        Next blPtr
        blSum = 0
        blPtr = 0
        bufFilled = False
    End If
    
    blSum = blSum + valueIn - blMem(blPtr)
    blMem(blPtr) = valueIn
    blPtr = blPtr + 1
    
    If blPtr >= blMemSize Then
        bufFilled = True
        blPtr = 0
    End If
    
    If bufFilled Then
        getBaseline = blSum / blMemSize
    Else
        getBaseline = blSum / blPtr
    End If

End Function

Public Function adjustOffset(als As ucALSusb, prox As Double, xTalk As Double) As Boolean
    ' performs a timer base binary search via repeated calls, timer controls waits
    ' xTalk in FSR
    ' returns done
    
    Static notDone As Boolean ' TRUE: running; FALSE: reset
    Static lastLutIndexBitWeight As Integer
    Static currentLutIndex As Integer
    Static bitCounter As Integer
    Static lastProx As Double
    Static pram As Long
    
    If notDone Then ' running adjustment (main loop)
    
        Debug.Print bitCounter, currentLutIndex, prox
        
        If prox < baselineTarget / 255# Then                                          ' offset is too high
            currentLutIndex = currentLutIndex - lastLutIndexBitWeight ' turn off last bit
        Else
            lastProx = prox
        End If
        
        bitCounter = bitCounter + 1
        
        If bitCounter < lutIndexBits Then                       ' try the next bit
            lastLutIndexBitWeight = lastLutIndexBitWeight / 2
            currentLutIndex = currentLutIndex + lastLutIndexBitWeight
            pram = currentLutIndex: als.dSetProxOffset pram ' pram: writes LutIndex, returns Lut Offset value (counts)
            als.dSetProxIntEnable 0: als.dSetProxIntEnable 1
        Else                                                          ' search done
            notDone = False ' search is complete
            If prox < baselineTarget / 255# Then
                pram = currentLutIndex: als.dSetProxOffset pram
            End If
        End If
        
    Else            ' reset to start adjustment
        bitCounter = 0
        lastLutIndexBitWeight = lutSize / 2
        currentLutIndex = lastLutIndexBitWeight
        pram = currentLutIndex: als.dSetProxOffset pram     ' set Lut to "MSB" (1/2 index)
        als.dSetProxIntEnable 0: als.dSetProxIntEnable 1
        notDone = True
    End If
    
    xTalk = lastProx + pram / 255
    adjustOffset = Not notDone
    
End Function

