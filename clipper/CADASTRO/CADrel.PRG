FUNCTION RELATORIO
DO WHILE.T.
   SETCOLOR("N+/B,BG+/B,,,BG+/B")
   ENTRADA("MENU DE RELATORIOS")
   relevo(06, 56, 08, 73, .T.) // BOTOES
   relevo(09, 56, 11, 73, .T.) // BOTOES
   relevo(12, 56, 17, 73, .T.) // BOTOES
   relevo(18, 56, 20, 73, .T.) // BOTOES
   @ 07,58 PROMPT padR("1.REGISTROS"  ,15)
   @ 10,58 PROMPT padR("2.Usu rios"  ,15)
   @ 19,58 PROMPT padR("5.Principal" ,15)
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
   ENTRADA("RELATORIO DE REGISTROS")
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
      @ 07,08 SAY PADC("RELATORIO GERAL DE REGISTROS",44) color "bg   /b"
      @ 10,08 say "Nome"
      @ 10,34 say "Telefone"
      @ 11,08 say repl("Ä",44)
      nLINHA=12
   ENDIF
   @ nLINHA,08 SAY PADR(C1NOME,25) COLOR "W+/B"
   @ nLINHA,34 SAY C1FONE  COLOR "W+/B"
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
USE DBCAD INDEX idCAD1.NTX,idCAD2.NTX 
SET ORDER TO 1
M->FILTRO_1=PADR("A",20)
M->FILTRO_2=PADR("Z",20)
RELEVO(05, 05, 21, 54,.F.,,2) // tela EQUERDA
RELEVO(06, 06, 08, 53,.T.,,2) // BARRA DE TITULO
RELEVO(12, 18, 16, 53,.F.,,2) // tela EQUERDA
@ 07,07 SAY PADC("Relatorio Selecionado",45)   color "W+/R"
@ 10,08 SAY PADR("Informe o intervalo dos dados" ,44) color "BG+/B"
@ 11,08 SAY PADR("a serem selecionados:"         ,44) color "BG+/B"

*******************************
@ 13,08 SAY padR("Inicio: ",10)
@ 14,08 SAY padR("Fim:    ",10) 
@ 13,19 GET M->FILTRO_1 PICT "@!"
@ 14,19 GET M->FILTRO_2 PICT "@!"
*******************************
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
SET FILTER TO TRIM(C1NOME)>=TRIM(M->FILTRO_1) .AND. TRIM(C1NOME)<=TRIM(M->FILTRO_2)
IF !(TRIM(C1NOME)>=TRIM(M->FILTRO_1) .AND. TRIM(C1NOME)<=TRIM(M->FILTRO_2))
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
      @ 10,34 say "Fone"                       color "n+/b"
      @ 11,08 say repl("Ä",44)                     color "n+/b"
      nLINHA=12
   ENDIF
   @ nLINHA,08 SAY PADR(c1NOME,25) COLOR "W+/B"
   @ nLINHA,34 SAY c1fone COLOR "W+/B"
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
      @ 03,00 SAY padC("RELATORIO GERAL DE REGISTROS",80)
      @ 04,00 SAY Repl("=",80)
      @ 05,00 say padr("REGISTROF",6)
      @ 05,43 say padl("Fone"     ,10)
      @ 05,00 say Repl("=",80)
      @ 05,60 SAY PADL(DTOC(DATE())+" "+TIME(),20)
      @ 06,00 say repl("Ä",80)
      nLINHA=07
   ENDIF
   @ nLINHA,00 SAY PADR(C1CODIGO+" "+C1NOME,33) COLOR "W+/B"
   @ nLINHA,35 SAY C1FONE  COLOR "W+/B"
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
USE DBCAD INDEX idCAD1.NTX,idCAD2.NTX 
SET ORDER TO 1
M->FILTRO_1=PADR("A",20)
M->FILTRO_2=PADR("Z",20)
RELEVO(05, 05, 21, 54,.F.,,2) // tela EQUERDA
RELEVO(06, 06, 08, 53,.T.,,2) // BARRA DE TITULO
RELEVO(12, 18, 16, 53,.F.,,2) // tela EQUERDA
@ 07,07 SAY PADC("Relatorio Selecionado",45)   color "W+/R"
@ 10,08 SAY PADR("Informe o intervalo dos dados" ,44) color "BG+/B"
@ 11,08 SAY PADR("a serem selecionados:"         ,44) color "BG+/B"
*******************************
@ 13,08 SAY padR("Inicio:",10)
@ 14,08 SAY padR("Fim:   ",10) 
@ 13,19 GET M->FILTRO_1 PICT "@!"
@ 14,19 GET M->FILTRO_2 PICT "@!"
*******************************
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
SET FILTER TO TRIM(C1NOME)>=TRIM(M->FILTRO_1) .AND. TRIM(C1NOME)<=TRIM(M->FILTRO_2)
IF !(TRIM(C1NOME)>=TRIM(M->FILTRO_1) .AND. TRIM(C1NOME)<=TRIM(M->FILTRO_2))
    SKIP
ENDIF
pagina=0
nLinha=1
nTOTAL=0
nREGISTRO=0
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
      @ 03,00 SAY PADC("RELATORIO SELECIONADO DE REGISTROS",80)
      @ 03,00 SAY PADC("RELATORIO SELECIONADO DE REGISTROS",80)
      @ 06,00 say "Nome"
      @ 06,34 say "Telefone"
      @ 06,60 SAY PADL(DTOC(DATE())+" "+TIME(),20)
      @ 07,00 say repl("Ä",80)
      nLINHA=08
   ENDIF
   @ nLINHA,  00 say C1CODIGO
   @ nLINHA,  10 say ALLTRIM(C1NOME)+REPL(".",30-LEN(ALLTRIM(C1NOME)))
   @ nLINHA,  43 say repl("_",36)
   nREGISTRO++
   SKIP
   nLinha++
   IF nLINHA>45 .OR. EOF()
      IF EOF()
         @ nLINHA+01,043 SAY padL("REGISTROS NO ARQUIVO: "+ALLTRIM(STR(RECNO()))      ,36)
         @ nLINHA+02,043 SAY padL("REGISTROS IMPRESSOS:  "+ALLTRIM(STR(nREGISTRO))    ,36)
         @ nLINHA+03,000 SAY "= (FIM) "+REPL("=",71)
         @ nLinha+13,00 say padc(M->Autor,80)
         @ nLinha+14,00 say padc(M->EMAIL,80)
         @ nLINHA+15,00 say PADc("- "+ALLTRIM(str(pagina,6))+" -",80)
         EXIT
      ELSE
         @ nLINHA+01,043 SAY padL("REGISTROS NO ARQUIVO: "+ALLTRIM(STR(RECNO()))      ,36)
         @ nLINHA+02,043 SAY padL("REGISTROS IMPRESSOS:  "+ALLTRIM(STR(nREGISTRO))    ,36)
         @ nLINHA+03,000 SAY "= (CONTINUA) "+REPL("=",77)
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


function RELFICHA  // IMPRIME UMA FICHA ( SELECIONADO NA IMPRESSORA )
RELEVO(11, 22, 13, 44, .T.,"R+/R")
@ 12,23 SAY PADC("AGUARDE",21) COLOR "W*+/R"
pagina=0
nLinha=1
nTOTAL=0
nREGISTRO=0
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
      @ 03,00 SAY PADC("FICHA DE INSCRICAO",80)
      @ 03,00 SAY PADC("FICHA DE INSCRICAO",80)
      @ 03,60 SAY PADL(TIME()+" "+DTOC(DATE()),20)
      @ 05,00 say repl("Ä",80)
      nLINHA=06
   ENDIF
   @ nLINHA,00 say "1.0. "+padr("INFORMACOES PESSOAIS",80);NLINHA=NLINHA+1
   @ nLINHA,00 SAY "1.1. "+padL("DATA"       ,10)+" :"+DTOC(C1DATA); nLINHA=nLINHA+2
   @ nLINHA,00 SAY "1.2. "+padL("NOME"       ,10)+" :"+C1NOME; nLINHA=nLINHA+1             
   @ nLINHA,00 say "1.3. "+padL("R.G."       ,10)+" :"+C1RG; nLINHA=nLINHA+1                          
   @ nLINHA,00 say "1.4. "+padL("C.P.F."     ,10)+" :"+C1CPF; nLINHA=nLINHA+1                          
   @ nLINHA,00 say "1.5. "+padL("C.TRABALHO" ,10)+" :"+ALLTRIM(C1CTRABN)+" SERIE: "+C1CTRABS; nLINHA=nLINHA+1             
   @ nLINHA,00 say "1.6. "+padL("NASCIMENTO" ,10)+" :"+DTOC(C1NASCI); nLINHA=nLINHA+1                         
   @ nLINHA,00 say "1.7. "+padL("ENDERECO"   ,10)+" :"+C1ENDE; nLINHA=nLINHA+1             
   @ nLINHA,00 say "1.8. "+padL("TELEFONE"   ,10)+" :"+C1FONE; nLINHA=nLINHA+1             
   @ nLINHA,00 say "1.9. "+padL("OBSERVACAO ",10)+" :1a."+padR(MEMOLINE(c1OBS,59,1),60); nLINHA=nLINHA+1             
   @ nLINHA,00 say "     "+padL("           ",10)+" :2a."+padR(MEMOLINE(c1OBS,59,2),60); nLINHA=nLINHA+1             
   @ nLINHA,00 say "     "+padL("           ",10)+" :3a."+padR(MEMOLINE(c1OBS,59,3),60); nLINHA=nLINHA+1             
   @ nLINHA,00 say "     "+padL("           ",10)+" :4a."+padR(MEMOLINE(c1OBS,59,4),50); nLINHA=nLINHA+2             
   @ nLINHA,00 SAY "2.0. "+padr("INFORMACOES DO ULTIMO TRABALHO",80); nLINHA=nLINHA+2             
   @ nLINHA,00 SAY "2.1. "+padL("EMPRESA"   ,10)+" :"+C2EMPRESA; nLINHA=nLINHA+1                          
   @ nLINHA,00 SAY "2.2. "+padL("ENDERECO"  ,10)+" :"+C2ENDE; nLINHA=nLINHA+1                          
   @ nLINHA,00 SAY "2.3. "+padL("FONE"      ,10)+" :"+C2FONE; nLINHA=nLINHA+1                          
   @ nLINHA,00 SAY "2.4. "+padL("CARGO"     ,10)+" :"+C2CARGO;nLINHA=nLINHA+1 
   @ nLINHA,00 SAY "2.5. "+padL("SALARIO"   ,10)+" :"+" R$"+ALLTRIM(STR(C2SALARIO,15,2)); nLINHA=nLINHA+1             
   @ nLINHA,00 SAY "2.6. "+padL("ADMISSAO"  ,10)+" :"+DTOC(C2ADMISAO); nLINHA=nLINHA+1                          
   @ nLINHA,00 SAY "2.7. "+padL("DEMISSAO"  ,10)+" :"+DTOC(C2DEMISAO); nLINHA=nLINHA+1                                       
   @ nLINHA,00 SAY "2.8. "+padL("MOTIVO"    ,10)+" :"+C2MOTIVO; nLINHA=nLINHA+2
   @ nLINHA,00 SAY "2.9. "+padr("REDIJA, NAS LINHAS ABAIXO, UMA PEQUENA TEXTO, JUSTIFICANDO",70); nLINHA=nLINHA+1             
   @ nLINHA,00 SAY "     "+padr("SUA SOLICITACAO DE TRABALHO NESTA EMPRESA.",70); nLINHA=nLINHA+2             
   @ nLINHA,00 SAY "     "+REPL(".",40); nLINHA=nLINHA+1             
   @ nLINHA,00 SAY "     "+REPL(".",40); nLINHA=nLINHA+1             
   @ nLINHA,00 SAY "     "+REPL(".",40); nLINHA=nLINHA+1             
   @ nLINHA,00 SAY "     "+REPL(".",40); nLINHA=nLINHA+1             
   @ nLINHA,00 SAY "     "+REPL(".",40); nLINHA=nLINHA+1             
   @ nLINHA,00 SAY "3.0. "+PADR("DECLARACAO",40); nLINHA=nLINHA+2             
   @ nLINHA,00 SAY "     "+PADR("Declaro sob todas as penas previstas em LEI que,",70); nLINHA=nLINHA+1             
   @ nLINHA,00 SAY "     "+PADR("as informacoes aqui contidas, informadas pela minha pessoa,",70); nLINHA=nLINHA+1
   @ nLINHA,00 SAY "     "+PADR("sao verdadeiras.",70); nLINHA=nLINHA+2
   @ nLINHA,00 SAY "     "+PADR(data(),70); nLINHA=nLINHA+2
   @ nLINHA,00 SAY PADr(REPL("_",45)   ,80); nLINHA=nLINHA+1             
   @ nLINHA,00 SAY PADr(C1NOME,80); nLINHA=nLINHA+1                
   @ 56,00 SAY "Ä (FIM) "+REPL("Ä",71); nLINHA=nLINHA+2             
   @ 57,00 say padc(M->Autor,80)
   @ 58,00 say padc(M->EMAIL,80)
   EXIT
enddo
EJECT
SET DEVI TO SCREEN
ALERT("CONCLUIDO O ENVIO DE DADOS PARA A IMPRESSORA,,") 
RETURN.T.


