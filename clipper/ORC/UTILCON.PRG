
* TITULO     :  MFB Materiais de Construcao Ltda ( MMStec - Orcamento )
* DATA       : 06/03/97
* PROGRAMA   : UTILCON.PRG
* COMENTARIO : MENU DE CONSUTAS,ALTERACOES E EXCLUSOES
 
**
** Bloco de inser‡„o MCO.B01
**
PARA R_CA
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
   DO UTILC01.PRG WITH R_CA
ELSEIF M->MENU_S=2
   DO UTILC02.PRG WITH R_CA
ELSEIF M->MENU_S=3
   DO UTILC03.PRG WITH R_CA
ELSEIF M->MENU_S=4
   DO UTILC04.PRG WITH R_CA
ELSEIF M->MENU_S=5
   DO UTILC05.PRG WITH R_CA
ELSEIF M->MENU_S=6
   DO UTILC06.PRG WITH R_CA
ENDIF
CLOSE DATABASES
**
** Bloco de inser‡„o MCO.B02
**
 
* Final do programa UTILCON.PRG