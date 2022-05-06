Algoritmo "desafio-data"
var
data,dd,mm,yyyy:caractere
dia:caractere
inicio
escreva("Uma data no formato (02/11/2014):")
leia(data)
dd<-Copia(data, 1 , 2)
mm<-Copia(data, 4 , 2)
yyyy<-Copia(data, 7 , 4)

escreval
escreval("Dia.......:",dd)
escreval("Mês.......:",mm)
escreval("Ano.......:",yyyy)
escreval("Data por extenso ",dia," de ")
fimalgoritmo
