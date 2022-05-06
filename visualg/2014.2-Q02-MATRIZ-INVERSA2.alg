algoritmo "MATRIZ"
var
MAT_A:VETOR[1..20,1..20] DE INTEIRO
MAT_B:VETOR[1..20,1..20] DE INTEIRO
I,J,CONTADOR:INTEIRO
inicio
contador<-10
para i de 1 ate 2 faca
     para j de 1 ate 3 faca
        MAT_A[i,j]<-contador
        contador<-contador+1
     fimpara
fimpara
escreval("MATRIZ A")
para i de 1 ate 2 faca
     para j de 1 ate 3 faca
          escreva(MAT_A[i,j]:3)
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
          escreva(MAT_B[i,j]:3)
     fimpara
     escreval
fimpara
fimalgoritmo
