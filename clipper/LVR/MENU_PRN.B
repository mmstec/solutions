FUNCTION MENU_PRN
*
* -> Menu de direcionamento de impressao
PARA ARQ_PRN
FUNDO()
JANELA(06,21,18,59,"Direcionamento de impress„o")
COR("MENU")
@ 09,26 CLEAR TO 13,54
DO WHILE .T.
   BOTAO(15,35,"Enter")
   DECLARE MENU_CFG[3]
   MENU_CFG[1]="     ("+CHR(7)+") Impressora"
   MENU_CFG[2]="     ("+CHR(7)+") Monitor   "
   MENU_CFG[3]="     ("+CHR(7)+") HARD DISK "
   MENSAGEM("Escolha um dos direcionamentos...")
   SETCOLOR(CONTECOR[2]+","+CONTECOR[7])
   KEYBOARD CHR(32)
   M->OPC_PRN=ACHOICE(10,28,12,52,MENU_CFG,.T.,"FUN_CFG")
   IF M->OPC_PRN<>0
      BOTAO(15,35,"Enter",-2)
   ENDIF
   IF M->OPC_PRN=0
      RETURN .F.
   ELSEIF M->OPC_PRN = 1
      M->TIPO_PRN = "I"
      IF .NOT. ISPRINTER()
         BEEP()
         MENSAGEM("Impressora desligada ou desconectada",3)
         MENSAGEM("Tecle <ESC> para sair")
         LOOP
      ENDIF
   ELSEIF M->OPC_PRN = 2
      M->TIPO_PRN = "T"
      M->EX_T=(VAL(SUBS(TIME(),4,2))*10)+VAL(SUBS(TIME(),7,2))
      ARQ_PRN=ARQ_PRN+"."+SUBS(STR(M->EX_T+1000,4),2)
      SET PRINTER TO &ARQ_PRN
   ELSEIF M->OPC_PRN = 3
      RESTSCREEN(LIN_MENU+1,00,23,79,TELA_PRI)
      JANELA(07,16,17,62,"Direcionamento de impress„o")
      COR("MENU")
      @ 10,20 CLEAR TO 14,58
      @ 11,23 SAY "Digite o nome do arquivo de saida"
      ARQ_PRN=SPACE(8)
      DO WHILE .T.
         @ 13,35 GET ARQ_PRN PICT "@!" VALID ISALPHA(ARQ_PRN)
         SET CURSOR ON
         READ
         SET CURSOR OFF
         IF LASTKEY()=27
            RETURN .F.
         ENDIF
         IF AT(".",ARQ_PRN)<>0
            BEEP()
            MENSAGEM("Digite o nome do arquivo sem extens„o",3)
            MENSAGEM("Tecle <ESC> para sair")
            LOOP
         ENDIF
         EXIT
      ENDDO
      ARQ_PRN=ARQ_PRN+".PRN"
      M->TIPO_PRN = "A"
      SET PRINTER TO &ARQ_PRN
   ENDIF
   MENSAGEM("Tecle <ESC> para pausa ou interrup‡„o")
   RETURN .T.
ENDDO
