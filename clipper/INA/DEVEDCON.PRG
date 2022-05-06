
* TITULO     : Controle de Inadiplencia
* DATA       : 15/04/97
* PROGRAMA   : DEVEDCON.PRG
* COMENTARIO : MENU DE CONSUTAS,ALTERACOES E EXCLUSOES
 
**
** Bloco de inser‡„o MCO.B01
**
PARA R_CA
MENSAGEM("Tecle <ESC> para sair")
DECLARE ME_NU[1]
ME_NU[1]="Inadiplente"
M->MENU_S=MENU()
IF M->MENU_S=0
   RETURN
ENDIF
IF M->MENU_S=1
   DO DEVEDC01.PRG WITH R_CA
ENDIF
CLOSE DATABASES
**
** Bloco de inser‡„o MCO.B02
**
 
* Final do programa DEVEDCON.PRG