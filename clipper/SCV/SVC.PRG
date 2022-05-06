
    SET COLOR TO W+/N,W+/B
    SET DATE FORMAT TO "dd,mm,yyyy"
    SET DATE BRIT
    SET EPOCH TO 1900
    SET EXCLUSIV ON
    SET DELETE ON

    USUARIO := SPACE(20)
    @ 10,10 CLEAR TO 15,70          
    @ 10,10       TO 15,70 DOUBLE COLOR "W+/N"
    @ 12,12 SAY "Por favor, seu nome"
    @ 13,12 GET USUARIO PICT "@!" VALID !EMPTY(USUARIO) .AND. LASTKEY()<>27
    READ
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
    
    IF FILE("SVC.LIG")
       ALERT("SISTEMA JA ESTA EM USO")
       QUIT
    ELSE
        if file("SVC.DES")
           ERASE SVC.DES
           SAVE all like LIG to SVC.LIG
        else
           SAVE all like LIG to SVC.LIG
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
   
   IF !FILE("VENDAC.DBF")
      FCAMPO:={}
      AADD( FCAMPO,{"DATA","D", 08,  0} )
      AADD( FCAMPO,{"ESPECIE","N", 10,  2} )
      AADD( FCAMPO,{"NOTA","N", 10,  2} )
      AADD( FCAMPO,{"DUPLICATA","N", 10,  2} )   
      AADD( FCAMPO,{"RECEBIDO","N", 10,  2} )   
      AADD( FCAMPO,{"TIPO","C", 01,  0} )   
      DBCREATE("VENDAC",FCAMPO)
      USE VENDAC
      INDEX ON DTOS(DATA) TO VENDAC
   ELSE
      USE VENDAC
      INDEX ON DTOS(DATA) TO VENDAC
   ENDIF

   PRIVATE Titulo[6] 
           Titulo[1] = "DATA"
           Titulo[2] = "ESPECIE"
           Titulo[3] = "NOTA"
           Titulo[4] = "DUPLICATA"
           Titulo[5] = "RECEBIDO"
           Titulo[6] = "TIPO"

   PRIVATE MASCARA[6]  
           MASCARA[1] = "@!"
           MASCARA[2] = "@!"
           MASCARA[3] = "@!"
           MASCARA[4] = "@!"
           MASCARA[5] = "@!"
           MASCARA[6] = "@!"

   DECLARE REGISTRO[6]
           REGISTRO[1] = "DATA"
           REGISTRO[2] = "ESPECIE"
           REGISTRO[3] = "NOTA"
           REGISTRO[4] = "DUPLICATA"
           REGISTRO[5] = "RECEBIDO"
           REGISTRO[6] = "TIPO"

   @ 01,01 SAY PADr("Barreto Material de Construcao",80)          color "w+/n"
   @ 03,01 SAY PADr("(073) 525-2344",80)                          color "R+/N"
   @ 05,01 SAY PADr("SVC Sistema de Vendas pelo Cimento",80)  color "w+/n"

   SET COLOR TO B+/N,N/W
   @ 06,00 CLEAR TO 21,79
   @ 06,01 say repl("อ",78)      COLOR "B+/N"
   @ 19,00       TO 21,79 double COLOR "B+/N"
   GO TOP
   DBEDIT(07,01,19,78,REGISTRO,"EDITA",MASCARA,TITULO,"อออ","   ","อออ",.T.)



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
           ERASE SVC.LIG
           SAVE all like DES to SVC.DES
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
                 SAVE SCREEN TO TELA
                 SET CURSOR ON
                 @ ROW(),COL() GET &CAMPO PICT "@!" 
                 MENSAGEM("ALTERACAO DE CAMPO ATIVADO")   
                 READ
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
                 VTIPO="C"
                 @ 07,17 clear to 20,57
                 @ 07,17       to 20,57 DOUBLE  color ("B+/N")
                 @ 08,20 SAY PADC("LANCANDO REGISTROS",35) COLOR "W+*/B"
                 @ 10,20 SAY "DATA"          color ("G+/N,W+/R")

                 @ 12,20 SAY "ESPECIE"    color ("G+/N")
                 @ 13,20 SAY "NOTA"    color ("G+/N")
                 @ 14,20 SAY "DUPLICATA"    color ("G+/N")
                 @ 15,20 SAY "RECEBIDO"    color ("G+/N")
                 *@ 16,20 SAY "TIPO"    color ("G+/N")

                 @ 10,26 GET DATA pict "@!"
                 @ 12,35 GET ESPECIE pict "@!"
                 @ 13,35 GET NOTA pict "@!"
                 @ 14,35 GET DUPLICATA pict "@!"
                 @ 15,35 GET RECEBIDO pict "@!"
                 *@ 16,35 GET vTIPO pict "@!"
                 @ 18,20 say PADC("Existe "+ALLTRIM(str(RecCount()-1,4))+" registros no arquivo",35) color "w+/n"
                 SET CURSOR ON
                 READ
                 REPLACE TIPO WITH VTIPO
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
                    INDEX ON DTOS(DATA) TO COMISSAO
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
               MENSAGEM("Dados no encontrados",3)
               MENSAGEM("Tecle <ESC> para escapar/sair")
               LOOP
          ENDIF
          EXIT
     ENDDO
SET DELETED ON
RETURN.T.


PROCEDURE GRAVALOG(ENTRADA,SAIDA)
TEMPO=ELAPTIME(ENTRADA,SAIDA)
IF FILE("SVC.TXT")
   TEXTO=MEMOREAD("SVC.TXT")
   ELSE
   TEXTO=""
ENDIF
TEXTO+="ESTACAO &MAQUINA. ATIVO POR &TEMPO."+CHR(13)+CHR(10)
TEXTO+="USUARIO: " + USUARIO+CHR(13)+CHR(10)
TEXTO+="DATA   : " + DTOC(DATE())+CHR(13)+CHR(10)
TEXTO+="INICIO : " + ENTRADA+CHR(13)+CHR(10)
TEXTO+="TERMINO: " + SAIDA+CHR(13)+CHR(10)
TEXTO+=REPLICATE("=",50)+CHR(13)+CHR(10)
MEMOWRIT("SVC.TXT",TEXTO)

********************************
function RELATORIO
   USE VENDAC
   index on DTOS(DATA) to VENDAC.NTX
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
         @  2,  0 say padR("SVC-SISTEMA DE VENDA DO CIMENTO", 80)
         @  5,  0 say padl("PAGINA: " + SubStr(Str(pagina + 1000000.0, 7), 2), 79)
         pagina := pagina + 1
         @  5,  0 say "VENDAS DO CIMENTO"
         @  6,  0 say "PERIODO DE:" + DToC(filtro1)
         @  6,  0 say padl("Arquivo :"+trim(dbf())+".DBF",79)
         @  7,  0 say "ATE       :" + DToC(filtro2)
         @ 10,  1 say Replicate("*",129)
         @ 11,  1 say "DATA"
         @ 11, 12 say "ESPECIE"
         @ 11, 26 say "NOTA"       
         @ 11, 40 say "DUPLICATA"     
         @ 11, 54 say "RECEBIDO"       
         @ 11, 68 say "T"     
         @ 12,  1 say Replicate("*",129)
         linha := 14
      endif

      @ linha, 01 say DATA
      @ linha, 12 say ESPECIE
      @ linha, 26 say NOTA
      @ linha, 40 say DUPLICATA
      @ linha, 54 say RECEBIDO
      @ linha, 68 say TIPO
      TOTAL1:= TOTAL1 + ESPECIE
      TOTAL2:= TOTAL2 + NOTA
      TOTAL3:= TOTAL3 + DUPLICATA
      TOTAL4:= TOTAL4 + RECEBIDO
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
