
* TITULO     :  Programa Utilitario e Aplicacoes Diversas
* DATA       : 22/08/96
* PROGRAMA   : UTILREL.PRG
* COMENTARIO : MENU DE RELATORIOS
 
**
** Bloco de inser‡„o REL.B01
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
   BEEP()
   MENSAGEM("Op‡„o n„o definida",3)
ELSEIF M->MENU_S=2
   DO UTILR02.PRG
ELSEIF M->MENU_S=3
   DO UTILR03.PRG
ELSEIF M->MENU_S=4
   DO UTILR04.PRG
ELSEIF M->MENU_S=5
   DO UTILR05.PRG
ELSEIF M->MENU_S=6
   DO UTILR06.PRG
ENDIF
CLOSE DATABASES
**
** Bloco de inser‡„o REL.B02
**
 
* Final do programa UTILREL.PRG