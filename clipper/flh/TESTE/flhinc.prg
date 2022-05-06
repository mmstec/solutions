
FUNCTION INCLUSAO
Tone(300,1)
DO WHILE.T.
   SETCOLOR("N+/B,BG+/B,,,BG+/B")
   ENTRADA("MENU DE INCLUSåES")
   relevo(06, 56, 08, 73, .T.) // BOTOES
   relevo(09, 56, 11, 73, .T.) // BOTOES
   relevo(12, 56, 17, 73, .T.) // BOTOES
   relevo(18, 56, 20, 73, .T.) // BOTOES
   @ 07,58 PROMPT padr("1.Admissao " ,15)
   @ 10,58 PROMPT padr("2.Demissao " ,15)
   @ 19,58 PROMPT padr("5.Retorna  " ,15)
   incMENU=1
   MENU TO incMENU
   DO CASE
   CASE incMENU=1
        INCflh()
   CASE incMENU=2
        *DEMflh()
        alert("DEMISSAO AINDA NAO DISPONIVEL") 
   CASE incMENU=3 .OR. LASTKEY()=27
        PRINCIPAL()
   ENDCASE
ENDDO
RETURN.T.

FUNCTION INCflh
AREA=SELECT()
Tone(300,1)
IF M->NIVEL>=1
*************
 M->RESPOSTA="N"
 TELA=""
 TELA=SAVESCREEN(00,00,24,80)
 SELE 2
 USE DBflh INDEX idflh1,idflh2
 SELE 2
 SET ORDER TO 1
 DO WHILE.T.
    IF LASTKEY()=27
       EXIT
    ENDIF
    M->vGRUPO :=SPACE(10)
    M->vCODIGO:=STRzero(LASTREC(),6)
    M->vALCUNHA  :=SPACE(30)
    M->vNOME  :=SPACE(30)
    M->vCargo :=SPACE(15)
    M->vRG    :=SPACE(15)
    M->vCPF   :=SPACE(15)
    M->vCTN   :=SPACE(10)
    M->vCTS   :=SPACE(05)
    M->vNASCI :=CTOD("")
    M->vENDE  :=SPACE(30)
    M->vDDD   :=SPACE(04)
    M->vFONE  :=SPACE(15)
    M->vSQTDE :=0
    M->vSBASE :=0
    M->vSPROD :=0
    M->vSGRAT :=0
    M->vSOUTR :=0
    M->vData  :=CTOD("")
    M->vadmis :=CTOD("")
    M->vdemis :=CTOD("")
    SET CURSOR ON 
    RELEVO(05, 05, 21, 54,.F.,,2) // tela EQUERDA
    RELEVO(06, 06, 08, 53,.T.,,2) // BARRA DE TITULO
    RELEVO(09, 18, 20, 53,.T.,,1) // tela EQUERDA
    *RELEVO(17, 19, 20, 53,.T.,,2) // BARRA DE INFERIOR
    @ 07,07 SAY PADC("MODULO DE INCLUSOES",45)  color "W+/R"
    @ 10,08 SAY padL("Grupo:"    ,10)        color "Bg+/b"
    @ 11,08 SAY padL("Alcunha:"  ,10)        color "Bg+/b"
    @ 12,08 SAY padL("Nome:"     ,10)                     color "Bg+/b"
    @ 13,08 say padL("R. Geral:" ,10)                     color "Bg+/b"
    @ 14,08 say padL("CPF.:"     ,10)                     color "Bg+/b"
    @ 15,08 say padL("C.Prof.:"  ,10)                     color "Bg+/b"
    @ 15,32 say padL("Serie:"    ,06)                     color "Bg+/b"
    @ 16,08 say padL("Nascimento:",10)                     color "Bg+/b"
    @ 17,08 say padL("Admiss„o:"  ,10)                     color "Bg+/b"
    @ 18,08 say padL("CARGO:"     ,10)                     color "Bg+/b"
    ***
    @ 10,20 get M->vGRUPO VALID !EMPTY(M->vGRUPO) picture "@!"  color "W+/B,W+/bG"
    @ 11,20 get M->vALCUNHA VALID !EMPTY(M->vALCUNHA) picture "@!"  color "W+/B,W+/bG"
    @ 12,20 get M->vNOME  VALID !EMPTY(M->vNOME) picture "@!"  color "W+/B,W+/bG"
    @ 13,20 get M->vRG    picture "@!"  color "W+/B,W+/bG"
    @ 14,20 get M->vCPF   picture "@!"  color "W+/B,W+/bG"
    @ 15,20 get M->vCTN   picture "@!"  color "W+/B,W+/bG"
    @ 15,38 get M->vCTS   picture "@!"  color "W+/B,W+/bG"
    @ 16,20 get M->vNASCI picture "@!"  color "W+/B,W+/bG"
    @ 17,20 get M->vAdmis picture "@!"  color "W+/B,W+/bG"
    @ 18,20 get M->vCargo picture "@!"  color "W+/B,W+/bG"
    ***
    READ
    TONE(500)
    RELEVO(05, 05, 21, 54,.F.,,2) // tela EQUERDA
    RELEVO(06, 06, 08, 53,.T.,,2) // BARRA DE TITULO
    RELEVO(09, 18, 19, 53,.T.,,1) // tela EQUERDA
    @ 07,07 SAY PADC("MODULO DE INCLUSåES",45)  color "W+ /R"
    @ 10,08 SAY padL("Grupo:"    ,10)                     color "Bg+/b"
    @ 11,08 SAY padL("Nome:"     ,10)                     color "Bg+/b"
    @ 12,08 say padL("Endere‡o:" ,10)                     color "Bg+/b"
    @ 13,08 say padL("Fone:"     ,10)                     color "Bg+/b"
    @ 14,08 say padL("SAL QTD:"  ,10)                     color "Bg+/b"
    @ 15,08 say padL("SAL BASE:" ,10)                     color "Bg+/b"
    @ 16,08 say padL("PROD.:"    ,10)                     color "Bg+/b"
    @ 17,08 say padL("GRAT.:"    ,10)                     color "Bg+/b"
    @ 18,08 say padL("OUTROS:"   ,10)                     color "Bg+/b"
    ***
    @ 10,20 SAY M->vGRUPO picture "@!"  color "W+/B,W+/bG"
    @ 11,20 SAY M->vNOME  picture "@!"  color "W+/B,W+/bG"
    @ 12,20 get M->vENDE  picture "@!"  color "W+/B,W+/bG"
    @ 13,20 get M->vFONE  picture "@!"  color "W+/B,W+/bG"
    @ 14,20 get M->vSQTDE VALID !EMPTY(M->vSQTDE) picture "@Z 999.9" color "W+/B,W+/bG"
    READ
    M->vSBASE=M->SALARIO_ATUAL*M->vSQTDE
    @ 15,20 GET M->vSBASE picture "@Z 99,999.99" color "W+/B,W+/bG"
    @ 16,20 GET M->vSPROD picture "@Z 99,999.99" color "W+/B,W+/bG"
    @ 17,20 GET M->vSGRAT picture "@Z 99,999.99" color "W+/B,W+/bG"
    @ 18,20 GET M->vSOUTR picture "@Z 99,999.99" color "W+/B,W+/bG"
    ***
    READ
    TOTALSALARIO=M->vSBASE+M->vSPROD+M->vSGRAT+M->vSOUTR
    @ 20,20 SAY "SALARIO MENSAL:  "+ALLTRIM(STR(TOTALSALARIO))   color "BG +/B"
    TONE(500)
    TONE(600)
    TONE(300)
    IF LASTKEY()=27
       EXIT
    ENDIF
    M->RESPOSTA=GRAVAV()
    IF M->RESPOSTA="N"
        LOOP
    ENDIF
    dBflh->(DBAPPEND())
    REPLACE GRUPO      WITH M->vGRUPO 
    REPLACE CODIGO     WITH M->vCODIGO
    REPLACE ALCUNHA    WITH M->vALCUNHA
    REPLACE NOME       WITH M->vNOME
    REPLACE RG         WITH M->vRG
    REPLACE CPF        WITH M->vCPF
    REPLACE CTRABALHON WITH M->vCTN
    REPLACE CTRABALHOS WITH M->vCTS
    REPLACE NASCIMENTO WITH M->vNASCI
    REPLACE ENDERECO   WITH M->vENDE
    REPLACE FONE       WITH M->vFONE
    REPLACE SALARIOQ   WITH M->vSQTDE 
    REPLACE SALARIOB   WITH M->vSBASE
    REPLACE SALARIOP   WITH M->vSPROD 
    REPLACE SALARIOG   WITH M->vSGRAT 
    REPLACE SALARIOX   WITH M->vSOUTR 
    REPLACE DATA       WITH M->vData  :=CTOD("")
    RELEVO(05, 55, 21, 74,.F.,,2) // tela DIREITA ENTERNA
    RELEVO(09, 56, 20, 73,.T.,,2) // tela DIREITA INTERNA
    @ 07,57 SAY PADc("INCLUSÇO ANTERIOR"                  ,16)  COLOR "W+*/B"
    @ 10,57 say PADr(ALLTRIM(GRUPO)                       ,16)  COLOR("W+ /B")
    @ 11,57 say PADr(ALLTRIM(NOME)                                ,16)  COLOR("W+ /B")
    @ 12,57 say PADr(ALLTRIM(ENDERECO)                            ,16)  COLOR("W+ /B")
    @ 13,57 say PADr(ALLTRIM(RG)                                  ,16)  COLOR("W+ /B")
    @ 14,57 say PADr(ALLTRIM(CPF)                                 ,16)  COLOR("W+ /B")
    @ 15,57 say PADr(ALLTRIM(CTRABALHON)+"-"+ALLTRIM(CTRABALHOS)  ,16)  COLOR("W+ /B")
    
 ENDDO
 RESTSCREEN(00,00,24,80,TELA)
 IF M->RESPOSTA="S"
    dBcompacta(16,40)
 ENDIF
*************
ELSE
   ALERT('OPERA€ÇO INTERCEPTADA;;Seu n¡vel de senha n„o permite esta opera‡Æo.;;N¡vel m¡nimo nescess rio: "1"',,"w+/n")
ENDIF
SELECT(AREA)
RETURN.T.

FUNCTION INCSAL
AREA=SELECT()
Tone(300,1)
IF M->NIVEL>=1
*************
 M->RESPOSTA="N"
 TELA=""
 TELA=SAVESCREEN(00,00,24,80)
 SELE 3
 USE DBSAL INDEX idSAL1,idSAL2
 SELE 3
 SET ORDER TO 1
 DO WHILE.T.
    IF LASTKEY()=27
       EXIT
    ENDIF
    M->vDATA    :=DATE()
    M->vSALARIO :=0
    SET CURSOR ON 
    RELEVO(05, 05, 21, 54,.F.,,2) // tela EQUERDA
    RELEVO(06, 06, 08, 53,.T.,,2) // BARRA DE TITULO
    RELEVO(09, 18, 20, 53,.T.,,1) // tela EQUERDA
    @ 07,07 SAY PADC("MODULO DE INCLUSOES",45)  color "W+/R"
    @ 10,08 SAY padL("DATA:"    ,10)        color "Bg+/b"
    @ 11,08 SAY padL("SALARIO:"  ,10)        color "Bg+/b"
    ***
    @ 10,20 get M->vDATA VALID !EMPTY(M->vDATA)  color "W+/B,W+/bG"
    @ 11,20 get M->vSALARIO VALID !EMPTY(M->vSALARIO) PICT "9,999,999.99" color "W+/B,W+/bG"
    ***
    READ
    TONE(500)
    IF LASTKEY()=27
       EXIT
    ENDIF
    M->RESPOSTA=GRAVAV()
    IF M->RESPOSTA="N"
        LOOP
    ENDIF
    dBSAL->(DBAPPEND())
    REPLACE SDATA    WITH M->vData  
    REPLACE SMINIMO  WITH M->vSALARIO
    M->SALARIO_ATUAL=M->vSALARIO
    EXIT
 ENDDO
 RESTSCREEN(00,00,24,80,TELA)
 IF M->RESPOSTA="S"
    dBcompacta(16,40)
 ENDIF
*************
ELSE
   ALERT('OPERA€ÇO INTERCEPTADA;;Seu n¡vel de senha n„o permite esta opera‡Æo.;;N¡vel m¡nimo nescess rio: "1"',,"w+/n")
ENDIF
SELECT(AREA)
RETURN.T.

