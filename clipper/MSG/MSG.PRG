PARAMETER cTEXTOB
#include "common.ch"
#include "inkey.ch"
set color to W/N,N /BG+,B+/N,B+/N
clear
SET DATE FORMAT TO "dd,mm,yyyy"
SET DATE BRIT
SET EPOCH TO 1900     

cAUTOR    := "(C) Marcos Morais de Sousa - 1995/"+TRAN(YEAR(DATE()),"@E 9999")
cTEXTOA   := PADC("ATENCAO: ESTE APARELHO DEVE SER DESLIGADO",70)
cTEXTOB   := IIF(cTEXTOB=NIL,SPACE(6) + "BAIXOS PRE€OS MELHORES PRAZOS E ATENDIMENTO NOTA DEZ",SPACE(LEN(CTEXTOB))+cTEXTOB)

DECLARE cTEXTO[22]

cTEXTO[1] := PADc("****  10 MANDAMENTOS DAS RELACOES HUMANAS  ****",70)
cTEXTO[2] := PADc("01. FALE COM AS PESSOAS",70)
cTEXTO[3] := PADc("02. SORIA PARA AS PESSOAS",70)
cTEXTO[4] := PADc("03. CHAME AS PESSOAS PELO NOME",70)
cTEXTO[5] := PADc("04. SEJA AMIGO E PRESTATIVO",70)
cTEXTO[6] := PADc("05. SEJA CORDIAL",70)
cTEXTO[7] := PADc("06. INTERESSE-SE SINCERAMENTE PELOS OUTROS",70)
cTEXTO[8] := PADc("07. SEJA GENEROSO EM ELOGIAR",70)
cTEXTO[9] := PADc("08. SAIBA CONSIDERAR OS SENTIMENTOS DOS OUTROS",70)
cTEXTO[10]:= PADc("09. PREOCUPE-SE SEMPRE COM A OPINIAO DOS OUTROS",70)
cTEXTO[11]:= PADc("10. PROCURE APRESENTAR UM EXELENTE SERVICO",70)
cTEXTO[12]:= PADc("*************   PALAVRAS IMPORTANTES   *************",70)
cTEXTO[13]:= PADc("As 6 palavras mais importantes: ADMITO QUE O ERRO FOI MEU",70)
cTEXTO[14]:= PADc("As 5 palavras mais importantes: VOCE FEZ UM BOM TRABALHO",70)
cTEXTO[15]:= PADc("As 4 palavras mais importantes: QUAL A SUA OPINIAO?",70)
cTEXTO[16]:= PADc("As 3 palavras mais importantes: FACA O FAVOR",70)
cTEXTO[17]:= PADc("As 2 palavras mais importantes: MUITO OBRIGADO",70)
cTEXTO[18]:= PADc("A palavra MAIS importante: NOS",70)
cTEXTO[19]:= PADc("A palavra MENOS importante: EU",70)
cTEXTO[20]:= PADc("***   NOTAS DE INTERESSE DA EMPRESA   ***",70)
cTEXTO[21]:= PADc("ATENCAO: Nao destrua o aparelho de seu trabalho. Matenha-o limpo.   ",70)
cTEXTO[22]:= PADc("ATENCAO: Fale ao telefone apenas o nescessario                      ",70)
                
A         := 0
MHZ       := 0
MAXL      := 42
MAXC      := MaxCol()
COR1      := "R+  /RG*+"
COR2      := "N   /RG*+"
COR3      := "N   /Rg*+"
COR4      := "B+  /Rg*+"
ContaTexto:= 1

setmode(43,80)
setblink(.f.)
setcolor(cor4)
cls
caixa(0,0,41,79,cor1, cor2)

do while  ( LastKey() <> K_ESC)

          @ 06, 05 say PADC("BARRETO MATERIAL DE CONSTRUCAO",72) color("B/RG+*")
          @ 07, 05 say PADC("&cAUTOR",72) color("B/RG+*")

          if (LastKey() == 13)
                pcx50("MSG.LOG",30)
                setmode(43,80) 
                keyboard CHR(4)
          endif    

          HORA_FIM  :=iif(dow(DATE())>=6,"12:50:00","11:50:00")

             COR4  := "B+/RG+*"

             cTEXTOB := SubStr(cTEXTOB, 1, 75)
             MMSLET05(18, 02, cTEXTOB, 0, COR4)
             cTEXTOB := SubStr(cTEXTOB, 2, 75) + SubStr(cTEXTOB, 1, 1) + SPACE(LEN(cTEXTOB)-75 * 6 )

             IF TIME() >= HORA_FIM .AND. time() <= "13:30:00" .OR. time() >= "17:50:00"
                cTEXTOA := SubStr(cTEXTOA, 1, 75)
                @ 35, 05 say space(70) color("w+/R")
                @ 36, 05 say cTEXTOA color("w+/R")
                @ 37, 05 say space(70) color("w+/R")
                cTEXTOA := SubStr(cTEXTOA, 2, 75) + SubStr(cTEXTOA, 1, 1) + SPACE(LEN(cTEXTOA)-75 * 6 )
                TONE(15000,0.0002)
                if time()>="13:30:00"
                @ 35, 05 say space(70) color("w+/Rg+*")
                @ 36, 05 say space(70) color("w+/Rg+*")
                @ 37, 05 say space(70) color("w+/Rg+*")
                endif
             ENDIF

             a++
             @ 10, 05 say cTexto[contaTexto] color("r/rg+*")
             if a >= 20
                 ContaTexto++
                 ContaTexto=iif(ContaTexto=22,1,contatexto)
                 a=0
             endif

          @ 28,(80-LEN(DBDATA()))/2 SAY DBDATA() COLOR(COR3)
          MMSLET05(30, 12, TIME(),1,COR3)
                      
          inkey(0.1)        
enddo  

setblink(.t.)
set color to w/n
setmode(25,80)
cls
quit


function caixa(l1,c1,l2,c2,cor1, cor2)

         cor1:=iif( cor1 = nil,"w+/w", cor1 )
         cor2:=iif( cor2 = nil,"n /w", cor2 )
         l1  :=iif( l1 = nil,0, l1 )
         c1  :=iif( c1 = nil,0, c1 )
         l2  :=iif( l2 = nil,maxRow(), l2 )
         c2  :=iif( c2 = nil,maxCol(), c2 )

         @ l1,c1 SAY "Ú"+REPL("Ä",c2-1)                 COLOR(COR1)
         @ l1,c2 SAY "¿"                                COLOR(COR1)
         FOR A = 1 TO l2-1
                 @ l1+A,c1 SAY "³"                      COLOR(COR1)
                 @ l1+A,c2 SAY "³"                      COLOR(COR2)
         NEXT
         @ l2,c1 SAY "À"+REPL("Ä",c2-1)                 COLOR(COR2)
         @ l2,c2 SAY "Ù"                                COLOR(COR2)

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



