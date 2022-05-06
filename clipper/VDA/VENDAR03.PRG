

* TITULO     :  MFB - Vendas Comissisionadas e Gerais
* DATA       : 12/04/97
* PROGRAMA   : VENDAR03.PRG
* COMENTARIO : RELATORIO ( * Comissao do grupo  B)

**
** Bloco de inser‡„o R03.B01
**
MENSAGEM("Aguarde abertura de arquivos")
SELE 2
IF .NOT. USEREDE("GRUP5678",.F.,10)
   BEEP()
   MENSAGEM("O arquivo GRUP5678 n„o est  dispon¡vel",3)
   RETURN
ELSE
   SET INDEX TO GRUP5002
ENDIF
***
*** Inicio do bloco de substitui‡„o R03.B
MENSAGEM("Tecle <ESC> para retornar")
COR("MENU")
@ LIN_MENU,00
@ LIN_MENU,01 SAY "Relat¢rio ³  * Comissao do grupo  B"
SELE 2
SET ORDER TO 1
**
** Bloco de inser‡„o R03.B02
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
** Bloco de inser‡„o R03.B03
**
   **
   ** Bloco de inser‡„o R03.B04
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
IF .NOT. MENU_PRN("VENDA_03")
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
M->TOT_0006=0
M->TOT_0007=0
M->TOT_0008=0
M->TOT_0009=0
M->TOT_0010=0
*
* -> Inicializa variaveis de subtotalizacao de quebra por DATA
M->TO3_0001=0
M->TO3_0002=0
M->TO3_0003=0
M->TO3_0004=0
M->TO3_0005=0
M->TO3_0006=0
M->TO3_0007=0
M->TO3_0008=0
**
** Bloco de inser‡„o R03.B05
**
M->SAI_DA="S"
*** Final do bloco de substitui‡„o R03.B
***
DO WHILE .NOT. EOF()
   **
   ** Bloco de inser‡„o R03.B06
   **
   IF INKEY()=27
      **
      ** Bloco de inser‡„o R03.B07
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
      ** Bloco de inser‡„o R03.B09
      **
      *
      * -> Determina o tipo de caracter para impressao
      IF TIPO_PRN<>"T"
         @ 00,01 SAY CHR(15)
      ENDIF
      M->CAB_1="MFB MATERIL DE CONSTRUCAO LTDA"
      M->CAB_2="**** COMISSAO DO GRUPO B *****"
      **
      ** Bloco de inser‡„o R03.B22
      **
      @ 00,001 SAY PADL("OPERADOR: "+RTRIM(M->OPERADOR),129)
      @ 01,01 SAY M->CAB_1
      @ 01,117 SAY "Pagina: "+SUBS(STR(M->PAG+10000,5),2)
      M->PAG=M->PAG+1
      @ 02,01 SAY M->CAB_2
      @ 02,117 SAY "Data: "+DTOC(DATE())
      @ 04,01 SAY "PERIODO DE....:"
      @ 04,017 SAY FILTRO_1
      @ 05,01 SAY "ATE...........:"
      @ 05,017 SAY FILTRO_2
      @ 07,001 SAY REPL("*",131)
      @ 08,001 SAY PADC("* RELATORIO DE COMISSOES DIARIAS POR VENDEDOR *",129)
      @ 09,001 SAY "DATA  DE"
      @ 09,010 SAY "-----------------------< VENDEDORES >-------------------------"
      @ 09,075 SAY "--------------------------< COMISSOES >------------------"
      @ 10,001 SAY "INCLUSAO"
      @ 10,014 SAY "VENDEDOR - 5"
      @ 10,029 SAY "VENDEDOR - 6"
      @ 10,044 SAY "VENDEDOR - 7"
      @ 10,059 SAY "VENDEDOR - 8"
      @ 10,074 SAY "COMISSAO - 5"
      @ 10,089 SAY "COMISSAO - 6"
      @ 10,104 SAY "COMISSAO - 7"
      @ 10,119 SAY "COMISSAO - 8"
      @ 11,01 SAY REPL("*",130)
      @ 13,01 SAY "MOVIMENTO DO MES"
      @ 13,018 SAY MES_ANO(M->QUEBRA_3)
      M->LI_NHA=15
      **
      ** Bloco de inser‡„o R03.B10
      **
   ENDIF
   **
   ** Bloco de inser‡„o R03.B20
   **
   @ M->LI_NHA,001 SAY DATA
   @ M->LI_NHA,014 SAY VENDAS05 PICTURE "@Z 9,999,999.99"
   @ M->LI_NHA,029 SAY VENDAS06 PICTURE "@Z 9,999,999.99"
   @ M->LI_NHA,044 SAY VENDAS07 PICTURE "@Z 9,999,999.99"
   @ M->LI_NHA,059 SAY VENDAS08 PICTURE "@Z 9,999,999.99"
   @ M->LI_NHA,074 SAY RFU03001() PICTURE "@Z 9,999,999.99"
   @ M->LI_NHA,089 SAY RFU03002() PICTURE "@Z 9,999,999.99"
   @ M->LI_NHA,104 SAY RFU03003() PICTURE "@Z 9,999,999.99"
   @ M->LI_NHA,119 SAY RFU03004() PICTURE "@Z 9,999,999.99"
   **
   ** Bloco de inser‡„o R03.B21
   **
   *
   * -> Totalizacao de campo numericos
   M->TOT_0001=M->TOT_0001+VENDAS05
   M->TOT_0002=M->TOT_0002+VENDAS06
   M->TOT_0003=M->TOT_0003+VENDAS07
   M->TOT_0004=M->TOT_0004+VENDAS08
   M->TOT_0005=M->TOT_0005+RFU03001()
   M->TOT_0006=M->TOT_0006+RFU03002()
   M->TOT_0007=M->TOT_0007+RFU03003()
   M->TOT_0008=M->TOT_0008+RFU03004()
   M->TOT_0009=M->TOT_0009+RFU03005()
   M->TOT_0010=M->TOT_0010+RFU03006()
   *
   * -> Subtotalizacao de quebra por DATA
   M->TO3_0001=M->TO3_0001+VENDAS05
   M->TO3_0002=M->TO3_0002+VENDAS06
   M->TO3_0003=M->TO3_0003+VENDAS07
   M->TO3_0004=M->TO3_0004+VENDAS08
   M->TO3_0005=M->TO3_0005+RFU03001()
   M->TO3_0006=M->TO3_0006+RFU03002()
   M->TO3_0007=M->TO3_0007+RFU03003()
   M->TO3_0008=M->TO3_0008+RFU03004()
   M->LI_NHA=M->LI_NHA+1
   **
   ** Bloco de inser‡„o R03.B12
   **
   SKIP
   IF M->QUEBRA_3<>MES_ANO(DATA)
      **
      ** Bloco de inser‡„o R03.B15
      **
      *
      * -> Imprime subtotalizacao da quebra
      @ M->LI_NHA+0,010 SAY REPL("-",120)
      @ M->LI_NHA+0,001 SAY "TOTAL"
      @ M->LI_NHA+1,001 SAY "DO MES"
      @ M->LI_NHA+1,012 SAY M->TO3_0001 PICTURE "@Z 999,999,999.99"
      @ M->LI_NHA+1,027 SAY M->TO3_0002 PICTURE "@Z 999,999,999.99"
      @ M->LI_NHA+1,042 SAY M->TO3_0003 PICTURE "@Z 999,999,999.99"
      @ M->LI_NHA+1,057 SAY M->TO3_0004 PICTURE "@Z 999,999,999.99"
      @ M->LI_NHA+1,072 SAY M->TO3_0005 PICTURE "@Z 999,999,999.99"
      @ M->LI_NHA+1,087 SAY M->TO3_0006 PICTURE "@Z 999,999,999.99"
      @ M->LI_NHA+1,102 SAY M->TO3_0007 PICTURE "@Z 999,999,999.99"
      @ M->LI_NHA+1,117 SAY M->TO3_0008 PICTURE "@Z 999,999,999.99"
      M->LI_NHA=M->LI_NHA+2
      *
      * -> Inicializa variaveis de subtotalizacao de quebra por DATA
      M->TO3_0001=0
      M->TO3_0002=0
      M->TO3_0003=0
      M->TO3_0004=0
      M->TO3_0005=0
      M->TO3_0006=0
      M->TO3_0007=0
      M->TO3_0008=0
      M->QUEBRA_3=MES_ANO(DATA)
      M->LI_NHA=47
   ENDIF
   IF M->LI_NHA>46 .OR. EOF()
      IF EOF()
         TOT_03(2)
      ELSE
         TOT_03(1)
      ENDIF
      M->LI_NHA=1
   ENDIF
ENDDO
**
** Bloco de inser‡„o R03.B18
**
EJECT
SET DEVI TO SCREEN
SET FILTER TO
IF M->TIPO_PRN = "A"
   SET PRINTER TO
ELSEIF M->TIPO_PRN = "T" .AND. M->SAI_DA="S"
   SET PRINTER TO
   IMP_TELA("VENDA_03",131)
ENDIF
**
** Bloco de inser‡„o R03.B19
**
RESTSCREEN(LIN_MENU+1,00,23,79,TELA_PRI)

FUNCTION TOT_03
*
* -> Funcao de impressao da totalizacao
PARA PAR1
IF PAR1=2
   M->LI_NHA=47
ENDIF
@ M->LI_NHA+0,001 SAY REPL("*",129)
@ 048,001 SAY PADC("* RELATORIO DE COMISSAO TOTALIZADO POR VENDEDOR *",129)
IF PAR1=2
   @ 048,001 SAY "TOTAL SUMARIZADO"
ELSE
   @ 048,001 SAY "SUBTOTAL SUMARIZADO"
ENDIF
@ 050,001 SAY "---------< VENDEDORES >----------"
@ 050,040 SAY "---------< COMISSOES >------------"
@ 050,085 SAY "-< Observacoes >----------------------------"
@ 051,001 SAY "VALDIR......5: ";@ 051,020 SAY M->TOT_0001 PICTURE "@Z 999,999,999.99";@ 051,040 SAY "COMISSAO - 05 :";@ 051,060 SAY M->TOT_0005 PICTURE "@Z 999,999,999.99";@ 51,085 SAY "PERIODO DE "+DTOC(FILTRO_1)+" ATE "+DTOC(FILTRO_2)
@ 052,001 SAY "VENDEDOR....6: ";@ 052,020 SAY M->TOT_0002 PICTURE "@Z 999,999,999.99";@ 052,040 SAY "COMISSAO - 06 :";@ 052,060 SAY M->TOT_0006 PICTURE "@Z 999,999,999.99"
@ 053,001 SAY "VENDEDOR....7: ";@ 053,020 SAY M->TOT_0003 PICTURE "@Z 999,999,999.99";@ 053,040 SAY "COMISSAO - 07 :";@ 053,060 SAY M->TOT_0007 PICTURE "@Z 999,999,999.99"
@ 054,001 SAY "VENDEDOR....8: ";@ 054,020 SAY M->TOT_0004 PICTURE "@Z 999,999,999.99";@ 054,040 SAY "COMISSAO - 08 :";@ 054,060 SAY M->TOT_0008 PICTURE "@Z 999,999,999.99"
@ 055,001 SAY "----------------------------------";@ 055,040 SAY "----------------------------------"
@ 056,001 SAY "TOTAL VENDAS.: ";@ 056,020 SAY M->TOT_0009 PICTURE "@Z 999,999,999.99";@ 056,040 SAY "TOTAL COMISSAO:";@ 056,060 SAY M->TOT_0010 PICTURE "@Z 999,999,999.99"
@ 057,001 SAY REPL("*",129)
RODAPE(60,01,129)

FUNCTION RFU03001
RETURN (VENDAS05*TAXA0005)/100

FUNCTION RFU03002
RETURN (VENDAS06*TAXA0006)/100

FUNCTION RFU03003
RETURN (VENDAS07*TAXA0007)/100

FUNCTION RFU03004
RETURN (VENDAS08*TAXA0008)/100

FUNCTION RFU03005
RETURN VENDAS05+VENDAS06+VENDAS07+VENDAS08

FUNCTION RFU03006
RETURN (VENDAS05*TAXA0005)/100+(VENDAS06*TAXA0006)/100+(VENDAS07*TAXA0007)/100+(VENDAS08*TAXA0008)/100

* Final do programa VENDAR03.PRG

*
* -> Funcao de impressao da totalizacao

 
* Final VENDAR03.PRG