
* TITULO     : Recep‡„o/Emiss„o de cheques
* DATA       : 15/05/97
* PROGRAMA   : CHQI02.PRG
* COMENTARIO : INCLUSAO (Contas-Correntes)
 
**
** Bloco de inser‡„o I02.B01
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
SELE 4
IF .NOT. USEREDE("CONTAS",.F.,10)
   BEEP()
   MENSAGEM("O arquivo CONTAS n„o est  dispon¡vel",3)
   RETURN
ELSE
   SET INDEX TO CONTA007,CONTA008,CONTA009
ENDIF
SELE 4
**
** Bloco de inser‡„o I02.B02
**
***
*** Inicio do bloco de substitui‡„o I02.B
COR("MENU")
@ LIN_MENU,00
@ LIN_MENU,01 SAY "Inclus„o ³ Contas-Correntes"
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
* -> Funcao que verifica duplicidade no arquivo "CONTAS"
PARA R_PARA
M->I_REG=RECN()
M->ORDEM = INDEXORD()
SET ORDER TO 2
SEEK M->NUMEROAGEN+M->NUMEROCONT
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
 
FUNCTION IFU02004
*
* -> Validacao para o campo ESPECIFICA
IF .NOT.(.NOT.EMPTY(M->ESPECIFICA)) .AND. LASTKEY()<>5
   BEEP()
   MENSAGEM("Especifique esta conta-corrente",3)
   MENSAGEM("Tecle <ESC> para retornar")
   RETURN .F.
ENDIF
RETURN .T.
 
FUNCTION PSQ02001
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
SELE 4
RETURN M->RETOR_NO
 
FUNCTION CARREG02
*
* -> Carrega variaveis para entrada ou altercao de dados
PARA R_CAR
**
** Bloco de inser‡„o I02.B14
**
PUBLIC NUMEROAGEN,NOMEDOBANK,NUMEROCONT,ESPECIFICA
IF M->R_CAR=1
   M->NUMEROAGEN=SPACE( 10)
   M->NOMEDOBANK=SPACE( 30)
   M->NUMEROCONT=SPACE( 20)
   M->ESPECIFICA=SPACE( 20)
**
** Bloco de inser‡„o I02.B15
**
M->DIGITADOR=M->OPERADOR
ELSE
   M->NUMEROAGEN=NUMEROAGEN
   M->NOMEDOBANK=NOMEDOBANK
   M->NUMEROCONT=NUMEROCONT
   M->ESPECIFICA=ESPECIFICA
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
JANELA( 7,12,18,64,"Contas-Correntes")
COR("CERCADURAS")
*
* -> Monta cercaduras
@  9,14 TO 11,27
@ 12,14 TO 14,47
@ 15,14 TO 17,37
@ 15,39 TO 17,62
**
** Bloco de inser‡„o I02.B18
**
COR("GETS")
*
* -> Carrega caracteres avulsos
@ 12,16 SAY ""
@  9,16 SAY "Agencia"
@ 12,16 SAY "Nome do banco"
@ 15,16 SAY "Conta-corrente"
@ 15,41 SAY "Especifica‡„o"
**
** Bloco de inser‡„o I02.B21
**
IF M->X_VERI
   PSQ02001()
ENDIF
*
* -> Monta tela de cadastro
@ 10,16 GET M->NUMEROAGEN PICTURE "9999999999" VALID PSQ02001()
@ 13,16 GET M->NOMEDOBANK PICTURE "@!"
@ 16,16 GET M->NUMEROCONT PICTURE "99999999999999999999" VALID VERI002(M->R_CAR)
@ 16,41 GET M->ESPECIFICA PICTURE "@!" VALID IFU02004()
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
REPLACE NUMEROAGEN WITH M->NUMEROAGEN
REPLACE NOMEDOBANK WITH M->NOMEDOBANK
REPLACE NUMEROCONT WITH M->NUMEROCONT
REPLACE ESPECIFICA WITH M->ESPECIFICA
**
** Bloco de inser‡„o I02.B28
**
 
* Final do programa CHQI02.PRG
