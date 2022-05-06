*
EDITOR()
*
FUNCTION EDITOR()
SAVE SCREEN TO TELA_EDITOR
CLEAR 
* -> cores
*
cor1="BG+/b"
cor2="BG+/b"
Cor3="BG+/b"
cor4="BG+/b"
cor5="BG+/b"
cor6="G+/N"
cor7="W+/N"
FUNDO="G+/N"
JANELA="B+/b"
TITULO="W+/B"
FUNDO=0
*
* -> COORDENADAS
*
L=00
C=00
L1=L+08
L2=L+09
L3=L+10
L4=L+11
L5=L+12
L6=L+08
C1=C+15
C2=C+15
C3=C+15
C4=C+15
C5=C+15
C6=C+44
*
*
*         
*

SET KEY 28 TO MMS_AJUDA()
SET KEY -1 TO RELOGIO()
SET KEY -2 TO MUSICA()
SET KEY -3 TO IMPRIME()
SET KEY -4 TO MMS_DESCANSO()
SET KEY -5 TO DESCANSO_MMS()
xconf="N"
DO WHILE.T.
*
*
SET CURSOR ON
ARQUIVO   :=SPACE(45)

ENTRADA_EDIT()
@ 18,08 SAY " Arquivo  "
@ 19,08 SAY " Caminho :" GET ARQUIVO PICT "@!" Color ("W+/B")
@ 23,00 SAY PADC(" Caminho e o nome do arquivo desejado ",80) color ("W+/N")
READ
     IF LASTKEY()=27
          save screen to saida_tela
          @ 10,32,13,50 BOX "€€€€€€€€€"  color ("R/R")
          @ 10,32 TO 13,50               color ("R+/R")
          SOMBRA_edit(10,32,13,50)
          setcolor ("w+/r")
          @ 11,35 SAY "Deseja sair?" 
          @ 12,35 SAY "   [S/N]    "  GET XCONF; 
                    PICT [!] valid xconf $ "NS" color ("r/r")
          set color to w
          read
          IF XCONF="N"
             loop
             ELSE
             EXIT
          ENDIF
     ENDIF                       
SETCOLOR ("G+/n")
TEXTO=MEMOREAD(ARQUIVO)

PREVEW_edit(04,08,18,73," VISUALIZACAO ")
@ 16,11 say "Caminho / Arquivo: " Color ("BG+/N")
@ 16,30 say "Ì" Color ("RG+/N")
@ 16,32 say "<                                       >" Color ("RG+/N")
@ 16,33 say PADL(ARQUIVO,39) Color ("G+*/N")
*
@ 17,11 say "AáÑo Realizada   :" COLOR ("BG+/N")
@ 17,30 say CHR(2) Color ("RG+/N")
@ 17,32 say "<            >" Color ("RG+/N")
@ 17,33 say PADC("LENDO",12) Color ("R+*/N")
SET CURSOR ON
MEMOEDIT(TEXTO,05,11,15,72,.T.)
       ENDDO
INFORMA_edit()

**********************
****** FUNCOES *******

Function INFORMA_edit
CLEAR 
?REPL(" MMS-Editor \//\\//\\/\",200) 
sombra_edit(07,15,07,68)
sombra_edit(08,15,08,68) 
sombra_edit(09,15,09,68)
sombra_edit(10,15,10,68)
sombra_edit(11,15,11,68)
sombra_edit(12,15,12,68)
sombra_edit(13,15,13,68)
sombra_edit(14,15,14,68)
sombra_edit(15,15,15,68)
@ 07,13 TO 17,66 COLOR ("n+/N")
@ 09,27 SAY PADC(" MMS-Editor Utilit†rio ",23) COLOR "W+/N"
@ 10,27 SAY PADC(" ---- versÑo 0.02 ---- ",23) COLOR "G+/N"
@ 13,25 SAY PADC(" Jequie  - Bahia -  Brasil. ",27) COLOR ("G+/N")
@ 14,20 SAY PADC(" ProduáÑo de Marcos Morais de Sousa. ",38) COLOR ("G+/N")
@ 02,00 SAY "Ligue   :" COLOR ("W+/N")
@ 02,09 SAY " (073) 525-2344 ou (073) 525-5932 " COLOR ("w*/N")
@ 23,00 SAY REPL("ƒ",80) COLOR ("r+/n")
@ 24,00 SAY PADL("MMS-Editor Utilit†rio for CLIPPER",80) COLOR ("w+/n")

  FUNCTION PAPEL_MMS
  SETCOLOR ("g+/n")
  ?REPL(" MMS-Editor \//\\//\\/\",200) 
  RETURN
  
  FUNCTION TIMBRE_edit
  SETCOLOR ("G+/n")
  TONE (1000,3)      
  @ 04,30,16,70 BOX "€€€€€€€€€" COLOR ("N/N")
  @ 04,30 TO 16,70 COLOR ("b+/N")
  SOMBRA_edit(04,30,16,70)
  @ 05,33 SAY PADC("MMS-Editor Utilit†rio",35) COLOR "W+/N"
  @ 06,33 SAY PADC("---- versÑo 0.02 ----",35) COLOR "G+/N"
  @ 09,33 SAY PADC("Desenvolvido por:",35) COLOR "W/B"
  @ 10,33 Say PADC("Marcos Morais de Sousa",35) COLOR "RG+/B"
  @ 08,33 to 13,67 color ("B+/B")
  @ 11,33 Say PADC("M.M.S.tec",35) COLOR "B/BG"
  @ 12,33 Say PADC("Artes Gr†ficas & Inform†tica.",35) COLOR "B/BG"
  @ 13,33 Say PADC("Fone:(073)525-5932",35) COLOR "B/BG"
  @ 14,33 Say PADC("Copyright(R) 1996-1997",35) COLOR "B/BG"
  @ 15,33 SAY PADC("                      ",35) COLOR "B/BG"
  SET CURSOR OFF
  SET COLOR TO W
  RETURN

  FUNCTION FUNDO_MMS
  PARA PJAN1,PJAN2,PJAN3,PJAN4,PJAN5
  PAPEL_1="≈"
  PAPEL_2="Ë"
  PAPEL_3="€"
  PAPEL_4="-" 
  IF PCOUNT()<>5
     PJAN5=""
  ENDIF
  SOMBRA_edit(PJAN1,PJAN2,PJAN3,PJAN4)
  SETCOLOR("W+/N")
  @ PJAN1,PJAN2,PJAN3,PJAN4 BOX "€€€€€€€€"+PAPEL_4
  SETCOLOR("W+/N")
  @ PJAN1,PJAN2,PJAN3,PJAN4 BOX "€€€€€€€€" 
  SETCOLOR("W+/B")
  @ PJAN1,PJAN2 clear to PJAN1,PJAN4 
  IF LEN(TRIM(PJAN5)) > 0
     @ PJAN1,PJAN2+(((PJAN4+1-PJAN2)-LEN(PJAN5))/2) SAY PJAN5
  ENDIF
     
  FUNCTION JANELA_MMS
  PARA PJAN1,PJAN2,PJAN3,PJAN4,PJAN5
  IF PCOUNT()<>5
     PJAN5=""
  ENDIF
  SOMBRA_edit(PJAN1,PJAN2,PJAN3,PJAN4)
  SETCOLOR("B+/B")
  @ PJAN1,PJAN2,PJAN3,PJAN4 BOX "€€€€€€€€€"
  SETCOLOR(COR1)
  SETCOLOR("W+/B")
  @ PJAN1,PJAN2 clear to PJAN1,PJAN4 
  IF LEN(TRIM(PJAN5)) > 0
     @ PJAN1,PJAN2+(((PJAN4+1-PJAN2)-LEN(PJAN5))/2) SAY PJAN5
     SET COLOR TO W/N
  ENDIF

  FUNCTION PREVEW_edit
  PARA PJAN1,PJAN2,PJAN3,PJAN4,PJAN5
  PAPEL="-"
  IF PCOUNT()<>5
     PJAN5=""
  ENDIF
  SOMBRA_edit(PJAN1,PJAN2,PJAN3,PJAN4)
  SETCOLOR("G+/N")
  @ PJAN1,PJAN2,PJAN3,PJAN4 BOX "€€€€€€€€"+PAPEL
  SETCOLOR("N/N")
  @ PJAN1,PJAN2+2,PJAN3-1,PJAN4-1 BOX "€€€€€€€€€" 
  SETCOLOR("W+/N")
  SETCOLOR("W+/G")
  @ PJAN1,PJAN2 clear to PJAN1,PJAN4 
  IF LEN(TRIM(PJAN5)) > 0
     @ PJAN1,PJAN2+(((PJAN4+1-PJAN2)-LEN(PJAN5))/2) SAY PJAN5
     SET COLOR TO W/N
  ENDIF

FUNCTION SOMBRA_edit
PARA LIN_SUP,COL_SUP,LIN_INF,COL_INF
IF PCOUNT()=2 .OR. PCOUNT()=3
   C_SOM=COL_SUP
   L_SOM=LIN_SUP
   LIN_SUP=VAL(SUBS(C_SOM,1,2))
   COL_SUP=VAL(SUBS(C_SOM,3,2))
   LIN_INF=VAL(SUBS(C_SOM,5,2))
   COL_INF=VAL(SUBS(C_SOM,7,2))
   COL_SOM=SUBS(C_SOM,9)
   LIN_SOM=L_SOM
ENDIF
IF COL_SUP<2 .OR. LIN_INF>22
   C_SOM=""
   L_SOM=""
   RETURN .F.
ENDIF
IF PCOUNT()=3
   RESTSCREEN(LIN_SUP+1,COL_SUP-2,LIN_INF+1,COL_SUP-1,COL_SOM)
   RESTSCREEN(LIN_INF+1,COL_SUP-2,LIN_INF+2,COL_INF-2,LIN_SOM)
   RETURN .F.
ENDIF
IF PCOUNT()<>2
   COL_SOM=SAVESCREEN(LIN_SUP+1,COL_SUP-2,LIN_INF+1,COL_SUP-1)
   LIN_SOM=SAVESCREEN(LIN_INF+1,COL_SUP-2,LIN_INF+2,COL_INF-2)
ENDIF
COL_SOM=SUBS(COL_SOM,1,((LIN_INF-LIN_SUP)+1)*4)
LIN_SOM=SUBS(LIN_SOM,1,((COL_INF-COL_SUP)+1)*4)
*
IF SUBS(COL_SOM,2,1)<>CHR(8)
   C_SOM=STR(LIN_SUP,2)+STR(COL_SUP,2)+STR(LIN_INF,2)+STR(COL_INF,2)+COL_SOM
   L_SOM=LIN_SOM
ENDIF
FOR I=2 TO LEN(COL_SOM) STEP 2
   COL_SOM=STUFF(COL_SOM,I,1,CHR(8))
   
NEXT
FOR I=2 TO LEN(LIN_SOM)/2 STEP 2
   LIN_SOM=STUFF(LIN_SOM,I,1,CHR(8))
   
NEXT
RESTSCREEN(LIN_SUP+1,COL_SUP-2,LIN_INF+1,COL_SUP-1,COL_SOM)
RESTSCREEN(LIN_INF+1,COL_SUP-2,LIN_INF+2,COL_INF-2,LIN_SOM)
*
************************************************************
*
FUNCTION ENTRADA_EDIT
SET CURSOR ON 
SET COLOR TO G+
*?REPL(" MMS-Editor ",200) 
?REPL(" MMS-Editor \//\\//\\/\",200) 
JANELA_MMS(02,05,20,75," MMS-Editor V.1.0 ")
Arquivo=space(45)
Private fontes[adir("*.*")]
adir("*.*",fontes)
SETCOLOR ("b+/B")
FUNDO_MMS(04,08,16,25," ARQUIVOS ")
SET COLOR TO W
TIMBRE_edit()
@ 02,05 SAY " [F1] Ajuda " COLOR ("B+/B")
@ 23,00 SAY PADC(" Mova o cursor para vizualizar mais arquivos e/ou <ENTER> ",80) color ("W+/N")
@ 24,00 SAY PADC(" <ESC> : Retorna ao MS-Dos ",80)                 color ("RG+/N")
SETCOLOR ("w/n,W+/BG")

Escolha=achoice(05,10,15,24,Fontes)
RETURN

FUNCTION IMPRIME()
LOCAL nCOPIAS
nCOPIAS   :=0
@ 00,02 SAY "QUANTAS COPIAS: " GET nCOPIAS PICT "99"
READ
FOR A     :=0 TO nCOPIAS
     IF .NOT. isPRINTER()
          @ 24,00 SAY PADC(" E a impressora? ",80) COLOR ("W+/n")
          INKEY(3)
          @ 24,00 say PADC("",80)
          RETURN NIL
     ENDIF
     
     SET CONSOLE OFF
     SET PRINTER ON
     @ 23,00 SAY PADC(" Tecle <ESC> para continuar...",80) COLOR ("W+*/N")
     @ 24,00 SAY PADC(" IMPRIMINDO... ",80) COLOR ("W+*/N")
     ? HARDCR(ARQUIVO)
     ?""
     ? HARDCR(MEMOEDIT(TEXTO,05,11,15,72,.T.))
     EJECT
     SET PRINTER OFF
     SET CONSOLE ON
     @ 24,00 SAY PADC(" ImpressÑo concluida. <ESC> Proxima tela.. ",80) COLOR ("W+*/N")
NEXT
RETURN

FUNCTION RELOGIO
* \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
* \ Empresa : M.M.S.tec INFORMATICA LTDA.
* \ Programa: MMS-Editor VERSAO:
* \ Data    : 17.01.1997.
* \ Sistema : Editor de Arquivos
* \ FunáÑo  : Ler e Editar arquivos
* \ Analista: Marcos Morais de Sousa.
* \ CriaáÑo : Marcos Morais de Sousa.
* \ Usu†rio : 
* \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
*
SAVE SCREEN TO TELA_HORA
SET CURSOR OFF
SET COLOR TO W
DO WHILE .T.
     IF LASTKEY()>1
     EXIT
     ENDIF
     SETCOLOR("R+/R")
     *@ 00,66 SAY "R E L O G I O" COLOR("G+/N")
     SOMBRA_edit(01,66,03,79)
     @ 01,66 Clear TO 03,79
     @ 01,66 TO 03,79 color ("R+/R")
     @ 02,69 SAY TIME() COLOR("W+/R")
     @ 02,75 SAY RIGHT(TIME(),2) COLOR("w+/R")
     TONE(1000,1)
     Inkey(1)
     @ 01,80 say SPACE(5) COLOR ("R/R")
     IF lASTKEY()>1
     EXIT
     ENDIF
     ENDDO
SET COLOR TO W
RESTORE SCREEN FROM TELA_HORA
*COR(TITULO)
*@ 23,00 say SPACE(80)

FUNCTION MMS_AJUDA
SAVE SCREEN TO TELA_AJUDA
SETCOLOR ("n+/N")
CLEAR
?REPL(" MMS-Editor \//\\//\\/\",200) 
*?REPL("/\\//\\//\\/\",300) 

SETCOLOR ("g+/G")
SOMBRA_edit(01,15,20,65)
@ 03,15 CLEAR TO 20,65
@ 03,15 TO 20,65 DOUBLE
SOMBRA_edit(03,15,20,65)
SETCOLOR ("W+/G")
@ 05,20 SAY "   ** MMS-Ajuda for MMS-Editor V.1.0 **  " COLOR ("RG+/G")
@ 06,20 SAY "                                         "
@ 07,20 SAY "   Programa desenvolvido com finalidade  "
@ 08,20 SAY "         de LEITURA de arquivos.         "
@ 09,20 SAY "       por Marcos Morais de Sousa.       "
@ 10,20 SAY "                                         "
@ 11,20 SAY "   ------------------------------------  " COLOR ("R+/G")
@ 12,20 SAY "                SUMARIO                  " 
@ 13,20 SAY "   ------------------------------------  " COLOR ("R+/G")
@ 14,20 SAY "   F1....AJUDA          F5.....<em teste>"
@ 15,20 SAY "   F2....RELOGIO        F6.....DESCANSO  "
@ 16,20 SAY "   F3....MUSICA         F7.....<aguarde> "
@ 17,20 SAY "   F4....IMPRIMIR       F8.....<aguarde> "
@ 18,20 SAY "                                         "
@ 19,18 SAY "Ps.:" COLOR("W+*/g")
@ 19,22 SAY " Evite ABRIR arquivos de sistema.      " COLOR("RG+/g")
@ 24,00 SAY PADC("Tecle <ESC> para prosseguir...",80) COLOR("W/n")
DO WHILE.T.
     IF LASTKEY()=27
          EXIT
     ENDIF
     @ 02,58 SAY TIME() COLOR("R+/n")
     @ 19,62 SAY RIGHT(TIME(),2) COLOR("G+/G")
     TONE(800,1)
     INKEY(1)
     @ 02,57 say SPACE(10) COLOR ("R+/n")
     @ 24,00 SAY PADC("Tecle <ESC> para prosseguir...",80) COLOR("G+/n")
     ENDDO
TONE (2000,5)
TONE (2000,5)
CLEAR
SETCOLOR ("W+/N")
RESTORE SCREEN FROM TELA_AJUDA

FUNCTION MUSICA
SAVE SCREEN TO TELA_MUSICA
SETCOLOR ("W+/n")
@ 00,70 SAY TIME()
TONE(500,4)
@ 00,70 SAY TIME()
TONE(550,4)
@ 00,70 SAY TIME()
TONE(600,4)
@ 00,70 SAY TIME()
TONE(650,4)
@ 00,70 SAY TIME()
TONE(600,4)
@ 00,70 SAY TIME()
TONE(550,4)
@ 00,70 SAY TIME()
TONE(500,4)
@ 00,70 SAY TIME()
TONE(350,4)
@ 00,70 SAY TIME()
TONE(500,4)
@ 00,70 SAY TIME()
TONE(550,7)
@ 00,70 SAY TIME()
TONE(500,4)
@ 00,70 SAY TIME()
TONE(550,7)
@ 00,70 SAY TIME()
TONE(500,4)
@ 00,70 SAY TIME()
TONE(550,4)
@ 00,70 SAY TIME()
TONE(600,4)
@ 00,70 SAY TIME()
TONE(650,4)
@ 00,70 SAY TIME()
TONE(600,4)
@ 00,70 SAY TIME()
TONE(550,4)
@ 00,70 SAY TIME()
TONE(500,4)
@ 00,70 SAY TIME()
TONE(350,4)
@ 00,70 SAY TIME()
TONE(500,4)
@ 00,70 SAY TIME()
TONE(550,7)
@ 00,70 SAY TIME()
TONE(500,7)
@ 00,70 SAY TIME()
TONE(500,7)
@ 00,70 SAY TIME()

TONE(500,4)
@ 00,70 SAY TIME()
TONE(550,4)
@ 00,70 SAY TIME()
TONE(600,4)
@ 00,70 SAY TIME()
TONE(650,4)
@ 00,70 SAY TIME()
TONE(600,4)
@ 00,70 SAY TIME()
TONE(550,4)
@ 00,70 SAY TIME()
TONE(500,4)
@ 00,70 SAY TIME()
TONE(350,4)
@ 00,70 SAY TIME()
TONE(500,4)
@ 00,70 SAY TIME()
TONE(550,7)
@ 00,70 SAY TIME()
TONE(500,7)
@ 00,70 SAY TIME()
TONE(600,10)
@ 00,70 SAY TIME()
TONE(350,4)
@ 00,70 SAY TIME()
@ 00,70 SAY SPACE(10)
RESTORE SCREEN FROM TELA_MUSICA


function MMS_DESCANSO
SAVE SCREEN TO AVISO_TELA
do while.t.
@ 24,10 CLEAR TO 24,80
set cursor off
a=0
l=0
c=0
**
**
for a=10 to 70 step +2
     inkey(.1)
     @ 24,10 CLEAR TO 24,80
     @ 24,00 say a color "R+/n"
     @ 24,C+A say " <ESC> : SAI "  color "G+/n"
     next
**
**
for a=70 to 10 step -2
     inkey(.1)
     @ 24,10 CLEAR TO 24,80
     @ 24,00 say a color "R+/n"
     @ 24,C+A say " <ESC> : SAI "  color "G+/n"
     next
if lastkey()>1
          ?"Fim do programa" 
          EXIT
     endif
enddo
RESTORE SCREEN FROM AVISO_TELA
RETURN ENTRADA_edit()



function DESCANSO_MMS
SAVE SCREEN to descanso
do while.t.
cls
set cursor off
a=0
l=0
c=0
**
**
for a=1 to 20 step +2
     inkey(.1)
     cls
     @ 00,78 say a color "G+/n"
     @ l+a,c+a+(2*(a)) say "\//\// Marcos \//\// "  color "G+/n"
     next
**
**
for a=20 to 01 step -2
     inkey(.1)
     cls
     @ 00,78 say a color "G+/n"
     @ l+a,c+(2*(a)) say "\//\// Marcos \//\// "  color "G+/n"
     next
if lastkey()=27
          ?"Fim do programa" 
          RESTORE SCREEN from descanso
          EXIT
     endif
enddo
?"Final do prograna" 
RESTORE SCREEN from descanso
return

