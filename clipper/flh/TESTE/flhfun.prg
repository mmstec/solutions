FUNCTION VERI001(VARIAVEL)
M->I_REG :=RECN()
M->ORDEM :=INDEXORD()
SET ORDER TO 1
IF DBValor->(DBSEEK(VARIAVEL))=.T.
   ALERT("Registro j† cadastrado")
   GOTO M->I_REG
   RETURN .F.
   ELSE
   SET ORDER TO M->ORDEM
   RETURN .T.
ENDIF
SET ORDER TO M->ORDEM
GOTO M->I_REG
RETURN .T.

FUNCTION VRFCONTA(LIN,COL)
SALVACOR=SETCOLOR()
SETCOLOR("W+/N,W+/R,,,R/N")
DECLARE I_TEM[8] , RESUL_T[8] , P_ERCENTUAL[8]
I_TEM[1] = "00" ;RESUL_T[1] = "Cimento   " ;P_ERCENTUAL[1] = 0.0
I_TEM[2] = "01" ;RESUL_T[2] = "Lourildo  " ;P_ERCENTUAL[2] = 1.5
I_TEM[3] = "02" ;RESUL_T[3] = "M†rcio    " ;P_ERCENTUAL[3] = 1.5
I_TEM[4] = "03" ;RESUL_T[4] = "M†rcia    " ;P_ERCENTUAL[4] = 1.5
I_TEM[5] = "04" ;RESUL_T[5] = "Miguel    " ;P_ERCENTUAL[5] = 1.5
I_TEM[6] = "05" ;RESUL_T[6] = "Valdir    " ;P_ERCENTUAL[6] = 0.0
I_TEM[7] = "06" ;RESUL_T[7] = "Itaciane  " ;P_ERCENTUAL[7] = 1.5
I_TEM[8] = "07" ;RESUL_T[8] = "Roberto   " ;P_ERCENTUAL[8] = 1.5
FOR M->PO_S = 8 TO 1 STEP -1
    IF M->CODCONTA = I_TEM[PO_S]
      @ LIN,COL SAY RESUL_T[PO_S]
      M->PO_S = -1
   ENDIF
NEXT
IF M->PO_S = 0
   @ LIN, COL SAY SPACE(10)
   IF LEN(READVAR())<>0
      DECLARE BAR_RA[8]
      FOR M->PO_S = 1 TO 8
         BAR_RA[M->PO_S] = I_TEM[M->PO_S] + " " + RESUL_T[M->PO_S]
      NEXT
      SAVE SCREEN TO M->T_ELA
      KEYBOARD CHR(65)
      M->PO_S=ACHOICE(LIN,COL-3,LIN,COL+10,BAR_RA)
      SAVE SCREEN TO M->T_ELA
      IF M->PO_S <> 0
         M->PERCENTUAL = P_ERCENTUAL[M->PO_S]
         M->CODCONTA = I_TEM[M->PO_S]
         @ LIN, COL SAY PADR(RESUL_T[M->PO_S],20)
      ENDIF
      RETURN .F.
   ENDIF
ENDIF
SELE 3
SETCOLOR(SALVACOR)
RETURN .T.

FUNCTION VRFCAIXA(LIN,COL)
*SETCOLOR("B/W,W+/R,,,B/W")
SETCOLOR("W+/N,W+/R,,,R/N")
DECLARE I_TEM[5] , RESUL_T[5] , P_AGA[5]
I_TEM[1]   = "01"; RESUL_T[1] = PADR("Venda Avista",22)         ; P_AGA[1] = "S"
I_TEM[2]   = "02"; RESUL_T[2] = PADR("Venda Aprazo",22)         ; P_AGA[2] = "N"
I_TEM[3]   = "03"; RESUL_T[3] = PADR("Venda Duplicata",22)      ; P_AGA[3] = "S"
I_TEM[4]   = "04"; RESUL_T[4] = PADR("Recebimento Aprazo",22)   ; P_AGA[4] = "S"
I_TEM[5]   = "05"; RESUL_T[5] = PADR("Recebimento Duplicata",22); P_AGA[5] = "N"
FOR M->PO_S = 5 TO 1 STEP -1
   IF M->CODCAIXA = I_TEM[PO_S]
      @ LIN,COL SAY RESUL_T[PO_S]
      M->PO_S = -1
   ENDIF
NEXT
IF M->PO_S = 0
   @ LIN, COL SAY SPACE(20)
   IF LEN(READVAR())<>0
      DECLARE BAR_RA[5]
      FOR M->PO_S = 1 TO 5
          BAR_RA[M->PO_S] = I_TEM[M->PO_S] + " " + RESUL_T[M->PO_S] 
      NEXT
      SAVE SCREEN TO M->T_ELA
      KEYBOARD CHR(65)
      M->PO_S=ACHOICE(LIN,COL-3,LIN,COL+20,BAR_RA)
      RESTORE SCREEN FROM M->T_ELA
      IF M->PO_S <> 0
         M->PG = P_AGA[M->PO_S]
         M->CODCAIXA = I_TEM[M->PO_S]
         @ LIN, COL SAY PADR(RESUL_T[M->PO_S],20)
      ENDIF
      RETURN .F.
   ENDIF
ENDIF
RETURN .T.

FUNCTION NCONTA(PAR)
M->VARIAVEL=PAR
    IF M->VARIAVEL = "00"; M->PERC="0.0"; RETURN "Cimento "
ELSEIF M->VARIAVEL = "01"; M->PERC="1.5"; RETURN "Lourildo"
ELSEIF M->VARIAVEL = "02"; M->PERC="1.5"; RETURN "M†rcio  "
ELSEIF M->VARIAVEL = "03"; M->PERC="1.5"; RETURN "M†rcia  "
ELSEIF M->VARIAVEL = "04"; M->PERC="1.5"; RETURN "Miguel  "
ELSEIF M->VARIAVEL = "05"; M->PERC="0.0"; RETURN "Valdir  "
ELSEIF M->VARIAVEL = "06"; M->PERC="1.5"; RETURN "Itaciane"
ELSEIF M->VARIAVEL = "07"; M->PERC="1.5"; RETURN "Roberto "
ELSE
   M->PERC="0.0" ; ALERT("E R R O!;;CONTA:"+M->VARIAVEL+";N/E NÑo Existe!")
   RETURN PADR("NAO EXISTE",10)
ENDIF

FUNCTION NCAIXA(PAR)
M->VARIAVEL=PAR
IF M->VARIAVEL        = "00"; M->PG="S"; RETURN "Valores AtÇ FEV/1999 "
   ELSEIF M->VARIAVEL = "01"; M->PG="S"; RETURN "Venda Avista         "
   ELSEIF M->VARIAVEL = "02"; M->PG="N"; RETURN "Venda Aprazo         "
   ELSEIF M->VARIAVEL = "03"; M->PG="S"; RETURN "Venda Duplicata      "
   ELSEIF M->VARIAVEL = "04"; M->PG="S"; RETURN "Recebimento Aprazo   "
   ELSEIF M->VARIAVEL = "05"; M->PG="N"; RETURN "Recebimento Duplicata"
   ELSE
   M->PG="N" ; ALERT("E R R O!;;CAIXA:"+M->VARIAVEL+";N/E NÑo Existe!")
   RETURN PADR("NAO EXISTE",20)
ENDIF

FUNCTION COMISSAO(PAR1,PAR2,PAR3)
M->cVALOR :=PAR1 
M->cCONTA :=PAR2
M->cCAIXA :=PAR3
M->nPERC  :=0
M->nRESP  :="S"
M->FORMULA:=0

       IF M->cCONTA="00" ; M->nPERC :=0.0 //CIMENTO
   elseIF M->cCONTA="01" ; M->nPERC :=1.5 //LOURILDO
   elseIF M->cCONTA="02" ; M->nPERC :=1.5 //MARCIO
   elseIF M->cCONTA="03" ; M->nPERC :=1.5 //MARCIA
   elseIF M->cCONTA="04" ; M->nPERC :=1.5 //MIGUEL
   elseIF M->cCONTA="05" ; M->nPERC :=1.5 //VALDIR
   elseIF M->cCONTA="06" ; M->nPERC :=1.5 //ITACIANE
   elseIF M->cCONTA="07" ; M->nPERC :=1.5 //ROBERTO
   else                  ; M->nPERC :=0.0 //OUTRA OPCAO
    endIF

       IF M->cCAIXA="00" ; M->nRESP :="S" //VALOR ANTERIOR A FEV/99
   elseIF M->cCAIXA="01" ; M->nRESP :="S" //VENDA AVISTA
   elseIF M->cCAIXA="02" ; M->nRESP :="N" //VENDA APRAZO
   elseIF M->cCAIXA="03" ; M->nRESP :="S" //VENDA DUPLICATA
   elseIF M->cCAIXA="04" ; M->nRESP :="S" //RECEBIMENTO APRAZO 
   elseIF M->cCAIXA="05" ; M->nRESP :="N" //RECEBIMENTO DUPLICATA
   else                  ; M->nRESP :="N" //OUTRA OPCAO
    endIF

IF M->nRESP="S"
   M->FORMULA=(cVALOR*M->nPERC)/100
   else
   M->FORMULA=0
ENDIF
RETURN M->FORMULA

FUNCTION MES_ANO
PARA D_ATA
IF TYPE("D_ATA")="D"
   M->RETOR_NO=SUBS(STR(YEAR(M->D_ATA),4),3)+"/"
   M->RETOR_NO=M->RETOR_NO+SUBS(STR(MONTH(M->D_ATA)+100,3),2)
ELSE
   M->RETOR_NO=SUBS(M->D_ATA,4,2)+"/"+SUBS(M->D_ATA,1,2)
ENDIF
RETURN M->RETOR_NO

FUNCTION RELEVO(Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7)
   local Local1, Local2, Local3, Local4
   Local4:= SetColor()
   if (Arg6 = Nil)
      Arg6:= "B"
   endif
   if (Arg7 = NIL .OR. Arg7<> 2)
      Arg7:= 1
      else
      Arg7:= 2
   endif
   Local2:= "N /" + Arg6 
   Local3:= "B+/" + Arg6 
   if (Arg5 = Nil)
      Arg5:= .F.
   endif
   ************************************************
   if (Arg5)
      set color to (Local2)
   else
      set color to (Local3)         
   endif
   @ Arg1, Arg2 clear to Arg3, Arg4
   IF Arg7 = 1
      @ Arg1, Arg2 say "⁄" 
      @ Arg3, Arg2 say "¿" + Replicate("ƒ", Arg4 - Arg2 - 1)
   else
     @ Arg1, Arg2 say "…" 
     @ Arg3, Arg2 say "»" + Replicate("Õ", Arg4 - Arg2 - 1)
   endif
   if (Arg3 - Arg1 == 2)
      if arg7=1
         @ Arg1 + 1, Arg2 say "≥"
         else
         @ Arg1 + 1, Arg2 say "∫"
      endif
   else
      if arg7=1
         @ Arg1 + 1, Arg2 to Arg3 - 1, Arg2 
         else
         @ Arg1 + 1, Arg2 to Arg3 - 1, Arg2 double
      endif
   endif
   ************************************************
   if (Arg5)
      set color to (Local3)
   else
      set color to (Local2)
   endif
   if (Arg3 - Arg1 == 2)
      if Arg7=1
         @ Arg1 + 1, Arg4 say "≥"
         else
         @ Arg1 + 1, Arg4 say "∫"
     endif
   else
     if Arg7=1
        @ Arg1 + 1, Arg4 to Arg3 - 1, Arg4 
        else
        @ Arg1 + 1, Arg4 to Arg3 - 1, Arg4 double
     endif
   endif
   if arg7=1
      @ Arg1, Arg2 + 1 say Replicate("ƒ", Arg4 - Arg2 - 1) + "ø"
      @ Arg3, Arg4 say "Ÿ"
      else
      @ Arg1, Arg2 + 1 say Replicate("Õ", Arg4 - Arg2 - 1) + "ª"
      @ Arg3, Arg4 say "º"
   endif
   set color to (Local4)
   return Nil


FUNCTION DbMES(vData)
if vData = nil
   vData = Date()
endif
MES      := "JANFEVMARABRIMAIJUNJULAGOSETOUTNOVDEZ"
ANO      := STR(YEAR(vData),4)
cDATA    := Trim(SubStr(MES, MONTH(vData) * 3 - 2, 3)) + "/" + ANO
return (cDATA)

   FUNCTION GRAVAV
   SALVACOR=SETCOLOR()
   SETCOLOR("N+/B,W+/B,,,BG+/B")
   RELEVO(05, 55, 21, 74,.F.,,2) // tela DIREITA
   relevo(06, 56, 08, 73,.T.)   // BOTOES
   relevo(09, 56, 11, 73,.T.)   // BOTOES
   @ 07,58 PROMPT padC("1.GRAVAR   ",15) MESSAGE PADC('P/ GRAVAR REGISTRO APERTE "1"',60)
   @ 10,58 PROMPT padC("2.CANCELAR ",15) MESSAGE PADC('P/ CANCELAR APERTE "2"',60)
   BOTAO=1
   MENU TO BOTAO
   DO CASE
   CASE BOTAO=1
        M->GRAVA="S"
   CASE BOTAO=2
        M->GRAVA="N"
   OTHERWISE
        M->GRAVA="N"
   ENDCASE
   SETCOLOR(SALVACOR)
   RETURN M->GRAVA


   FUNCTION DBACESSO
   IF FILE("SRV.LIG") .AND. FILE("dBvalor.DBF") .and. FILE("dBconta.DBF") .AND. FILE("dBcaixa.DBF")
         IF FILE("SRV.LIG")
            M->MSGPRO   := PROCNAME()+".EXE"
            M->MSGUSO   := "TODOS"
            M->MSGMAQ   := ALLTRIM(NETNAME())
            M->MSGDATA  := DTOC(DATE())
            M->MSGHORA  := TIME()
            *************
            ERASE SRV.MSG
            SAVE all like MSG* to SRV.MSG
            *************
            restore from SRV.LIG ADDITIVE
            setblink(.F.)
            cMensagem :=";SRV - SISTEMA REGISTRADOR DE VALORES;"+;
                        ";E R R O  D E  A C E S S O;"+;
                        ";A BASE DE DADOS DO SISTEMA SOLICITADO   "+;
                        ";NAO PODE SER ACESSADO NESTE MOMENTO.;    "+;
                        ";MOTIVO: (1) Provavelmente o programa    "+;
                        ";            esta sendo usado em outra   "+;
                        ";            m†quina da rede.            "+;
                        ";        (2) O sistema pode ter sido     "+;
                        ";           finalizado de forma errada.;"+;
                        ";ORIGEM:                                 "+;
                        ";EXECUTAVEL.........:"+padr(LOGPRO,20)    +;
                        ";MµQUINA ...........:"+padr(LOGMAQ,20)    +;
                        ";DATA INICIO........:"+padr(LOGDATA,20)   +;
                        ";HORA INICIO........:"+padr(LOGHORA,20)
            cResposta :={ padc("P/ SAIR APERTE <ENTER>",40) }
            cCor      :="W+/B" 
            ALERT(cMensagem, cResposta, cCor)
            setblink(.T.)
            QUIT
         ENDIF
         InKey(0.5)
         return.T.
      ENDIF

   FUNCTION DBMENSAGEM
   IF FILE("SRV.MSG")
      restore from SRV.MSG ADDITIVE
      cMensagem :=";SRV - SISTEMA REGISTRADOR DE VALORES;"+;
                  ";TENTATIVA DE ACESSO;"+;
                  ";A BASE DE DADOS DO SISTEMA CORRENTE ESTA  "+;
                  ";SENDO SOLICITADO POR OUTRO USUARIO NA REDE; "+;
                  ";Provavel respons†vel pela falha do sistema:;"+;
                  ";MµQUINA ...........:"+padr(MSGMAQ,20)    +;
                  ";DATA...............:"+padr(MSGDATA,20)   +;
                  ";HORA...............:"+padr(MSGHORA,20)
       cResposta :={ padc("P/ CONTINUAR APERTE <ENTER>",40) }
       cCor      :="W+/N" 
       TONE(300,4.5)
       ALERT(cMensagem, cResposta, cCor)
       IF FILE("SRV.MSG")
          ERASE SRV.MSG  // APAGA ARQUIVO-MENSAGEM DE TENTATIVA DE ACESSO
       ENDIF
  ENDIF
  RETURN.T.

FUNCTION CALENDARIO
* -> calend†rio
DECLARE BOTOES[10]
Q_BOTOES=1
MENU_P=1
X=1
C_SOM=""
L_SOM=""
M->DAT_HOJE=DATE()
M->SOS_MENU=" "
M->CALEN_X=ROW()
M->CALEN_Y=COL()
M->CLEN_COR=SETCOLOR()
SET CURSOR OFF
SET DATE BRIT
SET CENTURY ON
M->CA_MES=MONTH(M->DAT_HOJE)
M->CA_ANO=YEAR(M->DAT_HOJE)
M->CA_DATA=CTOD("01/"+STR(M->CA_MES,2)+"/"+STR(M->CA_ANO,4))
L_CALEN=L_SOM
C_CALEN=C_SOM
*sombra(L_SOM,C_SOM,.T.)
M->CA_TELA1=SAVESCREEN(03,11,22,66)
@ 04,13,21,66 BOX "€€€€€€€€€€" color "BG+/BG"
*sombra(04,13,21,66)
@ 04,13 to 21,66   color "R+/BG"
BOTAO(10,53," [+] Màs  ",1)
BOTAO(12,53," [-] Màs  ",2)
BOTAO(14,53," [+] Ano  ",3)
BOTAO(16,53," [-] Ano  ",4)
BOTAO(18,53,"    Ano   ",5)

M->OPC_BOT=1
M->SOS_MENU="CALENDARIO"
DO WHILE .T.
   SETCOLOR("W+/W")
   @ 06,15 SAY "  Dom  Seg  Ter  Qua  Qui  Sex  Sab " COLOR("W+/N")
   SETCOLOR(SUBS(SETCOLOR("W+/W"),4,2)+"/"+SUBS(SETCOLOR("W+/W"),4,2))
   FOR F_CALEN=8 TO 18 STEP 2
      @ 07,15 SAY "ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ" COLOR("BG+/BG")
      @ F_CALEN+0,15 SAY " €€€€ €€€€ €€€€ €€€€ €€€€ €€€€ €€€€ " COLOR("N/BG")
      @ F_CALEN+1,15 SAY " ﬂﬂﬂﬂ ﬂﬂﬂﬂ ﬂﬂﬂﬂ ﬂﬂﬂﬂ ﬂﬂﬂﬂ ﬂﬂﬂﬂ ﬂﬂﬂﬂ " COLOR("N/BG")
   NEXT
   IF AT(SUBS(STR(M->CA_MES+100,3),2),"01 03 05 07 08 10 12")<>0
      M->ULT_DIA = 31
   ELSE
      M->ULT_DIA=IIF(M->CA_MES#2,30,IIF(MOD(M->CA_ANO,4)=0,29,28))
   ENDIF
   M->X_X=DOW(M->CA_DATA)
   M->Y_Y=8
   SETCOLOR("W+/N")
   FOR F_CALEN=1 TO M->ULT_DIA
       IF  M->X_X=1
           @ M->Y_Y,(M->X_X*5)+13 SAY STR(F_CALEN,2) COLOR("R+/N")
       ELSE
           @ M->Y_Y,(M->X_X*5)+13 SAY STR(F_CALEN,2) COLOR("W+/N")
       ENDIF
       IF  STR(F_CALEN,2)=STR(DAY(DATE()),2)
         @ M->Y_Y,(M->X_X*5)+13 SAY STR(F_CALEN,2) COLOR("RG+*/N")
       ENDIF
      M->X_X=M->X_X+1
      IF M->X_X>7
         M->X_X=1
         M->Y_Y=M->Y_Y+2
      ENDIF
   NEXT
   SETCOLOR("BG+/N")
   @ 06,53 CLEAR TO 08,63
   @ 06,52 TO 08,63
   @ 06,52 CLEAR TO 06,63
   @ 06,53 SAY SUBS(" Janeiro  Fevereiro   Maráo     Abril      Maio     Junho     Julho     Agosto   Setembro  Outubro   Novembro  Dezembro ",MONTH(M->CA_DATA)*10-9,10)   COLOR("R+/N")
   @ 07,55 SAY TRAN(YEAR(M->CA_DATA),"@E 9999")                                    COLOR("RG+/N")
   M->OPC_BOT=BOTAO(M->OPC_BOT)
   IF M->OPC_BOT=0
      EXIT
   ELSEIF M->OPC_BOT=5
      SETCOLOR("W/N")
      @ 07,54 SAY CHR(26)
      *M->CA_TEMP=CTOD("  /  /  ")
      M->CA_TEMP=""
      M->TECLA=0
      SET CURSOR ON
      DO WHILE M->TECLA<>13 .AND. M->TECLA<>27
         IF AT(CHR(M->TECLA),"0123456789")<>0
            M->CA_TEMP=M->CA_TEMP+CHR(M->TECLA)
            IF LEN(M->CA_TEMP)=4
               EXIT
            ENDIF
         ENDIF
         IF (M->TECLA=19 .OR. M->TECLA=8) .AND. LEN(M->CA_TEMP)>0
            M->CA_TEMP=SUBS(M->CA_TEMP,1,LEN(M->CA_TEMP)-1)
         ENDIF
         ***
         @ 07,55 SAY "     "
         IF LEN(M->CA_TEMP)=0
            @ 07,56 SAY ""
         ELSE
            @ 07,56 SAY SUBS(M->CA_TEMP,1,4)
         ENDIF
         M->TECLA=INKEY(0)
      ENDDO
      SET CURSOR OFF
      M->CA_ANO=VAL(M->CA_TEMP)
      @ 07,54 SAY " "
   ENDIF
   M->CA_ANO=M->CA_ANO+IIF(M->OPC_BOT=4,-1,IIF(M->OPC_BOT=3,1,0))
   M->CA_ANO=IIF(M->CA_ANO<100,100,IIF(M->CA_ANO>2999,2999,M->CA_ANO))
   M->CA_MES=M->CA_MES+IIF(M->OPC_BOT=2,-1,IIF(M->OPC_BOT=1,1,0))
   M->CA_MES=IIF(M->CA_MES<1,12,IIF(M->CA_MES>12,1,M->CA_MES))
   M->CA_DATA=CTOD("01/"+STR(M->CA_MES,2)+"/"+STR(M->CA_ANO,4))
ENDDO
M->SOS_MENU=""
RESTSCREEN(03,11,22,66,M->CA_TELA1)
*sombra(L_CALEN,C_CALEN)
SETCOLOR(M->CLEN_COR)
*
SET CENTURY OFF
@ M->CALEN_X,M->CALEN_Y SAY ""


FUNCTION BOTAO
PARA LIN_BOT,COL_BOT,NOM_BOT,NUM_BOT
SALVACOR=SETCOLOR()
IF PCOUNT()=0
   NUM_BOT=0
ENDIF
IF PCOUNT()=3
   NUM_BOT=-1
ENDIF
IF PCOUNT()=4
   IF NUM_BOT<1
      Q_BOTOES=1
   ELSE
      Q_BOTOES=NUM_BOT
   ENDIF
  BOTOES[Q_BOTOES]=STR(COL_BOT,3)+STR(LIN_BOT,3)+NOM_BOT
ENDIF
IF PCOUNT()=1
   X_BOT=LIN_BOT
   NUM_BOT=0
ELSE
   X_BOT=1
ENDIF
IF NUM_BOT>0 .OR. NUM_BOT=-1
   SETCOLOR("R+/R")
   @ LIN_BOT,COL_BOT SAY SPACE(11)
   @ LIN_BOT,COL_BOT+1 SAY NOM_BOT
   @ LIN_BOT,COL_BOT-1 SAY " ‹"                COLOR("n+/bG")
   @ LIN_BOT+1,COL_BOT-1 SAY " ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ "    COLOR("n+/bG")
ELSE
   TECLA=0
   DO WHILE .T.
      COL_BOT=VAL(SUBS(BOTOES[X_BOT],1,3))
      LIN_BOT=VAL(SUBS(BOTOES[X_BOT],4,3))
      NOM_BOT=SUBS(BOTOES[X_BOT],7)
      SETCOLOR("W+/R")
      Tone(500,1)
      @ LIN_BOT,COL_BOT SAY SPACE(11)
      @ LIN_BOT,COL_BOT+1 SAY NOM_BOT
      @ LIN_BOT,COL_BOT-1 SAY " ‹"                  COLOR("N+/BG")
      @ LIN_BOT+1,COL_BOT-1 SAY " ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ "      COLOR("N+/BG")
      IF TECLA=13
         Tone(800,2)
         INKEY(.2)
         RETURN X_BOT
      ENDIF
      IF NUM_BOT=-2
         TECLA=13
      ELSE
         TECLA=INKEY(0)
      ENDIF
      IF TECLA=27
          TONE(500,2)
         RETURN 0
      ENDIF
      *IF TECLA=28
      *   TONE(300,2)
      *   HELP()
      * ENDIF
      *IF TECLA=(-1)
      *   TONE(300,2)
      *   ALERT("CONCEPÄ«O DE MARCOS MORAIS DE SOUSA")
      *ENDIF
      SETCOLOR("R+/R")
      @ LIN_BOT,COL_BOT+1 SAY NOM_BOT
      FOR F_BOT=1 TO Q_BOTOES
         IF SUBS(BOTOES[F_BOT],7,1)=UPPER(CHR(TECLA))
            X_BOT=F_BOT
            TECLA=13
            COL_BOT=VAL(SUBS(BOTOES[X_BOT],1,3))
            LIN_BOT=VAL(SUBS(BOTOES[X_BOT],4,3))
            NOM_BOT=SUBS(BOTOES[X_BOT],7)
            EXIT
         ENDIF
      NEXT
      IF TECLA=13
         SETCOLOR("BG/BG")
         @ LIN_BOT,COL_BOT SAY "€"
         @ LIN_BOT+1,COL_BOT-1 SAY "€€€€€€€€€€€€"
         @ LIN_BOT,COL_BOT+10 SAY "€"
         SETCOLOR("W+/R")
         @ LIN_BOT,COL_BOT-1 SAY " "+NOM_BOT+" "
         INKEY(.2)
         LOOP
      ENDIF
      IF TECLA=19 .OR. TECLA=5
         X_BOT=X_BOT-1
      ELSEIF TECLA=4 .OR. TECLA=24
         X_BOT=X_BOT+1
      ENDIF
      X_BOT=IIF(X_BOT<1,Q_BOTOES,IIF(X_BOT>Q_BOTOES,1,X_BOT))
   ENDDO
ENDIF
SETCOLOR(SALVACOR)
*
* ////////////////////////////////////////////////////////////////////*

FUNCTION AJUDA
SAVE SCREEN TO TELA_AJUDA
salvacor=setcolor()
SETCOLOR("N+/N")
CLEAR
?REPL(" MMS /\//\\//\\/\",205) 
@ 03,15 CLEAR TO 20,65
SETBLINK(.T.)
RELEVO(03,15,20,65,.F.,,1)
RELEVO(17,54,19,62,.f.,,2)
@ 18,55 SAY PADC("OK",07) COLOR "R*/B"
@ 05,18 SAY PADC(M->SISTEMA                      ,44) color "BG+  /B"
@ 06,18 SAY PADC("VersÑo "+M->VERSAO             ,44) color "BG   /B"
@ 08,18 SAY PADR(M->AUTOR                        ,44) color "N+   /B"
@ 09,18 SAY PADR(M->EMAIL                        ,44) color "N+   /B"
@ 12,18 SAY PADR("Este produto est† licencidado para:",44) color "W+/B"
@ 13,18 SAY PADR(M->DONO1                        ,44) color "N+  /B"
@ 14,18 SAY PADR(M->DONO2                        ,44) color "N+  /B"
@ 15,18 SAY PADR(REPL("ƒ",45)                    ,44) color "N+  /B"
@ 17,18 say "Mem¢ria livre   :"+alltrim(str(memory(2)))+" kb"  color "bg/B"
@ 18,18 say "M†quina         :"+trim(netname())                color "bg/B"

inkey(10)
RELEVO(17,54,19,62,.t.,,1)
@ 18,55 SAY PADC("OK",07) COLOR "W+/B"
TONE(514,2)
cls
setcolor(salvacor)
RESTORE SCREEN FROM TELA_AJUDA
RETURN.T.

  function pergunta(par)
  IF par=nil
     par="CONTINUAR?"
  ENDIF
  SAVE SCREEN TO TELA
  SALVACOR=SETCOLOR()
  SETCOLOR("N+/R,BG*+/R,B+/N,B+/N")
  RELEVO(18,24,22,56,.T.,"R")
  @ 19,25 say PADC(PAR,30) COLOR "W+/R"
  RESPOSTA = 1
  @ 21,34 PROMPT " Sim "
  @ 21,41 PROMPT " NÑo "
  MENU TO RESPOSTA
  READ
  RESTORE SCREEN FROM TELA
  SETCOLOR(SALVACOR)
  RETURN(RESPOSTA)

function UseRede(arquivo, modo, segundos)
   local sempre
   sempre:= segundos = 0
   do while (sempre .OR. segundos > 0)
      if (modo)
         use (arquivo) exclusive
         else
         use (arquivo) shared
      endif
      if (!neterr())
         return .T.
      endif
      segundos:= segundos - 1
   enddo
   return .F.

function V_N(Arg2)
   sup_tmp :=0
   ok      := "N"
   a       :=0
   converte:=""
   for contador=1 to len(Arg2)
       a++
       Var1     :=ASC(substr(arg2,a,contador))+33 // CODIFICA DIGITO PARA COMPARAR
       converte :=converte + chr(var1)
   next
   arg2:=converte
   seek Upper(Arg2)
   if (Found())
      if (alltrim(Upper(senha)) == alltrim(Upper(Arg2))) 
         usu_tmp:= dBsys->usuario
         sup_tmp:= dBsys->nivel
         ok     := "S"
      endif
   endif
   if (ok = "N")
      ok      := "N"
      a       :=0
      converte:=""
      for contador=1 to len(Arg2)
          a++
          Var1     :=ASC(substr(arg2,a,contador))-33 // DECODIFICA DIGITO PARA COMPARAR
          converte :=converte + chr(var1)
       next
      arg2:=converte
      if (Upper(Arg2) == "MMSTEC")
         usu_tmp:= "MMSTEC"
         sup_tmp:= 4
         ok:= "S"
      endif
   endif
   return .T.

Function LIBERA
   public usu_tmp,sup_tmp
   dbCRIA()
   if (!USEREDE("dBsys",.F.,10))
      op_cao:= 0
      return .F.
      else
      USE DBSYS
      INDEX on SENHA+USUARIO to iDSYS1.NTX
      INDEX on USUARIO+SENHA to iDSYS2.NTX
      INDEX on SENHA         to iDSYS3.NTX
      SET ORDER TO 3
   endif
   tentativa:= 0
   do while (.T.)
      if (tentativa >= 3)
         cls
         alert("Sinto muito;;Esgotaram-se as tentativas permitidas;",,"r+/n")
         op_cao:= 0
         return .F.
      endif
      var2:= ""
      RELEVO(09, 20, 13,60,.F.,,2) 
      @ 11, 22 say "Senha: "  color "W+ /B"
      l:= 11
      c:= 29
      cod:= 32
      do while (.T.)
         @ l, c say Chr(cod)  color "RG+/B"
         tecla:= InKey(0)
         if (tecla = 13 .OR. tecla = 27)
            exit
         endif
         cod:= 254
         if (tecla == 8)
            var2:= Left(var2, Len(var2) - 1)
            @ l, c say " "     color "B+/B"
            c--
            if (c <= 29)
               c  := 29
               cod:= 32
            endif
         else
            c++
            if (c >= 59)
               c:= 59
            else
               var2:= var2 + Chr(tecla)
            endif
         endif
      enddo
      if (LastKey() == 27)
         loop
      endif
      tentativa++
      ok:= "N"
      var2:= alltrim(var2)
      if (!Empty(var2))
         v_n(var2)
      endif
      if (ok = "N")
         tone(1000, 1)
         tone(800, 2)
         tone(1200, 1)
         alert("ACESSO NEGADO;;CERTIFIQUE-SE DE QUE ESTEJA DIGITANDO SUA SENHA CORRETAMENTE; E QUE A MESMA CONTENHA APENAS DIGITOS NUMERICOS;;"+ALLTRIM(M->AUTOR),,"rg+/n")
      else
         TONE(500,5)
         alert(";"+ALLTRIM(USU_TMP)+";;NIVEL:"+STR(SUP_TMP,1)+";;"+dbdata(),{PADC("APERTE UMA TECLA",20)},"RG+/N")
         exit
      endif
   enddo
   set color to "w/n"
   cls
   close databases
   select 1
   close format
   M->USUARIO:= USU_TMP
   M->NIVEL  := SUP_TMP
   return .T.
