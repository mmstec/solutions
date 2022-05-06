
* ////////////////////////////////////////////////////////////////////////////
*
* TITULO     : MFB - folha de pagamento
* Data       : 29/04/97
* Programa   : folha.prg
* Proposta   : Cria arquivos para controle  e impressao de pagamentos    
*              de folha de pagamentos ( arquivo  OPERARIO.DBF )
* 
* ////////////////////////////////////////////////////////////////////////////
*
If !FILE("EMPRESA.DAT")
    
    EMPRESA   := Space(40)
    CLS
    @ 01,00 SAY "(C) Marcos Morais de Sousa - 1995/"+TRAN(YEAR(DATE()),"@E 9999")
    DATA(1,03,00,40)
    @ 07,00 say "Empresa usu ria :"
    @ 08,00  Get EMPRESA PICT "@!" 
    READ
    SAVE TO EMPRESA.DAT

EndIf

RESTORE FROM EMPRESA.DAT

   Autor  :="(C) Marcos Morais de Sousa - 1995/"+TRAN(YEAR(DATE()),"@E 9999")
   MMStec :="MMStec Artes Gr ficas & Inform tica Ltda"
   Titulo :="FOLHA DE PAGAMENTO"
   Versao :="Vers„o 1.0"

   PUBLIC MODOTELA
   
   IF SETMODE(43,80) 
      
      MODOTELA = "4380"
      ?"Tela alterada para 43x80"
   
   ELSE
      cls
      MODOTELA = "2580"
      quit
      ?"Impossivel alterar tela"
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

   SET COLOR TO BG+/N 
   SET DATE FORMAT TO "dd,mm,yyyy"
   SET EPOCH TO 0100
   SET SCOR OFF
   SET DATE BRIT
   SET DELETE ON
   SET WRAP ON
   SET COLOR TO BG+/N 
   SET KEY F1  TO BACKUP()
   SET KEY F11 TO REIDEXAR
   SET INTENSITY ON
   Setcursor(2)

   CLS
   @ 00,00                 SAY PADR(AUTOR,LEN(AUTOR))     COLOR ("W +/N")
   @ 00,(80-LEN(Rtrim(EMPRESA)))  SAY PADL(Rtrim(EMPRESA),LEN(Rtrim(EMPRESA))) COLOR ("G +/N")
   @ 02,(80-LEN(TITULO))   SAY PADL(TITULO,LEN(TITULO))   COLOR ("W +/N")

   OPERADOR   :=SPACE(20)
   @ 03,01 SAY "Seu nome " GET OPERADOR PICT "@!" VALID VRFOPERADOR()
   READ
   
   PUBLIC OPERADOR
   IF .NOT.EMPTY(OPERADOR) .AND. LASTKEY()<>5
     OPERADOR  := OPERADOR
   ELSE
     OPERADOR  := "Operador"
   ENDIF
   DIGITADORR = OPERADOR

   PRIVATE FLHFILES[ADIR("FLH*.DBF")]
   ADIR("FLH*.DBF",FLHFILES)

   ARQUIVO   := SPACE(4)
   
   @ 03,00 CLEAR TO 24,80
   @ 05,01 SAY REPL("Д",78)                            color ("R+/n")
   @ 05,01 say "Lista de Arquivos folhas disponiveis " color ("g+/n")
   @ 03,01 SAY "MES / ANO DO REGISTRO " GET ARQUIVO PICT "9999" VALID VRFARQUIVO()
   ZOOM   = achoice(08,01,18,78,flhfiles)
   READ
   @ 03,00 CLEAR TO 24,80
   
   PUBLIC ARQUIVO
   ARQUIVO   := "FLH0"+ARQUIVO
   
   If.Not. FILE("OPERARIO.DBF") 
   
   OpCAMPOS    :={}

   AADD( OpCAMPOS,{"NOMEEEEEEE","C", 35,  0} )   
   DBCREATE("OPERARIO",OpCAMPOS)
   
   ElseIf .Not. FILE(ARQUIVO+".DBF")

   FlhCampos    :={}

   AADD( FlhCampos,{"NOMEEEEEEE","C", 35,  0} )   
   AADD( FlhCampos,{"VALORPAGOO","N", 10,  2} )
   AADD( FlhCampos,{"OBSERVACAO","C", 35,  0} )
   DBCREATE(ARQUIVO,FlhCampos)
   COP()      
   
   EndIf
   
   PRIVATE TituloS[3] 
   
   * -> TituloS das colunas
   
   TituloS[1] = "Nome do funcion rio"
   TituloS[2] = "Valor Pago"
   TituloS[3] = "Observa‡„o"
   
   PRIVATE MASCARAS[6]  
   
   * -> Mascaras das colunas
                  
   MASCARAS[1] = "@!"
   MASCARAS[2] = "@E 999,999.99"
   MASCARAS[3] = "@!"
   
   DECLARE ConteudoS[3] 
   
   *-> Conteudo das colunas
   
   ConteudoS[1] = "NOMEEEEEEE"
   ConteudoS[2] = "VALORPAGOO"
   ConteudoS[3] = "OBSERVACAO"

   INDICES(.T.)
   
   *-> prepara tela
   
   @ 04,50 say "Memoria :"                              color("n+/n")
   @ 04,60 say memory()      pict "999,999,999,999,999" color("g/n")
   @ 05,50 say "HD livre :"                             color("n+/n")
   @ 05,60 say DiskSpace()   pict "999,999,999,999,999" color("g/n")
   
   SETBLINK(.F.)
   SETCOLOR("W+/N*,W/R")
   
   @ 06,00 CLEAR TO 33,79 
   @ 06,00       TO 33,79 DOUBLE COLOR("W+/N")
   
   @ 06,00 SAY PADC(STRZERO(RecCount(),03)+" "+DBF(),80)         Color("R+/W*")
   @ 06,03 SAY Cdow(DATE())+" "+OS()  Color("R+/W*")
   
   @ 31,03 say "[INSERT] INCLUIR"   COLOR ("G+/N*")
   @ 31,35 SAY "[ENTER] ALTERAR"    COLOR ("G+/N*")
   @ 31,65 SAY "[F5] IMPRIMIR"      COLOR ("G+/N*")
   
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
dBedit(08,01,29,78,ConteudoS,"Edita",MascaraS,TituloS,"ДВД"," | ","ДБД",.T.)


FUNCTION EDITA(MODO,INDICE)
   LOCAL TECLA  
   SET COLOR TO BG+/N 
   TECLA  := LASTKEY()
   CAMPO  := ConteudoS[INDICE]


DO CASE
      CASE MODO = 1
          
          Mensagem(" INICIO DO ARQUIVO") 
          
          RETURN 1
      
      CASE MODO = 2
          
          Mensagem(" FINAL DO ARQUIVO") 
          
          RETURN 1
      
      CASE MODO = 3
          
          Mensagem(" ARQUIVO VAZIO") 
          
          RETURN 1
          
      CASE MODO = 4
          
          IF   TECLA     = ESC
               
               backup()
               Salva()
               
               CLS
               LOGOMARCA();SETBLINK(.t.)
               
               RETURN 0

          ELSEIF TECLA = F4
               
          Consulta()     
               
          return 1
          
          ELSEIF TECLA   = ENTER
               
               save screen to alteraregistro
               
               SETCOLOR(",W+/R*+")
               
               @ row(),col() GET &CAMPO PICT "@!" VALID VRFCAMPO() 
               Mensagem("Alterando registro")
               @ 31,35 SAY "[ENTER] ALTERAR"    COLOR ("RG+/N*")
               
               SET CURSOR ON
               READ
               restore screen from alteraregistro
               
               SET CURSOR OFF
               
               SETCOLOR(",W/R")
               
               RETURN 2
          
          ELSEIF TECLA   = INSERT
               save screen to inserecampo
               APPEND BLANK 
               TONE(290)
               Setcolor("B+/n")
               @ 15,15 clear to 22,65
               @ 15,15       to 22,65
               @ 17,20 SAY "Novo funcionario" color ("W+/N")
               @ 18,20 SAY Repl("Ь",35)      color ("G+/N")
               @ 20,20 GET NOMEEEEEEE ;
               pict "@!" VALID VRFCAMPO()     color ("G+/N")
               
               Mensagem("Incluindo registro")
               
               @ 31,03 say "[INSERT] INCLUIR"   COLOR ("RG+/N*")
               SET CURSOR ON
               READ
               restore screen from inserecampo
               SET CURSOR OFF
               INDICES(.T.)
               GO TOP
               RETURN 2

          ELSEIF TECLA   = F5
               @ 31,65 SAY "[F5] IMPRIMIR"      COLOR ("RG+/N*")
               TONE(290)
               RELATORIO()
          RETURN 2
          
          ELSEIF TECLA   = DEL
          save screen to DELETAcampo
          RESPOSTA ="S"
                
                @ 35,000 say "Elimina registro corrente ? ( S )im - ( N )„o " get resposta PICT "@!"
                  READ
                  IF RESPOSTA = "S"
                     DELETE  // Marca   registro corrente 
                     
                     Mensagem("Registro sendo deletado")
                     
                     PACK    // Elimina registro corrente
                     
                     TONE(290)
                     
                     Mensagem("Registro deletado",5)
                     
                  ENDIF
          restore screen from DELETAcampo
          INDICES(.T.)
          GO TOP
          EndIF
          
          Otherwise
          
          Mensagem("Tecle [ESC] para SAIDA")
          
          RETURN 1

   
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
N         :=1
PAGINA    :=1
LINHA     :=0
SOMA      :=0
LOOP      :=1


IF .NOT. ISPRINTER()
   @ 42,(80-LEN(PRINTOFF))/2 SAY SPACE(LEN(PRINTOFF))
   @ 42,(80-LEN(PRINTOFF))/2 SAY PADC(PRINTOFF,LEN(PRINTOFF))
   inkey(0) 
   @ 22,(80-LEN(PRINTOFF))/2 SAY SPACE(LEN(PRINTOFF))
   RETURN.T.
ENDIF

@ 00,00 SAY CHR(18)  &&Determina o tipo de letra para impressao

DO WHILE .NOT. EOF() 
     
     SET DEVI TO SCREEN                        
          @ 42,(80-LEN(PRINTING))/2 SAY SPACE(LEN(PRINTING))
          @ 42,(80-LEN(PRINTING))/2 SAY PADC(PRINTING,LEN(PRINTING))
     SET DEVI TO PRINT
     
     
     IF LINHA = 60 .OR. LINHA = 0
     
          DATA(1,00,01,78);DATA(1,00,01,78);DATA(1,00,01,78)
          @ 00,(80-LEN(Rtrim(EMPRESA)))  SAY PADL(Rtrim(EMPRESA),LEN(Rtrim(EMPRESA))) 
          @ 01,00 SAY chr(16)+" "+rtrim(operador)+" "+chr(17)
          @ 01,00 SAY PADL(TITULO,80)                          
          @ 02,00                 SAY PADC("RELATORIO DE PAGAMENTOS",80)
          @ 02,00 SAY PADR(" Arquivo "+RTRIM(ARQUIVO)+".DBF",30)
          @ 04,01                 SAY REPL("*",79)
           
          @ 05,01 SAY STRZERO(QTDEREG,3)+" Funcionario(S)"
          @ 05,39 SAY "Valor Pago"
          @ 05,51 SAY "Assinaturas"
          
          @ 06,01 SAY REPL("*",79)                  
          LINHA= 8                                  
                                                    
     ENDIF
          
          @ LINHA,01 SAY STRZERO(N,3)+" "+RTRIM(NOMEEEEEEE)+REPL(".",30-LEN(RTRIM(NOMEEEEEEE)))+">" PICT "@!"
          N=N+1
          @ LINHA,37 SAY VALORPAGOO PICT "@E 9,999,999.99"
          @ LINHA,51 SAY REPL("_",28)
          
          SOMA = SOMA+VALORPAGOO
          
          SKIP
          
          LINHA     = LINHA    +1
      
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
@ 42,(80-LEN(PRINTING))/2 SAY SPACE(LEN(PRINTING))
@ 42,(80-LEN(PRINTED)) /2 SAY PADC(PRINTED,LEN(PRINTED))
INKEY(3)
@ 42,(80-LEN(PRINTED))/2 SAY SPACE(LEN(PRINTED))
TONE(290)
RETURN.T.

FUNCTION TOTAL
PARA PAR1
IF PAR1=2
   LINHA=57
ENDIF
@ LINHA+0,01 SAY REPL("*", 79)
IF PAR1=2
   @ LINHA+1,001 SAY "TOTAL DE PAGAMENTO EFETUADO"
ELSE
   @ LINHA+1,001 SAY "(SUB)TOTAL DE PAGAMENTO EFETUADO"
ENDIF
@ LINHA+01,035 SAY SOMA PICTURE "@E 999,999,999.99"
@ LINHA+02,001 SAY REPL("*", 79)
@ LINHA+04,(80-LEN(AUTOR))/2  SAY PADC(AUTOR,LEN(AUTOR))    
@ LINHA+04,068 SAY "PAGINA: "+SUBS(STR(PAGINA+10000,5),2)
SET DEVI TO SCREEN                        
  @ 42,060 SAY padL("P gina(s): "+SUBS(STR(PAGINA+10000,5),2),20)
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
LINHA:=REPL("Д",80)

CLS
SETCOLOR("G+/N")
@ LA,X say "ЫЫЫЫ     ЫЫЫЫ ЫЫЫЫ     ЫЫЫЫ ЬЫЫЫЫЫЫЫЫЫЬ ЫЫЫЫЫЫЫЫЫЫЫЫ ЫЫЫЫЫЫЫЫЫЫ ЫЫЫЫЫЫЫЫЫЫ"
@ LB,X say "ЫЫЫЫЫ   ЫЫЫЫЫ ЫЫЫЫЫ   ЫЫЫЫЫ ЫЫЫЫЫЫЫЫЫЫЫ ЫЫЫЫЫЫЫЫЫЫЫЫ ЫЫЫЫЫЫЫЫЫЫ ЫЫЫЫЫЫЫЫЫЫ"
@ LC,X say "ЫЫЫЫЫЫ ЫЫЫЫЫЫ ЫЫЫЫЫЫ ЫЫЫЫЫЫ ЫЫЫЫ   ЫЫЫЫ     ЫЫЫЫ     ЫЫЫЫ       ЫЫЫЫ"
@ LD,X say "ЫЫЫЫЫЫЫЫЫЫЫЫЫ ЫЫЫЫЫЫЫЫЫЫЫЫЫ ЫЫЫЫ            ЫЫЫЫ     ЫЫЫЫ       ЫЫЫЫ"
@ LE,X say "ЫЫЫЫЫЫЫЫЫЫЫЫЫ ЫЫЫЫЫЫЫЫЫЫЫЫЫ ЫЫЫЫЫЫЫЫЫЫЬ     ЫЫЫЫ     ЫЫЫЫЫЫЫЫ   ЫЫЫЫ"
@ LF,X say "ЫЫЫЫ ЫЫЫ ЫЫЫЫ ЫЫЫЫ ЫЫЫ ЫЫЫЫ ЯЫЫЫЫЫЫЫЫЫЫ     ЫЫЫЫ     ЫЫЫЫЫЫЫЫ   ЫЫЫЫ"
@ LG,X say "ЫЫЫЫ  Ы  ЫЫЫЫ ЫЫЫЫ  Ы  ЫЫЫЫ        ЫЫЫЫ     ЫЫЫЫ     ЫЫЫЫ       ЫЫЫЫ"
@ LH,X say "ЫЫЫЫ     ЫЫЫЫ ЫЫЫЫ     ЫЫЫЫ ЫЫЫЫ   ЫЫЫЫ     ЫЫЫЫ     ЫЫЫЫ       ЫЫЫЫ"
@ LI,X say "ЫЫЫЫ     ЫЫЫЫ ЫЫЫЫ     ЫЫЫЫ ЫЫЫЫЫЫЫЫЫЫЫ     ЫЫЫЫ     ЫЫЫЫЫЫЫЫЫЫ ЫЫЫЫЫЫЫЫЫЫ"
@ LJ,X say "ЫЫЫЫ     ЫЫЫЫ ЫЫЫЫ     ЫЫЫЫ ЯЫЫЫЫЫЫЫЫЫЯ     ЫЫЫЫ     ЫЫЫЫЫЫЫЫЫЫ ЫЫЫЫЫЫЫЫЫЫ"

SETCOLOR("G/N")
@ LC,Y+33  say "ЫЫЫ";@ LC,Y+41  say "ЫЫЫЫ";@ LC,Y+49  say "ЫЫЫЫ";@ LC,Y+58  say "ЫЫЫЫЫЫ";@ LC,Y+69  say "ЫЫЫЫЫЫ"
@ LD,Y+36  say "ЫЫЫЫ"
@ LF,Y+05  say "Ы";@ LF,Y+09  say "Ы";@ LF,Y+19  say "Ы";@ LF,Y+23  say "Ы";@ LF,Y+29  say "Ы"
@ LG,Y+06  say "Ы";@ LG,Y+08  say "Ы";@ LG,Y+20  say "Ы";@ LG,Y+22  say "Ы";@ LG,Y+30  say "ЫЫЫЫЫЫ";@ LG,Y+58  say "ЫЫЫЫ"
@ LH,Y+07  say "Ы";@ LH,Y+21  say "Ы"
@ LJ,Y+29  say "Ы";@ LJ,Y+39  say "Ы"
@ LL,Y+01  say "ЫЫЫЫ";@ LL,Y+10  say "ЫЫЫЫ";@ LL,Y+15  say "ЫЫЫЫ";@ LL,Y+24  say "ЫЫЫЫ";@ LL,Y+30  say "ЫЫЫЫЫЫЫЫЫ"
@ LL,Y+45  say "ЫЫЫЫ";@ LL,Y+54  say "ЫЫЫЫЫЫЫЫЫЫ";@ LL,Y+65  say "ЫЫЫЫЫЫЫЫЫЫ"
SETCOLOR("G+/BG")

FOR   A  :=0 TO LEN(LINHA)+10 STEP +10
      SET COLOR TO W/N 
      @ LL+3,(80-LEN(AUTOR)) SAY PADC(SUBSTR(AUTOR,1,A),LEN(AUTOR))
      @ LL+2,(80-LEN(LINHA)) SAY PADR(SUBSTR(LINHA,1,A),LEN(LINHA)) COLOR("r+/N")
      @ LL+3,00  say "Produzido em "+VERSION()
      INKEY(0.01)
NEXT
IF SETMODE(25,80) 
   ?"Tela alterada para 25x80"
   ?""
ELSE
   ?"Impossivel alterar tela"
   ?""
ENDIF
Return
*
* -> Final da funcao LOGOMARCA
* ///////////////////////////////////////////////////////////////////////////*

FUNCTION INDICES

SUM   VALORPAGOO TO FLHTOTAL

IF .NOT. FILE("OPERARIO.NTX") .OR. PCOUNT()<>0
     
     IF .NOT. USEREDE("OPERARIO.DBF",.F.,10)
          TONE(500,3)
          SET COLOR TO BG+/N 
          SET CURSOR OFF
          CLEAR
          ?"N„o foi possЎvel acesso ao arquivo OPERARIO.DBF"
          QUIT
     ENDIF
     
     INDEX ON NOMEEEEEEE TO OPERARIO

ENDIF

IF .NOT. FILE(ARQUIVO+".NTX") .OR. PCOUNT()<>0
     
     IF .NOT. USEREDE(ARQUIVO+".DBF",.F.,10)
          TONE(500,3)
          SET COLOR TO BG+/N 
          SET CURSOR OFF
          CLEAR
          ?"N„o foi possЎvel acesso ao arquivo"+ ARQUIVO+".DBF" 
          QUIT
     ENDIF
     
     INDEX ON NOMEEEEEEE TO &ARQUIVO
     
     @ 35,66 SAY "Total de hoje"   color("W+/N")
     @ 36,66 SAY REPL("Ь",14)      color("G+/N")
     @ 38,66 SAY FLHTOTAL  PICT "@E R$ 9,999,999.99" COLOR ("G+/N") 
     @ 02,00 SAY "Directory : C:\"+CURDIR()+"> "+STR(RecCount(),3)+" Funcion rios" 
     Go Top

ENDIF

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
Mensagem("Abrindo..."+ARQ) 
@ 08,01 SAY CDOW(DATE()) color ("b+/n+*")

          @ 42,00 SAY SPACE(10)
          @ 42,00 say REPL("°°°",09)                           COLOR("N+/N")
          
          FOR A=00 TO 10 step +3
               INKEY(.01)
               @ 40,00 say DBF()+" "+STR(A,3)+"%  Organizando"  COLOR("W+/N")
               @ 42,00 say REPL("ЫЫЫ",A)                        COLOR("R+/N")
               
          Next
          @ 37,00 SAY "M quina :"+rtrim(NetName())+"  Usu rio :"+rtrim(Operador)  COLOR("G+/N")
          
          @ 40,00 say DBF()+" 100%  Organizado!"   COLOR("R/N")         
          SETCOLOR("W+/N")
          DATA(1,35,00,40)                         

DO WHILE (M->SEMPRE .OR. M->TEMPO>0)
   IF EXUSE
      USE &ARQ EXCLUSIVE
      @ 04,00 SAY Rtrim(ARQ)+" em modo Exclusivo     " COLOR("g/N")
   ELSE
      USE &ARQ
      @ 04,00 SAY Rtrim(ARQ)+" em modo Compartilhado " COLOR("g/N")
   ENDIF
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
     ?""
     ?" Informe o mes e ano para este arquivo"
     RETURN .F.
ENDIF
RETURN .T.

FUNCTION VRFOPERADOR
IF .NOT.(.NOT.EMPTY(OPERADOR)) .AND. LASTKEY()<>5
     TONE(200)
     ?""
     ?" Informe seu nome para processamento"
     RETURN .F.
ENDIF
RETURN .T.

FUNCTION VRFCAMPO   
public OBS
M->OBS01 = "Valor ainda nao definido"
M->OBS02 = "Pagamento efetuado em "+dtoc(date())
IF .NOT.(.NOT.EMPTY(NOMEEEEEEE)) .AND. LASTKEY()<>5
     TONE(200)
     @ 42,00 SAY PADC("Informe seu nome para processamento",80)
     INKEY(3)
     RETURN .F.
ENDIF
IF EMPTY(VALORPAGOO)
     TONE(200)
     @ 42,00 SAY PADC("Informe seu nome para processamento",80)
     OBSERVACAO = M->OBS01
     REPLACE OBSERVACAO WITH M->OBS01
else
     OBSERVACAO = M->OBS02
     REPLACE OBSERVACAO WITH M->OBS02
     @ 42,00 SAY PADC("Atualizacao de "+dbf()+" efetuado",80)
ENDIF
RETURN .T.

* -> funcao copiadora de dados 
*
Function COP 

INDICES(.T.)
Sele 1
Use OPERARIO 
If !File("OPERARIO.NTX")
   @ 42,00 SAY PADC("Indexando "+dbf(),80)
   INDEX ON NOMEEEEEEE TO OPERARIO.NTX
EndIf

SELE 2
USE &ARQUIVO
ZAP

Sele 1
Set Order to 1
Go Top
M-> A = 7

@ 06,00       TO 33,79 DOUBLE   COLOR("W+/N")
while operario->(!eof())
      if M->A >= 30
        @ 06,00 CLEAR TO 33,79 
        @ 06,00       TO 33,79 DOUBLE
        M->A = 8
      else
        M->A = M->A + 1
      endif
      
      CopNome:=operario->(nomeeeeeee)
           @ A   ,10 say space(35)
           @ A+1 ,10 say " Copiando &CopNome"             COLOR("W+/N")
      sele 2   
      append blank
      &ARQUIVO->nomeeeeeee:= CopNome
           inkey(.1)
           @ A ,10 say "  Copiado  &CopNome  para "+DBF() COLOR("G/N")  
      sele 1
      skip
ENDDO
CLOSE  ALL
Return.T.

Function Salva

SELE 1
USE OPERARIO
ZAP

SELE 2
USE &ARQUIVO

Sele 2
Set Order TO 2
Go Top
M-> A = 17

@ 14,10 CLEAR TO 25,75 
@ 14,10       TO 25,75 
@ 16,12 say "Salvando o nome dos operarios" color ("RG+/N")
while &arquivo->(!eof())
      
      if M->A >= 23             && (SE) A for maior ou igual a 23
        @ 14,10 CLEAR TO 25,75  && Limpa tela
        @ 14,10       TO 25,75  && Refaz cercadura
        M->A = 17               && novo valor de A
      else                      && (senao)
        M->A = M->A + 1         && a = a + 1
      endif                     && (fim do SE)
      
      SavNome:=&arquivo->(nomeeeeeee)
           @ A   ,12 say space(35)
           @ A+1 ,12 say " Salvando &SavNome"  COLOR("RG+/N")
      sele 1   
      append blank
      Operario->nomeeeeeee:= SavNome
           inkey(0.01)
           @ A,12 say "  Salvo = &SavNome  em "+DBF() 
      sele 2
      skip
ENDDO
Tone(750,1)
SET COLOR TO BG+/N 
Return.T.

Function Backup
  @ 49,00 say padc('"Backupiando" &ARQUIVO para "BACKUP.DBF"!!! ',80) Color ("RG+,N") 
  Copy to BACKUP.dbf
RETURN.T.

Function Consulta
   
   Public Nome    
   Tela = SaveScreen(35,00,35,80)
   Set cursor On
   Go Top
   Do While .T.
      M->Nome = Space(Len(&arquivo->Nomeeeeeee))
      @ 35,00 say Space(Len(M->Nome))
      @ 35,00 say "Funcion rio:" Get M->Nome Pict "@!" Valid PSQ(Nome)
      Read
        Exit
   EndDo
   Set Cursor Off
   RestScreen(35,00,35,80,Tela)

Return.T.

Function PSQ(Chave)
   If Empty(Chave)
     @ 42,00 say PADC("Preenchimento obrigatorio",80) ; tone(200)
     Inkey(5)
     @ 42,00 say Space(80)
     Return.F.
   ElseIf &arquivo->(DbSeek(Chave))=.F.
     @ 42,00 say PADC("Funcion rio n„o existe",80)   ; tone(200)
     Inkey(5)
     @ 42,00 say Space(80)
     Return.f.
   Else
     Chave=&Arquivo->Nomeeeeeee
   endif
Return.t.

FUNCTION RELOGIO (linha, coluna)

Local LIN_CUR := ROW(), COL_CUR :=COL()
Static l,c

l:=linha
c:=coluna

If LastKey() >1
   return.t.
Else
   inkey(.01)
   Set Cursor off
   @ l,c Say TIME()
   SetPos( LIN_CUR, COL_CUR )
   Set Cursor on
EndIf
return .t.




* /////////////////////////////////////////////////////////////////////////*
*
* -> Inicio da funcao que imprime mensagens na tela
*
Function Mensagem
  
  IF MODOTELA = "4380"
      
      RODAPE = 42
  
  ELSEIF MODOTELA = "2580" 
      
      RODAPE = 24
  
  endif

COR_MENS=SETCOLOR("W+/R")
SetColor("W+/N")
Set Cursor OFF
IF PCount()=0
   @ RODAPE,30 SAY Space(50)
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

@ RODAPE-1,30 SAY Space(50)
@ RODAPE-1,30 SAY PadL(Repl("Я",Len(RTRIM(M->OPERADOR)+", "+TEXTO)),50)

@ RODAPE,30 SAY Space(50)
@ RODAPE,30 say PadL(RTRIM(M->OPERADOR)+", "+TEXTO,50)

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

