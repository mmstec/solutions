
* TITULO     :  MFB - Vendas Comissisionadas e Gerais
* DATA       : 03/06/97
* PROGRAMA   : VENDAI03.PRG
* COMENTARIO : INCLUSAO ( * Grupo B < 05,06,07,08 >)
 
**
** Bloco de inser‡„o I03.B01
**
*
* -> Define o nivel de acesso
IF M->NIVEL<"2"
   BEEP()
   MENSAGEM("Acesso n„o permitido para este n¡vel de senha",3)
   RETURN
ENDIF
MENSAGEM("Aguarde abertura de arquivos")
SELE 2
IF .NOT. USEREDE("GRUP5678",.F.,10)
   BEEP()
   MENSAGEM("O arquivo GRUP5678 n„o est  dispon¡vel",3)
   RETURN
ELSE
   SET INDEX TO GRUP5002
ENDIF
SELE 2
**
** Bloco de inser‡„o I03.B02
**
***
*** Inicio do bloco de substitui‡„o I03.B
COR("MENU")
@ LIN_MENU,00
@ LIN_MENU,01 SAY "Inclus„o ³  * Grupo B < 05,06,07,08 >"
M->P_VERI = .T.
M->X_VERI = .F.
M->IN_CLUI=.T.
DO WHILE .T.
   **
   ** Bloco de inser‡„o I03.B03
   **
   MENSAGEM("Tecle <ESC> para retornar")
   IF M->P_VERI
      **
      ** Bloco de inser‡„o I03.B04
      **
      *
      * -> Inicializa variaveis
      CARREG03(1)
   ELSE
      M->X_VERI = .T.
      **
      ** Bloco de inser‡„o I03.B05
      **
   ENDIF
   *
   * -> Carrega tela de cadastro
   IF CARGET03(IIF(M->AL_TERA,2,1))=.F.
      IF M->AL_TERA
         **
         ** Bloco de inser‡„o I03.B06
         **
         CARREG03(2)
         M->X_VERI = .T.
         CARGET03(5)
         BEEP()
         IF PERG("Registro j  cadastrado. Deseja alterar ?")="S"
            **
            ** Bloco de inser‡„o I03.B07
            **
            M->IN_CLUI=.F.
            M->P_VERI=.F.
         ELSE
            **
            ** Bloco de inser‡„o I03.B08
            **
            M->AL_TERA=.F.
         ENDIF
         LOOP
      ENDIF
      **
      ** Bloco de inser‡„o I03.B09
      **
      EXIT
   ENDIF
   **
   ** Bloco de inser‡„o I03.B10
   **
   IF PERG("Confirma as informa‡”es ?")="N"
      *
      * -> Faz reedicao
      M->P_VERI = .F.
      **
      ** Bloco de inser‡„o I03.B11
      **
      LOOP
   ENDIF
   M->P_VERI = .T.
   M->X_VERI = .F.
   **
   ** Bloco de inser‡„o I03.B12
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
   SALVAR03()
   COMMIT
   UNLOCK
   IF .NOT. M->IN_CLUI
      M->IN_CLUI=.T.
   ENDIF
ENDDO
RESTSCREEN(LIN_MENU+1,00,23,79,TELA_PRI)
**
** Bloco de inser‡„o I03.B13
**
*** Final do bloco de substitui‡„o I03.B
***
 
FUNCTION VERI003
*
* -> Funcao que verifica duplicidade no arquivo "GRUP5678"
PARA R_PARA
M->I_REG=RECN()
M->ORDEM = INDEXORD()
SET ORDER TO 1
SEEK DTOS(M->DATA)
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
 
FUNCTION IFU03001
*
* -> Funcao que faz calculo com campos numericos
SETCOLOR(CONTECOR[8])
@ 10,47 SAY (M->VENDAS05*M->TAXA0005)/100 PICT "@Z 9,999,999.99"
COR("GETS")
RETURN .T.
 
FUNCTION IFU03002
*
* -> Funcao que faz calculo com campos numericos
SETCOLOR(CONTECOR[8])
@ 12,47 SAY (M->VENDAS06*M->TAXA0006)/100 PICT "@Z 9,999,999.99"
COR("GETS")
RETURN .T.
 
FUNCTION IFU03003
*
* -> Funcao que faz calculo com campos numericos
SETCOLOR(CONTECOR[8])
@ 14,47 SAY (M->VENDAS07*M->TAXA0007)/100 PICT "@Z 9,999,999.99"
COR("GETS")
RETURN .T.
 
FUNCTION IFU03004
*
* -> Funcao que faz calculo com campos numericos
SETCOLOR(CONTECOR[8])
@ 16,47 SAY (M->VENDAS08*M->TAXA0008)/100 PICT "@Z 9,999,999.99"
COR("GETS")
RETURN .T.
 
FUNCTION IFU03009
*
* -> Validacao para o campo DATA
IF .NOT.(.NOT.EMPTY(M->DATA)) .AND. LASTKEY()<>5
   BEEP()
   MENSAGEM("INFORME A DATA DE INCLUSAO",3)
   MENSAGEM("Tecle <ESC> para retornar")
   RETURN .F.
ENDIF
RETURN .T.
 
FUNCTION CARREG03
*
* -> Carrega variaveis para entrada ou altercao de dados
PARA R_CAR
**
** Bloco de inser‡„o I03.B14
**
PUBLIC VENDAS05,VENDAS06,VENDAS07,VENDAS08,TAXA0005,TAXA0006,TAXA0007,TAXA0008,DATA
IF M->R_CAR=1
   M->VENDAS05=0
   M->VENDAS06=0
   M->VENDAS07=0
   M->VENDAS08=0
   M->TAXA0005=0
   M->TAXA0006=0
   M->TAXA0007=0
   M->TAXA0008=0
   M->DATA=CTOD("  /  /  ")
**
** Bloco de inser‡„o I03.B15
**
M->DIGITADOR=M->OPERADOR
ELSE
   M->VENDAS05=VENDAS05
   M->VENDAS06=VENDAS06
   M->VENDAS07=VENDAS07
   M->VENDAS08=VENDAS08
   M->TAXA0005=TAXA0005
   M->TAXA0006=TAXA0006
   M->TAXA0007=TAXA0007
   M->TAXA0008=TAXA0008
   M->DATA=DATA
   **
   ** Bloco de inser‡„o I03.B16
   **
ENDIF
 
FUNCTION CARGET03
*
* -> Formata a tela para entrada ou alteracao de dados
PARA R_CAR
IF R_CAR<>5
   M->AL_TERA=.F.
ENDIF
**
** Bloco de inser‡„o I03.B17
**
JANELA( 4,17,20,61," * Grupo B < 05,06,07,08 >")
COR("CERCADURAS")
*
* -> Monta cercaduras
@  9,36 TO 17,45
@  9,18 TO 17,21
@  9,18 TO 17,60
@  7,18 TO 17,60
@  5,18 TO 19,60
**
** Bloco de inser‡„o I03.B18
**
COR("GETS")
*
* -> Carrega caracteres avulsos
@  8,19 SAY "No"
@  8,23 SAY "R$  VENDEDOR"
@  8,37 SAY "INDICE %"
@  8,47 SAY "TOTAL DO DIA"
@  6,19 SAY "INCLUSAO"
@ 10,19 SAY "05"
@ 12,19 SAY "06"
@ 14,19 SAY "07"
@ 16,19 SAY "08"
**
** Bloco de inser‡„o I03.B21
**
IF M->X_VERI
   IFU03001()
   IFU03002()
   IFU03003()
   IFU03004()
ENDIF
*
* -> Monta tela de cadastro
@  6,28 GET M->DATA VALID IFU03009() .AND.  VERI003(M->R_CAR)
@ 10,23 GET M->VENDAS05 PICTURE "@Z 9,999,999.99" VALID IFU03001()
@ 10,38 GET M->TAXA0005 PICTURE "@Z 9.99"
@ 12,23 GET M->VENDAS06 PICTURE "@Z 9,999,999.99" VALID IFU03002()
@ 12,38 GET M->TAXA0006 PICTURE "@Z 9.99"
@ 14,23 GET M->VENDAS07 PICTURE "@Z 9,999,999.99" VALID IFU03003()
@ 14,38 GET M->TAXA0007 PICTURE "@Z 9.99"
@ 16,23 GET M->VENDAS08 PICTURE "@Z 9,999,999.99" VALID IFU03004()
@ 16,38 GET M->TAXA0008 PICTURE "@Z 9.99"
**
** Bloco de inser‡„o I03.B24
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
 
FUNCTION SALVAR03
*
* -> Salva o conteudo das variaveis de entrada no arquivo
**
** Bloco de inser‡„o I03.B27
**
REPLACE VENDAS05 WITH M->VENDAS05
REPLACE VENDAS06 WITH M->VENDAS06
REPLACE VENDAS07 WITH M->VENDAS07
REPLACE VENDAS08 WITH M->VENDAS08
REPLACE TAXA0005 WITH M->TAXA0005
REPLACE TAXA0006 WITH M->TAXA0006
REPLACE TAXA0007 WITH M->TAXA0007
REPLACE TAXA0008 WITH M->TAXA0008
REPLACE DATA WITH M->DATA
**
** Bloco de inser‡„o I03.B28
**
 
* Final do programa VENDAI03.PRG