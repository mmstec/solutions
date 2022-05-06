algoritmo "Q1"
//Uma torneira enche um tanque de 48 litros em 8 horas.
//Uma segunda torneira enche o mesmo tanque em 12 horas.
//Se ligarmos as duas torneiras em quanto tempo o tanque é completamente cheio?
var
tanque:real
T1,T2,T,H,M,S:real
prod,soma,diff:real
inicio
//escreva("capacidade em litros do tanque...")
//leia(tanque)
escreva("Tempo para encher com a 1a torneira..")
leia(t1)
escreva("Tempo para encher com a 2a torneira..")
leia(t2)

T<-int(T1*T2)/int(T1+T2)
PROD<-int(T1*T2)
SOMA<-int(T1+T2)
H<-int(PROD) DIV int(SOMA)
M<-(T-H)*60


//MOD Retorna o resto da divisão entre 2 números inteiros.
//DIV Retorna o valor inteiro que resulta da divisão entre 2 números inteiros.


escreval
escreval("SEM CONVERSÃO:")
escreval("T:",T)
escreval
escreval("CONVERTENDO EM TEMPO:")
escreva("T:",H:2,"h ",M:2,"min ",S:2,"seg ")
escreval
escreval

fimalgoritmo
