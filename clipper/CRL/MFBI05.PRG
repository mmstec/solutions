
* TITULO     : *** Barreto Constru‡„o ***
* DATA       : 17/04/97
* PROGRAMA   : MFBI05.PRG
* COMENTARIO : INCLUSAO (   Vendas da loja a vista)
 
**
** Bloco de inser‡„o I05.B01
**
MENSAGEM("Aguarde abertura de arquivos")
SELE 2
IF .NOT. USEREDE("AVISTALJ",.F.,10)
     BEEP()
     MENSAGEM("O arquivo AVISTALJ n„o est  dispon¡vel",3)
     RETURN
ELSE
     SET INDEX TO AVIST002,AVIST003,AVIST004
ENDIF
SELE 2
**
** Bloco de inser‡„o I05.B02
**
***
*** Inicio do bloco de substitui‡„o I05.B
COR("MENU")
@ LIN_MENU,00
@ LIN_MENU,01 SAY "Inclus„o ³    Vendas da loja a vista"
M->P_VERI = .T.
M->X_VERI = .F.
M->CNF_XXX=.T.
M->IN_CLUI=.T.
DO WHILE .T.
     **
     ** Bloco de inser‡„o I05.B03
     **
     MENSAGEM("Tecle <ESC> para retornar")
     IF M->P_VERI
          **
          ** Bloco de inser‡„o I05.B04
          **
          IF M->CNF_XXX
               IF M->CNF_REP
                    M->CNF_XXX=.F.
               ENDIF
               *
               * -> Inicializa variaveis
               CARREG05(1)
          ELSE
               M->X_VERI = .T.
          ENDIF
     ELSE
          M->X_VERI = .T.
          **
          ** Bloco de inser‡„o I05.B05
          **
     ENDIF
     *
     * -> Carrega tela de cadastro
     IF CARGET05(IIF(M->AL_TERA,2,1))=.F.
          IF M->AL_TERA
               **
               ** Bloco de inser‡„o I05.B06
               **
               CARREG05(2)
               M->X_VERI = .T.
               CARGET05(5)
               BEEP()
               IF PERG("Registro j  cadastrado. Deseja alterar ?")="S"
                    **
                    ** Bloco de inser‡„o I05.B07
                    **
                    M->IN_CLUI=.F.
                    M->P_VERI=.F.
               ELSE
                    **
                    ** Bloco de inser‡„o I05.B08
                    **
                    M->AL_TERA=.F.
               ENDIF
               LOOP
          ENDIF
          **
          ** Bloco de inser‡„o I05.B09
          **
          EXIT
     ENDIF
     **
     ** Bloco de inser‡„o I05.B10
     **
     IF PERG("Confirma as informa‡”es ?")="N"
          *
          * -> Faz reedicao
          M->P_VERI = .F.
          **
          ** Bloco de inser‡„o I05.B11
          **
          LOOP
     ENDIF
     M->P_VERI = .T.
     M->X_VERI = .F.
     **
     ** Bloco de inser‡„o I05.B12
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
     SALVAR05()
     COMMIT
     UNLOCK
     IF .NOT. M->IN_CLUI
          M->IN_CLUI=.T.
     ENDIF
ENDDO
RESTSCREEN(LIN_MENU+1,00,23,79,TELA_PRI)
**
** Bloco de inser‡„o I05.B13
**
*** Final do bloco de substitui‡„o I05.B
***
 
FUNCTION VERI005
*
* -> Funcao que verifica duplicidade no arquivo "AVISTALJ"
PARA R_PARA
M->I_REG=RECN()
M->ORDEM = INDEXORD()
SET ORDER TO 3
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
 
FUNCTION IFU05001
*
* -> Validacao para o campo DATA
IF .NOT.(.NOT.EMPTY(M->DATA)) .AND. LASTKEY()<>5
     BEEP()
     MENSAGEM("Data ‚ obrigatoria!",3)
     MENSAGEM("Tecle <ESC> para retornar")
     RETURN .F.
ENDIF
RETURN .T.
 
FUNCTION IFU05002
*
* -> Funcao que cria uma tabela para o campo "FORMAVENDA"
DECLARE I_TEM[3] , RESUL_T[3]
I_TEM[1] = "1"
RESUL_T[1] = "Especie"+SPACE(7)
I_TEM[2] = "2"
RESUL_T[2] = "Cheque"+SPACE(8)
I_TEM[3] = "3"
RESUL_T[3] = "Cart„o cr‚dito"
SETCOLOR(CONTECOR[8])
FOR M->PO_S = 3 TO 1 STEP -1
     IF M->FORMAVENDA = I_TEM[PO_S]
          @ 13,48 SAY RESUL_T[PO_S]
          M->PO_S = -1
     ENDIF
NEXT
IF M->PO_S = 0
     @ 13,48 SAY SPACE(14)
     IF LEN(READVAR())<>0
          DECLARE BAR_RA[3]
          FOR M->PO_S = 1 TO 3
               BAR_RA[M->PO_S] = " [" + I_TEM[M->PO_S] + "]  " + RESUL_T[M->PO_S]
          NEXT
          C_TAB=C_SOM
          L_TAB=L_SOM
          SOMBRA(L_SOM,C_SOM,.T.)
          SAVE SCREEN TO M->T_ELA
          JANELA(07,23,17,55)
          COR("MENU")
          @ 10,28 CLEAR TO 14,50
          KEYBOARD CHR(65)
          M->PO_S=ACHOICE(11,29,13,49,BAR_RA)
          RESTORE SCREEN FROM M->T_ELA
          SOMBRA(L_TAB,C_TAB)
          IF M->PO_S <> 0
               M->FORMAVENDA = I_TEM[M->PO_S]
               SETCOLOR(CONTECOR[8])
               @ 13,48 SAY RESUL_T[M->PO_S]
          ENDIF
          COR("GETS")
          RETURN .F.
     ENDIF
ENDIF
RETURN .T.
 
FUNCTION IFU05004
*
* -> Validacao para o campo NATADUPLIC
IF .NOT.(.NOT.EMPTY(M->NATADUPLIC)) .AND. LASTKEY()<>5
     BEEP()
     MENSAGEM("O No. do documento ‚ obrig torio!",3)
     MENSAGEM("Tecle <ESC> para retornar")
     RETURN .F.
ENDIF
RETURN .T.
 
FUNCTION IFU05005
*
* -> Validacao para o campo VALORVENDA
IF .NOT.(.NOT.EMPTY(M->VALORVENDA)) .AND. LASTKEY()<>5
     BEEP()
     MENSAGEM("O valor pago ‚ obrigatorio!",3)
     MENSAGEM("Tecle <ESC> para retornar")
     RETURN .F.
ENDIF
RETURN .T.
 
FUNCTION IFU05006
*
* -> Funcao que cria uma tabela para o campo "VENDEDOR"
DECLARE I_TEM[7] , RESUL_T[7]
I_TEM[1] = "0"
RESUL_T[1] = "Sem comiss„o"
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
          @ 13,32 SAY RESUL_T[PO_S]
          M->PO_S = -1
     ENDIF
NEXT
IF M->PO_S = 0
     @ 13,32 SAY SPACE(12)
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
               @ 13,32 SAY RESUL_T[M->PO_S]
          ENDIF
          COR("GETS")
          RETURN .F.
     ENDIF
ENDIF
RETURN .T.
 
FUNCTION CARREG05
*
* -> Carrega variaveis para entrada ou altercao de dados
PARA R_CAR
**
** Bloco de inser‡„o I05.B14
**
PUBLIC DATA,FORMAVENDA,NOMECLIENT,NATADUPLIC,VALORVENDA,VENDEDOR,OBSNUMERO,OBSERVACAO
IF M->R_CAR=1
     M->DATA=CTOD("  /  /  ")
     M->FORMAVENDA=SPACE(  1)
     M->NOMECLIENT=SPACE( 30)
     M->NATADUPLIC=SPACE( 13)
     M->VALORVENDA=0
     M->VENDEDOR=SPACE(  1)
     M->OBSNUMERO=SPACE( 13)
     M->OBSERVACAO=SPACE( 30)
**
** Bloco de inser‡„o I05.B15
**
M->DIGITADOR=M->OPERADOR
ELSE
     M->DATA=DATA
     M->FORMAVENDA=FORMAVENDA
     M->NOMECLIENT=NOMECLIENT
     M->NATADUPLIC=NATADUPLIC
     M->VALORVENDA=VALORVENDA
     M->VENDEDOR=VENDEDOR
     M->OBSNUMERO=OBSNUMERO
     M->OBSERVACAO=OBSERVACAO
     **
     ** Bloco de inser‡„o I05.B16
     **
ENDIF
 
FUNCTION CARGET05
*
* -> Formata a tela para entrada ou alteracao de dados
PARA R_CAR
IF R_CAR<>5
     M->AL_TERA=.F.
ENDIF
**
** Bloco de inser‡„o I05.B17
**
JANELA( 4,13,20,64,"   Vendas da loja a vista")
COR("CERCADURAS")
*
* -> Monta cercaduras
@  5,14 TO 14,63
@ 16,14 TO 19,63
**
** Bloco de inser‡„o I05.B18
**
COR("GETS")
*
* -> Carrega caracteres avulsos
@  6,16 SAY "Data"
@  9,16 SAY "No. Documento"
@  9,32 SAY "Comprador"
@ 12,16 SAY "Valor pago"
@ 12,30 SAY "N Vendedor"
@ 12,46 SAY "N Forma de venda"
@ 15,29 SAY "* Nosso controle *"
@ 17,16 SAY "Cheque/cart„o"
@ 17,32 SAY "Oberva‡„o do cheque ou cart„o"
**
** Bloco de inser‡„o I05.B21
**
IF M->X_VERI
     IFU05002()
     IFU05006()
ENDIF
*
* -> Monta tela de cadastro
@  7,16 GET M->DATA VALID IFU05001()
@ 10,16 GET M->NATADUPLIC PICTURE "@!" VALID IFU05004() .AND.  VERI005(M->R_CAR)
@ 10,32 GET M->NOMECLIENT PICTURE "@!"
@ 13,16 GET M->VALORVENDA PICTURE "@E 9,999,999.99" VALID IFU05005()
@ 13,30 GET M->VENDEDOR PICTURE "@!" VALID IFU05006()
@ 13,46 GET M->FORMAVENDA PICTURE "@!" VALID IFU05002()
@ 18,16 GET M->OBSNUMERO PICTURE "@!"
@ 18,32 GET M->OBSERVACAO
**
** Bloco de inser‡„o I05.B24
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
 
FUNCTION SALVAR05
*
* -> Salva o conteudo das variaveis de entrada no arquivo
**
** Bloco de inser‡„o I05.B27
**
REPLACE DATA WITH M->DATA
REPLACE FORMAVENDA WITH M->FORMAVENDA
REPLACE NOMECLIENT WITH M->NOMECLIENT
REPLACE NATADUPLIC WITH M->NATADUPLIC
REPLACE VALORVENDA WITH M->VALORVENDA
REPLACE VENDEDOR WITH M->VENDEDOR
REPLACE OBSNUMERO WITH M->OBSNUMERO
REPLACE OBSERVACAO WITH M->OBSERVACAO
**
** Bloco de inser‡„o I05.B28
**
 
* Final do programa MFBI05.PRG