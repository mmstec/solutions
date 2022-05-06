algoritmo "2014.2-AV1-Q05"
var
//Questão 05.
//(10 pontos) Uma loja está vendendo os seus produtos a um prazo x,
//com juros simples de y% e a vista com desconto de z%. Além disso,
//o algoritmo deve ler o nome do cliente e o valor da compra. Ao final,
//o algoritmo deve calcular o valor à vista e a prazo exibindo todas as informações lidas na tela

produto:caractere
prazo:real
jurosimples:real
desconto:real
nomecliente:caractere
valorcompra:real
valoravista:real
valoraprazo:real

inicio

  escreval("Escreva as informações abaixo:")
  escreva("Produto..................:")
  leia(produto)
  escreva("Prazo em meses...........:")
  leia(prazo)
  escreva("Juros Simples............:")
  leia(jurosimples)
  escreva("Desconto.................:")
  leia(desconto)
  escreva("Valor compra.............:")
  leia(valorcompra)

  valoraprazo<-valorcompra+((jurosimples*valorcompra)/100)*prazo
  valoravista<-valorcompra-(valorcompra*(desconto/100))

  escreval
  escreval
  escreval("Resposta :")
  escreval("Produto..................:",produto)
  escreval("Prazo em meses...........:",prazo)
  escreval("Juros Simples............:",jurosimples:10:2,"%")
  escreval("Desconto.................:",desconto:10:2,"%")
  escreval("Valor compra.............:",valorcompra:10:2)
  escreval("valor Avista.............:",valoravista:10:2)
  escreval("Valor Aprazo.............:",valoraprazo:10:2)

fimalgoritmo
