algoritmo "Q4"
//As torneiras A e B enchem o tanque respectivamente 8 e 6 horas e a
//válvula C esvazia em 12 horas.
//Estando o reservatório vazio e abrindo A,B e C simultaneamente,
//em quanto tempo o reservatório estará cheio?

//A) 4h 48 mim   *
//B) 4h 40 mim
//C) 4h 30 mim
//D) 4h 20 mim
//E) 4h 168 mim

var
   T1,T2,T3,T,Z,H,M,S:real
   prod,soma,diff:real
inicio
   escreval("INFORME O TEMPO (em horas):")
   escreva("1a TORNEIRA - ENCHE    :")
   leia(T1)
   escreva("2a TORNEIRA - ENCHE    :")
   leia(T2)
   escreva("RALO - ESVAZIA         :")
   leia(T3)

   T<-int(T1*T2)/int(T1+T2)
   PROD<-int(T1*T2)
   SOMA<-int(T1+T2)

   //MOD Retorna o resto da divisão entre 2 números inteiros.
   //DIV Retorna o valor inteiro que resulta da divisão entre 2 números inteiros.
   M<-INT(PROD) DIV INT(SOMA)
   S<-(T-M)*60

   escreval
   escreval("RESPOSTA:")
   escreval("TEMPO PARA ENCHER:")
   escreval("SEM CONVERSÃO:")
   escreval("T:",T)
   escreval("CONVERTENDO:")
   escreval("T:",M:2,"h ",S:2,"min ")
   escreval
   escreval

   //FORMULA Fórmula para resolver o problema R.T/T-R onde:
   // R = capacidade de esvaziar o tanque
   // T = capacidade de encher o tanque
   Z<-(T3*T)/(T3-T)
   M<-INT(Z)
   S<-(Z-INT(Z))*60

   escreval("TEMPO PARA ESVAZIAR:")
   escreval("SEM CONVERSÃO:")
   escreval("T:",Z)
   escreval("CONVERTENDO:")
   escreval("T:",M,"h ",S,"min ")
   escreval
   escreval
   
fimalgoritmo
