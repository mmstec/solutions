
* TITULO     : MFB - CONTROLE DE VENDAS
* DATA       : 12/05/97
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
ME_NU[1]=">A - Movimento do Cimento"
ME_NU[2]="-"
ME_NU[3]=">B - PFP"
M->MENU_S=MENU()
IF M->MENU_S=0
   RETURN
ENDIF
IF M->MENU_S=1
   DECLARE ME_NU[3]
   ME_NU[1]="  1.Vendas de Cimento"
   ME_NU[2]="  2.Quita‡„o de Cimento"
   ME_NU[3]="  3.Manuten‡„o"
   S_MENU=MENU(1)
   IF M->S_MENU=1
      DO MFBI02.PRG
   ELSEIF M->S_MENU=2
      DO MFBI03.PRG
   ELSEIF M->S_MENU=3
      DO MFBI04.PRG
   ENDIF
ELSEIF M->MENU_S=3
   DECLARE ME_NU[2]
   ME_NU[1]="  1. PFP a entregar"
   ME_NU[2]="  2. PFP entregues"
   S_MENU=MENU(1)
   IF M->S_MENU=1
      DO MFBI06.PRG
   ELSEIF M->S_MENU=2
      DO MFBI07.PRG
   ENDIF
ENDIF
CLOSE DATABASES
**
** Bloco de inser‡„o INC.B02
**
 
* Final do programa MFBINC.PRG