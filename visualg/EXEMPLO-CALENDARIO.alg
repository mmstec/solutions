ALGORITMO "monta calendario"
var
mat:vetor[1..7,1..7] de inteiro
col,lin,contador:inteiro
x,numdias:inteiro
dia,mes,ano:caractere
data:caractere

funcao verificadiadoano(minhadata:caractere):caractere
var
a,b,c,d,ee,f,g,h,i,j:inteiro
dd, mm, aaaa:inteiro
resposta:caractere
inicio
dd<-caracpnum(copia(minhadata,0,2))
mm<-caracpnum(copia(minhadata,4,2))
aaaa<-caracpnum(copia(minhadata,7,4))
a<-int((12-mm) div 10)
b<-int(aaaa-a)
c<-int(mm+(12*a))
d<-int(b div 100)
ee<-int(d div 4)
f<-int(2-d+ee)

g<-int(365.25*b)
h<-int(30.6001*(c+1))
i<-int((f+g)+(h+dd)+5)
j<-int(i mod 7)
//Resto de I por 7,onde0<-SAB,1<-DOM,2<-SEG,3<-TER,4<-QUA,5<-QUI,6<-SEX

escolha(j)
caso 0
   resposta<-"SAB"
caso 1
   resposta<-"DOM"
caso 2
   resposta<-"SEG"
caso 3
   resposta<-"TER"
caso 4
   resposta<-"QUA"
caso 5
   resposta<-"QUI"
caso 6
   resposta<-"SEX"
outrocaso
   resposta<-"Erro ao tentar retornar o dia da semana"
fimescolha
retorne resposta
fimfuncao

inicio

escreval("Informe o mês e o ano (exp. 06/2015): ")
leia(data)
data<-"01/"+data
ano<-copia(data,7,4)
mes<-copia(data,4,2)
dia<-verificadiadoano(data)

//preechendo a matriz
contador<-1
para LIN de 1 ate 7 faca
   escolha(dia)
   caso "dom"
      dia<-"ok"
      x<-1
   caso "seg"
      dia<-"ok"
      x<-2
   caso "ter"
      dia<-"ok"
      x<-3
   caso "qua"
      dia<-"ok"
      x<-4
   caso "qui"
      dia<-"ok"
      x<-5
   caso "sex"
      dia<-"ok"
      x<-6
   caso "sab"
      dia<-"ok"
      x<-7
   outrocaso
      x<-1
   fimescolha
   para COL de x ate 7 faca
      mat[LIN,COL]<-contador
      contador<-contador+1
   fimpara
fimpara

//lendo a matriz
escreval(" -+--+--+--+--+--+--+")
escreval(" D| S| T| Q| Q| S| S|")
escreval(" -+--+--+--+--+--+--+")
para LIN de 1 ate 7 faca
   para COL de 1 ate 7 faca
      escolha(mes)
      caso "01"
         numdias<-31
      caso "02"
         se(caracpnum(ano) mod 400=0) ou ((caracpnum(ano) mod 4=0) e (caracpnum(ano) mod 100<>0)) entao
            numdias<-29
         senao
            numdias<-28
         fimse
      caso "03"
         numdias<-31
      caso "05"
         numdias<-31
      caso "07"
         numdias<-31
      caso "08"
         numdias<-31
      caso "10"
         numdias<-31
      caso "12"
         numdias<-31
      outrocaso
         numdias<-30
      fimescolha
      se (mat[LIN,COL]<=numdias) e (mat[LIN,COL]<>0) entao
         escreva(mat[LIN,COL]:2,"|")
      senao
         escreva("   ")
      fimse
   fimpara
   escreval
fimpara
fimalgoritmo
