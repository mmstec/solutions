* FNEREG.PRG *

FUNCTION AJUDA
SAVE SCREEN TO TELA_REGISTRE
salvacor=setcolor()
TONE(300,1)
SETCOLOR("N+/N")
CLEAR
?REPL(" MMS /\//\\//\\/\",205) 
DO WHILE .T.
   SETCOLOR("N+/B,BG+/B,,,BG+/B")
   RELEVO(02, 08, 22, 72,.F.,,1)
   relevo(15, 56, 17, 71, .T.) // BOTOES
   relevo(18, 56, 20, 71, .T.) // BOTOES     
   @ 05,10 SAY PADC(M->SISTEMA                      ,55) color "BG+  /B"
   @ 06,10 SAY PADC("Vers„o "+M->VERSAO             ,55) color "BG   /B"
   VERIFICA_REGISTRO()
   @ 08,20 TO 13,60                             color "W/B"
   @ 09,21 SAY PADC(" Registrado em nome de ",38)        color "bg+/B"
   @ 10,21 SAY PADC(alltrim(M->LNOME)        ,38) color "RG+  /B"
   @ 11,21 SAY PADC(" N.§ do Registro "      ,38)        color "bg+/B"
   @ 12,21 SAY PADC(alltrim(M->LCODIGO)      ,38) color "RG+  /B"
   
   @ 15,10 SAY REPL("Ä",45) COLOR "B+/B"
   @ 16,10 SAY PADR(M->AUTOR                        ,44) color "B+  /B"
   @ 17,10 SAY PADR(M->EMAIL                        ,44) color "B+  /B"
   @ 18,10 SAY PADR(M->ICQ                          ,44) color "B+  /B"
   @ 19,10 SAY PADR(M->celular                      ,44) color "B+  /B"
   @ 21,40 say "Mem¢ria livre "+alltrim(str(memory(2)))+" kb"  color "W/B"
   @ 21,10 say "M quina "+trim(netname())                color "W/B"
   
   @ 16,58 PROMPT padR("     OK     " ,13) 
   @ 19,58 PROMPT padR("  REGISTRE  " ,13) 
   
   DBMENSAGEM()
   OPCMENU=1
   MENU TO OPCMENU
   DO CASE
   CASE OPCMENU=1 .OR. LASTKEY()=27
        PRINCIPAL()
   CASE OPCMENU=2 
        REGISTRE()
   ENDCASE
ENDDO
cls
setcolor(salvacor)
RESTORE SCREEN FROM TELA_REGISTRE
RETURN.T.

   
   
FUNCTION REGISTRE
SAVE SCREEN TO TELA_AJUDA
salvacor=setcolor()
set cursor on
SETCOLOR("N+/N")
        *CLEAR
        *RELEVO(02,06,22,73,.F.,,1)
VAR1=SPACE(40)
VAR2=SPACE(40)
@ 15,10 TO 17,52                            color "W/B"
@ 15,11 SAY "ENTRE COM SEU NOME"            color "bg+/B"
@ 16,11 GET VAR1 valid !empty(var1)         color "bg+/N"
@ 18,10 TO 20,52                            color "W/B"
@ 18,11 SAY "ENTRE COM O REGISTRO"          color "bg+/B"
@ 19,11 GET VAR2 valid !empty(var2)         color "bg+/N"
READ
IF LASTKEY()=27
   return.t.
   ELSE
   IF iCODIFICA(VAR1)=alltrim(VAR2)  .AND. LEN(iCODIFICA(VAR1))=LEN(iCODIFICA(VAR2))
      ALERT("PROGRAMA REGISTRADO",,"W+/G")
      ikNOM=VAR1
      ikCOD=VAR2
      ikDAT=DATE()
      if file("MMSTEC.SYS")
         erase MMSTEC.SYS
      endif
      SAVE ALL LIKE ik* to MMSTEC.SYS 
      ELSE
      TONE(300)
      ALERT("SINTO MUITO;;CODIGO DIGITADO INVALIDO")
   ENDIF
ENDIF
CLEAR
set cursor off
setcolor(salvacor)
RESTORE SCREEN FROM TELA_AJUDA
RETURN.T.
   
   
   
                  
   ********
   FUNCTION iaCODIFICA(PARAMETER)
   CHAVE   :=ALLTRIM(PARAMETER)
   LIMITE  :=0
   CRACK   :=""
   for contador=1 to len(chave)
       LIMITE++
       iCODIFICA :=ASC(substr(chave,LIMITE,contador))+LEN(CHAVE)
       CRACK    :=CRACK + chr(iCODIFICA)
   next
   RETURN CRACK

   FUNCTION iaDECODIFICA(PARAMETER)
   CHAVE   :=iCODIFICA(PARAMETER)
   LIMITE  :=0
   CRACK   :=""
   for contador=1 to len(chave)
       LIMITE++
       iDECODIFICA :=ASC(substr(chave,LIMITE,contador))-LEN(CHAVE)
       CRACK       :=CRACK - chr(iDECODIFICA)
   next
   RETURN CRACK

   FUNCTION iCODIFICA(PARAMETER)
   CHAVE   :=ALLTRIM(PARAMETER)
   LIMITE  :=0
   CRACK   :=""
   for contador=1 to len(chave)
       LIMITE++
       CODIFICA :=ASC(substr(chave,LIMITE,contador))+33
       CRACK    :=CRACK + chr(CODIFICA)
   next
   RETURN CRACK

   FUNCTION iDECODIFICA(PARAMETER)
   CHAVE   :=CODIFICA(PARAMETER)
   LIMITE  :=0
   CRACK   :=""
   for contador=1 to len(chave)
       LIMITE++
       DECODIFICA :=ASC(substr(chave,LIMITE,contador))-33
       CRACK      :=CRACK - chr(DECODIFICA)
   next
   RETURN CRACK


   FUNCTION DECODIFICA(PARAMETER)
   CHAVE   :=CODIFICA(PARAMETER)
   LIMITE  :=0
   CRACK   :=""
   for contador=1 to len(chave)
       LIMITE++
       DECODIFICA :=ASC(substr(chave,LIMITE,contador))-33
       CRACK      :=CRACK - chr(DECODIFICA)
   next
   RETURN CRACK
   

 FUNCTION VERIFICA_REGISTRO
 IF FILE("MMSTEC.SYS")
    RESTORE FROM MMSTEC.SYS ADDITIVE
    ELSE
    ikNOM=" AVALIACAO "
    ikCOD="J_JURJLJX"
    ikDAT=DATE()
    SAVE ALL LIKE ik* to MMSTEC.SYS
    RESTORE FROM MMSTEC.SYS ADDITIVE
 ENDIF
 M->LNOME    := ikNOM
 M->LCODIGO  := ikCOD
 M->LENDERECO:= ""
 RETURN
