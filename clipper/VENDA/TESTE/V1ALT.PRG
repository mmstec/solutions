
FUNCTION Altvalores( nColuna ) 
LOCAL cIndexVal
LOCAL nRetVal
LOCAL nField
LOCAL nFieldVal
LOCAL nCursSave
campo:=fieldName(nColuna)
cIndexVal:= &( INDEXKEY(0) )
nField:=FIELDPOS( dB_conte [ nColuna ] )
IF M->NIVEL>=2
IF TYPE("&CAMPO")="D"
          nCursSave:=SETCURSOR()
          SETCURSOR(1)
          @ ROW(), COL()+5 GET &CAMPO color "w+/R"
          READ
          SETCURSOR(nCursSave)
   ELSEIF TYPE ("&CAMPO")="C"
          nCursSave:=SETCURSOR()
          SETCURSOR(1)
          @ ROW(), COL() GET &CAMPO color "w+/R"
          READ
          SETCURSOR(nCursSave)
   ELSEIF TYPE ("&CAMPO")="N" 
          nCursSave:=SETCURSOR()
          SETCURSOR(1)
          @ ROW(), COL() GET &CAMPO color "w+/R*"
          READ
          SETCURSOR(nCursSave)
   ELSEIF TYPE ("&CAMPO")="M"
          ALERT("CAMPO PARA MEMORANDOS")
   ELSE
          ALERT("<DESCONHECIDO>;;CHAME O ADMINISTRADOR AGORA!")
ENDIF
ELSE
   ALERT('OPERA€ÇO INTERCEPTADA;;Seu n¡vel de senha n„o permite esta opera‡Æo.;;N¡vel m¡nimo nescess rio: "2"',,"w+/n")
ENDIF
IF cIndexVal != &(INDEXKEY(0))
   nRequest:=2
   keyboard CHR(4)
   ELSE
   nRequest:=1
ENDIF

RETURN nRequest
