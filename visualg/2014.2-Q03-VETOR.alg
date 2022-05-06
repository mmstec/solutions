algoritmo "VETOR"
var
w: vetor[1..9] de inteiro
i,j,q,aux: inteiro
inicio
//preechendo o vetor
para i de 1 ate 9 faca
   w[i]<-i
fimpara
//trecho do código
para j de 1 ate 3 faca
   q<-j+1
   aux<-w[q]
   w[q]<-w[9-q] div 2
   w[9-q]<-aux
fimpara
//exemplo para ver o resultado
para i de 1 ate 9 faca
   escreva(w[i])
fimpara
fimalgoritmo
