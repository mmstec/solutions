
* TITULO     :  Recupera‡„o de Inadiplencia
* DATA       : 28/02/97
* PROGRAMA   : NAOPGI01.PRG
* COMENTARIO : INCLUSAO (1.Inadiplentes)
 
**
** Bloco de inser‡„o I01.B01
**
MENSAGEM("Aguarde abertura de arquivos")
SELE 1
IF .NOT. USEREDE("VEND_NPG",.F.,10)
   BEEP()
   MENSAGEM("O arquivo VEND_NPG n„o est  dispon¡vel",3)
   RETURN
ELSE
   SET INDEX TO VEND_001,VEND_002,VEND_003
ENDIF
SELE 1
**
** Bloco de inser‡„o I01.B02
**
***
*** Inicio do bloco de substitui‡„o I01.B
COR("MENU")
@ LIN_MENU,00
@ LIN_MENU,01 SAY "Inclus„o ³ 1.Inadiplentes"
M->P_VERI = .T.
M->X_VERI = .F.
DO WHILE .T.
   **
   ** Bloco de inser‡„o I01.B03
   **
   MENSAGEM("Tecle <ESC> para retornar")
   IF M->P_VERI
      **
      ** Bloco de inser‡„o I01.B04
      **
      *
      * -> Inicializa variaveis
      CARREG01(1)
   ELSE
      M->X_VERI = .T.
      **
      ** Bloco de inser‡„o I01.B05
      **
   ENDIF
   *
   * -> Carrega tela de cadastro
   IF CARGET01(1)=.F.
      EXIT
   ENDIF
   **
   ** Bloco de inser‡„o I01.B10
   **
   IF PERG("Confirma as informa‡”es ?")="N"
      *
      * -> Faz reedicao
      M->P_VERI = .F.
      **
      ** Bloco de inser‡„o I01.B11
      **
      LOOP
   ENDIF
   M->P_VERI = .T.
   M->X_VERI = .F.
   **
   ** Bloco de inser‡„o I01.B12
   **
   IF .NOT. ADIREG(0)
      M->P_VERI=.F.
      MENSAGEM("Inclus„o n„o foi bem sucedida",3)
      MENSAGEM("Tecle <ESC> para retornar")
      LOOP
   ENDIF
   *
   * -> Atualiza o banco de dados
   SALVAR01()
   COMMIT
   UNLOCK
ENDDO
RESTSCREEN(LIN_MENU+1,00,23,79,TELA_PRI)
**
** Bloco de inser‡„o I01.B13
**
*** Final do bloco de substitui‡„o I01.B
***
 
FUNCTION IFU01001
*
* -> Funcao que cria uma tabela para o campo "VENDEDOR"
DECLARE I_TEM[5] , RESUL_T[5]
I_TEM[1] = "1"
RESUL_T[1] = ":Resp. Lourildo"
I_TEM[2] = "2"
RESUL_T[2] = ":Resp. Marcio"+SPACE(2)
I_TEM[3] = "3"
RESUL_T[3] = ":Resp. Marcia"+SPACE(2)
I_TEM[4] = "4"
RESUL_T[4] = ":Resp. Miguel"+SPACE(2)
I_TEM[5] = "5"
RESUL_T[5] = ":Resp. Outros"+SPACE(2)
SETCOLOR(CONTECOR[8])
FOR M->PO_S = 5 TO 1 STEP -1
   IF M->VENDEDOR = I_TEM[PO_S]
      @  9,31 SAY RESUL_T[PO_S]
      M->PO_S = -1
   ENDIF
NEXT
IF M->PO_S = 0
   @  9,31 SAY SPACE(15)
   IF LEN(READVAR())<>0
      DECLARE BAR_RA[5]
      FOR M->PO_S = 1 TO 5
         BAR_RA[M->PO_S] = " [" + I_TEM[M->PO_S] + "]  " + RESUL_T[M->PO_S]
      NEXT
      C_TAB=C_SOM
      L_TAB=L_SOM
      SOMBRA(L_SOM,C_SOM,.T.)
      SAVE SCREEN TO M->T_ELA
      JANELA(06,23,18,56)
      COR("MENU")
      @ 09,28 CLEAR TO 15,51
      KEYBOARD CHR(65)
      M->PO_S=ACHOICE(10,29,14,50,BAR_RA)
      RESTORE SCREEN FROM M->T_ELA
      SOMBRA(L_TAB,C_TAB)
      IF M->PO_S <> 0
         M->VENDEDOR = I_TEM[M->PO_S]
         SETCOLOR(CONTECOR[8])
         @  9,31 SAY RESUL_T[M->PO_S]
      ENDIF
      COR("GETS")
      RETURN .F.
   ENDIF
ENDIF
RETURN .T.
 
FUNCTION CARREG01
*
* -> Carrega variaveis para entrada ou altercao de dados
PARA R_CAR
**
** Bloco de inser‡„o I01.B14
**
PUBLIC VENDEDOR,DOCUMENTO,CLIENTE,VALORSJURO,VALORCJURO,CIMENTO,PAGO_NAOPG,OBSERVACAO
IF M->R_CAR=1
   M->VENDEDOR=SPACE(  1)
   M->DOCUMENTO=SPACE( 10)
   M->CLIENTE=SPACE( 30)
   M->VALORSJURO=0
   M->VALORCJURO=0
   M->CIMENTO=0
   M->PAGO_NAOPG=CTOD("  /  /  ")
   M->OBSERVACAO=SPACE( 30)
   **
   ** Bloco de inser‡„o I01.B15
   **
ELSE
   M->VENDEDOR=VENDEDOR
   M->DOCUMENTO=DOCUMENTO
   M->CLIENTE=CLIENTE
   M->VALORSJURO=VALORSJURO
   M->VALORCJURO=VALORCJURO
   M->CIMENTO=CIMENTO
   M->PAGO_NAOPG=PAGO_NAOPG
   M->OBSERVACAO=OBSERVACAO
   **
   ** Bloco de inser‡„o I01.B16
   **
ENDIF
 
FUNCTION CARGET01
*
* -> Formata a tela para entrada ou alteracao de dados
PARA R_CAR
**
** Bloco de inser‡„o I01.B17
**
JANELA( 7,13,16,64,"1.Inadiplentes")
**
** Bloco de inser‡„o I01.B18
**
COR("GETS")
**
** Bloco de inser‡„o I01.B21
**
IF M->X_VERI
   IFU01001()
ENDIF
*
* -> Monta tela de cadastro
@  9,15 SAY "Vendedor   :" GET M->VENDEDOR PICTURE "@!" VALID IFU01001()
@ 10,15 SAY "Ducumento  :" GET M->DOCUMENTO PICTURE "@!"
@ 11,15 SAY "Cliente    :" GET M->CLIENTE PICTURE "@!"
@ 12,15 SAY "R$ S/juros :" GET M->VALORSJURO PICTURE "@E 9,999,999.99"
@ 13,15 SAY "R$ C/juros :" GET M->VALORCJURO PICTURE "@E 9,999,999.99"
@ 14,15 SAY "R$ Cimento :" GET M->CIMENTO PICTURE "@E 9,999,999.99"
**
** Bloco de inser‡„o I01.B24
**
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
   IF LASTKEY()=27
      RETURN .F.
   ENDIF
ENDIF
RETURN .T.
 
FUNCTION SALVAR01
*
* -> Salva o conteudo das variaveis de entrada no arquivo
**
** Bloco de inser‡„o I01.B27
**
REPLACE VENDEDOR WITH M->VENDEDOR
REPLACE DOCUMENTO WITH M->DOCUMENTO
REPLACE CLIENTE WITH M->CLIENTE
REPLACE VALORSJURO WITH M->VALORSJURO
REPLACE VALORCJURO WITH M->VALORCJURO
REPLACE CIMENTO WITH M->CIMENTO
REPLACE PAGO_NAOPG WITH M->PAGO_NAOPG
REPLACE OBSERVACAO WITH M->OBSERVACAO
**
** Bloco de inser‡„o I01.B28
**
 
* Final do programa NAOPGI01.PRG