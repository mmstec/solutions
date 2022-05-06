   *
   ****************************************************************************
   *
   * Programa......: MMS BookFone(R)
   * Descri‡Æo.....: Programa desenvolvido para armazenamento e processamento
   *                 de dados para Encontros de Pedreiros e Mestres de Obras
   * Autor.........: Marcos Morais de Sousa
   ****************************************************************************
   *
   * Compilar com .: CA-CLIPPER (5x)
   * Exemplo ......: Clipper EPMJ
   * Linkar com....: RTLINK   fi EPMJ lib mmstec (P/Clipper v5.0 a 5.2)
   * Linkar com....: EXOSPACE fi EPMJ lib mmstec (P/Clipper superior a v5.2)
   * ou............: BLINKER  fi EPMJ lib mmstec
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
   
   CLEAR

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
   VERSAO   := DIRECTORY("&PROGRAMA")
   MAQUINA  := ALLTRIM(NETNAME())
   USUARIO  := SPACE(58)
   DATAENTRA:= DTOC(DATE())
   ENTRADA  := TIME()
   ACAO     := time()+"-Entrada normal"+CHR(13)+CHR(10)
   FILTRO1  := space(35)
   FILTRO2  := space(35)
   AUTOR    := "(C) Marcos Morais de Sousa - 1995/"+TRAN(YEAR(DATE()),"@E 9999")
   SISTEMA  := "(R) MMStec EPMJ - vers„o "+Dtos(VERSAO[1,3])
   EMPRESA  := "Barreto Material de Construcao"
   TITULO   := "II Encontro de Pedreiros e Mestres de Obras de Jequie"
   SENHA    := Space(10)
   DO WHILE .T.
       MMSLET05(00,10,"EPMJ-98",3,"bg+/n")
       @ 04,03 SAY PADC("&TITULO",77)                          COLOR "R+"
       @ 06,03 SAY PADC("&SISTEMA",77)                         COLOR "BG"
       @ 07,03 SAY PADC("&AUTOR",77)                           COLOR "BG"
       @ 09,03 SAY PADC(dbData(),77)                           COLOR "W+"
       @ 10,03 SAY PADC(ANO2000,77)                            COLOR "W+"
       @ 12,10,18,71 box("        Û")                        color "b/n"
       caixa( 12,10, 18,71)
       @ 14,12 SAY "Usuario entre com seu nome" color "W+/B*+"
       @ 16,12 get USUARIO pict "@!" color "W+/BG"
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

   USUARIO  := IIF(EMPTY(USUARIO),"USUARIO ESTRANHO",TRIM(USUARIO))

   SET CURSOR ON

   M->CODIGO:=0
   IF FILE("EPMJ.LIG")
      RESTORE FROM EPMJ.LIG ADDITIVE
      ALERT("SISTEMA EM USO ;OU; DESLIGADO INCORRETAMENTE;;"+REPL("Ä",20)+";Maquina "+LOGMAQ+";Programa "+LogPRO+";Usu rio "+LogUSO+";; * Entrada *;"+LogINI,,"W+/B")
      QUIT

      ELSE
      LOGPRO := PROGRAMA
      LOGMAQ := MAQUINA
      LOGUSO := USUARIO
      LOGINI := DATAENTRA+"-"+ENTRADA

      IF FILE("EPMJ.DES")
         ERASE EPMJ.DES
         SAVE all like LOG* to EPMJ.LIG

         ELSE
         SAVE all like LOG* to EPMJ.LIG
      ENDIF
   ENDIF

   CLS
   IF !FILE("EPMJ.DBF")
      FCAMPO:={}
      AADD( FCAMPO,{"CODIGO","C", 6,  0} )   
      AADD( FCAMPO,{"NOME","C", 15,  0} )
      AADD( FCAMPO,{"SOBRENOME","C", 25,  0} )
      AADD( FCAMPO,{"DDD","C", 3,  0} )
      AADD( FCAMPO,{"FONE","C", 15,  0} )
      AADD( FCAMPO,{"REFERENCIA","C", 35,  0} )   
      AADD( FCAMPO,{"OBS","M", 10,  0} )
      DBCREATE("EPMJ",FCAMPO)
      *
      setcolor("W/B,N /BG*,B+/N,B+/N")
      cls
      USE EPMJ NEW
      INDEX on NOME+SOBRENOME to idEPMJ.ntx EVAL {|| PROGRESSO() } EVERY 1
      Append Blank
      Replace nome with "Marcos Morais de Sousa (*)"
      Replace fone with "525-2344/5932"
   ELSE
      *
      setcolor("W/B,N /BG*,B+/N,B+/N")
      cls
      USE EPMJ NEW
      INDEX on NOME+SOBRENOME to idEPMJ.ntx  EVAL {|| PROGRESSO() } EVERY 1
      *
   ENDIF

   PRIVATE Titulo[7]
           Titulo[1] = "CàDIGO"
           Titulo[2] = "NOME"
           Titulo[3] = "SOBRENOME"
           Titulo[4] = "DDD"
           Titulo[5] = "TELEFONE"
           Titulo[6] = "REFERENCIA"
           Titulo[7] = "OBSERVA€ÇO"
   
   PRIVATE MASCARA[7]  
           MASCARA[1] = "@!"
           MASCARA[2] = "@!"
           MASCARA[3] = "@!"
           MASCARA[4] = "@!"
           MASCARA[5] = "@!"
           MASCARA[6] = "@!"
           MASCARA[7] = "@!"

   DECLARE REGISTRO[7]           
           REGISTRO[1] = 'CODIGO'
           REGISTRO[2] = 'NOME'
           REGISTRO[3] = 'SOBRENOME'
           REGISTRO[4] = 'DDD'
           REGISTRO[5] = 'FONE'
           REGISTRO[6] = 'REFERENCIA'
           REGISTRO[7] = 'OBS'

   SETBLINK(.F.)
   SET COLOR TO W/B,N /BG*,B+/N,B+/N
   cls
   caixa(00,00,24,79,"N /B","b+/B")
   caixa(05,05,21,75,"b+/B","N /B")
   @ 02,05 SAY SISTEMA                           color "bg+ /b"
   @ 03,05 SAY EMPRESA+" - "+ALLTRIM(USUARIO)    color "bg  /b"
   @ 04,05 SAY "II Encontro de Pedreiros e Mestres de Obras de Jequie"                color "r+  /b"
   GO TOP
   DBEDIT(07,06,20,74,REGISTRO,"EDITA",MASCARA,TITULO,"   ","  ","   ",.T.)

FUNCTION EDITA(MODO,INDICE)
LOCAL TECLA  
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
           CAIXA(18,24,22,56,"N/RG+*","R+/RG+*")
           @ 19,25 say PADC(" Sair do (R) MMStec EPMJ-98 ?",30) 
           @ 21,35 PROMPT " Sim "
           @ 21,41 PROMPT " Nao "
           MENU TO RESPOSTA
           READ
           IF RESPOSTA = 1
              SET COLOR TO W/N
              CLS
              SAIDA = TIME()
              ACAO   +=+time()+"-Saida normal "+CHR(13)+CHR(10)
              DES     = CHR(13)+CHR(10)
              DES    +="MAQUINA  : " + MAQUINA+CHR(13)+CHR(10)
              DES    +="PROGRAMA : " + PROGRAMA+CHR(13)+CHR(10)
              DES    +="USUARIO  : " + USUARIO+CHR(13)+CHR(10)
              DES    +="ENTRADA  : " + DATAENTRA+"-"+ENTRADA+CHR(13)+CHR(10)
              DES    +="TERMINO  : " + TIME()+CHR(13)+CHR(10)
              DES    +="TOTAL    : " + ELAPTIME(ENTRADA,TIME())+CHR(13)+CHR(10)
              DES    +="HISTORICO: " + CHR(13)+CHR(10)+ACAO+CHR(13)+CHR(10)
              GRAVALOG(ENTRADA,SAIDA)
              ERASE EPMJ.LIG
              SAVE all like DES to EPMJ.DES
              ?REPL("Bye, bye..."+ALLTRIM(USUARIO),300)
              LOGOMARCA()
              RETURN(0)
            ELSE
                 SETCOLOR(CORATUAL)
                 RESTORE SCREEN FROM TELA
                 RETURN(1)
            ENDIF  
          ELSEIF TECLA = F12
                 TROCAUSUARIO()
                 RETURN(1)

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
                    @ 14,20 SAY "Entrada         :"+trim(dataentra+"-"+entrada)
                    @ 15,20 SAY "Rel¢gio         :"+trim(dtoc(date())+"-"+TIME())
                    @ 16,20 SAY "Cron“metro      :"
                    @ 16,37 say SubStr(ELAPTIME(ENTRADA,time()),1,2)+"ø";
                               +SubStr(ELAPTIME(ENTRADA,time()),4,2)+"'";
                               +SubStr(ELAPTIME(ENTRADA,time()),7,2)+'"'  color "RG+ / b"
                 enddo
                 PACK
                 SETCOLOR(CORATUAL)
                 RESTORE SCREEN FROM TELA
                 RETURN(1)

          ELSEIF TECLA = 80 .OR. TECLA = 112
                 SAVE SCREEN TO TELA
                 CONSULTA()
                 RESTORE SCREEN FROM TELA
                 RETURN(1)
          
          ELSEIF TECLA = 69 .OR. TECLA = 101 
                 save screen to tela
                 set cursor on
                 campo:=fieldName(INDICE)
                 vReg :=Recno()
                 tone(1000,1)
                 IF At('*',NOME)<>0 .AND. M->SENHA<>"MASTER" 
                    ALERT("SINTO MUITO;; ESTE REGISTRO NAO PODE ;SER ALTERADO POR;"+ALLTRIM(USUARIO),,"R/RG*")
                 ELSE
                 IF type("&CAMPO")="M"
                   MEMOTELA=SAVESCREEN(8,9,21,71)
                   set color to bg+/B*
                   CAIXA(08,09,20,71,"N /B+*","W+/B+*")
                   CAIXA(10,10,18,70,"W+/B+*","N /B+*")
                   @ 09,11 say padC("Editando Observacoes"   ,59)      color "w+/b*"
                   @ 19,11 say padC("* Crtl-W sai gravando * ",59)     color "w+/b*"
                   REPLACE &CAMPO WITH MEMOEDIT(&CAMPO,11,12,17,69,.T.)
                   RESTSCREEN(8,9,21,71,MEMOTELA)
                   set cursor off
                   acao=acao+time()+"-Edita memo "+campo+CHR(13)+CHR(10)
                 ELSE
                   @ ROW(),COL() GET &CAMPO COLOR "W+/R"
                   acao=acao+time()+"-Edita "+campo+CHR(13)+CHR(10)
                   READ
                   clear gets
                 ENDIF
                  *REPLACE OBS WITH OBS+CHR(13)+CHR(10)+"Alterado por "+alltrim(usuario)+" em "+dtoc(date())+" as "+time()
                 ENDIF                                           
                 go vReg
                 return(1)

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
                 acao=acao+time()+"-Relatorio "+CHR(13)+CHR(10)
                 RETURN (1)

          ELSEIF TECLA = 076 .OR. TECLA = 108
                 SAVE SCREEN TO TELA
                 APPEND BLANK
                 M->vCODIGO=STRzero(LASTREC(),6)
                 M->vNOME  =SPACE(15)
                 M->vSOBRENOME=SPACE(25)
                 M->vDDD   =SPACE(3)
                 M->vFONE  =SPACE(15)
                 M->vREFE  =SPACE(35) 
                 M->vOBS   =PADC("RESPONSAVEL CADASTRO: "+ALLTRIM(UPPER(USUARIO)),35)
                 caixa(07,18,22,57,"N /B*","w+/B*")
                 @ 08,20 SAY PADC("LAN€ANDO REGISTROS",35) COLOR "W+/R"
                 @ 10,20 SAY "PRIMEIRO NOME"         color "Bg+/b*"
                 @ 12,20 SAY "Sobrenome completo"    color "Bg+/b*"
                 @ 14,20 say "DDD"                   color "Bg+/b*"
                 @ 14,24 say "Telefone"              color "Bg+/b*"
                 @ 16,20 say "Contato/Referencia/Trabalho/etc."   color "Bg+/b*"

                 ALERT("ATEN€ÇO;; O PARTICIPANTE DEVE ENTREGAR UMA FOTO 3X4.",,"R/RG*")
                 @ 11,20 get M->vNOME picture "@!"  VALID !empty(M->vNOME) color "W+/b,N/bG*"
                 @ 13,20 get M->vSOBRENOME picture "@!"  VALID !empty(M->vSOBRENOME) color "W+/b,N/bG*"
                 @ 15,20 get M->vDDD  picture "@!"  color "W+/b,N/bG*"
                 @ 15,24 get M->vFONE picture "@!"  color "W+/b,N/bG*"
                 @ 17,20 get M->vREFE picture "@!"                           color "W+/b,N/bG*"
                 @ 19,20 SAY M->vOBS picture  "@!"                           color "W+/b,N/bG*"
                 @ 20,20 say padc("Existe " + alltrim(Str(LastRec() - 1,4)) + " registros no arquivo", 35) color "b/b*"
                 @ 21,20 say padc(">> "+trim(dbf())+" <<", 35) color "b/b*"
                 SET CURSOR ON
                 READ
                 REPLACE CODIGO WITH M->vCODIGO
                 REPLACE NOME WITH M->vNOME
                 REPLACE SOBRENOME WITH M->vSOBRENOME
                 REPLACE DDD WITH M->vDDD
                 REPLACE FONE WITH M->vFONE
                 REPLACE REFERENCIA WITH M->vREFE
                 REPLACE OBS WITH M->vOBS
                 IF LASTKEY()=27
                    DELETE
                    PACK
                    ALERT("ATEN€ÇO;; CANCELADO INCLUSAO DE REGISTRO.",,"R/RG*")
                 ELSE
                 ***************
                 RESPOSTA := 1
                 vNOME    := NOME
                 SET COLOR TO W+/G,W+*/R,B+/N,B+/N
                 CAIXA(18,24,22,56,"N/G","G+/G")
                 @ 19,25 say PADC("O PARTICIPANTE ENTREGOU A FOTO 3x4 ?",30) 
                 @ 21,35 PROMPT " Sim "
                 @ 21,40 PROMPT " Nao "
                 MENU TO RESPOSTA
                 READ
                 IF RESPOSTA <> 1
                    ACAO=ACAO+TIME()+"-Apagou registros "+&campo+CHR(13)+CHR(10)
                    DELETE
                    PACK
                    ALERT("SINTO MUITO;; ESTE REGISTRO NAO PODE ;SER CADASTRADO",,"R/RG*")
                    INDEX on NOME+SOBRENOME to idEPMJ.ntx
                 ELSE
                    ALERT("ATEN€ÇO;; COLOQUE O NOME E O CODIGO; DO PARTICIPANTE NO;VERSO DA FOTO 3X4.;;<CODIGO:"+M->vCODIGO+">;<NOME:"+alltrim(M->vNOME)+" "+alltrim(M->vSOBRENOME)+">",,"R/RG*")
                 ENDIF
                 ENDIF
                 ***************
                 RESTORE SCREEN FROM TELA
                 SET COLOR TO W/B,N /BG*,B+/N,B+/N
                 SET SOFTSEEK On
                 SEEK trim(vNOME)
                 SET SOFTSEEK OFF
                 RETURN(1)

                 RESTORE SCREEN FROM TELA
                 SET CURSOR OFF
                 acao=acao+time()+"-Inclusao de registro "+vnome+CHR(13)+CHR(10)
                 SET COLOR TO 
                 RETURN(2)

          ELSEIF TECLA = 65 .OR. TECLA = 97
                 SAVE SCREEN TO TELA
                 RESPOSTA := 1
                 vNOME    := NOME
                 IF At('*',NOME)<>0
                    ALERT("SINTO MUITO;; ESTE REGISTRO NAO PODE ;SER DELETADO",,"R/RG*")
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
                       ACAO=ACAO+TIME()+"-Apagou registros "+&campo+CHR(13)+CHR(10)
                       DELETE
                       PACK
                       INDEX on NOME+SOBRENOME to indfone.ntx 
                       alert(ALLTRIM(USUARIO)+';VOCE ELIMINOU O REGISTRO;;"'+ALLTRIM(NOMEATUAL)+'"',,"W+/R+*")  
                    ENDIF
                 ENDIF
                 RESTORE SCREEN FROM TELA
                 SET COLOR TO W/B,N /BG*,B+/N,B+/N
                 SET SOFTSEEK On
                 SEEK trim(vNOME)
                 SET SOFTSEEK OFF
                 RETURN(1)

          ELSEIF TECLA = DEL
                 ALERT("Para EXCLUIR tecle; [A] ;de Apagar")
                 RETURN(1)

          ELSEIF TECLA = ENTER
                 CAMPO=FIELDNAME(INDICE)
                 IF TYPE("&CAMPO")="M"
                    MEMOTELA=SAVESCREEN(8,9,19,71)
                    set cursor off
                    set color to BG+/B*
                    CAIXA(08,09,18,71,"N /B+*","W+/B+*")
                    CAIXA(10,10,17,70,"W+/B+*","N /B+*")
                    @ 09,11 SAY PADC("Visualizando Observacoes",58)      color "w+/b*"
                    REPLACE &CAMPO WITH MEMOEDIT(&CAMPO,11,11,16,69,.f.)
                    RESTSCREEN(8,9,19,71,MEMOTELA)
                 ELSE
                    ALERT("PARA EDITAR ESCOLHA [E] DITAR",,"n+/w*")
                 ENDIF
                 RETURN 1
          ELSE
                 @ 23,03 SAY SPACE(75)        COLOR "W/R"
                    @ 23,05 SAY "[P] esquisar" COLOR ("W/R")
                 @ 23,06 SAY "P" COLOR ("W+/R")
                   @ 23,20 say "[E] ditar"    COLOR "W/R"
                 @ 23,21 SAY "E" COLOR ("W+/R")
                   @ 23,35 say "[A] pagar"    COLOR "W/R"
                 @ 23,36 SAY "A" COLOR ("W+/R")
                   @ 23,50 say "[L] lancar"   COLOR "W/R"
                 @ 23,51 SAY "L" COLOR ("W+/R")
                   @ 23,65 say "[I] mprimir"  COLOR "W/R"
                 @ 23,66 say "I"COLOR ("W+/R")
                 RETURN 1        
          ENDIF
      OTHERWISE
          setcolor("W/B,N /BG*,B+/N,W+/B*")
          @ 04,60 say padL(alltrim( str( LastRec() ) ) + " Registros",15) 
          @ 23,03 say padc(data(),75) color "bg+/b"
          SET CURSOR OFF
          tone(10000,0.5)
          RETURN(1)
      ENDCASE

FUNCTION CONSULTA
     set cursor on
     nRec  := 0
     lDone := .F.
     psq   := space(54)     
     do while .T.
          @ 23,05 say PADR("Pesquisar :",70)        COLOR "W+/B"
          @ 23,21 get PSQ PICT "@!"                 COLOR ",W+/BG"
          set cursor on
          read
          set cursor off
          if lastKey()=27
             exit
          endif
          nRec := Recno()
          seek trim(PSQ)
          if !found()
             acao=acao+time()+"-Pesquisou registro '"+trim(psq)+"'."+CHR(13)+CHR(10);
             +SPACE(9)+"Nao localizou!"+CHR(13)+CHR(10)
             mensagem("Pesquisa mal sucedida",3,"W+/B")                      
             mensagem("Tecle <ESC> para continuar",,"W+/B")
             goto nRec
             loop
           else
             lDone := .T.
             mensagem("Pesquisa bem sucedida",0.01,"W+/B")
             acao=acao+time()+"-Pesquisou registro '"+trim(psq)+"'."+CHR(13)+CHR(10);
             +SPACE(9)+"Localizou '"+TRIM(EPMJ->(NOME))+" "+TRIM(EPMJ->(FONE))+"'"+CHR(13)+CHR(10)
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



PROCEDURE GRAVALOG(ENTRADA,SAIDA)
TEMPO   :=ELAPTIME(ENTRADA,SAIDA)
IF FILE("EPMJ.TXT")
   TAM=DIRECTORY("EPMJ.TXT","2")                                                                                                   
   IF TAM[1,2] > 60000                                                       
      ERASE EPMJ.TXT
      ALERT("O aquivo de parametros;"+TAM[1,1]+";foi renovado.;;"+REPL("Ä",20)+";Motivo;Tamanho excedido",,"W+/B")
      ACAO=ACAO+time()+"-Renovado "+TAM[1,1]+" por excesso de tamanho"+CHR(13)+CHR(10)
      TEXTO=""
   ELSE
      TEXTO=MEMOREAD("EPMJ.TXT")
   ENDIF   
ELSE
   TEXTO=""
ENDIF
TEXTO+="MAQUINA  : " + MAQUINA+CHR(13)+CHR(10)
TEXTO+="PROGRAMA : " + PROGRAMA+CHR(13)+CHR(10)
TEXTO+="VERSAO   : " + DTOC(VERSAO[1,3])+CHR(13)+CHR(10)
TEXTO+="USUARIO  : " + USUARIO+CHR(13)+CHR(10)
TEXTO+="ENTRADA  : " + DATAENTRA+"-"+ENTRADA+CHR(13)+CHR(10)
TEXTO+="TERMINO  : " + DTOC(DATE())+"-"+SAIDA+CHR(13)+CHR(10)
TEXTO+="USO TOTAL: " + TEMPO+CHR(13)+CHR(10)
TEXTO+="*** HISTORICO ***" + CHR(13)+CHR(10)+ACAO+CHR(13)+CHR(10)
TEXTO+=REPLICATE("=",50)+CHR(13)+CHR(10)
MEMOWRIT("EPMJ.TXT",TEXTO)

FUNCTION VALIDADE(GET)
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
      index on nome to indsenha.ntx
   else
      use senha
      index on nome to indsenha.ntx
   endif
   vUSUARIO := SPACE(57)
   vSENHA   := ctod("  /  /  ")
   vTENTA   := 0
   do while .t.
      if vTenta >= 3
         cls
         Alert("Suas chances terminaram",,"W+/R+")
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
         Alert("SINTO MUITO.;Senha incorreta",,"W+/RG+")
         vtenta=vtenta+1
         vsenha=ctod("  /  /  ")
         loop
      endif
      set cursor off
      seek trim(vUSUARIO)
      if eof()
         vtenta=vtenta+1
         ALert("TENTATIVA:"+STR(VTENTA,2)+";Usuario n„o encontrado.;Tente novamente")
         loop
      else
         alert(trim(nome),,"W+/G+")
      endif
      exit
   enddo
usuario=vusuario
RETURN USUARIO

FUNCTION RELATORIO
   USE EPMJ
   INDEX on NOME+SOBRENOME to idEPMJ.ntx 
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
   ACAO=ACAO+TIME()+"-Impressao de"+trim(filtro1)+" ate "+trim(filtro2)+CHR(13)+CHR(10)
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
         @ linha+2,  00 say padC("II ENCONTRO DE PEDREIROS E MESTRES DE OBRAS DE JEQUIE",80)
         @ linha+3,  00 say padC('Impress„o de "'+ Trim(filtro1) +'" a "' + Trim(filtro2)+'"',80)
         @ linha+5,  0 say REPL("*",80)
         @ linha+6,  0 say "Nome completo"
         @ linha+6, 43 say "Telefone para contato"
         @ linha+7,  0 say REPL("*",137)
         linha = 8
      endif
      @ linha, 00 say ALLTRIM(NOME)+" "+SOBRENOME
      @ linha, 43 say "("+DDD+")"+FONE
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

function caixa( nL1, nC1, nL2, nC2, COR1, COR2 )

if pcount() < 6
   COR1 = "N /B"
   COR2 = "B+/B"
endif
   
coratual=setcolor()
setcolor(COR2)

IF nL2 < nL1+4
   nL2 = nL1+4
endif

@ nL1, nC1 clear to nL2, nC2

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

 set cursor off
 M->DDD=IIF(EMPTY(DDD),"073",DDD)
 Replace CODIGO with STRZERO(RECNO(),6)
 Replace DDD with M->DDD

 grafico   := int ( ( RecNo() / LastRec() ) *  60 )
 percentual:= int ( ( RecNo() / LastRec() ) * 100 )
 @ L-1  ,10 + grafico say "Û"+repl(" ",60-grafico)                 color "rg+/n"
 @ L+1,10 say padc(Str(percentual,3 )+"%"+" conclu¡do",60)         color "rg+/b"

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
   ALERT("ATEN€ÇO;;TROCA DE SENHA;PROCESSADA",,"RG+/N")
RETURN.T.
