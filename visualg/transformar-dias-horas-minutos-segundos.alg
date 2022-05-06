algoritmo "semnome"
// Função :
// Anos             1
// Meses            12
// Semanas          52,18
// Dias             365,25
// Horas            8766
// Minutos          525960
// Segundos         31557600
// Milissegundo     31557600000
// Microsegundos    3,16×1013
// Nanosegundos     3,16×1016
//
//Para operar com intervalos de tempo, lembre que:
//1 ano = 12 meses;
//1 mês = 30 dias;
//1 semana = 7 dias;
//1 dia = 24 horas;
//1 hora = 60 minutos;
//1 min = 60 segundos.
//Logo, a partir de uma regra de três usando uma das igualdades acima pode-se fazer qualquer conversão.
var
    entrada:inteiro
    h,m,s:real
    yyyy,mm,dd:real
inicio

    escreva("Entre com a qtd de anos : ")
    leia(yyyy)

    mm<-yyyy*12
    dd<-mm*30
    h<-(entrada div 3600)
    m<-(entrada mod 3600)/60
    s<-(entrada mod 3600)mod 60
    
    escreval("Anos....................:",yyyy)
    escreval("Meses...................:",mm)
    escreval("Dias....................:",dd)
    escreval("Horas...................:",h)
    escreval("Minutos.................:",m)
    escreval("Segundos................:",s)
fimalgoritmo
