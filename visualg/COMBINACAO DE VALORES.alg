algoritmo "semnome"
var
m,n1,n2,n3:inteiro
inicio
leia(n1)
m<-n1
leia(n2)
se(n2>m) entao
   m<-n2
fimse
se(n3>m) entao
   m<-n3
fimse
se(n2>m) entao
   m<-n3
fimse
leia(n2)
se(n1=n2 E n2=n3)entao
   escreva("Combinação de valores indesejada!")
senao
   escreva(m)
fimse
fimalgoritmo


