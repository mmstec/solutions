algoritmo "Q2"
//Uma torneira enche um tanque em 12 minutos
//Uma segunda torneira enche o mesmo tanque em 15 minutos.
//Se ligarmos as duas torneiras em quanto tempo o tanque é completamente cheio?
var
T1,T2,T,H,M,S:real
prod,soma,diff:real
inicio
escreval("INFORME O TEMPO (em minutos) PARA ENCHER O TANQUE:")
escreva("1a TORNEIRA  :")
leia(T1)
escreva("2a TORNEIRA  :")
leia(T2)

T<-int(T1*T2)/int(T1+T2)
PROD<-int(T1*T2)
SOMA<-int(T1+T2)

//MOD Retorna o resto da divisão entre 2 números inteiros.
//DIV Retorna o valor inteiro que resulta da divisão entre 2 números inteiros.

M<-int(PROD) DIV int(SOMA)
S<-(T-M)*60

escreval
escreval("SEM CONVERSÃO:")
escreval("T:",T)
escreval
escreval("CONVERTENDO EM TEMPO:")
escreva("T:",H:2,"h ",M:2,"min ",S:2,"seg ")
escreval
escreval
fimalgoritmo
