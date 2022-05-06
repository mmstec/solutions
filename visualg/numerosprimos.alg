algoritmo "numeros primos"
// Função :  verifica se o numero é primo
// Autor :  Marcos Cordeiro
// Data : 01/06/2011
// Seção de Declarações
var
num,cont,primo: inteiro
inicio
// Seção de Comandos
escreva ("valor: ")
leia(num)
//laço com teste para o resto da divisão
para cont de 1 ate num passo 1 faca
   se (num % cont=0) entao
      primo<- primo + 1;
   fimse
fimpara
//teste para escrever na tela se é primo ou nao
se (primo=2) entao
   escreval ("O numero é primo")
senao
   escreval ("O numero nao e primo")
fimse

fimalgoritmo


