
* TITULO     :  MFB Materiais de Construcao Ltda ( MMStec - Orcamento )
* DATA       : 06/03/97
* PROGRAMA   : UTIL.PRG
* COMENTARIO : MENU PRINCIPAL
 
APRESENTA()
  *
  *
  FUNCTION APRESENTA
  SETCOLOR("W+/b")
  SETCANCEL(.f.)               // desativa ALT-C/BREAK
  *SET EPOCH TO 1960            // prepara datas para o terceiro milˆnio
  SET CURSOR OFF
  SET COLOR TO W
a=0
b=0
c=0
d=0
sombra(a+05,b+12,c+06,d+72)
sombra(a+06,b+12,c+06,d+72)
sombra(a+07,b+12,c+07,d+72)
sombra(a+08,b+12,c+08,d+72)
sombra(a+09,b+12,c+09,d+72)
sombra(a+10,b+12,c+10,d+72)
sombra(a+11,b+12,c+11,d+72)
sombra(a+12,b+12,c+12,d+72)
sombra(a+13,b+12,c+13,d+72)
**
@ a+06,b+10 to c+15,d+70 color ("n+/n")
@ a+08,b+25 SAY PADC("/\/ M.M.S.tec  Utilit rio /\/ ",30) COLOR "W+/N"
@ a+09,b+25 SAY PADC(" ------ vers„o 0.01 ------ ",28) COLOR "G+/N"
@ a+12,b+25 SAY PADC(" Jequie  - Bahia -  Brasil. ",27) COLOR ("G+/N")
@ a+13,b+20 SAY PADC(" Produ‡„o de Marcos Morais de Sousa. ",38) COLOR ("G+/N")
@ 24,00 say ""
  @ 24,00 SAY PADL("< LENDO >",78) COLOR "R+*/n"
  @ 24,65 SAY chr(2) color ("RG+/N")
INKEY(2)
  CLS
  SET COLOR TO W
  @ 00,00 CLEAR TO 24,80
  @ 11,10 SAY "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ-" COLOR "R/n"
  @ 12,10 SAY "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ-" COLOR "R/n"
  @ 13,10 SAY "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ" COLOR "r/n"
  @ 14,10 SAY "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ-" COLOR "r/n"
  @ 15,10 SAY "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ-" COLOR "r/n"
  @ 16,10 SAY "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ-" COLOR "R/n"
  @ 17,10 SAY "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ-" COLOR "R/n"
  @ 18,10 SAY "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ-" COLOR "R/n"
  *
  @ 13,15 SAY " ÛÜ   ÜÛ " COLOR "B+/n"
  @ 14,15 SAY " Û ßÜß Û " COLOR "B+/n"
  @ 15,15 SAY " Û     Û " COLOR "BG/n"
  @ 16,15 SAY " ß     ß " COLOR "BG+/n"
  TONE(800.8)
  @ 13,15 Say " ÛÜ   ÜÛ ÛÜ   ÜÛ" COLOR "B+/n"
  @ 14,15 SAY " Û ßÜß Û Û ßÜß Û" COLOR "B+/n"
  @ 15,15 SAY " Û     Û Û     Û" COLOR "BG/n"
  @ 16,15 SAY " ß     ß ß     ß" COLOR "Bg+/n"
  TONE(800.8)
  @ 13,15 Say " ÛÜ   ÜÛ ÛÜ   ÜÛ ÛßßßßßÛ" COLOR "B/n"
  @ 14,15 SAY " Û ßÜß Û Û ßÜß Û ÛÜÜÜÜÜÜ" COLOR "B+/n"
  @ 15,15 SAY " Û     Û Û     Û Ü     Û" COLOR "BG/n"
  @ 16,15 SAY " ß     ß ß     ß ßßßßßßß" COLOR "Bg+/n"
  TONE(800.8)
  @ 13,15 Say " ÛÜ   ÜÛ ÛÜ   ÜÛ ÛßßßßßÛ  Ü " COLOR "B/n"
  @ 14,15 SAY " Û ßÜß Û Û ßÜß Û ÛÜÜÜÜÜÜ ßÛß" COLOR "B+/n"
  @ 15,15 SAY " Û     Û Û     Û Ü     Û  Û " COLOR "BG/n"
  @ 16,15 SAY " ß     ß ß     ß ßßßßßßß  ßß" COLOR "BG+/n"
  TONE(800.8)
  @ 13,15 Say " ÛÜ   ÜÛ ÛÜ   ÜÛ ÛßßßßßÛ  Ü  INFORMA" COLOR "B/n"
  @ 14,15 SAY " Û ßÜß Û Û ßÜß Û ÛÜÜÜÜÜÜ ßÛß ÛßßßßßÛ" COLOR "B+/n"
  @ 15,15 SAY " Û     Û Û     Û Ü     Û  Û  Ûßßßßßß" COLOR "BG/n"
  @ 16,15 SAY " ß     ß ß     ß ßßßßßßß  ßß ßßßßßßß" COLOR "BG+/n"
  TONE(800.8)
  @ 13,15 Say " ÛÜ   ÜÛ ÛÜ   ÜÛ ÛßßßßßÛ  Ü  INFORMATICA LTDA (R)" COLOR "B/N"
  @ 14,15 SAY " Û ßÜß Û Û ßÜß Û ÛÜÜÜÜÜÜ ßÛß ÛßßßßßÛ ÛßßßßßßÛ " COLOR "B+/N"
  @ 15,15 SAY " Û     Û Û     Û Ü     Û  Û  Ûßßßßßß Û      Ü" COLOR "BG/N"
  @ 16,15 SAY " Û     Û Û     Û ßßßßßßß  ßß ßßßßßßß ßßßßßßßß " COLOR "BG+/N"
  @ 17,15 SAY " ß     ßßß     ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß " COLOR "W/N"
  SETCOLOR ("Rg+/R")
  @ 04,09 CLEAR TO 09,69
  @ 04,09,09,69 BOX "ÛÛÛÛÛÜÛÛ" COLOR ("W+/R")
  @ 06,20 SAY "   M.M.S.tec PassWord(r) Vers„o 1.0    "
  @ 07,20 SAY "(C) Copyright by Marcos Morais de Sousa"
  TONE(550,4)
  TONE(850,8)

AMBIENTE()
SET PROCEDURE TO UTILARQ
SET PROCEDURE TO UTILSOS
SET PROCEDURE TO UTILFUN
FUNDO=1
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
M->AL_TERA=.F.
SET KEY -2 TO CALEN
SET KEY -3 TO CALCU
MOVCAL_X=5
MOVCAL_Y=0
SET KEY -4 TO SHELLDOS
IF FILE("UTIL.CFG")
   VAR=MEMOREAD("UTIL.CFG")
   FOR F=1 TO 12
      CONTECOR[F]=SUBS(VAR,(F*5)-4,5)
   NEXT
   MOVCAL_X=VAL(SUBS(VAR,61,2))
   MOVCAL_Y=VAL(SUBS(VAR,63,2))
   FUNDO=VAL(SUBS(VAR,69,2))
   CONTECOR[13]=SUBS(VAR,72,5)
ENDIF
TITU_LO="MFB Materiais de Construcao Ltda ( MMStec - Orcamento )"
*TITU_LO="MFB Materiais de Constru‡„o Ltda."
TITU_LO_B="Movimento Finaceiro de Cimento Diario."
LIN_MENU=2
COR("TITULO")
@ 00,00
@ 00,(80-LEN(TITU_LO_B))/2 SAY TITU_LO_B
@ 01,00
@ 01,(80-LEN(TITU_LO))/2 SAY TITU_LO

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
C_SOM=""
L_SOM=""
SET EXCLUSIVE OFF
M->DAT_HOJE=DATE()
MENSAGEM("Aguarde acesso aos arquivos")
CRIARQ()
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
      DO UTILINC
   ELSEIF MENU_P=2 .OR. MENU_P=3 .OR. MENU_P=4
      DO UTILCON WITH SUBS(" CAE",MENU_P,1)
      ***
      *** Inicio do bloco de substitui‡„o EXCLUIR.B
      IF M->OK_PACK
         M->OK_PACK=.F.
         IF MENU_P=4
            IF PERGUNTA("Confirma a exclus„o dos registros marcados ?","N")="N"
               LOOP
            ELSE
               CLOSE DATABASES
               MENSAGEM("Compactando o arquivo ICMS.DBF")
               IF USEREDE("ICMS",.T.,10)
                  PACK
               ELSE
                  BEEP()
                  MENSAGEM("O arquivo ICMS n„o esta dispon¡vel",3)
               ENDIF
               MENSAGEM("Compactando o arquivo PRECO.DBF")
               IF USEREDE("PRECO",.T.,10)
                  PACK
               ELSE
                  BEEP()
                  MENSAGEM("O arquivo PRECO n„o esta dispon¡vel",3)
               ENDIF
               MENSAGEM("Compactando o arquivo LISTA.DBF")
               IF USEREDE("LISTA",.T.,10)
                  PACK
               ELSE
                  BEEP()
                  MENSAGEM("O arquivo LISTA n„o esta dispon¡vel",3)
               ENDIF
               MENSAGEM("Compactando o arquivo HEPPYDAY.DBF")
               IF USEREDE("HEPPYDAY",.T.,10)
                  PACK
               ELSE
                  BEEP()
                  MENSAGEM("O arquivo HEPPYDAY n„o esta dispon¡vel",3)
               ENDIF
               MENSAGEM("Compactando o arquivo FOLHA_PA.DBF")
               IF USEREDE("FOLHA_PA",.T.,10)
                  PACK
               ELSE
                  BEEP()
                  MENSAGEM("O arquivo FOLHA_PA n„o esta dispon¡vel",3)
               ENDIF
               MENSAGEM("Compactando o arquivo REPRESET.DBF")
               IF USEREDE("REPRESET",.T.,10)
                  PACK
               ELSE
                  BEEP()
                  MENSAGEM("O arquivo REPRESET n„o esta dispon¡vel",3)
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
      DO UTILREL
   ELSEIF MENU_P=6
      MENSAGEM("Tecle <ESC> para sair")
      DECLARE ME_NU[5]
      ME_NU[1]="Reorganizar"
      ME_NU[2]="-"
      ME_NU[3]=">Papel de parede"
      ME_NU[4]=">Configura‡„o de cores"
      ME_NU[5]="Configura‡„o padr„o"
      **
      ** Bloco de inser‡„o MENU.B05
      **
      MENU_S=MENU()
      IF MENU_S=1
         IF PERGUNTA("Comfirma a reorganiza‡„o dos arquivos ?")="S"
            MENSAGEM("Aguarde organiza‡„o dos arquivos")
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
      ELSEIF MENU_S=3
         FUNDO(1)
      ELSEIF MENU_S=4
         CONFCOR()
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
VAR=""
FOR F=1 TO 12
   VAR=VAR+CONTECOR[F]
NEXT
VAR=VAR+STR(MOVCAL_X,2)
VAR=VAR+STR(MOVCAL_Y,2)
VAR=VAR+"FF  "
VAR=VAR+STR(FUNDO,2)
VAR=VAR+"A"
VAR=VAR+CONTECOR[13]
MEMOWRIT("UTIL.CFG",VAR)
*
SAIDA()
* Localizacao - > C:\Mirro\Menu.B06
*
FUNCTION SAIDA
*
SET COLO TO W
@ 00,00 CLEAR TO 24,80
@ 11,10 SAY "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ-" COLOR "R/n"
@ 12,10 SAY "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ-" COLOR "R/n"
@ 13,10 SAY "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ" COLOR "r/n"
@ 14,10 SAY "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ-" COLOR "r/n"
@ 15,10 SAY "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ-" COLOR "r/n"
@ 16,10 SAY "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ-" COLOR "R/n"
@ 17,10 SAY "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ-" COLOR "R/n"
@ 18,10 SAY "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ-" COLOR "R/n"
*
@ 13,15 SAY " ÛÜ   ÜÛ " COLOR "B+/n"
@ 14,15 SAY " Û ßÜß Û " COLOR "B+/n"
@ 15,15 SAY " Û     Û " COLOR "BG/n"
@ 16,15 SAY " ß     ß " COLOR "BG+/n"
TONE(800.8)
@ 13,15 Say " ÛÜ   ÜÛ ÛÜ   ÜÛ" COLOR "B+/n"
@ 14,15 SAY " Û ßÜß Û Û ßÜß Û" COLOR "B+/n"
@ 15,15 SAY " Û     Û Û     Û" COLOR "BG/n"
@ 16,15 SAY " ß     ß ß     ß" COLOR "Bg+/n"
TONE(800.8)
@ 13,15 Say " ÛÜ   ÜÛ ÛÜ   ÜÛ ÛßßßßßÛ" COLOR "B/n"
@ 14,15 SAY " Û ßÜß Û Û ßÜß Û ÛÜÜÜÜÜÜ" COLOR "B+/n"
@ 15,15 SAY " Û     Û Û     Û Ü     Û" COLOR "BG/n"
@ 16,15 SAY " ß     ß ß     ß ßßßßßßß" COLOR "Bg+/n"
TONE(800.8)
@ 13,15 Say " ÛÜ   ÜÛ ÛÜ   ÜÛ ÛßßßßßÛ  Ü " COLOR "B/n"
@ 14,15 SAY " Û ßÜß Û Û ßÜß Û ÛÜÜÜÜÜÜ ßÛß" COLOR "B+/n"
@ 15,15 SAY " Û     Û Û     Û Ü     Û  Û " COLOR "BG/n"
@ 16,15 SAY " ß     ß ß     ß ßßßßßßß  ßß" COLOR "BG+/n"
TONE(800.8)
@ 13,15 Say " ÛÜ   ÜÛ ÛÜ   ÜÛ ÛßßßßßÛ  Ü  INFORMA" COLOR "B/n"
@ 14,15 SAY " Û ßÜß Û Û ßÜß Û ÛÜÜÜÜÜÜ ßÛß ÛßßßßßÛ" COLOR "B+/n"
@ 15,15 SAY " Û     Û Û     Û Ü     Û  Û  Ûßßßßßß" COLOR "BG/n"
@ 16,15 SAY " ß     ß ß     ß ßßßßßßß  ßß ßßßßßßß" COLOR "BG+/n"
TONE(800.8)
@ 13,15 Say " ÛÜ   ÜÛ ÛÜ   ÜÛ ÛßßßßßÛ  Ü  INFORMATICA LTDA (R)" COLOR "B/N"
@ 14,15 SAY " Û ßÜß Û Û ßÜß Û ÛÜÜÜÜÜÜ ßÛß ÛßßßßßÛ ÛßßßßßßÛ " COLOR "B+/N"
@ 15,15 SAY " Û     Û Û     Û Ü     Û  Û  Ûßßßßßß Û      Ü" COLOR "BG/N"
@ 16,15 SAY " Û     Û Û     Û ßßßßßßß  ßß ßßßßßßß ßßßßßßßß " COLOR "BG+/N"
@ 17,15 SAY " ß     ßßß     ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß " COLOR "W/N"

     SETCOLOR ("Rg+/R")
          @ 04,09 CLEAR TO 09,69
          @ 04,09,09,69 BOX "ÛÛÛÛÛÜÛÛ" COLOR ("W+/R")
          @ 06,20 SAY "   M.M.S.tec PassWord(r) Vers„o 1.0    "
          @ 07,20 SAY "(C) Copyright by Marcos Morais de Sousa"

INKEY(1)
CLS
SET COLOR TO W
SET CURSOR OFF
@ 00,00 CLEAR TO 24,80
  SETCOLOR("W+/b")
  @ 06,22,18,62 BOX("ÛÛÛÛÛÛÛÛÛ") COLOR ("N/N")
  @ 05,19,18,60 BOX("ÜÜÜÛßßßÛÛ") COLOR ("B+/n")
  @ 05,18,18,61 BOX"ÛÛÛÛßßßÛ" COLOR "W+/n"
  @ 05,18 SAY PADC("MMS-Login Utilit rio",44) COLOR "B/W"
  @ 06,19 SAY PADC("------ vers„o 3.1 -------",42) COLOR "W+/B"
  @ 10,21 SAY PADC("Uma produ‡„o de:",38) COLOR "W/B"
  @ 11,21 Say PADC("Marcos Morais de Sousa",38) COLOR "G+/B"
  @ 09,21 to 15,58 color ("B+/B")
  @ 12,21 Say PADC("è MMS.tec - 1996-1997 è ",38) COLOR "B/BG"
  @ 13,21 Say PADC("Artes Gr ficas & Inform tica.",38) COLOR "B/BG"
  @ 14,21 Say PADC("Fone:(073)525-5932",38) COLOR "B/BG"
  @ 15,21 Say PADC("è  Copyright(R) 1996  è",38) COLOR "B/BG"
  @ 16,21 Say PADC(" ",38) COLOR "B/BG"
  @ 22,00 SAY PADL("< LENDO >",78) COLOR "R+*/n"
  @ 22,65 SAY chr(2) color ("RG+/N")
  @ 21,65 to 23,80   color ("N+/N")
  INKEY(2)
  SET COLOR TO W+

LICENSA_A1="Propriedade exclusiva de "
@ 03,01 SAY PADC(LICENSA_A1,80) COLOR ("W/N")
LICENSA_A2="Marcos Morais de Sousa."
@ 04,01 SAY PADC(LICENSA_A2,80) COLOR ("BG+/N")

LICENSA_B="Uso licenciado para:"
@ 23,01 SAY PADC(LICENSA_B,80) COLOR ("w/N")
LICENSA_C=TITU_LO
@ 24,01 SAY PADC(LICENSA_C,80) COLOR ("bg+/N")
SET COLOR TO W
          TONE(550,4)
          TONE(850,8)
INKEY(2)
CLS
Aviso_A="Licen‡a concedida a:"
@ 15,02 SAY PADC(AVISO_A,80) COLOR ("W/N")
@ 16,02 SAY"                      Barreto Material de Construcao Ltda.                   " COLOR "B+/N"
@ 17,02 SAY"             C.G.C. 34.196.147/000-18 - Insc. Estadual 28.956.505            " COLOR "B+/N"

*@ 01,02 say"MMS-Livro de Preco (C)1996 vers„o 3.0 " Color("bg/N")
*@ 01,02 say"MMS-Consulta Cheques (C)1996 vers„o 2.0 " Color("bg/N")
*@ 01,02 say"MMS-Movimento Cimento(C)1996 vers„o 1.0 " Color("G+/N")

SET CURSOR OFF
CLS
@ 16,02 SAY"                      Barreto Material de Construcao Ltda.                   " COLOR "W+/N"
@ 17,02 SAY"           C.G.C. 34.196.147/000-18 - Insc. Estadual 28.956.505-NO         " COLOR "W+/N"

inkey(.1)
@ 03,02 say"ÜÜÜÜÜÜ/                ÜÜÜÜÜÜ/ ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ/ ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ/    " Color("Bg+/N")
inkey(.1)
@ 04,02 say"ÜÜÜÜÜÜÜ/              ÜÜÜÜÜÜÜ/ ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ/ ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ/  " Color("bg+/N")
inkey(.1)
@ 05,02 say" ÜÜÜÜÜÜÜ/            ÜÜÜÜÜÜÜ/   ÜÜÜÜ/         ÜÜÜÜ/  ÜÜÜÜÜ/          ÜÜÜÜÜÜÜ/ " Color("bg+/N")
inkey(.1)
@ 06,02 say" ÜÜÜÜÜÜÜÜ/          ÜÜÜÜÜÜÜÜ/   ÜÜÜÜ/   ÜÜÜÜ/        ÜÜÜÜÜ/           ÜÜÜÜÜÜÜ/ " Color("bg+/N")
inkey(.1)
@ 07,02 say" ÜÜÜÜ/ÜÜÜÜ/        ÜÜÜÜ/ÜÜÜÜ/   ÜÜÜÜÜÜÜÜÜÜÜÜ/        ÜÜÜÜÜ/          ÜÜÜÜÜÜÜ/  " Color("bg+/N")
inkey(.1)
@ 08,02 say" ÜÜÜÜ/ ÜÜÜÜ/      ÜÜÜÜ/ ÜÜÜÜ/   ÜÜÜÜÜÜÜÜÜÜÜÜ/        ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ/   " Color("bg+/N")
inkey(.1)
@ 09,02 say" ÜÜÜÜ/  ÜÜÜÜ/    ÜÜÜÜ/  ÜÜÜÜ/   ÜÜÜÜ/   ÜÜÜÜ/        ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ/   " Color("bg+/N")
inkey(.1)
@ 10,02 say" ÜÜÜÜ/   ÜÜÜÜ/  ÜÜÜÜ/   ÜÜÜÜ/   ÜÜÜÜ/                ÜÜÜÜÜ/          ÜÜÜÜÜÜÜ/  "Color("bg+/N")
inkey(.1)
@ 11,02 say" ÜÜÜÜ/    ÜÜÜÜ/ÜÜÜÜ/    ÜÜÜÜ/   ÜÜÜÜ/                ÜÜÜÜÜ/            ÜÜÜÜÜÜ/ "Color("bg+/N")
inkey(.1)
@ 12,02 say" ÜÜÜÜ/     ÜÜÜÜÜÜÜ/     ÜÜÜÜ/   ÜÜÜÜ/                ÜÜÜÜÜ/          ÜÜÜÜÜÜÜ/  "Color("bg+/N")
inkey(.1)
@ 13,02 say"ÜÜÜÜÜÜ/     ÜÜÜÜÜ/     ÜÜÜÜÜÜ/ ÜÜÜÜÜÜ/              ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ/   "Color("bg+/N")
inkey(.1)
@ 14,02 say"ÜÜÜÜÜÜ/      ÜÜÜ/      ÜÜÜÜÜÜ/ ÜÜÜÜÜÜ/              ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ/     "Color("bg+/N")
inkey(.1)
@ 20,02 say"                                                                               "Color("b+/N")
SETCOLOR ("R+/R")
@ 19,10 CLEAR TO 21,70
@ 19,10 TO 21,70
@ 20,14 SAY "(R) M.M.S.tec - Artes Gr ficas & Inform tica Ltda.     " COLOR ("W/R")
SET COLOR TO W
          TONE(550,4)
          TONE(850,8)
SETCOLOR ("G+/G")
@ 00,01 CLEAR TO 02,35
@ 00,01 TO 02,35 DOUBLE
@ 01,03 say"MMS-ContrCim (C)1996 vers„o 1.0" Color("W+/G")
@ 20,14 SAY "(R) M.M.S.tec - Sistema para Gerenciamento de Lojas     " COLOR ("W+/R")
INKEY(0)
LENTE()
?""
QUIT

 
     FUNCTION JANELA
     PARA PJAN1,PJAN2,PJAN3,PJAN4,PJAN5
     IF PCOUNT()<>5
        PJAN5=""
     ENDIF
     SOMBRA(PJAN1,PJAN2,PJAN3,PJAN4)
     SETCOLOR(CONTECOR[4])
     @ PJAN1,PJAN2 CLEAR TO PJAN3,PJAN4
     *COR("BOX DA JANELA DE DIALOGO")
     *@ PJAN1,PJAN2 TO PJAN3,PJAN4 DOUBLE
     SETCOLOR(CONTECOR[5])
     @ PJAN1,PJAN2 CLEAR TO PJAN1,PJAN4
     IF LEN(TRIM(PJAN5)) > 0
        @ PJAN1,PJAN2+(((PJAN4+1-PJAN2)-LEN(PJAN5))/2) SAY PJAN5
     ENDIF
 
FUNCTION AMBIENTE
SET TALK OFF
SET DATE BRIT
SET BELL OFF
SET STAT OFF
SET SCORE OFF
SET WRAP ON
SET CURSOR OFF
SET DELETED ON
SETCANCEL(.f.)               // desativa ALT-C/BREAK
*SET EPOCH TO 1960            // prepara datas para o terceiro milˆnio
*
* -> Ativa a demostracao das horas na tecla F8
SET KEY -7 TO RELOGIO
*
* -> Ativa a demostracao das horas na tecla F9
SET KEY -8 TO BOM_DIA
*
* -> Ativa a demostracao das horas na tecla F10
SET KEY -9 TO MUSICA
*
* -> Ativa a demostracao das horas na tecla F11
SET KEY -40 TO MMS_EDITOR
*
* -> Ativa a dESCANSO DE TELA NA TECLA  F12
SET KEY -41 TO DESCANSO_MMS
RETURN .F.

FUNCTION PADRAO
CONTECOR[01]="09/01"
CONTECOR[02]="00/07"
CONTECOR[03]="15/03"
CONTECOR[04]="07/01"
CONTECOR[05]="04/07"
CONTECOR[06]="07/04"
CONTECOR[07]="14/04"
CONTECOR[08]="07/01"
CONTECOR[09]="15/00"
CONTECOR[10]="15/01"
CONTECOR[11]="07/01"
CONTECOR[12]="07/01"
CONTECOR[13]="14/03"
RETURN .T.

FUNCTION PERG
COR("MENU")
SET CURSOR OFF
M->RES_POSTA="S"
PARA TEX_TO,RES_POSTA
M->SIM_NAO=IIF(M->RES_POSTA="N",2,1)
@ 24,11 SAY SPACE(58)
M->LI=(80-(LEN(M->TEX_TO)+11))/2
@ 24,M->LI SAY M->TEX_TO
M->LI=M->LI+LEN(M->TEX_TO)+2
DO WHILE .T.
   @ 24,M->LI   PROMPT "Sim"
   @ 24,M->LI+6 PROMPT "N„o"
   @ 24,M->LI+4 SAY "-"
   MENU TO M->SIM_NAO
   IF M->SIM_NAO<>0
      EXIT
   ENDIF
ENDDO
ON_CURSOR()
RETURN IIF(M->SIM_NAO=1,"S","N")
 
* Final do programa UTIL.PRG