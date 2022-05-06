FUNCTION INCLUSAO
Tone(300,1)
DO WHILE.T.
   SETCOLOR("N+/B,BG+/B,,,BG+/B")
   ENTRADA("MENU DE INCLUSåES")
   relevo(06, 56, 08, 73, .T.) // BOTOES
   relevo(09, 56, 11, 73, .T.) // BOTOES
   relevo(12, 56, 17, 73, .T.) // BOTOES
   relevo(18, 56, 20, 73, .T.) // BOTOES
   @ 07,58 PROMPT padr("1.Incluir " ,15)
   @ 10,58 PROMPT padr("2.Excluir " ,15)
   @ 19,58 PROMPT padr("5.Retornar" ,15)
   incMENU=1
   MENU TO incMENU
   DO CASE
   CASE incMENU=1
        INCCAD()
   CASE incMENU=2
        *DEMCAD()
        alert("Exclusao ainda nao disponivel") 
   CASE incMENU=3 .OR. LASTKEY()=27
        PRINCIPAL()
   ENDCASE
ENDDO
RETURN.T.

FUNCTION INCCAD
Tone(300,1)
IF M->NIVEL>=1
*************
 M->RESPOSTA="N"
 TELA=""
 TELA=SAVESCREEN(00,00,24,80)
 SELE 2
 USE DBCAD INDEX idCAD1,idCAD2
 SELE 2
 SET ORDER TO 1
 DO WHILE.T.
    IF LASTKEY()=27
       EXIT
    ENDIF
    SET CURSOR ON 
    RELEVO(05, 05, 21, 54,.F.,,2) // tela EQUERDA
    RELEVO(06, 06, 08, 53,.T.,,2) // BARRA DE TITULO
    RELEVO(09, 18, 20, 53,.T.,,1) // tela EQUERDA
    M->v1Data      :=DATE()
    M->v1CODIGO    :=SPACE(8)
    M->v1NOME      :=SPACE(45)
    M->v1RG        :=SPACE(15)
    M->v1CPF       :=SPACE(15)
    M->v1CTRABN    :=SPACE(10)
    M->v1CTRABS    :=SPACE(6)
    M->v1NASCI     :=CTOD("")
    M->v1ENDE      :=SPACE(45)
    M->v1FONE      :=SPACE(15)
    M->v1OBS1      :=SPACE(45);M->v1OBS2      :=SPACE(45)
    M->v1OBS3      :=SPACE(45);M->v1OBS4      :=SPACE(45)
    M->v2EMPRESA   :=SPACE(45)
    M->v2ENDE      :=SPACE(45)
    M->v2FONE      :=SPACE(15)
    M->v2CARGO     :=SPACE(15)
    M->v2SALARIO   :=0
    M->v2ADMISSAO  :=CTOD("")
    M->v2DEMISSAO  :=CTOD("")
    M->v2MOTIVO    :=SPACE(45)
    @ 07,07 SAY PADC("INCLUSAO (DADOS PESSOAIS)",45)  color "W+/R"
    @ 10,08 SAY padL("Data:"     ,10)                     color "Bg+/b"
    @ 11,08 SAY padL("Nome:"     ,10)                     color "Bg+/b"
    @ 12,08 say padL("R.G.:"     ,10)                     color "Bg+/b"
    @ 13,08 say padL("C.P.F.:"   ,10)                     color "Bg+/b"
    @ 14,08 say padL("C.Trab.:"  ,10)                     color "Bg+/b"
    @ 15,08 say padL("Nascim.:"  ,10)                     color "Bg+/b"
    @ 16,08 say padL("Endere‡o:" ,10)                     color "Bg+/b"
    @ 17,08 say padL("Fone.:"    ,10)                     color "Bg+/b"
    @ 18,08 say padL("Obs.:"     ,10)                     color "Bg+/b"
    ***
    @ 10,20 SAY M->v1DATA      picture "@!"  color "W+/B,W+/bG"
    @ 11,20 get M->v1NOME  picture "@!"  color "W+/B,W+/bG"
    @ 12,20 get M->v1RG    picture "@!"  color "W+/B,W+/bG"
    @ 13,20 get M->v1CPF   picture "@!"  color "W+/B,W+/bG"
    @ 14,20 get M->v1CTRABN   picture "@!"  color "W+/B,W+/bG"
    @ 14,35 get M->v1CTRABS   picture "@!"  color "W+/B,W+/bG"
    @ 15,20 get M->v1NASCI picture "@!"  color "W+/B,W+/bG"
    @ 16,20 get M->v1ENDE  picture "@!"  color "W+/B,W+/bG"
    @ 17,20 get M->v1FONE  picture "@!"  color "W+/B,W+/bG"
    READ
    ALERT(PADC("A T E N C A O",40)+;
      ";"+"EM OBSERVACOES, INFORME:                          ;"+; 
      ";"+" - O ESTADO CIVIL DO CANDIDADO(CASADO OU SOLTEIRO);"+;
      ";"+" - O GRAU DE ESCOLARIDADE,                        ;"+;
      ";"+" - QUALIFICACOES PROFISSIONAIS,                   ;"+;
      ";"+" - CURSOS (DATILOGRAFIA, COMPUTACAO BASICA, ETC.) ;;",,"RG+/N")
    @ 18,20 get M->v1OBS1 picture "@!"  color "W+/B,W+/bG"
    @ 19,20 get M->v1OBS2 picture "@!"  color "W+/B,W+/bG"
    @ 20,20 get M->v1OBS3 picture "@!"  color "W+/B,W+/bG"
    @ 21,20 get M->v1OBS4 picture "@!"  color "W+/B,W+/bG"
    READ
    TONE(500)
    RELEVO(05, 05, 21, 54,.F.,,2) // tela EQUERDA
    RELEVO(06, 06, 08, 53,.T.,,2) // BARRA DE TITULO
    RELEVO(09, 18, 18, 53,.T.,,1) // tela EQUERDA
    @ 07,07 SAY PADC("INCLUSAO (DADOS DO ULTIMO TRABALHO)",45)  color "W+/R"
    @ 10,08 SAY padL("EMPRESA:"  ,10)                     color "Bg+/b"
    @ 11,08 SAY padL("ENDERECO:" ,10)                     color "Bg+/b"
    @ 12,08 say padL("FONE:"     ,10)                     color "Bg+/b"
    @ 13,08 say padL("CARGO:"    ,10)                     color "Bg+/b"
    @ 14,08 say padL("SALARIO:"  ,10)                     color "Bg+/b"
    @ 15,08 say padL("ADMISSAO:" ,10)                     color "Bg+/b"
    @ 16,08 say padL("DEMISSAO:" ,10)                     color "Bg+/b"
    @ 17,08 say padL("MOTIVO:"   ,10)                     color "Bg+/b"
    ***
    @ 10,20 get M->v2EMPRESA  picture "@!"  color "W+/B,W+/bG"
    @ 11,20 get M->v2ENDE     picture "@!"  color "W+/B,W+/bG"
    @ 12,20 get M->v2FONE     picture "@!"  color "W+/B,W+/bG"
    @ 13,20 get M->v2CARGO    picture "@!"  color "W+/B,W+/bG"
    @ 14,20 get M->v2SALARIO  picture "@Z 999,999.99"  color "W+/B,W+/bG"
    @ 15,20 get M->v2ADMISSAO picture "@!"  color "W+/B,W+/bG"
    @ 16,20 get M->v2DEMISSAO picture "@!"  color "W+/B,W+/bG"
    @ 17,20 get M->v2MOTIVO   picture "@!"  color "W+/B,W+/bG"
    READ
    TONE(500)
    TONE(600)
    TONE(300)
    IF LASTKEY()=27
       EXIT
    ENDIF
    M->RESPOSTA=GRAVAV()
    IF M->RESPOSTA="N"
        LOOP
    ENDIF
    dBCAD->(DBAPPEND())
    ////////////////////////////////////////
    REPLACE c1DATA       WITH M->v1Data  
    REPLACE c1CODIGO     WITH M->v1CODIGO
    REPLACE c1NOME       WITH M->v1NOME
    REPLACE c1RG         WITH M->v1RG
    REPLACE c1CPF        WITH M->v1CPF
    REPLACE c1CTRABN     WITH M->v1CTRABN
    REPLACE c1CTRABS     WITH M->v1CTRABS
    REPLACE c1NASCI      WITH M->v1NASCI
    REPLACE c1ENDE       WITH M->v1ENDE
    REPLACE c1FONE       WITH M->v1FONE
    REPLACE c1OBS        WITH M->v1OBS1+chr(4)+chr(10)+M->v1OBS2+chr(4)+chr(10)+M->v1OBS3+chr(4)+chr(10)+M->v1OBS4
    ////////////////////////////////////////
    REPLACE c2EMPRESA    WITH M->v2EMPRESA
    REPLACE c2ENDE       WITH M->v2ENDE
    REPLACE c2FONE       WITH M->v2FONE
    REPLACE c2CARGO      WITH M->v2CARGO
    REPLACE c2SALARIO    WITH M->v2SALARIO
    REPLACE c2ADMISAO    WITH M->v2ADMISSAO
    REPLACE c2DEMISAO    WITH M->v2DEMISSAO
    REPLACE c2MOTIVO     WITH M->v2MOTIVO
    ////////////////////////////////////////
    RELEVO(05, 55, 21, 74,.F.,,2) // tela DIREITA ENTERNA
    RELEVO(09, 56, 20, 73,.T.,,2) // tela DIREITA INTERNA
    @ 07,57 SAY PADc("INCLUSÇO ANTERIOR"                  ,16)  COLOR "W+*/B"
    @ 10,57 say PADr(ALLTRIM(V1NOME)                                ,16)  COLOR("W+ /B")
    @ 11,57 say PADr(ALLTRIM(V1ENDE)                            ,16)  COLOR("W+ /B")
    @ 12,57 say PADr(ALLTRIM(V1RG)                                  ,16)  COLOR("W+ /B")
    @ 13,57 say PADr(ALLTRIM(V1CPF)                                 ,16)  COLOR("W+ /B")
    @ 14,57 say PADr(ALLTRIM(V1CTRABN)+"-"+ALLTRIM(V1CTRABS)  ,16)  COLOR("W+ /B")
    RELFICHA()
 ENDDO
 RESTSCREEN(00,00,24,80,TELA)
 IF M->RESPOSTA="S"
    dBcompacta(16,40)
 ENDIF
*************
ELSE
   ALERT('OPERA€ÇO INTERCEPTADA;;Seu n¡vel de senha n„o permite esta opera‡Æo.;;N¡vel m¡nimo nescess rio: "1"',,"w+/n")
ENDIF
RETURN.T.
