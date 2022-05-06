algoritmo "questao1"

var
//(c=j/i.n)

r,m,c,j,i,n:real

inicio

escreval("Informe:")
escreval("Capital.......:")
leia(c)
escreval("Taxa %........:")
leia(i)
escreval("Tempo em meses:")
leia(n)

r<-c+(c*(i/100)*n)
escreval("Montante......:",r)

escreval("Informe:")
escreval("Montante......:")
leia(m)
escreval("Taxa %........:")
leia(i)
escreval("Tempo em meses:")
leia(n)

r<-m*100/(100-i)

escreval("Capital.......:",r)


fimalgoritmo
