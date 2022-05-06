algoritmo "QUESTAO 02"
// Função :
// Autor : MARLON SOUZA SOARES
// Data : 26/11/2013
// Seção de Declarações
var
h:caracter
c,a,b,n,nn,mult,nmult,v,p :inteiro
d:real
inicio
// Seção de Comandos
escreval ("FIBONACI")
ESCREVA ("INFORME A QTDE DE TERMOS: ")
leia(v)
P<-v
repita
   c<-1
   para n de 1 ate v faca
      se n=1 entao
         a<-1
      senao
         a<-b+c
         b<-c
         c<-a
      fimse
   fimpara
   se a mod 3=0 entao
      mult<-mult+1
   senao
      nmult<-nmult+1
   fimse
   se v mod 2=0 entao
      d<-a*1.05
      h<-"+5% ="
   senao
      d<-a*1.02
      h<-"+2% ="
   fimse
   n<-n-1
   escreval (n,"º TERMO: ",a,"",h," ",d:3:2)
      v<-v-1
   a<-0
   b<-0
ate v=0
escreval
escreval ("TOTAL DE NUMEROS MULTIPLOS DE 3: ",MULT)
c<-1
   para n de 1 ate p faca
      se n=1 entao
         a<-1
      senao
         a<-b+c
         b<-c
         c<-a
      fimse
      se a mod 3=0 entao
      escreva (a)
      fimse
   fimpara
   escreval
 escreval ("TOTAL DE NUMEROS NAO MULTIPLOS DE 3: ",NMULT)
 c<-1
 a<-0
   b<-0
   para n de 1 ate p faca
      se n=1 entao
         a<-1
      senao
         a<-b+c
         b<-c
         c<-a
      fimse
      se a mod 3<>0 entao
      escreva (a)
      fimse
   fimpara
   escreval
fimalgoritmo
