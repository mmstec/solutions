
* TITULO     : ALGO - LIVRO DE PRECOS
* DATA       : 12/05/97
* PROGRAMA   : LIVROI02.PRG
* COMENTARIO : INCLUSAO ( Produtos)
 
**
** Bloco de inser‡„o I02.B01
**
*
* -> Define o nivel de acesso
IF M->NIVEL<"2"
     BEEP()
     MENSAGEM("Acesso n„o permitido para este n¡vel de senha",3)
     RETURN
ENDIF
MENSAGEM("Aguarde abertura de arquivos")
SELE 1
IF .NOT. USEREDE("PRODUTOS",.F.,10)
     BEEP()
     MENSAGEM("O arquivo PRODUTOS n„o est  dispon¡vel",3)
     RETURN
ELSE
     SET INDEX TO PRODU001,PRODU002,PRODU003
ENDIF
SELE 2
IF .NOT. USEREDE("GRUPOSSS",.F.,10)
     BEEP()
     MENSAGEM("O arquivo GRUPOSSS n„o est  dispon¡vel",3)
     RETURN
ELSE
     SET INDEX TO GRUPO004,GRUPO005
ENDIF
SELE 1
**
** Bloco de inser‡„o I02.B02
**
***
*** Inicio do bloco de substitui‡„o I02.B
COR("MENU")
@ LIN_MENU,00
@ LIN_MENU,01 SAY "Inclus„o ³  Produtos"
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
* -> Funcao que verifica duplicidade no arquivo "PRODUTOS"
PARA R_PARA
M->I_REG=RECN()
M->ORDEM = INDEXORD()
SET ORDER TO 3
SEEK M->REFERENCIA
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
* -> Validacao para o campo REFERENCIA
IF .NOT.(.NOT.EMPTY(M->REFERENCIA)) .AND. LASTKEY()<>5
     BEEP()
     MENSAGEM("referencia nao pode ser vazia ou repitida",3)
     MENSAGEM("Tecle <ESC> para retornar")
     RETURN .F.
ENDIF
RETURN .T.
 
FUNCTION IFU02002
*
* -> Validacao para o campo GRUPOOOOOO
IF .NOT.(.NOT.EMPTY(M->GRUPOOOOOO)) .AND. LASTKEY()<>5
     BEEP()
     MENSAGEM("INFORME UM GRUPO PARA ESTE PRODUTO",3)
     MENSAGEM("Tecle <ESC> para retornar")
     RETURN .F.
ENDIF
RETURN .T.
 
FUNCTION IFU02003
*
* -> Validacao para o campo DESCRICAOO
IF .NOT.(.NOT.EMPTY(M->DESCRICAOO)) .AND. LASTKEY()<>5
     BEEP()
     MENSAGEM("digite um descricao para este produto",3)
     MENSAGEM("Tecle <ESC> para retornar")
     RETURN .F.
ENDIF
RETURN .T.
 
FUNCTION IFU02005
*
* -> Validacao para o campo PRECOAVIST
IF .NOT.(.NOT.EMPTY(M->PRECOAVIST)) .AND. LASTKEY()<>5
     BEEP()
     MENSAGEM("Preco a vista nao pode ser vazio",3)
     MENSAGEM("Tecle <ESC> para retornar")
     RETURN .F.
ENDIF
RETURN .T.
 
FUNCTION PSQ02001
*
* -> Funcao que faz pesquisas em outro banco de dados
SELE 2
SET ORDER TO 2
SEEK M->GRUPOOOOOO
M->RETOR_NO=.T.
IF (EOF() .AND. LASTKEY()<>5) .OR. M->TEC_F2
     M->GET_CAM=READVAR()
     IF LEN(M->GET_CAM)<>0
          EDIT_ARQ(EMPTY(M->GRUPOOOOOO))
          IF LASTKEY()=13
               M->GRUPOOOOOO = DESCRICAOO
          ENDIF
     ENDIF
ELSE
     M->GRUPOOOOOO = DESCRICAOO
ENDIF
SELE 1
RETURN M->RETOR_NO
 
FUNCTION CARREG02
*
* -> Carrega variaveis para entrada ou altercao de dados
PARA R_CAR
**
** Bloco de inser‡„o I02.B14
**
PUBLIC REFERENCIA,GRUPOOOOOO,DESCRICAOO,MARCAAAAAA,PRECOAVIST,DIGITADOR
IF M->R_CAR=1
     M->REFERENCIA=SPACE( 15)
     M->GRUPOOOOOO=SPACE( 20)
     M->DESCRICAOO=SPACE( 35)
     M->MARCAAAAAA=SPACE( 10)
     M->PRECOAVIST=0
     M->DIGITADOR=SPACE( 20)
**
** Bloco de inser‡„o I02.B15
**
M->DIGITADOR=M->OPERADOR
ELSE
     M->REFERENCIA=REFERENCIA
     M->GRUPOOOOOO=GRUPOOOOOO
     M->DESCRICAOO=DESCRICAOO
     M->MARCAAAAAA=MARCAAAAAA
     M->PRECOAVIST=PRECOAVIST
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
JANELA( 5,12,19,65," Produtos")
COR("CERCADURAS")
*
* -> Monta cercaduras
@  6,13 TO 18,64
**
** Bloco de inser‡„o I02.B18
**
COR("GETS")
*
* -> Carrega caracteres avulsos
@ 10,15 SAY "REFERENCIA"
@  7,15 SAY "GRUPO   DO   PRODUTO"
@ 13,15 SAY "DESCRICAO DO PRODUTO"
@ 13,53 SAY "FABRICANTE"
@ 16,15 SAY "R$  P/ VENDA"
@ 13,28 SAY ""
@ 13,41 SAY ""
@ 16,30 SAY "RESPONSAVEL INCLUSAO"
**
** Bloco de inser‡„o I02.B21
**
IF M->X_VERI
     PSQ02001()
ENDIF
*
* -> Monta tela de cadastro
@  8,15 GET M->GRUPOOOOOO PICTURE "@!" VALID PSQ02001() .AND.  IFU02002()
@ 11,15 GET M->REFERENCIA PICTURE "@!" VALID IFU02001() .AND.  VERI002(M->R_CAR)
@ 14,15 GET M->DESCRICAOO PICTURE "@!" VALID IFU02003()
@ 14,53 GET M->MARCAAAAAA PICTURE "@!"
@ 17,15 GET M->PRECOAVIST PICTURE "@Z 9,999,999.99" VALID IFU02005()
@ 17,30 GET M->DIGITADOR PICTURE "@!"
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
     IF LASTKEY()=27
          RETURN .F.
     ENDIF
ENDIF
RETURN .T.
 
FUNCTION SALVAR02
*
* -> Salva o conteudo das variaveis de entrada no arquivo
**
** Bloco de inser‡„o I02.B27
**
REPLACE REFERENCIA WITH M->REFERENCIA
REPLACE GRUPOOOOOO WITH M->GRUPOOOOOO
REPLACE DESCRICAOO WITH M->DESCRICAOO
REPLACE MARCAAAAAA WITH M->MARCAAAAAA
REPLACE PRECOAVIST WITH M->PRECOAVIST
REPLACE DIGITADOR WITH M->DIGITADOR
**
** Bloco de inser‡„o I02.B28
**
 
* Final do programa LIVROI02.PRG