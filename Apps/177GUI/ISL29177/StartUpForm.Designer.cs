namespace ISL29177
{
    partial class StartUpForm
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(StartUpForm));
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.cb_Devices = new System.Windows.Forms.ComboBox();
            this._btnCancel = new System.Windows.Forms.Button();
            this._btnConnect = new System.Windows.Forms.Button();
            this.lbl_info = new System.Windows.Forms.Label();
            this.pictureBox1 = new System.Windows.Forms.PictureBox();
            this.groupBox1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).BeginInit();
            this.SuspendLayout();
            // 
            // groupBox1
            // 
            this.groupBox1.BackColor = System.Drawing.SystemColors.ActiveCaption;
            this.groupBox1.Controls.Add(this.cb_Devices);
            this.groupBox1.Controls.Add(this._btnCancel);
            this.groupBox1.Controls.Add(this._btnConnect);
            this.groupBox1.Controls.Add(this.lbl_info);
            this.groupBox1.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.groupBox1.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.groupBox1.ForeColor = System.Drawing.Color.Maroon;
            this.groupBox1.Location = new System.Drawing.Point(16, 97);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(315, 176);
            this.groupBox1.TabIndex = 19;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Select Device";
            // 
            // cb_Devices
            // 
            this.cb_Devices.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cb_Devices.FlatStyle = System.Windows.Forms.FlatStyle.System;
            this.cb_Devices.FormattingEnabled = true;
            this.cb_Devices.Items.AddRange(new object[] {
            "ISL29177"});
            this.cb_Devices.Location = new System.Drawing.Point(72, 46);
            this.cb_Devices.Name = "cb_Devices";
            this.cb_Devices.Size = new System.Drawing.Size(170, 28);
            this.cb_Devices.TabIndex = 23;
            // 
            // _btnCancel
            // 
            this._btnCancel.BackColor = System.Drawing.SystemColors.MenuHighlight;
            this._btnCancel.ForeColor = System.Drawing.Color.White;
            this._btnCancel.Location = new System.Drawing.Point(160, 111);
            this._btnCancel.Name = "_btnCancel";
            this._btnCancel.Size = new System.Drawing.Size(82, 37);
            this._btnCancel.TabIndex = 22;
            this._btnCancel.Text = "Cancel";
            this._btnCancel.UseVisualStyleBackColor = false;
            this._btnCancel.Click += new System.EventHandler(this._btnCancel_Click);
            // 
            // _btnConnect
            // 
            this._btnConnect.BackColor = System.Drawing.SystemColors.MenuHighlight;
            this._btnConnect.ForeColor = System.Drawing.Color.White;
            this._btnConnect.Location = new System.Drawing.Point(72, 111);
            this._btnConnect.Name = "_btnConnect";
            this._btnConnect.Size = new System.Drawing.Size(82, 37);
            this._btnConnect.TabIndex = 21;
            this._btnConnect.Text = "Connect";
            this._btnConnect.UseVisualStyleBackColor = false;
            this._btnConnect.Click += new System.EventHandler(this._btnConnect_Click);
            // 
            // lbl_info
            // 
            this.lbl_info.AutoSize = true;
            this.lbl_info.Location = new System.Drawing.Point(102, 68);
            this.lbl_info.Name = "lbl_info";
            this.lbl_info.Size = new System.Drawing.Size(0, 20);
            this.lbl_info.TabIndex = 18;
            // 
            // pictureBox1
            // 
            this.pictureBox1.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Center;
            this.pictureBox1.Image = ((System.Drawing.Image)(resources.GetObject("pictureBox1.Image")));
            this.pictureBox1.InitialImage = null;
            this.pictureBox1.Location = new System.Drawing.Point(176, 32);
            this.pictureBox1.Name = "pictureBox1";
            this.pictureBox1.Size = new System.Drawing.Size(155, 40);
            this.pictureBox1.TabIndex = 20;
            this.pictureBox1.TabStop = false;
            // 
            // StartUpForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.SystemColors.ActiveCaption;
            this.ClientSize = new System.Drawing.Size(349, 290);
            this.Controls.Add(this.pictureBox1);
            this.Controls.Add(this.groupBox1);
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.MaximizeBox = false;
            this.MinimizeBox = false;
            this.Name = "StartUpForm";
            this.Text = "Connect Device";
            this.groupBox1.ResumeLayout(false);
            this.groupBox1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.Label lbl_info;
        private System.Windows.Forms.Button _btnCancel;
        private System.Windows.Forms.Button _btnConnect;
        private System.Windows.Forms.PictureBox pictureBox1;
        private System.Windows.Forms.ComboBox cb_Devices;

    }
}

