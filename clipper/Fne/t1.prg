clear
set color to W+/N,W+/B
set date format to "dd,mm,yy"
set date brit
arq1 :="Fone"     // origem  de dados
arq2 :="DbFone"   // destino de dados
M->contaREG:=1
******
IF !FILE(ARQ1+".DBF") .OR. !FILE(ARQ1+".DBT") .OR. !FILE(ARQ2+".DBF")
   ALERT("OPERA€ÇO INTERCEPTADA;;Um dos arquivos necess rios; para a 'Opera‡Æo de Transferˆncia' nÆo foi localizado",,"w+/n")
   QUIT
ENDIF
******
sele 1
use (arq1)
index on nome+ddd+fone TO iDT1.NTX
******
sele 2
use (arq2) ; zap
sele 1
******
go top
do while (arq1)->(!eof())
         @ 07,18 say ""                                     color 'bg+*/n'
         @ 11,18 say ""                                     color 'n+ /n'
         @ 05, 20 say "Tranferˆncia de Registros entre "+arq1+" e "+arq2  color 'bg+/n'
         @ 07, 20 say "Origem         :" + padl(DBF()    ,10) color 'w  /n'
         @ 08, 20 say "Registro Total :" +Str(LastRec()  ,10) color 'w  /n'
         @ 09, 20 say "Registro Atual :" +Str(M->contaREG,10) color 'w  /n'
         @ 15, 20 say "Andamento Total: "+str(M->contaREG*100/LastRec(),4)+"%" color 'bg/n'

         v0    :=(arq1)->codigo
         v1    :=(arq1)->nome
         v3    :=(arq1)->ddd                                 
         v4    :=(arq1)->fone                                
         v5    :=ALLTRIM(memoline((arq1)->obs,30,1))
         v6    :=ALLTRIM(memoline((arq1)->obs,30,2))
         v7    :=ALLTRIM(memoline((arq1)->obs,30,3))
         sele 2
         append blank
         (arq2)->CODIGO   :=v0
         (arq2)->NOME     :=v1
         (arq2)->DDD      :=v3
         (arq2)->FONE     :=v4
         (arq2)->OBS      :=v5+CHR(13)+CHR(10)
         (arq2)->OBS      :=v6+CHR(13)+CHR(10)
         (arq2)->OBS      :=v7+"."
         @ 07,18 say ""                                     color 'n +/n'
         @ 11,18 say ""                                     color 'bg+*/n'
         @ 11, 20 say "Destino        :" +padL(DBF()   ,10)
         @ 12, 20 say "Registro Total :" +Str(LastRec(),10)
         @ 13, 20 say "Registro Atual :" +Str(Recno()  ,10)
         sele 1                           
         M->contaREG++
         skip
enddo
close databases
@ 20,00 say ""
QUIT
