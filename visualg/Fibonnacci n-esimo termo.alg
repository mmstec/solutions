algoritmo "NÚMERO DE FIBONACCI"
// Função : CALCULAR SEQUÊNCIA DE NÚMEROS
// Autor : JOÃO CÂNCIO E MAURILIO SENA
// Data : 18/11/2013
// Seção de Declarações
var

A1, A2, F, T, N, Q:INTEIRO

INICIO
// Seção de Comandos

ESCREVAL("------------ NÚMERO DE FIBONACCI -------------")
ESCREVAL("")
ESCREVA("INFORME O TERMO: ")
LEIA(Q)
ESCREVAL("")
F<-0
A1<-1
A2<-1


PARA N DE 0 ATE Q FACA
     SE N<2 ENTAO
     F<-A1
     SENAO
     F<-F+A1
     A1<-A2
     A2<-F
     FIMSE
     ESCREVAL(N:2," TERMO :",F:2)
FIMPARA

ESCREVAL("")
ESCREVAL("SEQUÊNCIA ATÉ O ", Q,"º TERMO")

FIMALGORITMO
