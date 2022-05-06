
* TITULO     : MFB - CONTROLE DE VENDAS
* DATA       : 12/05/97
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
DECLARE ME_NU[3]
ME_NU[1]=">A - Movimento de Cimento"
ME_NU[2]="-"
ME_NU[3]=">B - PFP"
M->MENU_S=MENU()
IF M->MENU_S=0
   RETURN
ENDIF
IF M->MENU_S=1
   DECLARE ME_NU[2]
   ME_NU[1]="1. Devedores"
   ME_NU[2]="2. Quitados"
   S_MENU=MENU(1)
   IF M->S_MENU=1
      DO MFBR02.PRG
   ELSEIF M->S_MENU=2
      DO MFBR03.PRG
   ENDIF
ELSEIF M->MENU_S=3
   DECLARE ME_NU[2]
   ME_NU[1]="1. PFP a entregar"
   ME_NU[2]="2. PFG entregues"
   S_MENU=MENU(1)
   IF M->S_MENU=1
      DO MFBR05.PRG
   ELSEIF M->S_MENU=2
      DO MFBR06.PRG
   ENDIF
ENDIF
CLOSE DATABASES
**
** Bloco de inser‡„o REL.B02
**
 
* Final do programa MFBREL.PRG