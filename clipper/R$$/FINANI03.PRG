
* TITULO     :  M.F.B.   Consulta de Cheques   Vers„o 1.0
* DATA       : 09/04/97
* PROGRAMA   : FINANI03.PRG
* COMENTARIO : INCLUSAO ( 2. Cheques Recebidos)
 
**
** Bloco de inser‡„o I03.B01
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
** Bloco de inser‡„o I03.B02
**
***
*** Inicio do bloco de substitui‡„o I03.B
COR("MENU")
@ LIN_MENU,00
@ LIN_MENU,01 SAY "Inclus„o ³  2. Cheques Recebidos"
M->P_VERI = .T.
M->X_VERI = .F.
M->CNF_XXX=.T.
M->IN_CLUI=.T.
DO WHILE .T.
     **
     ** Bloco de inser‡„o I03.B03
     **
     MENSAGEM("Tecle <ESC> para retornar")
     IF M->P_VERI
          **
          ** Bloco de inser‡„o I03.B04
          **
          IF M->CNF_XXX
               IF M->CNF_REP
                    M->CNF_XXX=.F.
               ENDIF
               *
               * -> Inicializa variaveis
               CARREG03(1)
          ELSE
               M->X_VERI = .T.
          ENDIF
     ELSE
          M->X_VERI = .T.
          **
          ** Bloco de inser‡„o I03.B05
          **
     ENDIF
     *
     * -> Carrega tela de cadastro
     IF CARGET03(IIF(M->AL_TERA,2,1))=.F.
          IF M->AL_TERA
               **
               ** Bloco de inser‡„o I03.B06
               **
               CARREG03(2)
               M->X_VERI = .T.
               CARGET03(5)
               BEEP()
               IF PERG("Registro j  cadastrado. Deseja alterar ?")="S"
                    **
                    ** Bloco de inser‡„o I03.B07
                    **
                    M->IN_CLUI=.F.
                    M->P_VERI=.F.
               ELSE
                    **
                    ** Bloco de inser‡„o I03.B08
                    **
                    M->AL_TERA=.F.
               ENDIF
               LOOP
          ENDIF
          **
          ** Bloco de inser‡„o I03.B09
          **
          EXIT
     ENDIF
     **
     ** Bloco de inser‡„o I03.B10
     **
     IF PERG("Confirma as informa‡”es ?")="N"
          *
          * -> Faz reedicao
          M->P_VERI = .F.
          **
          ** Bloco de inser‡„o I03.B11
          **
          LOOP
     ENDIF
     M->P_VERI = .T.
     M->X_VERI = .F.
     **
     ** Bloco de inser‡„o I03.B12
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
     SALVAR03()
     COMMIT
     UNLOCK
     IF .NOT. M->IN_CLUI
          M->IN_CLUI=.T.
     ENDIF
ENDDO
RESTSCREEN(LIN_MENU+1,00,23,79,TELA_PRI)
**
** Bloco de inser‡„o I03.B13
**
*** Final do bloco de substitui‡„o I03.B
***
 
FUNCTION VERI003
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
 
FUNCTION IFU03001
*
* -> Funcao que cria uma tabela para o campo "ESTADO"
DECLARE I_TEM[1] , RESUL_T[1]
I_TEM[1] = "2"
RESUL_T[1] = "Cheque Q U I T A D O"
SETCOLOR(CONTECOR[8])
FOR M->PO_S = 1 TO 1 STEP -1
     IF M->ESTADO = I_TEM[PO_S]
          @ 11,11 SAY RESUL_T[PO_S]
          M->PO_S = -1
     ENDIF
NEXT
IF M->PO_S = 0
     @ 11,11 SAY SPACE(20)
     IF LEN(READVAR())<>0
          DECLARE BAR_RA[1]
          FOR M->PO_S = 1 TO 1
               BAR_RA[M->PO_S] = " [" + I_TEM[M->PO_S] + "]  " + RESUL_T[M->PO_S]
          NEXT
          C_TAB=C_SOM
          L_TAB=L_SOM
          SOMBRA(L_SOM,C_SOM,.T.)
          SAVE SCREEN TO M->T_ELA
          JANELA(08,20,16,58)
          COR("MENU")
          @ 11,25 CLEAR TO 13,53
          KEYBOARD CHR(65)
          M->PO_S=ACHOICE(12,26,12,52,BAR_RA)
          RESTORE SCREEN FROM M->T_ELA
          SOMBRA(L_TAB,C_TAB)
          IF M->PO_S <> 0
               M->ESTADO = I_TEM[M->PO_S]
               SETCOLOR(CONTECOR[8])
               @ 11,11 SAY RESUL_T[M->PO_S]
          ENDIF
          COR("GETS")
          RETURN .F.
     ENDIF
ENDIF
RETURN .T.
 
FUNCTION IFU03002
*
* -> Validacao para o campo NUMERO_DOC
IF .NOT.(.NOT.EMPTY(M->NUMERO_DOC)) .AND. LASTKEY()<>5
     BEEP()
     MENSAGEM("Informa‡„o nescess ria",3)
     MENSAGEM("Tecle <ESC> para retornar")
     RETURN .F.
ENDIF
RETURN .T.
 
FUNCTION IFU03003
*
* -> Validacao para o campo CLIENT_DOC
IF .NOT.(.NOT.EMPTY(M->CLIENT_DOC)) .AND. LASTKEY()<>5
     BEEP()
     MENSAGEM("Informa‡„o nescess ria",3)
     MENSAGEM("Tecle <ESC> para retornar")
     RETURN .F.
ENDIF
RETURN .T.
 
FUNCTION IFU03004
*
* -> Validacao para o campo VALOR__DOC
IF .NOT.(.NOT.EMPTY(M->VALOR__DOC)) .AND. LASTKEY()<>5
     BEEP()
     MENSAGEM("Informa‡„o nescess ria",3)
     MENSAGEM("Tecle <ESC> para retornar")
     RETURN .F.
ENDIF
RETURN .T.
 
FUNCTION IFU03005
*
* -> Funcao que cria uma tabela para o campo "F_PAG__DOC"
DECLARE I_TEM[1] , RESUL_T[1]
I_TEM[1] = "1"
RESUL_T[1] = "Cheque PrŠ-datado"
SETCOLOR(CONTECOR[8])
FOR M->PO_S = 1 TO 1 STEP -1
     IF M->F_PAG__DOC = I_TEM[PO_S]
          @  8,11 SAY RESUL_T[PO_S]
          M->PO_S = -1
     ENDIF
NEXT
IF M->PO_S = 0
     @  8,11 SAY SPACE(17)
     IF LEN(READVAR())<>0
          DECLARE BAR_RA[1]
          FOR M->PO_S = 1 TO 1
               BAR_RA[M->PO_S] = " [" + I_TEM[M->PO_S] + "]  " + RESUL_T[M->PO_S]
          NEXT
          C_TAB=C_SOM
          L_TAB=L_SOM
          SOMBRA(L_SOM,C_SOM,.T.)
          SAVE SCREEN TO M->T_ELA
          JANELA(08,22,16,57)
          COR("MENU")
          @ 11,27 CLEAR TO 13,52
          KEYBOARD CHR(65)
          M->PO_S=ACHOICE(12,28,12,51,BAR_RA)
          RESTORE SCREEN FROM M->T_ELA
          SOMBRA(L_TAB,C_TAB)
          IF M->PO_S <> 0
               M->F_PAG__DOC = I_TEM[M->PO_S]
               SETCOLOR(CONTECOR[8])
               @  8,11 SAY RESUL_T[M->PO_S]
          ENDIF
          COR("GETS")
          RETURN .F.
     ENDIF
ENDIF
RETURN .T.
 
FUNCTION IFU03008
*
* -> Validacao para o campo VENCIM_DOC
IF .NOT.(.NOT.EMPTY(M->VENCIM_DOC)) .AND. LASTKEY()<>5
     BEEP()
     MENSAGEM("Informa‡„o Nescess ria",3)
     MENSAGEM("Tecle <ESC> para retornar")
     RETURN .F.
ENDIF
RETURN .T.
 
FUNCTION IFU03009
*
* -> Validacao para o campo PAGAME_DOC
IF .NOT.(M->PAGAME_DOC>=M->VENCIM_DOC) .AND. LASTKEY()<>5
     BEEP()
     MENSAGEM("O pagamento deve ser igual ou maior que o vencimento",3)
     MENSAGEM("Tecle <ESC> para retornar")
     RETURN .F.
ENDIF
RETURN .T.
 
FUNCTION CARREG03
*
* -> Carrega variaveis para entrada ou altercao de dados
PARA R_CAR
**
** Bloco de inser‡„o I03.B14
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
     M->ESTADO="2"
     M->F_PAG__DOC="1"
     **
     ** Bloco de inser‡„o I03.B15
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
     ** Bloco de inser‡„o I03.B16
     **
ENDIF
 
FUNCTION CARGET03
*
* -> Formata a tela para entrada ou alteracao de dados
PARA R_CAR
IF R_CAR<>5
     M->AL_TERA=.F.
ENDIF
**
** Bloco de inser‡„o I03.B17
**
JANELA( 5, 6,19,68," 2. Cheques Recebidos")
COR("CERCADURAS")
*
* -> Monta cercaduras
@  6, 7 TO 18,67
**
** Bloco de inser‡„o I03.B18
**
COR("GETS")
*
* -> Carrega caracteres avulsos
@ 10, 9 SAY "N Estado"
@  7, 9 SAY "F Forma de pagamento"
@ 10,51 SAY "Banco"
@ 16,41 SAY "Sacar em"
@ 13,51 SAY "Valor"
@ 13, 9 SAY "Titular do pr‚-datado"
@ 16, 9 SAY "Controle para pr‚-datado"
@ 16,51 SAY "Apresetado"
@ 10,33 SAY "No.Documento"
**
** Bloco de inser‡„o I03.B21
**
IF M->X_VERI
     IFU03001()
     IFU03005()
ENDIF
*
* -> Monta tela de cadastro
@ 11, 9 GET M->ESTADO PICTURE "@!" VALID IFU03001()
@ 11,33 GET M->NUMERO_DOC PICTURE "@!" VALID IFU03002()
@ 11,51 GET M->BANCO PICTURE "@!"
@ 14, 9 GET M->CLIENT_DOC PICTURE "@!" VALID IFU03003() .AND.  VERI003(M->R_CAR)
@ 14,51 GET M->VALOR__DOC PICTURE "@E 9,999,999.99" VALID IFU03004()
@ 17, 9 GET M->OBS_01_DOC
@ 17,41 GET M->VENCIM_DOC VALID IFU03008()
@ 17,51 GET M->PAGAME_DOC VALID IFU03009()
@  8, 9 GET M->F_PAG__DOC PICTURE "@!" VALID IFU03005()
**
** Bloco de inser‡„o I03.B24
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
 
FUNCTION SALVAR03
*
* -> Salva o conteudo das variaveis de entrada no arquivo
**
** Bloco de inser‡„o I03.B27
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
** Bloco de inser‡„o I03.B28
**
 
* Final do programa FINANI03.PRG