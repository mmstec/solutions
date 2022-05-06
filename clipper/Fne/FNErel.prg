FUNCTION RELATORIO
DO WHILE.T.
   SETCOLOR("N+/B,BG+/B,,,BG+/B")
   ENTRADA("MENU DE RELATORIOS")
   relevo(06, 56, 08, 73, .T.) // BOTOES
   relevo(09, 56, 11, 73, .T.) // BOTOES
   relevo(12, 56, 17, 73, .T.) // BOTOES
   relevo(18, 56, 20, 73, .T.) // BOTOES
   @ 07,58 PROMPT padR("1.Contatos"  ,15)
   @ 10,58 PROMPT padR("2.Usu rios"  ,15)
   @ 19,58 PROMPT padR("5.Principal" ,15)
   RELMENU=1
   MENU TO RELMENU
   DO CASE
   CASE RELMENU=1 
        RELCONTATOS()
   CASE RELMENU=2
        ALERT("Opera‡Æo n„o Permitida")
   CASE RELMENU=3 .OR. LASTKEY()=27
        PRINCIPAL()
   ENDCASE
ENDDO
RETURN.T.

FUNCTION RELCONTATOS
DO WHILE.T.
   SETCOLOR("N+/B,BG+/B,,,BG+/B")
   ENTRADA("RELATORIO DE CONTATOS")
   relevo(06, 56, 08, 73, .T.) // BOTOES
   relevo(09, 56, 11, 73, .T.) // BOTOES
   relevo(12, 56, 17, 73, .T.) // BOTOES
   relevo(18, 56, 20, 73, .T.) // BOTOES
   @ 07,58 PROMPT padR("1.Geral       "  ,15) MESSAGE PADC('P/ RELATORIO DE TODOS OS REGISTROS APERTE "1"',67)
   @ 10,58 PROMPT padR("2.Selecionados"  ,15) MESSAGE PADC('P/ RELATORIO DE REGISTROS SELECIONADOS APERTE "2"',67)
   @ 19,58 PROMPT padR("5.Retorna     "  ,15) MESSAGE PADC('P/ RETORNAR AO MENU PRINCIPAL APERTE "5" OU "ESC"',67)      
   RELESCOLHA:=1
   MENU TO RELESCOLHA
   DO CASE
   CASE RELESCOLHA=1             
        ************
        PERGUNTA  :=Alert("SAIDA DO RELATORIO",{ padc("MONITOR",13), padc("IMPRESSORA",13), padc("CANCELA",13) },"W+/N")
        DO CASE
           CASE PERGUNTA==1
                REL1_SCREEN()
           CASE PERGUNTA==2
                REL1_LPT()
           OTHERWISE
                RELATORIO()
        ENDCASE
        ************
   CASE RELESCOLHA=2
        ************                           
        PERGUNTA  :=Alert("SAIDA DO RELATORIO",{ padc("MONITOR",13), padc("IMPRESSORA",13), padc("CANCELA",13) },"W+/N")
        DO CASE
           CASE PERGUNTA==1
                REL2_SCREEN()
           CASE PERGUNTA==2
                REL2_LPT()
           OTHERWISE
                RELATORIO()
        ENDCASE
        ************
   CASE RELESCOLHA=3 .OR. LASTKEY()=27
        RELATORIO()
   ENDCASE
ENDDO
RETURN.T.

function REL1_SCREEN // relatorio na tela
pagina=0
nLinha=1
GOTO TOP
do while .t.
   if lastkey()=27
      exit
   endif
   if nLinha=1
      RELEVO(05, 05, 21, 54,.F.,,2) // tela EQUERDA
      RELEVO(06, 06, 08, 53,.F.,,1) // BARRA DE TITULO
      pagina++
      @ 07,08 SAY PADC("RELATORIO GERAL DE CONTATOS E TELEFONES",44) color "bg   /b"
      @ 10,08 say "Nome"
      @ 10,34 say "DDD Telefone"
      @ 11,08 say repl("Ä",44)
      nLINHA=12
   ENDIF
   @ nLINHA,08 SAY PADR(NOME,25) COLOR "W+/B"
   @ nLINHA,34 SAY DDD+" "+FONE  COLOR "W+/B"
   SKIP
   nLinha++
   IF nLINHA>18 .OR. EOF()
      @ nLINHA+1,08 say PADc("- "+ALLTRIM(str(pagina,6))+" -",44) color "r+/b"
      IF EOF()
         INKEY(0)
         EXIT
      ELSE
         INKEY(10)
         nLINHA=1
      ENDIF
   ENDIF
enddo  
RETURN.T.

function REL2_SCREEN // relatorio na tela
SALVACOR=SETCOLOR()
SETCOLOR("Bg+/b,W+/R,,,W+/B")
SELE 2
USE DBFONE INDEX idFONE1.NTX,idFONE2.NTX 
SET ORDER TO 1
M->FILTRO_1=PADR("A",20)
M->FILTRO_2=PADR("Z",20)
RELEVO(05, 05, 21, 54,.F.,,2) // tela EQUERDA
RELEVO(06, 06, 08, 53,.T.,,2) // BARRA DE TITULO
RELEVO(12, 18, 15, 53,.F.,,2) // tela EQUERDA
@ 07,07 SAY PADC("Relatorio Selecionado",45)   color "W+/R"
@ 10,08 SAY PADR("Informe o intervalo dos dados" ,44) color "BG+/B"
@ 11,08 SAY PADR("a serem selecionados:"         ,44) color "BG+/B"

*******************************
@ 13,08 SAY padR("INICIO: ",10)
@ 14,08 SAY padR("FIM: "   ,10) 
@ 13,19 GET M->FILTRO_1
@ 14,19 GET M->FILTRO_2
*******************************
@ 16,08 SAY 'Ex.: Como imprimir todos os "MARCOS"?'  color "N+/B"
@ 17,08 SAY "     INICIO: MARCOS"                    color "N+/B"
@ 18,08 SAY "     FIM   : MARCOS"                    color "N+/B"
SET CURSOR ON
READ
SET CURSOR OFF
IF LASTKEY()=27
   SET FILTER TO
   RETURN
ENDIF
RELEVO(11, 22, 13, 44, .T.,"R+/R")
@ 12,23 SAY PADC("AGUARDE",21) COLOR "W*+/R"
IF EMPTY(M->FILTRO_2)
   M->FILTRO_2=M->FILTRO_1
ENDIF
SET FILTER TO TRIM(NOME)>=TRIM(M->FILTRO_1) .AND. TRIM(NOME)<=TRIM(M->FILTRO_2)
IF !(TRIM(NOME)>=TRIM(M->FILTRO_1) .AND. TRIM(NOME)<=TRIM(M->FILTRO_2))
    SKIP
ENDIF
pagina=0
nLinha=1
GOTO TOP
do while .t.
   if lastkey()=27
      exit
   endif
   if nLinha=1
      RELEVO(05, 05, 21, 54,.F.,,2) // tela EQUERDA
      RELEVO(06, 06, 08, 53,.F.,,1) // BARRA DE TITULO
      pagina++
      @ 07,08 SAY PADC("RELATORIO SELECIONADO",44) color "bg+/b"
      @ 10,08 say "Nome"                           color "n+/b"
      @ 10,34 say "DDD Telefone"                   color "n+/b"
      @ 11,08 say repl("Ä",44)                     color "n+/b"
      nLINHA=12
   ENDIF
   @ nLINHA,08 SAY PADR(NOME,25) COLOR "W+/B"
   @ nLINHA,34 SAY DDD+" "+FONE  COLOR "W+/B"
   SKIP
   nLinha++
   IF nLINHA>18 .OR. EOF()
      @ nLINHA+1,08 say PADc("- "+ALLTRIM(str(pagina,6))+" -",44) color "N+/b"
      IF EOF()
         INKEY(0)
         EXIT
      ELSE
         INKEY(10)
         nLINHA=1
      ENDIF
   ENDIF
enddo  
SET FILTER TO
RETURN.T.


function REL1_LPT  // relatorio na impressora
pagina=0
nLinha=1
GOTO TOP
SET DEVI TO PRINT
do while .t.
   IF (!isprinter())
      SET DEVI TO SCREEN
      ALERT("* IMPRESSORA ESTA DESLIGADA *")
      RELATORIO()
   ENDIF
   if lastkey()=27
      EXIT
   endif
   if nLinha=1
      pagina++
      @ 00,01 SAY CHR(18)
      @ 01,00 SAY PADC(M->SISTEMA+" v."+M->VERSAO,80) 
      @ 02,00 SAY PADC(M->DONO1,80)
      @ 03,00 SAY PADC("RELATORIO GERAL DE CONTATOS E TELEFONES",80)
      @ 05,00 say "Nome"
      @ 05,34 say "DDD Telefone"
      @ 05,60 SAY PADL(DTOC(DATE())+" "+TIME(),20)
      @ 06,00 say repl("Ä",80)
      nLINHA=07
   ENDIF
   @ nLINHA,00 SAY PADR(NOME,33) COLOR "W+/B"
   @ nLINHA,34 SAY DDD+" "+FONE  COLOR "W+/B"
   SKIP
   nLinha++
   IF nLINHA>54 .OR. EOF()
      @ nLinha+1,00 say padc(M->Autor,80)
      @ nLinha+2,00 say padc(M->EMAIL,80)
      @ nLINHA+4,00 say PADc("- "+ALLTRIM(str(pagina,6))+" -",80)
      IF EOF()
         EXIT
      ELSE
         nLINHA=1
      ENDIF
   ENDIF
enddo
EJECT
SET DEVI TO SCREEN
RETURN.T.

function REL2_LPT  // relatorio na impressora ( SELECIONADO )
SALVACOR=SETCOLOR()
SETCOLOR("Bg+/b,W+/R,,,W+/B")
SELE 2
USE DBFONE INDEX idFONE1.NTX,idFONE2.NTX 
SET ORDER TO 1
M->FILTRO_1=PADR("A",20)
M->FILTRO_2=PADR("Z",20)
RELEVO(05, 05, 21, 54,.F.,,2) // tela EQUERDA
RELEVO(06, 06, 08, 53,.T.,,2) // BARRA DE TITULO
RELEVO(12, 18, 15, 53,.F.,,2) // tela EQUERDA
@ 07,07 SAY PADC("Relatorio Selecionado",45)   color "W+/R"
@ 10,08 SAY PADR("Informe o intervalo dos dados" ,44) color "BG+/B"
@ 11,08 SAY PADR("a serem selecionados:"         ,44) color "BG+/B"

*******************************
@ 13,08 SAY padR("INICIO: ",10)
@ 14,08 SAY padR("FIM: "   ,10) 
@ 13,19 GET M->FILTRO_1
@ 14,19 GET M->FILTRO_2
*******************************
@ 16,08 SAY 'Ex.: Como imprimir todos os "MARCOS"?'  color "N+/B"
@ 17,08 SAY "     INICIO: MARCOS"                    color "N+/B"
@ 18,08 SAY "     FIM   : MARCOS"                    color "N+/B"
SET CURSOR ON
READ
SET CURSOR OFF
IF LASTKEY()=27
   SET FILTER TO
   RETURN
ENDIF
RELEVO(11, 22, 13, 44, .T.,"R+/R")
@ 12,23 SAY PADC("AGUARDE",21) COLOR "W*+/R"
IF EMPTY(M->FILTRO_2)
   M->FILTRO_2=M->FILTRO_1
ENDIF
SET FILTER TO TRIM(NOME)>=TRIM(M->FILTRO_1) .AND. TRIM(NOME)<=TRIM(M->FILTRO_2)
IF !(TRIM(NOME)>=TRIM(M->FILTRO_1) .AND. TRIM(NOME)<=TRIM(M->FILTRO_2))
    SKIP
ENDIF
pagina=0
nLinha=1
GOTO TOP
SET DEVI TO PRINT
do while .t.
   IF (!isprinter())
      SET DEVI TO SCREEN
      ALERT("* IMPRESSORA ESTA DESLIGADA *")
      RELATORIO()
   ENDIF
   if lastkey()=27
      EXIT
   endif
   if nLinha=1
      pagina++
      @ 00,01 SAY CHR(18)
      @ 01,00 SAY PADC(M->SISTEMA+" v."+M->VERSAO,80) 
      @ 02,00 SAY PADC(M->DONO1,80)
      @ 03,00 SAY PADC("RELATORIO SELECIONADO DE CONTATOS E TELEFONES",80)
      @ 03,00 SAY PADC("RELATORIO SELECIONADO DE CONTATOS E TELEFONES",80)
      @ 05,00 say "Nome"
      @ 05,34 say "DDD Telefone"
      @ 05,60 SAY PADL(DTOC(DATE())+" "+TIME(),20)
      @ 06,00 say repl("Ä",80)
      nLINHA=07
   ENDIF
   @ nLINHA,00 SAY PADR(NOME,33) COLOR "W+/B"
   @ nLINHA,34 SAY DDD+" "+FONE  COLOR "W+/B"
   SKIP
   nLinha++
   IF nLINHA>54 .OR. EOF()
      @ nLinha+1,00 say padc(M->Autor,80)
      @ nLinha+2,00 say padc(M->EMAIL,80)
      @ nLINHA+4,00 say PADc("- "+ALLTRIM(str(pagina,6))+" -",80)
      IF EOF()
         EXIT
      ELSE
         nLINHA=1
      ENDIF
   ENDIF
enddo
EJECT
SET DEVI TO SCREEN
RETURN.T.

