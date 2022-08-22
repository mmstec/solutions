using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Runtime.InteropServices;
using eventos.TAB;
using eventos.BLL;
using eventos.LIB;
using System.Drawing.Imaging;
using System.Text.RegularExpressions;
using System.IO;


namespace eventos.UIWindows.xUSUARIOS
{
    public partial class FormPerfil : Form
    {
        [System.Runtime.InteropServices.DllImport("kernel32.dll")]
        public static extern bool Beep(UInt32 frequency, UInt32 duration);
        public string strUsuariosID;
        public string strUsuariosNome;
        public string strUsuariosLogin; 
        public string strUsuariosSenha; 
        public string strUsuariosSenhaRepetir; 
        public string strUsuariosPerfil; 
        public string strUsuariosEmail;
        public bool strUsuariosOnline;
        public byte[] parUsuariosFoto = null;
        public string strTitulo;
        public string strComando;

        public FormPerfil()
        {
            InitializeComponent();
        }
        
        /// <summary>
        /// Marcos: Método que retorna um formulario que inclur, altera e deleta registros.
        /// parametros: select, insert, update e delete 
        /// </summary>
        /// <param name="comando"></param>
        /// <returns></returns>
        public FormPerfil(string pComando)
        {
            InitializeComponent();
            strComando = pComando;
            switch (strComando)
            {
                case "select":
                    toolStripButtonGravar.Text = "Fechar";
                    toolStripButtonGravar.Image = Properties.Resources.ok;
                    toolStripButtonCancelar.Visible = false;
                    buttonOnOff.Visible = false;
                    buttonFotografar.Visible = false;
                    Library.cmdBloquearControles(this, false, false, Color.Black);
                    break;
                case "insert":
                    toolStripButtonGravar.Text = "Confirmar &Incluir";
                    toolStripButtonGravar.Image = Properties.Resources.ok;
                    toolStripButtonCancelar.Visible = true;
                    Library.cmdBloquearControles(this, true, true, Color.Black);
                    break;
                case "update":
                    toolStripButtonGravar.Text = "Confirmar &Alterar";
                    toolStripButtonGravar.Image = Properties.Resources.ok;
                    toolStripButtonCancelar.Visible = true;
                    Library.cmdBloquearControles(this, true, true, Color.OrangeRed);
                    break;
                case "delete":
                    toolStripButtonGravar.Text = "Confirmar &Excluir";
                    toolStripButtonGravar.Image = Properties.Resources.ok;
                    toolStripButtonCancelar.Visible = true;
                    buttonOnOff.Visible = false;
                    buttonFotografar.Visible = false;
                    Library.cmdBloquearControles(this, false, true, Color.Red);
                    break;
                default:
                    Close();
                    break;
            }
        }

        #region ligar, fotografar e desligar webcam
            private IDataObject dados;
            private Image bmap;
            private int hHwnd;    
            const short WM_CAP = 1024;
            const int WM_CAP_DRIVER_CONNECT = (WM_CAP + 10);
            const int WM_CAP_DRIVER_DISCONNECT = (WM_CAP + 11);
            const int WM_CAP_EDIT_COPY = (WM_CAP + 30);
            const int WM_CAP_SET_PREVIEW = (WM_CAP + 50);
            const int WM_CAP_SET_PREVIEWRATE = (WM_CAP + 52);
            const int WM_CAP_SET_SCALE = (WM_CAP + 53);
            const int WS_CHILD = 1073741824;
            const int WS_VISIBLE = 268435456;
            const short SWP_NOMOVE = 2;
            const short SWP_NOSIZE = 1;
            const short SWP_NOZORDER = 4;
            const short HWND_BOTTOM = 1;
            
            //Envia uma mensagem especifica para a janela ou para o Windows
            [DllImport("user32.dll", EntryPoint = "SendMessageA")]
            static extern void SendMessage(int hwnd, int wMsg, int wParam, [MarshalAs(UnmanagedType.AsAny)] Object lParam);
            
            //Define a posição da janela relativa ao buffer de tela
            [DllImport("user32.dll", EntryPoint = "SetWindowPos")]
            static extern int SetWindowPos(int hwnd, int hWndInsertAfter, int x, int y, int cx, int cy, int wFlags);
            
            //Destroi a janela especificada
            [DllImport("user32.dll")]
            static extern bool DestroyWindow(int hndw);

            [DllImport("avicap32.dll")]
            static extern int capCreateCaptureWindowA(string lpszWindowName, int dwStyle, int x, int y, int nWidth, int nHeight, int hWndParent, int nID);

            [DllImport("avicap32.dll")]
            static extern bool capGetDriverDescriptionA(short wDriver, string lpszName, int cbName, string lpszVer, int cbVer);
            
            private void cmdLigarWebCam()
            {
                int height = pictureBoxFoto.Height;
                int widht = pictureBoxFoto.Width;

                try
                {
                    hHwnd = capCreateCaptureWindowA("WEBCAM", (WS_VISIBLE | WS_CHILD), 0, 0, 149, 126, this.pictureBoxFoto.Handle.ToInt32(), 0);
                    SendMessage(hHwnd, WM_CAP_DRIVER_CONNECT, 0, 0);
                    SendMessage(hHwnd, WM_CAP_SET_SCALE, 66, 0);
                    SendMessage(hHwnd, WM_CAP_SET_PREVIEWRATE, 66, 0);
                    SendMessage(hHwnd, WM_CAP_SET_PREVIEW, 66, 0);
                    SetWindowPos(hHwnd, HWND_BOTTOM, 0, 0, pictureBoxFoto.Width, pictureBoxFoto.Height, (SWP_NOMOVE | SWP_NOZORDER));
                }
                catch (Exception ex)
                {
                    throw new Exception("Erro ao ligar WebCam!" + Environment.NewLine + "Detalhes: " + ex.Message);
                }
                Refresh();
            }
            private void cmdDesligarWebCam()
            {
                try
                {
                    SendMessage(hHwnd, WM_CAP_DRIVER_DISCONNECT, 0, 0);
                    DestroyWindow(hHwnd);
                }
                catch (Exception ex)
                {
                    throw new Exception("Erro ao desconectar câmera" + "Detalhes: " + ex.Message);
                }
                Refresh();
            }
            private void cmdCapturarFoto()
            {
                try
                {
                    SendMessage(hHwnd, WM_CAP_EDIT_COPY, 0, 0);
                    dados = Clipboard.GetDataObject();
                    if (dados.GetDataPresent(typeof(System.Drawing.Bitmap)))
                    {
                        bmap = ((Image)(dados.GetData(typeof(System.Drawing.Bitmap))));
                        pictureBoxFoto.Image = bmap;
                        //PictureBox.Image = pictureBoxFoto.Image;
                    }
                }
                catch (Exception ex)
                {
                    throw new Exception("Erro ao capturar imagem!" + Environment.NewLine + "Detalhes: " + ex.Message);
                }
                Refresh();
            }
        

        private void buttonOnOff_Click(object sender, EventArgs e)
        {
            switch (buttonOnOff.Text)
            {
                case "On":
                    buttonOnOff.Text = "Off";
                    buttonFotografar.Enabled = true;
                    cmdLigarWebCam();
                    break;
                case "Off":
                    buttonOnOff.Text = "On";
                    buttonFotografar.Enabled = false;
                    cmdDesligarWebCam();
                    break;
                default:
                    buttonOnOff.Text = "Off";
                    buttonFotografar.Enabled = true;
                    cmdLigarWebCam();
                    break;
            }
            
        }

        private void buttonFotografar_Click(object sender, EventArgs e)
        {
            buttonOnOff.Text = "On";
            buttonFotografar.Enabled = false;
            cmdCapturarFoto();
            Beep(1000, 100);
            cmdDesligarWebCam();
        }
        #endregion

        private bool cmdValidarEmail(string email)
        {
            // Expressão regular que vai validar os e-mails  
            string emailRegex = @"^(([^<>()[\]\\.,;áàãâäéèêëíìîïóòõôöúùûüç:\s@\""]+"
                    + @"(\.[^<>()[\]\\.,;áàãâäéèêëíìîïóòõôöúùûüç:\s@\""]+)*)|(\"".+\""))@"
                    + @"((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|"
                    + @"(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$";
            // Instância da classe Regex, passando como   
            // argumento sua Expressão Regular
            Regex regex = new Regex(emailRegex);
            // Método IsMatch da classe Regex que retorna  
            // verdadeiro caso o e-mail passado estiver  
            // dentro das regras da sua regex.
            return regex.IsMatch(email);
        }

        private void FormPerfil_Load(object sender, EventArgs e)
        {
            //preprando procedimento para descriptar as senhas no banco
            LIB.Crypt _crypt = new LIB.Crypt(CryptProvider.Rijndael);
            _crypt.Key = "mmstec";

            BLL.usuarios comando = new BLL.usuarios();
            TAB.usuarios registro = new TAB.usuarios();
            textBoxCodigo.Text = strUsuariosID;
            textBoxNome.Text = strUsuariosNome;
            textBoxLogin.Text = strUsuariosLogin;
            textBoxSenha.Text = _crypt.Decrypt(strUsuariosSenha); // descriptado
            textBoxSenhaRepetir.Text = textBoxSenha.Text;
            comboBoxPerfil.SelectedItem = strUsuariosPerfil;
            textBoxEmail.Text = strUsuariosEmail;
            
            if ((parUsuariosFoto != null) && (parUsuariosFoto.Length != 0))
            {
                pictureBoxFoto.Image = Library.cmdByteToImage(parUsuariosFoto);
            }
            else
            {
                pictureBoxFoto.Image = Properties.Resources.user;
            }

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
            registro.usuariosFoto = Library.cmdImagemParaByte(pictureBoxFoto.Image, ImageFormat.Png);
 
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
                case "select":
                    Close();
                    break;
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

        private void textBoxEmail_Validating(object sender, CancelEventArgs e)
        {
            if (strComando != "select")
            {
                if (!cmdValidarEmail(textBoxEmail.Text))
                {
                    errorProvider.SetError(textBoxEmail, "E-mail inválido. Por favor, informe um e-mail válido.");
                    e.Cancel = true;
                    toolStripButtonGravar.Enabled = false;
                }
                else
                {
                    errorProvider.SetError(textBoxEmail, "");
                    toolStripButtonGravar.Enabled = true;
                }
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
