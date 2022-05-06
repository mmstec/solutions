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

