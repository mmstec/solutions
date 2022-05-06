
* TITULO     : MFB - Duplicatas e Estoque do Cimento
* DATA       : 25/04/97
* PROGRAMA   : MONTEC04.PRG
* COMENTARIO : CONSULTA ( ESTOQUE    CIMENTO)
 
PARA R_CA
IF M->R_CA="E"
   SET DELETED OFF
   OK_PACK=.T.
ENDIF
**
** Bloco de inser‡„o C04.B01
**
MENSAGEM("Aguarde abertura de arquivos")
SELE 2
IF .NOT. USEREDE("DOCUMENT",.F.,10)
   BEEP()
   MENSAGEM("O arquivo DOCUMENT n„o est  dispon¡vel",3)
   RETURN
ELSE
   SET INDEX TO DOCUM002,DOCUM003,DOCUM004,DOCUM005
ENDIF
SELE 2
**
** Bloco de inser‡„o C04.B02
**
SET ORDER TO 1
M->X_VERI = .T.
COR("MENU")
@ LIN_MENU,00
@ LIN_MENU,01 SAY IIF(R_CA="C","Consulta",IIF(R_CA="A","Altera‡„o","Exclus„o"))+" ³  ESTOQUE    CIMENTO"
JANELA(03,02,21,77," ESTOQUE    CIMENTO")
L_CON=L_SOM
C_CON=C_SOM
COR("MENU")
@ 05,04 CLEAR TO 17,75
@ 05,04 TO 07,75
@ 07,04 TO 17,75
@ 07,04 SAY "Ã"
@ 07,75 SAY "´"
DECLARE DB_CONTE[6],DB_CAB[6]
*
* -> Titulos das colunas
DB_CAB[1]="Data"
DB_CAB[2]="Compra"
DB_CAB[3]="Venda"
DB_CAB[4]="Pgo/F/Pegar"
DB_CAB[5]="Saldo Bruto"
DB_CAB[6]="Saldo liquido"
*
* -> Conteudo das colunas
DB_CONTE[1]='DTOC(DATA)'
DB_CONTE[2]='STR(COMPRA,10,1)'
DB_CONTE[3]='STR(VENDA,10,1)'
DB_CONTE[4]='STR(PGO_F_PEGA,10,1)'
DB_CONTE[5]='CFU04001()'
DB_CONTE[6]='CFU04002()'
IF M->R_CA="E"
   DB_CAB[1]="  "+DB_CAB[1]
   DB_CONTE[1]='DELE_TAR()+" "+'+DB_CONTE[1]
   DB_CAB[6]=DB_CAB[6]+"  "
   DB_CONTE[6]=DB_CONTE[6]+'+" "+DELE_TAR()'
ENDIF
SAI_DB=.T.
**
** Bloco de inser‡„o C04.B03
**
DO WHILE .T.
   **
   ** Bloco de inser‡„o C04.B04
   **
   MENSAGEM("Posicione sobre o registro desejado e tecle <ENTER>")
   COR("MENU")
   KEYBOARD CHR(65) 
   ***
   *** Inicio do bloco de substitui‡„o DB04.B
   DBEDIT(06,05,17,74,DB_CONTE,"EDITAR04",.T.,DB_CAB,"ÄÂÄ"," ³ ","ÄÁÄ")
   *** Final do bloco de substitui‡„o DB04.B
   ***
   ***
   *** Inicio do bloco de substitui‡„o C04.B
   SAI_DB=.F.
   MENSAGEM("Tecle <ESC> para sair")
   DO WHILE .T.
      M->DATA=CTOD("  /  /  ")
      COR("GETS")
      @ 19,04 SAY "Data" GET M->DATA
      SET CURSOR ON
      READ
      SET CURSOR OFF
      IF LASTKEY()=27
         EXIT
      ENDIF
      SEEK TRIM(DTOS(M->DATA))
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
** Bloco de inser‡„o C04.B05
**
*** Final do bloco de substitui‡„o C04.B
***
 
FUNCTION EDITAR04
**
** Bloco de inser‡„o C04.B06
**
IF SAI_DB .OR. LASTKEY()=27
   *
   * -> Finaliza edi‡„o
   RETURN 0
ELSEIF LASTKEY()=13
   *
   * -> Mostra o registro detalhadamente
   SAVE SCREEN TO TE_LA
   FUNDO()
   DO WHILE .T.
      MENSAGEM("Tecle <ESC> para sair")
      *
      * -> Carrega o conteudo do registro em variaveis
      CARREG03(2)
      IF M->R_CA="A"
         *
         * -> Monta tela de edicao
         IF .NOT. REGLOCK(5)
            BEEP()
            MENSAGEM("Registro bloqueado, tente novamente",3)
            MENSAGEM("Tecle <ESC> para sair")
            RESTORE SCREEN FROM TE_LA
            RETURN 1
         ENDIF
         OK_GETS=CARGET03(2)
         IF OK_GETS
            IF PERG("Confirma altera‡”es ?")="S"
               *
               * -> Atualiza o banco de dados
               SALVAR03()
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
         *
         * -> Mostra registro detalhadamente
         CARGET03(0)
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
         CARGET03(3)
         L_SOM=L_CON
         C_SOM=C_CON
         COR("MENU")
         RESTORE SCREEN FROM TE_LA
         KEYBOARD CHR(0)
         RETURN 1
      ENDIF
   ENDDO
ELSEIF LASTKEY()=1
   *
   * Vai para o comeco do arquivo
   GOTO TOP
ELSEIF LASTKEY()=6
   *
   * -> Vai para o final do arquivo
   GOTO BOTT
ENDIF
RETURN 1
 
FUNCTION CFU04001
RE_TORNO = COMPRA-VENDA
RETURN STR(RE_TORNO,10,2)
 
FUNCTION CFU04002
RE_TORNO = COMPRA-VENDA-PGO_F_PEGA
RETURN STR(RE_TORNO,10,2)
 
* Final do programa MONTEC04.PRG