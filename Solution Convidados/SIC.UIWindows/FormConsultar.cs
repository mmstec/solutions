using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Threading;
using EVENTOS.BLL;
using System.Reflection;

namespace EVENTOS.UIWindows
{
    /// <summary>
    /// Enumerador com as opções de filtro da pesquisa de Clientes.
    /// </summary>
    enum Filtros
    {
        [Description("Código")]
            CodigoConvidado,
        [Description("Descrição")]
            NomeConvidado,
    }
    
    public partial class FormConsultar : Form
    {
        private string getSql;
        private int RegAtual = 0;


        //private bool editando = false;
        //private bool inserindo = false;

        public FormConsultar(string sql, string titulo, string subTitulo)
        {
            InitializeComponent();
            getSql = sql;
            labelTitulo.Text = titulo;
            labelSubTitulo.Text = subTitulo;
        }
        public FormConsultar(string sql)
        {
            InitializeComponent();
            getSql = sql;
            labelTitulo.Text = "Convidados";
            labelSubTitulo.Text = "Registro de convidados";
        }
        public FormConsultar()
        {
            InitializeComponent();
            getSql = "select * from Convidados";
            labelTitulo.Text = "Convidados";
            labelSubTitulo.Text = "Registro de convidados";
        }

        #region Atributos
        #endregion

        /// <summary>
        /// Autor: Marcos Morais
        /// Verifica presença do convidado
        /// </summary> 
        /// <param name="texto"></param>
        /// <returns></returns>
        //private void verificaPresenca(PictureBox parPictureBox, int codigo)
        private void verificaPresenca(PictureBox parPictureBox)
        {
            //objConvidados C = new objConvidados();
            //DataSet dsConvidados = C.Selecionar("SELECT * from convidados");

            if (dataGridView.CurrentRow.Cells[1].Value != null)
            {
                //switch (dsConvidados.Tables[0].Rows[0].Field<string>("situacaoConvidado"))
                switch(dataGridView.CurrentRow.Cells[1].Value.ToString())
                {
                    case "Ausente":
                        parPictureBox.Image = Properties.Resources.button_withe;
                        toolTip1.SetToolTip(parPictureBox, "AUSENTE - convidado não esta no evento.");
                        break;
                    case "Presente":
                        parPictureBox.Image = Properties.Resources.button_green; 
                        toolTip1.SetToolTip(parPictureBox, "PRESENTE - convidado esta no evento.");
                        break;
                    default:
                        parPictureBox.Image = Properties.Resources.button_red;
                        toolTip1.SetToolTip(parPictureBox, "VERIFICAR PROBLEMAS COM O CADASTRO");
                        break;
                }
            }
        }
        
        /// <summary>
        /// Obtém a descrição de um determinado Enumerador.
        /// </summary>
        /// <param name="valor">Enumerador que terá a descrição obtida.</param>
        /// <returns>String com a descrição do Enumerador.</returns>
        public static string ObterDescricao(Enum valor)
        {
            FieldInfo fieldInfo = valor.GetType().GetField(valor.ToString());
            DescriptionAttribute[] atributos = (DescriptionAttribute[])fieldInfo.GetCustomAttributes(typeof(DescriptionAttribute), false);
            return atributos.Length > 0 ? atributos[0].Description ?? "Nulo" : valor.ToString();
        }

        /// <summary>
        /// Retorna uma lista com os valores de um determinado enumerador.
        /// </summary>
        /// <param name="tipo">Enumerador que terá os valores listados.</param>
        /// <returns>Lista com os valores do Enumerador.</returns>
        public static System.Collections.IList Listar(Type tipo)
        {
            System.Collections.ArrayList lista = new System.Collections.ArrayList();
            if (tipo != null)
            {
                Array enumValores = Enum.GetValues(tipo);
                foreach (Enum valor in enumValores)
                {
                    lista.Add(new KeyValuePair<Enum, string>(valor, ObterDescricao(valor)));
                }
            }
            return lista;
        }

        #region Botões de Navegação
        private void toolStripButton6_Click(object sender, EventArgs e)
        {
            try
            {
                if (dataGridView.CurrentRow.Index != 0)
                {
                    dataGridView.CurrentCell = dataGridView.Rows[0].Cells[0];
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Erro: " + ex.Message.ToString(), "Erro", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void toolStripButton7_Click(object sender, EventArgs e)
        {
            try
            {
                if (dataGridView.CurrentRow.Index != 0)
                {
                    dataGridView.CurrentCell = dataGridView.Rows[dataGridView.CurrentRow.Index - 1].Cells[0];
                    RegAtual = dataGridView.CurrentRow.Index+1;
                    toolStripTextBoxRegistroAtual.Text = (RegAtual).ToString();
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Erro: " + ex.Message.ToString(), "Erro", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }
        private void toolStripButton8_Click(object sender, EventArgs e)
        {
            try
            {
                if (dataGridView.CurrentRow.Index != int.Parse(dataGridView.Rows[dataGridView.RowCount - 1].Cells[0].RowIndex.ToString()))
                {
                    dataGridView.CurrentCell = dataGridView.Rows[dataGridView.CurrentRow.Index + 1].Cells[0];
                    RegAtual = dataGridView.CurrentRow.Index + 1;
                    toolStripTextBoxRegistroAtual.Text = (RegAtual).ToString();
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Erro: " + ex.Message.ToString(), "Erro", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void toolStripButton9_Click(object sender, EventArgs e)
        {
            try
            {
                if (dataGridView.CurrentRow.Index != int.Parse(dataGridView.Rows[dataGridView.RowCount - 1].Cells[0].RowIndex.ToString()))
                {
                    dataGridView.CurrentCell = dataGridView.Rows[dataGridView.RowCount - 1].Cells[0];
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Erro: " + ex.Message.ToString(), "Erro", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }
        #endregion        

        public void comandoSQL()
        {
            try
            {
                DateTime tempoinicio = DateTime.Now;
                convidadosBll obj = new convidadosBll();
                dataGridView.DataSource = obj.dtRetornaDados(getSql);
                toolStripStatusLabelPesquisa.Text = "Operação realizada em " + EVENTOS.UIWindows.ClassComandos.Comando.DoCronometro("F", tempoinicio);
            }
            catch (Exception ex)
            {
                MessageBox.Show("Erro: " + ex.Message.ToString(), "Erro", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        //public void AtualizaGrid(int Registro)
        public void AtualizaGrid()
        {
            
            try
            {
                DateTime tempoinicio = DateTime.Now;
                convidadosBll obj = new convidadosBll();
                dataGridView.DataSource = obj.dtRetornaDados(getSql);
                int RegTotal = dataGridView.Rows.Count;
                toolStripLabelRegistroTotal.Text = " de " + (RegTotal).ToString();

                for (int i = 0; i < RegTotal; i++)
                {
                    if (dataGridView.Rows[i].Cells[4].Value.ToString() == "Ausente")
                    {
                        dataGridView.Rows[i].DefaultCellStyle.ForeColor = Color.Silver;
                        dataGridView.Rows[i].Cells[0].Value = Properties.Resources.misc_branco;
                    }
                    else
                    {
                        dataGridView.Rows[i].DefaultCellStyle.ForeColor = Color.Black;
                        dataGridView.Rows[i].Cells[0].Value = Properties.Resources.misc_green;
                    }
                }

                toolStripStatusLabelPesquisa.Text = "Operação realizada em " + EVENTOS.UIWindows.ClassComandos.Comando.DoCronometro("F", tempoinicio);
            }
            catch (Exception ex)
            {
                MessageBox.Show("Erro: " + ex.Message.ToString(), "Erro", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void FormTeste_Load(object sender, EventArgs e)
        {
            Thread thr = new Thread(new ThreadStart(EVENTOS.UIWindows.ClassComandos.Comando.cmdAguarde));
            thr.Start();
            try
            {
                AtualizaGrid();

                textBoxPesquisar.Focus();
                comboBoxCampos.DataSource = Listar(typeof(Filtros));
                comboBoxCampos.DisplayMember = "Value";
                comboBoxCampos.ValueMember = "Key";
                
            }
            catch (Exception ex)
            {
                MessageBox.Show("Erro: " + ex.Message.ToString(), "Erro", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
            thr.Abort();

            
        }

        private void textBoxPesquisar_TextChanged(object sender, EventArgs e)
        {
            if (textBoxPesquisar.Text == "")
            {
                AtualizaGrid();
            }
            else
            {
                DoBuscaConvidado(textBoxPesquisar.Text);
            }
        }

        private void DoBuscaConvidado(string filtro)
        {
            try
            {
                Filtros tabelaCampo = (Filtros)comboBoxCampos.SelectedValue;
                convidadosBll obj = new convidadosBll();
                dataGridView.DataSource = obj.dtRetornaDados("select * from Convidados where " + tabelaCampo.ToString() + " LIKE '" + filtro + "%'");
                textBoxPesquisar.Focus();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Erro: " + ex.Message.ToString(), "Erro", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void tableLayoutPanel1_Paint(object sender, PaintEventArgs e)
        {

        }

        private void pnltopo_Paint(object sender, PaintEventArgs e)
        {

        }

        private void toolStripButtonAtualizar_Click(object sender, EventArgs e)
        {
            AtualizaGrid();
        }

        private void dataGridView_RowEnter(object sender, DataGridViewCellEventArgs e)
        {
            try
            {
                if (dataGridView.CurrentRow != null)
                {
                   toolStripTextBoxRegistroAtual.Text = (e.RowIndex + 1).ToString();
                   label1.Text = dataGridView[1, e.RowIndex].Value.ToString();
                   toolStripMenuItem9.Text = String.Format("Imprimir ficha de {0} ", dataGridView[1, e.RowIndex].Value.ToString());

                   if (labelTitulo.Text != "Eventos")
                   {
                       // Este procedimento de criar datatable/dataset para verificar conteudo de celula é desnecessário.
                       // convidadosBll obj = new convidadosBll();
                       // DataTable dtConvidados = obj.dtRetornaDados("select * from convidados where codigoConvidado =" + int.Parse(dataGridView[0, e.RowIndex].Value.ToString()) + "");
                       // switch (dtConvidados.Rows[0].Field<string>("situacaoConvidado"))        

                       switch (dataGridView[4, e.RowIndex].Value.ToString())
                       {
                           case "Ausente":
                               pictureBoxStatus.Image = Properties.Resources.button_withe;
                               toolTip1.SetToolTip(pictureBoxStatus, "AUSENTE - convidado não esta no evento.");
                               dataGridView[0, e.RowIndex].Value = Properties.Resources.misc_branco;
                               break;
                           case "Presente":
                               pictureBoxStatus.Image = Properties.Resources.button_green;
                               toolTip1.SetToolTip(pictureBoxStatus, "PRESENTE - convidado esta no evento.");
                               dataGridView[0, e.RowIndex].Value = Properties.Resources.misc_green;
                               break;
                           default:
                               pictureBoxStatus.Image = Properties.Resources.button_red;
                               toolTip1.SetToolTip(pictureBoxStatus, "VERIFICAR PROBLEMAS COM O CADASTRO");
                               dataGridView[0, e.RowIndex].Value = Properties.Resources.misc_red;
                               break;
                       }
                   }

                }
             }
             catch (Exception ex)
             {
                 MessageBox.Show("Erro: " + ex.Message.ToString(), "Erro", MessageBoxButtons.OK, MessageBoxIcon.Error);
             }
             
        }

        private void dataGridView_CellDoubleClick(object sender, DataGridViewCellEventArgs e)
        {
            MessageBox.Show("Clique duplo  para anterar registro","Aviso",MessageBoxButtons.OK,MessageBoxIcon.Information);
            
        }

        private void toolStripMenuItem5_Click(object sender, EventArgs e)
        {
            toolStripDropDownButtonOpcoes.Visible = false;
            toolStripButtonGravar.Visible = true;
            toolStripSeparator12.Visible = false;
            
        }

        private void toolStripButtonGravar_Click(object sender, EventArgs e)
        {
            toolStripDropDownButtonOpcoes.Visible = true;
            toolStripButtonGravar.Visible = false;
            toolStripSeparator12.Visible = false;
        }

        private void toolStripMenuItem1_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void testeToolStripMenuItem_Click(object sender, EventArgs e)
        {
            toolStripDropDownButtonOpcoes.Visible = false;
            toolStripButtonGravar.Visible = true;
            toolStripSeparator12.Visible = false;
            DataRowView dtRowView = dataGridView.SelectedRows[0].DataBoundItem as DataRowView;
            DataRow dtRow = dtRowView.Row;
            dtRowView.Row.Delete();
        }

        private void alterarToolStripMenuItem_Click(object sender, EventArgs e)
        {
            toolStripDropDownButtonOpcoes.Visible = false;
            toolStripButtonGravar.Visible = true;
            toolStripSeparator12.Visible = false;
            DataRowView dtRowView = dataGridView.SelectedRows[0].DataBoundItem as DataRowView;
            DataRow dtRow = dtRowView.Row;
            dtRowView.Row.BeginEdit();
        }

        private void toolStripButtonImprimir_Click(object sender, EventArgs e)
        {
            printDGV.Print_DataGridView(dataGridView, labelTitulo.Text.ToString());
        }

        private void dataGridView_Sorted(object sender, EventArgs e)
        {
            for (int i = 0; i < dataGridView.Rows.Count; i++)
            {
                if (dataGridView.Rows[i].Cells[4].Value.ToString() == "Ausente")
                {
                    dataGridView.Rows[i].DefaultCellStyle.ForeColor = Color.Silver;
                    dataGridView.Rows[i].Cells[0].Value = Properties.Resources.misc_branco;
                }
                else
                {
                    dataGridView.Rows[i].DefaultCellStyle.ForeColor = Color.Black;
                    dataGridView.Rows[i].Cells[0].Value = Properties.Resources.misc_green;
                }
            }
        }

    }
}
