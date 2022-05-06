
* TITULO     : *** Barreto Constru‡„o ***
* DATA       : 17/04/97
* PROGRAMA   : MFBR12.PRG
* COMENTARIO : RELATORIO (  Por cliente Loja)
 
**
** Bloco de inser‡„o R12.B01
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
*** Inicio do bloco de substitui‡„o R12.B
MENSAGEM("Tecle <ESC> para retornar")
COR("MENU")
@ LIN_MENU,00
@ LIN_MENU,01 SAY "Relat¢rio ³   Por cliente Loja"
SELE 4
SET ORDER TO 2
**
** Bloco de inser‡„o R12.B02
**
GOTO TOP
*
* -> Inicializa variaveis para filtragem
M->FILTRO_1=SPACE(14)
JANELA( 8,21,16,61)
COR("MENU")
@ 11,25 CLEAR TO 13,57
**
** Bloco de inser‡„o R12.B03
**
DO WHILE .T.
     **
     ** Bloco de inser‡„o R12.B04
     **
     @ 12,28 SAY "CPF ou CGC :" GET M->FILTRO_1
     SET CURSOR ON
     READ
     SET CURSOR OFF
     IF LASTKEY()=27
          RESTSCREEN(LIN_MENU+1,00,23,79,TELA_PRI)
          EXIT
     ENDIF
     SEEK M->FILTRO_1
     IF EOF()
          BEEP()
          MENSAGEM("Registro n„o encontrado",3)
          MENSAGEM("Tecle <ESC> para sair")
          LOOP
     ENDIF
     EXIT
ENDDO
IF LASTKEY()=27
     RESTSCREEN(LIN_MENU+1,00,23,79,TELA_PRI)
     RETURN
ENDIF
M->TIPO_PRN="I"
*
* -> Menu que permite direcionar a saida de impressao
IF .NOT. MENU_PRN("MFB_12")
     RESTSCREEN(LIN_MENU+1,00,23,79,TELA_PRI)
     RETURN
ENDIF
SET DEVI TO PRINT
M->LI_NHA=1
M->PAG=1
**
** Bloco de inser‡„o R12.B05
**
M->SAI_DA="S"
*** Final do bloco de substitui‡„o R12.B
***
DO WHILE .NOT. EOF()
     **
     ** Bloco de inser‡„o R12.B06
     **
     IF INKEY()=27
          **
          ** Bloco de inser‡„o R12.B07
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
     IF .NOT.(REFERENCIA=M->FILTRO_1)
          **
          ** Bloco de inser‡„o R12.B08
          **
          EXIT
     ENDIF
     IF M->LI_NHA=1
          **
          ** Bloco de inser‡„o R12.B09
          **
          *
          * -> Determina o tipo de caracter para impressao
          IF TIPO_PRN<>"T"
               @ 00,01 SAY CHR(18)
          ENDIF
          M->CAB_1="*********** MFB Material de construcao ltda ******"
          M->CAB_2="******** MOVIMENTO DE CAPITAL POR CLIENTE LOJA ***"
          **
          ** Bloco de inser‡„o R12.B22
          **
          @ 01,01 SAY M->CAB_1
          @ 01, 55 SAY "Pagina: "+SUBS(STR(M->PAG+10000,5),2)
          M->PAG=M->PAG+1
          @ 02,01 SAY M->CAB_2
          @ 02, 55 SAY "Data: "+DTOC(DATE())
          @ 04,01 SAY "CFC OU CGC :"
          @ 04,014 SAY FILTRO_1
          @ 06,01 SAY REPL("-", 68)
          @ 07,001 SAY "Documento"
          @ 07,015 SAY "Dta vend"
          @ 07,024 SAY "Dta venc"
          @ 07,033 SAY "Dta pag."
          @ 07,042 SAY "R$     Valor"
          @ 07,055 SAY "N vendedor"
          @ 08,01 SAY REPL("-", 68)
          M->LI_NHA=09
          **
          ** Bloco de inser‡„o R12.B10
          **
     ENDIF
     **
     ** Bloco de inser‡„o R12.B20
     **
     @ M->LI_NHA,001 SAY NATADUPLIC
     @ M->LI_NHA,015 SAY DATAVENDA
     @ M->LI_NHA,024 SAY DATAVENCI
     @ M->LI_NHA,033 SAY DATAPAGAM
     @ M->LI_NHA,042 SAY VALORVENDA PICTURE "@Z 9,999,999.99"
     @ M->LI_NHA,055 SAY VENDEDOR
     @ M->LI_NHA,057 SAY RFU12001()
     **
     ** Bloco de inser‡„o R12.B21
     **
     M->LI_NHA=M->LI_NHA+1
     **
     ** Bloco de inser‡„o R12.B12
     **
     SKIP
     IF M->LI_NHA>61
          M->LI_NHA=1
     ENDIF
ENDDO
**
** Bloco de inser‡„o R12.B18
**
EJECT
SET DEVI TO SCREEN
IF M->TIPO_PRN = "A"
     SET PRINTER TO
ELSEIF M->TIPO_PRN = "T" .AND. M->SAI_DA="S"
     SET PRINTER TO
     IMP_TELA("MFB_12", 69,  1)
ENDIF
**
** Bloco de inser‡„o R12.B19
**
RESTSCREEN(LIN_MENU+1,00,23,79,TELA_PRI)
 
FUNCTION RFU12001
IF VENDEDOR = "0"
     RETURN "Sem comissao"
ELSEIF VENDEDOR = "1"
     RETURN "Lourildo"+SPACE(4)
ELSEIF VENDEDOR = "2"
     RETURN "Marcio"+SPACE(6)
ELSEIF VENDEDOR = "3"
     RETURN "Marcia"+SPACE(6)
ELSEIF VENDEDOR = "4"
     RETURN "Miguel"+SPACE(6)
ELSEIF VENDEDOR = "5"
     RETURN "Valdir"+SPACE(6)
ELSEIF VENDEDOR = "6"
     RETURN "Outros"+SPACE(6)
ENDIF
 
* Final do programa MFBR12.PRG