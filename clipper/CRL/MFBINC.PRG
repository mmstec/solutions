
* TITULO     : *** Barreto Constru‡„o ***
* DATA       : 17/04/97
* PROGRAMA   : MFBINC.PRG
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
ME_NU[1]=">1.Cadastro de Clientes"
ME_NU[2]=">2.Vendas"
ME_NU[3]=">3.Recebimento"
M->MENU_S=MENU()
IF M->MENU_S=0
     RETURN
ENDIF
IF M->MENU_S=1
     DECLARE ME_NU[2]
     ME_NU[1]="  Pessoa Fisica"
     ME_NU[2]="  Pessoa Juridica"
     S_MENU=MENU(1)
     IF M->S_MENU=1
          DO MFBI02.PRG
     ELSEIF M->S_MENU=2
          DO MFBI03.PRG
     ENDIF
ELSEIF M->MENU_S=2
     DECLARE ME_NU[7]
     ME_NU[1]="  Vendas da loja a vista"
     ME_NU[2]="  Vendas de cimento a vista"
     ME_NU[3]="-"
     ME_NU[4]="  Vendas da Loja a prazo"
     ME_NU[5]="  Vendas de cimento a prazo"
     ME_NU[6]="  .                       ."
     ME_NU[7]="  .                       ."
     S_MENU=MENU(1)
     IF M->S_MENU=1
          DO MFBI05.PRG
     ELSEIF M->S_MENU=2
          DO MFBI06.PRG
     ELSEIF M->S_MENU=4
          DO MFBI07.PRG
     ELSEIF M->S_MENU=5
          DO MFBI08.PRG
     ELSEIF M->S_MENU=6
          BEEP()
          MENSAGEM("Op‡„o n„o definida",3)
     ELSEIF M->S_MENU=7
          BEEP()
          MENSAGEM("Op‡„o n„o definida",3)
     ENDIF
ELSEIF M->MENU_S=3
     DECLARE ME_NU[2]
     ME_NU[1]="  Loja."
     ME_NU[2]="  Cimento."
     S_MENU=MENU(1)
     IF M->S_MENU=1
          DO MFBI12.PRG
     ELSEIF M->S_MENU=2
          DO MFBI13.PRG
     ENDIF
ENDIF
CLOSE DATABASES
**
** Bloco de inser‡„o INC.B02
**
 
* Final do programa MFBINC.PRG