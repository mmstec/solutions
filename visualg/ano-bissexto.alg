algoritmo "ANO-BISSETO"
//    Leia(ano);
//    Se ano módulo 400 é 0 então bissexto=Verdade;
//    Se ano módulo 4 é 0 E ano módulo 100 é diferente de 0
//    então bissexto=Verdade;
//    Senão bissexto=Falso;
var
ano:inteiro
bissexto:logico
inicio
escreval("Os anos bissextos são:")
escreval("multiplos de 400 ou")
escreval("múltiplos de 4 e não múltiplos de 100")
escreval
escreval("informe o ano (ex.1994)")
leia(ano)
se(ano mod 400=0) ou (ano mod 4=0) e (ano mod 100 <>0) entao
   bissexto<-verdadeiro
senao
   bissexto<-falso
fimse
escreval("Ano ",ano," bissexto é ",bissexto)
fimalgoritmo
