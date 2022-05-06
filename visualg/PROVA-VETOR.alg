algoritmo "semnome"
// Função :
// Autor :
// Data : 15/12/2014
// Seção de Declarações 
var
MAT_A: vetor[1..100] de inteiro
MAT_B: vetor[1..100] de inteiro
i,j,contador: inteiro
inicio
contador<-1
para i de 1 ate 2 faca
     para j de 1 ate 3 faca
        MAT_A[i,j]<-contador
        contador<-contador+1
     fimpara
fimpara
escreval("MATRIZ A")
para i de 1 ate 2 faca
     para j de 1 ate 3 faca
          escreva(MAT_A[i,j])
     fimpara
     escreval
fimpara
para i de 1 ate 3 faca
     para j de 1 ate 2 faca
        MAT_B[i,j]<-MAT_A[j,i]
     fimpara
fimpara
escreval("MATRIZ B")
para i de 1 ate 3 faca
     para j de 1 ate 2 faca
          escreva(MAT_B[i,j])
     fimpara
     escreval
fimpara
// Seção de Comandos
fimalgoritmo
