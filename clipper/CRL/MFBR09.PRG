
* TITULO     : *** Barreto Constru‡„o ***
* DATA       : 17/04/97
* PROGRAMA   : MFBR09.PRG
* COMENTARIO : RELATORIO (  V prazo loja)
 
**
** Bloco de inser‡„o R09.B01
**
MENSAGEM("Aguarde abertura de arquivos")
SELE 4
IF .NOT. USEREDE("APRAZOLJ",.F.,10)
     BEEP()
     MENSAGEM("O arquivo APRAZOLJ n„o est  dispon¡vel",3)
     RETURN
ELSE
     SET INDEX TO APRAZ007,APRAZ008
ENDIF
***
*** Inicio do bloco de substitui‡„o R09.B
MENSAGEM("Tecle <ESC> para retornar")
COR("MENU")
@ LIN_MENU,00
@ LIN_MENU,01 SAY "Relat¢rio ³   V prazo loja"
SELE 4
SET ORDER TO 0
**
** Bloco de inser‡„o R09.B02
**
GOTO TOP
M->TIPO_PRN="I"
*
* -> Menu que permite direcionar a saida de impressao
IF .NOT. MENU_PRN("MFB_09")
     RESTSCREEN(LIN_MENU+1,00,23,79,TELA_PRI)
     RETURN
ENDIF
SET DEVI TO PRINT
M->LI_NHA=1
M->PAG=1
**
** Bloco de inser‡„o R09.B05
**
M->SAI_DA="S"
*** Final do bloco de substitui‡„o R09.B
***
DO WHILE .NOT. EOF()
     **
     ** Bloco de inser‡„o R09.B06
     **
     IF INKEY()=27
          **
          ** Bloco de inser‡„o R09.B07
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
          ** Bloco de inser‡„o R09.B09
          **
          *
          * -> Determina o tipo de caracter para impressao
          IF TIPO_PRN<>"T"
               @ 00,01 SAY CHR(18)
          ENDIF
          M->CAB_1="MFB material de construcao ltda"
          M->CAB_2="VENDAS A PRAZO DA LOJA"
      **
      ** Bloco de inser‡„o R09.B22
      **
      @ 00,001 SAY "Usu rio: "+M->OPERADOR
          @ 01,01 SAY M->CAB_1
          @ 01, 66 SAY "Pagina: "+SUBS(STR(M->PAG+10000,5),2)
          M->PAG=M->PAG+1
          @ 02,01 SAY M->CAB_2
          @ 02, 66 SAY "Data: "+DTOC(DATE())
          @ 04,01 SAY REPL("-", 79)
          @ 05,001 SAY "Documento"
          @ 05,015 SAY "Cliente"
          @ 05,047 SAY "N"
          @ 05,050 SAY "R$  valor"
          @ 05,063 SAY "Dta vend"
          @ 05,072 SAY "Dta venc"
          @ 06,01 SAY REPL("-", 79)
          M->LI_NHA=07
          **
          ** Bloco de inser‡„o R09.B10
          **
     ENDIF
     **
     ** Bloco de inser‡„o R09.B20
     **
     @ M->LI_NHA,001 SAY NATADUPLIC
     @ M->LI_NHA,015 SAY NOMECLIENT
     @ M->LI_NHA,047 SAY VENDEDOR
     @ M->LI_NHA,050 SAY VALORVENDA PICTURE "@Z 9,999,999.99"
     @ M->LI_NHA,063 SAY DATAVENDA
     @ M->LI_NHA,072 SAY DATAVENCI
     **
     ** Bloco de inser‡„o R09.B21
     **
     M->LI_NHA=M->LI_NHA+1
     **
     ** Bloco de inser‡„o R09.B12
     **
     SKIP
     IF M->LI_NHA>61
          M->LI_NHA=1
     ENDIF
ENDDO
**
** Bloco de inser‡„o R09.B18
**
EJECT
SET DEVI TO SCREEN
IF M->TIPO_PRN = "A"
     SET PRINTER TO
ELSEIF M->TIPO_PRN = "T" .AND. M->SAI_DA="S"
     SET PRINTER TO
     IMP_TELA("MFB_09", 80)
ENDIF
**
** Bloco de inser‡„o R09.B19
**
RESTSCREEN(LIN_MENU+1,00,23,79,TELA_PRI)
 
* Final do programa MFBR09.PRG