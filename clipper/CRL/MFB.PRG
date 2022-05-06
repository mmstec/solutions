
* TITULO     : *** Barreto Constru‡„o ***
* DATA       : 17/04/97
* PROGRAMA   : MFB.PRG
* COMENTARIO : MENU PRINCIPAL
 
OpTela     = "S"
     CLS
     @ 01,00 SAY SPACE(80)
     @ 01,00 SAY 'Deseja alterar o modo de Video para " 43x80 " ? ( S )im ou ( N ) „o' get OPTELA pict "@!"
     READ
     IF OpTela = "S"
        TONE(290)
        SETMODE(43,80) 
        PUBLIC OpTela
        OpTela = "43X80"
     ENDIF
     CLS

IF FILE ("MENU.TXT")
     SETCOLOR("G/N")
     TEXTO=MEMOREAD("MENU.TXT")
     @ 06,10 CLEAR TO 20,70
     @ 06,10       TO 20,70
     @ 07,11 SAY PADC("ATENCAO OPERADOR...",58) COLOR ("RG+/N")
     MEMOEDIT(TEXTO,08,11,19,69,.F.)
ENDIF
**
** Bloco de inser‡„o MENU.B01
**
AMBIENTE()
*
* -> Modulo de criacao de arquivos
SET PROCEDURE TO MFBARQ
*
* -> Modulo de help
SET PROCEDURE TO MFBSOS
*
* -> Modulo de Funcoes
SET PROCEDURE TO MFBFUN
*
* -> Variavel de controle do papel de parede
FUNDO=1
*
* -> Controle de cores
DECLARE NOMECOR[13],CONTECOR[13]
NOMECOR[01]="FUNDO DA TELA"
NOMECOR[02]="MENU"
NOMECOR[03]="DESTAQUE DO MENU"
NOMECOR[04]="JANELA DE DIALOGO"
NOMECOR[05]="BOX DA JANELA DE DIALOGO"
NOMECOR[06]="BOTOES"
NOMECOR[07]="BOTAO EM DESTAQUE"
NOMECOR[08]="GETS"
NOMECOR[09]="GET EM DESTAQUE"
NOMECOR[10]="TELA DE APRESENTACAO"
NOMECOR[11]="CARACTERES AVULSOS"
NOMECOR[12]="CERCADURAS"
NOMECOR[13]="TITULO"
PADRAO()
*
* -> Ativa consulta em outro arquivo tecla F2
SET KEY -1 TO CGETS
M->TEC_F2=.F.
M->PRO_CURA=""
M->ULT_PSQ=" "
M->AL_TERA=.F.
*
* -> Ativa o calendario na tecla F3
SET KEY -2 TO CALEN
*
* -> Ativa a calculadora na tecla F4
SET KEY -3 TO CALCU
MOVCAL_X=5
MOVCAL_Y=0
*
* -> Ativa saida ao DOS na tecla F5
SET KEY -4 TO SHELLDOS
*
* -> Ativa configuracao na tecla F6
SET KEY -5 TO SET_CONF
CNF_REP=.F.
CNF_CON=.F.
CNF_DEL="  "
*
* -> Ativa caracteres acentuados nas teclas de funcoes
SET KEY -6 TO HELP_TEC
M->VAR_TEC="Ž„ …†ƒ€‡‚ˆ‰Š¡‹Œ“¢™”•£š–¦§"
FOR M->X=1 TO LEN(M->VAR_TEC)
     SET FUNCTION M->X+11 TO SUBS(M->VAR_TEC,M->X,1)
NEXT
M->DRI_VE = "A"
IF FILE("MFB.CFG")
     *
     * -> Restaurando configuracao
     VAR=MEMOREAD("MFB.CFG")
     *
     * -> Cores
     FOR F=1 TO 12
          CONTECOR[F]=SUBS(VAR,(F*5)-4,5)
     NEXT
     *
     * -> Posicao da Calculadora
     MOVCAL_X=VAL(SUBS(VAR,61,2))
     MOVCAL_Y=VAL(SUBS(VAR,63,2))
     *
     * -> Configuracao para Entrada de Dados (Tecla F6)
     CNF_REP=IIF(SUBS(VAR,65,1)="F",.F.,.T.)
     CNF_CON=IIF(SUBS(VAR,66,1)="F",.F.,.T.)
     CNF_DEL=SUBS(VAR,67,2)
     *
     * -> Fundo da tela
     FUNDO=VAL(SUBS(VAR,69,2))
     *
     * -> Unidade de saida do back-up
     M->DRI_VE=SUBS(VAR,71,1)
     *
     * -> Cor do titulo
     CONTECOR[13]=SUBS(VAR,72,5)
ENDIF
TITU_LO="*** Barreto Constru‡„o ***"
**
** Bloco de inser‡„o MENU.B08
**
LIN_MENU=1
COR("TITULO")
@ 00,00
@ 00,(80-LEN(TITU_LO))/2 SAY TITU_LO
COR("MENU")
@ LIN_MENU,00
@ 24,00
@ 24,01 SAY DATE()
@ 24,10 SAY "³"
@ 24,69 SAY "³"
@ 24,71 SAY "F1-Ajuda"
FUNDO()
PUBL MENU_POS
DECLARE BOTOES[10]
Q_BOTOES=1
MENU_P=1
X=1
M->SOS_MENU=" "
* -> Inicio do Bloco de substitui‡„o MENUPRI1.B
*
BUFFER=CHR(13)
DECLARE MENU_PRI[7],MENU_POS[7]
MENU_PRI[1]="Inclus”es"
MENU_PRI[2]="Consultas"
MENU_PRI[3]="Altera‡”es"
MENU_PRI[4]="Exclus”es"
MENU_PRI[5]="Extratos"
MENU_PRI[6]="Configura"
MENU_PRI[7]="Saida "+CHR(16)+CHR(16)
COL_MENU=2
*SETCOLOR("B+/"+ALLTRIM(SUBS(CONTECOR[13],4)))
COR("MENU")
FOR F_MENU=1 TO LEN(MENU_PRI)
     MENU_POS[F_MENU]=COL_MENU
     COL_MENU=COL_MENU+LEN(MENU_PRI[F_MENU])+2
     @ LIN_MENU,MENU_POS[F_MENU] SAY " "+MENU_PRI[F_MENU]+" "
NEXT
TELA_PRI=SAVESCREEN(LIN_MENU+1,00,23,79)
TELA_PRI=SAVESCREEN(LIN_MENU+1,00,23,79)
*
* - > Grava a ultima sombra
C_SOM=""
L_SOM=""
*
*** Inicio do bloco de substitui‡„o ACESSO.B
*
* -> Rotina de senha para acesso
*
*
SET CURSOR   OFF
SET COLOR TO BG+/N
CLS
LA="ÜÜÜÜÜÜ/                ÜÜÜÜÜÜ/ ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ/ ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ/    "
LB="ÜÜÜÜÜÜÜ/              ÜÜÜÜÜÜÜ/ ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ/ ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ/  "
LC=" ÜÜÜÜÜÜÜ/            ÜÜÜÜÜÜÜ/   ÜÜÜÜ/         ÜÜÜÜ/  ÜÜÜÜÜ/          ÜÜÜÜÜÜÜ/ "
LD=" ÜÜÜÜÜÜÜÜ/          ÜÜÜÜÜÜÜÜ/   ÜÜÜÜ/   ÜÜÜÜ/        ÜÜÜÜÜ/           ÜÜÜÜÜÜÜ/"
LE=" ÜÜÜÜ/ÜÜÜÜ/        ÜÜÜÜ/ÜÜÜÜ/   ÜÜÜÜÜÜÜÜÜÜÜÜ/        ÜÜÜÜÜ/          ÜÜÜÜÜÜÜ/ "
LF=" ÜÜÜÜ/ ÜÜÜÜ/      ÜÜÜÜ/ ÜÜÜÜ/   ÜÜÜÜÜÜÜÜÜÜÜÜ/        ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ/  "
LG=" ÜÜÜÜ/  ÜÜÜÜ/    ÜÜÜÜ/  ÜÜÜÜ/   ÜÜÜÜ/   ÜÜÜÜ/        ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ/  "
LH=" ÜÜÜÜ/   ÜÜÜÜ/  ÜÜÜÜ/   ÜÜÜÜ/   ÜÜÜÜ/                ÜÜÜÜÜ/          ÜÜÜÜÜÜÜ/ "
LI=" ÜÜÜÜ/    ÜÜÜÜ/ÜÜÜÜ/    ÜÜÜÜ/   ÜÜÜÜ/                ÜÜÜÜÜ/            ÜÜÜÜÜÜ/"
LJ=" ÜÜÜÜ/     ÜÜÜÜÜÜÜ/     ÜÜÜÜ/   ÜÜÜÜ/                ÜÜÜÜÜ/          ÜÜÜÜÜÜÜ/ "
LL="ÜÜÜÜÜÜ/     ÜÜÜÜÜ/     ÜÜÜÜÜÜ/ ÜÜÜÜÜÜ/              ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ/  "
LM="ÜÜÜÜÜÜ/      ÜÜÜ/      ÜÜÜÜÜÜ/ ÜÜÜÜÜÜ/              ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ/    "
*
CONTADOR=0
EMPRESA="Barreto Material de Construcao Ltda."
CGC="C.G.C. 34.196.147/000-18 - Insc. Estadual 28.956.505-NO"
*
**
FOR CONTADOR=0 TO LEN(LA)+10 STEP +10
     @ 03,(80-LEN(LA))/2 say PADL(SUBSTR(LA,1,CONTADOR),LEN(LA))
     @ 04,(80-LEN(LB))/2 say PADR(SUBSTR(LB,1,CONTADOR),LEN(LB))
     @ 05,(80-LEN(LC))/2 say PADL(SUBSTR(LC,1,CONTADOR),LEN(LC))
     @ 06,(80-LEN(LD))/2 say PADR(SUBSTR(LD,1,CONTADOR),LEN(LD))
     @ 07,(80-LEN(LE))/2 say PADL(SUBSTR(LE,1,CONTADOR),LEN(LE))
     @ 08,(80-LEN(LF))/2 say PADR(SUBSTR(LF,1,CONTADOR),LEN(LF))
     @ 09,(80-LEN(LG))/2 say PADL(SUBSTR(LG,1,CONTADOR),LEN(LG))
     @ 10,(80-LEN(LH))/2 say PADR(SUBSTR(LH,1,CONTADOR),LEN(LH))
     @ 11,(80-LEN(LI))/2 say PADL(SUBSTR(LI,1,CONTADOR),LEN(LI))
     @ 12,(80-LEN(LJ))/2 say PADR(SUBSTR(LJ,1,CONTADOR),LEN(LJ))
     @ 13,(80-LEN(LL))/2 say PADL(SUBSTR(LL,1,CONTADOR),LEN(LL))
     @ 14,(80-LEN(LM))/2 say PADR(SUBSTR(LM,1,CONTADOR),LEN(LM))
     INKEY(0.01)
NEXT
*
SET CURSOR OFF
@ 00,00 SAY PADC("M.M.S.tec Artes Graficas & Inform tica Ltda.",80)     COLOR ("G+/N")
@ 01,00 SAY PADC("(C) Copyright Marcos Morais de Sousa - 1996/1997",80) COLOR ("w+/N")
@ 16,00 SAY PADC(EMPRESA,80) COLOR ("W+/N")
@ 17,00 SAY PADC(CGC,80)     COLOR ("G+/N")
*
*
SET COLOR TO W
@ 15,00 SAY ""
@ 16,00 CLEAR TO 24,80
M->NIVEL=" "
M->TENTATIVA=1
DO WHILE M->NIVEL=" " .AND. M->TENTATIVA<4
   M->NIVEL=SENHA()
   IF M->NIVEL=" " .AND. M->TENTATIVA<3
      BEEP()
      *
      @ 19,00 to 21,11        COLOR("B+/"+ALLTRIM(SUBS(CONTECOR[13],4)))
      SOMBRA(19,00,21,11)
      @ 20,01 SAY PADC("E R R O",10) COLOR("R+/"+ALLTRIM(SUBS(CONTECOR[13],4)))
      *
          @ 23,01 SAY REPL("Ü",78) COLOR("N/"+ALLTRIM(SUBS(CONTECOR[13],4)))
          MENSAGEM("Senha n„o confere, tente novamente",2)
   ENDIF
   M->TENTATIVA=M->TENTATIVA+1
ENDDO
RESTSCREEN(LIN_MENU+1,00,23,79,TELA_PRI)
IF M->NIVEL=" "
   SET CURSOR OFF
   BEEP()
      *
      @ 19,00 to 21,11        COLOR("B+/"+ALLTRIM(SUBS(CONTECOR[13],4)))
      SOMBRA(19,00,21,11)
      @ 20,01 SAY PADC("E R R O",10) COLOR("R+/"+ALLTRIM(SUBS(CONTECOR[13],4)))
      *
     @ 23,01 SAY REPL("Ü",78) COLOR("N/"+ALLTRIM(SUBS(CONTECOR[13],4)))
     MENSAGEM("Acesso n„o permitido",3)
   SET CURSOR ON
   SET COLOR TO w+/W
   @ 00,00 CLEAR TO 20,79
   ? REPL(" M.M.S.tec ",240)
   SETColor ("G+/G")
   @ 10,15 CLEAR TO 15,60
   @ 10,15 TO 15,60 DOUBLE
   SOMBRA(10,15,15,60)
   @ 12,20 say PADC(RTRIM(M->OPERADOR)+", sinto muito!",40) Color "W+*/G"
   @ 13,20 say PADC("Esgotaram-se suas tentativas",40)                  Color "W+*/G"
   ***
   @ 24,00 SAY PADL("Marcos Morais de Sousa.",80)     Color "G+/N"
   @ 01,00 SAY PADR(" M.M.S.tec Artes Gr fica e infor tica Ltda. ",80)     Color "W+/N"
   @ 02,00 to 23,79 color("r+/n")
   SET COLOR TO W/N
   @ 24,00 SAY ""
   QUIT
   **
ENDIF
COR("TITULO")
@ 00,00
@ 00,(80-LEN(TITU_LO))/2 SAY TITU_LO
COR("MENU")
@ LIN_MENU,01
*
*** Final do bloco de substitui‡„o ACESSO.B
***
*

*
* Desativa acesso exclusivo permitindo acesso multiusuario
SET EXCLUSIVE OFF
M->DAT_HOJE=DATE()
MENSAGEM("Aguarde acesso aos arquivos")
*
* -> Funcao que cria DBF'S inexistentes
CRIARQ()
*
* -> Funcao que cria indices inexistentes
INDICES()
M->EX_T=0
M->OPC_ACHO=0
M->OK_PACK=.F.
**
** Bloco de inser‡„o MENU.B02
**
DO WHILE .T.
TONE(700,1)
   ***
   *** Inicio do bloco de substitui‡„o MENUPRI2.B
   SETCOLOR("W/"+ALLTRIM(SUBS(CONTECOR[13],4)))
   @ LIN_MENU,00 SAY "  "
   @ LIN_MENU,78 SAY "  "
   FOR F_MENU=1 TO LEN(MENU_PRI)
      @ LIN_MENU,MENU_POS[F_MENU] PROMPT " "+MENU_PRI[F_MENU]+" "
   NEXT
   KEYBOARD BUFFER
   MENU TO MENU_P
   BUFFER=CHR(13)
   *** Final do bloco de substitui‡„o MENUPRI2.B
   ***
     **
     ** Bloco de inser‡„o MENU.B04
     **
     IF MENU_P=1
          DO MFBINC
     ELSEIF MENU_P=2 .OR. MENU_P=3 .OR. MENU_P=4
          DO MFBCON WITH SUBS(" CAE",MENU_P,1)
          ***
          *** Inicio do bloco de substitui‡„o EXCLUIR.B
          IF M->OK_PACK
               M->OK_PACK=.F.
               IF MENU_P=4
                    IF PERGUNTA("Confirma a exclus„o dos registros marcados ?","N")="N"
                         LOOP
                    ELSE
                         *
                         * -> Executa a exclusao fisica
                         CLOSE DATABASES
                         MENSAGEM("Compactando o arquivo AVISTACM.DBF")
                         IF USEREDE("AVISTACM",.T.,10)
                              PACK
                         ELSE
                              BEEP()
                              MENSAGEM("O arquivo AVISTACM n„o esta dispon¡vel",3)
                         ENDIF
                         MENSAGEM("Compactando o arquivo AVISTALJ.DBF")
                         IF USEREDE("AVISTALJ",.T.,10)
                              PACK
                         ELSE
                              BEEP()
                              MENSAGEM("O arquivo AVISTALJ n„o esta dispon¡vel",3)
                         ENDIF
                         MENSAGEM("Compactando o arquivo APRAZOCM.DBF")
                         IF USEREDE("APRAZOCM",.T.,10)
                              PACK
                         ELSE
                              BEEP()
                              MENSAGEM("O arquivo APRAZOCM n„o esta dispon¡vel",3)
                         ENDIF
                         MENSAGEM("Compactando o arquivo APRAZOLJ.DBF")
                         IF USEREDE("APRAZOLJ",.T.,10)
                              PACK
                         ELSE
                              BEEP()
                              MENSAGEM("O arquivo APRAZOLJ n„o esta dispon¡vel",3)
                         ENDIF
                         MENSAGEM("Compactando o arquivo UNITARIO.DBF")
                         IF USEREDE("UNITARIO",.T.,10)
                              PACK
                         ELSE
                              BEEP()
                              MENSAGEM("O arquivo UNITARIO n„o esta dispon¡vel",3)
                         ENDIF
                         MENSAGEM("Compactando o arquivo FICHACLI.DBF")
                         IF USEREDE("FICHACLI",.T.,10)
                              PACK
                         ELSE
                              BEEP()
                              MENSAGEM("O arquivo FICHACLI n„o esta dispon¡vel",3)
                         ENDIF
                         MENSAGEM("Aguarde organiza‡„o dos arquivos")
                         USE
                         INDICES(.T.)
                    ENDIF
               ENDIF
          ENDIF
          *** Final do bloco de substitui‡„o EXCLUIR.B
          ***
     ELSEIF MENU_P=5
          DO MFBREL
     ELSEIF MENU_P=6
          MENSAGEM("Tecle <ESC> para sair")
          DECLARE ME_NU[11]
          ME_NU[1]="Reorganizar"
          ME_NU[2]="-"
          ME_NU[3]=">Papel de parede"
          ME_NU[4]=">Configura‡„o de cores"
          ME_NU[5]="Configura‡„o padr„o"
          ME_NU[6]="-"
          ME_NU[7]="Configura‡„o de back-up"
          ME_NU[8]="Back-up"
          ME_NU[9]="Restaura"
          ME_NU[10]="-"
          IF M->NIVEL="3"
               ME_NU[11]=">Senhas"
          ELSE
               ME_NU[11]="Mudan‡a de senha"
          ENDIF
          **
          ** Bloco de inser‡„o MENU.B05
          **
          MENU_S=MENU()
          IF MENU_S=1
               IF PERGUNTA("Comfirma a reorganiza‡„o dos arquivos ?")="S"
                    MENSAGEM("Aguarde organiza‡„o dos arquivos")
                    *
                    * -> Ativa organiza‡„o dos arquivos
                    INDICES(.T.)
               ENDIF
          ELSEIF MENU_S=5
               IF PERGUNTA("Ativar configura‡„o padr„o de cores ?")="S"
                    PADRAO()
                    FUNDO()
                    COR("TITULO")
                    @ 00,00
                    @ 00,(80-LEN(TITU_LO))/2 SAY TITU_LO
                    COR("MENU")
                    @ LIN_MENU,00
                    FOR F_MENU=1 TO LEN(MENU_PRI)
                         @ LIN_MENU,MENU_POS[F_MENU]+1 SAY MENU_PRI[F_MENU]
                    NEXT
                    @ 24,00
                    @ 24,01 SAY "F1-Ajuda ³"
                    @ 24,69 SAY "³"
                    @ 24,71 SAY DATE()
                    TELA_PRI=SAVESCREEN(LIN_MENU+1,00,23,79)
               ENDIF
          ELSEIF MENU_S=7
               JANELA(06,21,17,59,"Configura‡„o de back-up")
               COR("MENU")
               @ LIN_MENU,00
               @ LIN_MENU,01 SAY "Utilit rios ³ Configura‡„o de back-up"
               @ 09,26 CLEAR TO 12,54
               BOTAO(14,35,"Enter")
               DECLARE MENU_CFG[2]
               MENU_CFG[1]="     ("+CHR(7)+") Unidade A:"
               MENU_CFG[2]="     ("+CHR(7)+") Unidade B:"
               SETCOLOR(CONTECOR[2]+","+CONTECOR[7])
               KEYBOARD CHR(32)
               M->TEC_CONF=IIF(M->DRI_VE="A",1,2)
               M->TEC_CONF=ACHOICE(10,28,11,52,MENU_CFG,.T.,"FUN_CFG",M->TEC_CONF)
               IF M->TEC_CONF<>0
                    BOTAO(14,35,"Enter",-2)
                    M->DRI_VE=IIF(M->TEC_CONF=1,"A","B")
               ENDIF
               RESTSCREEN(LIN_MENU+1,00,23,79,TELA_PRI)
          ELSEIF MENU_S=8
               DECLARE NOMARQ[007]
               NOMARQ[001]="AVISTACM.DBF"
               NOMARQ[002]="AVISTALJ.DBF"
               NOMARQ[003]="APRAZOCM.DBF"
               NOMARQ[004]="APRAZOLJ.DBF"
               NOMARQ[005]="UNITARIO.DBF"
               NOMARQ[006]="FICHACLI.DBF"
               NOMARQ[007]="FICHACLI.DBT"
               BACKUP("MFB")
          ELSEIF MENU_S=9
               RESTAURA("MFB")
               MENSAGEM("Aguarde organiza‡„o dos arquivos")
               INDICES(.T.)
          ELSEIF MENU_S=3
               FUNDO(1)
          ELSEIF MENU_S=4
               CONFCOR()
          ELSEIF MENU_S=11
               IF M->NIVEL<"3"
                    RESTSCREEN(LIN_MENU+1,00,23,79,TELA_PRI)
                    COR("MENU")
                    @ LIN_MENU,00
                    @ LIN_MENU,01 SAY "Utilit rios ³ Senhas"
               ENDIF
               M_SENHA()
               RESTSCREEN(LIN_MENU+1,00,23,79,TELA_PRI)
          ENDIF
     ELSEIF MENU_P=7
          DECLARE ME_NU[1]
          ME_NU[1]="Fim de execu‡„o"
          MENU_S=MENU()
          IF MENU_S=1
               IF PERGUNTA("Confirma o encerramento ?")="S"
                    EXIT
               ENDIF
          ENDIF
     ENDIF
ENDDO
SET COLOR TO W
CLEAR
SET CURSOR ON
*
* -> Salvando configuracao
VAR=""
* -> Cores
FOR F=1 TO 12
     VAR=VAR+CONTECOR[F]
NEXT
*
* -> Posicao da Calculadora
VAR=VAR+STR(MOVCAL_X,2)
VAR=VAR+STR(MOVCAL_Y,2)
*
* -> Configuracao para Entrada de dados (Tecla F6)
VAR=VAR+IIF(CNF_REP,"T","F")
VAR=VAR+IIF(CNF_CON,"T","F")
VAR=VAR+CNF_DEL
*
* -> Fundo da tela
VAR=VAR+STR(FUNDO,2)
*
* -> Unidade de saida do back-up
VAR=VAR+M->DRI_VE
*
* -> Cor do titulo
VAR=VAR+CONTECOR[13]
*
* -> Gravando configuracao
MEMOWRIT("MFB.CFG",VAR)
SAIDA(60)

*
* ////////////////////////////////////////////////////////////////////////////*
*
* -> Inicioa da Funaco saida ( arquivo de localizacao: MENU.B06 )
*
FUNCTION SAIDA
PARA SAIDA            // determina tempo de espera
*
SET CURSOR   OFF      // desliga o cursor
SET COLOR TO BG+/N    // define cor padrao
CLS
LA="ÜÜÜÜÜÜ/                ÜÜÜÜÜÜ/ ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ/ ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ/    "
LB="ÜÜÜÜÜÜÜ/              ÜÜÜÜÜÜÜ/ ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ/ ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ/  "
LC=" ÜÜÜÜÜÜÜ/            ÜÜÜÜÜÜÜ/   ÜÜÜÜ/         ÜÜÜÜ/  ÜÜÜÜÜ/          ÜÜÜÜÜÜÜ/ "
LD=" ÜÜÜÜÜÜÜÜ/          ÜÜÜÜÜÜÜÜ/   ÜÜÜÜ/   ÜÜÜÜ/        ÜÜÜÜÜ/           ÜÜÜÜÜÜÜ/"
LE=" ÜÜÜÜ/ÜÜÜÜ/        ÜÜÜÜ/ÜÜÜÜ/   ÜÜÜÜÜÜÜÜÜÜÜÜ/        ÜÜÜÜÜ/          ÜÜÜÜÜÜÜ/ "
LF=" ÜÜÜÜ/ ÜÜÜÜ/      ÜÜÜÜ/ ÜÜÜÜ/   ÜÜÜÜÜÜÜÜÜÜÜÜ/        ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ/  "
LG=" ÜÜÜÜ/  ÜÜÜÜ/    ÜÜÜÜ/  ÜÜÜÜ/   ÜÜÜÜ/   ÜÜÜÜ/        ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ/  "
LH=" ÜÜÜÜ/   ÜÜÜÜ/  ÜÜÜÜ/   ÜÜÜÜ/   ÜÜÜÜ/                ÜÜÜÜÜ/          ÜÜÜÜÜÜÜ/ "
LI=" ÜÜÜÜ/    ÜÜÜÜ/ÜÜÜÜ/    ÜÜÜÜ/   ÜÜÜÜ/                ÜÜÜÜÜ/            ÜÜÜÜÜÜ/"
LJ=" ÜÜÜÜ/     ÜÜÜÜÜÜÜ/     ÜÜÜÜ/   ÜÜÜÜ/                ÜÜÜÜÜ/          ÜÜÜÜÜÜÜ/ "
LL="ÜÜÜÜÜÜ/     ÜÜÜÜÜ/     ÜÜÜÜÜÜ/ ÜÜÜÜÜÜ/              ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ/  "
LM="ÜÜÜÜÜÜ/      ÜÜÜ/      ÜÜÜÜÜÜ/ ÜÜÜÜÜÜ/              ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ/    "
*
CONTADOR  :=0
AUTOR     :="(C) Copyright Marcos Morais de Sousa - 1996/"+TRAN(YEAR(DATE()),"@E 9999")
MMSTEC    :="MMStec Artes Gr ficas & Inform tica Ltda"
EMPRESA   :="MFB Material de Constru‡„o Ltda."
CGC       :="CGC 034.196.147/000-18 - Insc. Estadual 028.956.505-NO"
*
**
FOR CONTADOR=0 TO LEN(LA)+10 STEP +10
     @ 03,(80-LEN(LA))/2 say PADL(SUBSTR(LA,1,CONTADOR),LEN(LA))
     @ 04,(80-LEN(LB))/2 say PADR(SUBSTR(LB,1,CONTADOR),LEN(LB))
     @ 05,(80-LEN(LC))/2 say PADL(SUBSTR(LC,1,CONTADOR),LEN(LC))
     @ 06,(80-LEN(LD))/2 say PADR(SUBSTR(LD,1,CONTADOR),LEN(LD))
     @ 07,(80-LEN(LE))/2 say PADL(SUBSTR(LE,1,CONTADOR),LEN(LE))
     @ 08,(80-LEN(LF))/2 say PADR(SUBSTR(LF,1,CONTADOR),LEN(LF))
     @ 09,(80-LEN(LG))/2 say PADL(SUBSTR(LG,1,CONTADOR),LEN(LG))
     @ 10,(80-LEN(LH))/2 say PADR(SUBSTR(LH,1,CONTADOR),LEN(LH))
     @ 11,(80-LEN(LI))/2 say PADL(SUBSTR(LI,1,CONTADOR),LEN(LI))
     @ 12,(80-LEN(LJ))/2 say PADR(SUBSTR(LJ,1,CONTADOR),LEN(LJ))
     @ 13,(80-LEN(LL))/2 say PADL(SUBSTR(LL,1,CONTADOR),LEN(LL))
     @ 14,(80-LEN(LM))/2 say PADR(SUBSTR(LM,1,CONTADOR),LEN(LM))
     INKEY(0.01)
NEXT
*
SET CURSOR OFF
@ 01,(80-LEN(MMSTEC)) /2 SAY PADC(MMSTEC,LEN(MMSTEC))   COLOR ("G+/N")
@ 02,(80-LEN(AUTOR))  /2 SAY PADC(AUTOR,LEN(AUTOR))     COLOR ("w+/N")
@ 16,(80-LEN(EMPRESA))/2 SAY PADC(EMPRESA,LEN(EMPRESA)) COLOR ("W+/N")
@ 17,(80-LEN(CGC))    /2 SAY PADC(CGC,LEN(CGC))         COLOR ("G+/N")
*
*
SETCOLOR ("R+/R")
@ 19,10 CLEAR TO 21,70
@ 19,10 TO 21,70
@ 20,(80-LEN(MMSTEC)) /2 SAY PADC(MMSTEC,LEN(MMSTEC))   COLOR ("W+/R")
SET COLOR TO W
TONE(550,4)
TONE(850,8)
*
@ 00,01 SAY REPL(CHR(4),SAIDA) COLOR("N+/N")
FOR SAIDA=01 TO 60
     SET CURSOR OFF
     IF LASTKEY()=27
        SETCOLOR("RG+/N")
        EXIT
     ENDIF
INKEY(1)
@ 00,SAIDA SAY CHR(4)                  COLOR("RG+/N")
@ 00,62  SAY "Restam"                  COLOR("G /N")
@ 00,69  SAY PADR(60-SAIDA,60-SAIDA)   COLOR("RG+/N")
@ 00,71  SAY " Segundos"               COLOR("G /N")
@ 01,69  SAY PADR(SAIDA,SAIDA)         COLOR("G+/N")
@ 01,71  SAY " Segundos"               COLOR("G /N")

NEXT
*
SETCOLOR("G+/N")
LOGOMARCA()
QUIT
*
* -> Final de funcao saida ( arquivo de localizacao: MENU.B06 )
*
* ////////////////////////////////////////////////////////////////////////// *
 
* /////////////////////////////////////////////////////////////////////////////////////////////////////// ** /////////////////////////////////////////////////////////////////////////////////////////////////////// *
*
* -> Inicio da funcao que edita um box em forma de janela
*
FUNCTION JANELA
*
PARA PJAN1,PJAN2,PJAN3,PJAN4,PJAN5
IF PCOUNT()<>5
    PJAN5=""
ENDIF
SOMBRA(PJAN1,PJAN2,PJAN3+1,PJAN4)
SETCOLOR(CONTECOR[4])
     @ PJAN1,PJAN2 CLEAR TO PJAN3+1,PJAN4
* /////////////////////////////////////////////////////////////////////////////////////////////////////// *
     AUTOR     :="(C) Marcos Morais de Sousa - 1995/"+TRAN(YEAR(DATE()),"@E 9999")
     MMSTEC    :="MMStec Artes Gr ficas & Inform tica Ltda"
     EMPRESA   :="MFB Material de Constru‡„O Ltda"
     CONTADOR  :=0
     HOJE      :=DATE()
     SEMANA    :="Domingo      Segunda-feiraTerca-feira  Quarta-feira Quinta-feira Sexta-feira  S bado       "
     DIA       :=TRIM(SUBS(SEMANA,DOW(HOJE)*13-12,13))+", "+ALLTRIM(STR(DAY(HOJE),2))
     MES       :="janeiro  fevereiromar‡o    abril    maio     junho    "
     MES       :=MES+"julho    agosto   setembro outubro  novembro dezembro "
     DIA       :=DIA+" de "+TRIM(SUBS(MES,MONTH(HOJE)*9-8,9))+" de "
     DIA       :=DIA+TRAN(YEAR(HOJE),"@E 9999")
     @ PJAN3,PJAN2+(((PJAN4+1-PJAN2)-LEN(DIA))/2) SAY DIA
* /////////////////////////////////////////////////////////////////////////////////////////////////////// *
DO CASE
     CASE VAL(LEFT(TIME(),2)) = 07
          @ PJAN3+1,PJAN2 SAY PADC(LEFT(TIME(),5)+" Bom dia, expediente Inicializado! ",PJAN4-PJAN2)               COLOR("R*/"+ALLTRIM(SUBS(CONTECOR[4],4)))
     CASE VAL(LEFT(TIME(),2)) = 12
          @ PJAN3+1,PJAN2 SAY PADC(LEFT(TIME(),5)+" Boa tarde, expediente finalizado! ",PJAN4-PJAN2)               COLOR("R*/"+ALLTRIM(SUBS(CONTECOR[4],4)))
     CASE VAL(LEFT(TIME(),2)) = 10 .OR. VAL(LEFT(TIME(),2)) = 15
          @ PJAN3+1,PJAN2 SAY PADC(LEFT(TIME(),5)+" Hora do lanche. Expediente interrompido! ",PJAN4-PJAN2)        COLOR("R*/"+ALLTRIM(SUBS(CONTECOR[4],4)))
     CASE VAL(LEFT(TIME(),2)) = 18
          @ PJAN3+1,PJAN2 SAY PADC(LEFT(TIME(),5)+" Boa noite, EXPEDIENTE ENCERRADO! ",PJAN4-PJAN2)                COLOR("R*/"+ALLTRIM(SUBS(CONTECOR[4],4)))
     CASE DATE() =  CTOD("01/01"+STR(YEAR(DATE())))
          @ PJAN3+1,PJAN2 SAY PADC("ANO NOVO - Dia internacional da Confraterniza‡„o",80)
     CASE DATE() =  CTOD("11/02"+STR(YEAR(DATE())))
          @ PJAN3+1,PJAN2 SAY PADC("Comemora‡„o do Carnaval",PJAN4+1-PJAN2)
     CASE DATE() =  CTOD("12/02"+STR(YEAR(DATE())))
          @ PJAN3+1,PJAN2 SAY PADC("Quarta feira de Cinzas",PJAN4+1-PJAN2)
     CASE DATE() =  CTOD("20/03"+STR(YEAR(DATE())))
          @ PJAN3+1,PJAN2 SAY PADC("Inicio do Outono",PJAN4+1-PJAN2)
     CASE DATE() =  CTOD("28/03"+STR(YEAR(DATE())))
          @ PJAN3+1,PJAN2 SAY PADC("Sexta feira da PAIXAO",PJAN4+1-PJAN2)
     CASE DATE() =  CTOD("30/03"+STR(YEAR(DATE())))
          @ PJAN3+1,PJAN2 SAY PADC("Comemora‡„o da Pascoa",PJAN4+1-PJAN2)
     CASE DATE() =  CTOD("01/04"+STR(YEAR(DATE())))
          @ PJAN3+1,PJAN2 SAY PADC("1§ de abril - DIA DA MENTIRA",PJAN4+1-PJAN2)
     CASE DATE() =  CTOD("21/04"+STR(YEAR(DATE())))
          @ PJAN3+1,PJAN2 SAY PADC("Dia de Tiradentes",PJAN4+1-PJAN2)
     CASE DATE() =  CTOD("01/05"+STR(YEAR(DATE())))
          @ PJAN3+1,PJAN2 SAY PADC("Dia do Trabalho",PJAN4+1-PJAN2)
     CASE DATE() =  CTOD("29/05"+STR(YEAR(DATE())))
          @ PJAN3+1,PJAN2 SAY PADC("CORPUS CRISTI",PJAN4+1-PJAN2)
     CASE DATE() =  CTOD("12/06"+STR(YEAR(DATE())))
          @ PJAN3+1,PJAN2 SAY PADC("Dia dos Namorados",PJAN4+1-PJAN2)
     CASE DATE() =  CTOD("21/06"+STR(YEAR(DATE())))
          @ PJAN3+1,PJAN2 SAY PADC("Inicio do Inverno",PJAN4+1-PJAN2)
     CASE DATE() =  CTOD("10/07"+STR(YEAR(DATE())))
          @ PJAN3+1,PJAN2 SAY PADC("MMS",PJAN4+1-PJAN2)
     CASE DATE() =  CTOD("07/09"+STR(YEAR(DATE())))
          @ PJAN3+1,PJAN2 SAY PADC("Comemora‡„o da Independencia do Brasil",PJAN4+1-PJAN2)
     CASE DATE() =  CTOD("22/09"+STR(YEAR(DATE())))
          @ PJAN3+1,PJAN2 SAY PADC("Inicio da Primavera",PJAN4+1-PJAN2)
     CASE DATE() =  CTOD("12/10"+STR(YEAR(DATE())))
          @ PJAN3+1,PJAN2 SAY PADC("Dia da Padroeira do Brasil - N.S. APARECIDA",PJAN4+1-PJAN2)
     CASE DATE() =  CTOD("02/11"+STR(YEAR(DATE())))
          @ PJAN3+1,PJAN2 SAY PADC("Dia de Finados",PJAN4+1-PJAN2)
     CASE DATE() =  CTOD("15/11"+STR(YEAR(DATE())))
          @ PJAN3+1,PJAN2 SAY PADC("Comemora‡„o da Proclama‡„o da Republica do Brasil",PJAN4+1-PJAN2)
     CASE DATE() =  CTOD("19/11"+STR(YEAR(DATE())))
          @ PJAN3+1,PJAN2 SAY PADC("Dia da Bandeira",PJAN4+1-PJAN2)
     CASE DATE() =  CTOD("21/12"+STR(YEAR(DATE())))
          @ PJAN3+1,PJAN2 SAY PADC("Inicio do verao",PJAN4+1-PJAN2)
     CASE DATE() =  CTOD("25/12"+STR(YEAR(DATE())))
          @ PJAN3+1,PJAN2 SAY PADC("Comemora‡„o do NATAL - Nascimento de Jesus Cristo",PJAN4+1-PJAN2)
     CASE DATE() =  CTOD("31/12"+STR(YEAR(DATE()))) .OR. DATE() =  CTOD("27/03"+STR(YEAR(DATE())));
     .OR. DATE() =  CTOD("29/03"+STR(YEAR(DATE()))) .OR. DATE() =  CTOD("20/04"+STR(YEAR(DATE())));
     .OR. DATE() =  CTOD("30/04"+STR(YEAR(DATE()))) .OR. DATE() =  CTOD("28/05"+STR(YEAR(DATE())));
     .OR. DATE() =  CTOD("06/09"+STR(YEAR(DATE()))) .OR. DATE() =  CTOD("11/10"+STR(YEAR(DATE())));
     .OR. DATE() =  CTOD("01/11"+STR(YEAR(DATE()))) .OR. DATE() =  CTOD("14/11"+STR(YEAR(DATE())));
     .OR. DATE() =  CTOD("24/12"+STR(YEAR(DATE())))
          @ PJAN3+1,PJAN2 SAY PADC(" Amanh„, ser  feriado  ",PJAN4+1-PJAN2)   COLOR("R*/"+ALLTRIM(SUBS(CONTECOR[4],4)))
     OTHERWISE
          @ PJAN3+1,PJAN2 SAY PADC(AUTOR,PJAN4+1-PJAN2)
ENDCASE
SETCOLOR(CONTECOR[5])
@ PJAN1,PJAN2 CLEAR TO PJAN1,PJAN4
IF LEN(TRIM(PJAN5)) > 0
    @ PJAN1,PJAN2+(((PJAN4+1-PJAN2)-LEN(PJAN5))/2) SAY PJAN5
ENDIF
*
* - > Final da funcao janela
*
* /////////////////////////////////////////////////////////////////////////////////////////////////////// ** /////////////////////////////////////////////////////////////////////////////////////////////////////// *
 
FUNCTION AMBIENTE
*
SET DATE FORMAT TO "dd,mm,yyyy"
SET EPOCH TO 0100          // prepara datas para o terceiro milˆnio
*
PUBLIC OPERADOR
IF .NOT.EMPTY(M->OPERADOR) .AND. LASTKEY()<>5
OPERADOR  :=M->OPERADOR
ELSE
OPERADOR  :="Operador"
ENDIF

SETCANCEL(.f.)               // desativa ALT-C/BREAK
SET TALK OFF
SET DATE GERMAN
SET BELL OFF
SET STAT OFF
SET SCORE OFF
SET WRAP ON
SET CURSOR OFF
SET DELETED ON
*
* -> Ativa a PROTECAO na tecla ...................:F07
SET KEY -6 TO SEGURANCA
*
* -> Ativa a demostracao das horas na tecla ......:F08
SET KEY -7 TO RELOGIO
*
* -> Ativa a demostracao das horas na tecla ......:F09
SET KEY -8 TO BOM_DIA
*
* -> Ativa a demostracao das horas na tecla ......:F10
SET KEY -9 TO MUSICA
*
* -> Ativa a demostracao das horas na tecla ......:F11
SET KEY -40 TO MMS_EDITOR
*
* -> Ativa a APRESENTACAO DO SISTEMA na tecla ....:F12
SET KEY -41 TO DESCANSO_MMS
AUTOR     :="(C) Marcos Morais de Sousa - 1995/"+TRAN(YEAR(DATE()),"@E 9999")
MMSTEC    :="MMStec Artes Gr ficas & Inform tica Ltda"
EMPRESA   :="MFB Material de Constru‡„o Ltda"
CONTADOR  :=0
HOJE      :=DATE()
SEMANA    :="Domingo      Segunda-feiraTerca-feira  Quarta-feira Quinta-feira Sexta-feira  S bado       "
DIA       :=TRIM(SUBS(SEMANA,DOW(HOJE)*13-12,13))+", "+ALLTRIM(STR(DAY(HOJE),2))
MES       :="janeiro  fevereiromar‡o    abril    maio     junho    "
MES       :=MES+"julho    agosto   setembro outubro  novembro dezembro "
DIA       :=DIA+" de "+TRIM(SUBS(MES,MONTH(HOJE)*9-8,9))+" de "
DIA       :=DIA+TRAN(YEAR(HOJE),"@E 9999")
RETURN .F.

FUNCTION PADRAO
CONTECOR[01]="09/01"
CONTECOR[02]="00/03"
CONTECOR[03]="15/03"
CONTECOR[04]="09/07"
CONTECOR[05]="14/01"
CONTECOR[06]="07/04"
CONTECOR[07]="15/04"
CONTECOR[08]="15/03"
CONTECOR[09]="10/00"
CONTECOR[10]="10/00"
CONTECOR[11]="09/07"
CONTECOR[12]="12/07"
CONTECOR[13]="15/01"
RETURN .T.

FUNCTION M_SENHA
M->SEN_OPC=0
IF M->NIVEL="3"
     MENSAGEM("Tecle <ESC> para retornar")
     DECLARE ME_NU[5]
     *
     * -> Menu para manipula‡„o de senhas
     ME_NU[1]="Credenciar novo operador"
     ME_NU[2]="Descredenciar operador"
     ME_NU[3]="Mudar o n¡vel de acesso"
     ME_NU[4]="Listagem de operadores"
     ME_NU[5]="Mudan‡a de senhas"
     M->SEN_OPC=MENU(1)
     IF M->SEN_OPC = 0
          RETURN .F.
     ENDIF
     BUFFER=CHR(13)+"S"
     COR("MENU")
     @ LIN_MENU,00
     @ LIN_MENU,01 SAY "Utilit rios ³ Senhas"
     IF M->SEN_OPC=1
          JANELA(06,13,18,66,"Credenciamento de operadores")
          COR("MENU")
          @ 09,18 CLEAR TO 15,61
          @ 10,20 SAY "Operador ....... :"
          @ 12,20 SAY "Nivel de acesso  :  1 - Operacional"
          @ 14,20 SAY "Senha .......... :"
          M->USUARIO=SPACE(20)
          M->ACESSO="1"
          @ 10,40 GET M->USUARIO PICT "@!" VALID .NOT. PESENHA("U",M->USUARIO,.T.,"Operador j  cadastrado") .AND. .NOT. EMPTY(M->USUARIO)
          @ 12,40 GET M->ACESSO PICT "9" VALID NIV_ACES(12)
          SET CURSOR ON
          READ
          SET CURSOR OFF
          IF LASTKEY()=27
               RETURN .F.
          ENDIF
          MENSAGEM("Digite a senha de acesso")
          M->CODSENHA=GET_COD(14,40)
          IF M->CODSENHA=CHR(27)
               RETURN .F.
          ENDIF
          M->NOM_ARQ="MFB.SNH"
          IF USEREDE(M->NOM_ARQ,.F.,10)
               IF .NOT. ADIREG(0)
                    BEEP()
                    MENSAGEM("Credenciamento mal sucedido",3)
                    USE
                    RETURN .F.
               ENDIF
          ELSE
               BEEP()
               MENSAGEM("Credenciamento mal sucedido",3)
               RETURN .F.
          ENDIF
          REPLACE CODSENHA WITH M->CODSENHA
          REPLACE USUARIO WITH M->USUARIO
          REPLACE ACESSO WITH M->ACESSO
          USE
     ELSEIF M->SEN_OPC=2
          JANELA(08,14,16,64,"Descredenciamento de operadores")
          COR("MENU")
          @ 11,18 CLEAR TO 13,60
          M->USUARIO=SPACE(20)
          @ 12,20 SAY "Nome do operador :" GET M->USUARIO PICT "@!" VALID PESENHA("U",M->USUARIO,.F.,"Operador n„o cadastrado")
          SET CURSOR ON
          READ
          SET CURSOR OFF
          IF LASTKEY()=27
               RETURN .F.
          ENDIF
          M->NOM_ARQ="MFB.SNH"
          IF .NOT. USEREDE(M->NOM_ARQ,.F.,10)
               BEEP()
               MENSAGEM("Acesso mal sucedido ao arquivo",3)
               RETURN .F.
          ENDIF
          GOTO TOP
          DO WHILE .NOT. EOF()
               IF USUARIO==M->USUARIO
                    MENSAGEM("Descredenciando o operador "+TRIM(M->USUARIO))
                    IF .NOT. REGLOCK(5)
                         BEEP()
                         MENSAGEM("Descredenciamento mal sucedido",3)
                         RESTORE SCREEN FROM TE_LA
                         RETURN .F.
                    ENDIF
                    DELETE
                    UNLOCK
                    EXIT
               ENDIF
               SKIP
          ENDDO
          USE
     ELSEIF M->SEN_OPC=3
          JANELA(07,14,17,66,"Mudan‡a do n¡vel de acesso")
          COR("MENU")
          @ 10,18 CLEAR TO 14,61
          @ 11,20 SAY "Operador ....... :"
          @ 13,20 SAY "Nivel de acesso  :"
          M->USUARIO=SPACE(20)
          M->ACESSO=" "
          @ 11,40 GET M->USUARIO PICT "@!" VALID PESENHA("U",M->USUARIO,.F.,"Operador n„o cadastrado")
          @ 13,40 GET M->ACESSO PICT "9" VALID NIV_ACES(13)
          SET CURSOR ON
          READ
          SET CURSOR OFF
          IF LASTKEY()=27
               RETURN .F.
          ENDIF
          M->NOM_ARQ="MFB.SNH"
          IF .NOT. USEREDE(M->NOM_ARQ,.F.,10)
               BEEP()
               MENSAGEM("Acesso mal sucedido ao arquivo",3)
               RETURN .F.
          ENDIF
          GOTO TOP
          DO WHILE .NOT. EOF()
               IF USUARIO==M->USUARIO
                    MENSAGEM("Troca de n¡vel conclu¡da",3)
                    IF .NOT. REGLOCK(20)
                         BEEP()
                         MENSAGEM("Troca de n¡vel mal sucedida",3)
                         EXIT
                    ENDIF
                    REPLACE USUARIO WITH M->USUARIO
                    REPLACE ACESSO WITH M->ACESSO
                    EXIT
               ENDIF
               SKIP
          ENDDO
          USE
     ELSEIF M->SEN_OPC=4
          JANELA(05,18,19,61,"Listagem de operadores")
          COR("MENU")
          @ 08,22 CLEAR TO 16,57
          @ 09,22 TO 16,57
          @ 08,24 SAY " Operador "
          @ 08,49 SAY " Nivel "
          M->NOM_ARQ="MFB.SNH"
          IF .NOT. USEREDE(M->NOM_ARQ,.F.,10)
               BEEP()
               MENSAGEM("Acesso mal sucedido ao arquivo",3)
               RETURN .F.
          ENDIF
          GOTO TOP
          DECLARE EDI_TAR[1]
          EDI_TAR[1]='" "+USUARIO+"       "+ACESSO+"   "'
          KEYBOARD CHR(0)
          DBEDIT(10,24,15,55,EDI_TAR,"","","","","")
     ENDIF
ENDIF
IF M->NIVEL<"3" .OR. M->SEN_OPC=5
     JANELA(07,20,17,59,"Mudan‡a de senhas")
     COR("MENU")
     @ 10,24 CLEAR TO 14,55
     @ 11,28 SAY "Senha atual"
     @ 13,28 SAY "Nova senha"
     M->TENTATIVA=1
     DO WHILE M->TENTATIVA<4
          MENSAGEM("Digite a senha atual")
          M->ATUSENHA=GET_COD(11,41)
          IF M->ATUSENHA<>CHR(27)
               IF .NOT. PESENHA("C",M->ATUSENHA)
                    IF M->TENTATIVA<>3
                         BEEP()
                         MENSAGEM("A senha atual n„o confere, tente novamente",3)
                    ENDIF
               ELSE
                    EXIT
               ENDIF
          ELSE
               EXIT
          ENDIF
          M->TENTATIVA=M->TENTATIVA+1
     ENDDO
     IF M->TENTATIVA=4
          BEEP()
          MENSAGEM("A senha atual n„o confere",3)
          RETURN .F.
     ENDIF
     IF M->ATUSENHA=CHR(27)
          RETURN .F.
     ENDIF
     MENSAGEM("Digite a nova senha")
     M->NOVSENHA=GET_COD(13,41)
     IF M->NOVSENHA=CHR(27)
          RETURN .F.
     ENDIF
     M->NOM_ARQ="MFB.SNH"
     IF .NOT. USEREDE(M->NOM_ARQ,.F.,10)
          BEEP()
          MENSAGEM("Acesso mal sucedido ao arquivo",3)
          RETURN .F.
     ENDIF
     GOTO TOP
     DO WHILE .NOT. EOF()
          IF CODSENHA==M->ATUSENHA
               MENSAGEM("Troca de senha conclu¡da ",3)
               IF .NOT. REGLOCK(20)
                    BEEP()
                    MENSAGEM("Troca de senha mal sucedida",3)
                    EXIT
               ENDIF
               REPLACE CODSENHA WITH M->NOVSENHA
               EXIT
          ENDIF
          SKIP
     ENDDO
     USE
ENDIF
RETURN .T.

FUNCTION PERG
*
* -> Funcao que executa uma pergunta
SETCOLOR("W+/"+ALLTRIM(SUBS(CONTECOR[13],4)))
SET CURSOR OFF
M->RES_POSTA="S"
PARA TEX_TO,RES_POSTA
M->SIM_NAO=IIF(M->RES_POSTA="N",2,1)
@ 24,11 SAY SPACE(58)
M->LI=(80-(LEN(M->TEX_TO)+11))/2
@ 24,M->LI SAY M->TEX_TO
M->LI=M->LI+LEN(M->TEX_TO)+2
DO WHILE .T.
   SETCOLOR("W*/"+ALLTRIM(SUBS(CONTECOR[13],4)))
   @ 24,M->LI   PROMPT " Sim "
   @ 24,M->LI+6 PROMPT " N„o "
   @ 24,M->LI+4 SAY " - "
   MENU TO M->SIM_NAO
   IF M->SIM_NAO<>0
      EXIT
   ENDIF
ENDDO
ON_CURSOR()
RETURN IIF(M->SIM_NAO=1,"S","N")
 
FUNCTION BACKUP
PARA NOMEBAK
COR("MENU")
@ LIN_MENU,00
@ LIN_MENU,01 SAY "Utilit rios ³ Back-up"
ESP_ACO=0
TOT_BYTE=0
BAK_PONT=0
L_SOM=""
C_SOM=""
NOMEBAK=DRI_VE+":\"+NOMEBAK
ARQCRIA=CRIABAK(NOMEBAK+".CTR")
IF ARQCRIA=-1
   RETURN .F.
ENDIF
MENSAGEM("Processando back-up")
JANELA(06,08,18,71,"Back-up")
SETCOLOR("g+/"+ALLTRIM(SUBS(CONTECOR[10],4)))
@ 09,12 CLEAR TO 15,67
@ 10,12 SAY "  0%       20%       40%       60%       80%       100% " COLOR("W+/"+ALLTRIM(SUBS(CONTECOR[10],4)))
@ 11,12 SAY "  ÃÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁ¿  "
@ 12,12 SAY "  ³                                                  ³  "
@ 13,12 SAY "  ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ  "
@ 14,15 SAY REPL(CHR(7),50) COLOR("W+/"+ALLTRIM(SUBS(CONTECOR[10],4)))
FOR NUMARQ=1 TO LEN(NOMARQ)
   ARQLER=FOPEN(NOMARQ[NUMARQ])
   FIMARQ=FSEEK(ARQLER,0,2)
   BAK=SUBS(NOMARQ[NUMARQ]+SPACE(15),1,15)
   BAK=BAK+STR(FIMARQ,10)+CHR(13)+CHR(10)
   TOT_BYTE=TOT_BYTE+FIMARQ
   FWRITE(ARQCRIA,BAK,27)
   FCLOSE(ARQLER)
NEXT
FCLOSE(ARQCRIA)
NUMDISCO=1
ARQCRIA=CRIABAK(NOMEBAK,@NUMDISCO)
IF ARQCRIA=-1
   RESTSCREEN(LIN_MENU+1,00,23,79,TELA_PRI)
   RETURN .F.
ENDIF
FOR NUMARQ=1 TO LEN(NOMARQ)
   ARQLER=FOPEN(NOMARQ[NUMARQ])
   FIMARQ=FSEEK(ARQLER,0,2)
   FOR PONTEIRO=0 TO FIMARQ STEP 5000
      BAK=SPACE(5000)
      IF PONTEIRO+5000>FIMARQ
         BAK=SPACE(FIMARQ-PONTEIRO)
      ENDIF
      FSEEK(ARQLER,PONTEIRO)
      FREAD(ARQLER,@BAK,LEN(BAK))
      BAK_PONT=BAK_PONT+LEN(BAK)
      IF GRAVABAK(ARQCRIA,BAK)=.F.
         RESTSCREEN(LIN_MENU+1,00,23,79,TELA_PRI)
         FCLOSE(ARQLER)
         RETURN .F.
      ENDIF
   NEXT
   FCLOSE(ARQLER)
NEXT
FCLOSE(ARQCRIA)
RESTSCREEN(LIN_MENU+1,00,23,79,TELA_PRI)

FUNCTION CRIABAK
PARA NOMECRIA,EXTCRIA
IF PCOUNT()=1
     EXTCRIA=0
ENDIF
IF EXTCRIA>1
     FCLOSE(ARQCRIA)
ENDIF
IF EXTCRIA<>1
     IF JANMENS("Insira o disco "+SUBS(STR(IIF(EXTCRIA=0,1,EXTCRIA)+1000,4),2)+" na unidade "+DRI_VE+":")=0
          RETURN -1
     ENDIF
ENDIF
IF EXTCRIA=0
     ARQ_NOM=NOMECRIA
     ARQ_DEL=SUBS(NOMECRIA,1,LEN(NOMECRIA)-3)+"001"
     IF FILE(ARQ_DEL)
          ERASE &ARQ_DEL
     ENDIF
ELSE
     ARQ_NOM=NOMECRIA+"."+SUBS(STR(EXTCRIA+1000,4),2)
ENDIF
DO WHILE .T.
     AR_Q=FCREATE(ARQ_NOM)
     IF FERROR()<>0
          FCLOSE(AR_Q)
          IF JANMENS("Disquete inexistente ou n„o formatado.")=0
               RETURN -1
          ELSE
               LOOP
          ENDIF
     ENDIF
     ESP_ACO=DISKSPACE( IIF(DRI_VE="A",1,2) )
     IF ESP_ACO<IIF(EXTCRIA=0,6000,5000)
          IF JANMENS("Disco sem espa‡o dispon¡vel para gerar BACK-UP.")=0
               FCLOSE(M->AR_Q)
               RETURN -1
          ENDIF
     ELSE
          ESP_ACO=ESP_ACO-4000
          EXIT
     ENDIF
ENDDO
EXTCRIA=EXTCRIA+1
RETURN AR_Q

FUNCTION JANMENS
PER_COR=SETCOLOR()
SET CURSOR OFF
SAVE SCREEN TO PER_TELA
PARA TEX_TO
L_JAN=L_SOM
C_JAN=C_SOM
SOMBRA(L_SOM,C_SOM,.T.)
M->SIM_NAO=1
M->LAR_G=LEN(M->TEX_TO)
IF M->LAR_G<37
     M->LAR_G=51
ELSE
     M->LAR_G=M->LAR_G+14
ENDIF
COL_SUP=INT((80-M->LAR_G)/2)
COL_INF=COL_SUP+LAR_G-1
JANELA(08,COL_SUP,16,COL_INF)
COR("JANELA DE DIALOGO")
@ 11,(80-LEN(TEX_TO))/2 SAY TEX_TO
BOTAO(13,25,"Continua",1)
BOTAO(13,42,"Sair",2)
BEEP()
SIM_NAO=BOTAO()
RESTORE SCREEN FROM PER_TELA
SETCOLOR(PER_COR)
SOMBRA(L_JAN,C_JAN)
RETURN IIF(SIM_NAO=2,0,SIM_NAO)

FUNCTION GRAVABAK
PARA P_ARQ,P_GRAV
IF ESP_ACO<LEN(P_GRAV)+10
   ARQCRIA=CRIABAK(NOMEBAK,@NUMDISCO)
   IF ARQCRIA=-1
      RETURN .F.
   ENDIF
ENDIF
FWRITE(P_ARQ,P_GRAV)
ESP_ACO=ESP_ACO-LEN(P_GRAV)
COR("MENU")
PERCENT=(BAK_PONT*100)/TOT_BYTE
IF PERCENT>0
   @ 12,15 SAY REPL("Û",INT((PERCENT/2)+.5))    COLOR("R+/"+ALLTRIM(SUBS(CONTECOR[10],4)))
   @ 14,15 SAY REPL(CHR(7),INT((PERCENT/2)+.5)) COLOR("G+/"+ALLTRIM(SUBS(CONTECOR[10],4)))
   ENDIF
RETURN .T.
 
FUNCTION RESTAURA
PARA NOMEBAK
COR("MENU")
@ LIN_MENU,00
@ LIN_MENU,01 SAY "Utilit rios ³ Restaura‡„o"
FIM=0
L_SOM=""
C_SOM=""
NOMEBAK=DRI_VE+":\"+NOMEBAK
ARQLER=LERBAK(NOMEBAK+".CTR")
FCLOSE(ARQLER)
IF ARQLER=-1
     RETURN .F.
ENDIF
BAK=MEMOREAD(NOMEBAK+".CTR")
NUMLINHA=MLCOUNT(BAK,25)
DECLARE NOMARQ[NUMLINHA]
TOT_BYTE=0
FOR FLINHA=1 TO NUMLINHA
     NOMARQ[FLINHA]=MEMOLINE(BAK,25,FLINHA)
     TOT_BYTE=TOT_BYTE+VAL(SUBS(NOMARQ[FLINHA],16))
NEXT
NUMDISCO=1
ARQLER=LERBAK(NOMEBAK,@NUMDISCO)
IF ARQLER=-1
     RETURN .F.
ENDIF
MENSAGEM("Processando restaura‡„o")
JANELA(06,08,18,71,"Restaura‡„o de back-up")
COR("MENU")
@ 09,12 CLEAR TO 15,67
@ 10,12 SAY "  0%       20%       40%       60%       80%       100% "
@ 11,12 SAY "  ÃÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁ¿  "
@ 12,12 SAY "  ³                                                  ³  "
@ 13,12 SAY "  ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ  "
PONTLER=0
BAK_PONT=0
FOR NUMARQ=1 TO LEN(NOMARQ)
     NOMECRIA=TRIM(SUBS(NOMARQ[NUMARQ],1,15))
     ARQCRIA=FCREATE(NOMECRIA)
     PONTBAK=0
     FIMARQ=VAL(TRIM(SUBS(NOMARQ[NUMARQ],16)))
     DO WHILE PONTBAK<FIMARQ
          IF PONTLER>=FIM
               ARQLER=LERBAK(NOMEBAK,@NUMDISCO)
               IF ARQLER=-1
                    FCLOSE(ARQLER)
                    RESTSCREEN(LIN_MENU+1,00,23,79,TELA_PRI)
                    RETURN .F.
               ENDIF
               PONTLER=0
          ENDIF
          FSEEK(ARQLER,PONTLER)
          BAK=SPACE(5000)
          IF PONTBAK+5000>FIMARQ
               BAK=SPACE(FIMARQ-PONTBAK)
          ENDIF
          IF PONTLER+LEN(BAK)>FIM
               BAK=SPACE(FIM-PONTLER)
          ENDIF
          FREAD(ARQLER,@BAK,LEN(BAK))
          FWRITE(ARQCRIA,BAK,LEN(BAK))
          PONTLER=PONTLER+LEN(BAK)
          PONTBAK=PONTBAK+LEN(BAK)
          BAK_PONT=BAK_PONT+LEN(BAK)
          PERCENT=(BAK_PONT*100)/TOT_BYTE
          IF PERCENT>0
               @ 12,15 SAY REPL(CHR(176),INT((PERCENT/2)+.5))
          ENDIF
          IF PERCENT=100
               EXIT
          ENDIF
     ENDDO
     FCLOSE(ARQCRIA)
NEXT
FCLOSE(ARQLER)
RESTSCREEN(LIN_MENU+1,00,23,79,TELA_PRI)

FUNCTION LERBAK
PARA NOMECRIA,EXTCRIA
IF PCOUNT()=1
     EXTCRIA=0
ENDIF
IF EXTCRIA>1
     FCLOSE(ARQLER)
ENDIF
IF EXTCRIA<>1
     IF JANMENS("Insira o disco "+SUBS(STR(IIF(EXTCRIA=0,1,EXTCRIA)+1000,4),2)+" na unidade "+DRI_VE+":")=0
          RETURN -1
     ENDIF
ENDIF
IF EXTCRIA=0
     ARQ_NOM=NOMECRIA
ELSE
     ARQ_NOM=NOMECRIA+"."+SUBS(STR(EXTCRIA+1000,4),2)
ENDIF
DO WHILE .T.
     AR_Q=FOPEN(ARQ_NOM)
     IF FERROR()<>0
          FCLOSE(AR_Q)
          IF JANMENS("Disquete incorreto, inexistente ou n„o formatado.")=0
               RETURN -1
          ELSE
               LOOP
          ENDIF
     ELSE
          EXIT
     ENDIF
ENDDO
FIM=FSEEK(AR_Q,0,2)
EXTCRIA=EXTCRIA+1
RETURN AR_Q
 
* Final do programa MFB.PRG
