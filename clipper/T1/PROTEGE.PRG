cls
TENTATIVA:=0
DG       :=SUBS(TIME(),7,8)
Do while file("USERFILE.ON") 
   RESTORE FROM USERFILE.ON ADDITIVE
   IF TENTATIVA=0
      @ 17,10 SAY ""
      run NET SEND &USERNAME &USERNAME SOLICITA LIBERACAO DO SISTEMA
      *;P/ CONTINUAR APERTE ALT e TAB
   ENDIF
   IF USERNAME=NETNAME()
      ERASE USERFILE.ON
      TONE(1000)
      @ 15,10 SAY "Sistema liberado"
   ENDIF
   IF SUBS(TIME(),7,8)<>DG
      TENTATIVA++
   ENDIF
   @ 08,10 SAY dtoc(date())+" "+time()                                 color "W+/n"
   @ 07,10 SAY ALLTRIM(PADR(NETNAME(),15))                                      color "BG+/n"
   @ 10,10 SAY userlog                                                 color "W+/n"
   @ 11,10 SAY ALLTRIM(PADR(UserName,15))+" ESTA BLOQUEANDO O SISTEMA"  color "BG+/n"
   @ 14,10 SAY alltrim(str(tentativa))+"¦ TENTATIVA DE ACESSO"         color "w+/n"
   @ 15,10 SAY "AGUARDE LIBERACAO DE "+PADR(USERNAME,15)               color "bg+/n"
   DG=SUBS(TIME(),7,8)
   inkey(1)                                             
enddo
UserName :=NetName()
UserLog  :=dtoc(date())+" "+time()
SAVE ALL like USER* TO USERFILE.ON
   @ 15,10 SAY "LIBERACAO DEFERIDA A "+PADR(NETNAME(),15)   color("rg+/n")
quit
