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
   MAQUINA := ALLTRIM(NETNAME())
   USUARIO := IIF(EMPTY(USUARIO),"Usuario",USUARIO)
   ENTRADA := TIME()
   LIG     :="Ligado em "+DTOC(date())+" "+time()
   DES     :="Desligado em "+DTOC(date())+" "+time()
   FILTRO1 :=ctod("  /  /    ")
   FILTRO2 :=ctod("  /  /    ")

    IF FILE("CEP.LIG")
       ALERT("SISTEMA JA ESTA EM USO")
       QUIT
    ELSE
       if file("CEP.DES")
           ERASE CEP.DES
           SAVE all like LIG to CEP.LIG
       else
           SAVE all like LIG to CEP.LIG
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
   
   clear screen
   if (!file("CEP.DBF"))
      fcampo:= {}
      AAdd(fcampo, {"CIDADE", "C", 20, 0})
      AAdd(fcampo, {"UF", "C", 2, 0})
      AAdd(fcampo, {"CEP", "C", 10, 0})
      AAdd(fcampo, {"DDD", "C", 4, 0})
      dbcreate("CEP", fcampo)
      USE CEP
      INDEX ON CIDADE+UF+CEP+DDD TO CEP.NTX
   else
      USE CEP
      INDEX ON CIDADE+UF+CEP+DDD TO CEP.NTX
   endif

   private titulo[4]
           titulo[1]:= "CIDADE"
           titulo[2]:= "UF"
           titulo[3]:= "CEP"
           titulo[4]:= "DDD"

   private mascara[4]
           mascara[1]:= "@!"
           mascara[2]:= "@!"
           mascara[3]:= "99.999-999"
           mascara[4]:= "@!"

   private registro[4]
           registro[1]:= "CIDADE"
           registro[2]:= "UF"
           registro[3]:= "CEP"
           registro[4]:= "DDD"

   @ 01,01 SAY PADr("Barreto Material de Construcao",80)          color "w+/n"
   @ 02,01 SAY PADr("(073) 525-2344",80)                          color "R+/N"
   @ 05,01 SAY PADr("C.E.P./Cadastro de Endereco Postal",80)      color "w+*/n"

   SET COLOR TO B+/N,N/W
   @ 06,00 CLEAR TO 21,79
   @ 06,01 say repl("Í",78)      COLOR "B+/N"
   @ 19,00       TO 21,79 double COLOR "B+/N"
   GO TOP
   DBEDIT(07,01,19,78,REGISTRO,"EDITA",MASCARA,TITULO,"ÍÍÍ","   ","ÍÍÍ",.T.)

FUNCTION EDITA(MODO,INDICE)
LOCAL TECLA  

TECLA := LASTKEY()
CAMPO := FIELDNAME(INDICE)

DO CASE
   CASE MODO = 1
        MENSAGEM("Inicio do Arquivo",3)
        MENSAGEM("")
        SET CURSOR OFF
        RETURN(1)

   CASE MODO = 2
        MENSAGEM("Final do Arquivo",3)
        MENSAGEM("")
        SET CURSOR OFF
        RETURN(1)
      
   CASE MODO = 3
        MENSAGEM("Arquivo Vazio")
        SET CURSOR OFF
        RETURN(1)
      
   CASE MODO = 4
        IF TECLA = ESC
           SET COLOR TO W/N
           CLS
           SAIDA = TIME()
           GRAVALOG(ENTRADA,SAIDA)
           ERASE CEP.LIG
           SAVE all like DES to CEP.DES
           LOGOMARCA()
           RETURN (0)

          ELSEIF TECLA = F1
                 AUTOR="(C) Marcos Morais de Sousa - 1995/"+TRAN(YEAR(DATE()),"@E 9999")
                 ALERT(" CRIACAO DE ;"+AUTOR)
                 PACK
                 RETURN(1)

          ELSEIF TECLA = 80 .OR. TECLA = 112
                 SAVE SCREEN TO TELA
                 CONSULTA()
                 RESTORE SCREEN FROM TELA
                 RETURN(1)
          
          ELSEIF TECLA = 69 .OR. TECLA = 101
                 SAVE SCREEN TO TELA
                 SET CURSOR ON
                 SET COLOR TO W+/N
                 CAMPO=FIELDNAME(INDICE)
                 IF TYPE("&CAMPO")="M"
                   MEMOTELA=SAVESCREEN(9,9,21,71)
                   @ 09,09 TO 21,71
                   @ 09,22 SAY "CTRL+W grava e sai <> ESC sai e nÆo grava"
                   REPLACE &CAMPO WITH MEMOEDIT(&CAMPO,10,10,20,70,.T.)
                   RESTSCREEN(9,09,21,71,MEMOTELA)
                   SET CURSOR OFF
                 ELSEIF CAMPO = "CEP" 
                   @ ROW(),COL() GET &CAMPO picture "99.999-999" COLOR "W+/N"
                   READ
                 ELSE
                   @ ROW(),COL() GET &CAMPO COLOR "W+/N"
                   READ
                 ENDIF
                 SET CURSOR OFF
                 SET COLOR TO W/N
                 KEYBOARD CHR(4)
                 RETURN(1)
                 RESTORE SCREEN FROM TELA

          ELSEIF TECLA = 73 .OR. TECLA = 105
                 *SAVE SCREEN TO TELA
                 *if (!isprinter())
                 *   alert("* IMPRESSORA DESLIGADA *")
                 *else
                 *   relatorio()
                 *   SET DEVI TO SCREEN
                 *   SET FILTER TO
                 *endif
                 *RESTORE SCREEN FROM TELA
                 ALERT("OPCAO INDISPONIVEL")
                 RETURN (1)

          ELSEIF TECLA = 076 .OR. TECLA = 108
                 SAVE SCREEN TO TELA
                 APPEND BLANK 
                 @ 07,17 clear to 19,57
                 @ 07,17       to 19,57 DOUBLE  color ("B+/N")
                 @ 08,20 SAY PADC("LANCANDO REGISTROS",35) COLOR "W+*/B"
                 @ 10,20 SAY "CIDADE"          color ("G+/N,W+/R")
                 @ 12, 20 say "ESTADO" color "G+/N"
                 @ 14, 20 say "CEP" color "G+/N"
                 @ 16, 20 say "DDD" color "G+/N"

                 @ 11, 20 get CIDADE picture "@!"
                 @ 13, 20 get UF picture "@!"
                 @ 15, 20 get CEP picture "99.999-999"
                 @ 17, 20 get DDD picture "@!"
                 @ 19, 20 say padc("Existe " + alltrim(Str(LastRec() - 1,4)) + " registros no arquivo", 35) color "w+/n"
                 SET CURSOR ON
                 READ
                 IF LASTKEY()=27
                    DELETE
                    PACK
                 ENDIF
                 RESTORE SCREEN FROM TELA
                 SET CURSOR OFF
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
                    INDEX ON CIDADE+UF+CEP+DDD TO CEP.NTX
                    GO TOP
                 ELSE
                    RESTORE SCREEN FROM TELA
                 ENDIF
          ELSEIF TECLA = DEL
                 ALERT("Para EXCLUIR tecle; [A] de Apagar")
                 RETURN(1)

          ELSEIF TECLA = ENTER
                 CAMPO=FIELDNAME(INDICE)
                 IF TYPE("&CAMPO")="M"
                    SET CURSOR off
                    SET COLOR TO W+/N
                    MEMOTELA=SAVESCREEN(8,9,19,71)
                    @ 08,09 clear TO 19,71 
                    @ 08,09 TO 19,71 DOUBLE
                    @ 09,11 SAY PADC("Observacoes",58)
                    @ 10,11 SAY repl("Ä",58)
                    REPLACE &CAMPO WITH MEMOEDIT(&CAMPO,13,10,18,70,.f.)
                    RESTSCREEN(8,9,19,71,MEMOTELA)
                 ELSE
                    ALERT("PARA EDITAR ESCOLHA [E] DITAR")
                 ENDIF
                 RETURN 1
          ELSE
                 ALERT("OPCAO INVALIDA")
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
          RETURN(1)
      
      ENDCASE

FUNCTION CONSULTA
     DO WHILE .T.
          PSQ=SPACE(20)
          @ 20,01 say "CIDADE A PROCURAR:" COLOR "B+/N"
          @ 20,20 GET PSQ                  COLOR ",RG+/R"
          SET CURSOR ON
          READ
          SET CURSOR OFF
          IF LASTKEY()=27
             EXIT
          ENDIF
          SEEK TRIM(PSQ)
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

********************************
PROCEDURE GRAVALOG(ENTRADA,SAIDA)
TEMPO=ELAPTIME(ENTRADA,SAIDA)
IF FILE("CEP.TXT")
   TEXTO=MEMOREAD("CEP.TXT")
   ELSE
   TEXTO=""
ENDIF
TEXTO+="ESTACAO &MAQUINA. ATIVO POR &TEMPO."+CHR(13)+CHR(10)
TEXTO+="USUARIO: " + USUARIO+CHR(13)+CHR(10)
TEXTO+="DATA   : " + DTOC(DATE())+CHR(13)+CHR(10)
TEXTO+="INICIO : " + ENTRADA+CHR(13)+CHR(10)
TEXTO+="TERMINO: " + SAIDA+CHR(13)+CHR(10)
TEXTO+=REPLICATE("=",50)+CHR(13)+CHR(10)
MEMOWRIT("CEP.TXT",TEXTO)
********************************
function RELATORIO
   use CEP
   INDEX ON CIDADE+UF+CEP+DDD TO CEP.NTX
   FILTRO1 :=ctod("  /  /    ")
   FILTRO2 :=ctod("  /  /    ")
   @  7, 22 to 17, 59 color "R+/N"
   @  8, 23 clear to 16, 58
   @  9, 24 say padc("INFORME O PERIODO", 35) color "W+/R"
   @ 11, 29 say "PERIODO DE :" get FILTRO1
   @ 13, 29 say "ATE        :" get FILTRO2
   SET CURSOR ON
   READ
   SET CURSOR OFF
   IF LASTKEY()=27
      SET DEVI TO SCREEN
      SET FILTER TO
      ALERT("IMPRESSAO ABORTADA")
      RETURN(1)
   ENDIF
   set filter to DATA>=FILTRO1 .AND. DATA<=FILTRO2
   if (!(data >= filtro1 .AND. data <= filtro2))
      skip 
   endif
   set device to printer
   total:= 0
   linha:= 1
   pagina:= 1
   do while (!EOF())
      if (linha == 1)
         @  1,  0 say padc("BARRETO MATERIAL DE CONSTRUCAO", 80)
         @  2,  0 say padc("CEP-SISTEMA DE FATURAMENTO FISCAL", 80)
         @  5,  0 say padl("PAGINA: " + SubStr(Str(pagina + 1000000.0, 7), 2), 79)
         pagina:= pagina + 1
         @  5,  0 say "FATURAMENTO DE CIMENTO"
         @  6,  0 say "PERIODO DE :" + DToC(filtro1)
         @  7,  0 say "ATE        :" + DToC(filtro2)
         @ 10,  1 say Replicate("*", 79)
         @ 11,  1 say "DATA"
         @ 11, 15 say "QUANTIDADE"
         @ 11, 30 say "OBSERVACAO"
         @ 12,  1 say Replicate("*", 79)
         linha := 14
      endif

      @ linha, 01 say data
      @ linha, 15 say qtde

      if (Empty(obs))
         @ linha, 30 say Replicate("_", 49)
      else
         @ linha, 30 say obs
      endif

      total:= total + qtde
      linha:= linha + 1
      skip 
      if (linha >= 55 .OR. EOF())
         if (EOF())
            @ linha + 2,  1 say "TOTAL"
            @ linha + 2, 12 say total
            data("C", 59, 0, 80)
            exit
         else
            @ linha + 2,  1 say "SUBTOTAL"
            @ linha + 2, 12 say total
            data("C", 59, 0, 80)
         endif
         linha:= 1
      endif
   enddo
   SET DEVI TO SCREEN
   return.T.

