Option Strict Off
Option Explicit On
<System.Runtime.InteropServices.ProgId("ucThorlabsAPT_NET.ucThorlabsAPT")> Public Class ucThorlabsAPT
	Inherits System.Windows.Forms.UserControl
	
	Enum loopParams
		eStart
		eStop
		eStep
		eOffset
		ePosition
	End Enum
	
	Dim me_height, me_width As Short
	Dim ltsEnabled As Boolean
	Dim HWSerialNum As Integer
	
	Dim gLoopCount, gLoopEnd As Short
	
	Const ltsHWSerialNum As Integer = 45839763 '45821356
	Const rotHWSerialNum As Integer = 83820662
	Const cr1z7HWSerialNum As Integer = 83820779
	Const mts50z8HWSerialNum As Integer = 83833260
	
	Const cFastOvershoot As Single = 1.2
	
	Const debugFlag As Boolean = False
	
	Dim linearStage As Boolean
	Dim fastSweepEnabled As Boolean
	
	Dim gSweepStartTick As Integer
	
	Dim gMaxSpeed, gSpeed, gAccn, gMinSpeed, gMaxAccn As Single
	Dim gSpeedRatio As Single
	
	Dim ucThorlabsAPT1_Height, ucThorlabsAPT1_Width As Short
	
	Public pMG17Motor As AxMG17MotorLib.AxMG17Motor
	
	Sub SetAbsMovePos(ByVal pos As Single)
		Dim debugPrint As Object
		
		If MG17Enabled Then
			
			pos = npos(pos + CDbl(tbMG17LoopParams(loopParams.eOffset).Text))
			
			Call MG17Motor1.SetAbsMovePos(MG17MotorLib.HWCHANNEL.CHAN1_ID, pos)
			
			If cbBlocking.CheckState = System.Windows.Forms.CheckState.Checked Then
				Call MG17Motor1.MoveAbsolute(MG17MotorLib.HWCHANNEL.CHAN1_ID, True) 'JWG True is blocking call
			Else
				Call MG17Motor1.MoveAbsolute(MG17MotorLib.HWCHANNEL.CHAN1_ID, False) 'JWG True is blocking call
			End If
			
            'If debugFlag Then debugPrint(pos)
			
		End If
		
	End Sub
	
	Private Sub wait4done(ByRef fpos As Single)
		Dim pos(0) As Single
		Dim lpos As Single : lpos = -400
		Dim count As Short : count = 3000
		Call moveTo(fpos, False)
		pos(0) = getValue(pos)
		
		While ((System.Math.Abs(fpos - pos(0)) > 1) And count > 0)
			count = count - 1
			Sleep((20)) : System.Windows.Forms.Application.DoEvents()
			pos(0) = getValue(pos)
			
			If lpos <> -400 Then
				If pos(0) = lpos Then ' motor has stopped, resend move
					Call moveTo(fpos, False)
					Sleep((20)) : System.Windows.Forms.Application.DoEvents()
				End If
			End If
			lpos = pos(0)
			Debug.Print("set=" & fpos & " get=" & pos(0))
		End While
		
		fpos = pos(0)
		
	End Sub
	
	Sub moveTo(ByVal pos As Single, Optional ByVal waitTilDone As Boolean = True)
		
		SetAbsMovePos((pos))
		If waitTilDone Then Call wait4done(pos)
		
		tbMG17LoopParams(loopParams.ePosition).Text = VB6.Format(pos, "###.000")
		
	End Sub
	
	Private Sub MG17Motor_Initialize()
		'UPGRADE_NOTE: error was upgraded to error_Renamed. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="A9E4979A-37FA-4718-9994-97DD76ED70A7"'
		Dim error_Renamed As Integer
		
		MG17Motor1.HWSerialNum = CInt(tbSerNum.Text)
		HWSerialNum = MG17Motor1.HWSerialNum
		error_Renamed = MG17Motor1.StartCtrl
		error_Renamed = MG17Motor1.EnableHWChannel(MG17MotorLib.HWCHANNEL.CHAN1_ID)
		
		If error_Renamed Then
			MG17Enabled = False
		Else
			MG17Enabled = True
			frmSerNum.Enabled = False
			linearStage = (HWSerialNum = ltsHWSerialNum)
			tmrGetPos.Enabled = True
			
			Call MG17Motor1.GetVelParams(MG17MotorLib.HWCHANNEL.CHAN1_ID, gMinSpeed, gMaxAccn, gMaxSpeed)
			
			Select Case HWSerialNum
				Case ltsHWSerialNum : gMaxSpeed = 15 : gMaxAccn = 5 : setStart(0) : setStop(160) : setStep(2)
				Case cr1z7HWSerialNum : gMaxSpeed = 6 : gMaxAccn = 5 : setStart(-90) : setStop(90) : setStep(1)
				Case Else : gMaxSpeed = 5 : gMaxAccn = 5 : setStart(0) : setStop(30) : setStep(6)
			End Select
			
			Call MG17Motor1.SetVelParams(MG17MotorLib.HWCHANNEL.CHAN1_ID, gMinSpeed, gMaxAccn, gMaxSpeed)
			gSpeed = gMaxSpeed : gAccn = gMaxAccn
			
		End If
	End Sub
	
	Private Function npos(ByVal pos As Single) As Single
		Dim i As Short
		
		If linearStage Then
			npos = 300 - pos
		Else
			i = pos / 180 - 0.5
			npos = pos - i * 180
			If i And 1 Then npos = npos - 180
		End If
		
	End Function
	
	'UPGRADE_WARNING: Event cbBlocking.CheckStateChanged may fire when form is initialized. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="88B12AE1-6DE0-48A0-86F1-60C0686C026A"'
	Private Sub cbBlocking_CheckStateChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cbBlocking.CheckStateChanged
		If cbBlocking.CheckState = System.Windows.Forms.CheckState.Checked Then
			cbBlocking.Text = "Position: Blocking"
		Else
			cbBlocking.Text = "Position: Non-Blocking"
		End If
	End Sub
	
	'UPGRADE_WARNING: Event cbSweepType.CheckStateChanged may fire when form is initialized. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="88B12AE1-6DE0-48A0-86F1-60C0686C026A"'
	Private Sub cbSweepType_CheckStateChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cbSweepType.CheckStateChanged
		If cbSweepType.CheckState = System.Windows.Forms.CheckState.Checked Then
			setFastSweepEnabled(True)
		Else
			setFastSweepEnabled(False)
		End If
	End Sub
	
	Public Sub setFastSweepEnabled(ByRef enabled As Boolean)
		If enabled Then
			cbSweepType.CheckState = System.Windows.Forms.CheckState.Checked
			cbSweepType.Text = "Fast"
			cmdCalSweep.Visible = True
		Else
			cbSweepType.CheckState = System.Windows.Forms.CheckState.Unchecked
			cbSweepType.Text = "Stepped"
			cmdCalSweep.Visible = False
		End If
		fastSweepEnabled = enabled
	End Sub
	
	Public Function getFastSweepEnabled() As Boolean
		getFastSweepEnabled = fastSweepEnabled
	End Function
	
	
	Public Sub setMotorSweepSpeed(Optional ByRef Ratio As Single = 1)
		
		Dim fMinVel, speed, fAccn As Single
		
		If Ratio > 1 Then
			Ratio = 1
		Else
			If Ratio < 0.05 Then
				Ratio = 0.05
			End If
		End If
		
		
		gSpeed = Ratio * gMaxSpeed
		If gSpeed > gMaxSpeed Then gSpeed = gMaxSpeed
		
		Call MG17Motor1.SetVelParams(MG17MotorLib.HWCHANNEL.CHAN1_ID, gMinSpeed, gAccn, gSpeed)
		System.Windows.Forms.Application.DoEvents()
		
	End Sub
	
	Private Sub cmbSamplePeriod_Change()
		
	End Sub
	
	Private Sub cmdSweep_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdSweep.Click
		fmSweep.BackColor = System.Drawing.ColorTranslator.FromOle(&H80FF80) 'pale green
		arm()
		If cbSweepType.Text = "Fast" Then
			setMotorSweepSpeed(gSpeedRatio)
		End If
	End Sub
	
	Private Sub tmrGetPos_Tick(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles tmrGetPos.Tick
		Dim value(0) As Single
		getValue(value)
	End Sub
	
	Private Sub UserControl_Initialize()
		'Dim i As Integer
		ucThorlabsAPT1_Height = VB6.PixelsToTwipsY(MyBase.Height) - VB6.PixelsToTwipsY(MG17Motor1.Height)
		ucThorlabsAPT1_Width = VB6.PixelsToTwipsX(MyBase.Width) - VB6.PixelsToTwipsX(MG17Motor1.Width)
		pMG17Motor = MG17Motor1
		tbSerNum.Text = cmbSerNum.Text
		HWSerialNum = CInt(tbSerNum.Text)
		gSpeedRatio = 1
	End Sub
	
	Private Sub ucThorlabsAPT_Resize(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Resize
		If (VB6.PixelsToTwipsY(MyBase.Height) - ucThorlabsAPT1_Height) > 0 Then MG17Motor1.Height = VB6.TwipsToPixelsY(VB6.PixelsToTwipsY(MyBase.Height) - ucThorlabsAPT1_Height)
		If (VB6.PixelsToTwipsX(MyBase.Width) - ucThorlabsAPT1_Width) > 0 Then MG17Motor1.Width = VB6.TwipsToPixelsX(VB6.PixelsToTwipsX(MyBase.Width) - ucThorlabsAPT1_Width)
	End Sub
	
	'UPGRADE_WARNING: Event tbSerNum.TextChanged may fire when form is initialized. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="88B12AE1-6DE0-48A0-86F1-60C0686C026A"'
	Private Sub tbSerNum_TextChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles tbSerNum.TextChanged
		Dim enterText As Object
		Dim serNum As Integer
		On Error GoTo errorExit
		'UPGRADE_WARNING: Couldn't resolve default property of object enterText(tbSerNum.text). Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		If enterText(tbSerNum.Text) Then
			serNum = CInt(tbSerNum.Text)
			tbSerNum.Text = CStr(serNum)
			MG17Motor_Initialize()
		End If
		GoTo sucessExit
errorExit: 
		tbSerNum.Text = CStr(HWSerialNum)
sucessExit: 
	End Sub
	
	'UPGRADE_WARNING: Event cmbSerNum.SelectedIndexChanged may fire when form is initialized. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="88B12AE1-6DE0-48A0-86F1-60C0686C026A"'
	Private Sub cmbSerNum_SelectedIndexChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmbSerNum.SelectedIndexChanged
		tbSerNum.Text = cmbSerNum.Text & Chr(13)
	End Sub
	
	Private Sub cmdZeroHome_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdZeroHome.Click
		moveTo(CSng(-tbMG17LoopParams(loopParams.eOffset).Text))
		Sleep((1000))
		Call MG17Motor1.MoveHome(MG17MotorLib.HWCHANNEL.CHAN1_ID, True)
	End Sub
	
	Private Sub cmdStoreZero_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdStoreZero.Click
		Dim Position As Single
		Call MG17Motor1.getPosition(MG17MotorLib.HWCHANNEL.CHAN1_ID, Position)
		tbMG17LoopParams(loopParams.eOffset).Text = VB6.Format(npos(Position), "###.000")
	End Sub
	
	
	
	
	
	
	
	
	
	
	
	'UPGRADE_WARNING: Event tbMG17LoopParams.TextChanged may fire when form is initialized. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="88B12AE1-6DE0-48A0-86F1-60C0686C026A"'
	Private Sub tbMG17LoopParams_TextChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles tbMG17LoopParams.TextChanged
		Dim Index As Short = tbMG17LoopParams.GetIndex(eventSender)
		Dim enterText As Object
		Dim test As Double
		On Error GoTo errorExit
		'UPGRADE_WARNING: Couldn't resolve default property of object enterText(tbMG17LoopParams(Index).text). Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		If enterText(tbMG17LoopParams(Index).Text) Then
			test = CDbl(tbMG17LoopParams(Index).Text)
			tbMG17LoopParams(Index).Text = CStr(test)
		End If
		GoTo sucessExit
errorExit: 
		tbSerNum.Text = CStr(HWSerialNum)
sucessExit: 
	End Sub
	
	'Private Function enterText(ByRef text As String) As Integer
	'    ' strip [cr] & [lf], return > 0
	'    enterText = InStr(text, Chr(13))
	'    If (enterText) Then
	'        text = Mid(text, 1, enterText - 1)
	'    End If
	'End Function
	
	
	
	
	
	
	Private Function getLoopParam(ByRef param As Short) As Single
		getLoopParam = CSng(tbMG17LoopParams(param).Text)
	End Function
	'UPGRADE_NOTE: val was upgraded to val_Renamed. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="A9E4979A-37FA-4718-9994-97DD76ED70A7"'
	Private Sub setLoopParam(ByRef param As Short, ByRef val_Renamed As Single)
		tbMG17LoopParams(param).Text = val_Renamed & Chr(13)
	End Sub
	
	Public Function getStart() As Single
		getStart = getLoopParam(loopParams.eStart)
	End Function
	'UPGRADE_NOTE: val was upgraded to val_Renamed. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="A9E4979A-37FA-4718-9994-97DD76ED70A7"'
	Public Sub setStart(ByRef val_Renamed As Single)
		Call setLoopParam(loopParams.eStart, val_Renamed)
	End Sub
	
	Public Function getStop() As Single
		getStop = getLoopParam(loopParams.eStop)
	End Function
	'UPGRADE_NOTE: val was upgraded to val_Renamed. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="A9E4979A-37FA-4718-9994-97DD76ED70A7"'
	Public Sub setStop(ByRef val_Renamed As Single)
		Call setLoopParam(loopParams.eStop, val_Renamed)
	End Sub
	
	Public Function getStep() As Single
		getStep = getLoopParam(loopParams.eStep)
	End Function
	'UPGRADE_NOTE: val was upgraded to val_Renamed. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="A9E4979A-37FA-4718-9994-97DD76ED70A7"'
	Public Sub setStep(ByRef val_Renamed As Single)
		Call setLoopParam(loopParams.eStep, val_Renamed)
	End Sub
	
	Public Function getOffset() As Single
		getOffset = getLoopParam(loopParams.eOffset)
	End Function
	'UPGRADE_NOTE: val was upgraded to val_Renamed. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="A9E4979A-37FA-4718-9994-97DD76ED70A7"'
	Public Sub setOffset(ByRef val_Renamed As Single)
		Call setLoopParam(loopParams.eOffset, val_Renamed)
	End Sub
	
	
	
	
	Public Function getHWSerialNum() As Integer
		getHWSerialNum = HWSerialNum
	End Function
	Public Sub setHWSerialNum(ByRef serNum As Integer)
		tbSerNum.Text = serNum & Chr(13)
	End Sub
	
	
	
	
	Public Function getValue(ByRef value() As Single) As Single
		
		If MG17Enabled Then
			Call MG17Motor1.getPosition(MG17MotorLib.HWCHANNEL.CHAN1_ID, getValue)
			getValue = npos(getValue - Val(tbMG17LoopParams(loopParams.eOffset).Text))
			tbMG17LoopParams(loopParams.ePosition).Text = VB6.Format(getValue, "###.000")
		End If
		
		value(0) = getValue
		
	End Function
	
	Public Sub setPosition(ByRef pos As Single)
		Call moveTo(pos)
	End Sub
	
	Public Sub arm()
		gLoopCount = 0
		gLoopEnd = (CDbl(tbMG17LoopParams(loopParams.eStop).Text) - CDbl(tbMG17LoopParams(loopParams.eStart).Text)) / CDbl(tbMG17LoopParams(loopParams.eStep).Text) + 1
		next_()
	End Sub
	
	Public Sub next_()
		If gLoopCount Then
			If fastSweepEnabled Then
				If gLoopCount = 1 Then
					tmrGetPos.Enabled = False
					Call moveTo(CSng(tbMG17LoopParams(loopParams.eStop).Text), False)
				End If
			Else
				If done = False Then
					moveTo((CDbl(tbMG17LoopParams(loopParams.eStart).Text) + gLoopCount * CDbl(tbMG17LoopParams(loopParams.eStep).Text)))
				End If
			End If
		Else ' arm
			setMotorSweepSpeed(1)
			Call moveTo(CSng(tbMG17LoopParams(loopParams.eStart).Text))
			setMotorSweepSpeed(gSpeedRatio)
		End If
		
		gLoopCount = gLoopCount + 1
		
	End Sub
	
	Public Function done() As Boolean
		Dim value(0) As Single
		If fastSweepEnabled Then
			If (System.Math.Abs(CDbl(tbMG17LoopParams(loopParams.eStop).Text) - getValue(value)) < 0.01) Then
				done = True
				setMotorSweepSpeed(0)
				gSpeedRatio = gSpeedRatio * gLoopCount / cFastOvershoot / gLoopEnd
			Else
				done = False
			End If
		Else
			done = (gLoopCount >= gLoopEnd)
		End If
		
		If done Then
			fmSweep.BackColor = System.Drawing.ColorTranslator.FromOle(&H8080FF) ' pale red
			tmrGetPos.Enabled = True
		End If
		
	End Function
	
	Private Sub cmdCalSweep_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdCalSweep.Click
		tmrCalSweep.Enabled = True
		gSweepStartTick = GetTickCount
		fastSweepEnabled = getFastSweepEnabled
	End Sub
	
	Private Sub tmrCalSweep_Tick(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles tmrCalSweep.Tick
		Dim debugPrint As Object
		Static tmrCounts As Integer
		Static lpos As Single
		Dim pos(0) As Single
		Dim ticks, msPerStep As Single
		Dim loopTime, timerSubTime, newTime As Single
		
		If fastSweepEnabled Then
			If done Then
				
				gSweepStartTick = GetTickCount - gSweepStartTick
				ticks = (getStop - getStart) / getStep + 1
				
				loopTime = gSweepStartTick / tmrCounts
				timerSubTime = loopTime - tmrCalSweep.Interval
				newTime = loopTime * tmrCounts / ticks
				If (newTime - timerSubTime) > 100 Then
					'UPGRADE_WARNING: Timer property tmrCalSweep.Interval cannot have a value of 0. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="169ECF4A-1968-402D-B243-16603CC08604"'
					tmrCalSweep.Interval = newTime - timerSubTime
				Else
					setMotorSweepSpeed((tmrCounts / ticks))
				End If
				
				tmrCalSweep.Enabled = False
				tmrCounts = 0
			Else
				pos(0) = getValue(pos)
				If tmrCounts = 0 Then
					next_()
				Else
                    'debugPrint(pos(0) - lpos)
				End If
				tmrCounts = tmrCounts + 1
				lpos = pos(0)
			End If
		Else
			tmrCalSweep.Enabled = False
			tmrCounts = 0
		End If
	End Sub
End Class