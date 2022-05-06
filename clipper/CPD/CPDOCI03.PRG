
* TITULO     :  Sistema de Contas a Pagar
* DATA       : 25/04/97
* PROGRAMA   : CPDOCI03.PRG
* COMENTARIO : INCLUSAO ( 2.Cheques a pagar)
 
**
** Bloco de inser‡„o I03.B01
**
MENSAGEM("Aguarde abertura de arquivos")
SELE 2
IF .NOT. USEREDE("CPCHK",.F.,10)
   BEEP()
   MENSAGEM("O arquivo CPCHK n„o est  dispon¡vel",3)
   RETURN
ELSE
   SET INDEX TO CPCHK004,CPCHK005,CPCHK006
ENDIF
SELE 2
**
** Bloco de inser‡„o I03.B02
**
***
*** Inicio do bloco de substitui‡„o I03.B
COR("MENU")
@ LIN_MENU,00
@ LIN_MENU,01 SAY "Inclus„o ³  2.Cheques a pagar"
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
* -> Funcao que verifica duplicidade no arquivo "CPCHK"
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
 
FUNCTION IFU03001
*
* -> Validacao para o campo NUMERO
IF .NOT.(.NOT.EMPTY(M->NUMERO)) .AND. LASTKEY()<>5
   BEEP()
   MENSAGEM("Nescessario informar o numero",3)
   MENSAGEM("Tecle <ESC> para retornar")
   RETURN .F.
ENDIF
RETURN .T.
 
FUNCTION IFU03002
*
* -> Validacao para o campo CEDENTE
IF .NOT.(.NOT.EMPTY(M->CEDENTE)) .AND. LASTKEY()<>5
   BEEP()
   MENSAGEM("Nescessario informar o cedente",3)
   MENSAGEM("Tecle <ESC> para retornar")
   RETURN .F.
ENDIF
RETURN .T.
 
FUNCTION IFU03003
*
* -> Validacao para o campo BANCO
IF .NOT.(.NOT.EMPTY(M->BANCO)) .AND. LASTKEY()<>5
   BEEP()
   MENSAGEM("Nescessario informar o banco",3)
   MENSAGEM("Tecle <ESC> para retornar")
   RETURN .F.
ENDIF
RETURN .T.
 
FUNCTION IFU03004
*
* -> Validacao para o campo CONTA
IF .NOT.(.NOT.EMPTY(M->CONTA)) .AND. LASTKEY()<>5
   BEEP()
   MENSAGEM("Nescessario informar a conta",3)
   MENSAGEM("Tecle <ESC> para retornar")
   RETURN .F.
ENDIF
RETURN .T.
 
FUNCTION IFU03005
*
* -> Validacao para o campo CIDADE
IF .NOT.(.NOT.EMPTY(M->CIDADE)) .AND. LASTKEY()<>5
   BEEP()
   MENSAGEM("Nescessario informar a cidade",3)
   MENSAGEM("Tecle <ESC> para retornar")
   RETURN .F.
ENDIF
RETURN .T.
 
FUNCTION IFU03007
*
* -> Validacao para o campo VENCIMENTO
IF .NOT.(.NOT.EMPTY(M->VENCIMENTO)) .AND. LASTKEY()<>5
   BEEP()
   MENSAGEM("Nescessario informar o vencimento",3)
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
PUBLIC NUMERO,CEDENTE,BANCO,CONTA,CIDADE,VALOR,VENCIMENTO,PAGAMENTO,HISTORICO
IF M->R_CAR=1
   M->NUMERO=SPACE( 10)
   M->CEDENTE=SPACE( 30)
   M->BANCO=SPACE( 15)
   M->CONTA=SPACE( 15)
   M->CIDADE=SPACE( 15)
   M->VALOR=0
   M->VENCIMENTO=CTOD("  /  /  ")
   M->PAGAMENTO=CTOD("  /  /  ")
   M->HISTORICO=SPACE( 30)
**
** Bloco de inser‡„o I03.B15
**
M->DIGITADOR=M->OPERADOR
ELSE
   M->NUMERO=NUMERO
   M->CEDENTE=CEDENTE
   M->BANCO=BANCO
   M->CONTA=CONTA
   M->CIDADE=CIDADE
   M->VALOR=VALOR
   M->VENCIMENTO=VENCIMENTO
   M->PAGAMENTO=PAGAMENTO
   M->HISTORICO=HISTORICO
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
JANELA( 5,14,16,65," 2.Cheques a pagar")
COR("CERCADURAS")
*
* -> Monta cercaduras
@  6,15 TO 15,64
**
** Bloco de inser‡„o I03.B18
**
COR("GETS")
**
** Bloco de inser‡„o I03.B21
**
*
* -> Monta tela de cadastro
@  7,17 SAY "Cedente     :" GET M->CEDENTE PICTURE "@!" VALID IFU03002()
@  8,17 SAY "Numero      :" GET M->NUMERO PICTURE "@!" VALID IFU03001() .AND.  VERI003(M->R_CAR)
@  9,17 SAY "Banco       :" GET M->BANCO PICTURE "@!" VALID IFU03003()
@ 10,17 SAY "Conta       :" GET M->CONTA PICTURE "@!" VALID IFU03004()
@ 11,17 SAY "Cidade      :" GET M->CIDADE PICTURE "@!" VALID IFU03005()
@ 12,17 SAY "Valor       :" GET M->VALOR PICTURE "@Z 9,999,999.99"
@ 13,17 SAY "Vencimento  :" GET M->VENCIMENTO VALID IFU03007()
@ 14,17 SAY "Historico   :" GET M->HISTORICO PICTURE "@!"
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
REPLACE NUMERO WITH M->NUMERO
REPLACE CEDENTE WITH M->CEDENTE
REPLACE BANCO WITH M->BANCO
REPLACE CONTA WITH M->CONTA
REPLACE CIDADE WITH M->CIDADE
REPLACE VALOR WITH M->VALOR
REPLACE VENCIMENTO WITH M->VENCIMENTO
REPLACE PAGAMENTO WITH M->PAGAMENTO
REPLACE HISTORICO WITH M->HISTORICO
**
** Bloco de inser‡„o I03.B28
**
 
* Final do programa CPDOCI03.PRG