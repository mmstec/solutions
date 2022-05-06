
* TITULO     :  MFB Materiais de Construcao Ltda ( MMStec - Orcamento )
* DATA       : 06/03/97
* PROGRAMA   : UTILI06.PRG
* COMENTARIO : INCLUSAO (6 - Representantes)
 
**
** Bloco de inser‡„o I06.B01
**
MENSAGEM("Aguarde abertura de arquivos")
SELE 6
IF .NOT. USEREDE("REPRESET",.F.,10)
   BEEP()
   MENSAGEM("O arquivo REPRESET n„o est  dispon¡vel",3)
   RETURN
ELSE
   SET INDEX TO REPRE007
ENDIF
SELE 6
**
** Bloco de inser‡„o I06.B02
**
***
*** Inicio do bloco de substitui‡„o I06.B
COR("MENU")
@ LIN_MENU,00
@ LIN_MENU,01 SAY "Inclus„o ³ 6 - Representantes"
M->P_VERI = .T.
M->X_VERI = .F.
DO WHILE .T.
   **
   ** Bloco de inser‡„o I06.B03
   **
   MENSAGEM("Tecle <ESC> para retornar")
   IF M->P_VERI
      **
      ** Bloco de inser‡„o I06.B04
      **
      CARREG06(1)
   ELSE
      M->X_VERI = .T.
      **
      ** Bloco de inser‡„o I06.B05
      **
   ENDIF
   IF CARGET06(1)=.F.
      EXIT
   ENDIF
   **
   ** Bloco de inser‡„o I06.B10
   **
   IF PERG("Confirma as informa‡”es ?")="N"
      M->P_VERI = .F.
      **
      ** Bloco de inser‡„o I06.B11
      **
      LOOP
   ENDIF
   M->P_VERI = .T.
   M->X_VERI = .F.
   **
   ** Bloco de inser‡„o I06.B12
   **
   IF .NOT. ADIREG(0)
      M->P_VERI=.F.
      MENSAGEM("Inclus„o n„o foi bem sucedida",3)
      MENSAGEM("Tecle <ESC> para retornar")
      LOOP
   ENDIF
   SALVAR06()
   COMMIT
   UNLOCK
ENDDO
RESTSCREEN(LIN_MENU+1,00,23,79,TELA_PRI)
**
** Bloco de inser‡„o I06.B13
**
*** Final do bloco de substitui‡„o I06.B
***
 
FUNCTION CARREG06
PARA R_CAR
**
** Bloco de inser‡„o I06.B14
**
PUBLIC NOME,FONE01,EMPRESA,FONE02,FAX,INTERNET
IF M->R_CAR=1
   M->NOME=SPACE( 30)
   M->FONE01=SPACE( 14)
   M->EMPRESA=SPACE( 30)
   M->FONE02=SPACE( 14)
   M->FAX=SPACE( 14)
   M->INTERNET=SPACE( 30)
   **
   ** Bloco de inser‡„o I06.B15
   **
ELSE
   M->NOME=NOME
   M->FONE01=FONE01
   M->EMPRESA=EMPRESA
   M->FONE02=FONE02
   M->FAX=FAX
   M->INTERNET=INTERNET
   **
   ** Bloco de inser‡„o I06.B16
   **
ENDIF
 
FUNCTION CARGET06
PARA R_CAR
**
** Bloco de inser‡„o I06.B17
**
JANELA( 4,11,13,65,"6 - Representantes")
COR("CERCADURAS")
@  5,13 TO 12,63
**
** Bloco de inser‡„o I06.B18
**
COR("GETS")
**
** Bloco de inser‡„o I06.B21
**
@  6,17 SAY "Representante:" GET M->NOME PICTURE "@!"
@  7,17 SAY "Telefone     :" GET M->FONE01 PICTURE "(999) 999.9999"
@  8,17 SAY "Empresa      :" GET M->EMPRESA PICTURE "@!"
@  9,17 SAY "Telefone     :" GET M->FONE02 PICTURE "(999) 999.9999"
@ 10,17 SAY "FAX          :" GET M->FAX PICTURE "(999) 999.9999"
@ 11,17 SAY "InterNET     :" GET M->INTERNET
**
** Bloco de inser‡„o I06.B24
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
 
FUNCTION SALVAR06
**
** Bloco de inser‡„o I06.B27
**
REPLACE NOME WITH M->NOME
REPLACE FONE01 WITH M->FONE01
REPLACE EMPRESA WITH M->EMPRESA
REPLACE FONE02 WITH M->FONE02
REPLACE FAX WITH M->FAX
REPLACE INTERNET WITH M->INTERNET
**
** Bloco de inser‡„o I06.B28
**
 
* Final do programa UTILI06.PRG