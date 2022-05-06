
// 01. FACA UM ALGORITMO QUE INFORMANDO O DIA, MÊS E ANO DE NASCIMENTO INFORME:
//a)anos vividos
//b)dias vividos
//c)horas vividas
//d)minutos vividos


//











algoritmo "CALCULO_DA_VIDA"
var
anos, meses, dias, idade, d, m,anoatual: inteiro
inicio
// Seção de Comandos
Escreval ("Estamos em que ano?")
Leia (anoatual)
Escreval ("Digite o Dia que você nasceu")
Leia (dias)
Escreval ("Digite o Mês que você nasceu")
Leia (meses)
Escreval ("Digite o Ano que você nasceu")
Leia (anos)
Escreval ("Você nasceu em:", dias:2,"/",meses:2,"/",anos:4)
idade <- anoatual - anos
Escreval ("Já se passaram:", idade)
m <- idade * 12
Escreval ("A quantidade de Mesês são:", m)
d <- dias + (meses * 30) + (idade * 365)
Escreval ("A quantidade de Dias são..:", d)
fimalgoritmo
