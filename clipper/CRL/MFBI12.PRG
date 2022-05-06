
* TITULO     : *** Barreto Constru‡„o ***
* DATA       : 17/04/97
* PROGRAMA   : MFBI12.PRG
* COMENTARIO : INCLUSAO (   Loja.)
 
**
** Bloco de inser‡„o I12.B01
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
SELE 4
**
** Bloco de inser‡„o I12.B02
**
***
*** Inicio do bloco de substitui‡„o I12.B
COR("MENU")
@ LIN_MENU,00
@ LIN_MENU,01 SAY "Inclus„o ³    Loja."
M->P_VERI = .T.
M->X_VERI = .F.
M->CNF_XXX=.T.
M->IN_CLUI=.T.
DO WHILE .T.
     **
     ** Bloco de inser‡„o I12.B03
     **
     MENSAGEM("Tecle <ESC> para retornar")
     IF M->P_VERI
          **
          ** Bloco de inser‡„o I12.B04
          **
          IF M->CNF_XXX
               IF M->CNF_REP
                    M->CNF_XXX=.F.
               ENDIF
               *
               * -> Inicializa variaveis
               CARREG12(1)
          ELSE
               M->X_VERI = .T.
          ENDIF
     ELSE
          M->X_VERI = .T.
          **
          ** Bloco de inser‡„o I12.B05
          **
     ENDIF
     *
     * -> Carrega tela de cadastro
     IF CARGET12(IIF(M->AL_TERA,2,1))=.F.
          IF M->AL_TERA
               **
               ** Bloco de inser‡„o I12.B06
               **
               CARREG12(2)
               M->X_VERI = .T.
               CARGET12(5)
               BEEP()
               IF PERG("Registro j  cadastrado. Deseja alterar ?")="S"
                    **
                    ** Bloco de inser‡„o I12.B07
                    **
                    M->IN_CLUI=.F.
                    M->P_VERI=.F.
               ELSE
                    **
                    ** Bloco de inser‡„o I12.B08
                    **
                    M->AL_TERA=.F.
               ENDIF
               LOOP
          ENDIF
          **
          ** Bloco de inser‡„o I12.B09
          **
          EXIT
     ENDIF
     **
     ** Bloco de inser‡„o I12.B10
     **
     IF PERG("Confirma as informa‡”es ?")="N"
          *
          * -> Faz reedicao
          M->P_VERI = .F.
          **
          ** Bloco de inser‡„o I12.B11
          **
          LOOP
     ENDIF
     M->P_VERI = .T.
     M->X_VERI = .F.
     **
     ** Bloco de inser‡„o I12.B12
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
     *
     * -> Atualiza o banco de dados
     SALVAR12()
     COMMIT
     UNLOCK
     IF .NOT. M->IN_CLUI
          M->IN_CLUI=.T.
     ENDIF
ENDDO
RESTSCREEN(LIN_MENU+1,00,23,79,TELA_PRI)
**
** Bloco de inser‡„o I12.B13
**
*** Final do bloco de substitui‡„o I12.B
***
 
FUNCTION VERI012
*
* -> Funcao que verifica duplicidade no arquivo "APRAZOLJ"
PARA R_PARA
M->I_REG=RECN()
M->ORDEM = INDEXORD()
SET ORDER TO 1
SEEK M->NATADUPLIC
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
 
FUNCTION IFU12006
*
* -> Validacao para o campo NATADUPLIC
IF .NOT.(.NOT.EMPTY(M->NATADUPLIC)) .AND. LASTKEY()<>5
     BEEP()
     MENSAGEM("Informe o numero do documento",3)
     MENSAGEM("Tecle <ESC> para retornar")
     RETURN .F.
ENDIF
RETURN .T.
 
FUNCTION CARREG12
*
* -> Carrega variaveis para entrada ou altercao de dados
PARA R_CAR
**
** Bloco de inser‡„o I12.B14
**
PUBLIC DATAVENDA,DATAVENCI,DATAPAGAM,REFERENCIA,NOMECLIENT,NATADUPLIC,VALORVENDA,VENDEDOR,OBSERVACAO,DIGITADOR
IF M->R_CAR=1
     M->DATAVENDA=CTOD("  /  /  ")
     M->DATAVENCI=CTOD("  /  /  ")
     M->DATAPAGAM=CTOD("  /  /  ")
     M->REFERENCIA=SPACE( 14)
     M->NOMECLIENT=SPACE( 30)
     M->NATADUPLIC=SPACE( 13)
     M->VALORVENDA=0
     M->VENDEDOR=SPACE(  1)
     M->OBSERVACAO=SPACE( 30)
     M->DIGITADOR=SPACE( 20)
     **
     ** Bloco de inser‡„o I12.B15
     **
ELSE
     M->DATAVENDA=DATAVENDA
     M->DATAVENCI=DATAVENCI
     M->DATAPAGAM=DATAPAGAM
     M->REFERENCIA=REFERENCIA
     M->NOMECLIENT=NOMECLIENT
     M->NATADUPLIC=NATADUPLIC
     M->VALORVENDA=VALORVENDA
     M->VENDEDOR=VENDEDOR
     M->OBSERVACAO=OBSERVACAO
     M->DIGITADOR=DIGITADOR
     **
     ** Bloco de inser‡„o I12.B16
     **
ENDIF
 
FUNCTION CARGET12
*
* -> Formata a tela para entrada ou alteracao de dados
PARA R_CAR
IF R_CAR<>5
     M->AL_TERA=.F.
ENDIF
**
** Bloco de inser‡„o I12.B17
**
JANELA( 4,13,18,64,"   Loja.")
**
** Bloco de inser‡„o I12.B18
**
COR("GETS")
*
* -> Carrega caracteres avulsos
@  6,17 SAY "No documento"
@  9,17 SAY "Nome do cliente"
@  9,50 SAY "R$     Valor"
@ 12,17 SAY "Dta vend"
@ 12,28 SAY "Dta venc"
@ 12,39 SAY "Dta pag."
@ 15,17 SAY "Observa‡„o"
@ 15,50 SAY "N Vendedor"
**
** Bloco de inser‡„o I12.B21
**
*
* -> Monta tela de cadastro
@  7,17 GET M->NATADUPLIC PICTURE "@!" VALID IFU12006() .AND.  VERI012(M->R_CAR)
@ 10,17 GET M->NOMECLIENT PICTURE "@!"
@ 10,50 GET M->VALORVENDA PICTURE "@Z 9,999,999.99"
@ 13,17 GET M->DATAVENDA
@ 13,28 GET M->DATAVENCI
@ 13,39 GET M->DATAPAGAM
@ 16,17 GET M->OBSERVACAO PICTURE "@!"
@ 16,50 GET M->VENDEDOR PICTURE "@!"
**
** Bloco de inser‡„o I12.B24
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
 
FUNCTION SALVAR12
*
* -> Salva o conteudo das variaveis de entrada no arquivo
**
** Bloco de inser‡„o I12.B27
**
REPLACE DATAVENDA WITH M->DATAVENDA
REPLACE DATAVENCI WITH M->DATAVENCI
REPLACE DATAPAGAM WITH M->DATAPAGAM
REPLACE REFERENCIA WITH M->REFERENCIA
REPLACE NOMECLIENT WITH M->NOMECLIENT
REPLACE NATADUPLIC WITH M->NATADUPLIC
REPLACE VALORVENDA WITH M->VALORVENDA
REPLACE VENDEDOR WITH M->VENDEDOR
REPLACE OBSERVACAO WITH M->OBSERVACAO
REPLACE DIGITADOR WITH M->DIGITADOR
**
** Bloco de inser‡„o I12.B28
**
 
* Final do programa MFBI12.PRG