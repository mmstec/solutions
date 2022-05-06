
FUNCTION MANUTENCAO
Tone(300,1)
DO WHILE.T.
   SALVACOR=SETCOLOR()
   SETCOLOR("N+/B,BG+/B,,,BG+/B")
   ENTRADA("MENU DE MANUTENÄÂES")
   relevo(06, 56, 08, 73, .T.) // BOTOES
   *relevo(09, 56, 11, 73, .T.) // BOTOES
   *relevo(12, 56, 14, 73, .T.) // BOTOES
   relevo(18, 56, 20, 73, .T.) // BOTOES     
   @ 07,58 PROMPT padR("1.Contatos    " ,15) MESSAGE PADC('P/ LOCALIZAR REGISTROS RAPIDAMENTE, APERTE "1"',67)
   *@ 10,58 PROMPT padR("2.Historico  " ,15) MESSAGE PADC('P/ LOCALISAR, ALTERAR E EXCLUIR REGISTROS APERTE "2"',67)
   *@ 13,58 PROMPT padR("3.C. Cheques " ,15) MESSAGE PADC('P/ IMPRIMIR RELATORIOS APERTE "3"',67)
   @ 19,58 PROMPT padR("5.Principal   " ,15) MESSAGE PADC('P/ SAIR DO SISTEMA APERTE "5"',67)
   MANMENU=1
   MENU TO MANMENU
   DO CASE
   CASE MANMENU=1 
        MAN00001()
   CASE MANMENU=2 .OR. LASTKEY()=27
        PRINCIPAL()
   ENDCASE
ENDDO
RETURN.T.


FUNCTION MAN00001  // MANUTENCAO DE FUNCIONARIOS
Tone(300,1)
SAVE SCREEN TO M->T_ELA
SELE 2
USE DBFONE INDEX idFONE1,idFONE2
SELE 2
SET ORDER TO 1
GOTO TOP
ENTRADA("MANUTENÄAO DE FUNCIONARIOS")
relevo(06, 56, 08, 73, .T.) // BOTOES
relevo(09, 56, 11, 73, .T.) // BOTOES
relevo(12, 56, 14, 73, .T.) // BOTOES
relevo(15, 56, 17, 73, .T.) // BOTOES
relevo(18, 56, 20, 73, .T.) // BOTOES     
DECLARE DB_CONTE[6],DB_CAB[6]
*DB_CAB[1]="DATA"
DB_CAB[1]="CODIGO"
DB_CAB[2]="NOME"
DB_CAB[3]="DDD"
DB_CAB[4]="TELEFONE"
DB_CAB[5]="ENDERECO"
DB_CAB[6]="OBSERVAÄÂES"
*DB_CONTE[1]='DBDATA(DATA)'
DB_CONTE[1]='CODIGO'
DB_CONTE[2]='NOME'
DB_CONTE[3]='DDD'
DB_CONTE[4]='FONE'
DB_CONTE[5]='ENDERECO'
DB_CONTE[6]='LERMEMO(OBS,44,1)'
KEYBOARD CHR(4)
DBEDIT(10, 08, 17, 52,DB_CONTE,"edita",.T.,DB_CAB,"ƒƒƒ","   ","   ")
RESTORE SCREEN FROM M->T_ELA
RETURN

FUNCTION LERMEMO(PAR,TAM,L)
IF PAR=NIL
   TEXTO="N/D"
   RETURN.F.
  ELSE
   IF TAM=NIL
      TAM=15
   ENDIF
   IF L=NIL
      L=1
   ENDIF
   TEXTO=MEMOLINE(PAR,TAM,L)
ENDIF
IF EMPTY(TEXTO)
   TEXTO=PADR("N/D",TAM)
ENDIF
RETURN TEXTO

FUNCTION EDITA(nMODO,nCOLUNA)
LOCAL nTECLA  := LASTKEY()
LOCAL nCAMPO  := FIELDNAME(nColuna)
LOCAL nRetVaL := 1 // continua dbedit
DO CASE
   CASE nMODO = 0
        SET CURSOR OFF
        @ 07,58 SAY padR("[C] orrigir  ",15) COLOR "N+/B"; @ 07,59 SAY "C" COLOR "W/B"
        @ 10,58 SAY padR("[E] xluir    ",15) COLOR "N+/B"; @ 10,59 SAY "E" COLOR "W/B"
        @ 13,58 SAY padR("[I] ncluir   ",15) COLOR "N+/B"; @ 13,59 SAY "I" COLOR "W/B"
        @ 16,58 SAY padR("[L] ocalizar ",15) COLOR "N+/B"; @ 16,59 SAY "L" COLOR "W/B"
        @ 19,58 SAY padR("[R] elat¢rios ",15) COLOR "N+/B"; @ 19,59 SAY "R" COLOR "W/B"
        @ 22,06 SAY PADC('P/ SAIR DA MANUTENÄ«O APERTE <ESC>',69)
        RETURN(1)  // Continua dbedit
        
   CASE nMODO = 1
        @ 22,10 SAY PADC("INICIO",60)
        RETURN(1) 
   CASE nMODO = 2
        @ 22,10 SAY PADC("FIM",60)
        RETURN(1) 
   CASE nMODO = 3
        @ 23,10 SAY PADC("BANCO DE DADOS VAZIO",60)
        inc00001()
        RETURN(1)
   CASE nMODO = 4
        IF nTECLA == 27 // TECLA: ESC
                  RETURN(0)  
                  SETCOLOR(SALVACOR)
           ELSEIF nTECLA=67 .OR. nTECLA=99 // TECLA: C/c (CORRIGIR)
                  ROW=ROW();COL=COL()
                  @ 07,58 SAY padR("[C] orrigindo  ",15) COLOR "bg*/B"
                  @ 07,59 SAY "C" COLOR "bg+/B"
                  @ ROW,COL SAY ""
                  alt00001(nCOLUNA)
                  RETURN(2)  
           ELSEIF nTECLA=69 .OR. nTECLA=101 .or. nTecla = 7 // TECLA: E/e/del (excluir)
                  @ 10,58 SAY padR("[E] xcluindo   ",15) COLOR "bg*/B"
                  @ 10,59 SAY "E" COLOR "bg+/B"
                  exc00001()
                  RETURN(2)  
           ELSEIF nTECLA=73 .OR. nTECLA=105 // TECLA: I/i (incluir)
                  @ 13,58 SAY padR("[I] ncluindo   ",15) COLOR "bg*/B"
                  @ 13,59 SAY "I" COLOR "bg+/B"
                  inc00001()
                  RETURN(2)  
           ELSEIF nTECLA=76 .OR. nTECLA=108 // TECLA: L/l (localizar)
                  @ 16,58 SAY padR("[L] ocalizando ",15) COLOR "bg*/B"
                  @ 16,59 SAY "L" COLOR "bg+/B"
                  locFONE()// alert("localizar VALORES;n∆o disponivel")
                  RETURN(2)  // atualiza dbedit
           ELSEIF nTECLA=82 .OR. nTECLA=114 // TECLA: R/r (relatorio)
                  @ 19,58 SAY padR("[R] elatando   ",15) COLOR "bg*/B"
                  @ 19,59 SAY "R" COLOR "bg+/B"
                  RELCONTATOS()
                  RETURN(2)  
           ELSEIF nTECLA=13
             do while !eof()
                      oAVISO  =PADc("€€€€≤≤∞∞  V I S U A L I Z A R  ∞∞≤≤€€€€;;",40)+;
                           ";"+PADR("Nome:    ",10)+padR(NOME,30) +;
                           ";"+PADR("Telefone:",10)+padR(DDD+" "+FONE,30)+;
                           ";"+PADR("Endereáo:",10)+padR(ENDERECO,30)+;
                           ";"+PADR("Obs.    :  ",10)+padR(MEMOLINE(OBS,29,1),30)+;
                           ";"+PADR("         ",10)+padR(MEMOLINE(OBS,29,2),30)+;
                           ";"+PADR("         ",10)+padR(MEMOLINE(OBS,29,3),30)
                      aOPCAO  ={padc(CHR(017)+CHR(017)+" Anterior",10), padc("proximo "+CHR(016)+CHR(016),10), padc(" ˛ stop ",10)}
                      aESCOLHA=ALERT(oAVISO, aOPCAO,"W+/N")
                  do case    
                     case aESCOLHA=1 ;SKIP-1
                     case aESCOLHA=2 ;SKIP+1
                     case aESCOLHA=3 ;TONE(1000);EXIT
                     OTHERWISE       ;TONE(1000);EXIT
                  endcase
             endDO
             return(1)
           ELSE
             return(1)
          ENDIF
      OTHERWISE
          RETURN(1)
      ENDCASE


