ALGORITMO "Procedimento"

var
A,B,C,D,CONT,AUX:Inteiro
Procedimento TROCA(var x, y: inteiro)
var
Aux : inteiro
INICIO
Aux <- x
x <- y
y <- Aux
FIMProcedimento

INICIO
LEIA (A,B,C,D)
Enquanto NAO((A<=B) e (B<=C) e (C<=D)) faca
se (D<C) entao
TROCA(D,C)
FIMSE
SE C<B ENTAO
TROCA(C,B)
FIMSE
SE B<A ENTAO
TROCA(A,B)
FIMSE
FIMENQUANTO
ESCREVA (A," ",B," ",C," ",D)
FIMALGORITMO
