
* TITULO     :  MFB Materiais de Construcao Ltda ( MMStec - Orcamento )
* DATA       : 06/03/97
* PROGRAMA   : UTILI05.PRG
* COMENTARIO : INCLUSAO (5 - Folha de Pagamento)
 
**
** Bloco de inser‡„o I05.B01
**
MENSAGEM("Aguarde abertura de arquivos")
SELE 5
IF .NOT. USEREDE("FOLHA_PA",.F.,10)
   BEEP()
   MENSAGEM("O arquivo FOLHA_PA n„o est  dispon¡vel",3)
   RETURN
ELSE
   SET INDEX TO FOLHA006
ENDIF
SELE 5
**
** Bloco de inser‡„o I05.B02
**
***
*** Inicio do bloco de substitui‡„o I05.B
COR("MENU")
@ LIN_MENU,00
@ LIN_MENU,01 SAY "Inclus„o ³ 5 - Folha de Pagamento"
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
      CARREG05(1)
   ELSE
      M->X_VERI = .T.
      **
      ** Bloco de inser‡„o I05.B05
      **
   ENDIF
   IF CARGET05(1)=.F.
      EXIT
   ENDIF
   **
   ** Bloco de inser‡„o I05.B10
   **
   IF PERG("Confirma as informa‡”es ?")="N"
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
 
FUNCTION IFU05003
SETCOLOR(CONTECOR[8])
@ 10,32 SAY M->VALOR/4 PICT "@Z 9,999,999.99"
COR("GETS")
RETURN .T.
 
FUNCTION CARREG05
PARA R_CAR
**
** Bloco de inser‡„o I05.B14
**
PUBLIC CODIGO,NOME,VALOR,ASSINA,SALAR_BASE,DATA
IF M->R_CAR=1
   M->CODIGO=SPACE(  5)
   M->NOME=SPACE( 30)
   M->VALOR=0
   M->ASSINA=SPACE( 30)
   M->SALAR_BASE=0
   M->DATA=CTOD("  /  /  ")
   **
   ** Bloco de inser‡„o I05.B15
   **
ELSE
   M->CODIGO=CODIGO
   M->NOME=NOME
   M->VALOR=VALOR
   M->ASSINA=ASSINA
   M->SALAR_BASE=SALAR_BASE
   M->DATA=DATA
   **
   ** Bloco de inser‡„o I05.B16
   **
ENDIF
 
FUNCTION CARGET05
PARA R_CAR
**
** Bloco de inser‡„o I05.B17
**
JANELA( 4,15,12,64,"5 - Folha de Pagamento")
COR("CERCADURAS")
@  5,16 TO 11,63
**
** Bloco de inser‡„o I05.B18
**
COR("GETS")
@ 10,18 SAY "S. SEMANAL  :"
**
** Bloco de inser‡„o I05.B21
**
IF M->X_VERI
   IFU05003()
ENDIF
@  6,18 SAY "CODIGO      :" GET M->CODIGO PICTURE "@Z 99999"
@  7,18 SAY "NOME        :" GET M->NOME PICTURE "@!"
@  8,18 SAY "PISO MINIMO :" GET M->SALAR_BASE PICTURE "@Z 9,999,999.99"
@  9,18 SAY "SALARIO     :" GET M->VALOR PICTURE "@Z 9,999,999.99" VALID IFU05003()
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
**
** Bloco de inser‡„o I05.B27
**
REPLACE CODIGO WITH M->CODIGO
REPLACE NOME WITH M->NOME
REPLACE VALOR WITH M->VALOR
REPLACE ASSINA WITH M->ASSINA
REPLACE SALAR_BASE WITH M->SALAR_BASE
REPLACE DATA WITH M->DATA
**
** Bloco de inser‡„o I05.B28
**
 
* Final do programa UTILI05.PRG