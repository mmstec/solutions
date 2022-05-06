 *
 *******************************************************************************
 *                 (C) MMSTEC TECNOLOGIA E INFORMACAO
 *******************************************************************************
 * Programa......: MFR-MOVIMENTO FINANCEIRO REGISTRADO
 * Descri‡Æo.....: Programa desenvolvido para armazenamento do movimento financeiro
 *                 e processamento de comissäes.
 * Autor.........: Marcos Morais de Sousa
 * Data..........: 20/01/1999
 * ATUALIZACAO...: 29/12/2000
 * COMPILADOR EM.: CA-CLIPPER (5.2)
 * LINKADO COM...: RTLINK
 * BIBLIOTECA....: MMSTEC.LIB (P/Clipper 5.2)
 * ---- * ---- * ---- * ---- * ---- * ---- * ---- * ---- * ---- * ---- * ----
 * NOTA: 
 * MMSTEC ‚ uma biblioteca de fun‡oes desenvolvida por Marcos Morais de Sousa
 *****************************************************************************
 *
 M->NIVEL="0"
 IF LIBERA()
    ELSE
    ALERT('OPERA€ÇO INTERCEPTADA;;O sistema NŽO est  disponivel no Momento',,"w+/n")
    QUIT
 ENDIF
 DBACESSO()
 AMBIENTE()
 M->AUTOR    := "(C) Marcos Morais de Sousa - 1995/"+TRAN(YEAR(DATE()),"@E 9999")
 M->EMPRESAF := "BARRETO MATERIAL DE CONSTRUCAO"
 M->EMPRESAR := "MFB Material de Constru‡Æo LTDA"
 M->EMPRESAD := "CGC 34.196.147/00001-10 IE 28.956.507 NO"
 M->EMAIL    := "mfb@ieg.com.br"
 M->SISTEMA  := "RMF - REGISTRO DE MOVIMENTO FINANCEIRO"
 M->VERSAO   := "1.06"
 M->LOGPRO   := PROCNAME()+".EXE"
 M->LOGUSO   := "TODOS"
 M->LOGMAQ   := ALLTRIM(NETNAME())
 M->LOGDATA  := DTOC(DATE())
 M->LOGHORA  := TIME()
 *************
 IF FILE("RMF.DES")
    ERASE RMF.DES
 ENDIF
 SAVE all like LOG* to RMF.LIG
 *************

 DECLARE NOMECOR[13],CONTECOR[13]
 NOMECOR[01]="FUNDO DA TELA"
 NOMECOR[02]="MENU"
 NOMECOR[03]="DESTAQUE DO MENU"
 NOMECOR[04]="JANELA DE DIALOGO"
 NOMECOR[05]="BOX DA JANELA DE DIALOGO"
 NOMECOR[06]="BOTOES"
 NOMECOR[07]="BOTAO EM DESTAQUE"
 NOMECOR[08]="GETS"
 NOMECOR[09]="GET EM DESTAQUE"
 NOMECOR[10]="TELA DE APRESENTACAO"
 NOMECOR[11]="CARACTERES AVULSOS"
 NOMECOR[12]="CERCADURAS"
 NOMECOR[13]="TITULO"
 PADRAO()

 SET PROCEDURE TO V1ARQ  // cria arquivos
 SET PROCEDURE TO V1FUN  // fun‡äes principais
 SET PROCEDURE TO V1MAN  // manuten‡Æo
 SET PROCEDURE TO V1INC  // inclui
 SET PROCEDURE TO V1ALT  // altera
 SET PROCEDURE TO V1EXC  // exclui
 SET PROCEDURE TO V1LOC  // localiza
 SET PROCEDURE TO V1REL  // relatorio
 SET PROCEDURE TO V1UTL  // utilitarios
 SET PROCEDURE TO V1SNH  // seguran‡a
 SET PROCEDURE TO V1EXT  // valores extensos

 SET MESSAGE TO 23 CENTER
 SET KEY 28 TO AJUDA()
 SET KEY -1 TO CALCULADORA()
 SET KEY -2 TO CALENDARIO()
 SET COLOR TO "W+/N,N/B,,,B+/BG"
 CLS

 dBCRIA()
 dBCOMPACTA(05, 05, 21)
 ENTRADA("RELATORIO DO DIA")
 RVT1()
 PRINCIPAL()

FUNCTION PRINCIPAL
DO WHILE.T.
   SETCOLOR("N+/B,BG+/B,,,BG+/B")
   ENTRADA("TELA PRINCIPAL")
   relevo(06, 56, 08, 73, .T.) // BOTOES
   relevo(09, 56, 11, 73, .T.) // BOTOES
   relevo(12, 56, 14, 73, .T.) // BOTOES
   relevo(15, 56, 17, 73, .T.) // BOTOES
   relevo(18, 56, 20, 73, .T.) // BOTOES     
   @ 07,58 PROMPT padR("1.Inclusäes  " ,15) MESSAGE PADC('P/ INCLUIR REGISTROS APERTE "1"',67)
   @ 10,58 PROMPT padR("2.Manuten‡äes" ,15) MESSAGE PADC('P/ LOCALISAR, ALTERAR E EXCLUIR REGISTROS APERTE "2"',67)
   @ 13,58 PROMPT padR("3.Relat¢rios " ,15) MESSAGE PADC('P/ IMPRIMIR RELATORIOS APERTE "3"',67)
   @ 16,58 PROMPT padR("4.Utilit rios" ,15) MESSAGE PADC('P/ ACESSO AOS UTILITARIOS APERTE "4"',67)
   @ 19,58 PROMPT padR("5.Sa¡da      " ,15) MESSAGE PADC('P/ SAIR DO SISTEMA APERTE "5"',67)
   DBMENSAGEM()
   OPCMENU=1
   MENU TO OPCMENU
   DO CASE
   CASE OPCMENU=1 
        INCLUSAO()   // ALERT("OPCAO AINDA;NAO DISPONIVEL")
   CASE OPCMENU=2
        MANUTENCAO()  // ALERT("OPCAO AINDA;NAO DISPONIVEL")
   CASE OPCMENU=3
        RELATORIO()   // ALERT("OPCAO AINDA;NAO DISPONIVEL")
   CASE OPCMENU=4
        UTILITARIO()  //  ALERT("OPCAO AINDA;NAO DISPONIVEL")
   CASE OPCMENU=5 .OR. LASTKEY()=27
        SAIR=PERGUNTA("DESEJA SAIR DO SISTEMA?")
        IF SAIR<>1
           PRINCIPAL()
        ENDIF
        EXIT
   ENDCASE
ENDDO
SETCOLOR("W/N")
CLS
M->LOGSAIDA = TIME()
LOGOMARCA()
?M->SISTEMA
?"EXECU€ÇO ENCERRADA EM:"+DTOC(DATE())+" ("+TIME()+")"
?"TEMPO DE USO ESTIMADO:"+ELAPTIME(M->LOGHORA,M->LOGSAIDA)
ERASE RMF.MSG  // APAGA ARQUIVO-MENSAGEM DE TENTATIVA DE ACESSO
ERASE RMF.LIG  // APAGA ARQUIVO-MENSAGEM DE SISTEMA LIGADO
QUIT
RETURN.T.

FUNCTION AMBIENTE
SETCANCEL(.T.)               // (.F.) desativa ALT-C/BREAK
SET EPOCH TO 1970            // prepara datas para o terceiro milˆnio
SET DATE FORMAT TO "dd,mm,yyyy"
SET DATE BRIT
SET TALK OFF
SET BELL OFF
SET STAT OFF
SET SCORE OFF
SET WRAP ON
SET CURSOR OFF
SET DELETED ON

FUNCTION PADRAO
CONTECOR[01]="09/01"
CONTECOR[02]="00/07"
CONTECOR[03]="15/04"
CONTECOR[04]="07/01"
CONTECOR[05]="00/03"
CONTECOR[06]="00/07"
CONTECOR[07]="15/07"
CONTECOR[08]="00/07"
CONTECOR[09]="15/04"
CONTECOR[10]="15/01"
CONTECOR[11]="07/01"
CONTECOR[12]="07/01"
CONTECOR[13]="15/03"
RETURN .T.

    FUNCTION BOTOES
    RELEVO(06,06,08,20,.T.)
    RELEVO(09,06,11,20,.T.)
    RELEVO(12,06,14,20,.T.)
    RELEVO(15,06,17,20,.T.)
    RELEVO(18,06,20,20,.T.)
    RETURN

    FUNCTION ENTRADA(PAR)
    IF PAR=NIL
       PAR="TELA DE OP€åES"
    ENDIF
    SETBLINK(.T.)
    RELEVO(00, 00, 24, 79,.T.)    // toda MAE
    RELEVO(05, 55, 21, 74,.F.,,2) // tela DIREITA
    RELEVO(05, 05, 21, 54,.F.,,2) // tela EQUERDA
    RELEVO(06, 06, 08, 53,.T.,,2) // BARRA DE TITULO
    RELEVO(09, 06, 20, 53,.T.,,1) // BARRA INTERNA
    @ 07, 08 SAY PADC(PAR,44)  COLOR "W+/B"
    SET CURSOR OFF
    @ 02,06 SAY M->AUTOR +" "+email                       color "bg+ /b"
    @ 03,06 SAY M->EMPRESAR                               color "bg  /b"
    @ 13,08 SAY PADC(M->SISTEMA                      ,44) color "W+  /b"
    @ 14,08 SAY PADC("Û²±° VERSAO:"+M->VERSAO+" °±²Û",44) color "B+  /b"
    @ 19,08 SAY PADC(M->AUTOR                        ,44) color "N+  /b"
    RETURN.T.                                 
