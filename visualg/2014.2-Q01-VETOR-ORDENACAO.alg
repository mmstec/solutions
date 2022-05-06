algoritmo "ORDENACAO"
var
nomes: vetor[0..3] de caractere
ordenado: logico
i: inteiro
inicio
nomes[0]<-"JOAO"
nomes[1]<-"ALBERTO"
nomes[2]<-"BRUNO"
ordenado<-FALSO
i<-0
enquanto (ordenado=FALSO) faca
      ordenado<-VERDADEIRO
      para i de 0 ate 1 faca
           i<-i+1
           se(nomes[i]<nomes[i+1]) entao
              nomes[i]<-nomes[i+1]
              nomes[i+1]<-nomes[i]
              ordenado<-FALSO
           fimse
      fimpara
fimenquanto
escreval(nomes[0]+","+nomes[1]+","+nomes[2])
fimalgoritmo
