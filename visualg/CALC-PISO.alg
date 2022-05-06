algoritmo "CALC-PISO"

var
//variaveis dos comodos
AREAPISO,C1,C2,C3,C4,C5,C6,C7: real
c1a,c1b:real
c2a,c2b:real
c3a,c3b:real
c4a,c4b:real
c5a,c5b:real
c6a,c6b:real
c7a,c7b:real
//variaveis das pedras
p1,p2,p3,p4,p5: real
p1a,p1b,p2a,p2b,p3a,p3b,p4a,p4b,p5a,p5b:real

//variaveis revestimento
altura_revestimento,perimetro_cozinha,cozL1,cozL2,cozC1,cozC2,cozA:real
perimetro_servico,serL1,serL2,serC1,serC2,serA:real
perimetro_banheiro,banL1,banL2,banC1,banC2,banA:real


AREAPISOPISO,AREAPISOSOLEIRA,AREAPIREVESTIMENTO,TOTAL:REAL

inicio

// comodos
escreval("Informe os lados do C1:")
leia(c1a,c1b)
escreval("Informe os lados do C2:")
leia(c2a,c2b)
escreval("Informe os lados do C3:")
leia(c3a,c3b)
escreval("Informe os lados do C4:")
leia(c4a,c4b)
escreval("Informe os lados do C5:")
leia(c5a,c5b)
escreval("Informe os lados do C6:")
leia(c6a,c6b)
escreval("Informe os lados do C7:")
leia(c7a,c7b)

//pedras
escreval("sobre as soleiras")
escreval("Informe os lados do P1:")
leia(p1a,p1b)
escreval("Informe os lados do P2:")
leia(p2a,p2b)
escreval("Informe os lados do P3:")
leia(p3a,p3b)
escreval("Informe os lados do P4:")
leia(p4a,p4b)
escreval("Informe os lados do P5:")
leia(p5a,p5b)

//revestimento
escreval("Altura do revestimento")
leia(altura_revestimento)

escreval("sobre a cozinha")
escreval("Informe lado1+lado2+comprimento1+comprimento2:")
leia(cozL1,cozL2,cozC1,cozC2)
escreval("Informe abertura da cozinha")
leia(cozA)
perimetro_cozinha<-((cozL1+cozL2+cozC1+cozC2)-cozA)*altura_revestimento


escreval("sobre a area de servico")
escreval("Informe lado1+lado2+comprimento1+comprimento2:")
leia(serL1,serL2,serL1,serL2)
escreval("Informe abertura da area de servico")
leia(serA)
perimetro_servico<-((serL1+serL2+serC1+serC2)-serA)*altura_revestimento


escreval("sobre banheiro")
escreval("Informe lado1+lado2+comprimento1+comprimento2:")
leia(banL1,banL2,banL1,banL2)
escreval("Informe abertura do banheiro")
leia(banA)
perimetro_banheiro<-((banL1+banL2+banC1+banC2)-banA)*altura_revestimento


C1<-c1a*c1b
C2<-c2a*c2b
C3<-c3a*c3b
C4<-c4a*c4b
C5<-c5a*c5b
C6<-c6a*c6b
C7<-c7a*c7b

P1<-p1a*p1b
P2<-p2a*p2b
P3<-p3a*p3b
P4<-p4a*p4b
P5<-p5a*p5b

AREAPISO<-C1+C2+C3+C4+C5+C6+C7
AREAPISOSOLEIRA<-P1+P2+P3+P4+P5
AREAPIREVESTIMENTO<-perimetro_cozinha+perimetro_servico+perimetro_banheiro
TOTAL<-AREAPISOPISO+AREAPISOSOLEIRA+AREAPIREVESTIMENTO

escreval("AREA PISO........:",AREAPISO:10:2)
escreval("AREA SOLEIRA.....:",AREAPISOSOLEIRA:10:2)
escreval("AREA REVESTIMENTO:",AREAPIREVESTIMENTO:10:2)
escreval("TOTAL............:",TOTAL:10:2)

fimalgoritmo
