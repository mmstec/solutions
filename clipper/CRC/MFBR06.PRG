
* TITULO     : MFB - CONTROLE DE VENDAS
* DATA       : 12/05/97
* PROGRAMA   : MFBR06.PRG
* COMENTARIO : RELATORIO ( 2. PFG entregues)
 
**
** Bloco de inser‡„o R06.B01
**
MENSAGEM("Aguarde abertura de arquivos")
SELE 3
IF .NOT. USEREDE("PAGOFP",.F.,10)
   BEEP()
   MENSAGEM("O arquivo PAGOFP n„o est  dispon¡vel",3)
   RETURN
ELSE
   SET INDEX TO PAGOF006,PAGOF007,PAGOF008
ENDIF
***
*** Inicio do bloco de substitui‡„o R06.B
MENSAGEM("Tecle <ESC> para retornar")
COR("MENU")
@ LIN_MENU,00
@ LIN_MENU,01 SAY "Relat¢rio ³  2. PFG entregues"
SELE 3
SET ORDER TO 2
**
** Bloco de inser‡„o R06.B02
**
GOTO TOP
*
* -> Inicializa variaveis para filtragem
M->FILTRO_1=CTOD("  /  /  ")
M->FILTRO_2=CTOD("  /  /  ")
JANELA( 7,20,17,61)
COR("MENU")
@ 10,24 CLEAR TO 14,57
**
** Bloco de inser‡„o R06.B03
**
   **
   ** Bloco de inser‡„o R06.B04
   **
@ 11,27 SAY "CPFG Entregue de  :" GET M->FILTRO_1
@ 13,27 SAY "Ate               :" GET M->FILTRO_2
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
IF .NOT. MENU_PRN("MFB_06")
   RESTSCREEN(LIN_MENU+1,00,23,79,TELA_PRI)
   RETURN
ENDIF
SET FILTER TO ENTREGA>=M->FILTRO_1 .AND. ENTREGA<=M->FILTRO_2 .AND. ENTREGA>CTOD('  /  /  ')
IF .NOT.(ENTREGA>=M->FILTRO_1 .AND. ENTREGA<=M->FILTRO_2 .AND. ENTREGA>CTOD('  /  /  '))
   SKIP
ENDIF
SET DEVI TO PRINT
M->LI_NHA=1
M->PAG=1
*
* -> Inicializa variaveis de totalizacao
M->TOT_0001=0
M->TOT_0002=0
M->TOT_0003=0
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
      M->CAB_1="*** MFB Materiais de Construcao Ltda. ***"
      M->CAB_2="*** Cimento Pago falta pegar ENTREGUE ***"
      **
      ** Bloco de inser‡„o R06.B22
      **
      @ 00,001 SAY "IMPRESSAO: "+RTRIM(M->OPERADOR)
      @ 01,01 SAY M->CAB_1
      @ 01,123 SAY "Pagina: "+SUBS(STR(M->PAG+10000,5),2)
      M->PAG=M->PAG+1
      @ 02,01 SAY M->CAB_2
      @ 02,123 SAY "Data: "+DTOC(DATE())
      @ 04,01 SAY "CPFP Entregue de  :"
      @ 04,021 SAY FILTRO_1
      @ 05,01 SAY "ate               :"
      @ 05,021 SAY FILTRO_2
      @ 07,01 SAY REPL("-",136)
      @ 08,001 SAY "Dt Entr."
      @ 08,010 SAY "Dt Pag."
      @ 08,019 SAY "Dt Venda"
      @ 08,028 SAY "Cliente"
      @ 08,059 SAY "Documento"
      @ 08,070 SAY "R$ Unit."
      @ 08,083 SAY "Quant. SC"
      @ 08,094 SAY "R$ Pago"
      @ 08,107 SAY "Consideracoes"
      @ 09,01 SAY REPL("-",136)
      M->LI_NHA=10
      **
      ** Bloco de inser‡„o R06.B10
      **
   ENDIF
   **
   ** Bloco de inser‡„o R06.B20
   **
   @ M->LI_NHA,001 SAY ENTREGA
   @ M->LI_NHA,010 SAY PAGAMENTO
   @ M->LI_NHA,019 SAY VENDA
   @ M->LI_NHA,028 SAY CLIENTE
   @ M->LI_NHA,059 SAY DOCUMENT
   @ M->LI_NHA,070 SAY RS_UNITARI PICTURE "@E 9,999,999.99"
   @ M->LI_NHA,083 SAY QUANT_SACO PICTURE "@E 9999999.99"
   @ M->LI_NHA,094 SAY TOTAL PICTURE "@E 9,999,999.99"
   @ M->LI_NHA,107 SAY OBSERVACAO
   **
   ** Bloco de inser‡„o R06.B21
   **
   *
   * -> Totalizacao de campo numericos
   M->TOT_0001=M->TOT_0001+RS_UNITARI
   M->TOT_0002=M->TOT_0002+QUANT_SACO
   M->TOT_0003=M->TOT_0003+TOTAL
   M->LI_NHA=M->LI_NHA+1
   **
   ** Bloco de inser‡„o R06.B12
   **
   SKIP
   IF M->LI_NHA>58 .OR. EOF()
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
   IMP_TELA("MFB_06",137)
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
   M->LI_NHA=59
ENDIF
@ M->LI_NHA+0,01 SAY REPL("-",136)
IF PAR1=2
   @ M->LI_NHA+1,001 SAY "TOTAL"
ELSE
   @ M->LI_NHA+1,001 SAY "SUBTOTAL"
ENDIF
@ M->LI_NHA+1,068 SAY M->TOT_0001 PICTURE "@E 999,999,999.99"
@ M->LI_NHA+1,081 SAY M->TOT_0002 PICTURE "@E 999999999.99"
@ M->LI_NHA+1,092 SAY M->TOT_0003 PICTURE "@E 999,999,999.99"
@ M->LI_NHA+2,01 SAY REPL("-",136)
 
* Final do programa MFBR06.PRG