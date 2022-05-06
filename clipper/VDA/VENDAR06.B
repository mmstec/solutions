
* TITULO     :  MFB - Vendas Comissisionadas e Gerais
* DATA       : 12/04/97
* PROGRAMA   : VENDAR06.PRG
* COMENTARIO : RELATORIO ( * Venda pelo  CIMENTO)
 
**
** Bloco de inser‡„o R06.B01
**
MENSAGEM("Aguarde abertura de arquivos")
SELE 3
IF .NOT. USEREDE("VENDASCM",.F.,10)
   BEEP()
   MENSAGEM("O arquivo VENDASCM n„o est  dispon¡vel",3)
   RETURN
ELSE
   SET INDEX TO VENDA003
ENDIF
***
*** Inicio do bloco de substitui‡„o R06.B
MENSAGEM("Tecle <ESC> para retornar")
COR("MENU")
@ LIN_MENU,00
@ LIN_MENU,01 SAY "Relat¢rio ³  * Venda pelo  CIMENTO"
SELE 3
SET ORDER TO 1
**
** Bloco de inser‡„o R06.B02
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
** Bloco de inser‡„o R06.B03
**
   **
   ** Bloco de inser‡„o R06.B04
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
IF .NOT. MENU_PRN("VENDA_06")
   RESTSCREEN(LIN_MENU+1,00,23,79,TELA_PRI)
   RETURN
ENDIF
SET FILTER TO DATA______>=M->FILTRO_1 .AND. DATA______<=M->FILTRO_2
IF .NOT.(DATA______>=M->FILTRO_1 .AND. DATA______<=M->FILTRO_2)
   SKIP
ENDIF
SET DEVI TO PRINT
M->LI_NHA=1
M->PAG=1
*
* -> Inicializa variaveis de quebra
M->QUEBRA_3=MES_ANO(DATA______)
*
* -> Inicializa variaveis de totalizacao
M->TOT_0001=0
M->TOT_0002=0
M->TOT_0003=0
M->TOT_0004=0
M->TOT_0005=0
M->TOT_0006=0
*
* -> Inicializa variaveis de subtotalizacao de quebra por DATA______
M->TO3_0001=0
M->TO3_0002=0
M->TO3_0003=0
M->TO3_0004=0
M->TO3_0005=0
M->TO3_0006=0
**
** Bloco de inser‡„o R06.B05
**
M->SAI_DA="S"
*** Final do bloco de substitui‡„o R06.B
***
DO WHILE .NOT. EOF()
   **
   ** Bloco de inser‡„o R06.B06
   **
   IF INKEY()=27
      **
      ** Bloco de inser‡„o R06.B07
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
      ** Bloco de inser‡„o R06.B09
      **
      *
      * -> Determina o tipo de caracter para impressao
      IF TIPO_PRN<>"T"
         @ 00,01 SAY CHR(15)
      ENDIF
      M->CAB_1="MFB MATERIAL DE CONSTRUCAO LTDA"
      M->CAB_2="** VENDA DIARIA PELO CIMENTO **"
      **
      ** Bloco de inser‡„o R06.B22
      **
      @ 00,001 SAY PADL("USUARIO: "+RTRIM(M->OPERADOR),134)
      @ 01,01 SAY M->CAB_1
      @ 01,121 SAY "Pagina: "+SUBS(STR(M->PAG+1000000,7),2)
      M->PAG=M->PAG+1
      @ 02,01 SAY M->CAB_2
      @ 02,121 SAY "Data: "+DTOC(DATE())
      @ 04,01 SAY "PERIODO DE....:"
      @ 04,017 SAY FILTRO_1
      @ 05,01 SAY "ATE...........:"
      @ 05,017 SAY FILTRO_2
      @ 07,01 SAY REPL("*",134)
      @ 09,001 SAY "DATA  DE"
      @ 09,014 SAY "--------< MOVIMENTO EM ESPECIE >----------"
      @ 09,060 SAY "--< MOVIMENTO EM QUANTIDADE DE SACOS >---"
      @ 09,105 SAY "-< HISTORICO >---------------"
      @ 10,001 SAY "INCLUSAO"
      @ 10,014 SAY "FIADO  -  R$"
      @ 10,029 SAY "VISTA  -  R$"
      @ 10,044 SAY "RECEB. -  R$"
      @ 10,060 SAY "FIADO - SC"
      @ 10,075 SAY "VISTA - SC"
      @ 10,091 SAY "RECEB.- SC"
      @ 11,001 SAY REPL("*",134)
      @ 13,01 SAY "VENDA PELO CIMENTO DO MES "
      @ 13,029 SAY MES_ANO(M->QUEBRA_3)
      M->LI_NHA=15
      **
      ** Bloco de inser‡„o R06.B10
      **
   ENDIF
   **
   ** Bloco de inser‡„o R06.B20
   **
   @ M->LI_NHA,001 SAY DATA______
   @ M->LI_NHA,014 SAY FIADO_____ PICTURE "@Z 9,999,999.99"
   @ M->LI_NHA,029 SAY AVISTA____ PICTURE "@Z 9,999,999.99"
   @ M->LI_NHA,044 SAY RECEBIDO__ PICTURE "@Z 9,999,999.99"
   @ M->LI_NHA,060 SAY QDE_SCOS_F PICTURE "@Z 9999999.99"
   @ M->LI_NHA,075 SAY QDE_SCOS_V PICTURE "@Z 9999999.99"
   @ M->LI_NHA,091 SAY QDE_SCOS_R PICTURE "@Z 9999999.99"
   @ M->LI_NHA,105 SAY OBS_______
   **
   ** Bloco de inser‡„o R06.B21
   **
   *
   * -> Totalizacao de campo numericos
   M->TOT_0001=M->TOT_0001+FIADO_____
   M->TOT_0002=M->TOT_0002+AVISTA____
   M->TOT_0003=M->TOT_0003+RECEBIDO__
   M->TOT_0004=M->TOT_0004+QDE_SCOS_F
   M->TOT_0005=M->TOT_0005+QDE_SCOS_V
   M->TOT_0006=M->TOT_0006+QDE_SCOS_R
   *
   * -> Subtotalizacao de quebra por DATA______
   M->TO3_0001=M->TO3_0001+FIADO_____
   M->TO3_0002=M->TO3_0002+AVISTA____
   M->TO3_0003=M->TO3_0003+RECEBIDO__
   M->TO3_0004=M->TO3_0004+QDE_SCOS_F
   M->TO3_0005=M->TO3_0005+QDE_SCOS_V
   M->TO3_0006=M->TO3_0006+QDE_SCOS_R
   M->LI_NHA=M->LI_NHA+1
   **
   ** Bloco de inser‡„o R06.B12
   **
   SKIP
   IF M->QUEBRA_3<>MES_ANO(DATA______)
      **
      ** Bloco de inser‡„o R06.B15
      **
      *
      * -> Imprime subtotalizacao da quebra
      @ M->LI_NHA+0,01 SAY REPL("-",134)
      @ M->LI_NHA+1,001 SAY "TOTAL"
      @ M->LI_NHA+2,001 SAY "DO MES"
      @ M->LI_NHA+2,012 SAY M->TO3_0001 PICTURE "@Z 999,999,999.99"
      @ M->LI_NHA+2,027 SAY M->TO3_0002 PICTURE "@Z 999,999,999.99"
      @ M->LI_NHA+2,042 SAY M->TO3_0003 PICTURE "@Z 999,999,999.99"
      @ M->LI_NHA+2,058 SAY M->TO3_0004 PICTURE "@Z 999999999.99"
      @ M->LI_NHA+2,073 SAY M->TO3_0005 PICTURE "@Z 999999999.99"
      @ M->LI_NHA+2,089 SAY M->TO3_0006 PICTURE "@Z 999999999.99"
      M->LI_NHA=M->LI_NHA+3
      *
      * -> Inicializa variaveis de subtotalizacao de quebra por DATA______
      M->TO3_0001=0
      M->TO3_0002=0
      M->TO3_0003=0
      M->TO3_0004=0
      M->TO3_0005=0
      M->TO3_0006=0
      M->QUEBRA_3=MES_ANO(DATA______)
      M->LI_NHA=58
   ENDIF
   IF M->LI_NHA>57 .OR. EOF()
      IF EOF()
         TOT_06(2)
      ELSE
         TOT_06(1)
      ENDIF
      M->LI_NHA=1
   ENDIF
ENDDO
**
** Bloco de inser‡„o R06.B18
**
EJECT
SET DEVI TO SCREEN
SET FILTER TO 
IF M->TIPO_PRN = "A"
   SET PRINTER TO
ELSEIF M->TIPO_PRN = "T" .AND. M->SAI_DA="S"
   SET PRINTER TO
   IMP_TELA("VENDA_06",135)
ENDIF
**
** Bloco de inser‡„o R06.B19
**
RESTSCREEN(LIN_MENU+1,00,23,79,TELA_PRI)
 
FUNCTION TOT_06
*
* -> Funcao de impressao da totalizacao
PARA PAR1
IF PAR1=2
   M->LI_NHA=58
ENDIF
@ M->LI_NHA+0,01 SAY REPL("*",134)
IF PAR1=2
   @ M->LI_NHA+1,001 SAY "TOTAL"
   @ M->LI_NHA+2,001 SAY "GERAL"
ELSE
   @ M->LI_NHA+1,001 SAY "SUBTOTAL"
   @ M->LI_NHA+2,001 SAY "GERAL"
ENDIF
@ M->LI_NHA+2,012 SAY M->TOT_0001 PICTURE "@Z 999,999,999.99"
@ M->LI_NHA+2,027 SAY M->TOT_0002 PICTURE "@Z 999,999,999.99"
@ M->LI_NHA+2,042 SAY M->TOT_0003 PICTURE "@Z 999,999,999.99"
@ M->LI_NHA+2,058 SAY M->TOT_0004 PICTURE "@Z 999999999.99"
@ M->LI_NHA+2,073 SAY M->TOT_0005 PICTURE "@Z 999999999.99"
@ M->LI_NHA+2,089 SAY M->TOT_0006 PICTURE "@Z 999999999.99"
@ M->LI_NHA+3,01 SAY REPL("*",134)
 
* Final do programa VENDAR06.PRG
