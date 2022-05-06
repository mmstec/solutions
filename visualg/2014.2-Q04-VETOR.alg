algoritmo "boasorte"                            //resposta: 5 6 5 8 2 2 4 1
var
v: vetor[0..8] de inteiro
i,aux: inteiro
inicio
V[0]<-0
V[1]<-5
V[2]<-1
V[3]<-4
V[4]<-2
V[5]<-7
V[6]<-80
V[7]<-3
V[8]<-6
escreval("escrevendo a matriz em tela...")
PARA i DE 1 ATE 8 FACA
     ESCREVA (v[i])
FIMPARA
PARA i DE 8 ATE 5 PASSO -1 FACA
   aux<-v[i]
   v[i]<-v[8-i+2]
   v[8-i+2]<- aux
FIMPARA
v[3]<-v[1]
v[v[3]]<-v[v[2]]

escreval
escreval("reescrevendo a matriz em tela...")
PARA i DE 1 ATE 8 FACA
     ESCREVA (v[i])
FIMPARA
fimalgoritmo
