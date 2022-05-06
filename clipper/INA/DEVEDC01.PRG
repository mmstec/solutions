
* TITULO     : Controle de Inadiplencia
* DATA       : 15/04/97
* PROGRAMA   : DEVEDC01.PRG
* COMENTARIO : CONSULTA (Inadiplente)
 
PARA R_CA
IF M->R_CA="E"
   SET DELETED OFF
   OK_PACK=.T.
ENDIF
**
** Bloco de inser‡„o C01.B01
**
MENSAGEM("Aguarde abertura de arquivos")
SELE 1
IF .NOT. USEREDE("DEVEDOR",.F.,10)
   BEEP()
   MENSAGEM("O arquivo DEVEDOR n„o est  dispon¡vel",3)
   RETURN
ELSE
   SET INDEX TO DEVED001,DEVED002
ENDIF
SELE 1
**
** Bloco de inser‡„o C01.B02
**
SET ORDER TO 2
M->X_VERI = .T.
COR("MENU")
@ LIN_MENU,00
@ LIN_MENU,01 SAY IIF(R_CA="C","Consulta",IIF(R_CA="A","Altera‡„o","Exclus„o"))+" ³ Inadiplente"
JANELA(03,02,21,77,"Inadiplente")
L_CON=L_SOM
C_CON=C_SOM
COR("MENU")
@ 05,04 CLEAR TO 19,75
@ 05,04 TO 07,75
@ 07,04 TO 19,75
@ 07,04 SAY "Ã"
@ 07,75 SAY "´"
DECLARE DB_CONTE[3],DB_CAB[3]
*
* -> Titulos das colunas
DB_CAB[1]=""
DB_CAB[2]="Nome"
DB_CAB[3]="Documento"
*
* -> Conteudo das colunas
DB_CONTE[1]='CFU01001()'
DB_CONTE[2]='NOME'
DB_CONTE[3]='DOCUMENTO'
IF M->R_CA="E"
   DB_CAB[1]="  "+DB_CAB[1]
   DB_CONTE[1]='DELE_TAR()+" "+'+DB_CONTE[1]
   DB_CAB[3]=DB_CAB[3]+"  "
   DB_CONTE[3]=DB_CONTE[3]+'+" "+DELE_TAR()'
ENDIF
SAI_DB=.T.
**
** Bloco de inser‡„o C01.B03
**
DO WHILE .T.
   **
   ** Bloco de inser‡„o C01.B04
   **
   MENSAGEM("Posicione sobre o registro desejado e tecle <ENTER>")
   COR("MENU")
   KEYBOARD CHR(65) 
   ***
   *** Inicio do bloco de substitui‡„o DB01.B
   DBEDIT(06,05,19,74,DB_CONTE,"EDITAR01",.T.,DB_CAB,"ÄÂÄ"," ³ ","ÄÁÄ")
   *** Final do bloco de substitui‡„o DB01.B
   ***
   ***
   *** Inicio do bloco de substitui‡„o C01.B
   SAI_DB=.F.
   MENSAGEM("Tecle <ESC> para sair")
DO WHILE .T.
   SOMBRA(L_CON,C_CON,.T.)
   JANELA( 9,19,15,59)
   COR("GETS")
   OPC = 1
   @ 11,30 PROMPT " 01 - Inadiplente"
   @ 12,30 PROMPT " 02 - Confronto  "
   @ 13,30 PROMPT " 03 - Funcionario"
   @ 14,30 PROMPT " 04 - Outro      "
   MENU TO OPC
   M->SELECAO =SPACE(1)
   DO CASE
   CASE OPC = 1
     M->SELECAO = "1"
   CASE OPC = 2
     M->SELECAO = "2"
   CASE OPC = 3
     M->SELECAO = "3"
   CASE OPC = 4
     M->SELECAO = "4"
   ENDCASE
      M->NOME=SPACE(30)
      @ 20,05 SAY "Nome" GET M->NOME PICTURE "@!"
      SET CURSOR ON
      READ
      SET CURSOR OFF
      IF LASTKEY()=27
         EXIT
      ENDIF
      SEEK TRIM(M->SELECAO+M->NOME)
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
** Bloco de inser‡„o C01.B05
**
*** Final do bloco de substitui‡„o C01.B
***
 
FUNCTION EDITAR01
**
** Bloco de inser‡„o C01.B06
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
      CARREG01(2)
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
         OK_GETS=CARGET01(2)
         IF OK_GETS
            IF PERG("Confirma altera‡”es ?")="S"
               *
               * -> Atualiza o banco de dados
               SALVAR01()
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
         CARGET01(0)
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
         CARGET01(3)
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
 
FUNCTION CFU01001
IF SELECAO = "1"
   RETURN "Inadiplente"
ELSEIF SELECAO = "2"
   RETURN "Confronto"+SPACE(2)
ELSEIF SELECAO = "3"
   RETURN "Funcionario"
ELSEIF SELECAO = "4"
   RETURN "Outro"+SPACE(6)
ELSE
   RETURN SPACE(11)
ENDIF
 
* Final do programa DEVEDC01.PRG
