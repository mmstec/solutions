
* TITULO     : Recep‡„o/Emiss„o de cheques
* DATA       : 15/05/97
* PROGRAMA   : CHQCON.PRG
* COMENTARIO : MENU DE CONSUTAS,ALTERACOES E EXCLUSOES
 
**
** Bloco de inser‡„o MCO.B01
**
PARA R_CA
MENSAGEM("Tecle <ESC> para sair")
DECLARE ME_NU[4]
ME_NU[1]="Bancos disponiveis"
ME_NU[2]="Contas-correntes"
ME_NU[3]="Cheques emitidos"
ME_NU[4]="Cheques recebidos"
M->MENU_S=MENU()
IF M->MENU_S=0
   RETURN
ENDIF
IF M->MENU_S=1
   DO CHQC01.PRG WITH R_CA
ELSEIF M->MENU_S=2
   DO CHQC02.PRG WITH R_CA
ELSEIF M->MENU_S=3
   DO CHQC03.PRG WITH R_CA
ELSEIF M->MENU_S=4
   DO CHQC04.PRG WITH R_CA
ENDIF
CLOSE DATABASES
**
** Bloco de inser‡„o MCO.B02
**
 
* Final do programa CHQCON.PRG