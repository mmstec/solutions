//Questão: Com base no texto abaixo, reescreva o algoritimo
//para calcular os multiplos de x de n a m.

ALGORITMO "Funções Personalizadas"
var
A,B, soma: real
I:INTEIRO
FUNCAO FSoma(digita_A, digita_B: Real):Real
var
total : real
Inicio
total<-digita_A+digita_B
retorne total
fimfuncao
INICIO
para i de 1 ate 10 faca
   A<-A+i
   B<-A
   ESCREVAL ("Soma das vaiáveis é ", FSoma(A,B))
fimpara
FIMALGORITMO
