using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UIWindows;
using System.Threading;

namespace eventos.UIWindows
{
    public class Aviso
    {
        /// <summary>
        /// Autor: Marcos
        /// Interação com o usuário, principalemente em processos demorados
        /// </summary> 
        /// <param name="texto">Aviso</param>
        /// <returns>Aviso</returns>
        public static void cmdAguarde()
        {
            FormAviso frm = new FormAviso();
            frm.FormBorderStyle = System.Windows.Forms.FormBorderStyle.None;
            frm.BackColor = System.Drawing.Color.White;
            frm.Text = "Aguarde...";
            frm.ShowDialog();
        }


        /// <summary>
        /// Autor: Marcos
        /// Faz exibição de mensagem, principalemente em processos demorados...
        /// </summary> 
        /// <param name="texto">Aviso</param>
        /// <returns>Aviso</returns>
        public static void cmdProcessamento(int opcao, string mensagem)
        {
            if (mensagem == null) { mensagem = "Aguarde..."; }

            Thread thr = new Thread(new ThreadStart(delegate
            {
                FormAviso frm = new FormAviso();
                frm.FormBorderStyle = System.Windows.Forms.FormBorderStyle.None;
                frm.Text = mensagem;
                frm.ShowDialog();
            }));

            thr.Name = "cmdProcessamento";
            switch (opcao)
            {
                case 0:
                    thr.Start();
                    break;
                case 1:
                    thr.Abort();
                    break;
                default:
                    thr.Abort();
                    break;
            }
        }
    }
}
