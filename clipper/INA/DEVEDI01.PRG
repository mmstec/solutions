
* TITULO     : Controle de Inadiplencia
* DATA       : 15/04/97
* PROGRAMA   : DEVEDI01.PRG
* COMENTARIO : INCLUSAO (Inadiplentes)
 
**
** Bloco de inser‡„o I01.B01
**
MENSAGEM("Aguarde abertura de arquivos")
SELE 1
IF .NOT. USEREDE("DEVEDOR",.F.,10)
   BEEP()
   MENSAGEM("O arquivo DEVEDOR n„o est  dispon¡vel",3)
   RETURN
ELSE
   SET INDEX TO DEVED001,DEVED002
ENDIF
SELE 1
**
** Bloco de inser‡„o I01.B02
**
***
*** Inicio do bloco de substitui‡„o I01.B
COR("MENU")
@ LIN_MENU,00
@ LIN_MENU,01 SAY "Inclus„o ³ Inadiplentes"
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
* -> Funcao que verifica duplicidade no arquivo "DEVEDOR"
PARA R_PARA
M->I_REG=RECN()
M->ORDEM = INDEXORD()
SET ORDER TO 1
SEEK M->DOCUMENTO
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
 
FUNCTION IFU01001
*
* -> Validacao para o campo NOME
IF .NOT.(.NOT.EMPTY(M->NOME)) .AND. LASTKEY()<>5
   BEEP()
   MENSAGEM("Nao vazio",3)
   MENSAGEM("Tecle <ESC> para retornar")
   RETURN .F.
ENDIF
RETURN .T.
 
FUNCTION IFU01002
*
* -> Validacao para o campo DOCUMENTO
IF .NOT.(.NOT.EMPTY(M->DOCUMENTO)) .AND. LASTKEY()<>5
   BEEP()
   MENSAGEM("nao vazio",3)
   MENSAGEM("Tecle <ESC> para retornar")
   RETURN .F.
ENDIF
RETURN .T.
 
FUNCTION IFU01003
*
* -> Validacao para o campo QUANT_SCOS
IF .NOT.(.NOT.EMPTY(M->QUANT_SCOS)) .AND. LASTKEY()<>5
   BEEP()
   MENSAGEM("nao vazio",3)
   MENSAGEM("Tecle <ESC> para retornar")
   RETURN .F.
ENDIF
RETURN .T.
 
FUNCTION IFU01004
*
* -> Validacao para o campo SELECAO
IF .NOT.(.NOT.EMPTY(M->SELECAO)) .AND. LASTKEY()<>5
   BEEP()
   MENSAGEM("nao vazio",3)
   MENSAGEM("Tecle <ESC> para retornar")
   RETURN .F.
ENDIF
*
* -> Funcao que cria uma tabela para o campo "SELECAO"
DECLARE I_TEM[4] , RESUL_T[4]
I_TEM[1] = "1"
RESUL_T[1] = "Inadiplente"
I_TEM[2] = "2"
RESUL_T[2] = "Confronto"+SPACE(2)
I_TEM[3] = "3"
RESUL_T[3] = "Funcionario"
I_TEM[4] = "4"
RESUL_T[4] = "Outro"+SPACE(6)
SETCOLOR(CONTECOR[8])
FOR M->PO_S = 4 TO 1 STEP -1
   IF M->SELECAO = I_TEM[PO_S]
      @ 12,33 SAY RESUL_T[PO_S]
      M->PO_S = -1
   ENDIF
NEXT
IF M->PO_S = 0
   @ 12,33 SAY SPACE(11)
   IF LEN(READVAR())<>0
      DECLARE BAR_RA[4]
      FOR M->PO_S = 1 TO 4
         BAR_RA[M->PO_S] = " [" + I_TEM[M->PO_S] + "]  " + RESUL_T[M->PO_S]
      NEXT
      C_TAB=C_SOM
      L_TAB=L_SOM
      SOMBRA(L_SOM,C_SOM,.T.)
      SAVE SCREEN TO M->T_ELA
      JANELA(06,25,17,54)
      COR("MENU")
      @ 09,30 CLEAR TO 14,49
      KEYBOARD CHR(65)
      M->PO_S=ACHOICE(10,31,13,48,BAR_RA)
      RESTORE SCREEN FROM M->T_ELA
      SOMBRA(L_TAB,C_TAB)
      IF M->PO_S <> 0
         M->SELECAO = I_TEM[M->PO_S]
         SETCOLOR(CONTECOR[8])
         @ 12,33 SAY RESUL_T[M->PO_S]
      ENDIF
      COR("GETS")
      RETURN .F.
   ENDIF
ENDIF
RETURN .T.
 
FUNCTION CARREG01
*
* -> Carrega variaveis para entrada ou altercao de dados
PARA R_CAR
**
** Bloco de inser‡„o I01.B14
**
PUBLIC NOME,DOCUMENTO,QUANT_SCOS,SELECAO
IF M->R_CAR=1
   M->NOME=SPACE( 30)
   M->DOCUMENTO=SPACE( 10)
   M->QUANT_SCOS=0
   M->SELECAO=SPACE(  1)
**
** Bloco de inser‡„o I01.B15
**
M->DIGITADOR=M->OPERADOR
ELSE
   M->NOME=NOME
   M->DOCUMENTO=DOCUMENTO
   M->QUANT_SCOS=QUANT_SCOS
   M->SELECAO=SELECAO
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
JANELA( 7,14,14,64,"Inadiplentes")
COR("CERCADURAS")
*
* -> Monta cercaduras
@  8,15 TO 13,63
**
** Bloco de inser‡„o I01.B18
**
COR("GETS")
**
** Bloco de inser‡„o I01.B21
**
IF M->X_VERI
   IFU01004()
ENDIF
*
* -> Monta tela de cadastro
@  9,17 SAY "Nome        :" GET M->NOME PICTURE "@!" VALID IFU01001()
@ 10,17 SAY "Documento n§:" GET M->DOCUMENTO PICTURE "@!" VALID IFU01002() .AND.  VERI001(M->R_CAR)
@ 11,17 SAY "Quant. Sacos:" GET M->QUANT_SCOS PICTURE "@Z 999.9" VALID IFU01003()
@ 12,17 SAY "Selecao     :" GET M->SELECAO PICTURE "@!" VALID IFU01004()
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
   IF LASTKEY()=27
      RETURN .F.
   ENDIF
ENDIF
RETURN .T.
 
FUNCTION SALVAR01
*
* -> Salva o conteudo das variaveis de entrada no arquivo
**
** Bloco de inser‡„o I01.B27
**
REPLACE NOME WITH M->NOME
REPLACE DOCUMENTO WITH M->DOCUMENTO
REPLACE QUANT_SCOS WITH M->QUANT_SCOS
REPLACE SELECAO WITH M->SELECAO
**
** Bloco de inser‡„o I01.B28
**
 
* Final do programa DEVEDI01.PRG