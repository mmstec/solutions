
* TITULO     : Recep‡„o/Emiss„o de cheques
* DATA       : 15/05/97
* PROGRAMA   : CHQR02.PRG
* COMENTARIO : RELATORIO (Contas Correntes)
 
**
** Bloco de inser‡„o R02.B01
**
MENSAGEM("Aguarde abertura de arquivos")
SELE 4
IF .NOT. USEREDE("CONTAS",.F.,10)
   BEEP()
   MENSAGEM("O arquivo CONTAS n„o est  dispon¡vel",3)
   RETURN
ELSE
   SET INDEX TO CONTA007,CONTA008,CONTA009
ENDIF
***
*** Inicio do bloco de substitui‡„o R02.B
MENSAGEM("Tecle <ESC> para retornar")
COR("MENU")
@ LIN_MENU,00
@ LIN_MENU,01 SAY "Relat¢rio ³ Contas Correntes"
SELE 4
SET ORDER TO 1
**
** Bloco de inser‡„o R02.B02
**
GOTO TOP
M->TIPO_PRN="I"
*
* -> Menu que permite direcionar a saida de impressao
IF .NOT. MENU_PRN("CHQ_02")
   RESTSCREEN(LIN_MENU+1,00,23,79,TELA_PRI)
   RETURN
ENDIF
SET DEVI TO PRINT
M->LI_NHA=1
M->PAG=1
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
      M->CAB_1="MFB Material de Construcao Ltda"
      M->CAB_2="Contas-correntes cadastradas"
      **
      ** Bloco de inser‡„o R02.B22
      **
      @ 00,001 SAY "IMPRESSAO: "+RTRIM(M->OPERADOR)
      @ 01,01 SAY M->CAB_1
      @ 01, 66 SAY "Pagina: "+SUBS(STR(M->PAG+10000,5),2)
      M->PAG=M->PAG+1
      @ 02,01 SAY M->CAB_2
      @ 02, 66 SAY "Data: "+DTOC(DATE())
      @ 04,01 SAY REPL("-", 79)
      M->LI_NHA=05
      **
      ** Bloco de inser‡„o R02.B10
      **
   ENDIF
   **
   ** Bloco de inser‡„o R02.B20
   **
   @ M->LI_NHA+00,001 SAY "Agencia........:"
   @ M->LI_NHA+00,018 SAY NUMEROAGEN
   @ M->LI_NHA+00,039 SAY "Banco....:"
   @ M->LI_NHA+00,050 SAY NOMEDOBANK
   @ M->LI_NHA+02,001 SAY "Conta-corrente.:"
   @ M->LI_NHA+02,018 SAY NUMEROCONT
   @ M->LI_NHA+02,039 SAY "Espicificacao......:"
   @ M->LI_NHA+02,060 SAY ESPECIFICA
   **
   ** Bloco de inser‡„o R02.B21
   **
   @ M->LI_NHA+03,01 SAY REPL("-", 79)
   M->LI_NHA=M->LI_NHA+4
   **
   ** Bloco de inser‡„o R02.B12
   **
   SKIP
   IF M->LI_NHA>58
      M->LI_NHA=1
   ENDIF
ENDDO
**
** Bloco de inser‡„o R02.B18
**
EJECT
SET DEVI TO SCREEN
IF M->TIPO_PRN = "A"
   SET PRINTER TO
ELSEIF M->TIPO_PRN = "T" .AND. M->SAI_DA="S"
   SET PRINTER TO
   IMP_TELA("CHQ_02", 80)
ENDIF
**
** Bloco de inser‡„o R02.B19
**
RESTSCREEN(LIN_MENU+1,00,23,79,TELA_PRI)
 
* Final do programa CHQR02.PRG