FUNCTION SHELLDOS
*
* -> Permite sair ao sistema operacional retornado com (EXIT)
M->X_DOS=ROW()
M->Y_DOS=COL()
M->COR=SETCOLOR()
SAVE SCREEN TO M->TELA
SET COLOR TO W
CLEAR SCREEN
@ 01,00 SAY PADC("N„o instale nem desinstale programas residentes.",80)  COLOR "G+/n"
@ 02,00 SAY PADC("Digite EXIT e tecle <ENTER> para retornar.",80) COLOR "G+/n"
@ 03,00 SAY REPL("Ä",80) COLOR "r+/n"
@ 04,00 SAY REPL(" ",80) COLOR "W/N"
BEEP()
SET CURSOR ON
RUN COMMAND.COM
SET CURSOR OFF
RESTORE SCREEN FROM M->TELA
ON_CURSOR()
@ M->X_DOS,M->Y_DOS SAY ""
SETCOLOR(M->COR)
