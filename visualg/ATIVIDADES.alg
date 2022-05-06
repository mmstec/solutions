
//01. FACA UM ALGORITMO QUE INFORMANDO O DIA, MÊS E ANO DE NASCIMENTO INFORME:
//a)anos vividos
//b)dias vividos
//c)horas vividas
//d)minutos vividos

//02. FAÇA UM ALGORITIMO PARA RECEBER UM NUMERO DE TRES DIGITOS E
// EXIBA O INVERSO

//03. CALCULO DA OSCILAÇÃO DO PREDIO:

//04. CALCULE O VOLUME DE TERRA A SER REMOVIDO DE UM TUNEO DE
//DIAMETRO N E COMPRIMENTO C


//05. CALCULE O VOLUME DE ASFALTO GASTO EM UMA CURVA COM:
//a) largura de M metros
//b) espessura de E "metros"
//c) raio R

//06. No cenário onde um veiculo com X peso, pecorrendo a
//uma velocidade V por uma distância D em uma pista com inclinação
//de Iº. Ao termino da distancia a inclinação passa a ser nula.
//Quantos metros esse veiculo vai percorrer sem tocar na pista?









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
