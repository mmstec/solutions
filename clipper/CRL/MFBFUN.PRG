
* TITULO     : *** Barreto ConstruáÑo ***
* DATA       : 17/04/97
* PROGRAMA   : MFBFUN.PRG
* COMENTARIO : FUNCOES

**
** Bloco de inseráÑo FUN.B01
**
FUNCTION T_DIR
COR("TITULO")
@ 00,69 SAY SPACE(11)
@ 00,75 SAY CHR(16)+CHR(16) COLOR("R*+/"+ALLTRIM(SUBS(CONTECOR[13],4)))
@ 00,72 SAY CHR(17)+CHR(17) COLOR("N+/"+ALLTRIM(SUBS(CONTECOR[13],4)))
KEYBOARD CHR(27)
BUFFER=CHR(4)+CHR(13)



FUNCTION T_ESQ
COR("TITULO")
@ 00,69 SAY SPACE(11)
@ 00,75 SAY CHR(16)+CHR(16) COLOR("N+/"+ALLTRIM(SUBS(CONTECOR[13],4)))
@ 00,72 SAY CHR(17)+CHR(17) COLOR("R+*/"+ALLTRIM(SUBS(CONTECOR[13],4)))
KEYBOARD CHR(27)
BUFFER=CHR(19)+CHR(13)
 
FUNCTION INDICES
*
* -> Funcao que cria arquivos indices
IF .NOT. FILE("AVIST001.NTX") .OR. PCOUNT()<>0
     IF .NOT. USEREDE("AVISTACM",.T.,10)
          @ 0,0 SAY ""
          BEEP()
          MENSAGEM("NÑo foi poss°vel acesso ao arquivo",5)
          SET COLOR TO W
          SET CURSOR OFF
          CLEAR
          QUIT
     ENDIF
     MENSAGEM("Organizando o arquivo AVIST001.NTX")
     INDEX ON NATADUPLIC TO AVIST001
ENDIF
IF .NOT. FILE("AVIST002.NTX") .OR. PCOUNT()<>0
     IF .NOT. USEREDE("AVISTALJ",.T.,10)
          @ 0,0 SAY ""
          BEEP()
          MENSAGEM("NÑo foi poss°vel acesso ao arquivo",5)
          SET COLOR TO W
          SET CURSOR OFF
          CLEAR
          QUIT
     ENDIF
     MENSAGEM("Organizando o arquivo AVIST002.NTX")
     INDEX ON DTOS(DATA) TO AVIST002
ENDIF
IF .NOT. FILE("AVIST003.NTX") .OR. PCOUNT()<>0
     IF .NOT. USEREDE("AVISTALJ",.T.,10)
          @ 0,0 SAY ""
          BEEP()
          MENSAGEM("NÑo foi poss°vel acesso ao arquivo",5)
          SET COLOR TO W
          SET CURSOR OFF
          CLEAR
          QUIT
     ENDIF
     MENSAGEM("Organizando o arquivo AVIST003.NTX")
     INDEX ON FORMAVENDA+OBSNUMERO TO AVIST003
ENDIF
IF .NOT. FILE("AVIST004.NTX") .OR. PCOUNT()<>0
     IF .NOT. USEREDE("AVISTALJ",.T.,10)
          @ 0,0 SAY ""
          BEEP()
          MENSAGEM("NÑo foi poss°vel acesso ao arquivo",5)
          SET COLOR TO W
          SET CURSOR OFF
          CLEAR
          QUIT
     ENDIF
     MENSAGEM("Organizando o arquivo AVIST004.NTX")
     INDEX ON NATADUPLIC TO AVIST004
ENDIF
IF .NOT. FILE("APRAZ005.NTX") .OR. PCOUNT()<>0
     IF .NOT. USEREDE("APRAZOCM",.T.,10)
          @ 0,0 SAY ""
          BEEP()
          MENSAGEM("NÑo foi poss°vel acesso ao arquivo",5)
          SET COLOR TO W
          SET CURSOR OFF
          CLEAR
          QUIT
     ENDIF
     MENSAGEM("Organizando o arquivo APRAZ005.NTX")
     INDEX ON NATADUPLIC TO APRAZ005
ENDIF
IF .NOT. FILE("APRAZ006.NTX") .OR. PCOUNT()<>0
     IF .NOT. USEREDE("APRAZOCM",.T.,10)
          @ 0,0 SAY ""
          BEEP()
          MENSAGEM("NÑo foi poss°vel acesso ao arquivo",5)
          SET COLOR TO W
          SET CURSOR OFF
          CLEAR
          QUIT
     ENDIF
     MENSAGEM("Organizando o arquivo APRAZ006.NTX")
     INDEX ON REFERENCIA+NOMECLIENT+DTOS(DATAVENDA)+DTOS(DATAVENCI)+DTOS(DATAPAGAM) TO APRAZ006
ENDIF
IF .NOT. FILE("APRAZ007.NTX") .OR. PCOUNT()<>0
     IF .NOT. USEREDE("APRAZOLJ",.T.,10)
          @ 0,0 SAY ""
          BEEP()
          MENSAGEM("NÑo foi poss°vel acesso ao arquivo",5)
          SET COLOR TO W
          SET CURSOR OFF
          CLEAR
          QUIT
     ENDIF
     MENSAGEM("Organizando o arquivo APRAZ007.NTX")
     INDEX ON NATADUPLIC TO APRAZ007
ENDIF
IF .NOT. FILE("APRAZ008.NTX") .OR. PCOUNT()<>0
     IF .NOT. USEREDE("APRAZOLJ",.T.,10)
          @ 0,0 SAY ""
          BEEP()
          MENSAGEM("NÑo foi poss°vel acesso ao arquivo",5)
          SET COLOR TO W
          SET CURSOR OFF
          CLEAR
          QUIT
     ENDIF
     MENSAGEM("Organizando o arquivo APRAZ008.NTX")
     INDEX ON REFERENCIA+NOMECLIENT+DTOS(DATAVENDA)+DTOS(DATAVENCI)+DTOS(DATAPAGAM) TO APRAZ008
ENDIF
IF .NOT. FILE("UNITA009.NTX") .OR. PCOUNT()<>0
     IF .NOT. USEREDE("UNITARIO",.T.,10)
          @ 0,0 SAY ""
          BEEP()
          MENSAGEM("NÑo foi poss°vel acesso ao arquivo",5)
          SET COLOR TO W
          SET CURSOR OFF
          CLEAR
          QUIT
     ENDIF
     MENSAGEM("Organizando o arquivo UNITA009.NTX")
     INDEX ON STR(RS_FIXO,10,2) TO UNITA009
ENDIF
IF .NOT. FILE("FICHA010.NTX") .OR. PCOUNT()<>0
     IF .NOT. USEREDE("FICHACLI",.T.,10)
          @ 0,0 SAY ""
          BEEP()
          MENSAGEM("NÑo foi poss°vel acesso ao arquivo",5)
          SET COLOR TO W
          SET CURSOR OFF
          CLEAR
          QUIT
     ENDIF
     MENSAGEM("Organizando o arquivo FICHA010.NTX")
     INDEX ON CODICPFCGC TO FICHA010
ENDIF
IF .NOT. FILE("FICHA011.NTX") .OR. PCOUNT()<>0
     IF .NOT. USEREDE("FICHACLI",.T.,10)
          @ 0,0 SAY ""
          BEEP()
          MENSAGEM("NÑo foi poss°vel acesso ao arquivo",5)
          SET COLOR TO W
          SET CURSOR OFF
          CLEAR
          QUIT
     ENDIF
     MENSAGEM("Organizando o arquivo FICHA011.NTX")
     INDEX ON NOMECPFCGC TO FICHA011
ENDIF
USE
**
** Bloco de inseráÑo FUN.B02
**
 
FUNCTION CGC
PARA C_GC
M->D_1=0
M->D_4=0
M->X_X=1
FOR M->CON_TA=1 TO LEN(M->C_GC)-2
     IF AT(SUBS(M->C_GC,M->CON_TA,1),"/-.")=0
          M->D_1=M->D_1+VAL(SUBS(M->C_GC,M->CON_TA,1))*(IIF(M->X_X<5,6,14)-M->X_X)
          M->D_4=M->D_4+VAL(SUBS(M->C_GC,M->CON_TA,1))*(IIF(M->X_X<6,7,15)-M->X_X)
          M->X_X=M->X_X+1
     ENDIF
NEXT
M->RES_TO=M->D_1-(INT(M->D_1/11)*11)
M->DIG_ITO=IIF(M->RES_TO<2,0,11-M->RES_TO)
M->D_4=M->D_4+2*M->DIG_ITO
M->RES_TO=M->D_4-(INT(M->D_4/11)*11)
M->DIG_ITO=VAL(STR(M->DIG_ITO,1)+STR(IIF(M->RES_TO<2,0,11-M->RES_TO),1))
IF DIG_ITO<>VAL(SUBS(M->C_GC,LEN(M->C_GC)-1,2))
     RETURN .F.
ELSE
     RETURN .T.
ENDIF
 
FUNCTION CIC
PARA C_IC
M->D_1=0
M->D_2=0
M->X_X=1
FOR M->CON_TA=1 TO LEN(M->C_IC)-2
     IF AT(SUBS(M->C_IC,M->CON_TA,1),"/-.")=0
          M->D_1=M->D_1+(11-M->X_X)*VAL(SUBS(M->C_IC,M->CON_TA,1))
          M->D_2=M->D_2+(12-M->X_X)*VAL(SUBS(M->C_IC,M->CON_TA,1))
          M->X_X=M->X_X+1
     ENDIF
NEXT
M->RES_TO=M->D_1-(INT(M->D_1/11)*11)
M->DIG_ITO=IIF(M->RES_TO<2,0,11-M->RES_TO)
M->D_2=M->D_2+2*M->DIG_ITO
M->RES_TO=M->D_2-(INT(M->D_2/11)*11)
M->DIG_ITO=VAL(STR(M->DIG_ITO,1)+STR(IIF(M->RES_TO<2,0,11-M->RES_TO),1))
IF M->DIG_ITO<>VAL(SUBS(M->C_IC,LEN(M->C_IC)-1,2))
     RETURN .F.
ELSE
     RETURN .T.
ENDIF

FUNCTION SET_CONF
PRIVATE CFG_X,CFG_Y,CFG_COR,TEL_CONF,TEC_CONF
SET KEY -5 TO
M->CFG_X=ROW()
M->CFG_Y=COL()
M->CFG_COR=SETCOLOR()
L_CFG=L_SOM
C_CFG=C_SOM
SOMBRA(L_SOM,C_SOM,.T.)
M->TEL_CONF=SAVESCREEN(06,16,19,62)
SET CURSOR OFF
JANELA(06,18,18,62,"ConfiguraáÑo")
COR("MENU")
@ 09,23 CLEAR TO 13,57
BOTAO(15,44,"Esc")
DO WHILE .T.
     BOTAO(15,27,"Enter")
     SETCOLOR(CONTECOR[2]+","+CONTECOR[7])
     @ 10,25 PROMPT "["+IIF(CNF_CON,"x"," ")+"] ConfirmaáÑo para entradas  "
     @ 11,25 PROMPT "["+IIF(CNF_REP,"x"," ")+"] RepetiáÑo de registros     "
     @ 12,25 PROMPT "["+IIF(CNF_DEL="  "," ","x")+"] Delimitadores para entradas"
     MENU TO M->TEC_CONF
     IF M->TEC_CONF=0
          BOTAO(15,44,"Esc",-2)
          EXIT
     ELSE
          BOTAO(15,27,"Enter",-2)
     ENDIF
     IF M->TEC_CONF=1
          M->CNF_CON=IIF(M->CNF_CON,.F.,.T.)
          IF M->CNF_CON
               SET CONFIRM ON
          ELSE
               SET CONFIRM OFF
          ENDIF
     ELSEIF M->TEC_CONF=2
          M->CNF_REP=IIF(M->CNF_REP,.F.,.T.)
          M->CNF_XXX=IIF(M->CNF_REP,.F.,.T.)
     ELSEIF M->TEC_CONF=3
          M->CNF_DEL=IIF(M->CNF_DEL="  ","[]","  ")
          IF M->CNF_DEL="  "
               SET DELIMITERS OFF
          ELSE
               SET DELIMITERS ON
               SET DELIMITERS TO M->CNF_DEL
          ENDIF
     ENDIF
ENDDO
RESTSCREEN(06,16,19,62,M->TEL_CONF)
SETCOLOR(M->CFG_COR)
ON_CURSOR()
SOMBRA(L_CFG,C_CFG)
@ M->CFG_X,M->CFG_Y SAY ""
SET KEY -5 TO SET_CONF
 
FUNCTION HELP_TEC
*
* -> Monta HELP das teclas com caracteres acentuados
L_THEL=L_SOM
C_THEL=C_SOM
SOMBRA(L_THEL,C_THEL,.T.)
M->THEL_COR=SETCOLOR()
M->TEL_HPTC=SAVESCREEN(02+LIN_MENU,06,22+LIN_MENU,71)
M->THEL_X=ROW()
M->THEL_Y=COL()
SET CURSOR OFF
JANELA(02+LIN_MENU,08,21+LIN_MENU,71,"Teclas com caracteres acentuados")
COR("MENU")
@ 04+LIN_MENU,11 SAY "⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø"
@ 05+LIN_MENU,11 SAY "≥ Tecla   Caracter ≥ Tecla   Caracter ≥ Tecla   Caracter ≥"
@ 06+LIN_MENU,11 SAY "√ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥"
@ 07+LIN_MENU,11 SAY "≥ Shift F2    é    ≥ Ctrl F1     ê    ≥ Alt F1      ¢    ≥"
@ 08+LIN_MENU,11 SAY "≥ Shift F3    è    ≥ Ctrl F2     Ç    ≥ Alt F2      ô    ≥"
@ 09+LIN_MENU,11 SAY "≥ Shift F4    Ñ    ≥ Ctrl F3     à    ≥ Alt F3      î    ≥"
@ 10+LIN_MENU,11 SAY "≥ Shift F5    †    ≥ Ctrl F4     â    ≥ Alt F4      ï    ≥"
@ 11+LIN_MENU,11 SAY "≥ Shift F6    Ö    ≥ Ctrl F5     ä    ≥ Alt F5      £    ≥"
@ 12+LIN_MENU,11 SAY "≥ Shift F7    Ü    ≥ Ctrl F6     °    ≥ Alt F6      ö    ≥"
@ 13+LIN_MENU,11 SAY "≥ Shift F8    É    ≥ Ctrl F7     ã    ≥ Alt F7      Å    ≥"
@ 14+LIN_MENU,11 SAY "≥ Shift F9    Ä    ≥ Ctrl F8     å    ≥ Alt F8      ñ    ≥"
@ 15+LIN_MENU,11 SAY "≥ Shift F10   á    ≥ Ctrl F9     ç    ≥ Alt F9      ¶    ≥"
@ 16+LIN_MENU,11 SAY "≥                  ≥ Ctrl F10    ì    ≥ Alt F10     ß    ≥"
@ 17+LIN_MENU,11 SAY "¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ"
BOTAO(19+LIN_MENU,35,"Esc")
DO WHILE INKEY(0)<>27
ENDDO
BOTAO(19+LIN_MENU,35,"Esc",-2)
RESTSCREEN(02+LIN_MENU,06,22+LIN_MENU,71,M->TEL_HPTC)
SETCOLOR(M->THEL_COR)
ON_CURSOR()
SOMBRA(L_THEL,C_THEL)
@ M->THEL_X,M->THEL_Y SAY ""
 
FUNCTION CGETS
*
* -> Funcao para chamada de consulta em outro arquivo
KEYBOARD CHR(13)
M->TEC_F2=.T.
 
FUNCTION EDIT_ARQ
PARA E_DITAR
IF E_DITAR=.F. .OR. M->TEC_F2
     GOTO TOP
     M->TEC_F2=.F.
     M->RETOR_NO=.F.
     L_PSQ=L_SOM
     C_PSQ=C_SOM
     SOMBRA(L_SOM,C_SOM,.T.)
     SAVE SCREEN TO M->T_ELA
     JANELA(04,03,20,78)
     BOTAO(18,18,"Procura")
     BOTAO(18,36,"Trecho")
     BOTAO(18,54,"Continua")
     COR("MENU")
     @ 06,06 CLEAR TO 16,75
     @ 06,06 TO 08,75
     @ 08,06 TO 16,75
     @ 08,06 SAY "√"
     @ 08,75 SAY "¥"
     SET KEY -1 TO
     KEYBOARD CHR(65)
     DECLARE PSQ_NOME[FCOUNT()],PSQ_TIPO[FCOUNT()],PSQ_TAM[FCOUNT()],PSQ_DEC[FCOUNT()]
     AFIELDS(PSQ_NOME,PSQ_TIPO,PSQ_TAM,PSQ_DEC)
     FOR F_PSQ=1 TO LEN(PSQ_NOME)
          PSQ_NOME[F_PSQ]=SUBS(PSQ_NOME[F_PSQ],1,1)+LOWER(SUBS(PSQ_NOME[F_PSQ],2))
     NEXT
     DBEDIT(07,07,16,74,.T.,"LER_ARQ",.T.,PSQ_NOME,"ƒ¬ƒ"," ≥ ","ƒ¡ƒ")
     SET KEY -1 TO CGETS
     RESTORE SCREEN FROM M->T_ELA
     SOMBRA(L_PSQ,C_PSQ)
     COR("GETS")
ENDIF
 
FUNCTION LER_ARQ
*
* -> Funcao de usuario para DBEDIT
PARA P_MODO,P_CAMPO
IF M->P_MODO=3
     COR("BOX DA JANELA DE DIALOGO")
     @ 09,25,13,54 BOX " "
     @ 09,25 SAY "˛"
     COR("JANELA DE DIALOGO")
     @ 10,26 CLEAR TO 12,53
     @ 11,33 SAY "Arquivo  vazio"
     BEEP()
     INKEY(4)
     COR("MENU")
     RETURN 0
ENDIF
M->TEC_PSQ=UPPER(CHR(LASTKEY()))
IF M->TEC_PSQ="P"
     BOTAO(18,18,"Procura",-2)
     BOTAO(18,18,"Procura")
ELSEIF M->TEC_PSQ="C"
     BOTAO(18,54,"Continua",-2)
     BOTAO(18,54,"Continua")
ELSEIF M->TEC_PSQ="T"
     BOTAO(18,36,"Trecho",-2)
     BOTAO(18,36,"Trecho")
ENDIF
IF LASTKEY()=27 .OR. LASTKEY()=13
     COR("MENU")
     RETURN 0
ELSEIF M->TEC_PSQ="P" .OR. M->TEC_PSQ="C" .OR. M->TEC_PSQ="T"
     IF M->TEC_PSQ<>"C"
          SAVE SCREEN
          M->PSQ_POS=(80-(PSQ_TAM[M->P_CAMPO]+4))/2
          IF PSQ_TAM[M->P_CAMPO]>50 .OR. PSQ_TIPO[M->P_CAMPO]="M"
               COR("BOX DA JANELA DE DIALOGO")
               @ 09,13,13,66 BOX " "
               @ 09,13 SAY "˛"
               COR("JANELA DE DIALOGO")
               @ 10,15 CLEAR TO 12,65
          ELSEIF M->PSQ_POS<25
               COR("BOX DA JANELA DE DIALOGO")
               @ 09,M->PSQ_POS,13,M->PSQ_POS+PSQ_TAM[M->P_CAMPO]+3 BOX " "
               @ 09,M->PSQ_POS SAY "˛"
               COR("JANELA DE DIALOGO")
               @ 10,M->PSQ_POS+1 CLEAR TO 12,M->PSQ_POS+PSQ_TAM[M->P_CAMPO]+2
          ELSE
               COR("BOX DA JANELA DE DIALOGO")
               @ 09,25,13,54 BOX " "
               @ 09,25 SAY "˛"
               COR("JANELA DE DIALOGO")
               @ 10,26 CLEAR TO 12,53
          ENDIF
          COR("BOX DA JANELA DE DIALOGO")
          @ 09,(80-LEN(TRIM(PSQ_NOME[M->P_CAMPO])))/2 SAY PSQ_NOME[M->P_CAMPO]
          COR("BOTAO EM DESTAQUE")
          SET CURSOR ON
          IF PSQ_TAM[M->P_CAMPO]>50
               M->PRO_CURA=VAR_GET(11,15,PSQ_TAM[M->P_CAMPO])
          ELSEIF PSQ_TIPO[M->P_CAMPO]="M"
               M->PRO_CURA=VAR_GET(11,15,200)
          ELSE
               M->PRO_CURA=VAR_GET(11,M->PSQ_POS+2,PSQ_TAM[M->P_CAMPO])
          ENDIF
          KEYBOARD CHR(65)
          SET CURSOR OFF
          RESTORE SCREEN
          M->REG_ATU=RECN()
          GOTO TOP
     ELSE
          M->REG_ATU=RECN()
     ENDIF
     IF M->TEC_PSQ="C"
          IF M->ULT_PSQ="P"
               M->TEC_PSQ="CP"
          ELSE
               M->TEC_PSQ="CT"
          ENDIF
     ELSE
          M->ULT_PSQ=M->TEC_PSQ
     ENDIF
     COR("MENU")
     DO WHILE .NOT. EOF()
          M->SUB_CAMPO=PSQ_NOME[M->P_CAMPO]
          M->PRO_CURA=UPPER(M->PRO_CURA)
          IF M->TEC_PSQ="P" .OR. (M->TEC_PSQ="CP" .AND. M->REG_ATU<>RECN())
               IF PSQ_TIPO[M->P_CAMPO]="N"
                    IF &SUB_CAMPO=VAL(M->PRO_CURA)
                         KEYBOARD CHR(65)
                         RETURN 1
                    ENDIF
               ELSEIF PSQ_TIPO[M->P_CAMPO]="D"
                    IF DTOC(&SUB_CAMPO)=M->PRO_CURA
                         KEYBOARD CHR(65)
                         RETURN 1
                    ENDIF
               ELSEIF PSQ_TIPO[M->P_CAMPO]="C"
                    M->CMP_MEMO=UPPER(&SUB_CAMPO)
                    IF M->CMP_MEMO=M->PRO_CURA
                         KEYBOARD CHR(65)
                         RETURN 1
                    ENDIF
               ELSEIF PSQ_TIPO[M->P_CAMPO]="T"
                    IF IIF(&SUB_CAMPO,"T","F")=M->PRO_CURA
                         KEYBOARD CHR(65)
                         RETURN 1
                    ENDIF
               ELSEIF PSQ_TIPO[M->P_CAMPO]="M"
                    M->CMP_MEMO=UPPER(&SUB_CAMPO)
                    IF M->CMP_MEMO=M->PRO_CURA
                         KEYBOARD CHR(65)
                         RETURN 1
                    ENDIF
               ENDIF
          ELSEIF M->TEC_PSQ="T" .OR. (M->TEC_PSQ="CT" .AND. M->REG_ATU<>RECN())
               IF PSQ_TIPO[M->P_CAMPO]="N"
                    IF AT(M->PRO_CURA,STR(&SUB_CAMPO,PSQ_TAM[M->P_CAMPO],PSQ_DEC[M->P_CAMPO]))<>0
                         KEYBOARD CHR(65)
                         RETURN 1
                    ENDIF
               ELSEIF PSQ_TIPO[M->P_CAMPO]="D"
                    IF AT(M->PRO_CURA,DTOC(&SUB_CAMPO))<>0
                         KEYBOARD CHR(65)
                         RETURN 1
                    ENDIF
               ELSEIF PSQ_TIPO[M->P_CAMPO]="C"
                    M->CMP_MEMO=UPPER(&SUB_CAMPO)
                    IF AT(M->PRO_CURA,M->CMP_MEMO)<>0
                         KEYBOARD CHR(65)
                         RETURN 1
                    ENDIF
               ELSEIF PSQ_TIPO[M->P_CAMPO]="T"
                    IF IIF(&SUB_CAMPO,"T","F")=M->PRO_CURA
                         KEYBOARD CHR(65)
                         RETURN 1
                    ENDIF
               ELSEIF PSQ_TIPO[M->P_CAMPO]="M"
                    M->CMP_MEMO=UPPER(&SUB_CAMPO)
                    IF AT(M->PRO_CURA,M->CMP_MEMO)<>0
                         KEYBOARD CHR(65)
                         RETURN 1
                    ENDIF
               ENDIF
          ENDIF
          SKIP
     ENDDO
     GOTO M->REG_ATU
     SAVE SCREEN
     COR("BOX DA JANELA DE DIALOGO")
     @ 09,25,13,54 BOX " "
     @ 09,25 SAY "˛"
     COR("JANELA DE DIALOGO")
     @ 10,26 CLEAR TO 12,53
     @ 11,30 SAY "Dados nÑo encontrados"
     BEEP()
     INKEY(.1)
     INKEY(3)
     COR("MENU")
     RESTORE SCREEN
ENDIF
RETURN 1

FUNCTION VAR_GET
*
* -> Simula um GET
PARA GET_X,GET_Y,GET_TAM
M->GET_VAR=""
M->TEC_GET=0
IF M->GET_TAM<50
     @ M->GET_X,M->GET_Y SAY SPACE(M->GET_TAM)
ELSE
     @ M->GET_X,M->GET_Y SAY SPACE(50)
ENDIF
DO WHILE .T.
     IF LEN(M->GET_VAR)<50
          @ M->GET_X,M->GET_Y SAY M->GET_VAR
     ELSE
          @ M->GET_X,M->GET_Y SAY SUBS(M->GET_VAR,LEN(M->GET_VAR)-48,50)
     ENDIF
     IF LEN(M->GET_VAR) = M->GET_TAM
          RETURN M->GET_VAR
     ENDIF
     M->TEC_GET=INKEY(0)
     IF M->TEC_GET=27
          RETURN ""
     ELSEIF M->TEC_GET=13
          RETURN M->GET_VAR
     ELSEIF M->TEC_GET=8 .OR. M->TEC_GET=19 .OR. M->TEC_GET=7
          IF LEN(M->GET_VAR)>0
               M->GET_VAR=SUBS(M->GET_VAR,1,LEN(M->GET_VAR)-1)
               IF LEN(M->GET_VAR)<50
                    @ M->GET_X,M->GET_Y SAY M->GET_VAR+" "
               ENDIF
          ENDIF
     ELSE
          M->GET_VAR = M->GET_VAR + CHR(M->TEC_GET)
     ENDIF
ENDDO
 
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
         @ LIN_BOT,COL_BOT-1 SAY ">"+NOM_BOT+"<"
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
 
FUNCTION EDITOR
*
* -> Funcao que edita campos do tipo "MEMO"
IF M->ME_MO <> "[memo]"
     M->ME_MO = "[memo]"
     RETURN .F.
ENDIF
IF PCOUNT()=2
     M->ALTE_RA=.T.
     PARA ME_VAR,ME_COM
ELSE
     PARA ME_VAR,ME_COM,ALTE_RA
ENDIF
IF LASTKEY() = 13 .OR. .NOT. M->ALTE_RA
     SAVE SCREEN TO TELA
     L_EDITOR=L_SOM
     C_EDITOR=C_SOM
     SOMBRA(L_SOM,C_SOM,.T.)
     MENSAGEM("Tecle <ESC> para finalizar a ediáÑo")
     JANELA(5,02,21,77,ALLTRIM(M->ME_COM))
     @ 21,05 SAY "Linha"
     @ 21,19 SAY "Coluna"
     M->INS_ERT = READINSERT()
     IF M->INS_ERT
          @ 21,31 SAY "Insert"
     ENDIF
     M->ME_VAR = MEMOEDIT(M->ME_VAR,6,03,20,76,M->ALTE_RA,"FUNMEMO")
     COR("GETS")
     L_SOM=L_EDITOR
     C_SOM=C_EDITOR
     RESTORE SCREEN FROM TELA
ENDIF
RETURN .T.

FUNCTION FUNMEMO
*
* -> Funcao de usuario para campo memo
PARA MODO,LINHA,COLUNA
IF LASTKEY() = 27 .AND. M->ALTE_RA
     BEEP()
     IF PERG("Confirma atualizaáÑo do campo memo ?") = "S"
          MENSAGEM("Tecle <ESC> para retornar")
          RETURN 23
     ELSE
          MENSAGEM("Tecle <ESC> para retornar")
          RETURN 27
     ENDIF
ENDIF
COR("BOX DA JANELA DE DIALOGO")
IF LASTKEY() = 22 .AND. M->ALTE_RA
     IF M->INS_ERT
          M->INS_ERT = .F.
          @ 21,31 SAY "      "
     ELSE
          M->INS_ERT = .T.
          @ 21,31 SAY "Insert"
     ENDIF
ENDIF
@ 21,11 SAY STRZERO(M->LINHA,5)
@ 21,26 SAY STRZERO(M->COLUNA+1,2)
COR("JANELA DE DIALOGO")
RETURN 0

FUNCTION SENHA
*
*
* -> Funcao para entrada e checagem de senha
COR("TITULO")
@ 24,00 SAY SPACE(80)
MENSAGEM("Digite seu nome")
SOMBRA(16,02,16,32)
SETCOLOR("W+/bG")
@ 16,00 SAY "Nome     :"               COLOR("w+/n")
@ 17,00 SAY "Senha    :  [˙˙˙˙˙˙˙˙˙]"   COLOR("W+/n")
SOMBRA(16,02,16,32)
M->SENHA=""
M->OPERADOR=SPACE(20)
M->TEC=0
****
SET COLOR TO G+/N,G+/N,,,G+/N
@ 16,12 GET M->OPERADOR PICT "@!" VALID .NOT. EMPTY(M->OPERADOR)
SET CURSOR ON
READ
****-----------------------------------------*
SETCOLOR("W/"+ALLTRIM(SUBS(CONTECOR[13],4)))
@ 24,70 SAY PADL(M->OPERADOR,20)
****-----------------------------------------*
SET CURSOR OFF
MENSAGEM("Digite a senha para acesso ao sistema")
SETCOLOR("G+/N")
SOMBRA(15,02,15,32)
@ 17,00 SAY "Senha    :  [˙˙˙˙˙˙˙˙˙]"   COLOR("w+/n")
@ 17,13 SAY "˙˙˙˙˙˙˙˙˙"                 COLOR("N+*/n")
FOR M->P_SENHA=13 TO 21
   M->TEC=INKEY(0)
   IF M->TEC=8
      IF M->P_SENHA>12
         M->P_SENHA=M->P_SENHA-1
         @ 17,M->P_SENHA SAY "˙"        COLOR("G+*/n")
         M->SENHA=SUBS(M->SENHA,1,LEN(M->SENHA)-1)
      ENDIF
      M->P_SENHA=M->P_SENHA-1
   ELSE
      M->SENHA=M->SENHA+CHR(M->TEC)
      IF M->TEC=13 .OR. M->TEC=27
         EXIT
      ENDIF
      @ 17,M->P_SENHA SAY CHR(4)
      ENDIF
NEXT
M->SENHA=UPPER(M->SENHA)
COD_FICA(@SENHA)
M->NOM_ARQ="MFB.SNH"
IF .NOT. FILE(M->NOM_ARQ)
   SET CURSOR OFF
   BEEP()
   MENSAGEM("Arquivo de senhas nÑo se encontra dispon°vel",3)
   SET COLOR TO W
   SET CURSOR ON
   CLEAR
   QUIT
ENDIF
IF .NOT. USEREDE(M->NOM_ARQ,.F.,10)
   BEEP()
   MENSAGEM("Acesso mal sucedido ao arquivo",3)
   RETURN .F.
ENDIF
GOTO TOP
M->NIVEL=" "
DO WHILE .NOT. EOF()
   IF CODSENHA==M->SENHA .AND. USUARIO==M->OPERADOR
      M->NIVEL=ACESSO
      EXIT
   ENDIF
   SKIP
ENDDO
MENSAGEM("Aguarde tentativa de acesso aos arquivos")
          COR("TITULO")
          @ 23,00,23,80 box "         "
          @ 23,01 say REPL(chr(7),78) COLOR("N/"+ALLTRIM(SUBS(CONTECOR[13],4)))
          *
          for a=01 to 78 step +2
               inkey(.01)
               *@ 23,00 clear to 23,80
               *@ 23,01 say REPL(chr(7),78) COLOR("N/"+ALLTRIM(SUBS(CONTECOR[13],4)))
               @ 23,00+A say chr(7)   COLOR("rg+/"+ALLTRIM(SUBS(CONTECOR[13],4)))
               @ 23,01+A say chr(7)   COLOR("rg+/"+ALLTRIM(SUBS(CONTECOR[13],4)))
               *
               @ 19,00 to 21,11        COLOR("B+/"+ALLTRIM(SUBS(CONTECOR[13],4)))
               SOMBRA(19,00,21,11)
               @ 20,01 SAY A           COLOR("W+/"+ALLTRIM(SUBS(CONTECOR[13],4)),"w+/B")
               Next
               Tone(800,1)
               @ 20,01 SAY PADL("100 %",10) COLOR("RG+/"+ALLTRIM(SUBS(CONTECOR[13],4)))
               *
Tone(500,3)
USE
SET CURSOR ON
RETURN M->NIVEL

FUNCTION PESENHA
*
* -> Pesquisa a existencia de uma senha ou de um usuario
PARA PAR1,PAR2,PAR3,PAR4
M->NOM_ARQ="MFB.SNH"
IF .NOT. USEREDE(M->NOM_ARQ,.F.,10)
     BEEP()
     MENSAGEM("Acesso mal sucedido ao arquivo",3)
     RETURN .F.
ENDIF
GOTO TOP
DO WHILE .NOT. EOF()
     IF M->PAR1="C" .AND. M->PAR2=CODSENHA
          RETURN .T.
     ENDIF
     IF M->PAR1="U" .AND. M->PAR2=USUARIO
          IF M->PAR3
               BEEP()
               MENSAGEM(M->PAR4,3)
               MENSAGEM("Tecle <ESC> para retornar")
          ENDIF
          SET COLOR TO N/W,W+/R,,,N/W
          RETURN .T.
     ENDIF
     SKIP
ENDDO
USE
IF M->PAR1="U"
     IF .NOT. M->PAR3
          BEEP()
          MENSAGEM(M->PAR4,3)
          MENSAGEM("Tecle <ESC> para retornar")
     ENDIF
ENDIF
SET COLOR TO N/W,W+/R,,,N/W
RETURN .F.

FUNCTION COD_FICA
*
* -> Codifica um senha
PARA CODI_GO
IF LEN(M->SENHA)<9
M->SENHA=M->SENHA+SPACE(9-LEN(M->SENHA))
ENDIF
M->COD=M->CODI_GO
M->CODI_GO=""
FOR M->X=9 TO 1 STEP -1
M->CODI_GO=M->CODI_GO+SUBS(M->COD,M->X,1)
NEXT
M->CODI_GO=SUBS(M->CODI_GO,4,3)+SUBS(M->CODI_GO,1,3)+SUBS(M->CODI_GO,7,3)
M->COD=""
FOR M->X=1 TO 9
     IF M->X/2=INT(M->X/2)
          IF ASC(SUBS(M->CODI_GO,M->X,1))=255
               M->COD=M->COD+CHR(0)
          ELSE
               M->COD=M->COD+CHR(ASC(SUBS(M->CODI_GO,M->X,1))+1)
          ENDIF
     ELSE
          IF ASC(SUBS(M->CODI_GO,M->X,1))=0
               M->COD=M->COD+CHR(255)
          ELSE
               M->COD=M->COD+CHR(ASC(SUBS(M->CODI_GO,M->X,1))-1)
          ENDIF
     ENDIF
NEXT
M->CODI_GO=M->COD

FUNCTION NIV_ACES
*
* -> Discrimina o nivel de acesso
PARA PARX
IF M->ACESSO="1"
     @ M->PARX,42 SAY "- Operacional"
ELSEIF M->ACESSO="2"
     @ M->PARX,42 SAY "- Gerencial  "
ELSEIF M->ACESSO="3"
     @ M->PARX,42 SAY "- Executivo  "
ELSE
     BEEP()
     @ M->PARX,42 SAY "-            "
     MENSAGEM("Os n°veis de acesso sÑo: 1, 2 ou 3",3)
     RETURN .F.
ENDIF
RETURN .T.

FUNCTION GET_COD
*
* -> Permite editar uma senha na posicao desejada
*    retornando a senha codificada
PARA PARX,PARY
SETCOLOR(CONTECOR[3])
@ M->PARX,M->PARY SAY "[˙˙˙˙˙˙˙˙˙]"
M->SENHA=""
M->TEC=0
SET CURSOR OFF
FOR M->P_SENHA=1 TO 9
     M->TEC=INKEY(0)
     IF M->TEC=8
          IF M->P_SENHA>1
               M->P_SENHA=M->P_SENHA-1
               @ M->PARX,M->PARY+M->P_SENHA SAY "˙"
               M->SENHA=SUBS(M->SENHA,1,LEN(M->SENHA)-1)
          ENDIF
          M->P_SENHA=M->P_SENHA-1
     ELSE
          M->SENHA=M->SENHA+CHR(M->TEC)
          IF M->TEC=13 .OR. M->TEC=27
               EXIT
          ENDIF
          @ M->PARX,M->PARY+M->P_SENHA SAY "˛"
     ENDIF
NEXT
IF M->TEC=27
     RETURN CHR(27)
ENDIF
M->SENHA=UPPER(M->SENHA)
COD_FICA(@SENHA)
SET CURSOR ON
RETURN M->SENHA
 
FUNCTION BEEP
*
* -> Emite um sinal sonoro
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
*
* -> Ativa o cursor caso exista um get pendente
M->GET_VAR=READVAR()
IF LEN(M->GET_VAR)>0 .AND. M->GET_VAR<>"MENU_OPC"
     SET CURSOR ON
ENDIF
 
* /////////////////////////////////////////////////////////////////////////*
*
* -> Inicio da funcao que imprime mensagens na tela
*
FUNCTION MENSAGEM
IF OPTELA = "43X80"
   LM     = 42 
ELSE   
   LM     = 24
ENDIF

COR_MENS=SETCOLOR("W+/R")
COR("TITULO")
SET CURSOR OFF
IF PCOUNT()=0
   
   @ LM,11 SAY SPACE(58)
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
@ LM,10 SAY SPACE(60)
@ LM,(80-LEN(TEX_TO+RTRIM(M->OPERADOR)))/2 SAY RTRIM(M->OPERADOR)+", "+TEX_TO
IF M->PAUSA<>0
   M->X=INKEY(M->PAUSA)
ENDIF
TONE(850,1)
SETCOLOR(COR_MENS)
ON_CURSOR()
RETURN .T.
*
* -> Final da funcao que imprime mensagens na tela
*
* /////////////////////////////////////////////////////////////////////////*
 
FUNCTION DELE_TAR
RETURN IIF(DELETED(),chr(4)," ")
 
FUNCTION PERGUNTA
*
* -> Funcao que executa uma pergunta
PER_COR=SETCOLOR("G+/N")
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
SETCOLOR("G/N")
@ 09,COL_SUP CLEAR TO 12,COL_INF
@ 09,COL_SUP TO 12,COL_INF  DOUBLE
SOMBRA(08,COL_SUP,12,COL_INF)
@ 10,(80-LEN(TEX_TO+RTRIM(M->OPERADOR)))/2 SAY RTRIM(M->OPERADOR)+", "+TEX_TO COLOR("W+/N")
DO WHILE .T.
   @ 11,32 PROMPT PADC(" Sim ",5)
   @ 11,37 SAY    PADC(" ou " ,4)
   @ 11,41 PROMPT PADC(" NÑo ",5)
   MENU TO M->SIM_NAO
   IF M->SIM_NAO<>0
      EXIT
   ENDIF
ENDDO
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
*
* Funcao de usuario para achoice
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
      MEN_U[M->X_X]=REPL("˘",M->LAR_G)
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
         @ LIN_MENU+MENU_OPC+2,COL() SAY MEN_U[MENU_OPC]
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
   MENU_CFG[3]="     ("+CHR(7)+") HARD DISK "
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
**
Tec1="€ﬂﬂ€ﬂﬂ€ €ﬂﬂ€ﬂﬂ€ €ﬂﬂﬂﬂﬂ€   ‹  Inform†tica Ltda"
Tec2="€  €  € €  €  € €‹‹‹‹‹‹‹ ﬂ€ﬂ €ﬂﬂﬂﬂﬂ€ €ﬂﬂﬂﬂﬂﬂ€"
Tec3="€€ €  € €€ €  € ‹     €€  €€ €€ﬂﬂﬂﬂﬂ €€     ‹"
Tec4="€€ €  € €€ €  € ﬂﬂﬂﬂﬂﬂﬂﬂ  ﬂﬂ ﬂﬂﬂﬂﬂﬂﬂ ﬂﬂﬂﬂﬂﬂﬂﬂ"
Tec5="ﬂﬂ    ﬂﬂﬂﬂ    ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ"
**
SET CURSOR OFF
FOR CONTADOR=0 TO LEN(tec1)+5 STEP +5
  SETCOLOR("B+ /N")
  @ 10,(80-LEN(tec1))/2 Say PADR(SUBSTR(tec1,1,CONTADOR),LEN(tec1))
  SETCOLOR("B  /N")
  @ 11,(80-LEN(tec2))/2 Say PADC(SUBSTR(tec2,1,CONTADOR),LEN(tec2))
  SETCOLOR("BG /N")
  @ 12,(80-LEN(tec3))/2 SAY PADL(SUBSTR(tec3,1,CONTADOR),LEN(tec3))
  SETCOLOR("BG+/N")
  @ 13,(80-LEN(tec4))/2 SAY PADC(SUBSTR(tec4,1,CONTADOR),LEN(tec4))
  SETCOLOR("W  /N")
  @ 14,(80-LEN(tec5))/2 SAY PADR(SUBSTR(tec5,1,CONTADOR),LEN(tec5))
  INKEY(0.01)
NEXT
INKEY(1)
FOR CONTADOR=LEN(tec1)+5 TO 0 STEP -5
  SETCOLOR("B+ /N")
  @ 10,(80-LEN(tec1))/2 Say PADR(SUBSTR(tec1,1,CONTADOR),LEN(tec1))
  SETCOLOR("B  /N")
  @ 11,(80-LEN(tec2))/2 Say PADC(SUBSTR(tec2,1,CONTADOR),LEN(tec2))
  SETCOLOR("BG /N")
  @ 12,(80-LEN(tec3))/2 SAY PADL(SUBSTR(tec3,1,CONTADOR),LEN(tec3))
  SETCOLOR("BG+/N")
  @ 13,(80-LEN(tec4))/2 SAY PADC(SUBSTR(tec4,1,CONTADOR),LEN(tec4))
  SETCOLOR("W  /N")
  @ 14,(80-LEN(tec5))/2 SAY PADR(SUBSTR(tec5,1,CONTADOR),LEN(tec5))
  INKEY(0.01)
NEXT
SET CURSOR ON
**
@ 06,05 say PADC("M.F.B. Material de ConstruáÑo Ltda.",69)      Color ("w+/N")
DTTA(07,00)
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
****------------------------------------------------------------------------*
@ 00,68 SAY " Abrindo..."         COLOR("R+/"+ALLTRIM(SUBS(CONTECOR[13],4)))
@ 24,70 SAY DATE()                COLOR("R+/"+ALLTRIM(SUBS(CONTECOR[13],4)))
****------------------------------------------------------------------------*
MENSAGEM("Aguarde tentativa de acesso aos arquivos")
          COR("TITULO")
          @ 24,00 SAY SPACE(10)
          @ 24,01 say REPL("‹",9)         COLOR("N/"+ALLTRIM(SUBS(CONTECOR[13],4)))
          for a=01 to 09 step +1
               inkey(.01)
               @ 24,00+A say "‹"          COLOR("R+/"+ALLTRIM(SUBS(CONTECOR[13],4)))
          Next
Tone(500,3)
@ 00,02 SAY " F1-Ajuda "                  COLOR("B+/"+ALLTRIM(SUBS(CONTECOR[13],4)))
DO WHILE (M->SEMPRE .OR. M->TEMPO>0)
   IF EXUSE
      USE &ARQ EXCLUSIVE
      @ 00,69 SAY SPACE(11)
      *
      * -> Uso exclusivo
   ELSE
      USE &ARQ
      @ 00,69 SAY SPACE(11)
      *
      * -> Uso compartilhado
   ENDIF
   IF .NOT. NETERR()
      RETURN .T.
   ENDIF
   M->TEC=INKEY(0.01)
   M->TEMPO=M->TEMPO-1
   IF M->TEC=27
      EXIT
   ENDIF
ENDDO
RETURN .F.


 
FUNCTION REGLOCK
*
* -> Efetua  tentativas  para  bloquear o registro durante um determinado tempo
*    enviado  atraves  do  parametro  tempo  ou indefinidamente caso, tyempo=0.
*    Se a tecla <Esc> for pressionada pelo usuario, as tentativas sao interrom-
*    pidas.
*
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
*
* -> Efetua tentaivas para  adicionar o  registro durante um determinado tempo
*    enviando  atraves  do  paramentro  tempo ou indefinidamente, caso tempo=0.
*    Se a tecla <Esc> for pressionada pelo usuario, as tentativas sao interrom-
*    pidas.
*
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
SAVE SCREEN TO TELA_HORA
SET CURSOR OFF
CONTADOR  :=0
AUTOR     :=" (C) Marcos Morais de Sousa - 1996/1997 "
CIDADE    :=" -"+" JEQUIE/BAHIA "
HOJE      :=DATE()
SEMANA    :="Domingo      Segunda-feiraTerca-feira  Quarta-feira Quinta-feira "
SEMANA    :=SEMANA+"Sexta-feira  S†bado       "
DIA       :=TRIM(SUBS(SEMANA,DOW(HOJE)*13-12,13))+", "+ALLTRIM(STR(DAY(HOJE),2))
MES       :="janeiro  fevereiromaráo    abril    maio     junho    "
MES       :=MES+"julho    agosto   setembro outubro  novembro dezembro "
DIA       :=DIA+" de "+TRIM(SUBS(MES,MONTH(HOJE)*9-8,9))+" de "
DIA       :=DIA+TRAN(YEAR(HOJE),"@E 9999")
COLESQ    :=(80-LEN(DIA+CIDADE))/2-2
COLDIR    :=COLESQ+LEN(DIA+CIDADE)+2
* //////////////////////////////////////////////////////////////////////////////*
SETCOLOR("N/N")
*
@ 10,COLESQ CLEAR TO 14,COLDIR
@ 10,COLESQ       TO 14,COLDIR  COLOR("N+/N")
SOMBRA(10,COLESQ,    14,COLDIR)
DO WHILE.T.
          IF LASTKEY()=27
               EXIT
          ENDIF
          FOR CONTADOR   :=0 TO LEN(DIA+CIDADE)
          SET CURSOR OFF
               IF LASTKEY()=27
                    EXIT
               ENDIF
          INKEY(0.01)
          SETCOLOR("G+/N")
          @ 11,COLESQ+02 SAY PADC(DIA+CIDADE,LEN(DIA+CIDADE))
          @ 13,COLESQ+02 SAY PADC(LEFT(TIME(),2)+" horas, "+SUBSTR(TIME(),4,2)+" minutos e "+RIGHT(TIME(),2)+" segundos.",LEN(DIA+CIDADE))
          NEXT
    ENDDO
RESTORE SCREEN FROM TELA_HORA
RETURN

FUNCTION BOM_DIA
SAVE SCREEN TO BOMDIA
*                                                  *
****************************************************
*
Tec1="€ﬂﬂ€ﬂﬂ€ €ﬂﬂ€ﬂﬂ€ €ﬂﬂﬂﬂﬂ€   ‹  Inform†tica Ltda"
Tec2="€  €  € €  €  € €‹‹‹‹‹‹‹ ﬂ€ﬂ €ﬂﬂﬂﬂﬂ€ €ﬂﬂﬂﬂﬂﬂ€"
Tec3="€€ €  € €€ €  € ‹     €€  €€ €€ﬂﬂﬂﬂﬂ €€     ‹"
Tec4="€€ €  € €€ €  € ﬂﬂﬂﬂﬂﬂﬂﬂ  ﬂﬂ ﬂﬂﬂﬂﬂﬂﬂ ﬂﬂﬂﬂﬂﬂﬂﬂ"
Tec5="ﬂﬂ    ﬂﬂﬂﬂ    ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ"
*
****************************************************
*                                                  *
TITULO="BOM    DIA   SENHOR"
LINHA5="No silencio deste dia  que amanhece,"
LINHA6="venho pedir-te a paz, a sabedoria, a foráa."
LINHA7="Quero olhar hoje o  mundo com"
LINHA8="olhos cheios  de amor, ser paciente,"
LINHA9="ser compreensivo,  manso e prudente;"
LINHA10="ver,  alem  das  aparencias humanas,"
LINHA11="teus  filhos,  como  TU mesmo os ves"
LINHA12="e  assim  nÑo  ver  senÑo  o  bem em cada um."
LINHA13="Cerra os meus ouvidos a toda calunia."
LINHA14="Guarda  minha  lingua de toda a maldade"
LINHA15="Que  so de benáÑo se encha meu espirito."
LINHA16="Que eu seja tÑo bondoso e alegre"
LINHA17="Que todos quantos se achegarem a mim,"
LINHA18="sintam TUA presenáa."
LINHA19="Reveste-me  de  TUA  graáa,  SENHOR,"
LINHA20="e que no decurso deste dia,"
LINHA21="eu nÑo TE ofenda e TE revele a todos."
LINHA22=""
************************************************
CONTADOR=0
MMSTEC="MMStec Artes Gr†ficas & Inform†tica Ltda"
AUTOR ="(c) Marcos Morais de Sousa - 1996/1997"
CIDADE=" JEQUIE/BAHIA"
HOJE=DATE()
SEMANA="Domingo      Segunda-feiraTerca-feira  Quarta-feira "
SEMANA=SEMANA+"Quinta-feira Sexta-feira  S†bado       "
DIA=TRIM(SUBS(SEMANA,DOW(HOJE)*13-12,13))+", "+ALLTRIM(STR(DAY(HOJE),2))
MES="Janeiro  FevereiroMaráo    Abril    Maio     Junho    "
MES=MES+"Julho    Agosto   Setembro Outubro  Novembro Dezembro "
DIA=DIA+" de "+TRIM(SUBS(MES,MONTH(HOJE)*9-8,9))+" de "
DIA=DIA+TRAN(YEAR(M->HOJE),"@E 9999")+" -"
************************************************

CLS
Do While .T.
   IF LASTKEY()>0
     exit
   endif
   SET CURSOR OFF
   SETCOLOR ("N+/N")
   CLS
   ?Repl("\\// M.M.S.tec //\\",100)
   @ 09,16 TO 15,62
FOR CONTADOR=0 TO LEN(tec1)+5 STEP +5
  IF LASTKEY()>0
    exit
  endif
  SETCOLOR("B+ /n")
  @ 10,(80-LEN(tec1))/2 Say PADR(SUBSTR(tec1,1,CONTADOR),LEN(tec1))
  SETCOLOR("B  /n")
  @ 11,(80-LEN(tec2))/2 Say PADC(SUBSTR(tec2,1,CONTADOR),LEN(tec2))
  SETCOLOR("BG /n")
  @ 12,(80-LEN(tec3))/2 SAY PADL(SUBSTR(tec3,1,CONTADOR),LEN(tec3))
  SETCOLOR("BG+/n")
  @ 13,(80-LEN(tec4))/2 SAY PADC(SUBSTR(tec4,1,CONTADOR),LEN(tec4))
  SETCOLOR("W  /n")
  @ 14,(80-LEN(tec5))/2 SAY PADR(SUBSTR(tec5,1,CONTADOR),LEN(tec5))
  INKEY(0.01)
NEXT
INKEY(1)
FOR CONTADOR=LEN(tec1)+5 TO 0 STEP -5
  IF LASTKEY()>0
    exit
  endif
  SETCOLOR("B+ /n")
  @ 10,(80-LEN(tec1))/2 Say PADR(SUBSTR(tec1,1,CONTADOR),LEN(tec1))
  SETCOLOR("B  /n")
  @ 11,(80-LEN(tec2))/2 Say PADC(SUBSTR(tec2,1,CONTADOR),LEN(tec2))
  SETCOLOR("BG /n")
  @ 12,(80-LEN(tec3))/2 SAY PADL(SUBSTR(tec3,1,CONTADOR),LEN(tec3))
  SETCOLOR("BG+/n")
  @ 13,(80-LEN(tec4))/2 SAY PADC(SUBSTR(tec4,1,CONTADOR),LEN(tec4))
  SETCOLOR("W  /n")
  @ 14,(80-LEN(tec5))/2 SAY PADR(SUBSTR(tec5,1,CONTADOR),LEN(tec5))
  INKEY(0.01)
NEXT
     *///////////////////////////////////////////////////////////////////////////////////////////////////*
     FOR CONTADOR=0 TO LEN(tec1)+5 STEP +5
     IF LASTKEY()>0
          exit
     endif
     @ 11,(80-LEN(MMSTEC))/2 Say PADL(SUBSTR(MMSTEC,1,CONTADOR),LEN(MMSTEC))    COLOR("w+ /n")
         @ 13,(80-LEN(AUTOR))/2 Say PADR(SUBSTR(autor,1,CONTADOR),LEN(autor))       COLOR("g+ / n")
        inkey(0.01)
     Next
     *//////////////////////////////////////////////////////////////////////////////////////////////////*
     SETCOLOR ("W+/G")
     FOR X=02 to 23 step +1
     IF LASTKEY()>0
          exit
     endif

          @ 01,02 clear to X,55+X
          @ 01,02       to X,55+X    COLOR "G+/G"
          PAUSA(0.01)
     NEXT
     *
     FOR CONTADOR=0 to LEN(DIA+CIDADE)
          SET COLOR TO w+/g
          @ 02,(80-LEN(DIA+CIDADE))/2 SAY PADR(SUBSTR(DIA+CIDADE,1,CONTADOR),LEN(DIA+CIDADE))
          @ 03,03 say REPL("ƒ",75)  color "R+/G"
          PAUSA(0.01)
     NexT
     SETCOLOR ("W+/G")
     FOR CONTADOR=0 TO LEN(TITULO)+5 STEP +5
     IF LASTKEY()>0
          EXIT
     ENDIF

          @ 02,70 SAY TIME()
          @ 04,(80-LEN(TITULO))/2 SAY PADC(SUBSTR(TITULO,1,CONTADOR),LEN(TITULO)) COLOR "RG+/G"
          PAUSA(0.01)
     NEXT
     FOR CONTADOR=0 TO LEN(LINHA5)+5 STEP +5
     IF LASTKEY()>0
          EXIT
     ENDIF

          @ 02,70 SAY TIME()
          @ 06,(80-LEN(LINHA5))/2 SAY PADC(SUBSTR(LINHA5,1,CONTADOR),LEN(LINHA5))
          PAUSA(0.01)
     NEXT
     FOR CONTADOR=0 TO LEN(LINHA6)+5 STEP +5
     IF LASTKEY()>0
          EXIT
     ENDIF

          @ 02,70 SAY TIME()
          @ 07,(80-LEN(LINHA6))/2 SAY PADC(SUBSTR(LINHA6,1,CONTADOR),LEN(LINHA6))
          PAUSA(0.01)
     NEXT
     FOR CONTADOR=0 TO LEN(LINHA7)+5 STEP +5
     IF LASTKEY()>0
          EXIT
     ENDIF

          @ 02,70 SAY TIME()
          @ 08,(80-LEN(LINHA7))/2 SAY PADC(SUBSTR(LINHA7,1,CONTADOR),LEN(LINHA7))
          PAUSA(0.01)
     NEXT
     FOR CONTADOR=0 TO LEN(LINHA8)+5 STEP +5
     IF LASTKEY()>0
          EXIT
     ENDIF

          @ 02,70 SAY TIME()
          @ 09,(80-LEN(LINHA8))/2 SAY PADC(SUBSTR(LINHA8,1,CONTADOR),LEN(LINHA8))
          PAUSA(0.01)
     NEXT
     FOR CONTADOR=0 TO LEN(LINHA9)+5 STEP +5
     IF LASTKEY()>0
          EXIT
     ENDIF

          @ 02,70 SAY TIME()
          @ 10,(80-LEN(LINHA9))/2 SAY PADC(SUBSTR(LINHA9,1,CONTADOR),LEN(LINHA9))
          PAUSA(0.01)
     NEXT
     FOR CONTADOR=0 TO LEN(LINHA10)+5 STEP +5
     IF LASTKEY()>0
          EXIT
     ENDIF

          @ 02,70 SAY TIME()
          @ 11,(80-LEN(LINHA10))/2 SAY PADC(SUBSTR(LINHA10,1,CONTADOR),LEN(LINHA10))
          PAUSA(0.01)
     NEXT
     FOR CONTADOR=0 TO LEN(LINHA11)+5 STEP +5
     IF LASTKEY()>0
          EXIT
     ENDIF

          @ 02,70 SAY TIME()
          @ 12,(80-LEN(LINHA11))/2 SAY PADC(SUBSTR(LINHA11,1,CONTADOR),LEN(LINHA11))
          PAUSA(0.01)
     NEXT
     FOR CONTADOR=0 TO LEN(LINHA12)+5 STEP +5
     IF LASTKEY()>0
          EXIT
     ENDIF

          @ 02,70 SAY TIME()
          @ 13,(80-LEN(LINHA12))/2 SAY PADC(SUBSTR(LINHA12,1,CONTADOR),LEN(LINHA12))
          PAUSA(0.01)
     NEXT
     FOR CONTADOR=0 TO LEN(LINHA13)+5 STEP +5
     IF LASTKEY()>0
          EXIT
     ENDIF

          @ 02,70 SAY TIME()
          @ 14,(80-LEN(LINHA13))/2 SAY PADC(SUBSTR(LINHA13,1,CONTADOR),LEN(LINHA13))
          PAUSA(0.01)
     NEXT
     FOR CONTADOR=0 TO LEN(LINHA14)+5 STEP +5
     IF LASTKEY()>0
          EXIT
     ENDIF

          @ 02,70 SAY TIME()
          @ 15,(80-LEN(LINHA14))/2 SAY PADC(SUBSTR(LINHA14,1,CONTADOR),LEN(LINHA14))
          PAUSA(0.01)
     NEXT
     FOR CONTADOR=0 TO LEN(LINHA15)+5 STEP +5
     IF LASTKEY()>0
          EXIT
     ENDIF

          @ 02,70 SAY TIME()
          @ 16,(80-LEN(LINHA15))/2 SAY PADC(SUBSTR(LINHA15,1,CONTADOR),LEN(LINHA15))
          PAUSA(0.01)
     NEXT
     FOR CONTADOR=0 TO LEN(LINHA16)+5 STEP +5
     IF LASTKEY()>0
          EXIT
     ENDIF

          @ 02,70 SAY TIME()
          @ 17,(80-LEN(LINHA16))/2 SAY PADC(SUBSTR(LINHA16,1,CONTADOR),LEN(LINHA16))
          PAUSA(0.01)
     NEXT
     FOR CONTADOR=0 TO LEN(LINHA17)+5 STEP +5
     IF LASTKEY()>0
          EXIT
     ENDIF

          @ 02,70 SAY TIME()
          @ 18,(80-LEN(LINHA17))/2 SAY PADC(SUBSTR(LINHA17,1,CONTADOR),LEN(LINHA17))
          PAUSA(0.01)
     NEXT
     FOR CONTADOR=0 TO LEN(LINHA18)+5 STEP +5
     IF LASTKEY()>0
          EXIT
     ENDIF

          @ 02,70 SAY TIME()
          @ 19,(80-LEN(LINHA18))/2 SAY PADC(SUBSTR(LINHA18,1,CONTADOR),LEN(LINHA18))
          PAUSA(0.01)
     NEXT
     FOR CONTADOR=0 TO LEN(LINHA19)+5 STEP +5
     IF LASTKEY()>0
          EXIT
     ENDIF

          @ 02,70 SAY TIME()
          @ 20,(80-LEN(LINHA19))/2 SAY PADC(SUBSTR(LINHA19,1,CONTADOR),LEN(LINHA19))
          PAUSA(0.01)
     NEXT
     FOR CONTADOR=0 TO LEN(LINHA20)+5 STEP +5
     IF LASTKEY()>0
          EXIT
     ENDIF

          @ 02,70 SAY TIME()
          @ 21,(80-LEN(LINHA20))/2 SAY PADC(SUBSTR(LINHA20,1,CONTADOR),LEN(LINHA20))
          PAUSA(0.01)
     NEXT
     FOR CONTADOR=0 TO LEN(LINHA21)+5 STEP +5
     IF LASTKEY()>0
          EXIT
     ENDIF

          @ 02,70 SAY TIME()
          @ 22,(80-LEN(LINHA21))/2 SAY PADC(SUBSTR(LINHA21,1,CONTADOR),LEN(LINHA21))
          PAUSA(0.01)
     NEXT
     IF LASTKEY()>0
          EXIT
     ENDIF
     AGUARDA(30)
     TONE(550,3)
ENDDO
set color to w/n
cls
FOR CONTADOR=0 TO LEN(tec1)+5 STEP +5
  SETCOLOR("B+ /n")
  @ 10,(80-LEN(tec1))/2 Say PADR(SUBSTR(tec1,1,CONTADOR),LEN(tec1))
  SETCOLOR("B  /n")
  @ 11,(80-LEN(tec2))/2 Say PADC(SUBSTR(tec2,1,CONTADOR),LEN(tec2))
  SETCOLOR("BG /n")
  @ 12,(80-LEN(tec3))/2 SAY PADL(SUBSTR(tec3,1,CONTADOR),LEN(tec3))
  SETCOLOR("BG+/n")
  @ 13,(80-LEN(tec4))/2 SAY PADC(SUBSTR(tec4,1,CONTADOR),LEN(tec4))
  SETCOLOR("W  /n")
  @ 14,(80-LEN(tec5))/2 SAY PADR(SUBSTR(tec5,1,CONTADOR),LEN(tec5))
  INKEY(0.01)
NEXT
  FOR CONTADOR=0 TO LEN(tec1)+5 STEP +5
      @ 16,(80-LEN(MMSTEC))/2 Say PADL(SUBSTR(MMSTEC,1,CONTADOR),LEN(MMSTEC))    COLOR("w+ /n")
      @ 17,(80-LEN(AUTOR))/2 Say PADR(SUBSTR(autor,1,CONTADOR),LEN(autor))       COLOR("g+ / n")
      inkey(0.01)
  Next
TONE(550,3)
SET CURSOR ON
RESTORE SCREEN FROM BOMDIA

FUNCTION PAUSA
PARA X
Inkey(x)
RETURN.T.

FUNCTION AGUARDA
PARA SEG
SET COLOR TO W/N
@ 00,02 SAY REPL(CHR(4),SEG) COLOR("N+/N")
FOR SAI=02 TO SEG
     @ 02,70 SAY TIME()               COLOR("W+  /G")
     SET CURSOR OFF
     IF LASTKEY()=27
        SETCOLOR("RG+/N")
        EXIT
     ENDIF
INKEY(1)
@ 00,SAI SAY CHR(4)                    COLOR("RG+ /N")
@ 00,61  SAY "Restam"                  COLOR("G   /N")
@ 00,68  SAY PADR(SEG-SAI,SEG-SAI)     COLOR("RG+ /N")
@ 00,70  SAY " Segundos"               COLOR("G   /N")
@ 24,68  SAY PADR(SAI,SAI)             COLOR("W+  /N")
@ 24,70  SAY " Segundos"               COLOR("G+  /N")
NEXT
RETURN.T.

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


FUNCTION DESCANSO_MMS
SAVE SCREEN TO APRESENTA_TELA
SET COLOR TO W/N
SET CURSOR OFF
CLS
*
tec1=" €‹   ‹€ €‹   ‹€ €ﬂﬂﬂﬂﬂ€  ‹  Inform†tica Ltda."
tec2=" € ﬂ‹ﬂ € € ﬂ‹ﬂ € €‹‹‹‹‹‹ ﬂ€ﬂ €ﬂﬂﬂﬂﬂ€ €ﬂﬂﬂﬂﬂﬂ€ "
tec3=" €     € €     € ‹     €  €  €ﬂﬂﬂﬂﬂﬂ €      ‹ "
tec4=" €     € €     € ﬂﬂﬂﬂﬂﬂﬂ  ﬂﬂ ﬂﬂﬂﬂﬂﬂﬂ ﬂﬂﬂﬂﬂﬂﬂﬂ "
tec5=" ﬂ     ﬂﬂﬂ     ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ"
*
*
CONTADOR=0
AUTOR=" Marcos Morais de Sousa. "
CIDADE=" JequiÇ, Bahia "
HOJE=DATE()
SEMANA="Domingo      Segunda-feiraTerca-feira  Quarta-feira "
SEMANA=SEMANA+"Quinta-feira Sexta-feira  S†bado       "
DIA=TRIM(SUBS(SEMANA,DOW(HOJE)*13-12,13))+", "+ALLTRIM(STR(DAY(HOJE),2))
MES="Janeiro  FevereiroMaráo    Abril    Maio     Junho    "
MES=MES+"Julho    Agosto   Setembro Outubro  Novembro Dezembro "
DIA=DIA+" de "+TRIM(SUBS(MES,MONTH(HOJE)*9-8,9))+" de "
DIA=DIA+TRAN(YEAR(M->HOJE),"@E 9999")+" -"
*/////////////////////////////////////////////////////////////////*
*
FOR CONTADOR=0 TO LEN(tec1)+5 STEP +5
  SETCOLOR("B+ /N")
  @ 10,(80-LEN(tec1))/2 Say PADR(SUBSTR(tec1,1,CONTADOR),LEN(tec1))
  SETCOLOR("B  /N")
  @ 11,(80-LEN(tec2))/2 Say PADC(SUBSTR(tec2,1,CONTADOR),LEN(tec2))
  SETCOLOR("BG /N")
  @ 12,(80-LEN(tec3))/2 SAY PADL(SUBSTR(tec3,1,CONTADOR),LEN(tec3))
  SETCOLOR("BG+/N")
  @ 13,(80-LEN(tec4))/2 SAY PADC(SUBSTR(tec4,1,CONTADOR),LEN(tec4))
  SETCOLOR("W  /N")
  @ 14,(80-LEN(tec5))/2 SAY PADR(SUBSTR(tec5,1,CONTADOR),LEN(tec5))
  INKEY(0.01)
NEXT
INKEY(1)
FOR CONTADOR=LEN(tec1)+5 TO 0 STEP -5
  SETCOLOR("B+ /N")
  @ 10,(80-LEN(tec1))/2 Say PADR(SUBSTR(tec1,1,CONTADOR),LEN(tec1))
  SETCOLOR("B  /N")
  @ 11,(80-LEN(tec2))/2 Say PADC(SUBSTR(tec2,1,CONTADOR),LEN(tec2))
  SETCOLOR("BG /N")
  @ 12,(80-LEN(tec3))/2 SAY PADL(SUBSTR(tec3,1,CONTADOR),LEN(tec3))
  SETCOLOR("BG+/N")
  @ 13,(80-LEN(tec4))/2 SAY PADC(SUBSTR(tec4,1,CONTADOR),LEN(tec4))
  SETCOLOR("W  /N")
  @ 14,(80-LEN(tec5))/2 SAY PADR(SUBSTR(tec5,1,CONTADOR),LEN(tec5))
  INKEY(0.01)
NEXT
*////////////////////////////////////////////////////////////////////*
     *
     ///////////////////// COLUNA I ///////////////////////*
     *
     L1C1="Desenvolvido por:"
     L2C1="MMStec Artes Gr†ficas e Inform†tica."
     L3C1="//\\//\\//\\//\\//\\//\\//\\//\\//\\//"
     *
     *
     L4C1="ConcepáÑo, ProgramaáÑo, Interface e"
     L5C1="Tratamento de Imagens:"
     L6C1="MARCOS MORAIS DE SOUSA"
     *
     L7C1="ConcepáÑo de Imagens, Interface e"
     L8C1="CoordenaáÑo Geral:"
     L9C1="MARCOS MOARSI DE SOUSA"
     *
     L10C1="Analise das funcoes,"
     L11C1="Redacao e organizaáÑo"
     L12C1="RevisÑo e correáÑo"
     L13C1="Pesquisa"
     L14C1="MARCOS MORAIS DE SOUSA"
     *
     L15C1="Gerador"
     L16C1="MIRRO 2.22"
     *
     L17C1="Copilador"
     L18C1="CLIPPER 5.10"
     *
     ///////////////////// COLUNA II //////////////////////
     *
     L1C2="Desenvolvimento de Funáoes:"
     L2C2="MARCOS MORAIS DE SOUSA"
     *
     L3C2="DigitaáÑo"
     L4C2="MARCOS MORAIS DE SOUSA"
     *
     L5C2="Apoio"
     L6C2="MFB Materiais de ConstruáÑo Ltda."
     *
     L7C2="Atualizaáao e/ou alteraáÑo"
     L8C2="MARCOS MORAIS DE SOUSA"
     *
     L9C2="Agradecimentos muito especiais"
     L10C2="'JESUS CRISTO'"
     L11C2="VALDIR CARLOS DE JESUS BARRETO"
     L12C2="EDSON SENNA SILVA"
     L13C2="EDJALMA FERREIRA DOS SANTOS"
     L14C2="ELIERSON FERREIRA DOS SANTOS"

For Contador=0 to LEN(DIA+CIDADE)
    SET COLOR TO G+/N
    @ 00,(80-LEN(DIA+CIDADE))/2 SAY PADC(SUBSTR(DIA+CIDADE,1,CONTADOR),LEN(DIA+CIDADE))
    INKEY(0.01)
NexT
*
@ 01,00 CLEAR TO 24,79
DO WHILE.t.
    IF lastkey()=27
          RESTORE SCREEN FROM APRESENTA_TELA
          EXIT
    endif
    ****************
     SET COLOR TO W/N
     SET CURSOR OFF
     For Contador=0 to LEN(L1C1)+3 STEP +3
     IF lastkey()=27
          EXIT
     endif

          SET COLOR TO W/N
          @ 01,00 SAY PADL(SUBSTR(L1C1,1,CONTADOR),38)
          INKEY(0.01)
     NexT
     For Contador=0 to LEN(L2C1)+3 STEP +3
          IF lastkey()=27
              EXIT
          endif

          SET COLOR TO W+/N
          @ 02,00 SAY PADL(SUBSTR(L2C1,1,CONTADOR),38)
          INKEY(0.01)
     NexT
     For Contador=0 to LEN(L3C1)+3 STEP +3
          IF lastkey()=27
              EXIT
          endif
          SET COLOR TO G/N
          @ 03,00 SAY PADL(SUBSTR(L3C1,1,CONTADOR),38)
          INKEY(0.01)
     NexT
     **************************************************
     For Contador=0 to LEN(L4C1)+3 STEP +3
          IF lastkey()=27
              EXIT
          endif
          SET COLOR TO G/N
          @ 05,00 SAY PADL(SUBSTR(L4C1,1,CONTADOR),38)
          INKEY(0.01)
     NexT
     For Contador=0 to LEN(L5C1)+3 STEP +3
          IF lastkey()=27
              EXIT
          endif
          SET COLOR TO G/N
          @ 06,00 SAY PADL(SUBSTR(L5C1,1,CONTADOR),38)
          INKEY(0.01)
     NexT
     For Contador=0 to LEN(L6C1)+3 STEP +3
          IF lastkey()=27
              EXIT
          endif
          SET COLOR TO G+/N
          @ 07,00 SAY PADL(SUBSTR(L6C1,1,CONTADOR),38)
          INKEY(0.01)
     NexT
     **************************************************
     For Contador=0 to LEN(L7C1)+3 STEP +3
          IF lastkey()=27
              EXIT
          endif
          SET COLOR TO G/N
          @ 09,00 SAY PADL(SUBSTR(L7C1,1,CONTADOR),38)
          INKEY(0.01)
     NexT
     For Contador=0 to LEN(L8C1)+3 STEP +3
          IF lastkey()=27
              EXIT
          endif
          SET COLOR TO G/N
          @ 10,00 SAY PADL(SUBSTR(L8C1,1,CONTADOR),38)
          INKEY(0.01)
     NexT
     For Contador=0 to LEN(L9C1)+3 STEP +3
          IF lastkey()=27
              EXIT
          endif
          SET COLOR TO G+/N
          @ 11,00 SAY PADL(SUBSTR(L9C1,1,CONTADOR),38)
          INKEY(0.01)
     NexT
     **************************************************
     For Contador=0 to LEN(L10C1)+3 STEP +3
          IF lastkey()=27
              EXIT
          endif
          SET COLOR TO G/N
          @ 13,00 SAY PADL(SUBSTR(L10C1,1,CONTADOR),38)
          INKEY(0.01)
     NexT
     For Contador=0 to LEN(L11C1)+3 STEP +3
          IF lastkey()=27
              EXIT
          endif
          SET COLOR TO G/N
          @ 14,00 SAY PADL(SUBSTR(L11C1,1,CONTADOR),38)
          INKEY(0.01)
     NexT
     For Contador=0 to LEN(L12C1)+3 STEP +3
          IF lastkey()=27
              EXIT
          endif
          SET COLOR TO G/N
          @ 15,00 SAY PADL(SUBSTR(L12C1,1,CONTADOR),38)
          INKEY(0.01)
     NexT
     For Contador=0 to LEN(L13C1)+3 STEP +3
          IF lastkey()=27
              EXIT
          endif
          SET COLOR TO G/N
          @ 16,00 SAY PADL(SUBSTR(L13C1,1,CONTADOR),38)
          INKEY(0.01)
     NexT
     For Contador=0 to LEN(L14C1)+3 STEP +3
          IF lastkey()=27
              EXIT
          endif
          SET COLOR TO G+/N
          @ 17,00 SAY PADL(SUBSTR(L14C1,1,CONTADOR),38)
          INKEY(0.01)
     NexT
     **************************************************
     For Contador=0 to LEN(L15C1)+3 STEP +3
          IF lastkey()=27
              EXIT
          endif
          SET COLOR TO G/N
          @ 19,00 SAY PADL(SUBSTR(L15C1,1,CONTADOR),38)
          INKEY(0.01)
     NexT
     For Contador=0 to LEN(L16C1)+3 STEP +3
          IF lastkey()=27
              EXIT
          endif
          SET COLOR TO G+/N
          @ 20,00 SAY PADL(SUBSTR(L16C1,1,CONTADOR),38)
          INKEY(0.01)
     NexT
     **************************************************
     For Contador=0 to LEN(L17C1)+3 STEP +3
          IF lastkey()=27
              EXIT
          endif
          SET COLOR TO G/N
          @ 22,00 SAY PADL(SUBSTR(L17C1,1,CONTADOR),38)
          INKEY(0.01)
     NexT
     For Contador=0 to LEN(L18C1)+3 STEP +3
          IF lastkey()=27
              EXIT
          endif
          SET COLOR TO G+/N
          @ 23,00 SAY PADL(SUBSTR(L18C1,1,CONTADOR),38)
          INKEY(0.01)
     NexT
     **************************************************
     *
     *
     * ////////////////// coluna dois //////////////////////////////
     *
     For Contador=0 to LEN(L1C2)+3 STEP +3
          IF lastkey()=27
              EXIT
          endif
          SET COLOR TO G/N
          @ 05,40 SAY PADR(SUBSTR(L1C2,1,CONTADOR),38)
          INKEY(0.01)
     NexT
     For Contador=0 to LEN(L2C2)+3 STEP +3
          IF lastkey()=27
              EXIT
          endif
          SET COLOR TO G+/N
          @ 06,40 SAY PADR(SUBSTR(L2C2,1,CONTADOR),38)
          INKEY(0.01)
     NexT
     **************************************************
     For Contador=0 to LEN(L3C2)+3 STEP +3
          IF lastkey()=27
              EXIT
          endif
          SET COLOR TO G/N
          @ 08,40 SAY PADR(SUBSTR(L3C2,1,CONTADOR),38)
          INKEY(0.01)
     NexT
     For Contador=0 to LEN(L4C2)+3 STEP +3
          IF lastkey()=27
              EXIT
          endif

          SET COLOR TO G+/N
          @ 09,40 SAY PADR(SUBSTR(L4C2,1,CONTADOR),38)
          INKEY(0.01)
     NexT
     **************************************************
     For Contador=0 to LEN(L5C2)+3 STEP +3
          IF lastkey()=27
              EXIT
          endif
          SET COLOR TO G/N
          @ 11,40 SAY PADR(SUBSTR(L5C2,1,CONTADOR),38)
          INKEY(0.01)
     NexT
     For Contador=0 to LEN(L6C2)+3 STEP +3
          IF lastkey()=27
              EXIT
          endif
          SET COLOR TO G+/N
          @ 12,40 SAY PADR(SUBSTR(L6C2,1,CONTADOR),38)
          INKEY(0.01)
     NexT
     **************************************************
     For Contador=0 to LEN(L7C2)+3 STEP +3
          IF lastkey()=27
              EXIT
          endif
          SET COLOR TO G/N
          @ 14,40 SAY PADR(SUBSTR(L7C2,1,CONTADOR),38)
          INKEY(0.01)
     NexT
     For Contador=0 to LEN(L8C2)+3 STEP +3
          IF lastkey()=27
              EXIT
          endif
          SET COLOR TO G+/N
          @ 15,40 SAY PADR(SUBSTR(L8C2,1,CONTADOR),38)
          INKEY(0.01)
     NexT
     **************************************************
     For Contador=0 to LEN(L9C2)+3 STEP +3
          IF lastkey()=27
              EXIT
          endif
          SET COLOR TO G/N
          @ 17,40 SAY PADR(SUBSTR(L9C2,1,CONTADOR),38)
          INKEY(0.01)
     NexT
     For Contador=0 to LEN(L10C2)+3 STEP +3
          IF lastkey()=27
              EXIT
          endif
          SET COLOR TO G+/N
          @ 18,40 SAY PADR(SUBSTR(L10C2,1,CONTADOR),38)
          INKEY(0.01)
     NexT
     For Contador=0 to LEN(L11C2)+3 STEP +3
          IF lastkey()=27
              EXIT
          endif
          SET COLOR TO G+/N
          @ 19,40 SAY PADR(SUBSTR(L11C2,1,CONTADOR),38)
          INKEY(0.01)
     NexT
     For Contador=0 to LEN(L12C2)+3 STEP +3
          IF lastkey()=27
              EXIT
          endif
          SET COLOR TO G+/N
          @ 20,40 SAY PADR(SUBSTR(L12C2,1,CONTADOR),38)
          INKEY(0.01)
     NexT
     For Contador=0 to LEN(L13C2)+3 STEP +3
          IF lastkey()=27
              EXIT
          endif
          SET COLOR TO G+/N
          @ 21,40 SAY PADR(SUBSTR(L13C2,1,CONTADOR),38)
          INKEY(0.01)
     NexT
     For Contador=0 to LEN(L14C2)+3 STEP +3
          IF lastkey()=27
              EXIT
          endif
          SET COLOR TO G+/N
          @ 22,40 SAY PADR(SUBSTR(L14C2,1,CONTADOR),38)
          INKEY(0.01)
     NexT
*///////////////////////////////////////////////////////////////////////*
CLS
FOR CONTADOR=0 TO LEN(tec1)+5 STEP +5
  SETCOLOR("B+ /N")
  @ 10,(80-LEN(tec1))/2 Say PADR(SUBSTR(tec1,1,CONTADOR),LEN(tec1))
  SETCOLOR("B  /N")
  @ 11,(80-LEN(tec2))/2 Say PADC(SUBSTR(tec2,1,CONTADOR),LEN(tec2))
  SETCOLOR("BG /N")
  @ 12,(80-LEN(tec3))/2 SAY PADL(SUBSTR(tec3,1,CONTADOR),LEN(tec3))
  SETCOLOR("BG+/N")
  @ 13,(80-LEN(tec4))/2 SAY PADC(SUBSTR(tec4,1,CONTADOR),LEN(tec4))
  SETCOLOR("W  /N")
  @ 14,(80-LEN(tec5))/2 SAY PADR(SUBSTR(tec5,1,CONTADOR),LEN(tec5))
  INKEY(0.01)
NEXT
*///////////////////////////////////////////////////////////////////////*
For Contador=0 to LEN(DIA+CIDADE)
          SET COLOR TO G+/N
          @ 00,(80-LEN(DIA+CIDADE))/2 SAY PADC(SUBSTR(DIA+CIDADE,1,CONTADOR),LEN(DIA+CIDADE))
          INKEY(0.01)
NexT
     @ 23,00 say PADR("Desenvolvido por:",80) color "w/n"
For Contador=0 to LEN(AUTOR)
          SET COLOR TO G+/N
          @ 24,00 SAY PADR(SUBSTR(AUTOR,1,CONTADOR),LEN(AUTOR))
          Tone(450,0.01)
NexT
//////////////////////////////////////////////////////////////////////*
FOR CONTADOR=LEN(tec1)+5 TO 0 STEP -5
  SETCOLOR("B+ /N")
  @ 10,(80-LEN(tec1))/2 Say PADR(SUBSTR(tec1,1,CONTADOR),LEN(tec1))
  SETCOLOR("B  /N")
  @ 11,(80-LEN(tec2))/2 Say PADC(SUBSTR(tec2,1,CONTADOR),LEN(tec2))
  SETCOLOR("BG /N")
  @ 12,(80-LEN(tec3))/2 SAY PADL(SUBSTR(tec3,1,CONTADOR),LEN(tec3))
  SETCOLOR("BG+/N")
  @ 13,(80-LEN(tec4))/2 SAY PADC(SUBSTR(tec4,1,CONTADOR),LEN(tec4))
  SETCOLOR("W  /N")
  @ 14,(80-LEN(tec5))/2 SAY PADR(SUBSTR(tec5,1,CONTADOR),LEN(tec5))
  INKEY(0.01)
NEXT
*////////////////////////////////////////////////////////////////////*
ENDDO
RESTORE SCREEN FROM APRESENTA_TELA
RETURN.T.

* ///////////////////////////////////////////////////////////////////////////*
* -> Inicio da funcao LOGOMARCA ( ARQUIVO DE INCERSAO : FUN.B03 )
*
FUNCTION LOGOMARCA
*
X    :=03;Y =X-1;LA=03;A=0
LB   :=LA+1;LC=LB+1;LD=LC+1;LE=LD+1;LF=LE+1
LG   :=LF+1;LH=LG+1;LI=LH+1;LJ=LI+1;LL=LJ+1
AUTOR:="(C) Marcos Morais de Sousa 1996/1997"
LINHA:=REPL("ƒ",80)

CLS
SETCOLOR("G+/N")
@ LA,X say "€€€€     €€€€ €€€€     €€€€ ‹€€€€€€€€€‹ €€€€€€€€€€€€ €€€€€€€€€€ €€€€€€€€€€"
@ LB,X say "€€€€€   €€€€€ €€€€€   €€€€€ €€€€€€€€€€€ €€€€€€€€€€€€ €€€€€€€€€€ €€€€€€€€€€"
@ LC,X say "€€€€€€ €€€€€€ €€€€€€ €€€€€€ €€€€   €€€€     €€€€     €€€€       €€€€"
@ LD,X say "€€€€€€€€€€€€€ €€€€€€€€€€€€€ €€€€            €€€€     €€€€       €€€€"
@ LE,X say "€€€€€€€€€€€€€ €€€€€€€€€€€€€ €€€€€€€€€€‹     €€€€     €€€€€€€€   €€€€"
@ LF,X say "€€€€ €€€ €€€€ €€€€ €€€ €€€€ ﬂ€€€€€€€€€€     €€€€     €€€€€€€€   €€€€"
@ LG,X say "€€€€  €  €€€€ €€€€  €  €€€€        €€€€     €€€€     €€€€       €€€€"
@ LH,X say "€€€€     €€€€ €€€€     €€€€ €€€€   €€€€     €€€€     €€€€       €€€€"
@ LI,X say "€€€€     €€€€ €€€€     €€€€ €€€€€€€€€€€     €€€€     €€€€€€€€€€ €€€€€€€€€€"
@ LJ,X say "€€€€     €€€€ €€€€     €€€€ ﬂ€€€€€€€€€ﬂ     €€€€     €€€€€€€€€€ €€€€€€€€€€"

SETCOLOR("G/N")
@ LC,Y+33  say "€€€";@ LC,Y+41  say "€€€€";@ LC,Y+49  say "€€€€";@ LC,Y+58  say "€€€€€€";@ LC,Y+69  say "€€€€€€"
@ LD,Y+36  say "€€€€"
@ LF,Y+05  say "€";@ LF,Y+09  say "€";@ LF,Y+19  say "€";@ LF,Y+23  say "€";@ LF,Y+29  say "€"
@ LG,Y+06  say "€";@ LG,Y+08  say "€";@ LG,Y+20  say "€";@ LG,Y+22  say "€";@ LG,Y+30  say "€€€€€€";@ LG,Y+58  say "€€€€"
@ LH,Y+07  say "€";@ LH,Y+21  say "€"
@ LJ,Y+29  say "€";@ LJ,Y+39  say "€"
@ LL,Y+01  say "€€€€";@ LL,Y+10  say "€€€€";@ LL,Y+15  say "€€€€";@ LL,Y+24  say "€€€€";@ LL,Y+30  say "€€€€€€€€€"
@ LL,Y+45  say "€€€€";@ LL,Y+54  say "€€€€€€€€€€";@ LL,Y+65  say "€€€€€€€€€€"
SETCOLOR("G+/BG")

FOR   A  :=0 TO LEN(LINHA)+10 STEP +10
      SET COLOR TO W+/N
      @ LL+3,(80-LEN(AUTOR)) SAY PADC(SUBSTR(AUTOR,1,A),LEN(AUTOR))
      @ LL+2,(80-LEN(LINHA)) SAY PADR(SUBSTR(LINHA,1,A),LEN(LINHA)) COLOR("r+/N")
      INKEY(0.01)
NEXT
BEEP()
*
* -> Final da funcao LOGOMARCA
* ///////////////////////////////////////////////////////////////////////////*

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
***********************
@ 02,00 clear to 02,80
***********************
CONTADOR=0
AUTOR=" (C) Marcos Morais de Sousa - 1996/1997 "
CIDADE=" -"+" JEQUIE/BAHIA "
HOJE=DATE()
SEMANA="Domingo      Segunda-feiraTerca-feira  Quarta-feira Quinta-feira "
SEMANA=SEMANA+"Sexta-feira  S†bado       "
DIA=TRIM(SUBS(SEMANA,DOW(HOJE)*13-12,13))+", "+ALLTRIM(STR(DAY(HOJE),2))
MES="janeiro  fevereiromaráo    abril    maio     junho    "
MES=MES+"julho    agosto   setembro outubro  novembro dezembro "
DIA=DIA+" de "+TRIM(SUBS(MES,MONTH(HOJE)*9-8,9))+" de "
DIA=DIA+TRAN(YEAR(HOJE),"@E 9999")
     COLESQ=(80-LEN(DIA+CIDADE))/2-2
     COLDIR=COLESQ+LEN(DIA+CIDADE)+2
     SETCOLOR("N /N")
     @ 14,COLESQ CLEAR TO 16,COLDIR
     @ 14,COLESQ       TO 16,COLDIR COLOR("N+/N")
SOMBRA(14,COLESQ,         16,COLDIR)
     @ 15,COLESQ+2 SAY PADC(DIA+CIDADE,LEN(DIA+CIDADE)) COLOR("G+/N")
RETURN

FUNCTION SEGURANCA
SAVE SCREEN TO M->TELA_SEG
M->MARCOS="593210"
M->VALDIR="102030"
SENHA=SPACE(20)
TENTATIVA=0
DO WHILE.T.
SET CURSOR ON
SETCOLOR ("W+/R")
SOMBRA(09,25,15,55)
@ 09,25 CLEAR TO 15,55
@ 09,25 TO 15,55    COLOR ("W/R")
@ 09,25 SAY CHR(2)  COLOR ("RG+/R")
@ 11,26 say PADC(" Qual a senha?:",29)
@ 13,31 GET SENHA PICT[@!] COLOR("W+/N")
READ
SET CURSOR OFF
IF SENHA=M->MARCOS
     @ 09,25 CLEAR TO 15,55
     @ 09,25 TO 15,55    COLOR ("W/R")
     @ 12,26 say PADC(" Acesso concedido!!! Marcos ",29)
     SET COLOR TO W
   exit
endif
IF SENHA=M->VALDIR
     @ 09,25 CLEAR TO 15,55
     @ 09,25 TO 15,55    COLOR ("W/R")
     @ 12,26 say PADC(" Acesso concedido!!! Valdir ",29)
     SET COLOR TO W
   exit
endif
     @ 09,25 CLEAR TO 15,55
     @ 09,25 TO 15,55    COLOR ("W/R")
     @ 11,26 say PADC(" Senha incorreta!!! ",29) COLOR("RG+/R")
     BEEP()
     @ 13,26 say PADC(" Acesso Negado!!! ",29)   COLOR("RG+/R")
     BEEP()
     Inkey(1)
TENTATIVA=TENTATIVA+1
     IF TENTATIVA<3
     MENSAGEM("Prossiga com a senha correta!")
     ENDIF
  ENDDO
BEEP()
RESTORE SCREEN FROM M->TELA_SEG
RETURN

FUNCTION DTTA
PARA L,C
*
CONTADOR=0
CIDADE=" -"+" JEQUIE/BAHIA"
HOJE=DATE()
SEMANA="Domingo      Segunda-feiraTerca-feira  Quarta-feira Quinta-feira Sexta-feira  S†bado       "
DIA=TRIM(SUBS(SEMANA,DOW(HOJE)*13-12,13))+", "+ALLTRIM(STR(DAY(HOJE),2))
MES="janeiro  fevereiromaráo    abril    maio     junho    "
MES=MES+"julho    agosto   setembro outubro  novembro dezembro "
DIA=DIA+" de "+TRIM(SUBS(MES,MONTH(HOJE)*9-8,9))+" de "
DIA=DIA+TRAN(YEAR(HOJE),"@E 9999")
FOR CONTA=0 TO LEN(DIA+CIDADE)+5 STEP +5
     SETCOLOR("G+/N")
     @ L,(80-LEN(DIA+CIDADE))/2 SAY PADR(SUBSTR(DIA+CIDADE,1,CONTA),LEN(DIA+CIDADE))
     inkey(0.01)
NEXT
RETURN


 
* Final do programa MFBFUN.PRG
