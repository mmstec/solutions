algoritmo "nascimento-dias-para-ano"
// Função :
// Autor :
// Data : 16/5/2008
// Seção de Declarações
var
d,anos,meses:inteiro
inicio
// Seção de Comandos
escreval("ENTRE COM O NÚMERO DE DIAS VIVIDOS.")
leia(d)
anos<-d\360
meses<-(d div 360)\30
d<-((d div 360) div 30)
escreval("se passaram ",anos," anos",meses," meses e",d," dias.")
fimalgoritmo
