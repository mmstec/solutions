

* TITULO     :  MFB - Vendas Comissisionadas e Gerais
* DATA       : 12/04/97
* PROGRAMA   : VENDAR05.PRG
* COMENTARIO : RELATORIO ( * Venda pela  LOJA)

**
** Bloco de inser‡„o R05.B01
**
MENSAGEM("Aguarde abertura de arquivos")
SELE 4
IF .NOT. USEREDE("VENDASLJ",.F.,10)
   BEEP()
   MENSAGEM("O arquivo VENDASLJ n„o est  dispon¡vel",3)
   RETURN
ELSE
   SET INDEX TO VENDA004
ENDIF
***
*** Inicio do bloco de substitui‡„o R05.B
MENSAGEM("Tecle <ESC> para retornar")
COR("MENU")
@ LIN_MENU,00
@ LIN_MENU,01 SAY "Relat¢rio ³  * Venda pela  LOJA"
SELE 4
SET ORDER TO 1
**
** Bloco de inser‡„o R05.B02
**
GOTO TOP
*
* -> Inicializa variaveis para filtragem
M->FILTRO_1=CTOD("  /  /  ")
M->FILTRO_2=CTOD("  /  /  ")
JANELA( 7,22,17,59)
COR("MENU")
@ 10,26 CLEAR TO 14,55
**
** Bloco de inser‡„o R05.B03
**
   **
   ** Bloco de inser‡„o R05.B04
   **
@ 11,29 SAY "PERIODO DE    :" GET M->FILTRO_1
@ 13,29 SAY "ATE           :" GET M->FILTRO_2
SET CURSOR ON
READ
SET CURSOR OFF
IF LASTKEY()=27
   RESTSCREEN(LIN_MENU+1,00,23,79,TELA_PRI)
   RETURN
ENDIF
M->TIPO_PRN="I"
*
* -> Menu que permite direcionar a saida de impressao
IF .NOT. MENU_PRN("VENDA_05")
   RESTSCREEN(LIN_MENU+1,00,23,79,TELA_PRI)
   RETURN
ENDIF
SET FILTER TO DATA>=M->FILTRO_1 .AND. DATA<=M->FILTRO_2
IF .NOT.(DATA>=M->FILTRO_1 .AND. DATA<=M->FILTRO_2)
   SKIP
ENDIF
SET DEVI TO PRINT
M->LI_NHA=1
M->PAG=1
*
* -> Inicializa variaveis de quebra
M->QUEBRA_3=MES_ANO(DATA)
*
* -> Inicializa variaveis de totalizacao
M->TOT_0001=0
M->TOT_0002=0
M->TOT_0003=0
M->TOT_0004=0
*
* -> Inicializa variaveis de subtotalizacao de quebra por DATA
M->TO3_0001=0
M->TO3_0002=0
M->TO3_0003=0
M->TO3_0004=0
**
** Bloco de inser‡„o R05.B05
**
M->SAI_DA="S"
*** Final do bloco de substitui‡„o R05.B
***
DO WHILE .NOT. EOF()
   **
   ** Bloco de inser‡„o R05.B06
   **
   IF INKEY()=27
      **
      ** Bloco de inser‡„o R05.B07
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
   IF M->LI_NHA=1
      **
      ** Bloco de inser‡„o R05.B09
      **
      *
      * -> Determina o tipo de caracter para impressao
      IF TIPO_PRN<>"T"
         @ 00,01 SAY CHR(18)
      ENDIF
      M->CAB_1="MFB MATERIAL DE CONSTRUCAO LTDA"
      M->CAB_2="*** VENDA DIARIA PELA  LOJA ***"
      **
      ** Bloco de inser‡„o R05.B22
      **
      @ 00,001 SAY PADL("USUARIO: "+RTRIM(M->OPERADOR),79)
      @ 01,001 SAY M->CAB_1
      @ 01,066 SAY "Pagina: "+SUBS(STR(M->PAG+1000000,7),2)
      M->PAG=M->PAG+1
      @ 02,001 SAY M->CAB_2
      @ 02,066 SAY "Data: "+DTOC(DATE())
      @ 04,001 SAY "PERIODO DE....:"
      @ 04,017 SAY FILTRO_1
      @ 05,001 SAY "ATE...........:"
      @ 05,017 SAY FILTRO_2
      @ 07,001 SAY REPL("*", 79)
      @ 08,001 SAY "INCLUSAO"
      @ 08,011 SAY "VENDA  FIADO"
      @ 08,026 SAY "VENDA  VISTA"
      @ 08,041 SAY "RECEBIMENTOS"
      @ 08,068 SAY "TOTAL VENDAS"
      @ 09,001 SAY REPL("*", 79)
      @ 11,001 SAY "VENDA PELA LOJA DO MES "
      @ 11,026 SAY MES_ANO(M->QUEBRA_3)
      M->LI_NHA=13
      **
      ** Bloco de inser‡„o R05.B10
      **
   ENDIF
   **
   ** Bloco de inser‡„o R05.B20
   **
   @ M->LI_NHA,001 SAY DATA
   @ M->LI_NHA,011 SAY FIADO PICTURE "@Z 9,999,999.99"
   @ M->LI_NHA,026 SAY AVISTA PICTURE "@Z 9,999,999.99"
   @ M->LI_NHA,041 SAY RECEBIMENO PICTURE "@Z 9,999,999.99"
   @ M->LI_NHA,068 SAY RFU05001() PICTURE "@Z 9,999,999.99"
   **
   ** Bloco de inser‡„o R05.B21
   **
   *
   * -> Totalizacao de campo numericos
   M->TOT_0001=M->TOT_0001+FIADO
   M->TOT_0002=M->TOT_0002+AVISTA
   M->TOT_0003=M->TOT_0003+RECEBIMENO
   M->TOT_0004=M->TOT_0004+RFU05001()
   *
   * -> Subtotalizacao de quebra por DATA
   M->TO3_0001=M->TO3_0001+FIADO
   M->TO3_0002=M->TO3_0002+AVISTA
   M->TO3_0003=M->TO3_0003+RECEBIMENO
   M->TO3_0004=M->TO3_0004+RFU05001()
   M->LI_NHA=M->LI_NHA+1
   **
   ** Bloco de inser‡„o R05.B12
   **
   SKIP
   IF M->QUEBRA_3<>MES_ANO(DATA)
      **
      ** Bloco de inser‡„o R05.B15
      **
      *
      * -> Imprime subtotalizacao da quebra
      @ M->LI_NHA+0,01 SAY REPL("-", 79)
      @ M->LI_NHA+1,001 SAY "TOTAL"
      @ M->LI_NHA+2,001 SAY "DO MES"
      @ M->LI_NHA+2,009 SAY M->TO3_0001 PICTURE "@Z 999,999,999.99"
      @ M->LI_NHA+2,024 SAY M->TO3_0002 PICTURE "@Z 999,999,999.99"
      @ M->LI_NHA+2,039 SAY M->TO3_0003 PICTURE "@Z 999,999,999.99"
      @ M->LI_NHA+2,066 SAY M->TO3_0004 PICTURE "@Z 999,999,999.99"
      M->LI_NHA=M->LI_NHA+3
      *
      * -> Inicializa variaveis de subtotalizacao de quebra por DATA
      M->TO3_0001=0
      M->TO3_0002=0
      M->TO3_0003=0
      M->TO3_0004=0
      M->QUEBRA_3=MES_ANO(DATA)
      M->LI_NHA=58
   ENDIF
   IF M->LI_NHA>57 .OR. EOF()
      IF EOF()
         TOT_05(2)
      ELSE
         TOT_05(1)
      ENDIF
      M->LI_NHA=1
   ENDIF
ENDDO
**
** Bloco de inser‡„o R05.B18
**
EJECT
SET DEVI TO SCREEN
SET FILTER TO
IF M->TIPO_PRN = "A"
   SET PRINTER TO
ELSEIF M->TIPO_PRN = "T" .AND. M->SAI_DA="S"
   SET PRINTER TO
   IMP_TELA("VENDA_05", 80)
ENDIF
**
** Bloco de inser‡„o R05.B19
**
RESTSCREEN(LIN_MENU+1,00,23,79,TELA_PRI)

FUNCTION TOT_05
*
* -> Funcao de impressao da totalizacao
PARA PAR1
IF PAR1=2
   M->LI_NHA=58
ENDIF
@ M->LI_NHA+0,01 SAY REPL("*", 79)
IF PAR1=2
   @ M->LI_NHA+1,001 SAY "TOTAL"
   @ M->LI_NHA+2,001 SAY "GERAL"
ELSE
   @ M->LI_NHA+1,001 SAY "SUBTOTAL"
   @ M->LI_NHA+2,001 SAY "DO GERAL"
ENDIF
@ M->LI_NHA+2,009 SAY M->TOT_0001 PICTURE "@Z 999,999,999.99"
@ M->LI_NHA+2,024 SAY M->TOT_0002 PICTURE "@Z 999,999,999.99"
@ M->LI_NHA+2,039 SAY M->TOT_0003 PICTURE "@Z 999,999,999.99"
@ M->LI_NHA+2,066 SAY M->TOT_0004 PICTURE "@Z 999,999,999.99"
@ M->LI_NHA+3,01 SAY REPL("*", 79)

FUNCTION RFU05001
RETURN FIADO+AVISTA

* Final do programa VENDAR05.PRG
 
* Final VENDAR05.PRG