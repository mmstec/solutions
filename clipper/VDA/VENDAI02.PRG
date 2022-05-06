
* TITULO     :  MFB - Vendas Comissisionadas e Gerais
* DATA       : 03/06/97
* PROGRAMA   : VENDAI02.PRG
* COMENTARIO : INCLUSAO ( * Grupo A < 01,02,03,04 >-)
 
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
IF .NOT. USEREDE("GRUP1234",.F.,10)
   BEEP()
   MENSAGEM("O arquivo GRUP1234 n„o est  dispon¡vel",3)
   RETURN
ELSE
   SET INDEX TO GRUP1001
ENDIF
SELE 1
**
** Bloco de inser‡„o I02.B02
**
***
*** Inicio do bloco de substitui‡„o I02.B
COR("MENU")
@ LIN_MENU,00
@ LIN_MENU,01 SAY "Inclus„o ³  * Grupo A < 01,02,03,04 >"
M->P_VERI = .T.
M->X_VERI = .F.
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
      *
      * -> Inicializa variaveis
      CARREG02(1)
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
* -> Funcao que verifica duplicidade no arquivo "GRUP1234"
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
 
FUNCTION IFU02001
*
* -> Funcao que faz calculo com campos numericos
SETCOLOR(CONTECOR[8])
@ 11,45 SAY (M->VENDAS01*M->TAXA0001)/100 PICT "@Z 9,999,999.99"
COR("GETS")
RETURN .T.
 
FUNCTION IFU02002
*
* -> Funcao que faz calculo com campos numericos
SETCOLOR(CONTECOR[8])
@ 13,45 SAY (M->VENDAS02*M->TAXA0002)/100 PICT "@Z 9,999,999.99"
COR("GETS")
RETURN .T.
 
FUNCTION IFU02003
*
* -> Funcao que faz calculo com campos numericos
SETCOLOR(CONTECOR[8])
@ 15,45 SAY (M->VENDAS03*M->TAXA0003)/100 PICT "@Z 9,999,999.99"
COR("GETS")
RETURN .T.
 
FUNCTION IFU02004
*
* -> Funcao que faz calculo com campos numericos
SETCOLOR(CONTECOR[8])
@ 17,45 SAY (M->VENDAS04*M->TAXA0004)/100 PICT "@Z 9,999,999.99"
COR("GETS")
RETURN .T.
 
FUNCTION IFU02009
*
* -> Validacao para o campo DATA
IF .NOT.(.NOT.EMPTY(M->DATA)) .AND. LASTKEY()<>5
   BEEP()
   MENSAGEM("informe a data de inclusao",3)
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
PUBLIC VENDAS01,VENDAS02,VENDAS03,VENDAS04,TAXA0001,TAXA0002,TAXA0003,TAXA0004,DATA
IF M->R_CAR=1
   M->VENDAS01=0
   M->VENDAS02=0
   M->VENDAS03=0
   M->VENDAS04=0
   M->TAXA0001=0
   M->TAXA0002=0
   M->TAXA0003=0
   M->TAXA0004=0
   M->DATA=CTOD("  /  /  ")
**
** Bloco de inser‡„o I02.B15
**
M->DIGITADOR=M->OPERADOR
ELSE
   M->VENDAS01=VENDAS01
   M->VENDAS02=VENDAS02
   M->VENDAS03=VENDAS03
   M->VENDAS04=VENDAS04
   M->TAXA0001=TAXA0001
   M->TAXA0002=TAXA0002
   M->TAXA0003=TAXA0003
   M->TAXA0004=TAXA0004
   M->DATA=DATA
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
JANELA( 5,14,21,59," * Grupo A < 01,02,03,04 >")
COR("CERCADURAS")
*
* -> Monta cercaduras
@ 10,34 TO 18,43
@ 10,15 TO 18,19
@ 10,15 TO 18,58
@  8,15 TO 18,58
@  6,15 TO 20,58
**
** Bloco de inser‡„o I02.B18
**
COR("GETS")
*
* -> Carrega caracteres avulsos
@  9,17 SAY "No"
@  9,21 SAY "R$ /VENDEDOR"
@  9,36 SAY "INDICE"
@  9,45 SAY "TOTAL DO DIA"
@ 11,17 SAY "01"
@ 13,17 SAY "02"
@ 15,17 SAY "03"
@ 17,17 SAY "04"
@  7,16 SAY "INCLUSAO"
**
** Bloco de inser‡„o I02.B21
**
IF M->X_VERI
   IFU02001()
   IFU02002()
   IFU02003()
   IFU02004()
ENDIF
*
* -> Monta tela de cadastro
@  7,25 GET M->DATA VALID IFU02009() .AND.  VERI002(M->R_CAR)
@ 11,21 GET M->VENDAS01 PICTURE "@Z 9,999,999.99" VALID IFU02001()
@ 11,36 GET M->TAXA0001 PICTURE "@Z 9.99"
@ 13,21 GET M->VENDAS02 PICTURE "@Z 9,999,999.99" VALID IFU02002()
@ 13,36 GET M->TAXA0002 PICTURE "@Z 9.99"
@ 15,21 GET M->VENDAS03 PICTURE "@Z 9,999,999.99" VALID IFU02003()
@ 15,36 GET M->TAXA0003 PICTURE "@Z 9.99"
@ 17,21 GET M->VENDAS04 PICTURE "@Z 9,999,999.99" VALID IFU02004()
@ 17,36 GET M->TAXA0004 PICTURE "@Z 9.99"
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
REPLACE VENDAS01 WITH M->VENDAS01
REPLACE VENDAS02 WITH M->VENDAS02
REPLACE VENDAS03 WITH M->VENDAS03
REPLACE VENDAS04 WITH M->VENDAS04
REPLACE TAXA0001 WITH M->TAXA0001
REPLACE TAXA0002 WITH M->TAXA0002
REPLACE TAXA0003 WITH M->TAXA0003
REPLACE TAXA0004 WITH M->TAXA0004
REPLACE DATA WITH M->DATA
**
** Bloco de inser‡„o I02.B28
**
 
* Final do programa VENDAI02.PRG