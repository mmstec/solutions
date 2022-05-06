algoritmo "ordenação"
var
a,b,c,aux:inteiro
inicio
   escreval("Escreva três numeros inteiros.:")
   leia(a,b,c)
    se(a>b) entao
      aux<-a
      a<-b
      b<-aux
   fimse
   se(a>c) entao
      aux<-a
      a<-b
      b<-aux
   fimse
   se(a>b) entao
      aux<-a
      a<-c
      c<-aux
   fimse
   se(b>c) entao
      aux<-b
      b<-c
      c<-aux
   fimse
escreval("Organizando...",a,b,c)
fimalgoritmo
