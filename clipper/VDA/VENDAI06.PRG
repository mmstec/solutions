
* TITULO     :  MFB - Vendas Comissisionadas e Gerais
* DATA       : 03/06/97
* PROGRAMA   : VENDAI06.PRG
* COMENTARIO : INCLUSAO ( * Venda pelo CIMENTO)
 
**
** Bloco de inser‡„o I06.B01
**
*
* -> Define o nivel de acesso
IF M->NIVEL<"2"
   BEEP()
   MENSAGEM("Acesso n„o permitido para este n¡vel de senha",3)
   RETURN
ENDIF
MENSAGEM("Aguarde abertura de arquivos")
SELE 3
IF .NOT. USEREDE("VENDASCM",.F.,10)
   BEEP()
   MENSAGEM("O arquivo VENDASCM n„o est  dispon¡vel",3)
   RETURN
ELSE
   SET INDEX TO VENDA003
ENDIF
SELE 3
**
** Bloco de inser‡„o I06.B02
**
***
*** Inicio do bloco de substitui‡„o I06.B
COR("MENU")
@ LIN_MENU,00
@ LIN_MENU,01 SAY "Inclus„o ³  * Venda pelo CIMENTO"
M->P_VERI = .T.
M->X_VERI = .F.
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
      *
      * -> Inicializa variaveis
      CARREG06(1)
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
* -> Funcao que verifica duplicidade no arquivo "VENDASCM"
PARA R_PARA
M->I_REG=RECN()
M->ORDEM = INDEXORD()
SET ORDER TO 1
SEEK DTOS(M->DATA______)
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
* -> Validacao para o campo DATA______
IF .NOT.(.NOT.EMPTY(M->DATA______)) .AND. LASTKEY()<>5
   BEEP()
   MENSAGEM("INFORME A DATA DE PROCESSAMENTO",3)
   MENSAGEM("Tecle <ESC> para retornar")
   RETURN .F.
ENDIF
RETURN .T.
 
FUNCTION CARREG06
*
* -> Carrega variaveis para entrada ou altercao de dados
PARA R_CAR
**
** Bloco de inser‡„o I06.B14
**
PUBLIC DATA______,FIADO_____,QDE_SCOS_F,AVISTA____,QDE_SCOS_V,RECEBIDO__,QDE_SCOS_R,OBS_______
IF M->R_CAR=1
   M->DATA______=CTOD("  /  /  ")
   M->FIADO_____=0
   M->QDE_SCOS_F=0
   M->AVISTA____=0
   M->QDE_SCOS_V=0
   M->RECEBIDO__=0
   M->QDE_SCOS_R=0
   M->OBS_______=SPACE( 30)
**
** Bloco de inser‡„o I06.B15
**
M->DIGITADOR=M->OPERADOR
ELSE
   M->DATA______=DATA______
   M->FIADO_____=FIADO_____
   M->QDE_SCOS_F=QDE_SCOS_F
   M->AVISTA____=AVISTA____
   M->QDE_SCOS_V=QDE_SCOS_V
   M->RECEBIDO__=RECEBIDO__
   M->QDE_SCOS_R=QDE_SCOS_R
   M->OBS_______=OBS_______
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
JANELA( 7,13,16,64," * Venda pelo CIMENTO")
COR("CERCADURAS")
*
* -> Monta cercaduras
@ 10,33 TO 15,48
@ 10,14 TO 15,18
@ 10,14 TO 15,63
@  8,14 TO 15,63
**
** Bloco de inser‡„o I06.B18
**
COR("GETS")
*
* -> Carrega caracteres avulsos
@ 11,35 SAY "VENDAS VISTA"
@ 11,20 SAY "VENDAS FIADO"
@ 11,50 SAY "RECEBIMENTOS"
@ 11,16 SAY "UN"
@ 14,16 SAY "R$"
@ 12,16 SAY "SC"
**
** Bloco de inser‡„o I06.B21
**
*
* -> Monta tela de cadastro
@  9,15 SAY "INCLUSAO" GET M->DATA______ VALID IFU06001() .AND.  VERI006(M->R_CAR)
@ 12,20 GET M->QDE_SCOS_F PICTURE "@Z 999999999.99"
@ 12,35 GET M->QDE_SCOS_V PICTURE "@Z 999999999.99"
@ 12,50 GET M->QDE_SCOS_R PICTURE "@Z 999999999.99"
@ 14,20 GET M->FIADO_____ PICTURE "@Z 9,999,999.99"
@ 14,35 GET M->AVISTA____ PICTURE "@Z 9,999,999.99"
@ 14,50 GET M->RECEBIDO__ PICTURE "@Z 9,999,999.99"
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
REPLACE DATA______ WITH M->DATA______
REPLACE FIADO_____ WITH M->FIADO_____
REPLACE QDE_SCOS_F WITH M->QDE_SCOS_F
REPLACE AVISTA____ WITH M->AVISTA____
REPLACE QDE_SCOS_V WITH M->QDE_SCOS_V
REPLACE RECEBIDO__ WITH M->RECEBIDO__
REPLACE QDE_SCOS_R WITH M->QDE_SCOS_R
REPLACE OBS_______ WITH M->OBS_______
**
** Bloco de inser‡„o I06.B28
**
 
* Final do programa VENDAI06.PRG