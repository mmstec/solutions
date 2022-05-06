
* TITULO     :  Recupera‡„o de Inadiplencia
* DATA       : 28/02/97
* PROGRAMA   : NAOPGR01.PRG
* COMENTARIO : RELATORIO (1.Inadiplentes)
 
**
** Bloco de inser‡„o R01.B01
**
MENSAGEM("Aguarde abertura de arquivos")
SELE 1
IF .NOT. USEREDE("VEND_NPG",.F.,10)
   BEEP()
   MENSAGEM("O arquivo VEND_NPG n„o est  dispon¡vel",3)
   RETURN
ELSE
   SET INDEX TO VEND_001,VEND_002,VEND_003
ENDIF
***
*** Inicio do bloco de substitui‡„o R01.B
MENSAGEM("Tecle <ESC> para retornar")
COR("MENU")
@ LIN_MENU,00
@ LIN_MENU,01 SAY "Relat¢rio ³ 1.Inadiplentes"
SELE 1
SET ORDER TO 2
**
** Bloco de inser‡„o R01.B02
**
GOTO TOP
*
* -> Inicializa variaveis para filtragem
M->FILTRO_1=SPACE(1)
JANELA( 8,29,16,53)
COR("MENU")
@ 11,33 CLEAR TO 13,49
**
** Bloco de inser‡„o R01.B03
**
DO WHILE .T.
   **
   ** Bloco de inser‡„o R01.B04
   **
   @ 12,36 SAY "Vendedor:" GET M->FILTRO_1
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
IF .NOT. MENU_PRN("NAOPG_01")
   RESTSCREEN(LIN_MENU+1,00,23,79,TELA_PRI)
   RETURN
ENDIF
SET FILTER TO PAGO_NAOPG = CTOD('  /  /  ')
IF .NOT.(PAGO_NAOPG = CTOD('  /  /  '))
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
   IF .NOT.(VENDEDOR=M->FILTRO_1)
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
         @ 00,01 SAY CHR(15)
      ENDIF
      M->CAB_1="* MFB Materiais de Constru‡„o Ltda *"
      M->CAB_2="***** RELACAO DE INADIPLENCIA ******"
      **
      ** Bloco de inser‡„o R01.B22
      **
      @ 01,01 SAY M->CAB_1
      @ 01, 96 SAY "Pagina: "+SUBS(STR(M->PAG+10000,5),2)
      M->PAG=M->PAG+1
      @ 02,01 SAY M->CAB_2
      @ 02, 96 SAY "Data: "+DTOC(DATE())
      @ 04,01 SAY "Vendedor Resp. No.:"
      @ 04,021 SAY FILTRO_1
      @ 06,01 SAY REPL("-",109)
      @ 07,001 SAY "Documento"
      @ 07,012 SAY "Cliente"
      @ 07,043 SAY "R$ S/Juros"
      @ 07,056 SAY "R$ C/Juros"
      @ 07,069 SAY "R$ Cimento"
      @ 08,01 SAY REPL("-",109)
      M->LI_NHA=09
      **
      ** Bloco de inser‡„o R01.B10
      **
   ENDIF
   **
   ** Bloco de inser‡„o R01.B20
   **
   @ M->LI_NHA,001 SAY DOCUMENTO
   @ M->LI_NHA,012 SAY CLIENTE
   @ M->LI_NHA,043 SAY VALORSJURO PICTURE "@E 9,999,999.99"
   @ M->LI_NHA,056 SAY VALORCJURO PICTURE "@E 9,999,999.99"
   @ M->LI_NHA,069 SAY CIMENTO PICTURE "@E 9,999,999.99"
   @ M->LI_NHA,082 SAY RFU01001()
   @ M->LI_NHA,109 SAY VENDEDOR
   **
   ** Bloco de inser‡„o R01.B21
   **
   *
   * -> Totalizacao de campo numericos
   M->TOT_0001=M->TOT_0001+VALORSJURO
   M->TOT_0002=M->TOT_0002+VALORCJURO
   M->TOT_0003=M->TOT_0003+CIMENTO
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
SET FILTER TO 
IF M->TIPO_PRN = "A"
   SET PRINTER TO
ELSEIF M->TIPO_PRN = "T" .AND. M->SAI_DA="S"
   SET PRINTER TO
   IMP_TELA("NAOPG_01",110)
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
@ M->LI_NHA+0,01 SAY REPL("-",109)
IF PAR1=2
   @ M->LI_NHA+1,001 SAY "TOTAL"
ELSE
   @ M->LI_NHA+1,001 SAY "SUBTOTAL"
ENDIF
@ M->LI_NHA+1,041 SAY M->TOT_0001 PICTURE "@E 999,999,999.99"
@ M->LI_NHA+1,054 SAY M->TOT_0002 PICTURE "@E 999,999,999.99"
@ M->LI_NHA+1,067 SAY M->TOT_0003 PICTURE "@E 999,999,999.99"
@ M->LI_NHA+2,01 SAY REPL("-",109)
 
FUNCTION RFU01001
IF VENDEDOR = "1"
   RETURN "Responsavel: Lourildo"+SPACE(5)
ELSEIF VENDEDOR = "2"
   RETURN "Responsavel: Marcio"+SPACE(7)
ELSEIF VENDEDOR = "3"
   RETURN "Responsavel: Marcia"+SPACE(7)
ELSEIF VENDEDOR = "4"
   RETURN "Responsavel: Miguel"+SPACE(7)
ELSEIF VENDEDOR = "5"
   RETURN "Responsavel: (a verificar)"
ENDIF
 
* Final do programa NAOPGR01.PRG