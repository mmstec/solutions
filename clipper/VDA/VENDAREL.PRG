
* TITULO     :  MFB - Vendas Comissisionadas e Gerais
* DATA       : 03/06/97
* PROGRAMA   : VENDAREL.PRG
* COMENTARIO : MENU DE RELATORIOS
 
IF FILE ("REL.TXT")
     SETCOLOR("G/N")
     TEXTO=MEMOREAD("REL.TXT")
     @ 06,10 CLEAR TO 20,70
     @ 06,10       TO 20,70
     SOMBRA(06,10,20,70)
     @ 07,11 SAY PADC("ATENCAO OPERADOR...",58) COLOR ("RG+/N")
     MEMOEDIT(TEXTO,08,11,19,69,.F.)
ENDIF
**
** Bloco de inser‡„o REL.B01
**
MENSAGEM("Tecle <ESC> para sair")
DECLARE ME_NU[3]
ME_NU[1]=">1. VENDA COMISSIONADA"
ME_NU[2]="-"
ME_NU[3]=">2. VENDA GERAL"
M->MENU_S=MENU()
IF M->MENU_S=0
   RETURN
ENDIF
IF M->MENU_S=1
   DECLARE ME_NU[2]
   ME_NU[1]="* Comissao do grupo  A"
   ME_NU[2]="* Comissao do grupo  B"
   S_MENU=MENU(1)
   IF M->S_MENU=1
      DO VENDAR02.PRG
   ELSEIF M->S_MENU=2
      DO VENDAR03.PRG
   ENDIF
ELSEIF M->MENU_S=3
   DECLARE ME_NU[2]
   ME_NU[1]="* Venda pela  LOJA"
   ME_NU[2]="* Venda pelo  CIMENTO"
   S_MENU=MENU(1)
   IF M->S_MENU=1
      DO VENDAR05.PRG
   ELSEIF M->S_MENU=2
      DO VENDAR06.PRG
   ENDIF
ENDIF
CLOSE DATABASES
**
** Bloco de inser‡„o REL.B02
**
 
* Final do programa VENDAREL.PRG