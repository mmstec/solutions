
* TITULO     :  Recupera‡„o de Inadiplencia
* DATA       : 28/02/97
* PROGRAMA   : NAOPGR02.PRG
* COMENTARIO : RELATORIO (2.Pagamentos)
 
**
** Bloco de inser‡„o R02.B01
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
*** Inicio do bloco de substitui‡„o R02.B
MENSAGEM("Tecle <ESC> para retornar")
COR("MENU")
@ LIN_MENU,00
@ LIN_MENU,01 SAY "Relat¢rio ³ 2.Pagamentos"
SELE 1
SET ORDER TO 3
**
** Bloco de inser‡„o R02.B02
**
GOTO TOP
*
* -> Inicializa variaveis para filtragem
M->FILTRO_1=SPACE(1)
M->FILTRO_2=CTOD("  /  /  ")
M->FILTRO_3=CTOD("  /  /  ")
JANELA( 6,22,18,59)
COR("MENU")
@  9,26 CLEAR TO 15,55
**
** Bloco de inser‡„o R02.B03
**
   **
   ** Bloco de inser‡„o R02.B04
   **
@ 10,29 SAY "Vendedor      :" GET M->FILTRO_1
@ 12,29 SAY "Pagamento de  :" GET M->FILTRO_2
@ 14,29 SAY "Ate           :" GET M->FILTRO_3
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
IF .NOT. MENU_PRN("NAOPG_02")
   RESTSCREEN(LIN_MENU+1,00,23,79,TELA_PRI)
   RETURN
ENDIF
SET FILTER TO VENDEDOR=M->FILTRO_1 .AND. PAGO_NAOPG>=M->FILTRO_2 .AND. PAGO_NAOPG<=M->FILTRO_3 .AND. Pago_naopg > CTOD('  /  /  ')
IF .NOT.(VENDEDOR=M->FILTRO_1 .AND. PAGO_NAOPG>=M->FILTRO_2 .AND. PAGO_NAOPG<=M->FILTRO_3 .AND. Pago_naopg > CTOD('  /  /  '))
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
      M->CAB_1="MFB Materiais de Construcao Ltda."
      M->CAB_2="Relacao de Inadiplencia Quitada"
      **
      ** Bloco de inser‡„o R02.B22
      **
      @ 01,01 SAY M->CAB_1
      @ 01,110 SAY "Pagina: "+SUBS(STR(M->PAG+10000,5),2)
      M->PAG=M->PAG+1
      @ 02,01 SAY M->CAB_2
      @ 02,110 SAY "Data: "+DTOC(DATE())
      @ 04,01 SAY "Vendedor      :"
      @ 04,017 SAY FILTRO_1
      @ 05,01 SAY "Pagamento de  :"
      @ 05,017 SAY FILTRO_2
      @ 06,01 SAY "Ate           :"
      @ 06,017 SAY FILTRO_3
      @ 08,01 SAY REPL("-",123)
      @ 09,001 SAY "V."
      @ 09,003 SAY "Documento"
      @ 09,014 SAY "Cliente"
      @ 09,045 SAY "R$ S/Juro"
      @ 09,058 SAY "R$ C/Juro"
      @ 09,071 SAY "R$ Cimento"
      @ 09,084 SAY "Pagamento"
      @ 09,094 SAY "Observacao"
      @ 10,01 SAY REPL("-",123)
      M->LI_NHA=11
      **
      ** Bloco de inser‡„o R02.B10
      **
   ENDIF
   **
   ** Bloco de inser‡„o R02.B20
   **
   @ M->LI_NHA,001 SAY VENDEDOR
   @ M->LI_NHA,003 SAY DOCUMENTO
   @ M->LI_NHA,014 SAY CLIENTE
   @ M->LI_NHA,045 SAY VALORSJURO PICTURE "@E 9,999,999.99"
   @ M->LI_NHA,058 SAY VALORCJURO PICTURE "@E 9,999,999.99"
   @ M->LI_NHA,071 SAY CIMENTO PICTURE "@E 9,999,999.99"
   @ M->LI_NHA,084 SAY PAGO_NAOPG
   @ M->LI_NHA,094 SAY OBSERVACAO
   **
   ** Bloco de inser‡„o R02.B21
   **
   *
   * -> Totalizacao de campo numericos
   M->TOT_0001=M->TOT_0001+VALORSJURO
   M->TOT_0002=M->TOT_0002+VALORCJURO
   M->TOT_0003=M->TOT_0003+CIMENTO
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
   IMP_TELA("NAOPG_02",124)
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
@ M->LI_NHA+0,01 SAY REPL("-",123)
IF PAR1=2
   @ M->LI_NHA+1,001 SAY "TOTAL"
ELSE
   @ M->LI_NHA+1,001 SAY "SUBTOTAL"
ENDIF
@ M->LI_NHA+1,043 SAY M->TOT_0001 PICTURE "@E 999,999,999.99"
@ M->LI_NHA+1,056 SAY M->TOT_0002 PICTURE "@E 999,999,999.99"
@ M->LI_NHA+1,069 SAY M->TOT_0003 PICTURE "@E 999,999,999.99"
@ M->LI_NHA+2,01 SAY REPL("-",123)
 
* Final do programa NAOPGR02.PRG