
* TITULO     :  MFB Materiais de Construcao Ltda ( MMStec - Orcamento )
* DATA       : 06/03/97
* PROGRAMA   : UTILI03.PRG
* COMENTARIO : INCLUSAO (3 - Lista / Precos)
 
**
** Bloco de inser‡„o I03.B01
**
MENSAGEM("Aguarde abertura de arquivos")
SELE 3
IF .NOT. USEREDE("LISTA",.F.,10)
   BEEP()
   MENSAGEM("O arquivo LISTA n„o est  dispon¡vel",3)
   RETURN
ELSE
   SET INDEX TO LISTA002,LISTA003
ENDIF
SELE 3
**
** Bloco de inser‡„o I03.B02
**
***
*** Inicio do bloco de substitui‡„o I03.B
COR("MENU")
@ LIN_MENU,00
@ LIN_MENU,01 SAY "Inclus„o ³ 3 - Lista / Precos"
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
      CARREG03(1)
   ELSE
      M->X_VERI = .T.
      **
      ** Bloco de inser‡„o I03.B05
      **
   ENDIF
   IF CARGET03(1)=.F.
      EXIT
   ENDIF
   **
   ** Bloco de inser‡„o I03.B10
   **
   IF PERG("Confirma as informa‡”es ?")="N"
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
 
FUNCTION CARREG03
PARA R_CAR
**
** Bloco de inser‡„o I03.B14
**
PUBLIC DESCRICAO,VALOR,DATA
IF M->R_CAR=1
   M->DESCRICAO=SPACE( 50)
   M->VALOR=0
   M->DATA=CTOD("  /  /  ")
   **
   ** Bloco de inser‡„o I03.B15
   **
ELSE
   M->DESCRICAO=DESCRICAO
   M->VALOR=VALOR
   M->DATA=DATA
   **
   ** Bloco de inser‡„o I03.B16
   **
ENDIF
 
FUNCTION CARGET03
PARA R_CAR
**
** Bloco de inser‡„o I03.B17
**
JANELA( 4, 9,12,68,"3 - Lista / Precos")
COR("CERCADURAS")
@  6,11 TO 11,67
**
** Bloco de inser‡„o I03.B18
**
COR("GETS")
@  6,27 SAY " DESCRICAO DO PRODUTO"
**
** Bloco de inser‡„o I03.B21
**
@  7,14 GET M->DESCRICAO PICTURE "@!"
@  9,14 SAY "VALOR PARA VENDA    :" GET M->VALOR PICTURE "@Z 9,999,999.99"
@ 10,14 SAY "DATA                :" GET M->DATA
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
**
** Bloco de inser‡„o I03.B27
**
REPLACE DESCRICAO WITH M->DESCRICAO
REPLACE VALOR WITH M->VALOR
REPLACE DATA WITH M->DATA
**
** Bloco de inser‡„o I03.B28
**
 
* Final do programa UTILI03.PRG