
* TITULO     : MFB - CONTROLE DE VENDAS
* DATA       : 12/05/97
* PROGRAMA   : MFBI07.PRG
* COMENTARIO : INCLUSAO (   2. PFP entregues)
 
**
** Bloco de inser‡„o I07.B01
**
MENSAGEM("Aguarde abertura de arquivos")
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
** Bloco de inser‡„o I07.B02
**
***
*** Inicio do bloco de substitui‡„o I07.B
COR("MENU")
@ LIN_MENU,00
@ LIN_MENU,01 SAY "Inclus„o ³    2. PFP entregues"
M->P_VERI = .T.
M->X_VERI = .F.
M->IN_CLUI=.T.
DO WHILE .T.
   **
   ** Bloco de inser‡„o I07.B03
   **
   MENSAGEM("Tecle <ESC> para retornar")
   IF M->P_VERI
      **
      ** Bloco de inser‡„o I07.B04
      **
      *
      * -> Inicializa variaveis
      CARREG07(1)
   ELSE
      M->X_VERI = .T.
      **
      ** Bloco de inser‡„o I07.B05
      **
   ENDIF
   *
   * -> Carrega tela de cadastro
   IF CARGET07(IIF(M->AL_TERA,2,1))=.F.
      IF M->AL_TERA
         **
         ** Bloco de inser‡„o I07.B06
         **
         CARREG07(2)
         M->X_VERI = .T.
         CARGET07(5)
         BEEP()
         IF PERG("Registro j  cadastrado. Deseja alterar ?")="S"
            **
            ** Bloco de inser‡„o I07.B07
            **
            M->IN_CLUI=.F.
            M->P_VERI=.F.
         ELSE
            **
            ** Bloco de inser‡„o I07.B08
            **
            M->AL_TERA=.F.
         ENDIF
         LOOP
      ENDIF
      **
      ** Bloco de inser‡„o I07.B09
      **
      EXIT
   ENDIF
   **
   ** Bloco de inser‡„o I07.B10
   **
   IF PERG("Confirma as informa‡”es ?")="N"
      *
      * -> Faz reedicao
      M->P_VERI = .F.
      **
      ** Bloco de inser‡„o I07.B11
      **
      LOOP
   ENDIF
   M->P_VERI = .T.
   M->X_VERI = .F.
   **
   ** Bloco de inser‡„o I07.B12
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
   SALVAR07()
   COMMIT
   UNLOCK
   IF .NOT. M->IN_CLUI
      M->IN_CLUI=.T.
   ENDIF
ENDDO
RESTSCREEN(LIN_MENU+1,00,23,79,TELA_PRI)
**
** Bloco de inser‡„o I07.B13
**
*** Final do bloco de substitui‡„o I07.B
***
 
FUNCTION VERI007
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
 
FUNCTION CARREG07
*
* -> Carrega variaveis para entrada ou altercao de dados
PARA R_CAR
**
** Bloco de inser‡„o I07.B14
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
** Bloco de inser‡„o I07.B15
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
   ** Bloco de inser‡„o I07.B16
   **
ENDIF
 
FUNCTION CARGET07
*
* -> Formata a tela para entrada ou alteracao de dados
PARA R_CAR
IF R_CAR<>5
   M->AL_TERA=.F.
ENDIF
**
** Bloco de inser‡„o I07.B17
**
JANELA( 6,10,18,66,"   2. PFP entregues")
COR("CERCADURAS")
*
* -> Monta cercaduras
@  7,12 TO 17,64
**
** Bloco de inser‡„o I07.B18
**
COR("GETS")
**
** Bloco de inser‡„o I07.B21
**
*
* -> Monta tela de cadastro
@  8,15 SAY "Documento      :" GET M->DOCUMENT PICTURE "@!" VALID VERI007(M->R_CAR)
@  9,15 SAY "Cliente        :" GET M->CLIENTE PICTURE "@!"
@ 10,15 SAY "R$ Unitario    :" GET M->RS_UNITARI PICTURE "@E 9,999,999.99"
@ 11,15 SAY "Quantidade SC  :" GET M->QUANT_SACO PICTURE "@E 9999999.99"
@ 12,15 SAY "R$ Pago        :" GET M->TOTAL PICTURE "@E 9,999,999.99"
@ 13,15 SAY "Data venda     :" GET M->VENDA
@ 14,15 SAY "Data pagamento :" GET M->PAGAMENTO
@ 15,15 SAY "Data da ENTREGA:" GET M->ENTREGA
@ 16,15 SAY "Considera‡”es  :" GET M->OBSERVACAO
**
** Bloco de inser‡„o I07.B24
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
 
FUNCTION SALVAR07
*
* -> Salva o conteudo das variaveis de entrada no arquivo
**
** Bloco de inser‡„o I07.B27
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
** Bloco de inser‡„o I07.B28
**
 
* Final do programa MFBI07.PRG