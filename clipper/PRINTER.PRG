   impress   := 1
   ini_italic:= "4"
   fin_italic:= "5"
   mod_carta := "x"
   draft     := "x" + Chr(0)
   roman     := "k" + Chr(0)
   sserif    := "k"
   ini_garraf:= ""
   fin_garraf:= ""
   ini_conden:= "!"     
   fin_conden:= ""
   dez_cpi   := "!" + Chr(0)
   doze_cpi  := "!"
   ps        := "!"
   ini_negrit:= "E"
   fin_negrit:= "F"
   ini_lpp   := "0"
   ini_lpp1  := "1"
   fin_lpp   := "2"


FRASE:="AGUARDE: Teste de impress∆o"
LINHA:=0
if (!isprinter())
   alert(";***; IMPRESSORA DESLIGADA ;***;")
else
   set device to printer

   @ linha++, 00 say impress 
   @ linha++, 00 say FRASE
   @ Linha++, 00 say ini_italic
   @ Linha++, 00 say FRASE
   @ Linha++, 00 say fin_italic
   @ Linha++, 00 say mod_carta
   @ Linha++, 00 say FRASE
   @ Linha++, 00 say draft
   @ Linha++, 00 say FRASE
   @ Linha++, 00 say roman
   @ Linha++, 00 say FRASE
   @ Linha++, 00 say sserif
   @ Linha++, 00 say FRASE
   @ Linha++, 00 say ini_garraf
   @ Linha++, 00 say FRASE
   @ Linha++, 00 say fin_garraf
   @ Linha++, 00 say ini_conden
   @ Linha++, 00 say FRASE
   @ Linha++, 00 say fin_conden
   @ Linha++, 00 say dez_cpi
   @ Linha++, 00 say FRASE
   @ Linha++, 00 say doze_cpi
   @ Linha++, 00 say ps
   @ Linha++, 00 say FRASE
   @ Linha++, 00 say ini_negrit
   @ Linha++, 00 say FRASE
   @ Linha++, 00 say fin_negrit
   @ Linha++, 00 say ini_lpp
   @ Linha++, 00 say FRASE
   @ Linha++, 00 say ini_lpp1
   @ Linha++, 00 say FRASE
   @ Linha++, 00 say fin_lpp
   @ Linha++, 00 say FRASE
   @ Linha++, 00 say fin_lpp
   @ Linha++, 00 say " * VERIFICAR * "
   set devi to screen

endif
?""
?"Teste de impressora (Epson) terminado"
?""
quit
