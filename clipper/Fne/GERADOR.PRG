   IF FILE("MMSTEC.SYS")
      RESTORE FROM MMSTEC.SYS ADDITIVE
     ELSE
      ikNOM="MMSTEC.HPG.COM.BR"
      ikCOD="nntufdOiqhOdpnOcs"
      iKDAT=date()
      SAVE ALL LIKE ik* to MMSTEC.SYS
      RESTORE FROM MMSTEC.SYS ADDITIVE
   ENDIF
   
   CLEAR
   VAR1=PADR("MMSTEC.HPG.COM.BR",40)
   VAR2=PADR("nntufdOiqhOdpnOcs",40)
   VAR3=date()

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
   if lastkey()=27
      quit
      ?"SISTEMA CANCELADO PELO OPERADOR"
      ELSE
   @ 14,11 SAY CODIFICA(VAR1) COLOR "RG+/N"
   @ 17,00 SAY ""
   ikNOM=VAR1
   ikCOD=CODIFICA(VAR1)
   iKDAT=DATE()
   ERASE MMSTEC.SYS
   SAVE ALL LIKE ik* to MMSTEC.SYS
   GRAVAREG()
   ENDIF
   
   ********
   FUNCTION CODIFICA(PARAMETER)
   CHAVE   :=ALLTRIM(PARAMETER)
   LIMITE  :=0
   CRACK   :=""
   for contador=1 to len(chave)
       LIMITE++
       CODIFICA :=ASC(substr(chave,LIMITE,contador))+33
       CRACK    :=CRACK + chr(CODIFICA)
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
   


********************************
PROCEDURE GRAVAREG
IF FILE("FNE.REG")
   TAM=DIRECTORY("FNE.REG","2")                                                                                                   
   IF TAM[1,2] > 60000                                                       
      ERASE FNE.REG
      ALERT("O aquivo de parametros;"+TAM[1,1]+";foi renovado.;;"+REPL("Ä",20)+";Motivo;Tamanho excedido",,"W+/B")
      ACAO=ACAO+time()+"-Renovado "+TAM[1,1]+" por excesso de tamanho"+CHR(13)+CHR(10)
      TEXTO=""
      ELSE
      TEXTO=MEMOREAD("FNE.REG")
   ENDIF
   ELSE
   TEXTO=""
ENDIF
TEXTO+="DATA   : " + DTOC(DATE())+CHR(13)+CHR(10)
TEXTO+="NOME   : " + ikNOM+CHR(13)+CHR(10)
TEXTO+="SERIAL : " + ikCOD+CHR(13)+CHR(10)
TEXTO+=REPLICATE("=",50)+CHR(13)+CHR(10)
MEMOWRIT("FNE.REG",TEXTO)
********************************

