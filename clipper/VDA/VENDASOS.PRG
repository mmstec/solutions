
* TITULO     :  MFB - Vendas Comissisionadas e Gerais
* DATA       : 03/06/97
* PROGRAMA   : VENDASOS.PRG
* COMENTARIO : ROTINA DE HELP
 

* TITULO     :  M.F.B. Material de Constru‡„o Ltda.
* DATA       : 22/02/97
* PROGRAMA   : MFBSOS.PRG
* COMENTARIO : ROTINA DE HELP

SET TALK OFF
SET DATE BRIT
SET BELL OFF
SET STAT OFF
SET SCORE OFF
SET WRAP ON
SET CURSOR OFF
SET DELETED ON
SETCANCEL(.f.)               // desativa ALT-C/BREAK
*
* -> Ativa a PROTECAO na tecla F7
SET KEY -6 TO SEGURANCA
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

FUNCTION HELP
SAVE SCREEN to SOS_MMS
   *
Do While .T.
   L=00
   C=03
   *
   SETColor ("N+/n")
   cls
   ?Repl("//\\// MMStec //\\//",100)
   SETColor ("W+/G")
   @ 02,02 clear to 22,78
   @ 02,02 to 22,78 COLOR "G+/G"
   @ l+04,c say Padc("TECLAS DE CONTROLE DO PROGRAMA",75) color ("RG+/G")
   @ l+04,60 say "P gina: 0000" Color "R+/G"
   @ l+05,c say REPL("Ä",75) color ("R+/G")
   @ l+06,c say PADR("  F1  > Aux¡lio ao Usu rio - Apresenta ao usu rio informa‡”es para",75)
   @ l+07,c say PADR("        manuseio do aplicativo ",75)
   @ l+08,c say PADR("  F2  > Agiliza campo ",75)
   @ l+09,c say PADR("  F3  > Calend rio ",75)
   @ l+10,c say PADR("  F4  > Cauculadora ",75)
   @ l+11,c say PADR("  F5  > Consulta ao sitema Operacional (MS-Dos) ",75)
   @ l+12,c say PADR("  F6  > Rotina n„o disponivel no momento ",75) color "G+/G"
   @ l+13,c say PADR("  F7  > Rotina de seguran‡a ",75)
   @ l+14,c say PADR("  F8  > Relogio ",75)
   @ l+15,c say PADR("  F9  > Mensagem ",75)
   @ l+16,c say PADR("  F10 > Musica ",75)
   @ l+17,c say PADR("  F11 > MMS-Editor de arquivos ",75)
   @ l+18,c say PADR("  F12 > Apresenta‡„o do aplicativo ",75)
   @ l+19,c say PADR("        ",75)
   @ l+20,c say PADR("        ",75)
   @ l+21,c say PADR("        ",75)
   @ 24,01 say PADC("Tecle <ESC> para voltar ao aplicativo ou qualquer tecla para continuar.",80) color "W+/N"
if lastkey()=27
     Beep()
     SET COLOR TO W
     restore screen from sos_MMS
     exit
     endif
   inkey(10)
   tone(840,2)
   @ l+01,60 say "Tecla:"COLOR "G+/N"
   @ l+01,67 say LASTKEY() COLOR "R+/N"
   *
   SETColor ("N+/n")
   cls
   ?Repl("//\\// MMStec //\\//",100)
   SETColor ("W+/G")
   @ 02,02 clear to 22,78
   @ 02,02 to 22,78 COLOR "G+/G"
   *
   @ l+04,c say PADc("TECLAS DE CONTROLE DE EDI€ŽO",75)   color ("RG+/G")
   *
   @ l+04,60 say "P gina: 0001" Color "R+/G"
   *
   @ l+05,c say REPL("Ä",75)   color ("R+/G")
   @ l+06,c say PADR("",75)
   @ l+07,c say PADR("  Enter  :  Efetua a entrada de dados.",75)
   @ l+08,c say PADR("  Setas  :  Movimentam o cursor para a dire‡„o indicada.",75)
   @ l+09,c say PADR("  Home   :  Move o cursor para o in¡cio do campo.",75)
   @ l+10,c say PADR("  End    :  Move o cursor para o final do campo.",75)
   @ l+11,c say PADR("  <--    :  Apaga o caracter a esquerda do cursor.",75)
   @ l+12,c say PADR("  Ins    :  Liga ou Desliga o modo de inser‡„o de caracteres.",75)
   @ l+13,c say PADR("  Del    :  Apaga o caracter sob o cursor.",75)
   @ l+14,c say PADR("  CTRL T :  Apaga a palavra … direita do cursor.",75)
   @ l+15,c say PADR("  CTRL Y :  Apaga todo o conte£do de um campo.",75)
   @ l+16,c say PADR("  Esc    :  Abandona a Edi‡„o.",75)
   @ l+17,c say PADR("",75)
   @ 24,01 say PADC("Tecle <ESC> para voltar ao aplicativo ou qualquer tecla para continuar.",80) color "W+/N"
if lastkey()=27
     Beep()
     SET COLOR TO W
     restore screen from sos_MMS
     exit
     endif
   inkey(10)
   TONE(840,2)
   @ l+01,60 say "Tecla:"COLOR "G+/N"
   @ l+01,67 say LASTKEY() COLOR "R+/N"
   *
   @ l+04,c say Padc("TECLAS DE NAVEGACAO DO MENU",75) color ("RG+/G")
   *
   @ l+04,60 say "P gina: 0002" Color "R+/G"
   *
   @ l+05,c say REPL("Ä",75) color ("R+/G")
   @ l+06,c say PADR("  Seta p/cima  :  Retorna a op‡„o anterior.",75)
   @ l+07,c say PADR("  ",75)
   @ l+08,c say PADR("  Seta p/baixo :  Acesso a op‡„o seguinte. Agiliza campo ",75)
   @ l+09,c say PADR("  ",75)
   @ l+10,c say PADR("  PgUp         :  Retorna a p gina anterior.",75)
   @ l+11,c say PADR("  ",75)
   @ l+12,c say PADR("  PgDn         :  Acesso a p gina seguinte.",75)
   @ l+13,c say PADR("  ",75)
   @ l+14,c say PADR("  Enter        :  Confirma op‡„o escolhida.",75)
   @ l+15,c say PADR("  ",75)
   @ l+16,c say PADR("  Esc          :  Retorna.",75)
   @ l+17,c say PADR("  ",75)
   @ l+18,c say PADR("        ",75)
   @ l+19,c say PADR("        ",75)
   @ l+20,c say PADR("        ",75)
   @ l+21,c say PADR("        ",75)
if lastkey()=27
     Beep()
     SET COLOR TO W
     restore screen from sos_MMS
     exit
     endif
   inkey(10)
   TONE(840,2)
   @ l+01,60 say "Tecla:"COLOR "G+/N"
   @ l+01,67 say LASTKEY() COLOR "R+/N"
   *
   @ l+04,c say Padc("MANUSEIO DO CALENDARIO",75) color ("RG+/G")
   *
   @ l+04,60 say "P gina: 0003" Color "R+/G"
   *
   @ l+05,c say REPL("Ä",75) color ("R+/G")
   @ l+06,c say PADR("  (+) Mˆs : Passa para o pr¢ximo mˆs.",75)
   @ l+07,c say PADR("  ",75)
   @ l+08,c say PADR("  (-) Mˆs : Volta para o mˆs anterior.",75)
   @ l+09,c say PADR("  ",75)
   @ l+10,c say PADR("  (+) Ano : Passa para o pr¢ximo ano.",75)
   @ l+11,c say PADR("  ",75)
   @ l+12,c say PADR("  (-) Ano : Volta para o ano anteiror.",75)
   @ l+13,c say PADR("  ",75) color "G+/G"
   @ l+14,c say PADR("  Ano     : Permite definir o ano desejado.",75)
   @ l+15,c say PADR("  ",75)
   @ l+16,c say PADR("  Esc     :  Retorna.",75)
   @ l+17,c say PADR("        ",75)
   @ l+18,c say PADR("        ",75)
   @ l+19,c say PADR("        ",75)
   @ l+20,c say PADR("        ",75)
   @ l+21,c say PADR("        ",75)
if lastkey()=27
     Beep()
     SET COLOR TO W
     restore screen from sos_MMS
     exit
     endif
   inkey(10)
   TONE(840,2)
   @ l+01,60 say "Tecla:"COLOR "G+/N"
   @ l+01,67 say LASTKEY() COLOR "R+/N"
   *
   @ l+04,c say Padc("MANUSEIO DA CAUCULADORA",75) color ("RG+/G")
   *
   @ l+04,60 say "P gina: 0004" Color "R+/G"
   *
   @ l+05,c say REPL("Ä",75) color ("R+/G")
   @ l+06,c say PADR("  *   :  Sinal de multiplica‡„o.",75)
   @ l+07,c say PADR("  ",75)
   @ l+08,c say PADR("  /   :  Sinal de divis„o.",75)
   @ l+09,c say PADR("  ",75)
   @ l+10,c say PADR("  +   :  Sinal de soma.",75)
   @ l+11,c say PADR("  ",75)
   @ l+12,c say PADR("  -   :  Sinal de subtra‡„o.",75)
   @ l+13,c say PADR("  ",75) color "G+/G"
   @ l+14,c say PADR("  E   :  Cancela o £ltimo valor digitado na calculadora.",75)
   @ l+15,c say PADR("  ",75)
   @ l+16,c say PADR("  C   :  Zera a calculadora.",75)
   @ l+17,c say PADR("  ",75)
   @ l+18,c say PADR("  Esc :  Abandona o manuseio da calculadora.",75)
   @ l+19,c say PADR("        ",75)
   @ l+20,c say PADR("  <Enter> ou =  : Sinal de igualdade.",75)
   @ l+21,c say PADR("        ",75)
   @ l+23,c say PADC("  Ctrl + setas  : Move a calculadora na tela.",75) COLOR "G+/n"
if lastkey()=27
     Beep()
     SET COLOR TO W
     restore screen from sos_MMS
     exit
     endif
   inkey(10)
   @ l+01,60 say "Tecla:"COLOR "G+/N"
   @ l+01,67 say LASTKEY() COLOR "R+/N"
   TONE(840,2)
ENDDO
RESTORE SCREEN FROM SOS_MMS



 
FUNCTION SOS
*
* -> Acrescenta uma linha ao texto de help
PARA TEX_TO
M->SOS=M->SOS+M->TEX_TO+CHR(13)+CHR(10)
 
 
* Final do programa VENDASOS.PRG