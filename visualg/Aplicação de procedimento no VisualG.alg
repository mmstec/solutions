algoritmo " Aplicação de procedimento no VisualG "
// Função : fazer o calculo de dois numeros em todas as operações
// Autor : marcos cordeiro
// Data : 03/04/2011
// Seção de Declarações
var
a,b: real

procedimento soma(a,b: real)
var
res: real
inicio
res<- a + b;
escreval ("Resultado da soma:",res)
fimprocedimento

procedimento sub(a,b: real)
var
res: real
inicio
res<- a - b;
escreval ("Resultado da subtração:",res)
fimprocedimento

procedimento mult(a,b: real)
var
res:real
inicio
res<- a * b;
escreval ("Resultado da multiplicação: ",res)
fimprocedimento

procedimento divi(a,b: real)
var
res: real
inicio
res<- a / b;
escreval ("Resultado da divisão: ",res)
fimprocedimento

procedimento resto(a,b:inteiro)
var
res : real
inicio
res<- a % b
escreval ("Resultado do resto da divisao:",res)
fimprocedimento

// inicio do programa
inicio
// Seção de Comandos
escreva ("Valor 1: ")
leia(a)
limpatela
escreva ("Valor 2: ")
leia(b)
limpatela;
soma(a,b);
sub(a,b);
mult(a,b);
divi(a,b);
resto(a,b);
fimalgoritmo

