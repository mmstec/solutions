
* TITULO     :  Recupera‡„o de Inadiplencia
* DATA       : 28/02/97
* PROGRAMA   : NAOPGREL.PRG
* COMENTARIO : MENU DE RELATORIOS
 
**
** Bloco de inser‡„o REL.B01
**
MENSAGEM("Tecle <ESC> para sair")
DECLARE ME_NU[2]
ME_NU[1]="1.Inadiplentes"
ME_NU[2]="2.Pagamentos"
M->MENU_S=MENU()
IF M->MENU_S=0
   RETURN
ENDIF
IF M->MENU_S=1
   DO NAOPGR01.PRG
ELSEIF M->MENU_S=2
   DO NAOPGR02.PRG
ENDIF
CLOSE DATABASES
**
** Bloco de inser‡„o REL.B02
**
 
* Final do programa NAOPGREL.PRG