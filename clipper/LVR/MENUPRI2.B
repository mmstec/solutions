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
