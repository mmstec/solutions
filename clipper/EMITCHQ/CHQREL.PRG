
* TITULO     : Recep‡„o/Emiss„o de cheques
* DATA       : 15/05/97
* PROGRAMA   : CHQREL.PRG
* COMENTARIO : MENU DE RELATORIOS
 
IF FILE ("REL.TXT")
     SETCOLOR("G/N")
     TEXTO=MEMOREAD("REL.TXT")
     @ 06,10 CLEAR TO 20,70
     @ 06,10       TO 20,70
     SOMBRA(06,10,20,70)
     @ 07,11 SAY PADC("ATENCAO OPERADOR...",58) COLOR ("RG+/N")
     MEMOEDIT(TEXTO,08,11,19,69,.F.)
ENDIF
**
** Bloco de inser‡„o REL.B01
**
MENSAGEM("Tecle <ESC> para sair")
DECLARE ME_NU[4]
ME_NU[1]="Bancos disponiveis"
ME_NU[2]="Contas Correntes"
ME_NU[3]="Cheques emitidos"
ME_NU[4]="Cheques recebidos"
M->MENU_S=MENU()
IF M->MENU_S=0
   RETURN
ENDIF
IF M->MENU_S=1
   DO CHQR01.PRG
ELSEIF M->MENU_S=2
   DO CHQR02.PRG
ELSEIF M->MENU_S=3
   DO CHQR03.PRG
ELSEIF M->MENU_S=4
   DO CHQR04.PRG
ENDIF
CLOSE DATABASES
**
** Bloco de inser‡„o REL.B02
**
 
* Final do programa CHQREL.PRG