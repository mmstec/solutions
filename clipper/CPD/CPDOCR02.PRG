
* TITULO     :  Sistema de Contas a Pagar
* DATA       : 25/04/97
* PROGRAMA   : CPDOCR02.PRG
* COMENTARIO : RELATORIO ( 1.Duplicatas a pagar)
 
**
** Bloco de inser‡„o R02.B01
**
MENSAGEM("Aguarde abertura de arquivos")
SELE 1
IF .NOT. USEREDE("CPDOC",.F.,10)
   BEEP()
   MENSAGEM("O arquivo CPDOC n„o est  dispon¡vel",3)
   RETURN
ELSE
   SET INDEX TO CPDOC001,CPDOC002,CPDOC003
ENDIF
***
*** Inicio do bloco de substitui‡„o R02.B
MENSAGEM("Tecle <ESC> para retornar")
COR("MENU")
@ LIN_MENU,00
@ LIN_MENU,01 SAY "Relat¢rio ³  1.Duplicatas a pagar"
SELE 1
SET ORDER TO 2
**
** Bloco de inser‡„o R02.B02
**
GOTO TOP
*
* -> Inicializa variaveis para filtragem
M->FILTRO_1=CTOD("  /  /  ")
M->FILTRO_2=CTOD("  /  /  ")
JANELA( 7,18,17,63)
COR("MENU")
@ 10,22 CLEAR TO 14,59
**
** Bloco de inser‡„o R02.B03
**
   **
   ** Bloco de inser‡„o R02.B04
   **
@ 11,25 SAY "Duplicatas a pagar de :" GET M->FILTRO_1
@ 13,25 SAY "Ate                   :" GET M->FILTRO_2
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
IF .NOT. MENU_PRN("CPDOC_02")
   RESTSCREEN(LIN_MENU+1,00,23,79,TELA_PRI)
   RETURN
ENDIF
SET FILTER TO VENCIMENTO>=M->FILTRO_1 .AND. VENCIMENTO<=M->FILTRO_2 .AND. Pagamento=CTOD('  /  /  ')
IF .NOT.(VENCIMENTO>=M->FILTRO_1 .AND. VENCIMENTO<=M->FILTRO_2 .AND. Pagamento=CTOD('  /  /  '))
   SKIP
ENDIF
SET DEVI TO PRINT
M->LI_NHA=1
M->PAG=1
*
* -> Inicializa variaveis de totalizacao
M->TOT_0001=0
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
      M->CAB_1="        M.F.B.Materiais de Construcao Ltda"
      M->CAB_2="CGC 34.196.147/000-10 - Insc. Estadual 28.956.505"
      **
      ** Bloco de inser‡„o R02.B22
      **
      @ 00,001 SAY "IMPRESSAO: "+RTRIM(M->OPERADOR)
      @ 01,01 SAY M->CAB_1
      @ 01, 81 SAY "Pagina: "+SUBS(STR(M->PAG+10000,5),2)
      M->PAG=M->PAG+1
      @ 02,01 SAY M->CAB_2
      @ 02, 81 SAY "Data: "+DTOC(DATE())
      @ 04,01 SAY "Duplicatas a pagar de :"
      @ 04,025 SAY FILTRO_1
      @ 05,01 SAY "Ate                   :"
      @ 05,025 SAY FILTRO_2
      @ 07,01 SAY REPL("-", 94)
      @ 08,001 SAY "Dta Venc"
      @ 08,010 SAY "Numero"
      @ 08,021 SAY "Cedente"
      @ 08,052 SAY "       Valor"
      @ 08,065 SAY "Historico"
      @ 09,01 SAY REPL("-", 94)
      M->LI_NHA=10
      **
      ** Bloco de inser‡„o R02.B10
      **
   ENDIF
   **
   ** Bloco de inser‡„o R02.B20
   **
   @ M->LI_NHA,001 SAY VENCIMENTO
   @ M->LI_NHA,010 SAY NUMERO
   @ M->LI_NHA,021 SAY CEDENTE
   @ M->LI_NHA,052 SAY VALOR PICTURE "@Z 9,999,999.99"
   @ M->LI_NHA,065 SAY HISTORICO
   **
   ** Bloco de inser‡„o R02.B21
   **
   *
   * -> Totalizacao de campo numericos
   M->TOT_0001=M->TOT_0001+VALOR
   M->LI_NHA=M->LI_NHA+1
   **
   ** Bloco de inser‡„o R02.B12
   **
   SKIP
   IF M->LI_NHA>58 .OR. EOF()
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
   IMP_TELA("CPDOC_02", 95)
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
   M->LI_NHA=59
ENDIF
@ M->LI_NHA+0,01 SAY REPL("-", 94)
IF PAR1=2
   @ M->LI_NHA+1,001 SAY "TOTAL"
ELSE
   @ M->LI_NHA+1,001 SAY "SUBTOTAL"
ENDIF
@ M->LI_NHA+1,050 SAY M->TOT_0001 PICTURE "@Z 999,999,999.99"
@ M->LI_NHA+2,01 SAY REPL("-", 94)
 
* Final do programa CPDOCR02.PRG