<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> Partial Class ucALSusb
#Region "Windows Form Designer generated code "
	<System.Diagnostics.DebuggerNonUserCode()> Public Sub New()
		MyBase.New()
		'This call is required by the Windows Form Designer.
		InitializeComponent()
		UserControl_Initialize()
	End Sub
	'Form overrides dispose to clean up the component list.
	<System.Diagnostics.DebuggerNonUserCode()> Protected Overloads Overrides Sub Dispose(ByVal Disposing As Boolean)
		If Disposing Then
			If Not components Is Nothing Then
				components.Dispose()
			End If
		End If
		MyBase.Dispose(Disposing)
	End Sub
	'Required by the Windows Form Designer
	Private components As System.ComponentModel.IContainer
	Public ToolTip1 As System.Windows.Forms.ToolTip
	Friend WithEvents _optAddr_4 As System.Windows.Forms.RadioButton
	Friend WithEvents _optAddr_3 As System.Windows.Forms.RadioButton
	Friend WithEvents _optAddr_2 As System.Windows.Forms.RadioButton
	Friend WithEvents _optAddr_1 As System.Windows.Forms.RadioButton
	Friend WithEvents cmdConversionTime As System.Windows.Forms.Button
	Friend WithEvents cbPoll As System.Windows.Forms.CheckBox
	Friend WithEvents optInt As System.Windows.Forms.RadioButton
	Friend WithEvents cmbDevice As System.Windows.Forms.ComboBox
	Friend WithEvents _cbEnable_0 As System.Windows.Forms.CheckBox
	Friend WithEvents _cmbIntPersist_0 As System.Windows.Forms.ComboBox
	Friend WithEvents cmbRange As System.Windows.Forms.ComboBox
	Friend WithEvents cmbInputSelect As System.Windows.Forms.ComboBox
	Friend WithEvents cmbIrdr As System.Windows.Forms.ComboBox
	Friend WithEvents _lblEnable_0 As System.Windows.Forms.Label
	Friend WithEvents _lblIntPersist_0 As System.Windows.Forms.Label
	Friend WithEvents lblRange As System.Windows.Forms.Label
	Friend WithEvents lblInputSelect As System.Windows.Forms.Label
	Friend WithEvents lblIrdr As System.Windows.Forms.Label
	Friend WithEvents fmBoth As System.Windows.Forms.GroupBox
	Friend WithEvents tmrPoll As System.Windows.Forms.Timer
	Friend WithEvents cmbResolution As System.Windows.Forms.ComboBox
	Friend WithEvents cbProxAmbRej As System.Windows.Forms.CheckBox
	Friend WithEvents cbIrdrFreq As System.Windows.Forms.CheckBox
	Friend WithEvents lblResolution As System.Windows.Forms.Label
	Friend WithEvents frmX11 As System.Windows.Forms.GroupBox
	Friend WithEvents cmbSleep As System.Windows.Forms.ComboBox
	Friend WithEvents cbIntLogic As System.Windows.Forms.CheckBox
	Friend WithEvents _cmbIntPersist_1 As System.Windows.Forms.ComboBox
	Friend WithEvents _cbEnable_1 As System.Windows.Forms.CheckBox
	Friend WithEvents lblSleep As System.Windows.Forms.Label
	Friend WithEvents _lblIntPersist_1 As System.Windows.Forms.Label
	Friend WithEvents _lblEnable_1 As System.Windows.Forms.Label
	Friend WithEvents frmX28 As System.Windows.Forms.GroupBox
	Friend WithEvents hscrProxOffset As System.Windows.Forms.HScrollBar
	Friend WithEvents lblProxOffset As System.Windows.Forms.Label
	Friend WithEvents fmProxOffset As System.Windows.Forms.GroupBox
	Friend WithEvents hscrIRcomp As System.Windows.Forms.HScrollBar
	Friend WithEvents lblIRcomp As System.Windows.Forms.Label
	Friend WithEvents fmIRcomp As System.Windows.Forms.GroupBox
	Friend WithEvents frmX38 As System.Windows.Forms.GroupBox
	Friend WithEvents frmDevice As System.Windows.Forms.GroupBox
	Friend WithEvents _optAddr_0 As System.Windows.Forms.RadioButton
	Friend WithEvents cbEnable As Microsoft.VisualBasic.Compatibility.VB6.CheckBoxArray
	Friend WithEvents cmbIntPersist As Microsoft.VisualBasic.Compatibility.VB6.ComboBoxArray
	Friend WithEvents lblEnable As Microsoft.VisualBasic.Compatibility.VB6.LabelArray
	Friend WithEvents lblIntPersist As Microsoft.VisualBasic.Compatibility.VB6.LabelArray
	Friend WithEvents optAddr As Microsoft.VisualBasic.Compatibility.VB6.RadioButtonArray
	'NOTE: The following procedure is required by the Windows Form Designer
	'It can be modified using the Windows Form Designer.
	'Do not modify it using the code editor.
	<System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
		Dim resources As System.Resources.ResourceManager = New System.Resources.ResourceManager(GetType(ucALSusb))
		Me.components = New System.ComponentModel.Container()
		Me.ToolTip1 = New System.Windows.Forms.ToolTip(components)
		Me._optAddr_4 = New System.Windows.Forms.RadioButton
		Me._optAddr_3 = New System.Windows.Forms.RadioButton
		Me._optAddr_2 = New System.Windows.Forms.RadioButton
		Me._optAddr_1 = New System.Windows.Forms.RadioButton
		Me.frmDevice = New System.Windows.Forms.GroupBox
		Me.cmdConversionTime = New System.Windows.Forms.Button
		Me.fmBoth = New System.Windows.Forms.GroupBox
		Me.cbPoll = New System.Windows.Forms.CheckBox
		Me.optInt = New System.Windows.Forms.RadioButton
		Me.cmbDevice = New System.Windows.Forms.ComboBox
		Me._cbEnable_0 = New System.Windows.Forms.CheckBox
		Me._cmbIntPersist_0 = New System.Windows.Forms.ComboBox
		Me.cmbRange = New System.Windows.Forms.ComboBox
		Me.cmbInputSelect = New System.Windows.Forms.ComboBox
		Me.cmbIrdr = New System.Windows.Forms.ComboBox
		Me._lblEnable_0 = New System.Windows.Forms.Label
		Me._lblIntPersist_0 = New System.Windows.Forms.Label
		Me.lblRange = New System.Windows.Forms.Label
		Me.lblInputSelect = New System.Windows.Forms.Label
		Me.lblIrdr = New System.Windows.Forms.Label
		Me.frmX11 = New System.Windows.Forms.GroupBox
		Me.tmrPoll = New System.Windows.Forms.Timer(components)
		Me.cmbResolution = New System.Windows.Forms.ComboBox
		Me.cbProxAmbRej = New System.Windows.Forms.CheckBox
		Me.cbIrdrFreq = New System.Windows.Forms.CheckBox
		Me.lblResolution = New System.Windows.Forms.Label
		Me.frmX28 = New System.Windows.Forms.GroupBox
		Me.cmbSleep = New System.Windows.Forms.ComboBox
		Me.cbIntLogic = New System.Windows.Forms.CheckBox
		Me._cmbIntPersist_1 = New System.Windows.Forms.ComboBox
		Me._cbEnable_1 = New System.Windows.Forms.CheckBox
		Me.lblSleep = New System.Windows.Forms.Label
		Me._lblIntPersist_1 = New System.Windows.Forms.Label
		Me._lblEnable_1 = New System.Windows.Forms.Label
		Me.frmX38 = New System.Windows.Forms.GroupBox
		Me.fmProxOffset = New System.Windows.Forms.GroupBox
		Me.hscrProxOffset = New System.Windows.Forms.HScrollBar
		Me.lblProxOffset = New System.Windows.Forms.Label
		Me.fmIRcomp = New System.Windows.Forms.GroupBox
		Me.hscrIRcomp = New System.Windows.Forms.HScrollBar
		Me.lblIRcomp = New System.Windows.Forms.Label
		Me._optAddr_0 = New System.Windows.Forms.RadioButton
		Me.cbEnable = New Microsoft.VisualBasic.Compatibility.VB6.CheckBoxArray(components)
		Me.cmbIntPersist = New Microsoft.VisualBasic.Compatibility.VB6.ComboBoxArray(components)
		Me.lblEnable = New Microsoft.VisualBasic.Compatibility.VB6.LabelArray(components)
		Me.lblIntPersist = New Microsoft.VisualBasic.Compatibility.VB6.LabelArray(components)
		Me.optAddr = New Microsoft.VisualBasic.Compatibility.VB6.RadioButtonArray(components)
		Me.frmDevice.SuspendLayout()
		Me.fmBoth.SuspendLayout()
		Me.frmX11.SuspendLayout()
		Me.frmX28.SuspendLayout()
		Me.frmX38.SuspendLayout()
		Me.fmProxOffset.SuspendLayout()
		Me.fmIRcomp.SuspendLayout()
		Me.SuspendLayout()
		Me.ToolTip1.Active = True
		CType(Me.cbEnable, System.ComponentModel.ISupportInitialize).BeginInit()
		CType(Me.cmbIntPersist, System.ComponentModel.ISupportInitialize).BeginInit()
		CType(Me.lblEnable, System.ComponentModel.ISupportInitialize).BeginInit()
		CType(Me.lblIntPersist, System.ComponentModel.ISupportInitialize).BeginInit()
		CType(Me.optAddr, System.ComponentModel.ISupportInitialize).BeginInit()
		Me.ClientSize = New System.Drawing.Size(291, 430)
		MyBase.Location = New System.Drawing.Point(0, 0)
		MyBase.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		MyBase.Name = "ucALSusb"
		Me._optAddr_4.TextAlign = System.Drawing.ContentAlignment.MiddleLeft
		Me._optAddr_4.Text = "72"
		Me._optAddr_4.Enabled = False
		Me._optAddr_4.Size = New System.Drawing.Size(49, 17)
		Me._optAddr_4.Location = New System.Drawing.Point(96, 0)
		Me._optAddr_4.TabIndex = 40
		Me._optAddr_4.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me._optAddr_4.CheckAlign = System.Drawing.ContentAlignment.MiddleLeft
		Me._optAddr_4.BackColor = System.Drawing.SystemColors.Control
		Me._optAddr_4.CausesValidation = True
		Me._optAddr_4.ForeColor = System.Drawing.SystemColors.ControlText
		Me._optAddr_4.Cursor = System.Windows.Forms.Cursors.Default
		Me._optAddr_4.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me._optAddr_4.Appearance = System.Windows.Forms.Appearance.Normal
		Me._optAddr_4.TabStop = True
		Me._optAddr_4.Checked = False
		Me._optAddr_4.Visible = True
		Me._optAddr_4.Name = "_optAddr_4"
		Me._optAddr_3.TextAlign = System.Drawing.ContentAlignment.MiddleLeft
		Me._optAddr_3.Text = "8C"
		Me._optAddr_3.Enabled = False
		Me._optAddr_3.Size = New System.Drawing.Size(49, 17)
		Me._optAddr_3.Location = New System.Drawing.Point(64, 0)
		Me._optAddr_3.TabIndex = 39
		Me._optAddr_3.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me._optAddr_3.CheckAlign = System.Drawing.ContentAlignment.MiddleLeft
		Me._optAddr_3.BackColor = System.Drawing.SystemColors.Control
		Me._optAddr_3.CausesValidation = True
		Me._optAddr_3.ForeColor = System.Drawing.SystemColors.ControlText
		Me._optAddr_3.Cursor = System.Windows.Forms.Cursors.Default
		Me._optAddr_3.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me._optAddr_3.Appearance = System.Windows.Forms.Appearance.Normal
		Me._optAddr_3.TabStop = True
		Me._optAddr_3.Checked = False
		Me._optAddr_3.Visible = True
		Me._optAddr_3.Name = "_optAddr_3"
		Me._optAddr_2.TextAlign = System.Drawing.ContentAlignment.MiddleLeft
		Me._optAddr_2.Text = "8A"
		Me._optAddr_2.Enabled = False
		Me._optAddr_2.Size = New System.Drawing.Size(49, 17)
		Me._optAddr_2.Location = New System.Drawing.Point(32, 0)
		Me._optAddr_2.TabIndex = 28
		Me._optAddr_2.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me._optAddr_2.CheckAlign = System.Drawing.ContentAlignment.MiddleLeft
		Me._optAddr_2.BackColor = System.Drawing.SystemColors.Control
		Me._optAddr_2.CausesValidation = True
		Me._optAddr_2.ForeColor = System.Drawing.SystemColors.ControlText
		Me._optAddr_2.Cursor = System.Windows.Forms.Cursors.Default
		Me._optAddr_2.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me._optAddr_2.Appearance = System.Windows.Forms.Appearance.Normal
		Me._optAddr_2.TabStop = True
		Me._optAddr_2.Checked = False
		Me._optAddr_2.Visible = True
		Me._optAddr_2.Name = "_optAddr_2"
		Me._optAddr_1.TextAlign = System.Drawing.ContentAlignment.MiddleLeft
		Me._optAddr_1.Text = "88"
		Me._optAddr_1.Enabled = False
		Me._optAddr_1.Size = New System.Drawing.Size(49, 17)
		Me._optAddr_1.Location = New System.Drawing.Point(0, 0)
		Me._optAddr_1.TabIndex = 29
		Me._optAddr_1.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me._optAddr_1.CheckAlign = System.Drawing.ContentAlignment.MiddleLeft
		Me._optAddr_1.BackColor = System.Drawing.SystemColors.Control
		Me._optAddr_1.CausesValidation = True
		Me._optAddr_1.ForeColor = System.Drawing.SystemColors.ControlText
		Me._optAddr_1.Cursor = System.Windows.Forms.Cursors.Default
		Me._optAddr_1.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me._optAddr_1.Appearance = System.Windows.Forms.Appearance.Normal
		Me._optAddr_1.TabStop = True
		Me._optAddr_1.Checked = False
		Me._optAddr_1.Visible = True
		Me._optAddr_1.Name = "_optAddr_1"
		Me.frmDevice.Text = "Device"
		Me.frmDevice.Size = New System.Drawing.Size(281, 465)
		Me.frmDevice.Location = New System.Drawing.Point(0, 16)
		Me.frmDevice.TabIndex = 0
		Me.frmDevice.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.frmDevice.BackColor = System.Drawing.SystemColors.Control
		Me.frmDevice.Enabled = True
		Me.frmDevice.ForeColor = System.Drawing.SystemColors.ControlText
		Me.frmDevice.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.frmDevice.Visible = True
		Me.frmDevice.Padding = New System.Windows.Forms.Padding(0)
		Me.frmDevice.Name = "frmDevice"
		Me.cmdConversionTime.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
		Me.cmdConversionTime.Text = "Conv. = 0 ms"
		Me.cmdConversionTime.Size = New System.Drawing.Size(105, 21)
		Me.cmdConversionTime.Location = New System.Drawing.Point(8, 8)
		Me.cmdConversionTime.TabIndex = 38
		Me.cmdConversionTime.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.cmdConversionTime.BackColor = System.Drawing.SystemColors.Control
		Me.cmdConversionTime.CausesValidation = True
		Me.cmdConversionTime.Enabled = True
		Me.cmdConversionTime.ForeColor = System.Drawing.SystemColors.ControlText
		Me.cmdConversionTime.Cursor = System.Windows.Forms.Cursors.Default
		Me.cmdConversionTime.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.cmdConversionTime.TabStop = True
		Me.cmdConversionTime.Name = "cmdConversionTime"
		Me.fmBoth.Text = "Both"
		Me.fmBoth.Size = New System.Drawing.Size(105, 169)
		Me.fmBoth.Location = New System.Drawing.Point(8, 24)
		Me.fmBoth.TabIndex = 14
		Me.fmBoth.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.fmBoth.BackColor = System.Drawing.SystemColors.Control
		Me.fmBoth.Enabled = True
		Me.fmBoth.ForeColor = System.Drawing.SystemColors.ControlText
		Me.fmBoth.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.fmBoth.Visible = True
		Me.fmBoth.Padding = New System.Windows.Forms.Padding(0)
		Me.fmBoth.Name = "fmBoth"
		Me.cbPoll.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
		Me.cbPoll.Text = "nPoll"
		Me.cbPoll.Size = New System.Drawing.Size(57, 17)
		Me.cbPoll.Location = New System.Drawing.Point(48, 8)
		Me.cbPoll.Appearance = System.Windows.Forms.Appearance.Button
		Me.cbPoll.TabIndex = 27
		Me.cbPoll.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.cbPoll.CheckAlign = System.Drawing.ContentAlignment.MiddleLeft
		Me.cbPoll.FlatStyle = System.Windows.Forms.FlatStyle.Standard
		Me.cbPoll.BackColor = System.Drawing.SystemColors.Control
		Me.cbPoll.CausesValidation = True
		Me.cbPoll.Enabled = True
		Me.cbPoll.ForeColor = System.Drawing.SystemColors.ControlText
		Me.cbPoll.Cursor = System.Windows.Forms.Cursors.Default
		Me.cbPoll.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.cbPoll.TabStop = True
		Me.cbPoll.CheckState = System.Windows.Forms.CheckState.Unchecked
		Me.cbPoll.Visible = True
		Me.cbPoll.Name = "cbPoll"
		Me.optInt.TextAlign = System.Drawing.ContentAlignment.MiddleLeft
		Me.optInt.Text = "Int"
		Me.optInt.Size = New System.Drawing.Size(33, 17)
		Me.optInt.Location = New System.Drawing.Point(0, 8)
		Me.optInt.TabIndex = 26
		Me.optInt.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.optInt.CheckAlign = System.Drawing.ContentAlignment.MiddleLeft
		Me.optInt.BackColor = System.Drawing.SystemColors.Control
		Me.optInt.CausesValidation = True
		Me.optInt.Enabled = True
		Me.optInt.ForeColor = System.Drawing.SystemColors.ControlText
		Me.optInt.Cursor = System.Windows.Forms.Cursors.Default
		Me.optInt.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.optInt.Appearance = System.Windows.Forms.Appearance.Normal
		Me.optInt.TabStop = True
		Me.optInt.Checked = False
		Me.optInt.Visible = True
		Me.optInt.Name = "optInt"
		Me.cmbDevice.Size = New System.Drawing.Size(105, 21)
		Me.cmbDevice.Location = New System.Drawing.Point(0, 24)
		Me.cmbDevice.TabIndex = 20
		Me.cmbDevice.Text = "Device"
		Me.cmbDevice.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.cmbDevice.BackColor = System.Drawing.SystemColors.Window
		Me.cmbDevice.CausesValidation = True
		Me.cmbDevice.Enabled = True
		Me.cmbDevice.ForeColor = System.Drawing.SystemColors.WindowText
		Me.cmbDevice.IntegralHeight = True
		Me.cmbDevice.Cursor = System.Windows.Forms.Cursors.Default
		Me.cmbDevice.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.cmbDevice.Sorted = False
		Me.cmbDevice.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDown
		Me.cmbDevice.TabStop = True
		Me.cmbDevice.Visible = True
		Me.cmbDevice.Name = "cmbDevice"
		Me._cbEnable_0.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
		Me._cbEnable_0.Text = "Enabled"
		Me._cbEnable_0.Size = New System.Drawing.Size(65, 17)
		Me._cbEnable_0.Location = New System.Drawing.Point(40, 48)
		Me._cbEnable_0.Appearance = System.Windows.Forms.Appearance.Button
		Me._cbEnable_0.TabIndex = 19
		Me._cbEnable_0.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me._cbEnable_0.CheckAlign = System.Drawing.ContentAlignment.MiddleLeft
		Me._cbEnable_0.FlatStyle = System.Windows.Forms.FlatStyle.Standard
		Me._cbEnable_0.BackColor = System.Drawing.SystemColors.Control
		Me._cbEnable_0.CausesValidation = True
		Me._cbEnable_0.Enabled = True
		Me._cbEnable_0.ForeColor = System.Drawing.SystemColors.ControlText
		Me._cbEnable_0.Cursor = System.Windows.Forms.Cursors.Default
		Me._cbEnable_0.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me._cbEnable_0.TabStop = True
		Me._cbEnable_0.CheckState = System.Windows.Forms.CheckState.Unchecked
		Me._cbEnable_0.Visible = True
		Me._cbEnable_0.Name = "_cbEnable_0"
		Me._cmbIntPersist_0.Size = New System.Drawing.Size(49, 21)
		Me._cmbIntPersist_0.Location = New System.Drawing.Point(56, 72)
		Me._cmbIntPersist_0.TabIndex = 18
		Me._cmbIntPersist_0.Text = "IntPersist"
		Me._cmbIntPersist_0.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me._cmbIntPersist_0.BackColor = System.Drawing.SystemColors.Window
		Me._cmbIntPersist_0.CausesValidation = True
		Me._cmbIntPersist_0.Enabled = True
		Me._cmbIntPersist_0.ForeColor = System.Drawing.SystemColors.WindowText
		Me._cmbIntPersist_0.IntegralHeight = True
		Me._cmbIntPersist_0.Cursor = System.Windows.Forms.Cursors.Default
		Me._cmbIntPersist_0.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me._cmbIntPersist_0.Sorted = False
		Me._cmbIntPersist_0.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDown
		Me._cmbIntPersist_0.TabStop = True
		Me._cmbIntPersist_0.Visible = True
		Me._cmbIntPersist_0.Name = "_cmbIntPersist_0"
		Me.cmbRange.Size = New System.Drawing.Size(65, 21)
		Me.cmbRange.Location = New System.Drawing.Point(40, 96)
		Me.cmbRange.TabIndex = 17
		Me.cmbRange.Text = "Range"
		Me.cmbRange.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.cmbRange.BackColor = System.Drawing.SystemColors.Window
		Me.cmbRange.CausesValidation = True
		Me.cmbRange.Enabled = True
		Me.cmbRange.ForeColor = System.Drawing.SystemColors.WindowText
		Me.cmbRange.IntegralHeight = True
		Me.cmbRange.Cursor = System.Windows.Forms.Cursors.Default
		Me.cmbRange.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.cmbRange.Sorted = False
		Me.cmbRange.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDown
		Me.cmbRange.TabStop = True
		Me.cmbRange.Visible = True
		Me.cmbRange.Name = "cmbRange"
		Me.cmbInputSelect.Size = New System.Drawing.Size(73, 21)
		Me.cmbInputSelect.Location = New System.Drawing.Point(32, 120)
		Me.cmbInputSelect.TabIndex = 16
		Me.cmbInputSelect.Text = "InputSelect"
		Me.cmbInputSelect.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.cmbInputSelect.BackColor = System.Drawing.SystemColors.Window
		Me.cmbInputSelect.CausesValidation = True
		Me.cmbInputSelect.Enabled = True
		Me.cmbInputSelect.ForeColor = System.Drawing.SystemColors.WindowText
		Me.cmbInputSelect.IntegralHeight = True
		Me.cmbInputSelect.Cursor = System.Windows.Forms.Cursors.Default
		Me.cmbInputSelect.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.cmbInputSelect.Sorted = False
		Me.cmbInputSelect.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDown
		Me.cmbInputSelect.TabStop = True
		Me.cmbInputSelect.Visible = True
		Me.cmbInputSelect.Name = "cmbInputSelect"
		Me.cmbIrdr.Size = New System.Drawing.Size(81, 21)
		Me.cmbIrdr.Location = New System.Drawing.Point(24, 144)
		Me.cmbIrdr.TabIndex = 15
		Me.cmbIrdr.Text = "Irdr"
		Me.cmbIrdr.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.cmbIrdr.BackColor = System.Drawing.SystemColors.Window
		Me.cmbIrdr.CausesValidation = True
		Me.cmbIrdr.Enabled = True
		Me.cmbIrdr.ForeColor = System.Drawing.SystemColors.WindowText
		Me.cmbIrdr.IntegralHeight = True
		Me.cmbIrdr.Cursor = System.Windows.Forms.Cursors.Default
		Me.cmbIrdr.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.cmbIrdr.Sorted = False
		Me.cmbIrdr.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDown
		Me.cmbIrdr.TabStop = True
		Me.cmbIrdr.Visible = True
		Me.cmbIrdr.Name = "cmbIrdr"
		Me._lblEnable_0.Text = "Chan0:"
		Me._lblEnable_0.Size = New System.Drawing.Size(65, 17)
		Me._lblEnable_0.Location = New System.Drawing.Point(0, 48)
		Me._lblEnable_0.TabIndex = 25
		Me._lblEnable_0.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me._lblEnable_0.TextAlign = System.Drawing.ContentAlignment.TopLeft
		Me._lblEnable_0.BackColor = System.Drawing.SystemColors.Control
		Me._lblEnable_0.Enabled = True
		Me._lblEnable_0.ForeColor = System.Drawing.SystemColors.ControlText
		Me._lblEnable_0.Cursor = System.Windows.Forms.Cursors.Default
		Me._lblEnable_0.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me._lblEnable_0.UseMnemonic = True
		Me._lblEnable_0.Visible = True
		Me._lblEnable_0.AutoSize = False
		Me._lblEnable_0.BorderStyle = System.Windows.Forms.BorderStyle.None
		Me._lblEnable_0.Name = "_lblEnable_0"
		Me._lblIntPersist_0.Text = "IntPersist0:"
		Me._lblIntPersist_0.Size = New System.Drawing.Size(57, 17)
		Me._lblIntPersist_0.Location = New System.Drawing.Point(0, 72)
		Me._lblIntPersist_0.TabIndex = 24
		Me._lblIntPersist_0.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me._lblIntPersist_0.TextAlign = System.Drawing.ContentAlignment.TopLeft
		Me._lblIntPersist_0.BackColor = System.Drawing.SystemColors.Control
		Me._lblIntPersist_0.Enabled = True
		Me._lblIntPersist_0.ForeColor = System.Drawing.SystemColors.ControlText
		Me._lblIntPersist_0.Cursor = System.Windows.Forms.Cursors.Default
		Me._lblIntPersist_0.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me._lblIntPersist_0.UseMnemonic = True
		Me._lblIntPersist_0.Visible = True
		Me._lblIntPersist_0.AutoSize = False
		Me._lblIntPersist_0.BorderStyle = System.Windows.Forms.BorderStyle.None
		Me._lblIntPersist_0.Name = "_lblIntPersist_0"
		Me.lblRange.Text = "Range:"
		Me.lblRange.Size = New System.Drawing.Size(41, 17)
		Me.lblRange.Location = New System.Drawing.Point(0, 96)
		Me.lblRange.TabIndex = 23
		Me.lblRange.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.lblRange.TextAlign = System.Drawing.ContentAlignment.TopLeft
		Me.lblRange.BackColor = System.Drawing.SystemColors.Control
		Me.lblRange.Enabled = True
		Me.lblRange.ForeColor = System.Drawing.SystemColors.ControlText
		Me.lblRange.Cursor = System.Windows.Forms.Cursors.Default
		Me.lblRange.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.lblRange.UseMnemonic = True
		Me.lblRange.Visible = True
		Me.lblRange.AutoSize = False
		Me.lblRange.BorderStyle = System.Windows.Forms.BorderStyle.None
		Me.lblRange.Name = "lblRange"
		Me.lblInputSelect.Text = "Input:"
		Me.lblInputSelect.Size = New System.Drawing.Size(33, 17)
		Me.lblInputSelect.Location = New System.Drawing.Point(0, 120)
		Me.lblInputSelect.TabIndex = 22
		Me.lblInputSelect.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.lblInputSelect.TextAlign = System.Drawing.ContentAlignment.TopLeft
		Me.lblInputSelect.BackColor = System.Drawing.SystemColors.Control
		Me.lblInputSelect.Enabled = True
		Me.lblInputSelect.ForeColor = System.Drawing.SystemColors.ControlText
		Me.lblInputSelect.Cursor = System.Windows.Forms.Cursors.Default
		Me.lblInputSelect.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.lblInputSelect.UseMnemonic = True
		Me.lblInputSelect.Visible = True
		Me.lblInputSelect.AutoSize = False
		Me.lblInputSelect.BorderStyle = System.Windows.Forms.BorderStyle.None
		Me.lblInputSelect.Name = "lblInputSelect"
		Me.lblIrdr.Text = "Irdr:"
		Me.lblIrdr.Size = New System.Drawing.Size(25, 17)
		Me.lblIrdr.Location = New System.Drawing.Point(0, 144)
		Me.lblIrdr.TabIndex = 21
		Me.lblIrdr.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.lblIrdr.TextAlign = System.Drawing.ContentAlignment.TopLeft
		Me.lblIrdr.BackColor = System.Drawing.SystemColors.Control
		Me.lblIrdr.Enabled = True
		Me.lblIrdr.ForeColor = System.Drawing.SystemColors.ControlText
		Me.lblIrdr.Cursor = System.Windows.Forms.Cursors.Default
		Me.lblIrdr.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.lblIrdr.UseMnemonic = True
		Me.lblIrdr.Visible = True
		Me.lblIrdr.AutoSize = False
		Me.lblIrdr.BorderStyle = System.Windows.Forms.BorderStyle.None
		Me.lblIrdr.Name = "lblIrdr"
		Me.frmX11.Text = "x11"
		Me.frmX11.Size = New System.Drawing.Size(121, 105)
		Me.frmX11.Location = New System.Drawing.Point(120, 32)
		Me.frmX11.TabIndex = 1
		Me.frmX11.Visible = False
		Me.frmX11.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.frmX11.BackColor = System.Drawing.SystemColors.Control
		Me.frmX11.Enabled = True
		Me.frmX11.ForeColor = System.Drawing.SystemColors.ControlText
		Me.frmX11.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.frmX11.Padding = New System.Windows.Forms.Padding(0)
		Me.frmX11.Name = "frmX11"
		Me.tmrPoll.Enabled = False
		Me.tmrPoll.Interval = 100
		Me.cmbResolution.Size = New System.Drawing.Size(81, 21)
		Me.cmbResolution.Location = New System.Drawing.Point(32, 8)
		Me.cmbResolution.TabIndex = 13
		Me.cmbResolution.Text = "Resolution"
		Me.cmbResolution.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.cmbResolution.BackColor = System.Drawing.SystemColors.Window
		Me.cmbResolution.CausesValidation = True
		Me.cmbResolution.Enabled = True
		Me.cmbResolution.ForeColor = System.Drawing.SystemColors.WindowText
		Me.cmbResolution.IntegralHeight = True
		Me.cmbResolution.Cursor = System.Windows.Forms.Cursors.Default
		Me.cmbResolution.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.cmbResolution.Sorted = False
		Me.cmbResolution.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDown
		Me.cmbResolution.TabStop = True
		Me.cmbResolution.Visible = True
		Me.cmbResolution.Name = "cmbResolution"
		Me.cbProxAmbRej.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
		Me.cbProxAmbRej.Text = "AmbRej: ON"
		Me.cbProxAmbRej.Size = New System.Drawing.Size(105, 17)
		Me.cbProxAmbRej.Location = New System.Drawing.Point(8, 48)
		Me.cbProxAmbRej.Appearance = System.Windows.Forms.Appearance.Button
		Me.cbProxAmbRej.TabIndex = 11
		Me.cbProxAmbRej.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.cbProxAmbRej.CheckAlign = System.Drawing.ContentAlignment.MiddleLeft
		Me.cbProxAmbRej.FlatStyle = System.Windows.Forms.FlatStyle.Standard
		Me.cbProxAmbRej.BackColor = System.Drawing.SystemColors.Control
		Me.cbProxAmbRej.CausesValidation = True
		Me.cbProxAmbRej.Enabled = True
		Me.cbProxAmbRej.ForeColor = System.Drawing.SystemColors.ControlText
		Me.cbProxAmbRej.Cursor = System.Windows.Forms.Cursors.Default
		Me.cbProxAmbRej.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.cbProxAmbRej.TabStop = True
		Me.cbProxAmbRej.CheckState = System.Windows.Forms.CheckState.Unchecked
		Me.cbProxAmbRej.Visible = True
		Me.cbProxAmbRej.Name = "cbProxAmbRej"
		Me.cbIrdrFreq.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
		Me.cbIrdrFreq.Text = "Freq: DC"
		Me.cbIrdrFreq.Size = New System.Drawing.Size(105, 17)
		Me.cbIrdrFreq.Location = New System.Drawing.Point(8, 32)
		Me.cbIrdrFreq.Appearance = System.Windows.Forms.Appearance.Button
		Me.cbIrdrFreq.TabIndex = 10
		Me.cbIrdrFreq.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.cbIrdrFreq.CheckAlign = System.Drawing.ContentAlignment.MiddleLeft
		Me.cbIrdrFreq.FlatStyle = System.Windows.Forms.FlatStyle.Standard
		Me.cbIrdrFreq.BackColor = System.Drawing.SystemColors.Control
		Me.cbIrdrFreq.CausesValidation = True
		Me.cbIrdrFreq.Enabled = True
		Me.cbIrdrFreq.ForeColor = System.Drawing.SystemColors.ControlText
		Me.cbIrdrFreq.Cursor = System.Windows.Forms.Cursors.Default
		Me.cbIrdrFreq.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.cbIrdrFreq.TabStop = True
		Me.cbIrdrFreq.CheckState = System.Windows.Forms.CheckState.Unchecked
		Me.cbIrdrFreq.Visible = True
		Me.cbIrdrFreq.Name = "cbIrdrFreq"
		Me.lblResolution.Text = "Res:"
		Me.lblResolution.Size = New System.Drawing.Size(33, 17)
		Me.lblResolution.Location = New System.Drawing.Point(8, 8)
		Me.lblResolution.TabIndex = 12
		Me.lblResolution.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.lblResolution.TextAlign = System.Drawing.ContentAlignment.TopLeft
		Me.lblResolution.BackColor = System.Drawing.SystemColors.Control
		Me.lblResolution.Enabled = True
		Me.lblResolution.ForeColor = System.Drawing.SystemColors.ControlText
		Me.lblResolution.Cursor = System.Windows.Forms.Cursors.Default
		Me.lblResolution.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.lblResolution.UseMnemonic = True
		Me.lblResolution.Visible = True
		Me.lblResolution.AutoSize = False
		Me.lblResolution.BorderStyle = System.Windows.Forms.BorderStyle.None
		Me.lblResolution.Name = "lblResolution"
		Me.frmX28.Text = "x28"
		Me.frmX28.Size = New System.Drawing.Size(121, 113)
		Me.frmX28.Location = New System.Drawing.Point(8, 200)
		Me.frmX28.TabIndex = 2
		Me.frmX28.Visible = False
		Me.frmX28.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.frmX28.BackColor = System.Drawing.SystemColors.Control
		Me.frmX28.Enabled = True
		Me.frmX28.ForeColor = System.Drawing.SystemColors.ControlText
		Me.frmX28.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.frmX28.Padding = New System.Windows.Forms.Padding(0)
		Me.frmX28.Name = "frmX28"
		Me.cmbSleep.Size = New System.Drawing.Size(73, 21)
		Me.cmbSleep.Location = New System.Drawing.Point(40, 88)
		Me.cmbSleep.TabIndex = 8
		Me.cmbSleep.Text = "800"
		Me.cmbSleep.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.cmbSleep.BackColor = System.Drawing.SystemColors.Window
		Me.cmbSleep.CausesValidation = True
		Me.cmbSleep.Enabled = True
		Me.cmbSleep.ForeColor = System.Drawing.SystemColors.WindowText
		Me.cmbSleep.IntegralHeight = True
		Me.cmbSleep.Cursor = System.Windows.Forms.Cursors.Default
		Me.cmbSleep.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.cmbSleep.Sorted = False
		Me.cmbSleep.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDown
		Me.cmbSleep.TabStop = True
		Me.cmbSleep.Visible = True
		Me.cmbSleep.Name = "cmbSleep"
		Me.cbIntLogic.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
		Me.cbIntLogic.Text = "IntLogic: OR"
		Me.cbIntLogic.Size = New System.Drawing.Size(105, 17)
		Me.cbIntLogic.Location = New System.Drawing.Point(8, 64)
		Me.cbIntLogic.Appearance = System.Windows.Forms.Appearance.Button
		Me.cbIntLogic.TabIndex = 7
		Me.cbIntLogic.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.cbIntLogic.CheckAlign = System.Drawing.ContentAlignment.MiddleLeft
		Me.cbIntLogic.FlatStyle = System.Windows.Forms.FlatStyle.Standard
		Me.cbIntLogic.BackColor = System.Drawing.SystemColors.Control
		Me.cbIntLogic.CausesValidation = True
		Me.cbIntLogic.Enabled = True
		Me.cbIntLogic.ForeColor = System.Drawing.SystemColors.ControlText
		Me.cbIntLogic.Cursor = System.Windows.Forms.Cursors.Default
		Me.cbIntLogic.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.cbIntLogic.TabStop = True
		Me.cbIntLogic.CheckState = System.Windows.Forms.CheckState.Unchecked
		Me.cbIntLogic.Visible = True
		Me.cbIntLogic.Name = "cbIntLogic"
		Me._cmbIntPersist_1.Size = New System.Drawing.Size(49, 21)
		Me._cmbIntPersist_1.Location = New System.Drawing.Point(64, 40)
		Me._cmbIntPersist_1.TabIndex = 5
		Me._cmbIntPersist_1.Text = "IntPersist"
		Me._cmbIntPersist_1.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me._cmbIntPersist_1.BackColor = System.Drawing.SystemColors.Window
		Me._cmbIntPersist_1.CausesValidation = True
		Me._cmbIntPersist_1.Enabled = True
		Me._cmbIntPersist_1.ForeColor = System.Drawing.SystemColors.WindowText
		Me._cmbIntPersist_1.IntegralHeight = True
		Me._cmbIntPersist_1.Cursor = System.Windows.Forms.Cursors.Default
		Me._cmbIntPersist_1.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me._cmbIntPersist_1.Sorted = False
		Me._cmbIntPersist_1.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDown
		Me._cmbIntPersist_1.TabStop = True
		Me._cmbIntPersist_1.Visible = True
		Me._cmbIntPersist_1.Name = "_cmbIntPersist_1"
		Me._cbEnable_1.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
		Me._cbEnable_1.Text = "Enabled"
		Me._cbEnable_1.Size = New System.Drawing.Size(65, 17)
		Me._cbEnable_1.Location = New System.Drawing.Point(48, 16)
		Me._cbEnable_1.Appearance = System.Windows.Forms.Appearance.Button
		Me._cbEnable_1.TabIndex = 4
		Me._cbEnable_1.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me._cbEnable_1.CheckAlign = System.Drawing.ContentAlignment.MiddleLeft
		Me._cbEnable_1.FlatStyle = System.Windows.Forms.FlatStyle.Standard
		Me._cbEnable_1.BackColor = System.Drawing.SystemColors.Control
		Me._cbEnable_1.CausesValidation = True
		Me._cbEnable_1.Enabled = True
		Me._cbEnable_1.ForeColor = System.Drawing.SystemColors.ControlText
		Me._cbEnable_1.Cursor = System.Windows.Forms.Cursors.Default
		Me._cbEnable_1.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me._cbEnable_1.TabStop = True
		Me._cbEnable_1.CheckState = System.Windows.Forms.CheckState.Unchecked
		Me._cbEnable_1.Visible = True
		Me._cbEnable_1.Name = "_cbEnable_1"
		Me.lblSleep.Text = "Sleep:"
		Me.lblSleep.Size = New System.Drawing.Size(33, 17)
		Me.lblSleep.Location = New System.Drawing.Point(8, 88)
		Me.lblSleep.TabIndex = 9
		Me.lblSleep.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.lblSleep.TextAlign = System.Drawing.ContentAlignment.TopLeft
		Me.lblSleep.BackColor = System.Drawing.SystemColors.Control
		Me.lblSleep.Enabled = True
		Me.lblSleep.ForeColor = System.Drawing.SystemColors.ControlText
		Me.lblSleep.Cursor = System.Windows.Forms.Cursors.Default
		Me.lblSleep.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.lblSleep.UseMnemonic = True
		Me.lblSleep.Visible = True
		Me.lblSleep.AutoSize = False
		Me.lblSleep.BorderStyle = System.Windows.Forms.BorderStyle.None
		Me.lblSleep.Name = "lblSleep"
		Me._lblIntPersist_1.Text = "IntPersist1:"
		Me._lblIntPersist_1.Size = New System.Drawing.Size(57, 17)
		Me._lblIntPersist_1.Location = New System.Drawing.Point(8, 40)
		Me._lblIntPersist_1.TabIndex = 6
		Me._lblIntPersist_1.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me._lblIntPersist_1.TextAlign = System.Drawing.ContentAlignment.TopLeft
		Me._lblIntPersist_1.BackColor = System.Drawing.SystemColors.Control
		Me._lblIntPersist_1.Enabled = True
		Me._lblIntPersist_1.ForeColor = System.Drawing.SystemColors.ControlText
		Me._lblIntPersist_1.Cursor = System.Windows.Forms.Cursors.Default
		Me._lblIntPersist_1.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me._lblIntPersist_1.UseMnemonic = True
		Me._lblIntPersist_1.Visible = True
		Me._lblIntPersist_1.AutoSize = False
		Me._lblIntPersist_1.BorderStyle = System.Windows.Forms.BorderStyle.None
		Me._lblIntPersist_1.Name = "_lblIntPersist_1"
		Me._lblEnable_1.Text = "Chan1:"
		Me._lblEnable_1.Size = New System.Drawing.Size(33, 17)
		Me._lblEnable_1.Location = New System.Drawing.Point(8, 16)
		Me._lblEnable_1.TabIndex = 3
		Me._lblEnable_1.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me._lblEnable_1.TextAlign = System.Drawing.ContentAlignment.TopLeft
		Me._lblEnable_1.BackColor = System.Drawing.SystemColors.Control
		Me._lblEnable_1.Enabled = True
		Me._lblEnable_1.ForeColor = System.Drawing.SystemColors.ControlText
		Me._lblEnable_1.Cursor = System.Windows.Forms.Cursors.Default
		Me._lblEnable_1.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me._lblEnable_1.UseMnemonic = True
		Me._lblEnable_1.Visible = True
		Me._lblEnable_1.AutoSize = False
		Me._lblEnable_1.BorderStyle = System.Windows.Forms.BorderStyle.None
		Me._lblEnable_1.Name = "_lblEnable_1"
		Me.frmX38.Text = "Frame1"
		Me.frmX38.Size = New System.Drawing.Size(121, 97)
		Me.frmX38.Location = New System.Drawing.Point(8, 304)
		Me.frmX38.TabIndex = 31
		Me.frmX38.Visible = False
		Me.frmX38.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.frmX38.BackColor = System.Drawing.SystemColors.Control
		Me.frmX38.Enabled = True
		Me.frmX38.ForeColor = System.Drawing.SystemColors.ControlText
		Me.frmX38.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.frmX38.Padding = New System.Windows.Forms.Padding(0)
		Me.frmX38.Name = "frmX38"
		Me.fmProxOffset.Text = "Prox Offset"
		Me.fmProxOffset.Size = New System.Drawing.Size(105, 41)
		Me.fmProxOffset.Location = New System.Drawing.Point(8, 8)
		Me.fmProxOffset.TabIndex = 32
		Me.fmProxOffset.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.fmProxOffset.BackColor = System.Drawing.SystemColors.Control
		Me.fmProxOffset.Enabled = True
		Me.fmProxOffset.ForeColor = System.Drawing.SystemColors.ControlText
		Me.fmProxOffset.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.fmProxOffset.Visible = True
		Me.fmProxOffset.Padding = New System.Windows.Forms.Padding(0)
		Me.fmProxOffset.Name = "fmProxOffset"
		Me.hscrProxOffset.Size = New System.Drawing.Size(57, 17)
		Me.hscrProxOffset.Location = New System.Drawing.Point(8, 16)
		Me.hscrProxOffset.Maximum = 15
		Me.hscrProxOffset.TabIndex = 33
		Me.hscrProxOffset.CausesValidation = True
		Me.hscrProxOffset.Enabled = True
		Me.hscrProxOffset.LargeChange = 1
		Me.hscrProxOffset.Minimum = 0
		Me.hscrProxOffset.Cursor = System.Windows.Forms.Cursors.Default
		Me.hscrProxOffset.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.hscrProxOffset.SmallChange = 1
		Me.hscrProxOffset.TabStop = True
		Me.hscrProxOffset.Value = 0
		Me.hscrProxOffset.Visible = True
		Me.hscrProxOffset.Name = "hscrProxOffset"
		Me.lblProxOffset.Text = "0"
		Me.lblProxOffset.Size = New System.Drawing.Size(17, 17)
		Me.lblProxOffset.Location = New System.Drawing.Point(80, 16)
		Me.lblProxOffset.TabIndex = 34
		Me.lblProxOffset.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.lblProxOffset.TextAlign = System.Drawing.ContentAlignment.TopLeft
		Me.lblProxOffset.BackColor = System.Drawing.SystemColors.Control
		Me.lblProxOffset.Enabled = True
		Me.lblProxOffset.ForeColor = System.Drawing.SystemColors.ControlText
		Me.lblProxOffset.Cursor = System.Windows.Forms.Cursors.Default
		Me.lblProxOffset.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.lblProxOffset.UseMnemonic = True
		Me.lblProxOffset.Visible = True
		Me.lblProxOffset.AutoSize = False
		Me.lblProxOffset.BorderStyle = System.Windows.Forms.BorderStyle.None
		Me.lblProxOffset.Name = "lblProxOffset"
		Me.fmIRcomp.Text = "IR Comp"
		Me.fmIRcomp.Size = New System.Drawing.Size(105, 41)
		Me.fmIRcomp.Location = New System.Drawing.Point(8, 48)
		Me.fmIRcomp.TabIndex = 35
		Me.fmIRcomp.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.fmIRcomp.BackColor = System.Drawing.SystemColors.Control
		Me.fmIRcomp.Enabled = True
		Me.fmIRcomp.ForeColor = System.Drawing.SystemColors.ControlText
		Me.fmIRcomp.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.fmIRcomp.Visible = True
		Me.fmIRcomp.Padding = New System.Windows.Forms.Padding(0)
		Me.fmIRcomp.Name = "fmIRcomp"
		Me.hscrIRcomp.Size = New System.Drawing.Size(57, 17)
		Me.hscrIRcomp.Location = New System.Drawing.Point(8, 16)
		Me.hscrIRcomp.Maximum = 31
		Me.hscrIRcomp.TabIndex = 36
		Me.hscrIRcomp.CausesValidation = True
		Me.hscrIRcomp.Enabled = True
		Me.hscrIRcomp.LargeChange = 1
		Me.hscrIRcomp.Minimum = 0
		Me.hscrIRcomp.Cursor = System.Windows.Forms.Cursors.Default
		Me.hscrIRcomp.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.hscrIRcomp.SmallChange = 1
		Me.hscrIRcomp.TabStop = True
		Me.hscrIRcomp.Value = 0
		Me.hscrIRcomp.Visible = True
		Me.hscrIRcomp.Name = "hscrIRcomp"
		Me.lblIRcomp.Text = "0"
		Me.lblIRcomp.Size = New System.Drawing.Size(17, 17)
		Me.lblIRcomp.Location = New System.Drawing.Point(80, 16)
		Me.lblIRcomp.TabIndex = 37
		Me.lblIRcomp.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.lblIRcomp.TextAlign = System.Drawing.ContentAlignment.TopLeft
		Me.lblIRcomp.BackColor = System.Drawing.SystemColors.Control
		Me.lblIRcomp.Enabled = True
		Me.lblIRcomp.ForeColor = System.Drawing.SystemColors.ControlText
		Me.lblIRcomp.Cursor = System.Windows.Forms.Cursors.Default
		Me.lblIRcomp.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.lblIRcomp.UseMnemonic = True
		Me.lblIRcomp.Visible = True
		Me.lblIRcomp.AutoSize = False
		Me.lblIRcomp.BorderStyle = System.Windows.Forms.BorderStyle.None
		Me.lblIRcomp.Name = "lblIRcomp"
		Me._optAddr_0.TextAlign = System.Drawing.ContentAlignment.MiddleLeft
		Me._optAddr_0.Text = "None"
		Me._optAddr_0.Size = New System.Drawing.Size(49, 17)
		Me._optAddr_0.Location = New System.Drawing.Point(64, 24)
		Me._optAddr_0.TabIndex = 30
		Me._optAddr_0.Checked = True
		Me._optAddr_0.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me._optAddr_0.CheckAlign = System.Drawing.ContentAlignment.MiddleLeft
		Me._optAddr_0.BackColor = System.Drawing.SystemColors.Control
		Me._optAddr_0.CausesValidation = True
		Me._optAddr_0.Enabled = True
		Me._optAddr_0.ForeColor = System.Drawing.SystemColors.ControlText
		Me._optAddr_0.Cursor = System.Windows.Forms.Cursors.Default
		Me._optAddr_0.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me._optAddr_0.Appearance = System.Windows.Forms.Appearance.Normal
		Me._optAddr_0.TabStop = True
		Me._optAddr_0.Visible = True
		Me._optAddr_0.Name = "_optAddr_0"
		Me.Controls.Add(_optAddr_4)
		Me.Controls.Add(_optAddr_3)
		Me.Controls.Add(_optAddr_2)
		Me.Controls.Add(_optAddr_1)
		Me.Controls.Add(frmDevice)
		Me.Controls.Add(_optAddr_0)
		Me.frmDevice.Controls.Add(cmdConversionTime)
		Me.frmDevice.Controls.Add(fmBoth)
		Me.frmDevice.Controls.Add(frmX11)
		Me.frmDevice.Controls.Add(frmX28)
		Me.frmDevice.Controls.Add(frmX38)
		Me.fmBoth.Controls.Add(cbPoll)
		Me.fmBoth.Controls.Add(optInt)
		Me.fmBoth.Controls.Add(cmbDevice)
		Me.fmBoth.Controls.Add(_cbEnable_0)
		Me.fmBoth.Controls.Add(_cmbIntPersist_0)
		Me.fmBoth.Controls.Add(cmbRange)
		Me.fmBoth.Controls.Add(cmbInputSelect)
		Me.fmBoth.Controls.Add(cmbIrdr)
		Me.fmBoth.Controls.Add(_lblEnable_0)
		Me.fmBoth.Controls.Add(_lblIntPersist_0)
		Me.fmBoth.Controls.Add(lblRange)
		Me.fmBoth.Controls.Add(lblInputSelect)
		Me.fmBoth.Controls.Add(lblIrdr)
		Me.frmX11.Controls.Add(cmbResolution)
		Me.frmX11.Controls.Add(cbProxAmbRej)
		Me.frmX11.Controls.Add(cbIrdrFreq)
		Me.frmX11.Controls.Add(lblResolution)
		Me.frmX28.Controls.Add(cmbSleep)
		Me.frmX28.Controls.Add(cbIntLogic)
		Me.frmX28.Controls.Add(_cmbIntPersist_1)
		Me.frmX28.Controls.Add(_cbEnable_1)
		Me.frmX28.Controls.Add(lblSleep)
		Me.frmX28.Controls.Add(_lblIntPersist_1)
		Me.frmX28.Controls.Add(_lblEnable_1)
		Me.frmX38.Controls.Add(fmProxOffset)
		Me.frmX38.Controls.Add(fmIRcomp)
		Me.fmProxOffset.Controls.Add(hscrProxOffset)
		Me.fmProxOffset.Controls.Add(lblProxOffset)
		Me.fmIRcomp.Controls.Add(hscrIRcomp)
		Me.fmIRcomp.Controls.Add(lblIRcomp)
		Me.cbEnable.SetIndex(_cbEnable_0, CType(0, Short))
		Me.cbEnable.SetIndex(_cbEnable_1, CType(1, Short))
		Me.cmbIntPersist.SetIndex(_cmbIntPersist_0, CType(0, Short))
		Me.cmbIntPersist.SetIndex(_cmbIntPersist_1, CType(1, Short))
		Me.lblEnable.SetIndex(_lblEnable_0, CType(0, Short))
		Me.lblEnable.SetIndex(_lblEnable_1, CType(1, Short))
		Me.lblIntPersist.SetIndex(_lblIntPersist_0, CType(0, Short))
		Me.lblIntPersist.SetIndex(_lblIntPersist_1, CType(1, Short))
		Me.optAddr.SetIndex(_optAddr_4, CType(4, Short))
		Me.optAddr.SetIndex(_optAddr_3, CType(3, Short))
		Me.optAddr.SetIndex(_optAddr_2, CType(2, Short))
		Me.optAddr.SetIndex(_optAddr_1, CType(1, Short))
		Me.optAddr.SetIndex(_optAddr_0, CType(0, Short))
		CType(Me.optAddr, System.ComponentModel.ISupportInitialize).EndInit()
		CType(Me.lblIntPersist, System.ComponentModel.ISupportInitialize).EndInit()
		CType(Me.lblEnable, System.ComponentModel.ISupportInitialize).EndInit()
		CType(Me.cmbIntPersist, System.ComponentModel.ISupportInitialize).EndInit()
		CType(Me.cbEnable, System.ComponentModel.ISupportInitialize).EndInit()
		Me.frmDevice.ResumeLayout(False)
		Me.fmBoth.ResumeLayout(False)
		Me.frmX11.ResumeLayout(False)
		Me.frmX28.ResumeLayout(False)
		Me.frmX38.ResumeLayout(False)
		Me.fmProxOffset.ResumeLayout(False)
		Me.fmIRcomp.ResumeLayout(False)
		Me.ResumeLayout(False)
		Me.PerformLayout()
	End Sub
#End Region 
End Class