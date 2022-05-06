
* TITULO     :  Programa Utilitario e Aplicacoes Diversas
* DATA       : 22/08/96
* PROGRAMA   : UTILR04.PRG
* COMENTARIO : RELATORIO (4 - Aniversariantes)
 
**
** Bloco de inser‡„o R04.B01
**
MENSAGEM("Aguarde abertura de arquivos")
SELE 4
USE HEPPYDAY INDEX HEPPY004,HEPPY005
***
*** Inicio do bloco de substitui‡„o R04.B
MENSAGEM("Tecle <ESC> para retornar")
COR("MENU")
@ LIN_MENU,00
@ LIN_MENU,01 SAY "Relat¢rio ³ 4 - Aniversariantes"
SELE 4
SET ORDER TO 2
**
** Bloco de inser‡„o R04.B02
**
GOTO TOP
M->TIPO_PRN="I"
IF .NOT. MENU_PRN("UTIL_04")
   RESTSCREEN(LIN_MENU+1,00,23,79,TELA_PRI)
   RETURN
ENDIF
SET DEVI TO PRINT
M->LI_NHA=1
M->PAG=1
**
** Bloco de inser‡„o R04.B05
**
M->SAI_DA="S"
*** Final do bloco de substitui‡„o R04.B
***
DO WHILE .NOT. EOF()
   **
   ** Bloco de inser‡„o R04.B06
   **
   IF INKEY()=27
      **
      ** Bloco de inser‡„o R04.B07
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
      ** Bloco de inser‡„o R04.B09
      **
      IF TIPO_PRN<>"T"
         @ 00,01 SAY CHR(18)
      ENDIF
      M->CAB_1="             M.F.B. MATERIAL DE CONSTRUCAO LTDA"
      M->CAB_2="     CGC 34.196.147/000-18 - INC.ESTADUAL 28.956.505"
      **
      ** Bloco de inser‡„o R04.B22
      **
      @ 01,01 SAY M->CAB_1
      @ 01, 61 SAY "Pagina: "+SUBS(STR(M->PAG+10000,5),2)
      M->PAG=M->PAG+1
      @ 02,01 SAY M->CAB_2
      @ 02, 61 SAY "Data: "+DTOC(DATE())
      @ 04,01 SAY REPL("-", 74)
      @ 05,001 SAY "ANIVERSARIANTE"
      @ 05,067 SAY "    DATA"
      @ 06,01 SAY REPL("-", 74)
      M->LI_NHA=07
      **
      ** Bloco de inser‡„o R04.B10
      **
   ENDIF
   **
   ** Bloco de inser‡„o R04.B20
   **
   @ M->LI_NHA,001 SAY ANIVER PICTURE "@!"
   @ M->LI_NHA,067 SAY DATA_ANI
   **
   ** Bloco de inser‡„o R04.B21
   **
   M->LI_NHA=M->LI_NHA+1
   **
   ** Bloco de inser‡„o R04.B12
   **
   SKIP
   IF M->LI_NHA>61
      M->LI_NHA=1
   ENDIF
ENDDO
**
** Bloco de inser‡„o R04.B18
**
EJECT
SET DEVI TO SCREEN
IF M->TIPO_PRN = "A"
   SET PRINTER TO
ELSEIF M->TIPO_PRN = "T" .AND. M->SAI_DA="S"
   SET PRINTER TO
   IMP_TELA("UTIL_04", 75)
ENDIF
**
** Bloco de inser‡„o R04.B19
**
RESTSCREEN(LIN_MENU+1,00,23,79,TELA_PRI)
 
* Final do programa UTILR04.PRG