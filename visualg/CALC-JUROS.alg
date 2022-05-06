algoritmo "JUROSSIMPLES"

var
 c,i,js,jc:real
 t,mes:INTEIRO
inicio

escreva("Capital  R$:")
leia (c)
escreva("Tempo meses:")
leia (t)
escreva("Juros %    :")
leia (i)

i<-i/100

 escreval
 escreval( "Juros compostos")
 escreval( "M = C * (1 + i) ^ t ")
 escreval

 escreval( "Juros simples ")
 escreval( "M = C * (1 + ( i . t )) ")
 escreval

jc<- c*(1+i)^t
js<- c*(1+(i*t))

Escreval("Montante com juros simples)...:R$", js:10:2)
Escreval("Montante com juros compostos).:R$", jc:10:2)
Escreval("onde:")

para mes de 1 ate t faca
Escreval ("Mês ",mes:2,":", c*(1+i)^mes:10:2," | ",)
fimpara


fimalgoritmo
