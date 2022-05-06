   SET COLOR TO W+/ ,W+/B
   SET DATE FORMAT TO "dd,mm,yyyy"
   SET DATE BRIT
   SET EPOCH TO 1900     
   SET EXCLUSIV ON
   SET DELETE ON
   SET BELL ON
   SET TALK OFF
   SET SOFTSEEK OFF
   SET SCORE OFF

   ANO2000 := ALLTRIM(STR(CTOD("01/01/2000")-DATE()))
   ANO2000 := '"FALTAM '+ANO2000+' DIAS PARA O ANO 2000"' 
   USUARIO := SPACE(58)
   DO WHILE .T.
       @ 06,(80-LEN(DBDATA()))/2 SAY DBDATA()    COLOR "W+"
       @ 08,(80-LEN(ANO2000))/2 SAY ANO2000      COLOR "W*+"
       @ 10,10,16,71 box("        Û")                        color "b/n"
       @ 10,10 to 16,71                                      color "bg+/b"
       @ 12,12 say padc("Usuario entre com seu nome.",58)    color "w+/b"
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
   
   PROGRAMA:= PROCNAME()+".EXE"
   MAQUINA := ALLTRIM(NETNAME())
   USUARIO := IIF(EMPTY(USUARIO),"Usuario",TRIM(USUARIO))
   ENTRADA := TIME()
   ACAO    := time()+"-Entrada normal"+CHR(13)+CHR(10)
   FILTRO1 := space(35)
   FILTRO2 := space(35)
   AUTOR   :="(C) Marcos Morais de Sousa - 1995/"+TRAN(YEAR(DATE()),"@E 9999")
   M->CODIGO:=0                                   
   IF FILE("DOC.LIG")
       RESTORE FROM DOC.LIG ADDITIVE
       ALERT("Sistema em uso ;ou; desligado incorretamente;em;"+REPL("Ä",20)+";Maquina "+LMAQUINA+";Programa "+LPROGRAMA+";Usu rio "+LUSUARIO+";Entrada "+Entrada,,"W+/B")
       QUIT
   ELSE
      Lprograma = PROGRAMA
      Lmaquina  = MAQUINA
      Lusuario  = USUARIO
      Ldata     = DTOC(DATE())
      Linicio   = ENTRADA
      IF FILE("DOC.DES")
         ERASE DOC.DES
         SAVE all like L* to DOC.LIG
      ELSE
         SAVE all like L* to DOC.LIG
      ENDIF
   ENDIF
   CLS
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
   
   IF !FILE("DOC.DBF")
      FCAMPO:={}
      AADD( FCAMPO,{"NOME"   ,"C", 35,  0} )   &&*1  X
      AADD( FCAMPO,{"ENDE"   ,"C", 35,  0} )   &&*2
      AADD( FCAMPO,{"SNUMERO","C", 11,  0} )   &&*3  X
      AADD( FCAMPO,{"NNUMERO","C", 11,  0} )   &&*4  X
      AADD( FCAMPO,{"VENCI"  ,"D", 08,  0} )   &&*5  X
      AADD( FCAMPO,{"VALOR"  ,"N", 10,  2} )   &&*6  X
      AADD( FCAMPO,{"TXPERM" ,"N", 06,  2} )   &&*7
      AADD( FCAMPO,{"CUSTO"  ,"N", 10,  2} )   &&*8
      DBCREATE("DOC",FCAMPO)
      USE DOC
      INDEX ON NOME TO DOC.NTX
   ELSE
      USE DOC
      INDEX ON NOME TO DOC.NTX
   ENDIF

   PRIVATE Titulo[8] 
           Titulo[1] = "Nome do Cliente"
           Titulo[2] = "Endereco"
           Titulo[3] = "S.Numero"
           Titulo[4] = "N.Numero"
           Titulo[5] = "Vencimento"
           Titulo[6] = "Valor Titulo"
           Titulo[7] = "Perm."
           Titulo[8] = "Custo Prot."
   
   PRIVATE MASCARA[8]  
           MASCARA[1] = "@!"
           MASCARA[2] = "@!"
           MASCARA[3] = "@!"
           MASCARA[4] = "@!"
           MASCARA[5] = "@!"
           MASCARA[6] = "@!"
           MASCARA[7] = "@!"
           MASCARA[8] = "@!"

   DECLARE REGISTRO[8]           
           REGISTRO[1] = 'NOME'
           REGISTRO[2] = 'ENDE'
           REGISTRO[3] = 'sNUMERO'
           REGISTRO[4] = 'nNUMERO'
           REGISTRO[5] = 'VENCI'
           REGISTRO[6] = 'VALOR'
           REGISTRO[7] = 'str(TXPERM,5,2)'
           REGISTRO[8] = 'CUSTO'

   SET COLOR TO W/B,N/W,B+/B,B+/B,B+/B,B+/B
   CLEAR
   @ 01,01 SAY "MMS DOCs - "+TRIM(USUARIO)                color "BG+/B"
   @ 02,01 SAY REPl("Ä",78)                               color "BG+/B"
   @ 04,06 SAY "BARRETO MATERIAL DE CONSTRUCAO"           color "W/B"
   @ 21,01 SAY REPL("Ä",78)                               color "BG+/B"
   GO TOP
   DBEDIT(06,01,20,78,REGISTRO,"EDITA",MASCARA,TITULO,"   ","  ","   ",.T.)

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
           DES    +="DATA     : " + DTOC(DATE())+CHR(13)+CHR(10)
           DES    +="INICIO   : " + ENTRADA+CHR(13)+CHR(10)
           DES    +="TERMINO  : " + TIME()+CHR(13)+CHR(10)
           DES    +="TOTAL    : " + ELAPTIME(ENTRADA,TIME())+CHR(13)+CHR(10)
           DES    +="HISTORICO: " + CHR(13)+CHR(10)+ACAO+CHR(13)+CHR(10)
           GRAVALOG(ENTRADA,SAIDA)
           ERASE DOC.LIG
           SAVE all like DES to DOC.DES
           *ARQ=MEMOREAD("DOC.DES")
           *MEMOEDIT(ARQ,02,02,23,78,.F.)
           LOGOMARCA()
           RETURN(0)

          ELSEIF TECLA = F1
                 SAVE SCREEN TO TELA
                 SET COLOR TO W+/N
                 @ 08,17 clear to 18,60
                 @ 08,17 to 18,60 double color "bg+"
                 do while .t.
                    if lastkey()=27
                       exit
                    endif
                    @ 09,20 SAY "Programa        :"+trim(programa)    
                    @ 10,20 SAY "Maquina         :"+trim(maquina)    
                    @ 11,20 SAY "Usuario         :"+trim(usuario)   
                    @ 12,20 SAY "Data da entrada :"+trim(dtoc(date()))
                    @ 13,20 SAY "Hora da entrada :"+trim(entrada)
                    @ 14,20 SAY "Horario atual   :"+trim(time())
                    @ 15,20 SAY "Tempo em uso    :"+ELAPTIME(ENTRADA,time())
                    @ 17,20 SAY "(C) Marcos Morais de Sousa - 1995/"+TRAN(YEAR(DATE()),"@E 9999") color "bg+"
                    inkey(0.05)
                 enddo
                 SET COLOR TO W/B,N/W,B+/B,B+/B,B+/B,B+/B
                 PACK
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
                 set color to W+/n
                 CAMPO=FIELDNAME(INDICE)
                 IF type("&CAMPO")="M"
                   MEMOTELA=SAVESCREEN(8,9,21,71)
                   @ 08,09 clear to 19,71 
                   @ 08,09       to 19,71 double
                   @ 09,11 say padC("Observacoes - Ctrl+W Grava",58)
                   @ 10,11 say repl("Ä",58)
                   REPLACE &CAMPO WITH MEMOEDIT(&CAMPO,12,11,18,70,.T.)
                   RESTSCREEN(8,9,19,71,MEMOTELA)
                   set cursor off
                   acao=acao+time()+"-Edita memo "+campo+CHR(13)+CHR(10)
                 ELSE
                   @ ROW(),COL() GET &CAMPO PICT "@!" COLOR "W+/R"
                   READ
                   acao=acao+time()+"-Edita "+campo+CHR(13)+CHR(10)
                   clear gets
                   set order to indexord()
                   goto recno()
                 ENDIF
                 set cursor off
                 set color to
                 keyboard CHR(4)
                 return(1)
                 restore screen from tela

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
                 acao=acao+time()+"-Relatorio" +CHR(13)+CHR(10)
                 RETURN (1)

          ELSEIF TECLA = 076 .OR. TECLA = 108
                 SAVE SCREEN TO TELA
                 APPEND BLANK
                 SET COLOR TO W/N,W+/B
                 @ 02,17 clear to 23,57
                 @ 02,17       to 23,57 DOUBLE  color ("BG+/N")
                 
                 @ 03,20 SAY PADC("LANCANDO REGISTROS",35) COLOR "W+*/BG"
                 @ 05,20 say "Nome" 
                 @ 07,20 say "Endereco"    
                 @ 09,20 say "Seu Numero" 
                 @ 11,20 say "Nosso Numero" 
                 @ 13,20 say "Vencimento"   
                 @ 15,20 say "Valor do titulo"
                 @ 17,20 say "Valor de mora (ao dia)"  
                 @ 19,20 say "Custo do protesto" 

                 @ 06,20 get NOME  pict "@!"
                 @ 08,20 get ENDE  pict "@!"  
                 @ 10,20 get SNUMERO pict "@99999999999"
                 @ 12,20 get NNUMERO pict "@99999999999"
                 @ 14,20 get VENCI pict "@!"    
                 @ 16,20 get VALOR  pict "@E 9999999999.99" 
                 @ 18,20 get TXPERM pict "@!"    
                 @ 20,20 get CUSTO  pict "@E 9999999999.99" 
                 SET CURSOR ON
                 READ
                 IF LASTKEY()=27
                    DELETE
                    PACK
                 ENDIF
                 RESTORE SCREEN FROM TELA
                 SET CURSOR OFF
                 acao=acao+time()+"-Inclusao de registro "+nome+CHR(13)+CHR(10)
                 SET COLOR TO 
                 RETURN(2)

          ELSEIF TECLA = 65 .OR. TECLA = 97
                 SAVE SCREEN TO TELA
                 RESPOSTA =1
                 set color to w+/g,W+*/r
                 @ 18,24 clear to 22,56
                 @ 18,24       to 22,56 double 
                 @ 19,25 say PADC(" Elimina registro corrente ?",30) 
                 @ 21,35 PROMPT " Sim "
                 @ 21,40 PROMPT " Nao "
                 MENU TO RESPOSTA
                 READ
                 SET COLOR TO B+/N,N/W
                 IF RESPOSTA = 1
                    acao=acao+time()+"-Apagou registros "+&campo+CHR(13)+CHR(10)
                    DELETE
                    PACK
                    RESTORE SCREEN FROM TELA
                    INDEX ON NOME TO DOC.NTX
                    GO TOP
                 ELSE
                    RESTORE SCREEN FROM TELA
                 ENDIF
          ELSEIF TECLA = DEL
                 ALERT("Para EXCLUIR tecle; [A] de Apagar")
                 RETURN 1

          ELSEIF TECLA = ENTER
                 * Formula dos calculos
                 * j = c.t.i/100
                 * i = J/(c.t/100)
                 c  = valor
                 t  = Date()-VENCI
                 jT = txperm*t
                 i  = jT/(c*t/100)
                 j  = c*t*(i/100)
                 Z  = c+custo+Jt
                 ******************* formulas ***
                 vATRAZ = (DATE() - VENCI)
                 vJUROS = (txperm * vATRAZ)
                 vTOTAL = (valor + custo + vJUROS)
                 *********************************
                 SAVE SCREEN TO TELA
                 SET COLOR TO W/N,W+/N
                 @ 01,17 clear to 23,57
                 @ 01,17       to 23,57 DOUBLE  color ("BG+/N")
                 @ 02,20 SAY PADC("REGISTRO "+ALLTRIM(SNUMERO),35) color ("W+/BG")
                 @ 04,20 say "Nome"
                 @ 06,20 say "Endereco"    
                 @ 05,20 say NOME COLOR "w+"
                 @ 07,20 say ENDE COLOR "w+"
                 @ 08,20 say padR(repl("Ä",15),35)  COLOR "Bg"
                 @ 09,20 say "Seu Numero............"+SNUMERO
                 @ 10,20 say "Nosso Numero.........."+NNUMERO 
                 @ 11,20 say "Vencimento............"+DtoC(VENCI)     
                 @ 12,20 say padR(repl("Ä",15),35)  COLOR "Bg"
                 @ 13,20 say "Dias em atrazo........"+str(vATRAZ,10,2)+"+"
                 @ 14,20 say "Juros de mora ao dia.."+STR(TXPERM,10,2)+"x"

                 @ 15,20 say "Total da mora........."
                 @ 16,20 say "Valor do titulo......."
                 @ 17,20 say "Custo do Protesto....."
                 @ 18,20 say REPL("Ä",35)            COLOR "Bg"
                 @ 19,20 say "Total hoje ..........."

                 @ 15,42 say STR(VJUROS,10,2)+"=+"   COLOR "G"
                 @ 16,42 say STR(valor, 10,2)+"+"    COLOR "G"
                 @ 17,42 say STR(custo, 10,2)+"+"    COLOR "G"
                 
                 @ 19,42 say STR(vTOTAL,10,2)+"="    color "G+*"
                 @ 21,20 say PADC(DBDATA(date()),35) color "W+"

                 @ 12,60 clear to 15,78
                 @ 12,60       to 15,78 color "bg+"
                 @ 13,61 say "Mora dia "+str(i,06,2)+"%"    color "bg"
                 @ 14,61 say "Mora mes "+str(i*30,06,2)+"%" color "bg"
                 inkey(0)
                 RESTORE SCREEN FROM TELA
                 RETURN 1

          ELSE
                 @ 22,02 SAY SPACE(76)        COLOR "W/R"
                 @ 22,05 SAY "[P] esquisar" COLOR ("W/R")
                 @ 22,06 SAY "P" COLOR ("W+/R")
                   @ 22,20 say "[E] ditar"    COLOR "W/R"
                 @ 22,21 SAY "E" COLOR ("W+/R")
                   @ 22,35 say "[A] pagar"    COLOR "W/R"
                 @ 22,36 SAY "A" COLOR ("W+/R")
                   @ 22,50 say "[L] lancar"   COLOR "W/R"
                 @ 22,51 SAY "L" COLOR ("W+/R")
                   @ 22,65 say "[I] mprimir"  COLOR "W/R"
                 @ 22,66 say "I"COLOR ("W+/R")
                 @ 23,01 SAY REPL("Ä",78) color "BG+/B"
                 RETURN 1        
          ENDIF
      OTHERWISE
          @ 22,02 say space(76) color "BG+/B"
          data("C",23,01,78,"BG+/B")
          SET CURSOR OFF
          SET COLOR TO W/B,N/W,B+/B,B+/B,B+/B,B+/B
          RETURN(1)
      ENDCASE

FUNCTION CONSULTA   
     GO TOP
     SET CURSOR ON
     DO WHILE .T.
          PSQ=SPACE(58)
          @ 23,01 say space(78)            COLOR "B/B"
          @ 22,01 say " NOME A PESQUISAR:" COLOR "W+/B"
          @ 22,20 get PSQ PICT "@!"        COLOR ",W+/BG"
          SET CURSOR ON
          READ
          SET CURSOR OFF
          IF LASTKEY()=27
             EXIT
          ENDIF
          SEEK TRIM(PSQ)
          IF EOF()
             acao=acao+time()+"-Pesquisou registro '"+trim(psq)+"'."+CHR(13)+CHR(10);
             +SPACE(9)+"Nao localizou!"+CHR(13)+CHR(10)
             MENSAGEM("Dados n„o encontrados",3,"W+/B")                      
             MENSAGEM("Tecle <ESC> para continuar",,"W+/B")
             LOOP
          ELSE
             acao=acao+time()+"-Pesquisou registro '"+trim(psq)+"'."+CHR(13)+CHR(10);
             +SPACE(9)+"Localizou '"+TRIM(DOC->(NOME))+" - "+TRIM(DOC->(SNUMERO))+","+CHR(13)+CHR(10)
          ENDIF
          EXIT
     ENDDO
SET DELETED ON
RETURN.T.

PROCEDURE GRAVALOG(ENTRADA,SAIDA)
TEMPO   :=ELAPTIME(ENTRADA,SAIDA)
IF FILE("DOC.TXT")
   TAM=DIRECTORY("DOC.TXT","2")                                                                                                   
   IF TAM[1,2] > 60000                                                       
      ERASE DOC.TXT
      ALERT("O aquivo de parametros;"+TAM[1,1]+";foi renovado.;;"+REPL("Ä",20)+";Motivo;Tamanho excedido",,"W+/B")
      ACAO=ACAO+time()+"-Renovado "+TAM[1,1]+" por excesso de tamanho"+CHR(13)+CHR(10)
      TEXTO=""
   ELSE
      TEXTO=MEMOREAD("DOC.TXT")
   ENDIF   
ELSE
   TEXTO=""
ENDIF
TEXTO+="MAQUINA  : " + MAQUINA+CHR(13)+CHR(10)
TEXTO+="PROGRAMA : " + PROGRAMA+CHR(13)+CHR(10)
TEXTO+="USUARIO  : " + USUARIO+CHR(13)+CHR(10)
TEXTO+="DATA     : " + DTOC(DATE())+CHR(13)+CHR(10)
TEXTO+="INICIO   : " + ENTRADA+CHR(13)+CHR(10)
TEXTO+="TERMINO  : " + SAIDA+CHR(13)+CHR(10)
TEXTO+="TOTAL    : " + TEMPO+CHR(13)+CHR(10)
TEXTO+="HISTORICO: " + CHR(13)+CHR(10)+ACAO+CHR(13)+CHR(10)
TEXTO+=REPLICATE("=",50)+CHR(13)+CHR(10)
MEMOWRIT("DOC.TXT",TEXTO)

FUNCTION VALIDADE(GET)
REG   = RECN()
ORDEM = INDEXORD()
SET ORDER TO 1
IF EMPTY(GET) .AND. LASTKEY()<>5
   ALERT("Preenchimento obrigatorio")
   RETURN.F.
ENDIF
IF DBSEEK(GET)=.T.
   ALERT(TRIM(GET)+";"+REPL("Ä",20)+";J  existe;Tente outro")
   GOTO REG
   RETURN.F.
ENDIF
SET ORDER TO ORDEM
GOTO REG
RETURN.T.


FUNCTION RELATORIO
   SET COLOR TO BG+/N,W+/B 
   USE DOC
   INDEX ON NOME TO DOC.NTX
   FILTRO1 := space(35)
   FILTRO2 := space(35)

   @  7,022 CLEAR TO 17, 60
   @  7,022       TO 17, 60           color "BG+/N"
   @  9,024 say padc("RELATORIO", 35) color "W+/BG"
   @ 11,023 say "INICIO:"
   @ 12,023 get FILTRO1 pict "@!"  
   @ 15,023 say "FINAL :"          
   @ 16,023 get FILTRO2 pict "@!"  
   SET CURSOR ON
   READ
   @ 09,024 SAY PADC("IMPRIMINDO. AGUARDE",35) COLOR ("W+*/R")
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
      @  linha+0,00 say ""
      if (linha == 0)
         Pagina++
         @ linha+0,00 say ""
         @ linha+1,000 say "BARRETO MATERIAL DE CONSTRUCAO"
         @ linha+2,000 say "TITULOS PROTESTADOS DEVOLVIDOS"
         @ linha+2,099 say "Arq.: " + TRIM(dbf())+".DBF"
         @ linha+2,121 say "Pag.: " + SubStr(Str(pagina+100000000.0,9),2)
         @ linha+3,099 say "Data: " + DBDATA(date())+" Hora: " + TIME()
         @ linha+4,  0 say PADL("Impresso por " + Trim(Usuario),135)
         @ linha+4,  0 say "Iniciado em  :" + Trim(filtro1)
         @ linha+5,  0 say "Finalizado em:" + Trim(filtro2)
         @ linha+7,  0 say Repl("Ä",135)
         @ linha+8,  0 say "Nome"
         @ linha+8, 37 say "Seu numero"
         @ linha+8, 49 say "Dia  vencimento"         
         @ linha+8, 65 say "Dias vencidos"            
         @ linha+8, 80 say "Valor titulo"
         @ linha+8, 95 say "Tx. Perm."
         @ linha+8,105 say "Tx. Protesto"
         @ linha+8,120 say "Valor c/juro"
         linha=10
      endif
      ** formulas ***
      vATRAZ = (DATE() - VENCI)
      vJUROS = (txperm * vATRAZ)
      vTOTAL = (valor + custo + vJUROS)

      @ linha, 00 say NOME
      @ linha, 37 say SNUMERO
      @ linha, 49 say dbData(venci)
      @ linha, 65 say str(vATRAZ,13)
      @ linha, 80 say str(VALOR,11,2)
      @ linha, 95 say str(TXPERM,9,2)
      @ linha,105 say str(CUSTO,13,2) 
      @ linha,120 say str(vTOTAL,11,2)
      TOTALVALOR+=VALOR
      TOTALJUROS+=vTOTAL
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
   @ LINHA+01,000 SAY "TOTAL"+REPL(".",75)
ELSE                                               
  @ LINHA+01,000 SAY "SUBTOTAL"+REPL(".",72)
ENDIF       
@ LINHA+01,080 SAY STR(TOTALVALOR,11,2)
@ LINHA+01,120 SAY STR(TOTALJUROS,11,2)
IF PAR1=2
   @ LINHA+03,000 SAY "RELATORIO COM "+ALLTRIM(STR(REGISTRO))+" REGISTROS."
   @ LINHA+05,000 SAY "OBS.: VALOR C/JUROS somente valido para o dia corrente '("+dbdata()+")'."
ENDIF
LINHA=0
EJECT
RETURN

FUNCTION DbData(vDATA)
if vdata=nil
   vdata=DATE()
else
   vdata=vdata
endif
semana   := "DomSegTerQuaQuiSexSab"
dia      := Trim(SubStr(semana, DoW(vDATA) * 3 - 2, 3)) + ". " 
dia      := dia+dtoc(vdata)
return dia

