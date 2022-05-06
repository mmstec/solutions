PARAMETERS PAR1
IF PCOUNT()<>1
   ALERT("ERRO: PARAMETRO NAO PODE SER VAZIO;;OBS: PAR1 = CONTA")
   QUIT
ENDIF
clear
set color to W+/N,W+/B
set date format to "dd,mm,yy"
set date brit
arq1 :="comissao"  // origem  de dados
arq2 :="dBVALOR"  // destino de dados
M->contaREG:=0
sele 1
     use (arq1)
     index on dtos(data)+str(vendas01)+;
                         str(vendas02)+;
                         str(vendas03)+;
                         str(vendas04)+;
                         str(vendas05)+;
                         str(vendas06) TO TRANSF.NTX
sele 2
     use (arq2)
     //zap
sele 1
go top
do while (arq1)->(!eof())
         @ 07, 20 say "Arquivo        :" + padl(DBF(),10)   color 'w/n'
         @ 08, 20 say "Registro Total :" +Str(LastRec(),10) color 'w/n'
         @ 09, 20 say "Registro Atual :" +Str(M->contaREG,10) color 'w/n'
         v0    :=(arq1)->data
         v1    :=(arq1)->vendas01
         v2    :=(arq1)->vendas02
         v3    :=(arq1)->vendas03
         v4    :=(arq1)->vendas04
         v5    :=(arq1)->vendas05
         v6    :=(arq1)->vendas06
         sele 2
         VRFCONTA()
         @ 11, 20 say "Arquivo        :" +padL(DBF(),10)
         @ 12, 20 say "Registro Total :" +Str(LastRec(),10)
         @ 13, 20 say "Registro Atual :" +Str(Recno(),10)
         @ 15, 20 say "CONTA          :" +padL(LKCONTA,10)
         sele 1                           
         M->contaREG++
         skip
enddo
close databases
QUIT

FUNCTION LIMPA
 INKEY(0)
 CLS
 USE DBVENDA ;PACK
 INDEX on STR(VALOR)+STR(COMISSAO)+DTOS(DATA)+LKCONTA+LKCAIXA to DBVENDA1.NTX 
 APAGADO=0
 GOTO TOP
 DO WHILE !EOF()
    IF VALOR=0 .AND. COMISSAO=0
       APAGADO++
       DELE
    ENDIF
    SKIP
 ENDDO
 ?""
 ?"QUANTIDADE DE REGISTROS ELIMINADOS:"+STR(APAGADO)
QUIT

RETURN.T.


FUNCTION VRFCONTA
M->VPAR1=PAR1
    IF M->VPAR1="1"
       M->CONTA="01"
       M->VALOR=V1
ELSEIF M->VPAR1="2"
       M->CONTA="02"
       M->VALOR=V2
ELSEIF M->VPAR1="3"
       M->CONTA="03"
       M->VALOR=V3
ELSEIF M->VPAR1="4"
       M->CONTA="04"
       M->VALOR=V4
ELSEIF M->VPAR1="5"
       M->CONTA="05"
       M->VALOR=V5
ELSEIF M->VPAR1="6"
       M->CONTA="06"
       M->VALOR=V6
ELSE
ALERT("ERRO: PAR1 NAO PODE SER MAIOR QUE 6")
QUIT
ENDIF
         append blank
         (arq2)->data    := v0
         (arq2)->lkconta :=M->CONTA
         (arq2)->lkcaixa :="00"
         (arq2)->valor   :=M->VALOR

RETURN
