
/*
TITULO     : MFB - LIVRO DE PRECOS
DATA       : 26/06/97
PROGRAMA   : LIVROFU1.PRG
COMENTARIO : FUNCOES - PARTE 1
*/

#include "LIVRO.CH"
#include "LIVROMOU.CH"
**
**BI [INI] FUN.B01
**BI [FIM] FUN.B01
**
 
FUNCTION AJUSTE
LOCAL MAXIMO, REDUCAO, MARGEM, CONTAR, CONTADOR, NUM_FORMULARIO
PARA LARGURA, FORMULARIO
IF VALTYPE( LARGURA ) = "C"
   FORMULARIO := LARGURA
   LARGURA := 150
ENDIF
REDUCAO := ""
MAXIMO := 0
IF FORMULARIO = "80"
   NUM_FORMULARIO := 1
ELSE
   NUM_FORMULARIO := 2
ENDIF
FOR CONTAR := 1 TO LEN( IMPRESSORA )
   IF LARGURA <= IMPRESSORA[ CONTAR ][ 1 ][ NUM_FORMULARIO ]
      MAXIMO := IMPRESSORA[ CONTAR ][ 1 ][ NUM_FORMULARIO ]
      FOR CONTADOR := 1 TO LEN( IMPRESSORA[ CONTAR ][ 2 ] )
         REDUCAO += CHR( IMPRESSORA[ CONTAR ][ 2 ][ CONTADOR ] )
      NEXT
      EXIT
   ENDIF
NEXT
IF FORMULARIO = "ETIQUETA"
   FOR CONTADOR := 1 TO LEN( IMPRESSORA[ REDUCAO_ETQ ][ 2 ] )
      REDUCAO += CHR( IMPRESSORA[ REDUCAO_ETQ ][ 2 ][ CONTADOR ] )
   NEXT
   ?? REDUCAO
   SET MARG TO 0
ELSE
   IF MAXIMO = 0
      @ 00, 01 SAY "SEM AJUSTE"
      RETURN .F.
   ENDIF
   MARGEM := INT( ( MAXIMO - LARGURA ) / 2 ) + relatorio:COL_INICIAL - 1
   SET MARG TO MARGEM
   @ PROW(), PCOL() + 1 SAY REDUCAO
ENDIF
RETURN .T.
 
FUNCTION GETREADER( GET )
LOCAL TECLA, BO_TAO, COL, LIN
IF ( GETPREVALIDADE( GET ) )
   GET:SETFOCUS()
   WHILE ( GET:EXITSTATE == GE_NOEXIT )
      IF ( GET:TYPEOUT )
         GET:EXITSTATE := GE_ENTER
      ENDIF
      WHILE ( GET:EXITSTATE == GE_NOEXIT )
         WHILE( TECLA := INKEY() ) == 0
            MOUSE( @BO_TAO, @LIN, @COL )
            IF BO_TAO = M_ESQUERDO .OR. BO_TAO = M_OS_DOIS
               DADO_CUR := SUBS( SAVESCREEN( LIN, COL, LIN, COL ), 1, 1 )
               IF DADO_CUR = CHR( 254 ) .OR. BO_TAO = M_OS_DOIS
                  KEYBOARD CHR( T_ESC )
                  TECLA := INKEY( 0 )
               ELSEIF LIN = 24 .AND. ( COL >= 71 .AND. COL <= 78 )
                  TECLA := T_F1
               ELSE
                  BEEP_MOUSE()
                  LOOP
               ENDIF
               EXIT
            ELSEIF BO_TAO = M_DIREITO
               KEYBOARD CHR( T_ENTER )
               TECLA := INKEY( 0 )
               EXIT
            ENDIF
         ENDDO
         MOUSE( DESLIGA )
         GETAPPLYKEY( GET, TECLA )
         MOUSE( LIGA )
      ENDDO
      IF ( !GETPOSTVALIDADE( GET ) )
         GET:EXITSTATE := GE_NOEXIT
      ENDIF
   ENDDO
   GET:KILLFOCUS()
ENDIF
RETURN NIL

FUNCTION MOUSE( BOTAO, LIN, COL )
LOCAL REGISTRADORES := {}, NUM_PAR := PCOUNT()
IF NUM_PAR = 0
   REGISTRADORES := { M_INICIALIZA, 0, 0, 0, 0, 0, 0 }
ELSEIF NUM_PAR = 1
   IF BOTAO = LIGA
      REGISTRADORES := { M_CURSOR_ON, 0, 0, 0, 0, 0, 0 }
   ELSE
      REGISTRADORES := { M_CURSOR_OFF, 0, 0, 0, 0, 0, 0 }
   ENDIF
ELSEIF NUM_PAR = 2
   REGISTRADORES := { M_POS_CURSOR, 0, LIN * 8, BOTAO * 8, 0, 0, 0 }
ELSEIF NUM_PAR = 3
   REGISTRADORES := { M_LER_STATUS, 0, 0, 0, 0, 0, 0 }
ELSE
   RETURN NIL
ENDIF
cint86( M_INTERRUPCAO, REGISTRADORES, REGISTRADORES )
IF NUM_PAR = 0
   RETURN REGISTRADORES[ AX ] = -1
ELSEIF NUM_PAR = 3
   BOTAO := REGISTRADORES[ BX ]
   LIN := INT( REGISTRADORES[ DX ] / 8 )
   COL := INT( REGISTRADORES[ CX ] / 8 )
   IF BOTAO != 0
      INKEY( 0.2 )
   ENDIF
ENDIF
RETURN NIL

FUNCTION TEC_MOU( SEGUNDOS )
LOCAL TECLA := 0, BO_TAO := 0, LIN := 0, COL := 0, DADO_CUR,;
      SEG_INI := SECONDS()
IF SEGUNDOS = NIL; SEGUNDOS := 0; ENDIF
WHILE( TECLA := INKEY() ) == 0
   IF SEGUNDOS != 0
      IF SECONDS() - SEG_INI >= SEGUNDOS; EXIT; ENDIF
   ENDIF
   IF TECLA = 0
      MOUSE( @BO_TAO, @LIN, @COL )
   ENDIF
   IF BO_TAO != 0
      IF BO_TAO = M_DIREITO; TECLA := T_ENTER; ENDIF
      IF BO_TAO = M_OS_DOIS; TECLA := T_ESC; ENDIF
      EXIT
   ENDIF
ENDDO
RETURN TECLA

FUNCTION INDICES
LOCAL CONTAR, OPCAO_INDEX := PCOUNT(), TODOS, NUM_INDICE,;
      MARCADOR
IF OPCAO_INDEX = 0
   DECLARE ARQ_NTX[ ADIR( "*.NTX" ) ]
   ADIR( "*.NTX", ARQ_NTX )
ELSEIF OPCAO_INDEX = 1
   COR( "MENU" )
   @ LIN_MENU, 00
   @ LIN_MENU, 01 SAY "Utilit rios ³ Organiza‡„o de arquivos"
   MENU_IND := { " PRODUTOS ->                            [ ] ",;
                 " GRUPOSSS ->                            [ ] " }
   JANELA( 04, 12, 20, 67, "Organiza‡„o de arquivos" )
   COR( "MENU" )
   @ 07, 17 CLEAR TO 15, 62
   NUM_INDICE := 1
   POS_JANELA := 1
   TODOS := .T.
   WHILE NUM_INDICE != 0
      botao:ADD( 17, 27, "Todos [" + IIF( TODOS, "x", " " ) + "]" )
      botao:ADD( 17, 43, "Organiza " )
      botao:MOSTRA()
      KEYBOARD CHR( 32 )
      COR( "MENU" )
      NUM_INDICE := ACHOICE( 08, 18, 14, 61, MENU_IND, .T., "IND_ACHO",;
                             NUM_INDICE, POS_JANELA )
      IF LASTKEY() = ASC( "T" ) .OR. LASTKEY() = ASC( "t" )
         botao:MOVIMENTA( 17, 27, "Todos [" + IIF( TODOS, "x", " " ) + "]" )
         FOR CONTAR := 1 TO LEN( MENU_IND )
            MENU_IND[ CONTAR ] := SUBS( MENU_IND[ CONTAR ], 1, 41 ) +;
                                  IIF( TODOS, "x", " " ) + "] "
         NEXT
         TODOS = IIF( TODOS, .F. ,.T. )
         NUM_INDICE := 1
         POS_JANELA := 1
      ELSEIF LASTKEY() = ASC( "O" ) .OR. LASTKEY() = ASC( "o" )
         botao:MOVIMENTA( 17, 43, "Organiza " )
         EXIT
      ELSEIF NUM_INDICE != 0
         MARCADOR := IIF( SUBS( MENU_IND[ NUM_INDICE ], 42, 1 ) = " ", "x",;
                          " " )
         MENU_IND[ NUM_INDICE ] := SUBS( MENU_IND[ NUM_INDICE ], 1, 41 ) +;
                                   MARCADOR + "] "
         IF NUM_INDICE < LEN( MENU_IND )
            NUM_INDICE++
            IF POS_JANELA < 7
               POS_JANELA++
            ENDIF
         ENDIF
      ENDIF
   ENDDO
   FUNDO()
   IF NUM_INDICE = 0
      RETURN NIL
   ENDIF
   ARQS_DBF := {}
   AEVAL( MENU_IND, { | MATRIZ | IIF( SUBS( MATRIZ, 42, 1 ) <> " ",;
                AADD( ARQS_DBF, TRIM( SUBS( MATRIZ, 2, 8 ) ) ), NIL ) } )
   IF LEN( ARQS_DBF ) = 0
   BEEP()
   MENSAGEM( "N„o h  arquivos marcados para organiza‡„o", 4 )
      RETURN NIL
   ENDIF
ENDIF
IF OPCAO_INDEX <> 0
   MENSAGEM( "Aguarde organiza‡„o dos arquivos" )
ENDIF
AEVAL( IN_DICES, { | MATRIZ | IN_DICE( MATRIZ[ 1 ], MATRIZ[ 2 ], MATRIZ[ 3 ],;
                   OPCAO_INDEX ) } )
RETURN NIL

FUNCTION IN_DICE( AQ_IND, AQ_DBF, AQ_EXP, OPCAO_INDEX )
LOCAL OK_IND := .F.
IF OPCAO_INDEX = 0
   IF ASCAN( ARQ_NTX, AQ_IND ) = 0; OK_IND := .T.; ENDIF
ELSEIF OPCAO_INDEX = 1
   IF ASCAN( ARQS_DBF, AQ_DBF ) <> 0; OK_IND := .T.; ENDIF
ELSEIF OPCAO_INDEX = 2
   OK_IND := .T.
ENDIF
IF OK_IND
   USE &AQ_DBF
   MENSAGEM( "Organizando o arquivo " + AQ_IND )
   INDEX ON &AQ_EXP TO &AQ_IND
   USE
ENDIF
RETURN NIL

FUNCTION IND_ACHO
PARA P_MODO, P_ELE, P_JAN
POS_JANELA := P_JAN
IF LASTKEY() = 13
   RETURN 1
ELSEIF LASTKEY() = 27
   RETURN 0
ELSEIF LASTKEY() = ASC( "T" ) .OR. LASTKEY() = ASC( "t" ) .OR.;
       LASTKEY() = ASC( "O" ) .OR. LASTKEY() = ASC( "o" )
   RETURN 1
ENDIF
RETURN 2
 
FUNCTION CGETS
KEYBOARD CHR( T_ENTER )
M->TEC_F2 := .T.
 
FUNCTION EDIT_ARQ( E_DITAR )
IF E_DITAR = .F. .OR. M->TEC_F2
   GOTO TOP
   M->TEC_F2 := .F.
   SOMBRA( L_PSQ := L_SOM, C_PSQ := C_SOM, .T. )
   MOUSE( DESLIGA )
   SAVE SCREEN TO M->T_ELA
   MOUSE( LIGA )
   JANELA( 04, 03, 20, 78 )
   botao:ADD( 18, 18, "Procura " )
   botao:ADD( 18, 36, "Trecho  " )
   botao:ADD( 18, 54, "Continua" )
   botao:MOSTRA()
   COR( "MENU" )
   @ 06, 06 CLEAR TO 16, 75
   @ 06, 06 TO 08, 75
   @ 08, 06 TO 16, 75
   @ 08, 06 SAY "Ã"
   @ 08, 75 SAY "´"
   SETKEY( T_F2, NIL )
   KEYBOARD CHR( 65 )
   DECLARE PSQ_NOME[ FCOUNT() ], PSQ_TIPO[ FCOUNT() ],;
           PSQ_TAM[ FCOUNT() ], PSQ_DEC[ FCOUNT() ]
   AFIELDS( PSQ_NOME, PSQ_TIPO, PSQ_TAM, PSQ_DEC )
   FOR F_PSQ = 1 TO LEN( PSQ_NOME )
      PSQ_NOME[ F_PSQ ] := SUBS( PSQ_NOME[ F_PSQ ], 1, 1 ) +;
                           LOWER( SUBS( PSQ_NOME[ F_PSQ ], 2 ) )
   NEXT
   DBEDIT( 07, 07, 16, 74, .T., "LER_ARQ", .T., PSQ_NOME, "ÄÂÄ", " ³ ", "ÄÁÄ" )
   SETKEY( T_F2, { || CGETS() } )
   MOUSE( DESLIGA )
   RESTORE SCREEN FROM M->T_ELA
   MOUSE( LIGA )
   SOMBRA( L_PSQ, C_PSQ )
   COR( "GETS" )
ENDIF
 
FUNCTION LER_ARQ
PARA P_MODO, P_CAMPO
IF M->P_MODO = 3
   COR( "BOX DA JANELA DE DIALOGO" )
   @ 09, 25, 13, 54 BOX " "
   @ 09, 25 SAY "þ"
   COR( "JANELA DE DIALOGO" )
   @ 10, 26 CLEAR TO 12, 53
   @ 11, 33 SAY "Arquivo  vazio"
   BEEP()
   INKEY( 4 )
   COR( "MENU" )
   RETURN 0
ENDIF
M->TEC_PSQ := UPPER( CHR( LASTKEY() ) )
IF M->TEC_PSQ = "P"
   botao:MOVIMENTA( 18, 18, "Procura " )
ELSEIF M->TEC_PSQ = "C"
   botao:MOVIMENTA( 18, 54, "Continua" )
ELSEIF M->TEC_PSQ = "T"
   botao:MOVIMENTA( 18, 36, "Trecho  " )
ENDIF
IF LASTKEY() = T_ESC .OR. LASTKEY() = T_ENTER
   COR( "MENU" )
   RETURN 0
ELSEIF M->TEC_PSQ = "P" .OR. M->TEC_PSQ = "C" .OR. M->TEC_PSQ = "T"
   IF M->TEC_PSQ <> "C"
      MOUSE( DESLIGA )
      SAVE SCREEN
      MOUSE( LIGA )
      M->PSQ_POS := ( 80 - ( PSQ_TAM[ M->P_CAMPO ] + 4 ) ) / 2
      IF PSQ_TAM[ M->P_CAMPO ] > 50 .OR. PSQ_TIPO[ M->P_CAMPO ] = "M"
         COR( "BOX DA JANELA DE DIALOGO" )
         @ 09, 13, 13, 66 BOX " "
         @ 09, 13 SAY "þ"
         COR( "JANELA DE DIALOGO" )
         @ 10, 15 CLEAR TO 12, 65
      ELSEIF M->PSQ_POS < 25
         COR( "BOX DA JANELA DE DIALOGO" )
         @ 09, M->PSQ_POS, 13, M->PSQ_POS + PSQ_TAM[ M->P_CAMPO ] + 3 BOX " "
         @ 09, M->PSQ_POS SAY "þ"
         COR( "JANELA DE DIALOGO" )
         @ 10, M->PSQ_POS + 1 CLEAR TO 12, M->PSQ_POS + PSQ_TAM[ M->P_CAMPO ] + 2
      ELSE
         COR( "BOX DA JANELA DE DIALOGO" )
         @ 09, 25, 13, 54 BOX " "
         @ 09, 25 SAY "þ"
         COR( "JANELA DE DIALOGO" )
         @ 10, 26 CLEAR TO 12, 53
      ENDIF
      COR( "BOX DA JANELA DE DIALOGO" )
      @ 09, ( 80 - LEN( TRIM( PSQ_NOME[ M->P_CAMPO ] ) ) ) / 2 SAY PSQ_NOME[ M->P_CAMPO ]
      COR( "BOTAO EM DESTAQUE" )
      CURSOR( LIGA )
      IF PSQ_TAM[ M->P_CAMPO ] > 50
         M->PRO_CURA := VAR_GET( 11, 15, PSQ_TAM[ M->P_CAMPO ] )
      ELSEIF PSQ_TIPO[ M->P_CAMPO ] = "M"
         M->PRO_CURA := VAR_GET( 11, 15, 200 )
      ELSE
         M->PRO_CURA := VAR_GET( 11, M->PSQ_POS + 2, PSQ_TAM[ M->P_CAMPO ] )
      ENDIF
      KEYBOARD CHR( 65 )
      CURSOR( DESLIGA )
      MOUSE( DESLIGA )
      RESTORE SCREEN
      MOUSE( LIGA )
      M->REG_ATU := RECN()
      GOTO TOP
   ELSE
      M->REG_ATU := RECN()
   ENDIF
   IF M->TEC_PSQ = "C"
      IF M->ULT_PSQ = "P"
         M->TEC_PSQ := "CP"
      ELSE
         M->TEC_PSQ := "CT"
      ENDIF
   ELSE
      M->ULT_PSQ := M->TEC_PSQ
   ENDIF
   COR( "MENU" )
   WHILE !EOF()
      M->SUB_CAMPO := PSQ_NOME[ M->P_CAMPO ]
      M->PRO_CURA := UPPER( M->PRO_CURA )
      IF M->TEC_PSQ = "P" .OR. ( M->TEC_PSQ = "CP" .AND. M->REG_ATU != RECN() )
         IF PSQ_TIPO[ M->P_CAMPO ] = "N"
            IF &SUB_CAMPO = VAL( M->PRO_CURA )
               KEYBOARD CHR( 65 )
               RETURN 1
            ENDIF
         ELSEIF PSQ_TIPO[ M->P_CAMPO ] = "D"
            IF DTOC( &SUB_CAMPO ) = M->PRO_CURA
               KEYBOARD CHR( 65 )
               RETURN 1
            ENDIF
         ELSEIF PSQ_TIPO[ M->P_CAMPO ] = "C"
            M->CMP_MEMO := UPPER( &SUB_CAMPO )
            IF M->CMP_MEMO = M->PRO_CURA
               KEYBOARD CHR( 65 )
               RETURN 1
            ENDIF
         ELSEIF PSQ_TIPO[ M->P_CAMPO ] = "T"
            IF IIF( &SUB_CAMPO, "T", "F" ) = M->PRO_CURA
               KEYBOARD CHR( 65 )
               RETURN 1
            ENDIF
         ELSEIF PSQ_TIPO[ M->P_CAMPO ] = "M"
            M->CMP_MEMO := UPPER( &SUB_CAMPO )
            IF M->CMP_MEMO = M->PRO_CURA
               KEYBOARD CHR( 65 )
               RETURN 1
            ENDIF
         ENDIF
      ELSEIF M->TEC_PSQ = "T" .OR. ( M->TEC_PSQ = "CT" .AND. M->REG_ATU != RECN() )
         IF PSQ_TIPO[ M->P_CAMPO ] = "N"
            IF AT( M->PRO_CURA, STR( &SUB_CAMPO, PSQ_TAM[ M->P_CAMPO ], PSQ_DEC[ M->P_CAMPO ] ) ) != 0
               KEYBOARD CHR( 65 )
               RETURN 1
            ENDIF
         ELSEIF PSQ_TIPO[ M->P_CAMPO ] = "D"
            IF AT( M->PRO_CURA, DTOC( &SUB_CAMPO ) ) != 0
               KEYBOARD CHR( 65 )
               RETURN 1
            ENDIF
         ELSEIF PSQ_TIPO[ M->P_CAMPO ] = "C"
            M->CMP_MEMO := UPPER( &SUB_CAMPO )
            IF AT( M->PRO_CURA, M->CMP_MEMO ) != 0
               KEYBOARD CHR( 65 )
               RETURN 1
            ENDIF
         ELSEIF PSQ_TIPO[ M->P_CAMPO ] = "T"
            IF IIF( &SUB_CAMPO, "T", "F" ) = M->PRO_CURA
               KEYBOARD CHR( 65 )
               RETURN 1
            ENDIF
         ELSEIF PSQ_TIPO[ M->P_CAMPO ] = "M"
            M->CMP_MEMO := UPPER( &SUB_CAMPO )
            IF AT( M->PRO_CURA, M->CMP_MEMO ) != 0
               KEYBOARD CHR( 65 )
               RETURN 1
            ENDIF
         ENDIF
      ENDIF
      SKIP
   ENDDO
   GOTO M->REG_ATU
   MOUSE( DESLIGA )
   SAVE SCREEN
   MOUSE( LIGA )
   COR( "BOX DA JANELA DE DIALOGO" )
   @ 09, 25, 13, 54 BOX " "
   @ 09, 25 SAY "þ"
   COR( "JANELA DE DIALOGO" )
   @ 10, 26 CLEAR TO 12, 53
   @ 11, 30 SAY "Dados n„o encontrados"
   BEEP()
   INKEY( .1 )
   INKEY( 3 )
   COR( "MENU" )
   MOUSE( DESLIGA )
   RESTORE SCREEN
   MOUSE( LIGA )
ENDIF
RETURN 1

FUNCTION VAR_GET
PARA GET_X, GET_Y, GET_TAM
M->GET_VAR := ""; M->TEC_GET := 0
IF M->GET_TAM < 50
   @ M->GET_X, M->GET_Y SAY SPACE( M->GET_TAM )
ELSE
   @ M->GET_X, M->GET_Y SAY SPACE( 50 )
ENDIF
WHILE .T.
   IF LEN( M->GET_VAR ) < 50
      @ M->GET_X, M->GET_Y SAY M->GET_VAR
   ELSE
      @ M->GET_X, M->GET_Y SAY SUBS( M->GET_VAR, LEN( M->GET_VAR ) - 48, 50 )
   ENDIF
   IF LEN( M->GET_VAR ) = M->GET_TAM
      RETURN M->GET_VAR
   ENDIF
   M->TEC_GET := INKEY( 0 )
   IF M->TEC_GET = T_ESC
      RETURN ""
   ELSEIF M->TEC_GET = T_ENTER
      RETURN M->GET_VAR
   ELSEIF M->TEC_GET = 8 .OR. M->TEC_GET = 19 .OR. M->TEC_GET = 7
      IF LEN( M->GET_VAR ) > 0
         M->GET_VAR := SUBS( M->GET_VAR, 1, LEN( M->GET_VAR ) - 1 )
         IF LEN( M->GET_VAR ) < 50
            @ M->GET_X, M->GET_Y SAY M->GET_VAR + " "
         ENDIF
      ENDIF
   ELSE
      M->GET_VAR = M->GET_VAR + CHR( M->TEC_GET )
   ENDIF
ENDDO
 
FUNCTION EDITOR
PARA ME_VAR, ME_COM, ALTE_RA
IF ALTE_RA = NIL; ALTE_RA := .T.; ENDIF
IF M->ME_MO != "[memo]"
   M->ME_MO := "[memo]"
   RETURN .F.
ENDIF
IF LASTKEY() = T_ENTER .OR. !ALTE_RA
   MOUSE( DESLIGA )
   SAVE SCREEN TO TELA
   MOUSE( LIGA )
   SOMBRA( L_EDITOR := L_SOM, C_EDITOR := C_SOM, .T. )
   MENSAGEM( "Tecle <ESC> para finalizar a edi‡„o" )
   JANELA( 12, 02, 21, 77, ALLTRIM( ME_COM ) )
   @ 21, 05 SAY "Linha"
   @ 21, 19 SAY "Coluna"
   M->INS_ERT := READINSERT()
   IF M->INS_ERT
      @ 21, 31 SAY "Insert"
   ENDIF
   ME_VAR = MEMOEDIT( ME_VAR, 13, 03, 20, 76, ALTE_RA, "FUNMEMO" )
   COR( "GETS" )
   L_SOM := L_EDITOR; C_SOM := C_EDITOR
   MOUSE( DESLIGA )
   RESTORE SCREEN FROM TELA
   MOUSE( LIGA )
ENDIF
RETURN .T.

FUNCTION FUNMEMO( MODO, LINHA, COLUNA )
IF LASTKEY() = T_ESC .AND. ALTE_RA
   BEEP()
   IF PERG( "Confirma atualiza‡„o do campo memo ?" ) = "S"
      MENSAGEM( "Tecle <ESC> para retornar" )
      RETURN T_CTRL_W
   ELSE
      MENSAGEM( "Tecle <ESC> para retornar" )
      RETURN T_ESC
   ENDIF
ENDIF
COR( "BOX DA JANELA DE DIALOGO" )
IF LASTKEY() = T_INSERT .AND. ALTE_RA
   IF M->INS_ERT
      M->INS_ERT := .F.
      @ 21, 31 SAY "      "
   ELSE
      M->INS_ERT := .T.
      @ 21, 31 SAY "Insert"
   ENDIF
ENDIF
@ 21, 11 SAY STRZERO( LINHA, 5 )
@ 21, 26 SAY STRZERO( COLUNA + 1, 2 )
COR( "JANELA DE DIALOGO" )
RETURN 0
 
FUNCTION MES_ANO
LOCAL RETORNO
PARA CONTEUDO
IF TYPE( "CONTEUDO" ) = "D"
   RETORNO := SUBS( STR( YEAR( CONTEUDO ), 4 ), 3 ) + "/"
   RETORNO += STRZERO( MONTH( CONTEUDO ), 2 )
ELSE
   RETORNO := SUBS( CONTEUDO, 4, 2 ) + "/" + SUBS( CONTEUDO, 1, 2 )
ENDIF
RETURN RETORNO
 
FUNCTION ANO( CONTEUDO )
RETURN SUBS( STR( YEAR( CONTEUDO ), 4 ), 3 )
 
*** (Em uso)
*** Inicio do bloco de substitui‡„o MENSAGEM.B
* /////////////////////////////////////////////////////////////////////////*
*
* -> Inicio da funcao que imprime mensagens na tela
*
FUNCTION MENSAGEM

COR_MENS=SETCOLOR("W+/R")
COR("TITULO")
SET CURSOR OFF
IF PCOUNT()=0
   @ 24,11 SAY SPACE(58)
   SETCOLOR(COR_MENS)
   ON_CURSOR()
   RETURN .T.
ENDIF
IF PCOUNT()=1
   PARA TEX_TO
   M->PAUSA=0
ELSE
   PARA TEX_TO,PAUSA
ENDIF
@ 24,10 SAY SPACE(60)
@ 24,(80-LEN(TEX_TO+RTRIM(M->OPERADOR)))/2 SAY RTRIM(M->OPERADOR)+", "+TEX_TO
IF M->PAUSA<>0
   M->X=INKEY(M->PAUSA)
ENDIF
TONE(850,1)
SETCOLOR(COR_MENS)
ON_CURSOR()
RETURN .T.
*
* -> Final da funcao que imprime mensagens na tela
*
* /////////////////////////////////////////////////////////////////////////*

*** Final do bloco de substitui‡„o MENSAGEM.B
*** (Em uso)
 
*** (Em uso)
*** Inicio do bloco de substitui‡„o DELE_TAR.B
* INICIO  ////////////////////////////////////////////////////////////////* 
*
FUNCTION DELE_TAR
RETURN IIF(DELETED(),"Marcado "+CHR(16)," ")
*
* FINAL  /////////////////////////////////////////////////////////////////* 

*** Final do bloco de substitui‡„o DELE_TAR.B
*** (Em uso)
 
*** (Em uso)
*** Inicio do bloco de substitui‡„o PERGUNTA.B
FUNCTION PERGUNTA
*
* -> Funcao que executa uma pergunta
PER_COR=SETCOLOR("G+/N")
SET CURSOR OFF
SAVE SCREEN TO PER_TELA
M->RES_POSTA="S"
PARA TEX_TO,RES_POSTA
M->SIM_NAO=IIF(M->RES_POSTA="N",2,1)
M->LAR_G=LEN(M->TEX_TO)
IF M->LAR_G<37
   M->LAR_G=51
ELSE
   M->LAR_G=M->LAR_G+14
ENDIF
COL_SUP=INT((80-M->LAR_G)/2)
COL_INF=COL_SUP+LAR_G-1
SETCOLOR("G/N")
@ 09,COL_SUP CLEAR TO 12,COL_INF
@ 09,COL_SUP TO 12,COL_INF  DOUBLE
SOMBRA(08,COL_SUP,12,COL_INF)
@ 10,(80-LEN(TEX_TO+RTRIM(M->OPERADOR)))/2 SAY RTRIM(M->OPERADOR)+", "+TEX_TO COLOR("W+/N")
DO WHILE .T.       
   @ 11,32 PROMPT PADC(" Sim ",5)
   @ 11,37 SAY    PADC(" ou " ,4)
   @ 11,41 PROMPT PADC(" N„o ",5)
   MENU TO M->SIM_NAO
   IF M->SIM_NAO<>0
      EXIT
   ENDIF
ENDDO
RESTORE SCREEN FROM PER_TELA
SETCOLOR(PER_COR)
RETURN IIF(M->SIM_NAO=1,"S","N")

*** Final do bloco de substitui‡„o PERGUNTA.B
*** (Em uso)

FUNCTION BOTAO( LINHA_SUPERIOR, COLUNA_ESQUERDA, NOME_BOTAO )
LOCAL BOTAO_MOUSE, COLUNA_MOUSE, LINHA_MOUSE, LEITURA_MOUSE,;
      TIPO_OPERACAO, LARGURA_BOTAO, CONTAR, TECLA, PONTEIRO := 1
IF PCOUNT() = 0
   TIPO_OPERACAO := EDITA_BOTOES
ELSEIF PCOUNT() = 1
   TIPO_OPERACAO := EDITA_BOTOES
   PONTEIRO := LINHA_SUPERIOR
ELSEIF PCOUNT() = 2
   TIPO_OPERACAO := MOSTRA_BOTOES
ELSEIF PCOUNT() = 3
   TIPO_OPERACAO := MOVIMENTA_BOTAO
ENDIF
IF TIPO_OPERACAO = MOVIMENTA_BOTAO
   LARGURA_BOTAO := LEN( NOME_BOTAO ) + 2
   COR( "JANELA DE DIALOGO" )
   @ LINHA_SUPERIOR, COLUNA_ESQUERDA SAY " "
   @ LINHA_SUPERIOR + 1, COLUNA_ESQUERDA - 1 SAY SPACE( LARGURA_BOTAO )
   @ LINHA_SUPERIOR, COLUNA_ESQUERDA + LARGURA_BOTAO - 1 SAY " "
   COR( "BOTAO EM DESTAQUE" )
   @ LINHA_SUPERIOR, COLUNA_ESQUERDA - 1 SAY " " + NOME_BOTAO + " "
   INKEY( .2 )
   COR( "BOTOES" )
   @ LINHA_SUPERIOR, COLUNA_ESQUERDA SAY " " + NOME_BOTAO + " "
   SETCOLOR( "N/" + ALLTRIM( SUBS( CONTECOR[ 4 ], 4 ) ) )
   @ LINHA_SUPERIOR, COLUNA_ESQUERDA - 1 SAY "Ü"
   @ LINHA_SUPERIOR + 1, COLUNA_ESQUERDA - 1 SAY REPL( "ß", LARGURA_BOTAO ) + " "
   INKEY( .2 )
ENDIF
IF TIPO_OPERACAO = EDITA_BOTOES .OR. TIPO_OPERACAO = MOSTRA_BOTOES
   FOR CONTAR := 1 TO LEN( ObjBotao )
      LARGURA_BOTAO := LEN( ObjBotao[ CONTAR ][ 3 ] ) + 2
      COR( "BOTOES" )
      @ ObjBotao[ CONTAR ][ 1 ], ObjBotao[ CONTAR ][ 2 ]  SAY " " + ;
        ObjBotao[ CONTAR ][ 3 ] + " "
      SETCOLOR( "N/" + ALLTRIM( SUBS( CONTECOR[ 4 ], 4 ) ) )
      @ ObjBotao[ CONTAR ][ 1 ], ObjBotao[ CONTAR ][ 2 ] - 1 SAY "Ü"
      @ ObjBotao[ CONTAR ][ 1 ] + 1, ObjBotao[ CONTAR ][ 2 ] - 1 SAY;
        REPL( "ß", LARGURA_BOTAO ) + " "
   NEXT
ENDIF
IF TIPO_OPERACAO = EDITA_BOTOES
   TECLA := 0
   WHILE .T.
      LARGURA_BOTAO := LEN( ObjBotao[ PONTEIRO ][ 3 ] ) + 2
      COR( "BOTAO EM DESTAQUE" )
      @ ObjBotao[ PONTEIRO ][ 1 ], ObjBotao[ PONTEIRO ][ 2 ] SAY;
        " " + ObjBotao[ PONTEIRO ][ 3 ] + " "
      SETCOLOR( "N/" + ALLTRIM( SUBS( CONTECOR[ 4 ], 4 ) ) )
      @ ObjBotao[ PONTEIRO ][ 1 ], ObjBotao[ PONTEIRO ][ 2 ] - 1 SAY "Ü"
      @ ObjBotao[ PONTEIRO ][ 1 ] + 1, ObjBotao[ PONTEIRO ][ 2 ] - 1 SAY;
        REPL( "ß", LARGURA_BOTAO ) + " "
      IF TECLA = T_ENTER
         INKEY( .2 )
         botao:LIMPA()
         RETURN PONTEIRO
      ENDIF
      TECLA := 0
      WHILE TECLA = 0
         TECLA := INKEY()
         MOUSE( @BOTAO_MOUSE, @LINHA_MOUSE, @COLUNA_MOUSE )
         IF BOTAO_MOUSE = M_ESQUERDO
            LEITURA_MOUSE := SUBS( SAVESCREEN( LINHA_MOUSE, COLUNA_MOUSE, LINHA_MOUSE, COLUNA_MOUSE ), 1, 1 )
            IF LEITURA_MOUSE = CHR( 254 )
               TECLA := T_ESC
               EXIT
            ELSEIF LINHA_MOUSE = 24 .AND. ( COLUNA_MOUSE >= 71 .AND. COLUNA_MOUSE <= 78 )
               TECLA := T_F1
               EXIT
            ENDIF
            FOR CONTAR = 1 TO LEN( ObjBotao )
               IF ObjBotao[ CONTAR ][ 1 ] = LINHA_MOUSE .AND.;
                  ( COLUNA_MOUSE >= ObjBotao[ CONTAR ][ 2 ] .AND.;
                  COLUNA_MOUSE <= ObjBotao[ CONTAR ][ 2 ] +;
                  LEN( ObjBotao[ CONTAR ][ 3 ] ) + 1 )
                     TECLA := T_ENTER; PONTEIRO := CONTAR
               ENDIF
            NEXT
            IF TECLA != T_ENTER
               BEEP_MOUSE()
            ENDIF
         ELSEIF BOTAO_MOUSE = M_OS_DOIS
            TECLA := T_ESC
         ELSEIF BOTAO_MOUSE = M_DIREITO
            TECLA := T_ENTER
         ENDIF
      ENDDO
      IF TECLA = T_ESC
         botao:LIMPA()
         RETURN 0
      ENDIF
      COR( "BOTOES" )
      @ ObjBotao[ PONTEIRO ][ 1 ], ObjBotao[ PONTEIRO ][ 2 ] + 1 SAY;
        ObjBotao[ PONTEIRO ][ 3 ]
      FOR CONTAR = 1 TO LEN( ObjBotao )
         IF SUBS( ObjBotao[ CONTAR ][ 3 ], 1, 1 ) = UPPER( CHR( TECLA ) )
            PONTEIRO := CONTAR
            TECLA := T_ENTER
            EXIT
         ENDIF
      NEXT
      IF TECLA = T_ENTER
         LARGURA_BOTAO := LEN( ObjBotao[ PONTEIRO ][ 3 ] ) + 2
         COR( "JANELA DE DIALOGO" )
         @ ObjBotao[ PONTEIRO ][ 1 ], ObjBotao[ PONTEIRO ][ 2 ] SAY " "
         @ ObjBotao[ PONTEIRO ][ 1 ] + 1, ObjBotao[ PONTEIRO ][ 2 ] - 1 SAY;
           SPACE( LARGURA_BOTAO )
         @ ObjBotao[ PONTEIRO ][ 1 ], ObjBotao[ PONTEIRO ][ 2 ] +;
           LARGURA_BOTAO - 1 SAY " "
         COR( "BOTAO EM DESTAQUE" )
         @ ObjBotao[ PONTEIRO ][ 1 ], ObjBotao[ PONTEIRO ][ 2 ] - 1 SAY ;
           " " + ObjBotao[ PONTEIRO ][ 3 ] + " "
         INKEY( .2 )
         LOOP
      ENDIF
      IF TECLA = T_ESQUERDA .OR. TECLA = T_CIMA
         PONTEIRO--
      ELSEIF TECLA = T_DIREITA .OR. TECLA = T_BAIXO
         PONTEIRO++
      ENDIF
      PONTEIRO := IIF( PONTEIRO < 1, LEN( ObjBotao ),;
                  IIF( PONTEIRO > LEN( ObjBotao ), 1, PONTEIRO ) )
   ENDDO
ENDIF
botao:LIMPA()
RETURN NIL
**
**BI [INI] FUN.B03
*
Function relogio
* \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
* \ Empresa : M.M.S.tec INFORMATICA LTDA.
* \ Programa: HORA.PRG.
* \ Data    : 20.11.1996.
* \ Sistema : Apresenta‡„o de Hor rio.
* \ Fun‡„o  : Informar as horas.
* \ Analista: Marcos Morais de Sousa.
* \ Cria‡„o : Marcos Morais de Sousa.
* \ Usu rio : M.F.B. Materiais de Constru‡„o Ltda.
* \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
*
*
SAVE SCREEN TO TELA_HORA
SET CURSOR OFF
CONTADOR  :=0
AUTOR     :=" (C) Marcos Morais de Sousa - 1996/1997 "
CIDADE    :=" -"+" JEQUIE/BAHIA "
HOJE      :=DATE()
SEMANA    :="Domingo      Segunda-feiraTerca-feira  Quarta-feira Quinta-feira "
SEMANA    :=SEMANA+"Sexta-feira  S bado       "
DIA       :=TRIM(SUBS(SEMANA,DOW(HOJE)*13-12,13))+", "+ALLTRIM(STR(DAY(HOJE),2))
MES       :="janeiro  fevereiromar‡o    abril    maio     junho    "
MES       :=MES+"julho    agosto   setembro outubro  novembro dezembro "
DIA       :=DIA+" de "+TRIM(SUBS(MES,MONTH(HOJE)*9-8,9))+" de "
DIA       :=DIA+TRAN(YEAR(HOJE),"@E 9999")
COLESQ    :=(80-LEN(DIA+CIDADE))/2-2
COLDIR    :=COLESQ+LEN(DIA+CIDADE)+2
* //////////////////////////////////////////////////////////////////////////////*
SETCOLOR("N/N")
*
@ 10,COLESQ CLEAR TO 14,COLDIR
@ 10,COLESQ       TO 14,COLDIR  COLOR("N+/N")
SOMBRA(10,COLESQ,    14,COLDIR)
DO WHILE.T.
          IF LASTKEY()=27
               EXIT
          ENDIF
          FOR CONTADOR   :=0 TO LEN(DIA+CIDADE)
          SET CURSOR OFF
               IF LASTKEY()=27
                    EXIT
               ENDIF
          INKEY(0.01)
          SETCOLOR("G+/N")
          @ 11,COLESQ+02 SAY PADC(DIA+CIDADE,LEN(DIA+CIDADE))                          
          @ 13,COLESQ+02 SAY PADC(LEFT(TIME(),2)+" horas, "+SUBSTR(TIME(),4,2)+" minutos e "+RIGHT(TIME(),2)+" segundos.",LEN(DIA+CIDADE))                          
          NEXT
    ENDDO                   
RESTORE SCREEN FROM TELA_HORA
RETURN

FUNCTION BOM_DIA
SAVE SCREEN TO BOMDIA
*                                                  *
****************************************************
*
Tec1="ÛßßÛßßÛ ÛßßÛßßÛ ÛßßßßßÛ   Ü  Inform tica Ltda"
Tec2="Û  Û  Û Û  Û  Û ÛÜÜÜÜÜÜÜ ßÛß ÛßßßßßÛ ÛßßßßßßÛ"
Tec3="ÛÛ Û  Û ÛÛ Û  Û Ü     ÛÛ  ÛÛ ÛÛßßßßß ÛÛ     Ü"
Tec4="ÛÛ Û  Û ÛÛ Û  Û ßßßßßßßß  ßß ßßßßßßß ßßßßßßßß"
Tec5="ßß    ßßßß    ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß"
*
****************************************************
*                                                  *
TITULO="BOM    DIA   SENHOR" 
LINHA5="No silencio deste dia  que amanhece,"
LINHA6="venho pedir-te a paz, a sabedoria, a for‡a." 
LINHA7="Quero olhar hoje o  mundo com"
LINHA8="olhos cheios  de amor, ser paciente,"
LINHA9="ser compreensivo,  manso e prudente;"
LINHA10="ver,  alem  das  aparencias humanas,"
LINHA11="teus  filhos,  como  TU mesmo os ves"
LINHA12="e  assim  n„o  ver  sen„o  o  bem em cada um."
LINHA13="Cerra os meus ouvidos a toda calunia."
LINHA14="Guarda  minha  lingua de toda a maldade"
LINHA15="Que  so de ben‡„o se encha meu espirito."
LINHA16="Que eu seja t„o bondoso e alegre"
LINHA17="Que todos quantos se achegarem a mim,"
LINHA18="sintam TUA presen‡a."
LINHA19="Reveste-me  de  TUA  gra‡a,  SENHOR," 
LINHA20="e que no decurso deste dia,"
LINHA21="eu n„o TE ofenda e TE revele a todos."
LINHA22=""
************************************************
CONTADOR=0
MMSTEC="MMStec Artes Gr ficas & Inform tica Ltda"
AUTOR ="(c) Marcos Morais de Sousa - 1996/1997"
CIDADE=" JEQUIE/BAHIA"
HOJE=DATE()
SEMANA="Domingo      Segunda-feiraTerca-feira  Quarta-feira "
SEMANA=SEMANA+"Quinta-feira Sexta-feira  S bado       "
DIA=TRIM(SUBS(SEMANA,DOW(HOJE)*13-12,13))+", "+ALLTRIM(STR(DAY(HOJE),2))
MES="Janeiro  FevereiroMar‡o    Abril    Maio     Junho    "
MES=MES+"Julho    Agosto   Setembro Outubro  Novembro Dezembro "
DIA=DIA+" de "+TRIM(SUBS(MES,MONTH(HOJE)*9-8,9))+" de "
DIA=DIA+TRAN(YEAR(M->HOJE),"@E 9999")+" -"
************************************************

CLS
Do While .T.
   IF LASTKEY()>0
     exit
   endif
   SET CURSOR OFF
   SETCOLOR ("N+/N")
   CLS
   ?Repl("\\// M.M.S.tec //\\",100)
   @ 09,16 TO 15,62
FOR CONTADOR=0 TO LEN(tec1)+5 STEP +5
  IF LASTKEY()>0
    exit
  endif
  SETCOLOR("B+ /n")
  @ 10,(80-LEN(tec1))/2 Say PADR(SUBSTR(tec1,1,CONTADOR),LEN(tec1)) 
  SETCOLOR("B  /n")
  @ 11,(80-LEN(tec2))/2 Say PADC(SUBSTR(tec2,1,CONTADOR),LEN(tec2)) 
  SETCOLOR("BG /n")
  @ 12,(80-LEN(tec3))/2 SAY PADL(SUBSTR(tec3,1,CONTADOR),LEN(tec3)) 
  SETCOLOR("BG+/n")         
  @ 13,(80-LEN(tec4))/2 SAY PADC(SUBSTR(tec4,1,CONTADOR),LEN(tec4)) 
  SETCOLOR("W  /n")
  @ 14,(80-LEN(tec5))/2 SAY PADR(SUBSTR(tec5,1,CONTADOR),LEN(tec5)) 
  INKEY(0.01)
NEXT
INKEY(1)  
FOR CONTADOR=LEN(tec1)+5 TO 0 STEP -5
  IF LASTKEY()>0
    exit
  endif
  SETCOLOR("B+ /n")
  @ 10,(80-LEN(tec1))/2 Say PADR(SUBSTR(tec1,1,CONTADOR),LEN(tec1)) 
  SETCOLOR("B  /n")
  @ 11,(80-LEN(tec2))/2 Say PADC(SUBSTR(tec2,1,CONTADOR),LEN(tec2)) 
  SETCOLOR("BG /n")
  @ 12,(80-LEN(tec3))/2 SAY PADL(SUBSTR(tec3,1,CONTADOR),LEN(tec3)) 
  SETCOLOR("BG+/n")         
  @ 13,(80-LEN(tec4))/2 SAY PADC(SUBSTR(tec4,1,CONTADOR),LEN(tec4)) 
  SETCOLOR("W  /n")
  @ 14,(80-LEN(tec5))/2 SAY PADR(SUBSTR(tec5,1,CONTADOR),LEN(tec5)) 
  INKEY(0.01)
NEXT
     *///////////////////////////////////////////////////////////////////////////////////////////////////*
     FOR CONTADOR=0 TO LEN(tec1)+5 STEP +5
     IF LASTKEY()>0
          exit
     endif
     @ 11,(80-LEN(MMSTEC))/2 Say PADL(SUBSTR(MMSTEC,1,CONTADOR),LEN(MMSTEC))    COLOR("w+ /n")
         @ 13,(80-LEN(AUTOR))/2 Say PADR(SUBSTR(autor,1,CONTADOR),LEN(autor))       COLOR("g+ / n")
        inkey(0.01)
     Next
     *//////////////////////////////////////////////////////////////////////////////////////////////////*
     SETCOLOR ("W+/G")
     FOR X=02 to 23 step +1 
     IF LASTKEY()>0
          exit
     endif
          
          @ 01,02 clear to X,55+X 
          @ 01,02       to X,55+X    COLOR "G+/G"
          PAUSA(0.01)
     NEXT
     *
     FOR CONTADOR=0 to LEN(DIA+CIDADE)
          SET COLOR TO w+/g
          @ 02,(80-LEN(DIA+CIDADE))/2 SAY PADR(SUBSTR(DIA+CIDADE,1,CONTADOR),LEN(DIA+CIDADE))
          @ 03,03 say REPL("Ä",75)  color "R+/G"
          PAUSA(0.01)
     NexT
     SETCOLOR ("W+/G")
     FOR CONTADOR=0 TO LEN(TITULO)+5 STEP +5    
     IF LASTKEY()>0
          EXIT
     ENDIF
          
          @ 02,70 SAY TIME()
          @ 04,(80-LEN(TITULO))/2 SAY PADC(SUBSTR(TITULO,1,CONTADOR),LEN(TITULO)) COLOR "RG+/G"
          PAUSA(0.01)
     NEXT
     FOR CONTADOR=0 TO LEN(LINHA5)+5 STEP +5
     IF LASTKEY()>0
          EXIT
     ENDIF
          
          @ 02,70 SAY TIME()
          @ 06,(80-LEN(LINHA5))/2 SAY PADC(SUBSTR(LINHA5,1,CONTADOR),LEN(LINHA5))
          PAUSA(0.01)
     NEXT
     FOR CONTADOR=0 TO LEN(LINHA6)+5 STEP +5
     IF LASTKEY()>0
          EXIT
     ENDIF
          
          @ 02,70 SAY TIME()
          @ 07,(80-LEN(LINHA6))/2 SAY PADC(SUBSTR(LINHA6,1,CONTADOR),LEN(LINHA6))
          PAUSA(0.01)
     NEXT
     FOR CONTADOR=0 TO LEN(LINHA7)+5 STEP +5
     IF LASTKEY()>0
          EXIT
     ENDIF
          
          @ 02,70 SAY TIME()
          @ 08,(80-LEN(LINHA7))/2 SAY PADC(SUBSTR(LINHA7,1,CONTADOR),LEN(LINHA7))
          PAUSA(0.01)
     NEXT
     FOR CONTADOR=0 TO LEN(LINHA8)+5 STEP +5
     IF LASTKEY()>0
          EXIT
     ENDIF
          
          @ 02,70 SAY TIME()
          @ 09,(80-LEN(LINHA8))/2 SAY PADC(SUBSTR(LINHA8,1,CONTADOR),LEN(LINHA8))
          PAUSA(0.01)
     NEXT
     FOR CONTADOR=0 TO LEN(LINHA9)+5 STEP +5
     IF LASTKEY()>0
          EXIT
     ENDIF
          
          @ 02,70 SAY TIME()
          @ 10,(80-LEN(LINHA9))/2 SAY PADC(SUBSTR(LINHA9,1,CONTADOR),LEN(LINHA9))
          PAUSA(0.01)
     NEXT
     FOR CONTADOR=0 TO LEN(LINHA10)+5 STEP +5
     IF LASTKEY()>0
          EXIT
     ENDIF
          
          @ 02,70 SAY TIME()
          @ 11,(80-LEN(LINHA10))/2 SAY PADC(SUBSTR(LINHA10,1,CONTADOR),LEN(LINHA10))
          PAUSA(0.01)
     NEXT
     FOR CONTADOR=0 TO LEN(LINHA11)+5 STEP +5
     IF LASTKEY()>0
          EXIT
     ENDIF
          
          @ 02,70 SAY TIME()
          @ 12,(80-LEN(LINHA11))/2 SAY PADC(SUBSTR(LINHA11,1,CONTADOR),LEN(LINHA11))
          PAUSA(0.01)
     NEXT
     FOR CONTADOR=0 TO LEN(LINHA12)+5 STEP +5
     IF LASTKEY()>0
          EXIT
     ENDIF
          
          @ 02,70 SAY TIME()
          @ 13,(80-LEN(LINHA12))/2 SAY PADC(SUBSTR(LINHA12,1,CONTADOR),LEN(LINHA12))
          PAUSA(0.01)
     NEXT
     FOR CONTADOR=0 TO LEN(LINHA13)+5 STEP +5
     IF LASTKEY()>0
          EXIT
     ENDIF
          
          @ 02,70 SAY TIME()
          @ 14,(80-LEN(LINHA13))/2 SAY PADC(SUBSTR(LINHA13,1,CONTADOR),LEN(LINHA13))
          PAUSA(0.01)
     NEXT
     FOR CONTADOR=0 TO LEN(LINHA14)+5 STEP +5
     IF LASTKEY()>0
          EXIT
     ENDIF
          
          @ 02,70 SAY TIME()
          @ 15,(80-LEN(LINHA14))/2 SAY PADC(SUBSTR(LINHA14,1,CONTADOR),LEN(LINHA14))
          PAUSA(0.01)
     NEXT
     FOR CONTADOR=0 TO LEN(LINHA15)+5 STEP +5
     IF LASTKEY()>0
          EXIT
     ENDIF
          
          @ 02,70 SAY TIME()
          @ 16,(80-LEN(LINHA15))/2 SAY PADC(SUBSTR(LINHA15,1,CONTADOR),LEN(LINHA15))
          PAUSA(0.01)
     NEXT
     FOR CONTADOR=0 TO LEN(LINHA16)+5 STEP +5
     IF LASTKEY()>0
          EXIT
     ENDIF
          
          @ 02,70 SAY TIME()
          @ 17,(80-LEN(LINHA16))/2 SAY PADC(SUBSTR(LINHA16,1,CONTADOR),LEN(LINHA16))
          PAUSA(0.01)
     NEXT
     FOR CONTADOR=0 TO LEN(LINHA17)+5 STEP +5
     IF LASTKEY()>0
          EXIT
     ENDIF
          
          @ 02,70 SAY TIME()
          @ 18,(80-LEN(LINHA17))/2 SAY PADC(SUBSTR(LINHA17,1,CONTADOR),LEN(LINHA17))
          PAUSA(0.01)
     NEXT
     FOR CONTADOR=0 TO LEN(LINHA18)+5 STEP +5
     IF LASTKEY()>0
          EXIT
     ENDIF
          
          @ 02,70 SAY TIME()
          @ 19,(80-LEN(LINHA18))/2 SAY PADC(SUBSTR(LINHA18,1,CONTADOR),LEN(LINHA18))
          PAUSA(0.01)
     NEXT
     FOR CONTADOR=0 TO LEN(LINHA19)+5 STEP +5
     IF LASTKEY()>0
          EXIT
     ENDIF
          
          @ 02,70 SAY TIME()
          @ 20,(80-LEN(LINHA19))/2 SAY PADC(SUBSTR(LINHA19,1,CONTADOR),LEN(LINHA19))
          PAUSA(0.01)
     NEXT
     FOR CONTADOR=0 TO LEN(LINHA20)+5 STEP +5
     IF LASTKEY()>0
          EXIT
     ENDIF
          
          @ 02,70 SAY TIME()
          @ 21,(80-LEN(LINHA20))/2 SAY PADC(SUBSTR(LINHA20,1,CONTADOR),LEN(LINHA20))
          PAUSA(0.01)
     NEXT
     FOR CONTADOR=0 TO LEN(LINHA21)+5 STEP +5
     IF LASTKEY()>0
          EXIT
     ENDIF
          
          @ 02,70 SAY TIME()
          @ 22,(80-LEN(LINHA21))/2 SAY PADC(SUBSTR(LINHA21,1,CONTADOR),LEN(LINHA21))
          PAUSA(0.01)
     NEXT
     IF LASTKEY()>0
          EXIT
     ENDIF
     AGUARDA(30)
     TONE(550,3)
ENDDO
set color to w/n
cls
FOR CONTADOR=0 TO LEN(tec1)+5 STEP +5
  SETCOLOR("B+ /n")
  @ 10,(80-LEN(tec1))/2 Say PADR(SUBSTR(tec1,1,CONTADOR),LEN(tec1)) 
  SETCOLOR("B  /n")
  @ 11,(80-LEN(tec2))/2 Say PADC(SUBSTR(tec2,1,CONTADOR),LEN(tec2)) 
  SETCOLOR("BG /n")
  @ 12,(80-LEN(tec3))/2 SAY PADL(SUBSTR(tec3,1,CONTADOR),LEN(tec3)) 
  SETCOLOR("BG+/n")         
  @ 13,(80-LEN(tec4))/2 SAY PADC(SUBSTR(tec4,1,CONTADOR),LEN(tec4)) 
  SETCOLOR("W  /n")
  @ 14,(80-LEN(tec5))/2 SAY PADR(SUBSTR(tec5,1,CONTADOR),LEN(tec5)) 
  INKEY(0.01)
NEXT
  FOR CONTADOR=0 TO LEN(tec1)+5 STEP +5
      @ 16,(80-LEN(MMSTEC))/2 Say PADL(SUBSTR(MMSTEC,1,CONTADOR),LEN(MMSTEC))    COLOR("w+ /n")
      @ 17,(80-LEN(AUTOR))/2 Say PADR(SUBSTR(autor,1,CONTADOR),LEN(autor))       COLOR("g+ / n")
      inkey(0.01)
  Next
TONE(550,3)
SET CURSOR ON
RESTORE SCREEN FROM BOMDIA

FUNCTION PAUSA
PARA X
Inkey(x)
RETURN.T.

FUNCTION AGUARDA
PARA SEG
SET COLOR TO W/N
@ 00,02 SAY REPL(CHR(4),SEG) COLOR("N+/N")
FOR SAI=02 TO SEG
     @ 02,70 SAY TIME()               COLOR("W+  /G")
     SET CURSOR OFF
     IF LASTKEY()=27
        SETCOLOR("RG+/N")
        EXIT
     ENDIF
INKEY(1)
@ 00,SAI SAY CHR(4)                    COLOR("RG+ /N")
@ 00,61  SAY "Restam"                  COLOR("G   /N")
@ 00,68  SAY PADR(SEG-SAI,SEG-SAI)     COLOR("RG+ /N")
@ 00,70  SAY " Segundos"               COLOR("G   /N")
@ 24,68  SAY PADR(SAI,SAI)             COLOR("W+  /N")
@ 24,70  SAY " Segundos"               COLOR("G+  /N")
NEXT
RETURN.T.

FUNCTION MUSICA
SAVE SCREEN TO TELA_MUSICA
COR("TITULO")
@ 00,70 SAY TIME()
TONE(500,4)
@ 00,70 SAY TIME()
TONE(550,4)
@ 00,70 SAY TIME()
TONE(600,4)
@ 00,70 SAY TIME()
TONE(650,4)
@ 00,70 SAY TIME()
TONE(600,4)
@ 00,70 SAY TIME()
TONE(550,4)
@ 00,70 SAY TIME()
TONE(500,4)
@ 00,70 SAY TIME()
TONE(350,4)
@ 00,70 SAY TIME()
TONE(500,4)
@ 00,70 SAY TIME()
TONE(550,7)
@ 00,70 SAY TIME()
TONE(500,4)
@ 00,70 SAY TIME()
TONE(550,7)
@ 00,70 SAY TIME()
TONE(500,4)
@ 00,70 SAY TIME()
TONE(550,4)
@ 00,70 SAY TIME()
TONE(600,4)
@ 00,70 SAY TIME()
TONE(650,4)
@ 00,70 SAY TIME()
TONE(600,4)
@ 00,70 SAY TIME()
TONE(550,4)
@ 00,70 SAY TIME()
TONE(500,4)
@ 00,70 SAY TIME()
TONE(350,4)
@ 00,70 SAY TIME()
TONE(500,4)
@ 00,70 SAY TIME()
TONE(550,7)
@ 00,70 SAY TIME()
TONE(500,7)
@ 00,70 SAY TIME()
TONE(500,7)
@ 00,70 SAY TIME()

TONE(500,4)
@ 00,70 SAY TIME()
TONE(550,4)
@ 00,70 SAY TIME()
TONE(600,4)
@ 00,70 SAY TIME()
TONE(650,4)
@ 00,70 SAY TIME()
TONE(600,4)
@ 00,70 SAY TIME()
TONE(550,4)
@ 00,70 SAY TIME()
TONE(500,4)
@ 00,70 SAY TIME()
TONE(350,4)
@ 00,70 SAY TIME()
TONE(500,4)
@ 00,70 SAY TIME()
TONE(550,7)
@ 00,70 SAY TIME()
TONE(500,7)
@ 00,70 SAY TIME()
TONE(600,10)
@ 00,70 SAY TIME()
TONE(350,4)
@ 00,70 SAY TIME()
@ 00,70 SAY SPACE(10)
RESTORE SCREEN FROM TELA_MUSICA


FUNCTION MMS_EDITOR
SAVE SCREEN TO TELA_EDITOR
CLEAR
*
* -> cores
*
cor1="BG+/b"
cor2="BG+/b"
Cor3="BG+/b"
cor4="BG+/b"
cor5="BG+/b"
cor6="G+/N"
cor7="W+/N"
FUNDO_MMS="G+/N"
JANELA_MMS="B+/b"
TITULO_MMS="W+/B"
FUNDO_MMS=0
*
* -> COORDENADAS
*
L=00
C=00
L1=L+08
L2=L+09
L3=L+10
L4=L+11
L5=L+12
L6=L+08
C1=C+15
C2=C+15
C3=C+15
C4=C+15
C5=C+15
C6=C+44
*
*
*
*
*
DO WHILE.T.
SET CURSOR ON
ARQUIVO=SPACE(45)
ENTRADA()
@ 23,00 SAY PADC(" Digite o nome do arquivo desejado ",80) color ("W+/N")
@ 19,08 SAY " Arquivo / caminho " GET ARQUIVO PICT "@!" Color ("W+/B")
READ
     IF LASTKEY()=27
          EXIT
     ENDIF

SETCOLOR ("G+/n")
TEXTO=MEMOREAD(ARQUIVO)
PREVEW(04,08,18,73," VISUALIZACAO ")
@ 16,11 say "Caminho / Arquivo: " Color ("BG+/N")
@ 16,30 say "í" Color ("RG+/N")
@ 16,32 say "<                                       >" Color ("RG+/N")
@ 16,33 say PADL(ARQUIVO,39) Color ("G+*/N")
*
*
@ 17,11 say "A‡„o Realizada   :" COLOR ("BG+/N")
@ 17,30 say CHR(2) Color ("RG+/N")
@ 17,32 say "<            >" Color ("RG+/N")
@ 17,33 say PADC("LENDO",12) Color ("R+*/N")
SET CURSOR ON
MEMOEDIT(TEXTO,05,11,15,72,.F.)
     ENDDO
     INFORMA()
RESTORE SCREEN FROM TELA_EDITOR
RETURN



**********************
****** FUNCOES *******

Function informa
CLEAR
?REPL(" MMS-Editor ",200)
@ 09,27 SAY PADC(" MMS-Editor Utilit rio ",23) COLOR "W+/N"
@ 10,27 SAY PADC(" ---- vers„o 0.02 ---- ",23) COLOR "G+/N"
@ 13,25 SAY PADC(" Jequie  - Bahia -  Brasil. ",27) COLOR ("G+/N")
@ 14,20 SAY PADC(" Produ‡„o de Marcos Morais de Sousa. ",38) COLOR ("G+/N")
@ 24,00 SAY PADC("",80)


  FUNCTION PAPEL
  SETCOLOR ("g+/n")
  ?REPL(" MMS-Editor ",200)
  RETURN

  FUNCTION TIMBRE
  SETCOLOR ("G+/n")
  TONE (1000,3)
  @ 04,30,16,70 BOX "ÛÛÛÛÛÛÛÛÛ" COLOR ("N/N")
  @ 04,30 TO 16,70 COLOR ("b+/N")
  SOMBRA_MMS(04,30,16,70)
  @ 05,33 SAY PADC("MMS-Editor Utilit rio",35) COLOR "W+/N"
  @ 06,33 SAY PADC("---- vers„o 0.02 ----",35) COLOR "G+/N"
  @ 09,33 SAY PADC("Desenvolvido por:",35) COLOR "W/B"
  @ 10,33 Say PADC("Marcos Morais de Sousa",35) COLOR "RG+/B"
  @ 08,33 to 13,67 color ("B+/B")
  @ 11,33 Say PADC("M.M.S.tec",35) COLOR "B/BG"
  @ 12,33 Say PADC("Artes Gr ficas & Inform tica.",35) COLOR "B/BG"
  @ 13,33 Say PADC("Fone:(073)525-5932",35) COLOR "B/BG"
  @ 14,33 Say PADC("Copyright(R) 1996-1997",35) COLOR "B/BG"
  @ 15,33 SAY PADC("                      ",35) COLOR "B/BG"
  SET CURSOR OFF
  SET COLOR TO W
  RETURN



     FUNCTION FUNDO_MMS
     PARA PJAN1,PJAN2,PJAN3,PJAN4,PJAN5
     PAPEL_1="Å"
     PAPEL_2="è"
     PAPEL_3="Û"
     PAPEL_4="-"
     IF PCOUNT()<>5
        PJAN5=""
     ENDIF
     SOMBRA_MMS(PJAN1,PJAN2,PJAN3,PJAN4)
     SETCOLOR("W+/N")
     @ PJAN1,PJAN2,PJAN3,PJAN4 BOX "ÛÛÛÛÛÛÛÛ"+PAPEL_4
     SETCOLOR("W+/N")
     @ PJAN1,PJAN2,PJAN3,PJAN4 BOX "ÛÛÛÛÛÛÛÛ"
     *SETCOLOR("W+/W")
     *@ PJAN1,PJAN2 TO PJAN3,PJAN4 DOUBLE
     SETCOLOR("W+/B")
     @ PJAN1,PJAN2 clear to PJAN1,PJAN4
     IF LEN(TRIM(PJAN5)) > 0
        @ PJAN1,PJAN2+(((PJAN4+1-PJAN2)-LEN(PJAN5))/2) SAY PJAN5
     ENDIF


     FUNCTION JANELA_MMS
     PARA PJAN1,PJAN2,PJAN3,PJAN4,PJAN5
     IF PCOUNT()<>5
        PJAN5=""
     ENDIF
     SOMBRA_MMS(PJAN1,PJAN2,PJAN3,PJAN4)
     SETCOLOR("B+/B")
     @ PJAN1,PJAN2,PJAN3,PJAN4 BOX "ÛÛÛÛÛÛÛÛÛ"
     SETCOLOR(COR1)
     *@ PJAN1,PJAN2 TO PJAN3,PJAN4 DOUBLE
     SETCOLOR("W+/B")
     @ PJAN1,PJAN2 clear to PJAN1,PJAN4
     IF LEN(TRIM(PJAN5)) > 0
        @ PJAN1,PJAN2+(((PJAN4+1-PJAN2)-LEN(PJAN5))/2) SAY PJAN5
     SET COLOR TO W/N
     ENDIF



     FUNCTION PREVEW
     PARA PJAN1,PJAN2,PJAN3,PJAN4,PJAN5
     PAPEL="-"
     IF PCOUNT()<>5
        PJAN5=""
     ENDIF
     SOMBRA_MMS(PJAN1,PJAN2,PJAN3,PJAN4)
     SETCOLOR("G+/N")
     @ PJAN1,PJAN2,PJAN3,PJAN4 BOX "ÛÛÛÛÛÛÛÛ"+PAPEL
     SETCOLOR("N/N")
     @ PJAN1,PJAN2+2,PJAN3-1,PJAN4-1 BOX "ÛÛÛÛÛÛÛÛÛ"
     SETCOLOR("W+/N")
     *@ PJAN1,PJAN2 TO PJAN3,PJAN4 DOUBLE
     SETCOLOR("W+/G")
     @ PJAN1,PJAN2 clear to PJAN1,PJAN4
     IF LEN(TRIM(PJAN5)) > 0
        @ PJAN1,PJAN2+(((PJAN4+1-PJAN2)-LEN(PJAN5))/2) SAY PJAN5
     SET COLOR TO W/N
     ENDIF

FUNCTION SOMBRA_MMS
PARA LIN_SUP,COL_SUP,LIN_INF,COL_INF
IF PCOUNT()=2 .OR. PCOUNT()=3
   C_SOM=COL_SUP
   L_SOM=LIN_SUP
   LIN_SUP=VAL(SUBS(C_SOM,1,2))
   COL_SUP=VAL(SUBS(C_SOM,3,2))
   LIN_INF=VAL(SUBS(C_SOM,5,2))
   COL_INF=VAL(SUBS(C_SOM,7,2))
   COL_SOM=SUBS(C_SOM,9)
   LIN_SOM=L_SOM
ENDIF
IF COL_SUP<2 .OR. LIN_INF>22
   C_SOM=""
   L_SOM=""
   RETURN .F.
ENDIF
IF PCOUNT()=3
   RESTSCREEN(LIN_SUP+1,COL_SUP-2,LIN_INF+1,COL_SUP-1,COL_SOM)
   RESTSCREEN(LIN_INF+1,COL_SUP-2,LIN_INF+2,COL_INF-2,LIN_SOM)
   RETURN .F.
ENDIF
IF PCOUNT()<>2
   COL_SOM=SAVESCREEN(LIN_SUP+1,COL_SUP-2,LIN_INF+1,COL_SUP-1)
   LIN_SOM=SAVESCREEN(LIN_INF+1,COL_SUP-2,LIN_INF+2,COL_INF-2)
ENDIF
COL_SOM=SUBS(COL_SOM,1,((LIN_INF-LIN_SUP)+1)*4)
LIN_SOM=SUBS(LIN_SOM,1,((COL_INF-COL_SUP)+1)*4)
*
IF SUBS(COL_SOM,2,1)<>CHR(8)
   C_SOM=STR(LIN_SUP,2)+STR(COL_SUP,2)+STR(LIN_INF,2)+STR(COL_INF,2)+COL_SOM
   L_SOM=LIN_SOM
ENDIF
FOR I=2 TO LEN(COL_SOM) STEP 2
   COL_SOM=STUFF(COL_SOM,I,1,CHR(8))

NEXT
FOR I=2 TO LEN(LIN_SOM)/2 STEP 2
   LIN_SOM=STUFF(LIN_SOM,I,1,CHR(8))

NEXT
RESTSCREEN(LIN_SUP+1,COL_SUP-2,LIN_INF+1,COL_SUP-1,COL_SOM)
RESTSCREEN(LIN_INF+1,COL_SUP-2,LIN_INF+2,COL_INF-2,LIN_SOM)
*
************************************************************
*
FUNCTION ENTRADA
SET CURSOR ON
SET COLOR TO G+
?REPL(" MMS-Editor ",200)
JANELA_MMS(02,05,20,75," MMS-Editor V.1.0 ")
Arquivo=space(45)
Private fontes[adir("*.*")]
Adir("*.*",fontes)
SETCOLOR ("b+/B")
FUNDO_MMS(04,08,16,25," ARQUIVOS ")
SET COLOR TO W
TIMBRE()
@ 23,00 SAY PADC(" Mova o cursor para vizualizar mais arquivos e/ou <ENTER> ",80) color ("W+/N")
@ 24,00 SAY PADC(" <ESC> : Retorna ao MS-Dos ",80)                 color ("RG+/N")
SETCOLOR ("w/n,W+/BG")
Escolha=achoice(05,10,15,24,Fontes)
SET COLOR TO W+
RETURN


FUNCTION DESCANSO_MMS
SAVE SCREEN TO APRESENTA_TELA
SET COLOR TO W/N
SET CURSOR OFF
CLS
*
tec1=" ÛÜ   ÜÛ ÛÜ   ÜÛ ÛßßßßßÛ  Ü  Inform tica Ltda."
tec2=" Û ßÜß Û Û ßÜß Û ÛÜÜÜÜÜÜ ßÛß ÛßßßßßÛ ÛßßßßßßÛ "
tec3=" Û     Û Û     Û Ü     Û  Û  Ûßßßßßß Û      Ü "
tec4=" Û     Û Û     Û ßßßßßßß  ßß ßßßßßßß ßßßßßßßß "
tec5=" ß     ßßß     ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß"
*
*
CONTADOR=0
AUTOR=" Marcos Morais de Sousa. "
CIDADE=" Jequi‚, Bahia "
HOJE=DATE()
SEMANA="Domingo      Segunda-feiraTerca-feira  Quarta-feira "
SEMANA=SEMANA+"Quinta-feira Sexta-feira  S bado       "
DIA=TRIM(SUBS(SEMANA,DOW(HOJE)*13-12,13))+", "+ALLTRIM(STR(DAY(HOJE),2))
MES="Janeiro  FevereiroMar‡o    Abril    Maio     Junho    "
MES=MES+"Julho    Agosto   Setembro Outubro  Novembro Dezembro "
DIA=DIA+" de "+TRIM(SUBS(MES,MONTH(HOJE)*9-8,9))+" de "
DIA=DIA+TRAN(YEAR(M->HOJE),"@E 9999")+" -"
*/////////////////////////////////////////////////////////////////*
*
FOR CONTADOR=0 TO LEN(tec1)+5 STEP +5
  SETCOLOR("B+ /N")
  @ 10,(80-LEN(tec1))/2 Say PADR(SUBSTR(tec1,1,CONTADOR),LEN(tec1))
  SETCOLOR("B  /N")
  @ 11,(80-LEN(tec2))/2 Say PADC(SUBSTR(tec2,1,CONTADOR),LEN(tec2))
  SETCOLOR("BG /N")
  @ 12,(80-LEN(tec3))/2 SAY PADL(SUBSTR(tec3,1,CONTADOR),LEN(tec3))
  SETCOLOR("BG+/N")
  @ 13,(80-LEN(tec4))/2 SAY PADC(SUBSTR(tec4,1,CONTADOR),LEN(tec4))
  SETCOLOR("W  /N")
  @ 14,(80-LEN(tec5))/2 SAY PADR(SUBSTR(tec5,1,CONTADOR),LEN(tec5))
  INKEY(0.01)
NEXT
INKEY(1)
FOR CONTADOR=LEN(tec1)+5 TO 0 STEP -5
  SETCOLOR("B+ /N")
  @ 10,(80-LEN(tec1))/2 Say PADR(SUBSTR(tec1,1,CONTADOR),LEN(tec1))
  SETCOLOR("B  /N")
  @ 11,(80-LEN(tec2))/2 Say PADC(SUBSTR(tec2,1,CONTADOR),LEN(tec2))
  SETCOLOR("BG /N")
  @ 12,(80-LEN(tec3))/2 SAY PADL(SUBSTR(tec3,1,CONTADOR),LEN(tec3))
  SETCOLOR("BG+/N")
  @ 13,(80-LEN(tec4))/2 SAY PADC(SUBSTR(tec4,1,CONTADOR),LEN(tec4))
  SETCOLOR("W  /N")
  @ 14,(80-LEN(tec5))/2 SAY PADR(SUBSTR(tec5,1,CONTADOR),LEN(tec5))
  INKEY(0.01)
NEXT
*////////////////////////////////////////////////////////////////////*
     *
     ///////////////////// COLUNA I ///////////////////////*
     *
     L1C1="Desenvolvido por:"
     L2C1="MMStec Artes Gr ficas e Inform tica."
     L3C1="//\\//\\//\\//\\//\\//\\//\\//\\//\\//"
     *
     *
     L4C1="Concep‡„o, Programa‡„o, Interface e"
     L5C1="Tratamento de Imagens:"
     L6C1="MARCOS MORAIS DE SOUSA"
     *
     L7C1="Concep‡„o de Imagens, Interface e"
     L8C1="Coordena‡„o Geral:"
     L9C1="MARCOS MOARSI DE SOUSA"
     *
     L10C1="Analise das funcoes,"
     L11C1="Redacao e organiza‡„o"
     L12C1="Revis„o e corre‡„o"
     L13C1="Pesquisa"
     L14C1="MARCOS MORAIS DE SOUSA"
     *
     L15C1="Gerador"
     L16C1="MIRRO 2.22"
     *
     L17C1="Copilador"
     L18C1="CLIPPER 5.10"
     *
     ///////////////////// COLUNA II //////////////////////
     *
     L1C2="Desenvolvimento de Fun‡oes:"
     L2C2="MARCOS MORAIS DE SOUSA"
     *
     L3C2="Digita‡„o"
     L4C2="MARCOS MORAIS DE SOUSA"
     *
     L5C2="Apoio"
     L6C2="MFB Materiais de Constru‡„o Ltda."
     *
     L7C2="Atualiza‡ao e/ou altera‡„o"
     L8C2="MARCOS MORAIS DE SOUSA"
     *
     L9C2="Agradecimentos muito especiais"
     L10C2="'JESUS CRISTO'"
     L11C2="VALDIR CARLOS DE JESUS BARRETO"
     L12C2="EDSON SENNA SILVA"
     L13C2="EDJALMA FERREIRA DOS SANTOS"
     L14C2="ELIERSON FERREIRA DOS SANTOS"

For Contador=0 to LEN(DIA+CIDADE)
    SET COLOR TO G+/N
    @ 00,(80-LEN(DIA+CIDADE))/2 SAY PADC(SUBSTR(DIA+CIDADE,1,CONTADOR),LEN(DIA+CIDADE))
    INKEY(0.01)
NexT
*
@ 01,00 CLEAR TO 24,79
DO WHILE.t.
    IF lastkey()=27
          RESTORE SCREEN FROM APRESENTA_TELA
          EXIT
    endif
    ****************
     SET COLOR TO W/N
     SET CURSOR OFF
     For Contador=0 to LEN(L1C1)+3 STEP +3
     IF lastkey()=27
          EXIT
     endif

          SET COLOR TO W/N
          @ 01,00 SAY PADL(SUBSTR(L1C1,1,CONTADOR),38)
          INKEY(0.01)
     NexT
     For Contador=0 to LEN(L2C1)+3 STEP +3
          IF lastkey()=27
              EXIT
          endif

          SET COLOR TO W+/N
          @ 02,00 SAY PADL(SUBSTR(L2C1,1,CONTADOR),38)
          INKEY(0.01)
     NexT
     For Contador=0 to LEN(L3C1)+3 STEP +3
          IF lastkey()=27
              EXIT
          endif
          SET COLOR TO G/N
          @ 03,00 SAY PADL(SUBSTR(L3C1,1,CONTADOR),38)
          INKEY(0.01)
     NexT
     **************************************************
     For Contador=0 to LEN(L4C1)+3 STEP +3
          IF lastkey()=27
              EXIT
          endif
          SET COLOR TO G/N
          @ 05,00 SAY PADL(SUBSTR(L4C1,1,CONTADOR),38)
          INKEY(0.01)
     NexT
     For Contador=0 to LEN(L5C1)+3 STEP +3
          IF lastkey()=27
              EXIT
          endif
          SET COLOR TO G/N
          @ 06,00 SAY PADL(SUBSTR(L5C1,1,CONTADOR),38)
          INKEY(0.01)
     NexT
     For Contador=0 to LEN(L6C1)+3 STEP +3
          IF lastkey()=27
              EXIT
          endif
          SET COLOR TO G+/N
          @ 07,00 SAY PADL(SUBSTR(L6C1,1,CONTADOR),38)
          INKEY(0.01)
     NexT
     **************************************************
     For Contador=0 to LEN(L7C1)+3 STEP +3
          IF lastkey()=27
              EXIT
          endif
          SET COLOR TO G/N
          @ 09,00 SAY PADL(SUBSTR(L7C1,1,CONTADOR),38)
          INKEY(0.01)
     NexT
     For Contador=0 to LEN(L8C1)+3 STEP +3
          IF lastkey()=27
              EXIT
          endif
          SET COLOR TO G/N
          @ 10,00 SAY PADL(SUBSTR(L8C1,1,CONTADOR),38)
          INKEY(0.01)
     NexT
     For Contador=0 to LEN(L9C1)+3 STEP +3
          IF lastkey()=27
              EXIT
          endif
          SET COLOR TO G+/N
          @ 11,00 SAY PADL(SUBSTR(L9C1,1,CONTADOR),38)
          INKEY(0.01)
     NexT
     **************************************************
     For Contador=0 to LEN(L10C1)+3 STEP +3
          IF lastkey()=27
              EXIT
          endif
          SET COLOR TO G/N
          @ 13,00 SAY PADL(SUBSTR(L10C1,1,CONTADOR),38)
          INKEY(0.01)
     NexT
     For Contador=0 to LEN(L11C1)+3 STEP +3
          IF lastkey()=27
              EXIT
          endif
          SET COLOR TO G/N
          @ 14,00 SAY PADL(SUBSTR(L11C1,1,CONTADOR),38)
          INKEY(0.01)
     NexT
     For Contador=0 to LEN(L12C1)+3 STEP +3
          IF lastkey()=27
              EXIT
          endif
          SET COLOR TO G/N
          @ 15,00 SAY PADL(SUBSTR(L12C1,1,CONTADOR),38)
          INKEY(0.01)
     NexT
     For Contador=0 to LEN(L13C1)+3 STEP +3
          IF lastkey()=27
              EXIT
          endif
          SET COLOR TO G/N
          @ 16,00 SAY PADL(SUBSTR(L13C1,1,CONTADOR),38)
          INKEY(0.01)
     NexT
     For Contador=0 to LEN(L14C1)+3 STEP +3
          IF lastkey()=27
              EXIT
          endif
          SET COLOR TO G+/N
          @ 17,00 SAY PADL(SUBSTR(L14C1,1,CONTADOR),38)
          INKEY(0.01)
     NexT
     **************************************************
     For Contador=0 to LEN(L15C1)+3 STEP +3
          IF lastkey()=27
              EXIT
          endif
          SET COLOR TO G/N
          @ 19,00 SAY PADL(SUBSTR(L15C1,1,CONTADOR),38)
          INKEY(0.01)
     NexT
     For Contador=0 to LEN(L16C1)+3 STEP +3
          IF lastkey()=27
              EXIT
          endif
          SET COLOR TO G+/N
          @ 20,00 SAY PADL(SUBSTR(L16C1,1,CONTADOR),38)
          INKEY(0.01)
     NexT
     **************************************************
     For Contador=0 to LEN(L17C1)+3 STEP +3
          IF lastkey()=27
              EXIT
          endif
          SET COLOR TO G/N
          @ 22,00 SAY PADL(SUBSTR(L17C1,1,CONTADOR),38)
          INKEY(0.01)
     NexT
     For Contador=0 to LEN(L18C1)+3 STEP +3
          IF lastkey()=27
              EXIT
          endif
          SET COLOR TO G+/N
          @ 23,00 SAY PADL(SUBSTR(L18C1,1,CONTADOR),38)
          INKEY(0.01)
     NexT
     **************************************************
     *
     *
     * ////////////////// coluna dois //////////////////////////////
     *
     For Contador=0 to LEN(L1C2)+3 STEP +3
          IF lastkey()=27
              EXIT
          endif
          SET COLOR TO G/N
          @ 05,40 SAY PADR(SUBSTR(L1C2,1,CONTADOR),38)
          INKEY(0.01)
     NexT
     For Contador=0 to LEN(L2C2)+3 STEP +3
          IF lastkey()=27
              EXIT
          endif
          SET COLOR TO G+/N
          @ 06,40 SAY PADR(SUBSTR(L2C2,1,CONTADOR),38)
          INKEY(0.01)
     NexT
     **************************************************
     For Contador=0 to LEN(L3C2)+3 STEP +3
          IF lastkey()=27
              EXIT
          endif
          SET COLOR TO G/N
          @ 08,40 SAY PADR(SUBSTR(L3C2,1,CONTADOR),38)
          INKEY(0.01)
     NexT
     For Contador=0 to LEN(L4C2)+3 STEP +3
          IF lastkey()=27
              EXIT
          endif

          SET COLOR TO G+/N
          @ 09,40 SAY PADR(SUBSTR(L4C2,1,CONTADOR),38)
          INKEY(0.01)
     NexT
     **************************************************
     For Contador=0 to LEN(L5C2)+3 STEP +3
          IF lastkey()=27
              EXIT
          endif
          SET COLOR TO G/N
          @ 11,40 SAY PADR(SUBSTR(L5C2,1,CONTADOR),38)
          INKEY(0.01)
     NexT
     For Contador=0 to LEN(L6C2)+3 STEP +3
          IF lastkey()=27
              EXIT
          endif
          SET COLOR TO G+/N
          @ 12,40 SAY PADR(SUBSTR(L6C2,1,CONTADOR),38)
          INKEY(0.01)
     NexT
     **************************************************
     For Contador=0 to LEN(L7C2)+3 STEP +3
          IF lastkey()=27
              EXIT
          endif
          SET COLOR TO G/N
          @ 14,40 SAY PADR(SUBSTR(L7C2,1,CONTADOR),38)
          INKEY(0.01)
     NexT
     For Contador=0 to LEN(L8C2)+3 STEP +3
          IF lastkey()=27
              EXIT
          endif
          SET COLOR TO G+/N
          @ 15,40 SAY PADR(SUBSTR(L8C2,1,CONTADOR),38)
          INKEY(0.01)
     NexT
     **************************************************
     For Contador=0 to LEN(L9C2)+3 STEP +3
          IF lastkey()=27
              EXIT
          endif
          SET COLOR TO G/N
          @ 17,40 SAY PADR(SUBSTR(L9C2,1,CONTADOR),38)
          INKEY(0.01)
     NexT
     For Contador=0 to LEN(L10C2)+3 STEP +3
          IF lastkey()=27
              EXIT
          endif
          SET COLOR TO G+/N
          @ 18,40 SAY PADR(SUBSTR(L10C2,1,CONTADOR),38)
          INKEY(0.01)
     NexT
     For Contador=0 to LEN(L11C2)+3 STEP +3
          IF lastkey()=27
              EXIT
          endif
          SET COLOR TO G+/N
          @ 19,40 SAY PADR(SUBSTR(L11C2,1,CONTADOR),38)
          INKEY(0.01)
     NexT
     For Contador=0 to LEN(L12C2)+3 STEP +3
          IF lastkey()=27
              EXIT
          endif
          SET COLOR TO G+/N
          @ 20,40 SAY PADR(SUBSTR(L12C2,1,CONTADOR),38)
          INKEY(0.01)
     NexT
     For Contador=0 to LEN(L13C2)+3 STEP +3
          IF lastkey()=27
              EXIT
          endif
          SET COLOR TO G+/N
          @ 21,40 SAY PADR(SUBSTR(L13C2,1,CONTADOR),38)
          INKEY(0.01)
     NexT
     For Contador=0 to LEN(L14C2)+3 STEP +3
          IF lastkey()=27
              EXIT
          endif
          SET COLOR TO G+/N
          @ 22,40 SAY PADR(SUBSTR(L14C2,1,CONTADOR),38)
          INKEY(0.01)
     NexT
*///////////////////////////////////////////////////////////////////////*
CLS
FOR CONTADOR=0 TO LEN(tec1)+5 STEP +5
  SETCOLOR("B+ /N")
  @ 10,(80-LEN(tec1))/2 Say PADR(SUBSTR(tec1,1,CONTADOR),LEN(tec1))
  SETCOLOR("B  /N")
  @ 11,(80-LEN(tec2))/2 Say PADC(SUBSTR(tec2,1,CONTADOR),LEN(tec2))
  SETCOLOR("BG /N")
  @ 12,(80-LEN(tec3))/2 SAY PADL(SUBSTR(tec3,1,CONTADOR),LEN(tec3))
  SETCOLOR("BG+/N")
  @ 13,(80-LEN(tec4))/2 SAY PADC(SUBSTR(tec4,1,CONTADOR),LEN(tec4))
  SETCOLOR("W  /N")
  @ 14,(80-LEN(tec5))/2 SAY PADR(SUBSTR(tec5,1,CONTADOR),LEN(tec5))
  INKEY(0.01)
NEXT
*///////////////////////////////////////////////////////////////////////*
For Contador=0 to LEN(DIA+CIDADE)
          SET COLOR TO G+/N
          @ 00,(80-LEN(DIA+CIDADE))/2 SAY PADC(SUBSTR(DIA+CIDADE,1,CONTADOR),LEN(DIA+CIDADE))
          INKEY(0.01)
NexT
     @ 23,00 say PADR("Desenvolvido por:",80) color "w/n"
For Contador=0 to LEN(AUTOR)
          SET COLOR TO G+/N
          @ 24,00 SAY PADR(SUBSTR(AUTOR,1,CONTADOR),LEN(AUTOR))
          Tone(450,0.01)
NexT
//////////////////////////////////////////////////////////////////////*
FOR CONTADOR=LEN(tec1)+5 TO 0 STEP -5
  SETCOLOR("B+ /N")
  @ 10,(80-LEN(tec1))/2 Say PADR(SUBSTR(tec1,1,CONTADOR),LEN(tec1))
  SETCOLOR("B  /N")
  @ 11,(80-LEN(tec2))/2 Say PADC(SUBSTR(tec2,1,CONTADOR),LEN(tec2))
  SETCOLOR("BG /N")
  @ 12,(80-LEN(tec3))/2 SAY PADL(SUBSTR(tec3,1,CONTADOR),LEN(tec3))
  SETCOLOR("BG+/N")
  @ 13,(80-LEN(tec4))/2 SAY PADC(SUBSTR(tec4,1,CONTADOR),LEN(tec4))
  SETCOLOR("W  /N")
  @ 14,(80-LEN(tec5))/2 SAY PADR(SUBSTR(tec5,1,CONTADOR),LEN(tec5))
  INKEY(0.01)
NEXT
*////////////////////////////////////////////////////////////////////*
ENDDO
RESTORE SCREEN FROM APRESENTA_TELA
RETURN.T.
 
* ///////////////////////////////////////////////////////////////////////////*
* -> Inicio da funcao LOGOMARCA ( ARQUIVO DE INCERSAO : FUN.B03 )
*
FUNCTION LOGOMARCA
*
X    :=03;Y =X-1;LA=03;A=0
LB   :=LA+1;LC=LB+1;LD=LC+1;LE=LD+1;LF=LE+1
LG   :=LF+1;LH=LG+1;LI=LH+1;LJ=LI+1;LL=LJ+1
AUTOR:="(C) Marcos Morais de Sousa 1996/1997"
LINHA:=REPL("Ä",80)

CLS
SETCOLOR("G+/N")
@ LA,X say "ÛÛÛÛ     ÛÛÛÛ ÛÛÛÛ     ÛÛÛÛ ÜÛÛÛÛÛÛÛÛÛÜ ÛÛÛÛÛÛÛÛÛÛÛÛ ÛÛÛÛÛÛÛÛÛÛ ÛÛÛÛÛÛÛÛÛÛ"
@ LB,X say "ÛÛÛÛÛ   ÛÛÛÛÛ ÛÛÛÛÛ   ÛÛÛÛÛ ÛÛÛÛÛÛÛÛÛÛÛ ÛÛÛÛÛÛÛÛÛÛÛÛ ÛÛÛÛÛÛÛÛÛÛ ÛÛÛÛÛÛÛÛÛÛ"
@ LC,X say "ÛÛÛÛÛÛ ÛÛÛÛÛÛ ÛÛÛÛÛÛ ÛÛÛÛÛÛ ÛÛÛÛ   ÛÛÛÛ     ÛÛÛÛ     ÛÛÛÛ       ÛÛÛÛ"      
@ LD,X say "ÛÛÛÛÛÛÛÛÛÛÛÛÛ ÛÛÛÛÛÛÛÛÛÛÛÛÛ ÛÛÛÛ            ÛÛÛÛ     ÛÛÛÛ       ÛÛÛÛ"      
@ LE,X say "ÛÛÛÛÛÛÛÛÛÛÛÛÛ ÛÛÛÛÛÛÛÛÛÛÛÛÛ ÛÛÛÛÛÛÛÛÛÛÜ     ÛÛÛÛ     ÛÛÛÛÛÛÛÛ   ÛÛÛÛ"      
@ LF,X say "ÛÛÛÛ ÛÛÛ ÛÛÛÛ ÛÛÛÛ ÛÛÛ ÛÛÛÛ ßÛÛÛÛÛÛÛÛÛÛ     ÛÛÛÛ     ÛÛÛÛÛÛÛÛ   ÛÛÛÛ"      
@ LG,X say "ÛÛÛÛ  Û  ÛÛÛÛ ÛÛÛÛ  Û  ÛÛÛÛ        ÛÛÛÛ     ÛÛÛÛ     ÛÛÛÛ       ÛÛÛÛ"      
@ LH,X say "ÛÛÛÛ     ÛÛÛÛ ÛÛÛÛ     ÛÛÛÛ ÛÛÛÛ   ÛÛÛÛ     ÛÛÛÛ     ÛÛÛÛ       ÛÛÛÛ"  
@ LI,X say "ÛÛÛÛ     ÛÛÛÛ ÛÛÛÛ     ÛÛÛÛ ÛÛÛÛÛÛÛÛÛÛÛ     ÛÛÛÛ     ÛÛÛÛÛÛÛÛÛÛ ÛÛÛÛÛÛÛÛÛÛ"
@ LJ,X say "ÛÛÛÛ     ÛÛÛÛ ÛÛÛÛ     ÛÛÛÛ ßÛÛÛÛÛÛÛÛÛß     ÛÛÛÛ     ÛÛÛÛÛÛÛÛÛÛ ÛÛÛÛÛÛÛÛÛÛ"

SETCOLOR("G/N")      
@ LC,Y+33  say "ÛÛÛ";@ LC,Y+41  say "ÛÛÛÛ";@ LC,Y+49  say "ÛÛÛÛ";@ LC,Y+58  say "ÛÛÛÛÛÛ";@ LC,Y+69  say "ÛÛÛÛÛÛ"                              
@ LD,Y+36  say "ÛÛÛÛ"
@ LF,Y+05  say "Û";@ LF,Y+09  say "Û";@ LF,Y+19  say "Û";@ LF,Y+23  say "Û";@ LF,Y+29  say "Û"
@ LG,Y+06  say "Û";@ LG,Y+08  say "Û";@ LG,Y+20  say "Û";@ LG,Y+22  say "Û";@ LG,Y+30  say "ÛÛÛÛÛÛ";@ LG,Y+58  say "ÛÛÛÛ"
@ LH,Y+07  say "Û";@ LH,Y+21  say "Û"
@ LJ,Y+29  say "Û";@ LJ,Y+39  say "Û"
@ LL,Y+01  say "ÛÛÛÛ";@ LL,Y+10  say "ÛÛÛÛ";@ LL,Y+15  say "ÛÛÛÛ";@ LL,Y+24  say "ÛÛÛÛ";@ LL,Y+30  say "ÛÛÛÛÛÛÛÛÛ"
@ LL,Y+45  say "ÛÛÛÛ";@ LL,Y+54  say "ÛÛÛÛÛÛÛÛÛÛ";@ LL,Y+65  say "ÛÛÛÛÛÛÛÛÛÛ"
SETCOLOR("G+/BG")      

FOR   A  :=0 TO LEN(LINHA)+10 STEP +10
      SET COLOR TO W+/N
      @ LL+3,(80-LEN(AUTOR)) SAY PADC(SUBSTR(AUTOR,1,A),LEN(AUTOR))
      @ LL+2,(80-LEN(LINHA)) SAY PADR(SUBSTR(LINHA,1,A),LEN(LINHA)) COLOR("r+/N")
      INKEY(0.01)
NEXT
BEEP()
*
* -> Final da funcao LOGOMARCA
* ///////////////////////////////////////////////////////////////////////////*

   FUNCTION DATE_MMS(x,y)
   x=0
   y=0
   M->DIA=DATE()
   M->ANO=DATE()
   M->MES=DATE()
   *************
   SETCOLOR ("G+/N") 
   @ x,y+00 SAY "Jequie,"
   @ x,y+09 SAY TRAN(DAY(M->DIA),"99 de") 
   @ x,y+15 SAY SUBS("Janeiro   Fevereiro Mar‡o     Abril     Maio      Junho     Julho     Agosto    Setembro  Outubro   Novembro  Dezembro ",MONTH(M->MES)*10-9,10)  
   @ x,y+25 SAY TRAN(YEAR(M->ANO),"de 9999.")                                    
   @ x+1,00 SAY  REPL("Ä",80) color "R+/N"
   *
   * @x,y+19 SAY TRAN(MONTH(M->MES),"99 de")                                    
   *
   return


FUNCTION DATAS
***********************
@ 02,00 clear to 02,80
***********************
CONTADOR=0
AUTOR=" (C) Marcos Morais de Sousa - 1996/1997 "
CIDADE=" -"+" JEQUIE/BAHIA "
HOJE=DATE()
SEMANA="Domingo      Segunda-feiraTerca-feira  Quarta-feira Quinta-feira "
SEMANA=SEMANA+"Sexta-feira  S bado       "
DIA=TRIM(SUBS(SEMANA,DOW(HOJE)*13-12,13))+", "+ALLTRIM(STR(DAY(HOJE),2))
MES="janeiro  fevereiromar‡o    abril    maio     junho    "
MES=MES+"julho    agosto   setembro outubro  novembro dezembro "
DIA=DIA+" de "+TRIM(SUBS(MES,MONTH(HOJE)*9-8,9))+" de "
DIA=DIA+TRAN(YEAR(HOJE),"@E 9999")
     COLESQ=(80-LEN(DIA+CIDADE))/2-2
     COLDIR=COLESQ+LEN(DIA+CIDADE)+2
     SETCOLOR("N /N")
     @ 14,COLESQ CLEAR TO 16,COLDIR 
     @ 14,COLESQ       TO 16,COLDIR COLOR("N+/N")
SOMBRA(14,COLESQ,         16,COLDIR) 
     @ 15,COLESQ+2 SAY PADC(DIA+CIDADE,LEN(DIA+CIDADE)) COLOR("G+/N")
RETURN

FUNCTION SEGURANCA
SAVE SCREEN TO M->TELA_SEG 
M->MARCOS="593210"
M->VALDIR="102030"
SENHA=SPACE(20)
TENTATIVA=0
DO WHILE.T.
SET CURSOR ON
SETCOLOR ("W+/R")
SOMBRA(09,25,15,55)
@ 09,25 CLEAR TO 15,55 
@ 09,25 TO 15,55    COLOR ("W/R")
@ 09,25 SAY CHR(2)  COLOR ("RG+/R")
@ 11,26 say PADC(" Qual a senha?:",29) 
@ 13,31 GET SENHA PICT[@!] COLOR("W+/N")
READ
SET CURSOR OFF
IF SENHA=M->MARCOS
     @ 09,25 CLEAR TO 15,55 
     @ 09,25 TO 15,55    COLOR ("W/R")
     @ 12,26 say PADC(" Acesso concedido!!! Marcos ",29)
     SET COLOR TO W
   exit
endif
IF SENHA=M->VALDIR
     @ 09,25 CLEAR TO 15,55 
     @ 09,25 TO 15,55    COLOR ("W/R")
     @ 12,26 say PADC(" Acesso concedido!!! Valdir ",29)
     SET COLOR TO W
   exit
endif
     @ 09,25 CLEAR TO 15,55 
     @ 09,25 TO 15,55    COLOR ("W/R")
     @ 11,26 say PADC(" Senha incorreta!!! ",29) COLOR("RG+/R")
     BEEP()
     @ 13,26 say PADC(" Acesso Negado!!! ",29)   COLOR("RG+/R")
     BEEP()
     Inkey(1)
TENTATIVA=TENTATIVA+1
     IF TENTATIVA<3                               
     MENSAGEM("Prossiga com a senha correta!")
     ENDIF
  ENDDO
BEEP()
RESTORE SCREEN FROM M->TELA_SEG 
RETURN

FUNCTION DTTA
PARA L,C
*
CONTADOR=0
CIDADE=" -"+" JEQUIE/BAHIA"
HOJE=DATE()
SEMANA="Domingo      Segunda-feiraTerca-feira  Quarta-feira Quinta-feira Sexta-feira  S bado       "
DIA=TRIM(SUBS(SEMANA,DOW(HOJE)*13-12,13))+", "+ALLTRIM(STR(DAY(HOJE),2))
MES="janeiro  fevereiromar‡o    abril    maio     junho    "
MES=MES+"julho    agosto   setembro outubro  novembro dezembro "
DIA=DIA+" de "+TRIM(SUBS(MES,MONTH(HOJE)*9-8,9))+" de "
DIA=DIA+TRAN(YEAR(HOJE),"@E 9999")
FOR CONTA=0 TO LEN(DIA+CIDADE)+5 STEP +5
     SETCOLOR("G+/N")
     @ L,(80-LEN(DIA+CIDADE))/2 SAY PADR(SUBSTR(DIA+CIDADE,1,CONTA),LEN(DIA+CIDADE))
     inkey(0.01)
NEXT
RETURN
     
* //////////////////////////////////////////////////////////////////////////////////
* - > Inicio da funcao que imprime um rodape
*
FUNCTION RODAPE
PARA L,C,T
*
AUTOR   :="(C) Marcos Morais de Sousa - 1995/"+TRAN(YEAR(DATE()),"@E 9999")
CONTA   :=0
HOJE    :=DATE()
SEMANA  :="Domingo      Segunda-feiraTerca-feira  Quarta-feira Quinta-feira Sexta-feira  S bado       "
DIA     :=TRIM(SUBS(SEMANA,DOW(HOJE)*13-12,13))+", "+ALLTRIM(STR(DAY(HOJE),2))
MES     :="janeiro  fevereiromar‡o    abril    maio     junho    "
MES     :=MES+"julho    agosto   setembro outubro  novembro dezembro "
DIA     :=DIA+" de "+TRIM(SUBS(MES,MONTH(HOJE)*9-8,9))+" de "
DIA     :=DIA+TRAN(YEAR(HOJE),"@E 9999 - JEQUIE/BAHIA ")
 IF T <> 0
   @ L,C SAY PADC(AUTOR,T)
   @ L+1,C SAY PADC(DIA,T)
 ELSE
   @ L,C SAY PADC(AUTOR,T)
   @ L+1,C SAY PADC(DIA,T)
 ENDIF
RETURN
*
* - > Final da funcao que imprime um rodape
* //////////////////////////////////////////////////////////////////////////////////

     
**BI [FIM] FUN.B03
**
 
/* Final do programa LIVROFU1.PRG */