FUNCTION LOCCAD
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
               do while !eof()
               IF ALERT(PADc("ÛÛÛÛ²²°°  L O C A L I Z A D O  °°²²ÛÛÛÛ;;",40)+;
                        ";"+PADR("Informa‡oes Pessoais",40)+;
                        ";"+PADR("Nome:"     ,10)+padr(c1Nome, 30)+;
                        ";"+PADR("Endereco:",10)+padr(c1ende, 30)+;
                        ";"+PADR("Fone:"    ,10)+padr(c1FONE, 30)+;
                        ";"+PADR("RG:"      ,10)+padr(c1RG,30)+;
                        ";"+PADR("CPF:"     ,10)+padr(c1CPF,30)+;
                        ";"+PADR("C.Trab:"  ,10)+padr(alltrim(c1Ctrabn)+" Serie: "+c1Ctrabs,30)+;
                        ";"+PADC("---X---",40)+;
                        ";"+PADR("Informa‡oes do Ultimo Trabalho",40)+;
                        ";"+PADR("EMPRESA:"  ,10)+padr(C2EMPRESA,30)+;
                        ";"+PADR("CARGO:"    ,10)+padr(C2Cargo,30)+;
                        ";"+PADR("ADMISSAO:" ,10)+padr(DTOC(C2ADMISAO),30)+;
                        ";"+PADR("DEMISSAO:" ,10)+padr(DTOC(C2DEMISAO),30)+;
                        ";"+PADR("MOTIVO:"   ,10)+padr(C2MOTIVO,30),{PADC("PROXIMO",10),PADC("RETORNA",10)},"W+/N")==1
               SKIP
               ELSE
               EXIT
               ENDIF
               ENDDO
          Endif                                     
          EXIT
     ENDDO
SET DELETED ON
RETURN.T.


FUNCTION procRapida()
     SAVE SCREEN TO M->T_ELArapid
     SELE 2
     USE DBCAD INDEX idCAD1,idCAD2
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
               if ALERT(PADc("ÛÛÛÛ²²°°  L O C A L I Z A D O  °°²²ÛÛÛÛ;;",40)+;
                        ";"+PADC("# DADOS PESSOAIS #",40)+;
                        ";"+PADR("Nome:"     ,10)+padr(c1Nome, 30)+;
                        ";"+PADR("Endereco:",10)+padr(c1ende, 30)+;
                        ";"+PADR("Fone:"    ,10)+padr(c1FONE, 30)+;
                        ";"+PADR("RG:"      ,10)+padr(c1RG,30)+;
                        ";"+PADR("CPF:"     ,10)+padr(c1CPF,30)+;
                        ";"+PADR("C.Trab:"  ,10)+padr(alltrim(c1Ctrabn)+" Serie: "+c1Ctrabs,30)+;
                        ";"+PADC("# DADOS DO ULTIMO TRABALHO #",40)+;
                        ";"+PADR("EMPRESA:"  ,10)+padr(C2EMPRESA,30)+;
                        ";"+PADR("CARGO:"    ,10)+padr(C2Cargo,30)+;
                        ";"+PADR("ADMISSAO:" ,10)+padr(DTOC(C2ADMISAO),30)+;
                        ";"+PADR("DEMISSAO:" ,10)+padr(DTOC(C2DEMISAO),30)+;
                        ";"+PADR("MOTIVO:"   ,10)+padr(C2MOTIVO,30),{PADC("PROXIMO",10),PADC("RETORNA",10)},"W+/N")==1
               SKIP
               ELSE
               EXIT
               ENDIF
               ENDDO
          endif                                     
          EXIT
     ENDDO
SET DELETED ON
restore SCREEN from M->T_ELArapid
RETURN.T.
