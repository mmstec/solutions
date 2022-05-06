
* TITULO     : MFB - CONTROLE DE VENDAS
* DATA       : 12/05/97
* PROGRAMA   : MFBI03.PRG
* COMENTARIO : INCLUSAO (   2.Quita‡„o de Cimento)
 
**
** Bloco de inser‡„o I03.B01
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
** Bloco de inser‡„o I03.B02
**
***
*** Inicio do bloco de substitui‡„o I03.B
COR("MENU")
@ LIN_MENU,00
@ LIN_MENU,01 SAY "Inclus„o ³    2.Quita‡„o de Cimento"
M->P_VERI = .T.
M->X_VERI = .F.
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
      *
      * -> Inicializa variaveis
      CARREG03(1)
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
 
FUNCTION IFU03001
*
* -> Validacao para o campo CLIENTE
IF .NOT.(.NOT.EMPTY(M->CLIENTE)) .AND. LASTKEY()<>5
   BEEP()
   MENSAGEM("Cliente nescessario",3)
   MENSAGEM("Tecle <ESC> para retornar")
   RETURN .F.
ENDIF
RETURN .T.
 
FUNCTION IFU03002
*
* -> Validacao para o campo DOCUMENT
IF .NOT.(.NOT.EMPTY(M->DOCUMENT)) .AND. LASTKEY()<>5
   BEEP()
   MENSAGEM("Informe o N§ do Documento",3)
   MENSAGEM("Tecle <ESC> para retornar")
   RETURN .F.
ENDIF
RETURN .T.
 
FUNCTION IFU03003
*
* -> Validacao para o campo RS_FIXO
IF .NOT.(.NOT.EMPTY(M->RS_FIXO)) .AND. LASTKEY()<>5
   BEEP()
   MENSAGEM("Valor Fixo Nescessario",3)
   MENSAGEM("Tecle <ESC> para retornar")
   RETURN .F.
ENDIF
RETURN .T.
 
FUNCTION IFU03007
*
* -> Validacao para o campo VENCIMENTO
IF .NOT.(M->VENCIMENTO>=M->VENDA) .AND. LASTKEY()<>5
   BEEP()
   MENSAGEM("Vencimento tem de ser maior ou igual a data da venda",3)
   MENSAGEM("Tecle <ESC> para retornar")
   RETURN .F.
ENDIF
*
* -> Funcao que faz subtracao de datas
IF M->VENCIMENTO=CTOD("  /  /  ") .OR. M->VENDA=CTOD("  /  /  ")
   SETCOLOR(CONTECOR[8])
   @ 16,45 SAY 0 PICT "@E 999 DIAS DE PRAZO"
   COR("GETS")
   RETURN .T.
ENDIF
SETCOLOR(CONTECOR[8])
@ 16,45 SAY M->VENCIMENTO-M->VENDA PICT "@E 999 DIAS DE PRAZO"
COR("GETS")
RETURN .T.
 
FUNCTION IFU03008
*
* -> Funcao que faz subtracao de datas
IF M->PAGAMENTO=CTOD("  /  /  ") .OR. M->VENCIMENTO=CTOD("  /  /  ")
   SETCOLOR(CONTECOR[8])
   @ 19,44 SAY 0 PICT "@E 999 DIAS ATRAZADOS"
   COR("GETS")
   RETURN .T.
ENDIF
SETCOLOR(CONTECOR[8])
@ 19,44 SAY M->PAGAMENTO-M->VENCIMENTO PICT "@E 999 DIAS ATRAZADOS"
SETCOLOR(CONTECOR[8])
@ 17,45 SAY M->PAGAMENTO-M->VENCIMENTO PICT "@E 999 DIAS ATRAZO"
COR("GETS")
RETURN .T.
 
FUNCTION PSQ03001
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
 
FUNCTION CARREG03
*
* -> Carrega variaveis para entrada ou altercao de dados
PARA R_CAR
**
** Bloco de inser‡„o I03.B14
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
   M->ESTADO="2"
**
** Bloco de inser‡„o I03.B15
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
JANELA( 4,11,21,64,"   2.Quita‡„o de Cimento")
COR("CERCADURAS")
*
* -> Monta cercaduras
@  5,12 TO 20,63
**
** Bloco de inser‡„o I03.B18
**
COR("GETS")
*
* -> Carrega caracteres avulsos
@  9,14 SAY "NOME DO COMPRADOR"
@  6,14 SAY "NUMERO DOC"
@ 12,14 SAY "R$  Unitario"
@ 12,30 SAY "QDE  SACOS"
@ 12,45 SAY "VALOR   PAGO"
@ 15,14 SAY "DTA VEND"
@ 15,24 SAY "DTA VENC"
@ 15,34 SAY "DTA PAG."
@ 18,14 SAY "OBSERVACOES"
**
** Bloco de inser‡„o I03.B21
**
IF M->X_VERI
   PSQ03001()
   IFU03008()
   IFU03007()
ENDIF
*
* -> Monta tela de cadastro
@  7,14 GET M->DOCUMENT PICTURE "@!" VALID IFU03002() .AND.  VERI003(M->R_CAR)
@ 10,14 GET M->CLIENTE PICTURE "@!" VALID IFU03001()
@ 13,14 GET M->RS_FIXO PICTURE "@E 9,999,999.99" VALID PSQ03001() .AND.  IFU03003()
@ 13,30 GET M->QUANT_SACO PICTURE "@E 9999999.99"
@ 13,45 GET M->TOTAL PICTURE "@E 9,999,999.99"
@ 16,14 GET M->VENDA
@ 16,24 GET M->VENCIMENTO VALID IFU03007()
@ 16,34 GET M->PAGAMENTO VALID IFU03008()
@ 19,14 GET M->OBSERVACAO
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
** Bloco de inser‡„o I03.B28
**
 
* Final do programa MFBI03.PRG