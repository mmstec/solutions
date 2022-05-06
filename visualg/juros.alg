algoritmo "jurossimples"

var
tipojuros,opcao:inteiro
j,m,c,i,n,R:real
inicio
escreval("QUADRO DE OPÇÕES")
escreval("[1] (j=c.i.n) Juros no periodo")
escreval("[2] (m=c+j)   Montante")
escreval("[3] (c=j/i.n) Capital")
escreval("[4] (i=j/c.n) Taxa ao mês")
escreval("[5] (n=j/c.i) Tempo em meses")
escreval("Escolha sua opção para calcular:")
leia(opcao)

        escolha(opcao)
        caso 1
                escreval("Sabendo-se o juro,o capital e a taxa,podemos encontrar o juros:")
                escreval("Capital, Taxa e tempo em meses:")
                leia(c,i,n)
                j<-c*(i/100)*n
                escreval("Juros:",j:10:2,"%")
        caso 2
                escreval("Sabendo-se o capital e o juros podemos encontrar o montante:")
                escreval("Capital e juros:")
                leia(c,j)
                m<-(c+j)
                escreval("Montante é:",m:10:2)
        caso 3
                escreval("Sabendo-se o juro,a taxa e o tempo,podemos encontrar o capital:")
                escreval("Juro,a taxa e o tempo em meses:")
                leia(j,i,n)
                c<-j/((i/100)*n)
                escreval("Capital é:",c:10:2)
        caso 4
                escreval("Sabendo-se o juro,o capital e o tempo,podemos encontrar a taxa:")
                escreval("Juro, Capital e o tempo em meses:")
                leia(j,c,n)
                i<-(j/c*n)*100
                escreval("Taxa%  é:",i:10:2,"%")
        caso 5
                escreval("Sabendo-se o juro,o capital e a taxa,podemos encontrar o tempo:")
                escreval("Juro, Capital e a taxa no mês:")
                leia(j,c,i)
                n<-j/c*i
                escreval("Tempo e meses :",n)

        outrocaso
                limpatela
                escreval("opção invalida")
        fimescolha
        


fimalgoritmo
