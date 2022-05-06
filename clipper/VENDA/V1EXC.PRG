FUNCTION excValores
REG:= recno()
IF M->NIVEL>=2
  cMENSAGEM :="ELIMINAR REGISTRO:"+;
              ";"+REPL("=",50)+;
              ";DATA    :"+PADR(DTOC(DATA),40)+;
              ";CONTA   :"+PADR(LKCONTA+" "+NCONTA(LKCONTA),40)+;
              ";CAIXA   :"+PADR(LKCAIXA+" "+NCAIXA(LKCAIXA),40)+;
              ";VALOR   :"+PADR(STR(VALOR,10,2),   40)+;
              ";COMISSAO:"+PADR(STR(COMISSAO,10,2),40)+;
              ";"+REPL("=",50)
             IF (Alert(cMENSAGEM,{ padc("NAO",05), padc("SIM",05) } ,"W+/R") == 2)
                 DELETE
                 PACK
                 REG++
             ENDIF
ELSE
   ALERT('OPERA€ÇO INTERCEPTADA;;Seu n¡vel de senha n„o permite esta opera‡Æo.;;N¡vel m¡nimo nescess rio: "2"',,"w+/n")
ENDIF
GOTO REG
RETURN

