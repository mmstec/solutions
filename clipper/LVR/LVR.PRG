*////////////////////////////////////////////////////////////////////////////
*
* TITULO     : MFB - folha de pagamento
* Data       : 19/05/1997
* Programa   : Lvr.prg
* Proposta   : Lista precos e produtos
* 
* ////////////////////////////////////////////////////////////////////////////
*

SET EXCLUSIV OFF
SET DELETE ON

If .not. file("EMPRESA.DAT")
    
    EMPRESA   := Space(40)
    CLS
    @ 01,00 SAY "(C) Marcos Morais de Sousa - 1995/"+TRAN(YEAR(DATE()),"@E 9999")
    DATA(1,03,00,40)
    @ 07,00 say "Nome da Empresa Usu ria :"
    @ 08,00 Get EMPRESA PICT "@!" 
    READ
    SAVE TO EMPRESA.DAT
Else
    RESTORE FROM EMPRESA.DAT
EndIf
     
     x := FastPCX("LVR.LOG")
     do case
          case x = 0          && Displayed OK.
               * - Agora no modo Gr fico, pressione uma tecla e retorne ao Sistema Operacional.
               inkey(03)
               txtMode()
               restore screen
          case x = 1
               ? 'Arquivo n„o encontrado.'
          case x = 2
               ? 'File Not found.'
          case x = 3
               ? 'Arquivo n„o suportou o formato PCX e/ou n„o ‚ verdadeiramente um Arquivo PCX.'
     endcase

Autor       :="(C) Marcos Morais de Sousa - 1995/"+TRAN(YEAR(DATE()),"@E 9999")
MMStec      :="MMStec Artes Gr ficas & Inform tica Ltda"
Titulo      :="Lista de Precos e Produtos" 
Versao      :="Vers„o 1.0"

   PUBLIC MODOTELA,xL
   
   IF SETMODE(50,80) 
      MODOTELA  = "5080"
      MSGTELA   = "Tela: 50x80" 

      xL:=49
      ?"Tela alterada para 50x80"
   
   ELSEIF SETMODE(43,80) 
      MODOTELA = "4380"
      xL:=42
      MSGTELA   = "Tela: 43x80" 

      ?"Tela alterada para 43x80"
   
   ELSE
      MODOTELA = "2580"
      MSGTELA  = "Tela: 25x80" 
      xL:=24
      
      ?"Tela alterada para 25x80"
   endif
   
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

   SET DATE FORMAT TO "dd,mm,yyyy"
   SET EPOCH TO 0100
   SET SCOR OFF
   SET DATE BRIT
   SET DELETE ON
   SET WRAP ON
   
   * SetColor(normal,realcado(get),fundo,borda,get nao atual)
   SET COLOR TO BG+/N,G+/N
   
   SET KEY F2  TO BACKUP()
   SET KEY F3  TO REIDEXAR
   SET INTENSITY ON
   Setcursor(2)
   
   ErrorNew()

CLS
@ 00,00                 SAY PADR(AUTOR,LEN(AUTOR))     COLOR ("W +/N")
@ 00,(80-LEN(Rtrim(EMPRESA)))  SAY PADL(Rtrim(EMPRESA),LEN(Rtrim(EMPRESA))) COLOR ("G +/N")
@ 02,(80-LEN(TITULO))   SAY PADL(TITULO,LEN(TITULO))   COLOR ("W +/N")

   OPERADOR   :=SPACE(20)
   @ 03,01 SAY "Seu nome " GET OPERADOR PICT "@!" VALID VRFOPERADOR()
   READ
   
   SET COLOR TO BG+/N,W/R
   
   @ 03,01 SAY Space(40)
   
   PUBLIC OPERADOR
   IF .NOT.EMPTY(OPERADOR) .AND. LASTKEY()<>5
     OPERADOR  :=  OPERADOR
   ELSE
     OPERADOR  := "Operador"
   ENDIF
     DIGITADOR :=  OPERADOR

   PUBLIC ARQUIVO
   
   ARQUIVO   := "PRODUTOS"
   
   If .Not. FILE(ARQUIVO+".DBF")

     LvrCampos    :={}
                       
     AADD( LvrCAMPOS,{"REFERENCIA","C", 15,  0} )   
     AADD( LvrCAMPOS,{"DESCRICAOO","C", 35,  0} )   
     AADD( LvrCAMPOS,{"MARCAAAAAA","C", 10,  0} )   
     AADD( LvrCAMPOS,{"PRECOAVIST","N", 10,  2} )   
     AADD( LvrCAMPOS,{"UNIDADEDEE","C", 02,  0} )
     
     DBCREATE(ARQUIVO,LvrCampos)
     
   EndIf
   
   
   PRIVATE TituloS[5] 
   
   * -> TituloS das colunas
   
   TituloS[1] = "Referˆncia"
   TituloS[2] = "Descri‡„o/Produto"
   TituloS[3] = "Fabricante"
   TituloS[4] = "R$   Valor"
   TituloS[5] = "UN"
   
   PRIVATE MascaraS[5]  
   
   * -> Mascaras das colunas
                  
   MASCARAS[1] = "@!"
   MASCARAS[2] = "@!"
   MASCARAS[3] = "@!"
   MASCARAS[4] = "@E 999,999.99"
   MASCARAS[5] = "@!"
   
   
   DECLARE ConteudoS[5] 
   
   *-> Conteudo das colunas
   
   CONTEUDOS[1] = "REFERENCIA"
   CONTEUDOS[2] = "DESCRICAOO"
   CONTEUDOS[3] = "MARCAAAAAA"
   CONTEUDOS[4] = "PRECOAVIST"
   CONTEUDOS[5] = "UNIDADEDEE"
   
   INDICES(.t.)

   *-> prepara tela
   
   SETBLINK(.F.)
   
   SETCOLOR("W+/N*")
                         
   MOUDURA =  ( CHR(219) + CHR(196) + CHR(183) + CHR(186) + ;
                  CHR(189) + CHR(196) + CHR(211) + CHR(186) )
   
   @ 06,00 CLEAR TO xL-9,79 ; @ 06,00,xL-9,79 BOX(MOUDURA)
   
   @ 06,00 SAY PADC(STRZERO(RecCount(),03)+" "+DBF(),80)         Color("R+/W*")
   
   @ 06,03 SAY Cdow(DATE())+" "+OS()  Color("R+/W*")
   
   @ xl- 11,03 say "[F1] AJUDA EXPRESSA" COLOR ("G+/N*")
   @ xl- 11,35 SAY "[F2] BACK-UP"        COLOR ("G+/N*")
   @ xl- 11,65 SAY "[F4] CONSULTA"       COLOR ("G+/N*")
   
   
   * // Dbedit( Linha    inicial   , 1
   *            Coluna   inicial   , 2
   *            Linha    final     , 3
   *            Coluna   final     , 4
   *            Colunas            , 5
   *            Funcao de controle , 6
   *            Mascaras p/ coluna , 7
   *            Cabe‡alho          , 8
   *            Cab p/Separadores  , 9
   *            Separadores/coluna , 10
   *            Separadores/rodape , 11
   *            Colunas p/ rodape  , 12
   *
   * // 1  2  3  4     5        6       7        8      9  10 1112

Go Top



DBedit(08,01,xl-13,78,ConteudoS,"EditA",MascaraS,TituloS,"ÄÂÄ"," | ","ÄÁÄ",.T.)

FUNCTION EDITA(MODO,INDICE)

LOCAL TECLA  

SET COLOR TO G+/N
   
   Inicio := " INICIO DO ARQUIVO "
   Final  := " FINAL DO ARQUIVO  "
   Vazio  := " ARQUIVO VAZIO     "
   DeLING := " deletando...      "
   DeLLED := " deletado          "
   Tecla  := LASTKEY()
   Campo  := ConteudoS[INDICE]


DO CASE
      
      CASE MODO = 1
          
          Mensagem(inicio,5)
          
          RETURN 1
      
      
      CASE MODO = 2
          
          Mensagem(final,5)
          
          RETURN 1
      
      
      CASE MODO = 3
          
          Mensagem(vazio,5)
          
          RETURN 1
      
      
      CASE MODO = 4
          
          IF   TECLA     = ESC
               
               backup()
               
               CLS
               
               LOGOMARCA();SETBLINK(.t.)
               
               RETURN 0

          
          ELSEIF TECLA = F4
               
               Consulta()     
               
               return 1
          
          
          ELSEIF TECLA   = ENTER
          
          IF OPERADOR <> "MARCOS"
                  TONE(550,2)
                  
                  Mensagem("A‡„o solicitada n„o lhe ‚ permitida!",5)
               return 1
           
           ENDIF
               
                    save screen to alteraregistro
               
                    SETCOLOR(",G+/N")
                    
                    @ row(),col() GET &CAMPO PICT "@!" VALID VRFCAMPO() 
               
                    Mensagem("Alterando registro")   
               
                    
                    SET CURSOR ON
               
               READ
               
                    restore screen from alteraregistro
               
                    SET CURSOR OFF
               
                    * INDICES(.T.)
                    
                    SETCOLOR("BG+/N,W/R")
               
               RETURN (2)
          
          ELSEIF TECLA   = INSERT
               
               IF OPERADOR <> "MARCOS"
                  TONE(550,2)
                  Mensagem("A‡„o solicitada n„o lhe ‚ permitida!",5)
                  RETURN 1
               ENDIF
               
               save screen to inserecampo
               APPEND BLANK 
               TONE(290)
               @ 11,17 clear to 28,58
               @ 11,17       to 28,58   color ("B+/N")
               @ 13,20 SAY "Referencia" color ("G+/N")
               @ 16,20 SAY "Descricao"  color ("G+/N")
               @ 19,20 SAY "Fabricante" color ("G+/N")
               @ 22,20 SAY "RS  Pre‡o"   color ("G+/N")
               @ 25,20 SAY "UN"         color ("G+/N")
               
               @ 14,20 GET Referencia pict "@!"         Valid .Not. Empty(Referencia)
               @ 17,20 GET Descricaoo pict "@!"         Valid .Not. Empty(Descricaoo)
               @ 20,20 GET Marcaaaaaa pict "@!"         
               @ 23,20 GET PrecoAVist pict "@E 99,999,999.99"  
               @ 26,20 GET Unidadedee pict "@!"                
               
               Mensagem("Incluindo registro")
               
               SET CURSOR ON
               READ
               restore screen from inserecampo
               SET CURSOR OFF
               INDICES(.T.)
               GO TOP
               RETURN 2

          ELSEIF TECLA   = F5
               
               IF OPERADOR <> "MARCOS"
                  TONE(550,2)
                  
                  Mensagem("A‡„o solicitada n„o lhe ‚ permitida!",5)
                  
                  RETURN 1
               ENDIF
               
               TONE(290)
               RELATORIO()
          RETURN 2
          
          ELSEIF TECLA   = F8
          
              DESCANSO()
          
          ELSEIF TECLA   = DEL
               
          IF OPERADOR <> "MARCOS"
                  TONE(550,2)
                  
                  Mensagem("A‡„o solicitada n„o lhe ‚ permitida!",5)
               
           ENDIF
          
          Save screen to DELETAcampo
          RESPOSTA ="S"
                
                SETCOLOR(",RG+/N")
                
                @ xl-7,000 say "Elimina registro corrente ? ( S )im - ( N )„o " get resposta PICT "@!"
                  READ
                  IF RESPOSTA = "S"
                     DELETE  // Marca   registro corrente 
                     Mensagem("Registro sendo eliminado")
                     * PACK    // Elimina registro corrente
                     TONE(290)
                     Mensagem("Registro marcado para ser eliminado")
                 EndIf
          restore screen from DELETAcampo
          
          SETCOLOR("BG+/N,G+/N")
          
          INDICES(.T.)
          
          GO TOP
          
          ELSEIF LASTKEY() = 1
          
                 GOTO TOP
          
          ELSEIF LASTKEY() = 6
          
                 GOTO BOTT
          
          EndIf

      OtherWise
          
          Mensagem("Tecle [ESC] para SAIDA")
                       
          @ 04,60 SAY "Respons vel Cadastro" color("BG+/N")
          @ 06,60 SAY PADL(RTRIM(DIGITADOR),20) PICT "@!" color("R+/W+*")
          
          @ xl-7,62 say "Pre‡o p/ varejo" color("W+/N")
          @ xl-5,62 say REPL("Ü",15)      color("G/N")
          @ xl-3,62 say PRECOAVIST   PICT "@E R$ 9,999,999.99" Color("G+/N")
          
          @ xl-7,78 say "UN"                   color("W+/N")
          @ xl-5,78 say REPL("Ü",02)           color("G/N")
          @ xl-3,78 say UNIDADEDEE   PICT "@!" Color("G+/N")
          
          Return 1 
      
      EndCase

FUNCTION DATA(M,L,C,T)
HOJE      :=DATE()
SEMANA    :="Domingo      Segunda-feiraTerca-feira  Quarta-feira Quinta-feira Sexta-feira  S bado       "
DIA       :=TRIM(SUBS(SEMANA,DOW(HOJE)*13-12,13))+", "+ALLTRIM(STR(DAY(HOJE),2))
MES       :="janeiro  fevereiromar‡o    abril    maio     junho    "
MES       :=MES+"julho    agosto   setembro outubro  novembro dezembro "
DIA       :=DIA+" de "+TRIM(SUBS(MES,MONTH(HOJE)*9-8,9))+" de "
DIA       :=DIA+TRAN(YEAR(HOJE),"@E 9999")
  IF      M = 1
          @ L,C SAY PADR(DIA,T)
  ELSEIF  M = 2
          @ L,C SAY PADC(DIA,T)
  ELSEIF  M = 3
          @ L,C SAY PADL(DIA,T)
  ENDIF

RETURN.T.

                      
FUNCTION RELATORIO                         
INDICES(.T.)     
printing=chr(16)+" Impress„o em andamento "+chr(17)
printed =chr(16)+" Impress„o FINALIZADA   "+chr(17)
printoff=chr(16)+" Impressora DESLIGADA "+chr(17)
GO TOP

QtdeReg   := RecCount() // conta numero de registros
Pagina    :=1
Linha     :=0
Loop      :=1
N         :=1



IF .NOT. ISPRINTER()
   @ xL,(80-LEN(PRINTOFF))/2 SAY SPACE(LEN(PRINTOFF))
   @ xL,(80-LEN(PRINTOFF))/2 SAY PADC(PRINTOFF,LEN(PRINTOFF))
   inkey(0) 
   @ xL-20,(80-LEN(PRINTOFF))/2 SAY SPACE(LEN(PRINTOFF))
   RETURN.T.
ENDIF

@ 00,00 SAY CHR(18)  &&Determina o tipo de letra para impressao

DO WHILE .NOT. EOF() 
     
     SET DEVI TO SCREEN                        
          @ xL,(80-LEN(PRINTING))/2 SAY SPACE(LEN(PRINTING))
          @ xL,(80-LEN(PRINTING))/2 SAY PADC(PRINTING,LEN(PRINTING))
     SET DEVI TO PRINT
     
     
     IF LINHA = 60 .OR. LINHA = 0
     
          DATA(1,00,01,78);DATA(1,00,01,78);DATA(1,00,01,78)
          @ 00,(80-LEN(Rtrim(EMPRESA)))  SAY PADL(Rtrim(EMPRESA),LEN(Rtrim(EMPRESA))) 
          @ 01,00 SAY chr(16)+" "+rtrim(operador)+" "+chr(17)
          @ 01,00 SAY PADL(TITULO,80)                          
          @ 02,00                 SAY PADC("LIVRO DE PRECOS EXPRESSO",80)
          @ 02,00                 SAY PADC("LIVRO DE PRECOS EXPRESSO",80)
          @ 02,00 SAY PADR(" Arquivo "+RTRIM(ARQUIVO)+".DBF",30)
          @ 04,01                 SAY REPL("*",79)
           
          @ 05,01 SAY STRZERO(QTDEREG,3)+" Referencia"
          @ 05,21 SAY "Descriacao / Produto"
          @ 05,58 SAY "Fabricante"
          @ 05,66 SAY "Preco UNITARIO"
          @ 06,01 SAY REPL("*",79)                  
          
          LINHA= 8                                  
                                                    
     ENDIF
          
          @ LINHA,01 SAY STRZERO(N,3)+" "+RTRIM(REFERENCIA)+REPL(".",15-LEN(RTRIM(REFERENCIA)))+">" PICT "@!"
          @ LINHA,21 SAY RTRIM(DESCRICAOO)+REPL(".",35-LEN(RTRIM(DESCRICAOO)))+">" PICT "@!"
          @ LINHA,58 SAY MARCAAAAAA PICT "@!"
          @ LINHA,67 SAY PRECOAVIST PICT "@E 99,999,999.99"
          
          SKIP
          
          SET DEVI TO SCREEN                        
              @ xL-05,57 SAY "Registro     "+str(N,10)
          SET DEVI TO PRINT
          
          N         = N        + 1
          LINHA     = LINHA    + 1
      
      
      
      IF M->LINHA>56 .OR. EOF()
         IF EOF()
               TOTAL(2)
         ELSE
               TOTAL(1)
         ENDIF
         LINHA=1
      ENDIF
ENDDO

SET DEVI TO SCREEN
EJECT
@ xL,(80-LEN(PRINTING))/2 SAY SPACE(LEN(PRINTING))
@ xL,(80-LEN(PRINTED)) /2 SAY PADC(PRINTED,LEN(PRINTED))
INKEY(3)
@ xL-05,55 SAY Space(25)
@ xL-05,(80-LEN(PRINTED))/2 SAY SPACE(LEN(PRINTED))
TONE(290)
RETURN.T.

FUNCTION TOTAL
PARA PAR1
IF PAR1=2
   LINHA=57
ENDIF
   * @ LINHA+0,01 SAY REPL("*", 79)
IF PAR1=2
   * @ LINHA+1,001 SAY "FINAL DE TELEFONES DISPONIVEIS"
ELSE
   * @ LINHA+1,001 SAY "Continuando..."
ENDIF

@ LINHA+02,001 SAY REPL("_", 79)
@ LINHA+04,(80-LEN(AUTOR))/2  SAY PADC(AUTOR,LEN(AUTOR))    
@ LINHA+04,068 SAY "PAGINA: "+SUBS(STR(PAGINA+10000,5),2)
SET DEVI TO SCREEN                        
  @ xL,060 SAY padL("P gina   : "+SUBS(STR(PAGINA+10000,5),2),20)
SET DEVI TO PRINT
PAGINA=PAGINA+1
RETURN.T.
      
      
* ///////////////////////////////////////////////////////////////////////////*
* -> Inicio da funcao LOGOMARCA 
*
FUNCTION LOGOMARCA
*
X    :=03;Y =X-1;LA=03;A=0
LB   :=LA+1;LC=LB+1;LD=LC+1;LE=LD+1;LF=LE+1
LG   :=LF+1;LH=LG+1;LI=LH+1;LJ=LI+1;LL=LJ+1
AUTOR:="(C) Marcos Morais de Sousa - 1995/"+TRAN(YEAR(DATE()),"@E 9999")
LINHA:=REPL("Ä",80)

CLS
SETCOLOR("G+/N")
@ LA,X say "ÛÛÛÛ     ÛÛÛÛ ÛÛÛÛ     ÛÛÛÛ ÜÛÛÛÛÛÛÛÛÛÜ ÛÛÛÛÛÛÛÛÛÛÛÛ ÛÛÛÛÛÛÛÛÛÛ ÛÛÛÛÛÛÛÛÛÛ"
@ LB,X say "ÛÛÛÛÛ   ÛÛÛÛÛ ÛÛÛÛÛ   ÛÛÛÛÛ ÛÛÛÛÛÛÛÛÛÛÛ ÛÛÛÛÛÛÛÛÛÛÛÛ ÛÛÛÛÛÛÛÛÛÛ ÛÛÛÛÛÛÛÛÛÛ"
@ LC,X say "ÛÛÛÛÛÛ ÛÛÛÛÛÛ ÛÛÛÛÛÛ ÛÛÛÛÛÛ ÛÛÛÛ   ÛÛÛÛ     ÛÛÛÛ     ÛÛÛÛ       ÛÛÛÛ"
@ LD,X say "ÛÛÛÛÛÛÛÛÛÛÛÛÛ ÛÛÛÛÛÛÛÛÛÛÛÛÛ ÛÛÛÛ            ÛÛÛÛ     ÛÛÛÛ       ÛÛÛÛ"
@ LE,X say "ÛÛÛÛÛÛÛÛÛÛÛÛÛ ÛÛÛÛÛÛÛÛÛÛÛÛÛ ÛÛÛÛÛÛÛÛÛÛÜ     ÛÛÛÛ     ÛÛÛÛÛÛÛÛ   ÛÛÛÛ"
@ LF,X say "ÛÛÛÛ ÛÛÛ ÛÛÛÛ ÛÛÛÛ ÛÛÛ ÛÛÛÛ ßÛÛÛÛÛÛÛÛÛÛ     ÛÛÛÛ     ÛÛÛÛÛÛÛÛ   ÛÛÛÛ"
@ LG,X say "ÛÛÛÛ  Û  ÛÛÛÛ ÛÛÛÛ  Û  ÛÛÛÛ        ÛÛÛÛ     ÛÛÛÛ     ÛÛÛÛ       ÛÛÛÛ"
@ LH,X say "ÛÛÛÛ     ÛÛÛÛ ÛÛÛÛ     ÛÛÛÛ ÛÛÛÛ   ÛÛÛÛ     ÛÛÛÛ     ÛÛÛÛ       ÛÛÛÛ"
@ LI,X say "ÛÛÛÛ     ÛÛÛÛ ÛÛÛÛ     ÛÛÛÛ ÛÛÛÛÛÛÛÛÛÛÛ     ÛÛÛÛ     ÛÛÛÛÛÛÛÛÛÛ ÛÛÛÛÛÛÛÛÛÛ"
@ LJ,X say "ÛÛÛÛ     ÛÛÛÛ ÛÛÛÛ     ÛÛÛÛ ßÛÛÛÛÛÛÛÛÛß     ÛÛÛÛ     ÛÛÛÛÛÛÛÛÛÛ ÛÛÛÛÛÛÛÛÛÛ"

SETCOLOR("G/N")
@ LC,Y+33  say "ÛÛÛ";@ LC,Y+41  say "ÛÛÛÛ";@ LC,Y+49  say "ÛÛÛÛ";@ LC,Y+58  say "ÛÛÛÛÛÛ";@ LC,Y+69  say "ÛÛÛÛÛÛ"
@ LD,Y+36  say "ÛÛÛÛ"
@ LF,Y+05  say "Û";@ LF,Y+09  say "Û";@ LF,Y+19  say "Û";@ LF,Y+23  say "Û";@ LF,Y+29  say "Û"
@ LG,Y+06  say "Û";@ LG,Y+08  say "Û";@ LG,Y+20  say "Û";@ LG,Y+22  say "Û";@ LG,Y+30  say "ÛÛÛÛÛÛ";@ LG,Y+58  say "ÛÛÛÛ"
@ LH,Y+07  say "Û";@ LH,Y+21  say "Û"
@ LJ,Y+29  say "Û";@ LJ,Y+39  say "Û"
@ LL,Y+01  say "ÛÛÛÛ";@ LL,Y+10  say "ÛÛÛÛ";@ LL,Y+15  say "ÛÛÛÛ";@ LL,Y+24  say "ÛÛÛÛ";@ LL,Y+30  say "ÛÛÛÛÛÛÛÛÛ"
@ LL,Y+45  say "ÛÛÛÛ";@ LL,Y+54  say "ÛÛÛÛÛÛÛÛÛÛ";@ LL,Y+65  say "ÛÛÛÛÛÛÛÛÛÛ"
SETCOLOR("G+/BG")

FOR   A  :=0 TO LEN(LINHA)+10 STEP +10
      SET COLOR TO W+/N
      @ LL+3,(80-LEN(AUTOR)) SAY PADC(SUBSTR(AUTOR,1,A),LEN(AUTOR))
      @ LL+2,(80-LEN(LINHA)) SAY PADR(SUBSTR(LINHA,1,A),LEN(LINHA)) COLOR("r+/N")
      @ LL+3,00  say "Produzido em "+VERSION()
      INKEY(0.01)
NEXT


IF SETMODE(25,80) 
   
   MODOTELA = "2580"
   ?"Tela alterada para 25x80"
   ?""
ELSE
   MODOTELA = "4280"
   ?"Impossivel alterar tela"
   ?""
ENDIF

*
* -> Final da funcao LOGOMARCA
* ///////////////////////////////////////////////////////////////////////////*

FUNCTION INDICES

QTDEREG := RECCOUNT()    // conta numero de registros

IF .NOT. FILE(ARQUIVO+".NTX") .OR. PCOUNT()<>0
     
     IF .Not. USEREDE(ARQUIVO+".DBF",.T.,20)
          
          Tone(500,3)
          Set Color To W
          Set Cursor Off
          Clear
          Logomarca()
          MENSAGEM("N„o foi poss¡vel acesso a &ARQUIVO"+".DBF") 
          Quit
     
     EndIf
     
     Index On &ARQUIVO->(Referencia)+&ARQUIVO->(Descricaoo)+&ARQUIVO->(Marcaaaaaa) To &ARQUIVO
     
     SET INDEX TO &ARQUIVO
     
     Titulo      :="Lista de Precos e de "+STRZERO(RecCount(),03)+" Produtos" 
     
     @ 02,(80-Len(Titulo))   SAY PADL(Titulo,LEN(Titulo))   COLOR ("W +/N")
                                                                            
     @ 02,00 SAY "Directory : C:\"+CURDIR()+"> "+Left(Time(),5)

     @ 02,30 SAY MSGTELA  COLOR ("B+/N")

     Go Top

EndIf

Return

FUNCTION USEREDE
*
* -> Efetua tentativas para abrir o arquivo durante um determinado tempo en-
*    viado atraves do parametro tempo ou indefinidamente, caso tempo=0. Se a
*    tecla <Esc> for precionada pela usuario, as tentaivas sao interrompidas.
*
PARA ARQ,EXUSE,TEMPO
PRIVATE SEMPRE
M->SEMPRE = (M->TEMPO=0)
SET CURSOR OFF
Mensagem("Aguarde abertura do "+ARQ)

          @ xL,00 SAY SPACE(10)
          @ xL,00 say REPL("°°°",09)                           COLOR("N+/N")
          
          FOR A=00 TO 10 step +3
               INKEY(.01)
               @ xL-2,00 say DBF()+" "+STR(A,3)+"%  Organizando"  COLOR("Rg+/N")
               @ xL,00 say REPL("ÛÛÛ",A)                        COLOR("R+/N")
          Next
          
          @ xL-5,00 SAY "M quina :"+rtrim(NetName())+"  Usu rio :"+rtrim(Operador)  COLOR("G+/N")
          
          @ xL-2,00 say DBF()+" 100%  Organizado!"   COLOR("R/N")         
          
          SETCOLOR("W+/N")
          
          DATA(1,xl-7,00,40)                         

DO WHILE (M->SEMPRE .OR. M->TEMPO>0)
   
   If Exuse               && se .T. 
      USE &ARQ            && use arquivo em modo Compartilhado
      @ 04,00 SAY PADr(rtrim(ARQ)+" em modo Compartilhado",len(rtrim(ARQ)+" em modo Compartilhado"))   COLOR("g/N")
   Else                   && senao
      USE &ARQ EXCLUSIVE  && use arquivo em modo exclusivo
      @ 04,00 SAY PADr(rtrim(ARQ)+" em modo Exclusivo",len(rtrim(ARQ)+" em modo Exclusivo"))        COLOR("g/N")
   EndIf                  && Fim do se
   
   IF .NOT. NETERR()
      RETURN .T.
   ENDIF
   
   M->TEC=INKEY(0.01)
   M->TEMPO=M->TEMPO-1
   IF M->TEC=27
      EXIT
   ENDIF
ENDDO
RETURN .F.
*
* FINAL DA FUNCAO USEREDE
****------------------------------------------------------------------------*


FUNCTION REIDEXAR
 INDICES(.T.)
RETURN.T.

FUNCTION VRFARQUIVO
IF .NOT.(.NOT.EMPTY(ARQUIVO)) .AND. LASTKEY()<>5
     TONE(200)
     Mensagem("Informe o mes e ano para este arquivo")
     RETURN .F.
ENDIF
RETURN .T.

FUNCTION VRFOPERADOR
IF .NOT.(.NOT.EMPTY(OPERADOR)) .AND. LASTKEY()<>5
     TONE(200)
     Mensagem(" Informe seu nome para processamento")
     RETURN .F.
ENDIF
RETURN .T.

FUNCTION VRFCAMPO   
Public OBS
M->Obs01 = "Inclusao e/ou alteracao "+dtoc(date())

If   Empty(DESCRICAOO) .AND. LastKey()<>5
     Tone(200)
     Mensagem("Informe seu nome para processamento",5)
     InKey(3)
     Return .F.
EndIf

Return .T.

Function Backup
  Mensagem('"Copiando" &ARQUIVO para "BACKUP.DBF"!!! ') 
  Copy to BackUp.dbf
  Mensagem('"Copia de completa!!! ',5)
Return.T.

Function Consulta
   
   Public Nome    
   
   PsqTela = SaveScreen(xl-7,00,xl-7,80)
   Set cursor On
   Go Top
   Do While .T.
      M->Nome = Space(Len(&arquivo->REFERENCIA))
      @ xl-7,00 say Space(Len(M->Nome))
      @ xl-7,00 say "Referˆncia a procurar .....:" Get M->Nome Pict "@!" Valid PSQ(NOME)
      Read
      Exit
   EndDo
   Set Cursor Off
   RestScreen(xl-7,00,xl-7,80,PsqTela)
   
Return.T.

Function PSQ(Chave)
   
   If Empty(Chave)
     MENSAGEM("Preenchimento obrigatorio") ; tone(200)
     Inkey(5)
     @ xL,00 say Space(80)
     Go top
     Return.F.
   
   ElseIf &arquivo->(DbSeek(TRIM(Chave)))=.F.
     MENSAGEM("Registro n„o existe ou n„o encontrado") ; tone(200)
     Inkey(5)
     @ xL,00 say Space(80)
     Go top
     Return.F.
   Else
     Chave = TRIM(&Arquivo->REFERENCIA)
   endif
Return.T.

* -> funcao copiadora de dados 
*
Function COPIAR 

INDICES(.T.)
Sele 1
Use PRODUTOS
If !File("PRODUTOS.NTX")
   @ xL,00 SAY PADC("Indexando "+dbf(),80)
   INDEX ON REFERENCIA TO PRODUTOS.NTX
EndIf

SELE 2
USE &ARQUIVO
ZAP

Sele 1
Set Order to 1
Go Top
M-> A = 7

@ 06,00       TO 33,79 DOUBLE   COLOR("W+/N")
while Produtos->(!eof())
      
      if M->A >= 30
        @ 06,00 CLEAR TO 33,79 
        @ 06,00       TO 33,79 DOUBLE
        M->A = 8
      else
        M->A = M->A + 1
      endif
      
      CopRef:=Produtos->(Referencia)
      CopDsc:=Produtos->(Descricaoo)     
      CopFbr:=Produtos->(Marcaaaaaa)     
      CopPun:=Produtos->(PrecoAvist)     
      CopUnd:=Produtos->(Unidadedee)     
           
           @ A ,10 say " Copiando &CopRef"             COLOR("W+/N")
      
      sele 2   
      append blank
      &ARQUIVO->Referencia:= CopRef
      &ARQUIVO->Referencia:= CopRef 
      &ARQUIVO->Descricaoo:= CopDsc
      &ARQUIVO->Marcaaaaaa:= CopFbr
      &ARQUIVO->PrecoAvist:= CopPun
      &ARQUIVO->Unidadedee:= CopUnd
           
           inkey(0.01)
           
           @ A ,10 say "  Copiado  &CopRef  para "+DBF() COLOR("G/N")  
      
      sele 1
      
      skip

ENDDO

CLOSE  ALL

Return.T.

Function HELP
   
   Save Screen to TelaHelP
   TONE(290)

   SetColor("G+/N")
   @ 10,15 clear to 34,65
   @ 10,15       to 34,65    color ("B+/N")

   @ 12,17 Say PADC("A.J.U.D.A.  E.X.P.R.E.S.S.A",46)   Color("RG+/N")
   @ 14,20 Say "TECLA       ACAO        COMENTARIO"     Color("W+/N")
   @ 15,20 Say "ÜÜÜÜÜ       ÜÜÜÜÜÜÜÜÜÜ  ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ"
   @ 18,20 Say "[F1]        Ajuda       Acesso Geral"          
   @ 20,20 Say "[F2]        Back-Up     Acesso Geral"          
   @ 22,20 Say "[F3]        Indexar     Acesso Geral"          
   @ 24,20 Say "[F4]        Consulta    Acesso Geral"          
   @ 26,20 Say "[F5]        Imprime     Acesso Restrito"       
   @ 28,20 Say "[DEL]       Apagar      Acesso Restrito"       
   @ 30,20 Say "[ENTER]     Alterar     Acesso Restrito"       
   @ 32,20 Say "[INSERT]    Incluir     Acesso Restrito"       
   Inkey(10)
   restore screen from TelaHelP

Return .t.

* /////////////////////////////////////////////////////////////////////////*
*
* -> Inicio da funcao que imprime mensagens na tela
*
Function Mensagem
  
COR_MENS=SETCOLOR("W+/R")
SetColor("W+/N")
Set Cursor OFF

IF PCount()=0
   
   @ xL-1,30 SAY Space(50)
   @ xL,30 SAY Space(50)
   
   SetColor(COR_MENS)
   Set Cursor ON
   Return .T.

EndIf

If PCount()=1
   Para TEXTO
   M->Pausa=0
Else
   Para TEXTO,PAUSA
EndIf
 
  @ xL-1,30 SAY PadL(Repl("ß",Len(RTRIM(M->OPERADOR)+", "+TEXTO)),50)

  @ xL,30 say PadL(RTRIM(M->OPERADOR)+", "+TEXTO,50)
  
IF M->PAUSA<>0
   M->X=Inkey(M->PAUSA)
ENDIF

SETCOLOR(COR_MENS)
SET CURSOR ON
RETURN .T.
*
* -> Final da funcao que imprime mensagens na tela
*
* /////////////////////////////////////////////////////////////////////////*

function descanso

TDP = SaveScreen(00,00,xL,80)
a = 21
b = xL-2
c = 21
d = xL-2

TEMPO = 0

Do while .t.

If lastkey() = 27
   exit
Endif

If tempo >= 1000 
TEMPO = 0
a = 21;b = 40;c = 21;d = xL-2
RestScreen(00,00,xL,80,TDP)
endif

Tempo = tempo + 1

If a <= 0
a = 21
endif

If b <= 0
b = xL-2
endif

If c >= xL-2
c = 21
endif

If d >= 80
d = xL-2
endif

TD1 = SaveScreen(a,b,c,d)
TD2 = SaveScreen(a+1,b+1,c+1,d+1)

* RestScreen(a,b,c,d,TD1)
* RestScreen(a-d,b-c,c-b,d-a,TD2)
* RestScreen(a,b,c,d,TDP)

@ A,B TO C,D DOUBLE  
@ A,B,C,D BOX(chr(A))
a = a -1
b = b -1
c = c +1
d = d +1

Setcolor ("W/N,,,,G+/N*+")
@ xL-2,00 say "Controle: "+StrZero(Memory())+STRZERO(Tempo)+Time()
@ xL,00 say "Memoria : "+StrZero(Memory())
Mensagem("Descanso de tela, ativado!",0.01)
enddo
SetColor(",,,,N/N")

RestScreen(00,00,xL,80,TDP)

RETURN 
