
* TITULO     : *** Barreto Constru‡„o ***
* DATA       : 17/04/97
* PROGRAMA   : MFBR07.PRG
* COMENTARIO : RELATORIO (  V vista cimento)
 
**
** Bloco de inser‡„o R07.B01
**
MENSAGEM("Aguarde abertura de arquivos")
SELE 1
IF .NOT. USEREDE("AVISTACM",.F.,10)
     BEEP()
     MENSAGEM("O arquivo AVISTACM n„o est  dispon¡vel",3)
     RETURN
ELSE
     SET INDEX TO AVIST001
ENDIF
***
*** Inicio do bloco de substitui‡„o R07.B
MENSAGEM("Tecle <ESC> para retornar")
COR("MENU")
@ LIN_MENU,00
@ LIN_MENU,01 SAY "Relat¢rio ³   V vista cimento"
SELE 1
SET ORDER TO 0
**
** Bloco de inser‡„o R07.B02
**
GOTO TOP
M->TIPO_PRN="I"
*
* -> Menu que permite direcionar a saida de impressao
IF .NOT. MENU_PRN("MFB_07")
     RESTSCREEN(LIN_MENU+1,00,23,79,TELA_PRI)
     RETURN
ENDIF
SET DEVI TO PRINT
M->LI_NHA=1
M->PAG=1
**
** Bloco de inser‡„o R07.B05
**
M->SAI_DA="S"
*** Final do bloco de substitui‡„o R07.B
***
DO WHILE .NOT. EOF()
     **
     ** Bloco de inser‡„o R07.B06
     **
     IF INKEY()=27
          **
          ** Bloco de inser‡„o R07.B07
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
          ** Bloco de inser‡„o R07.B09
          **
          *
          * -> Determina o tipo de caracter para impressao
          IF TIPO_PRN<>"T"
               @ 00,01 SAY CHR(18)
          ENDIF
          M->CAB_1="MFB Material de Construcao Ltda"
          M->CAB_2="VENDAS A VISTA DO CIMENTO"
      **
      ** Bloco de inser‡„o R07.B22
      **
      @ 00,001 SAY "Usu rio: "+M->OPERADOR
          @ 01,01 SAY M->CAB_1
          @ 01, 66 SAY "Pagina: "+SUBS(STR(M->PAG+10000,5),2)
          M->PAG=M->PAG+1
          @ 02,01 SAY M->CAB_2
          @ 02, 66 SAY "Data: "+DTOC(DATE())
          @ 04,01 SAY REPL("-", 79)
          @ 05,001 SAY "Data"
          @ 05,010 SAY "Documento"
          @ 05,024 SAY "Cliente"
          @ 05,055 SAY "Qde sacos"
          @ 05,068 SAY "R$     Valor"
          @ 06,01 SAY REPL("-", 79)
          M->LI_NHA=07
          **
          ** Bloco de inser‡„o R07.B10
          **
     ENDIF
     **
     ** Bloco de inser‡„o R07.B20
     **
     @ M->LI_NHA,001 SAY DATA
     @ M->LI_NHA,010 SAY NATADUPLIC
     @ M->LI_NHA,024 SAY NOMECLIENT
     @ M->LI_NHA,055 SAY QUANTSACOS PICTURE "@Z 9999999.99"
     @ M->LI_NHA,068 SAY VALORVENDA PICTURE "@Z 9,999,999.99"
     **
     ** Bloco de inser‡„o R07.B21
     **
     M->LI_NHA=M->LI_NHA+1
     **
     ** Bloco de inser‡„o R07.B12
     **
     SKIP
     IF M->LI_NHA>61
          M->LI_NHA=1
     ENDIF
ENDDO
**
** Bloco de inser‡„o R07.B18
**
EJECT
SET DEVI TO SCREEN
IF M->TIPO_PRN = "A"
     SET PRINTER TO
ELSEIF M->TIPO_PRN = "T" .AND. M->SAI_DA="S"
     SET PRINTER TO
     IMP_TELA("MFB_07", 80)
ENDIF
**
** Bloco de inser‡„o R07.B19
**
RESTSCREEN(LIN_MENU+1,00,23,79,TELA_PRI)
 
* Final do programa MFBR07.PRG