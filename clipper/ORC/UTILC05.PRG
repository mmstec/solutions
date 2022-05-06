
* TITULO     :  MFB Materiais de Construcao Ltda ( MMStec - Orcamento )
* DATA       : 06/03/97
* PROGRAMA   : UTILC05.PRG
* COMENTARIO : CONSULTA (5 - Folha de Pagamento)
 
PARA R_CA
IF M->R_CA="E"
   SET DELETED OFF
   OK_PACK=.T.
ENDIF
**
** Bloco de inser‡„o C05.B01
**
MENSAGEM("Aguarde abertura de arquivos")
SELE 5
IF .NOT. USEREDE("FOLHA_PA",.F.,10)
   BEEP()
   MENSAGEM("O arquivo FOLHA_PA n„o est  dispon¡vel",3)
   RETURN
ELSE
   SET INDEX TO FOLHA006
ENDIF
SELE 5
**
** Bloco de inser‡„o C05.B02
**
SET ORDER TO 1
M->X_VERI = .T.
COR("MENU")
@ LIN_MENU,00
@ LIN_MENU,01 SAY IIF(R_CA="C","Consulta",IIF(R_CA="A","Altera‡„o","Exclus„o"))+" ³ 5 - Folha de Pagamento"
JANELA(03,02,21,77,"5 - Folha de Pagamento")
L_CON=L_SOM
C_CON=C_SOM
COR("MENU")
@ 05,04 CLEAR TO 17,75
@ 05,04 TO 07,75
@ 07,04 TO 17,75
@ 07,04 SAY "Ã"
@ 07,75 SAY "´"
DECLARE DB_CONTE[4],DB_CAB[4]
DB_CAB[1]="CODIGO"
DB_CAB[2]="NOME"
DB_CAB[3]="SALARIO"
DB_CAB[4]="SALARIO SEMANAL"
DB_CONTE[1]='CODIGO'
DB_CONTE[2]='NOME'
DB_CONTE[3]='STR(VALOR,10,2)'
DB_CONTE[4]='CFU05001()'
IF M->R_CA="E"
   DB_CAB[1]="  "+DB_CAB[1]
   DB_CONTE[1]='DELE_TAR()+" "+'+DB_CONTE[1]
   DB_CAB[4]=DB_CAB[4]+"  "
   DB_CONTE[4]=DB_CONTE[4]+'+" "+DELE_TAR()'
ENDIF
SAI_DB=.T.
**
** Bloco de inser‡„o C05.B03
**
DO WHILE .T.
   **
   ** Bloco de inser‡„o C05.B04
   **
   MENSAGEM("Posicione sobre o registro desejado e tecle <ENTER>")
   COR("MENU")
   KEYBOARD CHR(65) 
   ***
   *** Inicio do bloco de substitui‡„o DB05.B
   DBEDIT(06,05,17,74,DB_CONTE,"EDITAR05",.T.,DB_CAB,"ÄÂÄ"," ³ ","ÄÁÄ")
   *** Final do bloco de substitui‡„o DB05.B
   ***
   ***
   *** Inicio do bloco de substitui‡„o C05.B
   SAI_DB=.F.
   MENSAGEM("Tecle <ESC> para sair")
   DO WHILE .T.
      M->NOME=SPACE(30)
      COR("GETS")
      @ 19,04 SAY "NOME" GET M->NOME PICTURE "@!"
      SET CURSOR ON
      READ
      SET CURSOR OFF
      IF LASTKEY()=27
         EXIT
      ENDIF
      SEEK TRIM(M->NOME)
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
** Bloco de inser‡„o C05.B05
**
*** Final do bloco de substitui‡„o C05.B
***
 
FUNCTION EDITAR05
**
** Bloco de inser‡„o C05.B06
**
IF SAI_DB .OR. LASTKEY()=27
   RETURN 0
ELSEIF LASTKEY()=13
   SAVE SCREEN TO TE_LA
   FUNDO()
   DO WHILE .T.
      MENSAGEM("Tecle <ESC> para sair")
      CARREG05(2)
      IF M->R_CA="A"
         IF .NOT. REGLOCK(5)
            BEEP()
            MENSAGEM("Registro bloqueado, tente novamente",3)
            MENSAGEM("Tecle <ESC> para sair")
            RESTORE SCREEN FROM TE_LA
            RETURN 1
         ENDIF
         OK_GETS=CARGET05(2)
         IF OK_GETS
            IF PERG("Confirma altera‡”es ?")="S"
               SALVAR05()
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
         CARGET05(0)
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
         CARGET05(3)
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
 
FUNCTION CFU05001
RE_TORNO = VALOR/4
RETURN STR(RE_TORNO,10,2)
 
* Final do programa UTILC05.PRG