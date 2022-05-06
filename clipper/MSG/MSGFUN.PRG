****************************************************************************
* INICIO DE FUNCAO INFORMA
*
FUNCTION INFORMA
PARA L,C,T
*
SETCOLOR("G+/N,W+/B")
* /////////////////////////////////////////////////////////////////////////////////////////////////////// *
     Public DIA
     AUTOR     :="(C) Marcos Morais de Sousa - 1995/"+TRAN(YEAR(DATE()),"@E 9999")
     MMSTEC    :="MMStec Artes Gr ficas & Inform tica Ltda"
     EMPRESA   :="MFB Material de Constru‡„O Ltda"
     CONTADOR  :=0
     HOJE      :=DATE()
     SEMANA    :="Domingo      Segunda-feiraTerca-feira  Quarta-feira Quinta-feira Sexta-feira  S bado       "
     DIA       :=TRIM(SUBS(SEMANA,DOW(HOJE)*13-12,13))+", "+ALLTRIM(STR(DAY(HOJE),2))
     MES       :="janeiro  fevereiromar‡o    abril    maio     junho    "
     MES       :=MES+"julho    agosto   setembro outubro  novembro dezembro "
     DIA       :=DIA+" de "+TRIM(SUBS(MES,MONTH(HOJE)*9-8,9))+" de "
     DIA       :=DIA+TRAN(YEAR(HOJE),"@E 9999")
     @ L-1,C SAY PADC(DIA,T)
* /////////////////////////////////////////////////////////////////////////////////////////////////////// *
DO CASE
     CASE VAL(LEFT(TIME(),2)) = 07
          @ L+1,C SAY PADC(LEFT(TIME(),5)+"  Bom dia "+RTRIM(USUARIO)+"! Expediente Inicializado! ",T)               COLOR("RG+/N")
     CASE VAL(LEFT(TIME(),2)) = 12
          @ L+1,C SAY PADC(LEFT(TIME(),5)+"  Boa tarde "+RTRIM(USUARIO)+"! Expediente finalizado! ",T)               COLOR("RG+/N")
     CASE VAL(LEFT(TIME(),2)) = 10 .OR. VAL(LEFT(TIME(),2)) = 15
          @ L+1,C SAY PADC(LEFT(TIME(),5)+"  Hora do lanche "+RTRIM(USUARIO)+"! Expediente interrompido! ",T)        COLOR("RG+/N")
     CASE VAL(LEFT(TIME(),2)) = 18
          @ L+1,C SAY PADC(LEFT(TIME(),5)+"  BOA NOITE "+RTRIM(USUARIO)+"! EXPEDIENTE ENCERRADO! ",T)                COLOR("RG+/N")
*OTHERWISE
*          @ L+1,C SAY PADC(LEFT(TIME(),5)+"  Arrependei-vos, e crede no Evangelho. Marcos 1:15",T)                COLOR("RG+/N")
ENDCASE
DO CASE     
     CASE DATE() =  CTOD("01/01"+STR(YEAR(DATE())))
          @ L,C SAY PADC("ANO NOVO - Dia internacional da Confraterniza‡„o",T)                          
     CASE DATE() =  CTOD("11/02"+STR(YEAR(DATE())))
          @ L,C SAY PADC("Comemora‡„o do Carnaval",T)        
     CASE DATE() =  CTOD("12/02"+STR(YEAR(DATE())))
          @ L,C SAY PADC("Quarta feira de Cinzas",T)                         
     CASE DATE() =  CTOD("20/03"+STR(YEAR(DATE())))
          @ L,C SAY PADC("Inicio do Outono",T)                         
     CASE DATE() =  CTOD("28/03"+STR(YEAR(DATE())))
          @ L,C SAY PADC("Sexta feira da PAIXAO",T)        
     CASE DATE() =  CTOD("30/03"+STR(YEAR(DATE())))
          @ L,C SAY PADC("Comemora‡„o da Pascoa",T)        
     CASE DATE() =  CTOD("01/04"+STR(YEAR(DATE())))
          @ L,C SAY PADC("1§ de abril - DIA DA MENTIRA",T) 
     CASE DATE() =  CTOD("02/04"+STR(YEAR(DATE())))
          @ L,C SAY PADC("Dia Internacional do livro infantil",T)        
     CASE DATE() =  CTOD("07/04"+STR(YEAR(DATE())))
          @ L,C SAY PADC("Dia do m‚dico legista",T)        
     CASE DATE() =  CTOD("08/04"+STR(YEAR(DATE())))
          @ L,C SAY PADC("Dia do desbravador",T)        
     CASE DATE() =  CTOD("21/04"+STR(YEAR(DATE())))
          @ L,C SAY PADC("Dia de Tiradentes",T)        
     CASE DATE() =  CTOD("01/05"+STR(YEAR(DATE())))
          @ L,C SAY PADC("Dia do Trabalho",T)        
     CASE DATE() =  CTOD("29/05"+STR(YEAR(DATE())))
          @ L,C SAY PADC("CORPUS CRISTI",T)        
     CASE DATE() =  CTOD("12/06"+STR(YEAR(DATE())))
          @ L,C SAY PADC("Dia dos Namorados",T)        
     CASE DATE() =  CTOD("21/06"+STR(YEAR(DATE())))
          @ L,C SAY PADC("Inicio do Inverno",T)        
     CASE DATE() =  CTOD("10/07"+STR(YEAR(DATE())))
          @ L,C SAY PADC("MMS",T)        
     CASE DATE() =  CTOD("07/09"+STR(YEAR(DATE())))
          @ L,C SAY PADC("Comemora‡„o da Independencia do Brasil",T)        
     CASE DATE() =  CTOD("22/09"+STR(YEAR(DATE())))
          @ L,C SAY PADC("Inicio da Primavera",T)        
     CASE DATE() =  CTOD("12/10"+STR(YEAR(DATE())))
          @ L,C SAY PADC("Dia da Padroeira do Brasil - N.S. APARECIDA",T)        
     CASE DATE() =  CTOD("02/11"+STR(YEAR(DATE())))
          @ L,C SAY PADC("Dia de Finados",T)        
     CASE DATE() =  CTOD("15/11"+STR(YEAR(DATE())))
          @ L,C SAY PADC("Comemora‡„o da Proclama‡„o da Republica do Brasil",T)        
     CASE DATE() =  CTOD("19/11"+STR(YEAR(DATE())))
          @ L,C SAY PADC("Dia da Bandeira",T)        
     CASE DATE() =  CTOD("21/12"+STR(YEAR(DATE())))
          @ L,C SAY PADC("Inicio do verao",T)                  
     CASE DATE() =  CTOD("25/12"+STR(YEAR(DATE())))
          @ L,C SAY PADC("Comemora‡„o do NATAL - Nascimento de Jesus Cristo",T)           
OTHERWISE
          @ L,C SAY PADC(AUTOR,T)           
ENDCASE
*
*
* FINAL DE FUNCAO INFORMA
* ***************************************************************************

* ***************************************************************************
* INICIO DA FUNCAO RECADOS
*
FUNCTION RECADOS
Public usuario
SETCOLOR("G+/N,W+/B")
USUARIO   :=SPACE(8)
TITULO    :="MMS - Correio eletronico"
INFORMA(02,00,80)
@ 05,10 SAY "POR FAVOR, SEU NOME:"  GET USUARIO PICT "@!" VALID .NOT.EMPTY(USUARIO)
READ
SETCOLOR("W+/N") 
IF .NOT. FILE ("\MFB\MSG\RECADOS\RECADOS.TXT")
    CLS
    ?"ARQUIVO RECADOS.TXT NAO ENCONTRADO"
    INKEY(1)
ELSE
TEXTO=MEMOREAD("\MFB\MSG\RECADOS\RECADOS.TXT")
     CLS
     @ 02,01       TO xL-2,79 COLOR ("G+/G")
     @ 00,02 SAY PADC(TITULO,74) COLOR ("RG+/N")
     INFORMA(05,03,76)
     SETCOLOR("W+/N")
     @ xL,02 say " [F2] grava e sai "
     @ xL,35 say " [esc] abadona "
     @ xL,65 say " [F5] Imprime "
     
     MEMOEDIT(TEXTO,10,03,39,74,.F.)
ENDIF          
     
     IF FILE("\MFB\MSG\RECADOS\"+RTRIM(USUARIO)+".TXT")   
          TEXTO=MEMOREAD("\MFB\MSG\RECADOS\"+RTRIM(USUARIO)+".TXT")   
          CLS
          @ 02,01       TO xL-2,79 COLOR ("G+/G")
          @ 00,02 SAY PADC(TITULO,74)
          INFORMA(05,03,76)
          SETCOLOR("W+/n")
          @ xL,02 say " [F2] grava e sai "
          @ xL,35 say " [esc] abadona "
          @ xL,65 say " [F5] Imprime "
               
          MEMOEDIT(TEXTO,10,03,39,74,.F.)
     ELSE
          CLS
          INFORMA(05,03,76)
          @ 07,00 SAY PADC("Sinto muito "+RTRIM(USUARIO)+" mas n„o h  recados para voce",80) COLOR ("W+/N")
          * RUN NET SEND * "Hoje ‚ &DIA" * 
          SetMode(25,80) 
          QUIT
     
     ENDIF
     RETURN
*
* FINAL DA FUNCAO RECADOS
* ***************************************************************************
