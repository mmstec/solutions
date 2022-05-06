
/*
TITULO     : MFB - LIVRO DE PRECOS
DATA       : 26/06/97
PROGRAMA   : LIVROFU2.PRG
COMENTARIO : FUNCOES - PARTE 2
*/

#include "LIVRO.CH"
#include "LIVROMOU.CH"
**
**BI [INI] FUN.B04
**BI [FIM] FUN.B04
**

*** (Em uso)
*** Inicio do bloco de substituiáÑo MENU.B
FUNCTION MENU
*
* -> Funcao que monta menu
PARA N_TELA
IF PCOUNT()=0
   N_TELA=0
   SET KEY  4 TO T_DIR
   SET KEY 19 TO T_ESQ
ENDIF
M->M_POS=MENU_POS[M->MENU_P]
M->LIN_INIC=LIN_MENU+2
IF N_TELA=1 .OR. N_TELA=2
   M->M_POS=M->M_POS+10
   IF N_TELA=1
      M->LIN_INIC=LIN_MENU+MENU_S+2
   ELSE
      M->LIN_INIC=LIN_MENU+2
   ENDIF
ENDIF
M->LAR_G=0
M->AL_TU=LEN(ME_NU)
DECLARE MEN_U[M->AL_TU] , MAR_C[M->AL_TU]
AFILL(MAR_C,.T.)
FOR M->X_X=1 TO M->AL_TU
   MEN_U[M->X_X]=" "+TRIM(ME_NU[M->X_X])+" "
   IF LEN(MEN_U[M->X_X]) > M->LAR_G
      M->LAR_G=LEN(MEN_U[M->X_X])
      IF SUBS(MEN_U[M->X_X],2,1)=">"
         M->LAR_G=M->LAR_G+1
      ENDIF
   ENDIF
NEXT
IF M->LAR_G < 18
   M->LAR_G=18
ENDIF
FOR M->X_X=1 TO M->AL_TU
   IF MEN_U[M->X_X]=" - "
      MAR_C[M->X_X]=.F.
      MEN_U[M->X_X]=REPL("˘",M->LAR_G)
   ENDIF                   
   IF SUBS(MEN_U[M->X_X],2,1)=">"
      MEN_U[M->X_X]=" "+SUBS(MEN_U[M->X_X],3)+SPACE((M->LAR_G-LEN(ALLTRIM(MEN_U[M->X_X])))-3)+CHR(16)+" "
   ENDIF
NEXT                                                                                            
M->AL_TU=M->AL_TU+2
IF M->AL_TU>15
   M->AL_TU=15
ENDIF
M->ULT_OPC=M->AL_TU
IF M->M_POS + M->LAR_G + 3 > 79
   IF M->N_TELA=0
      M->M_POS = M->M_POS - ((M->LAR_G+2) - LEN(MENU_PRI[M->MENU_P]))
   ELSE
      M->M_POS = M->M_POS - ((M->M_POS+M->LAR_G+3)-79)
   ENDIF
ENDIF
M->X_X=M->M_POS+M->LAR_G+2
SOMBRA(M->LIN_INIC,M->M_POS,M->AL_TU+M->LIN_INIC-1,M->M_POS+M->LAR_G+3)
COR("MENU")
@ M->LIN_INIC,M->M_POS CLEAR TO M->AL_TU+M->LIN_INIC-1,M->M_POS+M->LAR_G+3
@ M->LIN_INIC,M->M_POS+1 TO M->AL_TU+M->LIN_INIC-1,M->M_POS+M->LAR_G+2 DOUBLE
IF M->AL_TU<15
   FOR M->X_X=1 TO M->AL_TU-2
      IF SUBS(MEN_U[M->X_X],1,1)="ƒ"
         @ M->X_X+M->LIN_INIC,M->M_POS+1 SAY "«"     
         @ M->X_X+M->LIN_INIC,M->M_POS+M->LAR_G+2 SAY "∂"
      ENDIF
   NEXT
ENDIF
IF LEN(MEN_U) > M->AL_TU-2
   @ M->LIN_INIC+1,M->M_POS+M->LAR_G+3 SAY CHR(24)
   @ M->LIN_INIC+M->AL_TU-2,M->M_POS+M->LAR_G+3 SAY CHR(25)
ENDIF
M->OPC_ACHO=0
M->MENU_OPC=ACHOICE(M->LIN_INIC+1,M->M_POS+2,M->LIN_INIC+M->AL_TU-2,M->M_POS+M->LAR_G+1,MEN_U,MAR_C,"FUN_ACHO")
IF M->MENU_OPC=0
   M->MENU_OPC = M->OPC_ACHO
   IF N_TELA=0 .AND. BUFFER=CHR(13) .AND. M->MENU_OPC=0
      BUFFER="S"+CHR(13)
   ENDIF
ENDIF
IF MENU_OPC<>0
   IF .NOT.(N_TELA=0 .AND. SUBS(MEN_U[MENU_OPC],LEN(MEN_U[MENU_OPC])-1,1)=CHR(16))
      RESTSCREEN(LIN_MENU+1,00,23,79,TELA_PRI)
   ELSE
      SOMBRA(L_SOM,C_SOM,.T.)
      IF LEN(MEN_U) <= M->AL_TU
         COR("DESTAQUE DO MENU")
         @ LIN_MENU+MENU_OPC+2,COL() SAY MEN_U[MENU_OPC]
      ENDIF
   ENDIF
ELSE
   RESTSCREEN(LIN_MENU+1,00,23,79,TELA_PRI)
ENDIF
SET KEY  4 TO
SET KEY 19 TO
RETURN M->MENU_OPC

*** Final do bloco de substituiáÑo MENU.B
*** (Em uso)

FUNCTION MIROMENU( LIN_SUP, COL_ESQ, LIN_INF, COL_DIR, DADOS_MENU, DESTAQUE_MENU )
LOCAL CONTAR, ULT_CURSOR := SETCURSOR(), TECLA := 0, OP_CAO := 1,;
      OBJ_MENU := TBROWSENEW( LIN_SUP, COL_ESQ, LIN_INF, COL_DIR ),;
      ULT_OPCAO := 1, ULT_LINHA := LIN_SUP, POS_DESTAQUE, CONTADOR,;
      BO_TAO := 0, LIN := 0, COL := 0, DADO_CUR, LE_TRA
OBJ_MENU:ADDCOLUMN( TBCOLUMNNEW( , { || DADOS_MENU[ OP_CAO ] } ) )
OBJ_MENU:GOTOPBLOCK := { || OP_CAO := 1 }
OBJ_MENU:GOBOTTOMBLOCK := { || OP_CAO := LEN( DADOS_MENU ) }
OBJ_MENU:SKIPBLOCK := { | SALTO | SKIPMENU( SALTO, LEN( DADOS_MENU ), @OP_CAO ) }
CURSOR( DESLIGA )
WHILE .T.
   MOUSE( DESLIGA )
   IF ( POS_DESTAQUE := AT( "~", DESTAQUE_MENU[ ULT_OPCAO ] ) ) != 0
      @ ULT_LINHA, COL_ESQ + POS_DESTAQUE SAY SUBS( DESTAQUE_MENU[ ULT_OPCAO ],;
                   POS_DESTAQUE + 1, 1 ) COLOR CONTECOR[ 7 ]
   ENDIF
   WHILE ( !OBJ_MENU:STABILIZE() )
      IF ( POS_DESTAQUE := AT( "~", DESTAQUE_MENU[ OP_CAO ] ) ) != 0
            @ ROW(), COL_ESQ + POS_DESTAQUE SAY SUBS( DESTAQUE_MENU[ OP_CAO ],;
                               POS_DESTAQUE + 1, 1 ) COLOR CONTECOR[ 7 ]
      ENDIF
    ENDDO
   MOUSE( LIGA )
   IF SUBS( DADOS_MENU[ OP_CAO ], 1, 1 ) = "ƒ"
      IF TECLA = T_CIMA .OR. TECLA = T_HOME .OR. TECLA = T_PGUP
         IF OP_CAO = 1
            OBJ_MENU:GOBOTTOM()
         ELSE
            OBJ_MENU:UP()
         ENDIF
      ELSE
         IF OP_CAO = LEN( DADOS_MENU )
            OBJ_MENU:GOTOP()
         ELSE
            OBJ_MENU:DOWN()
         ENDIF
      ENDIF
      LOOP
   ENDIF
   ULT_LINHA := LIN_SUP + OBJ_MENU:ROWPOS - 1
   ULT_OPCAO := OP_CAO
   IF OBJ_MENU:STABLE
      WHILE( TECLA := INKEY() ) == 0
         IF TECLA = 0
            MOUSE( @BO_TAO, @LIN, @COL )
         ENDIF
         IF BO_TAO = M_ESQUERDO .OR. BO_TAO = M_OS_DOIS
            DADO_CUR := SUBS( SAVESCREEN( LIN, COL, LIN, COL ), 1, 1 )
            IF DADO_CUR = CHR( 254 ) .OR. BO_TAO = M_OS_DOIS
               TECLA := T_ESC
            ELSEIF LIN = 24 .AND. ( COL >= 71 .AND. COL <= 78 )
               TECLA := T_F1
            ELSEIF ( LIN = LIN_SUP - 1 .AND. ( COL >= COL_ESQ .AND.;
                     COL <= COL_DIR ) ) .OR. DADO_CUR = CHR( 24 )
               TECLA := T_CIMA
            ELSEIF ( LIN = LIN_INF + 1 .AND. ( COL >= COL_ESQ .AND.;
                     COL <= COL_DIR ) ) .OR. DADO_CUR = CHR( 25 )
               TECLA := T_BAIXO
            ELSEIF ( COL >= COL_ESQ .AND. COL <= COL_DIR ) .AND.;
                   ( LIN >= LIN_SUP .AND. LIN <= LIN_INF )
               OBJ_MENU:ROWPOS := ( LIN - LIN_SUP ) + 1
               OBJ_MENU:REFRESHALL()
               MOUSE( DESLIGA )
               WHILE ( !OBJ_MENU:STABILIZE() )
                  IF ( POS_DESTAQUE := AT( "~", DESTAQUE_MENU[ OP_CAO ] ) ) != 0
                     @ ROW(), COL_ESQ + POS_DESTAQUE SAY SUBS(;
                              DESTAQUE_MENU[ OP_CAO ], POS_DESTAQUE + 1, 1 );
                              COLOR CONTECOR[ 7 ]
                  ENDIF
               ENDDO
               MOUSE( LIGA )
               TECLA := T_ENTER
            ELSEIF LIN = LIN_MENU
               FOR CONTAR = 1 TO LEN( MENU_PRI )
                  IF COL >= MENU_POS[ CONTAR ] + 1 .AND.;
                     COL <= LEN( MENU_PRI[ CONTAR ] ) + MENU_POS[ CONTAR ]
                     MENU_P := CONTAR
                     OP_CAO := -1
                     EXIT
                  ENDIF
               NEXT
            ELSE
               BEEP_MOUSE()
               LOOP
            ENDIF
            EXIT
         ELSEIF BO_TAO = M_DIREITO
            TECLA := T_ENTER
            EXIT
         ENDIF
      ENDDO
      IF OP_CAO = -1
         EXIT
      ENDIF
   ENDIF
   FOR CONTADOR := 1 TO LEN( DESTAQUE_MENU )
      IF ( POS_DESTAQUE := AT( "~", DESTAQUE_MENU[ CONTADOR ] ) ) != 0
         LE_TRA := SUBS( DESTAQUE_MENU[ CONTADOR ], POS_DESTAQUE + 1, 1 )
         IF UPPER( LE_TRA ) = UPPER( CHR( TECLA ) )
            ULT_OPCAO := CONTADOR
            CONTADOR = ( CONTADOR - OP_CAO )
            IF CONTADOR < 0
               CONTADOR *= ( -1 )
               TECLA = T_CIMA
            ELSE
               TECLA = T_BAIXO
            ENDIF
            FOR CONTAR := 1 TO CONTADOR
               IF TECLA = T_CIMA
                  OBJ_MENU:UP()
               ELSE
                  OBJ_MENU:DOWN()
               ENDIF
            NEXT
            MOUSE( DESLIGA )
            OBJ_MENU:REFRESHALL()
            WHILE ( !OBJ_MENU:STABILIZE() )
               IF ( POS_DESTAQUE := AT( "~", DESTAQUE_MENU[ OP_CAO ] ) ) != 0
                  @ ROW(), COL_ESQ + POS_DESTAQUE SAY SUBS(;
                           DESTAQUE_MENU[ OP_CAO ], POS_DESTAQUE + 1, 1 );
                           COLOR CONTECOR[ 7 ]
               ENDIF
               IF OP_CAO = ULT_OPCAO
                  OBJ_MENU:ROWPOS := ( ROW() - LIN_SUP ) + 1
               ENDIF
            ENDDO
            MOUSE( LIGA )
            TECLA := T_ENTER
            EXIT
         ENDIF
      ENDIF
   NEXT
   IF TECLA = T_ESC
      OP_CAO := 0
      EXIT
   ELSEIF TECLA = T_ENTER
      EXIT
   ELSEIF TECLA == T_F1
      HELP( "MENU" )
   ELSEIF TECLA = T_DIREITA
      BUFFER := CHR( T_DIREITA ) + CHR( T_ENTER )
      OP_CAO := 0
      EXIT
   ELSEIF TECLA = T_ESQUERDA
      BUFFER := CHR( T_ESQUERDA ) + CHR( T_ENTER )
      OP_CAO := 0
      EXIT
   ELSEIF TECLA = T_CIMA
      IF OP_CAO = 1
         OBJ_MENU:GOBOTTOM()
      ELSE
         OBJ_MENU:UP()
      ENDIF
   ELSEIF TECLA = T_BAIXO
      IF OP_CAO = LEN( DADOS_MENU )
         OBJ_MENU:GOTOP()
      ELSE
         OBJ_MENU:DOWN()
      ENDIF
   ELSEIF TECLA = T_HOME
      OBJ_MENU:GOTOP()
   ELSEIF TECLA = T_END
      OBJ_MENU:GOBOTTOM()
   ELSEIF TECLA = T_PGUP
      OBJ_MENU:PAGEUP()
   ELSEIF TECLA = T_PGDN
      OBJ_MENU:PAGEDOWN()
   ENDIF
ENDDO
SETCURSOR( ULT_CURSOR )
RETURN OP_CAO

FUNCTION SKIPMENU( SALTO, ULT_OPCAO, OP_CAO )
LOCAL TOT_SALTO := 0
IF SALTO + OP_CAO < 1
   TOT_SALTO := ( OP_CAO - 1 ) * ( -1 )
   OP_CAO := 1
ELSEIF SALTO + OP_CAO > ULT_OPCAO
   TOT_SALTO := ULT_OPCAO - OP_CAO
   OP_CAO := ULT_OPCAO
ELSE
   TOT_SALTO := SALTO
   OP_CAO += SALTO
ENDIF
RETURN TOT_SALTO

FUNCTION SOMBRA( LIN_SUP, COL_SUP, LIN_INF, COL_INF )
MOUSE( DESLIGA )
IF PCOUNT() = 2 .OR. PCOUNT() = 3
   C_SOM := COL_SUP; L_SOM := LIN_SUP
   LIN_SUP := VAL( SUBS( C_SOM, 1, 2 ) )
   COL_SUP := VAL( SUBS( C_SOM, 3, 2 ) )
   LIN_INF := VAL( SUBS( C_SOM, 5, 2 ) )
   COL_INF := VAL( SUBS( C_SOM, 7, 2 ) )
   COL_SOM := SUBS( C_SOM, 9 )
   LIN_SOM := L_SOM
ENDIF
IF COL_SUP < 2 .OR. LIN_INF > 22
   C_SOM := ""; L_SOM := ""
   MOUSE( LIGA )
   RETURN .F.
ENDIF
IF PCOUNT() = 3
   RESTSCREEN( LIN_SUP + 1, COL_SUP - 2, LIN_INF + 1, COL_SUP - 1, COL_SOM )
   RESTSCREEN( LIN_INF + 1, COL_SUP - 2, LIN_INF + 2, COL_INF - 2, LIN_SOM )
   MOUSE( LIGA )
   RETURN .F.
ENDIF
IF PCOUNT() != 2
   COL_SOM := SAVESCREEN( LIN_SUP + 1, COL_SUP - 2, LIN_INF + 1, COL_SUP - 1 )
   LIN_SOM := SAVESCREEN( LIN_INF + 1, COL_SUP - 2, LIN_INF + 2, COL_INF - 2 )
ENDIF
IF SUBS( COL_SOM, 2, 1 ) != CHR( 8 )
   C_SOM := STR( LIN_SUP, 2 ) + STR( COL_SUP, 2 ) + STR( LIN_INF, 2 ) +;
            STR( COL_INF, 2 ) + COL_SOM
   L_SOM := LIN_SOM
ENDIF
FOR I = 2 TO LEN( COL_SOM ) STEP 2
   COL_SOM := STUFF( COL_SOM, I, 1, CHR( 8 ) )
NEXT
FOR I = 2 TO LEN( LIN_SOM ) / 2 STEP 2
   LIN_SOM := STUFF( LIN_SOM, I, 1, CHR( 8 ) )
NEXT
RESTSCREEN( LIN_SUP + 1, COL_SUP - 2, LIN_INF + 1, COL_SUP - 1, COL_SOM )
RESTSCREEN( LIN_INF + 1, COL_SUP - 2, LIN_INF + 2, COL_INF - 2, LIN_SOM )
MOUSE( LIGA )
RETURN .T.
 
FUNCTION CONFCOR
menu:TIPO_MENU := SUB_MENU
menu:ADD( "~Papel de parede" )
menu:ADD( "~Menu" )
menu:ADD( "~Destaque do menu" )
menu:ADD( "~Janela de dialogo" )
menu:ADD( "~Box da janela de dialogo" )
menu:ADD( "B~otoes" )
menu:ADD( "Bo~tao em destaque" )
menu:ADD( "~Get's" )
menu:ADD( "G~et em destaque" )
menu:ADD( "Te~la de apresentacao" )
menu:ADD( "~Caracteres avulsos" )
menu:ADD( "Ce~rcaduras" )
menu:ADD( "T~itulo" )
ME_NU := menu:CONTEUDO()
OPC_COR := menu:RODA()
IF OPC_COR = 0
   RETURN.T.
ENDIF
SETCOLOR( "W" )
MOUSE( DESLIGA )
RESTSCREEN( LIN_MENU + 1, 00, 23, 79, TELA_PRI )
MOUSE( LIGA )
COR( "MENU" )
@ LIN_MENU, 00
@ LIN_MENU, 01 SAY "ConfiguraáÑo de cores ≥ "+ME_NU[ _OPCOES_MENU ][ OPC_COR ]
COR( "FUNDO DA TELA" )
IF FUNDO = 10
   FUN_DO := "∞∞∞∞"
ELSE
   FUN_DO := "¿ø¿ø"
ENDIF
MENSAGEM( "Utilize as setas para configurar as cores" )
IF OPC_COR != 10
   SOMBRA( 03, 20, 21, 79 )
   FOR F = 1 + LIN_MENU TO 17
      @ F + 3, 20 SAY REPL( SUBS( FUN_DO, 1, 2 ), 30 )
      FUN_DO := SUBS( FUN_DO, 3 ) + SUBS( FUN_DO, 1, 2 )
   NEXT
   FUN_DO := SUBS( FUN_DO, 3 ) + SUBS( FUN_DO, 1, 2 )
   COR( "TITULO" )
   @ 03, 20 SAY "                    Titulo do aplicativo                    "
   COR( "MENU" )
   @ LIN_MENU + 3, 20 SAY "   Cadastros  Manutenáîes  Relat¢rios  Utilit†rios  Sair    "
   @ 21, 20 SAY SPACE( 60 )
   @ 21, 21 SAY DTOC( M->DAT_HOJE ) + " ≥"
   @ 21, 38 SAY "Escolha a opáÑo desejada"
   @ 21, 69 SAY "≥ F1-Ajuda"
ENDIF
IF OPC_COR = 3
   @ LIN_MENU + 4,22 SAY " ⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø "
   @ LIN_MENU + 5,22 SAY " ≥ OpáÑo um            ≥ "
   @ LIN_MENU + 6,22 SAY " √ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥ "
   @ LIN_MENU + 7,22 SAY " ≥ OpáÑo dois          ≥ "
   @ LIN_MENU + 8,22 SAY " ≥ OpáÑo tres          ≥ "
   @ LIN_MENU + 9,22 SAY " ¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ "
ENDIF
IF OPC_COR = 4 .OR. OPC_COR = 5 .OR. OPC_COR = 6 .OR. OPC_COR = 7
   JANELA( 08, 28, 16, 71 )
   @ 11, 38 SAY "Confirma o encerramento ?"
   botao:ADD( 13, 36, "Sim     " )
   botao:ADD( 13, 53, "NÑo     " )
   botao:MOSTRA()
   COR( "BOTAO EM DESTAQUE" )
   @ 13, 37 SAY "Sim"
ENDIF
IF OPC_COR = 8 .OR. OPC_COR = 9 .OR. OPC_COR = 11 .OR. OPC_COR = 12
   JANELA( 06, 23, 18, 76, "Cadastro de clientes" )
   COR( "CERCADURAS" )
   @ 11, 27 TO 11, 48
   @ 11, 52 TO 11, 72
   @ 15, 27 TO 15, 48
   @ 15, 52 TO 15, 63
   @ 15, 66 TO 15, 72
   COR( "CARACTERES AVULSOS" )
   @ 10, 27 SAY "Nome"
   @ 10, 52 SAY "Empresa"
   @ 14, 27 SAY "Endereáo"
   @ 14, 52 SAY "Bairro"
   @ 14, 66 SAY "Cep"
   COR( "GET EM DESTAQUE" )
   @ 12, 27 SAY "TESTE" + SPACE( 17 )
   SETCOLOR( CONTECOR[ 8 ] )
   @ 12, 52 SAY "TESTE" + SPACE( 16 )
   @ 16, 27 SAY "TESTE" + SPACE( 17 )
   @ 16, 52 SAY "TESTE" + SPACE( 7 )
   @ 16, 66 SAY "9999999"
ENDIF
X_COR := 07; Y_COR := 0
CURSOR( DESLIGA )
SETCOLOR( "BG/RB" )
@ X_COR, Y_COR, X_COR + 9, Y_COR + 17 BOX "€"
FOR F_COR = 0 TO 7
   FOR C_COR = 0 TO 15
      SETCOLOR( ALLTRIM( STR( C_COR, 2 ) ) + "/" + ALLTRIM( STR( F_COR, 2 ) ) )
      @ F_COR + X_COR + 1, C_COR + Y_COR + 1 SAY "˛"
   NEXT
NEXT
C_COR := VAL( SUBS( CONTECOR[ OPC_COR ], 1, 2 ) )
F_COR := VAL( SUBS( CONTECOR[ OPC_COR ], 4 ) )
OK := .T.
WHILE .T.
   SETCOLOR( "N/BG" )
   @ X_COR, Y_COR, X_COR + 9, Y_COR + 17 BOX " "
   @ F_COR + X_COR + 1, Y_COR + 17 SAY CHR( 17 )
   @ X_COR, Y_COR + C_COR + 1 SAY CHR( 31 )
   SETCOLOR( ALLTRIM( STR( C_COR, 3 ) ) + "/" + ALLTRIM( STR( F_COR, 3 ) ) )
   CONTECOR[ OPC_COR ] := STRZERO( C_COR, 2 ) + "/" + STRZERO( F_COR, 2 )
   IF OPC_COR = 1
      FOR F= 1 + LIN_MENU TO 17
         @ F + 3, 20 SAY REPL( SUBS( FUN_DO, 1, 2 ), 30 )
         FUN_DO := SUBS( FUN_DO, 3 ) + SUBS( FUN_DO, 1, 2 )
      NEXT
      FUN_DO := SUBS( FUN_DO, 3 ) + SUBS( FUN_DO, 1, 2 )
   ELSEIF OPC_COR = 2
      @ LIN_MENU + 3, 20 SAY "   Cadastros  Manutenáîes  Relat¢rios  Utilit†rios  Sair    "
      @ 21, 20 SAY SPACE( 60 )
      @ 21, 21 SAY DTOC( M->DAT_HOJE ) + " ≥"
      @ 21, 38 SAY "Escolha a opáÑo desejada"
      @ 21, 69 SAY "≥ F1-Ajuda"
      IF OPC_COR = 2
         @ LIN_MENU + 4,22 SAY " ⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø "
         @ LIN_MENU + 5,22 SAY " ≥ OpáÑo um            ≥ "
         @ LIN_MENU + 6,22 SAY " √ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥ "
         @ LIN_MENU + 7,22 SAY " ≥ OpáÑo dois          ≥ "
         @ LIN_MENU + 8,22 SAY " ≥ OpáÑo tres          ≥ "
         @ LIN_MENU + 9,22 SAY " ¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ "
         COR( "DESTAQUE DO MENU" )
         @ LIN_MENU + 3, 22 SAY " Cadastros "
         @ LIN_MENU + 5, 24 SAY " OpáÑo um            "
      ENDIF
   ELSEIF OPC_COR = 3
      @ LIN_MENU + 3, 22 SAY " Cadastros "
      @ LIN_MENU + 5, 24 SAY " OpáÑo um            "
   ELSEIF OPC_COR = 5
      @ 08, 28, 16, 71 BOX " "
      @ 08, 28 SAY "˛"
   ELSEIF OPC_COR = 4
      @ 09, 29 CLEAR TO 15, 70
      @ 11, 38 SAY "Confirma o encerramento ?"
      botao:ADD( 13, 36, "Sim     " )
      botao:ADD( 13, 53, "NÑo     " )
      botao:MOSTRA()
      COR( "BOTAO EM DESTAQUE" )
      @ 13, 37 SAY "Sim     "
   ELSEIF OPC_COR = 6
      botao:ADD( 13, 53, "NÑo     " )
      botao:MOSTRA()
   ELSEIF OPC_COR = 7
      botao:ADD( 13, 36, "Sim     " )
      botao:MOSTRA()
      COR( "BOTAO EM DESTAQUE" )
      @ 13, 36 SAY " Sim       "
   ELSEIF OPC_COR = 12
      @ 11, 27 TO 11, 48
      @ 11, 52 TO 11, 72
      @ 15, 27 TO 15, 48
      @ 15, 52 TO 15, 63
      @ 15, 66 TO 15, 72
   ELSEIF OPC_COR = 11
      @ 10, 27 SAY "Nome"
      @ 10, 52 SAY "Empresa"
      @ 14, 27 SAY "Endereáo"
      @ 14, 52 SAY "Bairro"
      @ 14, 66 SAY "Cep"
   ELSEIF OPC_COR = 9
      @ 12, 27 SAY "TESTE" + SPACE( 17 )
   ELSEIF OPC_COR = 8
      @ 12, 52 SAY "TESTE" + SPACE( 16 )
      @ 16, 27 SAY "TESTE" + SPACE( 17 )
      @ 16, 52 SAY "TESTE" + SPACE( 7 )
      @ 16, 66 SAY "9999999"
   ELSEIF OPC_COR = 10
      COR( "TELA DE APRESENTACAO" )
      @ 03, 20 SAY "∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞"
      @ 04, 20 SAY "∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞"
      @ 05, 20 SAY "∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞"
      @ 06, 20 SAY "∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞"
      @ 07, 20 SAY "∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞"
      @ 08, 20 SAY "∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞"
      @ 09, 20 SAY "∞∞∞∞∞∞∞∞∞∞∞€€€€€€€∞€€€€€€€∞€€€€€€€∞€€€€€€€∞€€€€€€€∞∞∞∞∞∞∞∞∞∞"
      @ 10, 20 SAY "∞∞∞∞∞∞∞∞∞     € ∞  €    ∞  €    ∞€    € ∞  €    ∞∞∞∞∞∞∞∞∞∞∞∞"
      @ 11, 20 SAY "∞∞∞∞∞∞∞∞∞∞∞∞ ∞€∞∞ ∞€∞∞∞∞∞ ∞€∞∞∞ ∞∞∞∞ ∞€∞∞ ∞€∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞"
      @ 12, 20 SAY "∞∞∞∞∞∞∞∞∞∞∞∞ ∞€€∞ ∞€€€€€€€∞€€€€€€€∞∞ ∞€€∞ ∞€€€€€€€∞∞∞∞∞∞∞∞∞∞"
      @ 13, 20 SAY "∞∞∞∞∞∞∞∞∞∞∞∞  €€∞  €€∞∞∞∞       €€∞∞  €€∞  €€   ∞∞∞∞∞∞∞∞∞∞∞∞"
      @ 14, 20 SAY "∞∞∞∞∞∞∞∞∞∞∞∞  €€∞  €€∞∞∞∞∞∞€∞∞  €€∞∞  €€∞  €€∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞"
      @ 15, 20 SAY "∞∞∞∞∞∞∞∞∞∞∞∞  €€∞  €€€€€€€ €€€€€€€∞∞  €€∞  €€€€€€€∞∞∞∞∞∞∞∞∞∞"
      @ 16, 20 SAY "∞∞∞∞∞∞∞∞∞∞∞∞  ∞∞∞       ∞       ∞∞∞∞  ∞∞∞       ∞∞∞∞∞∞∞∞∞∞∞∞"
      @ 17, 20 SAY "∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞"
      @ 18, 20 SAY "∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞"
      @ 19, 20 SAY "∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞"
      @ 20, 20 SAY "∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞"
      @ 21, 20 SAY "∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞"
      IF OK
         OK := .F.
         SOMBRA( 03, 20, 21, 79 )
      ENDIF
   ELSEIF OPC_COR = 13
      @ 03, 20 SAY "                    Titulo do aplicativo                    "
   ENDIF
   TECLA := INKEY( 0 )
   SETCOLOR( "W/BG" )
   @ X_COR + F_COR + 1, Y_COR + 17 SAY " "
   @ X_COR, C_COR + Y_COR + 1 SAY " "
   F_COR += IIF( TECLA = T_CIMA, -1, IIF( TECLA = T_BAIXO, 1, 0 ) )
   C_COR += IIF( TECLA = T_ESQUERDA, -1, IIF( TECLA = T_DIREITA, 1, 0 ) )
   F_COR = IIF( F_COR < 0, 7, IIF( F_COR > 7, 0, F_COR ) )
   C_COR = IIF( C_COR < 0, 15, IIF( C_COR > 15, 0, C_COR ) )
   IF TECLA = T_ESC .OR. TECLA = T_ENTER
      EXIT
   ENDIF
ENDDO
CONTECOR[ OPC_COR ] := STRZERO( C_COR, 2 ) + "/" + STRZERO( F_COR, 2 )
COR( "TITULO" )
@ 00, 00
@ 00, ( 80 - LEN( TITU_LO ) ) / 2 SAY TITU_LO
FUNDO()
COR( "MENU" )
@ LIN_MENU, 00
FOR F_MENU = 1 TO LEN( MENU_PRI )
   @ LIN_MENU, MENU_POS[ F_MENU ] + 1 SAY MENU_PRI[ F_MENU ]
NEXT
@ 24, 00
@ 24, 01 SAY M->DAT_HOJE
@ 24, 10 SAY "≥"
@ 24, 69 SAY "≥"
@ 24, 71 SAY "F1-Ajuda"
MOUSE( DESLIGA )
TELA_PRI := SAVESCREEN( LIN_MENU + 1, 00, 23, 79 )
MOUSE( LIGA )
BUFFER := CHR( T_ENTER ) + "C"
RETURN .T.

*** (Em uso)
*** Inicio do bloco de substituiáÑo FUNDO.B
FUNCTION FUNDO
*
* -> Monta papel de parede
PARA PAR1
IF PCOUNT()=0
   PAR1=0
ENDIF
DECLARE ME_NU[14]
ME_NU[1]="//\\//\\//\\//\\//  M.M.S.tec \\//\\//\\//\\//\\//"
ME_NU[2]="≤≤≤≤≤≤≤≤≤≤€€€€€€€€€∞∞∞∞∞∞∞∞∞∞±±±±±±±±±±"
ME_NU[3]="∞"
ME_NU[4]="€"
ME_NU[5]="ﬁ"
*ME_NU[6]="ﬂ"
ME_NU[6]="‹"
ME_NU[7]="Ë"
ME_NU[8]="Ì"
ME_NU[9]=" "
ME_NU[10]="¿ø¿ø"
ME_NU[11]=" ÀÀ "
ME_NU[12]="¡¬¬¡"
ME_NU[13]="√¥¥√"
ME_NU[14]="πÃÃπ"
IF PAR1=1
   S_MENU=MENU(1)
   IF S_MENU=0
      RETURN .F.
   ENDIF
   FUNDO=S_MENU
ENDIF
COR("FUNDO DA TELA")
IF FUNDO=1
   FUN_DO="\\//\\//\\//\\//\\// M.M.S.tec /\\//\\//\\//\\//\\//"
ELSE
   FUN_DO=ME_NU[FUNDO]
ENDIF
IF FUNDO<10
   FUN_DO=SUBS(FUN_DO+REPL(FUN_DO,1840/LEN(FUN_DO)),1,1840)
ENDIF
FOR F=LIN_MENU+1 TO 23
   IF FUNDO<10
      @ F,00 SAY SUBS(FUN_DO,F*80-79,80)
   ELSE
      @ F,00 SAY REPL(SUBS(FUN_DO,1,2),40)
      FUN_DO=SUBS(FUN_DO,3)+SUBS(FUN_DO,1,2)
   ENDIF
NEXT
IF PAR1=1
   TELA_PRI=SAVESCREEN(LIN_MENU+1,00,23,79)
ENDIF
RETURN .T.

*** Final do bloco de substituiáÑo FUNDO.B
*** (Em uso)

FUNCTION COR( NOM_COR )
QUAL_COR := ASCAN( NOMECOR, UPPER( NOM_COR ) )
IF QUAL_COR != 0
   IF QUAL_COR = 2
      SETCOLOR( CONTECOR[ 2 ] + "," + CONTECOR[ 3 ] + ",,," + CONTECOR[ 2 ] )
   ELSEIF QUAL_COR = 8
      SETCOLOR( CONTECOR[ 11 ] + "," + CONTECOR[ 9 ] + ",,," + CONTECOR[ 8 ] )
   ELSE
      SETCOLOR( CONTECOR[ QUAL_COR ] )
   ENDIF
ENDIF
RETURN .T.

FUNCTION FUN_CFG( PAR1 )
IF LASTKEY() = T_ENTER
   RETURN 1
ELSEIF LASTKEY() = T_ESC
   RETURN 0
ELSEIF AT( UPPER( CHR( LASTKEY() ) ), "IFRSC" ) > 0 .OR.;
       LASTKEY() = T_TAB .OR. LASTKEY() = T_SH_TAB
   RETURN 0
ELSEIF PAR1 = 1
   KEYBOARD CHR( T_CTRL_PGDN )
ELSEIF PAR1 = 2
   KEYBOARD CHR( T_CTRL_PGUP )
ENDIF
CFG_COR := SETCOLOR()
COR( "MENU" )
FOR F_CFG = 1 TO LEN( MENU_CFG )
   @ 09 + F_CFG, 34 SAY " "
NEXT
SETCOLOR( CFG_COR )
RETURN 2
 
*** (Em uso)
*** Inicio do bloco de substituiáÑo MENU_PRN.B
FUNCTION MENU_PRN
*
* -> Menu de direcionamento de impressao
PARA ARQ_PRN
FUNDO()
JANELA(06,21,18,59,"Direcionamento de impressÑo")
COR("MENU")
@ 09,26 CLEAR TO 13,54
DO WHILE .T.
   BOTAO(15,35,"Enter")
   DECLARE MENU_CFG[3]
   MENU_CFG[1]="     ("+CHR(7)+") Impressora"
   MENU_CFG[2]="     ("+CHR(7)+") Monitor   "
   MENU_CFG[3]="     ("+CHR(7)+") HARD DISK "
   MENSAGEM("Escolha um dos direcionamentos...")
   SETCOLOR(CONTECOR[2]+","+CONTECOR[7])
   KEYBOARD CHR(32)
   M->OPC_PRN=ACHOICE(10,28,12,52,MENU_CFG,.T.,"FUN_CFG")
   IF M->OPC_PRN<>0
      BOTAO(15,35,"Enter",-2)
   ENDIF
   IF M->OPC_PRN=0
      RETURN .F.
   ELSEIF M->OPC_PRN = 1
      M->TIPO_PRN = "I"
      IF .NOT. ISPRINTER()
         BEEP()
         MENSAGEM("Impressora desligada ou desconectada",3)
         MENSAGEM("Tecle <ESC> para sair")
         LOOP
      ENDIF
   ELSEIF M->OPC_PRN = 2
      M->TIPO_PRN = "T"
      M->EX_T=(VAL(SUBS(TIME(),4,2))*10)+VAL(SUBS(TIME(),7,2))
      ARQ_PRN=ARQ_PRN+"."+SUBS(STR(M->EX_T+1000,4),2)
      SET PRINTER TO &ARQ_PRN
   ELSEIF M->OPC_PRN = 3
      RESTSCREEN(LIN_MENU+1,00,23,79,TELA_PRI)
      JANELA(07,16,17,62,"Direcionamento de impressÑo")
      COR("MENU")
      @ 10,20 CLEAR TO 14,58
      @ 11,23 SAY "Digite o nome do arquivo de saida"
      ARQ_PRN=SPACE(8)
      DO WHILE .T.
         @ 13,35 GET ARQ_PRN PICT "@!" VALID ISALPHA(ARQ_PRN)
         SET CURSOR ON
         READ
         SET CURSOR OFF
         IF LASTKEY()=27
            RETURN .F.
         ENDIF
         IF AT(".",ARQ_PRN)<>0
            BEEP()
            MENSAGEM("Digite o nome do arquivo sem extensÑo",3)
            MENSAGEM("Tecle <ESC> para sair")
            LOOP
         ENDIF
         EXIT
      ENDDO
      ARQ_PRN=ARQ_PRN+".PRN"
      M->TIPO_PRN = "A"
      SET PRINTER TO &ARQ_PRN
   ENDIF
   MENSAGEM("Tecle <ESC> para pausa ou interrupáÑo")
   RETURN .T.
ENDDO

*** Final do bloco de substituiáÑo MENU_PRN.B
*** (Em uso)
 
*** (Em uso)
*** Inicio do bloco de substituiáÑo IMP_TELA.B
* -> FUNCAO QUE IMPRIME NA TELA
*
FUNCTION IMP_TELA
*
* Local: c:\miro\IMP_TELA.B
*
PARA ARQ_PRN,TAM_LIN,MARG_ESQ
IF PCOUNT()=2
   M->MARG_ESQ=0
ENDIF
M->MARG_ESQ=M->MARG_ESQ+1
MENSAGEM("Aguarde processamento")
SELE 100
PUBL QUAN_REG,ULT_POS
M->ARQ_PRN1=M->ARQ_PRN+"."+SUBS(STR(M->EX_T+1000,4),2)
M->ARQ_PRN2=M->ARQ_PRN+"."+SUBS(STR(M->EX_T+1100,4),2)
CREATE ARQ_STRU
IF .NOT. USEREDE("ARQ_STRU",.T.,10)
   @ 0,0 SAY ""
   ? CHR(7)
   MENSAGEM("Nao foi possivel criar arquivo, tente novamente",5)
   RETURN .F.
ENDIF
IF .NOT. ADIREG(0)
   @ 0,0 SAY ""
   ? CHR(7)
   MENSAGEM("Nao foi possivel criar arquivo, tente novamente",5)
   USE
   RETURN .F.
ENDIF
REPLACE FIELD_NAME WITH "LI_NHA",FIELD_TYPE WITH "C"
REPLACE FIELD_LEN  WITH M->TAM_LIN+1,FIELD_DEC WITH 0
CREATE &ARQ_PRN2 FROM ARQ_STRU
USE
ERASE ARQ_STRU.DBF
IF .NOT. USEREDE(ARQ_PRN2,.T.,10)
   @ 0,0 SAY ""
   ? CHR(7)
   MENSAGEM("Nao foi possivel acesso, tente novamente",5)
   RETURN .F.
ENDIF
APPEND FROM &ARQ_PRN1 SDF
M->QUAN_REG=LASTREC()
IF M->QUAN_REG=0
   M->QUAN_REG=1
ENDIF
GOTO TOP
JANELA(LIN_MENU+3,02,21,77)
@ LIN_MENU+4,77 SAY CHR(30)  COLOR("R+/"+ALLTRIM(SUBS(CONTECOR[5],4)))
@ 20,77 SAY CHR(31)          COLOR("R+/"+ALLTRIM(SUBS(CONTECOR[4],4)))
IF M->TAM_LIN<72
   DECLARE EDI_TAR[1]
   EDI_TAR[1]="SUBS(LI_NHA,M->MARG_ESQ)"
ELSE
   IF INT(M->TAM_LIN/36)=M->TAM_LIN/36
      M->NUM_COL=M->TAM_LIN/36
   ELSE
      M->NUM_COL=INT(M->TAM_LIN/36)+1
   ENDIF
   DECLARE EDI_TAR[M->NUM_COL]
   M->X=1
   DO WHILE M->X<M->NUM_COL
      M->NUM_MAT=(M->X*36)-34
      EDI_TAR[M->X]="SUBS(LI_NHA,"+STR(M->NUM_MAT,3)+",36)"
      M->X=M->X+1
   ENDDO
   M->NUM_MAT=(M->X*36)-34
   EDI_TAR[M->X]="SUBS(LI_NHA,"+STR(M->NUM_MAT,3)+")+SPACE("+STR((M->NUM_COL*36)-M->TAM_LIN,2)+")"
ENDIF
KEYBOARD CHR(65)
M->ULT_POS=LIN_MENU+5
MENSAGEM("Tecle <ESC> para sair")
M->SOS_MENU="RELATORIO"
SETCOLOR(CONTECOR[4]+","+CONTECOR[7])
SETCOLOR ("R+*/N")
@ 05,03 clear to 20,76
**                         
Tec1="€ﬂﬂ€ﬂﬂ€ €ﬂﬂ€ﬂﬂ€ €ﬂﬂﬂﬂﬂ€   ‹  Inform†tica Ltda"
Tec2="€  €  € €  €  € €‹‹‹‹‹‹‹ ﬂ€ﬂ €ﬂﬂﬂﬂﬂ€ €ﬂﬂﬂﬂﬂﬂ€"
Tec3="€€ €  € €€ €  € ‹     €€  €€ €€ﬂﬂﬂﬂﬂ €€     ‹"
Tec4="€€ €  € €€ €  € ﬂﬂﬂﬂﬂﬂﬂﬂ  ﬂﬂ ﬂﬂﬂﬂﬂﬂﬂ ﬂﬂﬂﬂﬂﬂﬂﬂ"
Tec5="ﬂﬂ    ﬂﬂﬂﬂ    ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ"
**
SET CURSOR OFF
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
SET CURSOR ON
**
@ 06,05 say PADC("M.F.B. Material de ConstruáÑo Ltda.",69)      Color ("w+/N")
DTTA(07,00)
@ 08,04 say REPL("ƒ",72)             Color ("N+/N")
@ 19,04 say repl("ƒ",72)             Color ("N+/N")
@ 20,05 say CHR(9)+" Rec"            Color ("N+*/N")
@ 20,20 say CHR(17)+CHR(17)+" Right" Color ("N+/N")
@ 20,35 say CHR(16)+CHR(16)+" Low"   Color ("N+/N")
@ 20,50 say CHR(16)+" Play"          Color ("N+/N")
@ 20,65 say CHR(19)+" Pause"         Color ("N+/N")
@ 06,05 say "< Read >"               Color ("N+*/N")
@ 21,03 say repl("ﬂ",74)             COLOR("N/"+ALLTRIM(SUBS(CONTECOR[4],4)))
*
COR("TELA DE APRESENTACAO")
DBEDIT(LIN_MENU+8,04,18,75,EDI_TAR,"FUN_IMP","","","","")
M->SOS_MENU=" "
USE
ERASE &ARQ_PRN1
ERASE &ARQ_PRN2
RELEASE QUAN_REG,ULT_POS

*** Final do bloco de substituiáÑo IMP_TELA.B
*** (Em uso)

*** (Em uso)
*** Inicio do bloco de substituiáÑo FUN_IMP.B
FUNCTION FUN_IMP
IF LASTKEY()=27
   *
   * -> Finaliza ediáÑo
   RETURN 0
ELSEIF LASTKEY()=1
   *
   * Vai para o comeco do arquivo
   GOTO TOP
ELSEIF LASTKEY()=6
   *
   * -> Vai para o final do arquivo
   GOTO BOTT
ENDIF
COR("JANELA DE DIALOGO")
@ M->ULT_POS,77 SAY "€"      COLOR("N+/"+ALLTRIM(SUBS(CONTECOR[4],4)))
M->ULT_POS=LIN_MENU+5+(((RECN()*100)/M->QUAN_REG)/(100/(19-(LIN_MENU+5))))
IF RECN()=1
   M->ULT_POS=LIN_MENU+5
ENDIF
@ M->ULT_POS,77 SAY CHR(4)  COLOR("R+*/"+ALLTRIM(SUBS(CONTECOR[5],4)))
@ M->ULT_POS,76 SAY "˙"     COLOR("N+*/n")
SETCOLOR(CONTECOR[4]+","+CONTECOR[7])
RETURN 1

*** Final do bloco de substituiáÑo FUN_IMP.B
*** (Em uso)
 
/* Final do programa LIVROFU2.PRG */