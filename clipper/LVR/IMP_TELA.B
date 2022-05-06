* -> FUNCAO QUE IMPRIME NA TELA
*
FUNCTION IMP_TELA
*
* Local: c:\miro\IMP_TELA.B
*
PARA ARQ_PRN,TAM_LIN,MARG_ESQ
IF PCOUNT()=2
   M->MARG_ESQ=0
ENDIF
M->MARG_ESQ=M->MARG_ESQ+1
MENSAGEM("Aguarde processamento")
SELE 100
PUBL QUAN_REG,ULT_POS
M->ARQ_PRN1=M->ARQ_PRN+"."+SUBS(STR(M->EX_T+1000,4),2)
M->ARQ_PRN2=M->ARQ_PRN+"."+SUBS(STR(M->EX_T+1100,4),2)
CREATE ARQ_STRU
IF .NOT. USEREDE("ARQ_STRU",.T.,10)
   @ 0,0 SAY ""
   ? CHR(7)
   MENSAGEM("Nao foi possivel criar arquivo, tente novamente",5)
   RETURN .F.
ENDIF
IF .NOT. ADIREG(0)
   @ 0,0 SAY ""
   ? CHR(7)
   MENSAGEM("Nao foi possivel criar arquivo, tente novamente",5)
   USE
   RETURN .F.
ENDIF
REPLACE FIELD_NAME WITH "LI_NHA",FIELD_TYPE WITH "C"
REPLACE FIELD_LEN  WITH M->TAM_LIN+1,FIELD_DEC WITH 0
CREATE &ARQ_PRN2 FROM ARQ_STRU
USE
ERASE ARQ_STRU.DBF
IF .NOT. USEREDE(ARQ_PRN2,.T.,10)
   @ 0,0 SAY ""
   ? CHR(7)
   MENSAGEM("Nao foi possivel acesso, tente novamente",5)
   RETURN .F.
ENDIF
APPEND FROM &ARQ_PRN1 SDF
M->QUAN_REG=LASTREC()
IF M->QUAN_REG=0
   M->QUAN_REG=1
ENDIF
GOTO TOP
JANELA(LIN_MENU+3,02,21,77)
@ LIN_MENU+4,77 SAY CHR(30)  COLOR("R+/"+ALLTRIM(SUBS(CONTECOR[5],4)))
@ 20,77 SAY CHR(31)          COLOR("R+/"+ALLTRIM(SUBS(CONTECOR[4],4)))
IF M->TAM_LIN<72
   DECLARE EDI_TAR[1]
   EDI_TAR[1]="SUBS(LI_NHA,M->MARG_ESQ)"
ELSE
   IF INT(M->TAM_LIN/36)=M->TAM_LIN/36
      M->NUM_COL=M->TAM_LIN/36
   ELSE
      M->NUM_COL=INT(M->TAM_LIN/36)+1
   ENDIF
   DECLARE EDI_TAR[M->NUM_COL]
   M->X=1
   DO WHILE M->X<M->NUM_COL
      M->NUM_MAT=(M->X*36)-34
      EDI_TAR[M->X]="SUBS(LI_NHA,"+STR(M->NUM_MAT,3)+",36)"
      M->X=M->X+1
   ENDDO
   M->NUM_MAT=(M->X*36)-34
   EDI_TAR[M->X]="SUBS(LI_NHA,"+STR(M->NUM_MAT,3)+")+SPACE("+STR((M->NUM_COL*36)-M->TAM_LIN,2)+")"
ENDIF
KEYBOARD CHR(65)
M->ULT_POS=LIN_MENU+5
MENSAGEM("Tecle <ESC> para sair")
M->SOS_MENU="RELATORIO"
SETCOLOR(CONTECOR[4]+","+CONTECOR[7])
SETCOLOR ("R+*/N")
@ 05,03 clear to 20,76
**                         
Tec1="€ﬂﬂ€ﬂﬂ€ €ﬂﬂ€ﬂﬂ€ €ﬂﬂﬂﬂﬂ€   ‹  Inform†tica Ltda"
Tec2="€  €  € €  €  € €‹‹‹‹‹‹‹ ﬂ€ﬂ €ﬂﬂﬂﬂﬂ€ €ﬂﬂﬂﬂﬂﬂ€"
Tec3="€€ €  € €€ €  € ‹     €€  €€ €€ﬂﬂﬂﬂﬂ €€     ‹"
Tec4="€€ €  € €€ €  € ﬂﬂﬂﬂﬂﬂﬂﬂ  ﬂﬂ ﬂﬂﬂﬂﬂﬂﬂ ﬂﬂﬂﬂﬂﬂﬂﬂ"
Tec5="ﬂﬂ    ﬂﬂﬂﬂ    ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ"
**
SET CURSOR OFF
FOR CONTADOR=0 TO LEN(tec1)+5 STEP +5
  SETCOLOR("B+ /N")
  @ 10,(80-LEN(tec1))/2 Say PADR(SUBSTR(tec1,1,CONTADOR),LEN(tec1)) 
  SETCOLOR("B  /N")
  @ 11,(80-LEN(tec2))/2 Say PADC(SUBSTR(tec2,1,CONTADOR),LEN(tec2)) 
  SETCOLOR("BG /N")
  @ 12,(80-LEN(tec3))/2 SAY PADL(SUBSTR(tec3,1,CONTADOR),LEN(tec3)) 
  SETCOLOR("BG+/N")         
  @ 13,(80-LEN(tec4))/2 SAY PADC(SUBSTR(tec4,1,CONTADOR),LEN(tec4)) 
  SETCOLOR("W  /N")
  @ 14,(80-LEN(tec5))/2 SAY PADR(SUBSTR(tec5,1,CONTADOR),LEN(tec5)) 
  INKEY(0.01)
NEXT
INKEY(1)  
FOR CONTADOR=LEN(tec1)+5 TO 0 STEP -5
  SETCOLOR("B+ /N")
  @ 10,(80-LEN(tec1))/2 Say PADR(SUBSTR(tec1,1,CONTADOR),LEN(tec1)) 
  SETCOLOR("B  /N")
  @ 11,(80-LEN(tec2))/2 Say PADC(SUBSTR(tec2,1,CONTADOR),LEN(tec2)) 
  SETCOLOR("BG /N")
  @ 12,(80-LEN(tec3))/2 SAY PADL(SUBSTR(tec3,1,CONTADOR),LEN(tec3)) 
  SETCOLOR("BG+/N")         
  @ 13,(80-LEN(tec4))/2 SAY PADC(SUBSTR(tec4,1,CONTADOR),LEN(tec4)) 
  SETCOLOR("W  /N")
  @ 14,(80-LEN(tec5))/2 SAY PADR(SUBSTR(tec5,1,CONTADOR),LEN(tec5)) 
  INKEY(0.01)
NEXT
SET CURSOR ON
**
@ 06,05 say PADC("M.F.B. Material de ConstruáÑo Ltda.",69)      Color ("w+/N")
DTTA(07,00)
@ 08,04 say REPL("ƒ",72)             Color ("N+/N")
@ 19,04 say repl("ƒ",72)             Color ("N+/N")
@ 20,05 say CHR(9)+" Rec"            Color ("N+*/N")
@ 20,20 say CHR(17)+CHR(17)+" Right" Color ("N+/N")
@ 20,35 say CHR(16)+CHR(16)+" Low"   Color ("N+/N")
@ 20,50 say CHR(16)+" Play"          Color ("N+/N")
@ 20,65 say CHR(19)+" Pause"         Color ("N+/N")
@ 06,05 say "< Read >"               Color ("N+*/N")
@ 21,03 say repl("ﬂ",74)             COLOR("N/"+ALLTRIM(SUBS(CONTECOR[4],4)))
*
COR("TELA DE APRESENTACAO")
DBEDIT(LIN_MENU+8,04,18,75,EDI_TAR,"FUN_IMP","","","","")
M->SOS_MENU=" "
USE
ERASE &ARQ_PRN1
ERASE &ARQ_PRN2
RELEASE QUAN_REG,ULT_POS
