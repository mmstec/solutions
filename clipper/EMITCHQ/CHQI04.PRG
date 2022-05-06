
* TITULO     : Recep‡„o/Emiss„o de cheques
* DATA       : 15/05/97
* PROGRAMA   : CHQI04.PRG
* COMENTARIO : INCLUSAO (Recep‡„o de CHQ's)
 
**
** Bloco de inser‡„o I04.B01
**
*
* -> Define o nivel de acesso
IF M->NIVEL<"2"
   BEEP()
   MENSAGEM("Acesso n„o permitido para este n¡vel de senha",3)
   RETURN
ENDIF
MENSAGEM("Aguarde abertura de arquivos")
SELE 2
IF .NOT. USEREDE("CHQRCB",.F.,10)
   BEEP()
   MENSAGEM("O arquivo CHQRCB n„o est  dispon¡vel",3)
   RETURN
ELSE
   SET INDEX TO CHQRC003,CHQRC004
ENDIF
SELE 3
IF .NOT. USEREDE("BANCOS",.F.,10)
   BEEP()
   MENSAGEM("O arquivo BANCOS n„o est  dispon¡vel",3)
   RETURN
ELSE
   SET INDEX TO BANCO005,BANCO006
ENDIF
SELE 2
**
** Bloco de inser‡„o I04.B02
**
***
*** Inicio do bloco de substitui‡„o I04.B
COR("MENU")
@ LIN_MENU,00
@ LIN_MENU,01 SAY "Inclus„o ³ Recep‡„o de CHQ's"
M->P_VERI = .T.
M->X_VERI = .F.
M->IN_CLUI=.T.
DO WHILE .T.
   **
   ** Bloco de inser‡„o I04.B03
   **
   MENSAGEM("Tecle <ESC> para retornar")
   IF M->P_VERI
      **
      ** Bloco de inser‡„o I04.B04
      **
      *
      * -> Inicializa variaveis
      CARREG04(1)
   ELSE
      M->X_VERI = .T.
      **
      ** Bloco de inser‡„o I04.B05
      **
   ENDIF
   *
   * -> Carrega tela de cadastro
   IF CARGET04(IIF(M->AL_TERA,2,1))=.F.
      IF M->AL_TERA
         **
         ** Bloco de inser‡„o I04.B06
         **
         CARREG04(2)
         M->X_VERI = .T.
         CARGET04(5)
         BEEP()
         IF PERG("Registro j  cadastrado. Deseja alterar ?")="S"
            **
            ** Bloco de inser‡„o I04.B07
            **
            M->IN_CLUI=.F.
            M->P_VERI=.F.
         ELSE
            **
            ** Bloco de inser‡„o I04.B08
            **
            M->AL_TERA=.F.
         ENDIF
         LOOP
      ENDIF
      **
      ** Bloco de inser‡„o I04.B09
      **
      EXIT
   ENDIF
   **
   ** Bloco de inser‡„o I04.B10
   **
   IF PERG("Confirma as informa‡”es ?")="N"
      *
      * -> Faz reedicao
      M->P_VERI = .F.
      **
      ** Bloco de inser‡„o I04.B11
      **
      LOOP
   ENDIF
   M->P_VERI = .T.
   M->X_VERI = .F.
   **
   ** Bloco de inser‡„o I04.B12
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
   SALVAR04()
   COMMIT
   UNLOCK
   IF .NOT. M->IN_CLUI
      M->IN_CLUI=.T.
   ENDIF
ENDDO
RESTSCREEN(LIN_MENU+1,00,23,79,TELA_PRI)
**
** Bloco de inser‡„o I04.B13
**
*** Final do bloco de substitui‡„o I04.B
***
 
FUNCTION VERI004
*
* -> Funcao que verifica duplicidade no arquivo "CHQRCB"
PARA R_PARA
M->I_REG=RECN()
M->ORDEM = INDEXORD()
SET ORDER TO 2
SEEK M->NUMEROAGEN+M->NUMERO_CHQ+M->CPFCGC_CLI
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
 
FUNCTION IFU04001
*
* -> Validacao para o campo NUMEROAGEN
IF .NOT.(.NOT.EMPTY(M->NUMEROAGEN)) .AND. LASTKEY()<>5
   BEEP()
   MENSAGEM("Informe o numero da agencia",3)
   MENSAGEM("Tecle <ESC> para retornar")
   RETURN .F.
ENDIF
RETURN .T.
 
FUNCTION IFU04005
*
* -> Validacao para o campo CPFCGC_CLI
IF .NOT.(CGC(M->CPFCGC_CLI) .OR. CIC(M->CPFCGC_CLI)) .AND. LASTKEY()<>5
   BEEP()
   MENSAGEM("Digito verificador invalido!!!",3)
   MENSAGEM("Tecle <ESC> para retornar")
   RETURN .F.
ENDIF
RETURN .T.
 
FUNCTION PSQ04001
*
* -> Funcao que faz pesquisas em outro banco de dados
SELE 3
SET ORDER TO 2
SEEK M->NUMEROAGEN
M->RETOR_NO=.T.
IF (EOF() .AND. LASTKEY()<>5) .OR. M->TEC_F2
   M->GET_CAM=READVAR()
   IF LEN(M->GET_CAM)<>0
      EDIT_ARQ(EMPTY(M->NUMEROAGEN))
      IF LASTKEY()=13
         M->NUMEROAGEN = NUMEROAGEN
      ENDIF
   ENDIF
ELSE
   M->NUMEROAGEN = NUMEROAGEN
   M->NOMEDOBANK = NOMEDOBANK
ENDIF
SELE 2
RETURN M->RETOR_NO
 
FUNCTION CARREG04
*
* -> Carrega variaveis para entrada ou altercao de dados
PARA R_CAR
**
** Bloco de inser‡„o I04.B14
**
PUBLIC NUMEROAGEN,NOMEDOBANK,NUMEROCONT,NUMERO_CHQ,CPFCGC_CLI,NOMEDO_CLI,VALORDOCHQ,DATAPSAQUE,FINALIDADE
IF M->R_CAR=1
   M->NUMEROAGEN=SPACE( 10)
   M->NOMEDOBANK=SPACE( 30)
   M->NUMEROCONT=SPACE( 20)
   M->NUMERO_CHQ=SPACE( 20)
   M->CPFCGC_CLI=SPACE( 14)
   M->NOMEDO_CLI=SPACE( 40)
   M->VALORDOCHQ=0
   M->DATAPSAQUE=CTOD("  /  /  ")
   M->FINALIDADE=SPACE( 40)
**
** Bloco de inser‡„o I04.B15
**
M->DIGITADOR=M->OPERADOR
ELSE
   M->NUMEROAGEN=NUMEROAGEN
   M->NOMEDOBANK=NOMEDOBANK
   M->NUMEROCONT=NUMEROCONT
   M->NUMERO_CHQ=NUMERO_CHQ
   M->CPFCGC_CLI=CPFCGC_CLI
   M->NOMEDO_CLI=NOMEDO_CLI
   M->VALORDOCHQ=VALORDOCHQ
   M->DATAPSAQUE=DATAPSAQUE
   M->FINALIDADE=FINALIDADE
   **
   ** Bloco de inser‡„o I04.B16
   **
ENDIF
 
FUNCTION CARGET04
*
* -> Formata a tela para entrada ou alteracao de dados
PARA R_CAR
IF R_CAR<>5
   M->AL_TERA=.F.
ENDIF
**
** Bloco de inser‡„o I04.B17
**
JANELA( 3, 7,20,71,"Recep‡„o de CHQ's")
COR("CERCADURAS")
*
* -> Monta cercaduras
@  5, 9 TO  7,22
@  8, 9 TO 10,42
@  8,43 TO 10,69
@ 11, 9 TO 13,32
@ 11,33 TO 13,48
@ 11,49 TO 13,69
@ 14, 9 TO 16,26
@ 14,27 TO 16,69
@ 17, 9 TO 19,69
**
** Bloco de inser‡„o I04.B18
**
COR("GETS")
*
* -> Carrega caracteres avulsos
@  5,11 SAY "Agencia"
@  5,25 SAY "< F2 > = Agˆncias disponiveis"
@  8,11 SAY "Nome do banco"
@  8,45 SAY "Conta-corrente/cliente"
@ 11,11 SAY "Numero do cheque"
@ 11,35 SAY "(R$)   valor"
@ 11,51 SAY "Previsao do saque"
@ 14,13 SAY "CPF ou CGC"
@ 14,28 SAY "Nome do titular do cheque"
@ 17,11 SAY "Cheque recebido, referente a:"
**
** Bloco de inser‡„o I04.B21
**
IF M->X_VERI
   PSQ04001()
ENDIF
*
* -> Monta tela de cadastro
@  6,11 GET M->NUMEROAGEN PICTURE "@!" VALID PSQ04001() .AND.  IFU04001()
@  9,11 GET M->NOMEDOBANK PICTURE "@!"
@  9,45 GET M->NUMEROCONT PICTURE "@!"
@ 12,11 GET M->NUMERO_CHQ
@ 12,35 GET M->VALORDOCHQ PICTURE "@Z 9,999,999.99"
@ 12,51 GET M->DATAPSAQUE
@ 15,11 GET M->CPFCGC_CLI PICTURE "99999999999999" VALID IFU04005() .AND.  VERI004(M->R_CAR)
@ 15,28 GET M->NOMEDO_CLI PICTURE "@!"
@ 18,11 GET M->FINALIDADE PICTURE "@!"
**
** Bloco de inser‡„o I04.B24
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
 
FUNCTION SALVAR04
*
* -> Salva o conteudo das variaveis de entrada no arquivo
**
** Bloco de inser‡„o I04.B27
**
REPLACE NUMEROAGEN WITH M->NUMEROAGEN
REPLACE NOMEDOBANK WITH M->NOMEDOBANK
REPLACE NUMEROCONT WITH M->NUMEROCONT
REPLACE NUMERO_CHQ WITH M->NUMERO_CHQ
REPLACE CPFCGC_CLI WITH M->CPFCGC_CLI
REPLACE NOMEDO_CLI WITH M->NOMEDO_CLI
REPLACE VALORDOCHQ WITH M->VALORDOCHQ
REPLACE DATAPSAQUE WITH M->DATAPSAQUE
REPLACE FINALIDADE WITH M->FINALIDADE
**
** Bloco de inser‡„o I04.B28
**
 
* Final do programa CHQI04.PRG
