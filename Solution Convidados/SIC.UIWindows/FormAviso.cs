using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using System.Net;
using System.IO;

namespace UIWindows
{
    public partial class FormAviso : Form
    {
        public FormAviso()
        {
            InitializeComponent();
        }

        private void FormAviso_Load(object sender, EventArgs e)
        {
            this.TopMost = true;
        }

        private void timer1_Tick(object sender, EventArgs e)
        {
            if (pictureBoxAlerta.Visible)
            {
                pictureBoxAlerta.Visible = false;
            }
            else
            {
                pictureBoxAlerta.Visible = true;
            }
        }

        private void FormAviso_Paint(object sender, PaintEventArgs e)
        {
            timer1.Start();
        }

    }
}
