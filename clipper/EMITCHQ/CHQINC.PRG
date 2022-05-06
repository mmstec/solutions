
* TITULO     : Recep‡„o/Emiss„o de cheques
* DATA       : 15/05/97
* PROGRAMA   : CHQINC.PRG
* COMENTARIO : MENU DE INCLUSAO
 
IF FILE ("INC.TXT")
     SETCOLOR("G/N")
     TEXTO=MEMOREAD("INC.TXT")
     @ 06,10 CLEAR TO 20,70
     @ 06,10       TO 20,70
     SOMBRA(06,10,20,70)
     @ 07,11 SAY PADC("ATENCAO OPERADOR...",58) COLOR ("RG+/N")
     MEMOEDIT(TEXTO,08,11,19,69,.F.)
ENDIF
**
** Bloco de inser‡„o INC.B01
**
MENSAGEM("Tecle <ESC> para sair")
DECLARE ME_NU[4]
ME_NU[1]="Bancos"
ME_NU[2]="Contas-Correntes"
ME_NU[3]="Emiss„o  de CHQ's"
ME_NU[4]="Recep‡„o de CHQ's"
M->SOS_MENU="INCLUSAO"
M->MENU_S=MENU()
M->SOS_MENU=" "
IF M->MENU_S=0
   RETURN
ENDIF
IF M->MENU_S=1
   DO CHQI01.PRG
ELSEIF M->MENU_S=2
   DO CHQI02.PRG
ELSEIF M->MENU_S=3
   DO CHQI03.PRG
ELSEIF M->MENU_S=4
   DO CHQI04.PRG
ENDIF
CLOSE DATABASES
**
** Bloco de inser‡„o INC.B02
**
 
* Final do programa CHQINC.PRG