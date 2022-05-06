   ***********************************************************************
   *
   *
   *
   *
   * Autor: Marcos Morais de Sousa
   ***********************************************************************
   *
   * Compilar com .: clipper DEV
   * Linkar com    : rtlink fi DEV lib mmstec (clipper5.1-5.2)
   * Linkar com    : EXOSPACE fi DEV lib mmstec (clipper5.3) ou
   * Linkar com    : BLINKER  fi DEV lib mmstec (clipper5.3)
   *
   * MMStec ‚ uma biblioteca de fun‡äes desenvolvida por Marcos Morais.
   *
   ***********************************************************************
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
   SET SCORE OFF

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
   SISTEMA  := "(R) MMStec Devedores - vers„o "+dtoc(VERSAO[1,3]) 
   EMPRESA  := "Barreto Material de Constru‡Æo"
   vMoraMes := 5
   vMoraDia := vMoraMes/30
   vMora    := vMoraDia/100

   DO WHILE .T.
       MMSLET04(02,10,dbData())
       @ 06,03 SAY PADC(ANO2000,77)                          COLOR "Wa+"
       @ 10,10,16,71 box("        Û")                        color "b/n"
       caixa( 10,10, 16,71)
       @ 12,12 SAY "Usuario entre com seu nome" color "W+/B*+"
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

   USUARIO  := IIF(EMPTY(USUARIO),"USUARIO ESTRANHO",TRIM(USUARIO))

   SET CURSOR ON

   M->CODIGO:=0
   IF FILE("DEV.LIG")
      RESTORE FROM DEV.LIG ADDITIVE
      ALERT("SISTEMA EM USO ;OU; DESLIGADO INCORRETAMENTE;;"+REPL("Ä",20)+";Maquina "+LOGMAQ+";Programa "+LogPRO+";Usu rio "+LogUSO+";; * Entrada *;"+LogINI,,"W+/B")
      QUIT

      ELSE
      LOGPRO := PROGRAMA
      LOGMAQ := MAQUINA
      LOGUSO := USUARIO
      LOGINI := DATAENTRA+"-"+ENTRADA

      IF FILE("DEV.DES")
         ERASE DEV.DES
         SAVE all like LOG* to dev.LIG
         ELSE
         SAVE all like LOG* to dev.LIG
      ENDIF

   ENDIF

   CLS
   IF !FILE("DEV.DBF")
      FCAMPO:={}
      AADD( FCAMPO,{"NOME"   ,"C", 30,  0} )   
      AADD( FCAMPO,{"ENDE"   ,"C", 30,  0} )   
      AADD( FCAMPO,{"NUMERO" ,"C", 12,  0} )   
      AADD( FCAMPO,{"VENCI"  ,"D", 08,  0} )   
      AADD( FCAMPO,{"VALOR"  ,"N", 10,  2} )   
      AADD( FCAMPO,{"DIVIDA" ,"N", 10,  2} )   
      DBCREATE("DEV",FCAMPO)
      USE DEV
      INDEX ON NOME+DTOC(VENCI) TO INDDEV.NTX
   ELSE
      USE DEV
      INDEX ON NOME+DTOC(VENCI) TO INDDEV.NTX
   ENDIF

   PRIVATE Titulo[6] 
           Titulo[1] = "CLIENTE"
           Titulo[2] = "ENDERECO"
           Titulo[3] = "NUMERO"
           Titulo[4] = "VENCIMENTO"
           Titulo[5] = PADL("VALOR",10)
           Titulo[6] = PADL("DIVIDA",10)
   
   PRIVATE MASCARA[6]  
           MASCARA[1] = "@!"
           MASCARA[2] = "@!"
           MASCARA[3] = "@!"
           MASCARA[4] = "@!"
           MASCARA[5] = "@!"
           MASCARA[5] = "@!"

   DECLARE REGISTRO[7]           
           REGISTRO[1] = 'NOME'
           REGISTRO[2] = 'ENDE'
           REGISTRO[3] = 'NUMERO'
           REGISTRO[4] = 'VENCI'
           REGISTRO[5] = 'VALOR'
           REGISTRO[6] = 'DIVIDA'

   SETBLINK(.F.)
   SET COLOR TO W/B,N /BG*,B+/N,B+/N
   cls
   caixa(00,00,24,79,"N /B","b+/B")
   caixa(05,05,21,75,"b+/B","N /B")
   @ 02,05 SAY SISTEMA                           color "bg+ /b"
   @ 03,05 SAY EMPRESA                           color "bg  /b"
   @ 04,05 SAY USUARIO                           color "r+  /b"
   ATUALIZA()
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
           ERASE dev.LIG
           SAVE all like DES to dev.DES
           LOGOMARCA()
           RETURN(0)

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
                   REPLACE Divida     WITH VALOR + ( (VALOR * vMORA) * ( DATE()-VENCI ) )
                   clear gets
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
                 NovoReg     =recno()
                 vNome       =space(30)
                 vEndereco   =space(30)
                 vDocumento  =space(12)
                 vVencimento =ctod("  /  /   ")
                 vValor      =0
                 vDivida     =0

                 CAIXA(06,17,20,67,"N /B*","w+/B*")

                    @ 07,20 say PADC("LAN€ANDO REGISTROS",45) COLOR "W+/R"
                    @ 09,20 say "Nome"                  color "Bg+/b*"
                    @ 11,20 say "Endereco"              color "Bg+/b*"
                    @ 13,20 say "Documento"             color "Bg+/b*"
                    @ 15,20 say "Vencimento"            color "Bg+/b*"
                    @ 17,20 say "Valor"                 color "Bg+/b*"
                    *@ 19,20 say "Divida"                color "Bg+/b*"
                    @ 19,20 say "Mora di ria de "+alltrim(str(vMoraDia))+"%" color "R/b*"

                    @ 09,32 get vNome      pict "@!"   color "W+/b,N/bG*"
                    @ 11,32 get vEndereco  pict "@!"   color "W+/b,N/bG*"
                    @ 13,32 get vDocumento             color "W+/b,N/bG*"
                    @ 15,32 get vVencimento            color "W+/b,N/bG*"
                    @ 17,32 get vValor ;
                               PICT "@ 9999999999.99" color "W+/b,N/bG*"
                    *@ 19,32 get vDivida;
                    *          PICT "@ 9999999999.99" color "W+/b,N/bG*"

                    SET CURSOR ON
                    READ

                    **********************************************************************
                    vDIVIDA = vVALOR + ( (vVALOR * vMORA) * ( DATE()-vVENCIMENTO ) )
                    ************************************************************************

                    REPLACE nome       WITH vNome
                    REPLACE Ende       WITH vEndereco   
                    REPLACE Numero     WITH vDocumento  
                    REPLACE Venci      WITH vVencimento 
                    REPLACE Valor      WITH vValor      
                    REPLACE Divida     WITH vDivida

                    IF LASTKEY()=27
                       go NovoReg
                       Delete
                       Pack
                    ENDIF


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
                    ALERT("SINTO MUITO;; ESTE REGISTRO NAO PODE ;SER DELETADO",,"N/RG*")
                    ELSE

                    SETCOLOR("W+/G,W+*/R,B+/N,B+/N")
                    CAIXA(18,24,22,56,"N/G","G+/G")
                    @ 19,25 say PADC(" Elimina registro corrente ?",30) 
                    @ 21,35 PROMPT " Sim "
                    @ 21,40 PROMPT " Nao "
                    MENU TO RESPOSTA
                    READ
                    IF RESPOSTA = 1
                       ACAO=ACAO+TIME()+"-Apagou registros "+&campo+CHR(13)+CHR(10)
                       DELETE
                       PACK
                       INDEX ON NOME+DTOC(VENCI) TO INDDEV.NTX
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

          ELSEIF TECLA = 116 .OR. TECLA = 84
                 SAVE SCREEN TO TELA
                 SET COLOR TO W/B,W+ /BG,B+/N,B+/N
                 TOTALIZA()
                 RESTORE SCREEN FROM TELA
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
          @ 22,05 say padC("Numero: "+Alltrim(numero)+" Valor: "+alltrim(str(valor))+" Divida: "+alltrim(str(divida)),70) color "w/b"
          @ 23,05 say padC(data(),70) color "bg+/b"
          set cursor off
          tone(10000,0.5)
          return (1)

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
             +SPACE(9)+"Localizou '"+TRIM(DEV->(NOME))+"'"+CHR(13)+CHR(10)
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
IF FILE("DEV.TXT")
   TAM=DIRECTORY("DEV.TXT","2")                                                                                                   
   IF TAM[1,2] > 60000                                                       
      ERASE DEV.TXT
      ALERT("O aquivo de parametros;"+TAM[1,1]+";foi renovado.;;"+REPL("Ä",20)+";Motivo;Tamanho excedido",,"W+/B")
      ACAO=ACAO+time()+"-Renovado "+TAM[1,1]+" por excesso de tamanho"+CHR(13)+CHR(10)
      TEXTO=""
   ELSE
      TEXTO=MEMOREAD("DEV.TXT")
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
MEMOWRIT("DEV.TXT",TEXTO)

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


FUNCTION RELATORIO

   USE DEV
   INDEX ON NOME+DTOC(VENCI) TO INDDEV.NTX

   FILTRO1 := space(35)
   FILTRO2 := space(35)

   CAIXA(07,22,17, 60)

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
   
   LINHA     := 0
   PAGINA    := 0
   REGISTRO  := 0
   TVALOR    := 0
   TDIVIDA   := 0

   do while (!EOF())

      @  linha+0,00 say ""

      if (linha == 0)

         Pagina++

         @ linha+1,  00 say padC(EMPRESA,160)
         @ linha+2,  00 say padC('Relat¢rio de Contas a Receber',160)
         @ linha+3,  00 say padC('ImpressÆo de "'+ Trim(filtro1) +'" a "' + Trim(filtro2)+'"',160)
         @ linha+4,  00 say Repl("Ä",160)
         @ linha+5,  00 say DBDATA(date())+" - " + TIME()
         @ linha+5, 100 say padL("P gina " + alltrim(str(PAGINA)),060)
         @ linha+6,  00 say "Nome"
         @ linha+6,  32 say "Endere‡o"
         @ linha+6,  63 say "N£mero"
         @ linha+6,  76 say "Vencimento"
         @ linha+6,  91 say padL("Valor",12)
         @ linha+6, 106 say padL("D¡vida",12)
         @ linha+7,  00 say Repl("Ä",160)

         linha = 8

      endif

      @ linha,  00 say NOME
      @ linha,  32 say iif(empty(ENDE),repl(".",30),ENDE)
      @ linha,  63 say NUMERO
      @ linha,  76 say VENCI
      @ linha,  91 say padL(Valor,12)
      @ linha, 106 say padL(Divida,12)

      REGISTRO++
      LINHA++
      TVALOR := TVALOR+VALOR
      TDIVIDA:= TDIVIDA+DIVIDA
      SKIP

      if (linha >= 50 .OR. EOF())
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
   @ LINHA+00,  00 SAY REPL(".",162)
   @ LINHA+01,  78 SAY "   TOTAL"
   @ LINHA+01,  90 SAY TRANSF(TVALOR,[@E 999,999,999.99])
   @ LINHA+01, 105 SAY TRANSF(TDIVIDA,[@E 999,999,999.99])
   
   ELSE
   @ LINHA+00,  00 SAY REPL(".",162)
   @ LINHA+01,  78 SAY "SUBTOTAL"
   @ LINHA+01,  90 SAY TRANSF(tVALOR,[@E 999,999,999.99])
   @ LINHA+01, 105 SAY TRANSF(tDIVIDA,[@E 999,999,999.99])
   
ENDIF       
IF PAR1=2
   @ LINHA+03,000 SAY ALLTRIM(STR(REGISTRO))+" REGISTROS IMPRESSOS."
   @ LINHA+05,000 SAY "* Valor da d¡vida cauculado at‚ a data:("+DTOC(DATE())+")."
   @ LINHA+06,000 SAY "* Ap¢s "+DTOC(DATE())+" acrescer di riamente "+alltrim(str(vMoraDia))+"% ao valor da d¡vida."
   @ LINHA+08,000 SAY AUTOR
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



FUNCTION ATUALIZA
********************
GO TOP
nREG=0
DO WHILE !eof()
   nREG++
   PERCENTUAL := int ( ( nREG / LastRec() ) * 100 )
   @ 23,20 SAY padr(nome,55)             color "rg+/n"
   @ 23,05 SAY padr(ALLTRIM(STR(PERCENTUAL,3))+"% conclu¡do",15)  color "rg+/b"
   REPLACE DIVIDA WITH VALOR + ( (VALOR * vMORA) * ( DATE()-VENCI ) )
   SKIP
ENDDO
GO TOP
*****************
RETURN.T.

                         
FUNCTION TOTALIZA
caixa(05,05,21,75,"b+/B","N /B")
GO TOP
nREG=0
nTOTAL=0
nDIVIDA=0
@ 06,10 SAY "* Ap¢s "+DTOC(DATE())+" acrescer di riamente "+alltrim(str(vMoraDia))+"%"
@ 07,10 SAY "  ao valor da d¡vida."
@ 09,10 SAY "* Valor total na base de dados"
@ 14,10 SAY "* D¡vida acumulada na base de dados" 
DO WHILE !eof()
   nREG++
   nTOTAL=nTOTAL+VALOR
   nDIVIDA=nDIVIDA+DIVIDA
   PERCENTUAL := int ( ( nREG / LastRec() ) * 100 )
   GRAFICO    := int ( ( nREG / LastRec() ) * 50  )
   @ 19,20 SAY repl("Û",grafico)  color "rg+/b"
   @ 19,10 SAY padr(ALLTRIM(STR(PERCENTUAL,3))+"% conclu¡do",15)  color "rg+/b"
   MMSLET06(10,10,ALLTRIM(TRANSF(nTOTAL,[@E 999,999,999.99])),1,"R+/B")
   MMSLET06(15,10,ALLTRIM(TRANSF(nDIVIDA,[@E 999,999,999.99])),1,"R+/B")
   @ 22,05 SAY SPACE(70)
   SKIP
ENDDO
INKEY(0)
GO TOP
*****************
RETURN.T.
                  
