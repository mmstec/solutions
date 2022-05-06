
* TITULO     : MFB - CONTROLE DE VENDAS
* DATA       : 12/05/97
* PROGRAMA   : MFBI02.PRG
* COMENTARIO : INCLUSAO (   1.Vendas de Cimento)
 
**
** Bloco de inser‡„o I02.B01
**
MENSAGEM("Aguarde abertura de arquivos")
SELE 1
IF .NOT. USEREDE("CIMENTO",.F.,10)
   BEEP()
   MENSAGEM("O arquivo CIMENTO n„o est  dispon¡vel",3)
   RETURN
ELSE
   SET INDEX TO CIMEN001,CIMEN002,CIMEN003
ENDIF
SELE 2
IF .NOT. USEREDE("MANUTENC",.F.,10)
   BEEP()
   MENSAGEM("O arquivo MANUTENC n„o est  dispon¡vel",3)
   RETURN
ELSE
   SET INDEX TO MANUT004,MANUT005
ENDIF
SELE 1
**
** Bloco de inser‡„o I02.B02
**
***
*** Inicio do bloco de substitui‡„o I02.B
COR("MENU")
@ LIN_MENU,00
@ LIN_MENU,01 SAY "Inclus„o ³    1.Vendas de Cimento"
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
* -> Funcao que verifica duplicidade no arquivo "CIMENTO"
PARA R_PARA
M->I_REG=RECN()
M->ORDEM = INDEXORD()
SET ORDER TO 3
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
 
FUNCTION IFU02001
*
* -> Validacao para o campo CLIENTE
IF .NOT.(.NOT.EMPTY(M->CLIENTE)) .AND. LASTKEY()<>5
   BEEP()
   MENSAGEM("Informe o Cliente",3)
   MENSAGEM("Tecle <ESC> para retornar")
   RETURN .F.
ENDIF
RETURN .T.
 
FUNCTION IFU02002
*
* -> Validacao para o campo DOCUMENT
IF .NOT.(.NOT.EMPTY(M->DOCUMENT)) .AND. LASTKEY()<>5
   BEEP()
   MENSAGEM("Informe o N§ do Documento",3)
   MENSAGEM("Tecle <ESC> para retornar")
   RETURN .F.
ENDIF
RETURN .T.
 
FUNCTION IFU02003
*
* -> Validacao para o campo RS_FIXO
IF .NOT.(.NOT.EMPTY(M->RS_FIXO)) .AND. LASTKEY()<>5
   BEEP()
   MENSAGEM("Valor fixo nescessario",3)
   MENSAGEM("Tecle <ESC> para retornar")
   RETURN .F.
ENDIF
RETURN .T.
 
FUNCTION IFU02004
*
* -> Validacao para o campo QUANT_SACO
IF .NOT.(.NOT.EMPTY(M->QUANT_SACO)) .AND. LASTKEY()<>5
   BEEP()
   MENSAGEM("Informe a Quantidade de Sacos de Cimento",3)
   MENSAGEM("Tecle <ESC> para retornar")
   RETURN .F.
ENDIF
*
* -> Funcao que faz calculo com campos numericos
M->TOTAL = M->QUANT_SACO*M->RS_FIXO
COR("GETS")
RETURN .T.
 
FUNCTION IFU02006
*
* -> Validacao para o campo VENDA
IF .NOT.(.NOT.EMPTY(M->VENDA)) .AND. LASTKEY()<>5
   BEEP()
   MENSAGEM("Informe a data da Venda de cimento",3)
   MENSAGEM("Tecle <ESC> para retornar")
   RETURN .F.
ENDIF
RETURN .T.
 
FUNCTION IFU02007
*
* -> Validacao para o campo VENCIMENTO
IF .NOT.(.NOT.EMPTY(M->VENCIMENTO)) .AND. LASTKEY()<>5
   BEEP()
   MENSAGEM("Informe a data do vencimento",3)
   MENSAGEM("Tecle <ESC> para retornar")
   RETURN .F.
ENDIF
*
* -> Validacao para o campo VENCIMENTO
IF .NOT.(M->VENCIMENTO>=M->VENDA) .AND. LASTKEY()<>5
   BEEP()
   MENSAGEM("Vencimento tem de ser Maior ou Igual a Venda",3)
   MENSAGEM("Tecle <ESC> para retornar")
   RETURN .F.
ENDIF
*
* -> Funcao que faz subtracao de datas
IF M->VENCIMENTO=CTOD("  /  /  ") .OR. M->VENDA=CTOD("  /  /  ")
   SETCOLOR(CONTECOR[8])
   @ 19,40 SAY 0 PICT "@E 999 DIAS PRAZO"
   COR("GETS")
   RETURN .T.
ENDIF
SETCOLOR(CONTECOR[8])
@ 19,40 SAY M->VENCIMENTO-M->VENDA PICT "@E 999 DIAS PRAZO"
COR("GETS")
RETURN .T.
 
FUNCTION PSQ02001
*
* -> Funcao que faz pesquisas em outro banco de dados
SELE 2
SET ORDER TO 2
SEEK STR(M->RS_FIXO,10,2)
M->RETOR_NO=.T.
IF (EOF() .AND. LASTKEY()<>5) .OR. M->TEC_F2
   M->GET_CAM=READVAR()
   IF LEN(M->GET_CAM)<>0
      EDIT_ARQ(EMPTY(M->RS_FIXO))
      IF LASTKEY()=13
         M->RS_FIXO = RS_FIXO
      ENDIF
   ENDIF
ELSE
   M->RS_FIXO = RS_FIXO
ENDIF
SELE 1
RETURN M->RETOR_NO
 
FUNCTION CARREG02
*
* -> Carrega variaveis para entrada ou altercao de dados
PARA R_CAR
**
** Bloco de inser‡„o I02.B14
**
PUBLIC CLIENTE,DOCUMENT,RS_FIXO,QUANT_SACO,TOTAL,VENDA,VENCIMENTO,PAGAMENTO,OBSERVACAO
IF M->R_CAR=1
   M->CLIENTE=SPACE( 30)
   M->DOCUMENT=SPACE( 10)
   M->RS_FIXO=0
   M->QUANT_SACO=0
   M->TOTAL=0
   M->VENDA=CTOD("  /  /  ")
   M->VENCIMENTO=CTOD("  /  /  ")
   M->PAGAMENTO=CTOD("  /  /  ")
   M->OBSERVACAO=SPACE( 30)
   *
   * -> Deficao de valores constantes
   M->ESTADO="1"
**
** Bloco de inser‡„o I02.B15
**
M->DIGITADOR=M->OPERADOR
ELSE
   M->CLIENTE=CLIENTE
   M->DOCUMENT=DOCUMENT
   M->RS_FIXO=RS_FIXO
   M->QUANT_SACO=QUANT_SACO
   M->TOTAL=TOTAL
   M->VENDA=VENDA
   M->VENCIMENTO=VENCIMENTO
   M->PAGAMENTO=PAGAMENTO
   M->OBSERVACAO=OBSERVACAO
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
JANELA( 4,17,21,56,"   1.Vendas de Cimento")
COR("CERCADURAS")
*
* -> Monta cercaduras
@  5,18 TO 20,55
**
** Bloco de inser‡„o I02.B18
**
COR("GETS")
*
* -> Carrega caracteres avulsos
@ 13,33 SAY ""
@  6,20 SAY "NOME DO COMPRADOR"
@ 12,20 SAY "R$  UNITARIO"
@ 18,20 SAY "DTA VEND"
@ 18,30 SAY "DTA VENC"
@ 15,20 SAY "QDE  SACOS"
@ 15,32 SAY "VALOR  TOTAL"
@  9,20 SAY "NUMERO DOC"
**
** Bloco de inser‡„o I02.B21
**
IF M->X_VERI
   PSQ02001()
   IFU02004()
   IFU02007()
ENDIF
*
* -> Monta tela de cadastro
@  7,20 GET M->CLIENTE PICTURE "@!" VALID IFU02001()
@ 10,20 GET M->DOCUMENT PICTURE "@!" VALID IFU02002() .AND.  VERI002(M->R_CAR)
@ 13,20 GET M->RS_FIXO PICTURE "@E 9,999,999.99" VALID PSQ02001() .AND.  IFU02003()
@ 16,20 GET M->QUANT_SACO PICTURE "@E 9999999.99" VALID IFU02004()
@ 16,32 GET M->TOTAL PICTURE "@E 9,999,999.99"
@ 19,20 GET M->VENDA VALID IFU02006()
@ 19,30 GET M->VENCIMENTO VALID IFU02007()
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

REPLACE CLIENTE WITH M->CLIENTE
REPLACE DOCUMENT WITH M->DOCUMENT
REPLACE RS_FIXO WITH M->RS_FIXO
REPLACE QUANT_SACO WITH M->QUANT_SACO
REPLACE TOTAL WITH M->TOTAL
REPLACE VENDA WITH M->VENDA
REPLACE VENCIMENTO WITH M->VENCIMENTO
REPLACE PAGAMENTO WITH M->PAGAMENTO
REPLACE OBSERVACAO WITH M->OBSERVACAO
**
** Bloco de inser‡„o I02.B28
**
 
* Final do programa MFBI02.PRG
