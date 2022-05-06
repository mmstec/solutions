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

    SET COLOR TO W+/N,W+/B
    SET DATE FORMAT TO "dd,mm,yyyy"
    SET DATE BRIT
    SET EPOCH TO 1900
    SET EXCLUSIV ON
    SET DELETE ON
    set score off

    USUARIO := SPACE(20)
    SENHA()
    PROGRAMA:= PROCNAME()+".EXE"
    MAQUINA := ALLTRIM(NETNAME())
    USUARIO := IIF(EMPTY(USUARIO),"Usuario",USUARIO)
    ENTRADA := TIME()
    ACAO    := time()+"-Entrada normal"+CHR(13)+CHR(10)
    LIG     :="Ligado em "+DTOC(date())+" "+time()
    DES     :="Desligado em "+DTOC(date())+" "+time()
    FILTRO1 :=ctod("  /  /    ")
    FILTRO2 :=ctod("  /  /    ")                            
    AUTOR   :="(C) Marcos Morais de Sousa - 1995/"+TRAN(YEAR(DATE()),"@E 9999")
    vIP     :=0
    V1      :=SPACE(10)
    V2      :=SPACE(10)
    V3      :=SPACE(10)
    V4      :=SPACE(10)
    V5      :=SPACE(10)
    V6      :=SPACE(10)

    IF FILE("scc.LIG")
       ALERT("SISTEMA JA ESTA EM USO")
       QUIT
    ELSE
        if file("scc.DES")
           ERASE scc.DES
           SAVE all like LIG to SCC.LIG
        else
           SAVE all like LIG to SCC.LIG
        endif
     ENDIF

    if !file("SCC.STG")
        vIP=0  && indice percentual
        @ 02,10 CLEAR TO 18,70
        @ 02,10 TO 18,70 DOUBLE color "BG+/n"
        @ 03,11 SAY PADC("C O N F I G U R A C O E S",60)     
        @ 05,11 SAY "Indice para calculo de comissoes"   color "w+/n"
        @ 06,11 SAY " Indice:" GET vIP PICT "@Z 99.99" valid !EMPTY(vIP) .AND. LASTKEY()<>27
        @ 08,11 SAY "Nome do vendedor"                   color "w+/n"
        @ 09,11 SAY " No. 01:" GET v1 PICT "@!" valid !EMPTY(v1) .AND. LASTKEY()<>27
        @ 10,11 SAY " No. 02:" GET v2 PICT "@!" valid !EMPTY(v2) .AND. LASTKEY()<>27
        @ 11,11 SAY " No. 03:" GET v3 PICT "@!" valid !EMPTY(v3) .AND. LASTKEY()<>27
        @ 12,11 SAY " No. 04:" GET v4 PICT "@!" valid !EMPTY(v4) .AND. LASTKEY()<>27
        @ 13,11 SAY " No. 05:" GET v5 PICT "@!" valid !EMPTY(v5) .AND. LASTKEY()<>27
        @ 14,11 SAY " No. 06:" GET v6 PICT "@!" valid !EMPTY(v6) .AND. LASTKEY()<>27
        @ 17,11 SAY " Informacoes obrigatorias " color 'w*/n'
        READ
        SAVE all like v* to SCC.stg
        RESTORE FROM scc.stg ADDITIVE
     else
        RESTORE FROM SCC.stg ADDITIVE
    endif
    CLS
    PUBLIC vIP,V1,V2,V3,V4,V5,V6
   
   IF !FILE("COMISSAO.DBF")
      FCAMPO:={}
      AADD( FCAMPO,{"DATA","D", 08,  0} )
      AADD( FCAMPO,{"VENDAS01","N", 10,  2} )
      AADD( FCAMPO,{"VENDAS02","N", 10,  2} )   
      AADD( FCAMPO,{"VENDAS03","N", 10,  2} )   
      AADD( FCAMPO,{"VENDAS04","N", 10,  2} )   
      AADD( FCAMPO,{"VENDAS05","N", 10,  2} )   
      AADD( FCAMPO,{"VENDAS06","N", 10,  2} )   
      DBCREATE("COMISSAO",FCAMPO)
      USE COMISSAO
      INDEX ON DTOS(DATA) TO COMISSAO
   ELSE
      USE COMISSAO
      INDEX ON DTOS(DATA) TO COMISSAO
   ENDIF

   PRIVATE Titulo[7] 
           Titulo[1] = "Dia  Data"
           Titulo[2] = padl(v1,12)
           Titulo[3] = padl(v2,12)
           Titulo[4] = padl(v3,12)
           Titulo[5] = padl(v4,12)
           Titulo[6] = padl(v5,12)
           Titulo[7] = padl(v6,12)

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
           REGISTRO[2] = 'VENDAS01'
           REGISTRO[3] = 'VENDAS02'
           REGISTRO[4] = 'VENDAS03'
           REGISTRO[5] = 'VENDAS04'
           REGISTRO[6] = 'VENDAS05'
           REGISTRO[7] = 'VENDAS06'

   @ 01,01 SAY PADr("Barreto Material de Construcao",80)          color "w+/n"
   @ 02,01 SAY PADr("(073) 525-2344",80)                          color "R+/N"
   @ 04,01 SAY PADr("SCC Sistema de Controlador de Comicoes",80)  color "w+/n"

   SET COLOR TO B+/N,N/W
   @ 05,00 CLEAR TO 21,79
   @ 05,01 say repl("Í",78)      COLOR "B+/N"
   @ 19,00       TO 21,79 double COLOR "B+/N"
   GO TOP
   DBEDIT(06,01,19,78,REGISTRO,"EDITA",MASCARA,TITULO,"ÍÍÍ","   ","ÍÍÍ",.T.)



FUNCTION EDITA(MODO,INDICE)
LOCAL TECLA  

TECLA := LASTKEY()
CAMPO  := REGISTRO[INDICE]

DO CASE
   CASE MODO = 1
        MENSAGEM("Inicio do Arquivo",3)
        MENSAGEM("")
        SET CURSOR OFF
        RETURN 1

   CASE MODO = 2
        MENSAGEM("Final do Arquivo",3)
        MENSAGEM("")
        SET CURSOR OFF
        RETURN 1
      
   CASE MODO = 3
        MENSAGEM("Arquivo Vazio")
        SET CURSOR OFF
        RETURN 1
      
   CASE MODO = 4
        IF TECLA = ESC
           SET COLOR TO W/N
           CLS
           SAIDA = TIME()
           ERASE SCC.LIG
           SAVE all like DES to SCC.DES
           if file("scc.des")
              ACAO=ACAO+SAIDA+"-Saida normal"+CHR(13)+CHR(10)
           else
              ACAO=ACAO+SAIDA+"-Saida ANORMAL"+CHR(13)+CHR(10)
           endif
           GRAVALOG(ENTRADA,SAIDA)
           LOGOMARCA()
           RETURN 0

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
                 SET COLOR TO
                 PACK
                 RESTORE SCREEN FROM TELA
                 RETURN(1)

          ELSEIF TECLA = 80 .OR. TECLA = 112
                 SAVE SCREEN TO TELA
                 CONSULTA()
                 RESTORE SCREEN FROM TELA
                 RETURN 1
          
          ELSEIF TECLA = 69 .OR. TECLA = 101
                 campo=fieldname(indice)
                 save screen to tela
                 set cursor on
                 if type("&campo")="D"
                    @ ROW(),COL()+5 GET &CAMPO COLOR "W+/N"
                    ACAO=ACAO+TIME()+"-Edicao de "+dtoc(data)+CHR(13)+CHR(10)
                 else
                    @ ROW(),COL() GET &CAMPO   COLOR "W+/N"
                    ACAO=ACAO+TIME()+"-Edicao de "+campo+CHR(13)+CHR(10)
                 endif
                 mensagem("Edicao de registro ativada")
                 read
                 restore screen from tela
                 set cursor off
                 keyboard CHR(4)
                 return(1)

          *I ou i*
          ELSEIF TECLA = 73 .OR. TECLA = 105
                 SAVE SCREEN TO TELA
                 if (!isprinter())
                    alert("* IMPRESSORA DESLIGADA *")
                 else
                    relatorio()
                    set devi to screen
                    set filter to
                 endif
                 return(2)
          
          elseif tecla = 076 .or. tecla = 108
                 save screen to tela
                 append blank
                 @ 07,17 clear to 22,57
                 @ 07,17       to 22,57 double             color ("BG+ /N")
                 @ 08,20 SAY PADC("LANCANDO REGISTROS",35) color ("W+*/BG")
                 @ 10,20 SAY "DATA"          color ("G+/N,W+/R")

                 @ 12,20 SAY PADR(V1,10)    color ("G+/N")
                 @ 13,20 SAY PADR(V2,10)    color ("G+/N")
                 @ 14,20 SAY PADR(V3,10)    color ("G+/N")
                 @ 15,20 SAY PADR(V4,10)    color ("G+/N")
                 @ 16,20 SAY PADR(V5,10)    color ("G+/N")
                 @ 17,20 SAY PADR(V6,10)    color ("G+/N")

                 @ 10,26 GET DATA pict "@!"
                 @ 12,35 GET VENDAS01   pict "@!"
                 @ 13,35 GET VENDAS02   pict "@!"  
                 @ 14,35 GET VENDAS03   pict "@!"  
                 @ 15,35 GET VENDAS04   pict "@!"
                 @ 16,35 GET VENDAS05   pict "@!"
                 @ 17,35 GET VENDAS06   pict "@!"
                 @ 21,20 say PADC("Existe "+ALLTRIM(str(RecCount()-1,4))+" registros no arquivo",35) color "w+/n"
                 SET CURSOR ON
                 READ                                               
                 ACAO=ACAO+TIME()+"-Lancamento de dados "+"Data      "+dtoc(data)+CHR(13)+CHR(10)
                 ACAO=ACAO+TIME()+"-Lancamento de dados "+V1+" "+str(vendas01)+CHR(13)+CHR(10)
                 ACAO=ACAO+TIME()+"-Lancamento de dados "+V2+" "+str(vendas02)+CHR(13)+CHR(10)
                 ACAO=ACAO+TIME()+"-Lancamento de dados "+V3+" "+str(vendas03)+CHR(13)+CHR(10)
                 ACAO=ACAO+TIME()+"-Lancamento de dados "+V4+" "+str(vendas04)+CHR(13)+CHR(10)
                 ACAO=ACAO+TIME()+"-Lancamento de dados "+V5+" "+str(vendas05)+CHR(13)+CHR(10)
                 ACAO=ACAO+TIME()+"-Lancamento de dados "+V6+" "+str(vendas06)+CHR(13)+CHR(10)
                 IF LASTKEY()=27
                    DELETE
                    PACK
                 ENDIF
                 RESTORE SCREEN FROM TELA
                 SET CURSOR OFF
                 *GO TOP
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
                    ACAO=ACAO+TIME()+"-Eliminou registro "+&campo+CHR(13)+CHR(10)
                    DELETE
                    PACK
                    RESTORE SCREEN FROM TELA
                    INDEX ON DTOS(DATA) TO COMISSAO
                    GO BOTTOM
                 ELSE
                    RESTORE SCREEN FROM TELA
                 ENDIF
          ELSEIF TECLA = DEL
                 ALERT("Para EXCLUIR tecle; [A] de Apagar")
                 RETURN 1

          ELSEIF TECLA = ENTER
                 SAVE SCREEN TO TELA
                 VENDAS=VENDAS01+VENDAS02+VENDAS03+VENDAS04
                 VENDAS=VENDAS+VENDAS05+VENDAS06
                 SET COLOR TO W+/N,W/N 
                 @ 05,17 to 07,64                                                COLOR("W+/R")
                 @ 06,18 say padc("Comissao = valor x Base de Cauculo / 100",46) COLOR("W+/R")
                 @ 08,17 clear to 23,64
                 @ 08,17       to 23,64 DOUBLE                                                                 COLOR "W+/n"
                 @ 09,20 say DIA(DATA)                                     COLOR "W+/n"
                 @ 10,20 SAY "Base do Cauculo: "+STRZERO(vIP,4,2)+"%"      COLOR "W /n"
                 @ 12,20 SAY PADr("Vendedor",10)+padl("Valor",14)+padl("Comissao",14)                          COLOR "bG+/n"
                 @ 14,20 SAY padR(V1,10)+padl(STR(VENDAS01),14)+padl(STR((VENDAS01*vIP)/100),14)    pict "@!"  COLOR "W+/n"
                 @ 15,20 SAY padR(V2,10) +padl(STR(VENDAS02),14)+padl(STR((VENDAS02*vIP)/100),14)   pict "@!"  COLOR "W+/n"
                 @ 16,20 SAY padR(V3,10) +padl(STR(VENDAS03),14)+padl(STR((VENDAS03*vIP)/100),14)   pict "@!"  COLOR "W+/n"
                 @ 17,20 SAY padR(V4,10) +padl(STR(VENDAS04),14)+padl(STR((VENDAS04*vIP)/100),14)   pict "@!"  COLOR "W+/n"
                 @ 18,20 SAY padR(V5,10) +padl(STR(VENDAS05),14)+padl(STR((VENDAS05*vIP)/100),14)   pict "@!"  COLOR "W+/n"
                 @ 19,20 SAY padR(V6,10) +padl(STR(VENDAS06),14)+padl(STR((VENDAS06*vIP)/100),14)   pict "@!"  COLOR "W+/n"
                 @ 21,20 SAY padr("TOTAL:",10)+padl(STR(VENDAS,12,2),14)+padl(STR((VENDAS*vIP)/100),14)      COLOR "g+/n"
                 ACAO=ACAO+TIME()+"-Visualizou ( teclou enter ) comissao do dia"+dtoc(data)+CHR(13)+CHR(10)
                 INKEY(60)
                 SET COLOR TO 
                 RESTORE SCREEN FROM TELA
                 RETURN 1
         ENDIF
      OTHERWISE

          SETCOLOR ("W/R")
          @ 20,01 SAY SPACE(78)
          @ 20,05 SAY "[P] esquisar"
            @ 20,06 SAY "P" COLOR ("W+/R")
          @ 20,20 say "[E] ditar"
            @ 20,21 SAY "E" COLOR ("W+/R")
          @ 20,35 say "[A] pagar"
            @ 20,36 SAY "A" COLOR ("W+/R")
          @ 20,50 say "[L] lancar"
            @ 20,51 SAY "L" COLOR ("W+/R")
          @ 20,65 say "[I] mprimir"
          @ 20,66 say "I"COLOR ("W+/R")

          *  @ 20,66 SAY "ESC" COLOR ("W+/R")
          MENSAGEM(" Registro "+alltrim(str(recno(),4))+"/"+alltrim(str(lastrec(),4)))
          DATA("C",24,00,80,"W+/N")
          SET CURSOR OFF
          RETURN 1
      
      ENDCASE

FUNCTION CONSULTA
     DO WHILE .T.
          PSQ=CTOD("  /  /  ")
          @ 19,00 TO 21,28 DOUBLE        COLOR "BG+/N"
          @ 20,01 say " DATA A PROCURAR :" COLOR "W+/N"
          @ 20,18 GET PSQ                 COLOR ",RG+/N"
          SET CURSOR ON
          READ
          SET CURSOR OFF
          IF LASTKEY()=27
             EXIT
          ENDIF
          SEEK TRIM(DTOS(PSQ))
          ACAO=ACAO+TIME()+"-Consultou data "+DTOC(PSQ)+CHR(13)+CHR(10)
          IF EOF()
               BEEP()
               MENSAGEM("Dados n„o encontrados",3)
               MENSAGEM("Tecle <ESC> para escapar/sair")
               LOOP
          ENDIF
          EXIT
     ENDDO
SET DELETED ON
RETURN.T.


PROCEDURE GRAVALOG(ENTRADA,SAIDA)
TEMPO   :=ELAPTIME(ENTRADA,SAIDA)
IF FILE("SCC.TXT")
   TEXTO=MEMOREAD("SCC.TXT")
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
texto+="HISTORICO: " + CHR(13)+CHR(10)+ACAO+CHR(10)
TEXTO+=REPLICATE("=",50)+CHR(13)+CHR(10)
MEMOWRIT("SCC.TXT",TEXTO)

********************************

function RELATORIO
   use COMISSAO
   index on DTOS(DATA) to COMISSAO.NTX
   FILTRO1 :=ctod("  /  /    ")
   FILTRO2 :=ctod("  /  /    ")
   @  7, 22 to 17, 59 color "R+/N"
   @  8, 23 clear to 16, 58
   @  9, 24 say padc("INFORME O PERIODO", 35) color "W+/R"
   @ 11, 29 say "PERIODO DE :" get FILTRO1
   @ 13, 29 say "ATE        :" get FILTRO2
   SET CURSOR ON
   READ
   alert("Aconselha-se imprimir; em modo condensado")
   @ 15, 24 SAY "Aguarde o fim da impressao..." color "w+*/r"
   ACAO=ACAO+TIME()+"-Impressao do periodo "+dtoc(filtro1)+" ate "+dtoc(filtro2)+CHR(13)+CHR(10)
   SET CURSOR OFF
   IF LASTKEY()=27
      SET DEVI TO SCREEN
      SET FILTER TO
      ALERT("IMPRESSAO ABORTADA")
      RETURN 1
   ENDIF
   set filter to DATA>=FILTRO1 .AND. DATA<=FILTRO2
   if (!(data >= filtro1 .AND. data <= filtro2))
      skip
   Endif
   set device to printer
   TOTALV1:=0
   TOTALV2:=0
   TOTALV3:=0
   TOTALV4:=0
   TOTALV5:=0
   TOTALV6:=0
   TVENDAS:=0
   TCOMISSAO:=0
   LINHA  := 1
   PAGINA := 1
   do while (!EOF())
      if (linha == 1)
         @  1,  0 say "BARRETO MATERIAL DE CONSTRUCAO"
         @  2,  0 say "SCC-Sistema Controlador de Comissoes"
         @  5,  0 say padl("PAGINA: " + SubStr(Str(pagina + 1000000.0, 7), 2)+" Hora:"+time(), 79)
         pagina:= pagina + 1
         @  5,  0 say "VENDAGEM COMISSIONADA"
         @  6,  0 say "PERIODO DE:" + DToC(filtro1)
         @  6,  0 say padl("Arquivo :"+trim(dbf())+".DBF",79)
         @  7,  0 say "ATE       :" + DToC(filtro2)
         @ 10,  1 say Replicate("*",129)
         @ 11,  1 say "Dia  Data"
         @ 11, 18 say padl(v1,13)
         @ 11, 32 say padl(v2,13)
         @ 11, 46 say padl(v3,13)
         @ 11, 60 say padl(v4,13)
         @ 11, 74 say padl(v5,13)
         @ 11, 88 say padl(v6,13)
         @ 12,  1 say Replicate("*",129)
         linha := 14
      endif

      @ linha, 01 say dbData(data)
      @ linha, 18 say VENDAS01 
      @ linha, 32 say VENDAS02 
      @ linha, 46 say VENDAS03 
      @ linha, 60 say VENDAS04
      @ linha, 74 say VENDAS05
      @ linha, 88 say VENDAS06
      TOTALV1:= TOTALV1 + VENDAS01
      TOTALV2:= TOTALV2 + VENDAS02
      TOTALV3:= TOTALV3 + VENDAS03
      TOTALV4:= TOTALV4 + VENDAS04
      TOTALV5:= TOTALV5 + VENDAS05
      TOTALV6:= TOTALV6 + VENDAS06
      Linha:= Linha + 1
      skip
      if (linha >= 45 .OR. EOF())
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
   @ LINHA+01,001 SAY "TOTAL   "
ELSE
   @ LINHA+01,001 SAY "SUBTOTAL"
ENDIF
   @ LINHA+01,18 SAY STR(TOTALV1,10,2)
   @ LINHA+01,32 SAY STR(TOTALV2,10,2)
   @ LINHA+01,46 SAY STR(TOTALV3,10,2)
   @ LINHA+01,60 SAY STR(TOTALV4,10,2)
   @ LINHA+01,74 SAY STR(TOTALV5,10,2)
   @ LINHA+01,88 SAY STR(TOTALV6,10,2) 
IF PAR1=2
   LINHA=45
   TVENDAS  :=TOTALV1+TOTALV2+TOTALV3+TOTALV4+TOTALV5+TOTALV6
   TCOMISSAO:=(TVENDAS*vIP)/100
   @ LINHA+01,001 SAY REPL("*",129)   
   @ LINHA+02,001 SAY PADR(V1,10)+".......:"+STR(TOTALV1,12,2)+" * "+STR(vIP,4,1)+" % = "+STR((TOTALV1*vIP)/100,10,2)
   @ LINHA+03,001 SAY PADR(V2,10)+".......:"+STR(TOTALV2,12,2)+" * "+STR(vIP,4,1)+" % = "+STR((TOTALV2*vIP)/100,10,2)
   @ LINHA+04,001 SAY PADR(V3,10)+".......:"+STR(TOTALV3,12,2)+" * "+STR(vIP,4,1)+" % = "+STR((TOTALV3*vIP)/100,10,2)
   @ LINHA+05,001 SAY PADR(V4,10)+".......:"+STR(TOTALV4,12,2)+" * "+STR(vIP,4,1)+" % = "+STR((TOTALV4*vIP)/100,10,2)
   @ LINHA+06,001 SAY PADR(V5,10)+".......:"+STR(TOTALV5,12,2)+" * "+STR(vIP,4,1)+" % = "+STR((TOTALV5*vIP)/100,10,2)
   @ LINHA+07,001 SAY PADR(V6,10)+".......:"+STR(TOTALV6,12,2)+" * "+STR(vIP,4,1)+" % = "+STR((TOTALV6*vIP)/100,10,2)
   @ LINHA+09,001 SAY PADR("Total",10)+".......:"+STR(TVENDAS,12,2)+SPACE(10)+STR(TCOMISSAO,12,2)
   @ LINHA+10,001 SAY REPL("*",129)                                      
ENDIF
eject
RETURN

FUNCTION condicao1
IF !EMPTY(v1) .AND. LASTKEY()<>5
   BEEP()
   MENSAGEM("Informacao obrigatoria",3)
   MENSAGEM("Tecle <ESC> para retornar")
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

function senha
   if !file("senha.dbf")
      fcampo:={}
      aadd( fcampo,{"NOME","C", 35,  0} )
      aadd( fcampo,{"SENHA","C", 6,  0} )   
      dBCreate("senha",fcampo)
      use senha
      index on nome to senha.ntx
   else
      use senha
      index on nome to senha.ntx
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
      @ 14,12 get vUSUARIO pict "@!" valid validade(vUSUARIO)
      read
      @ 16,12 say padc(">>Digite a senha de acesso<<",56)  color "w+*/r"
      @ 90,12 get vSENHA PICT "@!" color "n/n" valid validade(vSENHA)
      set cursor on
      READ
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

