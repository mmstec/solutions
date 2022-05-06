
FUNCTION INCLUSAO
DO WHILE.T.
   SETCOLOR("N+/B,BG+/B,,,BG+/B")
   ENTRADA("MENU DE INCLUSåES")
   relevo(06, 56, 08, 73, .T.) // BOTOES
   relevo(09, 56, 11, 73, .T.) // BOTOES
   relevo(12, 56, 14, 73, .T.) // BOTOES
   relevo(18, 56, 20, 73, .T.) // BOTOES
   @ 07,58 PROMPT padR("1.Valores "  ,15)
   @ 10,58 PROMPT padR("2.Contas  "  ,15)
   @ 13,58 PROMPT padR("3.Caixas  "  ,15)
   @ 19,58 PROMPT padR("5.Principal" ,15)
   OPCMENU=1
   MENU TO CADMENU
   DO CASE
   CASE CADMENU=1 
        INCVALORES()
   CASE CADMENU=2
        *CONTAS()
        ALERT("INCLUSÇO NAO PERMITIDA;;Procure o administrador.")
   CASE CADMENU=3
        *CAIXAS()
        ALERT("INCLUSÇO NAO PERMITIDA;;Procure o administrador.")
   CASE CADMENU=4 .OR. LASTKEY()=27
        PRINCIPAL()
   ENDCASE
ENDDO
RETURN.T.

FUNCTION INCVALORES()
TELA=""
M->RESPOSTA="N"
AREAINC=ALIAS()
TELA=SAVESCREEN(00,00,24,80)
SELE 3
USE DBVALOR INDEX idVALOR1,idVALOR2,idVALOR3,idVALOR4
SELE 3
SET ORDER TO 1
DO WHILE.T.
   IF LASTKEY()=27
      EXIT
   ENDIF
   M->Data      :=ctod("  /  /  ")
   M->CodConta  :=SPACE(2)
   M->CodCaixa  :=SPACE(2)
   M->Valor     :=0
   M->Comissao  :=0
   M->PERCENTUAL:=0
   M->PG        :="S"
   M->GRAVA     :=SPACE(1)
   SET CURSOR ON
   RELEVO(05, 05, 21, 54,.F.,,2) // tela EQUERDA
   RELEVO(06, 06, 08, 17,.T.,,2) // BARRA DE TITULO1
   RELEVO(06, 18, 08, 53,.F.,,1) // BARRA DE TITULO2
   RELEVO(09, 18, 17, 53,.T.,,1) // tela EQUERDA
   RELEVO(09, 18, 20, 53,.T.,,1) // BARRA DE INFERIOR
   @ 07,07 SAY PADC("MODULO",09)               color "W+/B"
   @ 07,19 SAY PADC("I N C L U S å E S",34)  color "W+/R"

   @ 10,08 say PADl("Data "    ,10)           COLOR "W/B"
   @ 12,08 say PADl("Conta "   ,10)           COLOR "W/B"
   @ 14,08 say PADl("Caixa "   ,10)           COLOR "W/B"
   @ 16,08 say PADl("Valor "   ,10)           COLOR "W/B"
   @ 18,08 say PADl("ComissÆo ",10)           COLOR("N+ /B")
   @ 18,19 say repl("*",33)                   COLOR("N+ /N")
   @ 19,19 say repl("*",33)                   COLOR("N+ /N")

   @ 10,19 GET M->DATA valid !empty(M->DATA)       COLOR("W+/N,W+/R")
   @ 12,19 GET M->CODCONTA valid VRFCONTA(12,22)   COLOR("W+/N,W+/R")
   @ 14,19 GET M->CODCAIXA valid VRFCAIXA(14,22) .AND.;
                                 VERI001(DTOS(M->DATA)+M->CODCONTA+M->CODCAIXA) COLOR("W+/N,W+/R")
   @ 16,19 GET M->VALOR PICT "@E 9,999,999,999.99" COLOR("W+/N,W+/R")
   
   READ
   IF LASTKEY()=27
      EXIT
   ENDIF
   ******************************************************
   M->COMISSAO  :=COMISSAO(M->VALOR,M->CODCONTA,M->CODCAIXA)
   M->PERCENTUAL:=(M->COMISSAO/M->VALOR)*100
   ******************************************************
   aExt := {}
   aExt := EXTENSO(M->COMISSAO,alltrim(str(m->comissao,10,2))+" (",")",2,33,"-x",3)
   FOR I= 1 to LEN(aExt)
       @ 17+1,08 say PADL("ComissÆo ",10) COLOR("BG /B")
       @ 17+i,19 say ALLTRIM(aExt[i])     COLOR("BG+/B")
   NEXT
   **
   M->RESPOSTA=GRAVAV()
   IF M->RESPOSTA="N"
      LOOP
   ENDIF
   dBvalor->(DBAPPEND())
   dBvalor->DATA    =M->Data
   dBvalor->LKCONTA =M->CODConta
   dBvalor->LKCAIXA =M->CODCaixa
   dBvalor->VALOR   =M->Valor
   dBvalor->COMISSAO=M->COMISSAO
   dBvalor->LKPERC  =M->PERCENTUAL
   dBvalor->LKRESP  =M->PG
   Tone(300,5)
   RELEVO(05, 55, 21, 74,.F.,,2) // tela DIREITA ENTERNA
   RELEVO(09, 56, 20, 73,.T.,,1) // tela DIREITA INTERNA
   @ 07,57 SAY PADc("MOVIMENTO GRAVADO"                  ,16)  COLOR("RG+/B")
   @ 10,57 say PADr(DBDATA(DATA)                         ,16)  COLOR("W+ /B")
   @ 12,57 say PADr(LKCAIXA+": "+NCAIXA(LKCAIXA)         ,16)  COLOR("W+ /B")
   @ 13,57 say PADr(LKCONTA+": "+NCONTA(LKCONTA)         ,16)  COLOR("W+ /B")
   @ 14,57 say PADr("R$:"+TRANSF(VALOR,"@E 99,999.99")   ,16)  COLOR("W+ /B")
   @ 15,57 say PADr("R%:"+TRANSF(COMISSAO,"@E 99,999.99"),16)  COLOR("W+ /B")
ENDDO
RESTSCREEN(00,00,24,80,TELA)
IF M->RESPOSTA="S"
   dBcompacta(16,40)
ENDIF
SELECT(AREAINC)
RETURN
