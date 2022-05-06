CLEAR
set VIDEOMODE TO 18
setcolor('1/3')
set color to W+/N,W+/B
set date format to "dd,mm,yy"
set date brit
set cursor off
arq1 :="COBREM"     // origem  de dados
arq2 :="COBQTD"     // destino de dados
M->contaREG:=1
******
IF !FILE(ARQ1+".DBF") .OR. !FILE(ARQ2+".DBF")
   ALERT("OPERA€AO INTERCEPTADA;;Um dos arquivos necess rios; para a 'Opera‡Æo de Transferˆncia' nÆo foi localizado",,"w+/n")
   QUIT
ENDIF
******
sele 1
use (arq1)
index on DTOS(REMDTGRAV) TO iDT1.NTX
******
sele 2
use (arq2) ; zap
sele 1
******
gBmpDisp(gBmpLoad("MMSTEC.BMP"),30,35)
cls
Janela(100,100,540,380,"T1TRA - UTILITARIO TRANSFERIDOR DE DADOS")
gBmpDisp(gBmpLoad("T1Red.BMP"),450,160)
gBmpDisp(gBmpLoad("T1R.BMP"),50,160)
go top
do while (arq1)->(!eof())
         @ 11,14 say chr(254) color 'r+/w'          
         @ 15,14 say chr(254) color 'n+/w'
         @ 08,16 say "Tranferˆncia de Registros entre "+arq1+" e "+arq2       color 'b/w'
         @ 11,16 say "Origem         :" + padl(DBF()    ,10)                  color 'w+  /w'
         @ 12,16 say "Registro Total :" +Str(LastRec()  ,10)                  color 'bg+  /w'
         @ 13,16 say "Registro Atual :" +Str(M->contaREG,10)                  color 'bg+  /w'
         @ 19,16 say "Andamento Total: "+str(M->contaREG*100/LastRec(),4)+"%" color 'r+  /w'

         v0    :=(arq1)->REMDTGRAV
         v1    :=(arq1)->REMHORA
         v3    :=(arq1)->REMNUMREM
         v4    :=(arq1)->REMNUMSEQ
       sele 2
         append blank
         (arq2)->REMDTGRAV   :=v0
         (arq2)->REMHORA     :=v1
         (arq2)->REMNUMREM   :=v3
         (arq2)->REMNUMSEQ   :=v4
         (arq2)->REMNUMQTD   :=v4-2
         @ 11,14 say chr(254) color 'n+/w'
         @ 15,14 say chr(254) color 'g+/w'
         @ 15,16 say "Destino        :" +padL(DBF()   ,10)      color 'w+  /w'
         @ 16,16 say "Registro Total :" +Str(LastRec(),10)      color 'bg+ /w'
         @ 17,16 say "Registro Atual :" +Str(Recno()  ,10)      color 'bg+  /w'
       sele 1                           
         M->contaREG++
         skip
@ 21,16 say "Aguarde...                    " color "b/w"
enddo
close databases
@ 21,16 say "P/ continuar aperte uma tecla." color "b+/w"
gBmpDisp(gBmpLoad("T1Gre.BMP"),450,160)
gBmpDisp(gBmpLoad("T1G.BMP"),50,160)
Tone(500)
set cursor on
QUIT

function janela(x,y,x2,y2,titulo)
gFrame(x     ,   y,  x2, 25+y, 07, 15, 08, 03, 03, 25, 03,-1)  
gFrame(x     ,25+y,  x2,   y2, 07, 15, 08, 25, 03, 03, 03,-1)  
gFrame(X     ,  Y2,  X2,Y2+30, 07, 15, 08, 03, 03, 03, 03,-1)  
gwriteat(x+26,  y+7,titulo ,15)
gwriteat(X+10, Y2+7,AUTOR(),15)
gwriteat(X+05,457+7,DATA() ,10)
return
