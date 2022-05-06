
* TITULO     : MFB - CONTROLE DE VENDAS
* DATA       : 12/05/97
* PROGRAMA   : MFBR05.PRG
* COMENTARIO : RELATORIO ( 1. PFP a entregar)
 
**
** Bloco de inser‡„o R05.B01
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
*** Inicio do bloco de substitui‡„o R05.B
MENSAGEM("Tecle <ESC> para retornar")
COR("MENU")
@ LIN_MENU,00
@ LIN_MENU,01 SAY "Relat¢rio ³  1. PFP a entregar"
SELE 3
SET ORDER TO 3
**
** Bloco de inser‡„o R05.B02
**
GOTO TOP
*
* -> Inicializa variaveis para filtragem
M->FILTRO_1=CTOD("  /  /  ")
M->FILTRO_2=CTOD("  /  /  ")
JANELA( 7,21,17,60)
COR("MENU")
@ 10,25 CLEAR TO 14,56
**
** Bloco de inser‡„o R05.B03
**
   **
   ** Bloco de inser‡„o R05.B04
   **
@ 11,28 SAY "Pagamento de    :" GET M->FILTRO_1
@ 13,28 SAY "Ate           :" GET M->FILTRO_2
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
IF .NOT. MENU_PRN("MFB_05")
   RESTSCREEN(LIN_MENU+1,00,23,79,TELA_PRI)
   RETURN
ENDIF
SET FILTER TO PAGAMENTO>=M->FILTRO_1 .AND. PAGAMENTO<=M->FILTRO_2 .AND. ENTREGA = CTOD('  /  /  ')
IF .NOT.(PAGAMENTO>=M->FILTRO_1 .AND. PAGAMENTO<=M->FILTRO_2 .AND. ENTREGA = CTOD('  /  /  '))
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
         @ 00,01 SAY CHR(15)
      ENDIF
      M->CAB_1="** MFB Materiais de Construcao Ltda **"
      M->CAB_2="*** Cimento Pago a ser entregue ******"
      **
      ** Bloco de inser‡„o R05.B22
      **
      @ 00,001 SAY "IMPRESSAO: "+RTRIM(M->OPERADOR)
      @ 01,01 SAY M->CAB_1
      @ 01, 83 SAY "Pagina: "+SUBS(STR(M->PAG+10000,5),2)
      M->PAG=M->PAG+1
      @ 02,01 SAY M->CAB_2
      @ 02, 83 SAY "Data: "+DTOC(DATE())
      @ 04,01 SAY "Pagamento de    :"
      @ 04,019 SAY FILTRO_1
      @ 05,01 SAY "Ate           :"
      @ 05,017 SAY FILTRO_2
      @ 07,01 SAY REPL("-", 96)
      @ 08,001 SAY "Cliente"
      @ 08,032 SAY "Documento"
      @ 08,043 SAY "R$ UNIT"
      @ 08,056 SAY "Quant.SC"
      @ 08,067 SAY "R$ Pago"
      @ 08,080 SAY "Dt Venda"
      @ 08,089 SAY "Dt Pagam"
      @ 09,01 SAY REPL("-", 96)
      M->LI_NHA=10
      **
      ** Bloco de inser‡„o R05.B10
      **
   ENDIF
   **
   ** Bloco de inser‡„o R05.B20
   **
   @ M->LI_NHA,001 SAY CLIENTE
   @ M->LI_NHA,032 SAY DOCUMENT
   @ M->LI_NHA,043 SAY RS_UNITARI PICTURE "@E 9,999,999.99"
   @ M->LI_NHA,056 SAY QUANT_SACO PICTURE "@E 9999999.99"
   @ M->LI_NHA,067 SAY TOTAL PICTURE "@E 9,999,999.99"
   @ M->LI_NHA,080 SAY VENDA
   @ M->LI_NHA,089 SAY PAGAMENTO
   **
   ** Bloco de inser‡„o R05.B21
   **
   *
   * -> Totalizacao de campo numericos
   M->TOT_0001=M->TOT_0001+RS_UNITARI
   M->TOT_0002=M->TOT_0002+QUANT_SACO
   M->TOT_0003=M->TOT_0003+TOTAL
   M->LI_NHA=M->LI_NHA+1
   **
   ** Bloco de inser‡„o R05.B12
   **
   SKIP
   IF M->LI_NHA>58 .OR. EOF()
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
   IMP_TELA("MFB_05", 97)
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
   M->LI_NHA=59
ENDIF
@ M->LI_NHA+0,01 SAY REPL("-", 96)
IF PAR1=2
   @ M->LI_NHA+1,001 SAY "TOTAL"
ELSE
   @ M->LI_NHA+1,001 SAY "SUBTOTAL"
ENDIF
@ M->LI_NHA+1,041 SAY M->TOT_0001 PICTURE "@E 999,999,999.99"
@ M->LI_NHA+1,054 SAY M->TOT_0002 PICTURE "@E 999999999.99"
@ M->LI_NHA+1,065 SAY M->TOT_0003 PICTURE "@E 999,999,999.99"
@ M->LI_NHA+2,01 SAY REPL("-", 96)
 
* Final do programa MFBR05.PRG