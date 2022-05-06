
* TITULO     :  M.F.B. Controle Finaceiro
* DATA       : 23/10/96
* PROGRAMA   : FINANI01.PRG
* COMENTARIO : INCLUSAO (Contas a receber)
 
**
** Bloco de inser‡„o I01.B01
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
** Bloco de inser‡„o I01.B02
**
***
*** Inicio do bloco de substitui‡„o I01.B
COR("MENU")
@ LIN_MENU,00
@ LIN_MENU,01 SAY "Inclus„o ³ Contas a receber"
M->P_VERI = .T.
M->X_VERI = .F.
M->CNF_XXX=.T.
M->IN_CLUI=.T.
DO WHILE .T.
   **
   ** Bloco de inser‡„o I01.B03
   **
   MENSAGEM("Tecle <ESC> para retornar")
   IF M->P_VERI
      **
      ** Bloco de inser‡„o I01.B04
      **
      IF M->CNF_XXX
         IF M->CNF_REP
            M->CNF_XXX=.F.
         ENDIF
         *
         * -> Inicializa variaveis
         CARREG01(1)
      ELSE
         M->X_VERI = .T.
      ENDIF
   ELSE
      M->X_VERI = .T.
      **
      ** Bloco de inser‡„o I01.B05
      **
   ENDIF
   *
   * -> Carrega tela de cadastro
   IF CARGET01(IIF(M->AL_TERA,2,1))=.F.
      IF M->AL_TERA
         **
         ** Bloco de inser‡„o I01.B06
         **
         CARREG01(2)
         M->X_VERI = .T.
         CARGET01(5)
         BEEP()
         IF PERG("Registro j  cadastrado. Deseja alterar ?")="S"
            **
            ** Bloco de inser‡„o I01.B07
            **
            M->IN_CLUI=.F.
            M->P_VERI=.F.
         ELSE
            **
            ** Bloco de inser‡„o I01.B08
            **
            M->AL_TERA=.F.
         ENDIF
         LOOP
      ENDIF
      **
      ** Bloco de inser‡„o I01.B09
      **
      EXIT
   ENDIF
   **
   ** Bloco de inser‡„o I01.B10
   **
   IF PERG("Confirma as informa‡”es ?")="N"
      *
      * -> Faz reedicao
      M->P_VERI = .F.
      **
      ** Bloco de inser‡„o I01.B11
      **
      LOOP
   ENDIF
   M->P_VERI = .T.
   M->X_VERI = .F.
   **
   ** Bloco de inser‡„o I01.B12
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
   SALVAR01()
   COMMIT
   UNLOCK
   IF .NOT. M->IN_CLUI
      M->IN_CLUI=.T.
   ENDIF
ENDDO
RESTSCREEN(LIN_MENU+1,00,23,79,TELA_PRI)
**
** Bloco de inser‡„o I01.B13
**
*** Final do bloco de substitui‡„o I01.B
***
 
FUNCTION VERI001
*
* -> Funcao que verifica duplicidade no arquivo "FINANCAS"
PARA R_PARA
M->I_REG=RECN()
M->ORDEM = INDEXORD()
SET ORDER TO 3
SEEK M->DOCUMENTO+M->NUMERO_DOC
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
 
FUNCTION IFU01002
*
* -> Funcao que cria uma tabela para o campo "DOCUMENTO"
DECLARE I_TEM[4] , RESUL_T[4]
I_TEM[1] = "1"
RESUL_T[1] = "Inclusao de Dinheiro a receber"
I_TEM[2] = "2"
RESUL_T[2] = "Inclusao de Cheque   a receber"
I_TEM[3] = "3"
RESUL_T[3] = "Inclusao de Nota     a receber"
I_TEM[4] = "4"
RESUL_T[4] = "Outros documentos a receber"+SPACE(3)
SETCOLOR(CONTECOR[8])
FOR M->PO_S = 4 TO 1 STEP -1
   IF M->DOCUMENTO = I_TEM[PO_S]
      @  9,23 SAY RESUL_T[PO_S]
      M->PO_S = -1
   ENDIF
NEXT
IF M->PO_S = 0
   @  9,23 SAY SPACE(30)
   IF LEN(READVAR())<>0
      DECLARE BAR_RA[4]
      FOR M->PO_S = 1 TO 4
         BAR_RA[M->PO_S] = " [" + I_TEM[M->PO_S] + "]  " + RESUL_T[M->PO_S]
      NEXT
      C_TAB=C_SOM
      L_TAB=L_SOM
      SOMBRA(L_SOM,C_SOM,.T.)
      SAVE SCREEN TO M->T_ELA
      JANELA(06,15,17,63)
      COR("MENU")
      @ 09,20 CLEAR TO 14,58
      KEYBOARD CHR(65)
      M->PO_S=ACHOICE(10,21,13,57,BAR_RA)
      RESTORE SCREEN FROM M->T_ELA
      SOMBRA(L_TAB,C_TAB)
      IF M->PO_S <> 0
         M->DOCUMENTO = I_TEM[M->PO_S]
         SETCOLOR(CONTECOR[8])
         @  9,23 SAY RESUL_T[M->PO_S]
      ENDIF
      COR("GETS")
      RETURN .F.
   ENDIF
ENDIF
RETURN .T.
 
FUNCTION IFU01003
*
* -> Validacao para o campo NUMERO_DOC
IF .NOT.(.NOT.EMPTY(M->NUMERO_DOC)) .AND. LASTKEY()<>5
   BEEP()
   MENSAGEM("nao vazio",3)
   MENSAGEM("Tecle <ESC> para retornar")
   RETURN .F.
ENDIF
*
* -> Validacao para o campo NUMERO_DOC
IF .NOT.(.NOT.EMPTY(M->NUMERO_DOC)) .AND. LASTKEY()<>5
   BEEP()
   MENSAGEM(" nao vazio",3)
   MENSAGEM("Tecle <ESC> para retornar")
   RETURN .F.
ENDIF
RETURN .T.
 
FUNCTION IFU01004
*
* -> Validacao para o campo CLIENT_DOC
IF .NOT.(.NOT.EMPTY(M->CLIENT_DOC)) .AND. LASTKEY()<>5
   BEEP()
   MENSAGEM("nao vazio",3)
   MENSAGEM("Tecle <ESC> para retornar")
   RETURN .F.
ENDIF
RETURN .T.
 
FUNCTION IFU01009
*
* -> Validacao para o campo VENCIM_DOC
IF .NOT.(.NOT.EMPTY(M->VENCIM_DOC)) .AND. LASTKEY()<>5
   BEEP()
   MENSAGEM("nao vazio",3)
   MENSAGEM("Tecle <ESC> para retornar")
   RETURN .F.
ENDIF
*
* -> Validacao para o campo VENCIM_DOC
IF .NOT.(.NOT.EMPTY(M->VENCIM_DOC)) .AND. LASTKEY()<>5
   BEEP()
   MENSAGEM("nao vazio",3)
   MENSAGEM("Tecle <ESC> para retornar")
   RETURN .F.
ENDIF
RETURN .T.
 
FUNCTION CARREG01
*
* -> Carrega variaveis para entrada ou altercao de dados
PARA R_CAR
**
** Bloco de inser‡„o I01.B14
**
PUBLIC ESTADO,DOCUMENTO,NUMERO_DOC,CLIENT_DOC,VALOR__DOC,F_PAG__DOC,OBS_01_DOC,OBS_02_DOC,VENCIM_DOC,PAGAME_DOC
IF M->R_CAR=1
   M->ESTADO=SPACE(  1)
   M->DOCUMENTO=SPACE(  1)
   M->NUMERO_DOC=SPACE( 15)
   M->CLIENT_DOC=SPACE( 40)
   M->VALOR__DOC=0
   M->F_PAG__DOC=SPACE(  1)
   M->OBS_01_DOC=SPACE( 40)
   M->OBS_02_DOC=SPACE( 40)
   M->VENCIM_DOC=CTOD("  /  /  ")
   M->PAGAME_DOC=CTOD("  /  /  ")
   *
   * -> Deficao de valores constantes
   M->ESTADO="1"
   **
   ** Bloco de inser‡„o I01.B15
   **
ELSE
   M->ESTADO=ESTADO
   M->DOCUMENTO=DOCUMENTO
   M->NUMERO_DOC=NUMERO_DOC
   M->CLIENT_DOC=CLIENT_DOC
   M->VALOR__DOC=VALOR__DOC
   M->F_PAG__DOC=F_PAG__DOC
   M->OBS_01_DOC=OBS_01_DOC
   M->OBS_02_DOC=OBS_02_DOC
   M->VENCIM_DOC=VENCIM_DOC
   M->PAGAME_DOC=PAGAME_DOC
   **
   ** Bloco de inser‡„o I01.B16
   **
ENDIF
 
FUNCTION CARGET01
*
* -> Formata a tela para entrada ou alteracao de dados
PARA R_CAR
IF R_CAR<>5
   M->AL_TERA=.F.
ENDIF
**
** Bloco de inser‡„o I01.B17
**
M->PAGINA = 1
DO WHILE .T.
   *
   * -> Monta pagina 1
   IF M->PAGINA = 1
      COR("MENU")
      @ LIN_MENU,66 SAY "³ P gina : 01"
      FUNDO()
      JANELA( 5,17,11,56,"Contas a receber")
      **
      ** Bloco de inser‡„o I01.B18
      **
      COR("GETS")
      **
      ** Bloco de inser‡„o I01.B21
      **
      IF M->X_VERI
         IFU01002()
      ENDIF
      *
      * -> Monta tela de cadastro
      @  8,23 SAY "Documento :" GET M->DOCUMENTO PICTURE "@!" VALID IFU01002()
      **
      ** Bloco de inser‡„o I01.B24
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
         IF LASTKEY() = 27
            RETURN .F.
         ENDIF
         IF LASTKEY() = 18
            M->PAGINA = 1
            M->X_VERI = .T.
            LOOP
         ENDIF
      ENDIF
      M->PAGINA = 2
      LOOP
   ENDIF
   *
   * -> Monta pagina 2
   IF M->PAGINA = 2
      COR("MENU")
      @ LIN_MENU,66 SAY "³ P gina : 02"
      FUNDO()
      JANELA( 5,10,13,67,"Contas a receber")
      **
      ** Bloco de inser‡„o I01.B19
      **
      COR("GETS")
      **
      ** Bloco de inser‡„o I01.B22
      **
      *
      * -> Monta tela de cadastro
      @  7,12 SAY "Numero doc:" GET M->NUMERO_DOC PICTURE "@!" VALID IFU01003() .AND.  VERI001(M->R_CAR)
      @  8,12 SAY "Cliente   :" GET M->CLIENT_DOC PICTURE "@!" VALID IFU01004()
      @  9,12 SAY "Valor     :" GET M->VALOR__DOC PICTURE "@Z 9,999,999.99"
      @ 10,12 SAY "Vencimento:" GET M->VENCIM_DOC VALID IFU01009()
      @ 11,12 SAY "Obs Doc   :" GET M->OBS_01_DOC
      **
      ** Bloco de inser‡„o I01.B25
      **
      IF M->R_CAR=3
         CLEAR GETS
         MENSAGEM("Tecle algo para continuar")
         M->R_X=INKEY(0)
         IF M->R_X=27
            RETURN .F.
         ENDIF
      ELSE
         SET CURSOR ON
         READ
         SET CURSOR OFF
         IF LASTKEY() = 27
            RETURN .F.
         ENDIF
         IF LASTKEY() = 18
            M->PAGINA = 1
            M->X_VERI = .T.
            LOOP
         ENDIF
      ENDIF
      RETURN .T.
   ENDIF
ENDDO
 
FUNCTION SALVAR01
*
* -> Salva o conteudo das variaveis de entrada no arquivo
**
** Bloco de inser‡„o I01.B27
**
REPLACE ESTADO WITH M->ESTADO
REPLACE DOCUMENTO WITH M->DOCUMENTO
REPLACE NUMERO_DOC WITH M->NUMERO_DOC
REPLACE CLIENT_DOC WITH M->CLIENT_DOC
REPLACE VALOR__DOC WITH M->VALOR__DOC
REPLACE F_PAG__DOC WITH M->F_PAG__DOC
REPLACE OBS_01_DOC WITH M->OBS_01_DOC
REPLACE OBS_02_DOC WITH M->OBS_02_DOC
REPLACE VENCIM_DOC WITH M->VENCIM_DOC
REPLACE PAGAME_DOC WITH M->PAGAME_DOC
**
** Bloco de inser‡„o I01.B28
**
 
* Final do programa FINANI01.PRG