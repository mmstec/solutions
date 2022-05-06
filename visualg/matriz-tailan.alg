algoritmo "tailan-teste"
var
MAT:VETOR[1..5,1..6] DE INTEIRO
i,j,contador:inteiro
inicio
//preenchendo a matriz em memoria
contador<-1
para i de 1 ate 5 faca
     para j de 1 ate 6 faca
          MAT[i,j]<-contador
          contador<-contador+1
     fimpara
fimpara
//ler a matriz ( imprimir em tela )
para i de 1 ate 5 faca
     para j de 1 ate 6 faca
          escreva(MAT[i,j]:4)
     fimpara
     escreval
fimpara
escreval
escreval
escreval("O quadrado de ",MAT[2,5]," É ",MAT[2,5]^2)
escreval("O quadrado de ",MAT[4,2]," É ",MAT[4,2]^2)
escreval("O quadrado de ",MAT[5,6]," É ",MAT[5,6]^2)
fimalgoritmo
