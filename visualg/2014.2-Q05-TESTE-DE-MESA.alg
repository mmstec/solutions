algoritmo "TRIANGULO"
var
a,b,c,i:inteiro
mens:caractere
inicio
PARA i DE 1 ATE 5 FACA
   ESCREVAL("a,b,c:")
   LEIA (a,b,c)
   SE(a<b+c) e (b<a+c) e (c<a+b) entao
      SE(A=B) E (B=C) ENTAO
         MENS<-"A) EQUILATERO"
      SENAO
         SE(A=B) OU (B=C) OU (A=C) ENTAO
            MENS<-"B) ISOSCELES"
         SENAO
            MENS<-"C) ESCALENO"
         FIMSE
      FIMSE
   SENAO
      MENS<-"D) Não é possível formar um triangulo"
   FIMSE
   ESCREVAL(MENS)
FIMPARA
fimalgoritmo

//RESPOSTA
//a,b,c: 1 2 3 = Não é possível formar um triangulo
//a,b,c: 3 4 5 = Triangulo Escaleno
//a,b,c: 2 2 4 = Não é possível formar um triangulo
//a,b,c: 4 4 4 = Trianfulo Equilatero
//a,b,c: 5 3 3 = Triangulo Isosceles
