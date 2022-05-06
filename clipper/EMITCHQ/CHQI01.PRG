
* TITULO     : Recep‡„o/Emiss„o de cheques
* DATA       : 15/05/97
* PROGRAMA   : CHQI01.PRG
* COMENTARIO : INCLUSAO (Bancos)
 
**
** Bloco de inser‡„o I01.B01
**
MENSAGEM("Aguarde abertura de arquivos")
SELE 3
IF .NOT. USEREDE("BANCOS",.F.,10)
   BEEP()
   MENSAGEM("O arquivo BANCOS n„o est  dispon¡vel",3)
   RETURN
ELSE
   SET INDEX TO BANCO005,BANCO006
ENDIF
SELE 3
**
** Bloco de inser‡„o I01.B02
**
***
*** Inicio do bloco de substitui‡„o I01.B
COR("MENU")
@ LIN_MENU,00
@ LIN_MENU,01 SAY "Inclus„o ³ Bancos"
M->P_VERI = .T.
M->X_VERI = .F.
M->IN_CLUI=.T.
DO WHILE .T.
   **
   ** Bloco de inser‡„o I01.B03
   **
   MENSAGEM("Tecle <ESC> para retornar")
   IF M->P_VERI
      **
      ** Bloco de inser‡„o I01.B04
      **
      *
      * -> Inicializa variaveis
      CARREG01(1)
   ELSE
      M->X_VERI = .T.
      **
      ** Bloco de inser‡„o I01.B05
      **
   ENDIF
   *
   * -> Carrega tela de cadastro
   IF CARGET01(IIF(M->AL_TERA,2,1))=.F.
      IF M->AL_TERA
         **
         ** Bloco de inser‡„o I01.B06
         **
         CARREG01(2)
         M->X_VERI = .T.
         CARGET01(5)
         BEEP()
         IF PERG("Registro j  cadastrado. Deseja alterar ?")="S"
            **
            ** Bloco de inser‡„o I01.B07
            **
            M->IN_CLUI=.F.
            M->P_VERI=.F.
         ELSE
            **
            ** Bloco de inser‡„o I01.B08
            **
            M->AL_TERA=.F.
         ENDIF
         LOOP
      ENDIF
      **
      ** Bloco de inser‡„o I01.B09
      **
      EXIT
   ENDIF
   **
   ** Bloco de inser‡„o I01.B10
   **
   IF PERG("Confirma as informa‡”es ?")="N"
      *
      * -> Faz reedicao
      M->P_VERI = .F.
      **
      ** Bloco de inser‡„o I01.B11
      **
      LOOP
   ENDIF
   M->P_VERI = .T.
   M->X_VERI = .F.
   **
   ** Bloco de inser‡„o I01.B12
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
   SALVAR01()
   COMMIT
   UNLOCK
   IF .NOT. M->IN_CLUI
      M->IN_CLUI=.T.
   ENDIF
ENDDO
RESTSCREEN(LIN_MENU+1,00,23,79,TELA_PRI)
**
** Bloco de inser‡„o I01.B13
**
*** Final do bloco de substitui‡„o I01.B
***
 
FUNCTION VERI001
*
* -> Funcao que verifica duplicidade no arquivo "BANCOS"
PARA R_PARA
M->I_REG=RECN()
M->ORDEM = INDEXORD()
SET ORDER TO 2
SEEK M->NUMEROAGEN
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
 
FUNCTION IFU01001
*
* -> Validacao para o campo NUMEROAGEN
IF .NOT.(.NOT.EMPTY(M->NUMEROAGEN)) .AND. LASTKEY()<>5
   BEEP()
   MENSAGEM("Informe o numero da agencia!!!",3)
   MENSAGEM("Tecle <ESC> para retornar")
   RETURN .F.
ENDIF
RETURN .T.
 
FUNCTION CARREG01
*
* -> Carrega variaveis para entrada ou altercao de dados
PARA R_CAR
**
** Bloco de inser‡„o I01.B14
**
PUBLIC NUMEROAGEN,NOMEDOBANK
IF M->R_CAR=1
   M->NUMEROAGEN=SPACE( 10)
   M->NOMEDOBANK=SPACE( 30)
**
** Bloco de inser‡„o I01.B15
**
M->DIGITADOR=M->OPERADOR
ELSE
   M->NUMEROAGEN=NUMEROAGEN
   M->NOMEDOBANK=NOMEDOBANK
   **
   ** Bloco de inser‡„o I01.B16
   **
ENDIF
 
FUNCTION CARGET01
*
* -> Formata a tela para entrada ou alteracao de dados
PARA R_CAR
IF R_CAR<>5
   M->AL_TERA=.F.
ENDIF
**
** Bloco de inser‡„o I01.B17
**
JANELA( 8,12,14,63,"Bancos")
COR("CERCADURAS")
*
* -> Monta cercaduras
@ 11,14 TO 13,27
@ 11,28 TO 13,61
**
** Bloco de inser‡„o I01.B18
**
COR("GETS")
*
* -> Carrega caracteres avulsos
@ 11,11 SAY ""
@ 11,16 SAY "Agˆncia"
@ 11,30 SAY "Nome do banco"
**
** Bloco de inser‡„o I01.B21
**
*
* -> Monta tela de cadastro
@ 12,16 GET M->NUMEROAGEN PICTURE "9999999999" VALID IFU01001() .AND.  VERI001(M->R_CAR)
@ 12,30 GET M->NOMEDOBANK PICTURE "@!"
**
** Bloco de inser‡„o I01.B24
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
 
FUNCTION SALVAR01
*
* -> Salva o conteudo das variaveis de entrada no arquivo
**
** Bloco de inser‡„o I01.B27
**
REPLACE NUMEROAGEN WITH M->NUMEROAGEN
REPLACE NOMEDOBANK WITH M->NOMEDOBANK
**
** Bloco de inser‡„o I01.B28
**
 
* Final do programa CHQI01.PRG