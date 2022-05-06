
FUNCTION LOCflh
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
           Else
               lDone := .T. // REGISTRO LOCALIZADO
               @ 22,06 say repl(" ",80-12)  COLOR "W+/B"
               @ 23,06 say repl(" ",80-12)  COLOR "W+/B"
             lDone := .T. // REGISTRO LOCALIZADO
             @ 22,06 say repl(" ",80-12)  COLOR "W+/B"
             @ 23,06 say repl(" ",80-12)  COLOR "W+/B"
             do while !eof()
                      salarion=salariob+salariop+salariog+salariox
                      oAVISO  =PADc(";ÛÛÛÛ²²°°  L O C A L I Z A D O  °°²²ÛÛÛÛ;;",40)+;
                             ";;"+PADR("Grupo:",10)+padr(Grupo,30)+;
                              ";"+PADR("Alcunha: ",10)+padr(Alcunha, 30)+;
                              ";"+PADR("Nome: ",10)+padr(Nome, 30)+;
                              ";"+PADR("Cargo:",10)+padr(Cargo,30)+;
                              ";"+PADR("S/mes:",10)+padr("R$"+alltrim(str(salarion,10,2)),30)+;
                              ";"+PADR("S/semana:",10)+padr("R$"+alltrim(str(salarion/4,10,2)),30)+;
                              ";"+PADR("RG:   ",10)+padr(RG,30)+;
                              ";"+PADR("CPF:  ",10)+padr(CPF,30)+;
                              ";"+PADR("C.Trab:",10)+padr(ALLTRIM(ctrabalhon)+"-"+ctrabalhos,30)
                      aOPCAO  ={padc(CHR(017)+CHR(017)+" Anterior",10), padc("proximo "+CHR(016)+CHR(016),10), padc(" þ stop ",10)}
                      aESCOLHA=ALERT(oAVISO, aOPCAO,"W+/N")
                  do case    
                     case aESCOLHA=1 ;SKIP-1
                     case aESCOLHA=2 ;SKIP+1
                     case aESCOLHA=3 ;TONE(1000);EXIT
                     OTHERWISE       ;TONE(1000);EXIT
                  endcase
               enddo
          Endif                                     
          EXIT
     ENDDO
SET DELETED ON
RETURN.T.


FUNCTION procRapida()
     SAVE SCREEN TO M->T_ELArapid
     SELE 2
     USE DBflh INDEX idflh1,idflh2
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
                      salarion=salariob+salariop+salariog+salariox
                      oAVISO  =PADc(";ÛÛÛÛ²²°°  L O C A L I Z A D O  °°²²ÛÛÛÛ;;;",40)+;
                             ";;"+PADR("Grupo:",10)+padr(Grupo,30)+;
                              ";"+PADR("Alcunha: ",10)+padr(Alcunha, 30)+;
                              ";"+PADR("Nome: ",10)+padr(Nome, 30)+;
                              ";"+PADR("Cargo:",10)+padr(Cargo,30)+;
                              ";"+PADR("S/mes:",10)+padr("R$"+alltrim(str(salarion,10,2)),30)+;
                              ";"+PADR("S/semana:",10)+padr("R$"+alltrim(str(salarion/4,10,2)),30)+;
                              ";"+PADR("RG:   ",10)+padr(RG,30)+;
                              ";"+PADR("CPF:  ",10)+padr(CPF,30)+;
                              ";"+PADR("C.Trab:",10)+padr(ALLTRIM(ctrabalhon)+"-"+ctrabalhos,30)
                      aOPCAO  ={padc(CHR(017)+CHR(017)+" Anterior",10), padc("proximo "+CHR(016)+CHR(016),10), padc(" þ stop ",10)}
                      aESCOLHA=ALERT(oAVISO, aOPCAO,"W+/N")
                  do case    
                     case aESCOLHA=1 ;SKIP-1
                     case aESCOLHA=2 ;SKIP+1
                     case aESCOLHA=3 ;TONE(1000);EXIT
                     OTHERWISE       ;TONE(1000);EXIT
                  endcase
               enddo
          endif                                     
          EXIT
     ENDDO
SET DELETED ON
restore SCREEN from M->T_ELArapid
RETURN.T.
