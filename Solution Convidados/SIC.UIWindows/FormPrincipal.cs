using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace EVENTOS.UIWindows
{
    public partial class FormPrincipal : Form
    {
        public FormPrincipal()
        {
            InitializeComponent();
        }
        private void FormPrincipal_Load(object sender, EventArgs e)
        {

        }
 
        private void testeToolStripMenuItem_Click(object sender, EventArgs e)
        {

            string setTitulo = eventosToolStripMenuItem.Text;
            string setSubtitulo = "Registro de convidados";

            try
            {
                /// <summary>
                /// Autor: Marcos
                /// CHAMA FORM PARA TESTES
                /// </summary> 
                /// <param name="texto">chama form</param>
                /// <returns>chama form</returns>
                FormConsultar frm = new FormConsultar();
                frm.ClientSize = new System.Drawing.Size(634, 456);  // equivale a 640x480
                frm.MaximizeBox = false;
                frm.MinimizeBox = false;
                frm.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
                frm.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog;
                frm.ShowDialog();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Erro: " + ex.Message.ToString(), "Erro", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }
        
        private void convidadosPorEventosToolStripMenuItem_Click(object sender, EventArgs e)
        {
            string setSql = "SELECT Eventos.NomeEvento as Evento, Convidados.NomeConvidado as Convidado, Convidados.TipoConvidado, Convidados.SituacaoConvidado, Convidados.ObsConvidado FROM Eventos INNER JOIN (Convidados INNER JOIN ConvidadosPorEventos ON Convidados.CodigoConvidado = ConvidadosPorEventos.CodigoConvidado) ON Eventos.CodigoEvento = ConvidadosPorEventos.CodigoEvento";
            string setTitulo = eventosToolStripMenuItem.Text;
            string setSubtitulo = "Registro de convidados";
   
            try
            {
                /// <summary>
                /// Autor: Marcos
                /// </summary> 
                /// <param name="texto">chama form</param>
                /// <returns>chama form</returns>
                FormConsultar frm = new FormConsultar(setSql, setTitulo, setSubtitulo);
                frm.ClientSize = new System.Drawing.Size(634, 456);  // equivale a 640x480
                frm.MaximizeBox = false;
                frm.MinimizeBox = false;
                frm.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
                frm.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog;
                frm.ShowDialog();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Erro: " + ex.Message.ToString(), "Erro", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void eventosToolStripMenuItem_Click(object sender, EventArgs e)
        {
            string setSql = "SELECT * from Eventos";
            string setTitulo = eventosToolStripMenuItem.Text;
            string setSubtitulo = "Registro de eventos";

            try
            {
                /// <summary>
                /// Autor: Marcos
                /// </summary> 
                /// <param name="texto">chama form</param>
                /// <returns>chama form</returns>
                FormConsultar frm = new FormConsultar(setSql,setTitulo,setSubtitulo);
                frm.ClientSize = new System.Drawing.Size(634, 456);  // equivale a 640x480
                frm.MaximizeBox = false;
                frm.MinimizeBox = false;
                frm.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
                frm.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog;
                frm.ShowDialog();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Erro: " + ex.Message.ToString(), "Erro", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }

        }

        private void sairToolStripMenuItem2_Click(object sender, EventArgs e)
        {
            ClassComandos.Comando.cmdSair();
        }
    }
}
