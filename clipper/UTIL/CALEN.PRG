* -> calend†rio
SET EXCLUSIVE OFF
DECLARE BOTOES[10]
Q_BOTOES=1
MENU_P=1
X=1
C_SOM=""
L_SOM=""
M->DAT_HOJE=DATE()
M->SOS_MENU=" "
M->CALEN_X=ROW()
M->CALEN_Y=COL()
M->CLEN_COR=SETCOLOR()
SET CURSOR OFF
SET DATE BRIT
SET CENTURY ON
M->CA_MES=MONTH(M->DAT_HOJE)
M->CA_ANO=YEAR(M->DAT_HOJE)
M->CA_DATA=CTOD("01/"+STR(M->CA_MES,2)+"/"+STR(M->CA_ANO,4))
L_CALEN=L_SOM
C_CALEN=C_SOM
*sombra(L_SOM,C_SOM,.T.)
M->CA_TELA1=SAVESCREEN(03,11,22,66)
@ 04,13,21,66 BOX "€€€€€€€€€€" color "BG+/BG"
*sombra(04,13,21,66)
@ 04,13 to 21,66   color "R+/BG"
BOTAO(10,53," [+] Màs  ",1)
BOTAO(12,53," [-] Màs  ",2)
BOTAO(14,53," [+] Ano  ",3)
BOTAO(16,53," [-] Ano  ",4)
BOTAO(18,53,"    Ano   ",5)

M->OPC_BOT=1
M->SOS_MENU="CALENDARIO"
DO WHILE .T.
   SETCOLOR("W+/W")
   @ 06,15 SAY "  Dom  Seg  Ter  Qua  Qui  Sex  Sab " COLOR("W+/N")
   SETCOLOR(SUBS(SETCOLOR("W+/W"),4,2)+"/"+SUBS(SETCOLOR("W+/W"),4,2))
   FOR F_CALEN=8 TO 18 STEP 2
      @ 07,15 SAY "ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ" COLOR("BG+/BG")
      @ F_CALEN+0,15 SAY " €€€€ €€€€ €€€€ €€€€ €€€€ €€€€ €€€€ " COLOR("N/BG")
      @ F_CALEN+1,15 SAY " ﬂﬂﬂﬂ ﬂﬂﬂﬂ ﬂﬂﬂﬂ ﬂﬂﬂﬂ ﬂﬂﬂﬂ ﬂﬂﬂﬂ ﬂﬂﬂﬂ " COLOR("N/BG")
   NEXT
   IF AT(SUBS(STR(M->CA_MES+100,3),2),"01 03 05 07 08 10 12")<>0
      M->ULT_DIA = 31
   ELSE
      M->ULT_DIA=IIF(M->CA_MES#2,30,IIF(MOD(M->CA_ANO,4)=0,29,28))
   ENDIF
   M->X_X=DOW(M->CA_DATA)
   M->Y_Y=8
   SETCOLOR("W+/N")
   FOR F_CALEN=1 TO M->ULT_DIA
       IF  M->X_X=1
           @ M->Y_Y,(M->X_X*5)+13 SAY STR(F_CALEN,2) COLOR("R+/N")
       ELSE
           @ M->Y_Y,(M->X_X*5)+13 SAY STR(F_CALEN,2) COLOR("W+/N")
       ENDIF
       IF  STR(F_CALEN,2)=STR(DAY(DATE()),2)
         @ M->Y_Y,(M->X_X*5)+13 SAY STR(F_CALEN,2) COLOR("RG+*/N")
       ENDIF
      M->X_X=M->X_X+1
      IF M->X_X>7
         M->X_X=1
         M->Y_Y=M->Y_Y+2
      ENDIF
   NEXT
   SETCOLOR("BG+/N")
   @ 06,53 CLEAR TO 08,63
   @ 06,52 TO 08,63
   @ 06,52 CLEAR TO 06,63
   @ 06,53 SAY SUBS(" Janeiro  Fevereiro   Maráo     Abril      Maio     Junho     Julho     Agosto   Setembro  Outubro   Novembro  Dezembro ",MONTH(M->CA_DATA)*10-9,10)   COLOR("R+/N")
   @ 07,55 SAY TRAN(YEAR(M->CA_DATA),"@E 9999")                                    COLOR("RG+/N")
   M->OPC_BOT=BOTAO(M->OPC_BOT)
   IF M->OPC_BOT=0
      EXIT
   ELSEIF M->OPC_BOT=5
      SETCOLOR("W/N")
      @ 07,54 SAY CHR(26)
      *M->CA_TEMP=CTOD("  /  /  ")
      M->CA_TEMP=""
      M->TECLA=0
      SET CURSOR ON
      DO WHILE M->TECLA<>13 .AND. M->TECLA<>27
         IF AT(CHR(M->TECLA),"0123456789")<>0
            M->CA_TEMP=M->CA_TEMP+CHR(M->TECLA)
            IF LEN(M->CA_TEMP)=4
               EXIT
            ENDIF
         ENDIF
         IF (M->TECLA=19 .OR. M->TECLA=8) .AND. LEN(M->CA_TEMP)>0
            M->CA_TEMP=SUBS(M->CA_TEMP,1,LEN(M->CA_TEMP)-1)
         ENDIF
         ***
         @ 07,55 SAY "     "
         IF LEN(M->CA_TEMP)=0
            @ 07,56 SAY ""
         ELSE
            @ 07,56 SAY SUBS(M->CA_TEMP,1,4)
         ENDIF
         M->TECLA=INKEY(0)
      ENDDO
      SET CURSOR OFF
      M->CA_ANO=VAL(M->CA_TEMP)
      @ 07,54 SAY " "
   ENDIF
   M->CA_ANO=M->CA_ANO+IIF(M->OPC_BOT=4,-1,IIF(M->OPC_BOT=3,1,0))
   M->CA_ANO=IIF(M->CA_ANO<100,100,IIF(M->CA_ANO>2999,2999,M->CA_ANO))
   M->CA_MES=M->CA_MES+IIF(M->OPC_BOT=2,-1,IIF(M->OPC_BOT=1,1,0))
   M->CA_MES=IIF(M->CA_MES<1,12,IIF(M->CA_MES>12,1,M->CA_MES))
   M->CA_DATA=CTOD("01/"+STR(M->CA_MES,2)+"/"+STR(M->CA_ANO,4))
ENDDO
M->SOS_MENU=""
RESTSCREEN(03,11,22,66,M->CA_TELA1)
*sombra(L_CALEN,C_CALEN)
SETCOLOR(M->CLEN_COR)
*
SET CENTURY OFF
@ M->CALEN_X,M->CALEN_Y SAY ""


FUNCTION BOTAO
*
*
PARA LIN_BOT,COL_BOT,NOM_BOT,NUM_BOT
IF PCOUNT()=0
   NUM_BOT=0
ENDIF
IF PCOUNT()=3
   NUM_BOT=-1
ENDIF
IF PCOUNT()=4
   IF NUM_BOT<1
      Q_BOTOES=1
   ELSE
      Q_BOTOES=NUM_BOT
   ENDIF
  BOTOES[Q_BOTOES]=STR(COL_BOT,3)+STR(LIN_BOT,3)+NOM_BOT
ENDIF
IF PCOUNT()=1
   X_BOT=LIN_BOT
   NUM_BOT=0
ELSE
   X_BOT=1
ENDIF
IF NUM_BOT>0 .OR. NUM_BOT=-1
   SETCOLOR("R+/R")
   @ LIN_BOT,COL_BOT SAY SPACE(11)
   @ LIN_BOT,COL_BOT+1 SAY NOM_BOT
   @ LIN_BOT,COL_BOT-1 SAY " ‹"                COLOR("n+/bG")
   @ LIN_BOT+1,COL_BOT-1 SAY " ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ "    COLOR("n+/bG")
ELSE
   TECLA=0
   DO WHILE .T.
      COL_BOT=VAL(SUBS(BOTOES[X_BOT],1,3))
      LIN_BOT=VAL(SUBS(BOTOES[X_BOT],4,3))
      NOM_BOT=SUBS(BOTOES[X_BOT],7)
      SETCOLOR("W+/R")
      Tone(500,1)
      @ LIN_BOT,COL_BOT SAY SPACE(11)
      @ LIN_BOT,COL_BOT+1 SAY NOM_BOT
      @ LIN_BOT,COL_BOT-1 SAY " ‹"                  COLOR("N+/BG")
      @ LIN_BOT+1,COL_BOT-1 SAY " ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ "      COLOR("N+/BG")
      IF TECLA=13
         Tone(800,2)
         INKEY(.2)
         RETURN X_BOT
      ENDIF
      IF NUM_BOT=-2
         TECLA=13
      ELSE
         TECLA=INKEY(0)
      ENDIF
      IF TECLA=27
          TONE(500,2)
         RETURN 0
      ENDIF
      *IF TECLA=28
      *   TONE(300,2)
      *   HELP()
      * ENDIF
      *IF TECLA=(-1)
      *   TONE(300,2)
      *   ALERT("CONCEPCAO DE MARCOS MORAIS DE SOUSA")
      *ENDIF
      SETCOLOR("R+/R")
      @ LIN_BOT,COL_BOT+1 SAY NOM_BOT
      FOR F_BOT=1 TO Q_BOTOES
         IF SUBS(BOTOES[F_BOT],7,1)=UPPER(CHR(TECLA))
            X_BOT=F_BOT
            TECLA=13
            COL_BOT=VAL(SUBS(BOTOES[X_BOT],1,3))
            LIN_BOT=VAL(SUBS(BOTOES[X_BOT],4,3))
            NOM_BOT=SUBS(BOTOES[X_BOT],7)
            EXIT
         ENDIF
      NEXT
      IF TECLA=13
         SETCOLOR("BG/BG")
         @ LIN_BOT,COL_BOT SAY "€"
         @ LIN_BOT+1,COL_BOT-1 SAY "€€€€€€€€€€€€"
         @ LIN_BOT,COL_BOT+10 SAY "€"
         SETCOLOR("W+/R")
         @ LIN_BOT,COL_BOT-1 SAY " "+NOM_BOT+" "
         INKEY(.2)
         LOOP
      ENDIF
      IF TECLA=19 .OR. TECLA=5
         X_BOT=X_BOT-1
      ELSEIF TECLA=4 .OR. TECLA=24
         X_BOT=X_BOT+1
      ENDIF
      X_BOT=IIF(X_BOT<1,Q_BOTOES,IIF(X_BOT>Q_BOTOES,1,X_BOT))
   ENDDO
ENDIF
*
* ////////////////////////////////////////////////////////////////////*
