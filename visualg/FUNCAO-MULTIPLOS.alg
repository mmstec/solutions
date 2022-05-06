//Questão: Com base no texto abaixo, reescreva o algoritmo
//para calcular os multiplos de x, de n a m.
//Exemplo: multiplos de 2 entre 1 e 10
ALGORITMO "Funções Personalizadas"
var
y,x,n,m,i:INTEIRO

FUNCAO fMultiplos(dx,dn,dm,:inteiro):caractere
var
i: inteiro
multiplos:caractere
Inicio

para i de dn ate dm faca
   se(i mod dx=0) entao
   multiplos<-multiplos+" "+Numpcarac(i)
   fimse
fimpara
retorne multiplos
fimfuncao

INICIO
   escreva("ESCREVA o multiplo (X).: ")
   leia(x)
   escreva("ESCREVA o núm.inicial..: ")
   leia(n)
   escreva("ESCREVA o núm.final....: ")
   leia(m)
   ESCREVAL ("O multiplos de x entre n e m:",fMultiplos(x,n,m))
FIMALGORITMO
