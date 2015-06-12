<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> Partial Class ucThorlabsAPT
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
	Friend WithEvents cmdSweep As System.Windows.Forms.Button
	Friend WithEvents cbSweepType As System.Windows.Forms.CheckBox
	Friend WithEvents cmdCalSweep As System.Windows.Forms.Button
	Friend WithEvents fmSweep As System.Windows.Forms.GroupBox
	Friend WithEvents tmrCalSweep As System.Windows.Forms.Timer
	Friend WithEvents tmrGetPos As System.Windows.Forms.Timer
	Friend WithEvents tbSerNum As System.Windows.Forms.TextBox
	Friend WithEvents cmbSerNum As System.Windows.Forms.ComboBox
	Friend WithEvents frmSerNum As System.Windows.Forms.GroupBox
	Friend WithEvents MG17Motor1 As AxMG17MotorLib.AxMG17Motor
	Friend WithEvents cbBlocking As System.Windows.Forms.CheckBox
	Friend WithEvents cmdZeroHome As System.Windows.Forms.Button
	Friend WithEvents _tbMG17LoopParams_4 As System.Windows.Forms.TextBox
	Friend WithEvents _frmMG17LoopParams_4 As System.Windows.Forms.GroupBox
	Friend WithEvents _tbMG17LoopParams_3 As System.Windows.Forms.TextBox
	Friend WithEvents _frmMG17LoopParams_3 As System.Windows.Forms.GroupBox
	Friend WithEvents cmdStoreZero As System.Windows.Forms.Button
	Friend WithEvents _tbMG17LoopParams_2 As System.Windows.Forms.TextBox
	Friend WithEvents _frmMG17LoopParams_2 As System.Windows.Forms.GroupBox
	Friend WithEvents _tbMG17LoopParams_1 As System.Windows.Forms.TextBox
	Friend WithEvents _frmMG17LoopParams_1 As System.Windows.Forms.GroupBox
	Friend WithEvents _tbMG17LoopParams_0 As System.Windows.Forms.TextBox
	Friend WithEvents _frmMG17LoopParams_0 As System.Windows.Forms.GroupBox
	Friend WithEvents frmMG17Motor As System.Windows.Forms.GroupBox
	Friend WithEvents frmMG17LoopParams As Microsoft.VisualBasic.Compatibility.VB6.GroupBoxArray
	Friend WithEvents tbMG17LoopParams As Microsoft.VisualBasic.Compatibility.VB6.TextBoxArray
	'NOTE: The following procedure is required by the Windows Form Designer
	'It can be modified using the Windows Form Designer.
	'Do not modify it using the code editor.
	<System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
		Dim resources As System.Resources.ResourceManager = New System.Resources.ResourceManager(GetType(ucThorlabsAPT))
		Me.components = New System.ComponentModel.Container()
		Me.ToolTip1 = New System.Windows.Forms.ToolTip(components)
		Me.fmSweep = New System.Windows.Forms.GroupBox
		Me.cmdSweep = New System.Windows.Forms.Button
		Me.cbSweepType = New System.Windows.Forms.CheckBox
		Me.cmdCalSweep = New System.Windows.Forms.Button
		Me.tmrCalSweep = New System.Windows.Forms.Timer(components)
		Me.tmrGetPos = New System.Windows.Forms.Timer(components)
		Me.frmSerNum = New System.Windows.Forms.GroupBox
		Me.tbSerNum = New System.Windows.Forms.TextBox
		Me.cmbSerNum = New System.Windows.Forms.ComboBox
		Me.MG17Motor1 = New AxMG17MotorLib.AxMG17Motor
		Me.frmMG17Motor = New System.Windows.Forms.GroupBox
		Me.cbBlocking = New System.Windows.Forms.CheckBox
		Me.cmdZeroHome = New System.Windows.Forms.Button
		Me._frmMG17LoopParams_4 = New System.Windows.Forms.GroupBox
		Me._tbMG17LoopParams_4 = New System.Windows.Forms.TextBox
		Me._frmMG17LoopParams_3 = New System.Windows.Forms.GroupBox
		Me._tbMG17LoopParams_3 = New System.Windows.Forms.TextBox
		Me.cmdStoreZero = New System.Windows.Forms.Button
		Me._frmMG17LoopParams_2 = New System.Windows.Forms.GroupBox
		Me._tbMG17LoopParams_2 = New System.Windows.Forms.TextBox
		Me._frmMG17LoopParams_1 = New System.Windows.Forms.GroupBox
		Me._tbMG17LoopParams_1 = New System.Windows.Forms.TextBox
		Me._frmMG17LoopParams_0 = New System.Windows.Forms.GroupBox
		Me._tbMG17LoopParams_0 = New System.Windows.Forms.TextBox
		Me.frmMG17LoopParams = New Microsoft.VisualBasic.Compatibility.VB6.GroupBoxArray(components)
		Me.tbMG17LoopParams = New Microsoft.VisualBasic.Compatibility.VB6.TextBoxArray(components)
		Me.fmSweep.SuspendLayout()
		Me.frmSerNum.SuspendLayout()
		Me.frmMG17Motor.SuspendLayout()
		Me._frmMG17LoopParams_4.SuspendLayout()
		Me._frmMG17LoopParams_3.SuspendLayout()
		Me._frmMG17LoopParams_2.SuspendLayout()
		Me._frmMG17LoopParams_1.SuspendLayout()
		Me._frmMG17LoopParams_0.SuspendLayout()
		Me.SuspendLayout()
		Me.ToolTip1.Active = True
		CType(Me.MG17Motor1, System.ComponentModel.ISupportInitialize).BeginInit()
		CType(Me.frmMG17LoopParams, System.ComponentModel.ISupportInitialize).BeginInit()
		CType(Me.tbMG17LoopParams, System.ComponentModel.ISupportInitialize).BeginInit()
		Me.ClientSize = New System.Drawing.Size(342, 309)
		MyBase.Location = New System.Drawing.Point(0, 0)
		MyBase.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		MyBase.Name = "ucThorlabsAPT"
		Me.fmSweep.BackColor = System.Drawing.Color.FromARGB(255, 128, 128)
		Me.fmSweep.Text = "Sweep"
		Me.fmSweep.Size = New System.Drawing.Size(153, 41)
		Me.fmSweep.Location = New System.Drawing.Point(384, 8)
		Me.fmSweep.TabIndex = 17
		Me.fmSweep.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.fmSweep.Enabled = True
		Me.fmSweep.ForeColor = System.Drawing.SystemColors.ControlText
		Me.fmSweep.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.fmSweep.Visible = True
		Me.fmSweep.Padding = New System.Windows.Forms.Padding(0)
		Me.fmSweep.Name = "fmSweep"
		Me.cmdSweep.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
		Me.cmdSweep.Text = "Arm"
		Me.cmdSweep.Size = New System.Drawing.Size(33, 17)
		Me.cmdSweep.Location = New System.Drawing.Point(8, 16)
		Me.cmdSweep.TabIndex = 20
		Me.cmdSweep.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.cmdSweep.BackColor = System.Drawing.SystemColors.Control
		Me.cmdSweep.CausesValidation = True
		Me.cmdSweep.Enabled = True
		Me.cmdSweep.ForeColor = System.Drawing.SystemColors.ControlText
		Me.cmdSweep.Cursor = System.Windows.Forms.Cursors.Default
		Me.cmdSweep.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.cmdSweep.TabStop = True
		Me.cmdSweep.Name = "cmdSweep"
		Me.cbSweepType.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
		Me.cbSweepType.Text = "Stepped"
		Me.cbSweepType.Size = New System.Drawing.Size(49, 17)
		Me.cbSweepType.Location = New System.Drawing.Point(40, 16)
		Me.cbSweepType.Appearance = System.Windows.Forms.Appearance.Button
		Me.cbSweepType.TabIndex = 19
		Me.cbSweepType.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.cbSweepType.CheckAlign = System.Drawing.ContentAlignment.MiddleLeft
		Me.cbSweepType.FlatStyle = System.Windows.Forms.FlatStyle.Standard
		Me.cbSweepType.BackColor = System.Drawing.SystemColors.Control
		Me.cbSweepType.CausesValidation = True
		Me.cbSweepType.Enabled = True
		Me.cbSweepType.ForeColor = System.Drawing.SystemColors.ControlText
		Me.cbSweepType.Cursor = System.Windows.Forms.Cursors.Default
		Me.cbSweepType.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.cbSweepType.TabStop = True
		Me.cbSweepType.CheckState = System.Windows.Forms.CheckState.Unchecked
		Me.cbSweepType.Visible = True
		Me.cbSweepType.Name = "cbSweepType"
		Me.cmdCalSweep.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
		Me.cmdCalSweep.Text = "Calibrate"
		Me.cmdCalSweep.Enabled = False
		Me.cmdCalSweep.Size = New System.Drawing.Size(57, 17)
		Me.cmdCalSweep.Location = New System.Drawing.Point(88, 16)
		Me.cmdCalSweep.TabIndex = 18
		Me.cmdCalSweep.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.cmdCalSweep.BackColor = System.Drawing.SystemColors.Control
		Me.cmdCalSweep.CausesValidation = True
		Me.cmdCalSweep.ForeColor = System.Drawing.SystemColors.ControlText
		Me.cmdCalSweep.Cursor = System.Windows.Forms.Cursors.Default
		Me.cmdCalSweep.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.cmdCalSweep.TabStop = True
		Me.cmdCalSweep.Name = "cmdCalSweep"
		Me.tmrCalSweep.Interval = 100
		Me.tmrCalSweep.Enabled = True
		Me.tmrGetPos.Enabled = False
		Me.tmrGetPos.Interval = 500
		Me.frmSerNum.Text = "Serial Number"
		Me.frmSerNum.Size = New System.Drawing.Size(89, 41)
		Me.frmSerNum.Location = New System.Drawing.Point(16, 8)
		Me.frmSerNum.TabIndex = 0
		Me.frmSerNum.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.frmSerNum.BackColor = System.Drawing.SystemColors.Control
		Me.frmSerNum.Enabled = True
		Me.frmSerNum.ForeColor = System.Drawing.SystemColors.ControlText
		Me.frmSerNum.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.frmSerNum.Visible = True
		Me.frmSerNum.Padding = New System.Windows.Forms.Padding(0)
		Me.frmSerNum.Name = "frmSerNum"
		Me.tbSerNum.AutoSize = False
		Me.tbSerNum.Size = New System.Drawing.Size(57, 21)
		Me.tbSerNum.Location = New System.Drawing.Point(8, 16)
		Me.tbSerNum.MultiLine = True
		Me.tbSerNum.TabIndex = 3
		Me.tbSerNum.Text = "88888888" & Chr(13) & Chr(10)
		Me.tbSerNum.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.tbSerNum.AcceptsReturn = True
		Me.tbSerNum.TextAlign = System.Windows.Forms.HorizontalAlignment.Left
		Me.tbSerNum.BackColor = System.Drawing.SystemColors.Window
		Me.tbSerNum.CausesValidation = True
		Me.tbSerNum.Enabled = True
		Me.tbSerNum.ForeColor = System.Drawing.SystemColors.WindowText
		Me.tbSerNum.HideSelection = True
		Me.tbSerNum.ReadOnly = False
		Me.tbSerNum.Maxlength = 0
		Me.tbSerNum.Cursor = System.Windows.Forms.Cursors.IBeam
		Me.tbSerNum.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.tbSerNum.ScrollBars = System.Windows.Forms.ScrollBars.None
		Me.tbSerNum.TabStop = True
		Me.tbSerNum.Visible = True
		Me.tbSerNum.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
		Me.tbSerNum.Name = "tbSerNum"
		Me.cmbSerNum.Size = New System.Drawing.Size(73, 21)
		Me.cmbSerNum.Location = New System.Drawing.Point(8, 16)
		Me.cmbSerNum.Items.AddRange(New Object(){"45839763", "83820662", "83820779", "83833260", "--alsET-", "83832070", "83833262", "--mono--", "83833331", "83833339", "---LT--", "83830728", "83833282", "--NTL---", "83833567", "83838149"})
		Me.cmbSerNum.TabIndex = 1
		Me.cmbSerNum.Text = "83820779"
		Me.cmbSerNum.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.cmbSerNum.BackColor = System.Drawing.SystemColors.Window
		Me.cmbSerNum.CausesValidation = True
		Me.cmbSerNum.Enabled = True
		Me.cmbSerNum.ForeColor = System.Drawing.SystemColors.WindowText
		Me.cmbSerNum.IntegralHeight = True
		Me.cmbSerNum.Cursor = System.Windows.Forms.Cursors.Default
		Me.cmbSerNum.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.cmbSerNum.Sorted = False
		Me.cmbSerNum.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDown
		Me.cmbSerNum.TabStop = True
		Me.cmbSerNum.Visible = True
		Me.cmbSerNum.Name = "cmbSerNum"
		MG17Motor1.OcxState = CType(resources.GetObject("MG17Motor1.OcxState"), System.Windows.Forms.AxHost.State)
		Me.MG17Motor1.Size = New System.Drawing.Size(337, 201)
		Me.MG17Motor1.Location = New System.Drawing.Point(0, 104)
		Me.MG17Motor1.TabIndex = 2
		Me.MG17Motor1.Name = "MG17Motor1"
		Me.frmMG17Motor.Size = New System.Drawing.Size(337, 97)
		Me.frmMG17Motor.Location = New System.Drawing.Point(0, 0)
		Me.frmMG17Motor.TabIndex = 4
		Me.frmMG17Motor.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.frmMG17Motor.BackColor = System.Drawing.SystemColors.Control
		Me.frmMG17Motor.Enabled = True
		Me.frmMG17Motor.ForeColor = System.Drawing.SystemColors.ControlText
		Me.frmMG17Motor.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.frmMG17Motor.Visible = True
		Me.frmMG17Motor.Padding = New System.Windows.Forms.Padding(0)
		Me.frmMG17Motor.Name = "frmMG17Motor"
		Me.cbBlocking.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
		Me.cbBlocking.Text = "Position: Non-Blocking"
		Me.cbBlocking.Size = New System.Drawing.Size(129, 17)
		Me.cbBlocking.Location = New System.Drawing.Point(184, 12)
		Me.cbBlocking.Appearance = System.Windows.Forms.Appearance.Button
		Me.cbBlocking.TabIndex = 21
		Me.cbBlocking.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.cbBlocking.CheckAlign = System.Drawing.ContentAlignment.MiddleLeft
		Me.cbBlocking.FlatStyle = System.Windows.Forms.FlatStyle.Standard
		Me.cbBlocking.BackColor = System.Drawing.SystemColors.Control
		Me.cbBlocking.CausesValidation = True
		Me.cbBlocking.Enabled = True
		Me.cbBlocking.ForeColor = System.Drawing.SystemColors.ControlText
		Me.cbBlocking.Cursor = System.Windows.Forms.Cursors.Default
		Me.cbBlocking.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.cbBlocking.TabStop = True
		Me.cbBlocking.CheckState = System.Windows.Forms.CheckState.Unchecked
		Me.cbBlocking.Visible = True
		Me.cbBlocking.Name = "cbBlocking"
		Me.cmdZeroHome.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
		Me.cmdZeroHome.Text = "Zero->Home"
		Me.cmdZeroHome.Size = New System.Drawing.Size(81, 17)
		Me.cmdZeroHome.Location = New System.Drawing.Point(96, 12)
		Me.cmdZeroHome.TabIndex = 11
		Me.cmdZeroHome.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.cmdZeroHome.BackColor = System.Drawing.SystemColors.Control
		Me.cmdZeroHome.CausesValidation = True
		Me.cmdZeroHome.Enabled = True
		Me.cmdZeroHome.ForeColor = System.Drawing.SystemColors.ControlText
		Me.cmdZeroHome.Cursor = System.Windows.Forms.Cursors.Default
		Me.cmdZeroHome.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.cmdZeroHome.TabStop = True
		Me.cmdZeroHome.Name = "cmdZeroHome"
		Me._frmMG17LoopParams_4.Text = "Position"
		Me._frmMG17LoopParams_4.Size = New System.Drawing.Size(65, 41)
		Me._frmMG17LoopParams_4.Location = New System.Drawing.Point(72, 48)
		Me._frmMG17LoopParams_4.TabIndex = 15
		Me._frmMG17LoopParams_4.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me._frmMG17LoopParams_4.BackColor = System.Drawing.SystemColors.Control
		Me._frmMG17LoopParams_4.Enabled = True
		Me._frmMG17LoopParams_4.ForeColor = System.Drawing.SystemColors.ControlText
		Me._frmMG17LoopParams_4.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me._frmMG17LoopParams_4.Visible = True
		Me._frmMG17LoopParams_4.Padding = New System.Windows.Forms.Padding(0)
		Me._frmMG17LoopParams_4.Name = "_frmMG17LoopParams_4"
		Me._tbMG17LoopParams_4.AutoSize = False
		Me._tbMG17LoopParams_4.TextAlign = System.Windows.Forms.HorizontalAlignment.Right
		Me._tbMG17LoopParams_4.Enabled = False
		Me._tbMG17LoopParams_4.Size = New System.Drawing.Size(49, 19)
		Me._tbMG17LoopParams_4.Location = New System.Drawing.Point(8, 16)
		Me._tbMG17LoopParams_4.MultiLine = True
		Me._tbMG17LoopParams_4.TabIndex = 16
		Me._tbMG17LoopParams_4.Text = "0"
		Me._tbMG17LoopParams_4.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me._tbMG17LoopParams_4.AcceptsReturn = True
		Me._tbMG17LoopParams_4.BackColor = System.Drawing.SystemColors.Window
		Me._tbMG17LoopParams_4.CausesValidation = True
		Me._tbMG17LoopParams_4.ForeColor = System.Drawing.SystemColors.WindowText
		Me._tbMG17LoopParams_4.HideSelection = True
		Me._tbMG17LoopParams_4.ReadOnly = False
		Me._tbMG17LoopParams_4.Maxlength = 0
		Me._tbMG17LoopParams_4.Cursor = System.Windows.Forms.Cursors.IBeam
		Me._tbMG17LoopParams_4.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me._tbMG17LoopParams_4.ScrollBars = System.Windows.Forms.ScrollBars.None
		Me._tbMG17LoopParams_4.TabStop = True
		Me._tbMG17LoopParams_4.Visible = True
		Me._tbMG17LoopParams_4.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
		Me._tbMG17LoopParams_4.Name = "_tbMG17LoopParams_4"
		Me._frmMG17LoopParams_3.Text = "Offset"
		Me._frmMG17LoopParams_3.Size = New System.Drawing.Size(65, 41)
		Me._frmMG17LoopParams_3.Location = New System.Drawing.Point(8, 48)
		Me._frmMG17LoopParams_3.TabIndex = 13
		Me._frmMG17LoopParams_3.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me._frmMG17LoopParams_3.BackColor = System.Drawing.SystemColors.Control
		Me._frmMG17LoopParams_3.Enabled = True
		Me._frmMG17LoopParams_3.ForeColor = System.Drawing.SystemColors.ControlText
		Me._frmMG17LoopParams_3.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me._frmMG17LoopParams_3.Visible = True
		Me._frmMG17LoopParams_3.Padding = New System.Windows.Forms.Padding(0)
		Me._frmMG17LoopParams_3.Name = "_frmMG17LoopParams_3"
		Me._tbMG17LoopParams_3.AutoSize = False
		Me._tbMG17LoopParams_3.TextAlign = System.Windows.Forms.HorizontalAlignment.Right
		Me._tbMG17LoopParams_3.Enabled = False
		Me._tbMG17LoopParams_3.Size = New System.Drawing.Size(49, 19)
		Me._tbMG17LoopParams_3.Location = New System.Drawing.Point(8, 16)
		Me._tbMG17LoopParams_3.MultiLine = True
		Me._tbMG17LoopParams_3.TabIndex = 14
		Me._tbMG17LoopParams_3.Text = "0"
		Me._tbMG17LoopParams_3.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me._tbMG17LoopParams_3.AcceptsReturn = True
		Me._tbMG17LoopParams_3.BackColor = System.Drawing.SystemColors.Window
		Me._tbMG17LoopParams_3.CausesValidation = True
		Me._tbMG17LoopParams_3.ForeColor = System.Drawing.SystemColors.WindowText
		Me._tbMG17LoopParams_3.HideSelection = True
		Me._tbMG17LoopParams_3.ReadOnly = False
		Me._tbMG17LoopParams_3.Maxlength = 0
		Me._tbMG17LoopParams_3.Cursor = System.Windows.Forms.Cursors.IBeam
		Me._tbMG17LoopParams_3.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me._tbMG17LoopParams_3.ScrollBars = System.Windows.Forms.ScrollBars.None
		Me._tbMG17LoopParams_3.TabStop = True
		Me._tbMG17LoopParams_3.Visible = True
		Me._tbMG17LoopParams_3.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
		Me._tbMG17LoopParams_3.Name = "_tbMG17LoopParams_3"
		Me.cmdStoreZero.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
		Me.cmdStoreZero.Text = "StoreOffset"
		Me.cmdStoreZero.Size = New System.Drawing.Size(81, 17)
		Me.cmdStoreZero.Location = New System.Drawing.Point(96, 28)
		Me.cmdStoreZero.TabIndex = 12
		Me.cmdStoreZero.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.cmdStoreZero.BackColor = System.Drawing.SystemColors.Control
		Me.cmdStoreZero.CausesValidation = True
		Me.cmdStoreZero.Enabled = True
		Me.cmdStoreZero.ForeColor = System.Drawing.SystemColors.ControlText
		Me.cmdStoreZero.Cursor = System.Windows.Forms.Cursors.Default
		Me.cmdStoreZero.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.cmdStoreZero.TabStop = True
		Me.cmdStoreZero.Name = "cmdStoreZero"
		Me._frmMG17LoopParams_2.Text = "Step"
		Me._frmMG17LoopParams_2.Size = New System.Drawing.Size(65, 41)
		Me._frmMG17LoopParams_2.Location = New System.Drawing.Point(264, 48)
		Me._frmMG17LoopParams_2.TabIndex = 9
		Me._frmMG17LoopParams_2.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me._frmMG17LoopParams_2.BackColor = System.Drawing.SystemColors.Control
		Me._frmMG17LoopParams_2.Enabled = True
		Me._frmMG17LoopParams_2.ForeColor = System.Drawing.SystemColors.ControlText
		Me._frmMG17LoopParams_2.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me._frmMG17LoopParams_2.Visible = True
		Me._frmMG17LoopParams_2.Padding = New System.Windows.Forms.Padding(0)
		Me._frmMG17LoopParams_2.Name = "_frmMG17LoopParams_2"
		Me._tbMG17LoopParams_2.AutoSize = False
		Me._tbMG17LoopParams_2.TextAlign = System.Windows.Forms.HorizontalAlignment.Right
		Me._tbMG17LoopParams_2.Size = New System.Drawing.Size(49, 19)
		Me._tbMG17LoopParams_2.Location = New System.Drawing.Point(8, 16)
		Me._tbMG17LoopParams_2.MultiLine = True
		Me._tbMG17LoopParams_2.TabIndex = 10
		Me._tbMG17LoopParams_2.Text = "10"
		Me._tbMG17LoopParams_2.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me._tbMG17LoopParams_2.AcceptsReturn = True
		Me._tbMG17LoopParams_2.BackColor = System.Drawing.SystemColors.Window
		Me._tbMG17LoopParams_2.CausesValidation = True
		Me._tbMG17LoopParams_2.Enabled = True
		Me._tbMG17LoopParams_2.ForeColor = System.Drawing.SystemColors.WindowText
		Me._tbMG17LoopParams_2.HideSelection = True
		Me._tbMG17LoopParams_2.ReadOnly = False
		Me._tbMG17LoopParams_2.Maxlength = 0
		Me._tbMG17LoopParams_2.Cursor = System.Windows.Forms.Cursors.IBeam
		Me._tbMG17LoopParams_2.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me._tbMG17LoopParams_2.ScrollBars = System.Windows.Forms.ScrollBars.None
		Me._tbMG17LoopParams_2.TabStop = True
		Me._tbMG17LoopParams_2.Visible = True
		Me._tbMG17LoopParams_2.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
		Me._tbMG17LoopParams_2.Name = "_tbMG17LoopParams_2"
		Me._frmMG17LoopParams_1.Text = "Stop"
		Me._frmMG17LoopParams_1.Size = New System.Drawing.Size(65, 41)
		Me._frmMG17LoopParams_1.Location = New System.Drawing.Point(200, 48)
		Me._frmMG17LoopParams_1.TabIndex = 7
		Me._frmMG17LoopParams_1.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me._frmMG17LoopParams_1.BackColor = System.Drawing.SystemColors.Control
		Me._frmMG17LoopParams_1.Enabled = True
		Me._frmMG17LoopParams_1.ForeColor = System.Drawing.SystemColors.ControlText
		Me._frmMG17LoopParams_1.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me._frmMG17LoopParams_1.Visible = True
		Me._frmMG17LoopParams_1.Padding = New System.Windows.Forms.Padding(0)
		Me._frmMG17LoopParams_1.Name = "_frmMG17LoopParams_1"
		Me._tbMG17LoopParams_1.AutoSize = False
		Me._tbMG17LoopParams_1.TextAlign = System.Windows.Forms.HorizontalAlignment.Right
		Me._tbMG17LoopParams_1.Size = New System.Drawing.Size(49, 19)
		Me._tbMG17LoopParams_1.Location = New System.Drawing.Point(8, 16)
		Me._tbMG17LoopParams_1.MultiLine = True
		Me._tbMG17LoopParams_1.TabIndex = 8
		Me._tbMG17LoopParams_1.Text = "30"
		Me._tbMG17LoopParams_1.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me._tbMG17LoopParams_1.AcceptsReturn = True
		Me._tbMG17LoopParams_1.BackColor = System.Drawing.SystemColors.Window
		Me._tbMG17LoopParams_1.CausesValidation = True
		Me._tbMG17LoopParams_1.Enabled = True
		Me._tbMG17LoopParams_1.ForeColor = System.Drawing.SystemColors.WindowText
		Me._tbMG17LoopParams_1.HideSelection = True
		Me._tbMG17LoopParams_1.ReadOnly = False
		Me._tbMG17LoopParams_1.Maxlength = 0
		Me._tbMG17LoopParams_1.Cursor = System.Windows.Forms.Cursors.IBeam
		Me._tbMG17LoopParams_1.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me._tbMG17LoopParams_1.ScrollBars = System.Windows.Forms.ScrollBars.None
		Me._tbMG17LoopParams_1.TabStop = True
		Me._tbMG17LoopParams_1.Visible = True
		Me._tbMG17LoopParams_1.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
		Me._tbMG17LoopParams_1.Name = "_tbMG17LoopParams_1"
		Me._frmMG17LoopParams_0.Text = "Start"
		Me._frmMG17LoopParams_0.Size = New System.Drawing.Size(65, 41)
		Me._frmMG17LoopParams_0.Location = New System.Drawing.Point(136, 48)
		Me._frmMG17LoopParams_0.TabIndex = 5
		Me._frmMG17LoopParams_0.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me._frmMG17LoopParams_0.BackColor = System.Drawing.SystemColors.Control
		Me._frmMG17LoopParams_0.Enabled = True
		Me._frmMG17LoopParams_0.ForeColor = System.Drawing.SystemColors.ControlText
		Me._frmMG17LoopParams_0.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me._frmMG17LoopParams_0.Visible = True
		Me._frmMG17LoopParams_0.Padding = New System.Windows.Forms.Padding(0)
		Me._frmMG17LoopParams_0.Name = "_frmMG17LoopParams_0"
		Me._tbMG17LoopParams_0.AutoSize = False
		Me._tbMG17LoopParams_0.TextAlign = System.Windows.Forms.HorizontalAlignment.Right
		Me._tbMG17LoopParams_0.Size = New System.Drawing.Size(49, 19)
		Me._tbMG17LoopParams_0.Location = New System.Drawing.Point(8, 16)
		Me._tbMG17LoopParams_0.MultiLine = True
		Me._tbMG17LoopParams_0.TabIndex = 6
		Me._tbMG17LoopParams_0.Text = "-30"
		Me._tbMG17LoopParams_0.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me._tbMG17LoopParams_0.AcceptsReturn = True
		Me._tbMG17LoopParams_0.BackColor = System.Drawing.SystemColors.Window
		Me._tbMG17LoopParams_0.CausesValidation = True
		Me._tbMG17LoopParams_0.Enabled = True
		Me._tbMG17LoopParams_0.ForeColor = System.Drawing.SystemColors.WindowText
		Me._tbMG17LoopParams_0.HideSelection = True
		Me._tbMG17LoopParams_0.ReadOnly = False
		Me._tbMG17LoopParams_0.Maxlength = 0
		Me._tbMG17LoopParams_0.Cursor = System.Windows.Forms.Cursors.IBeam
		Me._tbMG17LoopParams_0.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me._tbMG17LoopParams_0.ScrollBars = System.Windows.Forms.ScrollBars.None
		Me._tbMG17LoopParams_0.TabStop = True
		Me._tbMG17LoopParams_0.Visible = True
		Me._tbMG17LoopParams_0.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
		Me._tbMG17LoopParams_0.Name = "_tbMG17LoopParams_0"
		Me.Controls.Add(fmSweep)
		Me.Controls.Add(frmSerNum)
		Me.Controls.Add(MG17Motor1)
		Me.Controls.Add(frmMG17Motor)
		Me.fmSweep.Controls.Add(cmdSweep)
		Me.fmSweep.Controls.Add(cbSweepType)
		Me.fmSweep.Controls.Add(cmdCalSweep)
		Me.frmSerNum.Controls.Add(tbSerNum)
		Me.frmSerNum.Controls.Add(cmbSerNum)
		Me.frmMG17Motor.Controls.Add(cbBlocking)
		Me.frmMG17Motor.Controls.Add(cmdZeroHome)
		Me.frmMG17Motor.Controls.Add(_frmMG17LoopParams_4)
		Me.frmMG17Motor.Controls.Add(_frmMG17LoopParams_3)
		Me.frmMG17Motor.Controls.Add(cmdStoreZero)
		Me.frmMG17Motor.Controls.Add(_frmMG17LoopParams_2)
		Me.frmMG17Motor.Controls.Add(_frmMG17LoopParams_1)
		Me.frmMG17Motor.Controls.Add(_frmMG17LoopParams_0)
		Me._frmMG17LoopParams_4.Controls.Add(_tbMG17LoopParams_4)
		Me._frmMG17LoopParams_3.Controls.Add(_tbMG17LoopParams_3)
		Me._frmMG17LoopParams_2.Controls.Add(_tbMG17LoopParams_2)
		Me._frmMG17LoopParams_1.Controls.Add(_tbMG17LoopParams_1)
		Me._frmMG17LoopParams_0.Controls.Add(_tbMG17LoopParams_0)
		Me.frmMG17LoopParams.SetIndex(_frmMG17LoopParams_4, CType(4, Short))
		Me.frmMG17LoopParams.SetIndex(_frmMG17LoopParams_3, CType(3, Short))
		Me.frmMG17LoopParams.SetIndex(_frmMG17LoopParams_2, CType(2, Short))
		Me.frmMG17LoopParams.SetIndex(_frmMG17LoopParams_1, CType(1, Short))
		Me.frmMG17LoopParams.SetIndex(_frmMG17LoopParams_0, CType(0, Short))
		Me.tbMG17LoopParams.SetIndex(_tbMG17LoopParams_4, CType(4, Short))
		Me.tbMG17LoopParams.SetIndex(_tbMG17LoopParams_3, CType(3, Short))
		Me.tbMG17LoopParams.SetIndex(_tbMG17LoopParams_2, CType(2, Short))
		Me.tbMG17LoopParams.SetIndex(_tbMG17LoopParams_1, CType(1, Short))
		Me.tbMG17LoopParams.SetIndex(_tbMG17LoopParams_0, CType(0, Short))
		CType(Me.tbMG17LoopParams, System.ComponentModel.ISupportInitialize).EndInit()
		CType(Me.frmMG17LoopParams, System.ComponentModel.ISupportInitialize).EndInit()
		CType(Me.MG17Motor1, System.ComponentModel.ISupportInitialize).EndInit()
		Me.fmSweep.ResumeLayout(False)
		Me.frmSerNum.ResumeLayout(False)
		Me.frmMG17Motor.ResumeLayout(False)
		Me._frmMG17LoopParams_4.ResumeLayout(False)
		Me._frmMG17LoopParams_3.ResumeLayout(False)
		Me._frmMG17LoopParams_2.ResumeLayout(False)
		Me._frmMG17LoopParams_1.ResumeLayout(False)
		Me._frmMG17LoopParams_0.ResumeLayout(False)
		Me.ResumeLayout(False)
		Me.PerformLayout()
	End Sub
#End Region 
End Class