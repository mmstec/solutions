 M->AUTOR:= "(C) Marcos Morais de Sousa - 1995/"+TRAN(YEAR(DATE()),"@E 9999")
 CLS
 *SET VIDEOMODE TO 18
 SET DATE BRIT                    
 SETCANCEL(.T.)                  // (.F.) desativa ALT-C/BREAK
 SET EPOCH TO 1930               // prepara datas para o terceiro milànio
 SET DATE FORMAT TO "dd,mm,yyyy" // formato de datas tipo 10/07/1974
 SET DATE BRIT                    
 SET CURSOR OFF                      
 CLS
****
arq1 :="COBREM"     // origem  de dados
arq2 :="COBQTD"     // destino de dados
atualiza:=0
salta=0
M->contaREG:=1
******
IF !FILE(ARQ1+".DBF") .OR. !FILE(ARQ2+".DBF")
   ALERT("OPERAÄAO INTERCEPTADA;;Um dos arquivos necess†rios; para a 'Operaá∆o de Transferància' n∆o foi localizado",,"w+/n")
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
index on REMDT TO iDT2.NTX
sele 1
******
cls
JANELA(03,10,19,60,"T1TRA")
go top
do while (arq1)->(!eof())
         @ 07,14 say chr(254) color 'r+/w'          
         @ 11,14 say chr(254) color 'n+/w'
         @ 03,16 say "(C) Marcos Morais de Sousa - 1995/"+TRAN(YEAR(DATE()),"@E 9999")  color 'bg+/b'
         @ 05,16 say "ATUALIZADOR DE DADOS (&ARQ2)"  color 'b/w'
         @ 07,16 say "Origem         :" + padl(DBF()    ,10)                  color 'w+  /w'
         @ 08,16 say "Registro Total :" +Str(LastRec()  ,10)                  color 'bg+  /w'
         @ 09,16 say "Registro Atual :" +Str(M->contaREG,10)                  color 'bg+  /w'
         @ 15,16 say "Andamento Total: "+str(M->contaREG*100/LastRec(),4)+"%" color 'r+  /w'
         v0    :=(arq1)->REMDTGRAV  // NUMERICO
         v1    :=(arq1)->REMHORA    // CARACTERE
         v3    :=(arq1)->REMNUMREM  // NUMERICO
         v4    :=(arq1)->REMNUMSEQ  // NUMERICO
       sele 2
       do while .T.
          seek v0
          if !found()
             atualiza++                           
             TOM=300               
             append blank               
             (arq2)->REMDTGRAV   :=NTOD(V0)
             (arq2)->REMDT       :=V0         
             (arq2)->REMHORA     :=v1
             (arq2)->REMNUMREM   :=v3
             (arq2)->REMNUMSEQ   :=v4
             (arq2)->REMNUMQTD   :=v4-2
           else
            TOM=700
            salta++
          endif                                     
          EXIT
       enddo
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
@ 16,16 say "˛ Registros Duplicados.:"+alltrim(str(salta))    color "b/w"
@ 17,16 say "˛ Registros Incluidos..:"+alltrim(str(atualiza)) color "b/w"
@ 23,00 say " "
Tone(TOM)
set cursor on
QUIT

function janela(x1,y1,x2,y2,titulo)
@ x1,y1,x2,y2 box("€€€€€€€€€")      color "w /w"
@ x1,y1 to x2,y2                    color "b /w"
@ x1,y1 say padl(titulo ,y2-y1+1)   color "w+/b"
return



             FUNCTION NTOD(PAR)
             IF PAR=NIL
                PAR=VAL(DTOS(DATE()))
             ENDIF
             DD:=SUBSTR(STR(PAR),7,2)
             MM:=SUBSTR(STR(PAR),5,2)
             AA:=SUBSTR(STR(PAR),3,2)    
             CONVERSAO:=ctod(dd+"/"+mm+"/"+aa)
             RETURN CONVERSAO

