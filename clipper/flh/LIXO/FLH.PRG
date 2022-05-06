   *
   ****************************************************************************
   * (C) MMStec Informatica
   * Programa......: MMS FLH(R)
   * Descri‡Æo.....: Sistema para registro de cheques devolvidos
   *                 
   * Autor.........: Marcos Morais de Sousa
   ****************************************************************************
   *
   * Compilar com .: CA-CLIPPER (5x)
   * Exemplo ......: Clipper FLH
   * Linkar com....: RTLINK   fi FLH lib mmstec (P/Clipper v5.0 a 5.2)
   * Linkar com....: EXOSPACE fi FLH lib mmstec (P/Clipper superior a v5.2)
   * ou............: BLINKER  fi FLH lib mmstec
   *
   * NOTA: MMStec ‚ uma biblioteca de fun‡äes desenvolvida por Marcos Morais.
   *
   ***************************************************************************
   *
   # INCLUDE "INKEY.CH"
   # DEFINE INSERT  22
   # DEFINE ENTER   13
   # DEFINE HOME     1   
   # DEFINE END      6   
   # DEFINE DEL      7
   # DEFINE ESC     27
   # DEFINE F1      28
   # DEFINE F2      -1
   # DEFINE F3      -2
   # DEFINE F4      -3
   # DEFINE F5      -4
   # DEFINE F6      -5
   # DEFINE F7      -6
   # DEFINE F8      -7
   # DEFINE F9      -8
   # DEFINE F10     -9
   # DEFINE F11     -40
   # DEFINE F12     -41
   # DEFINE SIM      1
   # DEFINE NAO      2
   CLS
   *SET KEY F1  TO AJUDA()
   *SET KEY F11 TO EDITOR()
   *SET KEY F12 TO TROCAUSUARIO()
   SET DATE FORMAT TO "dd,mm,yyyy"
   SET DATE BRIT
   SET EPOCH TO 1900     
   SET EXCLUSIV ON
   SET DELETE ON
   SET BELL ON
   SET TALK OFF
   SET SOFTSEEK OFF
   SET SCORE Off

   ANO2000  := ALLTRIM(STR(CTOD("01/01/2000")-DATE()))
   ANO2000  := '"FALTAM '+ANO2000+' DIAS PARA O ANO 2000"'
   PROGRAMA := PROCNAME()+".EXE"
   VERSAO   :="1.02"
   VERSAODE :=DIRECTORY("&PROGRAMA")
   MAQUINA  := ALLTRIM(NETNAME())
   USUARIO  := SPACE(58)
   DATAENTRA:= DTOC(DATE())
   ENTRADA  := TIME()
   M->LOGHORA:=TIME()
   ACAO     := time()+"-Entrada normal"+CHR(13)+CHR(10)
   FILTRO1  := space(35)
   FILTRO2  := space(35)
   AUTOR    := "(C) Marcos Morais de Sousa - 1995/"+TRAN(YEAR(DATE()),"@E 9999")
   SISTEMA  := "Registro de Funcion rios"
   M->EMPRESA  := "MFB Material de Constru‡Æo LTDA"
   M->SENHA :=SPACE(10)
   M->CODIGO:=0
   IF FILE("FLH.LIG")
      RESTORE FROM FLH.LIG ADDITIVE
      SETBLINK(.F.)
      ALERT("SISTEMA EM USO ;OU; DESLIGADO INCORRETAMENTE;;"+REPL("Ä",20)+";Maquina "+LOGMAQ+";Programa "+LogPRO+";Usu rio "+LogUSO+";; * Entrada *;"+LogINI,,"N/RG+*")
      SETBLINK(.T.)
      QUIT
   ENDIF

   DO WHILE .T.
       @ 04,03 SAY PADC("&SISTEMA",77)                         COLOR "BG"
       @ 05,03 SAY PADC("&AUTOR",77)                           COLOR "BG"
       @ 07,03 SAY PADC(dbData(),77)                           COLOR "W+"
       @ 08,03 SAY PADC(ANO2000,77)                            COLOR "W+"
       @ 10,10,16,71 box("        Û")                        color "b/n"
       RELEVO( 10,10, 16,71,.T.)
       @ 12,12 SAY "Nome" color "W+/B+"
       @ 14,12 get USUARIO pict "@!" color "W+/BG"
       SET CURSOR ON
       READ
       SET CURSOR OFF
       if empty(USUARIO) .AND. lastkey()<>5
          alert("Preenchimento obrigatorio")
          loop
       endif
       if LEN(ALLTRIM(USUARIO)) < 4
          alert("Usuario invalido;"+Repl("Ä",15)+";Digite seu nome corretamente",,"W+/B")
          loop
       endif
       exit
   ENDDO
   USUARIO  := IIF(EMPTY(USUARIO),"USUARIO ESTRANHO",TRIM(UPPER(USUARIO)))
   SET CURSOR ON
   CLS
   LOGPRO := PROGRAMA
   LOGMAQ := MAQUINA
   LOGUSO := USUARIO
   LOGINI := DATAENTRA+"-"+ENTRADA
   SAVE all like LOG* to FLH.LIG

   if (!file("dBFLH.DBF"))
      fcampo:= {}
      AAdd(fcampo, {"DATA"      , "D", 08, 0})
      AAdd(fcampo, {"CODIGO"    , "C", 06, 2})
      AAdd(fcampo, {"EMPREGADO" , "C", 30, 0})
      AAdd(fcampo, {"FUNCAO"    , "C", 30, 0})
      AAdd(fcampo, {"ORIGEM"    , "C", 30, 2})
      AAdd(fcampo, {"SALARIO"   , "N", 10, 2})
      AAdd(fcampo, {"ADMISSAO"  , "D", 08, 0})
      AAdd(fcampo, {"DEMISSAO"  , "D", 08, 0})

      AAdd(fcampo, {"ENDERECO"  , "C", 30, 0})
      AAdd(fcampo, {"BAIRRO"    , "C", 30, 0})
      AAdd(fcampo, {"CEP"       , "C", 09, 0})
      AAdd(fcampo, {"CIDADE"    , "C", 30, 0})
      AAdd(fcampo, {"ESTADO"    , "C", 02, 0})
      AAdd(fcampo, {"TEL"       , "C", 15, 0})
      AAdd(fcampo, {"RG"        , "C", 15, 0})
      AAdd(fcampo, {"CPF"       , "C", 15, 0})
      AAdd(fcampo, {"RG"        , "C", 15, 0})
      AAdd(fcampo, {"PROFISSION", "C", 15, 0})
      AAdd(fcampo, {"NASCI"     , "D", 08, 0})

      dbcreate("dBFLH", fcampo)
      SELE 1
      use dBFLH
      index on ORIGEM+EMPREGADO to idFLH01.NTX
      index on EMPREGADO+ORIGEM to idFLH02.NTX
      index on ORIGEM+DTOC(DEMISSAO) to idFLH03.NTX
   else
      SELE 1
      use dBFLH
      index on ORIGEM+EMPREGADO to idFLH01.NTX
      index on EMPREGADO+ORIGEM to idFLH02.NTX
      index on ORIGEM+DTOC(DEMISSAO) to idFLH03.NTX
   endif


   Principal()


function manutencao
*
SELE 1
use dBFLH
index on ORIGEM+EMPREGADO to idFLH01.NTX
index on EMPREGADO+ORIGEM to idFLH02.NTX
SELE 1
SET ORDER TO 2
GOTO TOP
*
RELEVO(05, 05, 21, 54,.F.,,2) // tela EQUERDA
RELEVO(06, 06, 08, 53,.T.,,2) // BARRA DE TITULO
RELEVO(09, 06, 20, 53,.T.,,2) // BARRA INTERNA
@ 07, 08 SAY PADC("Manuten‡Æo",44)  COLOR "W+/R"
  BOTOES()
  keyboard CHR(4)
  private titulo[16]
   titulo[1]:= "DIA  DATA"
   titulo[2]:= "CODIGO"   
   titulo[3]:= "FUNCIONARIO"     
   titulo[4]:= "FUNCAO"
   titulo[5]:= "ORIGEM"     
   titulo[6]:= "SALARIO"  
   titulo[7]:= "DIA ADMISSAO"       
   titulo[8]:= "DIA DEMISSAO"
   titulo[9]:= "ENDERECO" 
   titulo[10]:= "BAIRRO"
   titulo[11]:= "CEP"
   titulo[11]:= "CIDADE"
   titulo[13]:= "ESTADO"
   titulo[14]:= "TEL"
   titulo[15]:= "CPF"
   titulo[16]:= "DIA  NACIMENTO"


  public mascara[16]
   mascara[1]:= "@!"
   mascara[2]:= "@!"
   mascara[3]:= "@!"
   mascara[4]:= "@!"
   mascara[5]:= "@!"
   mascara[6]:= "@!"
   mascara[7]:= "@!"
   mascara[8]:= "@!"
   mascara[9]:= "@!"
   mascara[10]:= "@!"
   mascara[11]:= "@!"
   mascara[12]:= "@!"
   mascara[13]:= "@!"
   mascara[14]:= "@!"
   mascara[15]:= "@!"
   mascara[16]:= "@!"

  public registro[16]
   registro[1]:= 'dbData(data)'
   registro[2]:= 'CODIGO'   
   registro[3]:= 'EMPREGADO'
   registro[4]:= 'FUNCAO'    
   registro[5]:= 'ORIGEM'
   registro[6]:= 'SALARIO'  
   registro[7]:= 'dBdata(ADMISSAO)'
   registro[8]:= 'dBdata(DEMISSAO)'
   registro[9]:= 'ENDERECO' 
   registro[10]:= 'BAIRRO'
   registro[11]:= 'CEP'
   registro[12]:= 'CIDADE'
   registro[13]:= 'ESTADO'
   registro[14]:= 'TEL'
   registro[15]:= 'CPF'
   registro[16]:= 'DBDATA(NASCI)'
  DBEDIT(10, 08, 16, 51,REGISTRO,"EDITA",MASCARA,TITULO,"ÄÄÄ","   ","ÄÄÄ",.F.)
return.t.

FUNCTION EDITA(MODO,INDICE)
LOCAL TECLA  
TECLA := LASTKEY()
CAMPO := REGISTRO[INDICE]

DO CASE
   CASE MODO = 0
        SET COLOR TO W/B,W+ /BG,B+/N,B+/N
        @ 17,08 SAY ORIGEM
        @ 18,08 SAY EMPREGADO+"          "
        @ 19,08 SAY "SALARIO:"
        @ 19,18 SAY padl("MES: $"+ALLTRIM(STR(SALARIO)),15)       COLOR "RG /b"
        @ 19,35 SAY padl("SEMANAL: $"+ALLTRIM(STR(SALARIO/4)),15) COLOR "RG+/b"
        
        @ 22,02 SAY SPACE(76)       color "BG+/B"
        @ 23,05 say padc(DATA(),70) color "BG+/B"
        IF !EMPTY(DEMISSAO)
           @ 18,08 SAY EMPREGADO+" DEMITIDO "  color "RG+/B"
           TONE(500)
           TONE(500)
        ENDIF
        SET CURSOR OFF
        RETURN(1)

   CASE MODO = 1
        @ 23, 05 SAY PADC("Inicio do Arquivo",70) COLOR "W+/B"
        SET CURSOR OFF
        RETURN(1)

   CASE MODO = 2
        @ 23, 05 SAY PADC("Final do Arquivo",70) COLOR "W+/B"
        SET CURSOR OFF
        RETURN(1)
      
   CASE MODO = 3
        SAVE SCREEN TO TELA_MODO3
        @ 23, 05 SAY PADC("Arquivo Vazio",70) COLOR "W+/B"
        ADMISSAO()
        SET CURSOR OFF
        RESTORE SCREEN FROM TELA_MODO3
        RETURN(2)
      
   CASE MODO = 4
        IF TECLA = ESC
           PRINCIPAL()
           RETURN(0) // sai do sistema

          ELSEIF TECLA = F1
                 SAVE SCREEN TO TELA
                 CORATUAL=SETCOLOR()
                 SETCOLOR("W+/B")
                 RELEVO(05, 05, 21, 54,.F.,,2) // tela EQUERDA
                 RELEVO(06, 06, 08, 53,.T.,,2) // BARRA DE TITULO
                 RELEVO(09, 06, 20, 53,.T.,,2) // BARRA INTERNA
                 @ 07, 08 SAY PADC("Gerenciador do Sistema",44)  COLOR "W+/R"
                 BOTOES()
                 do while LastKey()<>27
                    inkey(0.05)
                    @ 10,08 SAY "(C) Marcos Morais de Sousa - 1995/"+TRAN(YEAR(DATE()),"@E 9999") color "bg+/B"
                    @ 12,08 SAY "Programa        :"+trim(programa)
                    @ 13,08 SAY "Maquina         :"+trim(maquina)    
                    @ 14,08 SAY "Usuario         :"+trim(usuario)   
                    @ 15,08 SAY "Data da entrada :"+trim(dtoc(date()))
                    @ 16,08 SAY "Hora da entrada :"+trim(entrada)
                    @ 17,08 SAY "Hora atualizada :"+trim(time())
                    @ 18,08 SAY "Cron“metro      :"
                    @ 18,26 say SubStr(ELAPTIME(ENTRADA,time()),1,2)+"ø";
                               +SubStr(ELAPTIME(ENTRADA,time()),4,2)+"'";
                               +SubStr(ELAPTIME(ENTRADA,time()),7,2)+'"'  color "RG+ / b"
                 enddo
                 PACK
                 SETCOLOR(CORATUAL)
                 RESTORE SCREEN FROM TELA
                 RETURN(2)

          ELSEIF TECLA = 80 .OR. TECLA = 112
                 SAVE SCREEN TO TELA
                 CONSULTA()
                 SET ORDER TO 2
                 RESTORE SCREEN FROM TELA
                 RETURN(2)
          
          ELSEIF TECLA = 69 .OR. TECLA = 101
                 save screen to tela
                 set cursor on
                 CAMPO=FIELDNAME(INDICE)
                 if type("&campo")="D"
                    @ ROW(),COL()+5 GET &CAMPO COLOR "W+/R"
                    ACAO=ACAO+TIME()+"-Edicao de "+dtoc(data)+CHR(13)+CHR(10)
                 elseif type("&campo")="M"
                   MEMOTELA=SAVESCREEN(8,9,21,71)
                   RELEVO(08,09,19,71,.T.)
                   RELEVO(10,10,18,70,.T.)
                   set color to w+/b+*
                   @ 09,11 say padC("Editando Observacoes - Ctrl+W Grava",58)
                   REPLACE &CAMPO WITH MEMOEDIT(&CAMPO,11,12,17,69,.T.)
                   RESTSCREEN(8,9,19,71,MEMOTELA)
                   set cursor off
                   acao=acao+time()+"-Edita memo "+campo+CHR(13)+CHR(10)
                 else
                    @ ROW(),COL() GET &CAMPO   COLOR "W+/R"
                    ACAO=ACAO+TIME()+"-Edicao de "+campo+CHR(13)+CHR(10)
                 endif
                 @ 23, 05 SAY PADC("Edicao de registro ativada",70) COLOR "W+/B"
                 read
                 restore screen from tela
                 set cursor off
                 keyboard CHR(4)
                 RETURN(2)


          ELSEIF TECLA = 73 .OR. TECLA = 105
                 SAVE SCREEN TO TELA_73
                 if (!isprinter())
                    alert("* IMPRESSORA DESLIGADA *")
                 else
                    relatorio()
                    SET DEVI TO SCREEN
                    SET FILTER TO
                 endif
                 RESTORE SCREEN FROM TELA_73
                 RETURN(2)

          ELSEIF TECLA = 076 .OR. TECLA = 108
                 SAVE SCREEN TO TELA_L
                 DO WHILE.T.
                    SETCOLOR("N+/B,BG+/B,,,BG+/B")
                    ENTRADA("TELA PRINCIPAL")
                    relevo(06, 56, 08, 73, .T.) // BOTOES
                    relevo(09, 56, 11, 73, .T.) // BOTOES
                    relevo(18, 56, 20, 73, .T.) // BOTOES
                    @ 07,58 PROMPT padR("1.Admissäes         ",15) MESSAGE PADC('P/ IMPRIMIR FOLHA DE PAGAMENTO APERTE "1"',67)
                    @ 10,58 PROMPT padR("2.Demissäes         ",15) MESSAGE PADC('P/ LOCALISAR, ALTERAR E EXCLUIR REGISTROS APERTE "2"',67)
                    @ 19,58 PROMPT padR("3.Retorna           ",15) MESSAGE PADC('P/ RETORNAR APERTE "3"',67)
                    OPCLANC=1
                    MENU TO OPCLANC
                    DO CASE
                       CASE OPCLANC=1 
                            ADMISSAO()
                            exit
                       CASE OPCLANC=2
                            DEMISSAO()
                            exit
                       CASE OPCLANC=3 .OR. LASTKEY()=27
                            exit
                    ENDCASE
                 ENDDO
                 RESTORE SCREEN FROM TELA_L
                 RETURN(2)

          ELSEIF TECLA = 65 .OR. TECLA = 97
                 SAVE SCREEN TO TELA
                 M->SALVAREG=RECNO()
                 AVISO="ATEN€AO: esta rotina elimina definitivamente;"+;
                       "o registro arquivado.;;Vocˆ tem certeza;"+;
                       "que deseja prosseguir?"
                 IF (Alert(AVISO,{ padc("NAO",05), padc("SIM",05) } ,"W+/R") == 2)
                    M->SALVAREG=M->SALVAREG-1
                    DELETE
                    PACK
                 ENDIF
                 RESTORE SCREEN FROM TELA
                 GOTO M->SALVAREG
                 RETURN(2)

          ELSEIF TECLA = DEL
                 ALERT("P/ EXCLUIR UM REGISTRO APERTE [A]")
                 RETURN(1)

          ELSEIF TECLA = ENTER
                 CAMPO=FIELDNAME(INDICE)
                 IF TYPE("&CAMPO")="M"
                   MEMOTELA=SAVESCREEN(8,9,21,71)
                   RELEVO(08,09,19,71,.T.)
                   RELEVO(10,10,18,70,.T.)
                   set color to w+/b+*
                   @ 09,11 say padC("Visualizando Observa‡”es",58)  color "w+/b"
                   REPLACE &CAMPO WITH MEMOEDIT(&CAMPO,11,12,17,68,.f.)
                   RESTSCREEN(8,9,19,71,MEMOTELA)
                   SET CURSOR OFF
                   acao=acao+time()+"-Edita memo "+campo+CHR(13)+CHR(10)
                 ELSE
                 SAVE SCREEN TO TELA
                 RELEVO(05, 05, 21, 54,.F.,,2) // tela EQUERDA
                 RELEVO(06, 06, 08, 53,.T.,,2) // BARRA DE TITULO
                 RELEVO(09, 18, 19, 53,.T.,,1) // tela EQUERDA
                 @ 07, 07 SAY PADC("FICHA DE FUNCIONARIO",45) COLOR "W+/R"
                 @ 10, 07 SAY PADL("Codigo:"       ,10)  color "Bg+/b"
                 @ 11, 07 SAY PADL("Func.:"  ,10)  color "Bg+/b"
                 @ 12, 07 SAY PADL("Funcao:" ,10)  color "Bg+/b"
                 @ 13, 07 SAY PADL("Salario:"      ,10)  color "Bg+/b"
                 @ 14, 07 SAY PADL("Vale semanal:" ,10)  color "Bg+/b"
                 @ 15, 07 SAY PADL("Admissao:"     ,10)  color "Bg+/b"
                 @ 16, 07 SAY PADL("Origem:"       ,10)  color "Bg+/b"
                 @ 10, 19 SAY CODIGO       PICT("@!")        color "W+ /B,N/bG"
                 @ 11, 19 SAY EMPREGADO    PICT("@!")        color "W+ /B,N/bG"
                 @ 12, 19 SAY FUNCAO       PICT("@!")        color "W+ /B,N/bG"
                 @ 13, 19 SAY SALARIO      PICT("@!")        color "W+ /B,N/bG"
                 @ 14, 19 SAY SALARIO/4    PICT("@!")        color "rg+/b,N/bG"
                 @ 15, 19 SAY ADMISSAO     PICT("@!")        color "W+ /B,N/bG"
                 @ 16, 19 SAY ORIGEM      PICT("@!")        color "W+ /B,N/bG"
                 @ 20, 07 SAY PADL("PµGINA: 01",45)
                 INKEY(30)
                 TONE(500)
                 RELEVO(09, 18, 19, 53,.T.,,1) // tela EQUERDA
                 @ 10, 07 SAY PADL("ENDERECO"        ,10)   color "Bg+/b"
                 @ 11, 07 SAY PADL("BAIRRO"          ,10)   color "Bg+/b"
                 @ 12, 07 SAY PADL("CEP"             ,10)   color "Bg+/b"
                 @ 13, 07 SAY PADL("CIDADE"          ,10)   color "Bg+/b"
                 @ 14, 07 SAY PADL("ESTADO"          ,10)   color "Bg+/b"
                 @ 15, 07 SAY PADL("TELEFONE"        ,10)   color "Bg+/b"
                 @ 16, 07 SAY PADL("CPF"             ,10)   color "Bg+/b"
                 @ 17, 07 SAY PADL("R.GERAL"         ,10)   color "Bg+/b"
                 @ 18, 07 SAY PADL("C. PROFISSIONAL" ,10)   color "Bg+/b"
                 @ 20, 07 SAY PADL("NASCIMENTO"      ,10)   color "Bg+/b"
                 @ 10, 19 SAY ENDERECO     COLOR "W+/B,N/bG"
                 @ 11, 19 SAY BAIRRO       COLOR "W+/B,N/bG"
                 @ 12, 19 SAY CEP          COLOR "W+/B,N/bG"
                 @ 13, 19 SAY CIDADE       COLOR "W+/B,N/bG"
                 @ 14, 19 SAY ESTADO       COLOR "W+/B,N/bG"
                 @ 15, 19 SAY TEL          COLOR "W+/B,N/bG"
                 @ 16, 19 SAY CPF          COLOR "W+/B,N/bG"
                 @ 17, 19 SAY RG           COLOR "W+/B,N/bG"
                 @ 18, 19 SAY PROFISSION   COLOR "W+/B,N/bG"
                 @ 20, 19 SAY NASCI        COLOR "W+/B,N/bG"
                 @ 20, 07 SAY PADL("PµGINA: 02",45)
                 INKEY(30)
                 RESTORE SCREEN FROM TELA
                 RETURN(1)
                 ENDIF
          ELSE
                 BOTOES()
                 RETURN(1)
          ENDIF
      OTHERWISE
          SET COLOR TO W/B,W+ /BG,B+/N,B+/N
          @ 22,02 SAY SPACE(76) color "BG+/B"
          @ 23,05 say padc(DATA(),70) color "BG+/B"
          SET CURSOR OFF
          RETURN(1)
      ENDCASE

FUNCTION CONSULTA   
     set cursor on
     SELE 1
     USE DBFLH INDEX idFLH01,idFLH02
     SELE 1
     SET ORDER TO 2
     nRec  := 0
     lDone := .F.
     m->psq1   := SPACE(30)
     do while .T.
          set cursor on
          @ 23,05 say PADR("FUNCIONARIO: ",70)         COLOR "RG+/B"
          @ 23,21 get M->PSQ1 PICT "@!"                COLOR "W+/N"
          read
          set cursor off
          if lastKey()=27
             exit
          endif
          nRec := Recno()
          SEEK TRIM(M->PSQ1)
          if !found()
             tone(1000, 1)
             tone(800, 2)
             tone(1200, 1)
             ALERT('&SISTEMA.;; O sistema n„o p“de localizar uma correspondˆcia para "'+alltrim(m->PSQ1)+'"; Caso vocˆ tenha certeza sobre a existˆncia dos dados procurados, verifique a digita‡„o e tente novamente.;;;')
             goto nRec
             loop
           else
             lDone := .T.
             @ 23, 05 SAY PADC("Registro localizado!",70) COLOR "W+/B"
          endif                                     
          EXIT
     ENDDO
SET DELETED ON
RETURN.T.

********************************
PROCEDURE GRAVALOG(ENTRADA,SAIDA)
TEMPO=ELAPTIME(ENTRADA,SAIDA)
TEMPO   :=ELAPTIME(ENTRADA,SAIDA)
IF FILE("FLH.TXT")
   TAM=DIRECTORY("FLH.TXT","2")                                                                                                   
   IF TAM[1,2] > 60000                                                       
      ERASE FLH.TXT
      ALERT("O aquivo de parametros;"+TAM[1,1]+";foi renovado.;;"+REPL("Ä",20)+";Motivo;Tamanho excedido",,"W+/B")
      ACAO=ACAO+time()+"-Renovado "+TAM[1,1]+" por excesso de tamanho"+CHR(13)+CHR(10)
      TEXTO=""
      ELSE
      TEXTO=MEMOREAD("FLH.TXT")
   ENDIF
   ELSE
   TEXTO=""
ENDIF
TEXTO+="Estacao: " + MAQUINA+CHR(13)+CHR(10)
TEXTO+="Usuario: " + USUARIO+CHR(13)+CHR(10)
TEXTO+="Data   : " + DTOC(DATE())+CHR(13)+CHR(10)
TEXTO+="Inicio : " + ENTRADA+CHR(13)+CHR(10)
TEXTO+="Termino: " + SAIDA+CHR(13)+CHR(10)
TEXTO+="Total  : " + TEMPO+CHR(13)+CHR(10)
TEXTO+=REPLICATE("=",50)+CHR(13)+CHR(10)
MEMOWRIT("FLH.TXT",TEXTO)
********************************
function RELATORIO
   SELE 1
   USE DBFLH INDEX iDflh01,iDflh02,iDflh03
   SELE 1
   SET ORDER TO 1
   GOTO TOP
   RELEVO(05, 05, 21, 54,.F.,,2) // tela EQUERDA
   RELEVO(06, 06, 08, 53,.T.,,2) // BARRA DE TITULO
   RELEVO(09, 18, 18, 53,.F.,,2) // tela EQUERDA
   FILTRO1 :=SPACE(15)
   FILTRO2 :=CTOD("  /  /    ")
   @ 07, 07 SAY PADC("FOLHA DE PAGAMENTO",45) COLOR "W+/R"
   @ 11, 08 say padl("ORIGEM: ",10) color "BG+/B"
   @ 11, 19 get FILTRO1 PICT("@!")   color "BG+/N,N/BG"
   SET CURSOR ON
   READ
   @ 19, 07 SAY PADC("ENVIANDO REGISTROS PARA IMPRESSORA. AGUARDE!",45) COLOR "W+/R"
   SET CURSOR OFF
   IF LASTKEY()=27
      ALERT("IMPRESSAO ABORTADA")
      MANUTENCAO()
   ENDIF
   SET FILTER TO ORIGEM=FILTRO1 .AND. DEMISSAO=FILTRO2
   if (!(ORIGEM = FILTRO1 .AND. DEMISSAO=FILTRO2 ))
      relevo(11, 22, 14, 44, .T.,"R+/R")
      @ 19,23 SAY PADC("ENVIANDO REGISTRO "+STRZERO(RECNO(),4),21) COLOR "W  /R"
      @ 13,23 SAY PADC("AGUARDE",21)                               COLOR "W*+/R"
      skip
   endif
   set device to printer
   Total    := 0
   Linha    := 0
   Pagina   := 0
   nRegistro:=0
   do while (!EOF())
      @  linha+0,00 say ""
      if (linha == 0)
         Pagina++
         @ linha+1,  00 say padC(M->EMPRESA,80)
         @ linha+2,  00 say padC('Folha de Pagamento',80)
         @ linha+4,  00 say padR('ORIGEM: "'+ ALLTRIM(Filtro1) +'"',80)
         @ linha+5,  00 say Repl("=",80)
         @ linha+6,  00 say "Codigo"
         @ linha+6,  10 say "Funcionario"
         @ linha+6,  43 say padl("Valor",10)
         @ linha+6,  54 say "Assinatura"
         @ linha+7,  00 say Repl("=",80)
         linha = 8
      endif
      @ linha+0,  00 say codigo
      @ linha+0,  10 say ALLTRIM(EMPREGADO)+REPL(".",30-LEN(ALLTRIM(EMPREGADO)))
      @ linha+0,  43 say "_______,__"
      @ linha+0,  54 say repl("_",25)
      LINHA++
      nREGISTRO++
      TOTAL=TOTAL+SALARIO
      skip
      *
      if (linha >= 45 .OR. EOF())
         if (EOF())
            TOT_01(2)
            exit
         else
            TOT_01(1)
         endif
         linha:=0
      endif
   ENDDO
   EJECT
   SET DEVI TO SCREEN
   SET FILTER TO
   SET ORDER TO 2
   RETURN.T.

FUNCTION TOT_01
PARA PAR1
IF PAR1=2                                
   @ LINHA+01,000 SAY "PREVISAO SEMANA:"+str(TOTAL/4,10,2)
   @ LINHA+01,030 SAY PADL("Total: ",10)
   @ LINHA+01,043 SAY "_______,__"
   @ LINHA+02,000 SAY "PREVISAO MES   :"+str(TOTAL,10,2)
   @ LINHA+04,000 SAY "= (FIM) "+REPL("=",71)
   ELSE
   @ LINHA+01,000 SAY "= (CONTINUA) "+REPL("=",77)
ENDIF       
IF PAR1=2
   @ LINHA+06,000 SAY PADC("Declaro para os devidos fins e a quem possa interessar que recebi a",80)
   @ LINHA+07,000 SAY PADC("quantia em dinheiro escrita a esquerda da minha assinatura.",80) 
   @ LINHA+09,000 SAY "NUMERO DE FUNCINARIOS..: "+ALLTRIM(STR(RECNO()))
   @ LINHA+10,000 SAY "FUNCIONARIOS IMPRESSOS.: "+ALLTRIM(STR(nREGISTRO))
   @ LINHA+11,000 SAY "RELATORIO IMPRESSO POR "+ALLTRIM(UPPER(Usuario))+"."
ENDIF
@ 58,00 say padR(AUTOR,80)
@ 59,00 say padR(DATA()+"-"+TIME(),40)+padL("P gina:" + alltrim(str(PAGINA)),40)
RETURN


FUNCTION RELEVO(Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7)
   local Local1, Local2, Local3, Local4
   Local4:= SetColor()
   if (Arg6 = Nil)
      Arg6:= "B"
   endif
   if (Arg7 = NIL .OR. Arg7<> 2)
      Arg7:= 1
      else
      Arg7:= 2
   endif
   Local2:= "N /" + Arg6 
   Local3:= "B+/" + Arg6 
   if (Arg5 = Nil)
      Arg5:= .F.
   endif
   ************************************************
   if (Arg5)
      set color to (Local2)
   else
      set color to (Local3)         
   endif
   @ Arg1, Arg2 clear to Arg3, Arg4
   IF Arg7 = 1
      @ Arg1, Arg2 say "Ú" 
      @ Arg3, Arg2 say "À" + Replicate("Ä", Arg4 - Arg2 - 1)
   else
     @ Arg1, Arg2 say "É" 
     @ Arg3, Arg2 say "È" + Replicate("Í", Arg4 - Arg2 - 1)
   endif
   if (Arg3 - Arg1 == 2)
      if arg7=1
         @ Arg1 + 1, Arg2 say "³"
         else
         @ Arg1 + 1, Arg2 say "º"
      endif
   else
      if arg7=1
         @ Arg1 + 1, Arg2 to Arg3 - 1, Arg2 
         else
         @ Arg1 + 1, Arg2 to Arg3 - 1, Arg2 double
      endif
   endif
   ************************************************
   if (Arg5)
      set color to (Local3)
   else
      set color to (Local2)
   endif
   if (Arg3 - Arg1 == 2)
      if Arg7=1
         @ Arg1 + 1, Arg4 say "³"
         else
         @ Arg1 + 1, Arg4 say "º"
     endif
   else
     if Arg7=1
        @ Arg1 + 1, Arg4 to Arg3 - 1, Arg4 
        else
        @ Arg1 + 1, Arg4 to Arg3 - 1, Arg4 double
     endif
   endif
   if arg7=1
      @ Arg1, Arg2 + 1 say Replicate("Ä", Arg4 - Arg2 - 1) + "¿"
      @ Arg3, Arg4 say "Ù"
      else
      @ Arg1, Arg2 + 1 say Replicate("Í", Arg4 - Arg2 - 1) + "»"
      @ Arg3, Arg4 say "¼"
   endif
   set color to (Local4)
   return Nil

                 FUNCTION BOTOES
                 RELEVO(06, 56, 08, 73, .T.) 
                 RELEVO(09, 56, 11, 73, .T.) 
                 RELEVO(12, 56, 14, 73, .T.) 
                 RELEVO(15, 56, 17, 73,.T.)
                 RELEVO(18, 56, 20, 73,.T.)
                 @ 07,57 SAY "[ ] esquisar" COLOR ("b+/B")
                 @ 07,58 SAY "P"            COLOR ("W+/B")
                 @ 10,57 say "[ ] ditar"    COLOR ("b+/B")
                 @ 10,58 SAY "E"            COLOR ("W+/B")
                 @ 13,57 say "[ ] pagar"    COLOR ("b+/B")
                 @ 13,58 SAY "A"            COLOR ("W+/B")
                 @ 16,57 say "[ ] an‡ar"    COLOR ("b+/B")
                 @ 16,58 SAY "L"            COLOR ("W+/B")
                 @ 19,57 say "[ ] mprimir"  COLOR ("b+/B")
                 @ 19,58 say "I"            COLOR ("W+/B")
                 RETURN


FUNCTION PRINCIPAL
DO WHILE.T.
   SETCOLOR("N+/B,BG+/B,,,BG+/B")
   ENTRADA("TELA PRINCIPAL")
   relevo(06, 56, 08, 73, .T.) // BOTOES 
   relevo(09, 56, 11, 73, .T.) // BOTOES
   relevo(12, 56, 14, 73, .T.) // BOTOES
   @ 07,58 PROMPT padR("1.Relat¢rios        ",15) MESSAGE PADC('P/ IMPRIMIR FOLHA DE PAGAMENTO APERTE "1"',67)
   @ 10,58 PROMPT padR("2.Manuten‡äes       ",15) MESSAGE PADC('P/ LOCALISAR, ALTERAR E EXCLUIR REGISTROS APERTE "2"',67)
   @ 13,58 PROMPT padR("3.Sa¡da             ",15) MESSAGE PADC('P/ SAIR DO SISTEMA APERTE "3"',67)
                ALERT("ATEN€AO: assim como nossa casa precisa ser limpa,;"+;
                       "todo sistema PRECISA ESTAR ATUALIZADO.;;N„o se esque‡a de atualizar os dados de seus sistemas;"+;
                       "para melhor funcionamento dos mesmos")
                
   OPCMENU=1
   MENU TO OPCMENU
   DO CASE
   CASE OPCMENU=1 
        SAVE SCREEN TO TELA_R
        if (!isprinter())
           alert("* IMPRESSORA DESLIGADA *")
           else
           RELATORIO()
           SET DEVI TO SCREEN
           SET FILTER TO
        endif
        RESTORE SCREEN FROM TELA_R
   CASE OPCMENU=2
        MANUTENCAO()
   CASE OPCMENU=3 .OR. LASTKEY()=27
        SAIR=PERGUNTA("Deseja sair do sistema?")
        IF SAIR<>1
           PRINCIPAL()
        ENDIF
        EXIT
   ENDCASE
ENDDO
SETCOLOR("W/N")
CLS
 ALERT("ATEN€AO: Assim como nossa casa precisa ser limpa,;"+;
       "todo sistema PRECISA ESTAR ATUALIZADO.;;N„o se esque‡a de atualizar os dados de seus sistemas;"+;
       "para melhor funcionamento dos mesmos")
M->LOGSAIDA = TIME()
SET COLOR TO W/N
CLS
SAIDA = TIME()
ACAO   +=+time()+"-Saida normal "+CHR(13)+CHR(10)
DES     = CHR(13)+CHR(10)
DES    +="MAQUINA  : " + MAQUINA+CHR(13)+CHR(10)
DES    +="PROGRAMA : " + PROGRAMA+CHR(13)+CHR(10)
DES    +="USUARIO  : " + USUARIO+CHR(13)+CHR(10)
DES    +="DATA     : " + DTOC(DATE())+CHR(13)+CHR(10)
DES    +="INICIO   : " + ENTRADA+CHR(13)+CHR(10)
DES    +="TERMINO  : " + TIME()+CHR(13)+CHR(10)
DES    +="TOTAL    : " + ELAPTIME(ENTRADA,TIME())+CHR(13)+CHR(10)
DES    +="HISTORICO: " + CHR(13)+CHR(10)+ACAO+CHR(13)+CHR(10)
GRAVALOG(ENTRADA,SAIDA)
ERASE FLH.LIG
SAVE all like DES to FLH.DES
LOGOMARCA()
?M->SISTEMA
?"EXECU€ÇO ENCERRADA EM:"+DTOC(DATE())+" ("+TIME()+")"
?"TEMPO DE USO ESTIMADO:"+ELAPTIME(M->LOGHORA,M->LOGSAIDA)
QUIT
RETURN.T.

FUNCTION ENTRADA(PAR)
IF PAR=NIL
   PAR="TELA DE OP€åES"
ENDIF
SETBLINK(.T.)
*SET COLOR TO W/B,N /BG*,B+/N,B+/N
RELEVO(00, 00, 24, 79,.T.)    // toda MAE
RELEVO(05, 55, 21, 74,.F.,,2) // tela DIREITA
RELEVO(05, 05, 21, 54,.F.,,2) // tela EQUERDA
RELEVO(06, 06, 08, 53,.T.,,2) // BARRA DE TITULO
RELEVO(09, 06, 20, 53,.T.,,1) // BARRA INTERNA
@ 07, 08 SAY PADC(PAR,44)  COLOR "W+/R"
SET CURSOR OFF
@ 02,06 SAY M->AUTOR                                  color "bg+ /b"
@ 03,06 SAY M->EMPRESA                                color "bg  /b"
@ 13,08 SAY PADC(M->SISTEMA                      ,44) color "W+  /b"
@ 15,08 SAY PADC("Û²±° versÆo "+M->VERSAO+" °±²Û",44) color "B+/b"
@ 19,08 SAY PADC(M->AUTOR                        ,44) color "W+  /b"
@ 19,08 SAY PADC(M->AUTOR                        ,44) color "N+  /b"
RETURN.T.                                 



                 FUNCTION ADMISSAO
                 M->SALVAREG1=RECNO()
                 APPEND BLANK
                 M->SALVAREG2=RECNO()
                 SAVE SCREEN TO TELA
                 RELEVO(05, 05, 21, 54,.F.,,2) // tela EQUERDA
                 RELEVO(06, 06, 08, 53,.T.,,2) // BARRA DE TITULO
                 RELEVO(09, 18, 20, 53,.T.,,1) // tela EQUERDA
                 M->DATA=DATE() 
                 M->CODIGO=STRZERO(LASTREC(),6)
                 @ 07, 07 SAY PADC("ADMISSAO DE FUNCIONARIO",45) COLOR "W+/R"
                 @ 10, 08 SAY PADL("CODIGO"        ,10)   color "Bg+/b"
                 @ 11, 08 SAY PADL("FUNCIONARIO"   ,10)   color "Bg+/b"
                 @ 12, 08 SAY PADL("FUNCAO/CARGO"  ,10)   color "Bg+/b"
                 @ 13, 08 SAY PADL("SALARIO"       ,10)   color "Bg+/b"
                 @ 14, 08 SAY PADL("ADMISSAO"      ,10)   color "Bg+/b"
                 @ 15, 08 SAY PADL("ORIGEM"       ,10)   color "Bg+/b"

                 @ 10, 19 SAY M->CODIGO    PICT("@!")        color "W+/B,N/bG"
                 @ 11, 19 GET EMPREGADO    PICT("@!")        color "W+/B,N/bG"
                 @ 12, 19 GET FUNCAO       PICT("@!")        color "W+/B,N/bG"
                 @ 13, 19 GET SALARIO      PICT("@!")        color "W+/B,N/bG"
                 @ 14, 19 GET ADMISSAO     PICT("@99/99/99") color "W+/B,N/bG"
                 @ 15, 19 GET ORIGEM      PICT("@!")        color "W+/B,N/bG"
                 SET CURSOR ON
                 READ
                 RELEVO(09, 18, 20, 53,.T.,,1) // tela EQUERDA
                 @ 10, 08 SAY PADL("ENDERECO"        ,10)   color "Bg+/b"
                 @ 11, 08 SAY PADL("BAIRRO"          ,10)   color "Bg+/b"
                 @ 12, 08 SAY PADL("CEP"             ,10)   color "Bg+/b"
                 @ 13, 08 SAY PADL("CIDADE"          ,10)   color "Bg+/b"
                 @ 14, 08 SAY PADL("ESTADO"          ,10)   color "Bg+/b"
                 @ 15, 08 SAY PADL("TELEFONE"        ,10)   color "Bg+/b"
                 @ 16, 08 SAY PADL("CPF"             ,10)   color "Bg+/b"
                 @ 17, 08 SAY PADL("R. GERAL"        ,10)   color "Bg+/b"
                 @ 18, 08 SAY PADL("C. PROFISSIONAL" ,10)   color "Bg+/b"
                 @ 19, 08 SAY PADL("NASCIMENTO"      ,10)   color "Bg+/b"

                 @ 10, 19 GET ENDERECO     COLOR "W+/B,N/bG"
                 @ 11, 19 GET BAIRRO       COLOR "W+/B,N/bG"
                 @ 12, 19 GET CEP          COLOR "W+/B,N/bG"
                 @ 13, 19 GET CIDADE       COLOR "W+/B,N/bG"
                 @ 14, 19 GET ESTADO       COLOR "W+/B,N/bG"
                 @ 15, 19 GET TEL          COLOR "W+/B,N/bG"
                 @ 16, 19 GET CPF          COLOR "W+/B,N/bG"
                 @ 17, 19 GET RG           COLOR "W+/B,N/bG"
                 @ 18, 19 GET PROFISSION   COLOR "W+/B,N/bG"
                 @ 19, 19 GET NASCI        COLOR "W+/B,N/bG"
                 READ
                 IF LASTKEY()=27
                    DELETE
                    PACK
                   ELSE
                    RESPOSTA=PERGUNTA("Grava admiss„o do Funcionario?")
                    IF RESPOSTA<>1
                       DELETE
                       PACK
                       GOTO M->SALVAREG1
                      ELSE
                       REPLACE DATA       WITH M->DATA
                       REPLACE CODIGO     WITH M->CODIGO
                       GOTO M->SALVAREG2
                    ENDIF
                 ENDIF
                 SET CURSOR OFF
                 RESTORE SCREEN FROM TELA
                 RETURN.T.

                 FUNCTION DEMISSAO
                 SAVE SCREEN TO TELA
                 M->SALVAREG1=RECNO()
                 CONSULTA()
                 M->SALVAREG2=RECNO()
                 RELEVO(05, 05, 21, 54,.F.,,2) // tela EQUERDA
                 RELEVO(06, 06, 08, 53,.T.,,2) // BARRA DE TITULO
                 RELEVO(09, 18, 17, 53,.T.,,1) // tela EQUERDA
                 M->DATA=DATE()
                 M->CODIGO=STRZERO(LASTREC(),6)
                 M->DEMISSAO=DATE()
                 @ 07, 07 SAY PADC("DEMISSAO DE FUNCIONARIO",45) COLOR "W+/R"
                 @ 10, 08 SAY PADL("ORIGEM"       ,10)   color "Bg+/b"
                 @ 11, 08 SAY PADL("CODIGO"        ,10)   color "Bg+/b"
                 @ 12, 08 SAY PADL("FUNCIONARIO"   ,10)   color "Bg+/b"
                 @ 13, 08 SAY PADL("FUNCAO/CARGO"  ,10)   color "Bg+/b"
                 @ 14, 08 SAY PADL("SALARIO"       ,10)   color "Bg+/b"
                 @ 15, 08 SAY PADL("ADMISSAO"      ,10)   color "Bg+/b"
                 @ 16, 08 SAY PADL("DEMISSAO"      ,10)   color "Bg+/b"
                 @ 10, 19 SAY ORIGEM      PICT("@!")        color "W+/B,N/bG"
                 @ 11, 19 SAY CODIGO       PICT("@!")        color "W+/B,N/bG"
                 @ 12, 19 SAY EMPREGADO    PICT("@!")        color "W+/B,N/bG"
                 @ 13, 19 SAY FUNCAO       PICT("@!")        color "W+/B,N/bG"
                 @ 14, 19 SAY SALARIO      PICT("@!")        color "W+/B,N/bG"
                 @ 15, 19 SAY ADMISSAO     PICT("@99/99/99") color "W+/B,N/bG"
                 @ 16, 19 GET M->DEMISSAO  PICT("@99/99/99") color "W+/B,N/bG"
                 IF !EMPTY(DEMISSAO)
                    ALERT("FUNCIONARIO FOI DEMITIDO EM "+DTOC(DEMISSAO))
                 ENDIF
                 SET CURSOR ON
                 READ
                 IF LASTKEY()=27
                    GOTO M->SALVAREG1
                    ELSE
                    RESPOSTA=PERGUNTA("Grava DemissÆo do Funcion rio?")
                    IF RESPOSTA=1 //SIM
                       REPLACE DEMISSAO WITH M->DEMISSAO
                       GOTO M->SALVAREG2
                       ELSE
                       GOTO M->SALVAREG1
                     ENDIF
                 ENDIF
                 RESTORE SCREEN FROM TELA
                 SET CURSOR OFF
                 RETURN.T.

  function pergunta(par)
  IF par=nil
     par="CONTINUAR?"
  ENDIF
  SAVE SCREEN TO TELA
  SALVACOR=SETCOLOR()
  SETCOLOR("N+/R,BG*+/R,B+/N,B+/N")
  RELEVO(18,24,22,56,.T.,"R")
  @ 19,25 say PADC(PAR,30) COLOR "W+/R"
  RESPOSTA = 1
  @ 21,34 PROMPT " Sim "
  @ 21,41 PROMPT " N„o "
  MENU TO RESPOSTA
  READ
  RESTORE SCREEN FROM TELA
  SETCOLOR(SALVACOR)
  RETURN(RESPOSTA)

