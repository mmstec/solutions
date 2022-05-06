algoritmo "Q1"
var
tanque:real
T1,T2,T,H,M,S:real
prod,soma,diff:real
inicio
escreva("Tempo para encher com a 1a OPCAO..")
leia(t1)
escreva("Tempo para encher com a 2a OPCAO..")
leia(t2)
T<-int(T1*T2)/int(T1+T2)
PROD<-int(T1*T2)
SOMA<-int(T1+T2)
M<-int(PROD) DIV int(SOMA)
S<-(T-M)*60
escreval
escreval("SEM CONVERSÃO:")
escreval("T:",T)
escreval
escreval("CONVERTENDO EM TEMPO:")
escreva("T:",H:2,"D ",M:2,"H ",S:2,"MIN ")
fimalgoritmo
