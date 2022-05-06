algoritmo " Aplicação de funções no visual G"
// Função :Função todas as operações
// Autor : Marcos Cordeiro
// Data : 03/04/2011
// Seção de Declarações

var
//variaveis globais
 a,b: real

// função para soma
funcao soma(a,b:real):real
var
res:real
inicio
res<- a + b;
retorne res;
fimfuncao

// função para subtração
funcao sub(a,b:real): real
var
res: real
inicio
res<- a - b;
retorne res;
fimfuncao

// função para divisão
funcao divi(a,b:real): real
var
res:real
inicio
res<- a / b;
retorne res;
fimfuncao

// função para o resto da divisão
funcao resto(a,b:inteiro): inteiro
var
res:inteiro
inicio
res<- a % b;
retorne res;
fimfuncao

//inicio do programa
inicio
escreva ("Valor 1: ")
leia(a)
escreva ("Valor 2: ")
leia(b)
escreval
escreval ("Resultado da soma............: ",soma(a,b))
escreval ("Resultado da subtração.......: ",sub(a,b))
escreval ("Resultado da Multiplicação...: ",mult(a,b))
escreval ("Resultado da Divisão.........: ",divi(a,b))
escreval ("Resto da divisão.............: ",resto(a,b))

fimalgoritmo

