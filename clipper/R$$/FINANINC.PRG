
* TITULO     :  M.F.B.   Consulta de Cheques   Vers„o 1.0
* DATA       : 09/04/97
* PROGRAMA   : FINANINC.PRG
* COMENTARIO : MENU DE INCLUSAO
 
**
** Bloco de inser‡„o INC.B01
**
MENSAGEM("Tecle <ESC> para sair")
DECLARE ME_NU[1]
ME_NU[1]=">A. Cheques"
M->MENU_S=MENU()
IF M->MENU_S=0
     RETURN
ENDIF
IF M->MENU_S=1
     DECLARE ME_NU[2]
     ME_NU[1]="1. Cheques Pr‚-datados"
     ME_NU[2]="2. Cheques Recebidos"
     S_MENU=MENU(1)
     IF M->S_MENU=1
          DO FINANI02.PRG
     ELSEIF M->S_MENU=2
          DO FINANI03.PRG
     ENDIF
ENDIF
CLOSE DATABASES
**
** Bloco de inser‡„o INC.B02
**
 
* Final do programa FINANINC.PRG