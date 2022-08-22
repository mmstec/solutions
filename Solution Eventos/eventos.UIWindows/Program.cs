using System;
using System.Collections.Generic;
using System.Linq;
using System.Windows.Forms;
using System.Globalization;
using System.Threading;
using System.Configuration;
using eventos.LIB;

namespace eventos.UIWindows
{
    static class Program
    {
        static int tentativa = 1;
        static string encryptedText = string.Empty;
        static string decryptedText = string.Empty;
        static string key = ConfigurationManager.AppSettings["sistemaData"];
        static string dataHoje = DateTime.Now.ToShortDateString();
        static string dataVelha = ConfigurationManager.AppSettings["sistemaDataLimite"];
        static TimeSpan diff;

        /// <summary>
        /// The main entry point for the application.
        /// </summary>
        [STAThread]
        static void Main()
        {
            Thread.CurrentThread.CurrentCulture = new CultureInfo("pt-BR");
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);

            LIB.Crypt _crypt = new LIB.Crypt(CryptProvider.Rijndael);
            _crypt.Key = key;
            decryptedText = _crypt.Decrypt(dataVelha);

            if (Convert.ToDateTime(decryptedText) < Convert.ToDateTime(dataHoje))
            {
                Application.Run(new FormRegistro());
            }
            else
            {
                diff = Convert.ToDateTime(decryptedText)-Convert.ToDateTime(dataHoje);
                if (Convert.ToInt32(diff.Days) <= 5)
                {
                    MessageBox.Show("O software vai expirar em " + decryptedText.ToString(), "Aviso", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
                Login(tentativa);
            }
        }

        /// <summary>
        /// Marcos:
        /// Método recursivo que limita números de tentativa de acesso ao sistema
        /// </summary>
        static void Login(int tentativa)
        {
            if (tentativa > 3)
            {
                MessageBox.Show("Tentativas esgotadas", "Acesso não perminito", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
            }
            else
            {
                FormLogin login = new FormLogin(tentativa);
                switch (login.ShowDialog())
                {
                    case DialogResult.OK:
                        if (login.usuarioPerfil.ToLower() == "usuario")
                        {
                            Application.Run(new FormConsultar(login.usuarioId, login.usuarioNome, login.usuarioPerfil, login.usuarioUltLogin));
                        }
                        else
                        {
                            Application.Run(new FormPrincipal(login.usuarioId, login.usuarioNome, login.usuarioPerfil, login.usuarioUltLogin));
                        }
                        break;
                    default:
                        Login(tentativa + 1);
                        break;
                }
            }
        }
    }
}
        
    
