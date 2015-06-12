Option Strict Off
Option Explicit On
Friend Class clsAlsRgbDrv
	
	Private Structure BitField
		Dim addr As Short
		Dim mask As Short
		Dim shift As Short
	End Structure
	
	Private Enum eAddr
		rConfig = &H1
		rRange = 0 ' bit fields (addr 0x01)
		rResolution = 1
		rMode = 2
		rTmodes = &H1A
		r4xMode = eAddr.rMode + 1 ' bit fields (addr 0x1A)
		r8bitMode
		rNbitFields
		rComp = &H2 ' full byte
		rTM = &H0 ' full byte
		rGreen = &H9 ' full words
		rRed = &HB
		rBlue = &HD
	End Enum
	
	Private Enum RW
		eWbyte
		eRbyte
		eWword
		eRword
		eWaddr
		eRaddr
	End Enum
	
    Dim regImage(eAddr.rNbitFields - 1) As BitField

    Dim image(255) As Short

    Dim ranges(2) As Double
    Dim resolutions(2) As Integer
    Dim rangeN As Short
    Dim resolutionN As Short
    Dim mode As Short

    Dim data As Integer

    Dim alsPtr As ucALSusb
    Dim hidPtr As cUsb2I2c

    Public Sub New()
        MyBase.New()

        regImage(eAddr.rMode).addr = eAddr.rConfig : regImage(eAddr.rMode).mask = 7 : regImage(eAddr.rMode).shift = 0
        regImage(eAddr.rRange).addr = eAddr.rConfig : regImage(eAddr.rRange).mask = 1 : regImage(eAddr.rRange).shift = 3
        regImage(eAddr.rResolution).addr = eAddr.rConfig : regImage(eAddr.rResolution).mask = 1 : regImage(eAddr.rResolution).shift = 4

        regImage(eAddr.r4xMode).addr = eAddr.rTmodes : regImage(eAddr.r4xMode).mask = 1 : regImage(eAddr.r4xMode).shift = 2
        regImage(eAddr.r8bitMode).addr = eAddr.rTmodes : regImage(eAddr.r8bitMode).mask = 1 : regImage(eAddr.r8bitMode).shift = 1

        ranges(0) = 375 : ranges(1) = 10250 : ranges(2) = 155
        resolutions(0) = 65535 : resolutions(1) = 4095 : resolutions(2) = 255

    End Sub

    Private Sub enterTestMode()
        hidPtr.DllCallBack(RW.eWbyte, eAddr.rTM, &H89)
        hidPtr.DllCallBack(RW.eWbyte, eAddr.rTM, &HC9)
    End Sub

    Private Sub exitTestMode()
        hidPtr.DllCallBack(RW.eWbyte, eAddr.rTM, &H0)
    End Sub

    Public Sub setAlsDll(ByRef hid As cUsb2I2c, ByRef dll As ucALSusb)
        hidPtr = hid
        alsPtr = dll
    End Sub

    Public Sub setI2cAddr(ByRef addr As Integer)
        hidPtr.DllCallBack(RW.eWaddr, addr, addr)
    End Sub

    Public Sub dGetRed(ByRef value As Double)
        hidPtr.DllCallBack(RW.eRword, eAddr.rRed, data)
        data = data And resolutions(resolutionN)
        value = ranges(rangeN) * data / resolutions(resolutionN)
    End Sub

    Public Sub dGetGreen(ByRef value As Double)
        hidPtr.DllCallBack(RW.eRword, eAddr.rGreen, data)
        data = data And resolutions(resolutionN)
        value = ranges(rangeN) * data / resolutions(resolutionN)
    End Sub

    Public Sub dGetBlue(ByRef value As Double)
        hidPtr.DllCallBack(RW.eRword, eAddr.rBlue, data)
        data = data And resolutions(resolutionN)
        value = ranges(rangeN) * data / resolutions(resolutionN)
    End Sub

    Private Sub rmwConfig(ByRef regIn As BitField, ByRef value As Integer)
        Dim Config As Integer : Config = image(regIn.addr)
        Config = Config And (255 - regIn.mask * 2 ^ regIn.shift)
        value = value And regIn.mask
        Config = Config Or (value * 2 ^ regIn.shift)
        hidPtr.DllCallBack(RW.eWbyte, regIn.addr, Config)
        image(regIn.addr) = Config
    End Sub

    Public Sub dSetInputSelect(ByVal chan As Integer, ByVal value As Integer)

        Dim modeVal As Integer
        'value={OFF,ALS,RGB}
        modeVal = value : If value = 2 Then modeVal = 5
        rmwConfig(regImage(eAddr.rMode), modeVal)

    End Sub

    Public Sub dSetIRcomp(ByVal value As Integer)
        hidPtr.DllCallBack(RW.eWbyte, eAddr.rComp, value And 255)
    End Sub
    Public Sub dGetIRcomp(ByRef value As Integer)
        hidPtr.DllCallBack(RW.eRbyte, eAddr.rComp, value)
    End Sub

    Public Sub dSetRange(ByVal chan As Integer, ByVal value As Integer)

        If value < 2 Then
            rmwConfig(regImage(eAddr.rRange), value)
            enterTestMode()
            hidPtr.DllCallBack(RW.eWbyte, &H1C, &H0) ' reset gain to 1
            hidPtr.DllCallBack(RW.eWbyte, &H19, &H0) ' return to fuse mode
            exitTestMode()
        Else
            ' |||| Test Mode ||||
            value = 2
            rmwConfig(regImage(eAddr.rRange), 0)
            enterTestMode()
            hidPtr.DllCallBack(RW.eWbyte, &H19, &H40) ' switch to register mode
            hidPtr.DllCallBack(RW.eWbyte, &H1C, &H2) ' set gain to Max (2.3)
            exitTestMode()
        End If

        rangeN = value

    End Sub

    Public Function dGetRange(ByVal chan As Integer, ByRef value As Integer) As Integer
        value = rangeN
    End Function

    Public Sub dSetResolution(ByVal chan As Integer, ByVal value As Integer)

        Static lastValue As Integer

        If value < 2 Then
            If lastValue = 2 Then
                enterTestMode()
                rmwConfig(regImage(eAddr.r8bitMode), 0)
                exitTestMode()
            End If

            rmwConfig(regImage(eAddr.rResolution), value)

        Else
            enterTestMode()
            rmwConfig(regImage(eAddr.r8bitMode), 1)
            exitTestMode()
            value = 2
        End If

        resolutionN = value
        lastValue = value

    End Sub

    Public Function dGetResolution(ByVal chan As Integer, ByRef value As Integer) As Integer
        value = resolutionN
    End Function

    Public Sub dEnable4x(ByRef value As Integer)
        enterTestMode()
        rmwConfig(regImage(eAddr.r4xMode), value)
        exitTestMode()
    End Sub
    Public Sub dEnable8bit(ByRef value As Integer)
        enterTestMode()
        rmwConfig(regImage(eAddr.r4xMode), 0)
        exitTestMode()
    End Sub




    Public Function dGetNrange(ByVal chan As Integer, ByRef value As Integer) As Integer
        Debug.Print("h")
        alsPtr.dGetNrange(0, value)
    End Function
    Public Sub dGetRangeList(ByVal chan As Integer, ByRef list As Integer)
        alsPtr.dGetRangeList(0, list)
    End Sub

    Public Function dGetNresolution(ByVal chan As Integer, ByRef value As Integer) As Integer
        alsPtr.dGetNresolution(0, value)
    End Function
    Public Sub dGetResolutionList(ByVal chan As Integer, ByRef list As Integer)
        alsPtr.dGetResolutionList(0, list)
    End Sub



    Public Function getEEpromObj() As clsEEprom
        getEEpromObj = alsPtr.getEEpromObj
    End Function

    Public Sub dWriteField(ByVal a As Byte, ByVal s As Byte, ByVal m As Byte, ByVal D As Byte)
        Dim bVal As BitField
        Dim data As Integer : data = D
        bVal.addr = a : bVal.shift = s : bVal.mask = m
        rmwConfig(bVal, data)
        D = data And 255
    End Sub

    Public Sub dReadField(ByVal a As Byte, ByVal s As Byte, ByVal m As Byte, ByRef D As Byte)
        Dim data As Integer : data = D
        hidPtr.DllCallBack(RW.eRbyte, a, data)
        D = (data * 2 ^ -s) And m
    End Sub
End Class