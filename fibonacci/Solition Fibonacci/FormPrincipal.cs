using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Solition_Fibonacci
{
    public partial class FormPrincipal : Form
    {
        public FormPrincipal()
        {
            InitializeComponent();
            txtTermos.Text = "0";
        }

 

   

        private void btnLimpar_Click(object sender, EventArgs e)
        {
            lblResultado.Text = "Resultado:";
            txtResultado.Text = string.Empty;
            txtTermos.Text = "0";
        }

        private void btnSobre_Click(object sender, EventArgs e)
        {
            Form frm = new AboutBox();
            frm.ShowDialog();
        }

        private void btnExecutar_Click(object sender, EventArgs e)
        {
            #region reserva
            /*int a = 0, fib = 1;
            if (Convert.ToInt16(txtTermos.Text) <= 0 || Convert.ToInt16(txtTermos.Text) > 1000)
            {
                MessageBox.Show("informe um valor entre zero e cem!");
            }
            else
            {
                txtResultado.Text = string.Empty;
                while (fib <= Convert.ToInt16(txtTermos.Text))
                {
                    txtResultado.Text += string.Format(" {0}  {1} ", a, fib);
                    a += fib;
                    fib += a;
                }
            }*/
            #endregion
            lblResultado.Text = "Resultado:";
            txtResultado.Text = string.Empty;

            /*
             F=0,A1=1,A2=1,Q=10
             PARA N DE 0 ATE Q-1 FACA
                 SE N<2 ENTAO
                      F<-A1
                 SENAO
                      F<-F+A1
                      A1<-A2
                      A2<-F
                 FIMSE
                 ESCREVAL(F)
             FIMPARA
             */

            int a1, a2, f, t, n1, q;
            f=0; a1=1; a2=1;q = Convert.ToInt16(txtTermos.Text);
     
            for (int n=0; n<q; n++)
            {
                if(n<2)
                {
                    f = a1;
                }
                else
                {
                    f = f + a1;
                    a1 = a2;
                    a2 = f;
                }
                txtResultado.Text += string.Format(" {0} ", f);
            }
            lblResultado.Text = string.Format("Resultado para f({0}):",q.ToString());
            


            
        }

        public int a2 { get; set; }

        private void btnPrograma_Click(object sender, EventArgs e)
        {
           System.Diagnostics.Process.Start("calc.exe");
        }
    }
}
