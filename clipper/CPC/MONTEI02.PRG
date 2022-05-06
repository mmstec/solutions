
* TITULO     : MFB - Duplicatas e Estoque do Cimento
* DATA       : 25/04/97
* PROGRAMA   : MONTEI02.PRG
* COMENTARIO : INCLUSAO ( DUPLICATAS ¥ PAGAS)
 
**
** Bloco de inser‡„o I02.B01
**
MENSAGEM("Aguarde abertura de arquivos")
SELE 2
IF .NOT. USEREDE("DOCUMENT",.F.,10)
   BEEP()
   MENSAGEM("O arquivo DOCUMENT n„o est  dispon¡vel",3)
   RETURN
ELSE
   SET INDEX TO DOCUM002,DOCUM003,DOCUM004,DOCUM005
ENDIF
SELE 2
**
** Bloco de inser‡„o I02.B02
**
***
*** Inicio do bloco de substitui‡„o I02.B
COR("MENU")
@ LIN_MENU,00
@ LIN_MENU,01 SAY "Inclus„o ³  DUPLICATAS ¥ PAGAS"
M->P_VERI = .T.
M->X_VERI = .F.
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
      *
      * -> Inicializa variaveis
      CARREG02(1)
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
* -> Funcao que verifica duplicidade no arquivo "DOCUMENT"
PARA R_PARA
M->I_REG=RECN()
M->ORDEM = INDEXORD()
SET ORDER TO 4
SEEK M->NDOCUMENTO
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
* -> Validacao para o campo NDOCUMENTO
IF .NOT.(.NOT.EMPTY(M->NDOCUMENTO)) .AND. LASTKEY()<>5
   BEEP()
   MENSAGEM("Nescessario informar N§ do documento",3)
   MENSAGEM("Tecle <ESC> para retornar")
   RETURN .F.
ENDIF
RETURN .T.
 
FUNCTION IFU02002
*
* -> Validacao para o campo VALOR
IF .NOT.(.NOT.EMPTY(M->VALOR)) .AND. LASTKEY()<>5
   BEEP()
   MENSAGEM("Nescessario informar o valor a pagar",3)
   MENSAGEM("Tecle <ESC> para retornar")
   RETURN .F.
ENDIF
RETURN .T.
 
FUNCTION IFU02003
*
* -> Validacao para o campo VENCIMENTO
IF .NOT.(.NOT.EMPTY(M->VENCIMENTO)) .AND. LASTKEY()<>5
   BEEP()
   MENSAGEM("Nescessario informar o Vencimento",3)
   MENSAGEM("Tecle <ESC> para retornar")
   RETURN .F.
ENDIF
RETURN .T.
 
FUNCTION CARREG02
*
* -> Carrega variaveis para entrada ou altercao de dados
PARA R_CAR
**
** Bloco de inser‡„o I02.B14
**
PUBLIC NDOCUMENTO,VALOR,VENCIMENTO,PAGAMENTO,HISTORICO
IF M->R_CAR=1
   M->NDOCUMENTO=SPACE( 15)
   M->VALOR=0
   M->VENCIMENTO=CTOD("  /  /  ")
   M->PAGAMENTO=CTOD("  /  /  ")
   M->HISTORICO="Adelson / Marcos => "+SPACE(10)
**
** Bloco de inser‡„o I02.B15
**
M->DIGITADOR=M->OPERADOR
ELSE
   M->NDOCUMENTO=NDOCUMENTO
   M->VALOR=VALOR
   M->VENCIMENTO=VENCIMENTO
   M->PAGAMENTO=PAGAMENTO
   M->HISTORICO=SPACE( 30)
ELSE   
   M->NDOCUMENTO=NDOCUMENTO
   M->VALOR=VALOR
   M->VENCIMENTO=VENCIMENTO
   M->PAGAMENTO=PAGAMENTO
   M->HISTORICO=HISTORICO
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
JANELA( 5,17,19,56," DUPLICATAS ¥ PAGAS")
COR("CERCADURAS")
*
* -> Monta cercaduras
@  6,18 TO  9,55
@  6,18 TO 18,55
**
** Bloco de inser‡„o I02.B18
**
COR("GETS")
*
* -> Carrega caracteres avulsos
@  8,20 SAY "Cia Materiais Sulfurosos Matsulfurs"
@  7,20 SAY "Cedente"
@ 10,20 SAY "No. Duplicata"
@ 13,20 SAY "Valor"
@ 13,35 SAY "Venciment"
@ 16,20 SAY "Historico"
**
** Bloco de inser‡„o I02.B21
**
*
* -> Monta tela de cadastro
@ 11,20 GET M->NDOCUMENTO PICTURE "@!" VALID IFU02001() .AND.  VERI002(M->R_CAR)
@ 14,20 GET M->VALOR PICTURE "@E 9,999,999.99" VALID IFU02002()
@ 14,35 GET M->VENCIMENTO VALID IFU02003()
@ 17,20 GET M->HISTORICO PICTURE "@!"
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
REPLACE NDOCUMENTO WITH M->NDOCUMENTO
REPLACE VALOR WITH M->VALOR
REPLACE VENCIMENTO WITH M->VENCIMENTO
REPLACE PAGAMENTO WITH M->PAGAMENTO
REPLACE HISTORICO WITH M->HISTORICO
**
** Bloco de inser‡„o I02.B28
**
 
* Final do programa MONTEI02.PRG
