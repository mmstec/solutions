algoritmo "fatorial"
var
cont, num, mult: Inteiro

inicio
   escreva ("Informe um número e conheça o seu fatorial:  ")
   leia (num)
   para cont de num ate 2 passo -1 faca
      se (cont = num) entao
          mult <- cont * (cont - 1)
          escreval ("")
          escreval (cont:10, " * ", (cont - 1):2, " = ", mult)
      fimse
      se (cont < num) e (cont <> 1)  entao
           mult <- mult * (cont - 1)
           escreval (mult:10, " * ", (cont - 1):2, " = ", mult)
      fimse
    fimpara
    escreval ("")
    escreval ("O fatorial de ", num, " é: ", mult)
fimalgoritmo
