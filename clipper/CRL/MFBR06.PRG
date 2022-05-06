
* TITULO     : *** Barreto Constru‡„o ***
* DATA       : 17/04/97
* PROGRAMA   : MFBR06.PRG
* COMENTARIO : RELATORIO (  V vista loja)
 
**
** Bloco de inser‡„o R06.B01
**
MENSAGEM("Aguarde abertura de arquivos")
SELE 2
IF .NOT. USEREDE("AVISTALJ",.F.,10)
     BEEP()
     MENSAGEM("O arquivo AVISTALJ n„o est  dispon¡vel",3)
     RETURN
ELSE
     SET INDEX TO AVIST002,AVIST003,AVIST004
ENDIF
***
*** Inicio do bloco de substitui‡„o R06.B
MENSAGEM("Tecle <ESC> para retornar")
COR("MENU")
@ LIN_MENU,00
@ LIN_MENU,01 SAY "Relat¢rio ³   V vista loja"
SELE 2
SET ORDER TO 0
**
** Bloco de inser‡„o R06.B02
**
GOTO TOP
M->TIPO_PRN="I"
*
* -> Menu que permite direcionar a saida de impressao
IF .NOT. MENU_PRN("MFB_06")
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
          ** Bloco de inser‡„o R06.B09
          **
          *
          * -> Determina o tipo de caracter para impressao
          IF TIPO_PRN<>"T"
               @ 00,01 SAY CHR(18)
          ENDIF
          M->CAB_1="MFB Material de construcao ltda"
          M->CAB_2="VENDAS A VISTA DA LOJA"
      **
      ** Bloco de inser‡„o R06.B22
      **
      @ 00,001 SAY "Usu rio: "+M->OPERADOR
          @ 01,01 SAY M->CAB_1
          @ 01, 67 SAY "Pagina: "+SUBS(STR(M->PAG+10000,5),2)
          M->PAG=M->PAG+1
          @ 02,01 SAY M->CAB_2
          @ 02, 67 SAY "Data: "+DTOC(DATE())
          @ 04,01 SAY REPL("-", 80)
          @ 05,001 SAY "Data"
          @ 05,010 SAY "Documento"
          @ 05,024 SAY "Cliente"
          @ 05,055 SAY "R$     valor"
          @ 05,068 SAY "CHEQUE/CARTAO"
          @ 06,01 SAY REPL("-", 80)
          M->LI_NHA=07
          **
          ** Bloco de inser‡„o R06.B10
          **
     ENDIF
     **
     ** Bloco de inser‡„o R06.B20
     **
     @ M->LI_NHA,001 SAY DATA
     @ M->LI_NHA,010 SAY NATADUPLIC
     @ M->LI_NHA,024 SAY NOMECLIENT
     @ M->LI_NHA,055 SAY VALORVENDA PICTURE "@Z 9,999,999.99"
     @ M->LI_NHA,068 SAY OBSNUMERO
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
     IMP_TELA("MFB_06", 81)
ENDIF
**
** Bloco de inser‡„o R06.B19
**
RESTSCREEN(LIN_MENU+1,00,23,79,TELA_PRI)
 
* Final do programa MFBR06.PRG