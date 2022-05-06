algoritmo "NÚMERO DE FIBONACCI"
// Função : CALCULAR SEQUÊNCIA DE NÚMEROS
// Autor : JOÃO CÂNCIO E MAURILIO SENA
// Data : 18/11/2013
// Seção de Declarações
var
A1, A2, F, T, N, Q:INTEIRO
CUSTO:REAL
INICIO
// Seção de Comandos

ESCREVAL("")
ESCREVAL("QUAL O CUSTO MEDIO DE UM PROJETO: ")
LEIA(CUSTO)
ESCREVA("INFORME O MÊS: ")
LEIA(Q)
ESCREVAL("")
F<-0
A1<-1
A2<-1
ESCREVAL("---+----------+----------+----------")
ESCREVAL("MÊS|   PARES  |    QTD   |   LUCRO  ")
ESCREVAL("---+----------+----------+----------")

PARA N DE 1 ATE Q FACA
     SE N<=2 ENTAO
        F<-A1
     SENAO
        F<-F+A1
        A1<-A2
        A2<-F
     FIMSE
     ESCREVAL(N:3,"|",F:10,"|",(F*2):10,"|",CUSTO*(F*2):10:2)
FIMPARA
ESCREVAL
ESCREVAL("RESP. EM ",Q:2," ME$E$ TEREMO$ ",F*2:2," PROJETO$")
ESCREVAL("      SE CADA PROJETO CUSTAR R$",CUSTO:7:2," TEREMOS R$",CUSTO*(F*2):7:2," BRUTO")

FIMALGORITMO
