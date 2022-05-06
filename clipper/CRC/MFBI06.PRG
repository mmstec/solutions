
* TITULO     : MFB - CONTROLE DE VENDAS
* DATA       : 12/05/97
* PROGRAMA   : MFBI06.PRG
* COMENTARIO : INCLUSAO (   1. PFP a entregar)
 
**
** Bloco de inser‡„o I06.B01
**
MENSAGEM("Aguarde abertura de arquivos")
SELE 2
IF .NOT. USEREDE("MANUTENC",.F.,10)
   BEEP()
   MENSAGEM("O arquivo MANUTENC n„o est  dispon¡vel",3)
   RETURN
ELSE
   SET INDEX TO MANUT004,MANUT005
ENDIF
SELE 3
IF .NOT. USEREDE("PAGOFP",.F.,10)
   BEEP()
   MENSAGEM("O arquivo PAGOFP n„o est  dispon¡vel",3)
   RETURN
ELSE
   SET INDEX TO PAGOF006,PAGOF007,PAGOF008
ENDIF
SELE 3
**
** Bloco de inser‡„o I06.B02
**
***
*** Inicio do bloco de substitui‡„o I06.B
COR("MENU")
@ LIN_MENU,00
@ LIN_MENU,01 SAY "Inclus„o ³    1. PFP a entregar"
M->P_VERI = .T.
M->X_VERI = .F.
M->IN_CLUI=.T.
DO WHILE .T.
   **
   ** Bloco de inser‡„o I06.B03
   **
   MENSAGEM("Tecle <ESC> para retornar")
   IF M->P_VERI
      **
      ** Bloco de inser‡„o I06.B04
      **
      *
      * -> Inicializa variaveis
      CARREG06(1)
   ELSE
      M->X_VERI = .T.
      **
      ** Bloco de inser‡„o I06.B05
      **
   ENDIF
   *
   * -> Carrega tela de cadastro
   IF CARGET06(IIF(M->AL_TERA,2,1))=.F.
      IF M->AL_TERA
         **
         ** Bloco de inser‡„o I06.B06
         **
         CARREG06(2)
         M->X_VERI = .T.
         CARGET06(5)
         BEEP()
         IF PERG("Registro j  cadastrado. Deseja alterar ?")="S"
            **
            ** Bloco de inser‡„o I06.B07
            **
            M->IN_CLUI=.F.
            M->P_VERI=.F.
         ELSE
            **
            ** Bloco de inser‡„o I06.B08
            **
            M->AL_TERA=.F.
         ENDIF
         LOOP
      ENDIF
      **
      ** Bloco de inser‡„o I06.B09
      **
      EXIT
   ENDIF
   **
   ** Bloco de inser‡„o I06.B10
   **
   IF PERG("Confirma as informa‡”es ?")="N"
      *
      * -> Faz reedicao
      M->P_VERI = .F.
      **
      ** Bloco de inser‡„o I06.B11
      **
      LOOP
   ENDIF
   M->P_VERI = .T.
   M->X_VERI = .F.
   **
   ** Bloco de inser‡„o I06.B12
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
   SALVAR06()
   COMMIT
   UNLOCK
   IF .NOT. M->IN_CLUI
      M->IN_CLUI=.T.
   ENDIF
ENDDO
RESTSCREEN(LIN_MENU+1,00,23,79,TELA_PRI)
**
** Bloco de inser‡„o I06.B13
**
*** Final do bloco de substitui‡„o I06.B
***
 
FUNCTION VERI006
*
* -> Funcao que verifica duplicidade no arquivo "PAGOFP"
PARA R_PARA
M->I_REG=RECN()
M->ORDEM = INDEXORD()
SET ORDER TO 1
SEEK M->DOCUMENT
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
 
FUNCTION IFU06001
*
* -> Validacao para o campo CLIENTE
IF .NOT.(.NOT.EMPTY(M->CLIENTE)) .AND. LASTKEY()<>5
   BEEP()
   MENSAGEM("Nome do Cliente obrigatorio!",3)
   MENSAGEM("Tecle <ESC> para retornar")
   RETURN .F.
ENDIF
RETURN .T.
 
FUNCTION IFU06002
*
* -> Validacao para o campo DOCUMENT
IF .NOT.(.NOT.EMPTY(M->DOCUMENT)) .AND. LASTKEY()<>5
   BEEP()
   MENSAGEM("Numero do documento (NOTA) obrigatorio",3)
   MENSAGEM("Tecle <ESC> para retornar")
   RETURN .F.
ENDIF
RETURN .T.
 
FUNCTION IFU06004
*
* -> Validacao para o campo QUANT_SACO
IF .NOT.(.NOT.EMPTY(M->QUANT_SACO)) .AND. LASTKEY()<>5
   BEEP()
   MENSAGEM("Quantidades de sacos vendidos: obrigatorio",3)
   MENSAGEM("Tecle <ESC> para retornar")
   RETURN .F.
ENDIF
*
* -> Funcao que faz calculo com campos numericos
M->TOTAL = M->QUANT_SACO*M->RS_UNITARI
COR("GETS")
RETURN .T.
 
FUNCTION IFU06006
*
* -> Validacao para o campo VENDA
IF .NOT.(.NOT.EMPTY(M->VENDA)) .AND. LASTKEY()<>5
   BEEP()
   MENSAGEM("Data de venda Û Obrigatoria!",3)
   MENSAGEM("Tecle <ESC> para retornar")
   RETURN .F.
ENDIF
RETURN .T.
 
FUNCTION IFU06007
*
* -> Validacao para o campo PAGAMENTO
IF .NOT.(.NOT.EMPTY(M->PAGAMENTO) .AND. M->PAGAMENTO>=M->VENDA) .AND. LASTKEY()<>5
   BEEP()
   MENSAGEM("Data de Pagamento Û Deve ser maior ou igual a Data de venda!",3)
   MENSAGEM("Tecle <ESC> para retornar")
   RETURN .F.
ENDIF
RETURN .T.
 
FUNCTION PSQ06001
*
* -> Funcao que faz pesquisas em outro banco de dados
SELE 2
SET ORDER TO 2
SEEK STR(M->RS_UNITARI,10,2)
M->RETOR_NO=.T.
IF (EOF() .AND. LASTKEY()<>5) .OR. M->TEC_F2
   M->GET_CAM=READVAR()
   IF LEN(M->GET_CAM)<>0
      EDIT_ARQ(EMPTY(M->RS_UNITARI))
      IF LASTKEY()=13
         M->RS_UNITARI = RS_FIXO
      ENDIF
   ENDIF
ELSE
   M->RS_UNITARI = RS_FIXO
ENDIF
SELE 3
RETURN M->RETOR_NO
 
FUNCTION CARREG06
*
* -> Carrega variaveis para entrada ou altercao de dados
PARA R_CAR
**
** Bloco de inser‡„o I06.B14
**
PUBLIC CLIENTE,DOCUMENT,RS_UNITARI,QUANT_SACO,TOTAL,VENDA,PAGAMENTO,ENTREGA,OBSERVACAO
IF M->R_CAR=1
   M->CLIENTE=SPACE( 30)
   M->DOCUMENT=SPACE( 10)
   M->RS_UNITARI=0
   M->QUANT_SACO=0
   M->TOTAL=0
   M->VENDA=CTOD("  /  /  ")
   M->PAGAMENTO=CTOD("  /  /  ")
   M->ENTREGA=CTOD("  /  /  ")
   M->OBSERVACAO=SPACE( 30)
**
** Bloco de inser‡„o I06.B15
**
M->DIGITADOR=M->OPERADOR
ELSE
   M->CLIENTE=CLIENTE
   M->DOCUMENT=DOCUMENT
   M->RS_UNITARI=RS_UNITARI
   M->QUANT_SACO=QUANT_SACO
   M->TOTAL=TOTAL
   M->VENDA=VENDA
   M->PAGAMENTO=PAGAMENTO
   M->ENTREGA=ENTREGA
   M->OBSERVACAO=OBSERVACAO
   **
   ** Bloco de inser‡„o I06.B16
   **
ENDIF
 
FUNCTION CARGET06
*
* -> Formata a tela para entrada ou alteracao de dados
PARA R_CAR
IF R_CAR<>5
   M->AL_TERA=.F.
ENDIF
**
** Bloco de inser‡„o I06.B17
**
JANELA( 7,12,17,65,"   1. PFP a entregar")
COR("CERCADURAS")
*
* -> Monta cercaduras
@  8,14 TO 16,63
**
** Bloco de inser‡„o I06.B18
**
COR("GETS")
**
** Bloco de inser‡„o I06.B21
**
IF M->X_VERI
   PSQ06001()
   IFU06004()
ENDIF
*
* -> Monta tela de cadastro
@  9,16 SAY "Cliente       :" GET M->CLIENTE PICTURE "@!" VALID IFU06001()
@ 10,16 SAY "Documento     :" GET M->DOCUMENT PICTURE "@!" VALID IFU06002() .AND.  VERI006(M->R_CAR)
@ 11,16 SAY "R$ Unitario   :" GET M->RS_UNITARI PICTURE "@E 9,999,999.99" VALID PSQ06001()
@ 12,16 SAY "Quant. Sacos  :" GET M->QUANT_SACO PICTURE "@E 9999999.99" VALID IFU06004()
@ 13,16 SAY "R$ a Pagar    :" GET M->TOTAL PICTURE "@E 9,999,999.99"
@ 14,16 SAY "Dta Venda     :" GET M->VENDA VALID IFU06006()
@ 15,16 SAY "Dta Pagamento :" GET M->PAGAMENTO VALID IFU06007()
**
** Bloco de inser‡„o I06.B24
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
 
FUNCTION SALVAR06
*
* -> Salva o conteudo das variaveis de entrada no arquivo
**
** Bloco de inser‡„o I06.B27
**
REPLACE CLIENTE WITH M->CLIENTE
REPLACE DOCUMENT WITH M->DOCUMENT
REPLACE RS_UNITARI WITH M->RS_UNITARI
REPLACE QUANT_SACO WITH M->QUANT_SACO
REPLACE TOTAL WITH M->TOTAL
REPLACE VENDA WITH M->VENDA
REPLACE PAGAMENTO WITH M->PAGAMENTO
REPLACE ENTREGA WITH M->ENTREGA
REPLACE OBSERVACAO WITH M->OBSERVACAO
**
** Bloco de inser‡„o I06.B28
**
 
* Final do programa MFBI06.PRG