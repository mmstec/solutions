   *
   ****************************************************************************
   * (C) MMStec Informatica
   * Programa......: MMS BookFone(R)
   * Descri‡Æo.....: Programa desenvolvido para armazenamento e processamento
   *                 de telefones.
   * Autor.........: Marcos Morais de Sousa
   *
   * Compilar com .: CA-CLIPPER (5x)
   * Exemplo ......: Clipper fone
   * Linkar com....: RTLINK   fi fone lib mmstec (P/Clipper v5.0 a 5.2)
   * Linkar com....: EXOSPACE fi fone lib mmstec (P/Clipper superior a v5.2)
   * ou............: BLINKER  fi fone lib mmstec
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
   IF FILE("fone.LIG") .AND. FILE("FoneLOG.DBF") .AND. FILE("Fone.DBF")
      CLS
      if (!ArqRede("FoneLOG", .T., 5))
         IF FILE("Fone.LIG")
            restore from Fone.LIG ADDITIVE
            setblink(.F.)
            ALERT(";ATENCAO;;O sistema para consulta de telefones ;MMStec BookFone (R); n„o se encontra dispon¡vel no momento;;"+REPL("Ä",40)+";NOME:"+alltrim(LogUSO)+";MAQUINA:"+LOGMAQ+";EXECUTAVEL:"+LogPRO+";DATA:"+LogDATA+";INICIO:"+LogHORA,,"w+/R")
            setblink(.T.)
            ELSE
            ALERT(";ATENCAO;;O sistema para consulta de telefones ;MMStec BookFone (R); n„o se encontra dispon¡vel no momento",,"W+/R")
         ENDIF
         InKey(0.5)
         close databases
         select 2
         close format
         return
      endif
      DBGOBOTTOM()
      SETBLINK(.F.)

      STATUS:="USUARIO:"+ALLTRIM(FoneLOG->USUARIO)+";"+;
              "MAQUINA:"+FoneLOG->MAQUINA+";"+;
              "DATA:"+DTOC(FoneLOG->DATA)+";"+;
              "INICIO:"+FoneLOG->INICIO+";"

      cALERT  :="O sistema para consulta de telefones ;" +;
              "MMStec BookFone (R); n„o se encontra dispon¡vel no momento.;;" +;
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
            M->ENTRADA=M->ENTRADA+CHR(13)+CHR(10)+SPACE(11)+"APAGA FONE.LIG"
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
   SISTEMA  := "MMStec BookFone (R) - vers„o "+Dtos(VERSAO[1,3])
   EMPRESA  := "Barreto Material de Constru‡„o"
   DtENTRADA:= DATE()
   HrENTRADA:= TIME()

   DO WHILE .T.
       @ 04,03 SAY PADC("&SISTEMA",77)                         COLOR "BG"
       @ 05,03 SAY PADC("&AUTOR",77)                           COLOR "BG"
       @ 07,03 SAY PADC(dbData(),77)                           COLOR "W+"
       @ 08,03 SAY PADC(ANO2000,77)                            COLOR "W+"
       @ 10,10,16,71 box("        Û")                        color "b/n"
       caixa(10,10,16,71)
       @ 12,12 SAY "Usuario entre com seu nome" color "W+/B*+"
       @ 14,12 get USUARIO pict "@!" color "W+/BG"
       SET CURSOR ON
       READ
       SET CURSOR OFF
       if empty(USUARIO) .AND. lastkey()<>5
          ALERT("Preenchimento obrigatorio")
          loop
       endif
       if LEN(ALLTRIM(USUARIO)) < 4
          ALERT("Usuario invalido;"+Repl("Ä",15)+";Digite seu nome corretamente",,"W+/B")
          loop
       endif
       exit
   ENDDO

   USUARIO  := IIF(EMPTY(USUARIO),"NAO IDENTIFICADO",TRIM(UPPER(USUARIO)))
   M->USU   := USUARIO
   LOGPRO   := PROGRAMA
   LOGMAQ   := MAQUINA
   LOGUSO   := USUARIO
   LOGDATA  := DTOC(DTENTRADA)
   LOGHORA  := HRENTRADA
   IF FILE("FONE.DES")
      ERASE FONE.DES
      SAVE all like LOG* to FONE.LIG
      ELSE
      SAVE all like LOG* to FONE.LIG
   ENDIF

   SET CURSOR ON
   M->CODIGO:=0
   CLS
   
   IF !FILE("FONELOG.DBF")
      CAMPO1:={}
      AADD( CAMPO1,{"DATA","D", 8,  0})   
      AADD( CAMPO1,{"INICIO","C", 8,  0})
      AADD( CAMPO1,{"FIM","C", 8,  0})   
      AADD( CAMPO1,{"MAQUINA","C", 10, 0})
      AADD( CAMPO1,{"USUARIO","C", 30, 0})
      AADD( CAMPO1,{"HISTORICO","M", 10, 0})
      DBCREATE("FONELOG", CAMPO1)
      SELE 2
      USE FONELOG 
      INDEX on DTOS(DATA)+INICIO+MAQUINA+USUARIO to iFONELOG.NTX EVAL {|| PROGRESSO() } EVERY 1
      M->ENTRADA=M->ENTRADA+CHR(13)+CHR(10)+SPACE(11)+"CRIA ARQUIVO "+DBF()
   ENDIF
   IF !FILE("FONE.DBF")
      CAMPO2:={}
      AADD( CAMPO2,{"CODIGO","C", 06,  0} )   
      AADD( CAMPO2,{"NOME","C", 35,  0} )
      AADD( CAMPO2,{"DDD","C", 04,  0} )   
      AADD( CAMPO2,{"FONE","C", 15,  0} )
      AADD( CAMPO2,{"OBS","M", 10,  0} )
      DBCREATE("FONE",CAMPO2)
      setcolor("W/B,N /BG*,B+/N,B+/N")
      cls
      SELE 1
      USE FONE
      INDEX on NOME+DDD to ifone.ntx  EVAL {|| PROGRESSO() } EVERY 1
      M->ENTRADA=M->ENTRADA+CHR(13)+CHR(10)+SPACE(11)+"CRIA ARQUIVO "+DBF()
      Append Blank
      Replace codigo with STRzero(LASTREC(),6)
      Replace nome with "Marcos Morais de Sousa (*)"
      Replace DDD with "0073"
      Replace fone with "525-2344/5932"
      Replace OBS with chr(13)+chr(10)+"* Autor do (R) BookFone *"
      Replace OBS with OBS+chr(13)+chr(10)+"Para Lancar registro tecle 'L'"
      Replace OBS with OBS+chr(13)+chr(10)+"Para Editar/Alterar registro tecle 'E'"
      Replace OBS with OBS+chr(13)+chr(10)+"Para Imprimir registro tecle 'I' e informe a letra inicial e a letra final a ser impressa"
      Replace OBS with OBS+chr(13)+chr(10)+"Para Apagar registro tecle 'A'"
      Replace OBS with OBS+chr(13)+chr(10)+"Para Pesquisar registro tecle 'P' e informe o dado a ser pesquisado"
      *
   ENDIF
   setcolor("W/B,N /BG*,B+/N,B+/N")
   cls
   SELE 1
   USE FONE
   INDEX on NOME+DDD to ifone.ntx  EVAL {|| PROGRESSO() } EVERY 1
   SELE 2
   USE FONELOG 
   INDEX on DTOS(DATA)+INICIO+MAQUINA+USUARIO to iFONELOG.NTX EVAL {|| PROGRESSO() } EVERY 1
   AUDITOR("I",M->ENTRADA)
   SELE 1

   PRIVATE Titulo[5]
           Titulo[1] = "CàDIGO"
           Titulo[2] = "NOME"
           Titulo[3] = "DDD"
           Titulo[4] = "TELEFONE"
           Titulo[5] = "OBSERVA€ÇO"
   
   PRIVATE MASCARA[5]  
           MASCARA[1] = "@!"
           MASCARA[2] = "@!"
           MASCARA[3] = "@!"
           MASCARA[4] = "@!"
           MASCARA[5] = "@!"

   DECLARE REGISTRO[5]           
           REGISTRO[1] = 'CODIGO'
           REGISTRO[2] = 'NOME'
           REGISTRO[3] = 'DDD'
           REGISTRO[4] = 'FONE'
           REGISTRO[5] = 'OBS'

   SETBLINK(.F.)
   SET COLOR TO W/B,N /BG*,B+/N,B+/N
   cls
   caixa(00,00,24,79,"N /B","b+/B",.F.)
   caixa(05,05,21,75,"b+/B","N /B",.F.)
   @ 02,05 SAY SISTEMA                           color "bg+ /b"
   @ 03,05 SAY EMPRESA                           color "bg  /b"
   @ 04,05 SAY "<&USUARIO>"                      color "r+  /b"
   
   GO TOP
   DBEDIT(07,06,20,74,REGISTRO,"EDITA",MASCARA,TITULO,"   ","  ","   ",.T.)
   
FUNCTION EDITA(MODO,INDICE)
LOCAL TECLA  
xcTamFile:=DIRECTORY("FONE.TXT","2")
TECLA := LASTKEY()
CAMPO := FIELDNAME(INDICE)
DO CASE
   CASE MODO = 1
        MENSAGEM("Inicio do Arquivo",3,"W+/B")
        MENSAGEM("",,"W+/B")
        SET CURSOR OFF
        RETURN(1)

   CASE MODO = 2
        MENSAGEM("Final do Arquivo",3,"W+/B")
        MENSAGEM("",,"W+/B")
        SET CURSOR OFF
        RETURN(1)
      
   CASE MODO = 3
        MENSAGEM("Arquivo Vazio",,"W+/B")
        SET CURSOR OFF
        RETURN(1)
      
   CASE MODO = 4
        IF TECLA = ESC
           SAVE SCREEN TO TELA
           CORATUAL=SETCOLOR()
           SET COLOR TO N/Rg*+,W+*/R,B+/N,B+/N
           CAIXA(17,24,22,56,"N/RG+*","R+/RG+*")
           @ 18,25 say PADC(" Sair do sistema",30)
           @ 19,25 say PADC(" (R) MMStec BookFone? ",30) 
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
              ERASE FONE.LIG
              LOGOMARCA()
              ?"&MAQUINA./&USUARIO."
              ?"INICIO     :"+DTOC(DTENTRADA)+" - "+HRENTRADA
              ?"FIM        :"+DTOC(DATE())+" - "+M->SAIDA
              ?"================================="
              ?"TEMPO TOTAL:             "+ELAPTIME(HRENTRADA,M->SAIDA)

              *tone(1000, 1)
              *tone(800, 2)
              *tone(1200, 1)
              Tone(146.80,13)
              Tone(146.80,13)
              Tone(196,18)
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
                 save screen to tela
                 set cursor on
                 campo:=fieldName(INDICE)
                 vReg :=Recno()
                 Tone(1000,1)
                 IF At('*',NOME)<>0 .AND. M->SENHA<>"MASTER"
                    Tone(146.80,13)
                    Tone(146.80,13)
                    Tone(196,18)
                    ALERT("SINTO MUITO;; ESTE REGISTRO NAO PODE ;SER ALTERADO POR;"+ALLTRIM(USUARIO),,"R/RG*")
                 ELSE
                 IF type("&CAMPO")="M"
                   MEMOTELA=SAVESCREEN(8,9,21,71)
                   set color to bg+/B*
                   CAIXA(08,09,20,71,"N /B+*","W+/B+*")
                   CAIXA(10,10,18,70,"W+/B+*","N /B+*",.F.)
                   @ 09,11 say padC("Editando Observacoes"   ,59)      color "w+/b*"
                   @ 19,11 say padC("* Crtl-W sai gravando * ",59)     color "w+/b*"
                   REPLACE &CAMPO WITH MEMOEDIT(&CAMPO,11,12,17,69,.T.)
                   RESTSCREEN(8,9,21,71,MEMOTELA)
                   set cursor off
                   AUDITOR(,"EDITA CAMPO "+ALLTRIM(CAMPO)+" DE:"+CHR(13)+CHR(10)+SPACE(11)+ALLTRIM(FONE->NOME))   
                 ELSE
                   @ ROW(),COL() GET &CAMPO COLOR "W+/R"
                   AUDITOR(,"EDITA CAMPO "+ALLTRIM(CAMPO)+" DE:"+CHR(13)+CHR(10)+SPACE(11)+ALLTRIM(FONE->NOME))   
                   READ
                   clear gets
                 ENDIF
                 ENDIF                                           
                 go vReg
                 return(2)

          ELSEIF TECLA = 73 .OR. TECLA = 105
                 SAVE SCREEN TO TELA
                 if (!isprinter())
                    ALERT("* IMPRESSORA DESLIGADA *")
                 else
                    relatorio()
                    SET DEVI TO SCREEN
                    SET FILTER TO
                 endif
                 RESTORE SCREEN FROM TELA
                 RETURN (2)

          ELSEIF TECLA = 076 .OR. TECLA = 108
                 SAVE SCREEN TO TELA
                 APPEND BLANK
                 M->vCODIGO=STRzero(LASTREC(),6)
                 M->vNOME  =SPACE(35)
                 M->vDDD   =SPACE(04)
                 M->vFONE  =SPACE(15)
                 M->vOBS   =SPACE(35)
                 caixa(07,17,20,57,"N /B*","w+/B*")
                 @ 08,20 SAY PADC("LAN€ANDO REGISTROS",35) COLOR "W+/R"
                 @ 10,20 SAY "Nome"                  color "Bg+/b*"
                 @ 12,20 say "DDD"                   color "Bg+/b*"
                 @ 12,25 say "Telefone"              color "Bg+/b*"
                 @ 14,20 say "Observa‡Æo"            color "Bg+/b*"

                 @ 11,20 get M->vNOME picture "@!"  VALID VALIDADE(M->vNOME) color "W+/b,N/bG*"
                 @ 13,20 get M->vDDD picture "@!"  VALID VALIDADE(M->vDDD) color "W+/b,N/bG*"
                 @ 13,25 get M->vFONE picture "@!"  VALID VALIDADE(M->vFONE) color "W+/b,N/bG*"
                 @ 15,20 get M->vOBS picture  "@!"                           color "W+/b,N/bG*"
                 @ 17,20 say padc("Existe " + alltrim(Str(LastRec() - 1,4)) + " registros no arquivo", 35) color "b/b*"
                 @ 18,20 say padc(">> "+trim(dbf())+" <<", 35) color "b/b*"
                 SET CURSOR ON
                 READ
                 REPLACE CODIGO WITH M->vCODIGO
                 REPLACE NOME WITH M->vNOME
                 REPLACE DDD WITH STRZERO(VAL(vDDD),4)  
                 REPLACE FONE WITH M->vFONE
                 REPLACE OBS WITH "Cadastrado por "+alltrim(usuario)+" em "+DTOC(DATE())+" as "+time()+chr(13)+chr(10)+alltrim(M->vOBS) 
                 IF LASTKEY()=27
                    DELETE
                    PACK
                 ELSE
                    AUDITOR(,"INCLUE REGISTRO"+CHR(13)+CHR(10)+SPACE(11)+vNOME) 
                 ENDIF
                 RESTORE SCREEN FROM TELA
                 SET CURSOR OFF
                 SET COLOR TO
                 RETURN(2)

          ELSEIF TECLA = 65 .OR. TECLA = 97
                 SAVE SCREEN TO TELA
                 RESPOSTA := 1
                 vNOME    := NOME
                 IF At('*',NOME)<>0
                    ALERT("SINTO MUITO;;ESTE REGISTRO NAO DEVE;SER ELIMINADO DO BANCO DE DADOS",,"R/RG*")
                 ELSE
                    NOMEATUAL=NOME
                    SET COLOR TO N/Rg*+,W+*/R,B+/N,B+/N
                    CAIXA(10,20,15,60,"N/RG+*","R+/RG+*")
                    @ 11,21 say PADC(' Elimina registro corrente, ',38) 
                    @ 12,21 say PADC('"'+alltrim(padc(nome,35))+'"?',38) 
                    TONE(500,5)
                    @ 14,35 PROMPT " Sim "
                    @ 14,40 PROMPT " N„o "
                    MENU TO RESPOSTA
                    READ
                    IF RESPOSTA = 1
                       DELETE
                       AUDITOR(,"ELIMINA REGISTRO"+CHR(13)+CHR(10)+SPACE(11)+NOMEATUAL) 
                       PACK
                       INDEX on NOME+DDD to iFONE.NTX
                       RESTORE SCREEN FROM TELA
                       ALERT(ALLTRIM(USUARIO)+';VOCE ELIMINOU O REGISTRO;;"'+ALLTRIM(NOMEATUAL)+'"',,"RG+/RG")
                    ENDIF
                 ENDIF
                 RESTORE SCREEN FROM TELA
                 SET COLOR TO W/B,N /BG*,B+/N,B+/N
                 SET SOFTSEEK On
                 SEEK trim(vNOME)
                 SET SOFTSEEK OFF
                 RETURN(2)

          ELSEIF TECLA = DEL
                 ALERT("Para EXCLUIR tecle; [A] ;de Apagar")
                 RETURN(2)

          ELSEIF TECLA = ENTER
                 CAMPO=FIELDNAME(INDICE)
                 IF TYPE("&CAMPO")="M"
                    AUDITOR(,"VISUALIZA CAMPO "+ALLTRIM(CAMPO)+" DE:"+CHR(13)+CHR(10)+SPACE(11)+ALLTRIM(FONE->NOME))   
                    SAVE SCREEN TO MemoTela
                    set cursor off
                    nLinha=MLCOUNT(&CAMPO,60)
                    set color to N+/RG+*  
                    caixa(06,06,13+nLinha,74,"N/RG+*","R+/RG+*")
                    @ 07,10 say "Nome: "+NOME color "N/RG+*"
                    @ 08,10 say "Fone: "+FONE color "N/RG+*"
                    @ 10,10 say "Observacoes" color "N/RG+*"
                    @ 11,10 say "==========================" color "N/RG+*"
                    FOR A=0 TO nlinha
                        @ 12+A,10 SAY PADC(MEMOLINE(&CAMPO,60,A),60) color "N/RG+*"
                    NEXT
                    INKEY(0)
                    RESTORE SCREEN FROM MemoTela
                 ELSE
                     AUDITOR(,"VISUALIZA CAMPO "+ALLTRIM(CAMPO)+" DE:"+CHR(13)+CHR(10)+SPACE(11)+ALLTRIM(FONE->NOME))   
                     ALERT("PARA EDITAR ESCOLHA [E] DITAR",,"n+/w*")

                 ENDIF
                 RETURN 2

          ELSE
                 help=     "[P] ...: procurar    ;"
                 help=HELP+"[E] ...: editar      ;"
                 help=help+"[A] ...: apagar      ;"
                 help=help+"[L] ...: lan‡ar      ;"
                 help=help+"[I] ...: imprimir    ;"
                 help=help+"[F1] ..: ajuda       ;"
                 help=help+"[F11] .: auditoria   ;"
                 help=help+"[F12] .: trocar senha;"
                 ALERT("&SISTEMA.;;&HELP",,"W+/G")
                 RETURN 2        
          ENDIF
      OTHERWISE
          setcolor("W/B,N /BG*,B+/N,W+/B*")
          @ 01,45,03,75 BOX(REPL("Û",9))  COLOR "RG/RG+*"                         
          SOMBRA(01,45,03,75)
          IF At('*',NOME)<>0 .OR. At('*',FONE)<>0
              MMSLET04(01,48,SUBSTR(FONE,1,8),0,"R/RG+*")
           ELSE
            @ 01,45 say padr("1."+ALLTRIM(MEMOLINE(OBS,27,1)),30)      color "n/RG+*"
            @ 02,45 say padr("2."+ALLTRIM(MEMOLINE(OBS,27,2)),30)      color "n/RG+*"
            @ 03,45 say padr("3."+ALLTRIM(MEMOLINE(OBS,27,3)),30)      color "n/RG+*"
          ENDIF
          @ 04,05 SAY "&USUARIO./"+PADR(DBF(),8) color "R+/b"
          @ 23,05 say padC(data(),70) color "bg+/b"
          SET CURSOR OFF
          TONE(10000,0.5)
          RETURN(1)
      ENDCASE

FUNCTION CONSULTA
     set cursor on
     nRec  := 0
     lDone := .F.
     psq   := space(54)     
     do while .T.
          @ 23,05 say PADR("Procurar :",70)        COLOR "W+/B"
          @ 23,21 get PSQ PICT "@!"                COLOR ",N/RG+*"
          set cursor on
          read
          set cursor off
          if lastKey()=27
             exit
          endif
          nRec := Recno()
          seek trim(PSQ)
          
          if !found()
             @ 23,05 say PADC('Verifique os digitos de sua procura',70)        COLOR "W+/B"
             tone(1000, 1)
             tone(800, 2)
             tone(1200, 1)
             AUDITOR(,"PROCURA REGISTRO"+CHR(13)+CHR(10)+SPACE(11)+TRIM(PSQ)+CHR(13)+CHR(10)+SPACE(11)+"NAO LOCALIZA")
             ALERT('&SISTEMA.;; O sistema n„o p“de localizar uma correspondˆcia para "'+alltrim(PSQ)+'"; Caso vocˆ tenha certeza sobre a existˆncia dos dados procurados no arquivo atual, verifique a digita‡„o e tente novamente.;;;')
             goto nRec
             loop
           else
             lDone := .T.
             mensagem("Registro localizado!",0.01,"W+/B")
             AUDITOR(,"PROCURA REGISTRO"+CHR(13)+CHR(10)+SPACE(11)+TRIM(PSQ)+;
             CHR(13)+CHR(10)+SPACE(11)+"LOCALIZA '"+TRIM(FONE->(NOME))+"/"+TRIM(FONE->(FONE))+"'")
          endif
          exit
     enddo
set deleted on
return (lDone)

func do_seek
local lDone, nRec, cSeekType
memvar k_trim,ntx_expr

	lDone := .F.

	if Empty(k_trim)
          mensagem("Expression not entered",0,"W+/B")
	else
          mensagem("Searching...",0,"W+/B")

		/* save record number in case no find */
          nRec := Recno()

		/* determine type for seek */
		cSeekType := Type(ntx_expr)

		/* try it */
		do case
		case cSeekType == "C"
			/* character search */
			seek k_trim

		case cSeekType == "N"
			/* numeric search */
			seek Val(k_trim)

		case cSeekType == "D"
			/* date search */
			seek Ctod(k_trim)
		end

		if Found()
			/* operation complete */
               mensagem("Found",0,"W+/B")
               lDone := .T.
		else
			/* consider this an error..start over */
                mensagem("Not found",0,"W+/R")
			goto nRec
		end
	end

return (lDone)



FUNCTION VALIDADE(GET)
Tone(146.80,10)
Tone(146.80,10)
Tone(196,15)
REG   = RECN()
ORDEM = INDEXORD()
SET ORDER TO 1
IF EMPTY(GET) .AND. LASTKEY()<>5
   ALERT("SINTO MUITO;; MAS O PREENCHIMENTO  OBRIGATàRIO")
   RETURN.F.
ENDIF
IF DBSEEK(GET)=.T.
   ALERT("SINTO MUITO;"+REPL("Ä",20)+";"+TRIM(GET)+";"+REPL("Ä",20)+";Jµ EXISTE;;TENTE OUTRO")
   GOTO REG
   RETURN.F.
ENDIF
SET ORDER TO ORDEM
GOTO REG
RETURN.T.

function senha
   if !file("senha.dbf")
      fcampo:={}
      aadd( fcampo,{"NOME","C", 35,  0} )
      aadd( fcampo,{"SENHA","C", 6,  0} )   
      dBCreate("senha",fcampo)
      use senha
      index on nome to iSENHA.ntx
   else
      use senha
      index on nome to iSENHA.ntx
   endif
   vUSUARIO := SPACE(57)
   vSENHA   := ctod("  /  /  ")
   vTENTA   := 0
   do while .t.
      if vTenta >= 3
         cls
         ALERT("Suas chances terminaram",,"W+/R+")
         quit
      elseif lastkey()==27
             quit
             exit
      endif
      @ 10,09,18,71 box("        Û") color "w+/n"
      @ 12,12 say padc("Usuario entre com seu nome...",58)
      @ 14,12 get vUSUARIO pict "@!" 
      read
      IF EMPTY(vUSUARIO) .AND. LASTKEY()<>5
         ALERT("Preenchimento obrigatorio")
         LOOP
         RETURN.F.
      ENDIF
      @ 16,12 say padc(">>Digite a senha de acesso<<",56)  color "w+*/r"
      @ 90,12 get vSENHA PICT "@!" color "n/n" valid validade(vSENHA)
      set cursor on
      READ
      IF EMPTY(vSENHA) .AND. LASTKEY()<>5
         ALERT("Preenchimento obrigatorio")
         LOOP
         RETURN.F.
      ENDIF
      if vsenha <> date()
         TONE(950,8)
         ALERT("SINTO MUITO.;Senha incorreta",,"W+/RG+")
         vtenta=vtenta+1
         vsenha=ctod("  /  /  ")
         loop
      endif
      set cursor off
      seek trim(vUSUARIO)
      if eof()
         vtenta=vtenta+1
         ALERT("TENTATIVA:"+STR(VTENTA,2)+";Usuario n„o encontrado.;Tente novamente")
         loop
      else
         ALERT(trim(nome),,"W+/G+")
      endif
      exit
   enddo
usuario=vusuario
RETURN USUARIO

FUNCTION RELATORIO
   USE FONE
   INDEX on NOME+DDD to iFONE.NTX
   FILTRO1 := space(35)
   FILTRO2 := space(35)
   caixa(07,22,17, 60)
   @  8,024 say padc("RELATORIO IMPRESSO", 35)         color "W+/R"
   @ 10,024 say "Nome ou letra inicial a ser impresso" color "bg+/b"
   @ 11,024 get FILTRO1 pict "@!"  
   @ 13,024 say "Nome ou letra final a ser impresso"   color "bg+/b"       
   @ 14,024 get FILTRO2 pict "@!"  
   SET CURSOR ON
   READ
   @ 16,024 SAY PADC("*** Aguarde a impressao final ***",35) COLOR ("W+*/R*")
   SET CURSOR OFF
   AUDITOR(,"IMPRIME REGISTRO"+CHR(13)+CHR(10)+"DE "+TRIM(filtro1)+" A "+TRIM(filtro2))
   SET CURSOR OFF
   IF LASTKEY()=27
      SET DEVI TO SCREEN
      SET FILTER TO
      ALERT("IMPRESSAO ABORTADA")
      RETURN(1)
   ENDIF
   SET FILTER TO TRIM(NOME)>=TRIM(FILTRO1) .AND. TRIM(NOME)<=TRIM(FILTRO2)
   IF !(TRIM(NOME)>=TRIM(FILTRO1) .AND. TRIM(NOME)<=TRIM(FILTRO2))
      SKIP
   ENDIF

   SET DEVI TO PRINT
   TOTALVALOR:= 0
   TOTALJUROS:= 0
   REGISTRO  := 0
   LINHA     := 0
   PAGINA    := 0

   do while (!EOF())
      if (linha == 0)
         Pagina++
         @ linha+0,00 say ""

         @ linha+0,  00 say PADC(DBDATA(date())+" - " + TIME()+" P gina " + alltrim(str(pagina)),80)
         @ linha+1,  00 say padC(UPPER(EMPRESA),80)
         @ linha+2,  00 say padC("RELATORIO DE TELEFONES",80)
         @ linha+3,  00 say padC('Impress„o de "'+ Trim(filtro1) +'" a "' + Trim(filtro2)+'"',80)
         @ linha+5,  0 say REPL("*",80)
         @ linha+6,  0 say "Nome"
         @ linha+6, 37 say "Telefone"
         @ linha+7,  0 say REPL("*",80)
         linha = 8
      endif

      @ linha, 00 say NOME
      @ linha, 37 say FONE
      REGISTRO++
      LINHA++
      SKIP
      if (linha >= 55 .OR. EOF())
         if (EOF())
            TOT_01(2)
            exit
         else
            TOT_01(1)
         endif
         linha:= 1
      endif
   enddo
   SET DEVI TO SCREEN
   SET FILTER TO
   return.T.

FUNCTION TOT_01
PARA PAR1
IF PAR1=2
   @ LINHA+01,000 SAY "* (FIM) "+REPL("*",71)
ELSE                                               
  @ LINHA+01,000 SAY "* (CONTINUA) "+REPL("*",77)
ENDIF       
IF PAR1=2
   @ LINHA+03,000 SAY "TOTAL DE PARTICIPANTES : "+ALLTRIM(STR(RECNO()))
   @ LINHA+04,000 SAY "PARTICIPANTES IMPRESSOS: "+ALLTRIM(STR(REGISTRO))
   @ LINHA+05,000 SAY "RELATORIO IMPRESSO POR "+ALLTRIM(UPPER(Usuario))+"."
ENDIF
LINHA=0
EJECT
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

 REG_ATUAL=FIELDNAME(2)
 
 IF DBF()+".DBF"="FONE.DBF"
    set cursor off
    M->DDD=IIF(EMPTY(FONE->DDD),"0073",FONE->DDD)
    Replace FONE->CODIGO with STRZERO(RECNO(),6)
    Replace FONE->DDD with STRZERO(VAL(FONE->DDD),4)
 ENDIF

 grafico   := int ( ( RecNo() / LastRec() ) *  60 )
 percentual:= int ( ( RecNo() / LastRec() ) * 100 )
 
 @ L-1  ,10 + grafico say "Û"+repl(" ",60-grafico)                 color "rg+/n"
 @ L+1  ,10 say padc(Str(percentual,3 )+"%"+" conclu¡do",60)       color "rg+/N"
 @ L+3  ,10 say padc(ALLTRIM(&REG_ATUAL),60) color "N/B"
 @ L-3  ,10 say padc("Arquivo corrente: "+dbf(),60)                 color "W+/N"
Return (.T.)

FUNCTION TROCAUSUARIO
   SAVE SCREEN TO TELA
   SET COLOR TO N/Rg*+,W+*/R,B+/N,B+/N
   CAIXA(11,20,15,60,"N/RG+*","R+/RG+*")
   M->SENHA :=SPACE(10)
   DO WHILE .T.
       @ 12,21 SAY PADC(ALLTRIM(USUARIO)+" ENTRE COM A SENHA:",38)
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
*@ 08,10 clear to 18,71
*@ 08,10       to 18,71 DOUBLE
*@ 08,10 say PADC(" A U D I T O R I A ",62) color "R/W+*"
JANELA(08,10,18,71," A U D I T O R I A ")
@ 09,10 say PADC(ALLTRIM(MEMOLINE(FONELOG->HISTORICO,58,1)),62) color "B/W+*"
MEMOEDIT(FONELOG->HISTORICO,11,12,17,69,.F.)
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
        Replace FONELOG->DATA with DtENTRADA
        Replace FONELOG->INICIO with HrENTRADA
        Replace FONELOG->MAQUINA with ALLTRIM(NETNAME())
        Replace FONELOG->USUARIO with M->USU
        Replace FONELOG->HISTORICO with FONELOG->HISTORICO+DTOC(DtENTRADA)+" &MAQUINA/&USU"+CHR(13)+CHR(10)+LOCAL2
   case local1="F"
        sele 2
        SEEK TRIM(DTOS(DtENTRADA))+HrENTRADA+MAQUINA+USUARIO
        Replace FONELOG->FIM with M->SAIDA
        Replace FONELOG->HISTORICO with FONELOG->HISTORICO+LOCAL2
        Replace FONELOG->HISTORICO with FONELOG->HISTORICO+"  "+ELAPTIME(HRENTRADA,TIME())+" TEMPO USADO" 
   otherwise
        sele 2
        SEEK TRIM(DTOS(DtENTRADA))+HrENTRADA+MAQUINA+USUARIO
        Replace FONELOG->HISTORICO with FONELOG->HISTORICO+LOCAL2
ENDCASE        
@ 04,05 SAY "&USUARIO./"+PADR(DBF(),8) color "RG+/b"
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


FUNCTION MSG( cMsg, acChoices )
   RETURN ( ALERT( cMsg, acChoices ) )

FUNCTION LERMEMO
  PARA LER1,LER2,LER3,LER4
  JANELA(LER1,LER2,LER3,LER4)
  SELE 2
  nLinha=MLCOUNT(FONELOG->HISTORICO,60)
  FOR A=0 TO nlinha
      @ LER1+1,10 SAY PADC(MEMOLINE(FONELOG->HISTORICO,60,nlinha-1),60) color "N/RG+*"
      @ LER1+2,10 SAY PADC(MEMOLINE(FONELOG->HISTORICO,60,nlinha),60) color "N/RG+*"
  NEXT
  SELE 1
RETURN
