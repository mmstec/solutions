algoritmo "Idade"
var
   i, dia_ini, mes_ini, ano_ini, dia_fim, mes_fim, ano_fim, ddia, dmes, dano: inteiro
   qtd_dias: vetor[1..12] de inteiro
   DATA_I,DATA_F:CARACTERE
inicio
   para i de 1 ate 12 faca
      se (i = 2) entao
         qtd_dias[i] <- 28
      senao
         se ((i = 4) ou (i = 6) ou (i =9) ou (i = 11)) entao
            qtd_dias[i] <- 30
         senao
            qtd_dias[i] <- 31
         fimse
      fimse
   fimpara
   escreva ("Informe o dia, mês e ano do nascimento: (15/10/2015)")
   LEIA(DATA_I)
   dia_ini<-caracpnum(COPIA(DATA_I,1,2))
   mes_ini<-caracpnum(COPIA(DATA_I,4,2))
   ano_ini<-caracpnum(COPIA(DATA_I,7,4))
   escreva ("Informe o dia, mês e ano atuais: (02/10/2016)")
   LEIA(DATA_F)
   dia_fim<-caracpnum(COPIA(DATA_I,1,2))
   mes_fim<-caracpnum(COPIA(DATA_I,4,2))
   ano_fim<-caracpnum(COPIA(DATA_I,7,4))

   dano<-int(ano_fim)-int(ano_ini)
   dmes<-mes_fim-mes_ini
   escreval(dano)
   
   se (dmes < 0) entao
      dano <- dano - 1
      dmes <- dmes + 12
   fimse
   ddia <- dia_fim - dia_ini
   se (ddia < 0) entao
      dmes <- dmes - 1
      se (dmes < 0) entao
         dano <- dano - 1
         dmes <- dmes + 12
      fimse
      ddia <- ddia + qtd_dias[dmes]
   fimse
   escreval(dano, " anos, ", dmes, " mes(es) ", ddia, " dia(s)")
fimalgoritmo
