FUNCTION RELATORIO
DO WHILE.T.
   SETCOLOR("N+/B,BG+/B,,,BG+/B")
   ENTRADA("MENU DE RELATORIOS")
   relevo(06, 56, 08, 73, .T.) // BOTOES
   relevo(09, 56, 11, 73, .T.) // BOTOES
   relevo(12, 56, 17, 73, .T.) // BOTOES
   relevo(18, 56, 20, 73, .T.) // BOTOES
   @ 07,58 PROMPT padR("1.Funcionarios"  ,15)
   @ 10,58 PROMPT padR("2.Usu rios"      ,15)
   @ 19,58 PROMPT padR("5.Principal"     ,15)
   RELMENU=1
   MENU TO RELMENU
   DO CASE
   CASE RELMENU=1 
        RELCONTATOS()
   CASE RELMENU=2
        tone(500)
        ALERT("Opera‡„o n„o permitida")
   CASE RELMENU=3 .OR. LASTKEY()=27
        PRINCIPAL()
   ENDCASE
ENDDO
RETURN.T.

FUNCTION RELCONTATOS
DO WHILE.T.
   SETCOLOR("N+/B,BG+/B,,,BG+/B")
   ENTRADA("RELATORIO DE FUNCIONARIOS")
   relevo(06, 56, 08, 73, .T.) // BOTOES
   relevo(09, 56, 11, 73, .T.) // BOTOES
   relevo(12, 56, 14, 73, .T.) // BOTOES
   relevo(15, 56, 17, 73, .T.) // BOTOES
   relevo(18, 56, 20, 73, .T.) // BOTOES
   @ 07,58 PROMPT padr("1.Geral"         ,15) MESSAGE PADC('APERTE "1" P/ RELATORIO DE TODOS OS REGISTROS'           ,67)
   @ 10,58 PROMPT padr("2.Selecionar"    ,15) MESSAGE PADC('APERTE "2" P/ RELATORIO DE REGISTROS SELECIONADOS'       ,67)
   @ 13,58 PROMPT padr("3.Folha"         ,15) MESSAGE PADC('APERTE "3" P/ RELATORIO DA FOLHA DE PAGAMENTOS'          ,67)
   @ 19,58 PROMPT padr("5.Retornar"      ,15) MESSAGE PADC('APERTE "5" OU "ESC" P/ RETORNAR AO MENU PRINCIPAL APERTE',67)      
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
   CASE RELESCOLHA=3
        FOLHA_PAG()
   CASE RELESCOLHA=4 .OR. LASTKEY()=27
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
      @ 07,08 SAY PADC("RELATORIO GERAL FUNCIONARIOS",44) color "bg   /b"
      @ 10,08 say "Nome"
      @ 10,34 say "Telefone"
      @ 11,08 say repl("Ä",44)
      nLINHA=12
   ENDIF
   @ nLINHA,08 say ALLTRIM(NOME)+REPL(".",30-LEN(ALLTRIM(NOME))) COLOR "W+/B"
   @ nLINHA,34 SAY " "+FONE  COLOR "W+/B"
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
USE DBFLH INDEX idFLH1.NTX,idFLH2.NTX 
SET ORDER TO 1
M->FILTRO_1=PADR("A",20)
M->FILTRO_2=PADR("Z",20)
M->FILTRO_3=PADR("BMC",20)
M->FILTRO_4=CTOD("  /  /    ")
RELEVO(05, 05, 21, 54,.F.,,2) // tela EQUERDA
RELEVO(06, 06, 08, 53,.T.,,2) // BARRA DE TITULO
RELEVO(12, 18, 16, 53,.F.,,2) // tela EQUERDA
@ 07,07 SAY PADC("Relatorio Selecionado",45)   color "W+/R"
@ 10,08 SAY PADR("Informe o intervalo dos dados" ,44) color "BG+/B"
@ 11,08 SAY PADR("a serem selecionados:"         ,44) color "BG+/B"

*******************************
@ 13,08 SAY padR("Inicio: ",10)
@ 14,08 SAY padR("Fim:    ",10) 
@ 15,08 SAY padR("Grupo:  ",10) 
@ 13,19 GET M->FILTRO_1 PICT "@!"
@ 14,19 GET M->FILTRO_2 PICT "@!"
@ 15,19 GET M->FILTRO_3 PICT "@!"
*******************************
SET CURSOR ON
READ
SET CURSOR OFF
IF LASTKEY()=27
   SET FILTER TO
   RETURN
ENDIF
RELEVO(10, 06, 13, 53, .T.,"R+/R")
@ 11,07 SAY PADC("ENVIANDO INFORMACOES PARA O MONITOR",46) COLOR "W+/R"
@ 12,07 SAY PADC("AGUARDE",46) COLOR "W*+/R"
TONE(1000)
IF EMPTY(M->FILTRO_2)
   M->FILTRO_2=M->FILTRO_1
ENDIF
SET FILTER TO TRIM(NOME)>=TRIM(M->FILTRO_1) .AND. TRIM(NOME)<=TRIM(M->FILTRO_2) .AND. TRIM(GRUPO)=TRIM(M->FILTRO_3) .AND. DTOC(DEMISAO)=DTOC(M->FILTRO_4)
IF !(TRIM(NOME)>=TRIM(M->FILTRO_1) .AND. TRIM(NOME)<=TRIM(M->FILTRO_2) .AND. TRIM(GRUPO)=TRIM(M->FILTRO_3) .AND. DTOC(DEMISAO)=DTOC(M->FILTRO_4))
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
      @ 10,34 say "Admissao"                       color "n+/b"
      @ 11,08 say repl("Ä",44)                     color "n+/b"
      nLINHA=12
   ENDIF
   @ nLINHA,08 say ALLTRIM(NOME)+REPL(".",30-LEN(ALLTRIM(NOME))) COLOR "W+/B"
   @ nLINHA,34 SAY " "+dtoc(admisao)+" "+padr(dtoc(demisao),5) COLOR "W+/B"
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
      @ 01,00 SAY padC(M->SISTEMA+" v."+M->VERSAO,80) 
      @ 02,00 SAY padC(M->DONO1,80)
      @ 03,00 SAY padC("RELATORIO GERAL DE FUNCIONARIOS",80)
      @ 04,00 SAY Repl("=",80)
      @ 05,00 say padr("Funcionario",6)
      @ 05,43 say padl("Fone"     ,10)
      @ 05,00 say Repl("=",80)
      @ 05,60 SAY PADL(DTOC(DATE())+" "+TIME(),20)
      @ 06,00 say repl("Ä",80)
      nLINHA=07
   ENDIF
   @ nLINHA,00 say ALLTRIM(NOME)+REPL(".",30-LEN(ALLTRIM(NOME))) COLOR "W+/B"
   @ nLINHA,35 SAY " "+FONE  COLOR "W+/B"
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

function REL2_LPT  // relatorio na impressora
SALVACOR=SETCOLOR()
SETCOLOR("Bg+/b,W+/R,,,W+/B")
SELE 2
USE DBFLH INDEX idFLH1.NTX,idFLH2.NTX 
SET ORDER TO 1
M->FILTRO_1=PADR("A",20)
M->FILTRO_2=PADR("Z",20)
M->FILTRO_3=PADR("BMC",20)
M->FILTRO_4=CTOD("  /  /    ")
RELEVO(05, 05, 21, 54,.F.,,2) // tela EQUERDA
RELEVO(06, 06, 08, 53,.T.,,2) // BARRA DE TITULO
RELEVO(12, 18, 16, 53,.F.,,2) // tela EQUERDA
@ 07,07 SAY PADC("Relatorio Selecionado",45)   color "W+/R"
@ 10,08 SAY PADR("Informe o intervalo dos dados" ,44) color "BG+/B"
@ 11,08 SAY PADR("a serem selecionados:"         ,44) color "BG+/B"
*******************************
@ 13,08 SAY padR("Inicio:",10)
@ 14,08 SAY padR("Fim:   ",10) 
@ 15,08 SAY padR("Grupo: ",10) 
@ 13,19 GET M->FILTRO_1 PICT "@!"
@ 14,19 GET M->FILTRO_2 PICT "@!"
@ 15,19 GET M->FILTRO_3 PICT "@!"
*******************************
SET CURSOR ON
READ
SET CURSOR OFF
IF LASTKEY()=27
   SET FILTER TO
   RETURN
ENDIF
RELEVO(10, 06, 13, 53, .T.,"R+/R")
@ 11,07 SAY PADC("ENVIANDO INFORMACOES A IMPRESSORA",46) COLOR "W+/R"
@ 12,07 SAY PADC("AGUARDE",46) COLOR "W*+/R"
TONE(1000)
IF EMPTY(M->FILTRO_2)
   M->FILTRO_2=M->FILTRO_1
ENDIF
SET FILTER TO TRIM(NOME)>=TRIM(M->FILTRO_1) .AND. TRIM(NOME)<=TRIM(M->FILTRO_2) .AND. TRIM(GRUPO)=TRIM(M->FILTRO_3) .AND. DTOC(DEMISAO)=DTOC(M->FILTRO_4)
IF !(TRIM(NOME)>=TRIM(M->FILTRO_1) .AND. TRIM(NOME)<=TRIM(M->FILTRO_2) .AND. TRIM(GRUPO)=TRIM(M->FILTRO_3) .AND. DTOC(DEMISAO)=DTOC(M->FILTRO_4))
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
      @ 01,00 SAY padC(M->SISTEMA+" v."+M->VERSAO,80) 
      @ 02,00 SAY padC(M->DONO1,80)
      @ 03,00 SAY padC("RELATORIO SELECIONADO DE FUNCIONARIOS",80)
      @ 04,00 SAY Repl("=",80)
      @ 05,00 say padr("Funcionario",6)
      @ 05,43 say padl("Fone"     ,10)
      @ 05,60 SAY PADL(DTOC(DATE())+" "+TIME(),20)
      @ 06,00 say Repl("=",80)
      nLINHA=07
   ENDIF
   @ nLINHA,00 SAY PADR(NOME,33) COLOR "W+/B"
   @ nLINHA,34 SAY FONE  COLOR "W+/B"
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

function FOLHA_PAG  // relatorio na impressora ( SELECIONADO )
SALVACOR=SETCOLOR()
SETCOLOR("Bg+/b,W+/R,,,W+/B")
SELE 2
USE DBFLH INDEX idFLH1.NTX,idFLH2.NTX 
SET ORDER TO 1
M->FILTRO_1=PADR("A",20)
M->FILTRO_2=PADR("Z",20)
M->FILTRO_3=PADR("BMC",20)
M->FILTRO_4=CTOD("  /  /    ")
RELEVO(05, 05, 21, 54,.F.,,2) // tela EQUERDA
RELEVO(06, 06, 08, 53,.T.,,2) // BARRA DE TITULO
RELEVO(12, 18, 16, 53,.F.,,2) // tela EQUERDA
@ 07,07 SAY PADC("Relatorio Selecionado",45)   color "W+/R"
@ 10,08 SAY PADR("Informe o intervalo dos dados" ,44) color "BG+/B"
@ 11,08 SAY PADR("a serem selecionados:"         ,44) color "BG+/B"
*******************************
@ 13,08 SAY padR("Inicio:",10)
@ 14,08 SAY padR("Fim:   ",10) 
@ 15,08 SAY padR("Grupo: ",10) 
@ 13,19 GET M->FILTRO_1 PICT "@!"
@ 14,19 GET M->FILTRO_2 PICT "@!"
@ 15,19 GET M->FILTRO_3 PICT "@!"
*******************************
SET CURSOR ON
READ
SET CURSOR OFF
IF LASTKEY()=27
   SET FILTER TO
   RETURN
ENDIF
RELEVO(10, 06, 13, 53, .T.,"R+/R")
@ 11,07 SAY PADC("ENVIANDO INFORMACOES A IMPRESSORA",46) COLOR "W+/R"
@ 12,07 SAY PADC("AGUARDE",46) COLOR "W*+/R"
TONE(1000)
IF EMPTY(M->FILTRO_2)
   M->FILTRO_2=M->FILTRO_1
ENDIF
SET FILTER TO TRIM(NOME)>=TRIM(M->FILTRO_1) .AND. TRIM(NOME)<=TRIM(M->FILTRO_2) .AND. TRIM(GRUPO)=TRIM(M->FILTRO_3) .AND. DTOC(DEMISAO)=DTOC(M->FILTRO_4)
IF !(TRIM(NOME)>=TRIM(M->FILTRO_1) .AND. TRIM(NOME)<=TRIM(M->FILTRO_2) .AND. TRIM(GRUPO)=TRIM(M->FILTRO_3) .AND. DTOC(DEMISAO)=DTOC(M->FILTRO_4))
    SKIP
ENDIF
pagina=0
nLinha=1
nTOTAL=0
nREGISTRO=1
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
      @ 03,00 SAY PADC("FOLHA DE PAGAMENTOS "+DTOC(DATE())+" "+substr(TIME(),1,5),80)
      @ 03,00 SAY PADC("FOLHA DE PAGAMENTOS "+DTOC(DATE())+" "+substr(TIME(),1,5),80)
      @ 05,00 say "GRUPO: ("+ALLTRIM(FILTRO_3)+")"
      @ 06,00 say "No Codigo"
      @ 06,11 say "Nome"
      @ 06,43 say "Valor pago"
      @ 06,54 say "Assinatura"
      @ 07,00 say repl("Ä",80)
      nLINHA=08
   ENDIF
   @ nLINHA,  00 say str(nREGISTRO,2)+" "+CODIGO
   @ nLINHA,  11 say ALLTRIM(NOME)+REPL(".",30-LEN(ALLTRIM(NOME)))
   @ nLINHA,  43 say "_______,__"
   @ nLINHA,  54 say repl("_",25)
   nREGISTRO++
   nTOTAL=nTOTAL+(SALARIOb+SALARIOg+SALARIOp+SALARIOx)
   SKIP
   nLinha++
   IF nLINHA>45 .OR. EOF()
      IF EOF()
         @ nLINHA+01,000 SAY "PREVISAO SEMANA:"+str(nTOTAL/4,10,2)
         @ nLINHA+01,030 SAY PADL("Total: ",10)
         @ nLINHA+01,043 SAY "_______,__"
         @ nLINHA+02,000 SAY "PREVISAO MES   :"+str(nTOTAL,10,2)
         @ nLINHA+03,040 SAY PADR(ALLTRIM(STR(RECNO()))    ,3)+"FUNCIONARIOS ARQUIVADOS."
         @ nLINHA+04,040 SAY PADR(ALLTRIM(STR(nREGISTRO-1)),3)+"FUNCIONARIOS DO GRUPO ("+ALLTRIM(FILTRO_3)+")"
         @ nLINHA+06,000 SAY "= (FIM) "+REPL("=",71)
         @ nLINHA+08,000 SAY PADC("Por minha assinatura escrita a direita do meu nome neste documento,",80)
         @ nLINHA+09,000 SAY PADC("declaro para os devidos fins e a quem possa interessar que recebi a",80) 
         @ nLINHA+10,000 SAY PADC("quantia referida em moeda corrente.",80) 
         @ nLinha+13,00 say padc(M->Autor,80)
         @ nLinha+14,00 say padc(M->EMAIL,80)
         @ nLINHA+15,00 say PADc("- "+ALLTRIM(str(pagina,6))+" -",80)
         EXIT
      ELSE
         @ nLINHA+01,040 SAY PADR(ALLTRIM(STR(RECNO()))    ,3)+"FUNCIONARIOS ARQUIVADOS."
         @ nLINHA+02,040 SAY PADR(ALLTRIM(STR(nREGISTRO-1)),3)+"FUNCIONARIOS DO GRUPO ("+ALLTRIM(FILTRO_3)+")"
         @ nLINHA+04,000 SAY "= (CONTINUA) "+REPL("=",77)
         @ nLINHA+06,000 SAY PADC("Por minha assinatura escrita a direita do meu nome neste documento,",80)
         @ nLINHA+07,000 SAY PADC("declaro para os devidos fins e a quem possa interessar que recebi a",80) 
         @ nLINHA+08,000 SAY PADC("quantia referida em moeda corrente.",80) 
         @ nLinha+13,00 say padc(M->Autor,80)
         @ nLinha+14,00 say padc(M->EMAIL,80)
         @ nLINHA+15,00 say PADc("- "+ALLTRIM(str(pagina,6))+" -",80)
         nLINHA=1
      ENDIF
   ENDIF
enddo
EJECT
SET DEVI TO SCREEN
RETURN.T.

