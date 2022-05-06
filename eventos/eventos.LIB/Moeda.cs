using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Drawing;

namespace eventos.LIB
{
    class Moeda
    {
        //Textbox que somente aceita tipos de dados double
        public class doubleTextBox : TextBox
        {
            //Evento ao digitar uma tecla. Só aceita teclas referentes ao tipo de dados double. 
            //Suprime outros tipos de tecla.
            protected override void OnKeyDown(System.Windows.Forms.KeyEventArgs e)
            {
                //Se for sinal de negativo "-", então deve ser o primeiro caracter
                if (e.KeyCode == Keys.Subtract || e.KeyCode == Keys.OemMinus)
                {
                    if (this.Text.Length > 0)
                        e.SuppressKeyPress = true;
                    else
                        e.SuppressKeyPress = false;
                }
                //Se for vírgua ou ponto, deve-se existir apenas 1,
                //Se for o primeiro caracter, o sistema joga um 0 a esquerda. 
                //Se existir uma vírgula logo depois do sinal de negativo, o sistema joga um 0 a esquerda
                else if (e.KeyCode == Keys.Oemcomma || e.KeyCode == Keys.Decimal || e.KeyCode == Keys.OemPeriod)
                {
                    if (this.Text.Length < 1)
                    {
                        this.Text = "";
                        this.Text = "0,";
                        e.SuppressKeyPress = true;
                        this.SelectionStart = this.Text.Length;
                    }
                    else
                    {
                        if (this.Text.Length == 1 && this.Text.Substring(0, 1) == "-")
                        {
                            this.Text = "";
                            this.Text = "-0,";
                            e.SuppressKeyPress = true;
                            this.SelectionStart = this.Text.Length;
                        }
                        else
                        {
                            int cont = 0;
                            int qtd = 0;
                            while (cont < this.Text.Length)
                            {
                                if (this.Text.Substring(cont, 1) == "," || this.Text.Substring(cont, 1) == ".")
                                {
                                    qtd++;
                                    break;
                                }
                                cont++;
                            }

                            if (qtd > 0)
                                e.SuppressKeyPress = true;
                            else
                                e.SuppressKeyPress = false;
                        }
                    }
                }
                //Verifica se o caracter está no conjunto de caracteres permitido para double
                else if (e.KeyCode == Keys.NumPad0 || e.KeyCode == Keys.NumPad1 ||
                    e.KeyCode == Keys.NumPad2 || e.KeyCode == Keys.NumPad3 ||
                    e.KeyCode == Keys.NumPad4 || e.KeyCode == Keys.NumPad5 ||
                    e.KeyCode == Keys.NumPad6 || e.KeyCode == Keys.NumPad7 ||
                    e.KeyCode == Keys.NumPad8 || e.KeyCode == Keys.NumPad9 ||
                    e.KeyCode == Keys.D0 || e.KeyCode == Keys.D1 ||
                    e.KeyCode == Keys.D2 || e.KeyCode == Keys.D3 ||
                    e.KeyCode == Keys.D4 || e.KeyCode == Keys.D5 ||
                    e.KeyCode == Keys.D6 || e.KeyCode == Keys.D7 ||
                    e.KeyCode == Keys.D8 || e.KeyCode == Keys.D9 ||
                    e.KeyCode == Keys.Delete || e.KeyCode == Keys.Enter ||
                    e.KeyCode == Keys.Return || e.KeyCode == Keys.Back ||
                    e.KeyCode == Keys.Tab || e.KeyCode == Keys.Left ||
                    e.KeyCode == Keys.Right || e.KeyCode == Keys.Up ||
                    e.KeyCode == Keys.Down || e.KeyCode == Keys.End ||
                    e.KeyCode == Keys.Home || e.KeyCode == Keys.PageDown ||
                    e.KeyCode == Keys.PageUp || e.KeyCode == Keys.Oemcomma ||
                    e.KeyCode == Keys.Decimal || e.KeyCode == Keys.OemPeriod)
                {
                    //Caracter está no conjunto. Nao suprime o caracter
                    e.SuppressKeyPress = false;
                }
                else
                {
                    //Caracter está fora do conjunto, suprime
                    e.SuppressKeyPress = true;
                }
            }

            //Substitui tecla "ponto" por tecla "virgula"
            protected override void OnKeyPress(KeyPressEventArgs e)
            {
                if (e.KeyChar == '.')
                    e.KeyChar = ',';
            }

            //Padroniza a cor de fundo ao receber foco
            protected override void OnGotFocus(EventArgs e)
            {
                this.BackColor = Color.Yellow;
            }

            //Volta a cor original do componente ao perder foco
            protected override void OnLostFocus(EventArgs e)
            {
                this.BackColor = Color.Empty;
            }

            //Desabilita o botão direito do mouse, para evitar copy paste
            protected override void OnMouseDown(MouseEventArgs e)
            {
                if (e.Button == MouseButtons.Right)
                {
                    MessageBox.Show("");
                    return;
                }
                else
                    base.OnMouseDown(e);
            }
        }
    }
}
