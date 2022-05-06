using System;
using System.Windows.Forms;
using System.Drawing;
using System.Drawing.Imaging;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.IO;
using System.Net;
using System.Globalization;
using System.Reflection;

namespace eventos.LIB
{
    public class Library
    {
        /// <summary>
        /// Autor: Marcos
        /// classe para abrigar livraria de funções e métodos do modulo AppWIN (FUSION SGWIN)
        /// evitando re-digitação desnecessária.
        /// </summary> 
        /// <param name="texto">funções e métodos</param>
        /// <returns>funções e métodos</returns>

            #region Propiedades

            #endregion

            #region Construtores

            #endregion

            #region Funções

            /// <summary>
            /// Autor: Marcos
            /// Mostra serial de um drive
            /// </summary> 
            /// <param name="texto">Aviso</param>
            /// <returns>Aviso</returns>
            public static string cmdMostraSerialHD(string parametro)
            {
                /* 
                ManagementObject disk = new ManagementObject("win32_logicaldisk.deviceid=\'"+parametro+"\'");
                ManagementObject disk = new ManagementObject("win32_logicaldisk.deviceid=\"c:\"");
                disk.Get();
                string serial = disk["VolumeSerialNumber"].ToString();
                toolStripStatusLabel1.Text = "TERMINAL SN: " + serial;
                */
                string serial = "";
                return serial;
            }

            /// <summary>
            /// Autor: Marcos
            /// Mostra versao do framework instalado para verificacao
            /// </summary> 
            /// <param name="texto">versao do framework</param>
            /// <returns>versao do framework</returns>
            public static string cmdMostraVersaoframework()
            {
                String versao = System.Runtime.InteropServices.RuntimeEnvironment.GetSystemVersion();
                return versao;
            }

            /// <summary>
            /// Autor: Marcos e Tony
            /// RETORNA DATA POR EXTENSO
            /// </summary> 
            /// <param name="texto">DATA</param>
            /// <returns>DATA</returns>
            public static string cmdDataExtenso(string wdata)
            {
                try
                {
                    DateTime data;
                    data = Convert.ToDateTime(wdata);
                    CultureInfo culture = new CultureInfo("pt-BR");
                    DateTimeFormatInfo dtfi = culture.DateTimeFormat;
                    int dia = data.Day;
                    int ano = data.Year;
                    string mes = culture.TextInfo.ToTitleCase(dtfi.GetMonthName(data.Month));
                    string diasemana = culture.TextInfo.ToTitleCase(dtfi.GetDayName(data.DayOfWeek));
                    return diasemana + ", " + dia + " de " + mes + " de " + ano + "|";
                }
                catch
                {
                    return ("Data Inválida...");
                }
            }

            /// <summary>
            /// Autor: Marcos
            /// Passar uma string formatada em c com o String.Format 
            /// o valor máximo é 999 bilhões, não esqueça o ' ,00 '
            /// </summary> 
            /// <param name="texto">RETORNA VALOR POR EXTENSO</param>
            /// <returns>RETORNA VALOR POR EXTENSO</returns>
            public string cmdValorExtenso(string wvalor)
            {
                string[] wunidade = { "", " e um", " e dois", " e trez", " e quatro", " e cinco", " e seis", " e sete", " e oito", " e nove" };
                string[] wdezes = { "", " e onze", " e doze", " e treze", " e quatorze", " e quinze", " e dezesseis", " e dezessete", " e dezoito", " e dezenove" };
                string[] wdezenas = { "", " e dez", " e vinte", " e trinta", " e quarenta", " e cinquenta", " e sessenta", " e setenta", " e oitenta", " e noventa" };
                string[] wcentenas = { "", " e cento", " e duzentos", " e trezentos", " e quatrocentos", " e quinhentos", " e seiscentos", " e setecentos", " e oitocentos", " e novecentos" };
                string[] wplural = { " bilhões", " milhões", " mil", "" };
                string[] wsingular = { " bilhão", " milhão", " mil", "" };
                string wextenso = "";
                string wfracao;
                wvalor = wvalor.Replace("R$", "");
                string wnumero = wvalor.Replace(",", "").Trim();
                wnumero = wnumero.Replace(".", "").PadLeft(14, '0');
                if (Int64.Parse(wnumero.Substring(0, 12)) > 0)
                {
                    for (int i = 0; i < 4; i++)
                    {
                        wfracao = wnumero.Substring(i * 3, 3);
                        if (int.Parse(wfracao) != 0)
                        {
                            if (int.Parse(wfracao.Substring(0, 3)) == 100) wextenso += " e cem";
                            else
                            {
                                wextenso += wcentenas[int.Parse(wfracao.Substring(0, 1))];
                                if (int.Parse(wfracao.Substring(1, 2)) > 10 && int.Parse(wfracao.Substring(1, 2)) < 20) wextenso += wdezes[int.Parse(wfracao.Substring(2, 1))];
                                else
                                {
                                    wextenso += wdezenas[int.Parse(wfracao.Substring(1, 1))];
                                    wextenso += wunidade[int.Parse(wfracao.Substring(2, 1))];
                                }
                            }
                            if (int.Parse(wfracao) > 1) wextenso += wplural;
                            else wextenso += wsingular;
                        }
                    }
                    if (Int64.Parse(wnumero.Substring(0, 12)) > 1) wextenso += " reais";
                    else wextenso += " real";
                }
                wfracao = wnumero.Substring(12, 2);
                if (int.Parse(wfracao) > 0)
                {
                    if (int.Parse(wfracao.Substring(0, 2)) > 10 && int.Parse(wfracao.Substring(0, 2)) < 20) wextenso = wextenso + wdezes[int.Parse(wfracao.Substring(1, 1))];
                    else
                    {
                        wextenso += wdezenas[int.Parse(wfracao.Substring(0, 1))];
                        wextenso += wunidade[int.Parse(wfracao.Substring(1, 1))];
                    }
                    if (int.Parse(wfracao) > 1) wextenso += " centavos";
                    else wextenso += " centavo";
                }
                if (wextenso != "") wextenso = wextenso.Substring(3, 1).ToUpper() + wextenso.Substring(4);
                else wextenso = "Nada";
                return wextenso;
            }

            /// <summary>
            /// Autor: Marcos
            /// Faz converção de imagem em butes...
            /// </summary> 
            /// <param name="texto">converte imagem</param>
            /// <returns>converte imagem</returns>
            public static byte[] cmdImagemParaByte(System.Drawing.Image imageToConvert, ImageFormat formatOfImage)
            {
                byte[] retorno;
                try
                {
                    using (MemoryStream ms = new MemoryStream())
                    {
                        imageToConvert.Save(ms, formatOfImage);
                        retorno = ms.ToArray();
                    }
                }
                catch (Exception)
                {
                    throw;
                }
                return retorno;
            }

            /// <summary>
            /// Autor: Marcos
            /// Estimativa de tempo gasto em uma consulta (em segundos)
            /// </summary> 
            /// <param name="texto">Medir tempo</param>
            /// <returns>Medir tempo</returns>
            public static string cmdCronometro(string param, DateTime tempo)
            {
                /*
                    Os principais métodos e propriedades de TimeSpan são : 
                
                    * Propriedades Públicas 
                    Days                Obtêm o número total de dias representado pela instância  
                    Hours               Obtêm o número total de horas representado pela instância.  
                    Milliseconds        Obtêm o número total de milliseconds representado pela instância.  
                    Minutes             Obtêm o número total de minutos representado pela instância.  
                    Seconds             Obtêm o número total de segundos representado pela instância.  
                    Ticks               Obtêm o valor da instância expressa em ticks.  
                    TotalDays           Obtêm o valor da instância expressa em dias totais e fracionários.  
                    TotalHours          Obtêm o valor da instância expressa em horas totais e fracionárias.  
                    TotalMilliseconds   Obtêm o valor da instância expressa em milisegundos totais e não inteiros.  
                    TotalMinutes        Obtêm o valor da instância expressa em minutos totais e não inteiros.  
                    TotalSeconds        Obtêm o valor da instância expressa em segundos totais e não inteiros  

                    * Métodos Públicos 
                    Add         Incluir um TimeSpan especifico na instância.  
                    Compare     Compara dois valores de TimeSpan e retorna um inteiro que indica seu relacionamento.  
                    Duration    Retorna o TimeSpan cujo valor é o valor absoluto da instância.  
                    Equals  Overloaded. Overridden. Retorna um valor que indica se duas instâncias de TimeSpan são iguais.  
                    Subtract    Subtrai o valor definido de TimeSpan de sua instância.  
                    ToString    Overridden. Retorna uma representação em string de um valor da instância.  
                */
                DateTime tempoI;  //tempo inicial
                DateTime tempoF;  //tempo final
                TimeSpan tempoT;  //tempo total 
                string retorno;

                switch (param)
                {
                    case "I":  //iniciar
                        tempoI = DateTime.Now;
                        retorno = tempoI.ToString();
                        break;
                    case "F":  //parar
                        tempoI = tempo;
                        tempoF = DateTime.Now;
                        tempoT = tempoF.Subtract(tempoI);
                        retorno = tempoT.TotalSeconds.ToString("0.000000") + " seg.";
                        break;
                    default:
                        retorno = "";
                        break;

                }
                return retorno;
            }

            #endregion

            #region Métodos    

            
            /// <summary>
            /// Autor: Marcos
            /// Trata controle
            /// </summary> 
            /// <param name="texto">Este form, Ativa, limpa</param>
            /// <returns>Este form, Ativa, limpa</returns>
            public static void cmdTratarComboBox(Control form, bool ativar, bool limpar)
            {
                foreach (Control ctl in form.Controls)
                {
                    if (ctl is ComboBox)
                    {
                       
                        if (ativar)
                        {
                            ((ComboBox)ctl).Enabled = true;
                            ((ComboBox)ctl).BackColor = SystemColors.Info;
                        }
                        else
                        {
                            ((ComboBox)ctl).Enabled = false;
                            ((ComboBox)ctl).BackColor = Color.White;

                        }
                        if (limpar)
                        {
                            ((ComboBox)ctl).Text = string.Empty;
                        }

                    }
                    else if (ctl.Controls.Count > 0)
                    {
                        cmdTratarComboBox(ctl, ativar, limpar);
                    }
                }
            }
            
            /// <summary>
            /// Autor: Marcos
            /// Trata controle
            /// </summary> 
            /// <param name="texto">Este form, Ativa, limpa</param>
            /// <returns>Este form, Ativa, limpa</returns>
            public static void cmdTratarTextBox(Control form, bool ativar, bool limpar)
            {
                foreach (Control ctl in form.Controls)
                {
                    if (ctl is TextBox)
                    {
                        
                        if (ativar)
                        {
                            ((TextBox)ctl).ForeColor = Color.Red;
                            ((TextBox)ctl).Enabled = true;
                            ((TextBox)ctl).BackColor = SystemColors.Info;
                        }
                        else
                        {
                            ((TextBox)ctl).Enabled = false;
                            ((TextBox)ctl).BackColor = Color.White;

                        }
                        if (limpar)
                        {
                            ((TextBox)ctl).Text = string.Empty;
                        }

                    }
                    else if (ctl.Controls.Count > 0)
                    {
                        cmdTratarTextBox(ctl, ativar, limpar);
                    }
                }
            }

            /// <summary>
            /// Autor: Marcos
            /// Trata controle
            /// </summary> 
            /// <param name="texto">Este form, Ativa, limpa</param>
            /// <returns>Este form, Ativa, limpa</returns>
            public static void cmdTratarMaskedTextBox(Control form, bool ativar, bool limpar)
            {
                foreach (Control ctl in form.Controls)
                {
                    if (ctl is MaskedTextBox)
                    {
                        if (ativar)
                        {
                            ((MaskedTextBox)ctl).Enabled = true;
                            ((MaskedTextBox)ctl).BackColor = SystemColors.Info;
                        }
                        else
                        {
                            ((MaskedTextBox)ctl).Enabled = false;
                            ((MaskedTextBox)ctl).BackColor = Color.White;

                        }
                        if (limpar)
                        {
                            ((MaskedTextBox)ctl).Text = string.Empty;
                        }

                    }
                    else if (ctl.Controls.Count > 0)
                    {
                        cmdTratarMaskedTextBox(ctl, ativar, limpar);
                    }
                }
            }
            /// <summary>
            /// Autor: Marcos
            /// VERIFICAR ARQUIVO NESCESSARIO A EXECUÇÃO DO PROGRAMA
            /// </summary> 
            /// <param name="texto">VERIFICAR ARQUIVO EXISTE</param>
            /// <returns>VERIFICAR ARQUIVO EXISTE</returns>
            public static bool cmdVerificaArquivo(string pathArquivo)
            {
                if (System.IO.File.Exists(pathArquivo))
                {
                    return true;
                }
                else
                {
                    MessageBox.Show("Aquivo " + pathArquivo + " não encontrado.", "Aviso", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    return false;
                }
            }

            /// <summary>
            /// Autor: Marcos
            /// VERIFICAR VERSÃO FRAMEWORK
            /// </summary> 
            /// <param name="texto">VERIFICAR VERSÃO FRAMEWORK</param>
            /// <returns>VERIFICAR VERSÃO FRAMEWORK</returns>
            public static bool cmdVerificaFramework(int versao)
            {
                string key1 = "";
                string key2 = "";
                string key3 = "";

                bool v10 = false;
                bool v11 = false;
                bool v20 = false;
                bool resposta = false;

                try
                {
                    key1 = Microsoft.Win32.Registry.LocalMachine.OpenSubKey("SOFTWARE").OpenSubKey("Microsoft").OpenSubKey(".NETFramework").OpenSubKey("Policy").OpenSubKey("v1.0").GetValue("3705").ToString();
                }
                catch (Exception)
                {
                }

                try
                {
                    key2 = Microsoft.Win32.Registry.LocalMachine.OpenSubKey("SOFTWARE").OpenSubKey("Microsoft").OpenSubKey(".NETFramework").OpenSubKey("Policy").OpenSubKey("v1.1").GetValue("4322").ToString();
                }
                catch (Exception)
                {
                }

                try
                {
                    key3 = Microsoft.Win32.Registry.LocalMachine.OpenSubKey("SOFTWARE").OpenSubKey("Microsoft").OpenSubKey(".NETFramework").OpenSubKey("Policy").OpenSubKey("v2.0").GetValue("50727").ToString();
                }
                catch (Exception)
                {
                }

                v10 = (key1 == "3321-3705");
                v11 = (key2 == "3706-4322");
                v20 = (key3 == "50727-50727");

                switch (versao)
                {
                    case 10:
                        if (v10)
                        { resposta = true; }
                        else
                        { resposta = false; }
                        break;
                    case 11:
                        if (v11) { resposta = true; }
                        else { resposta = false; }
                        break;
                    case 20:
                        if (v20)
                        { resposta = true; }
                        else
                        { resposta = false; }
                        break;
                }
                if (!resposta)
                {
                    MessageBox.Show(".Net Framework v1.0 - " + v10.ToString() + Environment.NewLine +
                                    ".Net Framework v1.1 - " + v11.ToString() + Environment.NewLine +
                                    ".Net Framework v2.0 - " + v20.ToString() + Environment.NewLine +
                                    ".Net Framework versão " + versao.ToString() + " é requerido para continuar com a aplicação.", "Framework", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
                return resposta;
            }

            /// <summary>
            /// Autor: Tony
            /// Habilitar ou desabilitar ToolStripButton
            /// </summary> 
            /// <param name="BackColor">ToolStripButton</param>
            /// <returns>ToolStripButton</returns>
            public static void cmdHabilitaToolStripButton(ToolStripButton parNome, int parametro)
            {
                switch (parametro)
                {
                    case 0:
                        parNome.Enabled = false;
                        break;
                    case 1:
                        parNome.Enabled = true;
                        break;
                    default:
                        if (parNome.Enabled == false)
                        {
                            parNome.Enabled = true;
                        }
                        else if (parNome.Enabled == true)
                        {
                            parNome.Enabled = false;
                        }
                        break;
                }
            }



            /// <summary>
            /// Autor: Tony
            /// Habilitar ou desabilitar DataGridView
            /// </summary> 
            /// <param name="BackColor">DataGridView</param>
            /// <returns>DataGridView</returns>
            public static void cmdHabilitaDataGridView(DataGridView parNome, int parametro)
            {
                switch (parametro)
                {
                    case 0:
                        parNome.EditMode = DataGridViewEditMode.EditProgrammatically;
                        parNome.GridColor = SystemColors.Window;
                        break;
                    case 1:
                        parNome.EditMode = DataGridViewEditMode.EditOnEnter;
                        parNome.GridColor = SystemColors.Info;
                        break;
                    default:
                        if (parNome.EditMode == DataGridViewEditMode.EditProgrammatically)
                        {
                            parNome.EditMode = DataGridViewEditMode.EditOnEnter;
                            parNome.GridColor = SystemColors.Info;
                        }
                        else //if (parNome.EditMode == DataGridViewEditMode.EditOnEnter)
                        {
                            parNome.EditMode = DataGridViewEditMode.EditProgrammatically;
                            parNome.GridColor = SystemColors.Window;
                        }
                        break;
                }
            }

            /// <summary>
            /// Autor: Tony
            /// Habilitar ou desabilitar RadioButton
            /// </summary> 
            /// <param name="BackColor">RadioButton</param>
            /// <returns>RadioButton</returns>
            public static void cmdHabilitaRadioButton(RadioButton parNome, int parametro)
            {
                switch (parametro)
                {
                    case 0:
                        parNome.Enabled = false;
                        break;
                    case 1:
                        parNome.Enabled = true;
                        break;
                    default:
                        if (parNome.Enabled == false)
                        {
                            parNome.Enabled = true;
                        }
                        else if (parNome.Enabled == true)
                        {
                            parNome.Enabled = false;
                        }
                        break;
                }
            }

            /// <summary>
            /// Autor: Tony
            /// Habilitar ou desabilitar CheckBox
            /// </summary> 
            /// <param name="BackColor">CheckBox</param>
            /// <returns>CheckBox</returns>
            public static void cmdHabilitaCheckBox(CheckBox parNome, int parametro)
            {
                switch (parametro)
                {
                    case 0:
                        parNome.Enabled = false;
                        break;
                    case 1:
                        parNome.Enabled = true;
                        break;
                    default:
                        if (parNome.Enabled == false)
                        {
                            parNome.Enabled = true;
                        }
                        else if (parNome.Enabled == true)
                        {
                            parNome.Enabled = false;
                        }
                        break;
                }
            }

            /// <summary>
            /// Autor: Tony
            /// Habilitar ou desabilitar Button
            /// </summary> 
            /// <param name="BackColor">Button</param>
            /// <returns>Button</returns>
            public static void cmdHabilitaButton(Button parNome, int parametro)
            {
                switch (parametro)
                {
                    case 0:
                        parNome.Enabled = false;
                        break;
                    case 1:
                        parNome.Enabled = true;
                        break;
                    default:
                        if (parNome.Enabled == false)
                        {
                            parNome.Enabled = true;
                        }
                        else if (parNome.Enabled == true)
                        {
                            parNome.Enabled = false;
                        }
                        break;
                }
            }

            /// <summary>
            /// Autor: Tony
            /// Muda a cor do controle dateTimePicker de Window para Info e vice-versa.
            /// </summary> 
            /// <param name="BackColor">DateTimePicker</param>
            /// <returns>DateTimePicker</returns>
            public static void cmdHabilitaDateTimePicker(DateTimePicker parNome, int parametro)
            {
                switch (parametro)
                {
                    case 0:
                        parNome.Enabled = false;
                        break;
                    case 1:
                        parNome.Enabled = true;
                        break;
                    default:
                        if (parNome.Enabled == false)
                        {
                            parNome.Enabled = true;
                        }
                        else if (parNome.Enabled == true)
                        {
                            parNome.Enabled = false;
                        }
                        break;
                }
            }

            /// <summary>
            /// Autor: Tony
            /// Muda a cor do controle Textbox de Window para Info e vice-versa. 
            /// </summary> 
            /// <param name="Enable">Textbox</param>
            /// <returns>Textbox</returns>
            public static void cmdHabilitaTextBox(TextBox parNome, int parametro)
            {
                switch (parametro)
                {
                    case 0:
                        parNome.BackColor = SystemColors.Window;
                        parNome.ReadOnly = true;
                        break;
                    case 1:
                        parNome.BackColor = SystemColors.Info;
                        parNome.ReadOnly = false;
                        break;
                    default:
                        if (parNome.BackColor == SystemColors.Window)
                        {
                            parNome.BackColor = SystemColors.Info;
                            parNome.ReadOnly = false;
                        }
                        else if (parNome.BackColor == SystemColors.Info)
                        {
                            parNome.BackColor = SystemColors.Window;
                            parNome.ReadOnly = true;
                        }
                        break;
                }
            }

            /// <summary>
            /// Autor: Tony
            /// Muda a cor do controle ComboBox de Window para Info e vice-versa. 
            /// </summary> 
            /// <param name="Enable">ComboBox</param>
            /// <returns>ComboBox</returns>
            public static void cmdHabilitaComboBox(ComboBox parNome, int parametro)
            {
                switch (parametro)
                {
                    case 0:
                        parNome.Enabled = false;
                        parNome.BackColor = Color.White;
                        parNome.ForeColor = Color.Black;
                        break;
                    case 1:
                        parNome.Enabled = true;
                        parNome.BackColor = SystemColors.Info;
                        break;
                    default:
                        if (parNome.BackColor == SystemColors.Window)
                        {
                            parNome.Enabled = true;
                            parNome.BackColor = SystemColors.Info;
                        }
                        else if (parNome.BackColor == SystemColors.Info)
                        {
                            parNome.Enabled = false;
                            parNome.BackColor = Color.White;
                        }
                        break;
                }
            }

            /// <summary>
            /// Autor: Tony
            /// Muda a cor do controle MaskedTextBox de Window para Info e vice-versa. 
            /// </summary> 
            /// <param name="Enable">MaskedTextBox</param>
            /// <returns>MaskedTextBox</returns>
            public static void cmdHabilitaMaskedTextBox(MaskedTextBox parNome, int parametro)
            {
                switch (parametro)
                {
                    case 0:
                        parNome.BackColor = SystemColors.Window;
                        parNome.ReadOnly = true;
                        break;
                    case 1:
                        parNome.BackColor = SystemColors.Info;
                        parNome.ReadOnly = false;
                        break;
                    default:
                        if (parNome.BackColor == SystemColors.Window)
                        {
                            parNome.BackColor = SystemColors.Info;
                            parNome.ReadOnly = false;
                        }
                        else if (parNome.BackColor == SystemColors.Info)
                        {
                            parNome.BackColor = SystemColors.Window;
                            parNome.ReadOnly = true;
                        }
                        break;
                }
            }


            /// <summary>
            /// Autor: Tony
            /// Criar Controle manualmente do Textbox
            /// </summary> 
            /// <param name="texto">Criar Controle</param>
            /// <returns>Criar Controle</returns>
            public static void DoCriaControleTextBox(TextBox txtparametro, Form frmparametro)
            {
                txtparametro.Parent = frmparametro;
                txtparametro.CreateControl();
            }

            public static void cmdCriaControleTextBox(TextBox txtparametro, TabPage frmparametro)
            {
                txtparametro.Parent = frmparametro;
                txtparametro.CreateControl();
            }

            /// <summary>
            /// Autor: Tony
            /// Criar Controle manualmente do ComboBox
            /// </summary> 
            /// <param name="texto">Criar Controle</param>
            /// <returns>Criar Controle</returns>
            public static void cmdCriaControleComboBox(ComboBox cmbparametro, Form frmparametro)
            {
                cmbparametro.Parent = frmparametro;
                cmbparametro.CreateControl();
                cmbparametro.Visible = true;
            }

            public static void cmdCriaControleComboBox(ComboBox cmbparametro, TabPage frmparametro)
            {
                cmbparametro.Parent = frmparametro;
                cmbparametro.CreateControl();
                cmbparametro.Visible = true;
            }


            /// <summary>
            /// Autor: Marcos e Tony
            /// limpa textbox
            /// </summary> 
            /// <param name="texto">limpa textbox</param>
            /// <returns>limpa textbox</returns>
            public static void cmdLimpaTextBox(TextBox parTextBox, string parTexto)
            {
                if (parTextBox.Text == parTexto)
                {
                    parTextBox.Text = "";
                }
            }

            /// <summary>
            /// Autor: Marcos e Tony
            /// limpa objeto
            /// </summary> 
            /// <param name="texto">limpa textbox</param>
            /// <returns>limpa textbox</returns>
            public static void cmdLimpaTexto(string parTexto)
            {
                if (parTexto == "PREENCHER...")
                {
                    parTexto = "";
                }
            }

            /// <summary>
            /// Autor: Marcos
            /// Verifica status financeiro de cliente
            /// branco ... inativo
            /// azul ..... ativo - não posue débitos
            /// verde .... ativo - posue débitos não vencidos
            /// amarelo .. ativo - posue débitos vencidos - venda liberada
            /// vermelho . ativo - posue débitos vencidos - venda bloqueada
            /// </summary> 
            /// <param name="texto">status financeiro</param>
            /// <returns>status financeiro</returns>
            /// 
            public static void cmdVerificaClienteStatus()
            {
                ToolTip toolTip1 = new ToolTip();
                toolTip1.AutoPopDelay = 5000;
                toolTip1.InitialDelay = 1000;
                toolTip1.ReshowDelay = 500;
                toolTip1.ShowAlways = true;

                //tony, colocar para verificar no banco
                /*if (SUSPENSO=="NAO")
                    {
                    if(divida<=0)
                    {
                        pictureBoxStatus.Image = Properties.Resources.button_blue;
                        toolTip1.SetToolTip(this.pictureBoxStatus, "LIBERADO - Este cliente possue débitos não vencidos");
                    }
                    if(divida<=0 && vencido=="NÃO")
                    {
                        pictureBoxStatus.Image = Properties.Resources.button_green;
                        toolTip1.SetToolTip(this.pictureBoxStatus, "LIBERADO - Este cliente possue débitos não vencidos");
                    }
                    
                    if(divida>0 && vencido=="SIM")
                    {                        
                        pictureBoxStatus.Image = Properties.Resources.button_yellow;
                        toolTip1.SetToolTip(this.pictureBoxStatus, "LIBERADO - Este cliente possue débitos vencidos");
                    }
                    if(divida>0 && vencido=="SIM") 
                    {
                       pictureBoxStatus.Image = Properties.Resources.button_red;
                       toolTip1.SetToolTip(this.pictureBoxStatus, "SUSPENSA - Este cliente possue débitos vencidos");                    
                    }
                
                }
                else
                {
                    pictureBoxStatus.BringToFront();
                    pictureBoxStatus.Image = Properties.Resources.button_withe;
                } 
                */



            }


        /// <summary>
            /// Autor: Marcos
            /// destacar textbox
            /// </summary> 
            /// <param name="BackColor">textbox</param>
            /// <returns>textbox</returns>
            public static void cmdAtivarTextBox(TextBox parNome)
            {
                if (parNome.BackColor == SystemColors.Window)
                {
                    parNome.BackColor = SystemColors.Info;
                }
                else if (parNome.BackColor == SystemColors.Info)
                {
                    parNome.BackColor = SystemColors.Window;
                }
            }

            /// <summary>
            /// Autor: Marcos
            /// destacar combobox
            /// </summary> 
            /// <param name="BackColor">combobox</param>
            /// <returns>combobox</returns>
            public static void cmdAtivarCombobox(ComboBox parNome)
            {
                if (parNome.BackColor == SystemColors.Window)
                {
                    parNome.BackColor = SystemColors.Info;
                }
                else if (parNome.BackColor == SystemColors.Info)
                {
                    parNome.BackColor = SystemColors.Window;
                }
            }

            /// <summary>
            /// Autor: Marcos
            /// destacar maskedTextBox
            /// </summary> 
            /// <param name="BackColor">maskedTextBox</param>
            /// <returns>maskedTextBox</returns>
            public static void cmdAtivarmaskedTextBox(MaskedTextBox parNome)
            {
                if (parNome.BackColor == SystemColors.Window)
                {
                    parNome.BackColor = SystemColors.Info;
                }
                else if (parNome.BackColor == SystemColors.Info)
                {
                    parNome.BackColor = SystemColors.Window;
                }
            }


              /// <summary>
            /// Autor: Marcos
            /// Faz alteração de fotos de clientes
            /// </summary> 
            /// <param name="texto">alterar foto</param>
            /// <returns>alterar foto</returns>
            public void cmdAlterarFoto(PictureBox obj)
            {

                string foto = null;
                OpenFileDialog dlg = new OpenFileDialog();

                dlg.Title = "Selecionar imagem...";
                dlg.Filter = "JPG (*.jpg)|*.jpg"
                    //+ "|BMP (*.bmp)|*.bmp"
                    //+ "|GIF (*.gif)|*.gif"
                    //+ "|PNG (*.png)|*.png"
                            + "|All files (*.*)|*.*";

                if (dlg.ShowDialog() == DialogResult.OK)
                {
                    try
                    {
                        obj.Image = new Bitmap(dlg.OpenFile());
                        foto = dlg.FileName;
                    }
                    catch (Exception ex)
                    {
                        MessageBox.Show("Não foi possivel carregar a imagem: " + ex.Message);
                    }
                }
                dlg.Dispose();
            }

            /// <summary>
            /// Autor: Marcos
            /// Metodo para encerrar o sistema
            /// </summary> 
            /// <param name="texto">sair</param>
            /// <returns>sair</returns>
            public static void cmdSair()
            {
                DialogResult dlg;
                dlg = MessageBox.Show("Deseja mesmo sair do sistema?", "Responda...", MessageBoxButtons.YesNo, MessageBoxIcon.Question);
                if (dlg.Equals(DialogResult.Yes))
                {
                    Application.Exit();
                }
            }


            /// <summary>
            /// Autor: Marcos
            /// Faz a padronização de posição, tamanho e tipo de forms
            /// </summary> 
            /// <param name="texto">padroniza form</param>
            /// <returns>padroniza form</returns>
            public static void cmdPadronizaForm(Form frm, String frmTitulo)
            {
                frm.ClientSize = new System.Drawing.Size(634, 456);  // equivale a 640x480
                frm.Name = frmTitulo;
                frm.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedToolWindow;
                frm.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            }


            /// <summary>
            /// Autor: Marcos
            /// Faz a padronização de posição, tamanho e tipo de forms
            /// </summary> 
            /// <param name="texto">padroniza form</param>
            /// <returns>padroniza form</returns>
            public static void cmdChamaForm(Form frm, String frmTitulo)
            {
                frm.ClientSize = new System.Drawing.Size(634, 456);  // equivale a 640x480
                frm.Name = frmTitulo;
                frm.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedToolWindow;
                frm.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            }



            /*
            /// <summary>
            /// Autor: Marcos
            /// Faz exibição de mensagem, principalemente em processos demorados...
            /// </summary> 
            /// <param name="texto">Aviso</param>
            /// <returns>Aviso</returns>
            public static void DoAviso(int opcao)
            {
                Thread thr = new Thread(new ThreadStart(DoAguarde));
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
            * 
            */

            #endregion

            #region Public Assembly Attribute Accessors
            /// <summary>
            /// Autor: Marcos
            /// retorno de versão e outras informações
            /// </summary> 
            /// <param name="texto">retorno de versão</param>
            /// <returns>retorno de versão</returns>
            public static string cmdAssemblyTitle
            {
                get
                {
                    object[] attributes = Assembly.GetExecutingAssembly().GetCustomAttributes(typeof(AssemblyTitleAttribute), false);
                    if (attributes.Length > 0)
                    {
                        AssemblyTitleAttribute titleAttribute = (AssemblyTitleAttribute)attributes[0];
                        if (titleAttribute.Title != "")
                        {
                            return titleAttribute.Title;
                        }
                    }
                    return System.IO.Path.GetFileNameWithoutExtension(Assembly.GetExecutingAssembly().CodeBase);
                }
            }

            public static string cmdAssemblyVersion
            {
                get
                {
                    return Assembly.GetExecutingAssembly().GetName().Version.ToString();
                }
            }

            public static string cmdAssemblyDescription
            {
                get
                {
                    object[] attributes = Assembly.GetExecutingAssembly().GetCustomAttributes(typeof(AssemblyDescriptionAttribute), false);
                    if (attributes.Length == 0)
                    {
                        return "";
                    }
                    return ((AssemblyDescriptionAttribute)attributes[0]).Description;
                }
            }

            public static string cmdAssemblyProduct
            {
                get
                {
                    object[] attributes = Assembly.GetExecutingAssembly().GetCustomAttributes(typeof(AssemblyProductAttribute), false);
                    if (attributes.Length == 0)
                    {
                        return "";
                    }
                    return ((AssemblyProductAttribute)attributes[0]).Product;
                }
            }

            public static string cmdAssemblyCopyright
            {
                get
                {
                    object[] attributes = Assembly.GetExecutingAssembly().GetCustomAttributes(typeof(AssemblyCopyrightAttribute), false);
                    if (attributes.Length == 0)
                    {
                        return "";
                    }
                    return ((AssemblyCopyrightAttribute)attributes[0]).Copyright;
                }
            }

            public static string cmdAssemblyCompany
            {
                get
                {
                    object[] attributes = Assembly.GetExecutingAssembly().GetCustomAttributes(typeof(AssemblyCompanyAttribute), false);
                    if (attributes.Length == 0)
                    {
                        return "";
                    }
                    return ((AssemblyCompanyAttribute)attributes[0]).Company;
                }
            }
            #endregion

    }
}
