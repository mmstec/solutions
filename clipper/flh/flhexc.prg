FUNCTION excFLH
REG:= recno()
IF M->NIVEL>=2
   IF AT("*",NOME)<>0 .AND. M->NIVEL<3
      ALERT('OPERA€ÇO INTERCEPTADA;;Seu n¡vel de senha n„o permite esta opera‡Æo.;;N¡vel m¡nimo nescess rio: "3"',,"w+/n")
      RETURN.F.
   ENDIF
   IF AT("(C)",NOME)<>0 .AND. M->NIVEL<4
      ALERT('OPERA€ÇO INTERCEPTADA;;Seu n¡vel de senha n„o permite esta opera‡Æo.;;N¡vel m¡nimo nescess rio: "4"',,"w+/n")
      RETURN.F.
   ENDIF
   cMENSAGEM :="³ÛÛÛÛ²²²°° ELIMINAR REGISTRO °°²²²ÛÛÛÛ³"+;
             ";"+REPL("Ä",50)+;
             ";Codigo  :"+PADR(CODIGO,40)+;
             ";Grupo   :"+PADR(GRUPO,40) +;
             ";Nome    :"+PADR(NOME,40)  +;
             ";Salario :"+PADR(alltrim(str(salariob+salariop+salariog+salariox)),40)+;
             ";"+REPL("Ä",50)+;
             ";"+PADC("Eliminar definitivamente este registro do sistema?",50)
             IF (Alert(cMENSAGEM,{ padc("NAO",05), padc("SIM",05) } ,"W+/R") == 2)
                 DELETE
                 PACK
                 REG++
                 TONE(300.2)
                 alert("REGISTRO ELIMINADO")
             ENDIF
ELSE
   ALERT('OPERA€ÇO INTERCEPTADA;;Seu n¡vel de senha n„o permite esta opera‡Æo.;;N¡vel m¡nimo nescess rio: "2"',,"w+/n")
ENDIF
GOTO REG
RETURN

FUNCTION excSAL
REG:= recno()
IF M->NIVEL>=2
   IF M->NIVEL<3
      ALERT('OPERA€ÇO INTERCEPTADA;;Seu n¡vel de senha n„o permite esta opera‡Æo.;;N¡vel m¡nimo nescess rio: "3"',,"w+/n")
      RETURN.F.
   ENDIF
   cMENSAGEM :="³ÛÛÛÛ²²²°° ELIMINAR REGISTRO °°²²²ÛÛÛÛ³"+;
             ";"+REPL("Ä",50)+;
             ";DATA     :"+PADR(DTOC(SDATA),40)+;
             ";S. MINIMO: "+PADR("R$"+ALLTRIM(STR(SMINIMO,2)),40) +;
             ";;"+REPL("Ä",50)+;
             ";;"+PADC("Eliminar definitivamente este registro do sistema?",50)
             IF (Alert(cMENSAGEM,{ padc("NAO",05), padc("SIM",05) } ,"W+/R") == 2)
                 DELETE
                 PACK
                 REG++
                 TONE(300.2)
                 alert("REGISTRO ELIMINADO")
             ENDIF
ELSE
   ALERT('OPERA€ÇO INTERCEPTADA;;Seu n¡vel de senha n„o permite esta opera‡Æo.;;N¡vel m¡nimo nescess rio: "2"',,"w+/n")
ENDIF
GOTO REG
RETURN
