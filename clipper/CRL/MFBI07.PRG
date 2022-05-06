
* TITULO     : *** Barreto Constru‡„o ***
* DATA       : 17/04/97
* PROGRAMA   : MFBI07.PRG
* COMENTARIO : INCLUSAO (   Vendas da Loja a prazo)
 
**
** Bloco de inser‡„o I07.B01
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
SELE 6
IF .NOT. USEREDE("FICHACLI",.F.,10)
     BEEP()
     MENSAGEM("O arquivo FICHACLI n„o est  dispon¡vel",3)
     RETURN
ELSE
     SET INDEX TO FICHA010,FICHA011
ENDIF
SELE 4
**
** Bloco de inser‡„o I07.B02
**
***
*** Inicio do bloco de substitui‡„o I07.B
COR("MENU")
@ LIN_MENU,00
@ LIN_MENU,01 SAY "Inclus„o ³    Vendas da Loja a prazo"
M->P_VERI = .T.
M->X_VERI = .F.
M->CNF_XXX=.T.
M->IN_CLUI=.T.
DO WHILE .T.
     **
     ** Bloco de inser‡„o I07.B03
     **
     MENSAGEM("Tecle <ESC> para retornar")
     IF M->P_VERI
          **
          ** Bloco de inser‡„o I07.B04
          **
          IF M->CNF_XXX
               IF M->CNF_REP
                    M->CNF_XXX=.F.
               ENDIF
               *
               * -> Inicializa variaveis
               CARREG07(1)
          ELSE
               M->X_VERI = .T.
          ENDIF
     ELSE
          M->X_VERI = .T.
          **
          ** Bloco de inser‡„o I07.B05
          **
     ENDIF
     *
     * -> Carrega tela de cadastro
     IF CARGET07(IIF(M->AL_TERA,2,1))=.F.
          IF M->AL_TERA
               **
               ** Bloco de inser‡„o I07.B06
               **
               CARREG07(2)
               M->X_VERI = .T.
               CARGET07(5)
               BEEP()
               IF PERG("Registro j  cadastrado. Deseja alterar ?")="S"
                    **
                    ** Bloco de inser‡„o I07.B07
                    **
                    M->IN_CLUI=.F.
                    M->P_VERI=.F.
               ELSE
                    **
                    ** Bloco de inser‡„o I07.B08
                    **
                    M->AL_TERA=.F.
               ENDIF
               LOOP
          ENDIF
          **
          ** Bloco de inser‡„o I07.B09
          **
          EXIT
     ENDIF
     **
     ** Bloco de inser‡„o I07.B10
     **
     IF PERG("Confirma as informa‡”es ?")="N"
          *
          * -> Faz reedicao
          M->P_VERI = .F.
          **
          ** Bloco de inser‡„o I07.B11
          **
          LOOP
     ENDIF
     M->P_VERI = .T.
     M->X_VERI = .F.
     **
     ** Bloco de inser‡„o I07.B12
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
     SALVAR07()
     COMMIT
     UNLOCK
     IF .NOT. M->IN_CLUI
          M->IN_CLUI=.T.
     ENDIF
ENDDO
RESTSCREEN(LIN_MENU+1,00,23,79,TELA_PRI)
**
** Bloco de inser‡„o I07.B13
**
*** Final do bloco de substitui‡„o I07.B
***
 
FUNCTION VERI007
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
 
FUNCTION IFU07001
*
* -> Validacao para o campo DATAVENDA
IF .NOT.(.NOT.EMPTY(M->DATAVENDA)) .AND. LASTKEY()<>5
     BEEP()
     MENSAGEM("A data da venda deve ser informada",3)
     MENSAGEM("Tecle <ESC> para retornar")
     RETURN .F.
ENDIF
RETURN .T.
 
FUNCTION IFU07002
*
* -> Validacao para o campo DATAVENCI
IF .NOT.(.NOT.EMPTY(M->DATAVENCI) .AND. M->DATAVENCI>=M->DATAVENDA) .AND. LASTKEY()<>5
     BEEP()
     MENSAGEM("O vencimento deve ser maior ou igual a data da venda",3)
     MENSAGEM("Tecle <ESC> para retornar")
     RETURN .F.
ENDIF
RETURN .T.
 
FUNCTION IFU07003
*
* -> Validacao para o campo DATAPAGAM
IF .NOT.(.NOT.EMPTY(M->DATAPAGAM)) .AND. LASTKEY()<>5
     BEEP()
     MENSAGEM("informe o No documento corretamente.",3)
     MENSAGEM("Tecle <ESC> para retornar")
     RETURN .F.
ENDIF
RETURN .T.
 
FUNCTION IFU07004
*
* -> Validacao para o campo REFERENCIA
IF .NOT.(.NOT.EMPTY(M->REFERENCIA)) .AND. LASTKEY()<>5
     BEEP()
     MENSAGEM("REF:. CPF - CGC",3)
     MENSAGEM("Tecle <ESC> para retornar")
     RETURN .F.
ENDIF
*
* -> Validacao para o campo REFERENCIA
IF .NOT.(.NOT.EMPTY(M->REFERENCIA)) .AND. LASTKEY()<>5
     BEEP()
     MENSAGEM("CPF ou CGC obrigatorio",3)
     MENSAGEM("Tecle <ESC> para retornar")
     RETURN .F.
ENDIF
RETURN .T.
 
FUNCTION IFU07005
*
* -> Validacao para o campo NOMECLIENT
IF .NOT.(.NOT.EMPTY(M->NOMECLIENT)) .AND. LASTKEY()<>5
     BEEP()
     MENSAGEM("Informe o Nome do cliente",3)
     MENSAGEM("Tecle <ESC> para retornar")
     RETURN .F.
ENDIF
*
* -> Validacao para o campo NOMECLIENT
IF .NOT.(.NOT.EMPTY(M->NOMECLIENT)) .AND. LASTKEY()<>5
     BEEP()
     MENSAGEM("O nome do cliente deve ser informado",3)
     MENSAGEM("Tecle <ESC> para retornar")
     RETURN .F.
ENDIF
RETURN .T.
 
FUNCTION IFU07006
*
* -> Validacao para o campo NATADUPLIC
IF .NOT.(.NOT.EMPTY(M->NATADUPLIC)) .AND. LASTKEY()<>5
     BEEP()
     MENSAGEM("Informe o numero do documento",3)
     MENSAGEM("Tecle <ESC> para retornar")
     RETURN .F.
ENDIF
RETURN .T.
 
FUNCTION IFU07007
*
* -> Validacao para o campo VALORVENDA
IF .NOT.(.NOT.EMPTY(M->VALORVENDA)) .AND. LASTKEY()<>5
     BEEP()
     MENSAGEM("Informe o valor corretamente",3)
     MENSAGEM("Tecle <ESC> para retornar")
     RETURN .F.
ENDIF
RETURN .T.
 
FUNCTION IFU07008
*
* -> Funcao que cria uma tabela para o campo "VENDEDOR"
DECLARE I_TEM[7] , RESUL_T[7]
I_TEM[1] = "0"
RESUL_T[1] = "Sem Comiss„o"
I_TEM[2] = "1"
RESUL_T[2] = "Lourildo"+SPACE(4)
I_TEM[3] = "2"
RESUL_T[3] = "M rcio"+SPACE(6)
I_TEM[4] = "3"
RESUL_T[4] = "M rcia"+SPACE(6)
I_TEM[5] = "4"
RESUL_T[5] = "Miguel"+SPACE(6)
I_TEM[6] = "5"
RESUL_T[6] = "Valdir"+SPACE(6)
I_TEM[7] = "6"
RESUL_T[7] = "Em teste"+SPACE(4)
SETCOLOR(CONTECOR[8])
FOR M->PO_S = 7 TO 1 STEP -1
     IF M->VENDEDOR = I_TEM[PO_S]
          @ 15,26 SAY RESUL_T[PO_S]
          M->PO_S = -1
     ENDIF
NEXT
IF M->PO_S = 0
     @ 15,26 SAY SPACE(12)
     IF LEN(READVAR())<>0
          DECLARE BAR_RA[7]
          FOR M->PO_S = 1 TO 7
               BAR_RA[M->PO_S] = " [" + I_TEM[M->PO_S] + "]  " + RESUL_T[M->PO_S]
          NEXT
          C_TAB=C_SOM
          L_TAB=L_SOM
          SOMBRA(L_SOM,C_SOM,.T.)
          SAVE SCREEN TO M->T_ELA
          JANELA(05,24,19,54)
          COR("MENU")
          @ 08,29 CLEAR TO 16,49
          KEYBOARD CHR(65)
          M->PO_S=ACHOICE(09,30,15,48,BAR_RA)
          RESTORE SCREEN FROM M->T_ELA
          SOMBRA(L_TAB,C_TAB)
          IF M->PO_S <> 0
               M->VENDEDOR = I_TEM[M->PO_S]
               SETCOLOR(CONTECOR[8])
               @ 15,26 SAY RESUL_T[M->PO_S]
          ENDIF
          COR("GETS")
          RETURN .F.
     ENDIF
ENDIF
RETURN .T.
 
FUNCTION PSQ07001
*
* -> Funcao que faz pesquisas em outro banco de dados
SELE 6
SET ORDER TO 1
SEEK M->REFERENCIA
M->RETOR_NO=.T.
IF (EOF() .AND. LASTKEY()<>5) .OR. M->TEC_F2
     M->GET_CAM=READVAR()
     IF LEN(M->GET_CAM)<>0
          EDIT_ARQ(EMPTY(M->REFERENCIA))
          EDIT_ARQ(EMPTY(M->NOMECLIENT))
          IF LASTKEY()=13
               M->REFERENCIA = CODICPFCGC
               M->NOMECLIENT = NOMECPFCGC
          ENDIF
     ENDIF
ELSE
     M->REFERENCIA = CODICPFCGC
     M->NOMECLIENT = NOMECPFCGC
ENDIF
SELE 4
RETURN M->RETOR_NO
 
FUNCTION CARREG07
*
* -> Carrega variaveis para entrada ou altercao de dados
PARA R_CAR
**
** Bloco de inser‡„o I07.B14
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
** Bloco de inser‡„o I07.B15
**
M->DIGITADOR=M->OPERADOR
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
     ** Bloco de inser‡„o I07.B16
     **
ENDIF
 
FUNCTION CARGET07
*
* -> Formata a tela para entrada ou alteracao de dados
PARA R_CAR
IF R_CAR<>5
     M->AL_TERA=.F.
ENDIF
**
** Bloco de inser‡„o I07.B17
**
JANELA( 6, 5,19,74,"   Vendas da Loja a prazo")
**
** Bloco de inser‡„o I07.B18
**
COR("GETS")
*
* -> Carrega caracteres avulsos
@  8, 8 SAY "Numero"
@ 11, 8 SAY "Cliente"
@ 11,41 SAY "Dta vend"
@ 11,51 SAY "Dta venc"
@ 14, 8 SAY "R$     valor"
@ 14,22 SAY "N   Vendedor"
@ 14,41 SAY "Observa‡„o"
@  8,24 SAY "CPF ou CGC"
**
** Bloco de inser‡„o I07.B21
**
IF M->X_VERI
     PSQ07001()
     IFU07008()
ENDIF
*
* -> Monta tela de cadastro
@  9, 8 GET M->NATADUPLIC PICTURE "@!" VALID IFU07006() .AND.  VERI007(M->R_CAR)
@  9,24 GET M->REFERENCIA PICTURE "@!" VALID PSQ07001() .AND.  IFU07004()
@ 12, 8 GET M->NOMECLIENT PICTURE "@!" VALID IFU07005()
@ 12,41 GET M->DATAVENDA VALID IFU07001()
@ 12,51 GET M->DATAVENCI VALID IFU07002()
@ 15, 8 GET M->VALORVENDA PICTURE "@Z 9,999,999.99" VALID IFU07007()
@ 15,22 GET M->VENDEDOR PICTURE "@!" VALID IFU07008()
@ 15,41 GET M->OBSERVACAO PICTURE "@!"
@ 17,29 SAY "Responsavel por dados" GET M->DIGITADOR PICTURE "@!"
**
** Bloco de inser‡„o I07.B24
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
 
FUNCTION SALVAR07
*
* -> Salva o conteudo das variaveis de entrada no arquivo
**
** Bloco de inser‡„o I07.B27
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
** Bloco de inser‡„o I07.B28
**
 
* Final do programa MFBI07.PRG