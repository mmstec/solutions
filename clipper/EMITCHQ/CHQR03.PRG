
* TITULO     : Recep‡„o/Emiss„o de cheques
* DATA       : 15/05/97
* PROGRAMA   : CHQR03.PRG
* COMENTARIO : RELATORIO (Cheques emitidos)
 
**
** Bloco de inser‡„o R03.B01
**
MENSAGEM("Aguarde abertura de arquivos")
SELE 1
IF .NOT. USEREDE("CHQEMT",.F.,10)
   BEEP()
   MENSAGEM("O arquivo CHQEMT n„o est  dispon¡vel",3)
   RETURN
ELSE
   SET INDEX TO CHQEM001,CHQEM002
ENDIF
***
*** Inicio do bloco de substitui‡„o R03.B
MENSAGEM("Tecle <ESC> para retornar")
COR("MENU")
@ LIN_MENU,00
@ LIN_MENU,01 SAY "Relat¢rio ³ Cheques emitidos"
SELE 1
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
@ 11,29 SAY "Data Inicial  :" GET M->FILTRO_1
@ 13,29 SAY "Data Final  :" GET M->FILTRO_2
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
IF .NOT. MENU_PRN("CHQ_03")
   RESTSCREEN(LIN_MENU+1,00,23,79,TELA_PRI)
   RETURN
ENDIF
SET FILTER TO DATAPPAGAR>=M->FILTRO_1 .AND. DATAPPAGAR<=M->FILTRO_2
IF .NOT.(DATAPPAGAR>=M->FILTRO_1 .AND. DATAPPAGAR<=M->FILTRO_2)
   SKIP
ENDIF
SET DEVI TO PRINT
M->LI_NHA=1
M->PAG=1
*
* -> Inicializa variaveis de totalizacao
M->TOT_0001=0
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
      M->CAB_1="MFB Material de Construcao Ltda"
      M->CAB_2="Cheques Emitidos e cadastrados"
      **
      ** Bloco de inser‡„o R03.B22
      **
      @ 00,001 SAY "IMPRESSAO: "+RTRIM(M->OPERADOR)
      @ 01,01 SAY M->CAB_1
      @ 01, 84 SAY "Pagina: "+SUBS(STR(M->PAG+10000,5),2)
      M->PAG=M->PAG+1
      @ 02,01 SAY M->CAB_2
      @ 02, 84 SAY "Data: "+DTOC(DATE())
      @ 04,01 SAY "Data inicial  :"
      @ 04,017 SAY FILTRO_1
      @ 05,01 SAY "Data Final  :"
      @ 05,015 SAY FILTRO_2
      @ 07,01 SAY REPL("-", 97)
      @ 08,001 SAY "Data/Sqe"
      @ 08,013 SAY "Conta-corrente"
      @ 08,034 SAY "Numero do cheque"
      @ 08,055 SAY "Valor do CHQ"
      @ 08,068 SAY "Destino da emissao"
      @ 09,01 SAY REPL("-", 97)
      M->LI_NHA=10
      **
      ** Bloco de inser‡„o R03.B10
      **
   ENDIF
   **
   ** Bloco de inser‡„o R03.B20
   **
   @ M->LI_NHA,001 SAY DATAPPAGAR
   @ M->LI_NHA,013 SAY NUMEROCONT
   @ M->LI_NHA,034 SAY NUMERO_CHQ
   @ M->LI_NHA,055 SAY VALORDOCHQ PICTURE "@Z 9,999,999.99"
   @ M->LI_NHA,068 SAY FINALIDADE
   **
   ** Bloco de inser‡„o R03.B21
   **
   *
   * -> Totalizacao de campo numericos
   M->TOT_0001=M->TOT_0001+VALORDOCHQ
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
   IMP_TELA("CHQ_03", 98)
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
@ M->LI_NHA+0,01 SAY REPL("-", 97)
IF PAR1=2
   @ M->LI_NHA+1,001 SAY "TOTAL"
ELSE
   @ M->LI_NHA+1,001 SAY "SUBTOTAL"
ENDIF
@ M->LI_NHA+1,053 SAY M->TOT_0001 PICTURE "@Z 999,999,999.99"
@ M->LI_NHA+2,01 SAY REPL("-", 97)
 
* Final do programa CHQR03.PRG