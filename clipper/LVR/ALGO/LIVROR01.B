
* TITULO     :  ALGO - LIVRO DE PRECOS
* DATA       : 07/04/97
* PROGRAMA   : LIVROR01.PRG
* COMENTARIO : RELATORIO (Livro de precos)
 
**
** Bloco de inser‡„o R01.B01
**
MENSAGEM("Aguarde abertura de arquivos")
SELE 1
IF .NOT. USEREDE("PRODUTOS",.F.,10)
     BEEP()
     MENSAGEM("O arquivo PRODUTOS n„o est  dispon¡vel",3)
     RETURN
ELSE
     SET INDEX TO PRODU001,PRODU002,PRODU003
ENDIF
***
*** Inicio do bloco de substitui‡„o R01.B
MENSAGEM("Tecle <ESC> para retornar")
COR("MENU")
@ LIN_MENU,00
@ LIN_MENU,01 SAY "Relat¢rio ³ Livro de precos"
SELE 1
SET ORDER TO 2
**
** Bloco de inser‡„o R01.B02
**
GOTO TOP
M->TIPO_PRN="I"
*
* -> Menu que permite direcionar a saida de impressao
IF .NOT. MENU_PRN("LIVRO_01")
     RESTSCREEN(LIN_MENU+1,00,23,79,TELA_PRI)
     RETURN
ENDIF
SET DEVI TO PRINT
M->LI_NHA=1
M->PAG=1
*
* -> Inicializa variaveis de quebra
M->QUEBRA_1=GRUPOOOOOO
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
          M->CAB_1="******** ALGO MATERIAL DE CONTRUCAO LTDA *******"
          M->CAB_2="********** LIVRO DE PRECOS E PRODUTOS *********"
          **
          ** Bloco de inser‡„o R01.B22
          **
          *@ 00,001 SAY "USUARIO RESPONSAVEL : "+RTRIM(M->OPERADOR)
          @ 00,000 SAY PADL("USUARIO RESPONSAVEL : "+RTRIM(M->OPERADOR),80)
          @ 01,001 SAY M->CAB_1
          @ 01,066 SAY "Pagina: "+SUBS(STR(M->PAG+1000000,7),2)
          M->PAG=M->PAG+1
          @ 02,001 SAY M->CAB_2
          @ 02,066 SAY "Data: "+DTOC(DATE())
          @ 04,001 SAY REPL("*", 79)
          @ 05,001 SAY M->QUEBRA_1
          @ 06,001 SAY "REFERENCIA"
          @ 06,017 SAY "Descricao"
          @ 06,053 SAY "Marca"
          @ 06,068 SAY "Preco  venda"
          @ 07,001 SAY REPL("*", 79)
          M->LI_NHA=09
          **
          ** Bloco de inser‡„o R01.B10
          **
     ENDIF
     **
     ** Bloco de inser‡„o R01.B20
     **
     @ M->LI_NHA,001 SAY REFERENCIA
     @ M->LI_NHA,017 SAY DESCRICAOO
     @ M->LI_NHA,053 SAY MARCAAAAAA
     @ M->LI_NHA,068 SAY PRECOAVIST PICTURE "@Z 9,999,999.99"
     **
     ** Bloco de inser‡„o R01.B21
     **
     M->LI_NHA=M->LI_NHA+1
     **
     ** Bloco de inser‡„o R01.B12
     **
     SKIP
     IF M->QUEBRA_1<>GRUPOOOOOO
          **
          ** Bloco de inser‡„o R01.B13
          **
          M->QUEBRA_1=GRUPOOOOOO
          M->LI_NHA=62
     ENDIF
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
     IMP_TELA("LIVRO_01", 80)
ENDIF
**
** Bloco de inser‡„o R01.B19
**
RESTSCREEN(LIN_MENU+1,00,23,79,TELA_PRI)
 
* Final do programa LIVROR01.PRG
