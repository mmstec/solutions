
FUNCTION MANUTENCAO
DO WHILE.T.
   SALVACOR=SETCOLOR()
   SETCOLOR("N+/B,BG+/B,,,BG+/B")
   ENTRADA("MENU DE MANUTENÄÂES")
   Relevo(06, 56, 08, 73, .T.) // BOTOES
   Relevo(09, 56, 11, 73, .T.) // BOTOES
   Relevo(12, 56, 14, 73, .T.) // BOTOES
   *Relevo(15, 56, 17, 73, .T.) // BOTOES
   Relevo(18, 56, 20, 73, .T.) // BOTOES
   @ 07,58 PROMPT padR("1.Valores "  ,15)
   @ 10,58 PROMPT padR("2.Contas  "  ,15)
   @ 13,58 PROMPT padR("3.Caixas  "  ,15)
   @ 19,58 PROMPT padR("5.Principal" ,15)
   MANMENU=1
   MENU TO MANMENU
   DO CASE
   CASE MANMENU=1 
        MANvalor()
   CASE MANMENU=2
        SAVE SCREEN TO M->T_ELA
        AREA_ANT:= alias()
        SELE 1
        DECLARE DB_CONTE[3],DB_CAB[3]
        DB_CAB[1]="Nß"
        DB_CAB[2]="CONTA"
        DB_CAB[3]="PERCENTUAL"
        DB_CONTE[1]='CODIGO'
        DB_CONTE[2]='DESCRICAO'
        DB_CONTE[3]='str(PERCENTUAL,10,2)+"%"'
        RELEVO(05, 05, 21, 54,.F.,,2) // tela EQUERDA
        RELEVO(06, 06, 08, 53,.T.,,2) // BARRA DE TITULO
        RELEVO(09, 06, 20, 53,.T.,,2) // BARRA INTERNA
        @ 07, 08 SAY PADC("Manutená∆o de Contas",44)  COLOR "W+/R"
        DBEDIT(10, 08, 18, 52,DB_CONTE,"dBeditor",.T.,DB_CAB,"ƒƒƒ","   ","   ")
        SELECT(AREA_ANT)
        RESTORE SCREEN FROM M->T_ELA
   CASE MANMENU=3
        SAVE SCREEN TO M->T_ELA
        AREA_ANT:=ALIAS()
        SELE 2
        DECLARE DB_CONTE[3],DB_CAB[3]
        DB_CAB[1]="Nß"
        DB_CAB[2]="CAIXA"
        DB_CAB[3]="PG"
        DB_CONTE[1]='CODIGO'
        DB_CONTE[2]='DESCRICAO'
        DB_CONTE[3]='PGCOMISSAO'
        RELEVO(05, 05, 21, 54,.F.,,2) // tela EQUERDA
        RELEVO(06, 06, 08, 53,.T.,,2) // BARRA DE TITULO
        RELEVO(09, 06, 20, 53,.T.,,2) // BARRA INTERNA
        @ 07, 08 SAY PADC("Manutená∆o de Caixas",44)  COLOR "W+/R"
        DBEDIT(10, 08, 18, 52,DB_CONTE,"dBeditor",.T.,DB_CAB,"ƒƒƒ","   ","   ")
        SELECT(AREA_ANT)
        RESTORE SCREEN FROM M->T_ELA
   CASE MANMENU=4 .OR. LASTKEY()=27
        PRINCIPAL()
   ENDCASE
ENDDO
RETURN.T.


FUNCTION MANvalor
SAVE SCREEN TO M->T_ELA
SELE 3
USE DBvalor INDEX iDvalor1,iDvalor2,iDvalor3,iDvalor4
SELE 3
set order to 1
GOTO TOP
ENTRADA("MANUTENÄ«O DE VALORES")
relevo(06, 56, 08, 73, .T.) // BOTOES
relevo(09, 56, 11, 73, .T.) // BOTOES
relevo(12, 56, 14, 73, .T.) // BOTOES
relevo(15, 56, 17, 73, .T.) // BOTOES
relevo(18, 56, 20, 73, .T.) // BOTOES     
DECLARE DB_CONTE[5],DB_CAB[5]
DB_CAB[1]="DATA"
DB_CAB[2]="CT"
DB_CAB[3]="CX"
DB_CAB[4]=padL("VALOR",10)
DB_CAB[5]=padL("COMISS«O",10)
DB_CONTE[1]='DBDATA(DATA)'
DB_CONTE[2]='lkCONTA'
DB_CONTE[3]='lkCAIXA'
DB_CONTE[4]='STR(VALOR,10,2)'
DB_CONTE[5]='STR(COMISSAO,10,2)'
DBEDIT(10, 08, 17, 52,DB_CONTE,"edita",.T.,DB_CAB,"ƒƒƒ","   ","   ")
RESTORE SCREEN FROM M->T_ELA
RETURN

FUNCTION EDITA(nMODO,nCOLUNA)
LOCAL nTECLA  := LASTKEY()
LOCAL nCAMPO  := FIELDNAME(nColuna)
LOCAL nRetVaL := 1 // continua dbedit
DO CASE
   CASE nMODO = 0
        SET CURSOR OFF
        relevo(06, 56, 08, 73, .T.) // BOTOES
        relevo(09, 56, 11, 73, .T.) // BOTOES
        relevo(12, 56, 14, 73, .T.) // BOTOES
        relevo(15, 56, 17, 73, .T.) // BOTOES
        relevo(18, 56, 20, 73, .T.) // BOTOES     
        @ 07,58 SAY padR("[C] orrigir  ",15) COLOR "N+/B"; @ 07,59 SAY "C" COLOR "W/B"
        @ 10,58 SAY padR("[E] xluir    ",15) COLOR "N+/B"; @ 10,59 SAY "E" COLOR "W/B"
        @ 13,58 SAY padR("[I] ncluir   ",15) COLOR "N+/B"; @ 13,59 SAY "I" COLOR "W/B"
        @ 16,58 SAY padR("[L] ocalizar ",15) COLOR "N+/B"; @ 16,59 SAY "L" COLOR "W/B"
        @ 19,58 SAY padR("[R] elat¢rios ",15) COLOR "N+/B"; @ 19,59 SAY "R" COLOR "W/B"
        @ 22,06 SAY PADC('P/ SAIR DA MANUTENÄ«O APERTE "ESC"',69)
        @ 19,08 SAY ""  COLOR "RG+*/B"
        @ 19,10 SAY PADC(LKCONTA+" "+NCONTA(LKCONTA)+" "+LKCAIXA+" "+NCAIXA(LKCAIXA),41) COLOR "R+ /B"

        REPLACE COMISSAO WITH COMISSAO(VALOR,LKCONTA,LKCAIXA)
        RETURN(1)  // Continua dbedit
        
   CASE nMODO = 1
        @ 22,10 SAY PADC("INICIO",60)
        RETURN(1) 
   CASE nMODO = 2
        @ 22,10 SAY PADC("FIM",60)
        RETURN(1)
   CASE nMODO = 3
        @ 23,10 SAY PADC("BANCO DE DADOS VAZIO",60)
        incValores()
        RETURN(1)
   CASE nMODO = 4
        IF nTECLA == 27 // TECLA: ESC
                  RETURN(0)  // aborta dbedit
                  SETCOLOR(SALVACOR)
           ELSEIF nTECLA=67 .OR. nTECLA=99 // TECLA: A/a (CORRIGIR)
                  COL=COL()
                  ROW=ROW()
                  relevo(06, 56, 08, 73, .F.) // BOTOES
                  @ 07,58 SAY padR("[C] orrigir   ",15) COLOR "bg/B"
                  @ 07,59 SAY "C" COLOR "bg+/B"
                  @ row,col say ""
                  altVALORES(nCOLUNA)
                  RETURN(2)  // atualiza dbedit
           ELSEIF nTECLA=69 .OR. nTECLA=101 .or. nTecla = 7 // TECLA: E/e/del (excluir)
                  relevo(09, 56, 11, 73, .T.) // BOTOES
                  @ 10,58 SAY padR("[E] xcluir   ",15) COLOR "bg/B"
                  @ 10,59 SAY "E" COLOR "bg+/B"
                  excVALORES()
                  RETURN(2)  // atualiza dbedit
           ELSEIF nTECLA=73 .OR. nTECLA=105 // TECLA: I/i (incluir)
                  relevo(12, 56, 14, 73, .T.) // BOTOES     
                  @ 13,58 SAY padR("[I] ncluir   ",15) COLOR "bg/B"
                  @ 13,59 SAY "I" COLOR "bg+/B"
                  incVALORES()
                  RETURN(2)  // atualiza dbedit
           ELSEIF nTECLA=76 .OR. nTECLA=108 // TECLA: L/l (localizar)
                  relevo(15, 56, 17, 73, .F.) // BOTOES     
                  @ 16,58 SAY padR("[L] ocalizar   ",15) COLOR "bg/B"
                  @ 16,59 SAY "L" COLOR "bg+/B"
                  locVALORES()// alert("localizar VALORES;n∆o disponivel")
                  RETURN(2)  // atualiza dbedit
           ELSEIF nTECLA=82 .OR. nTECLA=114 // TECLA: R/r (relatorio)
                  relevo(18, 56, 20, 73, .F.) // BOTOES     
                  @ 19,58 SAY padR("[R] elat¢rios",15) COLOR "bg/B"
                  @ 19,59 SAY "R" COLOR "bg+/B"
                  relvalores() // alert("relatorio de VALORES;n∆o disponivel")
                  RETURN(2)  // atualiza dbedit
           ELSEIF nTECLA=13
             do while !eof()
                TONE(900)
                oAVISO  =PADR(";€€€€≤≤∞∞  L O C A L I Z A D O  ∞∞≤≤€€€€;;",40)+;
                       ";;"+PADR("DATA.....:" ,10)    +":"+PADR(DBDATA(DATA),30)+;
                        ";"+PADR("CONTA....:",10)    +":"+PADR(LKCONTA+" "+NCONTA(LKCONTA),30)+;
                        ";"+PADR("CAIXA....:",10)    +":"+PADR(LKCAIXA+" "+NCAIXA(LKCAIXA),30)+;
                        ";"+PADR("VALOR....:",10)    +":"+PADR(str(valor,10,2),30)+;
                        ";"+PADR("COMISSAO.:",10)+":"+PADR(str(comissao,10,2),30)
                  
                  aOPCAO  ={padc(CHR(017)+CHR(017)+" Anterior",10), padc("proximo "+CHR(016)+CHR(016),10), padc(" ˛ stop ",10)}
                  aESCOLHA=ALERT(oAVISO, aOPCAO,"W+/N")
                  do case    
                     case aESCOLHA=1 ;SKIP-1
                     case aESCOLHA=2 ;SKIP+1
                     case aESCOLHA=3 ;TONE(1000);EXIT
                     OTHERWISE       ;TONE(1000);EXIT
                  endcase
             endDO
                 TONE(500)
                 RETURN(1)
          ELSE
                  RETURN(1)
          ENDIF
          
      OTHERWISE
          RETURN(1)
      ENDCASE


FUNCTION dBeditor(nMODO,nCOLUNA)
LOCAL nTECLA  := LASTKEY()
LOCAL nCAMPO  := FIELDNAME(nColuna)
LOCAL nRetVaL := 1 
DO CASE
   CASE nMODO = 0
        SET CURSOR OFF
        @ 07,58 SAY padR("[C] orrigir  ",15) COLOR "N+/B"; @ 07,59 SAY "C" COLOR "W/B"
        @ 10,58 SAY padR("[E] xluir    ",15) COLOR "N+/B"; @ 10,59 SAY "E" COLOR "W/B"
        @ 13,58 SAY padR("[I] ncluir   ",15) COLOR "N+/B"; @ 13,59 SAY "I" COLOR "W/B"
        @ 16,58 SAY padR("[L] ocalizar ",15) COLOR "N+/B"; @ 16,59 SAY "L" COLOR "W/B"
        @ 19,58 SAY padR("[R] elat¢rios ",15) COLOR "N+/B"; @ 19,59 SAY "R" COLOR "W/B"
        @ 22,06 SAY PADC('P/ SAIR DA MANUTENÄ«O APERTE <ESC>',69)
        IF DBF()="DBCONTA"
           IF PERCENTUAL>0
             @ 19, 08 SAY PADC("PERCENTUAL PARA ESTA CONTA: "+str(percentual,4,2)+"%",44) COLOR "g+/B"
             else
             @ 19, 08 SAY PADC("ESTA CONTA N«O GERA COMISSAO",44) COLOR "R+/B"
           ENDIF
          ELSEIF DBF()="DBCAIXA"
           IF PGCOMISSAO="S"
              @ 19, 08 SAY PADC("Caixa comissionado",44) COLOR "g+/B"
              ELSE
              @ 19, 08 SAY PADC("Caixa N«O comissionado",44) COLOR "r+/B"
           ENDIF
        ENDIF
        @ 22,06 SAY PADC('P/ RETORNAR APERTE "ESC"',69)
        RETURN(1) 

   CASE nMODO = 1
        @ 22,10 SAY PADC("INICIO",60)
        RETURN(1) 
   CASE nMODO = 2
        @ 22,10 SAY PADC("FIM",60)
        RETURN(1) 
   CASE nMODO = 3
        @ 23,10 SAY PADC("BANCO DE DADOS VAZIO",60)
        RETURN(1) 
   CASE nMODO = 4
        IF nTECLA == 27 // TECLA: ESC
           RETURN(0)
           ELSE
           RETURN(2)
        ENDIF
   OTHERWISE
        RETURN(1)
   ENDCASE
RETURN.T.

