

* TITULO     :  Programa Utilitario e Aplicacoes Diversas
* DATA       : 22/08/96
* PROGRAMA   : UTILR05.PRG
* COMENTARIO : RELATORIO (5 - Folha de Pagamento)

**
** Bloco de inser‡„o R05.B01
**
MENSAGEM("Aguarde abertura de arquivos")
SELE 5
USE FOLHA_PA INDEX FOLHA006
***
*** Inicio do bloco de substitui‡„o R05.B
MENSAGEM("Tecle <ESC> para retornar")
COR("MENU")
@ LIN_MENU,00
@ LIN_MENU,01 SAY "Relat¢rio ³ 5 - Folha de Pagamento"
SELE 5
SET ORDER TO 1
**
** Bloco de inser‡„o R05.B02
**
GOTO TOP
M->TIPO_PRN="I"
IF .NOT. MENU_PRN("UTIL_05")
   RESTSCREEN(LIN_MENU+1,00,23,79,TELA_PRI)
   RETURN
ENDIF
SET DEVI TO PRINT
M->LI_NHA=1
M->PAG=1
M->TOT_0001=0
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
      IF TIPO_PRN<>"T"
         @ 00,01 SAY CHR(18)
      ENDIF
      M->CAB_1="          M.F.B. MATERIAL DE CONSTRUCAO LTDA"
      M->CAB_2="C.G.C. 34.196.147/000-18 - Insc. Estadual 28.956.505"
      **
      ** Bloco de inser‡„o R05.B22
      **
      @ 01,01 SAY M->CAB_1
      @ 01, 68 SAY "Pagina: "+SUBS(STR(M->PAG+10000,5),2)
      M->PAG=M->PAG+1
      @ 02,01 SAY M->CAB_2
      @ 02, 68 SAY "Data: "+DTOC(DATE())
      @ 04,01 SAY REPL("-", 81)
      @ 05,001 SAY "CODIGO"
      @ 05,008 SAY "FUNCIONARIO"
      @ 05,039 SAY "S. SEMANAL"
      @ 05,052 SAY "ASSINATURA"
      @ 06,01 SAY REPL("-", 81)
      M->LI_NHA=07
      **
      ** Bloco de inser‡„o R05.B10
      **
   ENDIF
   **
   ** Bloco de inser‡„o R05.B20
   **
   @ M->LI_NHA,001 SAY CODIGO PICTURE "@Z 99999"
   @ M->LI_NHA,008 SAY NOME PICTURE "@!"
   @ M->LI_NHA,039 SAY RFU05001() PICTURE "@Z 9,999,999.99"
   @ M->LI_NHA,052 SAY ASSINA PICTURE "@!"
   **
   ** Bloco de inser‡„o R05.B21
   **
   M->TOT_0001=M->TOT_0001+RFU05001()
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
IF M->TIPO_PRN = "A"
   SET PRINTER TO
ELSEIF M->TIPO_PRN = "T" .AND. M->SAI_DA="S"
   SET PRINTER TO
   IMP_TELA("UTIL_05", 82)
ENDIF
**
** Bloco de inser‡„o R05.B19
**
RESTSCREEN(LIN_MENU+1,00,23,79,TELA_PRI)

FUNCTION TOT_05
PARA PAR1
IF PAR1=2
   M->LI_NHA=59
ENDIF
@ M->LI_NHA+0,01 SAY REPL("-", 81)
IF PAR1=2
   @ M->LI_NHA+1,001 SAY "TOTAL"
ELSE
   @ M->LI_NHA+1,001 SAY "SUBTOTAL"
ENDIF
@ M->LI_NHA+1,037 SAY M->TOT_0001 PICTURE "@Z 999,999,999.99"
@ M->LI_NHA+2,01 SAY REPL("-", 81)

FUNCTION RFU05001
RETURN VALOR/4

* Final do programa UTILR05.PRG
 
* Final UTILR05.PRG