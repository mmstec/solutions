
* TITULO     : *** Barreto Constru‡„o ***
* DATA       : 17/04/97
* PROGRAMA   : MFBI02.PRG
* COMENTARIO : INCLUSAO (   Pessoa Fisica)
 
**
** Bloco de inser‡„o I02.B01
**
*
* -> Define o nivel de acesso
IF M->NIVEL<"3"
     BEEP()
     MENSAGEM("Acesso n„o permitido para este n¡vel de senha",3)
     RETURN
ENDIF
MENSAGEM("Aguarde abertura de arquivos")
SELE 6
IF .NOT. USEREDE("FICHACLI",.F.,10)
     BEEP()
     MENSAGEM("O arquivo FICHACLI n„o est  dispon¡vel",3)
     RETURN
ELSE
     SET INDEX TO FICHA010,FICHA011
ENDIF
SELE 6
**
** Bloco de inser‡„o I02.B02
**
***
*** Inicio do bloco de substitui‡„o I02.B
COR("MENU")
@ LIN_MENU,00
@ LIN_MENU,01 SAY "Inclus„o ³    Pessoa Fisica"
M->P_VERI = .T.
M->X_VERI = .F.
M->CNF_XXX=.T.
M->IN_CLUI=.T.
DO WHILE .T.
     **
     ** Bloco de inser‡„o I02.B03
     **
     MENSAGEM("Tecle <ESC> para retornar")
     IF M->P_VERI
          **
          ** Bloco de inser‡„o I02.B04
          **
          IF M->CNF_XXX
               IF M->CNF_REP
                    M->CNF_XXX=.F.
               ENDIF
               *
               * -> Inicializa variaveis
               CARREG02(1)
          ELSE
               M->X_VERI = .T.
          ENDIF
     ELSE
          M->X_VERI = .T.
          **
          ** Bloco de inser‡„o I02.B05
          **
     ENDIF
     *
     * -> Carrega tela de cadastro
     IF CARGET02(IIF(M->AL_TERA,2,1))=.F.
          IF M->AL_TERA
               **
               ** Bloco de inser‡„o I02.B06
               **
               CARREG02(2)
               M->X_VERI = .T.
               CARGET02(5)
               BEEP()
               IF PERG("Registro j  cadastrado. Deseja alterar ?")="S"
                    **
                    ** Bloco de inser‡„o I02.B07
                    **
                    M->IN_CLUI=.F.
                    M->P_VERI=.F.
               ELSE
                    **
                    ** Bloco de inser‡„o I02.B08
                    **
                    M->AL_TERA=.F.
               ENDIF
               LOOP
          ENDIF
          **
          ** Bloco de inser‡„o I02.B09
          **
          EXIT
     ENDIF
     **
     ** Bloco de inser‡„o I02.B10
     **
     IF PERG("Confirma as informa‡”es ?")="N"
          *
          * -> Faz reedicao
          M->P_VERI = .F.
          **
          ** Bloco de inser‡„o I02.B11
          **
          LOOP
     ENDIF
     M->P_VERI = .T.
     M->X_VERI = .F.
     **
     ** Bloco de inser‡„o I02.B12
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
     SALVAR02()
     COMMIT
     UNLOCK
     IF .NOT. M->IN_CLUI
          M->IN_CLUI=.T.
     ENDIF
ENDDO
RESTSCREEN(LIN_MENU+1,00,23,79,TELA_PRI)
**
** Bloco de inser‡„o I02.B13
**
*** Final do bloco de substitui‡„o I02.B
***
 
FUNCTION VERI002
*
* -> Funcao que verifica duplicidade no arquivo "FICHACLI"
PARA R_PARA
M->I_REG=RECN()
M->ORDEM = INDEXORD()
SET ORDER TO 1
SEEK M->CODICPFCGC
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
 
FUNCTION IFU02001
*
* -> Validacao para o campo CODICPFCGC
IF .NOT.(.NOT.EMPTY(M->CODICPFCGC) .AND. CIC(M->CODICPFCGC)) .AND. LASTKEY()<>5
     BEEP()
     MENSAGEM("CPF incorreto!",3)
     MENSAGEM("Tecle <ESC> para retornar")
     RETURN .F.
ENDIF
RETURN .T.
 
FUNCTION IFU02004
*
* -> Validacao para o campo NOMECPFCGC
IF .NOT.(.NOT.EMPTY(M->NOMECPFCGC)) .AND. LASTKEY()<>5
     BEEP()
     MENSAGEM("Informe o nome do Cliente Pessoa Fisica",3)
     MENSAGEM("Tecle <ESC> para retornar")
     RETURN .F.
ENDIF
RETURN .T.
 
FUNCTION IFU02010
*
* -> Funcao que cria uma tabela para o campo "ESTADO"
DECLARE I_TEM[6] , RESUL_T[6]
I_TEM[1] = "BA"
RESUL_T[1] = "Bahia"+SPACE(9)
I_TEM[2] = "SP"
RESUL_T[2] = "S„o Paulo"+SPACE(5)
I_TEM[3] = "RJ"
RESUL_T[3] = "Rio de Janeiro"
I_TEM[4] = "SC"
RESUL_T[4] = "Santa Catarina"
I_TEM[5] = "MG"
RESUL_T[5] = "Mato Grosso"+SPACE(3)
I_TEM[6] = "RN"
RESUL_T[6] = "Rio G do Norte"
SETCOLOR(CONTECOR[8])
FOR M->PO_S = 6 TO 1 STEP -1
     IF M->ESTADO = I_TEM[PO_S]
          @ 19,13 SAY RESUL_T[PO_S]
          M->PO_S = -1
     ENDIF
NEXT
IF M->PO_S = 0
     @ 19,13 SAY SPACE(14)
     IF LEN(READVAR())<>0
          DECLARE BAR_RA[6]
          FOR M->PO_S = 1 TO 6
               BAR_RA[M->PO_S] = " [" + I_TEM[M->PO_S] + "]  " + RESUL_T[M->PO_S]
          NEXT
          C_TAB=C_SOM
          L_TAB=L_SOM
          SOMBRA(L_SOM,C_SOM,.T.)
          SAVE SCREEN TO M->T_ELA
          JANELA(05,23,18,56)
          COR("MENU")
          @ 08,28 CLEAR TO 15,51
          KEYBOARD CHR(65)
          M->PO_S=ACHOICE(09,29,14,50,BAR_RA)
          RESTORE SCREEN FROM M->T_ELA
          SOMBRA(L_TAB,C_TAB)
          IF M->PO_S <> 0
               M->ESTADO = I_TEM[M->PO_S]
               SETCOLOR(CONTECOR[8])
               @ 19,13 SAY RESUL_T[M->PO_S]
          ENDIF
          COR("GETS")
          RETURN .F.
     ENDIF
ENDIF
RETURN .T.
 
FUNCTION IFU02016
*
* -> Validacao para o campo REFCOM_001
IF .NOT.(.NOT.EMPTY(M->REFCOM_001)) .AND. LASTKEY()<>5
     BEEP()
     MENSAGEM("Referencia comercial ‚ obrigatoria",3)
     MENSAGEM("Tecle <ESC> para retornar")
     RETURN .F.
ENDIF
RETURN .T.
 
FUNCTION IFU02023
*
* -> Funcao que cria uma tabela para o campo "QUALIFICAC"
DECLARE I_TEM[6] , RESUL_T[6]
I_TEM[1] = "1"
RESUL_T[1] = "Cliente Excelente"
I_TEM[2] = "2"
RESUL_T[2] = "Cliente Otimo"+SPACE(4)
I_TEM[3] = "3"
RESUL_T[3] = "Cliente Bom"+SPACE(6)
I_TEM[4] = "4"
RESUL_T[4] = "Cliente Regular"+SPACE(2)
I_TEM[5] = "5"
RESUL_T[5] = "Cliente Pessimo"+SPACE(2)
I_TEM[6] = "6"
RESUL_T[6] = "Cliente SUSPENSO"+SPACE(1)
SETCOLOR(CONTECOR[8])
FOR M->PO_S = 6 TO 1 STEP -1
     IF M->QUALIFICAC = I_TEM[PO_S]
          @ 19,31 SAY RESUL_T[PO_S]
          M->PO_S = -1
     ENDIF
NEXT
IF M->PO_S = 0
     @ 19,31 SAY SPACE(17)
     IF LEN(READVAR())<>0
          DECLARE BAR_RA[6]
          FOR M->PO_S = 1 TO 6
               BAR_RA[M->PO_S] = " [" + I_TEM[M->PO_S] + "]  " + RESUL_T[M->PO_S]
          NEXT
          C_TAB=C_SOM
          L_TAB=L_SOM
          SOMBRA(L_SOM,C_SOM,.T.)
          SAVE SCREEN TO M->T_ELA
          JANELA(05,22,18,57)
          COR("MENU")
          @ 08,27 CLEAR TO 15,52
          KEYBOARD CHR(65)
          M->PO_S=ACHOICE(09,28,14,51,BAR_RA)
          RESTORE SCREEN FROM M->T_ELA
          SOMBRA(L_TAB,C_TAB)
          IF M->PO_S <> 0
               M->QUALIFICAC = I_TEM[M->PO_S]
               SETCOLOR(CONTECOR[8])
               @ 19,31 SAY RESUL_T[M->PO_S]
          ENDIF
          COR("GETS")
          RETURN .F.
     ENDIF
ENDIF
RETURN .T.
 
FUNCTION IFU02024
*
* -> Validacao para o campo DATAINCLUS
IF .NOT.(.NOT.EMPTY(M->DATAINCLUS)) .AND. LASTKEY()<>5
     BEEP()
     MENSAGEM("Informe a data de inclusao do cliente",3)
     MENSAGEM("Tecle <ESC> para retornar")
     RETURN .F.
ENDIF
RETURN .T.
 
FUNCTION CARREG02
*
* -> Carrega variaveis para entrada ou altercao de dados
PARA R_CAR
**
** Bloco de inser‡„o I02.B14
**
PUBLIC ME_MO,CODICPFCGC,________RG,INSCRICAOE,NOMECPFCGC,NOMEFANTAS,ENDERECO,BAIRRO,CIDADE,CEP,ESTADO
PUBLIC TELEFONE01,TELEFONE02,TELEFONE03,AVAL_NOME,AVAL_CPF,REFCOM_001,REFCOM_002,REFCOM_003,REFCOMFON1,REFCOMFON2
PUBLIC REFCOMFON3,OBSERVACAO,QUALIFICAC,DATAINCLUS,DIGITADOR
M->ME_MO = "[memo]"
IF M->R_CAR=1
     M->CODICPFCGC=SPACE( 14)
     M->________RG=SPACE( 14)
     M->INSCRICAOE=SPACE( 14)
     M->NOMECPFCGC=SPACE( 30)
     M->NOMEFANTAS=SPACE( 30)
     M->ENDERECO=SPACE( 30)
     M->BAIRRO=SPACE( 30)
     M->CIDADE=SPACE( 18)
     M->CEP=SPACE( 10)
     M->ESTADO=SPACE(  2)
     M->TELEFONE01=SPACE( 13)
     M->TELEFONE02=SPACE( 13)
     M->TELEFONE03=SPACE( 13)
     M->AVAL_NOME=SPACE( 30)
     M->AVAL_CPF=SPACE( 14)
     M->REFCOM_001=SPACE( 30)
     M->REFCOM_002=SPACE( 30)
     M->REFCOM_003=SPACE( 30)
     M->REFCOMFON1=SPACE( 13)
     M->REFCOMFON2=SPACE( 13)
     M->REFCOMFON3=SPACE( 13)
     M->OBSERVACAO=SPACE( 10)
     M->QUALIFICAC=SPACE(  1)
     M->DATAINCLUS=CTOD("  /  /  ")
     M->DIGITADOR=SPACE( 20)
**
** Bloco de inser‡„o I02.B15
**
M->DIGITADOR=M->OPERADOR
ELSE
     M->CODICPFCGC=CODICPFCGC
     M->________RG=________RG
     M->INSCRICAOE=INSCRICAOE
     M->NOMECPFCGC=NOMECPFCGC
     M->NOMEFANTAS=NOMEFANTAS
     M->ENDERECO=ENDERECO
     M->BAIRRO=BAIRRO
     M->CIDADE=CIDADE
     M->CEP=CEP
     M->ESTADO=ESTADO
     M->TELEFONE01=TELEFONE01
     M->TELEFONE02=TELEFONE02
     M->TELEFONE03=TELEFONE03
     M->AVAL_NOME=AVAL_NOME
     M->AVAL_CPF=AVAL_CPF
     M->REFCOM_001=REFCOM_001
     M->REFCOM_002=REFCOM_002
     M->REFCOM_003=REFCOM_003
     M->REFCOMFON1=REFCOMFON1
     M->REFCOMFON2=REFCOMFON2
     M->REFCOMFON3=REFCOMFON3
     M->OBSERVACAO=OBSERVACAO
     M->QUALIFICAC=QUALIFICAC
     M->DATAINCLUS=DATAINCLUS
     M->DIGITADOR=DIGITADOR
     **
     ** Bloco de inser‡„o I02.B16
     **
ENDIF
 
FUNCTION CARGET02
*
* -> Formata a tela para entrada ou alteracao de dados
PARA R_CAR
IF R_CAR<>5
     M->AL_TERA=.F.
ENDIF
**
** Bloco de inser‡„o I02.B17
**
M->PAGINA = 1
DO WHILE .T.
     *
     * -> Monta pagina 1
     IF M->PAGINA = 1
          COR("MENU")
          @ LIN_MENU,66 SAY "³ P gina : 01"
          FUNDO()
          JANELA( 4, 6,21,73,"   Pessoa Fisica")
          COR("CERCADURAS")
          *
          * -> Monta cercaduras
          @  5, 7 TO 20,72
          **
          ** Bloco de inser‡„o I02.B18
          **
          COR("GETS")
          *
          * -> Carrega caracteres avulsos
          @  6, 9 SAY "Codigo - CPF"
          @  9, 9 SAY "Registro geral"
          @  9,25 SAY "Nome do cliente"
          @ 12, 9 SAY "Apelido"
          @ 12,41 SAY "Endere‡o"
          @ 15, 9 SAY "Bairro"
          @ 15,41 SAY "Cidade /Distrito"
          @ 18, 9 SAY "UF  Estado"
          @ 18,28 SAY "Telefone"
          @ 18,43 SAY "Celular  /FAX"
          @ 18,58 SAY "Telefone /GRA"
          @ 15,61 SAY "C.E.P."
          @  6,51 SAY "Operador Respons vel"
          @ 10,59 SAY ""
          @ 10,58 SAY ""
          **
          ** Bloco de inser‡„o I02.B21
          **
          IF M->X_VERI
               IFU02010()
          ENDIF
          *
          * -> Monta tela de cadastro
          @  7, 9 GET M->CODICPFCGC PICTURE "999.999.999-99" VALID IFU02001() .AND.  VERI002(M->R_CAR)
          @  7,51 GET M->DIGITADOR PICTURE "@!"
          @ 10, 9 GET M->________RG PICTURE "99999999999999"
          @ 10,25 GET M->NOMECPFCGC PICTURE "@!" VALID IFU02004()
          @ 13, 9 GET M->NOMEFANTAS PICTURE "@!"
          @ 13,41 GET M->ENDERECO
          @ 16, 9 GET M->BAIRRO
          @ 16,41 GET M->CIDADE
          @ 16,61 GET M->CEP PICTURE "99.999-999"
          @ 19, 9 GET M->ESTADO PICTURE "@!" VALID IFU02010()
          @ 19,28 GET M->TELEFONE01 PICTURE "(999)999.9999"
          @ 19,43 GET M->TELEFONE02 PICTURE "(999)999.9999"
          @ 19,58 GET M->TELEFONE03 PICTURE "(9999)99.9999"
          **
          ** Bloco de inser‡„o I02.B24
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
               IF LASTKEY() = 27
                    RETURN .F.
               ENDIF
               IF LASTKEY() = 18
                    M->PAGINA = 1
                    M->X_VERI = .T.
                    LOOP
               ENDIF
          ENDIF
          M->PAGINA = 2
          LOOP
     ENDIF
     *
     * -> Monta pagina 2
     IF M->PAGINA = 2
          COR("MENU")
          @ LIN_MENU,66 SAY "³ P gina : 02"
          FUNDO()
          JANELA( 4,15,21,66,"   Pessoa Fisica")
          COR("CERCADURAS")
          *
          * -> Monta cercaduras
          @ 17,16 TO 20,65
          @  5,16 TO 20,65
          **
          ** Bloco de inser‡„o I02.B19
          **
          COR("GETS")
          *
          * -> Carrega caracteres avulsos
          @  6,18 SAY "Avalista"
          @  6,50 SAY "CPF"
          @  9,18 SAY "Referencia Comercial"
          @ 12,18 SAY "Referencia Comercial"
          @ 15,18 SAY "Referencia Comercial"
          @ 18,18 SAY "Observa‡„o"
          @ 18,50 SAY "Inclus„o"
          @ 15,50 SAY "Telefone"
          @ 12,50 SAY "Telefone"
          @  9,50 SAY "Telefone"
          @ 18,29 SAY "N Qualifica‡„o"
          **
          ** Bloco de inser‡„o I02.B22
          **
          IF M->X_VERI
               IFU02023()
          ENDIF
          *
          * -> Monta tela de cadastro
          @  7,18 GET M->AVAL_NOME PICTURE "@!"
          @  7,50 GET M->AVAL_CPF PICTURE "999.999.999-99"
          @ 10,18 GET M->REFCOM_001 PICTURE "@!" VALID IFU02016()
          @ 10,50 GET M->REFCOMFON1 PICTURE "(999)999.9999"
          @ 13,18 GET M->REFCOM_002 PICTURE "@!"
          @ 13,50 GET M->REFCOMFON2 PICTURE "(999)999.9999"
          @ 16,18 GET M->REFCOM_003 PICTURE "@!"
          @ 16,50 GET M->REFCOMFON3 PICTURE "(999)999.9999"
          @ 19,18 GET ME_MO PICT "9memo]" VALID EDITOR(@OBSERVACAO,"")
          @ 19,29 GET M->QUALIFICAC PICTURE "@!" VALID IFU02023()
          @ 19,50 GET M->DATAINCLUS VALID IFU02024()
          **
          ** Bloco de inser‡„o I02.B25
          **
          IF M->R_CAR=3
               CLEAR GETS
               MENSAGEM("Tecle algo para continuar")
               M->R_X=INKEY(0)
               IF M->R_X=27
                    RETURN .F.
               ENDIF
               EDITOR(OBSERVACAO,"",.F.)
          ELSE
               SET CURSOR ON
               READ
               SET CURSOR OFF
               IF LASTKEY() = 27
                    RETURN .F.
               ENDIF
               IF LASTKEY() = 18
                    M->PAGINA = 1
                    M->X_VERI = .T.
                    LOOP
               ENDIF
          ENDIF
          RETURN .T.
     ENDIF
ENDDO
 
FUNCTION SALVAR02
*
* -> Salva o conteudo das variaveis de entrada no arquivo
**
** Bloco de inser‡„o I02.B27
**
REPLACE CODICPFCGC WITH M->CODICPFCGC
REPLACE ________RG WITH M->________RG
REPLACE INSCRICAOE WITH M->INSCRICAOE
REPLACE NOMECPFCGC WITH M->NOMECPFCGC
REPLACE NOMEFANTAS WITH M->NOMEFANTAS
REPLACE ENDERECO WITH M->ENDERECO
REPLACE BAIRRO WITH M->BAIRRO
REPLACE CIDADE WITH M->CIDADE
REPLACE CEP WITH M->CEP
REPLACE ESTADO WITH M->ESTADO
REPLACE TELEFONE01 WITH M->TELEFONE01
REPLACE TELEFONE02 WITH M->TELEFONE02
REPLACE TELEFONE03 WITH M->TELEFONE03
REPLACE AVAL_NOME WITH M->AVAL_NOME
REPLACE AVAL_CPF WITH M->AVAL_CPF
REPLACE REFCOM_001 WITH M->REFCOM_001
REPLACE REFCOM_002 WITH M->REFCOM_002
REPLACE REFCOM_003 WITH M->REFCOM_003
REPLACE REFCOMFON1 WITH M->REFCOMFON1
REPLACE REFCOMFON2 WITH M->REFCOMFON2
REPLACE REFCOMFON3 WITH M->REFCOMFON3
REPLACE OBSERVACAO WITH M->OBSERVACAO
REPLACE QUALIFICAC WITH M->QUALIFICAC
REPLACE DATAINCLUS WITH M->DATAINCLUS
REPLACE DIGITADOR WITH M->DIGITADOR
**
** Bloco de inser‡„o I02.B28
**
 
* Final do programa MFBI02.PRG
