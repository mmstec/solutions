FUNCTION LOCFONE
     nRec  := 0
     lDone := .F.
     psq   := space(30)
     do while .T.
          nCursSave:=SETCURSOR()
          SETCURSOR(1)
          @ 22,06 say PADR("LOCALIZAR:",59)         COLOR "W+/B"
          @ 22,17 get PSQ PICT "@!"         COLOR ",W+/R"
          READ
          SETCURSOR(nCursSave)
          if lastKey()=27
             exit
          endif
          nRec := Recno()
          seek trim(PSQ)
          if !found()
             @ 22,06 say PADC('VERIFIQUE SUA DIGITA€ÇO',59)        COLOR "R/B"
             tone(1000, 1)
             tone(800, 2)
             tone(1200, 1)
             ALERT('&SISTEMA.;; O sistema n„o p“de localizar uma correspondˆcia para "'+alltrim(PSQ)+'"; Caso vocˆ tenha certeza sobre a existˆncia dos dados procurados, verifique a digita‡„o e tente novamente.;;;')
             goto nRec
             loop
           else
             lDone := .T. // REGISTRO LOCALIZADO
             @ 22,06 say repl(" ",80-12)  COLOR "W+/B"
             @ 23,06 say repl(" ",80-12)  COLOR "W+/B"
             do while !eof()
                oAVISO  =PADR(";ÛÛÛÛ²²°°  L O C A L I Z A D O  °°²²ÛÛÛÛ;;",40)+;
                           ";;"+PADR("Nome:    ",10)+padR(NOME,30) +;
                           ";"+PADR("Telefone:",10)+padR(DDD+" "+FONE,30)+;
                           ";"+PADR("Endere‡o:",10)+padR(ENDERECO,30)+;
                           ";"+PADR("Obs.    :  ",10)+padR(MEMOLINE(OBS,29,1),30)+;
                           ";"+PADR("         ",10)+padR(MEMOLINE(OBS,29,2),30)+;
                           ";"+PADR("         ",10)+padR(MEMOLINE(OBS,29,3),30)
                      aOPCAO  ={padc(CHR(017)+CHR(017)+" Anterior",10), padc("proximo "+CHR(016)+CHR(016),10), padc(" þ stop ",10)}
                      aESCOLHA=ALERT(oAVISO, aOPCAO,"W+/N")
                  do case    
                     case aESCOLHA=1 ;SKIP-1
                     case aESCOLHA=2 ;SKIP+1
                     case aESCOLHA=3 ;TONE(1000);EXIT
                     OTHERWISE       ;TONE(1000);EXIT
                  endcase
             endDO
          endif                                     
          EXIT
     ENDDO
SET DELETED ON
RETURN.T.


FUNCTION procRapida()
     SAVE SCREEN TO M->T_ELArapid
     SELE 2
     USE DBFONE INDEX idFONE1,idFONE2
     SELE 2
     SET ORDER TO 1
     GOTO TOP
     nRec  := 0
     lDone := .F.
     psq   := space(30)
     do while .T.
          nCursSave:=SETCURSOR()
          SETCURSOR(1)
          @ 23,06 say repl(" ",80-12)  COLOR "W+/B"
          @ 22,06 say PADR("LOCALIZAR:",59) COLOR "rg+/B"
          @ 22,17 get PSQ PICT "@!"         COLOR ",W+/R"
          READ
          SETCURSOR(nCursSave)
          if lastKey()=27
             exit
          endif
          nRec := Recno()
          seek trim(PSQ)
          if !found()
             @ 22,06 say PADC('VERIFIQUE SUA DIGITA€ÇO',59)        COLOR "R/B"
             tone(1000, 1)
             tone(800, 2)
             tone(1200, 1)
             ALERT('&SISTEMA.;; O sistema n„o p“de localizar uma correspondˆcia para "'+alltrim(PSQ)+'"; Caso vocˆ tenha certeza sobre a existˆncia dos dados procurados, verifique a digita‡„o e tente novamente.;;'+;
             'DICA: Voce pode pesquisar tambem em MANUTENCAO/CONTATOS/LOCALIZAR;;;')
             goto nRec
             loop
           else
             lDone := .T. // REGISTRO LOCALIZADO
             restore SCREEN from M->T_ELArapid
             do while !eof()
                oAVISO  =PADR(";ÛÛÛÛ²²°°  L O C A L I Z A D O  °°²²ÛÛÛÛ;;;",40)+;
                         ";;"+PADR("Nome:    ",10)+padR(NOME,30) +;
                         ";"+PADR("Telefone:",10)+padR(DDD+" "+FONE,30)+;
                         ";"+PADR("Endere‡o:",10)+padR(ENDERECO,30)+;
                         ";"+PADR("Obs.    :  ",10)+padR(MEMOLINE(OBS,29,1),30)+;
                         ";"+PADR("         ",10)+padR(MEMOLINE(OBS,29,2),30)+;
                         ";"+PADR("         ",10)+padR(MEMOLINE(OBS,29,3),30)
                  aOPCAO  ={padc(CHR(017)+CHR(017)+" Anterior",10), padc("proximo "+CHR(016)+CHR(016),10), padc(" þ stop ",10)}
                  aESCOLHA=ALERT(oAVISO, aOPCAO,"W+/N")
                  do case    
                     case aESCOLHA=1 ;SKIP-1
                     case aESCOLHA=2 ;SKIP+1
                     case aESCOLHA=3 ;TONE(1000);EXIT
                     OTHERWISE       ;TONE(1000);EXIT
                  endcase
             endDO
          endif                                     
          EXIT
     ENDDO
SET DELETED ON
restore SCREEN from M->T_ELArapid
RETURN.T.

