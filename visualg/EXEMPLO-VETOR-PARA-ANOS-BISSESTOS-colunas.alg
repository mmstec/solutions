algoritmo "EXEMPLO-ANO_BISSEXTO"
var
INTERVALO,GERADOR:inteiro
LIN,COL:INTEIRO
MAT: VETOR [1..100,1..100] DE INTEIRO
ANO_I,ANO_F,MAXCOL,MAXLIN:INTEIRO
funcao verifica_bissexto(ano:inteiro):logico
var
bissexto:logico
inicio
se(ano mod 400=0) ou (ano mod 4=0) e (ano mod 100 <>0) entao
   bissexto<-verdadeiro
senao
   bissexto<-falso
fimse
retorne bissexto
fimfuncao
inicio
LIMPATELA
escreval("INSTITUIÇÃO FACULDADE DE TECNOLOGIA E CIÊNCIAS - JEQUIE")
escreval("CURSO       ENGENHARIA CIVIL")
escreval("DISCIPLINA  ALGORITIMO E PROGRAMAÇÃO")
escreval("PROFESSOR   MARCOS MORAIS DE SOUSA")
ESCREVAL
ESCREVA("ANO INICIAL..:")
LEIA(ANO_I)
ESCREVA("ANO FINAL....:")
LEIA(ANO_F)
GERADOR<-ANO_I
INTERVALO<-ANO_F-ANO_I
ESCREVA("QTD COLUNAS..:")
LEIA(MAXCOL)
MAXLIN<-INT(INTERVALO/MAXCOL)+1
para LIN de 1 ate MAXLIN faca
   para COL de 1 ate MAXCOL faca
      SE(GERADOR<=ANO_F) ENTAO
         MAT[LIN,COL]<-GERADOR
         GERADOR<-GERADOR+1
      FIMSE
   fimpara
fimpara
ESCREVAL
ESCREVAL("ANOS LISTADOS")
para LIN de 1 ate MAXLIN faca
   para COL de 1 ate MAXCOL faca
      ESCREVA(MAT[LIN,COL]:5)
   fimpara
   escreval
fimpara
ESCREVAL
ESCREVAL("ANOS LISTADOS QUE SÃO BISSEXTOS")
GERADOR<-0
para LIN de 1 ate MAXLIN faca
   para COL de 1 ate MAXCOL faca
      se(verifica_bissexto(MAT[LIN,COL])) entao
         se(MAT[LIN,COL]>0) entao
            ESCREVA(MAT[LIN,COL]:5)
            GERADOR<-GERADOR+1
         fimse
      fimse
   fimpara
fimpara
escreval
escreval
escreval("Ou seja, dos ",intervalo+1:2," anos listados,",GERADOR:2," anos são bissextos.")
escreval("Quantidade de linhas...",INT((ANO_F-ANO_I)/MAXCOL)+1)
fimalgoritmo


//escreval("Resposta da prova: letra e)")

