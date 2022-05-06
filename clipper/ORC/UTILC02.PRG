
* TITULO     :  MFB Materiais de Construcao Ltda ( MMStec - Orcamento )
* DATA       : 06/03/97
* PROGRAMA   : UTILC02.PRG
* COMENTARIO : CONSULTA (2 - Orcamento)
 
PARA R_CA
IF M->R_CA="E"
   SET DELETED OFF
   OK_PACK=.T.
ENDIF
**
** Bloco de inser‡„o C02.B01
**
MENSAGEM("Aguarde abertura de arquivos")
SELE 2
IF .NOT. USEREDE("PRECO",.F.,10)
   BEEP()
   MENSAGEM("O arquivo PRECO n„o est  dispon¡vel",3)
   RETURN
ELSE
   SET INDEX TO PRECO001
ENDIF
SELE 2
**
** Bloco de inser‡„o C02.B02
**
SET ORDER TO 1
M->X_VERI = .T.
COR("MENU")
@ LIN_MENU,00
@ LIN_MENU,01 SAY IIF(R_CA="C","Consulta",IIF(R_CA="A","Altera‡„o","Exclus„o"))+" ³ 2 - Orcamento"
JANELA(03,02,21,77,"2 - Orcamento")
L_CON=L_SOM
C_CON=C_SOM
COR("MENU")
@ 05,04 CLEAR TO 17,75
@ 05,04 TO 07,75
@ 07,04 TO 17,75
@ 07,04 SAY "Ã"
@ 07,75 SAY "´"
DECLARE DB_CONTE[5],DB_CAB[5]
DB_CAB[1]="IDENTIFICACAO"
DB_CAB[2]="QUANTIDADE"
DB_CAB[3]="DESCRICAO"
DB_CAB[4]="VALOR TOTAL"
DB_CAB[5]="VALOR UNITARIO"
DB_CONTE[1]='IDENTIFIC'
DB_CONTE[2]='STR(QUANTID,12,2)'
DB_CONTE[3]='DESCRICAO'
DB_CONTE[4]='STR(VALOR_TOTA,10,2)'
DB_CONTE[5]='STR(VALOR_UNIT,10,2)'
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
      M->IDENTIFIC=SPACE(30)
      COR("GETS")
      @ 19,04 SAY "IDENTIFICACAO" GET M->IDENTIFIC PICTURE "@!"
      SET CURSOR ON
      READ
      SET CURSOR OFF
      IF LASTKEY()=27
         EXIT
      ENDIF
      SEEK TRIM(M->IDENTIFIC)
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
IF SAI_DB .OR. LASTKEY()=27
   RETURN 0
ELSEIF LASTKEY()=13
   SAVE SCREEN TO TE_LA
   FUNDO()
   DO WHILE .T.
      MENSAGEM("Tecle <ESC> para sair")
      CARREG02(2)
      IF M->R_CA="A"
         IF .NOT. REGLOCK(5)
            BEEP()
            MENSAGEM("Registro bloqueado, tente novamente",3)
            MENSAGEM("Tecle <ESC> para sair")
            RESTORE SCREEN FROM TE_LA
            RETURN 1
         ENDIF
         OK_GETS=CARGET02(2)
         IF OK_GETS
            IF PERG("Confirma altera‡”es ?")="S"
               SALVAR02()
               COMMIT
               UNLOCK
               COR("MENU")
               RESTORE SCREEN FROM TE_LA
               KEYBOARD CHR(0)
               L_SOM=L_CON
               C_SOM=C_CON
               RETURN 2
            ELSE
               UNLOCK
               LOOP
            ENDIF
         ELSE
            UNLOCK
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
            IF .NOT. REGLOCK(5)
               BEEP()
               MENSAGEM("Dele‡„o mal sucedida",3)
               MENSAGEM("Tecle <ESC> para sair")
               RESTORE SCREEN FROM TE_LA
               RETURN 1
            ENDIF
            DELE
         ELSE
            IF .NOT. REGLOCK(5)
               BEEP()
               MENSAGEM("Dele‡„o mal sucedida",3)
               MENSAGEM("Tecle <ESC> para sair")
               RESTORE SCREEN FROM TE_LA
               RETURN 1
            ENDIF
            RECALL
         ENDIF
         UNLOCK
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
 
* Final do programa UTILC02.PRG