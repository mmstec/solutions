using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Configuration;
using eventos.LIB;

namespace eventos.UIWindows
{
    public partial class FormRegistro : Form
    {
        static string encryptedText = string.Empty;
        static string decryptedText = string.Empty;
        static string key = ConfigurationManager.AppSettings["sistemaData"];
        static string dataHoje = DateTime.Now.ToShortDateString();
        static string dataVelha = ConfigurationManager.AppSettings["sistemaDataLimite"];

        public FormRegistro()
        {
            InitializeComponent();
            timer1.Interval = 1000; // 1 segundo
            timer1.Start();
            LIB.Crypt _crypt = new LIB.Crypt(CryptProvider.Rijndael);
            _crypt.Key = key;
            decryptedText = _crypt.Decrypt(dataVelha);
            //encryptedText = _crypt.Encrypt(decryptedText);
            textBoxSenhaVerde.Text = dataVelha; ;//encryptedText;
        }
        public static void GravarConfiguracao(string chave, string valor)
        {
            Configuration config = ConfigurationManager.OpenExeConfiguration(ConfigurationUserLevel.None);
            config.AppSettings.Settings.Remove(chave);
            config.Save();
            config.AppSettings.Settings.Add(chave, valor);
            config.Save();
        }
        private void FormRegistro_Load(object sender, EventArgs e)
        {
            //Marcos: personalizando tabcontrol
            TabControl1.Dock = DockStyle.Fill;
            TabControl1.DrawMode = TabDrawMode.OwnerDrawFixed;
            TabControl1.TabPages[0].BackColor = SystemColors.Control;
            TabControl1.Appearance = TabAppearance.Normal;
            //TabControl1.TabPages.Clear();
            //TabControl1.TabPages.Add("TAB 1");
            //TabControl1.TabPages.Add("TAB 2");
            //TabControl1.TabPages.Add("TAB 3");
            //TabControl1.TabPages.Add("TAB 4");
            //TabControl1.TabPages[0].BackColor = Color.Coral;
            //TabControl1.TabPages[1].BackColor = Color.LightYellow;
            //TabControl1.TabPages[2].BackColor = Color.PowderBlue;
            //TabControl1.TabPages[3].BackColor = Color.LightGreen;
            textBoxContraSenha.Focus();
            textBoxContraSenha.Select();
        }

        private void toolStripButtonGravar_Click(object sender, EventArgs e)
        {
            LIB.Crypt _crypt = new LIB.Crypt(CryptProvider.Rijndael);
            _crypt.Key = key;
            GravarConfiguracao("sistemaData", textBoxSenhaVerde.Text.Trim());
            GravarConfiguracao("sistemaDataLimite",textBoxContraSenha.Text.Trim());
            Application.Exit();
        }

        private void toolStripButtonCancelar_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }

        private void timer1_Tick(object sender, EventArgs e)
        {
            string hora = DateTime.Now.ToLongDateString() + " - " + DateTime.Now.ToLongTimeString();
            char primeira = char.ToUpper(hora[0]);
            hora = primeira + hora.Substring(1);
            toolStripRelogio.Text = hora.ToUpper();
        }

        private void FormRegistro_FormClosed(object sender, FormClosedEventArgs e)
        {
            Application.Exit();
        }

        private void TabControl1_DrawItem(object sender, DrawItemEventArgs e)
        {
            //Marcos: personalizando tabcontrol
            Rectangle quadradinho = TabControl1.GetTabRect(e.Index);
            SolidBrush pincel = new SolidBrush(TabControl1.TabPages[e.Index].BackColor);
            e.Graphics.FillRectangle(pincel, quadradinho);
            e.Graphics.DrawString(TabControl1.TabPages[e.Index].Text, new Font("Microsoft Sans Serif", 8, FontStyle.Regular), Brushes.Black, quadradinho.X + 2, quadradinho.Y + 2);
        }
    }
}
