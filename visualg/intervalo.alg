algoritmo "intervalo"
//exemplo de algoritmo que mostra
//os números inteiros em um intervalo
//e verifica se número é par

var
numero:inteiro
inicio
escreva("Informe um número inteiro:")
leia(numero)
se((numero> -10) e (numero<10)) entao
   escreval("número no intervalo")
senao
   escreval("número FORA do intervalo")
   se(numero mod 2=0) entao
      escreval("número é par")
   senao
      escreval("número é impar")
   fimse
fimse
fimalgoritmo

//Atividade: Agora faça um algoritmo que mostre os números
//FORA do intervalo e se esse número é PAR ou IMPAR!
//Boa sorte!
