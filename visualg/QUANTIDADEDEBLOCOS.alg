algoritmo "QUANTIDA_DE_BLOCOS"
var
perimetro: real
parede_A: real
parede_B: real
parede_C: real
parede_D: real
parede_altura: real
area_total: real
porta_altura: real
porta_base: real
area_porta: real
qtd_porta: inteiro
janela_base: real
janela_altura: real

area_janela: real
qtd_janela: inteiro
area_aberta: real
area_construida: real


bloco_base: real
bloco_altura : real
bloco_profundidade: real
bloco_area: real
bloco_metro2: real
bloco_construcao:real
bloco_meiosblocos:real
inicio

//entradas
escreva("base da parede A....(em m): ")
leia(parede_A)
escreva("base da parede B....(em m): ")
leia(parede_B)
escreva("base da parede C....(em m): ")
leia(parede_C)
escreva("base da parede D....(em m): ")
leia(parede_D)
escreva("altura das paredes..(em m): ")
leia(parede_altura)

escreva("base das portas..(em m): ")
leia(porta_base)
escreva("altura das portas..(em m): ")
leia(porta_altura)

escreva("base das janelas..(em m): ")
leia(janela_base)
escreva("altura das janelas..(em m): ")
leia(janela_altura)

escreva("qtd portas................: ")
leia(qtd_porta)
escreva("qtd janelas...............: ")
leia(qtd_janela)
//processamento
perimetro<-parede_A+parede_B+parede_C+parede_D
area_total<-perimetro*parede_altura
area_porta<-(porta_base*porta_altura)*qtd_porta
area_janela<-(janela_base*janela_altura)*qtd_janela
area_aberta<-area_porta+area_janela
area_construida<-area_total-area_aberta

escreva("bloco base...........(em m): ")
leia(bloco_base)
escreva("bloco altura.........(em m): ")
leia(bloco_altura)
escreva("bloco profundidade...(em m): ")
leia(bloco_profundidade)

bloco_area<-bloco_base*bloco_altura
bloco_metro2<-1/bloco_area
bloco_construcao<-bloco_metro2*area_construida
bloco_meiosblocos<-construcao*(10/100)

//saida
escreval("bloco por metro²..........: ",bloco_metro2)
escreval("area_construida....(em m²): ",area_construida)
escreval("Total de blocos inteiros (- espaçamento): ",bloco_construcao)
escreval("Total de blocos 1/2      (- espaçamento): ",bloco_meiosblocos)





escreval
escreval
escreval("JÁ PODEMOS FAZER VA1?")

fimalgoritmo
