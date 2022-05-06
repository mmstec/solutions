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
   MAQUINA := ALLTRIM(NETNAME())
   USUARIO := IIF(EMPTY(USUARIO),"Usuario",USUARIO)
   ENTRADA := TIME()
   LIG     :="Ligado em "+DTOC(date())+" "+time()
   DES     :="Desligado em "+DTOC(date())+" "+time()
   FILTRO1 :=SPACE(18)
   FILTRO2 :=ctod("  /  /    ")
   
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
   if (!file("CARTA.DBF"))
      fcampo:= {}
      AAdd(fcampo, {"DATA", "D", 8, 0})
      AAdd(fcampo, {"NUMERO", "C", 12, 0})
      AAdd(fcampo, {"VALOR", "N", 8, 2})
      AAdd(fcampo, {"VENCI", "D", 8, 0})
      AAdd(fcampo, {"SACADO", "C",20, 0})
      AAdd(fcampo, {"CPFCGC", "C",18, 0})
      AAdd(fcampo, {"ORDEM", "C",18, 0})

      dbcreate("CARTA", fcampo)
      use CARTA
      index on SACADO+DTOS(DATA) to CARTA1.NTX
      index on CPFCGC+DTOS(DATA) to CARTA2.NTX

   else
      use CARTA
      index on SACADO+DTOS(DATA) to CARTA1.NTX
      index on CPFCGC+DTOS(DATA) to CARTA2.NTX
   endif

   private titulo[7]
           titulo[1]:="Data"
           titulo[2]:="N.numero"
           titulo[3]:="Valor"
           titulo[4]:="Vencimento"
           titulo[5]:="Sacado"
           titulo[6]:="CPF CGC"
           titulo[7]:="Ordem"

   private mascara[7]
           mascara[1]:= "@!"
           mascara[2]:= "@!"
           mascara[3]:= "@!"
           mascara[4]:= "@!"
           mascara[5]:= "@!"
           mascara[6]:= "@!"
           mascara[7]:= "@!"

   private registro[7]
           registro[1]:="DATA"
           Registro[2]:="NUMERO"
           Registro[3]:="VALOR"
           Registro[4]:="VENCI"
           Registro[5]:="SACADO"
           Registro[6]:="CPFCGC"
           Registro[7]:="ORDEM"

   @ 01,01 SAY PADr("Barreto Material de Construcao",80)          color "w+/n"
   @ 03,01 SAY PADr("(073) 525-2344",80)                          color "R+/N"
   @ 05,01 SAY PADr("Emissao/relacao de cartas",80)  color "w+*/n"

   SET COLOR TO B+/N,N/W
   @ 06,00 CLEAR TO 21,79
   @ 06,01 say repl("Í",78)      COLOR "B+/N"
   @ 19,00       TO 21,79 double COLOR "B+/N"
   SET INDEX TO CARTA1
   GO TOP
   DBEDIT(07,01,19,78,REGISTRO,"EDITA",MASCARA,TITULO,"ÍÍÍ","   ","ÍÍÍ",.T.)

FUNCTION EDITA(MODO,INDICE)
LOCAL TECLA  
TECLA := LASTKEY()
CAMPO := REGISTRO[INDICE]
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
                 SAVE SCREEN TO TELA
                 if (!isprinter())
                    alert("* IMPRESSORA DESLIGADA *")
                 else
                    relatorio()
                    SET DEVI TO SCREEN
                    SET FILTER TO
                 endif

                 RESTORE SCREEN FROM TELA
                 RETURN (1)

          ELSEIF TECLA = 076 .OR. TECLA = 108
                 SAVE SCREEN TO TELA
                 APPEND BLANK 
                 VMEMO=SPACE(20)
                 vDATA=DATE()
                 @ 04,17 clear to 22,57
                 @ 04,17       to 22,57 DOUBLE  color ("Bg+/N")
                 @ 05, 20 SAY PADC("LANCANDO REGISTROS",35) COLOR "W+*/Bg"
                 @ 07, 20 SAY "DATA"           color ("G+/N,W+/R")
                 @ 09, 20 say "N. numero"      color "G+/N"
                 @ 11, 20 say "Valor"          color "G+/N"
                 @ 13, 20 say "Vecimento"      color "G+/N"
                 @ 15, 20 say "Sacado"         color "G+/N"
                 @ 17, 20 say "CPF ou CGC"     color "G+/N"
                 @ 19, 20 say "Ordem"          color "G+/N"

                 @ 08, 20 get vDATA   PICT "@!"
                 @ 10, 20 get NUMERO  PICT "@!"
                 @ 12, 20 get VALOR   PICT "@!"
                 @ 14, 20 get VENCI   PICT "@!"
                 @ 16, 20 get SACADO  PICT "@!"
                 @ 18, 20 get CPFCGC  PICT "@!"
                 @ 20, 20 get ORDEM   PICT "@!"
                 SET CURSOR ON
                 READ
                 REPLACE DATA WITH VDATA
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
                    INDEX ON DTOS(DATA) TO COMISSAO
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
     SET INDEX TO CARTA1
     DO WHILE .T.
          PSQ=SPACE(30)
          @ 20,01 say "SACADO A PROCURAR:" COLOR "B+/N"
          @ 20,18 GET PSQ               COLOR ",RG+/R"
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
IF FILE("CARTA.TXT")
   TEXTO=MEMOREAD("CARTA.TXT")
   ELSE
   TEXTO=""
ENDIF
TEXTO+="ESTACAO &MAQUINA. ATIVO POR &TEMPO."+CHR(13)+CHR(10)
TEXTO+="USUARIO: " + USUARIO+CHR(13)+CHR(10)
TEXTO+="DATA   : " + DTOC(DATE())+CHR(13)+CHR(10)
TEXTO+="INICIO : " + ENTRADA+CHR(13)+CHR(10)
TEXTO+="TERMINO: " + SAIDA+CHR(13)+CHR(10)
TEXTO+=REPLICATE("=",50)+CHR(13)+CHR(10)
MEMOWRIT("CARTA.TXT",TEXTO)
********************************
function RELATORIO
   use carta
   set index to carta2
   FILTRO1 :=SPACE(18)
   FILTRO2 :=ctod("  /  /    ")
   @  7, 23 clear to 17, 63
   @  7, 23       to 17, 63 DOUBLE color "W+/N"
   @  9, 25 say padc("INFORME OS DADOS", 36) 
   @ 11, 25 say "CPF ou CGC     :" get FILTRO1 
   @ 13, 25 say "Data do Pedido :" get FILTRO2      
   @ 15, 25 say "Atencao: Nao pode haver erro de DIGITO"
   SET CURSOR ON
   READ
   @ 18, 25 SAY PADC("Aguarde o final da impressao...",36) color "w+*/n"
   SET CURSOR OFF
   IF LASTKEY()=27
      SET DEVI TO SCREEN
      SET FILTER TO
      ALERT("IMPRESSAO ABORTADA")
      RETURN(1)
   ENDIF
   set filter to CPFCGC=FILTRO1 .AND. DATA=FILTRO2
   if (!(CPFCGC = filtro1 .AND. data = filtro2)) 
      skip 
   endif
   set device to printer
   total:= 0
   linha:= 1
   pagina:= 1
   do while (!EOF())
      if (linha == 1)
         @  1,  0 say padR("BARRETO MATERIAL DE CONSTRUCAO", 80)
         @  1,  0 say padL("Pagina: " + SubStr(Str(pagina + 1000000.0, 7), 2), 79)
         pagina:= pagina + 1

         @  2,  0 say padr("CGC 34.196.147/0001-10 - IE 28.956.505-NO", 80)
         @  5,  0 say padR("Data  : " + dtoc(date())+" "+time(), 79)
         @ 15,  1 say "A Caixa Economica Federal S/A"
         @ 20,  1 say "Solicitamos o cumprimento da(s) ordem(ns) abaixo:"
         @ 22,  1 say padr("Ordem",10)+"   "+padr("N. Numero",12)+"   "+;
                        padl("Valor (R$)",10)+"   "+padr("Sacado",12)+"   "+;
                        padr("CPF ou CGC",18)

         @ 23,  1 say Replicate("-", 79)
         linha := 24
      endif

         @ linha,  1 say padr(Ordem,10)+" | "+padr(Numero,12)+" | "+;
                         padl(str(valor,8,2),10)+" | "+padr(Sacado,12)+" | "+;
                         padr(CPFCGC,18)

      total:= total + valor
      linha:= linha + 1
      skip 
      if (linha >= 40 .OR. EOF())
         if (EOF())
            @ linha + 0,  1 say Replicate("-", 79)
            @ linha + 2,  1 say "TOTAL"
            @ linha + 2, 26 say total
            @ linha + 5, 0  say "Atenciosamente;"
            @ linha + 10, 0  say "________________________________"
            @ linha + 11, 0  say "MFB Material de Construcao Ltda"
            @ linha + 12, 0  say "Setor de Crediario"
            EJECT
            EXIT
         else
            @ linha + 0,  1 say Replicate("-", 79)
            @ linha + 2,  1 say "SUBTOTAL"
            @ linha + 2, 26 say total
         endif
         linha:= 1
      endif
   enddo
   SET DEVI TO SCREEN
   return.T.

