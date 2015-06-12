Option Strict Off
Option Explicit On
Imports VB = Microsoft.VisualBasic
Friend Class frmEEprom
	Inherits System.Windows.Forms.Form
	Dim EEprom As clsEEprom
	
	Dim widthMin As Short
	Dim heightMin As Short
	Dim widthText As Short
	Dim heightText As Short
	Dim topFirst As Short
	Dim heightMenu As Short
	
	Enum eepromButtons
		cmdNew
		cmdReadFile
		cmdWriteFile
		cmdReadHdw
		cmdWriteHdw
		cmdDeleteFile
		cmdNcmds
	End Enum
	
	Dim CallBackForm As System.Windows.Forms.Form
	
	Const tbTwipOffset As Short = 70
	Const tbTwipPerLineMin As Short = 275 ' height = tbTwipPerLineMin * #/lines + tbTwipOffset
	Dim tbTwipSpace As Short
	'Dim nRecords As Integer, lines() As Integer
	
	Dim fileDrive As String
	Dim fileDirectory As String
	Dim fileName As String
	
	Const ShowEMUdebug As Boolean = True
	'UPGRADE_NOTE: newDefault was changed from a Constant to a Variable. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="C54B49D7-5804-4D48-834B-B3D81E4C2F13"'
	Dim newDefault As Short = modEEprom.eePromRevs.E004
	
	Private Sub setFile()
		ChDir(fileDirectory)
		File1.Path = fileDirectory
		
		lblDirectory.Text = fileDirectory & "\"
		
		If Len(lblDirectory.Text) > 50 Then
			lblDirectory.TextAlign = System.Drawing.ContentAlignment.TopRight
		Else
			lblDirectory.TextAlign = System.Drawing.ContentAlignment.TopLeft
		End If
		
		'UPGRADE_WARNING: Dir has a new behavior. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="9B7D5ADD-D8FE-4819-A36C-6DEDAF088CC7"'
		If Dir(lblDirectory.Text & fileName) <> "" Then
			tbFile.Text = fileName
		Else
			tbFile.Text = ""
		End If
		
	End Sub
	
	
	Private Sub Drive1_SelectedIndexChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles Drive1.SelectedIndexChanged
		Dim parse() As String
		Dim directory As String
		parse = Split(Drive1.Drive, ":")
		fileDrive = parse(0) & ":"
		ChDir(fileDrive)
		Dir1.Path = fileDrive
		Dir1_Change(Dir1, New System.EventArgs())
	End Sub
	
	Private Sub Dir1_Change(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles Dir1.Change
		fileDirectory = Dir1.Path
		setFile()
	End Sub
	
	Private Sub File1_SelectedIndexChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles File1.SelectedIndexChanged
		fileName = File1.FileName
		setFile()
	End Sub
	
	Private Sub File1_DoubleClick(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles File1.DoubleClick
		File1_SelectedIndexChanged(File1, New System.EventArgs())
		cmdEEpromIO_Click(cmdEEpromIO.Item((eepromButtons.cmdReadFile)), New System.EventArgs())
	End Sub
	
	'UPGRADE_WARNING: Event cbByteAddr.CheckStateChanged may fire when form is initialized. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="88B12AE1-6DE0-48A0-86F1-60C0686C026A"'
	Private Sub cbByteAddr_CheckStateChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cbByteAddr.CheckStateChanged
		If cbByteAddr.CheckState = System.Windows.Forms.CheckState.Checked Then
			cbByteAddr.Text = "Addr:Byte"
			EEprom.setI2c2ByteAddr(True)
		Else
			cbByteAddr.Text = "Addr:Word"
			EEprom.setI2c2ByteAddr(False)
		End If
	End Sub
	
	Public Sub setCallBackForm(ByRef cbForm As System.Windows.Forms.Form)
		CallBackForm = cbForm
	End Sub
	
	Public Sub init(ByRef prom As clsEEprom)
		Dim i As Short
		Dim parse() As String
		
		On Error Resume Next
		
		EEprom = prom
		
		' start with a default version
		EEprom.newEEprom(2)
		EEprom.setTBobj(txtEEprom(0))
		EEprom.setTBobj(txtEEprom(1), 1)
		
		i = EEprom.getI2c
		
		If i > 0 Then
			cmbAddr.Text = "0x" & Hex(i)
			cmdEEpromIO_Click(cmdEEpromIO.Item((eepromButtons.cmdReadHdw)), New System.EventArgs())
			If EEprom.getEEpromVersion > 0 Then
				cmbAddr_SelectedIndexChanged(cmbAddr, New System.EventArgs())
				Exit Sub ' Successful preset
			End If
		Else ' try to scan
			For i = 0 To cmbAddr.Items.Count ' 1 extra (eval byte mode)
				If i = 0 Then
					cmbAddr.SelectedIndex = i
					cbByteAddr.CheckState = System.Windows.Forms.CheckState.Checked : cbByteAddr_CheckStateChanged(cbByteAddr, New System.EventArgs())
				Else
					cmbAddr.SelectedIndex = i - 1
					cbByteAddr.CheckState = System.Windows.Forms.CheckState.Unchecked : cbByteAddr_CheckStateChanged(cbByteAddr, New System.EventArgs())
				End If
				parse = Split(cmbAddr.Text, "x")
				
				EEprom.setI2c(CShort("&H" & parse(1)))
				cmdEEpromIO_Click(cmdEEpromIO.Item((eepromButtons.cmdReadHdw)), New System.EventArgs())
				If EEprom.getEEpromVersion > 0 Then
					If EEprom.getCardGain(0) > 0 Then
						cmbAddr_SelectedIndexChanged(cmbAddr, New System.EventArgs())
						If ShowEMUdebug Then
							readEMU()
						End If
						Exit Sub ' Successful scan
					End If
				End If
			Next i
		End If
		
		EEprom.getFile("", Me) : loadCalibration()
		
		cmbAddr.Text = "0x00" ' no EEprom found
		parse = Split(frmHdw.Text, ":")
		frmHdw.Text = parse(0) & ":None"
		
	End Sub
	
	'UPGRADE_WARNING: Event cmbAddr.SelectedIndexChanged may fire when form is initialized. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="88B12AE1-6DE0-48A0-86F1-60C0686C026A"'
	Private Sub cmbAddr_SelectedIndexChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmbAddr.SelectedIndexChanged
		
		Dim parse() As String
		Dim addr As Short
		
		parse = Split(cmbAddr.Text, "x")
		addr = CShort("&H" & parse(1))
		
		parse = Split(frmHdw.Text, ":")
		
		frmHdw.Text = parse(0) & ":"
		
		Select Case addr
			Case modEEprom.eePromAddrs.evaluationCard : frmHdw.Text = frmHdw.Text & "Evaluation Card"
			Case modEEprom.eePromAddrs.paletteCard : frmHdw.Text = frmHdw.Text & "Palette Card"
			Case modEEprom.eePromAddrs.systemCard : frmHdw.Text = frmHdw.Text & "System I/O Card"
		End Select
		
		EEprom.setI2c(addr)
		
		enableReadWrites()
		
	End Sub
	
	Public Sub setEEpromObjs()
		Dim nRec As Object
		Dim i As Short
		'UPGRADE_WARNING: Couldn't resolve default property of object nRec. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		nRec = EEprom.getNrecords
		'UPGRADE_WARNING: Couldn't resolve default property of object nRec. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		For i = 0 To nRec - 1
			EEprom.setTBobj(txtEEprom(i), i)
		Next i
	End Sub
	
	Private Sub enableReadWrites()
		
		Dim i, nRec As Short
		
		If EEprom.getI2c Then
			cmdEEpromIO(eepromButtons.cmdReadHdw).Enabled = True
		End If
		
		If EEprom.getEEpromVersion Then
			
			cmdEEpromIO(eepromButtons.cmdWriteFile).Enabled = True
			
			If EEprom.getI2c Then
				cmdEEpromIO(eepromButtons.cmdWriteHdw).Enabled = True
			End If
			
			frmEEprom_Resize(Me, New System.EventArgs())
			
			setEEpromObjs()
			
		End If
		
	End Sub
	
	Private Sub loadCalibration()
		'UPGRADE_WARNING: Arrays in structure dummy may need to be initialized before they can be used. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="814DF224-76BD-4BB4-BFFB-EA359CB9FC48"'
		Dim i As Short
		Dim dummy As calValues
		For i = 0 To UBound(dummy.CCM)
			'UPGRADE_ISSUE: Control loadCalibration could not be resolved because it was within the generic namespace Form. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="084D22AD-ECB1-400F-B4C7-418ECEC5E36E"'
			CallBackForm.loadCalibration(i)
		Next i
	End Sub
	
	Private Sub cmdEEpromIO_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdEEpromIO.Click
		Dim Index As Short = cmdEEpromIO.GetIndex(eventSender)
		
		'Dim i As Integer, nRec As Integer, dummy As calValues
		
		On Error Resume Next
		
		Select Case Index
			Case eepromButtons.cmdNew : EEprom.newEEprom(newDefault) 'InputBox("Select Version between 1 and " & eePromRevs.Last - 1)
			Case eepromButtons.cmdReadFile : If tbFile.Text <> "" Then EEprom.getFile(lblDirectory.Text & tbFile.Text, Me)
			Case eepromButtons.cmdWriteFile : If tbFile.Text <> "" Then EEprom.setFile(lblDirectory.Text & tbFile.Text) : File1.Refresh()
			Case eepromButtons.cmdReadHdw : EEprom.getEEprom(Me)
			Case eepromButtons.cmdWriteHdw : EEprom.setEEprom()
			Case eepromButtons.cmdDeleteFile : Kill(lblDirectory.Text & tbFile.Text) : tbFile.Text = "" & vbCr : File1.Refresh()
		End Select
		
		enableReadWrites()
		
		loadCalibration()
		
		'    For i = 0 To UBound(dummy.CCM)
		'        CallBackForm.loadCalibration i
		'    Next i
		
	End Sub
	
	Private Function getHeightText(ByRef lines As Short) As Short
		Dim tbTwipPerLine As Object
		'UPGRADE_WARNING: Couldn't resolve default property of object tbTwipPerLine. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		getHeightText = tbTwipOffset + lines * tbTwipPerLine
	End Function
	
	Private Sub setTBtopHeight(ByRef tb As System.Windows.Forms.TextBox, ByRef lines As Short)
		Dim tbTwipPerLine As Object
		
		'UPGRADE_ISSUE: TextBox property tb.Index was not upgraded. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="CC4C7EC0-C903-48FC-ACCC-81861D12DA4A"'
		If tb.Index = 0 Then
			'UPGRADE_ISSUE: TextBox property tb.Index was not upgraded. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="CC4C7EC0-C903-48FC-ACCC-81861D12DA4A"'
			tb.Top = VB6.TwipsToPixelsY(VB6.PixelsToTwipsY(txtEEprom(tb.Index - 1).Top) + VB6.PixelsToTwipsY(txtEEprom(tb.Index - 1).Height))
		Else
			tb.Top = VB6.TwipsToPixelsY(topFirst)
		End If
		
		'UPGRADE_WARNING: Couldn't resolve default property of object tbTwipPerLine. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		If tbTwipPerLine < tbTwipPerLineMin Then tbTwipPerLine = tbTwipPerLineMin
		
		'UPGRADE_WARNING: Couldn't resolve default property of object tbTwipPerLine. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		tb.Height = VB6.TwipsToPixelsY(lines * tbTwipPerLine + tbTwipOffset)
		
	End Sub
	
	Public Sub ReadFile()
		
		If cmbAddr.Text = "0x00" Then cmdEEpromIO_Click(cmdEEpromIO.Item((eepromButtons.cmdReadFile)), New System.EventArgs())
		
	End Sub
	
	Private Sub frmEEprom_Load(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Load
		Dim tbTwipPerLine As Object
		Dim i, lines As Short
		widthMin = VB6.PixelsToTwipsX(Width)
		widthText = VB6.PixelsToTwipsX(Width) - VB6.PixelsToTwipsX(txtEEprom(0).Width)
		topFirst = VB6.PixelsToTwipsY(txtEEprom(0).Top)
		tbTwipSpace = VB6.PixelsToTwipsY(txtEEprom(1).Top) - (VB6.PixelsToTwipsY(txtEEprom(0).Top) + VB6.PixelsToTwipsY(txtEEprom(0).Height))
		
		'UPGRADE_WARNING: Couldn't resolve default property of object tbTwipPerLine. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		tbTwipPerLine = tbTwipPerLineMin
		
		For i = txtEEprom.LBound To txtEEprom.UBound
			txtEEprom(i).Text = ""
			'UPGRADE_WARNING: Couldn't resolve default property of object tbTwipPerLine. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
			lines = lines + (VB6.PixelsToTwipsY(txtEEprom(i).Height) - tbTwipOffset) / tbTwipPerLine
		Next i
		
		heightText = VB6.PixelsToTwipsY(Height) - getHeightText(lines)
		heightMin = heightText
		heightMin = VB6.PixelsToTwipsY(Height)
		heightMenu = VB6.PixelsToTwipsY(Height) - VB6.PixelsToTwipsY(frmFile.Height)
		
		'--------------------------------
		fileDrive = VB.Left(Drive1.Drive, 2)
		'UPGRADE_WARNING: Dir has a new behavior. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="9B7D5ADD-D8FE-4819-A36C-6DEDAF088CC7"'
		If Dir(Dir1.Path & "\CCMfiles\*") <> "" Then ChDir(Dir1.Path & "\CCMfiles") : Dir1.Path = CurDir()
		fileDirectory = Dir1.Path
		fileName = tbFile.Text 'File1.fileName
		File1.FileName = "*.txt"
		setFile()
		'--------------------------------
		
		cmbAddr.Items.Add("0x" & Hex(modEEprom.eePromAddrs.evaluationCard))
		cmbAddr.Items.Add("0x" & Hex(modEEprom.eePromAddrs.paletteCard))
		cmbAddr.Items.Add("0x" & Hex(modEEprom.eePromAddrs.systemCard))
		
		frmEMUdebug.Visible = ShowEMUdebug
		
	End Sub
	
	Private Sub enterTM()
		'UPGRADE_ISSUE: COM expression not supported: Module methods of COM objects. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="5D48BAC6-2CD4-45AD-B1CC-8E4A241CDB58"'
		als.writeField(0, 0, &HFF, &H89)
		'UPGRADE_ISSUE: COM expression not supported: Module methods of COM objects. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="5D48BAC6-2CD4-45AD-B1CC-8E4A241CDB58"'
		als.writeField(0, 0, &HFF, &HC9)
	End Sub
	
	Private Sub exitTM()
		'UPGRADE_ISSUE: COM expression not supported: Module methods of COM objects. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="5D48BAC6-2CD4-45AD-B1CC-8E4A241CDB58"'
		als.writeField(0, 0, &HFF, 0)
	End Sub
	
	Private Function invertNibLsb(ByRef nibble As Byte) As Object
		If nibble > 7 Then
			'UPGRADE_WARNING: Couldn't resolve default property of object invertNibLsb. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
			invertNibLsb = nibble
		Else
			'UPGRADE_WARNING: Couldn't resolve default property of object invertNibLsb. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
			invertNibLsb = nibble Xor 7
		End If
	End Function
	
	Private Sub readEMU()
		Dim emu As Byte
		
		enterTM()
		
		'UPGRADE_ISSUE: COM expression not supported: Module methods of COM objects. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="5D48BAC6-2CD4-45AD-B1CC-8E4A241CDB58"'
		emu = als.readField(&H19, 6, 1) ' read emu bit set
		
		'UPGRADE_ISSUE: COM expression not supported: Module methods of COM objects. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="5D48BAC6-2CD4-45AD-B1CC-8E4A241CDB58"'
		als.writeField(&H19, 6, 1, 0) ' set to fuse
		
		'UPGRADE_ISSUE: COM expression not supported: Module methods of COM objects. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="5D48BAC6-2CD4-45AD-B1CC-8E4A241CDB58"'
		'UPGRADE_WARNING: Couldn't resolve default property of object invertNibLsb(). Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		cmbAll.Text = invertNibLsb(als.readField(&H1D, 4, &HF)) ' read coarse (all)
		'UPGRADE_ISSUE: COM expression not supported: Module methods of COM objects. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="5D48BAC6-2CD4-45AD-B1CC-8E4A241CDB58"'
		'UPGRADE_WARNING: Couldn't resolve default property of object invertNibLsb(). Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		cmbRB.Text = invertNibLsb(als.readField(&H1D, 0, &HF)) ' read fine (R&B)
		
		'UPGRADE_ISSUE: COM expression not supported: Module methods of COM objects. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="5D48BAC6-2CD4-45AD-B1CC-8E4A241CDB58"'
		als.writeField(&H19, 6, 1, emu) ' reset to emu value
		
		exitTM()
		
	End Sub
	
	'UPGRADE_WARNING: Event cbFuseReg.CheckStateChanged may fire when form is initialized. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="88B12AE1-6DE0-48A0-86F1-60C0686C026A"'
	Private Sub cbFuseReg_CheckStateChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cbFuseReg.CheckStateChanged
		If cbFuseReg.CheckState = System.Windows.Forms.CheckState.Checked Then
			cbFuseReg.Text = "Reg"
			enterTM()
			'UPGRADE_ISSUE: COM expression not supported: Module methods of COM objects. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="5D48BAC6-2CD4-45AD-B1CC-8E4A241CDB58"'
			als.writeField(&H19, 6, 1, 1) ' set to reg
			cmbAll.Enabled = True
			cmbRB.Enabled = True
		Else
			cbFuseReg.Text = "Fuse"
			enterTM()
			'UPGRADE_ISSUE: COM expression not supported: Module methods of COM objects. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="5D48BAC6-2CD4-45AD-B1CC-8E4A241CDB58"'
			als.writeField(&H19, 6, 1, 0) ' set to fuse
			cmbAll.Enabled = False
			cmbRB.Enabled = False
		End If
		
		'UPGRADE_ISSUE: COM expression not supported: Module methods of COM objects. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="5D48BAC6-2CD4-45AD-B1CC-8E4A241CDB58"'
		'UPGRADE_WARNING: Couldn't resolve default property of object invertNibLsb(). Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		cmbAll.Text = invertNibLsb(als.readField(&H1D, 4, &HF)) ' read coarse (all)
		'UPGRADE_ISSUE: COM expression not supported: Module methods of COM objects. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="5D48BAC6-2CD4-45AD-B1CC-8E4A241CDB58"'
		'UPGRADE_WARNING: Couldn't resolve default property of object invertNibLsb(). Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		cmbRB.Text = invertNibLsb(als.readField(&H1D, 0, &HF)) ' read fine (R&B)
		exitTM()
		
	End Sub
	
	'UPGRADE_WARNING: Event cmbAll.SelectedIndexChanged may fire when form is initialized. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="88B12AE1-6DE0-48A0-86F1-60C0686C026A"'
	Private Sub cmbAll_SelectedIndexChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmbAll.SelectedIndexChanged
		On Error Resume Next
		enterTM()
		'UPGRADE_WARNING: Couldn't resolve default property of object invertNibLsb(). Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		'UPGRADE_ISSUE: COM expression not supported: Module methods of COM objects. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="5D48BAC6-2CD4-45AD-B1CC-8E4A241CDB58"'
		als.writeField(&H1B, 4, &HF, invertNibLsb((cmbAll.SelectedIndex)))
		cbFuseReg_CheckStateChanged(cbFuseReg, New System.EventArgs())
	End Sub
	
	'UPGRADE_WARNING: Event cmbRB.SelectedIndexChanged may fire when form is initialized. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="88B12AE1-6DE0-48A0-86F1-60C0686C026A"'
	Private Sub cmbRB_SelectedIndexChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmbRB.SelectedIndexChanged
		On Error Resume Next
		enterTM()
		'UPGRADE_WARNING: Couldn't resolve default property of object invertNibLsb(). Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		'UPGRADE_ISSUE: COM expression not supported: Module methods of COM objects. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="5D48BAC6-2CD4-45AD-B1CC-8E4A241CDB58"'
		als.writeField(&H1B, 0, &HF, invertNibLsb((cmbRB.SelectedIndex)))
		cbFuseReg_CheckStateChanged(cbFuseReg, New System.EventArgs())
	End Sub
	
	Public Sub cmdFuse2Reg_Enable(Optional ByRef enable As Short = 1)
		
		Dim cbFuseReg_value As Short : cbFuseReg_value = cbFuseReg.CheckState
		Dim trimValue As Byte
		
		If enable <> 0 Then enable = 1
		
		cbFuseReg.CheckState = System.Windows.Forms.CheckState.Unchecked : cbFuseReg_CheckStateChanged(cbFuseReg, New System.EventArgs()) ' set to Fuse
		enterTM()
		'UPGRADE_ISSUE: COM expression not supported: Module methods of COM objects. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="5D48BAC6-2CD4-45AD-B1CC-8E4A241CDB58"'
		trimValue = als.readField(&H1D, 0, &HFF)
		'UPGRADE_ISSUE: COM expression not supported: Module methods of COM objects. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="5D48BAC6-2CD4-45AD-B1CC-8E4A241CDB58"'
		als.writeField(&H19, 6, 1, 1) ' set to reg
		'UPGRADE_ISSUE: COM expression not supported: Module methods of COM objects. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="5D48BAC6-2CD4-45AD-B1CC-8E4A241CDB58"'
		als.writeField(&H1B, 0, &HFF, trimValue * enable) ' write fuse value into reg
		cbFuseReg.CheckState = cbFuseReg_value : cbFuseReg_CheckStateChanged(cbFuseReg, New System.EventArgs()) ' reset to original
		
	End Sub
	
	Private Sub cmdFuse2Reg_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdFuse2Reg.Click
		
		cmdFuse2Reg_Enable()
		
	End Sub
	
	'UPGRADE_NOTE: Form_Terminate was upgraded to Form_Terminate_Renamed. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="A9E4979A-37FA-4718-9994-97DD76ED70A7"'
	'UPGRADE_WARNING: frmEEprom event Form.Terminate has a new behavior. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6BA9B8D2-2A32-4B6E-8D36-44949974A5B4"'
	Private Sub Form_Terminate_Renamed()
		cmbAddr.Items.Clear()
	End Sub
	
	
	'UPGRADE_WARNING: Event frmEEprom.Resize may fire when form is initialized. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="88B12AE1-6DE0-48A0-86F1-60C0686C026A"'
	Private Sub frmEEprom_Resize(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Resize
		
		On Error Resume Next
		
		Dim nRecords, i As Short
		Dim linesPerTB() As Short
		If WindowState <> System.Windows.Forms.FormWindowState.Minimized Then
			
			
			If Not EEprom Is Nothing Then
				nRecords = EEprom.getNrecords
				If nRecords > 0 Then
					ReDim linesPerTB(nRecords - 1)
					EEprom.getTBlines(linesPerTB)
				End If
			End If
			
			If nRecords = 0 Then ' if there is no data lock the window size to design default
				Width = VB6.TwipsToPixelsX(widthMin)
				Height = VB6.TwipsToPixelsY(heightMin)
			Else
				If VB6.PixelsToTwipsX(Width) < widthMin Then Width = VB6.TwipsToPixelsX(widthMin)
				For i = 0 To nRecords - 1
					txtEEprom(i).Visible = True
					txtEEprom(i).Width = VB6.TwipsToPixelsX(VB6.PixelsToTwipsX(Width) - widthText)
					txtEEprom(i).Height = VB6.TwipsToPixelsY(linesPerTB(i) * tbTwipPerLineMin + tbTwipOffset)
					If i > 0 Then
						txtEEprom(i).Top = VB6.TwipsToPixelsY(VB6.PixelsToTwipsY(txtEEprom(i - 1).Top) + VB6.PixelsToTwipsY(txtEEprom(i - 1).Height) + tbTwipSpace)
					End If
				Next i
				
				If nRecords > 0 Then
					Height = VB6.TwipsToPixelsY(VB6.PixelsToTwipsY(txtEEprom(nRecords - 1).Top) + VB6.PixelsToTwipsY(txtEEprom(nRecords - 1).Height) + tbTwipSpace + heightMenu)
				Else
					Height = VB6.TwipsToPixelsY(heightMin)
				End If
				
			End If
			
		End If
		
	End Sub
	
	Private Sub frmEEprom_FormClosed(ByVal eventSender As System.Object, ByVal eventArgs As System.Windows.Forms.FormClosedEventArgs) Handles Me.FormClosed
		'UPGRADE_NOTE: Object EEprom may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6E35BFF6-CD74-4B09-9689-3E1A43DF8969"'
		EEprom = Nothing
	End Sub
	
	'UPGRADE_WARNING: Event tbFile.TextChanged may fire when form is initialized. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="88B12AE1-6DE0-48A0-86F1-60C0686C026A"'
	Private Sub tbFile_TextChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles tbFile.TextChanged
		If enterText((tbFile.Text)) Then
			tbFile.Text = VB.Left(tbFile.Text, Len(tbFile.Text) - 1)
			fileName = tbFile.Text
		End If
	End Sub
End Class