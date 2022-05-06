
FUNCTION INCLUSAO
Tone(300,1)
DO WHILE.T.
   SETCOLOR("N+/B,BG+/B,,,BG+/B")
   ENTRADA("MENU DE INCLUSåES")
   relevo(06, 56, 08, 73, .T.) // BOTOES
   *relevo(09, 56, 11, 73, .T.) // BOTOES
   *relevo(12, 56, 14, 73, .T.) // BOTOES
   relevo(18, 56, 20, 73, .T.) // BOTOES     
   @ 07,58 PROMPT padR("1.Contatos   " ,15) MESSAGE PADC('P/ LOCALIZAR REGISTROS RAPIDAMENTE, APERTE "1"',67)
   * 10,58 PROMPT padR("2.Historico  " ,15) MESSAGE PADC('P/ LOCALISAR, ALTERAR E EXCLUIR REGISTROS APERTE "2"',67)
   * 13,58 PROMPT padR("3.Contra-CHK " ,15) MESSAGE PADC('P/ IMPRIMIR RELATORIOS APERTE "3"',67)
   @ 19,58 PROMPT padR("5.Principal  " ,15) MESSAGE PADC('P/ SAIR DO SISTEMA APERTE "5"',67)
   incMENU=1
   MENU TO incMENU
   DO CASE
   CASE incMENU=1
        INC00001() // inclusao de funcionario
   CASE incMENU=2 .OR. LASTKEY()=27
        PRINCIPAL()
   ENDCASE
ENDDO
RETURN.T.

FUNCTION INC00001
Tone(300,1)
IF M->NIVEL>=1
*************
 M->RESPOSTA="N"
 TELA=""
 TELA=SAVESCREEN(00,00,24,80)
 SELE 2
 USE DBFONE INDEX idFONE1,idFONE2
 SELE 2
 SET ORDER TO 1
 DO WHILE.T.
    IF LASTKEY()=27
       EXIT
    ENDIF
    M->Data   :=Date()
    M->vCODIGO:=STRzero(LASTREC(),6)
    M->vENDE  :=SPACE(30)
    M->vNOME  :=SPACE(30)
    M->vDDD   :=SPACE(04)
    M->vFONE  :=SPACE(15)
    M->vOBS1  :=SPACE(30)
    M->vOBS2  :=SPACE(30)
    M->vOBS3  :=SPACE(30)
    SET CURSOR ON
    RELEVO(05, 05, 21, 54,.F.,,2) // tela EQUERDA
    RELEVO(06, 06, 08, 53,.T.,,2) // BARRA DE TITULO
    RELEVO(09, 18, 16, 53,.T.,,1) // tela EQUERDA
    RELEVO(17, 18, 20, 53,.T.,,2) // BARRA DE INFERIOR
    @ 07,07 SAY PADC("FUNCIONARIOS",45)  color "W+/R"
    @ 10,08 SAY padr("Nome:"     ,10)        color "Bg+/b"
    @ 12,08 say padr("Endere‡o:" ,10)        color "Bg+/b"
    @ 14,08 say padr("DDD Fone:" ,10)        color "Bg+/b"
    @ 18,08 say padl("Obs.:"     ,10)        color "Bg+/b"
    **
    @ 10,20 get M->vNOME picture "@!"  color "W+/B,W+/bG"
    @ 12,20 get M->vENDE picture "@!"  color "W+/B,W+/bG"
    @ 14,20 get M->vDDD  picture "@!"  color "W+/B,W+/bG"
    @ 14,26 get M->vFONE picture "@!"  color "W+/B,W+/bG"
    @ 18,20 get M->vOBS1 picture "@!"  color "W+/B,W+/bG"
    @ 19,20 get M->vOBS2 picture "@!"  color "W+/B,W+/bG"
    SET CURSOR ON
    READ
    IF LASTKEY()=27
       EXIT
    ENDIF
    M->RESPOSTA=GRAVAV()
    IF M->RESPOSTA="N"
        LOOP
    ENDIF
    dBfone->(DBAPPEND())
    REPLACE DATA      WITH DATE()
    REPLACE CODIGO    WITH M->vCODIGO
    REPLACE NOME      WITH M->vNOME
    REPLACE ENDERECO  WITH ALLTRIM(M->vENDE)
    REPLACE DDD       WITH STRZERO(VAL(vDDD),4)
    REPLACE FONE      WITH M->vFONE
    REPLACE OBS       WITH DTOC(DATE())+" "+TIME()
    REPLACE OBS       WITH OBS+chr(13)+chr(10)+alltrim(M->vOBS1) 
    REPLACE OBS       WITH OBS+chr(13)+chr(10)+alltrim(M->vOBS2) 
    RELEVO(05, 55, 21, 74,.F.,,2) // tela DIREITA ENTERNA
    RELEVO(09, 56, 20, 73,.T.,,2) // tela DIREITA INTERNA
    @ 07,57 SAY PADc("INCLUSÇO ANTERIOR"                  ,16)  COLOR "W+*/B"
    @ 10,57 say PADr(NOME                                 ,16)  COLOR("W+ /B")
    @ 11,57 say PADr(ENDERECO                             ,16)  COLOR("W+ /B")
    @ 13,57 say PADr(DDD                                  ,16)  COLOR("W+ /B")
    @ 14,57 say PADr(FONE                                 ,16)  COLOR("W+ /B")
 ENDDO
 RESTSCREEN(00,00,24,80,TELA)
 IF M->RESPOSTA="S"
    dBcompacta(16,40)
 ENDIF
*************
ELSE
   ALERT('OPERA€ÇO INTERCEPTADA;;Seu n¡vel de senha n„o permite esta opera‡Æo.;;N¡vel m¡nimo nescess rio: "1"',,"w+/n")
ENDIF
RETURN.T.
