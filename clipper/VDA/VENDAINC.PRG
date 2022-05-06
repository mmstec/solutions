
* TITULO     :  MFB - Vendas Comissisionadas e Gerais
* DATA       : 03/06/97
* PROGRAMA   : VENDAINC.PRG
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
DECLARE ME_NU[3]
ME_NU[1]=">1.VENDA COMISSIONADA"
ME_NU[2]="-"
ME_NU[3]=">2.VENDA GERAL"
M->MENU_S=MENU()
IF M->MENU_S=0
   RETURN
ENDIF
IF M->MENU_S=1
   DECLARE ME_NU[3]
   ME_NU[1]="* Grupo A < 01,02,03,04 >"
   ME_NU[2]="-"
   ME_NU[3]="* Grupo B < 05,06,07,08 >"
   S_MENU=MENU(1)
   IF M->S_MENU=1
      DO VENDAI02.PRG
   ELSEIF M->S_MENU=3
      DO VENDAI03.PRG
   ENDIF
ELSEIF M->MENU_S=3
   DECLARE ME_NU[3]
   ME_NU[1]="* Venda pela LOJA"
   ME_NU[2]="-"
   ME_NU[3]="* Venda pelo CIMENTO"
   S_MENU=MENU(1)
   IF M->S_MENU=1
      DO VENDAI05.PRG
   ELSEIF M->S_MENU=3
      DO VENDAI06.PRG
   ENDIF
ENDIF
CLOSE DATABASES
**
** Bloco de inser‡„o INC.B02
**
 
* Final do programa VENDAINC.PRG