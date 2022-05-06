
* TITULO     :  MFB Materiais de Construcao Ltda ( MMStec - Orcamento )
* DATA       : 06/03/97
* PROGRAMA   : UTILINC.PRG
* COMENTARIO : MENU DE INCLUSAO
 
**
** Bloco de inser‡„o INC.B01
**
MENSAGEM("Tecle <ESC> para sair")
DECLARE ME_NU[6]
ME_NU[1]="1 - ICMS"
ME_NU[2]="2 - Orcamento"
ME_NU[3]="3 - Lista / Precos"
ME_NU[4]="4 - Aniversariantes"
ME_NU[5]="5 - Folha de Pagamento"
ME_NU[6]="6 - Representantes"
M->MENU_S=MENU()
IF M->MENU_S=0
   RETURN
ENDIF
IF M->MENU_S=1
   DO UTILI01.PRG
ELSEIF M->MENU_S=2
   DO UTILI02.PRG
ELSEIF M->MENU_S=3
   DO UTILI03.PRG
ELSEIF M->MENU_S=4
   DO UTILI04.PRG
ELSEIF M->MENU_S=5
   DO UTILI05.PRG
ELSEIF M->MENU_S=6
   DO UTILI06.PRG
ENDIF
CLOSE DATABASES
**
** Bloco de inser‡„o INC.B02
**
 
* Final do programa UTILINC.PRG