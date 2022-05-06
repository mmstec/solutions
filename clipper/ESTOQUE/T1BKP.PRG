 *
 *******************************************************************************
 *                           (C) MMStec inform tica LTDA
 *******************************************************************************
 * Programa......: REGISTRO DE ENTRADA DE CIMENTO
 * Descri‡Æo.....: Programa contagem de duplicatas emitidas
 * Autor.........: Marcos Morais de Sousa
 * Data..........: 05/04/1999 
 * COMPILADOR EM.: CA-CLIPPER (5.2)
 * LINKADO COM...: RTLINK
 * BIBLIOTECA....: MMSTEC.LIB (P/Clipper v5.0 a 5.2)
 *
 * NOTA: 
 * MMStec ‚ uma biblioteca de fun‡äes desenvolvida por Marcos Morais de Sousa
 ******************************************************************************
 *
 M->AUTOR:= "(C) Marcos Morais de Sousa - 1995/"+TRAN(YEAR(DATE()),"@E 9999")
 CLS
 SET VIDEOMODE TO 18
 SETCANCEL(.F.)                  // (.F.) desativa ALT-C/BREAK
 SET EPOCH TO 1960               // prepara datas para o terceiro milˆnio
 SET DATE FORMAT TO "dd,mm,yyyy" // formato de datas tipo 10/07/1974
 SET DATE BRIT                    
 SET CURSOR OFF                      
 cls  
 gFrame(000,000, 639, 079, 7, 15, 8, 3, 3, 3, 4,-1)  
 gFrame(000,000, 639, 039, 7, 15, 8, 3, 3, 3, 4,-1)  
 *gFrame(000,110, 049, 137, 7, 15, 8, 3, 3, 3, 4,-1)  
 *gFrame(000,000, 639, 456, 7, 15, 8, 3, 3, 3, 4,-1)  
 gFrame(000,400, 639, 456, 7, 15, 8, 3, 3, 3, 4,-1)  
 gFrame(000,457, 639, 479, 7, 15, 8, 3, 3, 3, 4,-1)  

@ 01,01 SAY PADC(PROCNAME()+" - REGISTRO DE ENTRADA DE CIMENTO",78)      color "B/W"
@ 03,01 SAY padc(data(),78) color "bg+/W"
@ 06,01 SAY padc("REGISTRO RESUMIDO DE ENTRADA DE CIMENTO",78) color "bg+/N"
USE DBEST
INDEX ON dtos(ENTRADA) TO idb1.NTX 
GO TOP
LIN:=08
ANO:=YEAR(ENTRADA)
MES:=1
COL:=5
TOTALMES:=0
TOTALANO:=0
GERALMES:=0
GERALANO:=0
CONTADOR:=0
LINHA =17
COLUNA=00
go top
DO WHILE .T.
   IF LIN>=16 .OR. EOF()
      IF EOF()
         RESUMO ()
         gwriteat(200,425,"P/ SAIR APERTE UMA TECLA",4)
         gwriteat(120,463,AUTOR() ,1)
         TONE(300,5)
         close databases
         contador=60*5
         do while contador>=0
            IF LASTKEY()>1
               EXIT
            ENDIF
            SET CURSOR OFF
            @ 24,01 SAY STR(CONTADOR,3)+"s para saida!" COLOR "R+/N"
            contador--
            inkey(1)
         enddo
         TONE(900,0.5)
         @ 23,01 SAY PADC("PROCESSAMENTO DE DADOS ENCERRADO",78) COLOR "W+/W"
         @ 24,01 SAY PADC(" ",4)
         @ 24,01 SAY ""
         QUIT
      ENDIF
      LIN=08
      @ 23,01 SAY PADC("APERTE UMA TECLA PARA CONTINUAR",78) COLOR "W+/W"
      @ 30,01 SAY PADC(m->autor,80) COLOR "bg+/W"
      INKEY(0)
      @ 008,01 CLEAR TO 24,78
   ENDIF
   LIN     :=LIN+1
   COL     :=6
   ANO     :=YEAR(ENTRADA)
   MES     :=1
   TOTALMES:=0
   GERALMES:=0
   DO WHILE ANO=YEAR(ENTRADA)
      DO WHILE MES=MONTH(ENTRADA) .AND. MES<=12
         TOTALMES=TOTALMES+QUANTIDADE
         @ 007,000 SAY PADL("ANO",   05) color "BG+/N"
         @ 007,066 SAY PADR("GLOBAL",07) color "BG+/N"
         @ 007,073 SAY PADR("MEDIA ",07) color "BG+/N"
         @ 007,COL SAY padl(OMES(MES),4) color "W+ /N"
        * @ 008,COL SAY REPL("Ä",4)       color "W+ /N"
         @ LIN,000 SAY YEAR(ENTRADA)   color "W+ /N"
         @ LIN,COL SAY STR(TOTALMES,5)   color "bg+/N"
         SKIP
      ENDDO
      MES     :=MES+1
      COL     :=COL+6
      GERALMES:=GERALMES+TOTALMES
      TOTALMES:=0  
      @ LIN,66 SAY PADR(ALLTRIM(STR(GERALMES)),06)+PADR(" ñ"+ALLTRIM(STR(INT(GERALMES/12))),07) color "R+/N"
   ENDDO
ENDDO
?""
?""
?""
FUNCTION OMES(nMES)
if nMES = nil
   nMES = month(Date())
endif
cMES     := "JANFEVMARABRMAIJUNJULAGOSETOUTNOVDEZ"
cDATA    := Trim(SubStr(cMES, nMES * 3 - 2, 3))
return (cDATA)

function resumo
VDATA=DATE()
zDIA=0
aDIA=0
QTD =0
resumogeral=0
GO TOP
DO WHILE !EOF()
   IF SUBSTR(DTOC(ENTRADA),4,10)=SUBSTR(DTOC(VDATA),4,10) 
      zDIA :=DOW(ENTRADA)
      xDATA:=ENTRADA
      QTD  :=0
      DO WHILE DOW(ENTRADA)=1 
         COL1=00;QTD1=+QUANTIDADE
      ENDDO
      DO WHILE DOW(ENTRADA)=2 .AND. 
         COL2=12;QTD2=+QUANTIDADE
      ENDDO
      @ 16, 01 SAY PADC("ENTRADA DE CIMENTO NO MES "+SUBSTR(DTOC(VDATA),4,10),78) COLOR "R+/N"
      @ 17, COLUNA SAY padR(cDIA,011) color "W+ /BG"
      @ LINHA+1,COLUNA+00 SAY SUBSTR(DTOC(ENTRADA),01,05)+": " COLOR "BG/N"
      DO WHILE XDATA=ENTRADA
         QTD        :=+QUANTIDADE
         RESUMOGERAL:=+QTD
         @ LINHA+1,COLUNA+06 SAY PADL(ALLTRIM(STR(QTD,06)),05) COLOR "BG+/N"
         skip
         zDIA++
      ENDDO
      IF ZdIA>=8
         linha++
      ENDIF
     
      
      ELSE                                           
      SKIP
   ENDIF
ENDDO
@ 16, 01 SAY PADC("ENTRADA DE CIMENTO NO MES "+SUBSTR(DTOC(VDATA),4,10)+" ("+ALLTRIM(STR(RESUMOGERAL,10))+" SC)",78) COLOR "RG+/N"
return.t.

