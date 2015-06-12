<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> Partial Class frmEEprom
#Region "Windows Form Designer generated code "
	<System.Diagnostics.DebuggerNonUserCode()> Public Sub New()
		MyBase.New()
		'This call is required by the Windows Form Designer.
		InitializeComponent()
	End Sub
	'Form overrides dispose to clean up the component list.
	<System.Diagnostics.DebuggerNonUserCode()> Protected Overloads Overrides Sub Dispose(ByVal Disposing As Boolean)
		If Disposing Then
			Static fTerminateCalled As Boolean
			If Not fTerminateCalled Then
				Form_Terminate_renamed()
				fTerminateCalled = True
			End If
			If Not components Is Nothing Then
				components.Dispose()
			End If
		End If
		MyBase.Dispose(Disposing)
	End Sub
	'Required by the Windows Form Designer
	Private components As System.ComponentModel.IContainer
	Public ToolTip1 As System.Windows.Forms.ToolTip
	Public WithEvents _txtEEprom_6 As System.Windows.Forms.TextBox
	Public WithEvents _txtEEprom_5 As System.Windows.Forms.TextBox
	Public WithEvents _txtEEprom_4 As System.Windows.Forms.TextBox
	Public WithEvents _txtEEprom_3 As System.Windows.Forms.TextBox
	Public WithEvents _txtEEprom_2 As System.Windows.Forms.TextBox
	Public WithEvents cbByteAddr As System.Windows.Forms.CheckBox
	Public WithEvents _cmdEEpromIO_4 As System.Windows.Forms.Button
	Public WithEvents cmbAddr As System.Windows.Forms.ComboBox
	Public WithEvents _cmdEEpromIO_3 As System.Windows.Forms.Button
	Public WithEvents frmHdw As System.Windows.Forms.GroupBox
	Public WithEvents _cmdEEpromIO_5 As System.Windows.Forms.Button
	Public WithEvents tbFile As System.Windows.Forms.TextBox
	Public WithEvents File1 As Microsoft.VisualBasic.Compatibility.VB6.FileListBox
	Public WithEvents Dir1 As Microsoft.VisualBasic.Compatibility.VB6.DirListBox
	Public WithEvents Drive1 As Microsoft.VisualBasic.Compatibility.VB6.DriveListBox
	Public WithEvents _cmdEEpromIO_2 As System.Windows.Forms.Button
	Public WithEvents _cmdEEpromIO_1 As System.Windows.Forms.Button
	Public WithEvents lblDirectory As System.Windows.Forms.Label
	Public WithEvents frmFile As System.Windows.Forms.GroupBox
	Public WithEvents _cmdEEpromIO_0 As System.Windows.Forms.Button
	Public WithEvents _txtEEprom_1 As System.Windows.Forms.TextBox
	Public WithEvents _txtEEprom_0 As System.Windows.Forms.TextBox
	Public WithEvents cmdFuse2Reg As System.Windows.Forms.Button
	Public WithEvents cbFuseReg As System.Windows.Forms.CheckBox
	Public WithEvents cmbRB As System.Windows.Forms.ComboBox
	Public WithEvents Frame2 As System.Windows.Forms.GroupBox
	Public WithEvents cmbAll As System.Windows.Forms.ComboBox
	Public WithEvents Frame1 As System.Windows.Forms.GroupBox
	Public WithEvents frmEMUdebug As System.Windows.Forms.GroupBox
	Public WithEvents cmdEEpromIO As Microsoft.VisualBasic.Compatibility.VB6.ButtonArray
	Public WithEvents txtEEprom As Microsoft.VisualBasic.Compatibility.VB6.TextBoxArray
	'NOTE: The following procedure is required by the Windows Form Designer
	'It can be modified using the Windows Form Designer.
	'Do not modify it using the code editor.
	<System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
		Dim resources As System.Resources.ResourceManager = New System.Resources.ResourceManager(GetType(frmEEprom))
		Me.components = New System.ComponentModel.Container()
		Me.ToolTip1 = New System.Windows.Forms.ToolTip(components)
		Me._txtEEprom_6 = New System.Windows.Forms.TextBox
		Me._txtEEprom_5 = New System.Windows.Forms.TextBox
		Me._txtEEprom_4 = New System.Windows.Forms.TextBox
		Me._txtEEprom_3 = New System.Windows.Forms.TextBox
		Me._txtEEprom_2 = New System.Windows.Forms.TextBox
		Me.frmHdw = New System.Windows.Forms.GroupBox
		Me.cbByteAddr = New System.Windows.Forms.CheckBox
		Me._cmdEEpromIO_4 = New System.Windows.Forms.Button
		Me.cmbAddr = New System.Windows.Forms.ComboBox
		Me._cmdEEpromIO_3 = New System.Windows.Forms.Button
		Me.frmFile = New System.Windows.Forms.GroupBox
		Me._cmdEEpromIO_5 = New System.Windows.Forms.Button
		Me.tbFile = New System.Windows.Forms.TextBox
		Me.File1 = New Microsoft.VisualBasic.Compatibility.VB6.FileListBox
		Me.Dir1 = New Microsoft.VisualBasic.Compatibility.VB6.DirListBox
		Me.Drive1 = New Microsoft.VisualBasic.Compatibility.VB6.DriveListBox
		Me._cmdEEpromIO_2 = New System.Windows.Forms.Button
		Me._cmdEEpromIO_1 = New System.Windows.Forms.Button
		Me.lblDirectory = New System.Windows.Forms.Label
		Me._cmdEEpromIO_0 = New System.Windows.Forms.Button
		Me._txtEEprom_1 = New System.Windows.Forms.TextBox
		Me._txtEEprom_0 = New System.Windows.Forms.TextBox
		Me.frmEMUdebug = New System.Windows.Forms.GroupBox
		Me.cmdFuse2Reg = New System.Windows.Forms.Button
		Me.cbFuseReg = New System.Windows.Forms.CheckBox
		Me.Frame2 = New System.Windows.Forms.GroupBox
		Me.cmbRB = New System.Windows.Forms.ComboBox
		Me.Frame1 = New System.Windows.Forms.GroupBox
		Me.cmbAll = New System.Windows.Forms.ComboBox
		Me.cmdEEpromIO = New Microsoft.VisualBasic.Compatibility.VB6.ButtonArray(components)
		Me.txtEEprom = New Microsoft.VisualBasic.Compatibility.VB6.TextBoxArray(components)
		Me.frmHdw.SuspendLayout()
		Me.frmFile.SuspendLayout()
		Me.frmEMUdebug.SuspendLayout()
		Me.Frame2.SuspendLayout()
		Me.Frame1.SuspendLayout()
		Me.SuspendLayout()
		Me.ToolTip1.Active = True
		CType(Me.cmdEEpromIO, System.ComponentModel.ISupportInitialize).BeginInit()
		CType(Me.txtEEprom, System.ComponentModel.ISupportInitialize).BeginInit()
		Me.StartPosition = System.Windows.Forms.FormStartPosition.Manual
		Me.Text = "EEprom"
		Me.ClientSize = New System.Drawing.Size(571, 227)
		Me.Location = New System.Drawing.Point(4, 23)
		Me.ControlBox = False
		Me.Icon = CType(resources.GetObject("frmEEprom.Icon"), System.Drawing.Icon)
		Me.ShowInTaskbar = False
		Me.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
		Me.BackColor = System.Drawing.SystemColors.Control
		Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.Sizable
		Me.Enabled = True
		Me.KeyPreview = False
		Me.MaximizeBox = True
		Me.MinimizeBox = True
		Me.Cursor = System.Windows.Forms.Cursors.Default
		Me.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.HelpButton = False
		Me.WindowState = System.Windows.Forms.FormWindowState.Normal
		Me.Name = "frmEEprom"
		Me._txtEEprom_6.AutoSize = False
		Me._txtEEprom_6.Font = New System.Drawing.Font("Courier New", 12!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me._txtEEprom_6.Size = New System.Drawing.Size(569, 22)
		Me._txtEEprom_6.Location = New System.Drawing.Point(0, 376)
		Me._txtEEprom_6.MultiLine = True
		Me._txtEEprom_6.TabIndex = 19
		Me._txtEEprom_6.Visible = False
		Me._txtEEprom_6.AcceptsReturn = True
		Me._txtEEprom_6.TextAlign = System.Windows.Forms.HorizontalAlignment.Left
		Me._txtEEprom_6.BackColor = System.Drawing.SystemColors.Window
		Me._txtEEprom_6.CausesValidation = True
		Me._txtEEprom_6.Enabled = True
		Me._txtEEprom_6.ForeColor = System.Drawing.SystemColors.WindowText
		Me._txtEEprom_6.HideSelection = True
		Me._txtEEprom_6.ReadOnly = False
		Me._txtEEprom_6.Maxlength = 0
		Me._txtEEprom_6.Cursor = System.Windows.Forms.Cursors.IBeam
		Me._txtEEprom_6.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me._txtEEprom_6.ScrollBars = System.Windows.Forms.ScrollBars.None
		Me._txtEEprom_6.TabStop = True
		Me._txtEEprom_6.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
		Me._txtEEprom_6.Name = "_txtEEprom_6"
		Me._txtEEprom_5.AutoSize = False
		Me._txtEEprom_5.Font = New System.Drawing.Font("Courier New", 12!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me._txtEEprom_5.Size = New System.Drawing.Size(569, 22)
		Me._txtEEprom_5.Location = New System.Drawing.Point(0, 352)
		Me._txtEEprom_5.MultiLine = True
		Me._txtEEprom_5.TabIndex = 18
		Me._txtEEprom_5.Visible = False
		Me._txtEEprom_5.AcceptsReturn = True
		Me._txtEEprom_5.TextAlign = System.Windows.Forms.HorizontalAlignment.Left
		Me._txtEEprom_5.BackColor = System.Drawing.SystemColors.Window
		Me._txtEEprom_5.CausesValidation = True
		Me._txtEEprom_5.Enabled = True
		Me._txtEEprom_5.ForeColor = System.Drawing.SystemColors.WindowText
		Me._txtEEprom_5.HideSelection = True
		Me._txtEEprom_5.ReadOnly = False
		Me._txtEEprom_5.Maxlength = 0
		Me._txtEEprom_5.Cursor = System.Windows.Forms.Cursors.IBeam
		Me._txtEEprom_5.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me._txtEEprom_5.ScrollBars = System.Windows.Forms.ScrollBars.None
		Me._txtEEprom_5.TabStop = True
		Me._txtEEprom_5.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
		Me._txtEEprom_5.Name = "_txtEEprom_5"
		Me._txtEEprom_4.AutoSize = False
		Me._txtEEprom_4.Font = New System.Drawing.Font("Courier New", 12!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me._txtEEprom_4.Size = New System.Drawing.Size(569, 22)
		Me._txtEEprom_4.Location = New System.Drawing.Point(0, 328)
		Me._txtEEprom_4.MultiLine = True
		Me._txtEEprom_4.TabIndex = 17
		Me._txtEEprom_4.Visible = False
		Me._txtEEprom_4.AcceptsReturn = True
		Me._txtEEprom_4.TextAlign = System.Windows.Forms.HorizontalAlignment.Left
		Me._txtEEprom_4.BackColor = System.Drawing.SystemColors.Window
		Me._txtEEprom_4.CausesValidation = True
		Me._txtEEprom_4.Enabled = True
		Me._txtEEprom_4.ForeColor = System.Drawing.SystemColors.WindowText
		Me._txtEEprom_4.HideSelection = True
		Me._txtEEprom_4.ReadOnly = False
		Me._txtEEprom_4.Maxlength = 0
		Me._txtEEprom_4.Cursor = System.Windows.Forms.Cursors.IBeam
		Me._txtEEprom_4.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me._txtEEprom_4.ScrollBars = System.Windows.Forms.ScrollBars.None
		Me._txtEEprom_4.TabStop = True
		Me._txtEEprom_4.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
		Me._txtEEprom_4.Name = "_txtEEprom_4"
		Me._txtEEprom_3.AutoSize = False
		Me._txtEEprom_3.Font = New System.Drawing.Font("Courier New", 12!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me._txtEEprom_3.Size = New System.Drawing.Size(569, 22)
		Me._txtEEprom_3.Location = New System.Drawing.Point(0, 304)
		Me._txtEEprom_3.MultiLine = True
		Me._txtEEprom_3.TabIndex = 16
		Me._txtEEprom_3.Visible = False
		Me._txtEEprom_3.AcceptsReturn = True
		Me._txtEEprom_3.TextAlign = System.Windows.Forms.HorizontalAlignment.Left
		Me._txtEEprom_3.BackColor = System.Drawing.SystemColors.Window
		Me._txtEEprom_3.CausesValidation = True
		Me._txtEEprom_3.Enabled = True
		Me._txtEEprom_3.ForeColor = System.Drawing.SystemColors.WindowText
		Me._txtEEprom_3.HideSelection = True
		Me._txtEEprom_3.ReadOnly = False
		Me._txtEEprom_3.Maxlength = 0
		Me._txtEEprom_3.Cursor = System.Windows.Forms.Cursors.IBeam
		Me._txtEEprom_3.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me._txtEEprom_3.ScrollBars = System.Windows.Forms.ScrollBars.None
		Me._txtEEprom_3.TabStop = True
		Me._txtEEprom_3.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
		Me._txtEEprom_3.Name = "_txtEEprom_3"
		Me._txtEEprom_2.AutoSize = False
		Me._txtEEprom_2.Font = New System.Drawing.Font("Courier New", 12!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me._txtEEprom_2.Size = New System.Drawing.Size(569, 22)
		Me._txtEEprom_2.Location = New System.Drawing.Point(0, 280)
		Me._txtEEprom_2.MultiLine = True
		Me._txtEEprom_2.TabIndex = 10
		Me._txtEEprom_2.Visible = False
		Me._txtEEprom_2.AcceptsReturn = True
		Me._txtEEprom_2.TextAlign = System.Windows.Forms.HorizontalAlignment.Left
		Me._txtEEprom_2.BackColor = System.Drawing.SystemColors.Window
		Me._txtEEprom_2.CausesValidation = True
		Me._txtEEprom_2.Enabled = True
		Me._txtEEprom_2.ForeColor = System.Drawing.SystemColors.WindowText
		Me._txtEEprom_2.HideSelection = True
		Me._txtEEprom_2.ReadOnly = False
		Me._txtEEprom_2.Maxlength = 0
		Me._txtEEprom_2.Cursor = System.Windows.Forms.Cursors.IBeam
		Me._txtEEprom_2.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me._txtEEprom_2.ScrollBars = System.Windows.Forms.ScrollBars.None
		Me._txtEEprom_2.TabStop = True
		Me._txtEEprom_2.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
		Me._txtEEprom_2.Name = "_txtEEprom_2"
		Me.frmHdw.Text = "Hardware:None"
		Me.frmHdw.Size = New System.Drawing.Size(161, 73)
		Me.frmHdw.Location = New System.Drawing.Point(0, 56)
		Me.frmHdw.TabIndex = 5
		Me.frmHdw.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.frmHdw.BackColor = System.Drawing.SystemColors.Control
		Me.frmHdw.Enabled = True
		Me.frmHdw.ForeColor = System.Drawing.SystemColors.ControlText
		Me.frmHdw.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.frmHdw.Visible = True
		Me.frmHdw.Padding = New System.Windows.Forms.Padding(0)
		Me.frmHdw.Name = "frmHdw"
		Me.cbByteAddr.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
		Me.cbByteAddr.Text = "Addr:Word"
		Me.cbByteAddr.Size = New System.Drawing.Size(65, 21)
		Me.cbByteAddr.Location = New System.Drawing.Point(64, 40)
		Me.cbByteAddr.Appearance = System.Windows.Forms.Appearance.Button
		Me.cbByteAddr.TabIndex = 15
		Me.cbByteAddr.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.cbByteAddr.CheckAlign = System.Drawing.ContentAlignment.MiddleLeft
		Me.cbByteAddr.FlatStyle = System.Windows.Forms.FlatStyle.Standard
		Me.cbByteAddr.BackColor = System.Drawing.SystemColors.Control
		Me.cbByteAddr.CausesValidation = True
		Me.cbByteAddr.Enabled = True
		Me.cbByteAddr.ForeColor = System.Drawing.SystemColors.ControlText
		Me.cbByteAddr.Cursor = System.Windows.Forms.Cursors.Default
		Me.cbByteAddr.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.cbByteAddr.TabStop = True
		Me.cbByteAddr.CheckState = System.Windows.Forms.CheckState.Unchecked
		Me.cbByteAddr.Visible = True
		Me.cbByteAddr.Name = "cbByteAddr"
		Me._cmdEEpromIO_4.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
		Me._cmdEEpromIO_4.Text = "Write"
		Me._cmdEEpromIO_4.Enabled = False
		Me._cmdEEpromIO_4.Size = New System.Drawing.Size(49, 21)
		Me._cmdEEpromIO_4.Location = New System.Drawing.Point(8, 40)
		Me._cmdEEpromIO_4.TabIndex = 6
		Me._cmdEEpromIO_4.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me._cmdEEpromIO_4.BackColor = System.Drawing.SystemColors.Control
		Me._cmdEEpromIO_4.CausesValidation = True
		Me._cmdEEpromIO_4.ForeColor = System.Drawing.SystemColors.ControlText
		Me._cmdEEpromIO_4.Cursor = System.Windows.Forms.Cursors.Default
		Me._cmdEEpromIO_4.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me._cmdEEpromIO_4.TabStop = True
		Me._cmdEEpromIO_4.Name = "_cmdEEpromIO_4"
		Me.cmbAddr.Size = New System.Drawing.Size(65, 21)
		Me.cmbAddr.Location = New System.Drawing.Point(64, 16)
		Me.cmbAddr.TabIndex = 8
		Me.cmbAddr.Text = "0x00"
		Me.cmbAddr.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.cmbAddr.BackColor = System.Drawing.SystemColors.Window
		Me.cmbAddr.CausesValidation = True
		Me.cmbAddr.Enabled = True
		Me.cmbAddr.ForeColor = System.Drawing.SystemColors.WindowText
		Me.cmbAddr.IntegralHeight = True
		Me.cmbAddr.Cursor = System.Windows.Forms.Cursors.Default
		Me.cmbAddr.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.cmbAddr.Sorted = False
		Me.cmbAddr.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDown
		Me.cmbAddr.TabStop = True
		Me.cmbAddr.Visible = True
		Me.cmbAddr.Name = "cmbAddr"
		Me._cmdEEpromIO_3.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
		Me._cmdEEpromIO_3.Text = "Read"
		Me._cmdEEpromIO_3.Enabled = False
		Me._cmdEEpromIO_3.Size = New System.Drawing.Size(49, 21)
		Me._cmdEEpromIO_3.Location = New System.Drawing.Point(8, 16)
		Me._cmdEEpromIO_3.TabIndex = 7
		Me._cmdEEpromIO_3.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me._cmdEEpromIO_3.BackColor = System.Drawing.SystemColors.Control
		Me._cmdEEpromIO_3.CausesValidation = True
		Me._cmdEEpromIO_3.ForeColor = System.Drawing.SystemColors.ControlText
		Me._cmdEEpromIO_3.Cursor = System.Windows.Forms.Cursors.Default
		Me._cmdEEpromIO_3.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me._cmdEEpromIO_3.TabStop = True
		Me._cmdEEpromIO_3.Name = "_cmdEEpromIO_3"
		Me.frmFile.Text = "File"
		Me.frmFile.Size = New System.Drawing.Size(401, 225)
		Me.frmFile.Location = New System.Drawing.Point(168, 0)
		Me.frmFile.TabIndex = 2
		Me.frmFile.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.frmFile.BackColor = System.Drawing.SystemColors.Control
		Me.frmFile.Enabled = True
		Me.frmFile.ForeColor = System.Drawing.SystemColors.ControlText
		Me.frmFile.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.frmFile.Visible = True
		Me.frmFile.Padding = New System.Windows.Forms.Padding(0)
		Me.frmFile.Name = "frmFile"
		Me._cmdEEpromIO_5.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
		Me._cmdEEpromIO_5.Text = "Delete"
		Me._cmdEEpromIO_5.Size = New System.Drawing.Size(49, 21)
		Me._cmdEEpromIO_5.Location = New System.Drawing.Point(64, 200)
		Me._cmdEEpromIO_5.TabIndex = 21
		Me.ToolTip1.SetToolTip(Me._cmdEEpromIO_5, "Delete Selected File")
		Me._cmdEEpromIO_5.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me._cmdEEpromIO_5.BackColor = System.Drawing.SystemColors.Control
		Me._cmdEEpromIO_5.CausesValidation = True
		Me._cmdEEpromIO_5.Enabled = True
		Me._cmdEEpromIO_5.ForeColor = System.Drawing.SystemColors.ControlText
		Me._cmdEEpromIO_5.Cursor = System.Windows.Forms.Cursors.Default
		Me._cmdEEpromIO_5.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me._cmdEEpromIO_5.TabStop = True
		Me._cmdEEpromIO_5.Name = "_cmdEEpromIO_5"
		Me.tbFile.AutoSize = False
		Me.tbFile.Size = New System.Drawing.Size(273, 19)
		Me.tbFile.Location = New System.Drawing.Point(120, 200)
		Me.tbFile.MultiLine = True
		Me.tbFile.TabIndex = 20
		Me.tbFile.Text = "default.txt"
		Me.ToolTip1.SetToolTip(Me.tbFile, "Calibration File Name")
		Me.tbFile.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.tbFile.AcceptsReturn = True
		Me.tbFile.TextAlign = System.Windows.Forms.HorizontalAlignment.Left
		Me.tbFile.BackColor = System.Drawing.SystemColors.Window
		Me.tbFile.CausesValidation = True
		Me.tbFile.Enabled = True
		Me.tbFile.ForeColor = System.Drawing.SystemColors.WindowText
		Me.tbFile.HideSelection = True
		Me.tbFile.ReadOnly = False
		Me.tbFile.Maxlength = 0
		Me.tbFile.Cursor = System.Windows.Forms.Cursors.IBeam
		Me.tbFile.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.tbFile.ScrollBars = System.Windows.Forms.ScrollBars.None
		Me.tbFile.TabStop = True
		Me.tbFile.Visible = True
		Me.tbFile.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
		Me.tbFile.Name = "tbFile"
		Me.File1.Size = New System.Drawing.Size(185, 123)
		Me.File1.Location = New System.Drawing.Point(208, 40)
		Me.File1.TabIndex = 13
		Me.File1.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.File1.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
		Me.File1.Archive = True
		Me.File1.BackColor = System.Drawing.SystemColors.Window
		Me.File1.CausesValidation = True
		Me.File1.Enabled = True
		Me.File1.ForeColor = System.Drawing.SystemColors.WindowText
		Me.File1.Hidden = False
		Me.File1.Cursor = System.Windows.Forms.Cursors.Default
		Me.File1.SelectionMode = System.Windows.Forms.SelectionMode.One
		Me.File1.Normal = True
		Me.File1.Pattern = "*.*"
		Me.File1.ReadOnly = True
		Me.File1.System = False
		Me.File1.TabStop = True
		Me.File1.TopIndex = 0
		Me.File1.Visible = True
		Me.File1.Name = "File1"
		Me.Dir1.Size = New System.Drawing.Size(193, 126)
		Me.Dir1.Location = New System.Drawing.Point(8, 40)
		Me.Dir1.TabIndex = 12
		Me.Dir1.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.Dir1.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
		Me.Dir1.BackColor = System.Drawing.SystemColors.Window
		Me.Dir1.CausesValidation = True
		Me.Dir1.Enabled = True
		Me.Dir1.ForeColor = System.Drawing.SystemColors.WindowText
		Me.Dir1.Cursor = System.Windows.Forms.Cursors.Default
		Me.Dir1.TabStop = True
		Me.Dir1.Visible = True
		Me.Dir1.Name = "Dir1"
		Me.Drive1.Size = New System.Drawing.Size(385, 21)
		Me.Drive1.Location = New System.Drawing.Point(8, 16)
		Me.Drive1.TabIndex = 11
		Me.Drive1.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.Drive1.BackColor = System.Drawing.SystemColors.Window
		Me.Drive1.CausesValidation = True
		Me.Drive1.Enabled = True
		Me.Drive1.ForeColor = System.Drawing.SystemColors.WindowText
		Me.Drive1.Cursor = System.Windows.Forms.Cursors.Default
		Me.Drive1.TabStop = True
		Me.Drive1.Visible = True
		Me.Drive1.Name = "Drive1"
		Me._cmdEEpromIO_2.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
		Me._cmdEEpromIO_2.Text = "Write"
		Me._cmdEEpromIO_2.Enabled = False
		Me._cmdEEpromIO_2.Size = New System.Drawing.Size(49, 21)
		Me._cmdEEpromIO_2.Location = New System.Drawing.Point(8, 200)
		Me._cmdEEpromIO_2.TabIndex = 4
		Me._cmdEEpromIO_2.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me._cmdEEpromIO_2.BackColor = System.Drawing.SystemColors.Control
		Me._cmdEEpromIO_2.CausesValidation = True
		Me._cmdEEpromIO_2.ForeColor = System.Drawing.SystemColors.ControlText
		Me._cmdEEpromIO_2.Cursor = System.Windows.Forms.Cursors.Default
		Me._cmdEEpromIO_2.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me._cmdEEpromIO_2.TabStop = True
		Me._cmdEEpromIO_2.Name = "_cmdEEpromIO_2"
		Me._cmdEEpromIO_1.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
		Me._cmdEEpromIO_1.Text = "Read"
		Me._cmdEEpromIO_1.Size = New System.Drawing.Size(49, 21)
		Me._cmdEEpromIO_1.Location = New System.Drawing.Point(8, 176)
		Me._cmdEEpromIO_1.TabIndex = 3
		Me._cmdEEpromIO_1.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me._cmdEEpromIO_1.BackColor = System.Drawing.SystemColors.Control
		Me._cmdEEpromIO_1.CausesValidation = True
		Me._cmdEEpromIO_1.Enabled = True
		Me._cmdEEpromIO_1.ForeColor = System.Drawing.SystemColors.ControlText
		Me._cmdEEpromIO_1.Cursor = System.Windows.Forms.Cursors.Default
		Me._cmdEEpromIO_1.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me._cmdEEpromIO_1.TabStop = True
		Me._cmdEEpromIO_1.Name = "_cmdEEpromIO_1"
		Me.lblDirectory.Text = "01234567890123456789012345678901234567890123456789012345678901234567890123456789"
		Me.lblDirectory.Size = New System.Drawing.Size(329, 13)
		Me.lblDirectory.Location = New System.Drawing.Point(64, 176)
		Me.lblDirectory.TabIndex = 14
		Me.lblDirectory.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.lblDirectory.TextAlign = System.Drawing.ContentAlignment.TopLeft
		Me.lblDirectory.BackColor = System.Drawing.SystemColors.Control
		Me.lblDirectory.Enabled = True
		Me.lblDirectory.ForeColor = System.Drawing.SystemColors.ControlText
		Me.lblDirectory.Cursor = System.Windows.Forms.Cursors.Default
		Me.lblDirectory.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.lblDirectory.UseMnemonic = True
		Me.lblDirectory.Visible = True
		Me.lblDirectory.AutoSize = False
		Me.lblDirectory.BorderStyle = System.Windows.Forms.BorderStyle.None
		Me.lblDirectory.Name = "lblDirectory"
		Me._cmdEEpromIO_0.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
		Me._cmdEEpromIO_0.Text = "New"
		Me._cmdEEpromIO_0.Size = New System.Drawing.Size(161, 41)
		Me._cmdEEpromIO_0.Location = New System.Drawing.Point(0, 8)
		Me._cmdEEpromIO_0.TabIndex = 1
		Me._cmdEEpromIO_0.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me._cmdEEpromIO_0.BackColor = System.Drawing.SystemColors.Control
		Me._cmdEEpromIO_0.CausesValidation = True
		Me._cmdEEpromIO_0.Enabled = True
		Me._cmdEEpromIO_0.ForeColor = System.Drawing.SystemColors.ControlText
		Me._cmdEEpromIO_0.Cursor = System.Windows.Forms.Cursors.Default
		Me._cmdEEpromIO_0.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me._cmdEEpromIO_0.TabStop = True
		Me._cmdEEpromIO_0.Name = "_cmdEEpromIO_0"
		Me._txtEEprom_1.AutoSize = False
		Me._txtEEprom_1.Font = New System.Drawing.Font("Courier New", 12!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me._txtEEprom_1.Size = New System.Drawing.Size(569, 22)
		Me._txtEEprom_1.Location = New System.Drawing.Point(0, 256)
		Me._txtEEprom_1.MultiLine = True
		Me._txtEEprom_1.TabIndex = 0
		Me._txtEEprom_1.Visible = False
		Me._txtEEprom_1.AcceptsReturn = True
		Me._txtEEprom_1.TextAlign = System.Windows.Forms.HorizontalAlignment.Left
		Me._txtEEprom_1.BackColor = System.Drawing.SystemColors.Window
		Me._txtEEprom_1.CausesValidation = True
		Me._txtEEprom_1.Enabled = True
		Me._txtEEprom_1.ForeColor = System.Drawing.SystemColors.WindowText
		Me._txtEEprom_1.HideSelection = True
		Me._txtEEprom_1.ReadOnly = False
		Me._txtEEprom_1.Maxlength = 0
		Me._txtEEprom_1.Cursor = System.Windows.Forms.Cursors.IBeam
		Me._txtEEprom_1.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me._txtEEprom_1.ScrollBars = System.Windows.Forms.ScrollBars.None
		Me._txtEEprom_1.TabStop = True
		Me._txtEEprom_1.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
		Me._txtEEprom_1.Name = "_txtEEprom_1"
		Me._txtEEprom_0.AutoSize = False
		Me._txtEEprom_0.Enabled = False
		Me._txtEEprom_0.Font = New System.Drawing.Font("Courier New", 12!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me._txtEEprom_0.Size = New System.Drawing.Size(569, 23)
		Me._txtEEprom_0.Location = New System.Drawing.Point(0, 232)
		Me._txtEEprom_0.MultiLine = True
		Me._txtEEprom_0.TabIndex = 9
		Me._txtEEprom_0.Visible = False
		Me._txtEEprom_0.AcceptsReturn = True
		Me._txtEEprom_0.TextAlign = System.Windows.Forms.HorizontalAlignment.Left
		Me._txtEEprom_0.BackColor = System.Drawing.SystemColors.Window
		Me._txtEEprom_0.CausesValidation = True
		Me._txtEEprom_0.ForeColor = System.Drawing.SystemColors.WindowText
		Me._txtEEprom_0.HideSelection = True
		Me._txtEEprom_0.ReadOnly = False
		Me._txtEEprom_0.Maxlength = 0
		Me._txtEEprom_0.Cursor = System.Windows.Forms.Cursors.IBeam
		Me._txtEEprom_0.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me._txtEEprom_0.ScrollBars = System.Windows.Forms.ScrollBars.None
		Me._txtEEprom_0.TabStop = True
		Me._txtEEprom_0.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
		Me._txtEEprom_0.Name = "_txtEEprom_0"
		Me.frmEMUdebug.Text = "Gain Trim(s)"
		Me.frmEMUdebug.Size = New System.Drawing.Size(161, 97)
		Me.frmEMUdebug.Location = New System.Drawing.Point(0, 128)
		Me.frmEMUdebug.TabIndex = 22
		Me.frmEMUdebug.Visible = False
		Me.frmEMUdebug.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.frmEMUdebug.BackColor = System.Drawing.SystemColors.Control
		Me.frmEMUdebug.Enabled = True
		Me.frmEMUdebug.ForeColor = System.Drawing.SystemColors.ControlText
		Me.frmEMUdebug.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.frmEMUdebug.Padding = New System.Windows.Forms.Padding(0)
		Me.frmEMUdebug.Name = "frmEMUdebug"
		Me.cmdFuse2Reg.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
		Me.cmdFuse2Reg.Text = "Fuse --> Reg"
		Me.cmdFuse2Reg.Size = New System.Drawing.Size(73, 17)
		Me.cmdFuse2Reg.Location = New System.Drawing.Point(80, 16)
		Me.cmdFuse2Reg.TabIndex = 24
		Me.cmdFuse2Reg.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.cmdFuse2Reg.BackColor = System.Drawing.SystemColors.Control
		Me.cmdFuse2Reg.CausesValidation = True
		Me.cmdFuse2Reg.Enabled = True
		Me.cmdFuse2Reg.ForeColor = System.Drawing.SystemColors.ControlText
		Me.cmdFuse2Reg.Cursor = System.Windows.Forms.Cursors.Default
		Me.cmdFuse2Reg.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.cmdFuse2Reg.TabStop = True
		Me.cmdFuse2Reg.Name = "cmdFuse2Reg"
		Me.cbFuseReg.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
		Me.cbFuseReg.Text = "Fuse"
		Me.cbFuseReg.Size = New System.Drawing.Size(73, 17)
		Me.cbFuseReg.Location = New System.Drawing.Point(8, 16)
		Me.cbFuseReg.Appearance = System.Windows.Forms.Appearance.Button
		Me.cbFuseReg.TabIndex = 23
		Me.cbFuseReg.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.cbFuseReg.CheckAlign = System.Drawing.ContentAlignment.MiddleLeft
		Me.cbFuseReg.FlatStyle = System.Windows.Forms.FlatStyle.Standard
		Me.cbFuseReg.BackColor = System.Drawing.SystemColors.Control
		Me.cbFuseReg.CausesValidation = True
		Me.cbFuseReg.Enabled = True
		Me.cbFuseReg.ForeColor = System.Drawing.SystemColors.ControlText
		Me.cbFuseReg.Cursor = System.Windows.Forms.Cursors.Default
		Me.cbFuseReg.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.cbFuseReg.TabStop = True
		Me.cbFuseReg.CheckState = System.Windows.Forms.CheckState.Unchecked
		Me.cbFuseReg.Visible = True
		Me.cbFuseReg.Name = "cbFuseReg"
		Me.Frame2.Text = "Red/Blue"
		Me.Frame2.Size = New System.Drawing.Size(73, 41)
		Me.Frame2.Location = New System.Drawing.Point(80, 32)
		Me.Frame2.TabIndex = 27
		Me.Frame2.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.Frame2.BackColor = System.Drawing.SystemColors.Control
		Me.Frame2.Enabled = True
		Me.Frame2.ForeColor = System.Drawing.SystemColors.ControlText
		Me.Frame2.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.Frame2.Visible = True
		Me.Frame2.Padding = New System.Windows.Forms.Padding(0)
		Me.Frame2.Name = "Frame2"
		Me.cmbRB.Enabled = False
		Me.cmbRB.Size = New System.Drawing.Size(49, 21)
		Me.cmbRB.Location = New System.Drawing.Point(8, 16)
		Me.cmbRB.Items.AddRange(New Object(){"0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15"})
		Me.cmbRB.TabIndex = 28
		Me.cmbRB.Text = "88"
		Me.cmbRB.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.cmbRB.BackColor = System.Drawing.SystemColors.Window
		Me.cmbRB.CausesValidation = True
		Me.cmbRB.ForeColor = System.Drawing.SystemColors.WindowText
		Me.cmbRB.IntegralHeight = True
		Me.cmbRB.Cursor = System.Windows.Forms.Cursors.Default
		Me.cmbRB.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.cmbRB.Sorted = False
		Me.cmbRB.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDown
		Me.cmbRB.TabStop = True
		Me.cmbRB.Visible = True
		Me.cmbRB.Name = "cmbRB"
		Me.Frame1.Text = "ALL"
		Me.Frame1.Size = New System.Drawing.Size(65, 41)
		Me.Frame1.Location = New System.Drawing.Point(8, 32)
		Me.Frame1.TabIndex = 25
		Me.Frame1.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.Frame1.BackColor = System.Drawing.SystemColors.Control
		Me.Frame1.Enabled = True
		Me.Frame1.ForeColor = System.Drawing.SystemColors.ControlText
		Me.Frame1.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.Frame1.Visible = True
		Me.Frame1.Padding = New System.Windows.Forms.Padding(0)
		Me.Frame1.Name = "Frame1"
		Me.cmbAll.Enabled = False
		Me.cmbAll.Size = New System.Drawing.Size(49, 21)
		Me.cmbAll.Location = New System.Drawing.Point(8, 16)
		Me.cmbAll.Items.AddRange(New Object(){"0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15"})
		Me.cmbAll.TabIndex = 26
		Me.cmbAll.Text = "88"
		Me.cmbAll.Font = New System.Drawing.Font("Arial", 8!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
		Me.cmbAll.BackColor = System.Drawing.SystemColors.Window
		Me.cmbAll.CausesValidation = True
		Me.cmbAll.ForeColor = System.Drawing.SystemColors.WindowText
		Me.cmbAll.IntegralHeight = True
		Me.cmbAll.Cursor = System.Windows.Forms.Cursors.Default
		Me.cmbAll.RightToLeft = System.Windows.Forms.RightToLeft.No
		Me.cmbAll.Sorted = False
		Me.cmbAll.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDown
		Me.cmbAll.TabStop = True
		Me.cmbAll.Visible = True
		Me.cmbAll.Name = "cmbAll"
		Me.Controls.Add(_txtEEprom_6)
		Me.Controls.Add(_txtEEprom_5)
		Me.Controls.Add(_txtEEprom_4)
		Me.Controls.Add(_txtEEprom_3)
		Me.Controls.Add(_txtEEprom_2)
		Me.Controls.Add(frmHdw)
		Me.Controls.Add(frmFile)
		Me.Controls.Add(_cmdEEpromIO_0)
		Me.Controls.Add(_txtEEprom_1)
		Me.Controls.Add(_txtEEprom_0)
		Me.Controls.Add(frmEMUdebug)
		Me.frmHdw.Controls.Add(cbByteAddr)
		Me.frmHdw.Controls.Add(_cmdEEpromIO_4)
		Me.frmHdw.Controls.Add(cmbAddr)
		Me.frmHdw.Controls.Add(_cmdEEpromIO_3)
		Me.frmFile.Controls.Add(_cmdEEpromIO_5)
		Me.frmFile.Controls.Add(tbFile)
		Me.frmFile.Controls.Add(File1)
		Me.frmFile.Controls.Add(Dir1)
		Me.frmFile.Controls.Add(Drive1)
		Me.frmFile.Controls.Add(_cmdEEpromIO_2)
		Me.frmFile.Controls.Add(_cmdEEpromIO_1)
		Me.frmFile.Controls.Add(lblDirectory)
		Me.frmEMUdebug.Controls.Add(cmdFuse2Reg)
		Me.frmEMUdebug.Controls.Add(cbFuseReg)
		Me.frmEMUdebug.Controls.Add(Frame2)
		Me.frmEMUdebug.Controls.Add(Frame1)
		Me.Frame2.Controls.Add(cmbRB)
		Me.Frame1.Controls.Add(cmbAll)
		Me.cmdEEpromIO.SetIndex(_cmdEEpromIO_4, CType(4, Short))
		Me.cmdEEpromIO.SetIndex(_cmdEEpromIO_3, CType(3, Short))
		Me.cmdEEpromIO.SetIndex(_cmdEEpromIO_5, CType(5, Short))
		Me.cmdEEpromIO.SetIndex(_cmdEEpromIO_2, CType(2, Short))
		Me.cmdEEpromIO.SetIndex(_cmdEEpromIO_1, CType(1, Short))
		Me.cmdEEpromIO.SetIndex(_cmdEEpromIO_0, CType(0, Short))
		Me.txtEEprom.SetIndex(_txtEEprom_6, CType(6, Short))
		Me.txtEEprom.SetIndex(_txtEEprom_5, CType(5, Short))
		Me.txtEEprom.SetIndex(_txtEEprom_4, CType(4, Short))
		Me.txtEEprom.SetIndex(_txtEEprom_3, CType(3, Short))
		Me.txtEEprom.SetIndex(_txtEEprom_2, CType(2, Short))
		Me.txtEEprom.SetIndex(_txtEEprom_1, CType(1, Short))
		Me.txtEEprom.SetIndex(_txtEEprom_0, CType(0, Short))
		CType(Me.txtEEprom, System.ComponentModel.ISupportInitialize).EndInit()
		CType(Me.cmdEEpromIO, System.ComponentModel.ISupportInitialize).EndInit()
		Me.frmHdw.ResumeLayout(False)
		Me.frmFile.ResumeLayout(False)
		Me.frmEMUdebug.ResumeLayout(False)
		Me.Frame2.ResumeLayout(False)
		Me.Frame1.ResumeLayout(False)
		Me.ResumeLayout(False)
		Me.PerformLayout()
	End Sub
#End Region 
End Class