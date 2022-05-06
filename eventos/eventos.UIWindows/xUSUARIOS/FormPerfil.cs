using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using eventos.TAB;
using eventos.BLL;
using eventos.LIB;

namespace eventos.UIWindows.xUSUARIOS
{
    public partial class FormPerfil : Form
    {
        [System.Runtime.InteropServices.DllImport("kernel32.dll")]
        public static extern bool Beep(UInt32 frequency, UInt32 duration);
        public string strUsuariosID;
        public string strUsuariosNome, strUsuariosLogin, strUsuariosSenha, strUsuariosSenhaRepetir, strUsuariosPerfil, strUsuariosEmail;
        public bool strUsuariosOnline;
        public string strTitulo;
        public string strComando;

        public FormPerfil()
        {
            InitializeComponent();
        }
        /// <summary>
        /// Método que retorna um formulario que inclur, altera e deleta registros.
        /// parametros: insert, update e delete 
        /// </summary>
        /// <param name="comando"></param>
        /// <returns></returns>
        public FormPerfil(string pComando)
        {
            InitializeComponent();
            strComando = pComando;
            switch (strComando)
            {
                case "insert":
                    toolStripButtonGravar.Text = "Confirmar &Incluir";
                    toolStripButtonGravar.Image = Properties.Resources.ok;
                    break;
                case "update":
                    toolStripButtonGravar.Text = "Confirmar &Alterar";
                    toolStripButtonGravar.Image = Properties.Resources.ok;
                    break;
                case "delete":
                    toolStripButtonGravar.Text = "Confirmar &Excluir";
                    toolStripButtonGravar.Image = Properties.Resources.ok;
                    break;
                default:
                    Close();
                    break;
            }
        }

        private void FormPerfil_Load(object sender, EventArgs e)
        {
            textBoxCodigo.Text = strUsuariosID;
            textBoxNome.Text = strUsuariosNome;
            textBoxLogin.Text = strUsuariosLogin;
            textBoxSenha.Text = strUsuariosSenha;
            textBoxSenhaRepetir.Text = strUsuariosSenha;
            comboBoxPerfil.SelectedItem = strUsuariosPerfil;
           
            textBoxEmail.Text = strUsuariosEmail;
            labelTitulo.Text = strTitulo;
            this.Text = strTitulo;
            textBoxNome.SelectAll();
            textBoxNome.Focus();

            switch (strUsuariosOnline)
            {
                case false:  //Ausente
                    pictureBoxStatus.Image = Properties.Resources.button_withe;
                    comboBoxPresenca.Text = "offline";
                    break;
                case true:   //Presente
                    pictureBoxStatus.Image = Properties.Resources.button_green;
                    comboBoxPresenca.Text = "online";
                    break;
                default:
                    pictureBoxStatus.Image = Properties.Resources.button_red;
                    break;
            }
        }

        private void toolStripButtonCancelar_Click(object sender, EventArgs e)
        {
            Close();
        }

        private void toolStripButtonGravar_Click(object sender, EventArgs e)
        {

            //preprando procedimento para encriptar as senhas no banco
            LIB.Crypt _crypt = new LIB.Crypt(CryptProvider.Rijndael);
            _crypt.Key = "mmstec";

            BLL.usuarios comando = new BLL.usuarios();
            TAB.usuarios registro = new TAB.usuarios();
            registro.usuariosNome = textBoxNome.Text;
            registro.usuariosLogin = textBoxLogin.Text;
            registro.usuariosSenha = _crypt.Encrypt(textBoxSenha.Text); // escriptando
            if (comboBoxPerfil.Text.Length <= 0)
            {
                registro.usuariosPerfil = "usuario";
            }
            else
            {
                registro.usuariosPerfil = comboBoxPerfil.Text;
            }
            registro.usuariosEmail = textBoxEmail.Text;

            switch (comboBoxPresenca.Text)
            {
                case "online":
                    registro.usuariosOnline = true;
                    break;
                case "offline":
                    registro.usuariosOnline = false;
                    break;
            }
            switch(strComando){
                case "insert":
                    registro.usuariosDataLogin = Convert.ToDateTime("01/01/1900");
                    registro.usuariosDataCadastro = DateTime.Now.Date;
                    comando.executarInsert(registro);
                    Beep(500, 100);
                    break;
                case "update":
                    registro.usuariosID = Convert.ToInt32(textBoxCodigo.Text);
                    comando.executarUpdate(registro);
                    Beep(500, 100);
                    break;
                case "delete":
                    if (MessageBox.Show("Confirma exclusão permanente? ", "Excluir", MessageBoxButtons.YesNo) == DialogResult.Yes)
                    {
                        registro.usuariosID = Convert.ToInt32(textBoxCodigo.Text);
                        comando.executarDelete(registro.usuariosID);
                        Beep(1000, 300);
                    }
                    break;
                default:
                    Close();
                    break;
            }
            Close();
        }
        
        private void textBoxLogin_Validated(object sender, EventArgs e)
        {
            textBoxLogin.Text = textBoxLogin.Text.ToLower();
        }
 
        private void textBoxLogin_Validating(object sender, CancelEventArgs e)
        {
            if(textBoxLogin.Text.Length <=0) 
            {
                errorProvider.SetError(textBoxLogin, "Digite um valor..");
                e.Cancel = true;
                toolStripButtonGravar.Enabled = false;
            }
            else
            {
                textBoxLogin.Text = textBoxLogin.Text.ToLower();
                errorProvider.SetError(textBoxLogin, "");
                toolStripButtonGravar.Enabled = true;
            }
        }

        private void textBoxNome_Validating(object sender, CancelEventArgs e)
        {
            if (textBoxNome.Text.Length <= 0)
            {
                errorProvider.SetError(textBoxNome, "Digite um nome");
                e.Cancel = true;
                toolStripButtonGravar.Enabled = false;
            }
            else
            {
                textBoxNome.Text = textBoxNome.Text.ToLower();
                errorProvider.SetError(textBoxNome, "");
                toolStripButtonGravar.Enabled = true;
            }
        }

        private void comboBoxPerfil_Validating(object sender, CancelEventArgs e)
        {
            if (comboBoxPerfil.Text.Length <= 0)
            {
                errorProvider.SetError(comboBoxPerfil, "Escolha um perfil para o convidado");
                e.Cancel = true;
                toolStripButtonGravar.Enabled = false;
            }
            else
            {
                errorProvider.SetError(comboBoxPerfil, "");
                toolStripButtonGravar.Enabled = true;
            }
        }

        private void comboBoxPresenca_Validating(object sender, CancelEventArgs e)
        {
            if (comboBoxPresenca.Text.Length <= 0)
            {
                errorProvider.SetError(comboBoxPresenca, "Informe a presença ou ausencia do convidado");
                e.Cancel = true;
                toolStripButtonGravar.Enabled = false;
            }
            else
            {
                errorProvider.SetError(comboBoxPresenca, "");
                toolStripButtonGravar.Enabled = true;
            }
        }

        private void textBoxSenha_Validating(object sender, CancelEventArgs e)
        {
            if (textBoxSenha.Text.Length <= 0)
            {
                errorProvider.SetError(textBoxSenha, "Digite uma senha");
                e.Cancel = true;
                toolStripButtonGravar.Enabled = false;
            }
            else
            {
                errorProvider.SetError(textBoxSenha, "");
                toolStripButtonGravar.Enabled = true;
            }
        }

        private void textBoxSenhaRepetir_Validating(object sender, CancelEventArgs e)
        {

            if(textBoxSenhaRepetir.Text.Length > 0 && textBoxSenhaRepetir.Text == textBoxSenha.Text)
            {
                errorProvider.SetError(textBoxSenhaRepetir, "");
                toolStripButtonGravar.Enabled = true;
            }
            else if(textBoxSenhaRepetir.Text.Length <= 0)
            {
                errorProvider.SetError(textBoxSenhaRepetir, "Confirme a senha");
                e.Cancel = true;
                toolStripButtonGravar.Enabled = false;
            }
            else if (textBoxSenhaRepetir.Text != textBoxSenha.Text)
            {
                errorProvider.SetError(textBoxSenhaRepetir, "O valor digitado não confere");
                e.Cancel = true;
                toolStripButtonGravar.Enabled = false;
            }

        }

        private void comboBoxPerfil_TextChanged(object sender, EventArgs e)
        {
            //administrador (incluir, apagar, alterar, visualizar)
            //gerente 	    (incluir, apagar, alterar, visualizar)
            //supervisor    (incluir, alterar, visualizar)
            //operador		(incluir, visualizar)
            //usuario	    (visualizar)
            switch (comboBoxPerfil.Text)
            {
                case "administrador":
                    labelDireitos.Text = "(incluir, apagar, alterar, visualizar)";
                    break;
                case "gerente":
                    labelDireitos.Text = "(incluir, apagar, alterar, visualizar)";
                    break;
                case "supervisor":
                    labelDireitos.Text = "(incluir, alterar, visualizar)";
                    break;
                case "operador":
                    labelDireitos.Text = "(incluir, visualizar)";
                    break;
                case "usuario":
                    labelDireitos.Text = "(visualizar)";
                    break;
            }
        }

     }
}
