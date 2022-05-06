


* TITULO     : MFB - Duplicatas e Estoque do Cimento
* DATA       : 17/04/97
* PROGRAMA   : MONTER04.PRG
* COMENTARIO : RELATORIO ( ESTOQUE    CIMENTO)

**
** Bloco de inser‡„o R04.B01
**
MENSAGEM("Aguarde abertura de arquivos")
SELE 1
IF .NOT. USEREDE("EST_CIMT",.F.,10)
   BEEP()
   MENSAGEM("O arquivo EST_CIMT n„o est  dispon¡vel",3)
   RETURN
ELSE
   SET INDEX TO EST_C001
ENDIF
***
*** Inicio do bloco de substitui‡„o R04.B
MENSAGEM("Tecle <ESC> para retornar")
COR("MENU")
@ LIN_MENU,00
@ LIN_MENU,01 SAY "Relat¢rio ³  ESTOQUE DE CIMENTO"
SELE 1
SET ORDER TO 1
**
** Bloco de inser‡„o R04.B02
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
** Bloco de inser‡„o R04.B03
**
   **
   ** Bloco de inser‡„o R04.B04
   **
@ 11,29 SAY "Estoque de    :" GET M->FILTRO_1
@ 13,29 SAY "Ate           :" GET M->FILTRO_2
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
IF .NOT. MENU_PRN("MONTE_04")
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
M->TOT_0005=0
*
* -> Inicializa variaveis de subtotalizacao de quebra por DATA
M->TO3_0001=0
M->TO3_0002=0
M->TO3_0003=0
M->TO3_0004=0
M->TO3_0005=0
**
** Bloco de inser‡„o R04.B05
**
M->SAI_DA="S"
*** Final do bloco de substitui‡„o R04.B
***
DO WHILE .NOT. EOF()
   **
   ** Bloco de inser‡„o R04.B06
   **
   IF INKEY()=27
      **
      ** Bloco de inser‡„o R04.B07
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
      ** Bloco de inser‡„o R04.B09
      **
      *
      * -> Determina o tipo de caracter para impressao
      IF TIPO_PRN<>"T"
         @ 00,01 SAY CHR(15)
      ENDIF
      M->CAB_1="M.F.B. MATERIAL DE CONSTRUCAO LTDA"
      M->CAB_2="ESTOQUE REGULAR APROXIMADO CIMENTO"
      **
      ** Bloco de inser‡„o R04.B22
      **
      @ 00,000 SAY PADL("RESPONSAVEL P/IMPRESSAO : "+RTRIM(M->OPERADOR),115)
      @ 01,01 SAY M->CAB_1
      @ 01,102 SAY "Pagina: "+SUBS(STR(M->PAG+10000,5),2)
      M->PAG=M->PAG+1
      @ 02,01 SAY M->CAB_2
      @ 02,102 SAY "Data: "+DTOC(DATE())
      @ 04,01 SAY "Estoque de....:"
      @ 04,017 SAY FILTRO_1
      @ 05,01 SAY "Ate...........:"
      @ 05,017 SAY FILTRO_2
      @ 07,01 SAY REPL("*",115)
      @ 08,001 SAY "INCLUSAO"
      @ 08,015 SAY "COMP  SC's"
      @ 08,030 SAY "VEND  SC's"
      @ 08,045 SAY "P.F.P SC's"
      @ 08,056 SAY "HISTORICO"
      @ 08,090 SAY "TOTAL BRUTO"
      @ 08,105 SAY "TOTAL  LQDO"
      @ 09,01 SAY REPL("*",115)
      @ 11,01 SAY "MS"
      @ 11,004 SAY MES_ANO(M->QUEBRA_3)
      M->LI_NHA=13
      **
      ** Bloco de inser‡„o R04.B10
      **
   ENDIF
   **
   ** Bloco de inser‡„o R04.B20
   **
   @ M->LI_NHA,001 SAY DATA
   @ M->LI_NHA,015 SAY COMPRA PICTURE "@Z 9999999.99"
   @ M->LI_NHA,030 SAY VENDA PICTURE "@Z 9999999.99"
   @ M->LI_NHA,045 SAY PGO_F_PEGA PICTURE "@Z 99999999.9"
   @ M->LI_NHA,056 SAY HISTORICO
   @ M->LI_NHA,090 SAY RFU04001() PICTURE "@Z 99999999.99"
   @ M->LI_NHA,105 SAY RFU04002() PICTURE "@Z 99999999.99"
   **
   ** Bloco de inser‡„o R04.B21
   **
   *
   * -> Totalizacao de campo numericos
   M->TOT_0001=M->TOT_0001+COMPRA
   M->TOT_0002=M->TOT_0002+VENDA
   M->TOT_0003=M->TOT_0003+PGO_F_PEGA
   M->TOT_0004=M->TOT_0004+RFU04001()
   M->TOT_0005=M->TOT_0005+RFU04002()
   *
   * -> Subtotalizacao de quebra por DATA
   M->TO3_0001=M->TO3_0001+COMPRA
   M->TO3_0002=M->TO3_0002+VENDA
   M->TO3_0003=M->TO3_0003+PGO_F_PEGA
   M->TO3_0004=M->TO3_0004+RFU04001()
   M->TO3_0005=M->TO3_0005+RFU04002()
   M->LI_NHA=M->LI_NHA+1
   **
   ** Bloco de inser‡„o R04.B12
   **
   SKIP
   IF M->QUEBRA_3<>MES_ANO(DATA)
      **
      ** Bloco de inser‡„o R04.B15
      **
      *
      * -> Imprime subtotalizacao da quebra
      @ M->LI_NHA+0,013 SAY REPL("-",12);@ M->LI_NHA+0,028 SAY REPL("-",12);@ M->LI_NHA+0,043 SAY REPL("-",12);@ M->LI_NHA+0,088 SAY REPL("-",12);@ M->LI_NHA+0,103 SAY REPL("-",12)
      @ M->LI_NHA+1,001 SAY "TOTAL MES"
      @ M->LI_NHA+1,013 SAY M->TO3_0001 PICTURE "9999999999.9"
      @ M->LI_NHA+1,028 SAY M->TO3_0002 PICTURE "9999999999.9"
      @ M->LI_NHA+1,043 SAY M->TO3_0003 PICTURE "@Z 9999999999.9"
      @ M->LI_NHA+1,088 SAY M->TO3_0004 PICTURE "@Z 9999999999.99"
      @ M->LI_NHA+1,103 SAY M->TO3_0005 PICTURE "@Z 9999999999.99"
      M->LI_NHA=M->LI_NHA+2
      *
      * -> Inicializa variaveis de subtotalizacao de quebra por DATA
      M->TO3_0001=0
      M->TO3_0002=0
      M->TO3_0003=0
      M->TO3_0004=0
      M->TO3_0005=0
      M->QUEBRA_3=MES_ANO(DATA)
      M->LI_NHA=59
   ENDIF
   IF M->LI_NHA>58 .OR. EOF()
      IF EOF()
         TOT_04(2)
      ELSE
         TOT_04(1)
      ENDIF
      M->LI_NHA=1
   ENDIF
ENDDO
**
** Bloco de inser‡„o R04.B18
**
EJECT
SET DEVI TO SCREEN
SET FILTER TO
IF M->TIPO_PRN = "A"
   SET PRINTER TO
ELSEIF M->TIPO_PRN = "T" .AND. M->SAI_DA="S"
   SET PRINTER TO
   IMP_TELA("MONTE_04",116)
ENDIF
**
** Bloco de inser‡„o R04.B19
**
RESTSCREEN(LIN_MENU+1,00,23,79,TELA_PRI)

FUNCTION TOT_04
*
* -> Funcao de impressao da totalizacao
PARA PAR1
IF PAR1=2
   M->LI_NHA=59
ENDIF
@ M->LI_NHA+0,01 SAY REPL("*",115)
IF PAR1=2
   @ M->LI_NHA+1,001 SAY "TOTAL"
ELSE
   @ M->LI_NHA+1,001 SAY "SUBTOTAL"
ENDIF
@ M->LI_NHA+1,013 SAY M->TOT_0001 PICTURE "9999999999.9"
@ M->LI_NHA+1,028 SAY M->TOT_0002 PICTURE "9999999999.9"
@ M->LI_NHA+1,043 SAY M->TOT_0003 PICTURE "@Z 9999999999.9"
@ M->LI_NHA+1,088 SAY M->TOT_0004 PICTURE "@Z 9999999999.99"
@ M->LI_NHA+1,103 SAY M->TOT_0005 PICTURE "@Z 9999999999.99"
@ M->LI_NHA+2,01 SAY REPL("*",115)
RODAPE(62,01,115)

FUNCTION RFU04001
RETURN COMPRA-VENDA

FUNCTION RFU04002
RETURN COMPRA-(VENDA+PGO_F_PEGA)

* Final do programa MONTER04.PRG

* Final MONTER04.PRG
 
* Final MONTER04.PRG