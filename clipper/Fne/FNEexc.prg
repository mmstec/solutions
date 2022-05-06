FUNCTION exc00001 // ESCLUI FUNCIONARIOS
REG:= recno()
IF M->NIVEL>=2
   IF AT("*",NOME)<>0 .AND. M->NIVEL<3
      ALERT('OPERA€ÇO INTERCEPTADA;;Seu n¡vel de senha n„o permite esta opera‡Æo.;;N¡vel m¡nimo nescess rio: "3"',,"w+/n")
      RETURN.F.
   ENDIF
   IF AT("(C)",NOME)<>0 .AND. M->NIVEL<4
      ALERT('OPERA€AO INTERCEPTADA;;Seu n¡vel de senha n„o permite esta opera‡Æo.;;N¡vel m¡nimo nescess rio: "4"',,"w+/n")
      RETURN.F.
   ENDIF
cMENSAGEM :="³ÛÛÛÛ²²²±±±°°°° ELIMINAR  REGISTRO °°°°±±±²²²ÛÛÛÛ³"+;
             ";"+REPL("Ä",50)+;
             ";Codigo  :"+PADR(CODIGO,40)+;
             ";Nome    :"+PADR(NOME,40)  +;
             ";Fone    :"+PADR(DDD+" "+FONE,40)+;
             ";"+REPL("Ä",50)+;
             ";"+PADc("Voce tem certeza de que deseja excluir este",50)+;
             ";"+PADc("registro definitivamente dos arquivos?",50)
             IF (Alert(cMENSAGEM,{ padc("NAO",05), padc("SIM",05) } ,"W+/R") == 2)
                 DELETE
                 PACK
                 REG++
                 alert("Registro;---x--;;"+Alltrim(nome)+";;"+"--x--;; Eliminado dos arquivos") 
                 Tone(1000)
             ENDIF
ELSE
   ALERT('OPERA€ÇO INTERCEPTADA;;Seu n¡vel de senha n„o permite esta opera‡Æo.;;N¡vel m¡nimo nescess rio: "2"',,"w+/n")
ENDIF
GOTO REG
RETURN

