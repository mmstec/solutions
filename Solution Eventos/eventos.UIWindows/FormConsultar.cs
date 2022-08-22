using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using eventos.BLL;
using System.Collections;
using System.Configuration;

namespace eventos.UIWindows
{

    public partial class FormConsultar : Form
    {
        [System.Runtime.InteropServices.DllImport("kernel32.dll")]
        public static extern bool Beep(UInt32 frequency, UInt32 duration);

        public string usuarioId;
        public string usuarioNome;
        public string usuarioLogin;
        public string usuarioPerfil;
        public DateTime usuarioUltLogin;
        public string strConvidadosID;
        public string strConvidadosCartao;
        public string strConvidadosNome;
        public string strConvidadosTipo;
        public string strConvidadosPresenca;
        public string strBotaoRegistrar;
        public int digitos;
        public int tecla;
        string empresaLogo = ConfigurationManager.AppSettings["empresaLogo"];

        public FormConsultar(string pUsuarioID, string pUsuarioNome, string pUsuarioPerfil, DateTime pUsuarioUltLogin)
        {
            InitializeComponent();
            pictureBoxLogo.ImageLocation = empresaLogo;
            usuarioId = pUsuarioID;
            usuarioNome = pUsuarioNome;
            usuarioPerfil = pUsuarioPerfil;
            usuarioUltLogin = pUsuarioUltLogin;
        }

        private void button1_Click(object sender, EventArgs e)
        {

            BLL.convidados comando = new BLL.convidados();
            TAB.convidados registro = new TAB.convidados();
            registro.convidadosCartao = strConvidadosCartao;
            registro.convidadosNome = strConvidadosNome;
            registro.convidadosTipo = strConvidadosTipo;
            registro.convidadosPresenca = strBotaoRegistrar;
            registro.convidadosId = Convert.ToInt32(strConvidadosID);
            comando.executarUpdate(registro);

            textBoxPesquisar.Text = string.Empty;
            labelConvidadoNome.Text = string.Empty;
            labelConvidadoPerfil.Text = string.Empty;
            buttonConfirmarPresença.Visible = false;
            buttonConfirmarPresençaNão.Visible = false;
            this.BackColor = System.Drawing.SystemColors.HotTrack;
            Beep(1000, 300);

        }

        private void pictureBox1_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void textBoxPesquisar_TextChanged(object sender, EventArgs e)
        {
            digitos = textBoxPesquisar.Text.Length;
            label1.Text = digitos.ToString();
            string query = "SELECT convidadosId, convidadosCartao, convidadosNome, convidadosTipo, convidadosPresenca FROM convidados WHERE convidadosCartao LIKE '" + textBoxPesquisar.Text + "'";
            BLL.convidados registro = new BLL.convidados();
            DataTable dt = registro.retornarQueryDataTable(query);

            if (textBoxPesquisar.Text.Trim() == string.Empty || digitos < 8)
            {
                    labelConvidadoNome.Text = string.Empty;
                    labelConvidadoPerfil.Text = string.Empty;
                    buttonConfirmarPresença.Visible = false;
                    buttonConfirmarPresençaNão.Visible = false;
                    this.BackColor = System.Drawing.SystemColors.HotTrack;
                    pictureBox2.Image = Properties.Resources.lupa_128x;
                    textBoxPesquisar.Focus();
                    textBoxPesquisar.Select();
            }
            else if (dt.Rows.Count > 0)
            {
                    if (digitos >= 8)
                    {
                        for (int i = 0; i < dt.Rows.Count; i++)
                        {
                            labelConvidadoNome.Text = "(" + dt.Rows[i].ItemArray[3].ToString() + ") " + dt.Rows[i].ItemArray[2].ToString();
                            this.BackColor = System.Drawing.Color.Green;
                            if (dt.Rows[i].ItemArray[4].ToString() == "PRESENTE")
                            {
                                strBotaoRegistrar = "AUSENTE";
                                buttonConfirmarPresença.Text = "REGISTRAR AUSENCIA";
                                buttonConfirmarPresença.BackColor = System.Drawing.Color.Yellow;
                                buttonConfirmarPresençaNão.Visible = true;
                                pictureBox2.Image = Properties.Resources.escudoAmarelo_128x;
                                labelConvidadoPerfil.Text = "ATENÇÃO: A presença do convidado já foi registrada.";
                                buttonConfirmarPresença.Visible = false;
                                buttonConfirmarPresençaNão.Visible = false;
                                this.BackColor = System.Drawing.Color.Orange;
                                Beep(5000, 200);
                            }
                            else
                            {
                                strBotaoRegistrar = "PRESENTE";
                                buttonConfirmarPresença.Text = "REGISTRAR PRESENÇA";
                                buttonConfirmarPresença.BackColor = System.Drawing.Color.Lime;
                                //labelConvidadoPerfil.Text = "ESTE CONVIDADO ESTA REGISTRADO COMO <AUSENTE>.";
                                pictureBox2.Image = Properties.Resources.escudoVerde_128x;
                                buttonConfirmarPresença.Visible = true;
                                buttonConfirmarPresençaNão.Visible = true;
                                Beep(500, 100);
                            }
                            strConvidadosID = dt.Rows[i].ItemArray[0].ToString();
                            strConvidadosCartao = dt.Rows[i].ItemArray[1].ToString();
                            strConvidadosNome = dt.Rows[i].ItemArray[2].ToString();
                            strConvidadosTipo = dt.Rows[i].ItemArray[3].ToString();
                            strConvidadosPresenca = dt.Rows[i].ItemArray[4].ToString();
                        }
                    }
                }
                else
                {
                    labelConvidadoNome.Text = "NÃO LOCALIZADO.";
                    labelConvidadoPerfil.Text = string.Empty;
                    buttonConfirmarPresença.Visible = false;
                    buttonConfirmarPresençaNão.Visible = false;
                    this.BackColor = System.Drawing.Color.OrangeRed;
                    pictureBox2.Image = Properties.Resources.escudoVermelho_128x;
                    if (textBoxPesquisar.Text.Length >= 8)
                    {
                        Beep(1000, 300);
                    }
                }
            
      

        }

        private void FormConsultar_Load(object sender, EventArgs e)
        {
            textBoxPesquisar.Focus();
            textBoxPesquisar.Select();
            labelConvidadoNome.Text = string.Empty;
            labelConvidadoPerfil.Text = string.Empty;
        }
        private void textBoxPesquisar_KeyPress(object sender, KeyPressEventArgs e)
        {
            //permitindo apenas números...
            if (!Char.IsDigit(e.KeyChar) && e.KeyChar != (char)8)
            {
                e.Handled = true;
            }
         
            /*if (e.KeyChar >= 48 && e.KeyChar <= 57)
            {
                MessageBox.Show("Control.KeyPress: '" +
                    e.KeyChar.ToString() + "' pressed.");

                switch (e.KeyChar)
                {
                    case (char)50:
                    case (char)53:
                    case (char)56:
                        MessageBox.Show("Control.KeyPress: '" +
                            e.KeyChar.ToString() + "' consumed.");
                        e.Handled = true;
                        break;
                }
            }*/
        }
        private void buttonConfirmarPresençaNão_Click_1(object sender, EventArgs e)
        {
            textBoxPesquisar.Text = string.Empty;
            labelConvidadoNome.Text = string.Empty;
            labelConvidadoPerfil.Text = string.Empty;
            buttonConfirmarPresença.Visible = false;
            buttonConfirmarPresençaNão.Visible = false;
            this.BackColor = System.Drawing.SystemColors.HotTrack;
        }

        private void button1_Click_1(object sender, EventArgs e)
        {
            this.Close();
        }

        private void FormConsultar_FormClosing(object sender, FormClosingEventArgs e)
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

        private void textBoxPesquisar_Click(object sender, EventArgs e)
        {
            textBoxPesquisar.Text = string.Empty;
        }

        private void textBoxPesquisar_KeyDown(object sender, KeyEventArgs e)
        {
            switch (e.KeyCode)
            {
                case Keys.F2:
                    textBoxPesquisar.Text = string.Empty;
                    textBoxPesquisar.SelectAll();
                    textBoxPesquisar.Focus();
                    break;
                case Keys.F10:
                    MessageBox.Show("F10: Disponível nas próximas versões.");
                    break;
                case Keys.F12:
                    MessageBox.Show("F12: Disponível nas próximas versões.");
                    break;
            }
        }
    }
}
