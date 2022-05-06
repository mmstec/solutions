algoritmo "fibonacci"
var
a,b,c,fib,n_termos:inteiro
inicio
escreval("FIBONACI")
escreva("INFORME A QTDE DE TERMOS: ")
leia(n_termos)
repita
   a<-1
   para c de 1 ate n_termos faca
      se c=1 entao
         fib<-1
      senao
         fib<-b+a
         b<-a
         a<-fib
      fimse
   fimpara
   c<-c-1
   escreval (c:2,"º TERMO: ",fib)
   n_termos<-n_termos-1
   fib<-0
   b<-0
ate n_termos=0
escreval
fimalgoritmo
