 *
 *******************************************************************************
 *                           (C) MMStec inform tica LTDA
 *******************************************************************************
 * Programa......: REGISTRO DE FUNCIONARIOS
 * Descri‡Æo.....: Programa desenvolvido para armazenamer registros de funcionarios
 * Autor.........: Marcos Morais de Sousa
 * Data..........: 20/01/1999 a 01/02/1999 
 * COMPILADOR EM.: CA-CLIPPER (5.2)
 * LINKADO COM...: RTLINK
 * BIBLIOTECA....: MMSTEC.LIB (P/Clipper v5.0 a 5.2)
 *
 * NOTA: 
 * MMStec ‚ uma biblioteca de fun‡äes desenvolvida por Marcos Morais de Sousa
 ******************************************************************************
 *
 M->AUTOR    := "(C) Marcos Morais de Sousa - 1995/"+TRAN(YEAR(DATE()),"@E 9999")
 *
 SETCANCEL(.F.)               // (.F.) desativa ALT-C/BREAK
 SET EPOCH TO 1960            // prepara datas para o terceiro milˆnio
 SET DATE FORMAT TO "dd,mm,yyyy"
 SET DATE BRIT
 dTRAVA=CTOD("01/07/99")
 vTRAVA=DTOC(dTrava)
 vTRAVA=vTRAVA+CHR(13)+CHR(10)+"ATENCAO: NAO APAGUE ESTE ARQUIVO"
 IF DATE()>=dTrava .and. !file("FLH.trv")
    SalvaCor=SetColor()
    setColor="w+/n"
    cls
    CONTADOR:=60
    DO WHILE CONTADOR>=1
    CONTADOR--
    Tone((60-CONTADOR)*100,1)
    Inkey(1)
    @ 08,10 say DTOC(DATE())+" "+TIME()                                color "BG+ /n"
    @ 10,10 say "SISTEMA NÇO REGISTRADO"                               color "RG+*/n"
    @ 12,10 say "Vocˆ tˆm 60 segundos para desligar este computador,"  color "w+/n"
    @ 13,10 say "ou o banco de dados sera eliminado."                         color "w+/n"
    @ 15,10 say "CONTAGEM REGRESSIVA:"+PADR(ALLTRIM(STR(CONTADOR)),10) color "BG+/n"
    @ 17,10 say "D£vidas: ligar para Marcos "                          color "n+/n"
    @ 18,10 say "Fone:    (073) 525-2344 ou 525-5932"                  color "n+/n"
    @ 19,10 say "e-mail:   m2s@uol.com.br"                             color "n+/n"
    SetColor(SalvaCor)
    IF LASTKEY()=27
       TONE(500,1)
       CLS
       ?'DTOC(DATE())'+' '+TIME()
       ?'SISTEMA NAO REGISTRADO'
       ?''
       ?'OPERACAO CANCELADA AOS "'+PADR(ALLTRIM(STR(CONTADOR))+'" SEGUNDOS.',10)
       ?'VOCE OPTOU PELA NAO ELIMINACAO DO BANCO DE DADOS'
       ?''
       ?'P/ REGISTRAR ESTE SISTEMA ENTRE EM CONTATO COM O AUTOR (MARCOS M. DE SOUSA)'
       ?'   telefone: (073) 525-2344 ou 525-5932'
       ?'   Celular:  (073) 921-9199'
       ?'   Internet mail:  m2s@uol.com.br'
       ?'' 
       ?M->AUTOR
       ?''
       QUIT
    ENDIF
    ENDDO
    CLS
    TONE(500,1)
    ALERT('A T E N C A O ;;'+alltrim(data())+';SEU "DRIVE C" NAO FOI FORMATADO;;'+ALLTRIM(M->AUTOR))
    SAVE ALL like vTRAVA TO FLH.TRV
 ENDIF
 *************
 IF !FILE("FLH.SYS") 
    ALERT('S I S T E M A   N A O   R E G I S T R A D O;;'+alltrim(data())+';;PARA NAO VER ESTA MENSAGEM NOVAMENTE, REGISTRE O SISTEMA;;'+ALLTRIM(M->AUTOR))
    TONE(500,1)
 ENDIF
 M->NIVEL="0"
 IF LIBERA()
    ELSE
    ALERT('OPERA€ÇO INTERCEPTADA;;O sistema est  indisponivel no Momento',,"w+/n")
    QUIT
 ENDIF
 M->AUTOR    := "(C) Marcos Morais de Sousa - 1995/"+TRAN(YEAR(DATE()),"@E 9999")
 M->EMAIL    := "m2s@uol.com.br"
 M->DONO1    := "BARRETO MATERIAL DE CONSTRU€ÇO - bmc@uol.com.br"
 M->DONO2    := "MFB Material de Constru‡Æo LTDA."
 M->DONO3    := "Av. Franz Gedeon, 297 Centro Jequi‚-Ba. CEP 45200-000"
 M->SISTEMA  := "REGISTRO DE FUNCIONARIOS"
 M->VERSAO   := "1.02"
 M->LOGPRO   := PROCNAME()+".EXE"
 M->LOGUSO   := "TODOS"
 M->LOGMAQ   := ALLTRIM(NETNAME())
 M->LOGDATA  := DTOC(DATE())
 M->LOGHORA  := TIME()
 *************
 DBACESSO()
 AMBIENTE()
 IF FILE("FLH.DES")
    ERASE FLH.DES
    SAVE all like LOG* to FLH.LIG
 ELSE
    SAVE all like LOG* to FLH.LIG
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

 SET PROCEDURE TO FLHARQ  // cria arquivos
 SET PROCEDURE TO FLHFUN  // fun‡äes principais
 SET PROCEDURE TO FLHMAN  // manuten‡Æo
 SET PROCEDURE TO FLHINC  // inclui
 SET PROCEDURE TO FLHALT  // altera
 SET PROCEDURE TO FLHEXC  // exclui
 SET PROCEDURE TO FLHLOC  // localiza
 SET PROCEDURE TO FLHREL  // relatorio
 SET PROCEDURE TO FLHUTL  // utilitarios
 SET PROCEDURE TO FLHSNH  // seguran‡a

 SET MESSAGE TO 23 CENTER
 SET KEY 28 TO AJUDA()
 SET KEY -1 TO CALCULADORA()
 SET KEY -2 TO CALENDARIO()
 SET COLOR TO "W+/N,N/B,,,B+/BG"
 CLS

 dBCRIA()
 dBCOMPACTA(05, 05, 21)
 PRINCIPAL()

FUNCTION PRINCIPAL
Tone(300,1)
DO WHILE.T.
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
LOGOMARCA()
?M->SISTEMA
?"EXECU€ÇO ENCERRADA EM:"+DTOC(DATE())+" ("+TIME()+")"
?"TEMPO DE USO ESTIMADO:"+ELAPTIME(M->LOGHORA,M->LOGSAIDA)
ERASE FLH.MSG  // APAGA ARQUIVO-MENSAGEM DE TENTATIVA DE ACESSO
ERASE FLH.LIG  // APAGA ARQUIVO-MENSAGEM DE SISTEMA LIGADO
QUIT
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
    @ 07, 08 SAY PADC(PAR,44)  COLOR "W+/R"
    SET CURSOR OFF
    @ 02,06 SAY M->AUTOR +" "+email                       color "bg+ /b"
    @ 03,06 SAY M->DONO2                                  color "bg  /b"
    @ 10,08 SAY PADC(M->SISTEMA                      ,44) color "W+  /b"
    @ 11,08 SAY PADC("Û²±° versÆo "+M->VERSAO+" °±²Û",44) color "B+  /b"
    @ 15,08 SAY PADR("SALARIO MINIMO ATUAL DE "+DTOC(M->DATA_ATUAL),44) color "R+  /b"
    @ 16,08 SAY PADR("R$ VALOR",44) color "R+  /b"
    @ 17,08 SAY PADR("R$"+ALLTRIM(STR(M->SALARIO_ATUAL)),44) color "R+  /b"
    @ 19,08 SAY PADC(M->AUTOR                        ,44) color "N+  /b"
    RETURN.T.                                 

           

