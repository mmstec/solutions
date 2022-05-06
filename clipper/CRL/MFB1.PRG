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
CONTADOR=0
EMPRESA="Barreto Material de Construcao Ltda."
CGC="C.G.C. 34.196.147/000-18 - Insc. Estadual 28.956.505-NO"

DO WHILE.T.
set color to BG+/N
@ 03,00 say LA
@ 04,00 say LB
@ 05,00 say LC
@ 06,00 say LD
@ 07,00 say LE
@ 08,00 say LF
@ 09,00 say LG
@ 10,00 say LH
@ 11,00 say LI
@ 12,00 say LJ
@ 13,00 say LL
@ 14,00 say LM
     
     IF LASTKEY()>1
          EXIT
     ENDIF
SET CURSOR OFF
SET COLOR TO BG+/N
FOR CONTADOR=0 TO 82 step +2
     IF LASTKEY()>1
          EXIT
     ENDIF
     @ 03,80-(CONTADOR*2) say SPACE(CONTADOR)
     @ 04,00+CONTADOR say SPACE(CONTADOR)
     @ 05,80-(CONTADOR*2) say SPACE(CONTADOR)
     @ 06,00+CONTADOR say SPACE(CONTADOR)
     @ 07,80-(CONTADOR*2) say SPACE(CONTADOR)
     @ 08,00+CONTADOR say SPACE(CONTADOR)
     @ 09,80-(CONTADOR*2) say SPACE(CONTADOR)
     @ 10,00+CONTADOR say SPACE(CONTADOR)
     @ 11,80-(CONTADOR*2) say SPACE(CONTADOR)
     @ 12,00+CONTADOR say SPACE(CONTADOR)
     @ 13,80-(CONTADOR*2) say SPACE(CONTADOR)
     @ 14,00+CONTADOR say SPACE(CONTADOR)
     INKEY(0.01)                   
NEXT

FOR CONTADOR=0 TO LEN(LA) step +3
     IF LASTKEY()>1
          EXIT
     ENDIF
     SETCOLOR(CONTADOR+LEN(LA))
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
SET CURSOR OFF
@ 16,00 SAY PADC(EMPRESA,80) COLOR ("W+/N")
@ 17,00 SAY PADC(CGC,80)     COLOR ("G+/N")
ENDDO
@ 03,00 say LA
@ 04,00 say LB
@ 05,00 say LC
@ 06,00 say LD
@ 07,00 say LE
@ 08,00 say LF
@ 09,00 say LG
@ 10,00 say LH
@ 11,00 say LI
@ 12,00 say LJ
@ 13,00 say LL
@ 14,00 say LM
SETCOLOR ("R+/R")
@ 19,10 CLEAR TO 21,70
@ 19,10 TO 21,70
@ 20,14 SAY "(R) M.M.S.tec - Artes Gr ficas & Inform tica Ltda.     " COLOR ("W/R")
SET COLOR TO W
TONE(550,4)
TONE(850,8)
*
@ 00,01 SAY REPL(CHR(4),60) COLOR("N+/N")
FOR SAI=01 to 60
     SET CURSOR OFF
     IF LASTKEY()=27
        SETCOLOR("RG+/N")
        EXIT
     ENDIF
INKEY(1)
@ 00,SAI SAY CHR(4)  COLOR("RG+/N")
@ 00,61  SAY SAI     COLOR("G+/N")
@ 00,71  SAY         " Segundos"
NEXT
*
@ 24,00
QUIT
