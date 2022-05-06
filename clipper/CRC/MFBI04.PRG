
* TITULO     : MFB - CONTROLE DE VENDAS
* DATA       : 12/05/97
* PROGRAMA   : MFBI04.PRG
* COMENTARIO : INCLUSAO (   3.Manuten‡„o)
 
**
** Bloco de inser‡„o I04.B01
**
*
* -> Define o nivel de acesso
IF M->NIVEL<"3"
   BEEP()
   MENSAGEM("Acesso n„o permitido para este n¡vel de senha",3)
   RETURN
ENDIF
MENSAGEM("Aguarde abertura de arquivos")
SELE 2
IF .NOT. USEREDE("MANUTENC",.F.,10)
   BEEP()
   MENSAGEM("O arquivo MANUTENC n„o est  dispon¡vel",3)
   RETURN
ELSE
   SET INDEX TO MANUT004,MANUT005
ENDIF
SELE 2
**
** Bloco de inser‡„o I04.B02
**
***
*** Inicio do bloco de substitui‡„o I04.B
COR("MENU")
@ LIN_MENU,00
@ LIN_MENU,01 SAY "Inclus„o ³    3.Manuten‡„o"
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
* -> Funcao que verifica duplicidade no arquivo "MANUTENC"
PARA R_PARA
M->I_REG=RECN()
M->ORDEM = INDEXORD()
SET ORDER TO 1
SEEK DTOS(M->DATA)
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
 
FUNCTION IFU04002
*
* -> Validacao para o campo DATA
IF .NOT.(.NOT.EMPTY(M->DATA)) .AND. LASTKEY()<>5
   BEEP()
   MENSAGEM("Informe a data",3)
   MENSAGEM("Tecle <ESC> para retornar")
   RETURN .F.
ENDIF
RETURN .T.
 
FUNCTION CARREG04
*
* -> Carrega variaveis para entrada ou altercao de dados
PARA R_CAR
**
** Bloco de inser‡„o I04.B14
**
PUBLIC RS_FIXO,DATA
IF M->R_CAR=1
   M->RS_FIXO=0
   M->DATA=CTOD("  /  /  ")
**
** Bloco de inser‡„o I04.B15
**
M->DIGITADOR=M->OPERADOR
ELSE
   M->RS_FIXO=RS_FIXO
   M->DATA=DATA
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
JANELA( 8,17,14,59,"   3.Manuten‡„o")
COR("CERCADURAS")
*
* -> Monta cercaduras
@ 10,44 TO 12,57
@ 10,19 TO 12,57
**
** Bloco de inser‡„o I04.B18
**
COR("GETS")
*
* -> Carrega caracteres avulsos
@ 10,21 SAY "Valor Unitario FX"
@ 10,47 SAY "Data"
**
** Bloco de inser‡„o I04.B21
**
*
* -> Monta tela de cadastro
@ 11,21 GET M->RS_FIXO PICTURE "@E 9,999,999.99"
@ 11,47 GET M->DATA VALID IFU04002() .AND.  VERI004(M->R_CAR)
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
REPLACE RS_FIXO WITH M->RS_FIXO
REPLACE DATA WITH M->DATA
**
** Bloco de inser‡„o I04.B28
**
 
* Final do programa MFBI04.PRG