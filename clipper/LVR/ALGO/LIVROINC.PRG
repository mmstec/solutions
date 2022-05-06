
* TITULO     : ALGO - LIVRO DE PRECOS
* DATA       : 12/05/97
* PROGRAMA   : LIVROINC.PRG
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
DECLARE ME_NU[1]
ME_NU[1]=">Livro de Pre‡o"
M->MENU_S=MENU()
IF M->MENU_S=0
     RETURN
ENDIF
IF M->MENU_S=1
     DECLARE ME_NU[2]
     ME_NU[1]="Produtos"
     ME_NU[2]="Grupo"
     S_MENU=MENU(1)
     IF M->S_MENU=1
          DO LIVROI02.PRG
     ELSEIF M->S_MENU=2
          DO LIVROI03.PRG
     ENDIF
ENDIF
CLOSE DATABASES
**
** Bloco de inser‡„o INC.B02
**
 
* Final do programa LIVROINC.PRG