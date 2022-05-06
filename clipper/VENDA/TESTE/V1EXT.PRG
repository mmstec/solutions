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
