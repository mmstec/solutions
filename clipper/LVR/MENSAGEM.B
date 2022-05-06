* /////////////////////////////////////////////////////////////////////////*
*
* -> Inicio da funcao que imprime mensagens na tela
*
FUNCTION MENSAGEM

COR_MENS=SETCOLOR("W+/R")
COR("TITULO")
SET CURSOR OFF
IF PCOUNT()=0
   @ 24,11 SAY SPACE(58)
   SETCOLOR(COR_MENS)
   ON_CURSOR()
   RETURN .T.
ENDIF
IF PCOUNT()=1
   PARA TEX_TO
   M->PAUSA=0
ELSE
   PARA TEX_TO,PAUSA
ENDIF
@ 24,10 SAY SPACE(60)
@ 24,(80-LEN(TEX_TO+RTRIM(M->OPERADOR)))/2 SAY RTRIM(M->OPERADOR)+", "+TEX_TO
IF M->PAUSA<>0
   M->X=INKEY(M->PAUSA)
ENDIF
TONE(850,1)
SETCOLOR(COR_MENS)
ON_CURSOR()
RETURN .T.
*
* -> Final da funcao que imprime mensagens na tela
*
* /////////////////////////////////////////////////////////////////////////*
