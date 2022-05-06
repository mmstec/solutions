algoritmo "converter real em dolar"
// Função : converter o valor do real em dolar
// Autor : Marcos Cordeiro
// Data : 29/03/2011
// Seção de Declarações
var
      montante,cotacao: real
inicio
      // Seção de Comandos
      escreva  ("Digite o valor em reais: ")
      leia(montante)
      escreva  ("Digite  a cotação a do dolar: ")
      leia(cotacao)

      montante <- montante * (1 /cotacao);
      escreval
      escreva ("US$: ",montante)
fimalgoritmo
