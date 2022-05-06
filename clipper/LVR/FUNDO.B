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
