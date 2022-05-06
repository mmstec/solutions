algoritmo "CALCULADORACOMESCOLHA"

var
OP: inteiro
V1,V2,R: real

FUNCAO FSOMA(A, B: Real):Real
   var  aux : real
Inicio
   aux<-A+B
   retorne aux
fimfuncao

FUNCAO FSUBTRACAO(A, B: Real):Real
   var  aux : real
Inicio
   aux<-A-B
   retorne aux
fimfuncao

FUNCAO FMUTIPLICAO(r_v1, r_v2: Real):Real
   var  aux : real
Inicio
   aux<-R_V1*R_V2
   retorne aux
fimfuncao

FUNCAO FDIVISAO(r_v1, r_v2: Real):Real
   var  aux : real
Inicio
   aux<-R_V1/R_V2
   retorne aux
fimfuncao

Procedimento MUDA(var x, y: real)
var
Aux : real
INICIO
Aux <- x
x <- y
y <- Aux
FIMProcedimento

inicio

escrevaL("OPÇÃO 1-SOMA, 2-SUBTRACAO, 3-MULTIPLICAÇÃO, 4-DIVISÃO, ")
escrevaL("OPÇÃO 5-POTENCIACAO, 6-MUDA VALOR, 7-SAIR:")
leia(OP)



se(op<7) entao
   escreval("VALOR 1:")
   leia(v1)
   escreval("VALOR 2:")
   leia(v2)
   
   escolha(OP)
      CASO 1
           R<-FSOMA(v1,v2)
      CASO 2
           R<-FSUBTRACAO(V1,V2)
      CASO 3
           R<-FMUTIPLICAO(V1,V2)
      CASO 4
           R<-FDIVISAO(V1,V2)
      CASO 5
           R<-EXP(V1,V2)
   fimescolha


   se(op=6) entao
      escreval("valor sem mudar de lugar:",v1,v2)
      MUDA(v1,v2)
      escreval("mudando valor de lugar:",v1,v2)
      senao
      escreval("RESULTADO:",R)
   fimse
senao
escreval("você escolheu uma opcao invalida")
fimse

fimalgoritmo
