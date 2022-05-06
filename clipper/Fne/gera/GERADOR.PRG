   IF FILE("MMSTEC.SYS")
      RESTORE FROM MMSTEC.SYS ADDITIVE
     ELSE
      ikNOM=" AVALIACAO "
      ikCOD=" bwbmjbdbp "
      iKDAT=DATE()
      SAVE ALL LIKE ik* to MMSTEC.SYS
      RESTORE FROM MMSTEC.SYS ADDITIVE
   ENDIF
   
   CLEAR
   VAR1=PADR(" AVALIACAO ",40)
   VAR2=PADR("AbwbmjbdbpA",40)
   VAR3=CTOD("01/01/2000")

   @ 02,10 say "Registrado para:"+ikNOM
   @ 03,10 say "Registro numero:"+ikCOD
   @ 04,10 say "DATA Registro  :"+DTOC(ikDAT)

   @ 08,10 SAY PADR("MMSTEC - GERADOR DE CODIGOS",40) color "bg+/B"
   @ 10,10 TO 12,52
   @ 10,11 SAY "ENTRE COM UM NOME" 
   @ 11,11 GET VAR1 valid !empty(var1)
   @ 13,10 TO 15,52
   @ 13,11 SAY "CODIGO DE REGISTRO" 
   @ 16,10 say AUTOR() color "bg+/n"
   READ
   @ 14,11 SAY CODIFICA(VAR1) COLOR "RG+/N"
   @ 17,00 SAY ""
   ikNOM=VAR1
   ikCOD=CODIFICA(VAR1)
   iKDAT=DATE()
   ERASE MMSTEC.SYS
   SAVE ALL LIKE ik* to MMSTEC.SYS 
   
   ********
   FUNCTION CODIFICA(PARAMETER)
   CHAVE   :=ALLTRIM(PARAMETER)
   LIMITE  :=0
   DG      :=0
   SERIAL  :=""
   for contador=1 to len(chave)
       LIMITE++
       CODIFICA :=ASC(substr(chave,LIMITE,contador))+LEN(CHAVE)
       SERIAL   :=SERIAL + chr(CODIFICA)
   next               
   RETURN SERIAL

   FUNCTION DECODIFICA(PARAMETER)
   CHAVE   :=CODIFICA(PARAMETER)
   LIMITE  :=0
   CRACK   :=""
   for contador=1 to len(chave)
       LIMITE++
       DECODIFICA :=ASC(substr(chave,LIMITE,contador))-LEN(CHAVE)
       CRACK      :=CRACK - chr(DECODIFICA)
   next
   RETURN CRACK
   

