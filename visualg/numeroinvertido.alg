algoritmo "numero invertido"
var
NumInv, Numero:inteiro
uni,dez,cen:inteiro
inicio
escreval("Escreva um número inteiro de 3 digitos:")
leia(Numero)
cen<- numero div 100
escreval(cen)
dez<-(numero div 10) mod 10
escreval(dez)
uni<- numero mod 10
escreval(uni)
NumInv<-(uni*100)+(dez*10)+(cen)
escreva("Numero invertido:",NumInv)
fimalgoritmo
