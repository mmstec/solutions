algoritmo "data por extenso"
// Função :
// Autor :
// Data : 01/06/2015
// Seção de Declarações
var
data,dia,mes,ano:caractere
inicio
escreva("Uma data no formato (02/11/2014):")
leia(data)

dia<-Copia(data, 1 , 2)
mes<-Copia(data, 4 , 2)
ano<-Copia(data, 7 , 4)

escreval
Escolha (mes)
caso "01"
   escreva ("Dia ", dia," de Janeiro de ", ano)
caso "02"
   escreva ("Dia ", dia," de Fevereiro de ", ano)
caso "03"
   escreva ("Dia ", dia," de Março de ", ano)
caso "04"
   escreva ("Dia ", dia," de Abril de ", ano)
caso "05"
   escreva ("Dia ", dia," de Maio de ", ano)
caso "06"
   escreva ("Dia ", dia," de Junho de ", ano)
caso "07"
   escreva ("Dia ", dia," de Julho de ", ano)
caso "08"
   escreva ("Dia ", dia," de Agosto de ", ano)
caso "09"
   escreva ("Dia ", dia," de Setembro de ", ano)
caso "10"
   escreva ("Dia ", dia," de Outubro de ", ano)
caso "11"
   escreva ("Dia ", dia," de Novembro de ", ano)
caso "12"
   escreva ("Dia ", dia," de Dezembro de ", ano)
Fimescolha

fimalgoritmo
