***
*** Inicio do bloco de substitui‡„o ACESSO.B
*
* -> Rotina de senha para acesso
set cursor off
set color to w/n
cls
*
do while.t.
a=00
l=00
c=00
**
**
For a=80 to -00 step -2
inkey(.1)
@ 00,78 say a color "G+/n"
setcolor ("BG+/N")
@ 03,C+a say" ÜÜÜÜÜÜ/                ÜÜÜÜÜÜ/ ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ/ ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ/     "
@ 04,C+a say" ÜÜÜÜÜÜÜ/              ÜÜÜÜÜÜÜ/ ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ/ ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ/   "
@ 05,C+a say"  ÜÜÜÜÜÜÜ/            ÜÜÜÜÜÜÜ/   ÜÜÜÜ/         ÜÜÜÜ/  ÜÜÜÜÜ/          ÜÜÜÜÜÜÜ/  "
@ 06,C+a say"  ÜÜÜÜÜÜÜÜ/          ÜÜÜÜÜÜÜÜ/   ÜÜÜÜ/   ÜÜÜÜ/        ÜÜÜÜÜ/           ÜÜÜÜÜÜÜ  "
@ 07,C+a say"  ÜÜÜÜ/ÜÜÜÜ/        ÜÜÜÜ/ÜÜÜÜ/   ÜÜÜÜÜÜÜÜÜÜÜÜ/        ÜÜÜÜÜ/          ÜÜÜÜÜÜÜ/  "
@ 08,C+a say"  ÜÜÜÜ/ ÜÜÜÜ/      ÜÜÜÜ/ ÜÜÜÜ/   ÜÜÜÜÜÜÜÜÜÜÜÜ/        ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ/   "
@ 09,C+a say"  ÜÜÜÜ/  ÜÜÜÜ/    ÜÜÜÜ/  ÜÜÜÜ/   ÜÜÜÜ/   ÜÜÜÜ/        ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ/   "
@ 10,C+a say"  ÜÜÜÜ/   ÜÜÜÜ/  ÜÜÜÜ/   ÜÜÜÜ/   ÜÜÜÜ/                ÜÜÜÜÜ/          ÜÜÜÜÜÜÜ/  "
@ 11,C+a say"  ÜÜÜÜ/    ÜÜÜÜ/ÜÜÜÜ/    ÜÜÜÜ/   ÜÜÜÜ/                ÜÜÜÜÜ/            ÜÜÜÜÜÜ  "
@ 12,C+a say"  ÜÜÜÜ/     ÜÜÜÜÜÜÜ/     ÜÜÜÜ/   ÜÜÜÜ/                ÜÜÜÜÜ/          ÜÜÜÜÜÜÜ/  "
@ 13,C+a say" ÜÜÜÜÜÜ/     ÜÜÜÜÜ/     ÜÜÜÜÜÜ/ ÜÜÜÜÜÜ/              ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ/   "
@ 14,C+a say" ÜÜÜÜÜÜ/      ÜÜÜ/      ÜÜÜÜÜÜ/ ÜÜÜÜÜÜ/              ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ/     "
*
@ 19,10,21,70 box "ÛÛÛÛÛÛÛÛÛÛ" color "b/N"
@ 19,10 to 21,70  color "b+/b"
@ 20,11 say padc(" Tecle qualquer tecla para prosseguir! ",59) color "W+/b"
*
@ 16,20 say padc(" MFB Materiais de Constru‡„o Ltda.! ",40) color "W+/n"
@ 17,20 say padc("Fonefax: (073)525-2344 - Jequie, Bahia",40) color "W/n"
*
@ 00,00 say Padc("MMStec (C) CopyRight - 1996/1997",80) COLOR ("G+/N")
@ 01,00 say Padc("Artes Graficas & Inform tica",80) COLOR ("w+/N")
next
**************
if lastkey()>1
     SET COLOR TO W
     exit
     endif
enddo
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
          @ 23,01 say REPL(chr(7),78) COLOR("N/"+ALLTRIM(SUBS(CONTECOR[13],4)))
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
     @ 23,01 say REPL(chr(7),78) COLOR("N/"+ALLTRIM(SUBS(CONTECOR[13],4)))
     MENSAGEM("Acesso n„o permitido",3)
   SET CURSOR ON
   SET COLOR TO w+/W
   @ 00,00 CLEAR TO 20,79
   ? REPL(" M.M.S.tec ",240)
   SETColor ("G+/G")
   @ 10,15 CLEAR TO 15,60
   @ 10,15 TO 15,60 DOUBLE
   SOMBRA(10,15,15,60)
   @ 12,20 say PADC("Sinto muito, acabaram-se as",40) Color "W+*/G"
   @ 13,20 say PADC("tentativas",40)                  Color "W+*/G"
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
