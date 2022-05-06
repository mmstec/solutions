FUNCTION SENHA
*
*
* -> Funcao para entrada e checagem de senha
MENSAGEM("Digite o nome do operador")
@ 07,16,17,62 box "ÛßÛÛÛÜÛÛÛ" COLOR("BG+/bG")
sombra(07,16,17,62)
* Acesso ao sistema
SETCOLOR("W+/bG")
@ 10,22 CLEAR TO 14,56
@ 10,22 TO 14,56                      COLOR("BG+/bG")
@ 11,24 SAY "Operador :"              COLOR("W+/bG")
@ 13,24 SAY "Senha    : [úúúúúúúúú]"  COLOR("W+/bG")
M->SENHA=""
M->OPERADOR=SPACE(20)
M->TEC=0
****
SET COLOR TO BG+/BG,BG+/BG,,,N/bg
@ 11,35 GET M->OPERADOR PICT "@!" VALID .NOT. EMPTY(M->OPERADOR)
SET CURSOR ON
READ
SET CURSOR OFF
MENSAGEM("Digite a senha para acesso ao sistema")
SETCOLOR("W+/BG")
@ 13,35 SAY "[úúúúúúúúú]"              COLOR("W+/bG")
FOR M->P_SENHA=36 TO 44
   M->TEC=INKEY(0)
   IF M->TEC=8
      IF M->P_SENHA>36
         M->P_SENHA=M->P_SENHA-1
         @ 13,M->P_SENHA SAY "ú"
         M->SENHA=SUBS(M->SENHA,1,LEN(M->SENHA)-1)
      ENDIF
      M->P_SENHA=M->P_SENHA-1
   ELSE
      M->SENHA=M->SENHA+CHR(M->TEC)
      IF M->TEC=13 .OR. M->TEC=27
         EXIT
      ENDIF
      @ 13,M->P_SENHA SAY "þ"
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
          @ 23,01 say REPL("Ü",78) COLOR("N/"+ALLTRIM(SUBS(CONTECOR[13],4)))
          *
          for a=01 to 78 step +1
               inkey(.01)
               @ 23,00+A say "Ü"   COLOR("BG+/"+ALLTRIM(SUBS(CONTECOR[13],4)))
               *
               @ 17,33 to 19,44        COLOR("B+/"+ALLTRIM(SUBS(CONTECOR[13],4)))
               SOMBRA(17,33,19,44)
               @ 18,34 SAY A           COLOR("W+/"+ALLTRIM(SUBS(CONTECOR[13],4)),"w+/B")
               *
          Next
          Tone(800,1)
          @ 18,38 SAY PADL("100 %",06) COLOR("RG+/"+ALLTRIM(SUBS(CONTECOR[13],4)))
          *
Tone(500,3)
USE
SET CURSOR ON
RETURN M->NIVEL

