
* TITULO     : *** Barreto Constru‡„o ***
* DATA       : 17/04/97
* PROGRAMA   : MFBCON.PRG
* COMENTARIO : MENU DE CONSUTAS,ALTERACOES E EXCLUSOES
 
**
** Bloco de inser‡„o MCO.B01
**
PARA R_CA
MENSAGEM("Tecle <ESC> para sair")
DECLARE ME_NU[3]
ME_NU[1]=">1.Ficha de Clientes"
ME_NU[2]=">2.Vendas a vista"
ME_NU[3]=">3.Vendas a prazo"
M->MENU_S=MENU()
IF M->MENU_S=0
     RETURN
ENDIF
IF M->MENU_S=1
     DECLARE ME_NU[6]
     ME_NU[1]="Pessoa Fisica por NOME"
     ME_NU[2]="Pessoa Fisica por C.P.F."
     ME_NU[3]="Pessoa Juridica por NOME"
     ME_NU[4]="Pessoa Juridica por C.G.C."
     ME_NU[5]="."
     ME_NU[6]="."
     S_MENU=MENU(1)
     IF M->S_MENU=1
          DO MFBC02.PRG WITH R_CA
     ELSEIF M->S_MENU=2
          DO MFBC03.PRG WITH R_CA
     ELSEIF M->S_MENU=3
          DO MFBC04.PRG WITH R_CA
     ELSEIF M->S_MENU=4
          DO MFBC05.PRG WITH R_CA
     ELSEIF M->S_MENU=5
          BEEP()
          MENSAGEM("Op‡„o n„o definida",3)
     ELSEIF M->S_MENU=6
          BEEP()
          MENSAGEM("Op‡„o n„o definida",3)
     ENDIF
ELSEIF M->MENU_S=2
     DECLARE ME_NU[4]
     ME_NU[1]="Venda/vista loja DOCUMENTO"
     ME_NU[2]="Venda/vista loja CHEQ/CARTAO"
     ME_NU[3]="Venda/vista Cimento"
     ME_NU[4]="."
     S_MENU=MENU(1)
     IF M->S_MENU=1
          DO MFBC09.PRG WITH R_CA
     ELSEIF M->S_MENU=2
          DO MFBC10.PRG WITH R_CA
     ELSEIF M->S_MENU=3
          DO MFBC11.PRG WITH R_CA
     ELSEIF M->S_MENU=4
          BEEP()
          MENSAGEM("Op‡„o n„o definida",3)
     ENDIF
ELSEIF M->MENU_S=3
     DECLARE ME_NU[2]
     ME_NU[1]="Venda/prazo Loja"
     ME_NU[2]="Venda/prazo Cimento"
     S_MENU=MENU(1)
     IF M->S_MENU=1
          DO MFBC14.PRG WITH R_CA
     ELSEIF M->S_MENU=2
          DO MFBC15.PRG WITH R_CA
     ENDIF
ENDIF
CLOSE DATABASES
**
** Bloco de inser‡„o MCO.B02
**
 
* Final do programa MFBCON.PRG