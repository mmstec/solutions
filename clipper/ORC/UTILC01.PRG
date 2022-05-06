
* TITULO     :  MFB Materiais de Construcao Ltda ( MMStec - Orcamento )
* DATA       : 06/03/97
* PROGRAMA   : UTILC01.PRG
* COMENTARIO : CONSULTA (1 - ICMS)
 
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
IF .NOT. USEREDE("ICMS",.F.,10)
   BEEP()
   MENSAGEM("O arquivo ICMS n„o est  dispon¡vel",3)
   RETURN
ELSE
   SET INDEX TO
ENDIF
SELE 1
**
** Bloco de inser‡„o C01.B02
**
SET ORDER TO 0
M->X_VERI = .T.
COR("MENU")
@ LIN_MENU,00
@ LIN_MENU,01 SAY IIF(R_CA="C","Consulta",IIF(R_CA="A","Altera‡„o","Exclus„o"))+" ³ 1 - ICMS"
JANELA(03,02,21,77,"1 - ICMS")
L_CON=L_SOM
C_CON=C_SOM
COR("MENU")
@ 05,04 CLEAR TO 19,75
@ 05,04 TO 07,75
@ 07,04 TO 19,75
@ 07,04 SAY "Ã"
@ 07,75 SAY "´"
DECLARE DB_CONTE[16],DB_CAB[16]
DB_CAB[1]="PRODUTO"
DB_CAB[2]="UNIDADE"
DB_CAB[3]="VALOR UNITARIO"
DB_CAB[4]="DESCONTO"
DB_CAB[5]="FINAnceiro"
DB_CAB[6]="total financeiro"
DB_CAB[7]="base de icms"
DB_CAB[8]="ICMS ( em % )"
DB_CAB[9]="CREDITO DO ICMS"
DB_CAB[10]="BASE FIXA / VARIAVEL"
DB_CAB[11]="BASE CAUCULO SUBTRAIDA"
DB_CAB[12]="VALOR DO ICMS ( em % )"
DB_CAB[13]="VALOR DO ICMS SUBTRAIDO"
DB_CAB[14]="VALOR TOTAL DO PRODUTO"
DB_CAB[15]="SUBTRACAO RETIDA"
DB_CAB[16]="TOTAL GERAL"
DB_CONTE[1]='PRODUTO'
DB_CONTE[2]='STR(UNIDADE,5,2)'
DB_CONTE[3]='STR(VALOR_UNI,10,2)'
DB_CONTE[4]='STR(DESCONTO,10,2)'
DB_CONTE[5]='STR(FINACEIRO,10,2)'
DB_CONTE[6]='STR(TOTALFINAC,10,2)'
DB_CONTE[7]='STR(BASE_ICMS,10,2)'
DB_CONTE[8]='STR(ICMS_7,10,2)'
DB_CONTE[9]='STR(CREDT_ICMS,10,2)'
DB_CONTE[10]='STR(BASE_135,10,2)'
DB_CONTE[11]='STR(BASE_C_SUB,10,2)'
DB_CONTE[12]='STR(V_ICMS_17,10,2)'
DB_CONTE[13]='STR(V_ICMS_SUB,10,2)'
DB_CONTE[14]='STR(VT_PRODUTO,10,2)'
DB_CONTE[15]='STR(SUB_RETIDA,10,2)'
DB_CONTE[16]='STR(TOTALGERAL,10,2)'
IF M->R_CA="E"
   DB_CAB[1]="  "+DB_CAB[1]
   DB_CONTE[1]='DELE_TAR()+" "+'+DB_CONTE[1]
   DB_CAB[16]=DB_CAB[16]+"  "
   DB_CONTE[16]=DB_CONTE[16]+'+" "+DELE_TAR()'
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
      IF LASTKEY()=27
         EXIT
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
   RETURN 0
ELSEIF LASTKEY()=13
   SAVE SCREEN TO TE_LA
   FUNDO()
   DO WHILE .T.
      MENSAGEM("Tecle <ESC> para sair")
      CARREG01(2)
      IF M->R_CA="A"
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
   GOTO TOP
ELSEIF LASTKEY()=6
   GOTO BOTT
ENDIF
RETURN 1
 
* Final do programa UTILC01.PRG