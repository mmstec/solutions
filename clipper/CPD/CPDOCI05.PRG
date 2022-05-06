
* TITULO     :  Sistema de Contas a Pagar
* DATA       : 25/04/97
* PROGRAMA   : CPDOCI05.PRG
* COMENTARIO : INCLUSAO ( 1.Duplicatas pagas)
 
**
** Bloco de inser‡„o I05.B01
**
MENSAGEM("Aguarde abertura de arquivos")
SELE 1
IF .NOT. USEREDE("CPDOC",.F.,10)
   BEEP()
   MENSAGEM("O arquivo CPDOC n„o est  dispon¡vel",3)
   RETURN
ELSE
   SET INDEX TO CPDOC001,CPDOC002,CPDOC003
ENDIF
SELE 1
**
** Bloco de inser‡„o I05.B02
**
***
*** Inicio do bloco de substitui‡„o I05.B
COR("MENU")
@ LIN_MENU,00
@ LIN_MENU,01 SAY "Inclus„o ³  1.Duplicatas pagas"
M->P_VERI = .T.
M->X_VERI = .F.
M->IN_CLUI=.T.
DO WHILE .T.
   **
   ** Bloco de inser‡„o I05.B03
   **
   MENSAGEM("Tecle <ESC> para retornar")
   IF M->P_VERI
      **
      ** Bloco de inser‡„o I05.B04
      **
      *
      * -> Inicializa variaveis
      CARREG05(1)
   ELSE
      M->X_VERI = .T.
      **
      ** Bloco de inser‡„o I05.B05
      **
   ENDIF
   *
   * -> Carrega tela de cadastro
   IF CARGET05(IIF(M->AL_TERA,2,1))=.F.
      IF M->AL_TERA
         **
         ** Bloco de inser‡„o I05.B06
         **
         CARREG05(2)
         M->X_VERI = .T.
         CARGET05(5)
         BEEP()
         IF PERG("Registro j  cadastrado. Deseja alterar ?")="S"
            **
            ** Bloco de inser‡„o I05.B07
            **
            M->IN_CLUI=.F.
            M->P_VERI=.F.
         ELSE
            **
            ** Bloco de inser‡„o I05.B08
            **
            M->AL_TERA=.F.
         ENDIF
         LOOP
      ENDIF
      **
      ** Bloco de inser‡„o I05.B09
      **
      EXIT
   ENDIF
   **
   ** Bloco de inser‡„o I05.B10
   **
   IF PERG("Confirma as informa‡”es ?")="N"
      *
      * -> Faz reedicao
      M->P_VERI = .F.
      **
      ** Bloco de inser‡„o I05.B11
      **
      LOOP
   ENDIF
   M->P_VERI = .T.
   M->X_VERI = .F.
   **
   ** Bloco de inser‡„o I05.B12
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
   SALVAR05()
   COMMIT
   UNLOCK
   IF .NOT. M->IN_CLUI
      M->IN_CLUI=.T.
   ENDIF
ENDDO
RESTSCREEN(LIN_MENU+1,00,23,79,TELA_PRI)
**
** Bloco de inser‡„o I05.B13
**
*** Final do bloco de substitui‡„o I05.B
***
 
FUNCTION VERI005
*
* -> Funcao que verifica duplicidade no arquivo "CPDOC"
PARA R_PARA
M->I_REG=RECN()
M->ORDEM = INDEXORD()
SET ORDER TO 3
SEEK M->NUMERO
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
 
FUNCTION IFU05001
*
* -> Validacao para o campo NUMERO
IF .NOT.(.NOT.EMPTY(M->NUMERO)) .AND. LASTKEY()<>5
   BEEP()
   MENSAGEM("Documento nescessario",3)
   MENSAGEM("Tecle <ESC> para retornar")
   RETURN .F.
ENDIF
RETURN .T.
 
FUNCTION CARREG05
*
* -> Carrega variaveis para entrada ou altercao de dados
PARA R_CAR
**
** Bloco de inser‡„o I05.B14
**
PUBLIC NUMERO,CEDENTE,VALOR,VENCIMENTO,PAGAMENTO,HISTORICO
IF M->R_CAR=1
   M->NUMERO=SPACE( 10)
   M->CEDENTE=SPACE( 30)
   M->VALOR=0
   M->VENCIMENTO=CTOD("  /  /  ")
   M->PAGAMENTO=CTOD("  /  /  ")
   M->HISTORICO=SPACE( 30)
**
** Bloco de inser‡„o I05.B15
**
M->DIGITADOR=M->OPERADOR
ELSE
   M->NUMERO=NUMERO
   M->CEDENTE=CEDENTE
   M->VALOR=VALOR
   M->VENCIMENTO=VENCIMENTO
   M->PAGAMENTO=PAGAMENTO
   M->HISTORICO=HISTORICO
   **
   ** Bloco de inser‡„o I05.B16
   **
ENDIF
 
FUNCTION CARGET05
*
* -> Formata a tela para entrada ou alteracao de dados
PARA R_CAR
IF R_CAR<>5
   M->AL_TERA=.F.
ENDIF
**
** Bloco de inser‡„o I05.B17
**
JANELA( 5,12,14,64," 1.Duplicatas pagas")
COR("CERCADURAS")
*
* -> Monta cercaduras
@  6,13 TO 13,63
**
** Bloco de inser‡„o I05.B18
**
COR("GETS")
**
** Bloco de inser‡„o I05.B21
**
*
* -> Monta tela de cadastro
@  7,15 SAY "Numero     :" GET M->NUMERO PICTURE "@!" VALID IFU05001() .AND.  VERI005(M->R_CAR)
@  8,15 SAY "Cedente    :" GET M->CEDENTE PICTURE "@!"
@  9,15 SAY "Valor      :" GET M->VALOR PICTURE "@Z 9,999,999.99"
@ 10,15 SAY "Vencimento :" GET M->VENCIMENTO
@ 11,15 SAY "Pagamento  :" GET M->PAGAMENTO
@ 12,15 SAY "Histrorico :" GET M->HISTORICO PICTURE "@!"
**
** Bloco de inser‡„o I05.B24
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
 
FUNCTION SALVAR05
*
* -> Salva o conteudo das variaveis de entrada no arquivo
**
** Bloco de inser‡„o I05.B27
**
REPLACE NUMERO WITH M->NUMERO
REPLACE CEDENTE WITH M->CEDENTE
REPLACE VALOR WITH M->VALOR
REPLACE VENCIMENTO WITH M->VENCIMENTO
REPLACE PAGAMENTO WITH M->PAGAMENTO
REPLACE HISTORICO WITH M->HISTORICO
**
** Bloco de inser‡„o I05.B28
**
 
* Final do programa CPDOCI05.PRG