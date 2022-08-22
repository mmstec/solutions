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
using System.Configuration;

namespace eventos.UIWindows
{
    public partial class FormPrincipal : Form
    {
        string empresaNome = ConfigurationManager.AppSettings["empresaNome"];
        string empresaCNPJ = ConfigurationManager.AppSettings["empresaCNPJ"];
        string empresaContato = ConfigurationManager.AppSettings["empresaContato"];
        string empresaImpressora = ConfigurationManager.AppSettings["empresaImpressora"];
        string empresaLogo = ConfigurationManager.AppSettings["empresaLogo"];
        string sistemaNome = ConfigurationManager.AppSettings["sistemaNome"];
        string sistemaVersao = ConfigurationManager.AppSettings["sistemaVersao"];
        string sistemaAutor = ConfigurationManager.AppSettings["sistemaAutor"];
        string sistemaData = ConfigurationManager.AppSettings["sistemaData"];
        string sistemaDataLimite = ConfigurationManager.AppSettings["sistemaDataLimite"];
        public string usuarioId;
        public string usuarioNome;
        public string usuarioLogin;
        public string usuarioPerfil;
        public DateTime usuarioUltLogin;

        public FormPrincipal(string pUsuarioID, string pUsuarioNome, string pUsuarioPerfil, DateTime pUsuarioUltLogin)
        {
            usuarioId = pUsuarioID;
            usuarioNome = pUsuarioNome;
            usuarioPerfil = pUsuarioPerfil;
            usuarioUltLogin = pUsuarioUltLogin;
            
            InitializeComponent();
            pictureBoxLogo.ImageLocation = empresaLogo;
            toolStripStatusLabelPefil.Text = String.Format("{0}:", pUsuarioPerfil.ToUpperInvariant());
            toolStripStatusLabelLogin.Text = String.Format("{0}", pUsuarioNome.ToUpper());
            toolStripStatusLabelDataLogin.Text = String.Format(" ÚLTIMO ACESSO: {0:dd/MM/yyyy HH:mm:ss}", pUsuarioUltLogin);
            toolStripStatusLabelDataExpira.Text = String.Format("{0}", sistemaDataLimite.ToUpper());
            timer1.Interval = 1000; // 1 segundo
            timer1.Start();

            //ATUALIZAR TABELA DE LOGIN COMO ONLINE
            BLL.usuarios comando = new BLL.usuarios();
            TAB.usuarios registro = new TAB.usuarios();
            registro.usuariosID = Convert.ToInt32(pUsuarioID);
            registro.usuariosOnline = true;
            registro.usuariosDataLogin = DateTime.Now.Date; 
            comando.executarUpdateLogin(registro);

            if(usuarioPerfil != "administrador")
            {
                toolStripMenuItemListaUsuarios.Enabled = false;
            }
        }

        private void FormPrincipal_Load(object sender, EventArgs e)
        {
            LIB.Crypt _crypt = new LIB.Crypt(CryptProvider.Rijndael);
            _crypt.Key = sistemaData;
            toolStripStatusLabelDataExpira.Text = String.Format("EXPIRA: {0}",_crypt.Decrypt(sistemaDataLimite));

            labelEmpresaNome.Text = empresaNome.ToUpper();
            labelSistemaNome.Text = sistemaNome.ToUpper() + " - " + sistemaVersao.ToUpper();
            labelSistemaDesenvolvedor.Text = sistemaAutor.ToUpper();
            this.Text = labelEmpresaNome.Text;
        }

        private void sairToolStripMenuItem2_Click(object sender, EventArgs e)
        {
            Close();
        }

        private void consultarToolStripMenuItem_Click_1(object sender, EventArgs e)
        {
                    try
                    {
                        /// <summary>
                        /// Autor: Marcos
                        /// CHAMA FORM
                        /// </summary> 
                        /// <param name="usuarioId, usuarioNome, usuarioPerfil, usuarioUltLogin">chama form</param>
                        /// <returns>ShowDialog()</returns>
                        FormConsultar frm = new FormConsultar(usuarioId, usuarioNome, usuarioPerfil, usuarioUltLogin);
                        //frm.ClientSize = new System.Drawing.Size(634, 456);  // equivale a 640x480
                        //frm.MaximizeBox = false;
                        //frm.MinimizeBox = false;
                        //frm.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
                        //frm.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog;
                        frm.ShowDialog();
                    }
                    catch (Exception ex)
                    {
                        MessageBox.Show("Erro: " + ex.Message.ToString(), "Erro", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    }
        }   

  
        private void toolStripMenuItemConsultaRapida_Click(object sender, EventArgs e)
        {
            try
            {
                /// <summary>
                /// Autor: Marcos
                /// CHAMA FORM
                /// </summary> 
                /// <param name="texto">chama form</param>
                /// <returns>chama form</returns>
                FormConsultar frm = new FormConsultar(usuarioId, usuarioNome, usuarioPerfil, usuarioUltLogin);
                //frm.ClientSize = new System.Drawing.Size(634, 456);  // equivale a 640x480
                //frm.MaximizeBox = false;
                //frm.MinimizeBox = false;
                //frm.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
                //frm.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog;
                frm.ShowDialog();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Erro: " + ex.Message.ToString(), "Erro", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void toolStripMenuItemSobre_Click(object sender, EventArgs e)
        {
            FormAboutBox frm = new FormAboutBox();
            frm.ShowDialog();
        }

       

        private void timer1_Tick(object sender, EventArgs e)
        {
            string relogio = DateTime.Now.ToLongDateString() + " - " + DateTime.Now.ToLongTimeString();
            char primeiraLetra = char.ToUpper(relogio[0]);
            relogio = primeiraLetra + relogio.Substring(1);
            toolStripStatusLabelRelogio.Text = relogio;
        }

        private void toolTip1_Popup(object sender, PopupEventArgs e)
        {
          
        }

        private void toolStripMenuItem2_Click(object sender, EventArgs e)
        {
            try
            {
                /// <summary>
                /// Autor: Marcos
                /// CHAMA FORM PARA TESTES
                /// </summary> 
                /// <param name="texto">chama form</param>
                /// <returns>chama form</returns>
                eventos.UIWindows.xCONVIDADOS.FormListar frm = new eventos.UIWindows.xCONVIDADOS.FormListar();
                frm.MaximizeBox = false;
                frm.MinimizeBox = false;
                frm.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
                frm.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog;
                frm.usuarioId = usuarioId;
                frm.usuarioNome = usuarioNome;
                frm.usuarioLogin = usuarioLogin;
                frm.usuarioPerfil = usuarioPerfil;
                frm.ShowDialog();

            }
            catch (Exception ex)
            {
                MessageBox.Show("Erro: " + ex.Message.ToString(), "Erro", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void toolStripMenuItem18_Click(object sender, EventArgs e)
        {
            try
            {
                /// <summary>
                /// Autor: Marcos
                /// CHAMA FORM PARA TESTES
                /// </summary> 
                /// <param name="texto">chama form</param>
                /// <returns>chama form</returns>
                eventos.UIWindows.xUSUARIOS.FormListar frm = new eventos.UIWindows.xUSUARIOS.FormListar();
                frm.MaximizeBox = false;
                frm.MinimizeBox = false;
                frm.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
                frm.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog;
                frm.usuarioId = usuarioId;
                frm.usuarioNome = usuarioNome;
                frm.usuarioLogin = usuarioLogin;
                frm.usuarioPerfil = usuarioPerfil;
                frm.ShowDialog();

            }
            catch (Exception ex)
            {
                MessageBox.Show("Erro: " + ex.Message.ToString(), "Erro", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void FormPrincipal_FormClosing(object sender, FormClosingEventArgs e)
        {
            DialogResult opcaoSelecionada;
            opcaoSelecionada = MessageBox.Show("Deseja mesmo sair do sistema?", "Pergunta", MessageBoxButtons.YesNo, MessageBoxIcon.Question);
            if (opcaoSelecionada.Equals(DialogResult.No))
            {
                e.Cancel = true;
            }
            else
            {
                //ATUALIZAR TABELA DE LOGIN COMO OFFLINE
                BLL.usuarios comando = new BLL.usuarios();
                TAB.usuarios registro = new TAB.usuarios();
                registro.usuariosID = Convert.ToInt32(usuarioId);
                registro.usuariosOnline = false;
                registro.usuariosDataLogin = registro.usuariosDataLogin;  // manter a data para registrar último login
                comando.executarUpdateLogin(registro);
            }
        }

        private void sairToolStripMenuItem1_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
