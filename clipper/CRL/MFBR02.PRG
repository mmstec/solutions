
* TITULO     : *** Barreto Constru‡„o ***
* DATA       : 17/04/97
* PROGRAMA   : MFBR02.PRG
* COMENTARIO : RELATORIO ( Todos os Clientes)
 
**
** Bloco de inser‡„o R02.B01
**
MENSAGEM("Aguarde abertura de arquivos")
SELE 6
IF .NOT. USEREDE("FICHACLI",.F.,10)
     BEEP()
     MENSAGEM("O arquivo FICHACLI n„o est  dispon¡vel",3)
     RETURN
ELSE
     SET INDEX TO FICHA010,FICHA011
ENDIF
***
*** Inicio do bloco de substitui‡„o R02.B
MENSAGEM("Tecle <ESC> para retornar")
COR("MENU")
@ LIN_MENU,00
@ LIN_MENU,01 SAY "Relat¢rio ³  Todos os Clientes"
SELE 6
SET ORDER TO 2
**
** Bloco de inser‡„o R02.B02
**
GOTO TOP
M->TIPO_PRN="I"
*
* -> Menu que permite direcionar a saida de impressao
IF .NOT. MENU_PRN("MFB_02")
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
               @ 00,01 SAY CHR(15)
          ENDIF
          M->CAB_1="**** MFB Material de Construcao Ltda *****"
          M->CAB_2="********** RELACAO DE CLIENTES ***********"
      **
      ** Bloco de inser‡„o R02.B22
      **
      @ 00,001 SAY "Usu rio: "+M->OPERADOR
          @ 01,01 SAY M->CAB_1
          @ 01, 74 SAY "Pagina: "+SUBS(STR(M->PAG+10000,5),2)
          M->PAG=M->PAG+1
          @ 02,01 SAY M->CAB_2
          @ 02, 74 SAY "Data: "+DTOC(DATE())
          @ 04,01 SAY REPL("-", 87)
          @ 05,001 SAY "Codigo CPF/CGC"
          @ 05,016 SAY "Cliente"
          @ 05,047 SAY "Telefone"
          @ 05,061 SAY "Telefone /FAX"
          @ 05,075 SAY "Telefone /S.T"
          @ 06,01 SAY REPL("-", 87)
          M->LI_NHA=07
          **
          ** Bloco de inser‡„o R02.B10
          **
     ENDIF
     **
     ** Bloco de inser‡„o R02.B20
     **
     @ M->LI_NHA,001 SAY CODICPFCGC
     @ M->LI_NHA,016 SAY NOMECPFCGC
     @ M->LI_NHA,047 SAY TELEFONE01 PICTURE "(999)999.9999"
     @ M->LI_NHA,061 SAY TELEFONE02 PICTURE "(999)999.9999"
     @ M->LI_NHA,075 SAY TELEFONE03 PICTURE "(9999)99.9999"
     **
     ** Bloco de inser‡„o R02.B21
     **
     M->LI_NHA=M->LI_NHA+1
     **
     ** Bloco de inser‡„o R02.B12
     **
     SKIP
     IF M->LI_NHA>61
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
     IMP_TELA("MFB_02", 88)
ENDIF
**
** Bloco de inser‡„o R02.B19
**
RESTSCREEN(LIN_MENU+1,00,23,79,TELA_PRI)
 
* Final do programa MFBR02.PRG