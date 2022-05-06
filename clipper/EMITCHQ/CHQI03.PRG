
* TITULO     : Recep‡„o/Emiss„o de cheques
* DATA       : 15/05/97
* PROGRAMA   : CHQI03.PRG
* COMENTARIO : INCLUSAO (Emiss„o  de CHQ's)
 
**
** Bloco de inser‡„o I03.B01
**
MENSAGEM("Aguarde abertura de arquivos")
SELE 1
IF .NOT. USEREDE("CHQEMT",.F.,10)
   BEEP()
   MENSAGEM("O arquivo CHQEMT n„o est  dispon¡vel",3)
   RETURN
ELSE
   SET INDEX TO CHQEM001,CHQEM002
ENDIF
SELE 4
IF .NOT. USEREDE("CONTAS",.F.,10)
   BEEP()
   MENSAGEM("O arquivo CONTAS n„o est  dispon¡vel",3)
   RETURN
ELSE
   SET INDEX TO CONTA007,CONTA008,CONTA009
ENDIF
SELE 1
**
** Bloco de inser‡„o I03.B02
**
***
*** Inicio do bloco de substitui‡„o I03.B
COR("MENU")
@ LIN_MENU,00
@ LIN_MENU,01 SAY "Inclus„o ³ Emiss„o  de CHQ's"
M->P_VERI = .T.
M->X_VERI = .F.
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
   IF CARGET03(1)=.F.
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
   IF .NOT. ADIREG(0)
      M->P_VERI=.F.
      MENSAGEM("Inclus„o n„o foi bem sucedida",3)
      MENSAGEM("Tecle <ESC> para retornar")
      LOOP
   ENDIF
   *
   * -> Atualiza o banco de dados
   SALVAR03()
   COMMIT
   UNLOCK
ENDDO
RESTSCREEN(LIN_MENU+1,00,23,79,TELA_PRI)
**
** Bloco de inser‡„o I03.B13
**
*** Final do bloco de substitui‡„o I03.B
***
 
FUNCTION IFU03003
*
* -> Validacao para o campo NUMEROCONT
IF .NOT.(.NOT.EMPTY(M->NUMEROCONT)) .AND. LASTKEY()<>5
   BEEP()
   MENSAGEM("Informe a conta corrente",3)
   MENSAGEM("Tecle <ESC> para retornar")
   RETURN .F.
ENDIF
RETURN .T.
 
FUNCTION IFU03007
*
* -> Validacao para o campo FINALIDADE
IF .NOT.(.NOT.EMPTY(M->FINALIDADE)) .AND. LASTKEY()<>5
   BEEP()
   MENSAGEM("Informe o destino/finalidade desta emissao!!!",3)
   MENSAGEM("Tecle <ESC> para retornar")
   RETURN .F.
ENDIF
RETURN .T.
 
FUNCTION PSQ03001
*
* -> Funcao que faz pesquisas em outro banco de dados
SELE 4
SET ORDER TO 3
SEEK M->NUMEROCONT
M->RETOR_NO=.T.
IF (EOF() .AND. LASTKEY()<>5) .OR. M->TEC_F2
   M->GET_CAM=READVAR()
   IF LEN(M->GET_CAM)<>0
      EDIT_ARQ(EMPTY(M->NUMEROCONT))
      IF LASTKEY()=13
         M->NUMEROCONT = NUMEROCONT
      ENDIF
   ENDIF
ELSE
   M->NUMEROCONT = NUMEROCONT
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
PUBLIC NOMEDOBANK,NUMEROAGEN,NUMEROCONT,NUMERO_CHQ,VALORDOCHQ,DATAPPAGAR,FINALIDADE
IF M->R_CAR=1
   M->NOMEDOBANK=SPACE( 30)
   M->NUMEROAGEN=SPACE( 10)
   M->NUMEROCONT=SPACE( 20)
   M->NUMERO_CHQ=SPACE( 20)
   M->VALORDOCHQ=0
   M->DATAPPAGAR=CTOD("  /  /  ")
   M->FINALIDADE=SPACE( 30)
**
** Bloco de inser‡„o I03.B15
**
M->DIGITADOR=M->OPERADOR
ELSE
   M->NOMEDOBANK=NOMEDOBANK
   M->NUMEROAGEN=NUMEROAGEN
   M->NUMEROCONT=NUMEROCONT
   M->NUMERO_CHQ=NUMERO_CHQ
   M->VALORDOCHQ=VALORDOCHQ
   M->DATAPPAGAR=DATAPPAGAR
   M->FINALIDADE=FINALIDADE
   **
   ** Bloco de inser‡„o I03.B16
   **
ENDIF
 
FUNCTION CARGET03
*
* -> Formata a tela para entrada ou alteracao de dados
PARA R_CAR
**
** Bloco de inser‡„o I03.B17
**
JANELA( 7, 7,18,68,"Emiss„o  de CHQ's")
COR("CERCADURAS")
*
* -> Monta cercaduras
@  9, 9 TO 11,32
@ 12, 9 TO 14,32
@ 12,33 TO 14,48
@ 12,49 TO 14,66
@ 15, 9 TO 17,46
**
** Bloco de inser‡„o I03.B18
**
COR("GETS")
*
* -> Carrega caracteres avulsos
@  9,11 SAY "Conta-corrente"
@ 12,11 SAY "Numero do cheque"
@ 12,35 SAY "(R$)   Valor"
@ 12,51 SAY "Data SQE"
@ 15,11 SAY "Finalidade desta emissao"
**
** Bloco de inser‡„o I03.B21
**
IF M->X_VERI
   PSQ03001()
ENDIF
*
* -> Monta tela de cadastro
@ 10,11 GET M->NUMEROCONT PICTURE "@!" VALID PSQ03001() .AND.  IFU03003()
@ 13,11 GET M->NUMERO_CHQ PICTURE "@!"
@ 13,35 GET M->VALORDOCHQ PICTURE "@Z 9,999,999.99"
@ 13,51 GET M->DATAPPAGAR
@ 16,11 GET M->FINALIDADE VALID IFU03007()
**
** Bloco de inser‡„o I03.B24
**
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
REPLACE NOMEDOBANK WITH M->NOMEDOBANK
REPLACE NUMEROAGEN WITH M->NUMEROAGEN
REPLACE NUMEROCONT WITH M->NUMEROCONT
REPLACE NUMERO_CHQ WITH M->NUMERO_CHQ
REPLACE VALORDOCHQ WITH M->VALORDOCHQ
REPLACE DATAPPAGAR WITH M->DATAPPAGAR
REPLACE FINALIDADE WITH M->FINALIDADE
**
** Bloco de inser‡„o I03.B28
**
 
* Final do programa CHQI03.PRG
