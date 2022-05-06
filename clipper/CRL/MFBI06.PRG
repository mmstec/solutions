
* TITULO     : *** Barreto Constru‡„o ***
* DATA       : 17/04/97
* PROGRAMA   : MFBI06.PRG
* COMENTARIO : INCLUSAO (   Vendas de cimento a vista-)
 
**
** Bloco de inser‡„o I06.B01
**
MENSAGEM("Aguarde abertura de arquivos")
SELE 1
IF .NOT. USEREDE("AVISTACM",.F.,10)
     BEEP()
     MENSAGEM("O arquivo AVISTACM n„o est  dispon¡vel",3)
     RETURN
ELSE
     SET INDEX TO AVIST001
ENDIF
SELE 1
**
** Bloco de inser‡„o I06.B02
**
***
*** Inicio do bloco de substitui‡„o I06.B
COR("MENU")
@ LIN_MENU,00
@ LIN_MENU,01 SAY "Inclus„o ³    Vendas de cimento a vista"
M->P_VERI = .T.
M->X_VERI = .F.
M->CNF_XXX=.T.
M->IN_CLUI=.T.
DO WHILE .T.
     **
     ** Bloco de inser‡„o I06.B03
     **
     MENSAGEM("Tecle <ESC> para retornar")
     IF M->P_VERI
          **
          ** Bloco de inser‡„o I06.B04
          **
          IF M->CNF_XXX
               IF M->CNF_REP
                    M->CNF_XXX=.F.
               ENDIF
               *
               * -> Inicializa variaveis
               CARREG06(1)
          ELSE
               M->X_VERI = .T.
          ENDIF
     ELSE
          M->X_VERI = .T.
          **
          ** Bloco de inser‡„o I06.B05
          **
     ENDIF
     *
     * -> Carrega tela de cadastro
     IF CARGET06(IIF(M->AL_TERA,2,1))=.F.
          IF M->AL_TERA
               **
               ** Bloco de inser‡„o I06.B06
               **
               CARREG06(2)
               M->X_VERI = .T.
               CARGET06(5)
               BEEP()
               IF PERG("Registro j  cadastrado. Deseja alterar ?")="S"
                    **
                    ** Bloco de inser‡„o I06.B07
                    **
                    M->IN_CLUI=.F.
                    M->P_VERI=.F.
               ELSE
                    **
                    ** Bloco de inser‡„o I06.B08
                    **
                    M->AL_TERA=.F.
               ENDIF
               LOOP
          ENDIF
          **
          ** Bloco de inser‡„o I06.B09
          **
          EXIT
     ENDIF
     **
     ** Bloco de inser‡„o I06.B10
     **
     IF PERG("Confirma as informa‡”es ?")="N"
          *
          * -> Faz reedicao
          M->P_VERI = .F.
          **
          ** Bloco de inser‡„o I06.B11
          **
          LOOP
     ENDIF
     M->P_VERI = .T.
     M->X_VERI = .F.
     **
     ** Bloco de inser‡„o I06.B12
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
     SALVAR06()
     COMMIT
     UNLOCK
     IF .NOT. M->IN_CLUI
          M->IN_CLUI=.T.
     ENDIF
ENDDO
RESTSCREEN(LIN_MENU+1,00,23,79,TELA_PRI)
**
** Bloco de inser‡„o I06.B13
**
*** Final do bloco de substitui‡„o I06.B
***
 
FUNCTION VERI006
*
* -> Funcao que verifica duplicidade no arquivo "AVISTACM"
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
 
FUNCTION IFU06001
*
* -> Validacao para o campo DATA
IF .NOT.(.NOT.EMPTY(M->DATA)) .AND. LASTKEY()<>5
     BEEP()
     MENSAGEM("Informe a data",3)
     MENSAGEM("Tecle <ESC> para retornar")
     RETURN .F.
ENDIF
RETURN .T.
 
FUNCTION IFU06003
*
* -> Validacao para o campo NATADUPLIC
IF .NOT.(.NOT.EMPTY(M->NATADUPLIC)) .AND. LASTKEY()<>5
     BEEP()
     MENSAGEM("Documento nao vazio",3)
     MENSAGEM("Tecle <ESC> para retornar")
     RETURN .F.
ENDIF
RETURN .T.
 
FUNCTION IFU06004
*
* -> Validacao para o campo QUANTSACOS
IF .NOT.(.NOT.EMPTY(M->QUANTSACOS)) .AND. LASTKEY()<>5
     BEEP()
     MENSAGEM("Informe a quantidade de sacos",3)
     MENSAGEM("Tecle <ESC> para retornar")
     RETURN .F.
ENDIF
RETURN .T.
 
FUNCTION IFU06005
*
* -> Validacao para o campo VALORUNITA
IF .NOT.(.NOT.EMPTY(M->VALORUNITA)) .AND. LASTKEY()<>5
     BEEP()
     MENSAGEM("Informe o valor unitario",3)
     MENSAGEM("Tecle <ESC> para retornar")
     RETURN .F.
ENDIF
RETURN .T.
 
FUNCTION IFU06006
*
* -> Funcao que faz calculo com campos numericos
M->VALORVENDA = M->QUANTSACOS*M->VALORUNITA
COR("GETS")
RETURN .T.
 
FUNCTION IFU06007
*
* -> Funcao que cria uma tabela para o campo "VENDEDOR"
DECLARE I_TEM[7] , RESUL_T[7]
I_TEM[1] = "0"
RESUL_T[1] = "SEM COMISSAO"
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
RESUL_T[7] = "Outros"+SPACE(6)
SETCOLOR(CONTECOR[8])
FOR M->PO_S = 7 TO 1 STEP -1
     IF M->VENDEDOR = I_TEM[PO_S]
          @ 16,52 SAY RESUL_T[PO_S]
          M->PO_S = -1
     ENDIF
NEXT
IF M->PO_S = 0
     @ 16,52 SAY SPACE(12)
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
               @ 16,52 SAY RESUL_T[M->PO_S]
          ENDIF
          COR("GETS")
          RETURN .F.
     ENDIF
ENDIF
RETURN .T.
 
FUNCTION CARREG06
*
* -> Carrega variaveis para entrada ou altercao de dados
PARA R_CAR
**
** Bloco de inser‡„o I06.B14
**
PUBLIC OP,DATA,NOMECLIENT,NATADUPLIC,QUANTSACOS,VALORUNITA,VALORVENDA,VENDEDOR,OBSERVACAO
M->OP=""
IF M->R_CAR=1
     M->DATA=CTOD("  /  /  ")
     M->NOMECLIENT=SPACE( 30)
     M->NATADUPLIC=SPACE( 13)
     M->QUANTSACOS=0
     M->VALORUNITA=0
     M->VALORVENDA=0
     M->VENDEDOR=SPACE(  1)
     M->OBSERVACAO=SPACE( 30)
**
** Bloco de inser‡„o I06.B15
**
M->DIGITADOR=M->OPERADOR
ELSE
     M->DATA=DATA
     M->NOMECLIENT=NOMECLIENT
     M->NATADUPLIC=NATADUPLIC
     M->QUANTSACOS=QUANTSACOS
     M->VALORUNITA=VALORUNITA
     M->VALORVENDA=VALORVENDA
     M->VENDEDOR=VENDEDOR
     M->OBSERVACAO=OBSERVACAO
     **
     ** Bloco de inser‡„o I06.B16
     **
ENDIF
 
FUNCTION CARGET06
*
* -> Formata a tela para entrada ou alteracao de dados
PARA R_CAR
IF R_CAR<>5
     M->AL_TERA=.F.
ENDIF
**
** Bloco de inser‡„o I06.B17
**
JANELA( 4, 8,18,67,"   Vendas de cimento a vista")
**
** Bloco de inser‡„o I06.B18
**
COR("GETS")
*
* -> Carrega caracteres avulsos
@  6,23 SAY "No Documento"
@  6,13 SAY "Data"
@  9,13 SAY "Nome do comprador"
@ 12,13 SAY "R$  unit rio"
@ 12,33 SAY "Qde  sacos"
@ 12,50 SAY "Valor  venda"
@ 15,13 SAY "Observa‡oes"
@ 15,50 SAY "N Vendedor"
**
** Bloco de inser‡„o I06.B21
**
IF M->X_VERI
     IFU06006()
     IFU06007()
ENDIF
*
* -> Monta tela de cadastro
@  7,13 GET M->DATA VALID IFU06001()
@  7,23 GET M->NATADUPLIC PICTURE "@!" VALID IFU06003() .AND.  VERI006(M->R_CAR)
@ 10,13 GET M->NOMECLIENT PICTURE "@!"
@ 13,13 GET M->VALORUNITA PICTURE "@Z 9,999,999.99" VALID IFU06005()
@ 13,33 GET M->QUANTSACOS PICTURE "@Z 9999999.99" VALID IFU06004()
@ 13,50 GET M->VALORVENDA PICTURE "@Z 9,999,999.99" VALID IFU06006()
@ 16,13 GET M->OBSERVACAO
@ 16,50 GET M->VENDEDOR PICTURE "@!" VALID IFU06007()
**
** Bloco de inser‡„o I06.B24
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
 
FUNCTION SALVAR06
*
* -> Salva o conteudo das variaveis de entrada no arquivo
**
** Bloco de inser‡„o I06.B27
**
REPLACE DATA WITH M->DATA
REPLACE NOMECLIENT WITH M->NOMECLIENT
REPLACE NATADUPLIC WITH M->NATADUPLIC
REPLACE QUANTSACOS WITH M->QUANTSACOS
REPLACE VALORUNITA WITH M->VALORUNITA
REPLACE VALORVENDA WITH M->VALORVENDA
REPLACE VENDEDOR WITH M->VENDEDOR
REPLACE OBSERVACAO WITH M->OBSERVACAO
**
** Bloco de inser‡„o I06.B28
**
 
* Final do programa MFBI06.PRG