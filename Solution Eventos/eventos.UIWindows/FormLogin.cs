using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using eventos.BLL;
using eventos.LIB;

namespace eventos.UIWindows
{
    public partial class FormLogin : Form
    {

        public string usuarioId { get; set; }
        public string usuarioNome { get; set; }
        public string usuarioLogin { get; set; }
        public string usuarioSenha { get; set; }
        public string usuarioPerfil { get; set; }
        public DateTime usuarioUltLogin { get; set; }
        public int tentativa;

        public FormLogin(int pTentativa)
        {
            InitializeComponent();
            timer1.Interval = 1000; // 1 segundo
            timer1.Start();

            usuarioId = string.Empty;
            usuarioNome = string.Empty;
            usuarioLogin = string.Empty;
            usuarioSenha = string.Empty;
            usuarioPerfil = string.Empty;
            tentativa = pTentativa;
            this.Text = this.Text + " - Tentativa " + tentativa.ToString() + "/3";
        }
        
        private void buttonEntrar_Click(object sender, EventArgs e)
        {
            //preprando procedimento para encriptar as senhas no banco
            LIB.Crypt _crypt = new LIB.Crypt(CryptProvider.Rijndael);
            _crypt.Key = "mmstec";
            string usuarioSenhaEncrypt = _crypt.Encrypt(textBoxSenha.Text);
            string filtro = "select UsuariosId, UsuariosNome, UsuariosLogin, UsuariosSenha, UsuariosPerfil, UsuariosDataLogin from usuarios where Usuarios.UsuariosLogin = '" + textBoxUsuario.Text.Trim() + "' and Usuarios.UsuariosSenha = '" + usuarioSenhaEncrypt.Trim() + "' ";
            
            BLL.usuarios obj = new BLL.usuarios();
            DataTable dt = obj.retornarQueryDataTable(filtro);

            int numrows = dt.Rows.Count;
            if (tentativa <=3)
            {
                if (textBoxUsuario.Text == string.Empty)
                {
                    MessageBox.Show("Informe seu nome de usuário", tentativa.ToString() + ".ª Tentativa", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    textBoxUsuario.SelectAll();
                    textBoxUsuario.Focus();
                }
                else if (textBoxSenha.Text == string.Empty)
                {
                    MessageBox.Show("Informe sua senha", tentativa.ToString() + ".ª Tentativa", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    textBoxSenha.SelectAll();
                    textBoxSenha.Focus();
                }
                else
                {

                    if (textBoxUsuario.Text != string.Empty)
                    {
                        if (textBoxSenha.Text != string.Empty)
                        {
                            if (numrows > 0)
                            {
                                usuarioId = dt.Rows[0].ItemArray[0].ToString();
                                usuarioNome = dt.Rows[0].ItemArray[1].ToString();
                                usuarioLogin = dt.Rows[0].ItemArray[2].ToString();
                                usuarioSenha = dt.Rows[0].ItemArray[3].ToString();
                                usuarioPerfil = dt.Rows[0].ItemArray[4].ToString();
                                usuarioUltLogin = Convert.ToDateTime(dt.Rows[0].ItemArray[5].ToString());

                                if (textBoxUsuario.Text.ToLower() == usuarioLogin.ToLower())
                                {
                                    if (usuarioSenhaEncrypt == usuarioSenha)
                                    {
                                        this.DialogResult = DialogResult.OK;
                                    }
                                    else
                                    {
                                        MessageBox.Show(usuarioSenhaEncrypt + "-->"+ usuarioSenha);
                                    }
                                }
                            }
                            else
                            {
                                MessageBox.Show("Acesso não permitido", tentativa.ToString() + "ª Tentativa", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                                textBoxUsuario.Text = string.Empty;
                                textBoxSenha.Text = string.Empty;
                                textBoxUsuario.Focus();
                            }

                        }
                    }
                }
            }
        }

        private void buttonSair_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }
        private void FormLogin_FormClosed(object sender, FormClosedEventArgs e)
        {
            Close();
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            textBoxUsuario.SelectAll();
            textBoxUsuario.Focus();
        }

        private void timer1_Tick(object sender, EventArgs e)
        {
            string frase = DateTime.Now.ToLongDateString() + " - " + DateTime.Now.ToLongTimeString();
            char primeira = char.ToUpper(frase[0]);
            frase = primeira + frase.Substring(1);
            toolStripStatusLabelRelogio.Text = frase.ToUpper();
        }
  
    }
}
