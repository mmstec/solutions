PARAMETERS cTEXTO2
#include "common.ch"
#include "inkey.ch"
set color to W/N,N /BG+,B+/N,B+/N
clear
SET DATE FORMAT TO "dd,mm,yyyy"
SET DATE BRIT
SET EPOCH TO 1900     

AUTOR     :=" * (C) Marcos Morais de Sousa - 1995/"+TRAN(YEAR(DATE()),"@E 9999")+" * "
cTEXTO1   := SPACE(6) + " * ESTE APARELHO DEVE SER DESLIGADO * "
cTEXTO2   := IIF(cTEXTO2=NIL,SPACE(6) + " * A SUA MELHOR OPCAO * ",SPACE(LEN(CTEXTO2))+cTEXTO2)
cTEXTO3   := SPACE(6) + "* VENDAS SO COM DUPLICATAS *"
cTEXTO4   := SPACE(6) + "* FALE AO TELEFONE APENAS O NESCESSARIO *"
cTEXTO5   := SPACE(6) + "* MANTENHA ESTE APARELHO LIMPO *"
cTEXTO6   := SPACE(6) + AUTOR

MHZ       := 0
MAXL      := 42
MAXC      := MaxCol()
COR1      := "R+  /RG*+"
COR2      := "N   /RG*+"
COR3      := "N   /Rg*+"
COR4      := "B+  /Rg*+"

setmode(43,80)
setblink(.f.)
setcolor(cor4)
cls
caixa(cor1, cor2)
do while  ( LastKey() <> K_ESC)

          if (LastKey() == 13)
                pcx50("MSG.LOG",30)
                setmode(43,80) 
                keyboard CHR(4)
          endif    

          HORA_FIM  :=iif(dow(DATE())>5,"11:50:00","12:50:00")
          if time() >= "11:50:00" .AND. time() <= HORA_FIM .OR. time() >= "17:50:00" 
             COR4   := "R+/RG+*"
             MMSLET04(12, 04,"      atencÇo     ",1,"R+/RG+*")
             cTEXTO1:= SubStr(cTEXTO1, 1, 75)
             MMSLET05(18, 02, cTEXTO1, 0, COR4)
             cTEXTO1 := SubStr(cTEXTO1,2, 75) + SubStr(cTEXTO1, 1, 1) + SPACE(LEN(cTEXTO1)-75 * 6 )
             TONE(15000,0.0002)
             else
             COR4  := "B+/RG+*"
             MMSLET04(12, 04,"barreto constru€Ço",1,"R+/RG+*")
             cTEXTO2:= SubStr(cTEXTO2, 1, 75)
             MMSLET05(18, 02, cTEXTO2, 0, COR4)
             cTEXTO2 := SubStr(cTEXTO2, 2, 75) + SubStr(cTEXTO2, 1, 1) + SPACE(LEN(cTEXTO2)-75 * 6 )

          endif

          @ 28,(80-LEN(DBDATA()))/2 SAY DBDATA() COLOR(COR3)
          MMSLET05(30, 12, TIME(),1,COR3)

          inkey(0.1)
enddo  

setblink(.t.)
set color to w/n
setmode(25,80)
cls
@ 04,02 say padc(autor,78) color "w+/n"
quit


function caixa(cor1, cor2)
         if cor1=nil
            cor1= "w+/w"
         endif
         if cor2 = nil
            cor2 = "N /w"
         endif
         @ 00,00 SAY "Ú"+REPL("Ä",MAXCOL()-1)           COLOR(COR1)
         @ 00,MAXCOL() SAY "¿"                          COLOR(COR1)
         FOR A = 1 TO MAXROW()-1
                 @ 00+A,00 SAY "³"                      COLOR(COR1)
                 @ 00+A,MAXCOL() SAY "³"                COLOR(COR2)
         NEXT
         @ MAXROW(),MAXCOL() SAY "Ù"                    COLOR(COR2)
         @ MAXROW(),00 SAY "À"+REPL("Ä",MAXCOL()-1)     COLOR(COR2)
         return (nil)

function Pcx50
         parameters PCXfile, PAR2
         local par1
         tempo=PAR2
         save screen
         if PCXfile = NIL
            alert("Sinto muito.;;Arquivo grafico ( PCX ) nao informado")
         else
            if At('.',PCXfile)=0
               PCXfile = PCXfile + '.PCX'
            endif
            par1 := FastPCX( PCXfile, .T., 100, 10 )
            do case
               case PAR1 = 0          && Arquivo OK.
                    inkey(TEMPO)
                    txtMode()
                    restore screen

               case PAR1 = 1          
                    ALERT( '"&PCXfile"; N„o encontrado.')

               case PAR1 = 2          
                    ALERT( '"&PCXfile"; N„o ‚ arquivo PCX.')

               case PAR1 = 3          
                    ALERT( '"&PCXfile"; Extrutura n„o confere; com o formato PCX')
            endcase
         endif
restore screen
return (nil)
