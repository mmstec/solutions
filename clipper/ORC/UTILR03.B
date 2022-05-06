
* TITULO     :  Programa Utilitario e Aplicacoes Diversas
* DATA       : 22/08/96
* PROGRAMA   : UTILR03.PRG
* COMENTARIO : RELATORIO (3 - Lista / Precos)
 
**
** Bloco de inser‡„o R03.B01
**
MENSAGEM("Aguarde abertura de arquivos")
SELE 3
USE LISTA INDEX LISTA002,LISTA003
***
*** Inicio do bloco de substitui‡„o R03.B
MENSAGEM("Tecle <ESC> para retornar")
COR("MENU")
@ LIN_MENU,00
@ LIN_MENU,01 SAY "Relat¢rio ³ 3 - Lista / Precos"
SELE 3
SET ORDER TO 2
**
** Bloco de inser‡„o R03.B02
**
GOTO TOP
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
IF .NOT. MENU_PRN("UTIL_03")
   RESTSCREEN(LIN_MENU+1,00,23,79,TELA_PRI)
   RETURN
ENDIF
SET FILTER TO DATA>=M->FILTRO_1 .AND. DATA<=M->FILTRO_2
IF .NOT.(DATA>=M->FILTRO_1 .AND. DATA<=M->FILTRO_2)
   SKIP
ENDIF
SET DEVI TO PRINT
M->LI_NHA=1
M->PAG=1
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
      IF TIPO_PRN<>"T"
         @ 00,01 SAY CHR(18)
      ENDIF
      M->CAB_1="          M.F.B. MATERIAL DE CONSTRUCAO LTDA"
      M->CAB_2="C.G.C. 34.196.147/001-10 - INSC. ESTADUAL 28.956.505"
      **
      ** Bloco de inser‡„o R03.B22
      **
      @ 01,01 SAY M->CAB_1
      @ 01, 62 SAY "Pagina: "+SUBS(STR(M->PAG+10000,5),2)
      M->PAG=M->PAG+1
      @ 02,01 SAY M->CAB_2
      @ 02, 62 SAY "Data: "+DTOC(DATE())
      @ 04,01 SAY "PERIODO DE    :"
      @ 04,017 SAY FILTRO_1
      @ 05,01 SAY "ATE           :"
      @ 05,017 SAY FILTRO_2
      @ 07,01 SAY REPL("-", 75)
      @ 08,001 SAY "DESCRICAO DOS PRODUTOS"
      @ 08,053 SAY "       VALOR"
      @ 08,068 SAY "INCLUSAO"
      @ 09,01 SAY REPL("-", 75)
      M->LI_NHA=10
      **
      ** Bloco de inser‡„o R03.B10
      **
   ENDIF
   **
   ** Bloco de inser‡„o R03.B20
   **
   @ M->LI_NHA,001 SAY DESCRICAO PICTURE "@!"
   @ M->LI_NHA,053 SAY VALOR PICTURE "@Z 9,999,999.99"
   @ M->LI_NHA,068 SAY DATA
   **
   ** Bloco de inser‡„o R03.B21
   **
   M->TOT_0001=M->TOT_0001+VALOR
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
   IMP_TELA("UTIL_03", 76)
ENDIF
**
** Bloco de inser‡„o R03.B19
**
RESTSCREEN(LIN_MENU+1,00,23,79,TELA_PRI)
 
FUNCTION TOT_03
PARA PAR1
IF PAR1=2
   M->LI_NHA=59
ENDIF
@ M->LI_NHA+0,01 SAY REPL("-", 75)
IF PAR1=2
   @ M->LI_NHA+1,001 SAY "TOTAL"
ELSE
   @ M->LI_NHA+1,001 SAY "SUBTOTAL"
ENDIF
@ M->LI_NHA+1,051 SAY M->TOT_0001 PICTURE "@Z 999,999,999.99"
@ M->LI_NHA+2,01 SAY REPL("-", 75)
 
* Final do programa UTILR03.PRG