 *
 *******************************************************************************
 *                           (C) MMStec inform tica LTDA
 *******************************************************************************
 * Programa......: REGISTRO DE REMDTGRAV DE CIMENTO
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
 SET DATE BRIT                    
 SETCANCEL(.T.)                  // (.F.) desativa ALT-C/BREAK
 SET EPOCH TO 1930               // prepara datas para o terceiro milˆnio
 SET DATE FORMAT TO "dd,mm,yyyy" // formato de datas tipo 10/07/1974
 SET DATE BRIT                    
 SET CURSOR OFF                      
 cls  
 gFrame(000,000, 639, 059, 7, 15, 8, 3, 3, 3, 4,-1)  
 *gFrame(000,000, 639, 079, 7, 15, 8, 3, 3, 3, 4,-1)  
 *gFrame(000,000, 639, 039, 7, 15, 8, 3, 3, 3, 4,-1)  
 *gFrame(000,110, 049, 137, 7, 15, 8, 3, 3, 3, 4,-1)  
 *gFrame(000,000, 639, 456, 7, 15, 8, 3, 3, 3, 4,-1)  
 *gFrame(000,400, 639, 456, 7, 15, 8, 3, 3, 3, 4,-1)  
 gFrame(000,457, 639, 479, 7, 15, 8, 3, 3, 3, 4,-1)  
@ 01,01 SAY PADC("DUPLICATAS",78)    color "B+/W"
@ 01,01 SAY PADR(PROCNAME(),08)      color "N+/W"
gwriteat(180,040,data(),01)
@ 05,01 SAY padc("REMESSA MENSAL DE DUPLICATAS",78) color "RG+/N"
USE COBQTD
INDEX ON dtos(REMDTGRAV) TO idb1.NTX 
GO TOP
LIN:=08
ANO:=YEAR(REMDTGRAV)
MES:=1
COL:=5
TOTALMES:=0
TOTALANO:=0
GERALMES:=0
GERALANO:=0
CONTADOR:=0
LINHA =18
COLUNA=01
go top
DO WHILE .T.
   IF LIN>=16 .OR. EOF()
      IF EOF()
         RESUMO()
         gwriteat(200,425,"P/ SAIR APERTE QUALQUER TECLA",15)
         gwriteat(120,463,AUTOR() ,1)
         TONE(300,5)
         close databases
         contador=60*5
         do while contador>=0
            IF LASTKEY()>1
               EXIT
            ENDIF
            SET CURSOR OFF
            @ 05,01 SAY STR(CONTADOR,3)+'"' COLOR "R+/N"
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
   ANO     :=YEAR(REMDTGRAV)
   MES     :=1
   TOTALMES:=0
   GERALMES:=0
   DO WHILE ANO=YEAR(REMDTGRAV)
      DO WHILE MES=MONTH(REMDTGRAV) .AND. MES<=12
         TOTALMES=TOTALMES+REMNUMQTD
         @ 007,000 SAY padL("  MES"   ,05) color "RG+/N"
         @ 008,000 SAY padR(" ANO "   ,05) color "RG+/N"
         @ 007,066 SAY padR("TOTAL"   ,07) color "RG+/N"
         @ 007,073 SAY padR("MEDIA "  ,07) color "RG+/N"
         @ 007,COL SAY padL(OMES(MES) ,04) color "W+ /N"
         @ LIN,000 SAY YEAR(REMDTGRAV)     color "W+ /N"
         @ LIN,COL SAY STR(TOTALMES   ,04) color "BG+/N"
         SKIP
      ENDDO
      MES     :=MES+1
      COL     :=COL+5
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

   FUNCTION RESUMO
   @ 17,00 SAY PADC("REMESSA DIARIA DO MES "+SUBSTR(DTOC(DATE()),4,10),80) COLOR "RG+/N" 
   LINHA   :=LINHA+1
   COLUNA  :=01
   MES     :=SUBSTR(DTOC(DATE()),4,10) 
   DIA     :=1
   TOTALDIA:=0
   TOTALMES:=0
   GO TOP
   DO WHILE !EOF()
   DO WHILE SUBSTR(DTOC(REMDTGRAV),4,10)=SUBSTR(DTOC(DATE()),4,10) 
      IF DIA     >07
         DIA     =01
         COLUNA  =01
         LINHA++
      ENDIF
      DO WHILE DIA=DOW(REMDTGRAV) .AND. DIA<=07
         TOTALDIA =TOTALDIA+REMNUMQTD
         @ 018   ,COLUNA+0 SAY padR(ODIA(DIA) ,10)        color "W+ /RG+"
         @ LINHA ,COLUNA+0 SAY SUBSTR(DTOC(REMDTGRAV),1,05) color "BG /N"
         @ LINHA ,COLUNA+5 SAY STR(TOTALDIA   ,05)        color "BG+/N"
         SKIP
      ENDDO
      DIA     :=DIA+01
      COLUNA  :=COLUNA+11
      TOTALMES=TOTALMES+TOTALDIA
      TOTALDIA:=0  
   ENDDO
   SKIP
   @ 24,27 SAY "°±Û" COLOR "B/N"
   @ 24,50 SAY "Û±°" COLOR "B/N"
   @ 24,30 SAY PADC("AGUARDE...",20) COLOR "RG+/B"
   ENDDO
   @ 24,30 SAY PADC("TOTAL DO MES:"+ALLTRIM(STR(TOTALMES,10)),20) COLOR "W+/B"
   close databases
   RETURN

      FUNCTION ODIA(VARIAVEL)
      IF VARIAVEL=NIL
         VARIAVEL=001
      ENDIF
      DO CASE
         CASE VARIAVEL=1 
              cDIA="DOM"
         CASE VARIAVEL=2 
              cDIA="SEG"
         CASE VARIAVEL=3 
              cDIA="TER"
         CASE VARIAVEL=4 
              cDIA="QUA"
         CASE VARIAVEL=5 
              cDIA="QUI"        
         CASE VARIAVEL=6 
              cDIA="SEX"        
         CASE VARIAVEL=7 
              cDIA="SAB"
      ENDCASE
      RETURN  CDIA
