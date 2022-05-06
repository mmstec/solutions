
* TITULO     :  Programa Utilitario e Aplicacoes Diversas
* DATA       : 22/08/96
* PROGRAMA   : UTILR02.PRG
* COMENTARIO : RELATORIO (2 - Orcamento)
 
**
** Bloco de inser‡„o R02.B01
**
MENSAGEM("Aguarde abertura de arquivos")
SELE 2
USE PRECO INDEX PRECO001
***
*** Inicio do bloco de substitui‡„o R02.B
MENSAGEM("Tecle <ESC> para retornar")
COR("MENU")
@ LIN_MENU,00
@ LIN_MENU,01 SAY "Relat¢rio ³ 2 - Orcamento"
SELE 2
SET ORDER TO 1
**
** Bloco de inser‡„o R02.B02
**
GOTO TOP
M->FILTRO_1=SPACE(30)
JANELA( 8,12,16,69)
COR("MENU")
@ 11,16 CLEAR TO 13,65
**
** Bloco de inser‡„o R02.B03
**
DO WHILE .T.
   **
   ** Bloco de inser‡„o R02.B04
   **
   @ 12,19 SAY "IDENTIFICACAO" GET M->FILTRO_1
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
IF .NOT. MENU_PRN("UTIL_02")
   RESTSCREEN(LIN_MENU+1,00,23,79,TELA_PRI)
   RETURN
ENDIF
SET DEVI TO PRINT
M->LI_NHA=1
M->PAG=1
M->TOT_0001=0
M->TOT_0002=0
M->TOT_0003=0
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
      M->SAI_DA=PERG("Continua a impress„o ?")
      MENSAGEM("Tecle <ESC> para pausa ou interrup‡„o")
      SET DEVI TO PRINT
      IF M->SAI_DA="N"
         EXIT
      ENDIF
   ENDIF
   IF .NOT.(IDENTIFIC=M->FILTRO_1)
      **
      ** Bloco de inser‡„o R02.B08
      **
      TOT_02(2)
      EXIT
   ENDIF
   IF M->LI_NHA=1
      **
      ** Bloco de inser‡„o R02.B09
      **
      IF TIPO_PRN<>"T"
         @ 00,01 SAY CHR(18)
      ENDIF
      M->CAB_1="            M.F.B. MATERIAL DE CONSTRUCAO LTDA"
      M->CAB_2="C.G.C. 34.196.147/000-18 - INC. ESTADUAL 28.956.505"
      **
      ** Bloco de inser‡„o R02.B22
      **
      @ 01,01 SAY M->CAB_1
      @ 01, 65 SAY "Pagina: "+SUBS(STR(M->PAG+10000,5),2)
      M->PAG=M->PAG+1
      @ 02,01 SAY M->CAB_2
      @ 02, 65 SAY "Data: "+DTOC(DATE())
      @ 04,001 SAY "IDENTIFICACAO"
      @ 04,015 SAY FILTRO_1 
      @ 06,001 SAY DESTINATAR PICTURE "@"
      @ 07,001 SAY CODIGO01
      @ 08,001 SAY CODIGO02
      @ 09,001 SAY CODIGO03
      @ 10,001 SAY CODIGO04
      @ 13,001 SAY "Corforme o solicitado, segue abaixo relacao de precos e itens:"
      @ 15,001 SAY OBSERVACAO
      @ 17,001 SAY REPL("=", 78)
      @ 18,001 SAY "DESCRICAO"
      @ 18,040 SAY "QUANTIDADE"
      @ 18,051 SAY "UN"
      @ 18,054 SAY "    UNITARIO"
      @ 18,067 SAY "       TOTAL"
      @ 19,001 SAY REPL("-", 78)
      M->LI_NHA=20
      **
      ** Bloco de inser‡„o R02.B10
      **
   ENDIF
   **
   ** Bloco de inser‡„o R02.B20
   **
   @ M->LI_NHA,001 SAY DESCRICAO
   @ M->LI_NHA,040 SAY QUANTID PICTURE "@Z 9999999.99"
   @ M->LI_NHA,051 SAY UNIDADE
   @ M->LI_NHA,054 SAY VALOR_UNIT PICTURE "@Z 9,999,999.99"
   @ M->LI_NHA,067 SAY VALOR_TOTA PICTURE "@Z 9,999,999.99"
   **
   ** Bloco de inser‡„o R02.B21
   **
   M->TOT_0001=M->TOT_0001+QUANTID
   M->TOT_0002=M->TOT_0002+VALOR_UNIT
   M->TOT_0003=M->TOT_0003+VALOR_TOTA
   M->LI_NHA=M->LI_NHA+1
   **
   ** Bloco de inser‡„o R02.B12
   **
   SKIP
   IF M->LI_NHA>49 .OR. EOF()
      IF EOF()
         TOT_02(2)
      ELSE
         TOT_02(1)
      ENDIF
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
   IMP_TELA("UTIL_02", 79)
ENDIF
**
** Bloco de inser‡„o R02.B19
**
RESTSCREEN(LIN_MENU+1,00,23,79,TELA_PRI)
 
FUNCTION TOT_02
PARA PAR1
IF PAR1=2
   M->LI_NHA=50
ENDIF
@ M->LI_NHA+0,01 SAY REPL("=", 78)
IF PAR1=2
   @ M->LI_NHA+1,001 SAY "TOTAL"
ELSE
   @ M->LI_NHA+1,001 SAY "SUBTOTAL"
ENDIF
@ M->LI_NHA+01,065 SAY M->TOT_0003 PICTURE "@Z 999,999,999.99"
@ M->LI_NHA+02,001 SAY REPL("-", 78)
@ M->LI_NHA+04,001 SAY "* ATENCAO! Os itens nao relacionados nao foram cotados. *"
@ M->LI_NHA+06,001 SAY "Atenciosamente:"
@ M->LI_NHA+08,001 SAY "___________________________________"
@ M->LI_NHA+09,001 SAY "  Valdir Carlos de Jesus Barreto."
@ M->LI_NHA+10,001 SAY "              Responsavel"
 
* Final do programa UTILR02.PRG
