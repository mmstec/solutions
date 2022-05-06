   *
   ****************************************************************************
   * (C) MMStec Informatica
   * Programa......: MMS CHQ(R)
   * Descri‡Æo.....: Sistema para registro de entrada de produtos
   *                 
   * Autor.........: Marcos Morais de Sousa
   ****************************************************************************
   *
   * Compilar com .: CA-CLIPPER (5x)
   * Exemplo ......: Clipper EST
   * Linkar com....: RTLINK   fi EST lib mmstec (P/Clipper v5.0 a 5.2)
   * Linkar com....: EXOSPACE fi EST lib mmstec (P/Clipper superior a v5.2)
   * ou............: BLINKER  fi EST lib mmstec
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
   
   CLEAR
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
   HENTRADA  := TIME()
   ACAO     := time()+"-Entrada normal"+CHR(13)+CHR(10)
   FILTRO1  := space(35)
   FILTRO2  := space(35)
   ANO      := "ANO "+ALLTRIM(TRAN(YEAR(DATE())-1995,"@E 9999"))
   AUTOR    := "(C) Marcos Morais de Sousa - 1995/"+TRAN(YEAR(DATE()),"@E 9999")+" "+ANO
   SISTEMA  := "Entrada de Produtos Registrados"
   EMPRESA  := "MFB Material de Constru‡Æo LTDA"
   M->SENHA :=SPACE(10)

   DO WHILE .T.
       @ 04,03 SAY PADC("&SISTEMA",77)                         COLOR "BG"
       @ 05,03 SAY PADC("&AUTOR",77)                           COLOR "BG"
       @ 07,03 SAY PADC(dbData(),77)                           COLOR "W+"
       @ 08,03 SAY PADC(ANO2000,77)                            COLOR "W+"
       @ 10,10,16,71 box("        Û")                        color "b/n"
       RELEVO( 10,10, 16,71,.T.)
       @ 12,12 SAY "Usuario entre com seu nome" color "W+/B+"
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

   M->CODIGO:=0
   IF FILE("EST.LIG")
      RESTORE FROM EST.LIG ADDITIVE
      SETBLINK(.F.)
      ALERT("SISTEMA EM USO ;OU; DESLIGADO INCORRETAMENTE;;"+REPL("Ä",20)+";Maquina "+LOGMAQ+";Programa "+LogPRO+";Usu rio "+LogUSO+";; * Entrada *;"+LogINI,,"N/RG+*")
      SETBLINK(.T.)
      QUIT

      ELSE
      LOGPRO := PROGRAMA
      LOGMAQ := MAQUINA
      LOGUSO := USUARIO
      LOGINI := DATAENTRA+"-"+HENTRADA

      IF FILE("EST.DES")
         ERASE EST.DES
         SAVE all like LOG* to EST.LIG

         ELSE
         SAVE all like LOG* to EST.LIG
      ENDIF
   ENDIF

   CLS
   
   if (!file("dbEST.DBF"))
      fcampo:= {}
      AAdd(fcampo, {"ENTRADA"   , "D",  8, 0})
      AAdd(fcampo, {"NF"        , "C", 10, 2})
      AAdd(fcampo, {"PRODUTO"   , "C", 30, 0})
      AAdd(fcampo, {"QUANTIDADE", "N", 10, 2})
      AAdd(fcampo, {"VALOR"     , "N", 10, 2})
      AAdd(fcampo, {"VENCIMENTO", "D",  8, 0})
      AAdd(fcampo, {"LANCAMENTO", "D",  8, 0})
      dbcreate("dBEST", fcampo)
      use dBEST
      index on DTOS(VENCIMENTO) to idEST01.NTX
      index on NF               to idEST02.NTX
   else
      use dBEST
      index on DTOS(VENCIMENTO) to idEST01.NTX
      index on NF               to idEST02.NTX
   endif

   private titulo[6]
   titulo[1]:= "DIA  ENTRADA"
   titulo[2]:= "NUMERO"     
   titulo[3]:= "PRODUTO"   
   titulo[4]:= "QUANTIDADE"     
   titulo[5]:= "VALOR"    
   titulo[6]:= "DIA  VENCIMENTO"

   private mascara[6]
    mascara[1]:= "@!"
    mascara[2]:= "@!"
    mascara[3]:= "@!"
    mascara[4]:= "@!"
    mascara[5]:= "@!"
    mascara[6]:= "@!"

   private registro[6]
   registro[1]:= 'dbData(ENTRADA)'
   registro[2]:= 'NF'     
   registro[3]:= 'PRODUTO'   
   registro[4]:= 'QUANTIDADE'     
   registro[5]:= 'VALOR'    
   registro[6]:= 'dBdata(VENCIMENTO)'

   ENTRADA()
   SET COLOR TO W/B,N /BG*,B+/N,B+/N
   GO TOP
   RELEVO(06,24,08,73,.T.)
   @ 07,25 SAY PADC(SISTEMA,46) COLOR "W+/B"
   DBEDIT(09,24,20,73,REGISTRO,"EDITA",MASCARA,TITULO,"   ","  ","   ",.T.)
FUNCTION EDITA(MODO,INDICE)
LOCAL TECLA  

TECLA  := LASTKEY()
CAMPO  := REGISTRO[INDICE]

DO CASE
   CASE MODO = 0
        SET COLOR TO W/B,W+ /BG,B+/N,B+/N
        @ 22,02 SAY SPACE(76) color "BG+/B"
        @ 23,05 say padc(DATA(),70) color "BG+/B"
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
        @ 23, 05 SAY PADC("Arquivo Vazio",70) COLOR "W+/B"
        SET CURSOR OFF
        RETURN(1)
      
   CASE MODO = 4
        IF TECLA = ESC
           SET COLOR TO W/N
           CLS
           SAIDA = TIME()
           ACAO   +=+time()+"-Saida normal "+CHR(13)+CHR(10)
           DES     = CHR(13)+CHR(10)
           DES    +="MAQUINA  : " + MAQUINA+CHR(13)+CHR(10)
           DES    +="PROGRAMA : " + PROGRAMA+CHR(13)+CHR(10)
           DES    +="USUARIO  : " + USUARIO+CHR(13)+CHR(10)
           DES    +="DATA     : " + DTOC(DATE())+CHR(13)+CHR(10)
           DES    +="INICIO   : " + HENTRADA+CHR(13)+CHR(10)
           DES    +="TERMINO  : " + TIME()+CHR(13)+CHR(10)
           DES    +="TOTAL    : " + ELAPTIME(HENTRADA,TIME())+CHR(13)+CHR(10)
           DES    +="HISTORICO: " + CHR(13)+CHR(10)+ACAO+CHR(13)+CHR(10)
           GRAVALOG(HENTRADA,SAIDA)
           ERASE EST.LIG
           SAVE all like DES to EST.DES
           LOGOMARCA()
           RETURN(0)

          ELSEIF TECLA = F1
                 SAVE SCREEN TO TELA
                 CORATUAL=SETCOLOR()
                 SETCOLOR("W+/B")
                 RELEVO(08,17,19,60,.T.)
                 do while LastKey()<>27
                    inkey(0.05)
                    @ 09,20 SAY "(C) Marcos Morais de Sousa - 1995/"+TRAN(YEAR(DATE()),"@E 9999") color "bg+/B"
                    @ 11,20 SAY "Programa        :"+trim(programa)
                    @ 12,20 SAY "Maquina         :"+trim(maquina)    
                    @ 13,20 SAY "Usuario         :"+trim(usuario)   
                    @ 14,20 SAY "Data da entrada :"+trim(dtoc(date()))
                    @ 15,20 SAY "Hora da entrada :"+trim(Hentrada)
                    @ 16,20 SAY "Hora atualizada :"+trim(time())
                    @ 17,20 SAY "Cron“metro      :"
                    @ 17,37 say SubStr(ELAPTIME(HENTRADA,time()),1,2)+"ø";
                               +SubStr(ELAPTIME(HENTRADA,time()),4,2)+"'";
                               +SubStr(ELAPTIME(HENTRADA,time()),7,2)+'"'  color "RG+ / b"
                 enddo
                 PACK
                 SETCOLOR(CORATUAL)
                 RESTORE SCREEN FROM TELA
                 RETURN(2)

          ELSEIF TECLA = 80 .OR. TECLA = 112
                 SAVE SCREEN TO TELA
                 CONSULTA()
                 SET ORDER TO 1
                 RESTORE SCREEN FROM TELA
                 RETURN(2)
          
          ELSEIF TECLA = 67 .OR. TECLA = 99
                 save screen to tela
                 set cursor on
                 CAMPO=FIELDNAME(INDICE)
                 if type("&campo")="D"
                    @ ROW(),COL()+5 GET &CAMPO COLOR "W+/R"
                    ACAO=ACAO+TIME()+"-Edicao de "+dtoc(ENTRADA)+CHR(13)+CHR(10)
                 elseif type("&campo")="M"
                   MEMOTELA=SAVESCREEN(8,9,21,71)
                   RELEVO(08,09,19,71,.T.)
                   RELEVO(10,10,18,70,.T.)
                   set color to w+/b+*
                   @ 09,11 say padC("Corrigindo Observa‡”es - Ctrl+W Grava",58)
                   REPLACE &CAMPO WITH MEMOEDIT(&CAMPO,11,12,17,69,.T.)
                   RESTSCREEN(8,9,19,71,MEMOTELA)
                   set cursor off
                   acao=acao+time()+"-Edita memo "+campo+CHR(13)+CHR(10)
                 else
                    @ ROW(),COL() GET &CAMPO   COLOR "W+/R"
                    ACAO=ACAO+TIME()+"-Corre‡„o de "+campo+CHR(13)+CHR(10)
                 endif
                 @ 23, 05 SAY PADC("Corre‡„o de registro ativada",70) COLOR "W+/B"
                 read
                 restore screen from tela
                 set cursor off
                 keyboard CHR(4)
                 RETURN(2)


          ELSEIF TECLA = 73 .OR. TECLA = 105
                 SAVE SCREEN TO TELA
                 if (!isprinter())
                    alert("* IMPRESSORA DESLIGADA *")
                 else
                    relatorio()
                    SET DEVI TO SCREEN
                    SET FILTER TO
                 endif

                 RESTORE SCREEN FROM TELA
                 RETURN(2)

          ELSEIF TECLA = 076 .OR. TECLA = 108
                 SAVE SCREEN TO TELA
                 APPEND BLANK 
                 RELEVO(05,22,21,75,.T.,,2)
                 RELEVO(06,24,08,74,.T.)
                 RELEVO(09,37,19,74,.T.)
                 @ 07, 25 SAY PADC("TELA DE LAN€AMENTOS",49) COLOR "W+/R"
                 @ 10, 25 SAY PADL("ENTRADA"   ,10)   color "Bg+/b"
                 @ 12, 25 SAY PADL("NUMERO"    ,10)   color "Bg+/b"
                 @ 14, 25 SAY PADL("PRODUTO"   ,10)   color "Bg+/b"
                 @ 16, 25 SAY PADL("QUANTIDADE",10)   color "Bg+/b"
                 @ 18, 25 SAY PADL("VALOR"     ,10)   color "Bg+/b"

                 @ 10, 38 GET ENTRADA      PICT("@99/99/99") color "W+/N,N/bG*"
                 @ 12, 38 GET NF           PICT("@!")        color "W+/N,N/bG*"
                 M->PRODUTO=PADR("CP Z32 50kg MONTES CLAROS",30)
                 @ 14, 38 GET M->PRODUTO   PICT("@!")        color "W+/N,N/bG*"
                 @ 16, 38 GET QUANTIDADE   PICT("@E 9,999,999.99")  color "W+/N,N/bG*"
                 @ 18, 38 GET VALOR        PICT("@E 9,999,999.99")  color "W+/N,N/bG*"
                 SET CURSOR ON
                 READ
                 ****
                 M->VENCIMENTO=ENTRADA+15
                 ****
                 @ 20, 25 SAY PADL("VENCIMENTO",10)   color "Bg+/b"
                 @ 20, 38 GET M->VENCIMENTO   PICT("@!")        color "W+/N,N/bG*"
                 READ
                 REPLACE ENTRADA    WITH ENTRADA
                 REPLACE NF         WITH NF
                 REPLACE PRODUTO    WITH M->PRODUTO
                 REPLACE QUANTIDADE WITH QUANTIDADE
                 REPLACE VALOR      WITH VALOR
                 REPLACE VENCIMENTO WITH M->VENCIMENTO
                 REPLACE LANCAMENTO WITH DATE()
                 IF LASTKEY()=27
                    DELETE
                    PACK
                 ENDIF
                 RESTORE SCREEN FROM TELA
                 SET CURSOR OFF
                 RETURN(2)

          ELSEIF TECLA = 65 .OR. TECLA = 97
                 SAVE SCREEN TO TELA
                 RESPOSTA = 1
                 CORATUAL=SETCOLOR()
                 SETCOLOR("W/R,W*/R+,B+/N,B+/N")
                 RELEVO(18,24,22,56,.T.,"R")
                 @ 19,25 say PADC(" Elimina registro corrente ?",30) COLOR "W+/R"
                 @ 21,34 PROMPT " Sim "
                 @ 21,41 PROMPT " Nao "
                 MENU TO RESPOSTA
                 READ
                 IF RESPOSTA = 1
                    ACAO=ACAO+TIME()+"-Apagou registros "+dbdata(ENTRADA)+"-"+trim(str(valor))+CHR(13)+CHR(10)
                    DELETE
                    PACK
                    GO TOP
                 ENDIF
                 index on DTOS(VENCIMENTO) to idEST01.NTX
                 index on NF               to idEST02.NTX
                 SET ORDER TO 1
                 RESTORE SCREEN FROM TELA
                 SETCOLOR(CORATUAL)
                 RETURN(2)

          ELSEIF TECLA = DEL
                 ALERT("Para EXCLUIR tecle; [A] de Apagar")
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
                   acao=acao+time()+"-Corrige memo "+campo+CHR(13)+CHR(10)
                 ELSE
                    ALERT('P/ CORRIGIR APERTE "C"',,"W+/R",)
                 ENDIF
                 RETURN(1)
          ELSEIF TECLA = 43  
                 SAVE SCREEN TO TELA
                 SET CURSOR ON
                 M->vSOMA  =0
                 @ 13,10 clear to 16,60
                 @ 13,10 to 16,60  DOUBLE               COLOR "BG+/N"
                 @ 14,15 SAY "Entrada"                  COLOR "W+/N"
                 @ 14,30 SAY "Valor do Dia"             COLOR "W+/N"
                 @ 14,45 SAY "Nova Entrada"   COLOR "W+/N"
                 @ 15,15 SAY ENTRADA                    COLOR "W+/N"
                 @ 15,30 SAY PADR(VALOR,12)              COLOR "W+/N"
                 @ 15,45 GET vSOMA PICT "99999999.99"   COLOR "W+/B"
                 READ
                 M->vSOMA=M->vSOMA+VALOR
                 REPLACE VALOR WITH vSOMA
                 SET CURSOR OFF
                 SET COLOR TO W/N
                 RESTORE SCREEN FROM TELA
                 RETURN(2)
                 
          ELSEIF TECLA = 116 .OR. TECLA = 84
                 SAVE SCREEN TO TELA
                 SET COLOR TO W/B,W+ /BG,B+/N,B+/N
                 TOTALIZA()
                 RESTORE SCREEN FROM TELA
                 RETURN(2)

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
     AREA=ALIAS()
     set cursor on
     SELE 1
     USE DBEST INDEX idEST01,idEST02
     SELE 1
     SET ORDER TO 2
     nRec  := 0
     lDone := .F.
     m->psq1   := SPACE(10)
     m->psq2   := SPACE(10)
     do while .T.
          set cursor on
          @ 23,05 say PADR("NOTA FISCAL:",70)        COLOR "RG+/B"
          @ 23,21 get M->PSQ2 PICT "@!"                COLOR "W+/N,N/RG+*"
          read
          set cursor off
          if lastKey()=27
             exit
          endif
          nRec := Recno()
          M->PESQUISA:=M->PSQ2
          SEEK TRIM(M->PESQUISA)
          if !found()
             tone(1000, 1)
             tone(800, 2)
             tone(1200, 1)
             ALERT('&SISTEMA.;; O sistema n„o p“de localizar uma correspondˆcia para "'+alltrim(M->PESQUISA)+'"; Caso vocˆ tenha certeza sobre a existˆncia dos dados procurados, verifique a digita‡„o e tente novamente.;;;')
             goto nRec
             loop
           else
             lDone := .T.
             @ 23, 05 SAY PADC("Registro localizado!",70) COLOR "W+/B"
          endif                                     
          EXIT
     ENDDO
     SELECT(AREA)
SET DELETED ON
RETURN.T.

********************************
PROCEDURE GRAVALOG(HENTRADA,SAIDA)
TEMPO=ELAPTIME(HENTRADA,SAIDA)
TEMPO   :=ELAPTIME(HENTRADA,SAIDA)
IF FILE("EST.TXT")
   TAM=DIRECTORY("EST.TXT","2")                                                                                                   
   IF TAM[1,2] > 60000                                                       
      ERASE EST.TXT
      ALERT("O aquivo de parametros;"+TAM[1,1]+";foi renovado.;;"+REPL("Ä",20)+";Motivo;Tamanho excedido",,"W+/B")
      ACAO=ACAO+time()+"-Renovado "+TAM[1,1]+" por excesso de tamanho"+CHR(13)+CHR(10)
      TEXTO=""
      ELSE
      TEXTO=MEMOREAD("EST.TXT")
   ENDIF
   ELSE
   TEXTO=""
ENDIF
TEXTO+="Estacao: " + MAQUINA+CHR(13)+CHR(10)
TEXTO+="Usuario: " + USUARIO+CHR(13)+CHR(10)
TEXTO+="Data   : " + DTOC(DATE())+CHR(13)+CHR(10)
TEXTO+="Inicio : " + HENTRADA+CHR(13)+CHR(10)
TEXTO+="Termino: " + SAIDA+CHR(13)+CHR(10)
TEXTO+="Total  : " + TEMPO+CHR(13)+CHR(10)
TEXTO+=REPLICATE("=",50)+CHR(13)+CHR(10)
MEMOWRIT("EST.TXT",TEXTO)
********************************
function RELATORIO

   use dBEST
   Index on DTOS(VENCIMENTO) to idEST01.NTX
   index on NF               to idEST02.NTX
   SET ORDER TO 1
   RELEVO(05,22,21,75,.T.,,2)
   RELEVO(06,24,08,74,.T.)
   RELEVO(09,37,19,74,.T.)
   @ 07, 25 SAY PADC("RELATORIO DE ENTRADAS POR PERIODO",49) COLOR "W+/R"
   FILTRO1 :=ctod("  /  /  ")
   FILTRO2 :=ctod("  /  /  ")
   @ 11, 25 say "Per¡odo: "         color "BG+/B"
   @ 11, 38 get FILTRO1             color "BG+/N,N/BG*"
   @ 13, 38 get FILTRO2             color "BG+/N,N/BG*"
   SET CURSOR ON
   READ
   @ 20, 25 SAY PADC("ENVIANDO REGISTROS PARA IMPRESSORA. AGUARDE!",49) COLOR "W+/R"
   SET CURSOR OFF
   IF LASTKEY()=27
      SET DEVI TO SCREEN
      SET FILTER TO
      ALERT("IMPRESSAO ABORTADA")
      RETURN(1)
   ENDIF
   *set filter to vencimento>=FILTRO1 .AND. vencimento<=FILTRO2
   *if (!(vencimento >= filtro1 .AND. vencimento <= filtro2))
   *   skip 
   *endif
   set filter to ENTRADA>=FILTRO1 .AND. ENTRADA<=FILTRO2
   if (!(ENTRADA >= filtro1 .AND. ENTRADA <= filtro2))
      skip 
   endif

   set device to printer

   TotalQ     := 0
   TotalV     := 0
   TotalE     := 0
   Linha      := 0
   Pagina     := 0
   iRegistro  :=CTOD("  /  /  ")
   M->Quebra_1:=CTOD("  /  /  ")

   do while (!EOF())
      @  linha+0,00 say ""
      if (linha == 0)
         Pagina++
         @ linha+1,  00 say padC(EMPRESA,80)
         @ linha+2,  00 say padC("RELATORIO DE ENTRADAS POR PERIODO",80)
         @ linha+4,  00 say padR('Per¡odo De:"'+ dtoc(filtro1)+'"',80)
         @ linha+5,  00 say padR('         A:"'+ dtoc(filtro2)+'"',80)
         @ linha+6,  00 say padR('PRODUTO   :"CP Z32 50kg - MONTES CLAROS"',80)
         * @ linha+7,  00 say Repl("=",80)
         @ linha+8,  00 say "Dia Entrada" 
         @ linha+8,  16 say "Nota Fiscal"
         @ linha+8,  32 say "Quantidade"
         @ linha+8,  43 say padl("Valor",14)
         @ linha+8,  64 say "Dia Vencimento"
         @ linha+9,  00 say Repl("=",80)
         linha = 10
      endif

      IF QUEBRA_1=ENTRADA
         M->ENTRADA=PADL('""',15)
         ELSE
         M->ENTRADA=dbdata(ENTRADA)
      ENDIF

      @ linha+0,  00 say M->ENTRADA
      @ linha+0,  16 say NF
      @ linha+0,  28 say transf(quantidade, [@E 999,999,999.99]) 
      @ linha+0,  43 say transf(Valor, [@E 999,999,999.99]) 
      @ linha+0,  64 say dBdata(Vencimento)

      TotalQ     := TotalQ + quantidade
      TotalV     := TotalV + valor
      TotalE     := TotalE + 1
      Linha      := Linha  + 1
      iREGISTRO  := ENTRADA
      skip 

      QUEBRA_1=iREGISTRO

      if (linha >= 50 .OR. EOF())
         if (EOF())
            @ linha + 1, 00 say padr("TOTAL:",10)
         else
            @ linha + 1,  1 say padr("SUBTOTAL:",10)
         endif
         @ linha + 1, 28 say transf(TOTALQ, [@E 999,999,999.99])
         @ linha + 1, 43 say transf(TOTALV, [@E 999,999,999.99])
         @ linha + 2, 00 say Repl("=",80)
         @ linha + 3, 00 say "Total a pagar:" + alltrim(transf(TOTALv, [@E 999,999,999.99]))
         @ linha + 4, 00 say "Quantidades:  " + alltrim(transf(TOTALq, [@E 999,999,999.99]))
         @ linha + 5, 00 say "Entradas:     " + alltrim(transf(TOTALe, [@E 999,999,999]))

         @ 58,00 say padR(DATA(),60)+padL(TIME()+" P gina " + alltrim(str(PAGINA)),19)
         @ 59,00 say padR(AUTOR,80)
         IF (EOF())    
            exit       
            else        
            linha:= 0                  
         endif
      endif
   enddo
   SET DEVI TO SCREEN
   return.T.

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



FUNCTION TOTALIZA
   M->dtENTRADA   :=CTOD("  /  /    ")
   M->dtLANCAMENTO:=CTOD("  /  /    ")
   nRECNO   := 0
   nLASTREC := 0
   nTOTALq  := 0
   nTOTALv  := 0
   RELEVO(05,22,21,75,.T.,,2)
   RELEVO(06,24,08,74,.T.)
   RELEVO(09,37,19,74,.T.)
   @ 07, 25 SAY PADC("RELATORIO DE ENTRADAS NUM PERIODO",49) COLOR "W+/R"
   FILTRO1 :=ctod("  /  /  ")
   FILTRO2 :=ctod("  /  /  ")
   @ 11, 25 say "Peri¢do: "         color "BG+/B"
   @ 11, 38 get FILTRO1             color "BG+/N,N/BG*"
   @ 13, 38 get FILTRO2             color "BG+/N,N/BG*"
   SET CURSOR ON
   READ
   if lastkey()=27
      set filter to
      alert("OPERA€ÇO INTERROMPIDA")
      RETURN (1)
   endif

   set cursor off
   set filter to ENTRADA>=FILTRO1 .AND. ENTRADA<=FILTRO2
   if (!(ENTRADA >= filtro1 .AND. ENTRADA<= filtro2))
      skip
   endif

RELEVO(05,05,21,75,.T.)
GO TOP

@ 06,10 SAY REPL("*",60)                                         color "BG/B"
@ 07,10 SAY "TOTAL ENTRADAS NO PERIODO"                          color "BG/B"
@ 08,10 SAY "Per¡odo de "+dtoc(filtro1)+" a "+ dtoc(filtro2)     color "BG/B"
@ 09,10 SAY REPL("*",60)                                         color "BG/B"

DO WHILE !eof()

   if ENTRADA <> ctod("  /  /    ")
      M->dtENTRADA = ENTRADA
      nLastRec ++
   endif
   if LANCAMENTO <> ctod("  /  /    ")
      M->dtLANCAMENTO = LANCAMENTO
   endif

   nRecNo++

   nTotalq    := nTotalQ + QUANTIDADE
   nTotalv    := nTotalV + VALOR
   Percentual := int ( ( nRecNo / nLastRec ) * 100 )
   Grafico    := int ( ( nRecNo / nLastRec ) * 50  )
   @ 11,10 SAY "QUANTIDADE TOTAL:"+TRANSF(nTOTALq,[@E 999,999,999.99])  color "W+/B"
   @ 12,10 SAY "     VALOR TOTAL:"+TRANSF(nTOTALv,[@E 999,999,999.99])  color "W+/B"
   MMSLET06(14,10,ALLTRIM(TRANSF(nTOTALQ,[@E 999,999,999.99])),1,"R+/B")
   @ 18,10 SAY "Obs.: 1) £ltima entrada do per¡odo: "+PADR(DBDATA(M->dtENTRADA),15) COLOR "BG/B"
   @ 19,10 SAY "      2) £ltima data de lan‡amento do per¡odo: "+PADR(DBDATA(M->dtLANCAMENTO),15) COLOR "BG/B"
   @ 20,20 SAY repL("Û",grafico)  color "RG+/B"
   @ 20,10 SAY padR(ALLTRIM(STR(PERCENTUAL,3))+"% conclu¡do",15)  color "RG+/B"
   @ 22,05 SAY Space(70)
   SKIP
ENDDO
INKEY(0)
SET FILTER TO
GO TOP
*****************
RETURN.T.



                 FUNCTION BOTOES
                 RELEVO(06,06,08,20,.T.)
                 RELEVO(09,06,11,20,.T.)
                 RELEVO(12,06,14,20,.T.)
                 RELEVO(15,06,17,20,.T.)
                 RELEVO(18,06,20,20,.T.)
                 @ 07,07 SAY "[ ] esquisar" COLOR ("b+/B")
                 @ 07,08 SAY "P"            COLOR ("W+/B")
                 @ 10,07 say "[ ] orrigir"  COLOR ("b+/B")
                 @ 10,08 SAY "C"            COLOR ("W+/B")
                 @ 13,07 say "[ ] pagar"    COLOR ("b+/B")
                 @ 13,08 SAY "A"            COLOR ("W+/B")
                 @ 16,07 say "[ ] an‡ar"    COLOR ("b+/B")
                 @ 16,08 SAY "L"            COLOR ("W+/B")
                 @ 19,07 say "[ ] mprimir"  COLOR ("b+/B")
                 @ 19,08 say "I"            COLOR ("W+/B")
                 RETURN

    FUNCTION ENTRADA
    SETBLINK(.F.)
    SET COLOR TO W/B,N /BG*,B+/N,B+/N
    RELEVO(00,00,24,79,.T.)  // toda a tela
    RELEVO(05,05,21,21,.F.,,2)  // tela esquerda
    RELEVO(05,22,21,75,.F.)  // tela direita
    BOTOES()
    SET CURSOR OFF
    @ 02,05 SAY AUTOR                             color "bg+ /b"
    @ 03,05 SAY EMPRESA                           color "bg  /b"
    @ 04,05 SAY USUARIO                           color "r+  /b"
    @ 12,23 SAY PADC(SISTEMA,51)                  color "W+  /b"
    @ 13,23 SAY PADC("Û²±° versÆo "+VERSAO+" °±²Û",51)      color "W/b"
    @ 20,23 SAY PADC(AUTOR,51)                    color "N+  /b"
    inkey(0)
   RETURN.T.
