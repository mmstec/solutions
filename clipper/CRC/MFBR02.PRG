*
* TITULO     : MFB - CONTROLE DE VENDAS
* DATA       : 16/05/97
* PROGRAMA   : MFBR02.PRG
* COMENTARIO : RELATORIO ( 1. Devedores)
*
**
** Bloco de inser‡„o R02.B01
**
*
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
*** Inicio do bloco de substitui‡„o R02.B
MENSAGEM("Tecle <ESC> para retornar")
COR("MENU")
@ LIN_MENU,00
@ LIN_MENU,01 SAY "Relat¢rio ³  1. Devedores"
SELE 1
SET ORDER TO 2
**
** Bloco de inser‡„o R02.B02
**
GOTO TOP
*
* -> Inicializa variaveis para filtragem
M->FILTRO_2=CTOD("  /  /  ")
M->FILTRO_3=CTOD("  /  /  ")
JANELA( 7,22,17,59)
COR("MENU")
@ 10,26 CLEAR TO 14,55
**
** Bloco de inser‡„o R02.B03
**
   **
   ** Bloco de inser‡„o R02.B04
   **
@ 11,29 SAY "Devedores de  :" GET M->FILTRO_2
@ 13,29 SAY "Ate           :" GET M->FILTRO_3
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
IF .NOT. MENU_PRN("MFB_02")
   RESTSCREEN(LIN_MENU+1,00,23,79,TELA_PRI)
   RETURN
ENDIF
SET FILTER TO VENCIMENTO>=M->FILTRO_2 .AND. VENCIMENTO<=M->FILTRO_3 .AND. Pagamento = CTOD('  /  /  ')
IF .NOT.(VENCIMENTO>=M->FILTRO_2 .AND. VENCIMENTO<=M->FILTRO_3 .AND. Pagamento = CTOD('  /  /  '))
   SKIP
ENDIF
SET DEVI TO PRINT
M->LI_NHA=1
M->PAG=1
M->N=1
*
* -> Inicializa variaveis de totalizacao
M->TOT_0001=0
M->TOT_0002=0
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
         @ 00,01 SAY CHR(18)
      ENDIF
      M->CAB_1="M.F.B. Material de Construcao Ltda"
      M->CAB_2="Relatorio Devedores **************"
      **
      ** Bloco de inser‡„o R02.B22
      **
      @ 00,001 SAY "Resposavel pela execucao da Impressao: "+RTRIM(M->OPERADOR)
      @ 01,01 SAY M->CAB_1
      @ 01, 65 SAY "Pagina: "+SUBS(STR(M->PAG+10000,5),2)
      M->PAG=M->PAG+1
      @ 02,01 SAY M->CAB_2
      @ 02, 65 SAY "Data: "+DTOC(DATE())
      @ 04,01 SAY "Devedores de  :"
      @ 04,017 SAY FILTRO_2
      @ 05,01 SAY "Ate           :"
      @ 05,017 SAY FILTRO_3
      @ 07,01 SAY REPL("-", 78)
      @ 08,001 SAY STRZERO(RecCount(),5)+" Clientes Devedores"
      @ 08,038 SAY "Documento"
      @ 08,049 SAY "Qde  Sacos"
      @ 08,060 SAY "R$   valor"
      @ 08,071 SAY "Dta Venc"
      @ 09,01 SAY REPL("-", 78)
      M->LI_NHA=10
      **
      ** Bloco de inser‡„o R02.B10
      **
   ENDIF
   **
   ** Bloco de inser‡„o R02.B20
   **
   @ M->LI_NHA,001 SAY STRZERO(N,5)+" "+RTRIM(CLIENTE)+REPL(".",30-LEN(RTRIM(CLIENTE))) PICT "@!"
   M->N=M->N+1
   @ M->LI_NHA,038 SAY Rtrim(DOCUMENT)+Repl(".",10-Len(Rtrim(DOCUMENT)))
   @ M->LI_NHA,049 SAY QUANT_SACO PICTURE "@Z 9999999.99"
   @ M->LI_NHA,060 SAY TOTAL PICTURE "@Z 9999999.99"
   @ M->LI_NHA,071 SAY VENCIMENTO
   **
   ** Bloco de inser‡„o R02.B21
   **
   *
   * -> Totalizacao de campo numericos
   M->TOT_0001=M->TOT_0001+QUANT_SACO
   M->TOT_0002=M->TOT_0002+TOTAL

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
   IMP_TELA("MFB_02", 79)
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
@ M->LI_NHA+0,01 SAY REPL("-", 78)
IF PAR1=2
   @ M->LI_NHA+1,001 SAY "TOTAL"
ELSE
   @ M->LI_NHA+1,001 SAY "SUBTOTAL"
ENDIF
@ M->LI_NHA+1,047 SAY M->TOT_0001 PICTURE "@Z 999999999.99"
@ M->LI_NHA+1,058 SAY M->TOT_0002 PICTURE "@Z 999999999.99"
@ M->LI_NHA+2,01 SAY REPL("-", 78)
 
* Final do programa MFBR02.PRG
