
* TITULO     :  MFB - Vendas Comissisionadas e Gerais
* DATA       : 03/06/97
* PROGRAMA   : VENDAI05.PRG
* COMENTARIO : INCLUSAO ( * Venda pela LOJA-)
 
**
** Bloco de inser‡„o I05.B01
**
*
* -> Define o nivel de acesso
IF M->NIVEL<"2"
   BEEP()
   MENSAGEM("Acesso n„o permitido para este n¡vel de senha",3)
   RETURN
ENDIF
MENSAGEM("Aguarde abertura de arquivos")
SELE 4
IF .NOT. USEREDE("VENDASLJ",.F.,10)
   BEEP()
   MENSAGEM("O arquivo VENDASLJ n„o est  dispon¡vel",3)
   RETURN
ELSE
   SET INDEX TO VENDA004
ENDIF
SELE 4
**
** Bloco de inser‡„o I05.B02
**
***
*** Inicio do bloco de substitui‡„o I05.B
COR("MENU")
@ LIN_MENU,00
@ LIN_MENU,01 SAY "Inclus„o ³  * Venda pela LOJA"
M->P_VERI = .T.
M->X_VERI = .F.
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
      *
      * -> Inicializa variaveis
      CARREG05(1)
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
* -> Funcao que verifica duplicidade no arquivo "VENDASLJ"
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
 
FUNCTION IFU05001
*
* -> Funcao que faz calculo com campos numericos
SETCOLOR(CONTECOR[8])
@ 15,32 SAY M->FIADO+M->AVISTA PICT "@Z 9,999,999.99"
COR("GETS")
RETURN .T.
 
FUNCTION IFU05003
*
* -> Funcao que faz calculo com campos numericos
SETCOLOR(CONTECOR[8])
@ 15,48 SAY M->FIADO+M->AVISTA-M->RECEBIMENO PICT "@Z 9,999,999.99"
COR("GETS")
RETURN .T.
 
FUNCTION IFU05004
*
* -> Validacao para o campo DATA
IF .NOT.(.NOT.EMPTY(M->DATA)) .AND. LASTKEY()<>5
   BEEP()
   MENSAGEM("INFORME A DATA PARA PROCESSAMENTO",3)
   MENSAGEM("Tecle <ESC> para retornar")
   RETURN .F.
ENDIF
RETURN .T.
 
FUNCTION CARREG05
*
* -> Carrega variaveis para entrada ou altercao de dados
PARA R_CAR
**
** Bloco de inser‡„o I05.B14
**
PUBLIC FIADO,AVISTA,RECEBIMENO,DATA
IF M->R_CAR=1
   M->FIADO=0
   M->AVISTA=0
   M->RECEBIMENO=0
   M->DATA=CTOD("  /  /  ")
**
** Bloco de inser‡„o I05.B15
**
M->DIGITADOR=M->OPERADOR
ELSE
   M->FIADO=FIADO
   M->AVISTA=AVISTA
   M->RECEBIMENO=RECEBIMENO
   M->DATA=DATA
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
JANELA( 6,13,17,62," * Venda pela LOJA")
COR("CERCADURAS")
*
* -> Monta cercaduras
@ 10,30 TO 16,45
@ 10,14 TO 16,61
@ 13,15 TO 13,59
@  7,14 TO 16,61
**
** Bloco de inser‡„o I05.B18
**
COR("GETS")
*
* -> Carrega caracteres avulsos
@ 11,16 SAY "VENDA  FIADO"
@ 11,32 SAY "VENDA  VISTA"
@ 11,48 SAY "RECEBIMENTOS"
@ 14,32 SAY "TOTAL VENDAS"
@ 14,48 SAY "TOTAL  SALDO"
@  8,16 SAY "INCLUSAO"
**
** Bloco de inser‡„o I05.B21
**
IF M->X_VERI
   IFU05001()
   IFU05003()
ENDIF
*
* -> Monta tela de cadastro
@  9,16 GET M->DATA VALID IFU05004() .AND.  VERI005(M->R_CAR)
@ 12,16 GET M->FIADO PICTURE "@Z 9,999,999.99" VALID IFU05001()
@ 12,32 GET M->AVISTA PICTURE "@Z 9,999,999.99"
@ 12,48 GET M->RECEBIMENO PICTURE "@Z 9,999,999.99" VALID IFU05003()
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
REPLACE FIADO WITH M->FIADO
REPLACE AVISTA WITH M->AVISTA
REPLACE RECEBIMENO WITH M->RECEBIMENO
REPLACE DATA WITH M->DATA
**
** Bloco de inser‡„o I05.B28
**
 
* Final do programa VENDAI05.PRG