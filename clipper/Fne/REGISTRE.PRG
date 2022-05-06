   CLEAR
   VAR1=SPACE(40)
   VAR2=SPACE(40)
   @ 08,10 SAY PADR("MMSTEC REGISTRADOR",40) color "bg+/B"
   @ 10,10 TO 12,52
   @ 10,11 SAY "ENTRE COM SEU NOME" 
   @ 11,11 GET VAR1 valid !empty(var1)
   @ 13,10 TO 15,52
   @ 13,11 SAY "ENTRE COM O REGISTRO" 
   @ 14,11 GET VAR2 valid !empty(var2)
   @ 16,10 say AUTOR() color "bg+/n"
   READ
   IF LASTKEY()=27
      QUIT
   ELSE
    IF iCODIFICA(VAR1)=alltrim(VAR2) 
      ALERT("PROGRAMA REGISTRADO",,"W+/G")
      ikNOM=VAR1
      ikCOD=VAR2
      if file("MMSTEC.SYS")
         erase MMSTEC.SYS
      endif
      SAVE ALL LIKE ik* to MMSTEC.SYS 
      ELSE
      TONE(300)
      ALERT("SINTO MUITO;;CODIGO DIGITADO INVALIDO")
    ENDIF
   ENDIF
   *** FIM DO PROGRAMA ****
   
   
   
   
   ********
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
   CHAVE   :=iCODIFICA(PARAMETER)
   LIMITE  :=0
   CRACK   :=""
   for contador=1 to len(chave)
       LIMITE++
       iDECODIFICA :=ASC(substr(chave,LIMITE,contador))-33
       CRACK      :=CRACK - chr(DECODIFICA)
   next
   RETURN CRACK

   

