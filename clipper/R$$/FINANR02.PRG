
* TITULO     :  M.F.B.   Consulta de Cheques   Vers„o 1.0
* DATA       : 09/04/97
* PROGRAMA   : FINANR02.PRG
* COMENTARIO : RELATORIO ( 1. Cheques Pr‚-datados)
 
**
** Bloco de inser‡„o R02.B01
**
MENSAGEM("Aguarde abertura de arquivos")
SELE 1
IF .NOT. USEREDE("FINANCAS",.F.,10)
     BEEP()
     MENSAGEM("O arquivo FINANCAS n„o est  dispon¡vel",3)
     RETURN
ELSE
     SET INDEX TO FINAN001,FINAN002,FINAN003,FINAN004
ENDIF
***
*** Inicio do bloco de substitui‡„o R02.B
MENSAGEM("Tecle <ESC> para retornar")
COR("MENU")
@ LIN_MENU,00
@ LIN_MENU,01 SAY "Relat¢rio ³  1. Cheques Pr‚-datados"
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
JANELA( 7,22,17,59)
COR("MENU")
@ 10,26 CLEAR TO 14,55
**
** Bloco de inser‡„o R02.B03
**
     **
     ** Bloco de inser‡„o R02.B04
     **
@ 11,29 SAY "Vencimento de :" GET M->FILTRO_1
@ 13,29 SAY "Ate           :" GET M->FILTRO_2
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
IF .NOT. MENU_PRN("FINAN_02")
     RESTSCREEN(LIN_MENU+1,00,23,79,TELA_PRI)
     RETURN
ENDIF
SET FILTER TO VENCIM_DOC>=M->FILTRO_1 .AND. VENCIM_DOC<=M->FILTRO_2 .AND. Pagame_doc=CTOD('  /  /  ')
IF .NOT.(VENCIM_DOC>=M->FILTRO_1 .AND. VENCIM_DOC<=M->FILTRO_2 .AND. Pagame_doc=CTOD('  /  /  '))
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
          M->CAB_1="       M.F.B. Materiais de Construcao Ltda.           * CHEQUES A RECEBER **"
          M->CAB_2="C.G.C. 34.196.147/0001-10 Insc. Estadual 28.956.505   * P R E - D A T A D O S *"
      **
      ** Bloco de inser‡„o R02.B22
      **
      @ 00,001 SAY "Usu rio: "+M->OPERADOR
          @ 01,01 SAY M->CAB_1
          @ 01,112 SAY "Pagina: "+SUBS(STR(M->PAG+10000,5),2)
          M->PAG=M->PAG+1
          @ 02,01 SAY M->CAB_2
          @ 02,112 SAY "Data: "+DTOC(DATE())
          @ 04,01 SAY "Vencimento de :"
          @ 04,017 SAY FILTRO_1
          @ 05,01 SAY "Ate           :"
          @ 05,017 SAY FILTRO_2
          @ 07,01 SAY REPL("-",125)
          @ 08,001 SAY "No. Pre-datado."
          @ 08,017 SAY "BCO"
          @ 08,021 SAY "Titular"
          @ 08,062 SAY "Sacar em"
          @ 08,071 SAY "       Valor"
          @ 08,084 SAY "C O N T R O L E"
          @ 08,115 SAY "E Cheque"
          @ 09,01 SAY REPL("-",125)
          M->LI_NHA=10
          **
          ** Bloco de inser‡„o R02.B10
          **
     ENDIF
     **
     ** Bloco de inser‡„o R02.B20
     **
     @ M->LI_NHA,001 SAY NUMERO_DOC
     @ M->LI_NHA,017 SAY BANCO PICTURE "@!"
     @ M->LI_NHA,021 SAY CLIENT_DOC
     @ M->LI_NHA,062 SAY VENCIM_DOC
     @ M->LI_NHA,071 SAY VALOR__DOC PICTURE "@E 9,999,999.99"
     @ M->LI_NHA,084 SAY OBS_01_DOC
     @ M->LI_NHA,115 SAY ESTADO
     @ M->LI_NHA,117 SAY RFU02001()
     **
     ** Bloco de inser‡„o R02.B21
     **
     *
     * -> Totalizacao de campo numericos
     M->TOT_0001=M->TOT_0001+VALOR__DOC
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
     IMP_TELA("FINAN_02",126)
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
@ M->LI_NHA+0,01 SAY REPL("-",125)
IF PAR1=2
     @ M->LI_NHA+1,001 SAY "TOTAL"
ELSE
     @ M->LI_NHA+1,001 SAY "SUBTOTAL"
ENDIF
@ M->LI_NHA+1,069 SAY M->TOT_0001 PICTURE "@E 999,999,999.99"
@ M->LI_NHA+2,01 SAY REPL("-",125)
 
FUNCTION RFU02001
IF ESTADO = "1"
     RETURN "A receber"
ENDIF
 
* Final do programa FINANR02.PRG