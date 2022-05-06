algoritmo "Q.02"
var
vet: vetor[0..5] de inteiro
i,x,y,conteudo: inteiro
inicio
para i de 1 ate 5 faca
  leia(vet[i])
  i<-i+1
fimpara
para x de 2 ate 5 faca
   conteudo<-vet[x]
   y<-x-1
   enquanto (y>0) e (vet[y]>conteudo) faca
           vet[y+1]<-vet[y]
            y<-y-1
   fimenquanto
   vet[y+1]<-conteudo
fimpara
fimalgoritmo
