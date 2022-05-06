
* TITULO     :  Recupera‡„o de Inadiplencia
* DATA       : 28/02/97
* PROGRAMA   : NAOPGI02.PRG
* COMENTARIO : INCLUSAO (2.Pagamentos)
 
**
** Bloco de inser‡„o I02.B01
**
MENSAGEM("Aguarde abertura de arquivos")
SELE 1
IF .NOT. USEREDE("VEND_NPG",.F.,10)
   BEEP()
   MENSAGEM("O arquivo VEND_NPG n„o est  dispon¡vel",3)
   RETURN
ELSE
   SET INDEX TO VEND_001,VEND_002,VEND_003
ENDIF
SELE 1
**
** Bloco de inser‡„o I02.B02
**
***
*** Inicio do bloco de substitui‡„o I02.B
COR("MENU")
@ LIN_MENU,00
@ LIN_MENU,01 SAY "Inclus„o ³ 2.Pagamentos"
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
* -> Funcao que verifica duplicidade no arquivo "VEND_NPG"
PARA R_PARA
M->I_REG=RECN()
M->ORDEM = INDEXORD()
SET ORDER TO 1
SEEK M->CLIENTE
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
 
FUNCTION CARREG02
*
* -> Carrega variaveis para entrada ou altercao de dados
PARA R_CAR
**
** Bloco de inser‡„o I02.B14
**
PUBLIC VENDEDOR,DOCUMENTO,CLIENTE,VALORSJURO,VALORCJURO,CIMENTO,PAGO_NAOPG,OBSERVACAO
IF M->R_CAR=1
   M->VENDEDOR=SPACE(  1)
   M->DOCUMENTO=SPACE( 10)
   M->CLIENTE=SPACE( 30)
   M->VALORSJURO=0
   M->VALORCJURO=0
   M->CIMENTO=0
   M->PAGO_NAOPG=CTOD("  /  /  ")
   M->OBSERVACAO=SPACE( 30)
   **
   ** Bloco de inser‡„o I02.B15
   **
ELSE
   M->VENDEDOR=VENDEDOR
   M->DOCUMENTO=DOCUMENTO
   M->CLIENTE=CLIENTE
   M->VALORSJURO=VALORSJURO
   M->VALORCJURO=VALORCJURO
   M->CIMENTO=CIMENTO
   M->PAGO_NAOPG=PAGO_NAOPG
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
JANELA( 7, 9,17,73,"2.Pagamentos")
**
** Bloco de inser‡„o I02.B18
**
COR("GETS")
**
** Bloco de inser‡„o I02.B21
**
*
* -> Monta tela de cadastro
@  9,12 SAY "Vendendor   :" GET M->VENDEDOR PICTURE "@!"
@ 10,12 SAY "Documento   :" GET M->DOCUMENTO PICTURE "@!"
@ 11,12 SAY "Cliente     :" GET M->CLIENTE PICTURE "@!" VALID VERI002(M->R_CAR)
@ 12,12 SAY "R$ S/juros  :" GET M->VALORSJURO PICTURE "@E 9,999,999.99"
@ 13,12 SAY "R$ C/ Juros :" GET M->VALORCJURO PICTURE "@E 9,999,999.99"
@ 14,12 SAY "R$ Cimento  :" GET M->CIMENTO PICTURE "@E 9,999,999.99"
@ 15,12 SAY "Pagamento   :" GET M->PAGO_NAOPG PICTURE "@!"
@ 16,12 SAY "Observa‡„o  :" GET M->OBSERVACAO
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
REPLACE VENDEDOR WITH M->VENDEDOR
REPLACE DOCUMENTO WITH M->DOCUMENTO
REPLACE CLIENTE WITH M->CLIENTE
REPLACE VALORSJURO WITH M->VALORSJURO
REPLACE VALORCJURO WITH M->VALORCJURO
REPLACE CIMENTO WITH M->CIMENTO
REPLACE PAGO_NAOPG WITH M->PAGO_NAOPG
REPLACE OBSERVACAO WITH M->OBSERVACAO
**
** Bloco de inser‡„o I02.B28
**
 
* Final do programa NAOPGI02.PRG