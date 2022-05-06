
* TITULO     :  Sistema de Contas a Pagar
* DATA       : 25/04/97
* PROGRAMA   : CPDOCCON.PRG
* COMENTARIO : MENU DE CONSUTAS,ALTERACOES E EXCLUSOES
 
**
** Bloco de inser‡„o MCO.B01
**
PARA R_CA
MENSAGEM("Tecle <ESC> para sair")
DECLARE ME_NU[2]
ME_NU[1]=">A.Contas a pagar"
ME_NU[2]=">B.Contas pagas"
M->MENU_S=MENU()
IF M->MENU_S=0
   RETURN
ENDIF
IF M->MENU_S=1
   DECLARE ME_NU[2]
   ME_NU[1]="1.Duplicatas a pagar"
   ME_NU[2]="2.Cheques a pagar"
   S_MENU=MENU(1)
   IF M->S_MENU=1
      DO CPDOCC02.PRG WITH R_CA
   ELSEIF M->S_MENU=2
      DO CPDOCC03.PRG WITH R_CA
   ENDIF
ELSEIF M->MENU_S=2
   DECLARE ME_NU[2]
   ME_NU[1]="1.Duplicatas pagas"
   ME_NU[2]="2.Cheques pagos"
   S_MENU=MENU(1)
   IF M->S_MENU=1
      DO CPDOCC05.PRG WITH R_CA
   ELSEIF M->S_MENU=2
      DO CPDOCC06.PRG WITH R_CA
   ENDIF
ENDIF
CLOSE DATABASES
**
** Bloco de inser‡„o MCO.B02
**
 
* Final do programa CPDOCCON.PRG