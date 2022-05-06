
* TITULO     :  Recupera‡„o de Inadiplencia
* DATA       : 28/02/97
* PROGRAMA   : NAOPGINC.PRG
* COMENTARIO : MENU DE INCLUSAO
 
**
** Bloco de inser‡„o INC.B01
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
   DO NAOPGI01.PRG
ELSEIF M->MENU_S=2
   DO NAOPGI02.PRG
ENDIF
CLOSE DATABASES
**
** Bloco de inser‡„o INC.B02
**
 
* Final do programa NAOPGINC.PRG