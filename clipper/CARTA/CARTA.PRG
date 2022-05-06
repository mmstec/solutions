///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
     CLS
     SETCANCEL(.F.)               // (.F.) desativa ALT-C/BREAK
     set epoch to 1950            // prepara datas para o terceiro milˆnio
     set date format to "dd,mm,yyyy"
     set date brit
     set cursor on
     AUTOR        := "(C) Marcos Morais de Sousa - 1995/"+TRAN(YEAR(DATE()),"@E 9999")
     SISTEMA      := "MMStec EMISSOR DE CARTAS EXPRESSAS (R) - vers„o "+Dtos(directory(procname()+".exe")[1,3])
     FUNCIONARIO  := padr("VALDIR CARLOS DE JESUS BARRETO",40)
     CARGO        := padr("SOCIO-GERENTE",40)
     EMPRESA      := padr("MFB MATERIAL DE CONSTRU€ÇO LTDA",40)
     DESTINATARIO := padr("CAIXA ECONOMICA FEDERAL S/A",40)
     CONTATO      := SPACE(40)
     MOTIVO       := SPACE(40)
     REFERENTE0   := SPACE(40)
     REFERENTE1   := SPACE(40)
     REFERENTE2   := DTOC(DATE())
     REFERENTE3   := SPACE(40)
     REFERENTE4   := SPACE(40)
     VALOR        := 0
     do while .T.
          @ 01,00 say padc(sistema,80)  COLOR "BG+/N"
          @ 02,00 say padc(autor,80)    COLOR "BG /N"
          @ 04,05 say "RESPONSAVEL   :" GET FUNCIONARIO  PICT "@!" VALID !EMPTY(FUNCIONARIO)   COLOR "W+/N,W+/B"
          @ 05,05 say "CARGO/FUNCAO  :" GET CARGO PICT "@!" VALID !EMPTY(CARGO)                COLOR "W+/N,W+/B"
          READ
          @ 05,05 say "EMPRESA       :" GET EMPRESA  PICT "@!" VALID !EMPTY(EMPRESA)           COLOR "W+/N,W+/B"
          READ
          @ 06,05 say "DESTINATARIO  :" GET DESTINATARIO PICT "@!" VALID !EMPTY(DESTINATARIO)  COLOR "W+/N,W+/B"
          @ 07,05 say "CONTATO       :" GET CONTATO PICT "@!"                                  COLOR "W+/N,W+/B"
          @ 08,05 SAY REPL("-",70)      COLOR "W/N"
          @ 10,05 say "PEDIDO/ORDEM  :" GET REFERENTE0 PICT "@!" VALID !EMPTY(REFERENTE0)      COLOR "W+/N,W+/B"
          @ 11,05 say "MOTIVO        :" GET MOTIVO     PICT "@!" VALID !EMPTY(MOTIVO)          COLOR "W+/N,W+/B"
          @ 14,05 say "NOSSO NUMERO  :" GET REFERENTE1 PICT "9999999999.9" VALID !EMPTY(REFERENTE1)   COLOR "W+/N,W+/B"
          @ 15,05 say "VENCIMENTO    :" GET REFERENTE2 PICT "99/99/9999" VALID !EMPTY(REFERENTE2)     COLOR "W+/N,W+/B"
          @ 16,05 say "VALOR         :" GET VALOR PICT "@E 9,999,999,999.99" VALID !EMPTY(VALOR)      COLOR "W+/N,W+/B"
          @ 17,05 say "SACADO        :" GET REFERENTE3 PICT "@!" VALID !EMPTY(REFERENTE3)      COLOR "W+/N,W+/B"
          @ 18,05 say "DOCUMENTO     :" GET REFERENTE4 PICT "@!" VALID !EMPTY(REFERENTE4)      COLOR "W+/N,W+/B"
          set cursor on
          read
          set cursor off
          M->RESPOSTA=PERGUNTA("CONFIRMA IMPRESSÇO?")
             DO CASE
                CASE M->RESPOSTA="N" // NAO IMPRIMIR E RETORNAR
                     CLS
                     LOOP
                CASE M->RESPOSTA="S" // IMPRIMIR
                CASE M->RESPOSTA="CANCELA" // NAO IMPRIMIR E SAIR P/ SO
                     CLS
                     ?TIME()+" IMPRESSAO ABORTADA PELO OPERADOR"
                     QUIT
             ENDCASE
          FUNCIONARIO  := ALLTRIM(FUNCIONARIO)
          CARGO        := ALLTRIM(CARGO)
          EMPRESA      := ALLTRIM(EMPRESA)
          DESTINATARIO := ALLTRIM(DESTINATARIO)
          REFERENTE    := "NOSSO NUMERO "+ALLTRIM(REFERENTE1)+", VENCIMENTO "+ALLTRIM(REFERENTE2)+;
                          ", SACADO "+ALLTRIM(REFERENTE3)+", "+ALLTRIM(REFERENTE4)
          VALOR        := VALOR
          GRAVA() // GRAVA EM DISCO OS DADOS DA CARTA
          INITEXTO:="Solicitamos o cumprimento da "+alltrim(REFERENTE0)+" pelo motivo "+alltrim(motivo)
          INITEXTO:=INITEXTO+" referente ao documento de "+REFERENTE+" no valor de R$"+alltrim(transf(valor,[@E 9,999,999,999.99]))+"("
          FIMTEXTO:=")."
          aExt := {}                    
          aExt := EXTENSO(VALOR,INITEXTO,FIMTEXTO,10,60,".x",3)
          set printer on
          set console off
          set device to printer
          if (!isprinter())
              alert("A V I S O;; A IMPRESSORA ESTA DESLIGADA OU APRESENTA PROBLEMAS."+;
                              ";VERIFIQUE O OCORRIDO E TENTE NOVAMENTE")
              set devi to screen
              set printer off
              set console on
              LOOP
              CLS
              else
              ALERT("Prepare a  impressora!",{ PADC("ENTER",7) })
              LINHA=22
              @ linha-07,10 SAY PADR(DATA()+" "+SUBSTR(TIME(),1,5),60)
              @ linha-06,10 SAY "CEP 45200-000 JEQUIE/BA"
              @ linha-03,10 SAY PADR("DE  :"+ALLTRIM(EMPRESA),60)
              @ linha-02,10 SAY PADR("PARA:"+ALLTRIM(DESTINATARIO),60)
              @ linha-01,10 SAY PADR("A/C.:"+alltrim(CONTATO),60)
              FOR I = 1 to LEN(aExt)
                  @ I+LINHA, 10 say aExt[i]
              NEXT
              @ linha+i+1 ,10 say padr("Sem mais nada a expor e tendo como certo o deferimento deste",60)
              @ linha+i+2 ,10 say padr("documento, firmo-o.",60)
              @ linha+i+5 ,10 say padr("Atenciosamente:",60)

              @ linha+i+7 ,10 say padr(REPL("_",LEN(EMPRESA)+1),60)
              @ linha+i+8 ,10 say padr(FUNCIONARIO,60)
              @ linha+i+9 ,10 say padr(CARGO,60)
              @ linha+i+10,10 say padr(EMPRESA,60)
         text

          IMPORTANTE!
          Documento valido apenas se carimbado e/ou timbrado, alem de,
          devidamente assinado por pessoa credenciada.
         endtex
          @ ROW()+1,10 SAY PADr("- DOC. Impresso na maquina "+alltrim(netname())+" em "+dtoc(date())+" "+SUBSTR(TIME(),1,5),60)
          endif
          eject
          set devi to screen
          set printer off
          set console on
          EXIT
ENDDO
QUIT

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

          INITEXTO:="Solicitamos o cumprimento da "+alltrim(REFERENTE0)+" pelo motivo "+alltrim(motivo)
          INITEXTO:=INITEXTO+" referente ao documento de "+REFERENTE+" no valor de R$"+alltrim(transf(valor,[@E 9,999,999,999.99]))+"("
          FIMTEXTO:=")."
          aExt := {}                    
          aExt := EXTENSO(VALOR,INITEXTO,FIMTEXTO,10,60,".x",3)

/***************************************************************************
 *
 * Fun‡„o para retornar valor por extenso
 *
 * nValor    := Valor a ser transformado em extenso
 * cTextoIni := Texto que ser  antecedido ao valor por extenso
 * cTextoFim := Texto que ser  precedido ao valor por extenso
 * nLinhas   := Quantidade de linhas que o extenso ir  usar.
 * nLargura  := Largura da linha do extenso
 * cResto    := Caracteres de preenchimento no final do extenso
 * nMoeda    := N£mero da moeda corrente ou seja 1 = CRUZEIRO,2 = DOLAR,3 = REAL
 ***************************************************************************/
FUNCTION EXTENSO(nValor,cTextoIni,cTextoFim,nLinhas,nLargura,cRESTO,nMoeda)
PRIVATE cTexto := ""
aTexto := {}
nInicio := 1
IF PCOUNT() == 0 ; RETURN {"X"} ; ENDIF
IF (cTextoIni == NIL,cTextoIni := "",)
IF (cTextoFim == NIL,cTextoFim := "",)
IF (nLinhas == NIL,nLinhas := 5,)
IF (nLargura == NIL,nLargura := 79,)
IF (cResto == NIL,cResto := "",)
IF (nMOEDA == NIL,cTIPOMOEDA := 3,cTipoMoeda := nMoeda)
aUnidade  := {"UM ","DOIS "," TRES "," QUATRO "," CINCO "," SEIS "," SETE ","OITO "," NOVE "}
aDezena   := {"DEZ ","VINTE ","TRINTA ","QUARENTA ","CINQUENTA ","SESSENTA ","SETENTA ","OITENTA ","NOVENTA "}
aDezena2  := {"DEZ ","ONZE "," DOZE ","TREZE ","QUATORZE ","QUINZE ","DEZESSEIS ","DEZESSETE ","DEZOITO ","DEZENOVE " }
aCentena  := {"CENTO ","DUZENTOS ","TREZENTOS ","QUATROCENTOS ","QUINHENTOS ","SEISCENTOS ","SETECENTOS ","OITOCENTOS ","NOVECENTOS " }
aMilhar   := {"MIL ","MILHAO ","MILHOES "}
aMoeda    := {{"CRUZEIRO ","CRUZEIROS "},{"DOLAR ","DOLARES "  },{"REAL ","REAIS "    }}
aCentavo  := {"CENTAVO","CENTAVOS"}
cValor1   := STRZERO(nValor,13,2)
cPosicao1 := SUBSTR(cValor1,2,3)
cPosicao2 := SUBSTR(cValor1,5,3)
cPosicao3 := SUBSTR(cValor1,8,3)
cPosicao4 := STRZERO((nValor-INT(nValor))*100,3)
CONVERTE( @cPosicao1,1)
cTexto := cTextoIni + " " + cTexto
CONVERTE( @cPosicao2,2)
IF VAL(cPosicao2)<>0 .AND. VAL(cPosicao3) <>0 .AND. VAL(cPosicao4)=0
   cTexto += "E "
ENDIF
CONVERTE( @cPosicao3,3)
IF cPosicao3="000" .AND. VAL(cPosicao1+cPosicao2)<>0
   cTexto += aMoeda[cTipoMoeda,2]
ENDIF
CONVERTE(@cPosicao4,4)
cTexto += " "+cTextoFim
cTexto := FORMATA( @cTexto,@nLinhas,@nLargura,cRESTO)
FOR nI := 1 TO nLINHAS
   AADD(aTexto,SUBSTR(cTEXTO,nINICIO,nLARGURA))
   nINICIO += nLARGURA
NEXT
RETURN aTexto
***************************************************************************

STATIC FUNCTION CONVERTE(cNumero,nCasas)
IF cNumero == "000"
   RETURN cTexto
ENDIF
cNumero1 := LEFT(cNumero,1)
cNumero2 := SUBS(cNumero,2,1)
cNumero3 := RIGHT(cNumero,1)
cNumero4 := RIGHT(cNumero,2)
IF nCasas == 4
  cTexto += IF(VAL(cPosicao1+cPosicao2+cPosicao3)<>0," E ","")
ENDIF
IF cNumero1 <> "0"
   IF (cNumero4 == "00" .AND. (cNumero1 == "1"),cTexto += "CEM ",cTexto += aCentena[VAL(cNumero1)])
ENDIF
IF cNumero4 >= "10" .AND. cNumero4 <= "19"
   cTexto += IF(cNumero1<>"0","E "+aDezena2[VAL(cNumero4)-9],aDezena2[VAL(cNumero4)-9])
ENDIF
IF cNumero2 >= "2"
  IF (cNumero1 <> "0",cTexto += "E "+aDezena[VAL(cNumero2)],cTexto += aDezena[VAL(cNumero2)])
ENDIF
IF cNumero3 <> "0" .AND. (cNumero4 <"10" .OR. cNumero4 >"19")
   IF (cNumero1<>"0" .OR. cNumero2<>"0",cTexto += "E "+aUnidade[VAL(cNumero3)],cTexto += aUnidade[VAL(cNumero3)])
ENDIF
IF nCasas == 1
   cTexto += IF(VAL(cNumero)=1, aMilhar[2], aMilhar[3])
ELSEIF nCasas == 2
   cTexto := IF(VAL(cNumero)>0,cTexto+aMILHAR[1],cTexto)
ELSEIF nCasas == 3
   cTexto += IF(VAL(cPosicao1+cPosicao2+cPosicao3)==1, aMOEDA[cTipoMoeda,1], aMOEDA[cTipoMoeda,2])
ELSEIF nCasas == 4
   cTexto += IF(VAL(cNumero)=1, aCENTAVO[1], aCENTAVO[2])
ELSEIF nCasas == NIL
   cTexto := cTexto
ENDIF
RETURN cTexto

***************************************************************************

STATIC FUNCTION FORMATA(cTEXTO,nLinhas,nTamanho,cRESTO)
nTotLin := MLCOUNT(cTexto,nTamanho)
nTotLin := IF(nTotLin>nLinhas,nLinhas,nTotLin)
cTextoAUX := ""
FOR nI := 1 TO nTotLin
   cLinha := TRIM(MEMOLINE(cTexto,nTamanho,nI))
   DO WHILE .T.
      nFalta := nTamanho-LEN(cLinha)
      IF nFalta > 20 .OR. RIGHT(cLinha,1) == "."
           EXIT
      ENDIF
      IF LEN(cLinha) < nTamanho
         cLinha=STRTRAN(cLinha," ",CHR(177))
         FOR nJ := 1 TO nFalta
            nACHA := RAT(CHR(177),cLinha)
            IF nACHA == 0
               EXIT
            ENDIF
            cLinha := STUFF(cLinha,nACHA,1,"  ")
         NEXT
         cLinha := STRTRAN(cLinha,CHR(177)," ")
      ENDIF
      IF LEN(TRIM(cLinha)) == nTamanho
         EXIT
      ENDIF
   ENDDO
   cTextoAUX += cLinha
NEXT
cTextoAUX := LEFT(TRIM(cTextoAUX)+REPL(cRESTO,nTamanho*nLinhas),nTamanho*nLinhas)
RETURN (cTextoAUX)
***************************************************************************

           FUNCTION PERGUNTA(TEXTO)
           SAVE SCREEN TO M->TELA
           COR=SETCOLOR()
           SETCOLOR("W+/R")
           IF TEXTO=NIL
              TEXTO="CONFIRMA?"
           ENDIF
           @  16, 24 clear to 21, 56
           @  16, 24       to 21, 56
           @ 18,25 say PADC(TEXTO,30)
           @ 20,25 PROMPT " SIM "
           @ 20,31 PROMPT " NAO "
           @ 20,37 PROMPT " CANCELA "
           MENU TO RESPOSTA
           READ
           DO CASE
           CASE RESPOSTA == 1 // SIM
                M->RESPOSTA="S"
           CASE RESPOSTA == 2 // NAO
                M->RESPOSTA="N"
           CASE RESPOSTA == 3 // CANCELA
                M->RESPOSTA="CANCELA"
           OTHERWISE
                M->RESPOSTA="N"
           ENDCASE
           SETCOLOR(COR)
           RESTORE SCREEN FROM M->TELA
           RETURN M->RESPOSTA

PROCEDURE GRAVA
ARQ="CARTA.TXT"
IF FILE(ARQ)
   TAM :=DIRECTORY(ARQ,"2")                                                                                                   
   ARQ2:=DIRECTORY("E???????.TXT")
   IF TAM[1,2] > 60000
      IF FILE("E???????.TXT")
         FOR i=1 to LEN(arq2)
             ARQCOPYA :=ARQ2[I][1]
         NEXT
         NUMCOPYA := STRZERO(VAL(SUBSTR(ARQCOPYA,4,5)) + 1,5)
         NOMCOPYA:="E"+SUBSTR(DTOC(DATE()),1,2)+NUMCOPYA+".TXT"
         ELSE
         NOMCOPYA:="E"+SUBSTR(DTOC(DATE()),1,2)+"00000.TXT"
       ENDIF
       copy file (arq) to (nomcopya)
       TEXTO=""
       ALERT("O aquivo de parametros;"+TAM[1,1]+";foi renovado.;;"+;
             "Motivo: O tamanho permitido foi ultrapassado",,"W+/B")
   ELSE
       TEXTO=MEMOREAD(ARQ)
   ENDIF   
ELSE
       TEXTO=""
ENDIF
TEXTO+="DATA         : "+DTOC(DATE())+CHR(13)+CHR(10)
TEXTO+="ESTACAO      : "+NETNAME()+CHR(13)+CHR(10)
TEXTO+="-------------: "+CHR(13)+CHR(10)
TEXTO+="RESPONSAVEL  : "+FUNCIONARIO+CHR(13)+CHR(10)
TEXTO+="CARGO/FUNCAO : "+CARGO+CHR(13)+CHR(10)
TEXTO+="EMPRESA      : "+EMPRESA+CHR(13)+CHR(10)
TEXTO+="DESTINATARIO : "+DESTINATARIO+CHR(13)+CHR(10)
TEXTO+="CONTATO      : "+CONTATO+CHR(13)+CHR(10)
TEXTO+="PEDIDO/ORDEM : "+REFERENTE0+CHR(13)+CHR(10)
TEXTO+="MOTIVO       : "+MOTIVO+CHR(13)+CHR(10)
TEXTO+="VENCIMENTO   : "+REFERENTE1+CHR(13)+CHR(10)
TEXTO+="VALOR        : "+REFERENTE2+CHR(13)+CHR(10)
TEXTO+="SACADO       : "+REFERENTE3+CHR(13)+CHR(10)
TEXTO+="N§ DOCUMENTO : "+REFERENTE4+CHR(13)+CHR(10)
TEXTO+=REPLICATE("=",50)+CHR(13)+CHR(10)
MEMOWRIT(ARQ,TEXTO)
