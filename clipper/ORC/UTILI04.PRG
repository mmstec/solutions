
* TITULO     :  MFB Materiais de Construcao Ltda ( MMStec - Orcamento )
* DATA       : 06/03/97
* PROGRAMA   : UTILI04.PRG
* COMENTARIO : INCLUSAO (4 - Aniversariantes)
 
**
** Bloco de inser‡„o I04.B01
**
MENSAGEM("Aguarde abertura de arquivos")
SELE 4
IF .NOT. USEREDE("HEPPYDAY",.F.,10)
   BEEP()
   MENSAGEM("O arquivo HEPPYDAY n„o est  dispon¡vel",3)
   RETURN
ELSE
   SET INDEX TO HEPPY004,HEPPY005
ENDIF
SELE 4
**
** Bloco de inser‡„o I04.B02
**
***
*** Inicio do bloco de substitui‡„o I04.B
COR("MENU")
@ LIN_MENU,00
@ LIN_MENU,01 SAY "Inclus„o ³ 4 - Aniversariantes"
M->P_VERI = .T.
M->X_VERI = .F.
M->IN_CLUI=.T.
DO WHILE .T.
   **
   ** Bloco de inser‡„o I04.B03
   **
   MENSAGEM("Tecle <ESC> para retornar")
   IF M->P_VERI
      **
      ** Bloco de inser‡„o I04.B04
      **
      CARREG04(1)
   ELSE
      M->X_VERI = .T.
      **
      ** Bloco de inser‡„o I04.B05
      **
   ENDIF
   IF CARGET04(IIF(M->AL_TERA,2,1))=.F.
      IF M->AL_TERA
         **
         ** Bloco de inser‡„o I04.B06
         **
         CARREG04(2)
         M->X_VERI = .T.
         CARGET04(5)
         BEEP()
         IF PERG("Registro j  cadastrado. Deseja alterar ?")="S"
            **
            ** Bloco de inser‡„o I04.B07
            **
            M->IN_CLUI=.F.
            M->P_VERI=.F.
         ELSE
            **
            ** Bloco de inser‡„o I04.B08
            **
            M->AL_TERA=.F.
         ENDIF
         LOOP
      ENDIF
      **
      ** Bloco de inser‡„o I04.B09
      **
      EXIT
   ENDIF
   **
   ** Bloco de inser‡„o I04.B10
   **
   IF PERG("Confirma as informa‡”es ?")="N"
      M->P_VERI = .F.
      **
      ** Bloco de inser‡„o I04.B11
      **
      LOOP
   ENDIF
   M->P_VERI = .T.
   M->X_VERI = .F.
   **
   ** Bloco de inser‡„o I04.B12
   **
   IF M->IN_CLUI
      IF .NOT. ADIREG(0)
         M->P_VERI=.F.
         MENSAGEM("Inclus„o n„o foi bem sucedida",3)
         MENSAGEM("Tecle <ESC> para retornar")
         LOOP
      ENDIF
   ELSE
      IF .NOT. REGLOCK(20)
         BEEP()
         MENSAGEM("Atualiza‡„o n„o foi bem sucedida",5)
         MENSAGEM("Tecle <ESC> para retornar")
         LOOP
      ENDIF
   ENDIF
   SALVAR04()
   COMMIT
   UNLOCK
   IF .NOT. M->IN_CLUI
      M->IN_CLUI=.T.
   ENDIF
ENDDO
RESTSCREEN(LIN_MENU+1,00,23,79,TELA_PRI)
**
** Bloco de inser‡„o I04.B13
**
*** Final do bloco de substitui‡„o I04.B
***
 
FUNCTION VERI004
PARA R_PARA
M->I_REG=RECN()
M->ORDEM = INDEXORD()
SET ORDER TO 1
SEEK M->ANIVER
IF M->I_REG=RECN() .AND. R_PARA=2
   SET ORDER TO M->ORDEM
   RETURN .T.
ENDIF
IF .NOT. EOF()
   IF R_PARA=2
      @ 00,00 SAY ""
      BEEP()
      MENSAGEM("Registro j  cadastrado",3)
      MENSAGEM("Tecle <ESC> para retornar")
      GOTO M->I_REG
      RETURN .F.
   ELSE
      M->AL_TERA=.T.
      CLEAR GETS
      SET ORDER TO M->ORDEM
      RETURN .T.
   ENDIF
ENDIF
SET ORDER TO M->ORDEM
GOTO M->I_REG
RETURN .T.
 
FUNCTION IFU04009
IF .NOT.(.NOT.EMPTY(M->DATA_ANI)) .AND. LASTKEY()<>5
   BEEP()
   MENSAGEM("Informe a data de nascimento!",3)
   MENSAGEM("Tecle <ESC> para retornar")
   RETURN .F.
ENDIF
RETURN .T.
 
FUNCTION CARREG04
PARA R_CAR
**
** Bloco de inser‡„o I04.B14
**
PUBLIC ANIVER,ENDERECO,BAIRRO,CIDADE,ESTADO,FONE_1,FONE_2,FONE_3,DATA_ANI,DATA_INC
IF M->R_CAR=1
   M->ANIVER=SPACE( 30)
   M->ENDERECO=SPACE( 30)
   M->BAIRRO=SPACE( 30)
   M->CIDADE=SPACE( 24)
   M->ESTADO=SPACE(  2)
   M->FONE_1=SPACE( 13)
   M->FONE_2=SPACE( 13)
   M->FONE_3=SPACE( 13)
   M->DATA_ANI=CTOD("  /  /  ")
   M->DATA_INC=CTOD("  /  /  ")
   **
   ** Bloco de inser‡„o I04.B15
   **
ELSE
   M->ANIVER=ANIVER
   M->ENDERECO=ENDERECO
   M->BAIRRO=BAIRRO
   M->CIDADE=CIDADE
   M->ESTADO=ESTADO
   M->FONE_1=FONE_1
   M->FONE_2=FONE_2
   M->FONE_3=FONE_3
   M->DATA_ANI=DATA_ANI
   M->DATA_INC=DATA_INC
   **
   ** Bloco de inser‡„o I04.B16
   **
ENDIF
 
FUNCTION CARGET04
PARA R_CAR
IF R_CAR<>5
   M->AL_TERA=.F.
ENDIF
**
** Bloco de inser‡„o I04.B17
**
JANELA( 3,12,15,67,"4 - Aniversariantes")
COR("CERCADURAS")
@  4,13 TO 14,66
**
** Bloco de inser‡„o I04.B18
**
COR("GETS")
**
** Bloco de inser‡„o I04.B21
**
@  5,15 SAY "NOVO ANIVERSARIANTE" GET M->ANIVER PICTURE "@!" VALID VERI004(M->R_CAR)
@  6,15 SAY "ENDERECO          :" GET M->ENDERECO PICTURE "@!"
@  7,15 SAY "BAIRRO            :" GET M->BAIRRO PICTURE "@!"
@  8,15 SAY "CIDADE            :" GET M->CIDADE PICTURE "@!"
@  8,60 SAY "UF" GET M->ESTADO PICTURE "@!"
@  9,15 SAY "FONE (1)          :" GET M->FONE_1 PICTURE "(999)999.9999"
@ 10,15 SAY "FONE (2)          :" GET M->FONE_2 PICTURE "(999)999.9999"
@ 11,15 SAY "FONE (3)          :" GET M->FONE_3 PICTURE "(999)999.9999"
@ 12,15 SAY "NASCIMENTO        :" GET M->DATA_ANI VALID IFU04009()
@ 13,15 SAY "INCLUSAO          :" GET M->DATA_INC
**
** Bloco de inser‡„o I04.B24
**
IF M->R_CAR=5
   CLEAR GETS
   RETURN .F.
ENDIF
IF M->R_CAR=3 .OR. M->R_CAR=0
   CLEAR GETS
   IF M->R_CAR=0
      RETURN .T.
   ENDIF
   MENSAGEM("Tecle algo para continuar")
   M->R_X=INKEY(0)
   IF M->R_X=27
      RETURN .F.
   ENDIF
ELSE
   SET CURSOR ON
   READ
   SET CURSOR OFF
   IF M->AL_TERA
      RETURN .F.
   ENDIF
   IF LASTKEY()=27
      RETURN .F.
   ENDIF
ENDIF
RETURN .T.
 
FUNCTION SALVAR04
**
** Bloco de inser‡„o I04.B27
**
REPLACE ANIVER WITH M->ANIVER
REPLACE ENDERECO WITH M->ENDERECO
REPLACE BAIRRO WITH M->BAIRRO
REPLACE CIDADE WITH M->CIDADE
REPLACE ESTADO WITH M->ESTADO
REPLACE FONE_1 WITH M->FONE_1
REPLACE FONE_2 WITH M->FONE_2
REPLACE FONE_3 WITH M->FONE_3
REPLACE DATA_ANI WITH M->DATA_ANI
REPLACE DATA_INC WITH M->DATA_INC
**
** Bloco de inser‡„o I04.B28
**
 
* Final do programa UTILI04.PRG