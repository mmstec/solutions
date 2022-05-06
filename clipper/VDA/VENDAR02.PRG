



* TITULO     :  MFB - Vendas Comissisionadas e Gerais
* DATA       : 12/04/97
* PROGRAMA   : VENDAR02.PRG
* COMENTARIO : RELATORIO ( * Comissao do grupo  A)

**
** Bloco de inser‡„o R02.B01
**
MENSAGEM("Aguarde abertura de arquivos")
SELE 1
IF .NOT. USEREDE("GRUP1234",.F.,10)
   BEEP()
   MENSAGEM("O arquivo GRUP1234 n„o est  dispon¡vel",3)
   RETURN
ELSE
   SET INDEX TO GRUP1001
ENDIF
***
*** Inicio do bloco de substitui‡„o R02.B
MENSAGEM("Tecle <ESC> para retornar")
COR("MENU")
@ LIN_MENU,00
@ LIN_MENU,01 SAY "Relat¢rio ³  * Comissao do grupo  A"
SELE 1
SET ORDER TO 1
**
** Bloco de inser‡„o R02.B02
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
** Bloco de inser‡„o R02.B03
**
   **
   ** Bloco de inser‡„o R02.B04
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
IF .NOT. MENU_PRN("VENDA_02")
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
** Bloco de inser‡„o R02.B05
**
M->SAI_DA="S"
*** Final do bloco de substitui‡„o R02.B
***
DO WHILE .NOT. EOF()
   **
   ** Bloco de inser‡„o R02.B06
   **
   IF INKEY()=27
      **
      ** Bloco de inser‡„o R02.B07
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
      ** Bloco de inser‡„o R02.B09
      **
      *
      * -> Determina o tipo de caracter para impressao
      IF TIPO_PRN<>"T"
         @ 00,01 SAY CHR(15)
      ENDIF
      M->CAB_1="MFB MATERIAL DE CONSTRUCAO LTDA"
      M->CAB_2="**** COMISSAO DO GRUPO A ******"
      **
      ** Bloco de inser‡„o R02.B22
      **
      @ 00,001 SAY PADL("OPERADOR: "+RTRIM(M->OPERADOR),131)
      @ 01,01 SAY M->CAB_1
      @ 01,118 SAY "Pagina: "+SUBS(STR(M->PAG+1000000,7),2)
      M->PAG=M->PAG+1
      @ 02,001 SAY M->CAB_2
      @ 02,118 SAY "Data: "+DTOC(DATE())
      @ 04,001 SAY "PERIODO DE....:"
      @ 04,017 SAY FILTRO_1
      @ 05,001 SAY "ATE ..........:"
      @ 05,017 SAY FILTRO_2
      @ 07,001 SAY PADC("MOVIMENTACAO DIARIA POR VENDEDOR",129)
      @ 09,010 SAY "--------------------< VENDAS POR VENDEDOR >--------------------"
      @ 09,075 SAY "----------------< COMISSOES POR VENDEDOR >----------------"
      @ 10,001 SAY "ENTRADA"
      @ 10,014 SAY "VENDEDOR - 1"
      @ 10,029 SAY "VENDEDOR - 2"
      @ 10,045 SAY "VENDEDOR - 3"
      @ 10,060 SAY "VENDEDOR - 4"
      @ 10,075 SAY "COMISSAO - 1"
      @ 10,090 SAY "COMISSAO - 2"
      @ 10,105 SAY "COMISSAO - 3"
      @ 10,120 SAY "COMISSAO - 4"
      @ 11,001 SAY REPL("*",131)
      @ 13,001 SAY "MOVIMENTO DO MES "+MES_ANO(M->QUEBRA_3)
      *@ 13,021 SAY 
      M->LI_NHA=14
      **
      ** Bloco de inser‡„o R02.B10
      **
   ENDIF
   **
   ** Bloco de inser‡„o R02.B20
   **
   @ M->LI_NHA,001 SAY DATA
   @ M->LI_NHA,014 SAY VENDAS01 PICTURE "@Z 9,999,999.99"
   @ M->LI_NHA,029 SAY VENDAS02 PICTURE "@Z 9,999,999.99"
   @ M->LI_NHA,045 SAY VENDAS03 PICTURE "@Z 9,999,999.99"
   @ M->LI_NHA,060 SAY VENDAS04 PICTURE "@Z 9,999,999.99"
   @ M->LI_NHA,075 SAY RFU02001() PICTURE "@Z 9,999,999.99"
   @ M->LI_NHA,090 SAY RFU02002() PICTURE "@Z 9,999,999.99"
   @ M->LI_NHA,105 SAY RFU02003() PICTURE "@Z 9,999,999.99"
   @ M->LI_NHA,120 SAY RFU02004() PICTURE "@Z 9,999,999.99"
   **
   ** Bloco de inser‡„o R02.B21
   **
   *
   * -> Totalizacao de campo numericos
   M->TOT_0001=M->TOT_0001+VENDAS01
   M->TOT_0002=M->TOT_0002+VENDAS02
   M->TOT_0003=M->TOT_0003+VENDAS03
   M->TOT_0004=M->TOT_0004+VENDAS04
   M->TOT_0005=M->TOT_0005+RFU02001()
   M->TOT_0006=M->TOT_0006+RFU02002()
   M->TOT_0007=M->TOT_0007+RFU02003()
   M->TOT_0008=M->TOT_0008+RFU02004()
   M->TOT_0009=M->TOT_0009+RFU02005()
   M->TOT_0010=M->TOT_0010+RFU02006()
   *
   * -> Subtotalizacao de quebra por DATA
   M->TO3_0001=M->TO3_0001+VENDAS01
   M->TO3_0002=M->TO3_0002+VENDAS02
   M->TO3_0003=M->TO3_0003+VENDAS03
   M->TO3_0004=M->TO3_0004+VENDAS04
   M->TO3_0005=M->TO3_0005+RFU02001()
   M->TO3_0006=M->TO3_0006+RFU02002()
   M->TO3_0007=M->TO3_0007+RFU02003()
   M->TO3_0008=M->TO3_0008+RFU02004()
   M->LI_NHA=M->LI_NHA+1
   **
   ** Bloco de inser‡„o R02.B12
   **
   SKIP
   IF M->QUEBRA_3<>MES_ANO(DATA)
      **
      ** Bloco de inser‡„o R02.B15
      **
      *
      * -> Imprime subtotalizacao da quebra
      @ M->LI_NHA+0,012 SAY REPL("-",14);@ M->LI_NHA+0,027 SAY REPL("-",14);@ M->LI_NHA+0,043 SAY REPL("-",14)
      @ M->LI_NHA+0,058 SAY REPL("-",14);@ M->LI_NHA+0,073 SAY REPL("-",14);@ M->LI_NHA+0,088 SAY REPL("-",14)
      @ M->LI_NHA+0,103 SAY REPL("-",14);@ M->LI_NHA+0,118 SAY REPL("-",14)
      @ M->LI_NHA+0,001 SAY "TOTAL"
      @ M->LI_NHA+1,001 SAY "DO MES"
      @ M->LI_NHA+1,012 SAY M->TO3_0001 PICTURE "@Z 999,999,999.99"
      @ M->LI_NHA+1,027 SAY M->TO3_0002 PICTURE "@Z 999,999,999.99"
      @ M->LI_NHA+1,043 SAY M->TO3_0003 PICTURE "@Z 999,999,999.99"
      @ M->LI_NHA+1,058 SAY M->TO3_0004 PICTURE "@Z 999,999,999.99"
      @ M->LI_NHA+1,073 SAY M->TO3_0005 PICTURE "@Z 999,999,999.99"
      @ M->LI_NHA+1,088 SAY M->TO3_0006 PICTURE "@Z 999,999,999.99"
      @ M->LI_NHA+1,103 SAY M->TO3_0007 PICTURE "@Z 999,999,999.99"
      @ M->LI_NHA+1,118 SAY M->TO3_0008 PICTURE "@Z 999,999,999.99"
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
   IF M->LI_NHA>56 .OR. EOF()
      IF EOF()
         TOT_02(2)
      ELSE
         TOT_02(1)
      ENDIF
      M->LI_NHA=1
   ENDIF
ENDDO
**
** Bloco de inser‡„o R02.B18
**
EJECT
SET DEVI TO SCREEN
SET FILTER TO
IF M->TIPO_PRN = "A"
   SET PRINTER TO
ELSEIF M->TIPO_PRN = "T" .AND. M->SAI_DA="S"
   SET PRINTER TO
   IMP_TELA("VENDA_02",132)
ENDIF
**
** Bloco de inser‡„o R02.B19
**
RESTSCREEN(LIN_MENU+1,00,23,79,TELA_PRI)

FUNCTION TOT_02
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
@ 051,001 SAY "LOURILDO.....: ";@ 051,020 SAY M->TOT_0001 PICTURE "@Z 999,999,999.99";@ 051,040 SAY "COMISSAO - 01 :";@ 051,060 SAY M->TOT_0005 PICTURE "@Z 999,999,999.99";@ 51,085 SAY "PERIODO DE "+DTOC(FILTRO_1)+" ATE "+DTOC(FILTRO_2)
@ 052,001 SAY "MARCIO.......: ";@ 052,020 SAY M->TOT_0002 PICTURE "@Z 999,999,999.99";@ 052,040 SAY "COMISSAO - 02 :";@ 052,060 SAY M->TOT_0006 PICTURE "@Z 999,999,999.99";@ 52,085 SAY "Responsavel / Relatorio: "+RTRIM(M->OPERADOR)
@ 053,001 SAY "MARCIA.......: ";@ 053,020 SAY M->TOT_0003 PICTURE "@Z 999,999,999.99";@ 053,040 SAY "COMISSAO - 03 :";@ 053,060 SAY M->TOT_0007 PICTURE "@Z 999,999,999.99"
@ 054,001 SAY "MIGUEL.......: ";@ 054,020 SAY M->TOT_0004 PICTURE "@Z 999,999,999.99";@ 054,040 SAY "COMISSAO - 04 :";@ 054,060 SAY M->TOT_0008 PICTURE "@Z 999,999,999.99"
@ 055,001 SAY "----------------------------------";@ 055,040 SAY "----------------------------------"
@ 056,001 SAY "TOTAL VENDAS.: ";@ 056,020 SAY M->TOT_0009 PICTURE "@Z 999,999,999.99";@ 056,040 SAY "TOTAL COMISSAO:";@ 056,060 SAY M->TOT_0010 PICTURE "@Z 999,999,999.99"
@ 057,001 SAY REPL("*",129)
RODAPE(60,01,129)

FUNCTION RFU02001
RETURN (VENDAS01*TAXA0001)/100

FUNCTION RFU02002
RETURN (VENDAS02*TAXA0002)/100

FUNCTION RFU02003
RETURN (VENDAS03*TAXA0003)/100

FUNCTION RFU02004
RETURN (VENDAS04*TAXA0004)/100

FUNCTION RFU02005
RETURN VENDAS01+VENDAS02+VENDAS03+VENDAS04

FUNCTION RFU02006
RETURN (VENDAS01*TAXA0001)/100+(VENDAS02*TAXA0002)/100+(VENDAS03*TAXA0003)/100+(VENDAS04*TAXA0004)/100

* Final do programa VENDAR02.PRG



* Final VENDAR02.PRG
 
* Final VENDAR02.PRG
