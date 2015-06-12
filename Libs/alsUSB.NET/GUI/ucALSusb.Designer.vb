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
        Me.components = New System.ComponentModel.Container
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
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
        Me.tmrPoll = New System.Windows.Forms.Timer(Me.components)
        Me._optAddr_0 = New System.Windows.Forms.RadioButton
        Me.cbEnable = New Microsoft.VisualBasic.Compatibility.VB6.CheckBoxArray(Me.components)
        Me.cmbIntPersist = New Microsoft.VisualBasic.Compatibility.VB6.ComboBoxArray(Me.components)
        Me.lblEnable = New Microsoft.VisualBasic.Compatibility.VB6.LabelArray(Me.components)
        Me.lblIntPersist = New Microsoft.VisualBasic.Compatibility.VB6.LabelArray(Me.components)
        Me.optAddr = New Microsoft.VisualBasic.Compatibility.VB6.RadioButtonArray(Me.components)
        Me.frmDevice.SuspendLayout()
        Me.fmBoth.SuspendLayout()
        Me.frmX11.SuspendLayout()
        Me.frmX28.SuspendLayout()
        Me.frmX38.SuspendLayout()
        Me.fmProxOffset.SuspendLayout()
        Me.fmIRcomp.SuspendLayout()
        CType(Me.cbEnable, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.cmbIntPersist, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.lblEnable, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.lblIntPersist, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.optAddr, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        '_optAddr_4
        '
        Me._optAddr_4.BackColor = System.Drawing.SystemColors.Control
        Me._optAddr_4.Cursor = System.Windows.Forms.Cursors.Default
        Me._optAddr_4.Enabled = False
        Me._optAddr_4.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._optAddr_4.ForeColor = System.Drawing.SystemColors.ControlText
        Me.optAddr.SetIndex(Me._optAddr_4, CType(4, Short))
        Me._optAddr_4.Location = New System.Drawing.Point(96, 0)
        Me._optAddr_4.Name = "_optAddr_4"
        Me._optAddr_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._optAddr_4.Size = New System.Drawing.Size(49, 17)
        Me._optAddr_4.TabIndex = 40
        Me._optAddr_4.TabStop = True
        Me._optAddr_4.Text = "72"
        Me._optAddr_4.UseVisualStyleBackColor = False
        '
        '_optAddr_3
        '
        Me._optAddr_3.BackColor = System.Drawing.SystemColors.Control
        Me._optAddr_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._optAddr_3.Enabled = False
        Me._optAddr_3.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._optAddr_3.ForeColor = System.Drawing.SystemColors.ControlText
        Me.optAddr.SetIndex(Me._optAddr_3, CType(3, Short))
        Me._optAddr_3.Location = New System.Drawing.Point(64, 0)
        Me._optAddr_3.Name = "_optAddr_3"
        Me._optAddr_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._optAddr_3.Size = New System.Drawing.Size(49, 17)
        Me._optAddr_3.TabIndex = 39
        Me._optAddr_3.TabStop = True
        Me._optAddr_3.Text = "8C"
        Me._optAddr_3.UseVisualStyleBackColor = False
        '
        '_optAddr_2
        '
        Me._optAddr_2.BackColor = System.Drawing.SystemColors.Control
        Me._optAddr_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._optAddr_2.Enabled = False
        Me._optAddr_2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._optAddr_2.ForeColor = System.Drawing.SystemColors.ControlText
        Me.optAddr.SetIndex(Me._optAddr_2, CType(2, Short))
        Me._optAddr_2.Location = New System.Drawing.Point(32, 0)
        Me._optAddr_2.Name = "_optAddr_2"
        Me._optAddr_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._optAddr_2.Size = New System.Drawing.Size(49, 17)
        Me._optAddr_2.TabIndex = 28
        Me._optAddr_2.TabStop = True
        Me._optAddr_2.Text = "8A"
        Me._optAddr_2.UseVisualStyleBackColor = False
        '
        '_optAddr_1
        '
        Me._optAddr_1.BackColor = System.Drawing.SystemColors.Control
        Me._optAddr_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._optAddr_1.Enabled = False
        Me._optAddr_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._optAddr_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.optAddr.SetIndex(Me._optAddr_1, CType(1, Short))
        Me._optAddr_1.Location = New System.Drawing.Point(0, 0)
        Me._optAddr_1.Name = "_optAddr_1"
        Me._optAddr_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._optAddr_1.Size = New System.Drawing.Size(49, 17)
        Me._optAddr_1.TabIndex = 29
        Me._optAddr_1.TabStop = True
        Me._optAddr_1.Text = "88"
        Me._optAddr_1.UseVisualStyleBackColor = False
        '
        'frmDevice
        '
        Me.frmDevice.BackColor = System.Drawing.SystemColors.Control
        Me.frmDevice.Controls.Add(Me.cmdConversionTime)
        Me.frmDevice.Controls.Add(Me.fmBoth)
        Me.frmDevice.Controls.Add(Me.frmX11)
        Me.frmDevice.Controls.Add(Me.frmX28)
        Me.frmDevice.Controls.Add(Me.frmX38)
        Me.frmDevice.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.frmDevice.ForeColor = System.Drawing.SystemColors.ControlText
        Me.frmDevice.Location = New System.Drawing.Point(0, 16)
        Me.frmDevice.Name = "frmDevice"
        Me.frmDevice.Padding = New System.Windows.Forms.Padding(0)
        Me.frmDevice.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.frmDevice.Size = New System.Drawing.Size(281, 465)
        Me.frmDevice.TabIndex = 0
        Me.frmDevice.TabStop = False
        Me.frmDevice.Text = "Device"
        '
        'cmdConversionTime
        '
        Me.cmdConversionTime.BackColor = System.Drawing.SystemColors.Control
        Me.cmdConversionTime.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmdConversionTime.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmdConversionTime.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdConversionTime.Location = New System.Drawing.Point(8, 8)
        Me.cmdConversionTime.Name = "cmdConversionTime"
        Me.cmdConversionTime.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdConversionTime.Size = New System.Drawing.Size(105, 21)
        Me.cmdConversionTime.TabIndex = 38
        Me.cmdConversionTime.Text = "Conv. = 0 ms"
        Me.cmdConversionTime.UseVisualStyleBackColor = False
        '
        'fmBoth
        '
        Me.fmBoth.BackColor = System.Drawing.SystemColors.Control
        Me.fmBoth.Controls.Add(Me.cbPoll)
        Me.fmBoth.Controls.Add(Me.optInt)
        Me.fmBoth.Controls.Add(Me.cmbDevice)
        Me.fmBoth.Controls.Add(Me._cbEnable_0)
        Me.fmBoth.Controls.Add(Me._cmbIntPersist_0)
        Me.fmBoth.Controls.Add(Me.cmbRange)
        Me.fmBoth.Controls.Add(Me.cmbInputSelect)
        Me.fmBoth.Controls.Add(Me.cmbIrdr)
        Me.fmBoth.Controls.Add(Me._lblEnable_0)
        Me.fmBoth.Controls.Add(Me._lblIntPersist_0)
        Me.fmBoth.Controls.Add(Me.lblRange)
        Me.fmBoth.Controls.Add(Me.lblInputSelect)
        Me.fmBoth.Controls.Add(Me.lblIrdr)
        Me.fmBoth.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.fmBoth.ForeColor = System.Drawing.SystemColors.ControlText
        Me.fmBoth.Location = New System.Drawing.Point(8, 24)
        Me.fmBoth.Name = "fmBoth"
        Me.fmBoth.Padding = New System.Windows.Forms.Padding(0)
        Me.fmBoth.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.fmBoth.Size = New System.Drawing.Size(105, 169)
        Me.fmBoth.TabIndex = 14
        Me.fmBoth.TabStop = False
        Me.fmBoth.Text = "Both"
        '
        'cbPoll
        '
        Me.cbPoll.Appearance = System.Windows.Forms.Appearance.Button
        Me.cbPoll.BackColor = System.Drawing.SystemColors.Control
        Me.cbPoll.Cursor = System.Windows.Forms.Cursors.Default
        Me.cbPoll.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cbPoll.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cbPoll.Location = New System.Drawing.Point(48, 8)
        Me.cbPoll.Name = "cbPoll"
        Me.cbPoll.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cbPoll.Size = New System.Drawing.Size(57, 17)
        Me.cbPoll.TabIndex = 27
        Me.cbPoll.Text = "nPoll"
        Me.cbPoll.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
        Me.cbPoll.UseVisualStyleBackColor = False
        '
        'optInt
        '
        Me.optInt.BackColor = System.Drawing.SystemColors.Control
        Me.optInt.Cursor = System.Windows.Forms.Cursors.Default
        Me.optInt.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.optInt.ForeColor = System.Drawing.SystemColors.ControlText
        Me.optInt.Location = New System.Drawing.Point(0, 8)
        Me.optInt.Name = "optInt"
        Me.optInt.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.optInt.Size = New System.Drawing.Size(33, 17)
        Me.optInt.TabIndex = 26
        Me.optInt.TabStop = True
        Me.optInt.Text = "Int"
        Me.optInt.UseVisualStyleBackColor = False
        '
        'cmbDevice
        '
        Me.cmbDevice.BackColor = System.Drawing.SystemColors.Window
        Me.cmbDevice.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmbDevice.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmbDevice.ForeColor = System.Drawing.SystemColors.WindowText
        Me.cmbDevice.Location = New System.Drawing.Point(0, 24)
        Me.cmbDevice.Name = "cmbDevice"
        Me.cmbDevice.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmbDevice.Size = New System.Drawing.Size(105, 22)
        Me.cmbDevice.TabIndex = 20
        Me.cmbDevice.Text = "Device"
        '
        '_cbEnable_0
        '
        Me._cbEnable_0.Appearance = System.Windows.Forms.Appearance.Button
        Me._cbEnable_0.BackColor = System.Drawing.SystemColors.Control
        Me._cbEnable_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._cbEnable_0.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._cbEnable_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cbEnable.SetIndex(Me._cbEnable_0, CType(0, Short))
        Me._cbEnable_0.Location = New System.Drawing.Point(40, 48)
        Me._cbEnable_0.Name = "_cbEnable_0"
        Me._cbEnable_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cbEnable_0.Size = New System.Drawing.Size(65, 17)
        Me._cbEnable_0.TabIndex = 19
        Me._cbEnable_0.Text = "Enabled"
        Me._cbEnable_0.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
        Me._cbEnable_0.UseVisualStyleBackColor = False
        '
        '_cmbIntPersist_0
        '
        Me._cmbIntPersist_0.BackColor = System.Drawing.SystemColors.Window
        Me._cmbIntPersist_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._cmbIntPersist_0.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._cmbIntPersist_0.ForeColor = System.Drawing.SystemColors.WindowText
        Me.cmbIntPersist.SetIndex(Me._cmbIntPersist_0, CType(0, Short))
        Me._cmbIntPersist_0.Location = New System.Drawing.Point(56, 72)
        Me._cmbIntPersist_0.Name = "_cmbIntPersist_0"
        Me._cmbIntPersist_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmbIntPersist_0.Size = New System.Drawing.Size(49, 22)
        Me._cmbIntPersist_0.TabIndex = 18
        Me._cmbIntPersist_0.Text = "IntPersist"
        '
        'cmbRange
        '
        Me.cmbRange.BackColor = System.Drawing.SystemColors.Window
        Me.cmbRange.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmbRange.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmbRange.ForeColor = System.Drawing.SystemColors.WindowText
        Me.cmbRange.Location = New System.Drawing.Point(40, 96)
        Me.cmbRange.Name = "cmbRange"
        Me.cmbRange.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmbRange.Size = New System.Drawing.Size(65, 22)
        Me.cmbRange.TabIndex = 17
        Me.cmbRange.Text = "Range"
        '
        'cmbInputSelect
        '
        Me.cmbInputSelect.BackColor = System.Drawing.SystemColors.Window
        Me.cmbInputSelect.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmbInputSelect.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmbInputSelect.ForeColor = System.Drawing.SystemColors.WindowText
        Me.cmbInputSelect.Location = New System.Drawing.Point(32, 120)
        Me.cmbInputSelect.Name = "cmbInputSelect"
        Me.cmbInputSelect.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmbInputSelect.Size = New System.Drawing.Size(73, 22)
        Me.cmbInputSelect.TabIndex = 16
        Me.cmbInputSelect.Text = "InputSelect"
        '
        'cmbIrdr
        '
        Me.cmbIrdr.BackColor = System.Drawing.SystemColors.Window
        Me.cmbIrdr.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmbIrdr.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmbIrdr.ForeColor = System.Drawing.SystemColors.WindowText
        Me.cmbIrdr.Location = New System.Drawing.Point(24, 144)
        Me.cmbIrdr.Name = "cmbIrdr"
        Me.cmbIrdr.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmbIrdr.Size = New System.Drawing.Size(81, 22)
        Me.cmbIrdr.TabIndex = 15
        Me.cmbIrdr.Text = "Irdr"
        '
        '_lblEnable_0
        '
        Me._lblEnable_0.BackColor = System.Drawing.SystemColors.Control
        Me._lblEnable_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEnable_0.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._lblEnable_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me.lblEnable.SetIndex(Me._lblEnable_0, CType(0, Short))
        Me._lblEnable_0.Location = New System.Drawing.Point(0, 48)
        Me._lblEnable_0.Name = "_lblEnable_0"
        Me._lblEnable_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEnable_0.Size = New System.Drawing.Size(65, 17)
        Me._lblEnable_0.TabIndex = 25
        Me._lblEnable_0.Text = "Chan0:"
        '
        '_lblIntPersist_0
        '
        Me._lblIntPersist_0.BackColor = System.Drawing.SystemColors.Control
        Me._lblIntPersist_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblIntPersist_0.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._lblIntPersist_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me.lblIntPersist.SetIndex(Me._lblIntPersist_0, CType(0, Short))
        Me._lblIntPersist_0.Location = New System.Drawing.Point(0, 72)
        Me._lblIntPersist_0.Name = "_lblIntPersist_0"
        Me._lblIntPersist_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblIntPersist_0.Size = New System.Drawing.Size(57, 17)
        Me._lblIntPersist_0.TabIndex = 24
        Me._lblIntPersist_0.Text = "IntPersist0:"
        '
        'lblRange
        '
        Me.lblRange.BackColor = System.Drawing.SystemColors.Control
        Me.lblRange.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblRange.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblRange.ForeColor = System.Drawing.SystemColors.ControlText
        Me.lblRange.Location = New System.Drawing.Point(0, 96)
        Me.lblRange.Name = "lblRange"
        Me.lblRange.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblRange.Size = New System.Drawing.Size(41, 17)
        Me.lblRange.TabIndex = 23
        Me.lblRange.Text = "Range:"
        '
        'lblInputSelect
        '
        Me.lblInputSelect.BackColor = System.Drawing.SystemColors.Control
        Me.lblInputSelect.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblInputSelect.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblInputSelect.ForeColor = System.Drawing.SystemColors.ControlText
        Me.lblInputSelect.Location = New System.Drawing.Point(0, 120)
        Me.lblInputSelect.Name = "lblInputSelect"
        Me.lblInputSelect.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblInputSelect.Size = New System.Drawing.Size(33, 17)
        Me.lblInputSelect.TabIndex = 22
        Me.lblInputSelect.Text = "Input:"
        '
        'lblIrdr
        '
        Me.lblIrdr.BackColor = System.Drawing.SystemColors.Control
        Me.lblIrdr.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblIrdr.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblIrdr.ForeColor = System.Drawing.SystemColors.ControlText
        Me.lblIrdr.Location = New System.Drawing.Point(0, 144)
        Me.lblIrdr.Name = "lblIrdr"
        Me.lblIrdr.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblIrdr.Size = New System.Drawing.Size(25, 17)
        Me.lblIrdr.TabIndex = 21
        Me.lblIrdr.Text = "Irdr:"
        '
        'frmX11
        '
        Me.frmX11.BackColor = System.Drawing.SystemColors.Control
        Me.frmX11.Controls.Add(Me.cmbResolution)
        Me.frmX11.Controls.Add(Me.cbProxAmbRej)
        Me.frmX11.Controls.Add(Me.cbIrdrFreq)
        Me.frmX11.Controls.Add(Me.lblResolution)
        Me.frmX11.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.frmX11.ForeColor = System.Drawing.SystemColors.ControlText
        Me.frmX11.Location = New System.Drawing.Point(120, 32)
        Me.frmX11.Name = "frmX11"
        Me.frmX11.Padding = New System.Windows.Forms.Padding(0)
        Me.frmX11.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.frmX11.Size = New System.Drawing.Size(121, 105)
        Me.frmX11.TabIndex = 1
        Me.frmX11.TabStop = False
        Me.frmX11.Text = "x11"
        Me.frmX11.Visible = False
        '
        'cmbResolution
        '
        Me.cmbResolution.BackColor = System.Drawing.SystemColors.Window
        Me.cmbResolution.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmbResolution.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmbResolution.ForeColor = System.Drawing.SystemColors.WindowText
        Me.cmbResolution.Location = New System.Drawing.Point(32, 8)
        Me.cmbResolution.Name = "cmbResolution"
        Me.cmbResolution.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmbResolution.Size = New System.Drawing.Size(81, 22)
        Me.cmbResolution.TabIndex = 13
        Me.cmbResolution.Text = "Resolution"
        '
        'cbProxAmbRej
        '
        Me.cbProxAmbRej.Appearance = System.Windows.Forms.Appearance.Button
        Me.cbProxAmbRej.BackColor = System.Drawing.SystemColors.Control
        Me.cbProxAmbRej.Cursor = System.Windows.Forms.Cursors.Default
        Me.cbProxAmbRej.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cbProxAmbRej.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cbProxAmbRej.Location = New System.Drawing.Point(8, 48)
        Me.cbProxAmbRej.Name = "cbProxAmbRej"
        Me.cbProxAmbRej.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cbProxAmbRej.Size = New System.Drawing.Size(105, 17)
        Me.cbProxAmbRej.TabIndex = 11
        Me.cbProxAmbRej.Text = "AmbRej: ON"
        Me.cbProxAmbRej.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
        Me.cbProxAmbRej.UseVisualStyleBackColor = False
        '
        'cbIrdrFreq
        '
        Me.cbIrdrFreq.Appearance = System.Windows.Forms.Appearance.Button
        Me.cbIrdrFreq.BackColor = System.Drawing.SystemColors.Control
        Me.cbIrdrFreq.Cursor = System.Windows.Forms.Cursors.Default
        Me.cbIrdrFreq.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cbIrdrFreq.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cbIrdrFreq.Location = New System.Drawing.Point(8, 32)
        Me.cbIrdrFreq.Name = "cbIrdrFreq"
        Me.cbIrdrFreq.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cbIrdrFreq.Size = New System.Drawing.Size(105, 17)
        Me.cbIrdrFreq.TabIndex = 10
        Me.cbIrdrFreq.Text = "Freq: DC"
        Me.cbIrdrFreq.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
        Me.cbIrdrFreq.UseVisualStyleBackColor = False
        '
        'lblResolution
        '
        Me.lblResolution.BackColor = System.Drawing.SystemColors.Control
        Me.lblResolution.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblResolution.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblResolution.ForeColor = System.Drawing.SystemColors.ControlText
        Me.lblResolution.Location = New System.Drawing.Point(8, 8)
        Me.lblResolution.Name = "lblResolution"
        Me.lblResolution.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblResolution.Size = New System.Drawing.Size(33, 17)
        Me.lblResolution.TabIndex = 12
        Me.lblResolution.Text = "Res:"
        '
        'frmX28
        '
        Me.frmX28.BackColor = System.Drawing.SystemColors.Control
        Me.frmX28.Controls.Add(Me.cmbSleep)
        Me.frmX28.Controls.Add(Me.cbIntLogic)
        Me.frmX28.Controls.Add(Me._cmbIntPersist_1)
        Me.frmX28.Controls.Add(Me._cbEnable_1)
        Me.frmX28.Controls.Add(Me.lblSleep)
        Me.frmX28.Controls.Add(Me._lblIntPersist_1)
        Me.frmX28.Controls.Add(Me._lblEnable_1)
        Me.frmX28.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.frmX28.ForeColor = System.Drawing.SystemColors.ControlText
        Me.frmX28.Location = New System.Drawing.Point(8, 200)
        Me.frmX28.Name = "frmX28"
        Me.frmX28.Padding = New System.Windows.Forms.Padding(0)
        Me.frmX28.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.frmX28.Size = New System.Drawing.Size(121, 113)
        Me.frmX28.TabIndex = 2
        Me.frmX28.TabStop = False
        Me.frmX28.Text = "x28"
        Me.frmX28.Visible = False
        '
        'cmbSleep
        '
        Me.cmbSleep.BackColor = System.Drawing.SystemColors.Window
        Me.cmbSleep.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmbSleep.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmbSleep.ForeColor = System.Drawing.SystemColors.WindowText
        Me.cmbSleep.Location = New System.Drawing.Point(40, 88)
        Me.cmbSleep.Name = "cmbSleep"
        Me.cmbSleep.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmbSleep.Size = New System.Drawing.Size(73, 22)
        Me.cmbSleep.TabIndex = 8
        Me.cmbSleep.Text = "800"
        '
        'cbIntLogic
        '
        Me.cbIntLogic.Appearance = System.Windows.Forms.Appearance.Button
        Me.cbIntLogic.BackColor = System.Drawing.SystemColors.Control
        Me.cbIntLogic.Cursor = System.Windows.Forms.Cursors.Default
        Me.cbIntLogic.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cbIntLogic.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cbIntLogic.Location = New System.Drawing.Point(8, 64)
        Me.cbIntLogic.Name = "cbIntLogic"
        Me.cbIntLogic.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cbIntLogic.Size = New System.Drawing.Size(105, 17)
        Me.cbIntLogic.TabIndex = 7
        Me.cbIntLogic.Text = "IntLogic: OR"
        Me.cbIntLogic.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
        Me.cbIntLogic.UseVisualStyleBackColor = False
        '
        '_cmbIntPersist_1
        '
        Me._cmbIntPersist_1.BackColor = System.Drawing.SystemColors.Window
        Me._cmbIntPersist_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._cmbIntPersist_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._cmbIntPersist_1.ForeColor = System.Drawing.SystemColors.WindowText
        Me.cmbIntPersist.SetIndex(Me._cmbIntPersist_1, CType(1, Short))
        Me._cmbIntPersist_1.Location = New System.Drawing.Point(64, 40)
        Me._cmbIntPersist_1.Name = "_cmbIntPersist_1"
        Me._cmbIntPersist_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmbIntPersist_1.Size = New System.Drawing.Size(49, 22)
        Me._cmbIntPersist_1.TabIndex = 5
        Me._cmbIntPersist_1.Text = "IntPersist"
        '
        '_cbEnable_1
        '
        Me._cbEnable_1.Appearance = System.Windows.Forms.Appearance.Button
        Me._cbEnable_1.BackColor = System.Drawing.SystemColors.Control
        Me._cbEnable_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._cbEnable_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._cbEnable_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cbEnable.SetIndex(Me._cbEnable_1, CType(1, Short))
        Me._cbEnable_1.Location = New System.Drawing.Point(48, 16)
        Me._cbEnable_1.Name = "_cbEnable_1"
        Me._cbEnable_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cbEnable_1.Size = New System.Drawing.Size(65, 17)
        Me._cbEnable_1.TabIndex = 4
        Me._cbEnable_1.Text = "Enabled"
        Me._cbEnable_1.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
        Me._cbEnable_1.UseVisualStyleBackColor = False
        '
        'lblSleep
        '
        Me.lblSleep.BackColor = System.Drawing.SystemColors.Control
        Me.lblSleep.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblSleep.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblSleep.ForeColor = System.Drawing.SystemColors.ControlText
        Me.lblSleep.Location = New System.Drawing.Point(8, 88)
        Me.lblSleep.Name = "lblSleep"
        Me.lblSleep.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblSleep.Size = New System.Drawing.Size(33, 17)
        Me.lblSleep.TabIndex = 9
        Me.lblSleep.Text = "Sleep:"
        '
        '_lblIntPersist_1
        '
        Me._lblIntPersist_1.BackColor = System.Drawing.SystemColors.Control
        Me._lblIntPersist_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblIntPersist_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._lblIntPersist_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.lblIntPersist.SetIndex(Me._lblIntPersist_1, CType(1, Short))
        Me._lblIntPersist_1.Location = New System.Drawing.Point(8, 40)
        Me._lblIntPersist_1.Name = "_lblIntPersist_1"
        Me._lblIntPersist_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblIntPersist_1.Size = New System.Drawing.Size(57, 17)
        Me._lblIntPersist_1.TabIndex = 6
        Me._lblIntPersist_1.Text = "IntPersist1:"
        '
        '_lblEnable_1
        '
        Me._lblEnable_1.BackColor = System.Drawing.SystemColors.Control
        Me._lblEnable_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEnable_1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._lblEnable_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.lblEnable.SetIndex(Me._lblEnable_1, CType(1, Short))
        Me._lblEnable_1.Location = New System.Drawing.Point(8, 16)
        Me._lblEnable_1.Name = "_lblEnable_1"
        Me._lblEnable_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEnable_1.Size = New System.Drawing.Size(33, 17)
        Me._lblEnable_1.TabIndex = 3
        Me._lblEnable_1.Text = "Chan1:"
        '
        'frmX38
        '
        Me.frmX38.BackColor = System.Drawing.SystemColors.Control
        Me.frmX38.Controls.Add(Me.fmProxOffset)
        Me.frmX38.Controls.Add(Me.fmIRcomp)
        Me.frmX38.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.frmX38.ForeColor = System.Drawing.SystemColors.ControlText
        Me.frmX38.Location = New System.Drawing.Point(8, 304)
        Me.frmX38.Name = "frmX38"
        Me.frmX38.Padding = New System.Windows.Forms.Padding(0)
        Me.frmX38.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.frmX38.Size = New System.Drawing.Size(121, 97)
        Me.frmX38.TabIndex = 31
        Me.frmX38.TabStop = False
        Me.frmX38.Text = "Frame1"
        Me.frmX38.Visible = False
        '
        'fmProxOffset
        '
        Me.fmProxOffset.BackColor = System.Drawing.SystemColors.Control
        Me.fmProxOffset.Controls.Add(Me.hscrProxOffset)
        Me.fmProxOffset.Controls.Add(Me.lblProxOffset)
        Me.fmProxOffset.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.fmProxOffset.ForeColor = System.Drawing.SystemColors.ControlText
        Me.fmProxOffset.Location = New System.Drawing.Point(8, 8)
        Me.fmProxOffset.Name = "fmProxOffset"
        Me.fmProxOffset.Padding = New System.Windows.Forms.Padding(0)
        Me.fmProxOffset.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.fmProxOffset.Size = New System.Drawing.Size(105, 41)
        Me.fmProxOffset.TabIndex = 32
        Me.fmProxOffset.TabStop = False
        Me.fmProxOffset.Text = "Prox Offset"
        '
        'hscrProxOffset
        '
        Me.hscrProxOffset.Cursor = System.Windows.Forms.Cursors.Default
        Me.hscrProxOffset.LargeChange = 1
        Me.hscrProxOffset.Location = New System.Drawing.Point(8, 16)
        Me.hscrProxOffset.Maximum = 15
        Me.hscrProxOffset.Name = "hscrProxOffset"
        Me.hscrProxOffset.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.hscrProxOffset.Size = New System.Drawing.Size(57, 17)
        Me.hscrProxOffset.TabIndex = 33
        Me.hscrProxOffset.TabStop = True
        '
        'lblProxOffset
        '
        Me.lblProxOffset.BackColor = System.Drawing.SystemColors.Control
        Me.lblProxOffset.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblProxOffset.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblProxOffset.ForeColor = System.Drawing.SystemColors.ControlText
        Me.lblProxOffset.Location = New System.Drawing.Point(80, 16)
        Me.lblProxOffset.Name = "lblProxOffset"
        Me.lblProxOffset.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblProxOffset.Size = New System.Drawing.Size(17, 17)
        Me.lblProxOffset.TabIndex = 34
        Me.lblProxOffset.Text = "0"
        '
        'fmIRcomp
        '
        Me.fmIRcomp.BackColor = System.Drawing.SystemColors.Control
        Me.fmIRcomp.Controls.Add(Me.hscrIRcomp)
        Me.fmIRcomp.Controls.Add(Me.lblIRcomp)
        Me.fmIRcomp.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.fmIRcomp.ForeColor = System.Drawing.SystemColors.ControlText
        Me.fmIRcomp.Location = New System.Drawing.Point(8, 48)
        Me.fmIRcomp.Name = "fmIRcomp"
        Me.fmIRcomp.Padding = New System.Windows.Forms.Padding(0)
        Me.fmIRcomp.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.fmIRcomp.Size = New System.Drawing.Size(105, 41)
        Me.fmIRcomp.TabIndex = 35
        Me.fmIRcomp.TabStop = False
        Me.fmIRcomp.Text = "IR Comp"
        '
        'hscrIRcomp
        '
        Me.hscrIRcomp.Cursor = System.Windows.Forms.Cursors.Default
        Me.hscrIRcomp.LargeChange = 1
        Me.hscrIRcomp.Location = New System.Drawing.Point(8, 16)
        Me.hscrIRcomp.Maximum = 31
        Me.hscrIRcomp.Name = "hscrIRcomp"
        Me.hscrIRcomp.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.hscrIRcomp.Size = New System.Drawing.Size(57, 17)
        Me.hscrIRcomp.TabIndex = 36
        Me.hscrIRcomp.TabStop = True
        '
        'lblIRcomp
        '
        Me.lblIRcomp.BackColor = System.Drawing.SystemColors.Control
        Me.lblIRcomp.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblIRcomp.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblIRcomp.ForeColor = System.Drawing.SystemColors.ControlText
        Me.lblIRcomp.Location = New System.Drawing.Point(80, 16)
        Me.lblIRcomp.Name = "lblIRcomp"
        Me.lblIRcomp.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblIRcomp.Size = New System.Drawing.Size(17, 17)
        Me.lblIRcomp.TabIndex = 37
        Me.lblIRcomp.Text = "0"
        '
        'tmrPoll
        '
        '
        '_optAddr_0
        '
        Me._optAddr_0.BackColor = System.Drawing.SystemColors.Control
        Me._optAddr_0.Checked = True
        Me._optAddr_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._optAddr_0.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._optAddr_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me.optAddr.SetIndex(Me._optAddr_0, CType(0, Short))
        Me._optAddr_0.Location = New System.Drawing.Point(64, 24)
        Me._optAddr_0.Name = "_optAddr_0"
        Me._optAddr_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._optAddr_0.Size = New System.Drawing.Size(49, 17)
        Me._optAddr_0.TabIndex = 30
        Me._optAddr_0.TabStop = True
        Me._optAddr_0.Text = "None"
        Me._optAddr_0.UseVisualStyleBackColor = False
        '
        'cbEnable
        '
        '
        'cmbIntPersist
        '
        '
        'optAddr
        '
        '
        'ucALSusb
        '
        Me.Controls.Add(Me._optAddr_4)
        Me.Controls.Add(Me._optAddr_3)
        Me.Controls.Add(Me._optAddr_2)
        Me.Controls.Add(Me._optAddr_1)
        Me.Controls.Add(Me.frmDevice)
        Me.Controls.Add(Me._optAddr_0)
        Me.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Name = "ucALSusb"
        Me.Size = New System.Drawing.Size(291, 527)
        Me.frmDevice.ResumeLayout(False)
        Me.fmBoth.ResumeLayout(False)
        Me.frmX11.ResumeLayout(False)
        Me.frmX28.ResumeLayout(False)
        Me.frmX38.ResumeLayout(False)
        Me.fmProxOffset.ResumeLayout(False)
        Me.fmIRcomp.ResumeLayout(False)
        CType(Me.cbEnable, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.cmbIntPersist, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.lblEnable, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.lblIntPersist, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.optAddr, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)

    End Sub
#End Region 
End Class