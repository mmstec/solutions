l=2
X=005
Y=(25*(-1))
*
* -> Fun‡„o que ativa a calculadora
*
C_SOM=""
L_SOM=""
MOVCAL_X=005
MOVCAL_y=(25*(-1))

M->CALCU_X=ROW()
M->CALCU_Y=COL()
M->CACU_COR=SETCOLOR()
L_CALCU=L_SOM
C_CALCU=C_SOM
*SOMBRA(L_SOM,C_SOM,.T.)
M->CA_TELA=SAVESCREEN(MOVCAL_X+0,MOVCAL_Y+47,MOVCAL_X+16,MOVCAL_Y+79)
SET CURSOR OFF
@ 00+MOVCAL_X,49+MOVCAL_Y,15+MOVCAL_X,79+MOVCAL_Y BOX ("ÛÛÛÛÛÛÛÛÛ") color "Bg+/BG" // Caixa da maquina
*SOMBRA(00+MOVCAL_X,49+MOVCAL_Y,15+MOVCAL_X,79+MOVCAL_Y)                            // SOMBRA da maquina
@ 05+MOVCAL_X,51+MOVCAL_Y,13+movcal_x,77+movcal_y BOX ("ÛÛÛÛÛÛÛÛÛ") color "Bg/BG"  // Caixa/fundo dos botoes
*
@ 00+MOVCAL_X,49+MOVCAL_Y to 15+MOVCAL_X,79+MOVCAL_Y color "R+/BG"
@ 02+MOVCAL_X,51+MOVCAL_Y,04+MOVCAL_X,77+MOVCAL_Y box("ÛÛÛÛÛÛÛÛÛ")color "N/G"   // Borda do visor
@ 02+MOVCAL_X,51+MOVCAL_Y,04+MOVCAL_X,77+MOVCAL_Y box("ÛßÛÛÛÜÛÛ")color "BG/n"   // Borda do visor
@ 05+MOVCAL_X,51+MOVCAL_Y,05+MOVCAL_X,77+MOVCAL_Y box("ßßßßßßßßß")color "BG+/BG"   // Borda do visor
*
BOTAO_CALC(06+MOVCAL_X,53+MOVCAL_Y," 7 ")
BOTAO_CALC(06+MOVCAL_X,58+MOVCAL_Y," 8 ")
BOTAO_CALC(06+MOVCAL_X,63+MOVCAL_Y," 9 ")
BOTAO_CALC(08+MOVCAL_X,53+MOVCAL_Y," 4 ")
BOTAO_CALC(08+MOVCAL_X,58+MOVCAL_Y," 5 ")
BOTAO_CALC(08+MOVCAL_X,63+MOVCAL_Y," 6 ")
BOTAO_CALC(10+MOVCAL_X,53+MOVCAL_Y," 1 ")
BOTAO_CALC(10+MOVCAL_X,58+MOVCAL_Y," 2 ")
BOTAO_CALC(10+MOVCAL_X,63+MOVCAL_Y," 3 ")
BOTAO_CALC(12+MOVCAL_X,53+MOVCAL_Y,"  0  ")
BOTAO_CALC(12+MOVCAL_X,61+MOVCAL_Y,"  .  ")
BOTAO_CALC(06+MOVCAL_X,MOVCAL_Y+69," - ")
BOTAO_CALC(12+MOVCAL_X,MOVCAL_Y+74," % ")
BOTAO_CALC(08+MOVCAL_X,MOVCAL_Y+69," + ")
BOTAO_CALC(08+MOVCAL_X,MOVCAL_Y+74," * ")
BOTAO_CALC(10+MOVCAL_X,MOVCAL_Y+74," / ")
BOTAO_CALC(10+MOVCAL_X,MOVCAL_Y+69," = ")
BOTAO_CALC(06+MOVCAL_X,MOVCAL_Y+74,"C/E")
M->C_RESULT=0
M->C_ALGA=SPACE(14)
M->C_DEC=""
M->C_DIG=CHR(0)
M->C_VAR="C_ALGA"
M->C_VERDAD=.F.
SET COLOR TO w+
@ 03+MOVCAL_X,54+MOVCAL_Y SAY " "+STR(M->C_RESULT,19,4)+" "
M->C_UOPER=""
M->C_PERC=" "
DO WHILE M->C_DIG<>CHR(27)
   M->C_DIG=CHR(INKEY(0))
   IF M->C_DIG="7" .OR. M->C_DIG=CHR(1)
      BOTAO(06+MOVCAL_X,53+MOVCAL_Y," 7 ",.T.)
   ELSEIF M->C_DIG="8" .OR. M->C_DIG=CHR(5)
      BOTAO(06+MOVCAL_X,58+MOVCAL_Y," 8 ",.T.)
   ELSEIF M->C_DIG="9" .OR. M->C_DIG=CHR(18)
      BOTAO(06+MOVCAL_X,63+MOVCAL_Y," 9 ",.T.)
   ELSEIF M->C_DIG="4" .OR. M->C_DIG=CHR(19)
      BOTAO(08+MOVCAL_X,53+MOVCAL_Y," 4 ",.T.)
   ELSEIF M->C_DIG="5" .OR. M->C_DIG=CHR(76)
      BOTAO(08+MOVCAL_X,58+MOVCAL_Y," 5 ",.T.)
   ELSEIF M->C_DIG="6" .OR. M->C_DIG=CHR(4)
      BOTAO(08+MOVCAL_X,63+MOVCAL_Y," 6 ",.T.)
   ELSEIF M->C_DIG="1" .OR. M->C_DIG=CHR(6)
      BOTAO(10+MOVCAL_X,53+MOVCAL_Y," 1 ",.T.)
   ELSEIF M->C_DIG="2" .OR. M->C_DIG=CHR(24)
      BOTAO(10+MOVCAL_X,58+MOVCAL_Y," 2 ",.T.)
   ELSEIF M->C_DIG="3" .OR. M->C_DIG=CHR(3)
      BOTAO(10+MOVCAL_X,63+MOVCAL_Y," 3 ",.T.)
   ELSEIF M->C_DIG="0" .OR. M->C_DIG=CHR(22)
      BOTAO(12+MOVCAL_X,53+MOVCAL_Y,"  0  ",.T.)
   ELSEIF M->C_DIG="." .OR. M->C_DIG=CHR(7)
      BOTAO(12+MOVCAL_X,61+MOVCAL_Y,"  .  ",.T.)
   ELSEIF M->C_DIG="-"
      BOTAO(06+MOVCAL_X,MOVCAL_Y+69," - ",.T.)
   ELSEIF M->C_DIG="%"
      BOTAO(12+MOVCAL_X,MOVCAL_Y+74," % ",.T.)
   ELSEIF M->C_DIG="+"
      BOTAO(08+MOVCAL_X,MOVCAL_Y+69," + ",.T.)
   ELSEIF M->C_DIG="*"
      BOTAO(08+MOVCAL_X,MOVCAL_Y+74," * ",.T.)
   ELSEIF M->C_DIG="/"
      BOTAO(10+MOVCAL_X,MOVCAL_Y+74," / ",.T.)
   ELSEIF M->C_DIG="=" .OR. ASC(M->C_DIG)=13
      BOTAO(10+MOVCAL_X,MOVCAL_Y+69," = ",.T.)
   ELSEIF AT(M->C_DIG,"cCeE")<>0
      BOTAO(06+MOVCAL_X,MOVCAL_Y+74,"C/E",.T.)
   ENDIF
   SET COLOR TO W+
   *
   IF AT(M->C_DIG,CHR(26)+CHR(2)+CHR(141)+CHR(145))<>0
      M->MOV_TELA=SAVESCREEN(MOVCAL_X+0,MOVCAL_Y+49,MOVCAL_X+15,MOVCAL_Y+79)
      RESTSCREEN(MOVCAL_X+0,MOVCAL_Y+47,MOVCAL_X+16,MOVCAL_Y+79,M->CA_TELA)
      IF M->C_DIG=CHR(26)
         MOVCAL_Y=MOVCAL_Y-1
      ELSEIF M->C_DIG=CHR(2)
         MOVCAL_Y=MOVCAL_Y+1
      ELSEIF M->C_DIG=CHR(141)
         MOVCAL_X=MOVCAL_X-1
      ELSEIF M->C_DIG=CHR(145)
         MOVCAL_X=MOVCAL_X+1
      ENDIF
      IF MOVCAL_X+0<0
         MOVCAL_X=0
      ELSEIF MOVCAL_X+17>24
         MOVCAL_X=24-17
      ELSEIF MOVCAL_Y+47<0
         MOVCAL_Y=-47
      ELSEIF MOVCAL_Y+79>79
         MOVCAL_Y=0
      ENDIF
      M->CA_TELA=SAVESCREEN(MOVCAL_X+0,MOVCAL_Y+47,MOVCAL_X+16,MOVCAL_Y+79)
      RESTSCREEN(MOVCAL_X+0,MOVCAL_Y+49,MOVCAL_X+15,MOVCAL_Y+79,M->MOV_TELA)
  ENDIF
  IF M->C_DIG=CHR(28)
     ALERT("Rotina indisponivel")
   ENDIF
   IF M->C_DIG=CHR(27)
      EXIT
   ENDIF
   M->C_XX=AT(M->C_DIG,CHR(22)+CHR(7)+CHR(6)+CHR(24)+CHR(3)+CHR(19)+CHR(76)+CHR(4)+CHR(1)+CHR(5)+CHR(18))
   IF M->C_XX<>0
      M->C_DIG=SUBS("0.123456789",M->C_XX,1)
   ENDIF
   M->C_VAR=IIF(M->C_DIG=".","M->C_DEC",M->C_VAR)
   M->C_ALGA=IIF(M->C_DIG="." .AND. M->C_ALGA=SPACE(14),SPACE(13)+"0",M->C_ALGA)
   IF M->C_DIG="%"
      IF M->C_VERDAD
         M->C_PERC=IIF(M->C_PERC="%"," ","%")
         @ 03+MOVCAL_X,75+MOVCAL_Y SAY M->C_PERC
         SET COLOR TO W+
      ELSE
         @ 03+MOVCAL_X,55+MOVCAL_Y SAY SPACE(13)+"0.0000" color ("W+*/N")
      ENDIF
   ELSEIF M->C_DIG $ "0123456789" .AND. LEN(LTRIM(&C_VAR))<>IIF(M->C_VAR="M->C_DEC",4,14)
      &C_VAR=IIF(M->C_VAR="M->C_DEC",&C_VAR+M->C_DIG,SUBS(&C_VAR+M->C_DIG,2))
      @ 03+MOVCAL_X,55+MOVCAL_Y SAY M->C_ALGA+"."+SUBS(M->C_DEC+SUBS("00000",LEN(M->C_DEC)+1),1,4)
      M->C_VERDAD=IIF(M->C_VERDAD .AND. M->C_UOPER $ "="+CHR(13),.F.,M->C_VERDAD)
   ELSEIF M->C_DIG $ "+-/*="+CHR(13)
      IF M->C_VERDAD
         IF VAL(M->C_ALGA+"."+M->C_DEC)<>0
            IF M->C_PERC="%"
               M->OPE_RA=STR(M->C_RESULT,19,4)+M->C_UOPER+"("+STR(M->C_RESULT,19,4)+"*"+M->C_ALGA+"."+SUBS(M->C_DEC+SUBS("00000",LEN(M->C_DEC)+1),1,4)+")/100.000"
            ELSE
               M->OPE_RA=STR(M->C_RESULT,19,4)+M->C_UOPER+M->C_ALGA+"."+SUBS(M->C_DEC+SUBS("00000",LEN(M->C_DEC)+1),1,4)
            ENDIF
            M->C_RESULT=&OPE_RA
            IF STR(M->C_RESULT,19,4)=REPL("*",19)
               @ 03+MOVCAL_X,55+MOVCAL_Y SAY "* * * E R R O * * *" color ("R+*/N")
               M->C_RESULT=0
               @ 03+MOVCAL_X,53+MOVCAL_Y SAY " "
               @ 03+MOVCAL_X,75+MOVCAL_Y SAY " "
               set color to W+
            ELSE
               @ 03+MOVCAL_X,55+MOVCAL_Y SAY STR(M->C_RESULT,19,4)
            ENDIF
         ENDIF
      ELSEIF M->C_DIG $ "+-/*"
         M->C_VERDAD=.T.
         M->C_RESULT=VAL(M->C_ALGA+"."+M->C_DEC)
      ENDIF
      IF M->C_DIG $ "+-/*="
         L=L+1
      ENDIF
      @ 03+MOVCAL_X,53+MOVCAL_Y SAY IIF(M->C_DIG $ "+-/*=",M->C_DIG," ")
      @ 03+MOVCAL_X,75+MOVCAL_Y SAY " "
      SET COLOR TO W+
      M->C_VAR="M->C_ALGA"
      M->C_ALGA=SPACE(14)
      M->C_DEC=""
      M->C_UOPER=M->C_DIG
      M->C_PERC=" "
   ELSEIF M->C_DIG $ "EeCc"
      M->C_VAR="M->C_ALGA"
      M->C_ALGA=SPACE(14)
      M->C_DEC=""
      M->C_PERC=" "
      IF M->C_DIG $ "Cc"
         M->C_VERDAD=.F.
         @ 03+MOVCAL_X,53+MOVCAL_Y SAY " "
         @ 03+MOVCAL_X,75+MOVCAL_Y SAY " "
         SET COLOR TO w+
      ENDIF
      @ 03+MOVCAL_X,55+MOVCAL_Y SAY SPACE(13)+"0.0000" color ("W+*/N")
   ENDIF
ENDDO
SETCOLOR(M->CACU_COR)
RESTSCREEN(0+MOVCAL_X,47+MOVCAL_Y,16+MOVCAL_X,79+MOVCAL_Y,M->CA_TELA)
@ M->CALCU_X,M->CALCU_Y SAY ""
RETURN

FUNCTIO BOTAO
PARA BOT_X,BOT_Y,BOT_N
IF PCOUNT()=4
   IF BOT_N=" = "
      SETCOLOR("rg+/Bg")
      @ BOT_X+0,BOT_Y+2 SAY " "
      @ BOT_X+1,BOT_Y+2 SAY " "
      @ BOT_X+2,BOT_Y+2 SAY " "
      @ BOT_X+3,BOT_Y-1 SAY "   "
      SETCOLOR("rg+/Bg")
      @ BOT_X+0,BOT_Y-1 SAY "   "
      @ BOT_X+1,BOT_Y-1 SAY " = "
      @ BOT_X+2,BOT_Y-1 SAY "   "
   ELSE
      SETCOLOR("rg+/Bg")
      @ BOT_X,BOT_Y+LEN(BOT_N)-1 SAY " "
      @ BOT_X+1,BOT_Y-1 SAY REPL(" ",LEN(BOT_N))
      SETCOLOR("rg+/n")
      @ BOT_X,BOT_Y-1 SAY BOT_N
   ENDIF
   INKEY(.1)
   SETCOLOR("N+/BG")
   IF BOT_N=" = "
      @ BOT_X+0,BOT_Y-1 SAY "Ü"
      @ BOT_X+1,BOT_Y-1 SAY "Û"
      @ BOT_X+2,BOT_Y-1 SAY "Û"
      @ BOT_X+3,BOT_Y-1 SAY "ßßß"
   ELSE
      @ BOT_X,BOT_Y-1 SAY "Ü"
      @ BOT_X+1,BOT_Y-1 SAY REPL("ß",LEN(BOT_N))
   ENDIF
ENDIF
SETCOLOR("w+/n")
IF BOT_N=" = "
   @ BOT_X+0,BOT_Y SAY "   "
   @ BOT_X+1,BOT_Y SAY " = "
   @ BOT_X+2,BOT_Y SAY "   "
ELSE
   @ BOT_X,BOT_Y SAY BOT_N
ENDIF
SETCOLOR("N+/Bg")
IF BOT_N=" = "
   @ BOT_X+0,BOT_Y-1 SAY "Ü"
   @ BOT_X+1,BOT_Y-1 SAY "Û"
   @ BOT_X+2,BOT_Y-1 SAY "Û"
   @ BOT_X+3,BOT_Y-1 SAY "ßßß"
ELSE
   @ BOT_X,BOT_Y-1 SAY "Ü"
   @ BOT_X+1,BOT_Y-1 SAY REPL("ß",LEN(BOT_N))
ENDIF
RETURN .T.


FUNCTIO BOTAO_CALC
PARA BOT_X,BOT_Y,BOT_N
IF PCOUNT()=4
   IF BOT_N=" = "
      SETCOLOR("rg+/Bg")
      @ BOT_X+0,BOT_Y+2 SAY " "
      @ BOT_X+1,BOT_Y+2 SAY " "
      @ BOT_X+2,BOT_Y+2 SAY " "
      @ BOT_X+3,BOT_Y-1 SAY "   "
      SETCOLOR("rg+/Bg")
      @ BOT_X+0,BOT_Y-1 SAY "   "
      @ BOT_X+1,BOT_Y-1 SAY " = "
      @ BOT_X+2,BOT_Y-1 SAY "   "
   ELSE
      SETCOLOR("rg+/Bg")
      @ BOT_X,BOT_Y+LEN(BOT_N)-1 SAY " "
      @ BOT_X+1,BOT_Y-1 SAY REPL(" ",LEN(BOT_N))
      SETCOLOR("rg+/n")
      @ BOT_X,BOT_Y-1 SAY BOT_N
   ENDIF
   INKEY(.1)
   SETCOLOR("N+/BG")
   IF BOT_N=" = "
      @ BOT_X+0,BOT_Y-1 SAY "Ü"
      @ BOT_X+1,BOT_Y-1 SAY "Û"
      @ BOT_X+2,BOT_Y-1 SAY "Û"
      @ BOT_X+3,BOT_Y-1 SAY "ßßß"
   ELSE
      @ BOT_X,BOT_Y-1 SAY "Ü"
      @ BOT_X+1,BOT_Y-1 SAY REPL("ß",LEN(BOT_N))
   ENDIF
ENDIF
SETCOLOR("w+/n")
IF BOT_N=" = "
   @ BOT_X+0,BOT_Y SAY "   "
   @ BOT_X+1,BOT_Y SAY " = "
   @ BOT_X+2,BOT_Y SAY "   "
ELSE
   @ BOT_X,BOT_Y SAY BOT_N
ENDIF
SETCOLOR("N+/Bg")
IF BOT_N=" = "
   @ BOT_X+0,BOT_Y-1 SAY "Ü"
   @ BOT_X+1,BOT_Y-1 SAY "Û"
   @ BOT_X+2,BOT_Y-1 SAY "Û"
   @ BOT_X+3,BOT_Y-1 SAY "ßßß"
ELSE
   @ BOT_X,BOT_Y-1 SAY "Ü"
   @ BOT_X+1,BOT_Y-1 SAY REPL("ß",LEN(BOT_N))
ENDIF
RETURN .T.
