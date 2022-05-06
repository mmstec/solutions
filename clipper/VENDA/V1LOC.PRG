FUNCTION LOCVALORES
     nRec  := 0
     lDone := .F.
     psq   := CTOD("  /  /    ")
     do while .T.
          nCursSave:=SETCURSOR()
          SETCURSOR(1)
          @ 22,06 say PADR("LOCALIZAR:",59)         COLOR "W+/B"
          @ 22,17 get PSQ PICT "99/99/9999"         COLOR ",W+/R"
          READ
          SETCURSOR(nCursSave)
          if lastKey()=27
             exit
          endif
          nRec := Recno()
          seek PSQ
          if !found()
             @ 22,06 say PADC('VERIFIQUE SUA DIGITAÄ«O',59)        COLOR "R/B"
             tone(1000, 1)
             tone(800, 2)
             tone(1200, 1)
             ALERT('&SISTEMA.;; O sistema nÑo pìde localizar uma correspondàcia para "'+alltrim(dtoc(PSQ))+'"; Caso vocà tenha certeza sobre a existància dos dados procurados, verifique a digitaáÑo e tente novamente.;;;')
             goto nRec
             loop
           else
             lDone := .T. // REGISTRO LOCALIZADO
             @ 22,06 say repl(" ",80-12)  COLOR "W+/B"
             @ 23,06 say repl(" ",80-12)  COLOR "W+/B"
              do while !eof()
                oAVISO  =PADR(";€€€€≤≤∞∞  L O C A L I Z A D O  ∞∞≤≤€€€€;;",40)+;
                       ";;"+PADR("DATA.....:",10)    +":"+PADR(DBDATA(DATA),30)+;
                        ";"+PADR("CONTA....:",10)    +":"+PADR(LKCONTA+" "+NCONTA(LKCONTA),30)+;
                        ";"+PADR("CAIXA....:",10)    +":"+PADR(LKCAIXA+" "+NCAIXA(LKCAIXA),30)+;
                        ";"+PADR("VALOR....:",10)    +":"+PADR(str(valor,10,2),30)+;
                        ";"+PADR("COMISSAO.:",10)+":"+PADR(str(comissao,10,2),30)
                  
                  aOPCAO  ={padc(CHR(017)+CHR(017)+" Anterior",10), padc("proximo "+CHR(016)+CHR(016),10), padc(" ˛ stop ",10)}
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
