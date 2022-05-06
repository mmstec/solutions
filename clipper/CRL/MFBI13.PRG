
* TITULO     : *** Barreto Constru‡„o ***
* DATA       : 17/04/97
* PROGRAMA   : MFBI13.PRG
* COMENTARIO : INCLUSAO (   Cimento.)
 
**
** Bloco de inser‡„o I13.B01
**
MENSAGEM("Aguarde abertura de arquivos")
SELE 3
IF .NOT. USEREDE("APRAZOCM",.F.,10)
     BEEP()
     MENSAGEM("O arquivo APRAZOCM n„o est  dispon¡vel",3)
     RETURN
ELSE
     SET INDEX TO APRAZ005,APRAZ006
ENDIF
SELE 3
**
** Bloco de inser‡„o I13.B02
**
***
*** Inicio do bloco de substitui‡„o I13.B
COR("MENU")
@ LIN_MENU,00
@ LIN_MENU,01 SAY "Inclus„o ³    Cimento."
M->P_VERI = .T.
M->X_VERI = .F.
M->CNF_XXX=.T.
M->IN_CLUI=.T.
DO WHILE .T.
     **
     ** Bloco de inser‡„o I13.B03
     **
     MENSAGEM("Tecle <ESC> para retornar")
     IF M->P_VERI
          **
          ** Bloco de inser‡„o I13.B04
          **
          IF M->CNF_XXX
               IF M->CNF_REP
                    M->CNF_XXX=.F.
               ENDIF
               *
               * -> Inicializa variaveis
               CARREG13(1)
          ELSE
               M->X_VERI = .T.
          ENDIF
     ELSE
          M->X_VERI = .T.
          **
          ** Bloco de inser‡„o I13.B05
          **
     ENDIF
     *
     * -> Carrega tela de cadastro
     IF CARGET13(IIF(M->AL_TERA,2,1))=.F.
          IF M->AL_TERA
               **
               ** Bloco de inser‡„o I13.B06
               **
               CARREG13(2)
               M->X_VERI = .T.
               CARGET13(5)
               BEEP()
               IF PERG("Registro j  cadastrado. Deseja alterar ?")="S"
                    **
                    ** Bloco de inser‡„o I13.B07
                    **
                    M->IN_CLUI=.F.
                    M->P_VERI=.F.
               ELSE
                    **
                    ** Bloco de inser‡„o I13.B08
                    **
                    M->AL_TERA=.F.
               ENDIF
               LOOP
          ENDIF
          **
          ** Bloco de inser‡„o I13.B09
          **
          EXIT
     ENDIF
     **
     ** Bloco de inser‡„o I13.B10
     **
     IF PERG("Confirma as informa‡”es ?")="N"
          *
          * -> Faz reedicao
          M->P_VERI = .F.
          **
          ** Bloco de inser‡„o I13.B11
          **
          LOOP
     ENDIF
     M->P_VERI = .T.
     M->X_VERI = .F.
     **
     ** Bloco de inser‡„o I13.B12
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
     SALVAR13()
     COMMIT
     UNLOCK
     IF .NOT. M->IN_CLUI
          M->IN_CLUI=.T.
     ENDIF
ENDDO
RESTSCREEN(LIN_MENU+1,00,23,79,TELA_PRI)
**
** Bloco de inser‡„o I13.B13
**
*** Final do bloco de substitui‡„o I13.B
***
 
FUNCTION VERI013
*
* -> Funcao que verifica duplicidade no arquivo "APRAZOCM"
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
 
FUNCTION IFU13006
*
* -> Validacao para o campo NATADUPLIC
IF .NOT.(.NOT.EMPTY(M->NATADUPLIC)) .AND. LASTKEY()<>5
     BEEP()
     MENSAGEM("Informe o numero do documento",3)
     MENSAGEM("Tecle <ESC> para retornar")
     RETURN .F.
ENDIF
RETURN .T.
 
FUNCTION CARREG13
*
* -> Carrega variaveis para entrada ou altercao de dados
PARA R_CAR
**
** Bloco de inser‡„o I13.B14
**
PUBLIC DATAVENDA,DATAVENCI,DATAPAGAM,REFERENCIA,NOMECLIENT,NATADUPLIC,QUANTSACOS,VALORUNITA,VALORVENDA,VENDEDOR
PUBLIC OBSERVACAO,DIGITADOR
IF M->R_CAR=1
     M->DATAVENDA=CTOD("  /  /  ")
     M->DATAVENCI=CTOD("  /  /  ")
     M->DATAPAGAM=CTOD("  /  /  ")
     M->REFERENCIA=SPACE( 14)
     M->NOMECLIENT=SPACE( 30)
     M->NATADUPLIC=SPACE( 13)
     M->QUANTSACOS=0
     M->VALORUNITA=0
     M->VALORVENDA=0
     M->VENDEDOR=SPACE(  1)
     M->OBSERVACAO=SPACE( 30)
     M->DIGITADOR=SPACE( 20)
     **
     ** Bloco de inser‡„o I13.B15
     **
ELSE
     M->DATAVENDA=DATAVENDA
     M->DATAVENCI=DATAVENCI
     M->DATAPAGAM=DATAPAGAM
     M->REFERENCIA=REFERENCIA
     M->NOMECLIENT=NOMECLIENT
     M->NATADUPLIC=NATADUPLIC
     M->QUANTSACOS=QUANTSACOS
     M->VALORUNITA=VALORUNITA
     M->VALORVENDA=VALORVENDA
     M->VENDEDOR=VENDEDOR
     M->OBSERVACAO=OBSERVACAO
     M->DIGITADOR=DIGITADOR
     **
     ** Bloco de inser‡„o I13.B16
     **
ENDIF
 
FUNCTION CARGET13
*
* -> Formata a tela para entrada ou alteracao de dados
PARA R_CAR
IF R_CAR<>5
     M->AL_TERA=.F.
ENDIF
**
** Bloco de inser‡„o I13.B17
**
JANELA( 4,12,21,65,"   Cimento.")
**
** Bloco de inser‡„o I13.B18
**
COR("GETS")
*
* -> Carrega caracteres avulsos
@  6,15 SAY "No documento"
@  6,34 SAY "N vendedor"
@  9,15 SAY "Nome do cliente"
@ 12,15 SAY "R$  unit rio"
@ 12,35 SAY "Qde  sacos"
@ 12,53 SAY "R$   Valor"
@ 15,15 SAY "Dta vend"
@ 15,26 SAY "Dta venc"
@ 15,36 SAY "Dta pag."
@ 18,15 SAY "Observa‡oes"
**
** Bloco de inser‡„o I13.B21
**
*
* -> Monta tela de cadastro
@  7,15 GET M->NATADUPLIC PICTURE "@!" VALID IFU13006() .AND.  VERI013(M->R_CAR)
@  7,34 GET M->VENDEDOR PICTURE "@!"
@ 10,15 GET M->NOMECLIENT PICTURE "@!"
@ 13,15 GET M->VALORUNITA PICTURE "@Z 9,999,999.99"
@ 13,35 GET M->QUANTSACOS PICTURE "@Z 9999999.99"
@ 13,53 GET M->VALORVENDA PICTURE "@Z 9999999.99"
@ 16,15 GET M->DATAVENDA
@ 16,26 GET M->DATAVENCI
@ 16,36 GET M->DATAPAGAM
@ 19,15 GET M->OBSERVACAO
**
** Bloco de inser‡„o I13.B24
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
 
FUNCTION SALVAR13
*
* -> Salva o conteudo das variaveis de entrada no arquivo
**
** Bloco de inser‡„o I13.B27
**
REPLACE DATAVENDA WITH M->DATAVENDA
REPLACE DATAVENCI WITH M->DATAVENCI
REPLACE DATAPAGAM WITH M->DATAPAGAM
REPLACE REFERENCIA WITH M->REFERENCIA
REPLACE NOMECLIENT WITH M->NOMECLIENT
REPLACE NATADUPLIC WITH M->NATADUPLIC
REPLACE QUANTSACOS WITH M->QUANTSACOS
REPLACE VALORUNITA WITH M->VALORUNITA
REPLACE VALORVENDA WITH M->VALORVENDA
REPLACE VENDEDOR WITH M->VENDEDOR
REPLACE OBSERVACAO WITH M->OBSERVACAO
REPLACE DIGITADOR WITH M->DIGITADOR
**
** Bloco de inser‡„o I13.B28
**
 
* Final do programa MFBI13.PRG