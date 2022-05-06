CLEAR
set color to W+/N,W+/B
set date format to "dd,mm,yy"
set date brit
set cursor off
arq1 :="COBqtd"     // origem  de dados
arq2 :="COBQTD"     // destino de dados
atualiza:=0
salta=0
M->contaREG:=1
******
IF !FILE(ARQ1+".DBF") .OR. !FILE(ARQ2+".DBF")
   ALERT("OPERA€AO INTERCEPTADA;;Um dos arquivos necess rios; para a 'Opera‡Æo de Transferˆncia' nÆo foi localizado",,"w+/n")
   QUIT
ENDIF
******
sele 1
use (arq1)
index on REMDTGRAV TO iDT1.NTX
if (arq1)->(eof())
   ?"***"
   ?"Nenhum registro a ser trasferido ou atualizado"
   quit
endif
******
sele 2
use (arq2)
sele 1
******
cls
JANELA(04,10,19,60,"T1TRA")
go top
do while (arq1)->(!eof())
         @ 07,14 say chr(254) color 'r+/w'          
         @ 11,14 say chr(254) color 'n+/w'
         @ 05,16 say "Tranferˆncia de Registros"                              color 'b/w'
         @ 07,16 say "Origem         :" + padl(DBF()    ,10)                  color 'w+  /w'
         @ 08,16 say "Registro Total :" +Str(LastRec()  ,10)                  color 'bg+  /w'
         @ 09,16 say "Registro Atual :" +Str(M->contaREG,10)                  color 'bg+  /w'
         @ 15,16 say "Andamento Total: "+str(M->contaREG*100/LastRec(),4)+"%" color 'r+  /w'

         NEW :=(arq2)->REMDTGRAV  
         *v0 :=(arq1)->REMDTGRAV  // NUMERICO
         *v1 :=(arq1)->REMHORA    // CARACTERE
         *v3 :=(arq1)->REMNUMREM  // NUMERICO
         *v4 :=(arq1)->REMNUMSEQ  // NUMERICO
       sele 2
         
         (arq2)->REMDTprov    :=val(dtoc(NEW))
         *append blank
         *(arq2)->REMDTGRAV   :=ctoD(STR(v0))
         *(arq2)->REMHORA     :=v1
         *(arq2)->REMNUMREM   :=v3
         *(arq2)->REMNUMSEQ   :=v4
         *(arq2)->REMNUMQTD   :=v4-2
         @ 07,14 say chr(254) color 'n+/w'
         @ 11,14 say chr(254) color 'g+/w'
         @ 11,16 say "Destino        :" +padL(DBF()   ,10)      color 'w+  /w'
         @ 12,16 say "Registro Total :" +Str(LastRec(),10)      color 'bg+ /w'
         @ 13,16 say "Registro Atual :" +Str(Recno()  ,10)      color 'bg+  /w'
       sele 1                           
         M->contaREG++
         skip          
         @ 17,16 say "Aguarde...                    " color "b/w"
enddo
close databases
@ 16,16 say ">>> Skip........:"+alltrim(str(salta))+"<<<" color "bg+/w"
@ 17,16 say ">>> Append Blank:"+alltrim(str(atualiza))+"<<<" color "bg+/w"
@ 23,00 say ""
Tone(500)
set cursor on
QUIT

function janela(x1,y1,x2,y2,titulo)
@ x1,y1,x2,y2 box("ÛÛÛÛÛÛÛÛÛ")      color "w /w"
@ x1,y1 to x2,y2                    color "b /w"
@ x1,y1 say padl(titulo ,y2-y1+1)   color "w+/b"
return
