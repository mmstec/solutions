
* TITULO     : Controle de Inadiplencia
* DATA       : 15/04/97
* PROGRAMA   : DEVEDR01.PRG
* COMENTARIO : RELATORIO (Inadiplentes)
 
**
** Bloco de inser‡„o R01.B01
**
MENSAGEM("Aguarde abertura de arquivos")
SELE 1
IF .NOT. USEREDE("DEVEDOR",.F.,10)
   BEEP()
   MENSAGEM("O arquivo DEVEDOR n„o est  dispon¡vel",3)
   RETURN
ELSE
   SET INDEX TO DEVED001,DEVED002
ENDIF
***
*** Inicio do bloco de substitui‡„o R01.B
MENSAGEM("Tecle <ESC> para retornar")
COR("MENU")
@ LIN_MENU,00
@ LIN_MENU,01 SAY "Relat¢rio ³ Inadiplentes"
SELE 1
SET ORDER TO 2
**
** Bloco de inser‡„o R01.B02
**
GOTO TOP
*
* -> Inicializa variaveis para filtragem
M->FILTRO_1=SPACE(1)
JANELA( 8,23,16,59)
COR("MENU")
@ 11,27 CLEAR TO 13,55

* TITULO     : Controle de Inadiplencia
* DATA       : 21/10/96
* PROGRAMA   : DEVEDR01.PRG
* COMENTARIO : RELATORIO (Inadiplente)

**
** Bloco de inser‡„o R01.B01
**
MENSAGEM("Aguarde abertura de arquivos")
SELE 1
IF .NOT. USEREDE("DEVEDOR",.F.,10)
   BEEP()
   MENSAGEM("O arquivo DEVEDOR n„o est  dispon¡vel",3)
   RETURN
ELSE
   SET INDEX TO DEVED001,DEVED002
ENDIF
***
*** Inicio do bloco de substitui‡„o R01.B
MENSAGEM("Tecle <ESC> para retornar")
COR("MENU")
@ LIN_MENU,00
@ LIN_MENU,01 SAY "Relat¢rio ³ Inadiplente"
SELE 1
SET ORDER TO 2
**
** Bloco de inser‡„o R01.B02
**
GOTO TOP
*
* -> Inicializa variaveis para filtragem
M->FILTRO_1=SPACE(1)
JANELA( 8,23,16,59)
COR("JANELA DE DIALOGO")
@ 11,27 CLEAR TO 13,55
**
** Bloco de inser‡„o R01.B03
**
DO WHILE .T.
   **
   ** Bloco de inser‡„o R01.B04
   **
   OPC = 1
   @ 11,30 PROMPT " 01 - Inadiplente"
   @ 12,30 PROMPT " 02 - Confronto  "
   @ 13,30 PROMPT " 03 - Funcionario"
   @ 14,30 PROMPT " 04 - Outro      "
   MENU TO OPC
   DO CASE
   CASE OPC = 1
     M->FILTRO_1 = "1"
   CASE OPC = 2
     M->FILTRO_1 = "2"
   CASE OPC = 3
     M->FILTRO_1 = "3"
   CASE OPC = 4
     M->FILTRO_1 = "4"
   ENDCASE

   SET CURSOR OFF
   IF LASTKEY()=27
      RESTSCREEN(LIN_MENU+1,00,23,79,TELA_PRI)
      EXIT
   ENDIF
   SEEK M->FILTRO_1
   IF EOF()
      BEEP()
      MENSAGEM("Registro n„o encontrado",3)
      MENSAGEM("Tecle <ESC> para sair")
      LOOP
   ENDIF
   EXIT
ENDDO
IF LASTKEY()=27
   RESTSCREEN(LIN_MENU+1,00,23,79,TELA_PRI)
   RETURN
ENDIF
M->TIPO_PRN="I"
*
* -> Menu que permite direcionar a saida de impressao
IF .NOT. MENU_PRN("DEVED_01")
   RESTSCREEN(LIN_MENU+1,00,23,79,TELA_PRI)
   RETURN
ENDIF
SET DEVI TO PRINT
M->LI_NHA=1
M->PAG=1
*
* -> Inicializa variaveis de totalizacao
M->TOT_0001=0
**
** Bloco de inser‡„o R01.B05
**
M->SAI_DA="S"
*** Final do bloco de substitui‡„o R01.B
***
DO WHILE .NOT. EOF()
   **
   ** Bloco de inser‡„o R01.B06
   **
   IF INKEY()=27
      **
      ** Bloco de inser‡„o R01.B07
      **
      SET DEVI TO SCREEN
      *
      * -> Permite interromper a impressao
      M->SAI_DA=PERG("Continua a impress„o ?")
      MENSAGEM("Tecle <ESC> para pausa ou interrup‡„o")
      SET DEVI TO PRINT
      IF M->SAI_DA="N"
         EXIT
      ENDIF
   ENDIF
   IF .NOT.(SELECAO=M->FILTRO_1)
      **
      ** Bloco de inser‡„o R01.B08
      **
      *
      * -> Funcao de impressao de totalizacao
      TOT_01(2)
      EXIT
   ENDIF
   IF M->LI_NHA=1
      **
      ** Bloco de inser‡„o R01.B09
      **
      *
      * -> Determina o tipo de caracter para impressao
      IF TIPO_PRN<>"T"
         @ 00,01 SAY CHR(18)
      ENDIF
      M->CAB_1="M.F.B. Materiais de Construcao Ltda."
      M->CAB_2="* * * I N A D I P L E N T E S  * * *"
      **
      ** Bloco de inser‡„o R01.B22
      **
      @ 01,01 SAY M->CAB_1
      @ 01, 47 SAY "Pagina: "+SUBS(STR(M->PAG+10000,5),2)
      M->PAG=M->PAG+1
      @ 02,01 SAY M->CAB_2
      @ 02, 47 SAY "Data: "+DTOC(DATE())
      @ 04,01 SAY REPL("-", 80)
      @ 05,014 SAY "Nome"
      @ 05,045 SAY "Documento"
      @ 05,056 SAY "Sacos"
      @ 06,01 SAY REPL("-", 80)
      M->LI_NHA=07
      **
      ** Bloco de inser‡„o R01.B10
      **
   ENDIF
   **
   ** Bloco de inser‡„o R01.B20
   **
   @ M->LI_NHA,001 SAY RFU01001()
   @ M->LI_NHA,014 SAY NOME
   @ M->LI_NHA,045 SAY DOCUMENTO
   @ M->LI_NHA,056 SAY QUANT_SCOS PICTURE "@Z 99.9"
   **
   ** Bloco de inser‡„o R01.B21
   **
   *
   * -> Totalizacao de campo numericos
   M->TOT_0001=M->TOT_0001+QUANT_SCOS
   M->LI_NHA=M->LI_NHA+1
   **
   ** Bloco de inser‡„o R01.B12
   **
   SKIP
   IF M->LI_NHA>58 .OR. EOF()
      IF EOF()
         TOT_01(2)
      ELSE
         TOT_01(1)
      ENDIF
      M->LI_NHA=1
   ENDIF
ENDDO
**
** Bloco de inser‡„o R01.B18
**
EJECT
SET DEVI TO SCREEN
IF M->TIPO_PRN = "A"
   SET PRINTER TO
ELSEIF M->TIPO_PRN = "T" .AND. M->SAI_DA="S"
   SET PRINTER TO
   IMP_TELA("DEVED_01", 61,  1)
ENDIF
**
** Bloco de inser‡„o R01.B19
**
RESTSCREEN(LIN_MENU+1,00,23,79,TELA_PRI)



* Final do programa DEVEDR01.PRG
DO WHILE .T.
   **
   ** Bloco de inser‡„o R01.B04
   **
   @ 12,30 SAY "Sele‡„o (01,02,03,04)" GET M->FILTRO_1
   SET CURSOR ON
   READ
   SET CURSOR OFF
   IF LASTKEY()=27
      RESTSCREEN(LIN_MENU+1,00,23,79,TELA_PRI)
      EXIT
   ENDIF
   SEEK M->FILTRO_1
   IF EOF()
      BEEP()
      MENSAGEM("Registro n„o encontrado",3)
      MENSAGEM("Tecle <ESC> para sair")
      LOOP
   ENDIF
   EXIT
ENDDO
IF LASTKEY()=27
   RESTSCREEN(LIN_MENU+1,00,23,79,TELA_PRI)
   RETURN
ENDIF
M->TIPO_PRN="I"
*
* -> Menu que permite direcionar a saida de impressao
IF .NOT. MENU_PRN("DEVED_01")
   RESTSCREEN(LIN_MENU+1,00,23,79,TELA_PRI)
   RETURN
ENDIF
SET DEVI TO PRINT
M->LI_NHA=1
M->PAG=1
*
* -> Inicializa variaveis de totalizacao
M->TOT_0001=0
**
** Bloco de inser‡„o R01.B05
**
M->SAI_DA="S"
*** Final do bloco de substitui‡„o R01.B
***
DO WHILE .NOT. EOF()
   **
   ** Bloco de inser‡„o R01.B06
   **
   IF INKEY()=27
      **
      ** Bloco de inser‡„o R01.B07
      **
      SET DEVI TO SCREEN
      *
      * -> Permite interromper a impressao
      M->SAI_DA=PERG("Continua a impress„o ?")
      MENSAGEM("Tecle <ESC> para pausa ou interrup‡„o")
      SET DEVI TO PRINT
      IF M->SAI_DA="N"
         EXIT
      ENDIF
   ENDIF
   IF .NOT.(SELECAO=M->FILTRO_1)
      **
      ** Bloco de inser‡„o R01.B08
      **
      *
      * -> Funcao de impressao de totalizacao
      TOT_01(2)
      EXIT
   ENDIF
   IF M->LI_NHA=1
      **
      ** Bloco de inser‡„o R01.B09
      **
      *
      * -> Determina o tipo de caracter para impressao
      IF TIPO_PRN<>"T"
         @ 00,01 SAY CHR(18)
      ENDIF
      M->CAB_1="M.F.B. Materiais de Construcao Ltda."
      M->CAB_2="* * *  I N D I P L E N T E S  * * *"
      **
      ** Bloco de inser‡„o R01.B22
      **
      @ 00,001 SAY "Usu rio: "+M->OPERADOR
      @ 01,01 SAY M->CAB_1
      @ 01, 47 SAY "Pagina: "+SUBS(STR(M->PAG+10000,5),2)
      M->PAG=M->PAG+1
      @ 02,01 SAY M->CAB_2
      @ 02, 47 SAY "Data: "+DTOC(DATE())
      @ 04,01 SAY REPL("-", 60)
      @ 05,014 SAY "Nome"
      @ 05,045 SAY "Documento"
      @ 05,056 SAY "Sacos"
      @ 06,01 SAY REPL("-", 60)
      M->LI_NHA=07
      **
      ** Bloco de inser‡„o R01.B10
      **
   ENDIF
   **
   ** Bloco de inser‡„o R01.B20
   **
   @ M->LI_NHA,001 SAY RFU01001()
   @ M->LI_NHA,014 SAY NOME
   @ M->LI_NHA,045 SAY DOCUMENTO
   @ M->LI_NHA,056 SAY QUANT_SCOS PICTURE "@Z 99.9"
   **
   ** Bloco de inser‡„o R01.B21
   **
   *
   * -> Totalizacao de campo numericos
   M->TOT_0001=M->TOT_0001+QUANT_SCOS
   M->LI_NHA=M->LI_NHA+1
   **
   ** Bloco de inser‡„o R01.B12
   **
   SKIP
   IF M->LI_NHA>58 .OR. EOF()
      IF EOF()
         TOT_01(2)
      ELSE
         TOT_01(1)
      ENDIF
      M->LI_NHA=1
   ENDIF
ENDDO
**
** Bloco de inser‡„o R01.B18
**
EJECT
SET DEVI TO SCREEN
IF M->TIPO_PRN = "A"
   SET PRINTER TO
ELSEIF M->TIPO_PRN = "T" .AND. M->SAI_DA="S"
   SET PRINTER TO
   IMP_TELA("DEVED_01", 61,  1)
ENDIF
**
** Bloco de inser‡„o R01.B19
**
RESTSCREEN(LIN_MENU+1,00,23,79,TELA_PRI)
 
FUNCTION TOT_01
*
* -> Funcao de impressao da totalizacao
PARA PAR1
IF PAR1=2
   M->LI_NHA=59
ENDIF
@ M->LI_NHA+0,01 SAY REPL("-", 60)
IF PAR1=2
   @ M->LI_NHA+1,001 SAY "TOTAL"
ELSE
   @ M->LI_NHA+1,001 SAY "SUBTOTAL"
ENDIF
@ M->LI_NHA+1,053 SAY M->TOT_0001 PICTURE "99999.9"
@ M->LI_NHA+2,01 SAY REPL("-", 60)
 
FUNCTION RFU01001
IF SELECAO = "1"
   RETURN "Inadiplente"
ELSEIF SELECAO = "2"
   RETURN "Confronto"+SPACE(2)
ELSEIF SELECAO = "3"
   RETURN "Funcionario"
ELSEIF SELECAO = "4"
   RETURN "Outro"+SPACE(6)
ENDIF
 
* Final do programa DEVEDR01.PRG
