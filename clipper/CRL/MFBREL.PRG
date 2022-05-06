
* TITULO     : *** Barreto Constru‡„o ***
* DATA       : 17/04/97
* PROGRAMA   : MFBREL.PRG
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
DECLARE ME_NU[4]
ME_NU[1]=">1.Relacao de Clientes"
ME_NU[2]=">2.Relatorio de V/vista"
ME_NU[3]=">3.Relatorio de V/prazo"
ME_NU[4]=">4.Movimentacao de capital"
M->MENU_S=MENU()
IF M->MENU_S=0
     RETURN
ENDIF
IF M->MENU_S=1
     DECLARE ME_NU[3]
     ME_NU[1]="Todos os Clientes"
     ME_NU[2]="."
     ME_NU[3]="."
     S_MENU=MENU(1)
     IF M->S_MENU=1
          DO MFBR02.PRG
     ELSEIF M->S_MENU=2
          BEEP()
          MENSAGEM("Op‡„o n„o definida",3)
     ELSEIF M->S_MENU=3
          BEEP()
          MENSAGEM("Op‡„o n„o definida",3)
     ENDIF
ELSEIF M->MENU_S=2
     DECLARE ME_NU[2]
     ME_NU[1]=" V vista loja"
     ME_NU[2]=" V vista cimento"
     S_MENU=MENU(1)
     IF M->S_MENU=1
          DO MFBR06.PRG
     ELSEIF M->S_MENU=2
          DO MFBR07.PRG
     ENDIF
ELSEIF M->MENU_S=3
     DECLARE ME_NU[2]
     ME_NU[1]=" V prazo loja"
     ME_NU[2]=" V prazo cimento"
     S_MENU=MENU(1)
     IF M->S_MENU=1
          DO MFBR09.PRG
     ELSEIF M->S_MENU=2
          DO MFBR10.PRG
     ENDIF
ELSEIF M->MENU_S=4
     DECLARE ME_NU[2]
     ME_NU[1]=" Por cliente Loja"
     ME_NU[2]=" Por cliente Cimento"
     S_MENU=MENU(1)
     IF M->S_MENU=1
          DO MFBR12.PRG
     ELSEIF M->S_MENU=2
          DO MFBR13.PRG
     ENDIF
ENDIF
CLOSE DATABASES
**
** Bloco de inser‡„o REL.B02
**
 
* Final do programa MFBREL.PRG