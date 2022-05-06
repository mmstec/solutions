using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


namespace Fibonacci.Console
{
    class Program
    {
        static void Main(string[] args)
        {
            // Iniciamos o programa setando duas variáveis int 
            int a = 0, fib = 1;
            // A variável fib é testada no laço while, e enquanto for <= 100 o laço continua 
            while (fib <= 100)
            {
                // O Console mostra os valores inicias das variaveis ‘a’ e ‘fib’, que são ‘0’ e ‘1’ respectivamente 
                System.Console.Write(a + " " + fib + " ");
                // A partir daqui as variáveis ‘a’ e ‘fib’ começam a obter os valores umas das outras
                // ‘a’ será igual a ela mesma mais ‘fib’ 
                a += fib;
                // ‘fib’ será igual a ela mesma mais ‘a’ 
                fib += a;
                // O laço while só será encerrado quando a condição do laço for falsa 
            }
            // O Console apenas coloca um espaço em branco no final da linha 
            System.Console.ReadLine();
        }
    }
}
