namespace eventos.UIWindows
{
    partial class FormPrintOptions
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
            this.chklst = new System.Windows.Forms.CheckedListBox();
            this.txtTitle = new System.Windows.Forms.TextBox();
            this.btnOK = new System.Windows.Forms.Button();
            this.btnCancel = new System.Windows.Forms.Button();
            this.groupBox5 = new System.Windows.Forms.GroupBox();
            this.pnlRodape = new System.Windows.Forms.Panel();
            this.buttonAjuda = new System.Windows.Forms.Button();
            this.pictureBox1 = new System.Windows.Forms.PictureBox();
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.groupBox5.SuspendLayout();
            this.pnlRodape.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).BeginInit();
            this.groupBox1.SuspendLayout();
            this.SuspendLayout();
            // 
            // chklst
            // 
            this.chklst.BackColor = System.Drawing.Color.LightYellow;
            this.chklst.FormattingEnabled = true;
            this.chklst.Location = new System.Drawing.Point(6, 21);
            this.chklst.Name = "chklst";
            this.chklst.ScrollAlwaysVisible = true;
            this.chklst.Size = new System.Drawing.Size(466, 276);
            this.chklst.TabIndex = 0;
            // 
            // txtTitle
            // 
            this.txtTitle.BackColor = System.Drawing.Color.LightYellow;
            this.txtTitle.Font = new System.Drawing.Font("Segoe UI", 8.25F);
            this.txtTitle.Location = new System.Drawing.Point(6, 21);
            this.txtTitle.Multiline = true;
            this.txtTitle.Name = "txtTitle";
            this.txtTitle.ScrollBars = System.Windows.Forms.ScrollBars.Vertical;
            this.txtTitle.Size = new System.Drawing.Size(470, 22);
            this.txtTitle.TabIndex = 3;
            // 
            // btnOK
            // 
            this.btnOK.Location = new System.Drawing.Point(460, 5);
            this.btnOK.Name = "btnOK";
            this.btnOK.Size = new System.Drawing.Size(75, 29);
            this.btnOK.TabIndex = 4;
            this.btnOK.Text = "OK";
            this.btnOK.UseVisualStyleBackColor = true;
            this.btnOK.Click += new System.EventHandler(this.btnOK_Click);
            // 
            // btnCancel
            // 
            this.btnCancel.Location = new System.Drawing.Point(541, 5);
            this.btnCancel.Name = "btnCancel";
            this.btnCancel.Size = new System.Drawing.Size(75, 29);
            this.btnCancel.TabIndex = 5;
            this.btnCancel.Text = "Cancelar";
            this.btnCancel.UseVisualStyleBackColor = true;
            this.btnCancel.Click += new System.EventHandler(this.btnCancel_Click);
            // 
            // groupBox5
            // 
            this.groupBox5.Controls.Add(this.txtTitle);
            this.groupBox5.Font = new System.Drawing.Font("Segoe UI", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.groupBox5.ForeColor = System.Drawing.Color.SteelBlue;
            this.groupBox5.Location = new System.Drawing.Point(140, 12);
            this.groupBox5.Name = "groupBox5";
            this.groupBox5.Size = new System.Drawing.Size(482, 48);
            this.groupBox5.TabIndex = 53;
            this.groupBox5.TabStop = false;
            this.groupBox5.Text = "Titulo da Impressão";
            // 
            // pnlRodape
            // 
            this.pnlRodape.Controls.Add(this.buttonAjuda);
            this.pnlRodape.Controls.Add(this.btnCancel);
            this.pnlRodape.Controls.Add(this.btnOK);
            this.pnlRodape.Dock = System.Windows.Forms.DockStyle.Bottom;
            this.pnlRodape.Location = new System.Drawing.Point(0, 402);
            this.pnlRodape.Name = "pnlRodape";
            this.pnlRodape.Size = new System.Drawing.Size(624, 40);
            this.pnlRodape.TabIndex = 52;
            // 
            // buttonAjuda
            // 
            this.buttonAjuda.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
            this.buttonAjuda.DialogResult = System.Windows.Forms.DialogResult.Cancel;
            this.buttonAjuda.FlatAppearance.BorderSize = 0;
            this.buttonAjuda.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.buttonAjuda.ForeColor = System.Drawing.Color.Red;
            this.buttonAjuda.Image = global::eventos.UIWindows.Properties.Resources.help;
            this.buttonAjuda.ImageAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.buttonAjuda.Location = new System.Drawing.Point(12, 8);
            this.buttonAjuda.Name = "buttonAjuda";
            this.buttonAjuda.Size = new System.Drawing.Size(63, 23);
            this.buttonAjuda.TabIndex = 36;
            this.buttonAjuda.Text = "&Ajuda";
            this.buttonAjuda.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            // 
            // pictureBox1
            // 
            this.pictureBox1.Image = global::eventos.UIWindows.Properties.Resources.print1;
            this.pictureBox1.Location = new System.Drawing.Point(12, 6);
            this.pictureBox1.Name = "pictureBox1";
            this.pictureBox1.Size = new System.Drawing.Size(122, 162);
            this.pictureBox1.SizeMode = System.Windows.Forms.PictureBoxSizeMode.Zoom;
            this.pictureBox1.TabIndex = 51;
            this.pictureBox1.TabStop = false;
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.chklst);
            this.groupBox1.Font = new System.Drawing.Font("Segoe UI", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.groupBox1.ForeColor = System.Drawing.Color.SteelBlue;
            this.groupBox1.Location = new System.Drawing.Point(140, 82);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(482, 314);
            this.groupBox1.TabIndex = 54;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Selecione os campos que deseja em seu relatório";
            // 
            // FormPrintOptions
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(624, 442);
            this.Controls.Add(this.groupBox1);
            this.Controls.Add(this.groupBox5);
            this.Controls.Add(this.pnlRodape);
            this.Controls.Add(this.pictureBox1);
            this.Name = "FormPrintOptions";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Opções de Impressão";
            this.Load += new System.EventHandler(this.PrintOptions_Load);
            this.groupBox5.ResumeLayout(false);
            this.groupBox5.PerformLayout();
            this.pnlRodape.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).EndInit();
            this.groupBox1.ResumeLayout(false);
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.CheckedListBox chklst;
        private System.Windows.Forms.TextBox txtTitle;
        private System.Windows.Forms.Button btnOK;
        private System.Windows.Forms.Button btnCancel;
        private System.Windows.Forms.GroupBox groupBox5;
        private System.Windows.Forms.Panel pnlRodape;
        private System.Windows.Forms.Button buttonAjuda;
        private System.Windows.Forms.PictureBox pictureBox1;
        private System.Windows.Forms.GroupBox groupBox1;
    }
}