CLS
do while .t.
   if lastkey()=27
      quit
   else
      origem   :=ALLTRIM(NETNAME())
      destino  :=SPACE(15)
      mensagem :=SPACE(55)
      RESPOSTA :=SPACE(1)
   endif
@ 00     ,00 say "MSGNET - para (C) Microsoft Windows NT"                          COLOR "W+/N"
@ 01     ,00 say "Marcos Morais de Sousa 1995/"+str(year(date()),4) COLOR "W+/n"
@ 02     ,00 say "MARQUINAS DISPONIVEIS EM "+DTOC(DATE())+" "+TIME() COLOR "bg/n"
@ ROW()+2,00 SAY ""
RUN NET VIEW
IF ROW()>=18
   @ 17,00 SAY ""
ENDIF
@ ROW()+1,00 SAY "MSGNET - MENSAGEN VIA REDE"  COLOR "W +/N"
@ ROW()+1,00 SAY "DE.............:"  COLOR "W +/N"
@ ROW()  ,18 GET ORIGEM PICT "@!"    COLOR "BG+/N"
@ ROW()+1,00 SAY "PARA...........:"  COLOR "W +/N"
@ ROW()  ,18 GET DESTINO PICT "@!"   COLOR "BG+/N"
@ ROW()+1,00 SAY "MENSAGEM.......:"  COLOR "W +/N"
@ ROW()  ,18 GET MENSAGEM PICT "@!"  COLOR "N/BG"
@ 24,00 SAY PADC("PARA SAIR APERTE <ESC>",80) COLOR "RG+/N"
READ
@ ROW()+1,00 SAY "CONFIRMA A MENSAGEM? [S/N]" GET RESPOSTA VALID RESPOSTA $ "SsNn" PICT "!" COLOR "RG+/N"
TONE(300.1)
READ
IF RESPOSTA="S" .OR. RESPOSTA="s"
   @ 24,00 SAY PADR("MENSAGEM SENDO ENVIADA. AGUARDE...",80) COLOR "RG+*/N"
   RUN NET SEND &DESTINO &MENSAGEM
   TONE(300.1)
   @ 02,00 CLEAR TO 24,80
   @ 03,00 SAY 'MENSAGEM ENVIADA:"'+ALLTRIM(MENSAGEM)+'"'
   @ 04,00 SAY "DE  :"+ORIGEM
   @ 05,00 SAY "PARA:"+DESTINO
   @ 07,00 SAY "ENVIAR OUTRA MENSAGEM? [S/N]" GET RESPOSTA VALID RESPOSTA $ "SsNn" PICT "!" COLOR "G+/N"
   READ
   IF RESPOSTA="S" .OR. RESPOSTA="s"
      CLS
      LOOP   
     ELSE
      CLS
      EXIT
   ENDIF
  ELSE
   @ 24,00 SAY PADR("MENSAGEM NAO FOI ENVIADA",80) COLOR "W+/R"
   TONE(300.1)
   TONE(700.1)
   LOOP
ENDIF
ENDDO
CLS
QUIT
