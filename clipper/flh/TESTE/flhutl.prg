FUNCTION utilitario
DO WHILE.T. 
   SETCOLOR("N+/B,BG+/B,,,BG+/B")
   ENTRADA("TELA DE RELATORIOS")
   relevo(06, 56, 08, 73, .T.) // BOTOES
   relevo(09, 56, 11, 73, .T.) // BOTOES
   relevo(12, 56, 14, 73, .T.) // BOTOES
   relevo(15, 56, 17, 73, .T.) // BOTOES
   relevo(18, 56, 20, 73, .T.) // BOTOES
   @ 07,58 PROMPT padR("1.Reorganiza "  ,15)   MESSAGE PADC('P/ ATUALIZAR ARQUIVOS APERTE "1"',67)
   @ 10,58 PROMPT padR("2.Calculadora"  ,15)   MESSAGE PADC('P/ USAR A CALCULADORA APERTE "2"',67)
   @ 13,58 PROMPT padR("3.Calendario "  ,15)   MESSAGE PADC('P/ USAR O CALENDARIO APERTE "3"',67)
   @ 16,58 PROMPT padR("4.Senhas     "  ,15)   MESSAGE PADC('P/ Cadastros, altera‡äes etc de senhas aperte "4"',67)          
   @ 19,58 PROMPT padR("5.Principal  "  ,15)   MESSAGE PADC('P/ RETORNAR AO MENU PRINCIPAL APERTE "4" ou "ESC"',67)
   UTLMENU=1
   MENU TO UTLMENU
   DO CASE
   CASE UTLMENU=1 
        DBCOMPACTA(12)
   CASE UTLMENU=2
        CALCULADORA()
   CASE UTLMENU=3
        CALENDARIO()
   CASE UTLMENU=4
        IF M->NIVEL>=3
           manSNH()
           ELSE
           ALERT('OPERA€ÇO INTERCEPTADA;;Seu n¡vel de senha n„o permite esta opera‡Æo.;;N¡vel m¡nimo nescess rio: "3"',,"w+/n")
        ENDIF
   CASE UTLMENU=5 .OR. LASTKEY()=27
        PRINCIPAL()
   ENDCASE
ENDDO
RETURN.T.
