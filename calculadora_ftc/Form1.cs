using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Media;
using System.Text;
using System.Windows.Forms;

namespace SimuladorDeNotasFTC
{

    public partial class Form1 : Form
    {
        private double NS = 0;
        private double AF = 0;
        private double VF = 0;
        private string RF = string.Empty;
        private List<Image> images;
     
        private void motraImagem()
        {
            Random r = new Random();
            images = new List<Image>();
            images.Add(Properties.Resources._128_calc__1_);
            images.Add(Properties.Resources._128_calc__2_);
            images.Add(Properties.Resources._128_calc__3_);
            images.Add(Properties.Resources._128_calc__4_);
            images.Add(Properties.Resources._128_calc__5_);
            images.Add(Properties.Resources._128_calc__6_);
            images.Add(Properties.Resources._128_calc__7_);
            images.Add(Properties.Resources._128_calc__8_);
            pictureBox2.Image = images[r.Next(0, 8)];
        }
        public Form1()
        {
            InitializeComponent();
            this.Text = "Simulador de Notas - Sistema FTC 2014";
        }
        private void playSimpleSound(int opcao)
        {
            SoundPlayer som = new System.Media.SoundPlayer();
            switch(opcao)
            {
                case 1:
                    som.SoundLocation = @"c:\Windows\Media\chimes.wav";
                    break;
                case 2:
                    som.SoundLocation = "002.wav";
                    break;
                case 3:
                    som.SoundLocation = "003.wav";
                    break;
            }
            som.Play();
        }
        private void PopulateDataGridView(int linha)
        {
            motraImagem();
            DataTable table = new DataTable();
            
            table.Columns.Add("VA1"     , typeof(Double));
            table.Columns.Add("VA2"     , typeof(Double));
            table.Columns.Add("OAts"    , typeof(Double));
            table.Columns.Add("NS"      , typeof(Double));
            table.Columns.Add("AF"      , typeof(Double));
            table.Columns.Add("VF"      , typeof(Double));
            table.Columns.Add("RF"      , typeof(String));
            table.Columns.Add(" ", typeof(Image));
            table.Rows.Add(40, 40, 20, 100, 0, 0, "APROVADO DIRETO", null);
            /*table.Rows[linha]["NS"] =   
                                    Convert.ToDouble(table.Rows[linha][0]) + 
                                    Convert.ToDouble(table.Rows[linha][1]) + 
                                    Convert.ToDouble(table.Rows[linha][2]);*/

            dataGridView1.DataSource = table;
            
            foreach (DataGridViewColumn column in dataGridView1.Columns)
            {
                if (column.Name == " " || column.Name == "RF")
                {
                    column.Width = 40;
                }
                if(column.Name=="AF" || column.Name =="VF")
                {
                    column.Visible = false;
                }

                if (column.Name == " " || column.Name == "NS" || column.Name == "VF" || column.Name == "RF")
                {
                    column.ReadOnly = true;
                }
                else
                {
                    column.DefaultCellStyle.BackColor = Color.Beige;
                }
            }

            this.dataGridView1.Columns["RF"].DefaultCellStyle.ForeColor = Color.Green;
            this.dataGridView1.Columns["RF"].DefaultCellStyle.BackColor = Color.White;
            this.dataGridView1.Columns[" "].DefaultCellStyle.BackColor = Color.White;
            this.dataGridView1[" ", linha].Value = Properties.Resources.misc_green;
            this.dataGridView1.ColumnHeadersBorderStyle =  DataGridViewHeaderBorderStyle.None;
            this.dataGridView1.CellBorderStyle = DataGridViewCellBorderStyle.None;
            this.dataGridView1.DefaultCellStyle.Font = new Font("Tahoma", 8);

            //this.dataGridView1.DefaultCellStyle.ForeColor = Color.Blue;
            //this.dataGridView1.DefaultCellStyle.BackColor = Color.Beige;
            //this.dataGridView1.DefaultCellStyle.SelectionForeColor = Color.Yellow;
            //this.dataGridView1.DefaultCellStyle.SelectionBackColor = Color.Black;
  
            dataGridView1.AutoResizeColumns();
            dataGridView1.AutoResizeRows();
            dataGridView1.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.AllCells;
            dataGridView1.CurrentCell = dataGridView1.Rows[linha].Cells[0];

            label1.Text = "RESULTADOS:";
     
            this.tabControl1.SelectedTab = tabPage1;
            this.tabPage1.Text = "BEM VINDO";
            

        }
        public byte[] imageToByteArray(System.Drawing.Image imageIn)
        {
            MemoryStream ms = new MemoryStream();
            imageIn.Save(ms, System.Drawing.Imaging.ImageFormat.Gif);
            return ms.ToArray();
        }
        public Image byteArrayToImage(byte[] byteArrayIn)
        {
            MemoryStream ms = new MemoryStream(byteArrayIn);
            Image returnImage = Image.FromStream(ms);
            return returnImage;
        }
        private void SetupLayout()
        {
            //this.Size = new Size(600, 500);

            //addNewRowButton.Text = "Add Row";
            //addNewRowButton.Location = new Point(10, 10);
            //addNewRowButton.Click += new EventHandler(addNewRowButton_Click);

            //deleteRowButton.Text = "Delete Row";
            //deleteRowButton.Location = new Point(100, 10);
            //deleteRowButton.Click += new EventHandler(deleteRowButton_Click);

            //buttonPanel.Controls.Add(addNewRowButton);
            //buttonPanel.Controls.Add(deleteRowButton);
            //buttonPanel.Height = 50;
            //buttonPanel.Dock = DockStyle.Bottom;

            //this.Controls.Add(this.buttonPanel);
        }
        private void SetupDataGridView()
        {
            //this.Controls.Add(dataGridView1);
            //dataGridView1.ColumnCount = 5;

            //dataGridView1.ColumnHeadersDefaultCellStyle.BackColor = Color.Navy;
            //dataGridView1.ColumnHeadersDefaultCellStyle.ForeColor = Color.White;
            //dataGridView1.ColumnHeadersDefaultCellStyle.Font = new Font(dataGridView1.Font, FontStyle.Bold);

            //dataGridView1.Name = "dataGridView1";
            //dataGridView1.Location = new Point(8, 8);
            //dataGridView1.Size = new Size(500, 250);
            //dataGridView1.AutoSizeRowsMode = DataGridViewAutoSizeRowsMode.DisplayedCellsExceptHeaders;
            //dataGridView1.ColumnHeadersBorderStyle =  DataGridViewHeaderBorderStyle.Single;
            //dataGridView1.CellBorderStyle = DataGridViewCellBorderStyle.Single;
            //dataGridView1.GridColor = Color.Black;
            //dataGridView1.RowHeadersVisible = false;

            //dataGridView1.Columns[0].Name = "Release Date";
            //dataGridView1.Columns[1].Name = "Track";
            //dataGridView1.Columns[2].Name = "Title";
            //dataGridView1.Columns[3].Name = "Artist";
            //dataGridView1.Columns[4].Name = "Album";
            //dataGridView1.Columns[4].DefaultCellStyle.Font = new Font(dataGridView1.DefaultCellStyle.Font, FontStyle.Italic);

            //dataGridView1.SelectionMode = DataGridViewSelectionMode.FullRowSelect;
            dataGridView1.MultiSelect = false;
            //dataGridView1.Dock = DockStyle.Fill;
            dataGridView1.CellFormatting += new DataGridViewCellFormattingEventHandler(dataGridView1_CellFormatting);
        }
        private void button1_Click(object sender, EventArgs e)
        {
            PopulateDataGridView(0);
        }
        private void button2_Click(object sender, EventArgs e)
        {
            Form1_Load(sender, e);
        }
        private void Form1_Load(object sender, EventArgs e)
        {
            SetupLayout();
            SetupDataGridView();
            PopulateDataGridView(0);
            label8.Text = string.Empty;
        }
        private void dataGridView1_CellEndEdit(object sender, DataGridViewCellEventArgs e)
        {
            motraImagem();
            NS=0;
            AF=0;
            VF=0;
            label8.Text = string.Empty;
            
            if (dataGridView1.CurrentRow != null)
            {
                NS = Convert.ToDouble(dataGridView1["VA1", e.RowIndex].Value) +
                     Convert.ToDouble(dataGridView1["VA2", e.RowIndex].Value) +
                     Convert.ToDouble(dataGridView1["OAts", e.RowIndex].Value);
                dataGridView1["NS", e.RowIndex].Value = NS;
                
                label8.Text = "REQUISITO P/APROVAÇÃO: 'AF' >= " + (Convert.ToDouble((5000-(NS*60))/40)).ToString();

                if (NS >= 40)
                {
                    if (NS < 70)
                    {
                        dataGridView1.Columns["AF"].Visible = true;
                        dataGridView1.CurrentCell = dataGridView1.Rows[e.RowIndex].Cells["AF"];
                        RF = "DIREITO A VERIFICAÇÃO FINAL";
                        
                        playSimpleSound(1);

                        this.dataGridView1.Columns["RF"].DefaultCellStyle.ForeColor = Color.Black;
                        dataGridView1.Columns["RF"].DefaultCellStyle.BackColor = Color.Yellow;
                        dataGridView1.Columns[" "].DefaultCellStyle.BackColor = Color.Yellow;
                        dataGridView1[" ", e.RowIndex].Value = Properties.Resources.alert;
                        
                        if (Convert.ToDouble(dataGridView1["AF", e.RowIndex].Value) > 0)
                        {
                            dataGridView1.Columns["VF"].Visible = true;
                            AF = Convert.ToDouble(dataGridView1["AF", e.RowIndex].Value);
                            VF = ((NS * 60.00) + (AF * 40.00)) / 100.00;
                            dataGridView1["VF", e.RowIndex].Value = VF;
                            if (VF >= 50)
                            {
                                RF = "APROVADO EM FINAL";
                                this.dataGridView1.Columns["RF"].DefaultCellStyle.ForeColor = Color.White;
                                this.dataGridView1.Columns["RF"].DefaultCellStyle.BackColor = Color.Green;
                                this.dataGridView1.Columns[" "].DefaultCellStyle.BackColor = Color.Green;
                                this.dataGridView1[" ", e.RowIndex].Value = Properties.Resources.misc_green;
                                label1.Text = "RESULTADOS:";
 
                            }
                            else
                            {
                                RF = "REPROVADO EM FINAL";
                                playSimpleSound(3);
                                this.dataGridView1.Columns["RF"].DefaultCellStyle.ForeColor = Color.White;
                                this.dataGridView1.Columns["RF"].DefaultCellStyle.BackColor = Color.Red;
                                this.dataGridView1.Columns[" "].DefaultCellStyle.BackColor = Color.Red;
                                this.dataGridView1[" ", e.RowIndex].Value = Properties.Resources.misc_red;
                                label1.Text = "RESULTADOS:";
                            }
                               
                        }
                        else
                        {
                            dataGridView1["VF", e.RowIndex].Value = 0;
                            dataGridView1.Columns["VF"].Visible = false;
                            label1.Text = "RESULTADOS:";
                          
                        }
                        
                    }
                    else
                    {
                        RF = "APROVADO DIRETO";
                        this.dataGridView1.Columns["RF"].DefaultCellStyle.ForeColor = Color.Green;
                        this.dataGridView1.Columns["RF"].DefaultCellStyle.BackColor = Color.White;
                        this.dataGridView1.Columns[" "].DefaultCellStyle.BackColor = Color.White;
                        this.dataGridView1[" ", e.RowIndex].Value = Properties.Resources.misc_green;

                        label1.Text = "RESULTADOS:";
                        if (dataGridView1.Columns["AF"].Visible)
                        {
                            dataGridView1["AF", e.RowIndex].Value = 0;
                            dataGridView1.Columns["AF"].Visible = false;
                            if (dataGridView1.Columns["VF"].Visible)
                            {
                                dataGridView1["VF", e.RowIndex].Value = 0;
                                dataGridView1.Columns["VF"].Visible = false;
                            }
                         }
                        
                    }
                }
                else
                {
                    RF = "REPROVADO DIRETO";
                    playSimpleSound(2);
                    label8.Text = String.Empty;
                    this.dataGridView1.Columns["RF"].DefaultCellStyle.ForeColor = Color.White;
                    this.dataGridView1.Columns["RF"].DefaultCellStyle.BackColor = Color.Red;
                    this.dataGridView1.Columns[" "].DefaultCellStyle.BackColor = Color.Red;
                    this.dataGridView1[" ", e.RowIndex].Value = Properties.Resources.misc_red;

                    
                    if (dataGridView1.Columns["AF"].Visible)
                    {
                        dataGridView1.Columns["AF"].Visible = false;
                        if (dataGridView1.Columns["VF"].Visible)
                        {
                            dataGridView1.Columns["VF"].Visible = false;
                        };
                    }
                }
                dataGridView1["RF", e.RowIndex].Value = RF;
                // Limpa o erro da linha no caso do usuário pressionar ESC
                dataGridView1.Rows[e.RowIndex].ErrorText = String.Empty;
                dataGridView1.AutoResizeColumns();
                dataGridView1.AutoSizeColumnsMode =  DataGridViewAutoSizeColumnsMode.AllCells;
            }
        }
        private void dataGridView1_CellValidating(object sender, DataGridViewCellValidatingEventArgs e)
        {
            // Valida o entrada para não permitindo valores em branco
            if (dataGridView1.Columns[e.ColumnIndex].Name == "VA1" || dataGridView1.Columns[e.ColumnIndex].Name == "VA2" || dataGridView1.Columns[e.ColumnIndex].Name == "OAts")
            {
                    if(String.IsNullOrEmpty(e.FormattedValue.ToString())) 
                    {
                        dataGridView1.Rows[e.RowIndex].ErrorText = "Não pode ser vazio.";
                        e.Cancel = true;
                    }
            }
        }
        private void dataGridView1_CellValidated(object sender, DataGridViewCellEventArgs e)
        {
           
            if (Convert.ToDouble(dataGridView1["VA1", e.RowIndex].Value) > 40 || Convert.ToDouble(dataGridView1["VA1", e.RowIndex].Value) < 0)
            {
                MessageBox.Show("Valor min. é 0 e  máx. 40.00");
                dataGridView1["VA1", e.RowIndex].Value = 40;
            }
            if (Convert.ToDouble(dataGridView1["VA2", e.RowIndex].Value) > 40 || Convert.ToDouble(dataGridView1["VA2", e.RowIndex].Value)<0)
            {
                MessageBox.Show("Valor min. é 0 e  máx. 40.00");
                dataGridView1["VA2", e.RowIndex].Value = 40;
            }
            if (Convert.ToDouble(dataGridView1["OAts", e.RowIndex].Value) > 20 || Convert.ToDouble(dataGridView1["OAts", e.RowIndex].Value) < 0)
            {
                MessageBox.Show("Valor min. é 0 e  máx.20.00");
                dataGridView1["OAts", e.RowIndex].Value = 20;
            }
            if (Convert.ToDouble(dataGridView1["AF", e.RowIndex].Value) > 100 || Convert.ToDouble(dataGridView1["AF", e.RowIndex].Value) < 0)
            {
                MessageBox.Show("Valor min. é 0 e  máx. 100.00");
                dataGridView1["AF", e.RowIndex].Value = 0;
            }
            NS = Convert.ToDouble(dataGridView1["NS", e.RowIndex].Value);
            AF = Convert.ToDouble(dataGridView1["AF", e.RowIndex].Value);
            VF = Convert.ToDouble(dataGridView1["VF", e.RowIndex].Value);
            RF = dataGridView1["RF", e.RowIndex].Value.ToString();
        }
        private void dataGridView1_CellFormatting(object sender, DataGridViewCellFormattingEventArgs e)
        {
            #region RF
            /*if (e.Value != null && e.ColumnIndex == 7)
            {
                if (NS >= 40)
                {
                    if (NS < 70)
                    {
                        if (VF < 50)
                        {
                            e.CellStyle.ForeColor = Color.White;
                            e.CellStyle.BackColor = Color.Red;
                        }
                        else
                        {
                            e.CellStyle.ForeColor = Color.White;
                            e.CellStyle.BackColor = Color.Blue;
                        }
                       
                    }
                    else
                    {
                        e.CellStyle.ForeColor = Color.White;
                        e.CellStyle.BackColor = Color.Green;
                    }

                }
                else
                {
                    e.CellStyle.ForeColor = Color.White;
                    e.CellStyle.BackColor = Color.Red;
                }
            }*/
            #endregion

            #region TESTE
            /*if (e != null )
            {
               
                
                if (this.dataGridView1.Columns[e.ColumnIndex].Name == "AV 1")
                {
                    if (e.Value != null)
                    {
                        try
                        {
                            e.Value = DateTime.Parse(e.Value.ToString()).ToLongDateString();
                            e.FormattingApplied = true;
                        }
                        catch (FormatException)
                        {
                            Console.WriteLine("{0} is not a valid date.", e.Value.ToString());
                        }
                    }
                }
            }*/
            #endregion
        }
        private void dataGridView1_RowPrePaint(object sender, DataGridViewRowPrePaintEventArgs e)
        {
            DataGridView dgv = sender as DataGridView;
            label2.Text = "NS = "+NS.ToString();
            label3.Text = "AF = "+AF.ToString();
            label4.Text = "VF = "+VF.ToString();
            label5.Text = "RF = "+RF.ToString();
        }
        private void button1_Click_1(object sender, EventArgs e)
        {
            if (MessageBox.Show("Deseja Encerrar a Aplicação?", "Sair", MessageBoxButtons.YesNo, MessageBoxIcon.Question) == System.Windows.Forms.DialogResult.Yes)
            {
                //System.Environment.Exit(0);
                this.Close();
            }
            
        }

        private void label7_Click(object sender, EventArgs e)
        {
            AboutBox1 frm  = new AboutBox1();
            frm.ShowDialog();
        }

        private void button3_Click(object sender, EventArgs e)
        {
            System.Diagnostics.Process.Start("Calc.exe");
        }

        private void button4_Click(object sender, EventArgs e)
        {
            try
            {
                System.Diagnostics.Process.Start("COMUNICADO CRITÉRIOS DE AVALIAÇÃO 2014.pdf");
            }catch
            {
                MessageBox.Show("Não foi encontrado um leitor de arquivos[pdf] em seu computador.");
            }
        }
    }
}
