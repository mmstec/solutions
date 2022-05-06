
* TITULO     :  Programa Utilitario e Aplicacoes Diversas
* DATA       : 31/08/96
* PROGRAMA   : UTILR06.PRG
* COMENTARIO : RELATORIO (6 - Representantes)
 
**
** Bloco de inser‡„o R06.B01
**
MENSAGEM("Aguarde abertura de arquivos")
SELE 6
USE REPRESET INDEX REPRE007
***
*** Inicio do bloco de substitui‡„o R06.B
MENSAGEM("Tecle <ESC> para retornar")
COR("MENU")
@ LIN_MENU,00
@ LIN_MENU,01 SAY "Relat¢rio ³ 6 - Representantes"
SELE 6
SET ORDER TO 1
**
** Bloco de inser‡„o R06.B02
**
GOTO TOP
M->TIPO_PRN="I"
IF .NOT. MENU_PRN("UTIL_06")
   RESTSCREEN(LIN_MENU+1,00,23,79,TELA_PRI)
   RETURN
ENDIF
SET DEVI TO PRINT
M->LI_NHA=1
M->PAG=1
**
** Bloco de inser‡„o R06.B05
**
M->SAI_DA="S"
*** Final do bloco de substitui‡„o R06.B
***
DO WHILE .NOT. EOF()
   **
   ** Bloco de inser‡„o R06.B06
   **
   IF INKEY()=27
      **
      ** Bloco de inser‡„o R06.B07
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
      ** Bloco de inser‡„o R06.B09
      **
      IF TIPO_PRN<>"T"
         @ 00,01 SAY CHR(30)+"2"
      ENDIF
      M->CAB_1="        M.F.B. MATERIAIS DE CONSTRUCAO LTDA."
      M->CAB_2="C.G.C 34.196.147/000-10 - Insc. Estadual 28.956.505"
      **
      ** Bloco de inser‡„o R06.B22
      **
      @ 01,01 SAY M->CAB_1
      @ 01,125 SAY "Pagina: "+SUBS(STR(M->PAG+10000,5),2)
      M->PAG=M->PAG+1
      @ 02,01 SAY M->CAB_2
      @ 02,125 SAY "Data: "+DTOC(DATE())
      @ 04,01 SAY REPL("-",138)
      @ 05,001 SAY "REPRESENTANTE"
      @ 05,032 SAY "FONE"
      @ 05,048 SAY "EMPRESA"
      @ 05,079 SAY "FONE"
      @ 05,094 SAY "FAX"
      @ 05,109 SAY "INTERNET"
      @ 06,01 SAY REPL("-",138)
      M->LI_NHA=07
      **
      ** Bloco de inser‡„o R06.B10
      **
   ENDIF
   **
   ** Bloco de inser‡„o R06.B20
   **
   @ M->LI_NHA,001 SAY NOME
   @ M->LI_NHA,032 SAY FONE01 PICTURE "(999) 999.9999"
   @ M->LI_NHA,048 SAY EMPRESA
   @ M->LI_NHA,079 SAY FONE02 PICTURE "(999) 999.9999"
   @ M->LI_NHA,094 SAY FAX PICTURE "(999) 999.9999"
   @ M->LI_NHA,109 SAY INTERNET
   **
   ** Bloco de inser‡„o R06.B21
   **
   M->LI_NHA=M->LI_NHA+1
   **
   ** Bloco de inser‡„o R06.B12
   **
   SKIP
   IF M->LI_NHA>61
      M->LI_NHA=1
   ENDIF
ENDDO
**
** Bloco de inser‡„o R06.B18
**
EJECT
SET DEVI TO SCREEN
IF M->TIPO_PRN = "A"
   SET PRINTER TO
ELSEIF M->TIPO_PRN = "T" .AND. M->SAI_DA="S"
   SET PRINTER TO
   IMP_TELA("UTIL_06",139)
ENDIF
**
** Bloco de inser‡„o R06.B19
**
RESTSCREEN(LIN_MENU+1,00,23,79,TELA_PRI)
 
* Final do programa UTILR06.PRG