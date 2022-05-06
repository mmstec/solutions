
* TITULO     : MFB - LIVRO DE PRECOS
* DATA       : 26/06/97
* PROGRAMA   : LIVROCON.PRG
* COMENTARIO : MENU DE CONSUTAS,ALTERACOES E EXCLUSOES
 
**
** Bloco de inser‡„o MCO.B01
**
PARA R_CA
MENSAGEM("Tecle <ESC> para sair")
DECLARE ME_NU[1]
ME_NU[1]=">Livro de precos"
M->MENU_S=MENU()
IF M->MENU_S=0
   RETURN
ENDIF
IF M->MENU_S=1
   DECLARE ME_NU[3]
   ME_NU[1]="Produtos P/ referencia"
   ME_NU[2]="Produtos P/ descricao"
   ME_NU[3]="Grupos"
   S_MENU=MENU(1)
   IF M->S_MENU=1
      DO LIVROC02.PRG WITH R_CA
   ELSEIF M->S_MENU=2
      DO LIVROC03.PRG WITH R_CA
   ELSEIF M->S_MENU=3
      BEEP()
      MENSAGEM("Op‡„o n„o definida",3)
   ENDIF
ENDIF
CLOSE DATABASES
**
** Bloco de inser‡„o MCO.B02
**
 
* Final do programa LIVROCON.PRG