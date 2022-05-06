
* TITULO     : Recep‡„o/Emiss„o de cheques
* DATA       : 15/05/97
* PROGRAMA   : CHQR01.PRG
* COMENTARIO : RELATORIO (Bancos disponiveis)
 
**
** Bloco de inser‡„o R01.B01
**
MENSAGEM("Aguarde abertura de arquivos")
SELE 3
IF .NOT. USEREDE("BANCOS",.F.,10)
   BEEP()
   MENSAGEM("O arquivo BANCOS n„o est  dispon¡vel",3)
   RETURN
ELSE
   SET INDEX TO BANCO005,BANCO006
ENDIF
***
*** Inicio do bloco de substitui‡„o R01.B
MENSAGEM("Tecle <ESC> para retornar")
COR("MENU")
@ LIN_MENU,00
@ LIN_MENU,01 SAY "Relat¢rio ³ Bancos disponiveis"
SELE 3
SET ORDER TO 1
**
** Bloco de inser‡„o R01.B02
**
GOTO TOP
M->TIPO_PRN="I"
*
* -> Menu que permite direcionar a saida de impressao
IF .NOT. MENU_PRN("CHQ_01")
   RESTSCREEN(LIN_MENU+1,00,23,79,TELA_PRI)
   RETURN
ENDIF
SET DEVI TO PRINT
M->LI_NHA=1
M->PAG=1
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
   IF M->LI_NHA=1
      **
      ** Bloco de inser‡„o R01.B09
      **
      *
      * -> Determina o tipo de caracter para impressao
      IF TIPO_PRN<>"T"
         @ 00,01 SAY CHR(18)
      ENDIF
      M->CAB_1="MFB Material de Construcao Ltda"
      M->CAB_2="Bancos cadastrados no sitema"
      **
      ** Bloco de inser‡„o R01.B22
      **
      @ 00,001 SAY "IMPRESSAO: "+RTRIM(M->OPERADOR)
      @ 01,01 SAY M->CAB_1
      @ 01, 34 SAY "Pagina: "+SUBS(STR(M->PAG+10000,5),2)
      M->PAG=M->PAG+1
      @ 02,01 SAY M->CAB_2
      @ 02, 34 SAY "Data: "+DTOC(DATE())
      @ 04,01 SAY REPL("-", 47)
      @ 05,001 SAY "Agenica"
      @ 05,015 SAY "Banco"
      @ 06,01 SAY REPL("-", 47)
      M->LI_NHA=07
      **
      ** Bloco de inser‡„o R01.B10
      **
   ENDIF
   **
   ** Bloco de inser‡„o R01.B20
   **
   @ M->LI_NHA,001 SAY NUMEROAGEN
   @ M->LI_NHA,015 SAY NOMEDOBANK
   **
   ** Bloco de inser‡„o R01.B21
   **
   M->LI_NHA=M->LI_NHA+1
   **
   ** Bloco de inser‡„o R01.B12
   **
   SKIP
   IF M->LI_NHA>61
      M->LI_NHA=1
   ENDIF
ENDDO
**
** Bloco de inser‡„o R01.B18
**
EJECT
SET DEVI TO SCREEN
IF M->TIPO_PRN = "A"
   SET PRINTER TO
ELSEIF M->TIPO_PRN = "T" .AND. M->SAI_DA="S"
   SET PRINTER TO
   IMP_TELA("CHQ_01", 48,  1)
ENDIF
**
** Bloco de inser‡„o R01.B19
**
RESTSCREEN(LIN_MENU+1,00,23,79,TELA_PRI)
 
* Final do programa CHQR01.PRG