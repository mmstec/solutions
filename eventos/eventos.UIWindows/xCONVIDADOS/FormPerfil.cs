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

namespace eventos.UIWindows.xCONVIDADOS
{
    public partial class FormPerfil : Form
    {
        [System.Runtime.InteropServices.DllImport("kernel32.dll")]
        public static extern bool Beep(UInt32 frequency, UInt32 duration);
        public string strConvidadosID;
        public string strConvidadosCartao, strConvidadosNome, strConvidadosTipo, strConvidadosPresenca;
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
            textBoxCodigo.Text = strConvidadosID;
            textBoxCartao.Text = strConvidadosCartao;
            textBoxNome.Text = strConvidadosNome;
            comboBoxPerfil.SelectedItem = strConvidadosTipo;
            comboBoxPresenca.SelectedItem = strConvidadosPresenca;
            labelTitulo.Text = strTitulo;
            this.Text = strTitulo;
            textBoxCartao.Focus();
            textBoxCartao.Select();

            switch (strConvidadosPresenca.ToUpper())
            {
                case "AUSENTE":  //Convidado Ausente
                    pictureBoxStatus.Image = Properties.Resources.button_withe;
                    break;
                case "PRESENTE":  //Convidado Presnte
                    pictureBoxStatus.Image = Properties.Resources.button_green;
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
            BLL.convidados comando = new BLL.convidados();
            TAB.convidados registro = new TAB.convidados();
            registro.convidadosCartao = textBoxCartao.Text;
            registro.convidadosNome = textBoxNome.Text;
            registro.convidadosTipo = comboBoxPerfil.Text;
            registro.convidadosPresenca = comboBoxPresenca.Text;
            
            switch(strComando){
                case "insert":
                    comando.executarInsert(registro);
                    Beep(500, 100);
                    break;
                case "update":
                    registro.convidadosId = Convert.ToInt32(textBoxCodigo.Text);
                    comando.executarUpdate(registro);
                    Beep(500, 100);
                    break;
                case "delete":
                    if (MessageBox.Show("Confirma exclusão permanente? ", "Excluir", MessageBoxButtons.YesNo) == DialogResult.Yes)
                    {
                        registro.convidadosId = Convert.ToInt32(textBoxCodigo.Text);
                        comando.executarDelete(registro.convidadosId);
                        Beep(1000, 300);
                    }
                    break;
                default:
                    Close();
                    break;
            }
            Close();
        }
        
        private void textBoxCartao_Validated(object sender, EventArgs e)
        {
            textBoxCartao.Text = textBoxCartao.Text.PadLeft(8, '0');
        }
 
        private void textBoxCartao_Validating(object sender, CancelEventArgs e)
        {
            if(textBoxCartao.Text.Length <=0) 
            {
                errorProvider.SetError(textBoxCartao, "Digite um código de 8 digitos");
                e.Cancel = true;
                toolStripButtonGravar.Enabled = false;
            }
            else
            {
                textBoxCartao.Text = textBoxCartao.Text.PadLeft(8, '0');
                errorProvider.SetError(textBoxCartao, "");
                toolStripButtonGravar.Enabled = true;
            }
        }

        private void textBoxNome_Validating(object sender, CancelEventArgs e)
        {
            if (textBoxNome.Text.Length <= 0)
            {
                errorProvider.SetError(textBoxNome, "Digite um nome para o convidado");
                e.Cancel = true;
                toolStripButtonGravar.Enabled = false;
            }
            else
            {
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
                errorProvider.SetError(comboBoxPresenca, "INforme a presença ou ausencia do convidado");
                e.Cancel = true;
                toolStripButtonGravar.Enabled = false;
            }
            else
            {
                errorProvider.SetError(comboBoxPresenca, "");
                toolStripButtonGravar.Enabled = true;
            }
        }
    }
}
