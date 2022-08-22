namespace eventos.UIWindows.xUSUARIOS
{
    partial class FormPerfil
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
            this.components = new System.ComponentModel.Container();
            this.textBoxNome = new System.Windows.Forms.TextBox();
            this.textBoxCodigo = new System.Windows.Forms.TextBox();
            this.tabPage1 = new System.Windows.Forms.TabPage();
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.labelDireitos = new System.Windows.Forms.Label();
            this.textBoxEmail = new System.Windows.Forms.TextBox();
            this.label1 = new System.Windows.Forms.Label();
            this.textBoxSenhaRepetir = new System.Windows.Forms.TextBox();
            this.labelSenhaConfirmar = new System.Windows.Forms.Label();
            this.textBoxSenha = new System.Windows.Forms.TextBox();
            this.labelSenha = new System.Windows.Forms.Label();
            this.textBoxLogin = new System.Windows.Forms.TextBox();
            this.labelCartao = new System.Windows.Forms.Label();
            this.comboBoxPresenca = new System.Windows.Forms.ComboBox();
            this.comboBoxPerfil = new System.Windows.Forms.ComboBox();
            this.labelPerfil = new System.Windows.Forms.Label();
            this.label4 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.PreviewTabela = new System.Windows.Forms.TabControl();
            this.dataGridViewImageColumn1 = new System.Windows.Forms.DataGridViewImageColumn();
            this.dataGridViewImageColumn2 = new System.Windows.Forms.DataGridViewImageColumn();
            this.tableLayoutPanel3 = new System.Windows.Forms.TableLayoutPanel();
            this.panel2 = new System.Windows.Forms.Panel();
            this.pictureBoxFoto = new System.Windows.Forms.PictureBox();
            this.buttonFotografar = new System.Windows.Forms.Button();
            this.buttonOnOff = new System.Windows.Forms.Button();
            this.labelTitulo = new System.Windows.Forms.Label();
            this.panel3 = new System.Windows.Forms.Panel();
            this.menuStrip1 = new System.Windows.Forms.MenuStrip();
            this.toolStripButtonCancelar = new System.Windows.Forms.ToolStripMenuItem();
            this.toolStripButtonGravar = new System.Windows.Forms.ToolStripMenuItem();
            this.pnltopo = new System.Windows.Forms.Panel();
            this.pictureBoxStatus = new System.Windows.Forms.PictureBox();
            this.labelSubTitulo = new System.Windows.Forms.Label();
            this.dataGridViewImageColumn3 = new System.Windows.Forms.DataGridViewImageColumn();
            this.tableLayoutPanel2 = new System.Windows.Forms.TableLayoutPanel();
            this.tableLayoutPanel1 = new System.Windows.Forms.TableLayoutPanel();
            this.panel1 = new System.Windows.Forms.Panel();
            this.errorProvider = new System.Windows.Forms.ErrorProvider(this.components);
            this.tabPage1.SuspendLayout();
            this.groupBox1.SuspendLayout();
            this.PreviewTabela.SuspendLayout();
            this.tableLayoutPanel3.SuspendLayout();
            this.panel2.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBoxFoto)).BeginInit();
            this.panel3.SuspendLayout();
            this.menuStrip1.SuspendLayout();
            this.pnltopo.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBoxStatus)).BeginInit();
            this.tableLayoutPanel2.SuspendLayout();
            this.tableLayoutPanel1.SuspendLayout();
            this.panel1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.errorProvider)).BeginInit();
            this.SuspendLayout();
            // 
            // textBoxNome
            // 
            this.textBoxNome.BackColor = System.Drawing.Color.White;
            this.textBoxNome.CharacterCasing = System.Windows.Forms.CharacterCasing.Upper;
            this.textBoxNome.Font = new System.Drawing.Font("Courier New", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.textBoxNome.ForeColor = System.Drawing.Color.OrangeRed;
            this.textBoxNome.Location = new System.Drawing.Point(121, 34);
            this.textBoxNome.Name = "textBoxNome";
            this.textBoxNome.Size = new System.Drawing.Size(323, 22);
            this.textBoxNome.TabIndex = 1;
            this.textBoxNome.Validating += new System.ComponentModel.CancelEventHandler(this.textBoxNome_Validating);
            // 
            // textBoxCodigo
            // 
            this.textBoxCodigo.BackColor = System.Drawing.Color.White;
            this.textBoxCodigo.CharacterCasing = System.Windows.Forms.CharacterCasing.Upper;
            this.textBoxCodigo.Font = new System.Drawing.Font("Courier New", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.textBoxCodigo.ForeColor = System.Drawing.Color.Black;
            this.textBoxCodigo.Location = new System.Drawing.Point(121, 6);
            this.textBoxCodigo.Name = "textBoxCodigo";
            this.textBoxCodigo.Size = new System.Drawing.Size(152, 22);
            this.textBoxCodigo.TabIndex = 0;
            this.textBoxCodigo.TabStop = false;
            this.textBoxCodigo.Visible = false;
            // 
            // tabPage1
            // 
            this.tabPage1.BackColor = System.Drawing.SystemColors.Control;
            this.tabPage1.Controls.Add(this.groupBox1);
            this.tabPage1.Controls.Add(this.textBoxEmail);
            this.tabPage1.Controls.Add(this.label1);
            this.tabPage1.Controls.Add(this.textBoxSenhaRepetir);
            this.tabPage1.Controls.Add(this.labelSenhaConfirmar);
            this.tabPage1.Controls.Add(this.textBoxSenha);
            this.tabPage1.Controls.Add(this.labelSenha);
            this.tabPage1.Controls.Add(this.textBoxLogin);
            this.tabPage1.Controls.Add(this.labelCartao);
            this.tabPage1.Controls.Add(this.comboBoxPresenca);
            this.tabPage1.Controls.Add(this.comboBoxPerfil);
            this.tabPage1.Controls.Add(this.labelPerfil);
            this.tabPage1.Controls.Add(this.textBoxNome);
            this.tabPage1.Controls.Add(this.textBoxCodigo);
            this.tabPage1.Controls.Add(this.label4);
            this.tabPage1.Controls.Add(this.label3);
            this.tabPage1.Controls.Add(this.label2);
            this.tabPage1.Location = new System.Drawing.Point(4, 29);
            this.tabPage1.Name = "tabPage1";
            this.tabPage1.Padding = new System.Windows.Forms.Padding(3);
            this.tabPage1.Size = new System.Drawing.Size(466, 283);
            this.tabPage1.TabIndex = 0;
            this.tabPage1.Text = "Dados pessoais";
            this.tabPage1.UseVisualStyleBackColor = true;
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.labelDireitos);
            this.groupBox1.Location = new System.Drawing.Point(273, 176);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(171, 101);
            this.groupBox1.TabIndex = 90;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Direitos:";
            // 
            // labelDireitos
            // 
            this.labelDireitos.Location = new System.Drawing.Point(7, 16);
            this.labelDireitos.Name = "labelDireitos";
            this.labelDireitos.Size = new System.Drawing.Size(158, 82);
            this.labelDireitos.TabIndex = 0;
            this.labelDireitos.Text = "lista de direitos";
            // 
            // textBoxEmail
            // 
            this.textBoxEmail.BackColor = System.Drawing.Color.White;
            this.textBoxEmail.CharacterCasing = System.Windows.Forms.CharacterCasing.Lower;
            this.textBoxEmail.Font = new System.Drawing.Font("Courier New", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.textBoxEmail.ForeColor = System.Drawing.Color.OrangeRed;
            this.textBoxEmail.Location = new System.Drawing.Point(121, 148);
            this.textBoxEmail.Name = "textBoxEmail";
            this.textBoxEmail.Size = new System.Drawing.Size(323, 22);
            this.textBoxEmail.TabIndex = 5;
            this.textBoxEmail.Validating += new System.ComponentModel.CancelEventHandler(this.textBoxEmail_Validating);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(6, 152);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(38, 13);
            this.label1.TabIndex = 89;
            this.label1.Text = "Email: ";
            // 
            // textBoxSenhaRepetir
            // 
            this.textBoxSenhaRepetir.AcceptsReturn = true;
            this.textBoxSenhaRepetir.BackColor = System.Drawing.Color.White;
            this.textBoxSenhaRepetir.CharacterCasing = System.Windows.Forms.CharacterCasing.Lower;
            this.textBoxSenhaRepetir.Font = new System.Drawing.Font("Courier New", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.textBoxSenhaRepetir.ForeColor = System.Drawing.Color.OrangeRed;
            this.textBoxSenhaRepetir.Location = new System.Drawing.Point(121, 120);
            this.textBoxSenhaRepetir.MaxLength = 8;
            this.textBoxSenhaRepetir.Name = "textBoxSenhaRepetir";
            this.textBoxSenhaRepetir.Size = new System.Drawing.Size(152, 22);
            this.textBoxSenhaRepetir.TabIndex = 4;
            this.textBoxSenhaRepetir.UseSystemPasswordChar = true;
            this.textBoxSenhaRepetir.Validating += new System.ComponentModel.CancelEventHandler(this.textBoxSenhaRepetir_Validating);
            // 
            // labelSenhaConfirmar
            // 
            this.labelSenhaConfirmar.AutoSize = true;
            this.labelSenhaConfirmar.Location = new System.Drawing.Point(6, 124);
            this.labelSenhaConfirmar.Name = "labelSenhaConfirmar";
            this.labelSenhaConfirmar.Size = new System.Drawing.Size(86, 13);
            this.labelSenhaConfirmar.TabIndex = 87;
            this.labelSenhaConfirmar.Text = "Confirmar senha:";
            // 
            // textBoxSenha
            // 
            this.textBoxSenha.AcceptsReturn = true;
            this.textBoxSenha.BackColor = System.Drawing.Color.White;
            this.textBoxSenha.CharacterCasing = System.Windows.Forms.CharacterCasing.Lower;
            this.textBoxSenha.Font = new System.Drawing.Font("Courier New", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.textBoxSenha.ForeColor = System.Drawing.Color.OrangeRed;
            this.textBoxSenha.Location = new System.Drawing.Point(121, 90);
            this.textBoxSenha.MaxLength = 8;
            this.textBoxSenha.Name = "textBoxSenha";
            this.textBoxSenha.Size = new System.Drawing.Size(152, 22);
            this.textBoxSenha.TabIndex = 3;
            this.textBoxSenha.UseSystemPasswordChar = true;
            this.textBoxSenha.Validating += new System.ComponentModel.CancelEventHandler(this.textBoxSenha_Validating);
            // 
            // labelSenha
            // 
            this.labelSenha.AutoSize = true;
            this.labelSenha.Location = new System.Drawing.Point(6, 94);
            this.labelSenha.Name = "labelSenha";
            this.labelSenha.Size = new System.Drawing.Size(41, 13);
            this.labelSenha.TabIndex = 85;
            this.labelSenha.Text = "Senha:";
            // 
            // textBoxLogin
            // 
            this.textBoxLogin.AcceptsReturn = true;
            this.textBoxLogin.BackColor = System.Drawing.Color.White;
            this.textBoxLogin.CharacterCasing = System.Windows.Forms.CharacterCasing.Lower;
            this.textBoxLogin.Font = new System.Drawing.Font("Courier New", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.textBoxLogin.ForeColor = System.Drawing.Color.OrangeRed;
            this.textBoxLogin.Location = new System.Drawing.Point(121, 62);
            this.textBoxLogin.MaxLength = 8;
            this.textBoxLogin.Name = "textBoxLogin";
            this.textBoxLogin.Size = new System.Drawing.Size(152, 22);
            this.textBoxLogin.TabIndex = 2;
            this.textBoxLogin.Validated += new System.EventHandler(this.textBoxLogin_Validated);
            this.textBoxLogin.Validating += new System.ComponentModel.CancelEventHandler(this.textBoxLogin_Validating);
            // 
            // labelCartao
            // 
            this.labelCartao.AutoSize = true;
            this.labelCartao.Location = new System.Drawing.Point(6, 66);
            this.labelCartao.Name = "labelCartao";
            this.labelCartao.Size = new System.Drawing.Size(36, 13);
            this.labelCartao.TabIndex = 83;
            this.labelCartao.Text = "Login:";
            // 
            // comboBoxPresenca
            // 
            this.comboBoxPresenca.DropDownStyle = System.Windows.Forms.ComboBoxStyle.Simple;
            this.comboBoxPresenca.Enabled = false;
            this.comboBoxPresenca.FormattingEnabled = true;
            this.comboBoxPresenca.Items.AddRange(new object[] {
            "online",
            "offline"});
            this.comboBoxPresenca.Location = new System.Drawing.Point(121, 203);
            this.comboBoxPresenca.Name = "comboBoxPresenca";
            this.comboBoxPresenca.Size = new System.Drawing.Size(146, 21);
            this.comboBoxPresenca.TabIndex = 7;
            this.comboBoxPresenca.Validating += new System.ComponentModel.CancelEventHandler(this.comboBoxPresenca_Validating);
            // 
            // comboBoxPerfil
            // 
            this.comboBoxPerfil.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.comboBoxPerfil.FormattingEnabled = true;
            this.comboBoxPerfil.Items.AddRange(new object[] {
            "administrador",
            "gerente",
            "supervisor",
            "operador",
            "usuario"});
            this.comboBoxPerfil.Location = new System.Drawing.Point(121, 176);
            this.comboBoxPerfil.Name = "comboBoxPerfil";
            this.comboBoxPerfil.Size = new System.Drawing.Size(146, 21);
            this.comboBoxPerfil.TabIndex = 6;
            this.comboBoxPerfil.Validating += new System.ComponentModel.CancelEventHandler(this.comboBoxPerfil_Validating);
            this.comboBoxPerfil.TextChanged += new System.EventHandler(this.comboBoxPerfil_TextChanged);
            // 
            // labelPerfil
            // 
            this.labelPerfil.AutoSize = true;
            this.labelPerfil.Location = new System.Drawing.Point(6, 203);
            this.labelPerfil.Name = "labelPerfil";
            this.labelPerfil.Size = new System.Drawing.Size(55, 13);
            this.labelPerfil.TabIndex = 80;
            this.labelPerfil.Text = "Presença:";
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(6, 176);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(33, 13);
            this.label4.TabIndex = 73;
            this.label4.Text = "Perfil:";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(6, 38);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(41, 13);
            this.label3.TabIndex = 72;
            this.label3.Text = "Nome: ";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(6, 10);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(104, 13);
            this.label2.TabIndex = 71;
            this.label2.Text = "Código (automático):";
            this.label2.Visible = false;
            // 
            // PreviewTabela
            // 
            this.PreviewTabela.Appearance = System.Windows.Forms.TabAppearance.FlatButtons;
            this.PreviewTabela.Controls.Add(this.tabPage1);
            this.PreviewTabela.Dock = System.Windows.Forms.DockStyle.Fill;
            this.PreviewTabela.Location = new System.Drawing.Point(128, 0);
            this.PreviewTabela.Margin = new System.Windows.Forms.Padding(0);
            this.PreviewTabela.Name = "PreviewTabela";
            this.PreviewTabela.Padding = new System.Drawing.Point(6, 5);
            this.PreviewTabela.SelectedIndex = 0;
            this.PreviewTabela.Size = new System.Drawing.Size(474, 316);
            this.PreviewTabela.TabIndex = 72;
            // 
            // dataGridViewImageColumn1
            // 
            this.dataGridViewImageColumn1.Frozen = true;
            this.dataGridViewImageColumn1.HeaderText = "";
            this.dataGridViewImageColumn1.Name = "dataGridViewImageColumn1";
            this.dataGridViewImageColumn1.Width = 30;
            // 
            // dataGridViewImageColumn2
            // 
            this.dataGridViewImageColumn2.Frozen = true;
            this.dataGridViewImageColumn2.HeaderText = "";
            this.dataGridViewImageColumn2.Name = "dataGridViewImageColumn2";
            this.dataGridViewImageColumn2.Width = 30;
            // 
            // tableLayoutPanel3
            // 
            this.tableLayoutPanel3.ColumnCount = 2;
            this.tableLayoutPanel3.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 21.42857F));
            this.tableLayoutPanel3.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 78.57143F));
            this.tableLayoutPanel3.Controls.Add(this.panel2, 0, 0);
            this.tableLayoutPanel3.Controls.Add(this.PreviewTabela, 1, 0);
            this.tableLayoutPanel3.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tableLayoutPanel3.Location = new System.Drawing.Point(0, 0);
            this.tableLayoutPanel3.Name = "tableLayoutPanel3";
            this.tableLayoutPanel3.RowCount = 1;
            this.tableLayoutPanel3.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 50F));
            this.tableLayoutPanel3.Size = new System.Drawing.Size(602, 316);
            this.tableLayoutPanel3.TabIndex = 70;
            // 
            // panel2
            // 
            this.panel2.Controls.Add(this.pictureBoxFoto);
            this.panel2.Controls.Add(this.buttonFotografar);
            this.panel2.Controls.Add(this.buttonOnOff);
            this.panel2.Dock = System.Windows.Forms.DockStyle.Fill;
            this.panel2.Location = new System.Drawing.Point(3, 3);
            this.panel2.Name = "panel2";
            this.panel2.Size = new System.Drawing.Size(122, 310);
            this.panel2.TabIndex = 82;
            // 
            // pictureBoxFoto
            // 
            this.pictureBoxFoto.BackColor = System.Drawing.Color.Gainsboro;
            this.pictureBoxFoto.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.pictureBoxFoto.Dock = System.Windows.Forms.DockStyle.Top;
            this.pictureBoxFoto.ErrorImage = null;
            this.pictureBoxFoto.Image = global::eventos.UIWindows.Properties.Resources.user;
            this.pictureBoxFoto.Location = new System.Drawing.Point(0, 0);
            this.pictureBoxFoto.Name = "pictureBoxFoto";
            this.pictureBoxFoto.Size = new System.Drawing.Size(122, 162);
            this.pictureBoxFoto.SizeMode = System.Windows.Forms.PictureBoxSizeMode.Zoom;
            this.pictureBoxFoto.TabIndex = 71;
            this.pictureBoxFoto.TabStop = false;
            // 
            // buttonFotografar
            // 
            this.buttonFotografar.Enabled = false;
            this.buttonFotografar.Image = global::eventos.UIWindows.Properties.Resources.camera;
            this.buttonFotografar.Location = new System.Drawing.Point(47, 168);
            this.buttonFotografar.Name = "buttonFotografar";
            this.buttonFotografar.Size = new System.Drawing.Size(73, 55);
            this.buttonFotografar.TabIndex = 82;
            this.buttonFotografar.UseVisualStyleBackColor = true;
            this.buttonFotografar.Click += new System.EventHandler(this.buttonFotografar_Click);
            // 
            // buttonOnOff
            // 
            this.buttonOnOff.FlatStyle = System.Windows.Forms.FlatStyle.System;
            this.buttonOnOff.Location = new System.Drawing.Point(3, 168);
            this.buttonOnOff.Name = "buttonOnOff";
            this.buttonOnOff.Size = new System.Drawing.Size(41, 55);
            this.buttonOnOff.TabIndex = 81;
            this.buttonOnOff.Text = "Ligar";
            this.buttonOnOff.UseVisualStyleBackColor = true;
            this.buttonOnOff.Click += new System.EventHandler(this.buttonOnOff_Click);
            // 
            // labelTitulo
            // 
            this.labelTitulo.AutoSize = true;
            this.labelTitulo.Font = new System.Drawing.Font("Microsoft Sans Serif", 15.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.labelTitulo.Location = new System.Drawing.Point(43, 6);
            this.labelTitulo.Name = "labelTitulo";
            this.labelTitulo.Size = new System.Drawing.Size(65, 25);
            this.labelTitulo.TabIndex = 0;
            this.labelTitulo.Text = "Titulo";
            // 
            // panel3
            // 
            this.panel3.Controls.Add(this.tableLayoutPanel3);
            this.panel3.Controls.Add(this.menuStrip1);
            this.panel3.Dock = System.Windows.Forms.DockStyle.Fill;
            this.panel3.Location = new System.Drawing.Point(8, 8);
            this.panel3.Name = "panel3";
            this.panel3.Size = new System.Drawing.Size(602, 344);
            this.panel3.TabIndex = 1;
            // 
            // menuStrip1
            // 
            this.menuStrip1.BackgroundImage = global::eventos.UIWindows.Properties.Resources.menu;
            this.menuStrip1.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Stretch;
            this.menuStrip1.Dock = System.Windows.Forms.DockStyle.Bottom;
            this.menuStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.toolStripButtonCancelar,
            this.toolStripButtonGravar});
            this.menuStrip1.Location = new System.Drawing.Point(0, 316);
            this.menuStrip1.Name = "menuStrip1";
            this.menuStrip1.Padding = new System.Windows.Forms.Padding(5, 5, 5, 3);
            this.menuStrip1.RenderMode = System.Windows.Forms.ToolStripRenderMode.Professional;
            this.menuStrip1.Size = new System.Drawing.Size(602, 28);
            this.menuStrip1.TabIndex = 63;
            this.menuStrip1.Text = "menuStrip1";
            // 
            // toolStripButtonCancelar
            // 
            this.toolStripButtonCancelar.Alignment = System.Windows.Forms.ToolStripItemAlignment.Right;
            this.toolStripButtonCancelar.Image = global::eventos.UIWindows.Properties.Resources.delete;
            this.toolStripButtonCancelar.Name = "toolStripButtonCancelar";
            this.toolStripButtonCancelar.Size = new System.Drawing.Size(81, 20);
            this.toolStripButtonCancelar.Text = "&Cancelar";
            this.toolStripButtonCancelar.Click += new System.EventHandler(this.toolStripButtonCancelar_Click);
            // 
            // toolStripButtonGravar
            // 
            this.toolStripButtonGravar.Alignment = System.Windows.Forms.ToolStripItemAlignment.Right;
            this.toolStripButtonGravar.Image = global::eventos.UIWindows.Properties.Resources.ok;
            this.toolStripButtonGravar.Name = "toolStripButtonGravar";
            this.toolStripButtonGravar.Size = new System.Drawing.Size(69, 20);
            this.toolStripButtonGravar.Text = "&Gravar";
            this.toolStripButtonGravar.ToolTipText = "Gravar";
            this.toolStripButtonGravar.Click += new System.EventHandler(this.toolStripButtonGravar_Click);
            // 
            // pnltopo
            // 
            this.pnltopo.BackColor = System.Drawing.SystemColors.Control;
            this.pnltopo.Controls.Add(this.pictureBoxStatus);
            this.pnltopo.Controls.Add(this.labelTitulo);
            this.pnltopo.Controls.Add(this.labelSubTitulo);
            this.pnltopo.Dock = System.Windows.Forms.DockStyle.Fill;
            this.pnltopo.Location = new System.Drawing.Point(3, 3);
            this.pnltopo.Name = "pnltopo";
            this.pnltopo.Size = new System.Drawing.Size(618, 70);
            this.pnltopo.TabIndex = 81;
            // 
            // pictureBoxStatus
            // 
            this.pictureBoxStatus.Image = global::eventos.UIWindows.Properties.Resources.button_withe;
            this.pictureBoxStatus.Location = new System.Drawing.Point(5, 6);
            this.pictureBoxStatus.Name = "pictureBoxStatus";
            this.pictureBoxStatus.Size = new System.Drawing.Size(32, 32);
            this.pictureBoxStatus.SizeMode = System.Windows.Forms.PictureBoxSizeMode.Zoom;
            this.pictureBoxStatus.TabIndex = 53;
            this.pictureBoxStatus.TabStop = false;
            // 
            // labelSubTitulo
            // 
            this.labelSubTitulo.Font = new System.Drawing.Font("Segoe UI", 9.75F);
            this.labelSubTitulo.ForeColor = System.Drawing.Color.Black;
            this.labelSubTitulo.Location = new System.Drawing.Point(45, 31);
            this.labelSubTitulo.Name = "labelSubTitulo";
            this.labelSubTitulo.Size = new System.Drawing.Size(368, 33);
            this.labelSubTitulo.TabIndex = 1;
            this.labelSubTitulo.Text = "Subtitulo";
            // 
            // dataGridViewImageColumn3
            // 
            this.dataGridViewImageColumn3.Frozen = true;
            this.dataGridViewImageColumn3.HeaderText = "";
            this.dataGridViewImageColumn3.Name = "dataGridViewImageColumn3";
            this.dataGridViewImageColumn3.Width = 30;
            // 
            // tableLayoutPanel2
            // 
            this.tableLayoutPanel2.CellBorderStyle = System.Windows.Forms.TableLayoutPanelCellBorderStyle.Inset;
            this.tableLayoutPanel2.ColumnCount = 1;
            this.tableLayoutPanel2.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 20.71197F));
            this.tableLayoutPanel2.Controls.Add(this.panel3, 0, 0);
            this.tableLayoutPanel2.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tableLayoutPanel2.Location = new System.Drawing.Point(0, 0);
            this.tableLayoutPanel2.Name = "tableLayoutPanel2";
            this.tableLayoutPanel2.Padding = new System.Windows.Forms.Padding(3);
            this.tableLayoutPanel2.RowCount = 1;
            this.tableLayoutPanel2.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 50F));
            this.tableLayoutPanel2.Size = new System.Drawing.Size(618, 360);
            this.tableLayoutPanel2.TabIndex = 1;
            // 
            // tableLayoutPanel1
            // 
            this.tableLayoutPanel1.ColumnCount = 1;
            this.tableLayoutPanel1.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 100F));
            this.tableLayoutPanel1.Controls.Add(this.pnltopo, 0, 0);
            this.tableLayoutPanel1.Controls.Add(this.panel1, 0, 1);
            this.tableLayoutPanel1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tableLayoutPanel1.Location = new System.Drawing.Point(0, 0);
            this.tableLayoutPanel1.Name = "tableLayoutPanel1";
            this.tableLayoutPanel1.RowCount = 2;
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 76F));
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 100F));
            this.tableLayoutPanel1.Size = new System.Drawing.Size(624, 442);
            this.tableLayoutPanel1.TabIndex = 114;
            // 
            // panel1
            // 
            this.panel1.Controls.Add(this.tableLayoutPanel2);
            this.panel1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.panel1.Location = new System.Drawing.Point(3, 79);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(618, 360);
            this.panel1.TabIndex = 82;
            // 
            // errorProvider
            // 
            this.errorProvider.ContainerControl = this;
            // 
            // FormPerfil
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(624, 442);
            this.Controls.Add(this.tableLayoutPanel1);
            this.Name = "FormPerfil";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Perfil";
            this.Load += new System.EventHandler(this.FormPerfil_Load);
            this.tabPage1.ResumeLayout(false);
            this.tabPage1.PerformLayout();
            this.groupBox1.ResumeLayout(false);
            this.PreviewTabela.ResumeLayout(false);
            this.tableLayoutPanel3.ResumeLayout(false);
            this.panel2.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.pictureBoxFoto)).EndInit();
            this.panel3.ResumeLayout(false);
            this.panel3.PerformLayout();
            this.menuStrip1.ResumeLayout(false);
            this.menuStrip1.PerformLayout();
            this.pnltopo.ResumeLayout(false);
            this.pnltopo.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBoxStatus)).EndInit();
            this.tableLayoutPanel2.ResumeLayout(false);
            this.tableLayoutPanel1.ResumeLayout(false);
            this.panel1.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.errorProvider)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.TextBox textBoxNome;
        private System.Windows.Forms.TextBox textBoxCodigo;
        private System.Windows.Forms.TabPage tabPage1;
        private System.Windows.Forms.ComboBox comboBoxPerfil;
        private System.Windows.Forms.Label labelPerfil;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.TabControl PreviewTabela;
        private System.Windows.Forms.DataGridViewImageColumn dataGridViewImageColumn1;
        private System.Windows.Forms.MenuStrip menuStrip1;
        private System.Windows.Forms.ToolStripMenuItem toolStripButtonCancelar;
        private System.Windows.Forms.DataGridViewImageColumn dataGridViewImageColumn2;
        private System.Windows.Forms.PictureBox pictureBoxFoto;
        private System.Windows.Forms.TableLayoutPanel tableLayoutPanel3;
        private System.Windows.Forms.Label labelTitulo;
        private System.Windows.Forms.Panel panel3;
        private System.Windows.Forms.PictureBox pictureBoxStatus;
        private System.Windows.Forms.Panel pnltopo;
        private System.Windows.Forms.Label labelSubTitulo;
        private System.Windows.Forms.DataGridViewImageColumn dataGridViewImageColumn3;
        private System.Windows.Forms.TableLayoutPanel tableLayoutPanel2;
        private System.Windows.Forms.TableLayoutPanel tableLayoutPanel1;
        private System.Windows.Forms.Panel panel1;
        private System.Windows.Forms.ErrorProvider errorProvider;
        private System.Windows.Forms.Panel panel2;
        private System.Windows.Forms.Button buttonFotografar;
        private System.Windows.Forms.Button buttonOnOff;
        private System.Windows.Forms.ComboBox comboBoxPresenca;
        private System.Windows.Forms.TextBox textBoxLogin;
        private System.Windows.Forms.Label labelCartao;
        private System.Windows.Forms.ToolStripMenuItem toolStripButtonGravar;
        private System.Windows.Forms.TextBox textBoxSenhaRepetir;
        private System.Windows.Forms.Label labelSenhaConfirmar;
        private System.Windows.Forms.TextBox textBoxSenha;
        private System.Windows.Forms.Label labelSenha;
        private System.Windows.Forms.TextBox textBoxEmail;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.Label labelDireitos;
    }
}