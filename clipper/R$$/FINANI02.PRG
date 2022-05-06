
* TITULO     :  M.F.B.   Consulta de Cheques   Vers„o 1.0
* DATA       : 09/04/97
* PROGRAMA   : FINANI02.PRG
* COMENTARIO : INCLUSAO ( 1. Cheques Pr‚-datados)
 
**
** Bloco de inser‡„o I02.B01
**
MENSAGEM("Aguarde abertura de arquivos")
SELE 1
IF .NOT. USEREDE("FINANCAS",.F.,10)
     BEEP()
     MENSAGEM("O arquivo FINANCAS n„o est  dispon¡vel",3)
     RETURN
ELSE
     SET INDEX TO FINAN001,FINAN002,FINAN003,FINAN004
ENDIF
SELE 1
**
** Bloco de inser‡„o I02.B02
**
***
*** Inicio do bloco de substitui‡„o I02.B
COR("MENU")
@ LIN_MENU,00
@ LIN_MENU,01 SAY "Inclus„o ³  1. Cheques Pr‚-datados"
M->P_VERI = .T.
M->X_VERI = .F.
M->CNF_XXX=.T.
M->IN_CLUI=.T.
DO WHILE .T.
     **
     ** Bloco de inser‡„o I02.B03
     **
     MENSAGEM("Tecle <ESC> para retornar")
     IF M->P_VERI
          **
          ** Bloco de inser‡„o I02.B04
          **
          IF M->CNF_XXX
               IF M->CNF_REP
                    M->CNF_XXX=.F.
               ENDIF
               *
               * -> Inicializa variaveis
               CARREG02(1)
          ELSE
               M->X_VERI = .T.
          ENDIF
     ELSE
          M->X_VERI = .T.
          **
          ** Bloco de inser‡„o I02.B05
          **
     ENDIF
     *
     * -> Carrega tela de cadastro
     IF CARGET02(IIF(M->AL_TERA,2,1))=.F.
          IF M->AL_TERA
               **
               ** Bloco de inser‡„o I02.B06
               **
               CARREG02(2)
               M->X_VERI = .T.
               CARGET02(5)
               BEEP()
               IF PERG("Registro j  cadastrado. Deseja alterar ?")="S"
                    **
                    ** Bloco de inser‡„o I02.B07
                    **
                    M->IN_CLUI=.F.
                    M->P_VERI=.F.
               ELSE
                    **
                    ** Bloco de inser‡„o I02.B08
                    **
                    M->AL_TERA=.F.
               ENDIF
               LOOP
          ENDIF
          **
          ** Bloco de inser‡„o I02.B09
          **
          EXIT
     ENDIF
     **
     ** Bloco de inser‡„o I02.B10
     **
     IF PERG("Confirma as informa‡”es ?")="N"
          *
          * -> Faz reedicao
          M->P_VERI = .F.
          **
          ** Bloco de inser‡„o I02.B11
          **
          LOOP
     ENDIF
     M->P_VERI = .T.
     M->X_VERI = .F.
     **
     ** Bloco de inser‡„o I02.B12
     **
     IF M->IN_CLUI
          IF .NOT. ADIREG(0)
               M->P_VERI=.F.
               MENSAGEM("Inclus„o n„o foi bem sucedida",3)
               MENSAGEM("Tecle <ESC> para retornar")
               LOOP
          ENDIF
     ELSE
          IF .NOT. REGLOCK(20)
               BEEP()
               MENSAGEM("Atualiza‡„o n„o foi bem sucedida",5)
               MENSAGEM("Tecle <ESC> para retornar")
               LOOP
          ENDIF
     ENDIF
     *
     * -> Atualiza o banco de dados
     SALVAR02()
     COMMIT
     UNLOCK
     IF .NOT. M->IN_CLUI
          M->IN_CLUI=.T.
     ENDIF
ENDDO
RESTSCREEN(LIN_MENU+1,00,23,79,TELA_PRI)
**
** Bloco de inser‡„o I02.B13
**
*** Final do bloco de substitui‡„o I02.B
***
 
FUNCTION VERI002
*
* -> Funcao que verifica duplicidade no arquivo "FINANCAS"
PARA R_PARA
M->I_REG=RECN()
M->ORDEM = INDEXORD()
SET ORDER TO 3
SEEK M->F_PAG__DOC+M->NUMERO_DOC+M->BANCO+M->CLIENT_DOC
IF M->I_REG=RECN() .AND. R_PARA=2
     SET ORDER TO M->ORDEM
     RETURN .T.
ENDIF
IF .NOT. EOF()
     IF R_PARA=2
          @ 00,00 SAY ""
          BEEP()
          MENSAGEM("Registro j  cadastrado",3)
          MENSAGEM("Tecle <ESC> para retornar")
          GOTO M->I_REG
          RETURN .F.
     ELSE
          M->AL_TERA=.T.
          CLEAR GETS
          SET ORDER TO M->ORDEM
          RETURN .T.
     ENDIF
ENDIF
SET ORDER TO M->ORDEM
GOTO M->I_REG
RETURN .T.
 
FUNCTION IFU02001
*
* -> Funcao que cria uma tabela para o campo "ESTADO"
DECLARE I_TEM[1] , RESUL_T[1]
I_TEM[1] = "1"
RESUL_T[1] = "Cheque a Receber"
SETCOLOR(CONTECOR[8])
FOR M->PO_S = 1 TO 1 STEP -1
     IF M->ESTADO = I_TEM[PO_S]
          @  8,12 SAY RESUL_T[PO_S]
          M->PO_S = -1
     ENDIF
NEXT
IF M->PO_S = 0
     @  8,12 SAY SPACE(16)
     IF LEN(READVAR())<>0
          DECLARE BAR_RA[1]
          FOR M->PO_S = 1 TO 1
               BAR_RA[M->PO_S] = " [" + I_TEM[M->PO_S] + "]  " + RESUL_T[M->PO_S]
          NEXT
          C_TAB=C_SOM
          L_TAB=L_SOM
          SOMBRA(L_SOM,C_SOM,.T.)
          SAVE SCREEN TO M->T_ELA
          JANELA(08,22,16,56)
          COR("MENU")
          @ 11,27 CLEAR TO 13,51
          KEYBOARD CHR(65)
          M->PO_S=ACHOICE(12,28,12,50,BAR_RA)
          RESTORE SCREEN FROM M->T_ELA
          SOMBRA(L_TAB,C_TAB)
          IF M->PO_S <> 0
               M->ESTADO = I_TEM[M->PO_S]
               SETCOLOR(CONTECOR[8])
               @  8,12 SAY RESUL_T[M->PO_S]
          ENDIF
          COR("GETS")
          RETURN .F.
     ENDIF
ENDIF
RETURN .T.
 
FUNCTION IFU02002
*
* -> Validacao para o campo NUMERO_DOC
IF .NOT.(.NOT.EMPTY(M->NUMERO_DOC)) .AND. LASTKEY()<>5
     BEEP()
     MENSAGEM("Informa‡„o nescess ria",3)
     MENSAGEM("Tecle <ESC> para retornar")
     RETURN .F.
ENDIF
RETURN .T.
 
FUNCTION IFU02003
*
* -> Validacao para o campo CLIENT_DOC
IF .NOT.(.NOT.EMPTY(M->CLIENT_DOC)) .AND. LASTKEY()<>5
     BEEP()
     MENSAGEM("Nao vazio",3)
     MENSAGEM("Tecle <ESC> para retornar")
     RETURN .F.
ENDIF
*
* -> Validacao para o campo CLIENT_DOC
IF .NOT.(.NOT.EMPTY(M->CLIENT_DOC)) .AND. LASTKEY()<>5
     BEEP()
     MENSAGEM("Informa‡1",3)
     MENSAGEM("Tecle <ESC> para retornar")
     RETURN .F.
ENDIF
*
* -> Validacao para o campo CLIENT_DOC
IF .NOT.(.NOT.EMPTY(M->CLIENT_DOC)) .AND. LASTKEY()<>5
     BEEP()
     MENSAGEM("Informa‡„o nescess ria",3)
     MENSAGEM("Tecle <ESC> para retornar")
     RETURN .F.
ENDIF
RETURN .T.
 
FUNCTION IFU02004
*
* -> Validacao para o campo VALOR__DOC
IF .NOT.(.NOT.EMPTY(M->VALOR__DOC)) .AND. LASTKEY()<>5
     BEEP()
     MENSAGEM("Nao vazio",3)
     MENSAGEM("Tecle <ESC> para retornar")
     RETURN .F.
ENDIF
*
* -> Validacao para o campo VALOR__DOC
IF .NOT.(.NOT.EMPTY(M->VALOR__DOC)) .AND. LASTKEY()<>5
     BEEP()
     MENSAGEM("Informa‡„o nescess ria",3)
     MENSAGEM("Tecle <ESC> para retornar")
     RETURN .F.
ENDIF
RETURN .T.
 
FUNCTION IFU02005
*
* -> Funcao que cria uma tabela para o campo "F_PAG__DOC"
DECLARE I_TEM[1] , RESUL_T[1]
I_TEM[1] = "1"
RESUL_T[1] = "Pr‚-datado"
SETCOLOR(CONTECOR[8])
FOR M->PO_S = 1 TO 1 STEP -1
     IF M->F_PAG__DOC = I_TEM[PO_S]
          @  8,32 SAY RESUL_T[PO_S]
          M->PO_S = -1
     ENDIF
NEXT
IF M->PO_S = 0
     @  8,32 SAY SPACE(10)
     IF LEN(READVAR())<>0
          DECLARE BAR_RA[1]
          FOR M->PO_S = 1 TO 1
               BAR_RA[M->PO_S] = " [" + I_TEM[M->PO_S] + "]  " + RESUL_T[M->PO_S]
          NEXT
          C_TAB=C_SOM
          L_TAB=L_SOM
          SOMBRA(L_SOM,C_SOM,.T.)
          SAVE SCREEN TO M->T_ELA
          JANELA(08,25,16,53)
          COR("MENU")
          @ 11,30 CLEAR TO 13,48
          KEYBOARD CHR(65)
          M->PO_S=ACHOICE(12,31,12,47,BAR_RA)
          RESTORE SCREEN FROM M->T_ELA
          SOMBRA(L_TAB,C_TAB)
          IF M->PO_S <> 0
               M->F_PAG__DOC = I_TEM[M->PO_S]
               SETCOLOR(CONTECOR[8])
               @  8,32 SAY RESUL_T[M->PO_S]
          ENDIF
          COR("GETS")
          RETURN .F.
     ENDIF
ENDIF
RETURN .T.
 
FUNCTION IFU02008
*
* -> Validacao para o campo VENCIM_DOC
IF .NOT.(.NOT.EMPTY(M->VENCIM_DOC)) .AND. LASTKEY()<>5
     BEEP()
     MENSAGEM("Nao vazio",3)
     MENSAGEM("Tecle <ESC> para retornar")
     RETURN .F.
ENDIF
*
* -> Validacao para o campo VENCIM_DOC
IF .NOT.(.NOT.EMPTY(M->VENCIM_DOC)) .AND. LASTKEY()<>5
     BEEP()
     MENSAGEM("Informa‡„o nescess ria",3)
     MENSAGEM("Tecle <ESC> para retornar")
     RETURN .F.
ENDIF
RETURN .T.
 
FUNCTION IFU02009
*
* -> Validacao para o campo PAGAME_DOC
IF .NOT.(M->PAGAME_DOC>=M->VENCIM_DOC) .AND. LASTKEY()<>5
     BEEP()
     MENSAGEM("Data deve ser maior que o vencimento",3)
     MENSAGEM("Tecle <ESC> para retornar")
     RETURN .F.
ENDIF
RETURN .T.
 
FUNCTION IFU02010
*
* -> Funcao que cria uma tabela para o campo "BANCO"
DECLARE I_TEM[12] , RESUL_T[12]
I_TEM[1] = "BNB"
RESUL_T[1] = "Banco do Nordeste S.A."+SPACE(6)
I_TEM[2] = "BBB"
RESUL_T[2] = "Bamerindus S.A."+SPACE(13)
I_TEM[3] = "BNO"
RESUL_T[3] = "Banorte S.A."+SPACE(16)
I_TEM[4] = "BRL"
RESUL_T[4] = "Banco Real S.A."+SPACE(13)
I_TEM[5] = "BB "
RESUL_T[5] = "Banco do Brasil S.A."+SPACE(8)
I_TEM[6] = "BAN"
RESUL_T[6] = "Baneb S.A."+SPACE(18)
I_TEM[7] = "BCB"
RESUL_T[7] = "Banco Central do Brasil S.A."
I_TEM[8] = "BRA"
RESUL_T[8] = "Bradesco"+SPACE(20)
I_TEM[9] = "ITA"
RESUL_T[9] = "Banco Itau S.A."+SPACE(13)
I_TEM[10] = "BNP"
RESUL_T[10] = "Banespa"+SPACE(21)
I_TEM[11] = "CEF"
RESUL_T[11] = "Caixa Economica Federal"+SPACE(5)
I_TEM[12] = "EXE"
RESUL_T[12] = "Excel Economico S.A."+SPACE(8)
SETCOLOR(CONTECOR[8])
FOR M->PO_S = 12 TO 1 STEP -1
     IF M->BANCO = I_TEM[PO_S]
          @ 17,26 SAY RESUL_T[PO_S]
          M->PO_S = -1
     ENDIF
NEXT
IF M->PO_S = 0
     @ 17,26 SAY SPACE(28)
     IF LEN(READVAR())<>0
          DECLARE BAR_RA[12]
          FOR M->PO_S = 1 TO 12
               BAR_RA[M->PO_S] = " [" + I_TEM[M->PO_S] + "]  " + RESUL_T[M->PO_S]
          NEXT
          C_TAB=C_SOM
          L_TAB=L_SOM
          SOMBRA(L_SOM,C_SOM,.T.)
          SAVE SCREEN TO M->T_ELA
          JANELA(05,15,19,63)
          COR("MENU")
          @ 08,20 CLEAR TO 16,58
          KEYBOARD CHR(65)
          M->PO_S=ACHOICE(09,21,15,57,BAR_RA)
          RESTORE SCREEN FROM M->T_ELA
          SOMBRA(L_TAB,C_TAB)
          IF M->PO_S <> 0
               M->BANCO = I_TEM[M->PO_S]
               SETCOLOR(CONTECOR[8])
               @ 17,26 SAY RESUL_T[M->PO_S]
          ENDIF
          COR("GETS")
          RETURN .F.
     ENDIF
ENDIF
RETURN .T.
 
FUNCTION CARREG02
*
* -> Carrega variaveis para entrada ou altercao de dados
PARA R_CAR
**
** Bloco de inser‡„o I02.B14
**
PUBLIC ESTADO,NUMERO_DOC,CLIENT_DOC,VALOR__DOC,F_PAG__DOC,OBS_01_DOC,OBS_02_DOC,VENCIM_DOC,PAGAME_DOC,BANCO
IF M->R_CAR=1
     M->ESTADO=SPACE(  1)
     M->NUMERO_DOC=SPACE( 15)
     M->CLIENT_DOC=SPACE( 40)
     M->VALOR__DOC=0
     M->F_PAG__DOC=SPACE(  1)
     M->OBS_01_DOC=SPACE( 30)
     M->OBS_02_DOC=SPACE( 30)
     M->VENCIM_DOC=CTOD("  /  /  ")
     M->PAGAME_DOC=CTOD("  /  /  ")
     M->BANCO=SPACE(  3)
     *
     * -> Deficao de valores constantes
     M->ESTADO="1"
     M->F_PAG__DOC="1"
     **
     ** Bloco de inser‡„o I02.B15
     **
ELSE
     M->ESTADO=ESTADO
     M->NUMERO_DOC=NUMERO_DOC
     M->CLIENT_DOC=CLIENT_DOC
     M->VALOR__DOC=VALOR__DOC
     M->F_PAG__DOC=F_PAG__DOC
     M->OBS_01_DOC=OBS_01_DOC
     M->OBS_02_DOC=OBS_02_DOC
     M->VENCIM_DOC=VENCIM_DOC
     M->PAGAME_DOC=PAGAME_DOC
     M->BANCO=BANCO
     **
     ** Bloco de inser‡„o I02.B16
     **
ENDIF
 
FUNCTION CARGET02
*
* -> Formata a tela para entrada ou alteracao de dados
PARA R_CAR
IF R_CAR<>5
     M->AL_TERA=.F.
ENDIF
**
** Bloco de inser‡„o I02.B17
**
JANELA( 5, 7,19,68," 1. Cheques Pr‚-datados")
COR("CERCADURAS")
*
* -> Monta cercaduras
@  6, 8 TO 18,67
**
** Bloco de inser‡„o I02.B18
**
COR("GETS")
*
* -> Carrega caracteres avulsos
@ 10,26 SAY "Titular do documento"
@ 10,10 SAY "No. documento"
@ 13,10 SAY "Valor"
@ 13,26 SAY "Controle"
@ 16,10 SAY "Data /Sq"
@ 16,21 SAY "SIG  Banco"
@  7,10 SAY "E Documento"
@  7,30 SAY "F Cheque"
**
** Bloco de inser‡„o I02.B21
**
IF M->X_VERI
     IFU02010()
     IFU02001()
     IFU02005()
ENDIF
*
* -> Monta tela de cadastro
@  8,10 GET M->ESTADO PICTURE "@!" VALID IFU02001()
@  8,30 GET M->F_PAG__DOC PICTURE "@!" VALID IFU02005()
@ 11,10 GET M->NUMERO_DOC PICTURE "@!" VALID IFU02002()
@ 11,26 GET M->CLIENT_DOC PICTURE "@!" VALID IFU02003() .AND.  VERI002(M->R_CAR)
@ 14,10 GET M->VALOR__DOC PICTURE "@E 9,999,999.99" VALID IFU02004()
@ 14,26 GET M->OBS_01_DOC
@ 17,10 GET M->VENCIM_DOC VALID IFU02008()
@ 17,21 GET M->BANCO PICTURE "@!" VALID IFU02010()
**
** Bloco de inser‡„o I02.B24
**
IF M->R_CAR=5
     CLEAR GETS
     RETURN .F.
ENDIF
IF M->R_CAR=3 .OR. M->R_CAR=0
     CLEAR GETS
     IF M->R_CAR=0
          RETURN .T.
     ENDIF
     MENSAGEM("Tecle algo para continuar")
     M->R_X=INKEY(0)
     IF M->R_X=27
          RETURN .F.
     ENDIF
ELSE
     SET CURSOR ON
     READ
     SET CURSOR OFF
     IF M->AL_TERA
          RETURN .F.
     ENDIF
     IF LASTKEY()=27
          RETURN .F.
     ENDIF
ENDIF
RETURN .T.
 
FUNCTION SALVAR02
*
* -> Salva o conteudo das variaveis de entrada no arquivo
**
** Bloco de inser‡„o I02.B27
**
REPLACE ESTADO WITH M->ESTADO
REPLACE NUMERO_DOC WITH M->NUMERO_DOC
REPLACE CLIENT_DOC WITH M->CLIENT_DOC
REPLACE VALOR__DOC WITH M->VALOR__DOC
REPLACE F_PAG__DOC WITH M->F_PAG__DOC
REPLACE OBS_01_DOC WITH M->OBS_01_DOC
REPLACE OBS_02_DOC WITH M->OBS_02_DOC
REPLACE VENCIM_DOC WITH M->VENCIM_DOC
REPLACE PAGAME_DOC WITH M->PAGAME_DOC
REPLACE BANCO WITH M->BANCO
**
** Bloco de inser‡„o I02.B28
**
 
* Final do programa FINANI02.PRG