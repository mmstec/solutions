    SET COLOR TO W+/N,W+/B
    SET DATE FORMAT TO "dd,mm,yyyy"
    SET DATE BRIT
    SET EPOCH TO 1900
    SET EXCLUSIV ON
    SET DELETE ON
    SET SCORE OFF

    USUARIO := SPACE(20)
    @ 10,10 CLEAR TO 15,70          
    @ 10,10       TO 15,70 DOUBLE COLOR "W+/N"
    @ 12,12 SAY "Por favor, seu nome"
    @ 13,12 GET USUARIO PICT "@!" VALID !EMPTY(USUARIO) .AND. LASTKEY()<>27
    READ
    PROGRAMA:= PROCNAME()+".EXE"
    MAQUINA := ALLTRIM(NETNAME())
    USUARIO := IIF(EMPTY(USUARIO),"Usuario",USUARIO)
    M->ENTRADA := TIME()
    LIG     :="Ligado em "+DTOC(date())+" "+time()
    DES     :="Desligado em "+DTOC(date())+" "+time()
    FILTRO1 :=ctod("  /  /    ")
    FILTRO2 :=ctod("  /  /    ")
    
    IF FILE("SMC.LIG")
       ALERT("SISTEMA JA ESTA EM USO")
       QUIT
    ELSE
       if file("SMC.DES")
           ERASE SMC.DES
           SAVE all like LIG to SMC.LIG
        else
           SAVE all like LIG to SMC.LIG
        endif
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
   
   IF !FILE("SMC.DBF")
      FCAMPO:={}
      AADD( FCAMPO,{"DATA","D", 08,  0} )
      AADD( FCAMPO,{"ENTRADA","N", 10,  1} )
      AADD( FCAMPO,{"SVISTA","N", 10,  1} )
      AADD( FCAMPO,{"SPRAZO","N", 10,  1} )   
      AADD( FCAMPO,{"STOTAL","N", 10,  1} )   
      DBCREATE("SMC",FCAMPO)
      USE SMC
      INDEX ON DTOS(DATA) TO SMC
   ELSE
      USE SMC
      INDEX ON DTOS(DATA) TO SMC
   ENDIF

   PRIVATE Titulo[5] 
           Titulo[1] = "DATA"
           Titulo[2] = "Entrada"
           Titulo[3] = "S. avista"
           Titulo[4] = "S. aprazo"
           Titulo[5] = "S. total"

   PRIVATE MASCARA[5]  
           MASCARA[1] = "@!"
           MASCARA[2] = "@!"
           MASCARA[3] = "@!"
           MASCARA[4] = "@!"
           MASCARA[5] = "@!"

   DECLARE REGISTRO[6]
           REGISTRO[1] = "DATA"
           REGISTRO[2] = "ENTRADA"
           REGISTRO[3] = "SVISTA"
           REGISTRO[4] = "SPRAZO"
           REGISTRO[5] = "STOTAL"

   @ 01,20 SAY PADC("BARRETO MATERIAL DE CONSTRUCAO",40) color "w+/B"
   @ 03,20 SAY PADC(" (073) 525-2344 ",40)   color "R+/N"
   @ 05,00 SAY PADC("SMC-SISTEMA DE MOVIMENTO DO CIMENTO",80) color "w+/b"

   SET COLOR TO B+/N,N/W
   @ 06,00 CLEAR TO 21,79
   @ 06,00       TO 21,79 double COLOR "B+/N"
   GO TOP
   DBEDIT(07,01,19,78,REGISTRO,"EDITA",MASCARA,TITULO,"ÄÂÄ"," ³ ","ÄÁÄ",.T.)



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
           GRAVALOG(ENTRADA,SAIDA)
           ERASE SMC.LIG
           SAVE all like DES to SMC.DES
           LOGOMARCA()
           RETURN 0

          ELSEIF TECLA = F1
                 AUTOR="(C) Marcos Morais de Sousa - 1995/"+TRAN(YEAR(DATE()),"@E 9999")
                 ALERT(" CRIACAO DE ;"+AUTOR)
                 PACK
                 RETURN 1

          ELSEIF TECLA = 80 .OR. TECLA = 112
                 SAVE SCREEN TO TELA
                 CONSULTA()
                 RESTORE SCREEN FROM TELA
                 RETURN 1
          
          ELSEIF TECLA = 69 .OR. TECLA = 101
                 SAVE SCREEN TO TELA
                 SET CURSOR ON
                 @ ROW(),COL() GET &CAMPO PICT "@!" 
                 MENSAGEM("ALTERACAO DE CAMPO ATIVADO")   
                 READ
                 READ
                 M->VSAIDA=SVISTA+SPRAZO
                 REPLACE STOTAL WITH M->VSAIDA
                 RESTORE SCREEN FROM TELA
                 SET CURSOR OFF
                 RETURN (2)
          *I ou i*
          ELSEIF TECLA = 73 .OR. TECLA = 105
                 SAVE SCREEN TO TELA
                 if (!isprinter())
                    alert("* IMPRESSORA DESLIGADA *")
                 else
                    relatorio()
                    SET DEVI TO SCREEN
                    SET FILTER TO
                 endif
                 RETURN (2)
          *L ou l*
          ELSEIF TECLA = 076 .OR. TECLA = 108
                 SAVE SCREEN TO TELA
                 APPEND BLANK 
                 @ 07,17 clear to 20,57
                 @ 07,17       to 20,57 DOUBLE  color ("B+/N")
                 @ 08,20 SAY PADC("LANCANDO REGISTROS",35) COLOR "W+*/B"
                 @ 10,20 SAY "DATA"          color ("G+/N,W+/R")
                 @ 12,20 SAY "ENTRADA"    color ("G+/N")
                 @ 14,20 SAY "SAIDA AVISTA"    color ("G+/N")
                 @ 16,20 SAY "SAIDA APRAZO"    color ("G+/N")

                 @ 10,35 GET DATA pict "@!"
                 @ 12,35 GET ENTRADA pict "@!"
                 @ 14,35 GET SVISTA pict "@!"
                 @ 16,35 GET SPRAZO pict "@!"
                 @ 18,20 say PADC("Existe "+ALLTRIM(str(RecCount()-1,4))+" registros no arquivo",35) color "w+/n"
                 SET CURSOR ON
                 READ
                 M->VSAIDA=SVISTA+SPRAZO
                 REPLACE STOTAL WITH M->VSAIDA
                 IF LASTKEY()=27
                    DELETE
                    PACK
                 ENDIF
                 RESTORE SCREEN FROM TELA
                 SET CURSOR OFF
                 *GO TOP
                 RETURN 2

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
                    DELETE
                    PACK
                    RESTORE SCREEN FROM TELA
                    INDEX ON DTOS(DATA) TO SMC
                    GO TOP
                 ELSE
                    RESTORE SCREEN FROM TELA
                 ENDIF
          ELSEIF TECLA = DEL
                 ALERT("Para EXCLUIR tecle; [A] de Apagar")
                 RETURN 1

          ELSEIF TECLA = ENTER
                 SAVE SCREEN TO TELA
                 ALERT("AINDA NAO DISPONIVEL")
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
TEMPO=ELAPTIME(M->ENTRADA,SAIDA)
IF FILE("SMC.TXT")
   TEXTO=MEMOREAD("SMC.TXT")
   ELSE
   TEXTO=""
ENDIF
TEXTO+="ESTACAO &MAQUINA. ATIVO POR &TEMPO."+CHR(13)+CHR(10)
TEXTO+="USUARIO: " + USUARIO+CHR(13)+CHR(10)
TEXTO+="DATA   : " + DTOC(DATE())+CHR(13)+CHR(10)
TEXTO+="INICIO : " + M->ENTRADA+CHR(13)+CHR(10)
TEXTO+="TERMINO: " + SAIDA+CHR(13)+CHR(10)
TEXTO+=REPLICATE("=",50)+CHR(13)+CHR(10)
MEMOWRIT("SMC.TXT",TEXTO)

********************************
function RELATORIO
   USE SMC
   index on DTOS(DATA) to SMC.NTX
   FILTRO1 :=ctod("  /  /    ")
   FILTRO2 :=ctod("  /  /    ")
   @  7, 22 to 17, 59 color "R+/N"
   @  8, 23 clear to 16, 58
   @  9, 24 say padc("INFORME O PERIODO", 35) color "W+/R"
   @ 11, 29 say "PERIODO DE :" get FILTRO1
   @ 13, 29 say "ATE        :" get FILTRO2
   SET CURSOR ON
   READ
   alert("Aconselha-se imprimir em modo condensado") 
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
   endif
   set device to printer
   TOTAL1:=0
   TOTAL2:=0
   TOTAL3:=0
   TOTAL4:=0
   TGERAL:=0
   LINHA := 1
   PAGINA:= 1
   do while (!EOF())
      if (linha = 1)
         @  1,  0 say padR("BARRETO MATERIAL DE CONSTRUCAO", 80)
         @  2,  0 say padR("SMC-SISTEMA DE MOVIMENTO DO CIMENTO", 80)
         @  5,  0 say padl("PAGINA: " + SubStr(Str(pagina + 1000000.0, 7), 2), 79)
         pagina := pagina + 1
         @  5,  0 say "MOVIMENTO DO CIMENTO"
         @  6,  0 say "PERIODO DE:" + DToC(filtro1)
         @  6,  0 say padl("Arquivo :"+trim(dbf())+".DBF",79)
         @  7,  0 say "ATE       :" + DToC(filtro2)
         @ 10,  1 say Replicate("*",129)
         @ 11,  1 say "DATA"
         @ 11, 12 say "ENTRADA"
         @ 11, 26 say "SAIDA AVISTA"       
         @ 11, 40 say "SAIDA APRAZO"     
         @ 11, 54 say "SAIDA TOTAL"       
         @ 12,  1 say Replicate("*",129)
         linha := 14
      endif

      @ linha, 01 say DATA
      @ linha, 12 say ENTRADA
      @ linha, 26 say SVISTA
      @ linha, 40 say SPRAZO
      @ linha, 54 say STOTAL

      TOTAL1:= TOTAL1 + ENTRADA
      TOTAL2:= TOTAL2 + SVISTA
      TOTAL3:= TOTAL3 + SPRAZO
      TOTAL4:= TOTAL4 + STOTAL
      Linha := Linha + 1
      skip 
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
   EJECT
   return.T.

FUNCTION TOT_01
PARA PAR1
IF PAR1=2
   @ LINHA+01,001 SAY "TOTAL   "
ELSE
   @ LINHA+01,001 SAY "SUBTOTAL"
ENDIF
   @ LINHA+01,12 SAY STR(TOTAL1,10,2)
   @ LINHA+01,26 SAY STR(TOTAL2,10,2)
   @ LINHA+01,40 SAY STR(TOTAL3,10,2)
   @ LINHA+01,54 SAY STR(TOTAL4,10,2)
IF PAR1=2
   LINHA=45
   TGERAL :=TOTAL1+TOTAL2+TOTAL3+TOTAL4
   @ LINHA+09,001 SAY "TOTAL......: "+STR(TGERAL,12,2)
   @ LINHA+10,001 SAY REPL("*",129)
ENDIF
RETURN
