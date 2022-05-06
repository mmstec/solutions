FUNCTION MANUTENCAO
Tone(300,1)
DO WHILE.T.
   SALVACOR=SETCOLOR()
   SETCOLOR("N+/B,BG+/B,,,BG+/B")
   ENTRADA("MENU DE MANUTENÄOES")
   Relevo(06, 56, 08, 73, .T.) // BOTOES
   Relevo(09, 56, 11, 73, .T.) // BOTOES
   Relevo(12, 56, 17, 73, .T.) // BOTOES
   Relevo(18, 56, 20, 73, .T.) // BOTOES
   @ 07,58 PROMPT padR("1.Funcionarios" ,15)
   @ 10,58 PROMPT padR("2.Salarios    " ,15)
   @ 19,58 PROMPT padR("5.Principal   " ,15)
   MANMENU=1
   MENU TO MANMENU
   DO CASE
   CASE MANMENU=1 
        MANFLH()
   CASE MANMENU=2 
        MANSAL()
        *alert("Operacao ainda nao disponivel") 
   CASE MANMENU=3 .OR. LASTKEY()=27
        PRINCIPAL()
   ENDCASE
ENDDO
RETURN.T.

FUNCTION MANFLH
Tone(300,1)
SAVE SCREEN TO M->T_ELA
SELE 2
USE DBFLH INDEX idFLH1,idFLH2
SELE 2
SET ORDER TO 1
GOTO TOP
ENTRADA("MANUTENÄAO DE FUNCIONARIOS")
relevo(06, 56, 08, 73, .T.) // BOTOES
relevo(09, 56, 11, 73, .T.) // BOTOES
relevo(12, 56, 14, 73, .T.) // BOTOES
relevo(15, 56, 17, 73, .T.) // BOTOES
relevo(18, 56, 20, 73, .T.) // BOTOES     
DECLARE DB_CONTE[20],DB_CAB[20]
DB_CAB[1] ="GRUPO"
DB_CAB[2] ="CODIGO"
DB_CAB[3] ="ALCUNHA"  
DB_CAB[4] ="NOME"
DB_CAB[5] ="CARGO"  
DB_CAB[6] ="RG"  
DB_CAB[7] ="CPF" 
DB_CAB[8] ="C.TRABALHO"
DB_CAB[9] ="SERIE"
DB_CAB[10] ="NASCIMENTO"
DB_CAB[11] ="ENDERECO"  
DB_CAB[12]="FONE"      
DB_CAB[13]="NßSALARIOS"  
DB_CAB[14]="R$ S. BASE"  
DB_CAB[15]="R$ PRODUT."  
DB_CAB[16]="R$ GRATIF."  
DB_CAB[17]="R$ OUTROS"  
DB_CAB[18]="DATA"      
DB_CAB[19]="ADMISSAO"      
DB_CAB[20]="DEMISSAO"      
*******************
DB_Conte[1]="GRUPO"
DB_Conte[2]="CODIGO"
DB_Conte[3]="ALCUNHA"
DB_Conte[4]="NOME"
DB_Conte[5]="CARGO"
DB_Conte[6]="RG"  
DB_Conte[7]="CPF" 
DB_Conte[8]="CTRABALHON"
DB_Conte[9]="CTRABALHOS"
DB_Conte[10]="NASCIMENTO"
DB_Conte[11]="ENDERECO"  
DB_Conte[12]="FONE"      
DB_Conte[13]="SALARIOQ"  
DB_Conte[14]="SALARIOB"  
DB_Conte[15]="SALARIOP"  
DB_Conte[16]="SALARIOG"  
DB_Conte[17]="SALARIOX"  
DB_Conte[18]="DATA"      
DB_Conte[19]="ADMISAO"      
DB_Conte[20]="DEMISAO"      
KEYBOARD CHR(4)+CHR(4)
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
        PRODUTIVIDADE=(SALARIOB*5)/100
        @ 18,08 SAY PADR(NOME,44) color "RG+/B"
        IF !EMPTY(DEMISAO)
           @ 19,08 SAY PADR("((((   D E M I T I D O   ))))",44) color "RG+*/R"
           TONE(500)
           TONE(500)
           ELSE
           @ 19,08 SAY PADR("SALARIO: 1/1=R$"+ALLTRIM(STR(SALARIOB+SALARIOP+SALARIOG+SALARIOX,10,2))+" OU 1/4=R$"+ALLTRIM(STR((SALARIOB+SALARIOP+SALARIOG+SALARIOX)/4,10,2))+") ",44) color "W+/b"
        ENDIF
        @ 07,58 SAY padR("[C] orrigir  ",15) COLOR "N+/B"; @ 07,59 SAY "C" COLOR "W/B"
        @ 10,58 SAY padR("[E] xluir    ",15) COLOR "N+/B"; @ 10,59 SAY "E" COLOR "W/B"
        @ 13,58 SAY padR("[I] ncluir   ",15) COLOR "N+/B"; @ 13,59 SAY "I" COLOR "W/B"
        @ 16,58 SAY padR("[L] ocalizar ",15) COLOR "N+/B"; @ 16,59 SAY "L" COLOR "W/B"
        @ 19,58 SAY padR("[R] elat¢rios ",15) COLOR "N+/B"; @ 19,59 SAY "R" COLOR "W/B"
        @ 22,06 SAY PADC('P/ SAIR DA MANUTENÄAO APERTE <ESC>',69)
        RETURN(1)  // Continua dbedit
        
   CASE nMODO = 1
        @ 22,10 SAY PADC("REGISTRO INICIAL",60) COLOR "BG+*/B";TONE(500)
        RETURN(1) 
   CASE nMODO = 2
        @ 22,10 SAY PADC("REGISTRO FINAL",60)   COLOR "BG+*/B";TONE(500)
        RETURN(1) 
   CASE nMODO = 3
        @ 23,10 SAY PADC("REGISTRO NAO EXISTENTE",60)
        incFLH()
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
                  altFLH(nCOLUNA)
                  RETURN(2)  
           ELSEIF nTECLA=69 .OR. nTECLA=101 .or. nTecla = 7 // TECLA: E/e/del (excluir)
                  @ 10,58 SAY padR("[E] xcluindo   ",15) COLOR "bg*/B"
                  @ 10,59 SAY "E" COLOR "bg+/B"
                  excFLH()
                  RETURN(2)  
           ELSEIF nTECLA=73 .OR. nTECLA=105 // TECLA: I/i (incluir)
                  @ 13,58 SAY padR("[I] ncluindo   ",15) COLOR "bg*/B"
                  @ 13,59 SAY "I" COLOR "bg+/B"
                  incFLH()
                  RETURN(2)  
           ELSEIF nTECLA=76 .OR. nTECLA=108 // TECLA: L/l (localizar)
                  @ 16,58 SAY padR("[L] ocalizando ",15) COLOR "bg*/B"
                  @ 16,59 SAY "L" COLOR "bg+/B"
                  locFLH()// alert("localizar VALORES;n∆o disponivel")
                  RETURN(2)  // atualiza dbedit
           ELSEIF nTECLA=82 .OR. nTECLA=114 // TECLA: R/r (relatorio)
                  @ 19,58 SAY padR("[R] elatando   ",15) COLOR "bg*/B"
                  @ 19,59 SAY "R" COLOR "bg+/B"
                  RELCONTATOS()
                  RETURN(2)  
           ELSEIF nTECLA=13
             do while !eof()
                      salarion=salariob+salariop+salariog+salariox
                      oAVISO  =PADc(";€€≤≤∞∞  V I S U A L I Z A N D O ∞∞≤≤€€;;;",40)+;
                              ";"+PADR("Grupo:",10)+padr(Grupo,30)+;
                              ";"+PADR("Alcunha: ",10)+padr(Alcunha, 30)+;
                              ";"+PADR("Nome: ",10)+padr(Nome, 30)+;
                              ";"+PADR("Cargo:",10)+padr(Cargo,30)+;
                              ";"+PADR("S/mes:",10)+padr("R$"+alltrim(str(salarion,10,2)),30)+;
                              ";"+PADR("S/semana:",10)+padr("R$"+alltrim(str(salarion/4,10,2)),30)+;
                              ";"+PADR("RG:   ",10)+padr(RG,30)+;
                              ";"+PADR("CPF:  ",10)+padr(CPF,30)+;
                              ";"+PADR("C.Trab:",10)+padr(ALLTRIM(ctrabalhon)+"-"+ctrabalhos,30)
                      aOPCAO  ={padc(CHR(017)+CHR(017)+" Anterior",10), padc("proximo "+CHR(016)+CHR(016),10), padc(" ˛ stop ",10)}
                      aESCOLHA=ALERT(oAVISO, aOPCAO,"W+/N")
                  do case    
                     case aESCOLHA=1 ;SKIP-1
                     case aESCOLHA=2 ;SKIP+1
                     case aESCOLHA=3 ;TONE(1000);EXIT
                     OTHERWISE       ;TONE(1000);EXIT
                  endcase
               enddo
                  return(1)
           ELSE
                  return(1)
          ENDIF
      OTHERWISE
          RETURN(1)
      ENDCASE

***************************************************************
FUNCTION MANSAL
Tone(300,1)
SAVE SCREEN TO M->T_ELA
SELE 3
USE DBSAL INDEX idSAL1,idSAL2
SELE 3
SET ORDER TO 1
GOTO TOP
ENTRADA("MANUTENÄAO DE SALARIOS")
relevo(06, 56, 08, 73, .T.) // BOTOES
relevo(09, 56, 11, 73, .T.) // BOTOES
relevo(12, 56, 14, 73, .T.) // BOTOES
relevo(15, 56, 17, 73, .T.) // BOTOES
relevo(18, 56, 20, 73, .T.) // BOTOES     
DECLARE DB_CONTE[02],DB_CAB[02]
DB_CAB[1] ="DATA"
DB_CAB[2] ="SALARIO"
*******************
DB_Conte[1]="SDATA"
DB_Conte[2]="SMINIMO"
DBEDIT(10, 08, 17, 52,DB_CONTE,"EDITASAL",.T.,DB_CAB,"ƒƒƒ","   ","   ")
RESTORE SCREEN FROM M->T_ELA
RETURN

FUNCTION EDITASAL(nMODO,nCOLUNA)
LOCAL nTECLA  := LASTKEY()
LOCAL nCAMPO  := FIELDNAME(nColuna)
LOCAL nRetVaL := 1 // continua dbedit
DO CASE
   CASE nMODO = 0
        SET CURSOR OFF
        @ 07,58 SAY padR("[C] orrigir  ",15) COLOR "N+/B"; @ 07,59 SAY "C" COLOR "W/B"
        *@ 10,58 SAY padR("[E] xluir    ",15) COLOR "N+/B"; @ 10,59 SAY "E" COLOR "W/B"
        *@ 13,58 SAY padR("[I] ncluir   ",15) COLOR "N+/B"; @ 13,59 SAY "I" COLOR "W/B"
        *@ 16,58 SAY padR("[L] ocalizar ",15) COLOR "N+/B"; @ 16,59 SAY "L" COLOR "W/B"
        *@ 19,58 SAY padR("[R] elat¢rios ",15) COLOR "N+/B"; @ 19,59 SAY "R" COLOR "W/B"
        @ 22,06 SAY PADC('P/ SAIR DA MANUTENÄAO APERTE <ESC>',69)
        RETURN(1)  // Continua dbedit
        
   CASE nMODO = 1
        @ 22,10 SAY PADC("REGISTRO INICIAL",60) COLOR "BG+*/B";TONE(500)
        RETURN(1) 
   CASE nMODO = 2
        @ 22,10 SAY PADC("REGISTRO FINAL",60)   COLOR "BG+*/B";TONE(500)
        RETURN(1) 
   CASE nMODO = 3
        @ 23,10 SAY PADC("REGISTRO NAO EXISTENTE",60)
        incSAL()
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
                  altSAL(nCOLUNA)
                  RETURN(2)  
           *ELSEIF nTECLA=69 .OR. nTECLA=101 .or. nTecla = 7 // TECLA: E/e/del (excluir)
           *       @ 10,58 SAY padR("[E] xcluindo   ",15) COLOR "bg*/B"
           *       @ 10,59 SAY "E" COLOR "bg+/B"
           *       excSAL()
           *       RETURN(2)  
           *ELSEIF nTECLA=73 .OR. nTECLA=105 // TECLA: I/i (incluir)
           *       @ 13,58 SAY padR("[I] ncluindo   ",15) COLOR "bg*/B"
           *       @ 13,59 SAY "I" COLOR "bg+/B"
           *       incSAL()
           *       RETURN(2)  
           *ELSEIF nTECLA=76 .OR. nTECLA=108 // TECLA: L/l (localizar)
           *       @ 16,58 SAY padR("[L] ocalizando ",15) COLOR "bg*/B"
           *       @ 16,59 SAY "L" COLOR "bg+/B"
           *       locSAL()// alert("localizar VALORES;n∆o disponivel")
           *       RETURN(2)  // atualiza dbedit
           *ELSEIF nTECLA=82 .OR. nTECLA=114 // TECLA: R/r (relatorio)
           *       @ 19,58 SAY padR("[R] elatando   ",15) COLOR "bg*/B"
           *       @ 19,59 SAY "R" COLOR "bg+/B"
           *       RELCONTATOS()
           *       RETURN(2)  
           ELSE
                  RETURN(1)
          ENDIF
      OTHERWISE
          RETURN(1)
      ENDCASE

