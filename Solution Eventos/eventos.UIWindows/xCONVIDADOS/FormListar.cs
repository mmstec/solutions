using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.Common;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Threading;
using System.Reflection;
using eventos.TAB;
using eventos.BLL;


namespace eventos.UIWindows.xCONVIDADOS
{
    public partial class FormListar : Form
    {
        #region parametros do usuário corrente
        public string usuarioId;
        public string usuarioNome;
        public string usuarioLogin;
        public string usuarioPerfil;
        public string UsuariosEmail;
        #endregion

        public DataSet ds;
        public BindingSource bs;
        public DataAdapter da;
        public int linhaAtual = 0;
        public string campo = "convidadosNome";
        public string filtro = string.Empty;

        public FormListar()
        {
            InitializeComponent();
            labelTitulo.Text = "LISTA DE CONVIDADOS";
            labelSubTitulo.Text = "";
            this.Text = labelTitulo.Text;
        }

        private void Filtrar(string ISQL)
        {
            DateTime tempoinicio = DateTime.Now;

            if (ISQL.Length <= 0)
            {
                ISQL = "SELECT * FROM convidados";
            }
            BLL.convidados convidados = new BLL.convidados();
            bs = new BindingSource();
            bs.DataSource = convidados.retornarQueryDataTable(ISQL);
            bindingNavigator1.BindingSource = bs;
            dataGridView1.DataSource = bs;


            int RegTotal = dataGridView1.Rows.Count;
            for (int i = 0; i < RegTotal; i++)
            {
                if (dataGridView1.Rows[i].Cells[5].Value.ToString().Trim() == "AUSENTE")
                {
                    dataGridView1.Rows[i].DefaultCellStyle.ForeColor = Color.Black;
                    dataGridView1.Rows[i].DefaultCellStyle.BackColor = Color.White;
                    dataGridView1.Rows[i].Cells[0].Value = Properties.Resources.misc_branco;
                }
                else if (dataGridView1.Rows[i].Cells[5].Value.ToString().Trim() == "PRESENTE")
                {
                    dataGridView1.Rows[i].DefaultCellStyle.ForeColor = Color.Black;
                    dataGridView1.Rows[i].DefaultCellStyle.BackColor = Color.LightCyan;
                    dataGridView1.Rows[i].Cells[0].Value = Properties.Resources.misc_green;
                }
                else
                {
                    dataGridView1.Rows[i].DefaultCellStyle.ForeColor = Color.Orange;
                    dataGridView1.Rows[i].DefaultCellStyle.BackColor = Color.White;
                    dataGridView1.Rows[i].Cells[0].Value = Properties.Resources.misc_red;
                }
                
                dataGridView1.Columns[1].Visible = false;
                dataGridView1.Columns[3].Width = 200;
                
                dataGridView1.Columns[1].HeaderText = "ID";
                dataGridView1.Columns[2].HeaderText = "CARTÃO";
                dataGridView1.Columns[3].HeaderText = "NOME";
                dataGridView1.Columns[4].HeaderText = "TIPO";
                dataGridView1.Columns[5].HeaderText = "SITUAÇÃO";
            }
            dataGridView1.SelectionMode = DataGridViewSelectionMode.FullRowSelect;
            toolStripTextBoxPesquisar.Focus();
            toolStripTextBoxPesquisar.Select();
            toolStripLabelStatus1.ToolTipText = "Operação realizada em " + LIB.Library.cmdCronometro("F", tempoinicio);
            if (linhaAtual >= 0)
            {
                bs.Position = linhaAtual;
            }
            else
            {
                bs.Position = 0;
            }
        }

        private void FormListar_Load(object sender, EventArgs e)
        {

            switch (usuarioPerfil)
            {
                case "administrador":
                case "gerente":
                    // visualizar, incluir, alterar, apagar
                    adicionarToolStripMenuItem.Enabled = true;
                    alterarToolStripMenuItem.Enabled = true;
                    excluirToolStripMenuItem.Enabled = true;
                    break;
                case "supervisor":
                    // visualizar, incluir, alterar
                    adicionarToolStripMenuItem.Enabled = true;
                    alterarToolStripMenuItem.Enabled = true;
                    excluirToolStripMenuItem.Enabled = false;
                    break;
                case "operador":
                    // visualizar, incluir
                    adicionarToolStripMenuItem.Enabled = true;
                    alterarToolStripMenuItem.Enabled = false;
                    excluirToolStripMenuItem.Enabled = false;
                    break;
                case "usuario":
                    // visualizar
                    adicionarToolStripMenuItem.Enabled = false;
                    alterarToolStripMenuItem.Enabled = false;
                    excluirToolStripMenuItem.Enabled = false;
                    break;
            }

            toolStripComboBoxProcurar.SelectedIndex = 0;
            dataGridView1.AllowUserToAddRows = false;
            dataGridView1.AllowUserToDeleteRows = false;
            dataGridView1.ReadOnly = true;
            Filtrar("SELECT * FROM convidados WHERE " + campo + " LIKE '" + toolStripTextBoxPesquisar.Text + "%' " + filtro);
        }

        private void toolStripComboBoxProcurar_SelectedIndexChanged(object sender, EventArgs e)
        {
            switch (toolStripComboBoxProcurar.SelectedIndex)
            {
                case 0:
                    campo = "convidadosNome";
                    toolStripTextBoxProcurar.MaxLength = 255;
                    break;
                case 1:
                    campo = "convidadosCartao";
                    toolStripTextBoxProcurar.MaxLength = 8;
                    break;
            }
        }

        private void dataGridView1_Sorted(object sender, EventArgs e)
        {
            int RegTotal = dataGridView1.Rows.Count;
            for (int i = 0; i < RegTotal; i++)
            {
                linhaAtual = dataGridView1.CurrentRow.Index;
                if (dataGridView1.Rows[i].Cells[5].Value.ToString().Trim() == "AUSENTE")
                {
                    dataGridView1.Rows[i].DefaultCellStyle.ForeColor = Color.Black;
                    dataGridView1.Rows[i].DefaultCellStyle.BackColor = Color.White;
                    dataGridView1.Rows[i].Cells[0].Value = Properties.Resources.misc_branco;
                }
                else if (dataGridView1.Rows[i].Cells[5].Value.ToString().Trim() == "PRESENTE")
                {
                    dataGridView1.Rows[i].DefaultCellStyle.ForeColor = Color.Black;
                    dataGridView1.Rows[i].DefaultCellStyle.BackColor = Color.LightCyan;
                    dataGridView1.Rows[i].Cells[0].Value = Properties.Resources.misc_green;
                }
                else
                {
                    dataGridView1.Rows[i].DefaultCellStyle.ForeColor = Color.Orange;
                    dataGridView1.Rows[i].DefaultCellStyle.BackColor = Color.White;
                    dataGridView1.Rows[i].Cells[0].Value = Properties.Resources.misc_red;
                }

                dataGridView1.Columns[1].Visible = false;
                dataGridView1.Columns[3].Width = 200;
                dataGridView1.Columns[1].HeaderText = "ID";
                dataGridView1.Columns[2].HeaderText = "CARTÃO";
                dataGridView1.Columns[3].HeaderText = "NOME";
                dataGridView1.Columns[4].HeaderText = "TIPO";
                dataGridView1.Columns[5].HeaderText = "SITUAÇÃO";
            }
        }

        private void dataGridView1_RowEnter(object sender, DataGridViewCellEventArgs e)
        {
            if (dataGridView1.CurrentRow != null)
            {
                    switch (dataGridView1[5, e.RowIndex].Value.ToString())
                    {
                        case "AUSENTE":  //Convidado Ausente
                            toolTip1.SetToolTip(pictureBoxStatus, "(AUSENTE) presença confirmada.");
                            pictureBoxStatus.Image = Properties.Resources.button_withe;
                            dataGridView1[0, e.RowIndex].Value = Properties.Resources.misc_branco;
                            break;
                        case "PRESENTE":  //Convidado Presnte
                            toolTip1.SetToolTip(pictureBoxStatus, "(PRESENTE) preseça não-confirmada."); 
                            pictureBoxStatus.Image = Properties.Resources.button_green;
                            dataGridView1[0, e.RowIndex].Value = Properties.Resources.misc_green;
                            break;
                        default:
                            toolTip1.SetToolTip(pictureBoxStatus, "(VERIFICAR) PROBLEMAS COM ESTE REGISTRO");
                            pictureBoxStatus.Image = Properties.Resources.button_red;
                            dataGridView1[0, e.RowIndex].Value = Properties.Resources.misc_red;
                            break;
                    }
            }
        }

        private void adicionarToolStripMenuItem_Click(object sender, EventArgs e)
        {
            FormPerfil frm = new FormPerfil("insert");
            frm.strConvidadosID = string.Empty;
            frm.strConvidadosCartao = string.Empty;
            frm.strConvidadosNome = string.Empty;
            frm.strConvidadosPresenca = string.Empty;
            frm.strConvidadosTipo = string.Empty;
            frm.strTitulo = "ADICIONAR REGISTRO";
            frm.ShowDialog();
            Filtrar("SELECT * FROM convidados WHERE convidadosNome LIKE '%' " + filtro);
        }

        private void alterarToolStripMenuItem_Click(object sender, EventArgs e)
        {
            FormPerfil frm = new FormPerfil("update");
            frm.strConvidadosID = dataGridView1.Rows[linhaAtual].Cells["convidadosId"].Value.ToString();
            frm.strConvidadosCartao = dataGridView1.Rows[linhaAtual].Cells["convidadosCartao"].Value.ToString();
            frm.strConvidadosNome = dataGridView1.Rows[linhaAtual].Cells["convidadosNome"].Value.ToString();
            frm.strConvidadosPresenca = dataGridView1.Rows[linhaAtual].Cells["convidadosPresenca"].Value.ToString();
            frm.strConvidadosTipo = dataGridView1.Rows[linhaAtual].Cells["convidadosTipo"].Value.ToString();
            frm.strTitulo = "ALTERAR REGISTRO";
            frm.ShowDialog();
            Filtrar("SELECT * FROM convidados WHERE convidadosNome LIKE '%' " + filtro);
        }

        private void excluirToolStripMenuItem_Click(object sender, EventArgs e)
        {
            FormPerfil frm = new FormPerfil("delete");
            frm.strConvidadosID = dataGridView1.Rows[linhaAtual].Cells["convidadosId"].Value.ToString();
            frm.strConvidadosCartao = dataGridView1.Rows[linhaAtual].Cells["convidadosCartao"].Value.ToString();
            frm.strConvidadosNome = dataGridView1.Rows[linhaAtual].Cells["convidadosNome"].Value.ToString();
            frm.strConvidadosPresenca = dataGridView1.Rows[linhaAtual].Cells["convidadosPresenca"].Value.ToString();
            frm.strConvidadosTipo = dataGridView1.Rows[linhaAtual].Cells["convidadosTipo"].Value.ToString();
            frm.strTitulo = "EXCLUIR REGISTRO (ATENÇÃO!)";
            frm.ShowDialog();
            Filtrar("SELECT * FROM convidados WHERE convidadosNome LIKE '%' " + filtro);
        }

        private void toolStripTextBox2_TextChanged(object sender, EventArgs e)
        {
            Filtrar("SELECT * FROM convidados WHERE " +campo+ " LIKE '" +toolStripTextBoxProcurar.Text+ "%' " +filtro);
        }

        private void dataGridView1_MouseClick(object sender, MouseEventArgs e)
        {
            linhaAtual = dataGridView1.CurrentRow.Index;
            dataGridView1.SelectionMode = DataGridViewSelectionMode.FullRowSelect;
        }

        private void toolStripButtonImprimir_Click(object sender, EventArgs e)
        {
            printDGV.Print_DataGridView(dataGridView1, "LISTA DE CONVIDADOS");
        }

        private void toolStripSplitButtonExibir_ButtonClick(object sender, EventArgs e)
        {
            Filtrar("SELECT * FROM convidados WHERE " + campo + " LIKE '" + toolStripTextBoxPesquisar.Text + "%' " + filtro);
        }

        private void toolStripMenuItemTodos_Click(object sender, EventArgs e)
        {
            filtro = " AND convidadosPresenca LIKE 'PRESENTE%' OR convidadosPresenca LIKE 'AUSENTE%'";
            toolStripMenuItemTodos.Checked = true;
            toolStripMenuItemAusentes.Checked = false;
            toolStripMenuItemPresentes.Checked = false;
            toolStripExibir.Text = "Exibir Todos";
            Filtrar("SELECT * FROM convidados WHERE " + campo + " LIKE '" + toolStripTextBoxPesquisar.Text + "%' " + filtro);
        }

        private void toolStripMenuItemAusentes_Click(object sender, EventArgs e)
        {
            filtro = " AND convidadosPresenca LIKE 'AUSENTE%'";
            toolStripMenuItemTodos.Checked = false;
            toolStripMenuItemAusentes.Checked = true;
            toolStripMenuItemPresentes.Checked = false;
            toolStripExibir.Text = "Exibir Ausentes";
            Filtrar("SELECT * FROM convidados WHERE " + campo + " LIKE '" + toolStripTextBoxPesquisar.Text + "%' " + filtro);
        }

        private void toolStripMenuItemPresentes_Click(object sender, EventArgs e)
        {
            filtro = " AND convidadosPresenca LIKE 'PRESENTE%'";
            toolStripMenuItemTodos.Checked = false;
            toolStripMenuItemAusentes.Checked = false;
            toolStripMenuItemPresentes.Checked = true;
            toolStripExibir.Text = "Exibir Presentes";
            Filtrar("SELECT * FROM convidados WHERE " + campo + " LIKE '" + toolStripTextBoxPesquisar.Text + "%' " + filtro);
        }

        private void dataGridView1_CellFormatting(object sender, DataGridViewCellFormattingEventArgs e)
        {
            if (e.RowIndex > -1)
            {
                //Faz o grid ficar zebrado
                if (e.RowIndex % 2 == 0)
                {
                    e.CellStyle.BackColor = Color.WhiteSmoke;
                }
                else
                {
                    e.CellStyle.BackColor = Color.White;
                }
            }
        }

      

    }
}
