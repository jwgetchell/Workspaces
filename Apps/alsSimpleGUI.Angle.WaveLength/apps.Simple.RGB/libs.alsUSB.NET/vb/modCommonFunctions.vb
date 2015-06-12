Option Strict Off
Option Explicit On
Module modCommonFunctions
	Private Structure doublePrecision
		Dim data As Double
	End Structure
	
	Private Structure float
		Dim data As Single
	End Structure
	
	Private Structure dateType
		Dim data As Date
    End Structure

    Private Structure byte8
        <VBFixedArray(7)> Dim data() As Byte

        'UPGRADE_TODO: "Initialize" must be called to initialize instances of this structure. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="B4BFF9E0-8631-45CF-910E-62AB3970F27B"'
        Public Sub Initialize()
            ReDim data(7)
        End Sub
    End Structure

    '|||||||||||||||||||||||||||||


    Public Function enterText(ByRef text As String) As Short
        ' strip [cr] & [lf], return > 0
        enterText = InStr(text, Chr(13))
        If (enterText) Then
            text = Mid(text, 1, enterText - 1)
        End If
    End Function


    '======================================================
    Public Function single2byte(ByRef real As Single, ByRef bits() As Byte, Optional ByVal index As Short = 0) As Short

        'UPGRADE_WARNING: Arrays in structure outData may need to be initialized before they can be used. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="814DF224-76BD-4BB4-BFFB-EA359CB9FC48"'
        Dim i As Short
        Dim indata As Single  ' JWG indata As float
        Dim outData(7) As Byte ' JWG outData As byte8

        indata = real ' JWG indata.data
        'UPGRADE_ISSUE: LSet cannot assign one type to another. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="899FA812-8F71-4014-BAEE-E5AF348BA5AA"'
        ucALSusb.cFloat2CharAry(indata, outData) ' JWG outData = LSet(indata, 8)

        For i = 0 To Len(real) - 1
            bits(i + index) = outData(i) ' JWG bits(i + index) = outData.data(i)
        Next i

        single2byte = index + i

    End Function
    '------------------------------------------------------
    Public Function byte2single(ByRef bits() As Byte, ByRef real As Single, Optional ByVal index As Short = 0) As Short

        'UPGRADE_WARNING: Arrays in structure indata may need to be initialized before they can be used. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="814DF224-76BD-4BB4-BFFB-EA359CB9FC48"'
        Dim i As Short
        Dim indata(7) As Byte ' JWG indata As byte8
        Dim outData As Single ' JWG outData As float

        For i = 0 To Len(real) - 1
            indata(i) = bits(i + index) ' JWG indata.data(i) = bits(i + index)
        Next i

        'UPGRADE_ISSUE: LSet cannot assign one type to another. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="899FA812-8F71-4014-BAEE-E5AF348BA5AA"'
        ucALSusb.cCharAry2Float(indata, outData) ' JWG outData = LSet(indata)
        real = outData ' JWG outData.data

        byte2single = index + i

    End Function
    '======================================================


    '======================================================
    Public Function double2byte(ByRef real As Double, ByRef bits() As Byte, Optional ByVal index As Short = 0) As Short

        'UPGRADE_WARNING: Arrays in structure outData may need to be initialized before they can be used. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="814DF224-76BD-4BB4-BFFB-EA359CB9FC48"'
        Dim i As Short
        Dim indata As Double ' JWG doublePrecision
        Dim outData(7) As Byte ' JWG byte8

        indata = real ' JWG .data
        'UPGRADE_ISSUE: LSet cannot assign one type to another. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="899FA812-8F71-4014-BAEE-E5AF348BA5AA"'
        ucALSusb.cDouble2CharAry(indata, outData) ' JWG outData = LSet(indata)

        For i = 0 To Len(real) - 1
            bits(i + index) = outData(i) ' JWG .data(i)
        Next i

        double2byte = index + i

    End Function
    '------------------------------------------------------
    Public Function byte2double(ByRef bits() As Byte, ByRef real As Double, Optional ByVal index As Short = 0) As Short

        'UPGRADE_WARNING: Arrays in structure indata may need to be initialized before they can be used. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="814DF224-76BD-4BB4-BFFB-EA359CB9FC48"'
        Dim i As Short
        Dim indata(7) As Byte ' JWG byte8
        Dim outData As Double ' JWG doublePrecision

        For i = 0 To Len(real) - 1
            indata(i) = bits(i + index) ' JWG indata.data(i) = bits(i + index)
        Next i

        'UPGRADE_ISSUE: LSet cannot assign one type to another. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="899FA812-8F71-4014-BAEE-E5AF348BA5AA"'
        ucALSusb.cCharAry2Double(indata, outData) ' JWG outData = LSet(indata)
        real = outData ' JWG .data

        byte2double = index + i

    End Function
    '======================================================


    '======================================================
    Public Function date2byte(ByRef real As Date, ByRef bits() As Byte, Optional ByVal index As Short = 0) As Short

        'UPGRADE_WARNING: Arrays in structure outData may need to be initialized before they can be used. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="814DF224-76BD-4BB4-BFFB-EA359CB9FC48"'
        Dim i As Short
        Dim indata As Date ' JWG dateType
        Dim outData(7) As Byte ' JWG byte8

        indata = real ' JWG .data
        'UPGRADE_ISSUE: LSet cannot assign one type to another. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="899FA812-8F71-4014-BAEE-E5AF348BA5AA"'
        ucALSusb.cDate2CharAry(indata, outData) ' JWG outData = LSet(indata)

        For i = 0 To Len(real) - 1
            bits(i + index) = outData(i) ' JWG .data(i)
        Next i

        date2byte = index + i

    End Function
    '------------------------------------------------------
    Public Function byte2date(ByRef bits() As Byte, ByRef real As Date, Optional ByVal index As Short = 0) As Short

        'UPGRADE_WARNING: Arrays in structure indata may need to be initialized before they can be used. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="814DF224-76BD-4BB4-BFFB-EA359CB9FC48"'
        Dim i As Short
        Dim indata(7) As Byte ' JWG byte8
        Dim outData As Date ' JWG dateType

        For i = 0 To Len(real) - 1
            indata(i) = bits(i + index) ' JWG .data
        Next i

        'UPGRADE_ISSUE: LSet cannot assign one type to another. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="899FA812-8F71-4014-BAEE-E5AF348BA5AA"'
        ucALSusb.cCharAry2Date(indata, outData) ' JWG outData = LSet(indata)
        real = outData ' JWG .data

        byte2date = index + i

    End Function
	'======================================================
	
	
	Public Function getExeDateTime(ByRef exe As String) As Date
		
		Dim file As String : file = My.Application.Info.DirectoryPath & "\" & exe
		
		'UPGRADE_WARNING: Dir has a new behavior. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="9B7D5ADD-D8FE-4819-A36C-6DEDAF088CC7"'
		If Dir(file) <> "" Then ' installer location
			getExeDateTime = FileDateTime(file)
		Else ' development location
			file = My.Application.Info.DirectoryPath & "\..\..\output\Debug\bin\" & exe
			'UPGRADE_WARNING: Dir has a new behavior. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="9B7D5ADD-D8FE-4819-A36C-6DEDAF088CC7"'
			If Dir(file) <> "" Then getExeDateTime = FileDateTime(file)
		End If
		
	End Function
End Module