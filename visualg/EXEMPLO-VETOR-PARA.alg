algoritmo "EXEMPLO-VETOR-PARA"

var
 MULTIPLO,CONTADOR,GERADOR:inteiro
 LIN,COL:INTEIRO
 MAT: VETOR [1..100,1..100] DE INTEIRO
 VET: VETOR [1..100] DE INTEIRO
 MAXCOL,MAXLIN:INTEIRO
inicio

GERADOR<-1

escreva("INFORME O NÚMERO DE LINHAS.....: ")
leia(MAXLIN)
escreva("INFORME O NÚMERO DE COLUNAS....: ")
leia(MAXCOL)
escreva("INFORME O NÚMERO CONTADOR......: ")
leia(CONTADOR)
escreva("INFORME O MULTIPLO.............: ")
leia(MULTIPLO)

 se(MAXLIN>100) OU (MAXCOL>100) ENTAO
    escreva("o valor maximo lin ou col é 100")
 senao

    //processamento
    para LIN de 1 ate MAXLIN faca
       para COL de 1 ate MAXCOL faca
          MAT[LIN,COL]<-GERADOR
          GERADOR<-GERADOR+CONTADOR
       fimpara
    fimpara
    
    //saída
     para LIN de 1 ate MAXLIN faca
       para COL de 1 ate MAXCOL faca
         ESCREVA(MAT[LIN,COL]:5)
       fimpara
       escreval
    fimpara
    
 fimse

 escreval
 escreval("MULTIPLOS DE ", numpcarac(MULTIPLO))
 para LIN de 1 ate MAXLIN faca
     para COL de 1 ate MAXCOL faca
        se (MAT[LIN,COL] mod MULTIPLO=0) entao
            escreva(MAT[LIN,COL]:5)
        fimse
     fimpara
     escreval
 fimpara

fimalgoritmo


