
* TITULO     :  MFB Materiais de Construcao Ltda ( MMStec - Orcamento )
* DATA       : 06/03/97
* PROGRAMA   : UTILFUN.PRG
* COMENTARIO : FUNCOES

**
** Bloco de inseráÑo FUN.B01
**
FUNCTION T_DIR
KEYBOARD CHR(27)
@ 00,75 SAY CHR(16)+CHR(16) COLOR("R*+/"+ALLTRIM(SUBS(CONTECOR[13],4)))
@ 00,72 SAY CHR(17)+CHR(17) COLOR("N+/"+ALLTRIM(SUBS(CONTECOR[13],4)))
BUFFER=CHR(4)+CHR(13)



FUNCTION T_ESQ
@ 00,75 SAY CHR(16)+CHR(16) COLOR("N+/"+ALLTRIM(SUBS(CONTECOR[13],4)))
@ 00,72 SAY CHR(17)+CHR(17) COLOR("R+*/"+ALLTRIM(SUBS(CONTECOR[13],4)))
KEYBOARD CHR(27)
BUFFER=CHR(19)+CHR(13)
 
FUNCTION INDICES
IF .NOT. FILE("PRECO001.NTX") .OR. PCOUNT()<>0
   IF .NOT. USEREDE("PRECO",.T.,10)
      @ 0,0 SAY ""
      BEEP()
      MENSAGEM("NÑo foi poss°vel acesso ao arquivo",5)
      SET COLOR TO W
      SET CURSOR OFF
      CLEAR
      QUIT
   ENDIF
   MENSAGEM("Organizando o arquivo PRECO001.NTX")
   INDEX ON IDENTIFIC TO PRECO001
ENDIF
IF .NOT. FILE("LISTA002.NTX") .OR. PCOUNT()<>0
   IF .NOT. USEREDE("LISTA",.T.,10)
      @ 0,0 SAY ""
      BEEP()
      MENSAGEM("NÑo foi poss°vel acesso ao arquivo",5)
      SET COLOR TO W
      SET CURSOR OFF
      CLEAR
      QUIT
   ENDIF
   MENSAGEM("Organizando o arquivo LISTA002.NTX")
   INDEX ON DESCRICAO TO LISTA002
ENDIF
IF .NOT. FILE("LISTA003.NTX") .OR. PCOUNT()<>0
   IF .NOT. USEREDE("LISTA",.T.,10)
      @ 0,0 SAY ""
      BEEP()
      MENSAGEM("NÑo foi poss°vel acesso ao arquivo",5)
      SET COLOR TO W
      SET CURSOR OFF
      CLEAR
      QUIT
   ENDIF
   MENSAGEM("Organizando o arquivo LISTA003.NTX")
   INDEX ON DTOS(DATA)+DTOS(DATA)+DESCRICAO TO LISTA003
ENDIF
IF .NOT. FILE("HEPPY004.NTX") .OR. PCOUNT()<>0
   IF .NOT. USEREDE("HEPPYDAY",.T.,10)
      @ 0,0 SAY ""
      BEEP()
      MENSAGEM("NÑo foi poss°vel acesso ao arquivo",5)
      SET COLOR TO W
      SET CURSOR OFF
      CLEAR
      QUIT
   ENDIF
   MENSAGEM("Organizando o arquivo HEPPY004.NTX")
   INDEX ON ANIVER TO HEPPY004
ENDIF
IF .NOT. FILE("HEPPY005.NTX") .OR. PCOUNT()<>0
   IF .NOT. USEREDE("HEPPYDAY",.T.,10)
      @ 0,0 SAY ""
      BEEP()
      MENSAGEM("NÑo foi poss°vel acesso ao arquivo",5)
      SET COLOR TO W
      SET CURSOR OFF
      CLEAR
      QUIT
   ENDIF
   MENSAGEM("Organizando o arquivo HEPPY005.NTX")
   INDEX ON SUBS(DTOC(DATA_ANI),4,2)+SUBS(DTOC(DATA_ANI),1,5)+DTOS(DATA_ANI)+ANIVER TO HEPPY005
ENDIF
IF .NOT. FILE("FOLHA006.NTX") .OR. PCOUNT()<>0
   IF .NOT. USEREDE("FOLHA_PA",.T.,10)
      @ 0,0 SAY ""
      BEEP()
      MENSAGEM("NÑo foi poss°vel acesso ao arquivo",5)
      SET COLOR TO W
      SET CURSOR OFF
      CLEAR
      QUIT
   ENDIF
   MENSAGEM("Organizando o arquivo FOLHA006.NTX")
   INDEX ON NOME TO FOLHA006
ENDIF
IF .NOT. FILE("REPRE007.NTX") .OR. PCOUNT()<>0
   IF .NOT. USEREDE("REPRESET",.T.,10)
      @ 0,0 SAY ""
      BEEP()
      MENSAGEM("NÑo foi poss°vel acesso ao arquivo",5)
      SET COLOR TO W
      SET CURSOR OFF
      CLEAR
      QUIT
   ENDIF
   MENSAGEM("Organizando o arquivo REPRE007.NTX")
   INDEX ON NOME+EMPRESA+FONE01+FONE02+FAX TO REPRE007
ENDIF
USE
**
** Bloco de inseráÑo FUN.B02
**
 
FUNCTION CALEN
*
* -> FunáÑo que ativa o calend†rio
SET EXCLUSIVE OFF
DECLARE BOTOES[10]
Q_BOTOES=1
MENU_P=1
X=1
C_SOM=""
L_SOM=""
M->DAT_HOJE=DATE()
M->SOS_MENU=" "
M->CALEN_X=ROW()
M->CALEN_Y=COL()
M->CLEN_COR=SETCOLOR()
SET CURSOR OFF
SET DATE BRIT
SET CENTURY ON
M->CA_MES=MONTH(M->DAT_HOJE)
M->CA_ANO=YEAR(M->DAT_HOJE)
M->CA_DATA=CTOD("01/"+STR(M->CA_MES,2)+"/"+STR(M->CA_ANO,4))
L_CALEN=L_SOM
C_CALEN=C_SOM
sombra(L_SOM,C_SOM,.T.)
M->CA_TELA1=SAVESCREEN(03,11,22,66)
@ 04,13,21,66 BOX "€€€€€€€€€€" color "BG+/BG"
sombra(04,13,21,66)
@ 04,13 to 21,66   color "R+/BG"
BOTAO_MMS(10,53," [+] Màs  ",1)
BOTAO_MMS(12,53," [-] Màs  ",2)
BOTAO_MMS(14,53," [+] Ano  ",3)
BOTAO_MMS(16,53," [-] Ano  ",4)
BOTAO_MMS(18,53,"    Ano   ",5)
**
@ 04,15 SAY "Æ          Ø" COLOR "r+/BG"
@ 04,17 SAY "F1-Ajuda" COLOR "bg+/BG"
@ 21,15 SAY "Æ                Ø" COLOR "r+/BG"
@ 21,17 SAY "F2-Calculadora" COLOR "bg+/BG"

**

M->OPC_BOT=1
M->SOS_MENU="CALENDARIO"
DO WHILE .T.
   SETCOLOR("W+/W")
   @ 06,15 SAY "  Dom  Seg  Ter  Qua  Qui  Sex  Sab " COLOR("W+/N")
   SETCOLOR(SUBS(SETCOLOR("W+/W"),4,2)+"/"+SUBS(SETCOLOR("W+/W"),4,2))
   FOR F_CALEN=8 TO 18 STEP 2
      @ 07,15 SAY "ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ" COLOR("BG+/BG")
      @ F_CALEN+0,15 SAY " €€€€ €€€€ €€€€ €€€€ €€€€ €€€€ €€€€ " COLOR("N/BG")
      @ F_CALEN+1,15 SAY " ﬂﬂﬂﬂ ﬂﬂﬂﬂ ﬂﬂﬂﬂ ﬂﬂﬂﬂ ﬂﬂﬂﬂ ﬂﬂﬂﬂ ﬂﬂﬂﬂ " COLOR("N/BG")
   NEXT
   IF AT(SUBS(STR(M->CA_MES+100,3),2),"01 03 05 07 08 10 12")<>0
      M->ULT_DIA = 31
   ELSE
      M->ULT_DIA=IIF(M->CA_MES#2,30,IIF(MOD(M->CA_ANO,4)=0,29,28))
   ENDIF
   M->X_X=DOW(M->CA_DATA)
   M->Y_Y=8
   SETCOLOR("W+/N")
   FOR F_CALEN=1 TO M->ULT_DIA
      IF M->X_X=1
         SETCOLOR("RG+/N")
         @ M->Y_Y,(M->X_X*5)+13 SAY STR(F_CALEN,2)
         SETCOLOR("W+/N")
      ELSE
         @ M->Y_Y,(M->X_X*5)+13 SAY STR(F_CALEN,2)
      ENDIF
      M->X_X=M->X_X+1
      IF M->X_X>7
         M->X_X=1
         M->Y_Y=M->Y_Y+2
      ENDIF
   NEXT
   SETCOLOR("BG+/N")
   @ 06,53 CLEAR TO 08,63
   @ 06,52 TO 08,63
   @ 06,52 CLEAR TO 06,63
   @ 06,53 SAY SUBS(" Janeiro. Fevereiro.  Maráo.    Abril.     Maio.    Junho.    Julho.    Agosto.  Setembro. Outubro.  Novembro. Dezembro.",MONTH(M->CA_DATA)*10-9,10)   COLOR("R+/N")
   @ 07,55 SAY TRAN(YEAR(M->CA_DATA),"@E 9,999")                                    COLOR("RG+*/N")
   M->OPC_BOT=BOTAO_MMS(M->OPC_BOT)
   IF M->OPC_BOT=0
      EXIT
   ELSEIF M->OPC_BOT=5
      SETCOLOR("W/N")
      @ 07,54 SAY CHR(26)
      M->CA_TEMP=""
      M->TECLA=0
      SET CURSOR ON
      DO WHILE M->TECLA<>13 .AND. M->TECLA<>27
         IF AT(CHR(M->TECLA),"0123456789")<>0
            M->CA_TEMP=M->CA_TEMP+CHR(M->TECLA)
            IF LEN(M->CA_TEMP)=4
               EXIT
            ENDIF
         ENDIF
         IF (M->TECLA=19 .OR. M->TECLA=8) .AND. LEN(M->CA_TEMP)>0
            M->CA_TEMP=SUBS(M->CA_TEMP,1,LEN(M->CA_TEMP)-1)
         ENDIF
         ***
         @ 07,55 SAY " .   "
         IF LEN(M->CA_TEMP)=0
            @ 07,56 SAY ""
         ELSE
            @ 07,56 SAY TRIM(SUBS(M->CA_TEMP,1,1)+"."+SUBS(M->CA_TEMP,2))
         ENDIF
         M->TECLA=INKEY(0)
      ENDDO
      SET CURSOR OFF
      M->CA_ANO=VAL(M->CA_TEMP)
      @ 07,54 SAY " "
   ENDIF
   M->CA_ANO=M->CA_ANO+IIF(M->OPC_BOT=4,-1,IIF(M->OPC_BOT=3,1,0))
   M->CA_ANO=IIF(M->CA_ANO<100,100,IIF(M->CA_ANO>2999,2999,M->CA_ANO))
   M->CA_MES=M->CA_MES+IIF(M->OPC_BOT=2,-1,IIF(M->OPC_BOT=1,1,0))
   M->CA_MES=IIF(M->CA_MES<1,12,IIF(M->CA_MES>12,1,M->CA_MES))
   M->CA_DATA=CTOD("01/"+STR(M->CA_MES,2)+"/"+STR(M->CA_ANO,4))
ENDDO
M->SOS_MENU=""
RESTSCREEN(03,11,22,66,M->CA_TELA1)
sombra(L_CALEN,C_CALEN)
SETCOLOR(M->CLEN_COR)
*
SET CENTURY OFF
@ M->CALEN_X,M->CALEN_Y SAY ""


FUNCTION BOTAO_MMS
*
*
PARA LIN_BOT,COL_BOT,NOM_BOT,NUM_BOT
IF PCOUNT()=0
   NUM_BOT=0
ENDIF
IF PCOUNT()=3
   NUM_BOT=-1
ENDIF
IF PCOUNT()=4
   IF NUM_BOT<1
      Q_BOTOES=1
   ELSE
      Q_BOTOES=NUM_BOT
   ENDIF
  BOTOES[Q_BOTOES]=STR(COL_BOT,3)+STR(LIN_BOT,3)+NOM_BOT
ENDIF
IF PCOUNT()=1
   X_BOT=LIN_BOT
   NUM_BOT=0
ELSE
   X_BOT=1
ENDIF
IF NUM_BOT>0 .OR. NUM_BOT=-1
   SETCOLOR("R+/R")
   @ LIN_BOT,COL_BOT SAY SPACE(11)
   @ LIN_BOT,COL_BOT+1 SAY NOM_BOT
   @ LIN_BOT,COL_BOT-1 SAY " ‹"                COLOR("n+/bG")
   @ LIN_BOT+1,COL_BOT-1 SAY " ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ "    COLOR("n+/bG")
ELSE
   TECLA=0
   DO WHILE .T.
      COL_BOT=VAL(SUBS(BOTOES[X_BOT],1,3))
      LIN_BOT=VAL(SUBS(BOTOES[X_BOT],4,3))
      NOM_BOT=SUBS(BOTOES[X_BOT],7)
      SETCOLOR("W+/R")
      Tone(500,1)
      @ LIN_BOT,COL_BOT SAY SPACE(11)
      @ LIN_BOT,COL_BOT+1 SAY NOM_BOT
      @ LIN_BOT,COL_BOT-1 SAY " ‹"                  COLOR("N+/BG")
      @ LIN_BOT+1,COL_BOT-1 SAY " ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ "      COLOR("N+/BG")
      IF TECLA=13
         Tone(800,2)
         INKEY(.2)
         RETURN X_BOT
      ENDIF
      IF NUM_BOT=-2
         TECLA=13
      ELSE
         TECLA=INKEY(0)
      ENDIF
      IF TECLA=27
          TONE(500,2)
         RETURN 0
      ENDIF
      IF TECLA=28
         TONE(300,2)
         HELP()
       ENDIF
      IF TECLA=(-1)
         TONE(300,2)
         CALCU()
      ENDIF
      SETCOLOR("R+/R")
      @ LIN_BOT,COL_BOT+1 SAY NOM_BOT
      FOR F_BOT=1 TO Q_BOTOES
         IF SUBS(BOTOES[F_BOT],7,1)=UPPER(CHR(TECLA))
            X_BOT=F_BOT
            TECLA=13
            COL_BOT=VAL(SUBS(BOTOES[X_BOT],1,3))
            LIN_BOT=VAL(SUBS(BOTOES[X_BOT],4,3))
            NOM_BOT=SUBS(BOTOES[X_BOT],7)
            EXIT
         ENDIF
      NEXT
      IF TECLA=13
         SETCOLOR("BG/BG")
         @ LIN_BOT,COL_BOT SAY "€"
         @ LIN_BOT+1,COL_BOT-1 SAY "€€€€€€€€€€€€"
         @ LIN_BOT,COL_BOT+10 SAY "€"
         SETCOLOR("W+/R")
         @ LIN_BOT,COL_BOT-1 SAY " "+NOM_BOT+" "
         INKEY(.2)
         LOOP
      ENDIF
      IF TECLA=19 .OR. TECLA=5
         X_BOT=X_BOT-1
      ELSEIF TECLA=4 .OR. TECLA=24
         X_BOT=X_BOT+1
      ENDIF
      X_BOT=IIF(X_BOT<1,Q_BOTOES,IIF(X_BOT>Q_BOTOES,1,X_BOT))
   ENDDO
ENDIF

*****************
*****************
*****************
 
FUNCTION BEEP
TONE(250,4)
 
FUNCTION SHELLDOS
*
* -> Permite sair ao sistema operacional retornado com (EXIT)
M->X_DOS=ROW()
M->Y_DOS=COL()
M->COR=SETCOLOR()
SAVE SCREEN TO M->TELA
SET COLOR TO W
CLEAR SCREEN
@ 01,00 SAY PADC("NÑo instale nem desinstale programas residentes.",80)  COLOR "G+/n"
@ 02,00 SAY PADC("Digite EXIT e tecle <ENTER> para retornar.",80) COLOR "G+/n"
@ 03,00 SAY REPL("ƒ",80) COLOR "r+/n"
@ 04,00 SAY REPL(" ",80) COLOR "W/N"
BEEP()
SET CURSOR ON
RUN COMMAND.COM
SET CURSOR OFF
RESTORE SCREEN FROM M->TELA
ON_CURSOR()
@ M->X_DOS,M->Y_DOS SAY ""
SETCOLOR(M->COR)
 
FUNCTION ON_CURSOR
M->GET_VAR=READVAR()
IF LEN(M->GET_VAR)>0 .AND. M->GET_VAR<>"MENU_OPC"
   SET CURSOR ON
ENDIF
 
FUNCTION MENSAGEM
*
* -> Funcao que imprime mensagens na tela
COR_MENS=SETCOLOR("W+/R")
COR("TITULO")
SET CURSOR OFF
IF PCOUNT()=0
   @ 24,11 SAY SPACE(58)
   SETCOLOR(COR_MENS)
   ON_CURSOR()
   RETURN .T.
ENDIF
IF PCOUNT()=1
   PARA TEX_TO
   M->PAUSA=0
ELSE
   PARA TEX_TO,PAUSA
ENDIF
@ 24,11 SAY SPACE(58)
@ 24,((80-LEN(M->TEX_TO))/2) SAY M->TEX_TO
IF M->PAUSA<>0
   M->X=INKEY(M->PAUSA)
ENDIF
tone(500,1)
SETCOLOR(COR_MENS)
ON_CURSOR()
RETURN .T.
 
FUNCTION DELE_TAR
RETURN IIF(DELETED(),chr(4)," ")
 
FUNCTION PERGUNTA
PER_COR=SETCOLOR()
SET CURSOR OFF
SAVE SCREEN TO PER_TELA
M->RES_POSTA="S"
PARA TEX_TO,RES_POSTA
M->SIM_NAO=IIF(M->RES_POSTA="N",2,1)
M->LAR_G=LEN(M->TEX_TO)
IF M->LAR_G<37
   M->LAR_G=51
ELSE
   M->LAR_G=M->LAR_G+14
ENDIF
COL_SUP=INT((80-M->LAR_G)/2)
COL_INF=COL_SUP+LAR_G-1
JANELA(08,COL_SUP,16,COL_INF)
COR("JANELA DE DIALOGO")
@ 11,(80-LEN(TEX_TO))/2 SAY TEX_TO
BOTAO(13,25,"Sim",1)
BOTAO(13,42,"NÑo",2)
SIM_NAO=BOTAO()
RESTORE SCREEN FROM PER_TELA
SETCOLOR(PER_COR)
RETURN IIF(M->SIM_NAO=1,"S","N")

FUNCTION BOTAO
PARA LIN_BOT,COL_BOT,NOM_BOT,NUM_BOT
IF PCOUNT()=0
   NUM_BOT=0
ENDIF
IF PCOUNT()=3
   NUM_BOT=-1
ENDIF
IF PCOUNT()=4
   IF NUM_BOT<1
      Q_BOTOES=1
   ELSE
      Q_BOTOES=NUM_BOT
   ENDIF
   BOTOES[Q_BOTOES]=STR(COL_BOT,3)+STR(LIN_BOT,3)+NOM_BOT
ENDIF
IF PCOUNT()=1
   X_BOT=LIN_BOT
   NUM_BOT=0
ELSE
   X_BOT=1
ENDIF
IF NUM_BOT>0 .OR. NUM_BOT=-1
   COR("BOTOES")
   @ LIN_BOT,COL_BOT SAY SPACE(11)
   @ LIN_BOT,COL_BOT+1 SAY NOM_BOT
   SETCOLOR("N/"+ALLTRIM(SUBS(CONTECOR[4],4)))
   @ LIN_BOT,COL_BOT-1 SAY "‹"
   @ LIN_BOT+1,COL_BOT-1 SAY "ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ "
ELSE
   TECLA=0
   DO WHILE .T.
      COL_BOT=VAL(SUBS(BOTOES[X_BOT],1,3))
      LIN_BOT=VAL(SUBS(BOTOES[X_BOT],4,3))
      NOM_BOT=SUBS(BOTOES[X_BOT],7)
      COR("BOTAO EM DESTAQUE")
      @ LIN_BOT,COL_BOT SAY SPACE(11)
      @ LIN_BOT,COL_BOT+1 SAY NOM_BOT
      SETCOLOR("N/"+ALLTRIM(SUBS(CONTECOR[4],4)))
      @ LIN_BOT,COL_BOT-1 SAY "‹"
      @ LIN_BOT+1,COL_BOT-1 SAY "ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ "
      IF TECLA=13
         INKEY(.2)
         RETURN X_BOT
      ENDIF
      IF NUM_BOT=-2
         TECLA=13
      ELSE
         TECLA=INKEY(0)
      ENDIF
      IF TECLA=27
         RETURN 0
      ENDIF
      IF TECLA=28
         DO HELP WITH "CALENDARIO",1,""
      ENDIF
      COR("BOTOES")
      @ LIN_BOT,COL_BOT+1 SAY NOM_BOT
      FOR F_BOT=1 TO Q_BOTOES
         IF SUBS(BOTOES[F_BOT],7,1)=UPPER(CHR(TECLA))
            X_BOT=F_BOT
            TECLA=13
            COL_BOT=VAL(SUBS(BOTOES[X_BOT],1,3))
            LIN_BOT=VAL(SUBS(BOTOES[X_BOT],4,3))
            NOM_BOT=SUBS(BOTOES[X_BOT],7)
            EXIT
         ENDIF
      NEXT
      IF TECLA=13
         COR("JANELA DE DIALOGO")
         @ LIN_BOT,COL_BOT SAY " "
         @ LIN_BOT+1,COL_BOT-1 SAY "            "
         @ LIN_BOT,COL_BOT+10 SAY " "
         COR("BOTAO EM DESTAQUE")
         @ LIN_BOT,COL_BOT-1 SAY " "+NOM_BOT+" "
         INKEY(.2)
         LOOP
      ENDIF
      IF TECLA=19 .OR. TECLA=5
         X_BOT=X_BOT-1
      ELSEIF TECLA=4 .OR. TECLA=24
         X_BOT=X_BOT+1
      ENDIF
      X_BOT=IIF(X_BOT<1,Q_BOTOES,IIF(X_BOT>Q_BOTOES,1,X_BOT))
   ENDDO
ENDIF
 
FUNCTION FUN_ACHO
PARA PAR1,PAR2,PAR3
M->TEC_ACHO=UPPER(CHR(LASTKEY()))
IF (M->TEC_ACHO>="A" .AND. M->TEC_ACHO<="Z") .OR. (M->TEC_ACHO>="0" .AND. M->TEC_ACHO<="9")
   FOR M->X_ACHO=1 TO LEN(ME_NU)
      FOR M->ACHO_X=1 TO LEN(ME_NU[M->X_ACHO])
         IF (SUBS(ME_NU[M->X_ACHO],M->ACHO_X,1)>="A" .AND. SUBS(ME_NU[M->X_ACHO],M->ACHO_X,1)<="Z") .OR. (SUBS(ME_NU[M->X_ACHO],M->ACHO_X,1)>="0" .AND. SUBS(ME_NU[M->X_ACHO],M->ACHO_X,1)<="9")
            IF SUBS(ME_NU[M->X_ACHO],M->ACHO_X,1) = M->TEC_ACHO
               M->OPC_ACHO = M->X_ACHO
               RETURN 0
            ENDIF
            EXIT
         ENDIF
      NEXT
   NEXT
ENDIF
IF LASTKEY()=13
   M->INC_COL=ROW()
   RETURN 1
ELSEIF LASTKEY()=27 .OR. M->TEC_ACHO="R"
   RETURN 0
ELSEIF PAR1=1
   KEYBOARD CHR(30)
ELSEIF PAR1=2
   KEYBOARD CHR(31)
ENDIF
RETURN 2
 
FUNCTION MENU
*
* -> Funcao que monta menu
PARA N_TELA
IF PCOUNT()=0
   N_TELA=0
   SET KEY  4 TO T_DIR
   SET KEY 19 TO T_ESQ
ENDIF
M->M_POS=MENU_POS[M->MENU_P]
M->LIN_INIC=LIN_MENU+2
IF N_TELA=1 .OR. N_TELA=2
   M->M_POS=M->M_POS+10
   IF N_TELA=1
      M->LIN_INIC=LIN_MENU+MENU_S+2
   ELSE
      M->LIN_INIC=LIN_MENU+2
   ENDIF
ENDIF
M->LAR_G=0
M->AL_TU=LEN(ME_NU)
DECLARE MEN_U[M->AL_TU] , MAR_C[M->AL_TU]
AFILL(MAR_C,.T.)
FOR M->X_X=1 TO M->AL_TU
   MEN_U[M->X_X]=" "+TRIM(ME_NU[M->X_X])+" "
   IF LEN(MEN_U[M->X_X]) > M->LAR_G
      M->LAR_G=LEN(MEN_U[M->X_X])
      IF SUBS(MEN_U[M->X_X],2,1)=">"
         M->LAR_G=M->LAR_G+1
      ENDIF
   ENDIF
NEXT
IF M->LAR_G < 18
   M->LAR_G=18
ENDIF
FOR M->X_X=1 TO M->AL_TU
   IF MEN_U[M->X_X]=" - "
      MAR_C[M->X_X]=.F.
      MEN_U[M->X_X]=REPL("ƒ",M->LAR_G)
   ENDIF
   IF SUBS(MEN_U[M->X_X],2,1)=">"
      MEN_U[M->X_X]=" "+SUBS(MEN_U[M->X_X],3)+SPACE((M->LAR_G-LEN(ALLTRIM(MEN_U[M->X_X])))-3)+CHR(16)+" "
   ENDIF
NEXT
M->AL_TU=M->AL_TU+2
IF M->AL_TU>15
   M->AL_TU=15
ENDIF
M->ULT_OPC=M->AL_TU
IF M->M_POS + M->LAR_G + 3 > 79
   IF M->N_TELA=0
      M->M_POS = M->M_POS - ((M->LAR_G+2) - LEN(MENU_PRI[M->MENU_P]))
   ELSE
      M->M_POS = M->M_POS - ((M->M_POS+M->LAR_G+3)-79)
   ENDIF
ENDIF
M->X_X=M->M_POS+M->LAR_G+2
SOMBRA(M->LIN_INIC,M->M_POS,M->AL_TU+M->LIN_INIC-1,M->M_POS+M->LAR_G+3)
COR("MENU")
@ M->LIN_INIC,M->M_POS CLEAR TO M->AL_TU+M->LIN_INIC-1,M->M_POS+M->LAR_G+3
@ M->LIN_INIC,M->M_POS+1 TO M->AL_TU+M->LIN_INIC-1,M->M_POS+M->LAR_G+2
IF M->AL_TU<15
   FOR M->X_X=1 TO M->AL_TU-2
      IF SUBS(MEN_U[M->X_X],1,1)="ƒ"
         @ M->X_X+M->LIN_INIC,M->M_POS+1 SAY "√"
         @ M->X_X+M->LIN_INIC,M->M_POS+M->LAR_G+2 SAY "¥"
      ENDIF
   NEXT
ENDIF
IF LEN(MEN_U) > M->AL_TU-2
   @ M->LIN_INIC+1,M->M_POS+M->LAR_G+3 SAY CHR(24)
   @ M->LIN_INIC+M->AL_TU-2,M->M_POS+M->LAR_G+3 SAY CHR(25)
ENDIF
M->OPC_ACHO=0
M->MENU_OPC=ACHOICE(M->LIN_INIC+1,M->M_POS+2,M->LIN_INIC+M->AL_TU-2,M->M_POS+M->LAR_G+1,MEN_U,MAR_C,"FUN_ACHO")
IF M->MENU_OPC=0
   M->MENU_OPC = M->OPC_ACHO
   IF N_TELA=0 .AND. BUFFER=CHR(13) .AND. M->MENU_OPC=0
      BUFFER="S"+CHR(13)
   ENDIF
ENDIF
IF MENU_OPC<>0
   IF .NOT.(N_TELA=0 .AND. SUBS(MEN_U[MENU_OPC],LEN(MEN_U[MENU_OPC])-1,1)=CHR(16))
      RESTSCREEN(LIN_MENU+1,00,23,79,TELA_PRI)
   ELSE
      SOMBRA(L_SOM,C_SOM,.T.)
      IF LEN(MEN_U) <= M->AL_TU
         COR("DESTAQUE DO MENU")
         @ LIN_MENU+MENU_OPC+1,COL() SAY MEN_U[MENU_OPC]
      ENDIF
   ENDIF
ELSE
   RESTSCREEN(LIN_MENU+1,00,23,79,TELA_PRI)
ENDIF
SET KEY  4 TO
SET KEY 19 TO
RETURN M->MENU_OPC

FUNCTION SOMBRA
PARA LIN_SUP,COL_SUP,LIN_INF,COL_INF
IF PCOUNT()=2 .OR. PCOUNT()=3
   C_SOM=COL_SUP
   L_SOM=LIN_SUP
   LIN_SUP=VAL(SUBS(C_SOM,1,2))
   COL_SUP=VAL(SUBS(C_SOM,3,2))
   LIN_INF=VAL(SUBS(C_SOM,5,2))
   COL_INF=VAL(SUBS(C_SOM,7,2))
   COL_SOM=SUBS(C_SOM,9)
   LIN_SOM=L_SOM
ENDIF
IF COL_SUP<2 .OR. LIN_INF>22
   C_SOM=""
   L_SOM=""
   RETURN .F.
ENDIF
IF PCOUNT()=3
   RESTSCREEN(LIN_SUP+1,COL_SUP-2,LIN_INF+1,COL_SUP-1,COL_SOM)
   RESTSCREEN(LIN_INF+1,COL_SUP-2,LIN_INF+2,COL_INF-2,LIN_SOM)
   RETURN .F.
ENDIF
IF PCOUNT()<>2
   COL_SOM=SAVESCREEN(LIN_SUP+1,COL_SUP-2,LIN_INF+1,COL_SUP-1)
   LIN_SOM=SAVESCREEN(LIN_INF+1,COL_SUP-2,LIN_INF+2,COL_INF-2)
ENDIF
*
* -> Estas duas linhas se fazem necess†rio apenas para algumas
*    versîes do Clipper Summer 87 que vez por outra apresentam
*    problemas na funáÑo SAVESCREEN
COL_SOM=SUBS(COL_SOM,1,((LIN_INF-LIN_SUP)+1)*4)
LIN_SOM=SUBS(LIN_SOM,1,((COL_INF-COL_SUP)+1)*4)
*
IF SUBS(COL_SOM,2,1)<>CHR(8)
   C_SOM=STR(LIN_SUP,2)+STR(COL_SUP,2)+STR(LIN_INF,2)+STR(COL_INF,2)+COL_SOM
   L_SOM=LIN_SOM
ENDIF
FOR I=2 TO LEN(COL_SOM) STEP 2
   COL_SOM=STUFF(COL_SOM,I,1,CHR(8))
NEXT
FOR I=2 TO LEN(LIN_SOM)/2 STEP 2
   LIN_SOM=STUFF(LIN_SOM,I,1,CHR(8))
NEXT
RESTSCREEN(LIN_SUP+1,COL_SUP-2,LIN_INF+1,COL_SUP-1,COL_SOM)
RESTSCREEN(LIN_INF+1,COL_SUP-2,LIN_INF+2,COL_INF-2,LIN_SOM)
RETURN .T.
 
FUNCTION CONFCOR
DECLARE ME_NU[13]
ME_NU[01]="Papel de parede"
ME_NU[02]="Menu"
ME_NU[03]="Destaque do menu"
ME_NU[04]="Janela de dialogo"
ME_NU[05]="Box da janela de dialogo"
ME_NU[06]="Botoes"
ME_NU[07]="Botao em destaque"
ME_NU[08]="Get's"
ME_NU[09]="Get em destaque"
ME_NU[10]="Tela de apresentacao"
ME_NU[11]="Caracteres avulsos"
ME_NU[12]="Cercaduras"
ME_NU[13]="Titulo"
OPC_COR=MENU(1)
IF OPC_COR=0
   RETURN.T.
ENDIF
SET COLOR TO W
RESTSCREEN(LIN_MENU+1,00,23,79,TELA_PRI)
COR("MENU")
@ LIN_MENU,00
@ LIN_MENU,01 SAY "ConfiguraáÑo de cores ≥ "+ME_NU[OPC_COR]
COR("FUNDO DA TELA")
IF FUNDO=10
   FUN_DO="∞∞∞∞"
ELSE
   FUN_DO="¿ø¿ø"
ENDIF
MENSAGEM("Utilize as setas para configurar as cores")
IF OPC_COR<>10
   SOMBRA(03,20,21,79)
   FOR F=1+LIN_MENU TO 17
      @ F+03,20 SAY REPL(SUBS(FUN_DO,1,2),30)
      FUN_DO=SUBS(FUN_DO,3)+SUBS(FUN_DO,1,2)
   NEXT
   FUN_DO=SUBS(FUN_DO,3)+SUBS(FUN_DO,1,2)
   COR("TITULO")
   @ 03,20 SAY "                    Titulo do aplicativo                    "
   COR("MENU")
   @ LIN_MENU+03,20 SAY "   Inclusîes  Consultas  Alteraáîes  Exclusîes  Relat¢rios  "
   @ 21,20 SAY SPACE(60)
   @ 21,21 SAY DTOC(DATE())+" ≥"
   @ 21,38 SAY "Escolha a opáÑo desejada"
   @ 21,69 SAY "≥ F1-Ajuda"
ENDIF
IF OPC_COR=3
   @ LIN_MENU+04,22 SAY " ⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø "
   @ LIN_MENU+05,22 SAY " ≥ OpáÑo um            ≥ "
   @ LIN_MENU+06,22 SAY " √ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥ "
   @ LIN_MENU+07,22 SAY " ≥ OpáÑo dois          ≥ "
   @ LIN_MENU+08,22 SAY " ≥ OpáÑo tres          ≥ "
   @ LIN_MENU+09,22 SAY " ¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ "
ENDIF
IF OPC_COR=4 .OR. OPC_COR=5 .OR. OPC_COR=6 .OR. OPC_COR=7
   COR("BOX DA JANELA DE DIALOGO")
   @ 08,28,16,71 BOX " "
   @ 08,28 SAY "˛"
   COR("JANELA DE DIALOGO")
   @ 09,29 CLEAR TO 15,70
   @ 11,38 SAY "Confirma o encerramento ?"
   BOTAO(13,36,"Sim")
   BOTAO(13,53,"NÑo")
   COR("BOTAO EM DESTAQUE")
   @ 13,37 SAY "Sim"
ENDIF
IF OPC_COR=8 .OR. OPC_COR=9 .OR. OPC_COR=11 .OR. OPC_COR=12
   COR("JANELA DE DIALOGO")
   @ 06,23 CLEAR TO 18,76
   COR("BOX DA JANELA DE DIALOGO")
   @ 06,23,18,76 BOX " "
   @ 06,23 SAY "˛"
   @ 06,41 SAY "Cadastro de clientes"
   COR("CERCADURAS")
   @ 11,27 TO 11,48
   @ 11,52 TO 11,72
   @ 15,27 TO 15,48
   @ 15,52 TO 15,63
   @ 15,66 TO 15,72
   COR("CARACTERES AVULSOS")
   @ 10,27 SAY "Nome"
   @ 10,52 SAY "Empresa"
   @ 14,27 SAY "Endereáo"
   @ 14,52 SAY "Bairro"
   @ 14,66 SAY "Cep"
   COR("GET EM DESTAQUE")
   @ 12,27 SAY "TESTE"+SPACE(17)
   SETCOLOR(CONTECOR[8])
   @ 12,52 SAY "TESTE"+SPACE(16)
   @ 16,27 SAY "TESTE"+SPACE(17)
   @ 16,52 SAY "TESTE"+SPACE(7)
   @ 16,66 SAY "9999999"
ENDIF
X_COR=07
Y_COR=0
SET CURSOR OFF
SET COLOR TO BG/RB
@ X_COR,Y_COR,X_COR+9,Y_COR+17 BOX "€"
FOR F_COR=0 TO 7
   FOR C_COR=0 TO 15
      AA=ALLTRIM(STR(C_COR,2))+"/"+ALLTRIM(STR(F_COR,2))
      SETCOLOR(AA)
      @ F_COR+X_COR+1,C_COR+Y_COR+1 SAY "˛"
   NEXT
NEXT
C_COR=VAL(SUBS(CONTECOR[OPC_COR],1,2))
F_COR=VAL(SUBS(CONTECOR[OPC_COR],4))
OK=.T.
DO WHILE .T.
   SET COLOR TO N/BG
   @ X_COR,Y_COR,X_COR+9,Y_COR+17 BOX " "
   @ F_COR+X_COR+1,Y_COR+17 SAY CHR(17)
   @ X_COR,Y_COR+C_COR+1 SAY CHR(31)
   SETCOLOR(ALLTRIM(STR(C_COR,3))+"/"+ALLTRIM(STR(F_COR,3)))
   CONTECOR[OPC_COR]=STRZERO(C_COR,2)+"/"+STRZERO(F_COR,2)
   IF OPC_COR=1
      FOR F=1+LIN_MENU TO 17
         @ F+03,20 SAY REPL(SUBS(FUN_DO,1,2),30)
         FUN_DO=SUBS(FUN_DO,3)+SUBS(FUN_DO,1,2)
      NEXT
      FUN_DO=SUBS(FUN_DO,3)+SUBS(FUN_DO,1,2)
   ELSEIF OPC_COR=2
      @ LIN_MENU+03,20 SAY "   Inclusîes  Consultas  Alteraáîes  Exclusîes  Relat¢rios  "
      @ 21,20 SAY SPACE(60)
      @ 21,21 SAY DTOC(DATE())+" ≥"
      @ 21,38 SAY "Escolha a opáÑo desejada"
      @ 21,69 SAY "≥ F1-Ajuda"
      IF OPC_COR=2
         @ LIN_MENU+04,22 SAY " ⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø "
         @ LIN_MENU+05,22 SAY " ≥ OpáÑo um            ≥ "
         @ LIN_MENU+06,22 SAY " √ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥ "
         @ LIN_MENU+07,22 SAY " ≥ OpáÑo dois          ≥ "
         @ LIN_MENU+08,22 SAY " ≥ OpáÑo tres          ≥ "
         @ LIN_MENU+09,22 SAY " ¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ "
         COR("DESTAQUE DO MENU")
         @ LIN_MENU+03,22 SAY " Inclusîes "
         @ LIN_MENU+05,24 SAY " OpáÑo um            "
      ENDIF
   ELSEIF OPC_COR=3
      @ LIN_MENU+03,22 SAY " Inclusîes "
      @ LIN_MENU+05,24 SAY " OpáÑo um            "
   ELSEIF OPC_COR=5
      @ 08,28,16,71 BOX " "
      @ 08,28 SAY "˛"
   ELSEIF OPC_COR=4
      @ 09,29 CLEAR TO 15,70
      @ 11,38 SAY "Confirma o encerramento ?"
      BOTAO(13,36,"Sim")
      BOTAO(13,53,"NÑo")
      COR("BOTAO EM DESTAQUE")
      @ 13,37 SAY "Sim"
   ELSEIF OPC_COR=6
      BOTAO(13,53,"NÑo")
   ELSEIF OPC_COR=7
      BOTAO(13,36,"Sim")
      COR("BOTAO EM DESTAQUE")
      @ 13,36 SAY " Sim       "
   ELSEIF OPC_COR=12
      @ 11,27 TO 11,48
      @ 11,52 TO 11,72
      @ 15,27 TO 15,48
      @ 15,52 TO 15,63
      @ 15,66 TO 15,72
   ELSEIF OPC_COR=11
      @ 10,27 SAY "Nome"
      @ 10,52 SAY "Empresa"
      @ 14,27 SAY "Endereáo"
      @ 14,52 SAY "Bairro"
      @ 14,66 SAY "Cep"
   ELSEIF OPC_COR=9
      @ 12,27 SAY "TESTE"+SPACE(17)
   ELSEIF OPC_COR=8
      @ 12,52 SAY "TESTE"+SPACE(16)
      @ 16,27 SAY "TESTE"+SPACE(17)
      @ 16,52 SAY "TESTE"+SPACE(7)
      @ 16,66 SAY "9999999"
   ELSEIF OPC_COR=10
      COR("TELA DE APRESENTACAO")
      @ 03,20 SAY "∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞"
      @ 04,20 SAY "∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞"
      @ 05,20 SAY "∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞"
      @ 06,20 SAY "∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞"
      @ 07,20 SAY "∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞"
      @ 08,20 SAY "∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞"
      @ 09,20 SAY "∞∞∞∞∞∞∞∞∞∞∞€€€€€€€∞€€€€€€€∞€€€€€€€∞€€€€€€€∞€€€€€€€∞∞∞∞∞∞∞∞∞∞"
      @ 10,20 SAY "∞∞∞∞∞∞∞∞∞     € ∞  €    ∞  €    ∞€    € ∞  €    ∞∞∞∞∞∞∞∞∞∞∞∞"
      @ 11,20 SAY "∞∞∞∞∞∞∞∞∞∞∞∞ ∞€∞∞ ∞€∞∞∞∞∞ ∞€∞∞∞ ∞∞∞∞ ∞€∞∞ ∞€∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞"
      @ 12,20 SAY "∞∞∞∞∞∞∞∞∞∞∞∞ ∞€€∞ ∞€€€€€€€∞€€€€€€€∞∞ ∞€€∞ ∞€€€€€€€∞∞∞∞∞∞∞∞∞∞"
      @ 13,20 SAY "∞∞∞∞∞∞∞∞∞∞∞∞  €€∞  €€∞∞∞∞       €€∞∞  €€∞  €€   ∞∞∞∞∞∞∞∞∞∞∞∞"
      @ 14,20 SAY "∞∞∞∞∞∞∞∞∞∞∞∞  €€∞  €€∞∞∞∞∞∞€∞∞  €€∞∞  €€∞  €€∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞"
      @ 15,20 SAY "∞∞∞∞∞∞∞∞∞∞∞∞  €€∞  €€€€€€€ €€€€€€€∞∞  €€∞  €€€€€€€∞∞∞∞∞∞∞∞∞∞"
      @ 16,20 SAY "∞∞∞∞∞∞∞∞∞∞∞∞  ∞∞∞       ∞       ∞∞∞∞  ∞∞∞       ∞∞∞∞∞∞∞∞∞∞∞∞"
      @ 17,20 SAY "∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞"
      @ 18,20 SAY "∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞"
      @ 19,20 SAY "∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞"
      @ 20,20 SAY "∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞"
      @ 21,20 SAY "∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞"
      IF OK
         OK=.F.
         SOMBRA(03,20,21,79)
      ENDIF
   ELSEIF OPC_COR=13
      @ 03,20 SAY "                    Titulo do aplicativo                    "
   ENDIF
   TECLA=INKEY(0)
   SET COLOR TO W/BG
   @ X_COR+F_COR+1,Y_COR+17 SAY " "
   @ X_COR,C_COR+Y_COR+1 SAY " "
   F_COR=F_COR+IIF(TECLA=5,-1,IIF(TECLA=24,1,0))
   C_COR=C_COR+IIF(TECLA=19,-1,IIF(TECLA=4,1,0))
   F_COR=IIF(F_COR<0,7,IIF(F_COR>7,0,F_COR))
   C_COR=IIF(C_COR<0,15,IIF(C_COR>15,0,C_COR))
   IF TECLA=27 .OR. TECLA=13
      EXIT
   ENDIF
ENDDO
CONTECOR[OPC_COR]=STRZERO(C_COR,2)+"/"+STRZERO(F_COR,2)
COR("TITULO")
@ 00,00
@ 00,(80-LEN(TITU_LO))/2 SAY TITU_LO
FUNDO()
COR("MENU")
@ LIN_MENU,00
FOR F_MENU=1 TO LEN(MENU_PRI)
   @ LIN_MENU,MENU_POS[F_MENU]+1 SAY MENU_PRI[F_MENU]
NEXT
@ 24,00
@ 24,01 SAY DATE()
@ 24,10 SAY "≥"
@ 24,69 SAY "≥"
@ 24,71 SAY "F1-Ajuda"
TELA_PRI=SAVESCREEN(LIN_MENU+1,00,23,79)
BUFFER=CHR(13)+"C"
RETURN .T.

FUNCTION FUNDO
*
* -> Monta papel de parede
PARA PAR1
IF PCOUNT()=0
   PAR1=0
ENDIF
DECLARE ME_NU[14]
ME_NU[1]="//\\//\\//\\//\\//  M.M.S.tec \\//\\//\\//\\//\\//"
ME_NU[2]="≤≤≤≤≤≤≤≤≤≤€€€€€€€€€∞∞∞∞∞∞∞∞∞∞±±±±±±±±±±"
ME_NU[3]="∞"
ME_NU[4]="€"
ME_NU[5]="ﬁ"
*ME_NU[6]="ﬂ"
ME_NU[6]="‹"
ME_NU[7]="Ë"
ME_NU[8]="Ì"
ME_NU[9]=" "
ME_NU[10]="¿ø¿ø"
ME_NU[11]=" ÀÀ "
ME_NU[12]="¡¬¬¡"
ME_NU[13]="√¥¥√"
ME_NU[14]="πÃÃπ"
IF PAR1=1
   S_MENU=MENU(1)
   IF S_MENU=0
      RETURN .F.
   ENDIF
   FUNDO=S_MENU
ENDIF
COR("FUNDO DA TELA")
IF FUNDO=1
   FUN_DO="\\//\\//\\//\\//\\// M.M.S.tec /\\//\\//\\//\\//\\//"
ELSE
   FUN_DO=ME_NU[FUNDO]
ENDIF
IF FUNDO<10
   FUN_DO=SUBS(FUN_DO+REPL(FUN_DO,1840/LEN(FUN_DO)),1,1840)
ENDIF
FOR F=LIN_MENU+1 TO 23
   IF FUNDO<10
      @ F,00 SAY SUBS(FUN_DO,F*80-79,80)
   ELSE
      @ F,00 SAY REPL(SUBS(FUN_DO,1,2),40)
      FUN_DO=SUBS(FUN_DO,3)+SUBS(FUN_DO,1,2)
   ENDIF
NEXT
IF PAR1=1
   TELA_PRI=SAVESCREEN(LIN_MENU+1,00,23,79)
ENDIF
RETURN .T.

FUNCTION COR
PARA NOM_COR
QUAL_COR=ASCAN(NOMECOR,UPPER(NOM_COR))
IF QUAL_COR<>0
   IF QUAL_COR=2
      SETCOLOR(CONTECOR[2]+","+CONTECOR[3]+",,,"+CONTECOR[2])
   ELSEIF QUAL_COR=8
      SETCOLOR(CONTECOR[11]+","+CONTECOR[9]+",,,"+CONTECOR[8])
   ELSE
      SETCOLOR(CONTECOR[QUAL_COR])
   ENDIF
ENDIF
RETURN .T.

FUNCTION FUN_CFG
PARA PAR1
IF LASTKEY()=13
   RETURN 1
ELSEIF LASTKEY()=27
   RETURN 0
ELSEIF PAR1=1
   KEYBOARD CHR(30)
ELSEIF PAR1=2
   KEYBOARD CHR(31)
ENDIF
CFG_COR=SETCOLOR()
COR("MENU")
FOR F_CFG=1 TO LEN(MENU_CFG)
   @ 09+F_CFG,34 SAY " "
NEXT
SETCOLOR(CFG_COR)
RETURN 2

FUNCTION CALCU
*
* -> FunáÑo que ativa a calculadora
*
C_SOM=""
L_SOM=""
MOVCAL_X=003
MOVCAL_y=-02
M->CALCU_X=ROW()
M->CALCU_Y=COL()
M->CACU_COR=SETCOLOR()
L_CALCU=L_SOM
C_CALCU=C_SOM
sombra(L_SOM,C_SOM,.T.)
M->CA_TELA=SAVESCREEN(MOVCAL_X+0,MOVCAL_Y+47,MOVCAL_X+16,MOVCAL_Y+79)
SET CURSOR OFF
@ 00+MOVCAL_X,49+MOVCAL_Y,15+MOVCAL_X,79+MOVCAL_Y BOX ("€€€€€€€€€") color "Bg+/BG" // Caixa da maquina
sombra(00+MOVCAL_X,49+MOVCAL_Y,15+MOVCAL_X,79+MOVCAL_Y)                            // Sombra da maquina
@ 05+MOVCAL_X,51+MOVCAL_Y,13+movcal_x,77+movcal_y BOX ("€€€€€€€€€") color "Bg/BG"  // Caixa/fundo dos botoes
*
@ 00+MOVCAL_X,49+MOVCAL_Y to 15+MOVCAL_X,79+MOVCAL_Y color "R+/BG"
@ 02+MOVCAL_X,51+MOVCAL_Y,04+MOVCAL_X,77+MOVCAL_Y box("€€€€€€€€€")color "N/G"   // Borda do visor
@ 02+MOVCAL_X,51+MOVCAL_Y,04+MOVCAL_X,77+MOVCAL_Y box("€ﬂ€€€‹€€")color "BG/n"   // Borda do visor
@ 05+MOVCAL_X,51+MOVCAL_Y,05+MOVCAL_X,77+MOVCAL_Y box("ﬂﬂﬂﬂﬂﬂﬂﬂﬂ")color "BG+/BG"   // Borda do visor
@ 00+MOVCAL_X,52+MOVCAL_Y say "Æ             Ø" color "R+/BG"                   // Titulo
@ 00+MOVCAL_X,53+MOVCAL_Y say " Calculadora " color "BG+/BG"                    // Titulo
*
BOTAO_CALC_MMS(06+MOVCAL_X,53+MOVCAL_Y," 7 ")
BOTAO_CALC_MMS(06+MOVCAL_X,58+MOVCAL_Y," 8 ")
BOTAO_CALC_MMS(06+MOVCAL_X,63+MOVCAL_Y," 9 ")
BOTAO_CALC_MMS(08+MOVCAL_X,53+MOVCAL_Y," 4 ")
BOTAO_CALC_MMS(08+MOVCAL_X,58+MOVCAL_Y," 5 ")
BOTAO_CALC_MMS(08+MOVCAL_X,63+MOVCAL_Y," 6 ")
BOTAO_CALC_MMS(10+MOVCAL_X,53+MOVCAL_Y," 1 ")
BOTAO_CALC_MMS(10+MOVCAL_X,58+MOVCAL_Y," 2 ")
BOTAO_CALC_MMS(10+MOVCAL_X,63+MOVCAL_Y," 3 ")
BOTAO_CALC_MMS(12+MOVCAL_X,53+MOVCAL_Y,"  0  ")
BOTAO_CALC_MMS(12+MOVCAL_X,61+MOVCAL_Y,"  .  ")
BOTAO_CALC_MMS(06+MOVCAL_X,MOVCAL_Y+69," - ")
BOTAO_CALC_MMS(12+MOVCAL_X,MOVCAL_Y+74," % ")
BOTAO_CALC_MMS(08+MOVCAL_X,MOVCAL_Y+69," + ")
BOTAO_CALC_MMS(08+MOVCAL_X,MOVCAL_Y+74," * ")
BOTAO_CALC_MMS(10+MOVCAL_X,MOVCAL_Y+74," / ")
BOTAO_CALC_MMS(10+MOVCAL_X,MOVCAL_Y+69," = ")
BOTAO_CALC_MMS(06+MOVCAL_X,MOVCAL_Y+74,"C/E")
**
@ 15+MOVCAL_X,52+MOVCAL_Y say "Æ          Ø" Color "R+/BG"
@ 15+MOVCAL_X,53+MOVCAL_Y say " F1-Ajuda " Color "BG+/BG"
**
M->C_RESULT=0
M->C_ALGA=SPACE(14)
M->C_DEC=""
M->C_DIG=CHR(0)
M->C_VAR="C_ALGA"
M->C_VERDAD=.F.
SET COLOR TO w+
@ 03+MOVCAL_X,54+MOVCAL_Y SAY " "+STR(M->C_RESULT,19,4)+" "
M->C_UOPER=""
M->C_PERC=" "
DO WHILE M->C_DIG<>CHR(27)
   M->C_DIG=CHR(INKEY(0))
   IF M->C_DIG="7" .OR. M->C_DIG=CHR(1)
      BOTAO_CALC_MMS(06+MOVCAL_X,53+MOVCAL_Y," 7 ",.T.)
   Tone(700,1)
   ELSEIF M->C_DIG="8" .OR. M->C_DIG=CHR(5)
      BOTAO_CALC_MMS(06+MOVCAL_X,58+MOVCAL_Y," 8 ",.T.)
   Tone(800,1)
   ELSEIF M->C_DIG="9" .OR. M->C_DIG=CHR(18)
      BOTAO_CALC_MMS(06+MOVCAL_X,63+MOVCAL_Y," 9 ",.T.)
   Tone(900,1)
   ELSEIF M->C_DIG="4" .OR. M->C_DIG=CHR(19)
      BOTAO_CALC_MMS(08+MOVCAL_X,53+MOVCAL_Y," 4 ",.T.)
   Tone(400,1)
   ELSEIF M->C_DIG="5" .OR. M->C_DIG=CHR(76)
      BOTAO_CALC_MMS(08+MOVCAL_X,58+MOVCAL_Y," 5 ",.T.)
   Tone(500,1)
   ELSEIF M->C_DIG="6" .OR. M->C_DIG=CHR(4)
      BOTAO_CALC_MMS(08+MOVCAL_X,63+MOVCAL_Y," 6 ",.T.)
   Tone(600,1)
   ELSEIF M->C_DIG="1" .OR. M->C_DIG=CHR(6)
      BOTAO_CALC_MMS(10+MOVCAL_X,53+MOVCAL_Y," 1 ",.T.)
   Tone(100,1)
   ELSEIF M->C_DIG="2" .OR. M->C_DIG=CHR(24)
      BOTAO_CALC_MMS(10+MOVCAL_X,58+MOVCAL_Y," 2 ",.T.)
   Tone(950,1)
   ELSEIF M->C_DIG="3" .OR. M->C_DIG=CHR(3)
      BOTAO_CALC_MMS(10+MOVCAL_X,63+MOVCAL_Y," 3 ",.T.)
   Tone(300,1)
   ELSEIF M->C_DIG="0" .OR. M->C_DIG=CHR(22)
      BOTAO_CALC_MMS(12+MOVCAL_X,53+MOVCAL_Y,"  0  ",.T.)
   Tone(105,1)
   ELSEIF M->C_DIG="." .OR. M->C_DIG=CHR(7)
      BOTAO_CALC_MMS(12+MOVCAL_X,61+MOVCAL_Y,"  .  ",.T.)
   Tone(950,1)
   ELSEIF M->C_DIG="-"
      BOTAO_CALC_MMS(06+MOVCAL_X,MOVCAL_Y+69," - ",.T.)
   Tone(950,1)
   ELSEIF M->C_DIG="%"
      BOTAO_CALC_MMS(12+MOVCAL_X,MOVCAL_Y+74," % ",.T.)
   Tone(950,1)
   ELSEIF M->C_DIG="+"
      BOTAO_CALC_MMS(08+MOVCAL_X,MOVCAL_Y+69," + ",.T.)
   Tone(950,1)
   ELSEIF M->C_DIG="*"
      BOTAO_CALC_MMS(08+MOVCAL_X,MOVCAL_Y+74," * ",.T.)
   Tone(950,1)
   ELSEIF M->C_DIG="/"
      BOTAO_CALC_MMS(10+MOVCAL_X,MOVCAL_Y+74," / ",.T.)
   Tone(950,1)
   ELSEIF M->C_DIG="=" .OR. ASC(M->C_DIG)=13
      BOTAO_CALC_MMS(10+MOVCAL_X,MOVCAL_Y+69," = ",.T.)
   Tone(950,1)
   ELSEIF AT(M->C_DIG,"cCeE")<>0
      BOTAO_CALC_MMS(06+MOVCAL_X,MOVCAL_Y+74,"C/E",.T.)
   ENDIF
   SET COLOR TO w+
   *
   IF AT(M->C_DIG,CHR(26)+CHR(2)+CHR(141)+CHR(145))<>0
      M->MOV_TELA=SAVESCREEN(MOVCAL_X+0,MOVCAL_Y+49,MOVCAL_X+15,MOVCAL_Y+79)
      RESTSCREEN(MOVCAL_X+0,MOVCAL_Y+47,MOVCAL_X+16,MOVCAL_Y+79,M->CA_TELA)
      *
      IF M->C_DIG=CHR(26)
         MOVCAL_Y=MOVCAL_Y-1
      ELSEIF M->C_DIG=CHR(2)
         MOVCAL_Y=MOVCAL_Y+1
      ELSEIF M->C_DIG=CHR(141)
         MOVCAL_X=MOVCAL_X-1
      ELSEIF M->C_DIG=CHR(145)
         MOVCAL_X=MOVCAL_X+1
      ENDIF
      IF MOVCAL_X+0<0
         MOVCAL_X=0
      ELSEIF MOVCAL_X+17>24
         MOVCAL_X=24-17
      ELSEIF MOVCAL_Y+47<0
         MOVCAL_Y=-47
      ELSEIF MOVCAL_Y+79>79
         MOVCAL_Y=0
      ENDIF
      M->CA_TELA=SAVESCREEN(MOVCAL_X+0,MOVCAL_Y+47,MOVCAL_X+16,MOVCAL_Y+79)
      sombra(MOVCAL_X+0,MOVCAL_Y+49,MOVCAL_X+15,MOVCAL_Y+79)
      RESTSCREEN(MOVCAL_X+0,MOVCAL_Y+49,MOVCAL_X+15,MOVCAL_Y+79,M->MOV_TELA)
  ENDIF
  IF M->C_DIG=CHR(28)
     help()
   ENDIF
   IF M->C_DIG=CHR(27)
      TONE(950,2)
      EXIT
   ENDIF
   M->C_XX=AT(M->C_DIG,CHR(22)+CHR(7)+CHR(6)+CHR(24)+CHR(3)+CHR(19)+CHR(76)+CHR(4)+CHR(1)+CHR(5)+CHR(18))
   IF M->C_XX<>0
      M->C_DIG=SUBS("0.123456789",M->C_XX,1)
   ENDIF
   M->C_VAR=IIF(M->C_DIG=".","M->C_DEC",M->C_VAR)
   M->C_ALGA=IIF(M->C_DIG="." .AND. M->C_ALGA=SPACE(14),SPACE(13)+"0",M->C_ALGA)
   IF M->C_DIG="%"
      IF M->C_VERDAD
         M->C_PERC=IIF(M->C_PERC="%"," ","%")
         @ 03+MOVCAL_X,75+MOVCAL_Y SAY M->C_PERC
         SET COLOR TO W+
      ELSE
         BEEP()
         @ 03+MOVCAL_X,55+MOVCAL_Y SAY SPACE(13)+"0.0000" color ("W+*/N")
      ENDIF
   ELSEIF M->C_DIG $ "0123456789" .AND. LEN(LTRIM(&C_VAR))<>IIF(M->C_VAR="M->C_DEC",4,14)
      &C_VAR=IIF(M->C_VAR="M->C_DEC",&C_VAR+M->C_DIG,SUBS(&C_VAR+M->C_DIG,2))
      @ 03+MOVCAL_X,55+MOVCAL_Y SAY M->C_ALGA+"."+SUBS(M->C_DEC+SUBS("00000",LEN(M->C_DEC)+1),1,4)
      M->C_VERDAD=IIF(M->C_VERDAD .AND. M->C_UOPER $ "="+CHR(13),.F.,M->C_VERDAD)
   ELSEIF M->C_DIG $ "+-/*="+CHR(13)
      IF M->C_VERDAD
         IF VAL(M->C_ALGA+"."+M->C_DEC)<>0
            IF M->C_PERC="%"
               M->OPE_RA=STR(M->C_RESULT,19,4)+M->C_UOPER+"("+STR(M->C_RESULT,19,4)+"*"+M->C_ALGA+"."+SUBS(M->C_DEC+SUBS("00000",LEN(M->C_DEC)+1),1,4)+")/100.000"
            ELSE
               M->OPE_RA=STR(M->C_RESULT,19,4)+M->C_UOPER+M->C_ALGA+"."+SUBS(M->C_DEC+SUBS("00000",LEN(M->C_DEC)+1),1,4)
            ENDIF
            M->C_RESULT=&OPE_RA
            IF STR(M->C_RESULT,19,4)=REPL("*",19)
               @ 03+MOVCAL_X,55+MOVCAL_Y SAY "* * * E r r o * * *" color ("R+*/N")
               M->C_RESULT=0
               @ 03+MOVCAL_X,53+MOVCAL_Y SAY " "
               @ 03+MOVCAL_X,75+MOVCAL_Y SAY " "
               set color to W+
            ELSE
               @ 03+MOVCAL_X,55+MOVCAL_Y SAY STR(M->C_RESULT,19,4)
            ENDIF
         ENDIF
      ELSEIF M->C_DIG $ "+-/*"
         M->C_VERDAD=.T.
         M->C_RESULT=VAL(M->C_ALGA+"."+M->C_DEC)
      ENDIF
      @ 03+MOVCAL_X,53+MOVCAL_Y SAY IIF(M->C_DIG $ "+-/*",M->C_DIG," ")
      @ 03+MOVCAL_X,75+MOVCAL_Y SAY " "
      SET COLOR TO W+
      M->C_VAR="M->C_ALGA"
      M->C_ALGA=SPACE(14)
      M->C_DEC=""
      M->C_UOPER=M->C_DIG
      M->C_PERC=" "
   ELSEIF M->C_DIG $ "EeCc"
      M->C_VAR="M->C_ALGA"
      M->C_ALGA=SPACE(14)
      M->C_DEC=""
      M->C_PERC=" "
      IF M->C_DIG $ "Cc"
         M->C_VERDAD=.F.
         @ 03+MOVCAL_X,53+MOVCAL_Y SAY " "
         @ 03+MOVCAL_X,75+MOVCAL_Y SAY " "
         SET COLOR TO w+
      ENDIF
      @ 03+MOVCAL_X,55+MOVCAL_Y SAY SPACE(13)+"0.0000" color ("W+*/N")
   ENDIF
ENDDO
SETCOLOR(M->CACU_COR)
RESTSCREEN(0+MOVCAL_X,47+MOVCAL_Y,16+MOVCAL_X,79+MOVCAL_Y,M->CA_TELA)
sombra(L_CALCU,C_CALCU)
@ M->CALCU_X,M->CALCU_Y SAY ""
RETURN


FUNCTIO BOTAO_CALC_MMS
PARA BOT_X,BOT_Y,BOT_N
IF PCOUNT()=4
   IF BOT_N=" = "
      SETCOLOR("rg+/Bg")
      @ BOT_X+0,BOT_Y+2 SAY " "
      @ BOT_X+1,BOT_Y+2 SAY " "
      @ BOT_X+2,BOT_Y+2 SAY " "
      @ BOT_X+3,BOT_Y-1 SAY "   "
      SETCOLOR("rg+/Bg")
      @ BOT_X+0,BOT_Y-1 SAY "   "
      @ BOT_X+1,BOT_Y-1 SAY " = "
      @ BOT_X+2,BOT_Y-1 SAY "   "
   ELSE
      SETCOLOR("rg+/Bg")
      @ BOT_X,BOT_Y+LEN(BOT_N)-1 SAY " "
      @ BOT_X+1,BOT_Y-1 SAY REPL(" ",LEN(BOT_N))
      SETCOLOR("rg+/n")
      @ BOT_X,BOT_Y-1 SAY BOT_N
   ENDIF
   INKEY(.1)
   SETCOLOR("N+/BG")
   IF BOT_N=" = "
      @ BOT_X+0,BOT_Y-1 SAY "‹"
      @ BOT_X+1,BOT_Y-1 SAY "€"
      @ BOT_X+2,BOT_Y-1 SAY "€"
      @ BOT_X+3,BOT_Y-1 SAY "ﬂﬂﬂ"
   ELSE
      @ BOT_X,BOT_Y-1 SAY "‹"
      @ BOT_X+1,BOT_Y-1 SAY REPL("ﬂ",LEN(BOT_N))
   ENDIF
ENDIF
SETCOLOR("w+/n")
IF BOT_N=" = "
   @ BOT_X+0,BOT_Y SAY "   "
   @ BOT_X+1,BOT_Y SAY " = "
   @ BOT_X+2,BOT_Y SAY "   "
ELSE
   @ BOT_X,BOT_Y SAY BOT_N
ENDIF
SETCOLOR("N+/Bg")
IF BOT_N=" = "
   @ BOT_X+0,BOT_Y-1 SAY "‹"
   @ BOT_X+1,BOT_Y-1 SAY "€"
   @ BOT_X+2,BOT_Y-1 SAY "€"
   @ BOT_X+3,BOT_Y-1 SAY "ﬂﬂﬂ"
ELSE
   @ BOT_X,BOT_Y-1 SAY "‹"
   @ BOT_X+1,BOT_Y-1 SAY REPL("ﬂ",LEN(BOT_N))
ENDIF
RETURN .T.





FUNCTIO BOT_CALC
PARA BOT_X,BOT_Y,BOT_N
IF PCOUNT()=4
   IF BOT_N=" = "
      SETCOLOR("N/"+ALLTRIM(SUBS(CONTECOR[4],4)))
      @ BOT_X+0,BOT_Y+2 SAY " "
      @ BOT_X+1,BOT_Y+2 SAY " "
      @ BOT_X+2,BOT_Y+2 SAY " "
      @ BOT_X+3,BOT_Y-1 SAY "   "
      COR("BOTOES")
      @ BOT_X+0,BOT_Y-1 SAY "   "
      @ BOT_X+1,BOT_Y-1 SAY " = "
      @ BOT_X+2,BOT_Y-1 SAY "   "
   ELSE
      SETCOLOR("N/"+ALLTRIM(SUBS(CONTECOR[4],4)))
      @ BOT_X,BOT_Y+LEN(BOT_N)-1 SAY " "
      @ BOT_X+1,BOT_Y-1 SAY REPL(" ",LEN(BOT_N))
      COR("BOTOES")
      @ BOT_X,BOT_Y-1 SAY BOT_N
   ENDIF
   INKEY(.1)
   SETCOLOR("N/"+ALLTRIM(SUBS(CONTECOR[4],4)))
   IF BOT_N=" = "
      @ BOT_X+0,BOT_Y-1 SAY "‹"
      @ BOT_X+1,BOT_Y-1 SAY "€"
      @ BOT_X+2,BOT_Y-1 SAY "€"
      @ BOT_X+3,BOT_Y-1 SAY "ﬂﬂﬂ"
   ELSE
      @ BOT_X,BOT_Y-1 SAY "‹"
      @ BOT_X+1,BOT_Y-1 SAY REPL("ﬂ",LEN(BOT_N))
   ENDIF
ENDIF
COR("BOTOES")
IF BOT_N=" = "
   @ BOT_X+0,BOT_Y SAY "   "
   @ BOT_X+1,BOT_Y SAY " = "
   @ BOT_X+2,BOT_Y SAY "   "
ELSE
   @ BOT_X,BOT_Y SAY BOT_N
ENDIF
SETCOLOR("N/"+ALLTRIM(SUBS(CONTECOR[4],4)))
IF BOT_N=" = "
   @ BOT_X+0,BOT_Y-1 SAY "‹"
   @ BOT_X+1,BOT_Y-1 SAY "€"
   @ BOT_X+2,BOT_Y-1 SAY "€"
   @ BOT_X+3,BOT_Y-1 SAY "ﬂﬂﬂ"
ELSE
   @ BOT_X,BOT_Y-1 SAY "‹"
   @ BOT_X+1,BOT_Y-1 SAY REPL("ﬂ",LEN(BOT_N))
ENDIF
RETURN .T.
 
FUNCTION MENU_PRN
*
* -> Menu de direcionamento de impressao
PARA ARQ_PRN
FUNDO()
JANELA(06,21,18,59,"Direcionamento de impressÑo")
COR("MENU")
@ 09,26 CLEAR TO 13,54
DO WHILE .T.
   BOTAO(15,35,"Enter")
   DECLARE MENU_CFG[3]
   MENU_CFG[1]="     ("+CHR(7)+") Impressora"
   MENU_CFG[2]="     ("+CHR(7)+") Monitor   "
   MENU_CFG[3]="     ("+CHR(7)+") Em disco  "
   MENSAGEM("Escolha um dos direcionamentos...")
   SETCOLOR(CONTECOR[2]+","+CONTECOR[7])
   KEYBOARD CHR(32)
   M->OPC_PRN=ACHOICE(10,28,12,52,MENU_CFG,.T.,"FUN_CFG")
   IF M->OPC_PRN<>0
      BOTAO(15,35,"Enter",-2)
   ENDIF
   IF M->OPC_PRN=0
      RETURN .F.
   ELSEIF M->OPC_PRN = 1
      M->TIPO_PRN = "I"
      IF .NOT. ISPRINTER()
         BEEP()
         MENSAGEM("Impressora desligada ou desconectada",3)
         MENSAGEM("Tecle <ESC> para sair")
         LOOP
      ENDIF
   ELSEIF M->OPC_PRN = 2
      M->TIPO_PRN = "T"
      M->EX_T=(VAL(SUBS(TIME(),4,2))*10)+VAL(SUBS(TIME(),7,2))
      ARQ_PRN=ARQ_PRN+"."+SUBS(STR(M->EX_T+1000,4),2)
      SET PRINTER TO &ARQ_PRN
   ELSEIF M->OPC_PRN = 3
      RESTSCREEN(LIN_MENU+1,00,23,79,TELA_PRI)
      JANELA(07,16,17,62,"Direcionamento de impressÑo")
      COR("MENU")
      @ 10,20 CLEAR TO 14,58
      @ 11,23 SAY "Digite o nome do arquivo de saida"
      ARQ_PRN=SPACE(8)
      DO WHILE .T.
         @ 13,35 GET ARQ_PRN PICT "@!" VALID ISALPHA(ARQ_PRN)
         SET CURSOR ON
         READ
         SET CURSOR OFF
         IF LASTKEY()=27
            RETURN .F.
         ENDIF
         IF AT(".",ARQ_PRN)<>0
            BEEP()
            MENSAGEM("Digite o nome do arquivo sem extensÑo",3)
            MENSAGEM("Tecle <ESC> para sair")
            LOOP
         ENDIF
         EXIT
      ENDDO
      ARQ_PRN=ARQ_PRN+".PRN"
      M->TIPO_PRN = "A"
      SET PRINTER TO &ARQ_PRN
   ENDIF
   MENSAGEM("Tecle <ESC> para pausa ou interrupáÑo")
   RETURN .T.
ENDDO
 
* -> FUNCAO QUE IMPRIME NA TELA
*
FUNCTION IMP_TELA
*
* Local: c:\miro\IMP_TELA.B
*
PARA ARQ_PRN,TAM_LIN,MARG_ESQ
IF PCOUNT()=2
   M->MARG_ESQ=0
ENDIF
M->MARG_ESQ=M->MARG_ESQ+1
MENSAGEM("Aguarde processamento")
SELE 100
PUBL QUAN_REG,ULT_POS
M->ARQ_PRN1=M->ARQ_PRN+"."+SUBS(STR(M->EX_T+1000,4),2)
M->ARQ_PRN2=M->ARQ_PRN+"."+SUBS(STR(M->EX_T+1100,4),2)
CREATE ARQ_STRU
IF .NOT. USEREDE("ARQ_STRU",.T.,10)
   @ 0,0 SAY ""
   ? CHR(7)
   MENSAGEM("Nao foi possivel criar arquivo, tente novamente",5)
   RETURN .F.
ENDIF
IF .NOT. ADIREG(0)
   @ 0,0 SAY ""
   ? CHR(7)
   MENSAGEM("Nao foi possivel criar arquivo, tente novamente",5)
   USE
   RETURN .F.
ENDIF
REPLACE FIELD_NAME WITH "LI_NHA",FIELD_TYPE WITH "C"
REPLACE FIELD_LEN  WITH M->TAM_LIN+1,FIELD_DEC WITH 0
CREATE &ARQ_PRN2 FROM ARQ_STRU
USE
ERASE ARQ_STRU.DBF
IF .NOT. USEREDE(ARQ_PRN2,.T.,10)
   @ 0,0 SAY ""
   ? CHR(7)
   MENSAGEM("Nao foi possivel acesso, tente novamente",5)
   RETURN .F.
ENDIF
APPEND FROM &ARQ_PRN1 SDF
M->QUAN_REG=LASTREC()
IF M->QUAN_REG=0
   M->QUAN_REG=1
ENDIF
GOTO TOP
JANELA(LIN_MENU+3,02,21,77)
@ LIN_MENU+4,77 SAY CHR(30)  COLOR("R+/"+ALLTRIM(SUBS(CONTECOR[5],4)))
@ 20,77 SAY CHR(31)          COLOR("R+/"+ALLTRIM(SUBS(CONTECOR[4],4)))
IF M->TAM_LIN<72
   DECLARE EDI_TAR[1]
   EDI_TAR[1]="SUBS(LI_NHA,M->MARG_ESQ)"
ELSE
   IF INT(M->TAM_LIN/36)=M->TAM_LIN/36
      M->NUM_COL=M->TAM_LIN/36
   ELSE
      M->NUM_COL=INT(M->TAM_LIN/36)+1
   ENDIF
   DECLARE EDI_TAR[M->NUM_COL]
   M->X=1
   DO WHILE M->X<M->NUM_COL
      M->NUM_MAT=(M->X*36)-34
      EDI_TAR[M->X]="SUBS(LI_NHA,"+STR(M->NUM_MAT,3)+",36)"
      M->X=M->X+1
   ENDDO
   M->NUM_MAT=(M->X*36)-34
   EDI_TAR[M->X]="SUBS(LI_NHA,"+STR(M->NUM_MAT,3)+")+SPACE("+STR((M->NUM_COL*36)-M->TAM_LIN,2)+")"
ENDIF
KEYBOARD CHR(65)
M->ULT_POS=LIN_MENU+5
MENSAGEM("Tecle <ESC> para sair")
M->SOS_MENU="RELATORIO"
SETCOLOR(CONTECOR[4]+","+CONTECOR[7])
SETCOLOR ("R+*/N")
@ 05,03 clear to 20,76
@ 06,05 say PADC("M.F.B. Material de ConstruáÑo Ltda.",69)      Color ("w+/N")
@ 07,05 say PADC(M->CAB_2,69)        Color ("N+/N")
@ 08,04 say REPL("ƒ",72)             Color ("N+/N")
@ 19,04 say repl("ƒ",72)             Color ("N+/N")
@ 20,05 say CHR(9)+" Rec"            Color ("N+*/N")
@ 20,20 say CHR(17)+CHR(17)+" Right" Color ("N+/N")
@ 20,35 say CHR(16)+CHR(16)+" Low"   Color ("N+/N")
@ 20,50 say CHR(16)+" Play"          Color ("N+/N")
@ 20,65 say CHR(19)+" Pause"         Color ("N+/N")
@ 06,05 say "< Read >"               Color ("N+*/N")
@ 21,03 say repl("ﬂ",74)             COLOR("N/"+ALLTRIM(SUBS(CONTECOR[4],4)))
*
COR("TELA DE APRESENTACAO")
DBEDIT(LIN_MENU+8,04,18,75,EDI_TAR,"FUN_IMP","","","","")
M->SOS_MENU=" "
USE
ERASE &ARQ_PRN1
ERASE &ARQ_PRN2
RELEASE QUAN_REG,ULT_POS

FUNCTION FUN_IMP
IF LASTKEY()=27
   *
   * -> Finaliza ediáÑo
   RETURN 0
ELSEIF LASTKEY()=1
   *
   * Vai para o comeco do arquivo
   GOTO TOP
ELSEIF LASTKEY()=6
   *
   * -> Vai para o final do arquivo
   GOTO BOTT
ENDIF
COR("JANELA DE DIALOGO")
@ M->ULT_POS,77 SAY "€"      COLOR("N+/"+ALLTRIM(SUBS(CONTECOR[4],4)))
M->ULT_POS=LIN_MENU+5+(((RECN()*100)/M->QUAN_REG)/(100/(19-(LIN_MENU+5))))
IF RECN()=1
   M->ULT_POS=LIN_MENU+5
ENDIF
@ M->ULT_POS,77 SAY CHR(4)  COLOR("R+*/"+ALLTRIM(SUBS(CONTECOR[5],4)))
@ M->ULT_POS,76 SAY "˙"     COLOR("N+*/n")
SETCOLOR(CONTECOR[4]+","+CONTECOR[7])
RETURN 1
 
FUNCTION USEREDE
*
* -> Efetua tentativas para abrir o arquivo durante um determinado tempo en-
*    viado atraves do parametro tempo ou indefinidamente, caso tempo=0. Se a
*    tecla <Esc> for precionada pela usuario, as tentaivas sao interrompidas.
*
PARA ARQ,EXUSE,TEMPO
PRIVATE SEMPRE
M->SEMPRE = (M->TEMPO=0)
SET CURSOR OFF
MENSAGEM("Aguarde tentativa de acesso aos arquivos")
          COR("TITULO")
          @ 24,00,24,10 box "   ≥     "   COLOR("N/"+ALLTRIM(SUBS(CONTECOR[13],4)))
          @ 24,01 say REPL("‹",9)         COLOR("N/"+ALLTRIM(SUBS(CONTECOR[13],4)))
          for a=01 to 09 step +1
               inkey(.01)
               @ 24,00+A say "‹"          COLOR("R+/"+ALLTRIM(SUBS(CONTECOR[13],4)))
          Next
Tone(500,3)
@ 24,69 SAY "≥ F1-Ajuda "                 COLOR("B+/"+ALLTRIM(SUBS(CONTECOR[13],4)))
DO WHILE (M->SEMPRE .OR. M->TEMPO>0)
   IF EXUSE
      USE &ARQ EXCLUSIVE
      *
      * -> Uso exclusivo
   ELSE
      USE &ARQ
      *
      * -> Uso compartilhado
   ENDIF
   IF .NOT. NETERR()
      RETURN .T.
   ENDIF
   M->TEC=INKEY(1)
   M->TEMPO=M->TEMPO-1
   IF M->TEC=27
      EXIT
   ENDIF
ENDDO
RETURN .F.
 
FUNCTION REGLOCK
PARA TEMPO
PRIVATE SEMPRE
IF RLOCK()
   RETURN .T.
ENDIF
SAVE SCREEN
MENSAGEM("Aguarde tentativa de acesso ao arquivo")
M->SEMPRE=(M->TEMPO=0)
DO WHILE (M->SEMPRE .OR. M->TEMPO>0)
   IF RLOCK()
      RESTORE SCREEN
      RETURN .T.
   ENDIF
   M->TEC=INKEY(.5)
   M->TEMPO=M->TEMPO - 0.5
   IF M->TEC=27
      EXIT
   ENDIF
ENDDO
RESTORE SCREEN
RETURN .F.
 
FUNCTION ADIREG
PARA TEMPO
PRIVATE SEMPRE
APPEND BLANK
IF .NOT. NETERR()
   RETURN .T.
ENDIF
SAVE SCREEN
MENSAGEM("Aguarde tentativa de acesso ao arquivo")
M->SEMPRE=(M->TEMPO=0)
DO WHILE (M->SEMPRE .OR. M->TEMPO>0)
   APPEND BLANK
   IF .NOT. NETERR()
      RESTORE SCREEN
      RETURN .T.
   ENDIF
   M->TEC=INKEY(.5)
   M->TEMPO=M->TEMPO - 0.5
   IF M->TEC=27
      EXIT
   ENDIF
ENDDO
RESTORE SCREEN
RETURN .F.
*
Function relogio
* \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
* \ Empresa : M.M.S.tec INFORMATICA LTDA.
* \ Programa: HORA.PRG.
* \ Data    : 20.11.1996.
* \ Sistema : ApresentaáÑo de Hor†rio.
* \ FunáÑo  : Informar as horas.
* \ Analista: Marcos Morais de Sousa.
* \ CriaáÑo : Marcos Morais de Sousa.
* \ Usu†rio : M.F.B. Materiais de ConstruáÑo Ltda.
* \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
*
*
SAVE SCREEN TO TELA_HORA1
DATAS()
SAVE SCREEN TO TELA_HORA
M->DIA=DATE()
M->ANO=DATE()
M->MES=DATE()
SET CURSOR OFF
SET COLOR TO W
DO WHILE .T.
     IF LASTKEY()>1
        beep()
        exit
        ENDIF
     For A=05 to 70 step +1
          SET COLOR TO W
          RESTORE SCREEN FROM TELA_HORA
          SETCOLOR("R+/R")
          @ 03,00+A to 05,09+A COLOR("R+/R")
          @ 04,01+A SAY TIME() COLOR("W+/R")
          SOMBRA(03,00+A,05,09+A)
          Inkey(1)
          Tone(800,3)
          IF lASTKEY()>1
               Tone(800,3)
               exit
          ENDIF
     NEXT
     *
     For A=04 to 20 step +1
          SET COLOR TO W
          RESTORE SCREEN FROM TELA_HORA
          SETCOLOR("R+/R")
          @ 00+a,69 to 02+a,78 COLOR("R+/R")
          @ 01+A,70 SAY TIME() COLOR("W+/R")
          SOMBRA(00+a,69,02+a,78)
          Inkey(1)
          Tone(700,3)
          IF lASTKEY()>1
               Tone(700,3)
               exit
          ENDIF
     NEXT
     *
     For A=70 to 05 step -1
          SET COLOR TO W
          RESTORE SCREEN FROM TELA_HORA
          SETCOLOR("R+/R")
          @ 19,00+A to 21,09+A COLOR("R+/R")
          @ 20,01+A SAY TIME() COLOR("W+/R")
          SOMBRA(19,00+A,21,09+A)
          Tone(600,3)
          Inkey(1)
          IF lASTKEY()>1
               Tone(600,3)
               exit
          ENDIF
     NEXT
     *
     For A=20 to 04 step -1
          SET COLOR TO W
          RESTORE SCREEN FROM TELA_HORA
          SETCOLOR("R+/R")
          @ 00+a,04 to 02+a,13 COLOR("R+/R")
          @ 01+A,05 SAY TIME() COLOR("W+/R")
          SOMBRA(00+a,04,02+a,13)
          Tone(500,3)
          Inkey(1)
          IF lASTKEY()>1
               Tone(500,3)
               exit
          ENDIF
     NEXT
ENDDO
RESTORE SCREEN FROM TELA_HORA1
RETURN

FUNCTION BOM_DIA
SAVE SCREEN TO TELA_BOMDIA
SETCOLOR ("W+/N")
CLEAR
SETCOLOR ("g+/G")
SOMBRA_MMS(01,15,24,65)
@ 01,15 CLEAR TO 24,65
@ 01,15 TO 24,65 DOUBLE
SETCOLOR ("W+/G")
@ 03,20 SAY "   ** B O M  D I A  S  E  N  H  O  R **  " COLOR ("RG+/G")
@ 05,20 SAY "   No silencio deste dia  que amanhece,  "
@ 06,20 SAY "   venho pedir-te a paz, a sabedoria, a  "
@ 07,20 SAY "   foráa. Quero olhar hoje o  mundo com  "
@ 08,20 SAY "   olhos cheios  de amor, ser paciente,  "
@ 09,20 SAY "   ser compreensivo,  manso e prudente;  "
@ 10,20 SAY "   ver,  alem  das  aparencias humanas,  "
@ 11,20 SAY "   teus  filhos,  como  TU mesmo os ves  "
@ 12,20 SAY "   e  assim  nÑo  ver  senÑo  o  bem em  "
@ 13,20 SAY "   cada um.                              "
@ 14,20 SAY "   Cerra os meus ouvidos a toda calunia  "
@ 15,20 SAY "   guarda  minha  lingua de toda a mal-  "
@ 16,20 SAY "   dade. Que  so de benáÑo se encha meu  "
@ 17,20 SAY "   espirito.  Que eu seja tÑo bondoso e  "
@ 18,20 SAY "   alegre, que todos quantos se achega-  "
@ 19,20 SAY "   rem a mim sintam TUA presenáa.        "
@ 20,20 SAY "   Reveste-me  de  TUA  graáa,  SENHOR,  "
@ 21,20 SAY "   e que, no decurso deste dia,  eu nÑo  "
@ 22,20 SAY "   TE ofenda e TE revele a todos.        "
@ 00,15 SAY "                                         " COLOR("W+/n")
DO WHILE.T.
     IF LASTKEY()=27
          EXIT
     ENDIF
     @ 00,58 SAY TIME() COLOR("R+/n")
     @ 23,62 SAY RIGHT(TIME(),2) COLOR("G+/G")
     TONE(800,1)
     INKEY(1)
     @ 00,58 say SPACE(8) COLOR ("R+/n")
     @ 00,15 SAY "Tecle <ESC> para prosseguir..." COLOR("W+/n")
     ENDDO
TONE (2000,5)
TONE (2000,5)
CLEAR
RESTORE SCREEN FROM TELA_BOMDIA

FUNCTION MUSICA
SAVE SCREEN TO TELA_MUSICA
COR("TITULO")
@ 00,70 SAY TIME()
TONE(500,4)
@ 00,70 SAY TIME()
TONE(550,4)
@ 00,70 SAY TIME()
TONE(600,4)
@ 00,70 SAY TIME()
TONE(650,4)
@ 00,70 SAY TIME()
TONE(600,4)
@ 00,70 SAY TIME()
TONE(550,4)
@ 00,70 SAY TIME()
TONE(500,4)
@ 00,70 SAY TIME()
TONE(350,4)
@ 00,70 SAY TIME()
TONE(500,4)
@ 00,70 SAY TIME()
TONE(550,7)
@ 00,70 SAY TIME()
TONE(500,4)
@ 00,70 SAY TIME()
TONE(550,7)
@ 00,70 SAY TIME()
TONE(500,4)
@ 00,70 SAY TIME()
TONE(550,4)
@ 00,70 SAY TIME()
TONE(600,4)
@ 00,70 SAY TIME()
TONE(650,4)
@ 00,70 SAY TIME()
TONE(600,4)
@ 00,70 SAY TIME()
TONE(550,4)
@ 00,70 SAY TIME()
TONE(500,4)
@ 00,70 SAY TIME()
TONE(350,4)
@ 00,70 SAY TIME()
TONE(500,4)
@ 00,70 SAY TIME()
TONE(550,7)
@ 00,70 SAY TIME()
TONE(500,7)
@ 00,70 SAY TIME()
TONE(500,7)
@ 00,70 SAY TIME()

TONE(500,4)
@ 00,70 SAY TIME()
TONE(550,4)
@ 00,70 SAY TIME()
TONE(600,4)
@ 00,70 SAY TIME()
TONE(650,4)
@ 00,70 SAY TIME()
TONE(600,4)
@ 00,70 SAY TIME()
TONE(550,4)
@ 00,70 SAY TIME()
TONE(500,4)
@ 00,70 SAY TIME()
TONE(350,4)
@ 00,70 SAY TIME()
TONE(500,4)
@ 00,70 SAY TIME()
TONE(550,7)
@ 00,70 SAY TIME()
TONE(500,7)
@ 00,70 SAY TIME()
TONE(600,10)
@ 00,70 SAY TIME()
TONE(350,4)
@ 00,70 SAY TIME()
@ 00,70 SAY SPACE(10)
RESTORE SCREEN FROM TELA_MUSICA


FUNCTION MMS_EDITOR
SAVE SCREEN TO TELA_EDITOR
CLEAR
*
* -> cores
*
cor1="BG+/b"
cor2="BG+/b"
Cor3="BG+/b"
cor4="BG+/b"
cor5="BG+/b"
cor6="G+/N"
cor7="W+/N"
FUNDO_MMS="G+/N"
JANELA_MMS="B+/b"
TITULO_MMS="W+/B"
FUNDO_MMS=0
*
* -> COORDENADAS
*
L=00
C=00
L1=L+08
L2=L+09
L3=L+10
L4=L+11
L5=L+12
L6=L+08
C1=C+15
C2=C+15
C3=C+15
C4=C+15
C5=C+15
C6=C+44
*
*
*
*
*
DO WHILE.T.
SET CURSOR ON
ARQUIVO=SPACE(45)
ENTRADA()
@ 23,00 SAY PADC(" Digite o nome do arquivo desejado ",80) color ("W+/N")
@ 19,08 SAY " Arquivo / caminho " GET ARQUIVO PICT "@!" Color ("W+/B")
READ
     IF LASTKEY()=27
          EXIT
     ENDIF

SETCOLOR ("G+/n")
TEXTO=MEMOREAD(ARQUIVO)
PREVEW(04,08,18,73," VISUALIZACAO ")
@ 16,11 say "Caminho / Arquivo: " Color ("BG+/N")
@ 16,30 say "Ì" Color ("RG+/N")
@ 16,32 say "<                                       >" Color ("RG+/N")
@ 16,33 say PADL(ARQUIVO,39) Color ("G+*/N")
*
*
@ 17,11 say "AáÑo Realizada   :" COLOR ("BG+/N")
@ 17,30 say CHR(2) Color ("RG+/N")
@ 17,32 say "<            >" Color ("RG+/N")
@ 17,33 say PADC("LENDO",12) Color ("R+*/N")
SET CURSOR ON
MEMOEDIT(TEXTO,05,11,15,72,.F.)
     ENDDO
     INFORMA()
RESTORE SCREEN FROM TELA_EDITOR
RETURN



**********************
****** FUNCOES *******

Function informa
CLEAR
?REPL(" MMS-Editor ",200)
@ 09,27 SAY PADC(" MMS-Editor Utilit†rio ",23) COLOR "W+/N"
@ 10,27 SAY PADC(" ---- versÑo 0.02 ---- ",23) COLOR "G+/N"
@ 13,25 SAY PADC(" Jequie  - Bahia -  Brasil. ",27) COLOR ("G+/N")
@ 14,20 SAY PADC(" ProduáÑo de Marcos Morais de Sousa. ",38) COLOR ("G+/N")
@ 24,00 SAY PADC("",80)


  FUNCTION PAPEL
  SETCOLOR ("g+/n")
  ?REPL(" MMS-Editor ",200)
  RETURN

  FUNCTION TIMBRE
  SETCOLOR ("G+/n")
  TONE (1000,3)
  @ 04,30,16,70 BOX "€€€€€€€€€" COLOR ("N/N")
  @ 04,30 TO 16,70 COLOR ("b+/N")
  SOMBRA_MMS(04,30,16,70)
  @ 05,33 SAY PADC("MMS-Editor Utilit†rio",35) COLOR "W+/N"
  @ 06,33 SAY PADC("---- versÑo 0.02 ----",35) COLOR "G+/N"
  @ 09,33 SAY PADC("Desenvolvido por:",35) COLOR "W/B"
  @ 10,33 Say PADC("Marcos Morais de Sousa",35) COLOR "RG+/B"
  @ 08,33 to 13,67 color ("B+/B")
  @ 11,33 Say PADC("M.M.S.tec",35) COLOR "B/BG"
  @ 12,33 Say PADC("Artes Gr†ficas & Inform†tica.",35) COLOR "B/BG"
  @ 13,33 Say PADC("Fone:(073)525-5932",35) COLOR "B/BG"
  @ 14,33 Say PADC("Copyright(R) 1996-1997",35) COLOR "B/BG"
  @ 15,33 SAY PADC("                      ",35) COLOR "B/BG"
  SET CURSOR OFF
  SET COLOR TO W
  RETURN



     FUNCTION FUNDO_MMS
     PARA PJAN1,PJAN2,PJAN3,PJAN4,PJAN5
     PAPEL_1="≈"
     PAPEL_2="Ë"
     PAPEL_3="€"
     PAPEL_4="-"
     IF PCOUNT()<>5
        PJAN5=""
     ENDIF
     SOMBRA_MMS(PJAN1,PJAN2,PJAN3,PJAN4)
     SETCOLOR("W+/N")
     @ PJAN1,PJAN2,PJAN3,PJAN4 BOX "€€€€€€€€"+PAPEL_4
     SETCOLOR("W+/N")
     @ PJAN1,PJAN2,PJAN3,PJAN4 BOX "€€€€€€€€"
     *SETCOLOR("W+/W")
     *@ PJAN1,PJAN2 TO PJAN3,PJAN4 DOUBLE
     SETCOLOR("W+/B")
     @ PJAN1,PJAN2 clear to PJAN1,PJAN4
     IF LEN(TRIM(PJAN5)) > 0
        @ PJAN1,PJAN2+(((PJAN4+1-PJAN2)-LEN(PJAN5))/2) SAY PJAN5
     ENDIF


     FUNCTION JANELA_MMS
     PARA PJAN1,PJAN2,PJAN3,PJAN4,PJAN5
     IF PCOUNT()<>5
        PJAN5=""
     ENDIF
     SOMBRA_MMS(PJAN1,PJAN2,PJAN3,PJAN4)
     SETCOLOR("B+/B")
     @ PJAN1,PJAN2,PJAN3,PJAN4 BOX "€€€€€€€€€"
     SETCOLOR(COR1)
     *@ PJAN1,PJAN2 TO PJAN3,PJAN4 DOUBLE
     SETCOLOR("W+/B")
     @ PJAN1,PJAN2 clear to PJAN1,PJAN4
     IF LEN(TRIM(PJAN5)) > 0
        @ PJAN1,PJAN2+(((PJAN4+1-PJAN2)-LEN(PJAN5))/2) SAY PJAN5
     SET COLOR TO W/N
     ENDIF



     FUNCTION PREVEW
     PARA PJAN1,PJAN2,PJAN3,PJAN4,PJAN5
     PAPEL="-"
     IF PCOUNT()<>5
        PJAN5=""
     ENDIF
     SOMBRA_MMS(PJAN1,PJAN2,PJAN3,PJAN4)
     SETCOLOR("G+/N")
     @ PJAN1,PJAN2,PJAN3,PJAN4 BOX "€€€€€€€€"+PAPEL
     SETCOLOR("N/N")
     @ PJAN1,PJAN2+2,PJAN3-1,PJAN4-1 BOX "€€€€€€€€€"
     SETCOLOR("W+/N")
     *@ PJAN1,PJAN2 TO PJAN3,PJAN4 DOUBLE
     SETCOLOR("W+/G")
     @ PJAN1,PJAN2 clear to PJAN1,PJAN4
     IF LEN(TRIM(PJAN5)) > 0
        @ PJAN1,PJAN2+(((PJAN4+1-PJAN2)-LEN(PJAN5))/2) SAY PJAN5
     SET COLOR TO W/N
     ENDIF

FUNCTION SOMBRA_MMS
PARA LIN_SUP,COL_SUP,LIN_INF,COL_INF
IF PCOUNT()=2 .OR. PCOUNT()=3
   C_SOM=COL_SUP
   L_SOM=LIN_SUP
   LIN_SUP=VAL(SUBS(C_SOM,1,2))
   COL_SUP=VAL(SUBS(C_SOM,3,2))
   LIN_INF=VAL(SUBS(C_SOM,5,2))
   COL_INF=VAL(SUBS(C_SOM,7,2))
   COL_SOM=SUBS(C_SOM,9)
   LIN_SOM=L_SOM
ENDIF
IF COL_SUP<2 .OR. LIN_INF>22
   C_SOM=""
   L_SOM=""
   RETURN .F.
ENDIF
IF PCOUNT()=3
   RESTSCREEN(LIN_SUP+1,COL_SUP-2,LIN_INF+1,COL_SUP-1,COL_SOM)
   RESTSCREEN(LIN_INF+1,COL_SUP-2,LIN_INF+2,COL_INF-2,LIN_SOM)
   RETURN .F.
ENDIF
IF PCOUNT()<>2
   COL_SOM=SAVESCREEN(LIN_SUP+1,COL_SUP-2,LIN_INF+1,COL_SUP-1)
   LIN_SOM=SAVESCREEN(LIN_INF+1,COL_SUP-2,LIN_INF+2,COL_INF-2)
ENDIF
COL_SOM=SUBS(COL_SOM,1,((LIN_INF-LIN_SUP)+1)*4)
LIN_SOM=SUBS(LIN_SOM,1,((COL_INF-COL_SUP)+1)*4)
*
IF SUBS(COL_SOM,2,1)<>CHR(8)
   C_SOM=STR(LIN_SUP,2)+STR(COL_SUP,2)+STR(LIN_INF,2)+STR(COL_INF,2)+COL_SOM
   L_SOM=LIN_SOM
ENDIF
FOR I=2 TO LEN(COL_SOM) STEP 2
   COL_SOM=STUFF(COL_SOM,I,1,CHR(8))

NEXT
FOR I=2 TO LEN(LIN_SOM)/2 STEP 2
   LIN_SOM=STUFF(LIN_SOM,I,1,CHR(8))

NEXT
RESTSCREEN(LIN_SUP+1,COL_SUP-2,LIN_INF+1,COL_SUP-1,COL_SOM)
RESTSCREEN(LIN_INF+1,COL_SUP-2,LIN_INF+2,COL_INF-2,LIN_SOM)
*
************************************************************
*
FUNCTION ENTRADA
SET CURSOR ON
SET COLOR TO G+
?REPL(" MMS-Editor ",200)
JANELA_MMS(02,05,20,75," MMS-Editor V.1.0 ")
Arquivo=space(45)
Private fontes[adir("*.*")]
Adir("*.*",fontes)
SETCOLOR ("b+/B")
FUNDO_MMS(04,08,16,25," ARQUIVOS ")
SET COLOR TO W
TIMBRE()
@ 23,00 SAY PADC(" Mova o cursor para vizualizar mais arquivos e/ou <ENTER> ",80) color ("W+/N")
@ 24,00 SAY PADC(" <ESC> : Retorna ao MS-Dos ",80)                 color ("RG+/N")
SETCOLOR ("w/n,W+/BG")
Escolha=achoice(05,10,15,24,Fontes)
SET COLOR TO W+
RETURN


function DESCANSO_MMS
SAVE SCREEN TO DESCANSO_TELA
do while.t.
set color to w
cls
set cursor off
a=0
l=0
c=0
**
**
If lastkey()=27
          EXIT
     Endif
for a=24 to -01 step -1
     inkey(.1)
     cls
     @ 00,78 say a color "G+/n"
     *
     @ l+1+a,c+00 say PADc("Empresa",80) color "w/n"
     @ l+2+a,c+00 say PADc("MMStec Artes Gr†ficas e Inform†tica.",80) color "W+/n"
     @ l+3+a,c+00 say PADc("//\\//\\//\\//\\//\\//\\//\\//\\//\\//",80) color "n+/n"
     NEXT
For a=23 to -23 step -1
     inkey(.1)
     cls
     @ 00,78 say a color "G+/n"
     *
     @ l+1+a,c+40 say PADc("Desenvolvido por:",38) color "w/n"
     @ l+2+a,c+40 say PADc("Marcos Morais de Sousa.",38) color "W+/n"
     @ l+3+a,c+40 say PADc("//\\//\\//\\//\\//\\//\\//\\//\\//\\//",38) color "n+/n"
     *
     *
     @ l+1+a,c say PADL("ConcepáÑo, ProgramaáÑo, Interface e",38) color "g/n"
     @ l+2+a,c say PADL("Tratamento de Imagens:",38) color "g/n"
     @ l+3+a,c say PADL("Por Marcos Morais de Sousa",38) color "g+/n"
     *
     @ l+5+a,c say PADL("ConcepáÑo de Imagens, Interface e",38) color "g/n"
     @ l+6+a,c say PADL("CoordenaáÑo Geral:",38) color "g/n"
     @ l+7+a,c say PADL("Por Marcos Morais de Sousa",38) color "g+/n"
     *
     @ l+9+a,c say PADL("Analise das funcoes,",38) color "g/n"
     @ l+10+a,c say PADL("Redacao e organizaáÑo",38) color "g/n"
     @ l+11+a,c say PADL("RevisÑo e correáÑo",38) color "g/n"
     @ l+12+a,c say PADL("Pesquisa",38) color "g/n"
     @ l+13+a,c say PADL("Marcos Morais de Sousa",38) color "g+/n"
     *
     @ l+15+a,c say PADL("Gerador",38) color "g/n"
     @ l+16+a,c say PADL("Mirro v.:2.22",38) color "g+/n"
     *
     @ l+18+a,c say PADL("Copilador",38) color "g/n"
     @ l+19+a,c say PADL("Clipper v.:5.00",38) color "g+/n"
     *
     @ l+21+a,c say Repl("ƒ",80) color "R+/n"
     @ l+22+a,c say PADc("MMStec Artes Graficas e Informatica Ltda.",80) color "g+/n"
     @ l+23+a,c say PADc("Fone: (073)525-5932 / FoneFax: (073)525-2344",80) color "g/n"
     *
     * ////////////////// coluna dois //////////////////////////////
     *
     *
     *
     @ l+7+a,c+40 say PADR("Desenvolvimento de Funáoes:",38) color "g/n"
     @ l+8+a,c+40 say PADR("Marcos Morais de Sousa",38) color "g+/n"
     *
     @ l+7+a,c+40 say PADR("DigitaáÑo",38) color "g/n"
     @ l+8+a,c+40 say PADR("Marcos Morais de Sousa",38) color "g+/n"
     *
     @ l+10+a,c+40 say PADR("Apoio",38) color "g/n"
     @ l+11+a,c+40 say PADR("MFB Materiais de ConstruáÑo Ltda.",38) color "g+/n"
     *
     @ l+13+a,c+40 say PADr("Atualizaáao e/ou alteraáÑo",38) color "g/n"
     @ l+14+a,c+40 say PADr("Marcos Morais de Sousa",38) color "g+/n"
     *
     @ l+16+a,c+40 say PADR("Agradecimentos muito especiais",38) color "g/n"
     @ l+17+a,c+40 say PADR("Jesus Cristo",38) color "g+/n"
     @ l+18+a,c+40 say PADR("Edson Silva Senna",38) color "g+/n"
     @ l+19+a,c+40 say PADR("Valdir Carlos de Jesus Barreto",38) color "g+/n"
     *
     @ l+24+a,c say REPL(".",80) color "N+/n"
     *
     Next
if lastkey()=27
     EXIT
     Endif
Enddo
RESTORE SCREEN FROM DESCANSO_TELA
RETURN.T.
RESTORE SCREEN FROM DESCANSO_TELA



FUNCTION LENTE
SET CURSOR OFF
SET COLOR TO W
a=0
b=0
c=0
d=0
sombra(a+05,b+12,c+06,d+72)
sombra(a+06,b+12,c+06,d+72)
sombra(a+07,b+12,c+07,d+72)
sombra(a+08,b+12,c+08,d+72)
sombra(a+09,b+12,c+09,d+72)
sombra(a+10,b+12,c+10,d+72)
sombra(a+11,b+12,c+11,d+72)
sombra(a+12,b+12,c+12,d+72)
sombra(a+13,b+12,c+13,d+72)
**
@ a+06,b+10 to c+15,d+70 color ("n+/n")
@ a+08,b+25 SAY PADC("/\/ M.M.S.tec  Utilit†rio /\/ ",30) COLOR "W+/N"
@ a+09,b+25 SAY PADC(" ------ versÑo 0.01 ------ ",28) COLOR "G+/N"
@ a+12,b+25 SAY PADC(" Jequie  - Bahia -  Brasil. ",27) COLOR ("G+/N")
@ a+13,b+20 SAY PADC(" ProduáÑo de Marcos Morais de Sousa. ",38) COLOR ("G+/N")
@ 19,00 say ""

   FUNCTION DATE_MMS(x,y)
   x=0
   y=0
   M->DIA=DATE()
   M->ANO=DATE()
   M->MES=DATE()
   *************
   SETCOLOR ("G+/N")
   @ x,y+00 SAY "Jequie,"
   @ x,y+09 SAY TRAN(DAY(M->DIA),"99 de")
   @ x,y+15 SAY SUBS("Janeiro   Fevereiro Maráo     Abril     Maio      Junho     Julho     Agosto    Setembro  Outubro   Novembro  Dezembro ",MONTH(M->MES)*10-9,10)
   @ x,y+25 SAY TRAN(YEAR(M->ANO),"de 9999.")
   @ x+1,00 SAY  REPL("ƒ",80) color "R+/N"
   *
   * @x,y+19 SAY TRAN(MONTH(M->MES),"99 de")
   *
   return


FUNCTION DATAS
*
M->DIA=DATE()
M->ANO=DATE()
M->MES=DATE()
SET COLOR TO G+/G
@ 14,15 CLEAR TO 16,55
@ 14,15 TO 16,55
SOMBRA(14,15,16,55)
SETCOLOR("W+/G")
@ 15,20 SAY "JequiÇ,"
@ 15,29 SAY TRAN(DAY(M->DIA),"99 de")
@ 15,35 SAY SUBS("Janeiro   Fevereiro Maráo     Abril     Maio      Junho     Julho     Agosto    Setembro  Outubro   Novembro  Dezembro ",MONTH(M->MES)*10-9,10)
@ 15,45 SAY TRAN(YEAR(M->ANO),"de 9999. ")
*
RETURN

 
* Final do programa UTILFUN.PRG