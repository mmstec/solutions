****------------------------------------------------------------------------*
* INICIO DA FUNCAO USEREDE
*
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
****------------------------------------------------------------------------*
COR("MENU")

@ 03,50 Clear TO 09,75 
@ 03,50       TO 09,75 
SOMBRA(03,50,09,75) 

@ 04,52 SAY PADr("C:\"+CurDir(),20)
@ 05,52 SAY PADr("M quina:"+NetName(),20)
@ 06,52 SAY PADr("Usu rio:"+Rtrim(Operador),20)
@ 07,52 SAY PADr("Memoria:"+StrZero(Memory()),20)
@ 08,52 SAY PADr("Espa‡o :"+StrZero(DiskSpace()),20)

****------------------------------------------------------------------------*
MENSAGEM("Aguarde tentativa de acesso a "+ARQ)
          
          @ 24,00 SAY SPACE(10)           COLOR("w+/"+ALLTRIM(SUBS(CONTECOR[13],4)))
          @ 24,01 say REPL("Ü",9)         COLOR("N+/"+ALLTRIM(SUBS(CONTECOR[13],4)))
          
          FOR A=00 TO 10 step +3
               INKEY(.01)
               @ 24,01 say REPL("Ü",A)    COLOR("R+/"+ALLTRIM(SUBS(CONTECOR[13],4)))
          Next

DO WHILE (M->SEMPRE .OR. M->TEMPO>0)
   IF EXUSE
      USE &ARQ EXCLUSIVE
      
      * -> Uso exclusivo
   MENSAGEM(ARQ+" aberto em modo Mono-Usu rio!")
   ELSE
      USE &ARQ
      *
      * -> Uso compartilhado
   MENSAGEM(ARQ+" aberto em modo multi-usu rio")
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
*

