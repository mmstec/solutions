* ////////////////////////////////////////////////////////////////////*
* INICIO DA FUNCAO SENHA
*
FUNCTION SENHA
*
*
* -> Funcao para entrada e checagem de senha
COR("TITULO")
@ 24,00 SAY SPACE(80)
MENSAGEM("Digite seu nome")
SOMBRA(16,02,16,32)
SETCOLOR("W+/bG")
@ 16,00 SAY "Nome    "               COLOR("w+/n")
@ 17,00 SAY "Senha     [תתתתתתתתת]"   COLOR("W+/n")
SOMBRA(16,02,16,32)
M->SENHA=""
M->OPERADOR=SPACE(20)
M->TEC=0
****
SET COLOR TO G+/N,G+/N,,,G+/N
@ 16,12 GET M->OPERADOR PICT "@!" VALID .NOT. EMPTY(M->OPERADOR)
SET CURSOR ON
READ
SET CURSOR OFF
MENSAGEM("Digite a senha para acesso ao sistema")
SETCOLOR("G+/N")
SOMBRA(15,02,15,32)
@ 17,00 SAY "Senha     [תתתתתתתתת]"   COLOR("W+/N")
@ 17,13 SAY "תתתתתתתתת"                 COLOR("N+*/N")
FOR M->P_SENHA=13 TO 21
   M->TEC=INKEY(0)
   IF M->TEC=8
      IF M->P_SENHA>13
         M->P_SENHA=M->P_SENHA-1
         @ 17,M->P_SENHA SAY "ת"        COLOR("G+*/n")
         M->SENHA=SUBS(M->SENHA,1,LEN(M->SENHA)-1)
      ENDIF
      M->P_SENHA=M->P_SENHA-1
   ELSE
      M->SENHA=M->SENHA+CHR(M->TEC)
      IF M->TEC=13 .OR. M->TEC=27
         EXIT
      ENDIF
      @ 17,M->P_SENHA SAY CHR(4)
      ENDIF
NEXT
M->SENHA=UPPER(M->SENHA)
COD_FICA(@SENHA)
M->NOM_ARQ="MFB.SNH"
IF .NOT. FILE(M->NOM_ARQ)
   SET CURSOR OFF
   BEEP()
   MENSAGEM("Arquivo de senhas n„o se encontra dispon¡vel",3)
   SET COLOR TO W
   SET CURSOR ON
   CLEAR
   QUIT
ENDIF
IF .NOT. USEREDE(M->NOM_ARQ,.F.,10)
   BEEP()
   MENSAGEM("Acesso mal sucedido ao arquivo",3)
   RETURN .F.
ENDIF
GOTO TOP
M->NIVEL=" "
DO WHILE .NOT. EOF()
   IF CODSENHA==M->SENHA .AND. USUARIO==M->OPERADOR
      M->NIVEL=ACESSO
      EXIT
   ENDIF
   SKIP
ENDDO
MENSAGEM("Aguarde tentativa de acesso aos arquivos")
          COR("TITULO")
          @ 23,00,23,80 box "         "
          @ 23,01 say REPL(chr(7),78) COLOR("N/"+ALLTRIM(SUBS(CONTECOR[13],4)))
          *
          FOR A=01 TO 78 step +5
               INKEY(0.01)
               SETCOLOR("RG+/"+ALLTRIM(SUBS(CONTECOR[13],4)))
               @ 23,00+A say chr(7);@ 23,01+A say chr(7);@ 23,02+A say chr(7)   
               @ 23,03+A say chr(7);@ 23,04+A say chr(7);@ 23,05+A say chr(7)
               *
               @ 19,00 TO 21,11        COLOR("B+/"+ALLTRIM(SUBS(CONTECOR[13],4)))
               SOMBRA(19,00,21,11)
               @ 20,01 SAY A           COLOR("W+/"+ALLTRIM(SUBS(CONTECOR[13],4)),"w+/B")
          NEXT
          TONE(800,1)
          @ 20,01 SAY PADL("100 %",10) COLOR("RG+/"+ALLTRIM(SUBS(CONTECOR[13],4)))
          *
Tone(500,3)
USE
SET CURSOR ON
RETURN M->NIVEL
*
* INICIO DA FUNCAO SENHA
* ////////////////////////////////////////////////////////////////////*
