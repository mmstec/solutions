
* TITULO     : MFB - CONTROLE DE VENDAS
* DATA       : 12/05/97
* PROGRAMA   : MFBR03.PRG
* COMENTARIO : RELATORIO ( 2. Quitados)
 
**
** Bloco de inser‡„o R03.B01
**
MENSAGEM("Aguarde abertura de arquivos")
SELE 1
IF .NOT. USEREDE("CIMENTO",.F.,10)
   BEEP()
   MENSAGEM("O arquivo CIMENTO n„o est  dispon¡vel",3)
   RETURN
ELSE
   SET INDEX TO CIMEN001,CIMEN002,CIMEN003
ENDIF
***
*** Inicio do bloco de substitui‡„o R03.B
MENSAGEM("Tecle <ESC> para retornar")
COR("MENU")
@ LIN_MENU,00
@ LIN_MENU,01 SAY "Relat¢rio ³  2. Quitados"
SELE 1
SET ORDER TO 1
**
** Bloco de inser‡„o R03.B02
**
GOTO TOP
*
* -> Inicializa variaveis para filtragem
M->FILTRO_2=CTOD("  /  /  ")
M->FILTRO_3=CTOD("  /  /  ")
JANELA( 7,21,17,60)
COR("MENU")
@ 10,25 CLEAR TO 14,56
**
** Bloco de inser‡„o R03.B03
**
   **
   ** Bloco de inser‡„o R03.B04
   **
@ 11,28 SAY "Pagamentos de   :" GET M->FILTRO_2
@ 13,28 SAY "Ate           :" GET M->FILTRO_3
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
IF .NOT. MENU_PRN("MFB_03")
   RESTSCREEN(LIN_MENU+1,00,23,79,TELA_PRI)
   RETURN
ENDIF
SET FILTER TO PAGAMENTO>=M->FILTRO_2 .AND. PAGAMENTO<=M->FILTRO_3 .AND. Pagamento>CTOD('  /  /  ')
IF .NOT.(PAGAMENTO>=M->FILTRO_2 .AND. PAGAMENTO<=M->FILTRO_3 .AND. Pagamento>CTOD('  /  /  '))
   SKIP
ENDIF
SET DEVI TO PRINT
M->LI_NHA=1
M->PAG=1
*
* -> Inicializa variaveis de totalizacao
M->TOT_0001=0
M->TOT_0002=0
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
      M->CAB_1="*** M.F.B. Material de Construcao Ltda ***"
      M->CAB_2="** Relatorio do Cimento Pago no Periodo **"
      **
      ** Bloco de inser‡„o R03.B22
      **
      @ 00,001 SAY "IMPRESSAO: "+RTRIM(M->OPERADOR)
      @ 01,01 SAY M->CAB_1
      @ 01,110 SAY "Pagina: "+SUBS(STR(M->PAG+10000,5),2)
      M->PAG=M->PAG+1
      @ 02,01 SAY M->CAB_2
      @ 02,110 SAY "Data: "+DTOC(DATE())
      @ 04,01 SAY "Pagamentos de   :"
      @ 04,019 SAY FILTRO_2
      @ 05,01 SAY "Ate           :"
      @ 05,017 SAY FILTRO_3
      @ 07,01 SAY REPL("-",123)
      @ 08,001 SAY "Cliente"
      @ 08,032 SAY "Documento"
      @ 08,043 SAY "Qde Sacos"
      @ 08,054 SAY "Total"
      @ 08,067 SAY "Dta Vend"
      @ 08,076 SAY "Dta Venc"
      @ 08,085 SAY "Dta Pag."
      @ 08,094 SAY "Observacoes"
      @ 09,01 SAY REPL("-",123)
      M->LI_NHA=10
      **
      ** Bloco de inser‡„o R03.B10
      **
   ENDIF
   **
   ** Bloco de inser‡„o R03.B20
   **
   @ M->LI_NHA,001 SAY CLIENTE
   @ M->LI_NHA,032 SAY DOCUMENT
   @ M->LI_NHA,043 SAY QUANT_SACO PICTURE "@Z 9999999.99"
   @ M->LI_NHA,054 SAY TOTAL PICTURE "@Z 9,999,999.99"
   @ M->LI_NHA,067 SAY VENDA
   @ M->LI_NHA,076 SAY VENCIMENTO
   @ M->LI_NHA,085 SAY PAGAMENTO
   @ M->LI_NHA,094 SAY OBSERVACAO
   **
   ** Bloco de inser‡„o R03.B21
   **
   *
   * -> Totalizacao de campo numericos
   M->TOT_0001=M->TOT_0001+QUANT_SACO
   M->TOT_0002=M->TOT_0002+TOTAL
   M->LI_NHA=M->LI_NHA+1
   **
   ** Bloco de inser‡„o R03.B12
   **
   SKIP
   IF M->LI_NHA>58 .OR. EOF()
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
   IMP_TELA("MFB_03",124)
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
   M->LI_NHA=59
ENDIF
@ M->LI_NHA+0,01 SAY REPL("-",123)
IF PAR1=2
   @ M->LI_NHA+1,001 SAY "TOTAL"
ELSE
   @ M->LI_NHA+1,001 SAY "SUBTOTAL"
ENDIF
@ M->LI_NHA+1,041 SAY M->TOT_0001 PICTURE "@Z 999999999.99"
@ M->LI_NHA+1,052 SAY M->TOT_0002 PICTURE "@Z 999,999,999.99"
@ M->LI_NHA+2,01 SAY REPL("-",123)
 
* Final do programa MFBR03.PRG
