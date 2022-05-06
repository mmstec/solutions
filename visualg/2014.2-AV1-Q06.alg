algoritmo "2014.2-AV1-Q05"
var
//Questão 05.
//(10 pontos) Uma loja está vendendo os seus produtos a um prazo x,
//com juros simples de y% e a vista com desconto de z%. Além disso,
//o algoritmo deve ler o nome do cliente e o valor da compra. Ao final,
//o algoritmo deve calcular o valor à vista e a prazo exibindo todas as informações lidas na tela
PROJETO:caractere
TP:real
VO:real
AD:real
VF:real
inicio

  escreva ("PJ = PROJETO.................: ")
  leia(PROJETO)
  escreva ("TP = TEMPO EM MESES..........: ")
  leia(TP)
  escreva ("VO = VALOR ORIGINAL..........: ")
  leia(VO)
  escreva ("AC = ACRESCIMO/DESCONTO......: ")
  leia(AD)

  VF<-VO+((AD*VO)/100)*TP

  escreval
  escreval
  escreval("--------------------+-----+-------+-------+-------+")
  escreval("PROJETO             |   TP|    VO |    AD |    VF |")
  escreval("--------------------+-----+-------+-------+-------+")
  escreval(PROJETO:20,"|",TP:5:0,"|",VO:7:2,"|",AD:7:2,"|",VF:7:2,"|")
  escreval("--------------------+-----+-------+-------+-------+")

fimalgoritmo
