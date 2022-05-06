 
 ************[ Ficha do Autor ]*******************
 ***
 M->AUTOR    := "(C) Marcos Morais de Sousa - 1995/"+TRAN(YEAR(DATE()),"@E 9999")
 M->EMAIL    := "EMAIL: mmstec@ig.com.br"
 M->ICQ      := "ISM  : ICQ#51757082 OU COMVC#215010" 
 M->CELULAR  := "CEL  : (73) 9121-2933"
 M->TELEFONE := "TEL  : (73)  525-5932"
 ***
 ************[ Ficha da Licensa ]*****************
 ***
 IF FILE("MMSTEC.SYS")
    RESTORE FROM MMSTEC.SYS ADDITIVE
    ELSE
    ikNOM="MMSTEC.HPG.COM.BR"
    ikCOD="nntufdoiqhOdpnOcs"
    ikDAT=DATE()
    SAVE ALL LIKE ik* to MMSTEC.SYS
    RESTORE FROM MMSTEC.SYS ADDITIVE
 ENDIF
 M->LNOME    := ikNOM
 M->LCODIGO  := ikCOD
 M->DTRAVA   := ikDAT
 ***
 ************[ Ficha do Programa ]****************
 ***
 M->SISTEMA  := "REGISTRO DE TELEFONES"
 M->VERSAO   := "1.0a"
 M->LOGPRO   := PROCNAME()+".EXE"
 M->LOGUSO   := "TODOS"
 M->LOGMAQ   := ALLTRIM(NETNAME())
 M->LOGDATA  := DTOC(DATE())
 M->LOGHORA  := TIME()
 ***
 ***********************************************
 CLS
 * SET VIDEOMODE TO 18
 * gBmpDisp(gBmpLoad("MMSTEC.BMP"),30,35)
 SETCANCEL(.F.)               // (.F.) desativa ALT-C/BREAK
 SET EPOCH TO 1960            // prepara datas para o terceiro milˆnio
 SET DATE FORMAT TO "dd,mm,yyyy"
 SET DATE BRIT
 IF DATE()>=M->DTRAVA .AND. M->LNOME=" AVALIACAO " .OR. LEN(M->LNOME)<=1
    SalvaCor=SetColor()
    setColor="w+/n"
    cls
    CONTADOR:=60
    DO WHILE CONTADOR>=1
    CONTADOR--
    Tone((60-CONTADOR)*100,1)
    Inkey(1)
    @ 08,10 say DTOC(DATE())+" "+TIME()                                color "BG+ /n"
    @ 10,10 say "SISTEMA NAO REGISTRADO"                               color "RG+*/n"
    @ 12,10 say "PARA REGISTRAR ESTE SISTEMA ENTRE EM CONTATO COM:" color "n+/n"
    @ 13,10 say M->AUTOR    := "(C) MARCOS M SOUSA - 1995/"+TRAN(YEAR(DATE()),"@E 9999")
    @ 14,10 say M->EMAIL    := "EMAIL: mmstec@ieg.com.br"
    @ 15,10 say M->ICQ      := "UIN  : ICQ#51757082" 
    @ 16,10 say M->CELULAR  := "CEL  : (73) 9121-2933"
        @ 18,10 say "CONTAGEM REGRESSIVA:"+PADR(ALLTRIM(STR(CONTADOR)),10) color "BG+/n"
    SetColor(SalvaCor)
    IF LASTKEY()=27
       TONE(500,1)
       @ 18,10 SAY "CONTAGEM CANCELADA AOS "+PADR(ALLTRIM(STR(CONTADOR))+" SEGUNDOS",10)
       @ 20,10 SAY " "                                                     color "BG+/n"
       CONTADOR=0
    ENDIF
    ENDDO
 ENDIF
 ***************************************
 ***************************************
 M->NIVEL="0"
 IF LIBERA()
    ELSE
    ALERT('OPERA€AO INTERCEPTADA;;O sistema est  indisponivel no Momento',,"w+/n")
    QUIT
 ENDIF
 DBACESSO()
 AMBIENTE()
 IF FILE("FNE.DES")
    ERASE FNE.DES
    SAVE all like LOG* to FNE.LIG
 ELSE
    SAVE all like LOG* to FNE.LIG
 ENDIF
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

 SET PROCEDURE TO FNEARQ  // cria base de dados
 SET PROCEDURE TO FNEFUN  // fun‡äes principais
 SET PROCEDURE TO FNEMAN  // manuten‡Æo
 SET PROCEDURE TO FNEINC  // inclui
 SET PROCEDURE TO FNEALT  // altera
 SET PROCEDURE TO FNEEXC  // exclui
 SET PROCEDURE TO FNELOC  // localiza
 SET PROCEDURE TO FNEREL  // relatorio
 SET PROCEDURE TO FNEUTL  // utilitarios
 SET PROCEDURE TO FNESNH  // seguran‡a
 SET PROCEDURE TO FNEREG  // registrar

 SET MESSAGE TO 23 CENTER
 SET KEY 28 TO AJUDA()
 SET KEY -1 TO CALCULADORA()
 SET KEY -2 TO CALENDARIO()
 
******************* INICIO DO SISTEMA ********************
* SET VIDEOMODE TO 18 // so para clipper 5.3
SET COLOR TO "W+/N,N/B,,,B+/BG"
CLS
DbCria()
DbCompacta(05, 05, 21)
Principal()

FUNCTION PRINCIPAL
TONE(300,1)
DO WHILE .T.
   SETCOLOR("N+/B,BG+/B,,,BG+/B")
   ENTRADA("TELA PRINCIPAL")
   relevo(06, 56, 08, 73, .T.) // BOTOES
   relevo(09, 56, 11, 73, .T.) // BOTOES
   relevo(12, 56, 14, 73, .T.) // BOTOES
   relevo(15, 56, 17, 73, .T.) // BOTOES
   relevo(18, 56, 20, 73, .T.) // BOTOES     
   @ 07,58 PROMPT padR("1.Acha r pido" ,15) MESSAGE PADC('P/ LOCALIZAR REGISTROS RAPIDAMENTE, APERTE "1"',67)
   @ 10,58 PROMPT padR("2.Manuten‡”es" ,15) MESSAGE PADC('P/ LOCALISAR, ALTERAR E EXCLUIR REGISTROS APERTE "2"',67)
   @ 13,58 PROMPT padR("3.Relat¢rios " ,15) MESSAGE PADC('P/ IMPRIMIR RELATORIOS APERTE "3"',67)
   @ 16,58 PROMPT padR("4.Utilit rios" ,15) MESSAGE PADC('P/ ACESSO AOS UTILITARIOS APERTE "4"',67)
   @ 19,58 PROMPT padR("5.Sa¡da      " ,15) MESSAGE PADC('P/ SAIR DO SISTEMA APERTE "5"',67)
   DBMENSAGEM()
   OPCMENU=1
   MENU TO OPCMENU
   DO CASE
   CASE OPCMENU=1 
        *INCLUSAO()   
        ProcRapida()
   CASE OPCMENU=2
        MANUTENCAO()  
   CASE OPCMENU=3
        RELATORIO()   
   CASE OPCMENU=4
        UTILITARIO()  
   CASE OPCMENU=5 .OR. LASTKEY()=27
        SAIR=PERGUNTA("Deseja sair do sistema?")
        IF SAIR<>1
           PRINCIPAL()
        ENDIF
        EXIT
   ENDCASE
ENDDO
SETCOLOR("W/N")
CLS
M->LOGSAIDA = TIME()
LogoMarca()
?M->SISTEMA
?"Processamento finalizado em.:"+DTOC(DATE())+" ("+TIME()+")"
?"Tempo de uso estimado.......:"+ELAPTIME(M->LOGHORA,M->LOGSAIDA)
ERASE FNE.MSG  // APAGA ARQUIVO-MENSAGEM DE TENTATIVA DE ACESSO
ERASE FNE.LIG  // APAGA ARQUIVO-MENSAGEM DE SISTEMA LIGADO
SET CURSOR ON
* SET VIDEOMODE TO 3 // so para clipper 5.3
QUIT
******************* FINAL DO SISTEMA ********************

RETURN.T.

FUNCTION AMBIENTE
SETCANCEL(.T.)               // (.F.) desativa ALT-C/BREAK
SET EPOCH TO 1960            // prepara datas para o terceiro milˆnio
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
    @ 02,06 SAY M->AUTOR                                  color "bg+ /b"
    @ 03,06 SAY M->LNOME                                  color "bg  /b"
    @ 13,08 SAY PADC(M->SISTEMA                      ,44) color "W+  /b"
    @ 14,08 SAY PADC("Û²±° versÆo "+M->VERSAO+" °±²Û",44) color "B+  /b"
    @ 19,08 SAY PADC(M->AUTOR                        ,44) color "N+  /b"
    RETURN.T.                                 

           
