using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Threading;
using System.Reflection;
using eventos.TAB;
using eventos.BLL;
using System.Data.Common;
using System.IO;
using eventos.LIB;

namespace eventos.UIWindows.xUSUARIOS
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
        public int digitos;
        public string campo;

        public FormListar()
        {
            InitializeComponent();
            labelTitulo.Text = "LISTA DE USUÁRIOS";
            labelSubTitulo.Text = "";
            this.Text = labelTitulo.Text;
        }

        private void Filtrar(string ISQL)
        {
            DateTime tempoinicio = DateTime.Now;
            /*
              SELECT Usuarios.UsuariosID, Usuarios.UsuariosNome, Usuarios.UsuariosLogin, Usuarios.UsuariosSenha, Usuarios.UsuariosPerfil, Usuarios.UsuariosOnline, Usuarios.UsuariosLoginHora
              FROM Usuarios
              WHERE (((Usuarios.UsuariosOnline)=True));
             */

            if (ISQL.Length <= 0)
            {
                ISQL = "SELECT * FROM usuarios";
            }
            BLL.usuarios usuarios = new BLL.usuarios();
            bs = new BindingSource();
            bs.DataSource = usuarios.retornarQueryDataTable(ISQL);
            bindingNavigator1.BindingSource = bs;
            dataGridView1.DataSource = bs;

            int RegTotal = dataGridView1.Rows.Count;
            for (int i = 0; i < RegTotal; i++)
            {
                if (Convert.ToBoolean(dataGridView1.Rows[i].Cells[6].Value) == false)
                {
                    dataGridView1.Rows[i].DefaultCellStyle.ForeColor = Color.Black;
                    dataGridView1.Rows[i].Cells[0].Value = Properties.Resources.misc_branco;
                }
                else if (Convert.ToBoolean(dataGridView1.Rows[i].Cells[6].Value) == true)
                {
                    dataGridView1.Rows[i].DefaultCellStyle.ForeColor = Color.Black;
                    dataGridView1.Rows[i].Cells[0].Value = Properties.Resources.misc_green;
                }
                else
                {
                    dataGridView1.Rows[i].DefaultCellStyle.ForeColor = Color.Orange;
                    dataGridView1.Rows[i].Cells[0].Value = Properties.Resources.misc_red;
                }
                dataGridView1.Columns[1].Visible = false;
                dataGridView1.Columns[4].Visible = false;
                dataGridView1.Columns[10].Visible = false;
                dataGridView1.Columns[2].Width = 200;
                //TITULOS
                dataGridView1.Columns[1].HeaderText = " ";
                dataGridView1.Columns[2].HeaderText = " Nome";
                dataGridView1.Columns[3].HeaderText = " Login";
                dataGridView1.Columns[4].HeaderText = " Senha";
                dataGridView1.Columns[5].HeaderText = " Perfil";
                dataGridView1.Columns[6].HeaderText = " Online";
                dataGridView1.Columns[7].HeaderText = " Email";
                dataGridView1.Columns[8].HeaderText = " Data Login";
                dataGridView1.Columns[9].HeaderText = " Data Cadastro";
            }
            dataGridView1.SelectionMode = DataGridViewSelectionMode.FullRowSelect;
            toolStripTextBox2.Focus();
            toolStripTextBox2.Select();
            toolStripLabelStatus.ToolTipText = "Operação realizada em " + LIB.Library.cmdCronometro("F", tempoinicio);
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

            dataGridView1.AllowUserToAddRows = false;
            dataGridView1.AllowUserToDeleteRows = false;
            dataGridView1.ReadOnly = true;
            Filtrar("");
        }

        private void dataGridView1_Sorted(object sender, EventArgs e)
        {
            int RegTotal = dataGridView1.Rows.Count;
            for (int i = 0; i < RegTotal; i++)
            {
                if (Convert.ToBoolean(dataGridView1.Rows[i].Cells[6].Value) == false)
                {
                    dataGridView1.Rows[i].DefaultCellStyle.ForeColor = Color.Black;
                    dataGridView1.Rows[i].Cells[0].Value = Properties.Resources.misc_branco;
                }
                else if (Convert.ToBoolean(dataGridView1.Rows[i].Cells[6].Value) == true)
                {
                    dataGridView1.Rows[i].DefaultCellStyle.ForeColor = Color.Black;
                    dataGridView1.Rows[i].Cells[0].Value = Properties.Resources.misc_green;
                }
                else
                {
                    dataGridView1.Rows[i].DefaultCellStyle.ForeColor = Color.Orange;
                    dataGridView1.Rows[i].Cells[0].Value = Properties.Resources.misc_red;
                }
                dataGridView1.Columns[1].Visible = false;
                dataGridView1.Columns[4].Visible = false;
                dataGridView1.Columns[10].Visible = false;
                dataGridView1.Columns[2].Width = 200;
                //TITULOS
                dataGridView1.Columns[1].HeaderText = " ";
                dataGridView1.Columns[2].HeaderText = " Nome";
                dataGridView1.Columns[3].HeaderText = " Login";
                dataGridView1.Columns[4].HeaderText = " Senha";
                dataGridView1.Columns[5].HeaderText = " Perfil";
                dataGridView1.Columns[6].HeaderText = " Online";
                dataGridView1.Columns[7].HeaderText = " Email";
                dataGridView1.Columns[8].HeaderText = " Data Login";
                dataGridView1.Columns[9].HeaderText = " Data Cadastro";
            }
        }

        private void dataGridView1_RowEnter(object sender, DataGridViewCellEventArgs e)
        {
            if (dataGridView1.CurrentRow != null)
            {
                    switch (Convert.ToBoolean(dataGridView1[6, e.RowIndex].Value))
                    {
                        case false:  //offline
                            toolTip1.SetToolTip(pictureBoxStatus, "(ONLINE)");
                            pictureBoxStatus.Image = Properties.Resources.button_withe;
                            dataGridView1[0, e.RowIndex].Value = Properties.Resources.misc_branco;
                            break;
                        case true:  //online
                            toolTip1.SetToolTip(pictureBoxStatus, "(OFFLINE)"); 
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

        private void toolStripButton1_Click(object sender, EventArgs e)
        {
            printDGV.Print_DataGridView(dataGridView1, "LISTA DE USUÁRIOS");
        }

        private void adicionarToolStripMenuItem_Click(object sender, EventArgs e)
        {
            FormPerfil frm = new FormPerfil("insert");
            frm.strUsuariosID = string.Empty;
            frm.strUsuariosNome = string.Empty;
            frm.strUsuariosLogin = string.Empty;
            frm.strUsuariosSenha = string.Empty;
            frm.strUsuariosSenhaRepetir = string.Empty;
            frm.strUsuariosOnline = false;
            frm.strUsuariosPerfil = string.Empty;
            frm.strUsuariosEmail = string.Empty;
            frm.parUsuariosFoto = null;
            frm.strTitulo = "ADICIONAR REGISTRO";
            frm.ShowDialog();
            Filtrar("");
        }

        private void alterarToolStripMenuItem_Click(object sender, EventArgs e)
        {
            FormPerfil frm = new FormPerfil("update");
            frm.strUsuariosID = dataGridView1.Rows[linhaAtual].Cells["usuariosId"].Value.ToString();
            frm.strUsuariosNome = dataGridView1.Rows[linhaAtual].Cells["usuariosNome"].Value.ToString();
            frm.strUsuariosLogin = dataGridView1.Rows[linhaAtual].Cells["usuariosLogin"].Value.ToString();
            frm.strUsuariosSenha = dataGridView1.Rows[linhaAtual].Cells["usuariosSenha"].Value.ToString();
            frm.strUsuariosSenhaRepetir = dataGridView1.Rows[linhaAtual].Cells["usuariosSenha"].Value.ToString();
            frm.strUsuariosEmail = dataGridView1.Rows[linhaAtual].Cells["usuariosEmail"].Value.ToString();
            frm.strUsuariosPerfil = dataGridView1.Rows[linhaAtual].Cells["usuariosPerfil"].Value.ToString();
            frm.strUsuariosOnline = Convert.ToBoolean(dataGridView1.Rows[linhaAtual].Cells["usuariosOnline"].Value);
            if (DBNull.Value != dataGridView1.Rows[linhaAtual].Cells["usuariosFoto"].Value)
                frm.parUsuariosFoto = (byte[])dataGridView1.Rows[linhaAtual].Cells["usuariosFoto"].Value;

            frm.strTitulo = "ALTERAR REGISTRO";
            frm.ShowDialog();
            Filtrar("");
        }

        private void excluirToolStripMenuItem_Click(object sender, EventArgs e)
        {
            FormPerfil frm = new FormPerfil("delete");
            frm.strUsuariosID = dataGridView1.Rows[linhaAtual].Cells["usuariosId"].Value.ToString();
            frm.strUsuariosNome = dataGridView1.Rows[linhaAtual].Cells["usuariosNome"].Value.ToString();
            frm.strUsuariosLogin = dataGridView1.Rows[linhaAtual].Cells["usuariosLogin"].Value.ToString();
            frm.strUsuariosSenha = dataGridView1.Rows[linhaAtual].Cells["usuariosSenha"].Value.ToString();
            frm.strUsuariosSenhaRepetir = dataGridView1.Rows[linhaAtual].Cells["usuariosSenha"].Value.ToString();
            frm.strUsuariosEmail = dataGridView1.Rows[linhaAtual].Cells["usuariosEmail"].Value.ToString();
            frm.strUsuariosPerfil = dataGridView1.Rows[linhaAtual].Cells["usuariosPerfil"].Value.ToString();
            frm.strUsuariosOnline = Convert.ToBoolean(dataGridView1.Rows[linhaAtual].Cells["usuariosOnline"].Value);
            if (DBNull.Value != dataGridView1.Rows[linhaAtual].Cells["usuariosFoto"].Value)
                frm.parUsuariosFoto = (byte[])dataGridView1.Rows[linhaAtual].Cells["usuariosFoto"].Value;

            frm.strTitulo = "EXCLUIR REGISTRO (ATENÇÃO!)";
            frm.ShowDialog();
            Filtrar("");
        }

        private void visualizarToolStripMenuItem_Click(object sender, EventArgs e)
        {
            

            FormPerfil frm = new FormPerfil("select");
            frm.strUsuariosID = dataGridView1.Rows[linhaAtual].Cells["usuariosId"].Value.ToString();
            frm.strUsuariosNome = dataGridView1.Rows[linhaAtual].Cells["usuariosNome"].Value.ToString();
            frm.strUsuariosLogin = dataGridView1.Rows[linhaAtual].Cells["usuariosLogin"].Value.ToString();
            frm.strUsuariosSenha = dataGridView1.Rows[linhaAtual].Cells["usuariosSenha"].Value.ToString();
            frm.strUsuariosSenhaRepetir = dataGridView1.Rows[linhaAtual].Cells["usuariosSenha"].Value.ToString();
            frm.strUsuariosEmail = dataGridView1.Rows[linhaAtual].Cells["usuariosEmail"].Value.ToString();
            frm.strUsuariosPerfil = dataGridView1.Rows[linhaAtual].Cells["usuariosPerfil"].Value.ToString();
            frm.strUsuariosOnline = Convert.ToBoolean(dataGridView1.Rows[linhaAtual].Cells["usuariosOnline"].Value);
            if (DBNull.Value != dataGridView1.Rows[linhaAtual].Cells["usuariosFoto"].Value)
                frm.parUsuariosFoto = (byte[])dataGridView1.Rows[linhaAtual].Cells["usuariosFoto"].Value;                

            frm.strTitulo = "VISUALIZAR REGISTRO";
            frm.ShowDialog();
            Filtrar("");
        }

        private void nrCartaoToolStripMenuItem_Click(object sender, EventArgs e)
        {
            chaveToolStripMenuItem.Text = nrCartaoToolStripMenuItem.Text;
            nomeToolStripMenuItem.Checked = false;
            nrCartaoToolStripMenuItem.Checked = true;
        }

        private void nomeToolStripMenuItem_Click(object sender, EventArgs e)
        {
            chaveToolStripMenuItem.Text = nomeToolStripMenuItem.Text;
            nomeToolStripMenuItem.Checked = true;
            nrCartaoToolStripMenuItem.Checked = false;
        }

        private void toolStripTextBox2_TextChanged(object sender, EventArgs e)
        {
            digitos++;
            switch (chaveToolStripMenuItem.Text)
            {
                case "Nome":
                    campo = "usuariosNome";
                    break;
                case "Perfil":
                    campo = "usuariosPerfil";
                    break;
            }
            Filtrar("SELECT * FROM usuarios WHERE " + campo + " LIKE'" + toolStripTextBox2.Text + "%' ORDER BY usuariosNome" );
        }

        private void dataGridView1_MouseClick(object sender, MouseEventArgs e)
        {
            linhaAtual = dataGridView1.CurrentRow.Index;
            dataGridView1.SelectionMode =  DataGridViewSelectionMode.FullRowSelect;
        }

 
    }
}
