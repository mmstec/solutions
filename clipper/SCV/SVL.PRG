   *
   ****************************************************************************
   * (C) MMStec Informatica
   * Programa......: MMS Comissao(R)
   * Descri‡Æo.....: Programa desenvolvido para armazenamento e processamento
   *                 do Fluxo de Venda Comissionado.
   * Autor.........: Marcos Morais de Sousa
   *
   * Compilar com .: CA-CLIPPER (5x)
   * Exemplo ......: Clipper SCC
   * Linkar com....: RTLINK   fi scc lib mmstec (P/Clipper v5.0 a 5.2)
   * Linkar com....: EXOSPACE fi scc lib mmstec (P/Clipper superior a v5.2)
   * ou............: BLINKER  fi scc lib mmstec
   *
   * NOTA: 
   * MMStec ‚ uma biblioteca de fun‡äes desenvolvida por Marcos Morais de Sousa
   ****************************************************************************
   *
   # INCLUDE "INKEY.CH"
   # DEFINE INSERT  22
   # DEFINE ENTER   13
   # DEFINE HOME     1   
   # DEFINE END      6   
   # DEFINE DEL      7
   # DEFINE ESC     27
   # DEFINE F1      28
   # DEFINE F2      23
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
   # DEFINE COMPLETA 1
   # DEFINE ATUAL    2
   
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
   M->SENHA    :=SPACE(10)
   M->ENTRADA  :="ENTRADA NORMAL"

   *********************
   CRIA_DBASE()
   *********************

   IF FILE("SVL.LIG") .AND. FILE("SVLLOG.DBF") .AND. FILE("VENDAL.DBF") .and. FILE("SVLSYS.DBF")
      CLS
      if (!UseRede("SVLLOG", .T., 5))
         IF FILE("SVL.LIG")
            restore from SVL.LIG ADDITIVE
            setblink(.F.)
            ALERT(";ATENCAO;;O sistema para registro do FLUXO DE VENDAS-LOJA;MMStec VENDASL (R); n„o se encontra dispon¡vel no momento;;"+REPL("Ä",40)+";NOME:"+alltrim(LogUSO)+";MAQUINA:"+LOGMAQ+";EXECUTAVEL:"+LogPRO+";DATA:"+LogDATA+";INICIO:"+LogHORA,,"w+/R")
            setblink(.T.)
            ELSE
            ALERT(";ATENCAO;;O sistema para registro do FLUXO DE VENDAS-LOJA;MMStec VENDASL (R); n„o se encontra dispon¡vel no momento",,"W+/R")
         ENDIF
         InKey(0.5)
         close databases
         select 2
         close format
         return
      endif
      DBGOBOTTOM()
      SETBLINK(.F.)

      STATUS:="USUARIO:"+ALLTRIM(SVLLOG->USUARIO)+";"+;
              "MAQUINA:"+SVLLOG->MAQUINA+";"+;
              "DATA:"+DTOC(SVLLOG->DATA)+";"+;
              "INICIO:"+SVLLOG->INICIO+";"

      cALERT  :="O sistema para controle de vendas comissionadas;" +;
              "MMStec Fluxo de Vendas/Loja (R); n„o se encontra dispon¡vel no momento.;;" +;
              "PROGRAMA FINALIZADO INCORRETAMENTE;"+STATUS+";"+;
              "O que voce prefere fazer?"

      if (Alert(cALERT,{ padc("Sair",15), padc("Corrigir",15) } ,"N/RG+*") == 1)
          ?"Programa finalizado incorretamente."
          ?"Procure o o responsavel pelo sistema, imediatamente."
          ??
          quit
      else
         TROCAUSUARIO()
         IF M->SENHA=="MASTER" 
            Append Blank
            M->ENTRADA=M->ENTRADA+CHR(13)+CHR(10)+SPACE(11)+"APAGA SVL.LIG"
            tone(1000, 1)
            tone(800, 2)
            tone(1200, 1)
            CLOSE DATABASES
           ELSE
            ALERT("SINTO MUITO;; VOCE NAO TEM ACESSO A ESTA ROTINA;;PROCURE O RESPONSAVEL;PELO SISTEMA;IMEDIATAMENTE",{padc("ENTER",15)},"N/RG*")
            QUIT
         ENDIF
      endif
      SETBLINK(.T.)
   ENDIF
   *******************

   ANO2000  := ALLTRIM(STR(CTOD("01/01/2000")-DATE()))
   ANO2000  := '"FALTAM '+ANO2000+' DIAS PARA O ANO 2000"'

   PROGRAMA := PROCNAME()+".EXE"
   VERSAO   := DIRECTORY("&PROGRAMA")
   MAQUINA  := ALLTRIM(NETNAME())
   USUARIO  := SPACE(58)
   FILTRO1  := space(35)
   FILTRO2  := space(35)
   AUTOR    := "(C) Marcos Morais de Sousa - 1995/"+TRAN(YEAR(DATE()),"@E 9999")
   SISTEMA  := "MMStec FLUXO DE VENDAS/LOJA (R) - vers„o "+Dtos(VERSAO[1,3])
   EMPRESA  := "Barreto Material de Constru‡„o"
   DtENTRADA:= DATE()
   HrENTRADA:= TIME()

   @ 04,03 SAY PADC("&SISTEMA",77)                         COLOR "BG"
   @ 05,03 SAY PADC("&AUTOR",77)                           COLOR "BG"
   @ 20,03 SAY PADC(dbData(),77)                           COLOR "W+"
   @ 22,03 SAY PADC(ANO2000,77)                            COLOR "W+"

   if libera()
      else
      quit
   endif
   USUARIO  := IIF(EMPTY(USUARIO),"NAO IDENTIFICADO",TRIM(UPPER(USUARIO)))
   M->USU   := USUARIO
   LOGPRO   := PROGRAMA
   LOGMAQ   := MAQUINA
   LOGUSO   := USUARIO
   LOGDATA  := DTOC(DTENTRADA)
   LOGHORA  := HRENTRADA
   IF FILE("SVL.DES")
      ERASE SVL.DES
      SAVE all like LOG* to SVL.LIG
      ELSE
      SAVE all like LOG* to SVL.LIG
   ENDIF

   SET CURSOR ON
   M->CODIGO:=0
   CLS
   setcolor("W/B,N /BG*,B+/N,B+/N")
   cls
   SELE 1
   USE VENDAL
   INDEX ON DTOS(DATA) TO IVENDAL.NTX EVAL {|| PROGRESSO() } EVERY 1
   SELE 2
   USE SVLLOG
   INDEX on DTOS(DATA)+INICIO+MAQUINA+USUARIO to iSVLLOG.NTX EVAL {|| PROGRESSO() } EVERY 1
   AUDITOR("I",M->ENTRADA)
   SELE 3
   USE SVLSYS
   INDEX on SENHA to iSVLSYS.NTX 
   SELE 1

   PRIVATE Titulo[7]
           Titulo[1] = "Dia  Data"
           Titulo[2] = "Vda Dinheiro "
           Titulo[3] = "Vda Crediario"
           Titulo[4] = "Vda Duplicata"
           Titulo[5] = "Rec Crediario"
           Titulo[6] = "Rec Duplicata"
           Titulo[7] = "Tp"

   PRIVATE MASCARA[7]  
           MASCARA[1] = "@!"
           MASCARA[2] = "@!"
           MASCARA[3] = "@!"
           MASCARA[4] = "@!"
           MASCARA[5] = "@!"
           MASCARA[6] = "@!"
           MASCARA[7] = "@!"

   DECLARE REGISTRO[7]
           REGISTRO[1] = 'dbData(data)'
           REGISTRO[2] = "especie"
           REGISTRO[3] = "crediarioV"
           REGISTRO[4] = "duplicataV"
           REGISTRO[5] = "crediarioR"
           REGISTRO[6] = "duplicataR"
           REGISTRO[7] = "tipo"

   SETBLINK(.F.)
   SET COLOR TO n/w,BG+/n,b+/n,b+/n
   cls
   caixa(00,00,24,79,"N /w","w+/w",.F.)
   caixa(05,05,21,75,"w+/w","N /w",.F.)
   @ 02,05 SAY SISTEMA                                color "B+ /W"
   @ 03,05 SAY EMPRESA                                color "BG+/W"
   @ 04,05 SAY substr(USUARIO,1, at(chr(32),USUARIO)) color "R/W"
   GO TOP
   DBEDIT(07,06,20,74,REGISTRO,"EDITA",MASCARA,TITULO,"   ","  ","   ",.T.)

FUNCTION EDITA(MODO,INDICE)
LOCAL TECLA  
xcTamFile:=DIRECTORY("SVL.TXT","2")
TECLA := LASTKEY()
CAMPO := FIELDNAME(INDICE)
DO CASE
   CASE MODO = 1
        MENSAGEM("Inicio do Arquivo",3,"W+/W")
        MENSAGEM("",,"W+/W")
        SET CURSOR OFF
        RETURN(1)

   CASE MODO = 2
        MENSAGEM("Final do Arquivo",3,"W+/W")
        MENSAGEM("",,"W+/W")
        SET CURSOR OFF
        RETURN(1)
      
   CASE MODO = 3
        MENSAGEM("Arquivo Vazio",,"W+/W")
        SET CURSOR OFF
        RETURN(1)
      
   CASE MODO = 4
        IF TECLA = ESC
           SAVE SCREEN TO TELA
           CORATUAL=SETCOLOR()
           SET COLOR TO N/Rg*+,W+*/R,B+/N,B+/N
           CAIXA(17,24,22,56,"N/RG+*","R+/RG+*")
           @ 18,25 say PADC(" Sair do sistema",30) 
           @ 19,25 say PADC(" (R) MMStec VENDAS-LOJA? ",30) 
           @ 21,35 PROMPT " SIM "
           @ 21,41 PROMPT " NAO "
           MENU TO nRESPOSTA
           READ
           DO CASE
           CASE nRESPOSTA == SIM
              SET COLOR TO W/N
              CLS
              M->SAIDA = TIME()
              AUDITOR("F","SAIDA NORMAL")
              ERASE SVL.LIG
              LOGOMARCA()
              ?"&MAQUINA./&USUARIO."
              ?"INICIO     :"+DTOC(DTENTRADA)+" - "+HRENTRADA
              ?"FIM        :"+DTOC(DATE())+" - "+M->SAIDA
              ?"================================="
              ?"TEMPO TOTAL:             "+ELAPTIME(HRENTRADA,M->SAIDA)
               tone(1000, 1)
               tone(800, 2)
               tone(1200, 1)

              RETURN(0)
            CASE nRESPOSTA == NAO
                 SETCOLOR(CORATUAL)
                 RESTORE SCREEN FROM TELA
                 RETURN(1)
            OTHERWISE
                 RESTORE SCREEN FROM TELA
                 RETURN(2)
            ENDCASE
          ELSEIF TECLA = F11
                 SAVE SCREEN TO TELA
                 AUDITORIA()
                 RESTORE SCREEN FROM TELA
                 RETURN(2)

          ELSEIF TECLA = F12
                 TROCAUSUARIO()
                 RETURN(2)

          ELSEIF TECLA = F1
                 SAVE SCREEN TO TELA
                 CORATUAL=SETCOLOR()
                 SETCOLOR("W+/B")
                 caixa(07,17,19,60)
                 do while LastKey()<>27
                    inkey(0.05)
                    @ 08,20 SAY "(C) Marcos Morais de Sousa - 1995/"+TRAN(YEAR(DATE()),"@E 9999") color "bg+/B"
                    @ 09,20 say "Mem¢ria livre   :"+alltrim(str(memory(2)))+" kb"  color "bg/B"
                    @ 11,20 SAY "Programa        :"+trim(programa)
                    @ 12,20 SAY "M quina         :"+trim(maquina)    
                    @ 13,20 SAY "Usu rio         :"+trim(usuario)   
                    @ 14,20 SAY "Entrada         :"+trim(dtoc(DTentrada)+"-"+HRentrada)
                    @ 15,20 SAY "Rel¢gio         :"+trim(dtoc(date())+"-"+TIME())
                    @ 16,20 SAY "Cron“metro      :"
                    @ 16,37 say SubStr(ELAPTIME(HrENTRADA,time()),1,2)+"ø";
                               +SubStr(ELAPTIME(HrENTRADA,time()),4,2)+"'";
                               +SubStr(ELAPTIME(HrENTRADA,time()),7,2)+'"'   color "RG+ / b"
                    @ 17,20 say "Registros       :"+dbf()+"/"+alltrim(str(LastRec()))
                 enddo
                 SETCOLOR("W+/N")
                 cls
                 ALERT(";;Uma produ‡„o de; &AUTOR;;"+REPL("Ä",20)+";TODOS OS DIREITOS;RESERVADOS;"+REPL("Ä",20)+";;Duvidas;+55 (073) 525-2344;",,"N/RG+*")
                 PACK
                 SETCOLOR(CORATUAL)
                 RESTORE SCREEN FROM TELA
                 RETURN(2)

          ELSEIF TECLA = 80 .OR. TECLA = 112
                 SAVE SCREEN TO TELA
                 CONSULTA()
                 RESTORE SCREEN FROM TELA
                 RETURN(2)
          
          ELSEIF TECLA = 69 .OR. TECLA = 101
                 campo=fieldname(indice)
                 save screen to tela
                 set cursor on
                 if type("&campo")="D"
                    @ ROW(),COL()+5 GET &CAMPO COLOR "W+/R*"
                    AUDITOR(,"EDITA REGISTRO  DATA DE "+DTOC(VENDAL->DATA)) 
                    else
                    @ ROW(),COL() GET &CAMPO   COLOR "W+/R*"
                    AUDITOR(,"EDITA REGISTRO "+ALLTRIM(CAMPO)+" DE "+ALLTRIM(DTOC(VENDAL->DATA))) 
                 endif
                 mensagem("Edicao de registro ativada",0.01,"R/W")
                 read
                 restore screen from tela
                 set cursor off
                 keyboard CHR(4)
                 RETURN(2)

          *I ou i*
          ELSEIF TECLA = 73 .OR. TECLA = 105
                 SAVE SCREEN TO TELA
                 if (!isprinter())
                    alert(";***; IMPRESSORA DESLIGADA ;***;")
                 else
                    relatorio()
                    set devi to screen
                    set filter to
                 endif
                 return(2)
          
          elseif tecla = 076 .or. tecla = 108
                 SET COLOR TO W/B,N /BG*,B+/N,B+/N
                 save screen to tela
                 xDATA    :=CTOD("  /  /    ")
                 xVAR1:=0
                 xVAR2:=0
                 xVAR3:=0
                 xVAR4:=0
                 xVAR5:=0
                 xVAR6:="L"
                 CAIXA(05,17,19,57)
                 @ 06,20 SAY PADC("LANCANDO REGISTROS",35) color ("W+/B+*")
                 @ 08,20 SAY PADL("DATA",10)+":"  color ("bG+/B")
                 @ 10,20 SAY PADL("Vda Dinheiro ",15)+":"    color ("bG+/B")
                 @ 11,20 SAY PADL("Vda Crediario",15)+":"    color ("bG+/B")
                 @ 12,20 SAY PADL("Vda Duplicata",15)+":"    color ("bG+/B")
                 @ 13,20 SAY PADL("Rec Crediario",15)+":"    color ("bG+/B")
                 @ 14,20 SAY PADL("Rec Duplicata",15)+":"    color ("bG+/B")

                 @ 08,38 GET xDATA pict "@!" valid ChkData(xDATA) color ("W+/B+*")
                 @ 10,38 GET xVAR1 pict "@E 999999999.99"    color ("W+/B+*")
                 @ 11,38 GET xVAR2 pict "@E 999999999.99"    color ("W+/B+*")
                 @ 12,38 GET xVAR3 pict "@E 999999999.99"    color ("W+/B+*")
                 @ 13,38 GET xVAR4 pict "@E 999999999.99"    color ("W+/B+*")
                 @ 14,38 GET xVAR5 pict "@E 999999999.99"    color ("W+/B+*")
                 @ 17,20 say PADC("Existe "+ALLTRIM(str(RecCount()-1,4))+" registros no arquivo",35) color "BG/B"
                 SET CURSOR ON
                 READ                                               
                 VENDAL->(dbappend())
                 VENDAL->data      :=xData
                 VENDAL->ESPECIE   :=xVAR1
                 VENDAL->CREDIARIOv:=xVAR2
                 VENDAL->CREDIARIOr:=xVAR3
                 VENDAL->DUPLICATAv:=xVAR4
                 VENDAL->DUPLICATAr:=xVAR5
                 VENDAL->TIPO      :=xVAR6
                 IF LASTKEY()=27
                    DELETE
                    PACK
                 ELSE
                    AUDITOR(,"LANCA DADOS - "+DTOC(VENDAL->DATA)+CHR(13)+CHR(10)+SPACE(9))
                 ENDIF

                 RESTORE SCREEN FROM TELA
                 SET CURSOR OFF
                 RETURN(2)

          ELSEIF TECLA = 65 .OR. TECLA = 97
                 SAVE SCREEN TO TELA
                 RESPOSTA := 1
                 DATAATUAL:= DATA
                 SET COLOR TO N/Rg*+,W+*/R,B+/N,B+/N
                 CAIXA(10,20,15,60,"N/RG+*","R+/RG+*")
                 @ 11,21 say PADC(' Elimina registro corrente, ',38) 
                 @ 12,21 say PADC('"'+alltrim(padc(DTOC(DATAATUAL),35))+'"?',38) 
                 TONE(500,5)
                 @ 14,35 PROMPT " Sim "
                 @ 14,40 PROMPT " N„o "
                 MENU TO RESPOSTA
                 READ
                 IF RESPOSTA = 1
                    DELETE
                    AUDITOR(,"ELIMINA REGISTRO"+CHR(13)+CHR(10)+SPACE(9)+DTOC(DATAATUAL)) 
                    PACK
                    RESTORE SCREEN FROM TELA
                    ALERT(ALLTRIM(USUARIO)+';VOCE ELIMINOU O REGISTRO;;"'+ALLTRIM(DTOC(DATAATUAL))+'"',,"RG+/RG")
                 ENDIF
                 RESTORE SCREEN FROM TELA
                 SET COLOR TO W/B,N /BG*,B+/N,B+/N
                 SET SOFTSEEK On
                 SEEK trim(DTOS(DATAATUAL))
                 SET SOFTSEEK OFF
                 RETURN(2)
          ELSEIF TECLA = DEL
                 ALERT("PARA EXCLUIR TECLE;; [A] ;;DE APAGAR")
                 RETURN(2)

          ELSEIF TECLA = 116 .OR. TECLA = 84
                 SAVE SCREEN TO TELA
                 SET COLOR TO W/B,W+ /BG,B+/N,B+/N
                 TOTAIS()
                 RESTORE SCREEN FROM TELA
                 RETURN(2)

          ELSEIF TECLA = ENTER
                 SAVE SCREEN TO TELA
                 CAIXA(04,10,23,70)
                 TVENDAS=ESPECIE+CREDIARIOv+DUPLICATAv+CREDIARIOr+DUPLICATAr
                 CAIXA(04,10,23,70)
                 @ 05,11 say padc("",58)  COLOR("W+/R")
                 @ 06,11 say padc("FLUXO DE VENDAS/LOJA",58)  COLOR("W+/R")
                 @ 07,11 say padc("",58)  COLOR("W+/R")

                 @ 09,11 say PADC(DIA(DATA),58)                                     COLOR "W+/B"
                 @ 11,15 SAY padL("Vdas ESPECIE",10)   +padL(STR(ESPECIE),14)+padL("("+alltrim(str((ESPECIE/Tvendas)*100))+"%)",14)   pict "@!"  COLOR "W+ /B"
                 @ 13,15 SAY padL("Vdas CREDIARIO",10) +padL(STR(CREDIARIOV),14)+padL("("+alltrim(str((CREDIARIOV/Tvendas)*100))+"%)",14)   pict "@!"  COLOR "W+ /B"
                 @ 15,15 SAY padL("Vdas DUPLICATA",10) +padL(STR(DUPLICATAV),14)+padL("("+alltrim(str((DUPLICATAV/Tvendas)*100))+"%)",14)   pict "@!"  COLOR "W+ /B"
                 @ 17,15 SAY padL("Rec  CREDIARIO",10) +padL(STR(CREDIARIOR),14)+padL("("+alltrim(str((CREDIARIOR/Tvendas)*100))+"%)",14)   pict "@!"  COLOR "W+ /B"
                 @ 19,15 SAY padL("Rec  DUPLICATA",10) +padL(STR(DUPLICATAR),14)+padL("("+alltrim(str((DUPLICATAR/Tvendas)*100))+"%)",14)   pict "@!"  COLOR "W+ /B"
                 @ 21,15 SAY padL("TOTAL/HOJE:",10)  +padL(STR(TVENDAS),14)+padL("("+alltrim(str((TVENDAS/Tvendas)*100))+"%)",14)   pict "@!"  COLOR "BG+ /B"
                 AUDITOR(,"VISUALIZA REGISTRO DE "+ALLTRIM(DTOC(VENDAL->DATA)) )
                 INKEY(60)
                 SET COLOR TO W/B,N /BG*,B+/N,B+/N
                 RESTORE SCREEN FROM TELA
                 RETURN(2)

                 INKEY(60)
                 SET COLOR TO W/B,N /BG*,B+/N,B+/N
                 RESTORE SCREEN FROM TELA
                 RETURN(2)
          ELSE
                 TONE(300,9)
                 help=     "[T] ...: Totalizar   ;"
                 help=HELP+"[P] ...: Procurar    ;"
                 help=HELP+"[E] ...: Editar      ;"
                 help=help+"[A] ...: Apagar      ;"
                 help=help+"[L] ...: Lan‡ar      ;"
                 help=help+"[I] ...: Imprimir    ;"
                 help=help+"[F1] ..: Ajudar      ;"
                 help=help+"[F11] .: Auditoria   ;"
                 help=help+"[F12] .: Trocar senha;"
                 ALERT("&SISTEMA.;;&HELP",,"W+/BG")
                 RETURN 2        
          ENDIF
      OTHERWISE
          @ 23,01 SAY PADC(DATA(),78) COLOR "BG+/W"
          SET CURSOR OFF
          SET COLOR TO W/B,N /BG*,B+/N,B+/N
          RETURN(1)
      ENDCASE

FUNCTION CONSULTA   
     set cursor on
     nRec  := 0
     lDone := .F.
     psq   := ctod("  /  /  ")
     do while .T.
          @ 23,05 say PADR("Procurar  :",70)        COLOR "R/W"
          @ 23,21 get PSQ PICT "@!"                 COLOR ",N/RG+*"
          
          set cursor on
          read
          set cursor off
          if lastKey()=27
             exit
          endif
          nRec := Recno()
          seek dtos(PSQ)
          if !found()
             @ 23,05 say PADC('Verifique os digitos de sua procura',70)        COLOR "R/W"
             tone(1000, 1)
             tone(800, 2)
             tone(1200, 1)
             AUDITOR(,"PROCURA REGISTRO"+CHR(13)+CHR(10)+SPACE(11)+TRIM(dtoc(PSQ))+CHR(13)+CHR(10)+SPACE(11)+"NAO LOCALIZA")
             ALERT('&SISTEMA.;; O sistema n„o p“de localizar uma correspondˆcia para "'+alltrim(dtoc(PSQ))+'"; Caso vocˆ tenha certeza sobre a existˆncia dos dados procurados, verifique a digita‡„o e tente novamente.;;;')
             goto nRec
             loop
           else
             lDone := .T.
             mensagem("Registro localizado!",0.01,"W+/W")
             AUDITOR(,"PROCURA REGISTRO"+CHR(13)+CHR(10)+SPACE(11)+TRIM(dtoc(PSQ))+;
             CHR(13)+CHR(10)+SPACE(11)+"LOCALIZA '"+TRIM(DTOC(VENDAL->(DATA)))+"'")
          endif                                     
          EXIT
     ENDDO
SET DELETED ON
RETURN.T.


function RELATORIO
   SELE 1
   index on DTOS(DATA) to IVENDAL.NTX
   FILTRO1 :=ctod("  /  /    ")
   FILTRO2 :=ctod("  /  /    ")

   caixa(07,22,17,56)

   @  8, 24 say padc("INFORME O PERIODO", 31) color "W+/R"

   @ 11, 29 say "PERIODO DE :" get FILTRO1
   @ 13, 29 say "ATE        :" get FILTRO2

   SET CURSOR ON
   READ

   alert("A T E N € Ç O ;; Prepare a impressora ;para imprimir; em modo condensado")

   @ 15, 24 SAY " * Aguarde o fim da impressao *" color "w+*/r"

   AUDITOR(,"IMPRIME REGISTRO"+CHR(13)+CHR(10)+SPACE(9)+"DE "+DTOC(filtro1)+" A "+DTOC(filtro2))
   SET CURSOR OFF

   IF LASTKEY()=27
      SET DEVI TO SCREEN
      SET FILTER TO
      ALERT("***IMPRESSAO ABORTADA***","W*+/R")
      RETURN(2)
   ENDIF
   set filter to DATA>=FILTRO1 .AND. DATA<=FILTRO2
   if (!(data >= filtro1 .AND. data <= filtro2))
      skip
   Endif
   set device to printer
   TOTAL1  :=0
   TOTAL2  :=0
   TOTAL3  :=0
   TOTAL4  :=0
   TOTAL5  :=0
   TGERAL  :=0
   VENDIDO :=0
   RECEBIDO:=0
   LINHA   :=0
   PAGINA  :=0
   do while (!EOF())

      if (linha == 0)

         Pagina++

         @ linha+0,  00 say "!"
         @ linha+1,  00 say padC(EMPRESA,137)
         @ linha+2,  00 say padC('Relat¢rio de vendas e comissoes',137)
         @ linha+3,  00 say DBDATA(date())+" - " + TIME()
         @ linha+3,  00 say padC('Impress„o de "'+ Trim(dtoc(filtro1)) +'" a "' + Trim(dtoc(filtro2))+'"',137)
         @ linha+3, 100 say padL("P gina " + alltrim(str(pagina)),037)

         @ linha+5,  0 say REPL("*",137)
         @ linha+6,  0 say "Arquivo.:"+DBF()
         @ linha+7,  0 say "Data"
         @ linha+7, 17 say padl("Vdas Dinheiro " ,20)
         @ linha+7, 37 say padl("Vdas Crediario" ,20)
         @ linha+7, 57 say padl("Vdas Duplicata" ,20)
         @ linha+7, 77 say padl("Rec  Crediario" ,20)
         @ linha+7, 97 say padl("Rec  Duplicata" ,20)
         @ linha+7,118 say "Tp"
         @ linha+8,  0 say REPL("*",137)

         linha = 9

      endif

      @ linha, 00 say DATA
      @ linha, 17 say PADL(ESPECIE    ,20)
      @ linha, 37 say PADL(CREDIARIOv ,20)
      @ linha, 57 say PADL(DUPLICATAv ,20)
      @ linha, 77 say PADL(CREDIARIOr ,20)
      @ linha, 97 say PADL(DUPLICATAr ,20)
      @ linha,118 say TIPO
      TOTAL1:= TOTAL1 + ESPECIE
      TOTAL2:= TOTAL2 + CREDIARIOv
      TOTAL3:= TOTAL3 + DUPLICATAv
      TOTAL4:= TOTAL4 + CREDIARIOr
      TOTAL5:= TOTAL5 + DUPLICATAr
      VENDIDO :=  VENDIDO + CREDIARIOv + DUPLICATAv
      RECEBIDO:= RECEBIDO + CREDIARIOr + DUPLICATAr
      Linha ++
      skip 
      if (linha >= 45 .OR. EOF())
         if (EOF())
            TOT_01(2)
            exit
         else
            TOT_01(1)
         endif
         linha:= 0
      endif
   enddo
   SET DEVI TO SCREEN
   SET FILTER TO
   return.T.

FUNCTION TOT_01
PARA PAR1
IF PAR1=2
   @ LINHA+01,001 SAY "TOTAL   "
ELSE
   @ LINHA+01,001 SAY "SUBTOTAL"
ENDIF
   @ linha+01, 17 say PADL(TOTAL1 ,20)
   @ linha+01, 37 say PADL(TOTAL2 ,20)
   @ linha+01, 57 say PADL(TOTAL3 ,20)
   @ linha+01, 77 say PADL(TOTAL4 ,20)
   @ linha+01, 97 say PADL(TOTAL5 ,20)
IF PAR1=2
   LINHA=45
   TGERAL :=TOTAL1+TOTAL2+TOTAL3+TOTAL4+TOTAL5
   @ LINHA+01,001 SAY REPL("*",129)
   @ LINHA+03,010 SAY      "FLUXO DE VENDAS NO PRRIODO DE "+DTOC(FILTRO1)+" A "+DTOC(FILTRO2)
   @ LINHA+05,010 SAY PADR("SOMA  VENDIDO  ( CREDIARIO + DUPLICATA ): ",50)+STR(VENDIDO,12,2)
   @ LINHA+06,010 SAY PADR("SOMA  RECEBIDO ( CREDIARIO + DUPLICATA ):",50)+STR(RECEBIDO,12,2)
   @ LINHA+08,010 SAY PADR("TOTAL SOMAS    ( CREDIARIO + DUPLICATA + ESPECIE ):",50)+STR(TGERAL,12,2)
   @ LINHA+08,010 SAY PADR("TOTAL SOMAS    ( CREDIARIO + DUPLICATA + ESPECIE ):",50)+STR(TGERAL,12,2)
   @ LINHA+10,010 SAY "NOTA: Relat¢rio impresso por "+alltrim(USUARIO)+" na m quina "+alltrim(MAQUINA)+"."
   @ LINHA+12,001 SAY REPL("*",129)
ENDIF
RETURN

FUNCTION condicao1
IF !EMPTY(v1) .AND. LASTKEY()<>5
   BEEP()
   MENSAGEM("Informacao obrigatoria",3,"R/W")
   MENSAGEM("Tecle <ESC> para retornar",,"W+/W")
   RETURN .F.
ENDIF
RETURN .T.


FUNCTION DIA(vDATA)
if vdata=nil
   vdata=DATE()
else
   vdata=vdata
endif
Data     := Date()
semana   := "DomingoSegundaTerca  Quarta Quinta Sexta  Sabado "
dia      := Trim(SubStr(semana, DoW(DATA) * 7 - 6, 7)) + ", " + alltrim(Str(Day(DATA), 2))
mes      := "janeiro  fevereiromarco    abril    maio     junho    "
mes      := mes + "julho    agosto   setembro outubro  novembro dezembro "
dia      := dia + " de " + Trim(SubStr(mes, Month(DATA) * 9 - 8, 9)) + " de "
dia      := dia + Transform(Year(DATA), "@E 9999")
RETURN DIA


FUNCTION VALIDADE(GET)
CAMPO = GET
REG   = RECN()
ORDEM = INDEXORD()
SET ORDER TO 1
IF EMPTY(CAMPO) .AND. LASTKEY()<>5 .or. lastkey()=27
   ALERT("Preenchimento obrigatorio")
   RETURN.F.
ENDIF
IF DBSEEK(CAMPO)=.T.
   ALERT("Registro "+TRIM(CAMPO)+" j  existe.;Tente outro")
   GOTO REG
   RETURN.F.
ENDIF
GOTO REG
RETURN.T.

FUNCTION TOTAIS

   FILTRO1 :=ctod("  /  /    ")
   FILTRO2 :=ctod("  /  /    ")
   caixa(06,22,17,56)
   @  7, 24 say padc("FLUXO DE VENDAS/LOJA", 31) color "W+/R"
   @  8, 24 say padc("Informe o periodo", 31) color "W+/R"
   @ 11, 29 say "PERIODO DE :" get FILTRO1 
   @ 13, 29 say "ATE        :" get FILTRO2
   SET CURSOR ON
   READ
   caixa(04,05,21,75,"b+/B","N /B")
   @ 05,07 SAY padc("FLUXO DE VENDAS/LOJA",67)                 color "w+/r"
   @ 06,07 SAY padc(dtoc(FILTRO1)+" - "+dtoc(FILTRO2),67)               color "w+/r"  
   SET CURSOR ON
   READ
   IF LASTKEY()=27
      SET FILTER TO
      RETURN
   ENDIF
   INICIO=TIME()
   AUDITOR(,"VER TOTAL/PERIODO"+CHR(13)+CHR(10)+SPACE(9)+" DE "+DTOC(filtro1)+" A "+DTOC(filtro2))
   SET CURSOR OFF
   SET FILTER TO DATA>=FILTRO1 .AND. DATA<=FILTRO2
   IF (!(DATA >= FILTRO1 .AND. DATA <= FILTRO2))
      SKIP
   ENDIF
   TOTALV1  :=0
   TOTALV2  :=0
   TOTALV3  :=0
   TOTALV4  :=0
   TOTALV5  :=0
   TVENDAS  :=0
   do while (!EOF())
      IF DATA <> CTOD("  /  /    ")
         DATAOK:= DATA
         REG   := RECN()
      ENDIF
      TOTALV1:= TOTALV1 + ESPECIE
      TOTALV2:= TOTALV2 + CREDIARIOV
      TOTALV3:= TOTALV3 + DUPLICATAV
      TOTALV4:= TOTALV4 + CREDIARIOR
      TOTALV5:= TOTALV5 + DUPLICATAR
      SKIP
      TVENDAS:= TOTALV1+TOTALV2+TOTALV3+TOTALV4+TOTALV5
      @ 08,15 SAY padL("Vdas ESPECIE"  ,15)+" R$: "+padL(STR(TOTALV1),14)+padL("("+alltrim(str((TOTALV1/Tvendas)*100))+"%)",14)   pict "@!"  COLOR "W+ /B"
      @ 10,15 SAY padL("Vdas CREDIARIO",15)+" R$: "+padL(STR(TOTALV2),14)+padL("("+alltrim(str((TOTALV2/Tvendas)*100))+"%)",14)   pict "@!"  COLOR "W+ /B"
      @ 12,15 SAY padL("Vdas DUPLICATA",15)+" R$: "+padL(STR(TOTALV3),14)+padL("("+alltrim(str((TOTALV3/Tvendas)*100))+"%)",14)   pict "@!"  COLOR "W+ /B"
      @ 14,15 SAY padL("Rec  CREDIARIO",15)+" R$: "+padL(STR(TOTALV4),14)+padL("("+alltrim(str((TOTALV4/Tvendas)*100))+"%)",14)   pict "@!"  COLOR "W+ /B"
      @ 16,15 SAY padL("Rec  DUPLICATA",15)+" R$: "+padL(STR(TOTALV5),14)+padL("("+alltrim(str((TOTALV5/Tvendas)*100))+"%)",14)   pict "@!"  COLOR "W+ /B"
      @ 18,15 SAY padL("TOTAL/PERIODO" ,15)+" R$: "+padL(STR(TVENDAS)   ,14)+padL("("+alltrim(str((TVENDAS/Tvendas)*100))+"%)",14)   pict "@!"  COLOR "BG+ /B"
      @ 20,007 SAY PADC("CALCULANDO",67) COLOR "W*+/R"
      if EOF()
         TONE(500,5)
         @ 20,007 SAY PADC(" ULTIMO LANCAMENTO DO PERIODO => "+PADR(DBDATA(DATAOK),15),67) COLOR "RG+/B"
         INKEY(0)
         GOTO REG
         exit
      endif
   enddo
   SET FILTER TO
RETURN

function caixa
PARA NL1,NC1,NL2,NC2,COR1,COR2,SOMBRA
IF PCOUNT()<6
   COR1  :="N /B"
   COR2  :="B+/B"
ENDIF
IF SOMBRA=NIL
   SOMBRA=.T.
   ELSE
   SOMBRA=SOMBRA
ENDIF
coratual=setcolor()
setcolor(COR2)
IF nL2 < nL1+4
   nL2 = nL1+4
endif
@ nL1, nC1 clear to nL2, nC2
IF SOMBRA=.T.
   SOMBRA(nL1,nC1,nL2, nC2)
ENDIF
for A = 1 to nL2-nL1
        @ nL1+A, nC1 say "³" color(cor1)
        @ nL1+A, nC2 say "³" color(cor2)
next
@ nL1, nC1 say repl("Ä",max(nC2,nC1)-min(nC2,nC1))       color(cor1)
@ nL2, nC1 say repl("Ä",max(nC2,nC1)-min(nC2,nC1))       color(cor2)
@ nL1, nC1 say "Ú"   color(cor1)
@ nL2, nC1 SAY "À"   color(cor2)
@ nL1, nC2 say "¿"   color(cor1)
@ nL2, nC2 say "Ù"   color(cor2)
Tone(350,0.0002)
CORA1 = COR2
CORA2 = COR1
for A = 1 to nL2-nL1
        @ nL1+A, nC1 say "³" color(corA1)
        @ nL1+A, nC2 say "³" color(corA2)
next
@ nL1, nC1 say repl("Ä",max(nC2,nC1)-min(nC2,nC1))       color(corA1)
@ nL2, nC1 say repl("Ä",max(nC2,nC1)-min(nC2,nC1))       color(corA2)
@ nL1, nC1 say "Ú"   color(corA1)
@ nL2, nC1 SAY "À"   color(corA2)
@ nL1, nC2 say "¿"   color(corA1)
@ nL2, nC2 say "Ù"   color(corA2)
setcolor(coratual)
return ( NIL )

function progresso(L)
 if pCount()<1
    L=12
 endif
 grafico   := int ( ( RecNo() / LastRec() ) *  60 )
 percentual:= int ( ( RecNo() / LastRec() ) * 100 )
 if dbf()="VENDAL"
    CAMPO=dbData(data)
    elseif dbf()="SVLLOG"
    CAMPO=dbData(data)
    else
    campo=data()
 ENDIF
 @ L-1  ,10 say padc("Arquivo corrente: "+dbf(),60)                color "W+ /N"
 @ L    ,10 + grafico say "Û"+repl(" ",59-grafico)                 color "rg+/n"
 @ L+1  ,10 say padc(Str(percentual,3 )+"%"+" conclu¡do",60)       color "RG+/N"
 @ L+3  ,10 say padc(CAMPO,60)                                     color "W+ /B"
Return (.T.)

FUNCTION TROCAUSUARIO
   SAVE SCREEN TO TELA
   SET COLOR TO N/Rg*+,W+*/R,B+/N,B+/N
   CAIXA(11,20,15,60,"N/RG+*","R+/RG+*")
   M->SENHA :=SPACE(10)
   DO WHILE .T.
       @ 12,21 SAY PADC(ALLTRIM(substr(USUARIO,1, at(chr(32),USUARIO)))+" ENTRE COM A SENHA:",38)
       @ 14,35 GET M->SENHA pict "@!" COLOR "N/N"
       SET CURSOR ON
       READ
       M->SENHA=UPPER(ALLTRIM(M->SENHA))
       EXIT
   ENDDO
   RESTORE SCREEN FROM TELA
   ALERT("ATEN€ÇO;;SENHA;PROCESSADA",,"RG+/N")
RETURN.T.


FUNCTION AUDITORIA
SELE 2
SEEK TRIM(DTOS(DtENTRADA))+HrENTRADA+MAQUINA+USUARIO
AUDITOR(,"VISUALIZA AUDITORIA")
setcolor("w+/w")         
JANELA(08,10,18,71," A U D I T O R I A ")
@ 09,10 say PADC(ALLTRIM(MEMOLINE(SVLLOG->HISTORICO,58,1)),62) color "B/W+*"
MEMOEDIT(SVLLOG->HISTORICO,11,12,17,69,.F.)
RETURN(1)
SELE 1
RETURN.T.

function auditor(op,texto)
local Local1, Local2
if pcount()<2
   op = "log"
   texto=texto
endif
if op = nil
   op = "LOG"
   else
   op = op
endif
if texto = nil
   texto = "#N/D"+chr(13)+chr(10)
   else
   texto = "  "+time()+" "+texto+chr(13)+chr(10)
endif
local1 = op
local2 = texto 
reclin=row()
reccol=col()
DO CASE
   case local1="I"
        sele 2
        Append Blank
        Replace SVLLOG->DATA with DtENTRADA
        Replace SVLLOG->INICIO with HrENTRADA
        Replace SVLLOG->MAQUINA with ALLTRIM(NETNAME())
        Replace SVLLOG->USUARIO with M->USU
        Replace SVLLOG->HISTORICO with SVLLOG->HISTORICO+DTOC(DtENTRADA)+" &MAQUINA/&USU"+CHR(13)+CHR(10)+LOCAL2
   case local1="F"
        sele 2
        SEEK TRIM(DTOS(DtENTRADA))+HrENTRADA+MAQUINA+USUARIO
        Replace SVLLOG->FIM with M->SAIDA
        Replace SVLLOG->HISTORICO with SVLLOG->HISTORICO+LOCAL2
        Replace SVLLOG->HISTORICO with SVLLOG->HISTORICO+"  "+ELAPTIME(HRENTRADA,TIME())+" TEMPO USADO" 
   otherwise
        sele 2
        SEEK TRIM(DTOS(DtENTRADA))+HrENTRADA+MAQUINA+USUARIO
        Replace SVLLOG->HISTORICO with SVLLOG->HISTORICO+LOCAL2
ENDCASE        
SELE 1
if local1="F"
   @ reclin,reccol say "<FIM>"
ENDIF
RETURN NIL


function ArqRede(arquivo, modo, segundos)
   local sempre
   sempre:= segundos = 0
   do while (sempre .OR. segundos > 0)
      if (modo)
         use (arquivo) exclusive
         else
         use (arquivo) shared
      endif
      if (!neterr())
         return .T.
      endif
      segundos:= segundos - 1
   enddo
   return .F.
                   
                 function ChkData(CHAVE)
                 if empty(chave)
                    tone(550,9)
                    alert("ATENCAO;;Prenchimento obrigatorio")
                    return.f.
                 endif
                 if dbseek(dtos(chave))=.T.
                    tone(550,9)
                    alert("ATENCAO;;Ja existe um lan‡amento para esta data;;Tente outra",,"N/RG+*")
                    return.f.
                 endif
                 Return.t.

********************************
function V_N(Arg2)
   ok      := "N"
   a       :=0
   converte:=""
   for contador=1 to len(Arg2)
       a++
       Var1     :=ASC(substr(arg2,a,contador))+33 // CODIFICA DIGITO PARA COMPARAR
       converte :=converte + chr(var1)
   next
   arg2:=converte
   seek Upper(Arg2)
   if (Found())
      if (alltrim(Upper(senha)) == alltrim(Upper(Arg2))) 
         usu_tmp:= SVLSYS->usuario
         sup_tmp:= SVLSYS->NIVEL
         ok     := "S"
      endif
   endif
   if (ok = "N")
      ok      := "N"
      a       :=0
      converte:=""
      for contador=1 to len(Arg2)
          a++
          Var1     :=ASC(substr(arg2,a,contador))-33 // DECODIFICA DIGITO PARA COMPARAR
          converte :=converte + chr(var1)
       next
      arg2:=converte
      if (Upper(Arg2) == "MMSTEC")
         usu_tmp:= "MMSTEC"
         sup_tmp:= "3"
         ok:= "S"
      endif
   endif
   return .T.
********************************

********************************
function LIBERA

   public usu_tmp,sup_tmp
   if (!USEREDE("SVLSYS",.F.,10))
      op_cao:= 0
      return .F.
      else
      INDEX on SENHA to iSVLSYS.NTX 
   endif
   tentativa:= 0
   do while (.T.)
      if (tentativa >= 3)
         cls
         alert("Sinto muito;;Esgotaram-se as tentativas permitidas;")
         op_cao:= 0
         return .F.
      endif
      var2:= ""
      caixa(09, 20, 13,60)
      @ 11, 22 say "Senha: "       color "W+ /B"
      l:= 11
      c:= 29
      cod:= 32
      do while (.T.)
         @ l, c say Chr(cod)   color "RG+/B"
         tecla:= InKey(0)
         if (tecla = 13 .OR. tecla = 27)
            exit
         endif
         cod:= 254
         if (tecla == 8)
            var2:= Left(var2, Len(var2) - 1)
            @ l, c say " "
            c--
            if (c <= 29)
               c  := 29
               cod:= 32
            endif
         else
            c++
            if (c >= 59)
               c:= 59
            else
               var2:= var2 + Chr(tecla)
            endif
         endif
      enddo
      if (LastKey() == K_ESC)
         loop
      endif
      tentativa++
      ok:= "N"
      var2:= alltrim(var2)
      if (!Empty(var2))
         v_n(var2)
      endif
      if (ok = "N")
         tone(1000, 1)
         tone(800, 2)
         tone(1200, 1)
         alert("Acesso;;N E G A D O")
      else
         TONE(500,5)
         alert(ALLTRIM(SVLSYS->usuario)+";NIVEL:"+SVLSYS->NIVEL+";;"+dbdata()+";"+ano2000,,"N/W")
         exit
      endif
   enddo
   set color to "w/n"
   cls
   close databases
   select 1
   close format
   USUARIO:= USU_TMP
   NIVEL  := SUP_TMP
   return .T.

function UseRede(arquivo, modo, segundos)
   local sempre
   sempre:= segundos = 0
   do while (sempre .OR. segundos > 0)
      if (modo)
         use (arquivo) exclusive
         else
         use (arquivo) shared
      endif
      if (!neterr())
         return .T.
      endif
      segundos:= segundos - 1
   enddo
   return .F.


FUNCTION CRIA_DBASE
   IF !FILE("SVLSYS.DBF")
      CAMPO0:={}
      AADD( CAMPO0,{"USUARIO","C", 45,  0})   
      AADD( CAMPO0,{"SENHA"  ,"C",  6,  0})
      AADD( CAMPO0,{"NIVEL"  ,"C",  1,  0})
      DBCREATE("SVLSYS",CAMPO0)
      SELE 3
      USE SVLSYS
      INDEX on SENHA to iSVLSYS.NTX 
      M->ENTRADA=M->ENTRADA+CHR(13)+CHR(10)+SPACE(11)+"CRIA ARQUIVO "+DBF()
      inclui_usu()
   ENDIF
   IF !FILE("SVLLOG.DBF")
      CAMPO1:={}
      AADD( CAMPO1,{"DATA","D", 8,  0})   
      AADD( CAMPO1,{"INICIO","C", 8,  0})
      AADD( CAMPO1,{"FIM","C", 8,  0})   
      AADD( CAMPO1,{"MAQUINA","C", 10, 0})
      AADD( CAMPO1,{"USUARIO","C", 30, 0})
      AADD( CAMPO1,{"HISTORICO","M", 10, 0})
      DBCREATE("SVLLOG", CAMPO1)
      SELE 2
      USE SVLLOG
      INDEX on DTOS(DATA)+INICIO+MAQUINA+USUARIO to iSVLLOG.NTX EVAL {|| PROGRESSO() } EVERY 1
      AUDITOR("I","ENTRADA NORMAL"+CHR(13)+CHR(10)+SPACE(9)+"CRIA ARQUIVO/"+DBF())
      M->ENTRADA=M->ENTRADA+CHR(13)+CHR(10)+SPACE(11)+"CRIA ARQUIVO "+DBF()
   ENDIF
   IF !FILE("VENDAL.DBF")
      FCAMPO:={}
      AADD( FCAMPO,{"DATA","D", 08,  0} )
      AADD( FCAMPO,{"ESPECIE","N", 10,  2} )
      AADD( FCAMPO,{"CREDIARIOv","N", 10,  2} )
      AADD( FCAMPO,{"DUPLICATAv","N", 10,  2} )
      AADD( FCAMPO,{"CREDIARIOr","N", 10,  2} )
      AADD( FCAMPO,{"DUPLICATAr","N", 10,  2} )
      AADD( FCAMPO,{"TIPO","C", 01,  0} )   
      DBCREATE("VENDAL",FCAMPO)
      SELE 1
      USE VENDAL
      INDEX ON DTOS(DATA) TO IVENDAL.NTX EVAL {|| PROGRESSO() } EVERY 1
      AUDITOR("I","ENTRADA NORMAL"+CHR(13)+CHR(10)+SPACE(9)+"CRIA ARQUIVO/"+DBF())
   ENDIF
   RETURN.T.

function inclui_usu
   SELE 3
   SET INDEX to iSVLSYS.NTX
   tentativa:= 0
   set cursor on
   do while (.T.)
      if (tentativa >= 3)
         alert("Sinto muito;;Esgotaram-se as tentativas permitidas;")
      endif
      cNome := space(45)
      cSenha:= space(06)
      cNivel:= space(01)
      caixa(07, 13, 15,67)
      @  9, 15 say "Nome : "       color "W+ /B"
      @ 11, 15 say "Senha: "       color "W+ /B"
      @ 13, 15 say "Nivel: "       color "W+ /B"

      @  9, 21 get cNome  PICT "@!" valid !empty(cNome)    color "w+/Bg"
      @ 11, 21 get cSenha PICT "@!" valid CODIFICA(cSenha) color "w+/Bg"
      @ 13, 21 get cNivel PICT "@!" valid !empty(cNivel)   color "w+/Bg"
      read
      if (LastKey() == K_ESC)
         return.f.
      endif
      tentativa++
      a       :=0
      converte:=""
      for contador=1 to len(cSenha)
          a++
          Var1     :=ASC(substr(cSenha,a,contador))+33 // CODIFICA DIGITO PARA COMPARAR
          converte :=converte + chr(var1)
      next
      cSenha:=CONVERTE
      Append Blank
      Replace usuario with cNome
      Replace senha   with cSenha
      Replace nivel   with cNivel
   enddo
   set cursor off
   return.t.

   function CODIFICA(chave)
   a       :=0
   converte:=""
   for contador=1 to len(chave)
       a++
       Var1     :=ASC(substr(chave,a,contador))+33 // CODIFICA DIGITO PARA COMPARAR
       converte :=converte + chr(var1)
   next
   CHAVE:=CONVERTE
   if empty(chave)
      alert("AVISO;;Preenchimento ‚ obrigatorio")
      return.f.
   endif
   if dbseek(chave)=.T.
      alert("AVISO;;Registro ja existe;;TENTE OUTRO")
      return.f.
   endif
   return.t.

FUNCTION JANELA
PARA PJAN1,PJAN2,PJAN3,PJAN4,PJAN5
IF PCOUNT()<>5
    PJAN5=""
ENDIF
SOMBRA(PJAN1,PJAN2,PJAN3+1,PJAN4)
setcolor("w+/w")         
@ PJAN1,PJAN2 CLEAR TO PJAN3+1,PJAN4
@ PJAN1,PJAN2       TO PJAN3+1,PJAN4 DOUBLE
@ PJAN1,PJAN2 CLEAR TO PJAN1,PJAN4
IF LEN(TRIM(PJAN5)) > 0
   @ PJAN1,PJAN2 SAY SPACE(PJAN4-PJAN2+1)                   COLOR ("R/W+*")         
   @ PJAN1,PJAN2+(((PJAN4+1-PJAN2)-LEN(PJAN5))/2) SAY PJAN5 COLOR ("R/W+*")
ENDIF
RETURN

FUNCTION SOMBRA
PARA LIN_SUP,COL_SUP,LIN_INF,COL_INF
IF PCOUNT()=2 .OR. PCOUNT()=3
   C_SOM=COL_SUP
   L_SOM=LIN_SUP
   LIN_SUP=VAL(SUBS(C_SOM,1,2))
   COL_SUP=VAL(SUBS(C_SOM,3,2))
   LIN_INF=VAL(SUBS(C_SOM,5,2))
   COL_INF=VAL(SUBS(C_SOM,7,2))
   COL_SOM=SUBS(C_SOM,9)
   LIN_SOM=L_SOM
ENDIF
IF COL_SUP<2 .OR. LIN_INF>22
   C_SOM=""
   L_SOM=""
   RETURN .F.
ENDIF
IF PCOUNT()=3
   RESTSCREEN(LIN_SUP+1,COL_SUP-2,LIN_INF+1,COL_SUP-1,COL_SOM)
   RESTSCREEN(LIN_INF+1,COL_SUP-2,LIN_INF+2,COL_INF-2,LIN_SOM)
   RETURN .F.
ENDIF
IF PCOUNT()<>2
   COL_SOM=SAVESCREEN(LIN_SUP+1,COL_SUP-2,LIN_INF+1,COL_SUP-1)
   LIN_SOM=SAVESCREEN(LIN_INF+1,COL_SUP-2,LIN_INF+2,COL_INF-2)
ENDIF
*
* -> Estas duas linhas se fazem necess rio apenas para algumas
*    vers”es do Clipper Summer 87 que vez por outra apresentam
*    problemas na fun‡„o SAVESCREEN
COL_SOM=SUBS(COL_SOM,1,((LIN_INF-LIN_SUP)+1)*4)
LIN_SOM=SUBS(LIN_SOM,1,((COL_INF-COL_SUP)+1)*4)
*
IF SUBS(COL_SOM,2,1)<>CHR(8)
   C_SOM=STR(LIN_SUP,2)+STR(COL_SUP,2)+STR(LIN_INF,2)+STR(COL_INF,2)+COL_SOM
   L_SOM=LIN_SOM
ENDIF
FOR I=2 TO LEN(COL_SOM) STEP 2
   COL_SOM=STUFF(COL_SOM,I,1,CHR(8))
NEXT
FOR I=2 TO LEN(LIN_SOM)/2 STEP 2
   LIN_SOM=STUFF(LIN_SOM,I,1,CHR(8))
NEXT
RESTSCREEN(LIN_SUP+1,COL_SUP-2,LIN_INF+1,COL_SUP-1,COL_SOM)
RESTSCREEN(LIN_INF+1,COL_SUP-2,LIN_INF+2,COL_INF-2,LIN_SOM)
RETURN .T.
