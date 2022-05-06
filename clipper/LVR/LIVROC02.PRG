
* TITULO     : MFB - LIVRO DE PRECOS
* DATA       : 26/06/97
* PROGRAMA   : LIVROC02.PRG
* COMENTARIO : CONSULTA ( Produtos P/ referencia)
 
PARA R_CA
IF M->R_CA="E"
   SET DELETED OFF
   OK_PACK=.T.
ENDIF
**
** Bloco de inser‡„o C02.B01
**
MENSAGEM("Aguarde abertura de arquivos")
SELE 1
USE PRODUTOS INDEX PRODU001,PRODU002,PRODU003
SELE 2
USE GRUPOSSS INDEX GRUPO004,GRUPO005
SELE 1
**
** Bloco de inser‡„o C02.B02
**
SET ORDER TO 3
M->X_VERI = .T.
COR("MENU")
@ LIN_MENU,00
@ LIN_MENU,01 SAY IIF(R_CA="C","Consulta",IIF(R_CA="A","Altera‡„o","Exclus„o"))+" ³  Produtos P/ referencia"
JANELA(03,02,21,77," Produtos P/ referencia")
L_CON=L_SOM
C_CON=C_SOM
COR("MENU")
@ 05,04 CLEAR TO 17,75
@ 05,04 TO 07,75
@ 07,04 TO 17,75
@ 07,04 SAY "Ã"
@ 07,75 SAY "´"
DECLARE DB_CONTE[5],DB_CAB[5]
DB_CAB[1]="Referencia"
DB_CAB[2]="Descricao"
DB_CAB[3]="Marca"
DB_CAB[4]="Preco  venda"
DB_CAB[5]="RESPONSAVEL"
DB_CONTE[1]='REFERENCIA'
DB_CONTE[2]='DESCRICAOO'
DB_CONTE[3]='MARCAAAAAA'
DB_CONTE[4]='STR(PRECOAVIST,10,2)'
DB_CONTE[5]='DIGITADOR'
IF M->R_CA="E"
   DB_CAB[1]="  "+DB_CAB[1]
   DB_CONTE[1]='DELE_TAR()+" "+'+DB_CONTE[1]
   DB_CAB[5]=DB_CAB[5]+"  "
   DB_CONTE[5]=DB_CONTE[5]+'+" "+DELE_TAR()'
ENDIF
SAI_DB=.T.
**
** Bloco de inser‡„o C02.B03
**
DO WHILE .T.
   **
   ** Bloco de inser‡„o C02.B04
   **
   MENSAGEM("Posicione sobre o registro desejado e tecle <ENTER>")
   COR("MENU")
   KEYBOARD CHR(65) 
   ***
   *** Inicio do bloco de substitui‡„o DB02.B
   DBEDIT(06,05,17,74,DB_CONTE,"EDITAR02",.T.,DB_CAB,"ÄÂÄ"," ³ ","ÄÁÄ")
   *** Final do bloco de substitui‡„o DB02.B
   ***
   ***
   *** Inicio do bloco de substitui‡„o C02.B
   SAI_DB=.F.
   MENSAGEM("Tecle <ESC> para sair")
   DO WHILE .T.
      M->REFERENCIA=SPACE(15)
      COR("GETS")
      @ 19,04 SAY "REFERENCIA:" GET M->REFERENCIA PICTURE "@!"
      SET CURSOR ON
      READ
      SET CURSOR OFF
      IF LASTKEY()=27
         EXIT
      ENDIF
      SEEK TRIM(M->REFERENCIA)
      IF EOF()
         BEEP()
         MENSAGEM("Dados n„o encontrados",3)
         MENSAGEM("Tecle <ESC> para sair")
         LOOP
      ENDIF
      EXIT
   ENDDO
   SOMBRA(L_CON,C_CON)
   IF LASTKEY()=27
      EXIT
   ENDIF
ENDDO
SET DELETED ON
RESTSCREEN(LIN_MENU+1,00,23,79,TELA_PRI)
**
** Bloco de inser‡„o C02.B05
**
*** Final do bloco de substitui‡„o C02.B
***
 
FUNCTION EDITAR02
**
** Bloco de inser‡„o C02.B06
**
COR("JANELA DE DIALOGO")
@ 18,04 SAY "Referˆncia  "
@ 18,62 SAY "PRE€O DE VENDA"
@ 19,04 SAY "Descri‡„o   "

COR("CERCADURAS")
@ 18,17 SAY REFERENCIA
@ 19,62 SAY " "+STRzero(PRECOAVIST,10,2)
@ 19,17 SAY DESCRICAOO
*
IF SAI_DB .OR. LASTKEY()=27
   RETURN 0
ELSEIF LASTKEY()=13
   SAVE SCREEN TO TE_LA
   FUNDO()
   DO WHILE .T.
      MENSAGEM("Tecle <ESC> para sair")
      CARREG02(2)
      IF M->R_CA="A"
         OK_GETS=CARGET02(2)
         IF OK_GETS
            IF PERG("Confirma altera‡”es ?")="S"
               SALVAR02()
               COMMIT
               COR("MENU")
               RESTORE SCREEN FROM TE_LA
               KEYBOARD CHR(0)
               L_SOM=L_CON
               C_SOM=C_CON
               RETURN 2
            ELSE
               LOOP
            ENDIF
         ELSE
            COR("MENU")
            RESTORE SCREEN FROM TE_LA
            KEYBOARD CHR(0)
            L_SOM=L_CON
            C_SOM=C_CON
            RETURN 1
         ENDIF
      ELSEIF M->R_CA="E"
         CARGET02(0)
         L_SOM=L_CON
         C_SOM=C_CON
         CLEAR GETS
         IF PERG("Deseja marcar este registro para EXCLUSAO ?")="S"
            DELE
         ELSE
            RECALL
         ENDIF
         COR("MENU")
         RESTORE SCREEN FROM TE_LA
         KEYBOARD CHR(0)
         RETURN 2
      ELSE
         CARGET02(3)
         L_SOM=L_CON
         C_SOM=C_CON
         COR("MENU")
         RESTORE SCREEN FROM TE_LA
         KEYBOARD CHR(0)
         RETURN 1
      ENDIF
   ENDDO
ELSEIF LASTKEY()=1
   GOTO TOP
ELSEIF LASTKEY()=6
   GOTO BOTT
ENDIF
RETURN 1
 
* Final do programa LIVROC02.PRG