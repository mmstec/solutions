
* TITULO     : MFB - Duplicatas e Estoque do Cimento
* DATA       : 22/04/97
* PROGRAMA   : MONTEI05.PRG
* COMENTARIO : INCLUSAO ( MENSAGENS)
 
**
** Bloco de inser‡„o I05.B01
**
MENSAGEM("Aguarde abertura de arquivos")
SELE 3
IF .NOT. USEREDE("MENSAGEM",.F.,10)
   BEEP()
   MENSAGEM("O arquivo MENSAGEM n„o est  dispon¡vel",3)
   RETURN
ELSE
   SET INDEX TO MENSA005
ENDIF
SELE 3
**
** Bloco de inser‡„o I05.B02
**
***
*** Inicio do bloco de substitui‡„o I05.B
COR("MENU")
@ LIN_MENU,00
@ LIN_MENU,01 SAY "Inclus„o ³  MENSAGENS"
M->P_VERI = .T.
M->X_VERI = .F.
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
   IF CARGET05(1)=.F.
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
   IF .NOT. ADIREG(0)
      M->P_VERI=.F.
      MENSAGEM("Inclus„o n„o foi bem sucedida",3)
      MENSAGEM("Tecle <ESC> para retornar")
      LOOP
   ENDIF
   *
   * -> Atualiza o banco de dados
   SALVAR05()
   COMMIT
   UNLOCK
ENDDO
RESTSCREEN(LIN_MENU+1,00,23,79,TELA_PRI)
**
** Bloco de inser‡„o I05.B13
**
*** Final do bloco de substitui‡„o I05.B
***
 
FUNCTION CARREG05
*
* -> Carrega variaveis para entrada ou altercao de dados
PARA R_CAR
**
** Bloco de inser‡„o I05.B14
**
PUBLIC NUMEROOOOO,MENSAGEMMM
IF M->R_CAR=1
   M->NUMEROOOOO=SPACE(  1)
   M->MENSAGEMMM=SPACE( 30)
**
** Bloco de inser‡„o I05.B15
**
M->DIGITADOR=M->OPERADOR
ELSE
   M->NUMEROOOOO=NUMEROOOOO
   M->MENSAGEMMM=MENSAGEMMM
   **
   ** Bloco de inser‡„o I05.B16
   **
ENDIF
 
FUNCTION CARGET05
*
* -> Formata a tela para entrada ou alteracao de dados
PARA R_CAR
**
** Bloco de inser‡„o I05.B17
**
JANELA( 7,15,13,64," MENSAGENS")
COR("CERCADURAS")
*
* -> Monta cercaduras
@  8,16 TO 12,63
**
** Bloco de inser‡„o I05.B18
**
COR("GETS")
**
** Bloco de inser‡„o I05.B21
**
*
* -> Monta tela de cadastro
@  9,18 SAY "NUMERO      :" GET M->NUMEROOOOO PICTURE "@!"
@ 11,18 SAY "MENSAGEM    :" GET M->MENSAGEMMM PICTURE "@!"
**
** Bloco de inser‡„o I05.B24
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
 
FUNCTION SALVAR05
*
* -> Salva o conteudo das variaveis de entrada no arquivo
**
** Bloco de inser‡„o I05.B27
**
REPLACE NUMEROOOOO WITH M->NUMEROOOOO
REPLACE MENSAGEMMM WITH M->MENSAGEMMM
**
** Bloco de inser‡„o I05.B28
**
 
* Final do programa MONTEI05.PRG