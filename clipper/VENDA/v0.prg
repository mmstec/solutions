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

   CRIA_DBASE()

   IF FILE("fone.LIG") .AND. FILE("FoneLOG.DBF") .AND. FILE("Fone.DBF") .and. FILE("Fonesys.DBF")
      CLS
      if (!UseRede("FoneLOG", .T., 5))
         IF FILE("Fone.LIG")
            restore from Fone.LIG ADDITIVE
            setblink(.F.)
            cMensagem :="A T E N C A O;;"+;
                        "O sistema para consulta de telefones MMStec BookFone (R)"+;
                        ";n„o se encontra dispon¡vel no momento." +;
                        ";;MOTIVO: O programa esta sendo usado em outra maquina"+;
                        ";;"+REPL("Ä",40)+;
                        ";Executavel em uso. :"+padr(LogPRO,20)+;
                        ";Maquina ligada . . :"+padr(LOGMAQ,20)+;
                        ";Nome do usuario. . :"+padr(alltrim(LogUSO),20)+;
                        ";Data de inicio . . :"+padr(LogDATA,20)+;
                        ";Hora de inicio . . :"+padr(LogHORA,20)+;
                        ";"+REPL("Ä",40)
            cResposta :={ padc("SAIDA",18) }
            cCor      :="W+/B" 
            ALERT(cMensagem, cResposta, cCor)
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

      cALERT  :="O sistema para consulta de telefones MMStec BookFone (R)"+;
                ";n„o se encontra dispon¡vel no momento." +;
                ";;MOTIVO: O programa foi finalidado incorretamente"+;
                ";;"+STATUS+;
                ";;Vocˆ ‚ tem senha de SUPERVISOR?"
                               
      if (Alert(cALERT,{ padc("NAO",05), padc("SIM",05) } ,"W+/R") == 1)
          ?"AVISO:"
          ?"O Programa foi finalizado incorretamente por "+alltrim(fonelog->usuario)
          ?"Procure o responsavel pelo sistema, imediatamente."
          ??
          quit
      else
         
         TROCAUSUARIO()
         IF M->SENHA=="MMSTEC"
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

   AUTOR    := "(C) Marcos Morais de Sousa - 1995/"+TRAN(YEAR(DATE()),"@E 9999")
   EMPRESA  := "BARRETO MATERIAL DE CONSTRUCAO"
   SISTEMA  := "MMStec BookFone (R) - vers„o "+Dtos(directory(procname()+".exe")[1,3])
   VERSAO   := DIRECTORY(PROCNAME()+".EXE")
   PROGRAMA := PROCNAME()+".EXE"
   MAQUINA  := ALLTRIM(NETNAME())
   USUARIO  := SPACE(58)
   FILTRO1  := space(35)
   FILTRO2  := space(35)
   DtENTRADA:= DATE()
   HrENTRADA:= TIME()

   SELE 3
   USE FONESYS
   INDEX on SENHA to iFONESYS.NTX 
   @ 04,03 SAY PADC("&SISTEMA",77)                         COLOR "BG"
   @ 05,03 SAY PADC("&AUTOR",77)                           COLOR "BG"
   @ 20,03 SAY PADC(dbData(),77)                           COLOR "W+"
   @ 22,03 SAY PADC(ANO2000,77)                            COLOR "W+"
   if libera()
      else
      quit
   endif
   USUARIO  := IIF(EMPTY(USUARIO),"NAO IDENTIFICADO",TRIM(UPPER(USUARIO)))
   usuario  := substr(USUARIO,1, at(chr(32),USUARIO))
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
   setcolor("W/B,N /BG*,B+/N,B+/N")
   cls
   SELE 1
   USE FONE
   INDEX on NOME+DDD to ifone.ntx  EVAL {|| PROGRESSO() } EVERY 1
   SELE 2
   USE FONELOG 
   INDEX on DTOS(DATA)+INICIO+MAQUINA+USUARIO to iFONELOG.NTX EVAL {|| PROGRESSO() } EVERY 1
   AUDITOR("I",M->ENTRADA)
   SELE 3
   USE FONESYS
   INDEX on SENHA to iFONESYS.NTX 
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
   SET COLOR TO n/w,bg+/n,b+/n,b+/n
   cls
   relevo(00, 00, 24, 79, .F.)
   relevo(05, 05, 21, 75, .T.)
   @ 02,05 SAY SISTEMA                                color "bg+ /w"
   @ 03,05 SAY EMPRESA                                color "n   /w"
   @ 04,05 SAY substr(USUARIO,1, at(chr(32),USUARIO)) color "r+/w"
                            
   GO TOP
   DBEDIT(07,06,20,74,REGISTRO,"EDITA",MASCARA,TITULO,"   ","  ","   ",.T.)
   
FUNCTION EDITA(MODO,INDICE)
LOCAL TECLA  
xcTamFile:=DIRECTORY("FONE.TXT","2")
TECLA := LASTKEY()
CAMPO := FIELDNAME(INDICE)
DO CASE
   CASE MODO = 1
        MENSAGEM("Inicio do Arquivo",3,"W+/w")
        MENSAGEM("",,"W+/w")
        SET CURSOR OFF
        RETURN(1)

   CASE MODO = 2
        MENSAGEM("Final do Arquivo",3,"W+/w")
        MENSAGEM("",,"W+/w")
        SET CURSOR OFF
        RETURN(1)
      
   CASE MODO = 3
        MENSAGEM("Arquivo Vazio",,"W+/w")
        SET CURSOR OFF
        RETURN(1)
      
   CASE MODO = 4
        IF TECLA = ESC
           SAVE SCREEN TO TELA
           CORATUAL=SETCOLOR()
           set color to N/Rg*+,W+*/R,B+/N,B+/N
           @  17, 24 clear to 22, 56
           relevo(17,24,22,56, .T., "RG+*")
           @ 18,25 say PADC("Sair do sistema",30)
           @ 19,25 say PADC("(R) MMStec BookFone? ",30) 
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

          ELSEIF TECLA = F5
                 IF M->SENHA<>"MMSTEC"
                    ALERT("AVISO;;VOCE NAO PODE;INCLUIR USUARIO E/OU SENHA")
                    ELSE
                    SAVE SCREEN TO TELA
                    AUDITOR(,"INCLUI USUARIO/SENHA")
                    sele 3
                    inclui_usu()
                    sele 1
                    RESTORE SCREEN FROM TELA
                 ENDIF
                 RETURN(2)
          ELSEIF TECLA = F6
                 IF M->SENHA<>"MMSTEC"
                   ALERT("AVISO;;VOCE NAO PODE;ALTERAR USUARIO E/OU SENHA")
                   ELSE
                   AUDITOR(,"VER/ALTERA USUARIO/SENHA")
                   sele 3
                   SET COLOR TO n/w,w+/n,b+/n,b+/n
                   DBEDIT(07,06,20,74,,,,,"   ","  ","   ",.T.)
                   sele 1
                 ENDIF
                 RETURN(2)
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
                 SETCOLOR("W+/b")
                 caixa(07,17,19,60)
                 do while LastKey()<>27
                    inkey(0.05)
                    @ 08,20 SAY "(C) Marcos Morais de Sousa - 1995/"+TRAN(YEAR(DATE()),"@E 9999") color "bg+/b"
                    @ 09,20 say "Mem¢ria livre   :"+alltrim(str(memory(2)))+" kb"  color "bg/B"
                    @ 11,20 SAY "Programa        :"+trim(programa)
                    @ 12,20 SAY "M quina         :"+trim(maquina)    
                    @ 13,20 SAY "Usu rio         :"+trim(usuario)   
                    @ 14,20 SAY "Entrada         :"+trim(dtoc(DTentrada)+" "+HRentrada)
                    @ 15,20 SAY "Rel¢gio         :"+trim(dtoc(date())+" "+TIME())
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
                 IF At('*',NOME)<>0 .AND. M->SENHA<>"MMSTEC"
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
                   @ ROW(),COL() GET &CAMPO COLOR "W+/R+"
                   AUDITOR(,"EDITA CAMPO "+ALLTRIM(CAMPO)+" DE:"+CHR(13)+CHR(10)+SPACE(11)+ALLTRIM(FONE->NOME))   
                   READ
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
                 M->vRAMO  =SPACE(35)
                 M->vNOME  =SPACE(35)
                 M->vDDD   =SPACE(04)
                 M->vFONE  =SPACE(15)
                 M->vOBS1  =SPACE(35)
                 M->vOBS2  =SPACE(35)
                 M->vOBS3  =SPACE(35)
                 relevo(05,17,21,57, .T., "B*")
                 @ 06,20 SAY PADC("LAN€ANDO REGISTROS",35) COLOR "W+/R"
                 @ 08,20 SAY "Nome"                  color "Bg+/b*"
                 @ 10,20 say "Ramo/Atividade"        color "Bg+/b*"
                 @ 12,20 say "DDD"                   color "Bg+/b*"
                 @ 12,25 say "Telefone"              color "Bg+/b*"
                 @ 14,20 say "Observa‡Æo"            color "Bg+/b*"

                 @ 09,20 get M->vNOME picture "@!"  VALID VALIDADE(M->vNOME) color "W+/b,N/bG*"
                 @ 11,20 get M->vRAMO picture "@!"  VALID VALIDADE(M->vRAMO) color "W+/b,N/bG*"
                 @ 13,20 get M->vDDD  picture "@!"  VALID VALIDADE(M->vDDD) color "W+/b,N/bG*"
                 @ 13,25 get M->vFONE picture "@!"  VALID VALIDADE(M->vFONE) color "W+/b,N/bG*"
                 @ 15,20 get M->vOBS1 picture "@!"                           color "W+/b,N/bG*"
                 @ 16,20 get M->vOBS2 picture "@!"                           color "W+/b,N/bG*"
                 @ 17,20 get M->vOBS3 picture "@!"                           color "W+/b,N/bG*"
                 @ 19,20 say padc("Existe " + alltrim(Str(LastRec() - 1,4)) + " registros no arquivo", 35) color "b/b*"
                 @ 20,20 say padc(">> "+trim(dbf())+" <<", 35) color "b/b*"
                 SET CURSOR ON
                 READ
                 REPLACE CODIGO WITH M->vCODIGO
                 REPLACE NOME WITH M->vNOME
                 REPLACE RAMO WITH ALLTRIM(M->vRAMO)
                 REPLACE DDD WITH STRZERO(VAL(vDDD),4)
                 REPLACE FONE WITH M->vFONE
                 REPLACE OBS WITH "Resp.: "+alltrim(usuario)+" Data:"+DTOC(DATE())+" "+TIME()
                 REPLACE OBS WITH OBS+chr(13)+chr(10)+alltrim(M->vOBS1) 
                 REPLACE OBS WITH OBS+chr(13)+chr(10)+alltrim(M->vOBS2) 
                 REPLACE OBS WITH OBS+chr(13)+chr(10)+alltrim(M->vOBS3) 
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
                    SET COLOR TO N/Rg*+,W+*/R+,B+/N,B+/N
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
                     cMensagem=Alltrim(Ramo)+";;"+Alltrim(nome)+";("+alltrim(ddd)+") "+alltrim(fone)
                     cResposta=" Ok "
                     cCor     ="w+/b*"
                     ALERT(cMensagem,{ cResposta },cCor)
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
            @ 01,45 say padr(" "+ALLTRIM(MEMOLINE(OBS,27,1)),30)      color "n/RG+*"
            @ 02,45 say padr(" "+ALLTRIM(MEMOLINE(OBS,27,2)),30)      color "n/RG+*"
            @ 03,45 say padr(" "+ALLTRIM(MEMOLINE(OBS,27,3)),30)      color "n/RG+*"
          ENDIF
          @ 04,05 SAY "&USUARIO."+PADR(logHora,05) color "b/w"
          @ 23,05 say padC(data()+" "+padr(time(),05),70) color "bg+/w"
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
          @ 23,05 say PADR("Procurar :",70)           COLOR "r/w"
          @ 23,21 get PSQ pict "@!" valid !empty(psq) COLOR ",N/RG+*"
          set cursor on
          read
          @ 23,05 say padc('Se preferir, tecle "PRINT SCRN" para imprimir esta pesquisa',70)  COLOR "bg+/w"
          set cursor off
          if lastKey()=27
             exit
          endif

          nRec   := Recno()
          nConta :=1
          nReg   :=0
          cNomes :=""
          procura:=PSQ

          seek trim(PROCURA)
          locate for nome=trim(procura) while nome=trim(procura)
          do while found()
             cNomes=cNomes+PadR(alltrim(nome),30)+"Tel.:("+DDD+") "+ALLTRIM(FONE)+";"
             skip
             nReg++
             locate rest for nome=trim(procura)
          ENDDO
          seek trim(PSQ)
          if !found()
             @ 23,05 say PADC('Verifique os digitos de sua procura',70)   COLOR "W+/W"
             tone(1000, 1)
             tone(800,  2)
             tone(1200, 1)
             AUDITOR(,"PROCURA REGISTRO"+CHR(13)+CHR(10)+SPACE(11)+TRIM(PSQ)+CHR(13)+CHR(10)+SPACE(11)+"NAO LOCALIZA")
             ALERT('&SISTEMA.;; O sistema n„o p“de localizar uma correspondˆcia para "'+alltrim(PSQ)+'"; Caso vocˆ tenha certeza sobre a existˆncia dos dados procurados no arquivo atual, verifique a digita‡„o e tente novamente.;;;')
             goto nRec
             loop
           else
             lDone := .T.
             do while !eof()
                if nReg>8
                   cNomes    :=alltrim(nome)+";("+DDD+") "+ALLTRIM(FONE)
                   cMensagem :=SISTEMA+';'+EMPRESA+';;'+;
                               'PROCURANDO "'+alltrim(psq)+'";;'+;
                                repl("Ä",35)+';'+;
                                cNomes+";"+repl("Ä",35)+";"+;
                               'Encontrado a ocorrˆncia "'+;
                                alltrim(str(nConta))+'" de "'+alltrim(str(nReg))+'";;'+;
                               ';Deseja prosseguir para a pr¢xima ocorrˆncia?'
                   cResposta :={ padc("SIM",05), padc("NAO",05) }

                else
                   nConta    :=nReg
                   cNomes    :=cNomes
                   cMensagem :=SISTEMA+';'+EMPRESA+';;'+;
                               'PROCURANDO "'+alltrim(psq)+'";;'+;
                               repl("Ä",50)+';'+;
                               cNomes+repl("Ä",50)+';;'+;
                               'Encontrado "'+alltrim(str(nReg))+'" ocorrˆncia(s)'
                               cResposta :={ padc("FINAL DA PROCURA",18) }
                endif
                nConta++
                nRec:=RecNo()   
                if (Alert(cMensagem, cResposta ,"W+/N") == 1 .AND. nConta<=nReg )
                   dbskip( 1 )
                   tone(750,3)
                   else
                   tone(1000, 1)
                   tone(0800, 2)
                   tone(1200, 1)
                   AUDITOR(,"PROCURA REGISTRO"+CHR(13)+CHR(10)+SPACE(11)+TRIM(PSQ)+;
                   CHR(13)+CHR(10)+SPACE(11)+"LOCALIZA '"+TRIM(FONE->(NOME))+"/"+TRIM(FONE->(FONE))+"'")
                   goto nRec
                   exit
                endif
             enddo

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
          nRec       := Recno()
          cSeekType := Type(ntx_expr)
          do case
             case cSeekType == "C"
                  seek k_trim
             case cSeekType == "N"
                  seek Val(k_trim)
             case cSeekType == "D"
                  seek Ctod(k_trim)
          endcase
          if Found()
             mensagem("Found",0,"W+/B")
             lDone := .T.
            else
             mensagem("Not found",0,"W+/R")
             goto nRec
         endif
        endif
return (lDone)


FUNCTION VALIDADE(GET)
REG   = RECN()
ORDEM = INDEXORD()
SET ORDER TO 1
IF EMPTY(GET) .AND. LASTKEY()<>5
   tone(100,3)
   ALERT("SINTO MUITO;; MAS O PREENCHIMENTO  OBRIGATàRIO")
   RETURN.F.
ENDIF
IF DBSEEK(GET)=.T.
   tone(100,3)
   ALERT("SINTO MUITO;"+REPL("Ä",20)+";"+TRIM(GET)+";"+REPL("Ä",20)+";Jµ EXISTE;;TENTE OUTRO")
   GOTO REG
   RETURN.F.
ENDIF
SET ORDER TO ORDEM
GOTO REG
RETURN.T.


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
SELE 1
if local1="F"
   @ reclin,reccol say "<FIM>"
ENDIF
RETURN NIL


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
         usu_tmp:= fonesys->usuario
         sup_tmp:= nivel
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
         sup_tmp:= 3
         ok:= "S"
      endif
   endif
   return .T.
********************************
                   
********************************
function LIBERA

   public usu_tmp,sup_tmp
   if (!USEREDE("FONESYS",.F.,10))
      op_cao:= 0
      return .F.
      else
      INDEX on SENHA to iFONESYS.NTX 
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
      @ 11, 22 say "Senha: "   color "W+ /B"
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
            @ l, c say " "    color "RG+/B"
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
         alert(ALLTRIM(fonesys->usuario),,"N/W")
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
   IF !FILE("FONEsys.DBF")
      CAMPO0:={}
      AADD( CAMPO0,{"USUARIO","C", 45,  0})   
      AADD( CAMPO0,{"SENHA"  ,"C",  6,  0})
      AADD( CAMPO0,{"NIVEL"  ,"N",  1,  0})
      DBCREATE("FONESYS",CAMPO0)
      SELE 3
      USE FONESYS
      INDEX on SENHA to iFONESYS.NTX 
      M->ENTRADA=M->ENTRADA+CHR(13)+CHR(10)+SPACE(11)+"CRIA ARQUIVO "+DBF()
      inclui_usu()
   ENDIF
   IF !FILE("FONELOG.DBF")
      CAMPO1:={}
      AADD( CAMPO1,{"DATA","D", 8,  0})   
      AADD( CAMPO1,{"INICIO","C", 8,  0})
      AADD( CAMPO1,{"FIM","C", 8,  0})   
      AADD( CAMPO1,{"MAQUINA","C", 10, 0})
      AADD( CAMPO1,{"USUARIO","C", 45, 0})
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
      AADD( CAMPO2,{"NOME","C", 45,  0} )
      AADD( CAMPO2,{"RAMO","C", 45,  0} )   
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
   ENDIF
   RETURN.T.

function inclui_usu
   SELE 3
   SET INDEX to iFONESYS.NTX
   tentativa:= 0
   set cursor on
   do while (.T.)
      if (tentativa >= 3)
         alert("Sinto muito;;Esgotaram-se as tentativas permitidas;")
      endif
      cNome := space(45)
      cSenha:= space(06)
      nNivel:= 0
      caixa(07, 13, 15,67)
      @  9, 15 say "Nome : "       color "W+ /B"
      @ 11, 15 say "Senha: "       color "W+ /B"
      @ 13, 15 say "Nivel: "       color "W+ /B"

      @  9, 21 get cNome  PICT "@!" valid !empty(cNome)    color "w+/Bg"
      @ 11, 21 get cSenha PICT "@!" valid CODIFICA(cSenha) color "w+/Bg"
      @ 13, 21 get nNivel PICT "@9" valid !empty(nNivel)   color "w+/Bg"
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
      Replace nivel   with nNivel
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

   relevo(00, 00, 24, 79, .F.)
   relevo(05, 05, 21, 75, .T.)

function RELEVO(Arg1, Arg2, Arg3, Arg4, Arg5, Arg6)

   local Local1, Local2, Local3, Local4
   Local4:= SetColor()
   if (Arg6 = Nil)
      Arg6:= "W"
   endif
   Local2:= "+W/" + Arg6 
   Local3:= "+N/" + Arg6 
   if (Arg5 = Nil)
      Arg5:= .F.
   endif
   if (Arg5)
      set color to (Local2)
   else
      set color to (Local3)         
   endif
   @ Arg1, Arg2 clear to Arg3, Arg4
   *@ Arg1, Arg2 say "Ú"
   *@ Arg3, Arg2 say "À" + Replicate("Ä", Arg4 - Arg2 - 1)
   @ Arg1, Arg2 say "É"
   @ Arg3, Arg2 say "È" + Replicate("Í", Arg4 - Arg2 - 1)
   if (Arg3 - Arg1 == 2)
      *@ Arg1 + 1, Arg2 say "³"
      @ Arg1 + 1, Arg2 say "º"
   else
      @ Arg1 + 1, Arg2 to Arg3 - 1, Arg2 double
   endif
   if (Arg5)
      set color to (Local3)
   else
      set color to (Local2)
   endif
   if (Arg3 - Arg1 == 2)
      *@ Arg1 + 1, Arg4 say "³"
      @ Arg1 + 1, Arg4 say "º"
   else
      @ Arg1 + 1, Arg4 to Arg3 - 1, Arg4  double
   endif
   *@ Arg1, Arg2 + 1 say Replicate("Ä", Arg4 - Arg2 - 1) + "¿"
   *@ Arg3, Arg4 say "Ù"
   @ Arg1, Arg2 + 1 say Replicate("Í", Arg4 - Arg2 - 1) + "»"
   @ Arg3, Arg4 say "¼"                     
   set color to (Local4)
   return Nil
