FUNCTION MANUTENCAO
Tone(300,1)
DO WHILE.T.
   SALVACOR=SETCOLOR()
   SETCOLOR("N+/B,BG+/B,,,BG+/B")
   ENTRADA("MENU DE MANUTENÄÂES")
   Relevo(06, 56, 08, 73, .T.) // BOTOES
   Relevo(09, 56, 17, 73, .T.) // BOTOES
   Relevo(18, 56, 20, 73, .T.) // BOTOES
   @ 07,58 PROMPT padR("1.Funcionarios" ,15)
   @ 19,58 PROMPT padR("5.Principal   " ,15)
   MANMENU=1
   MENU TO MANMENU
   DO CASE
   CASE MANMENU=1 
        MANCAD()
   CASE MANMENU=2 .OR. LASTKEY()=27
        PRINCIPAL()
   ENDCASE
ENDDO
RETURN.T.


FUNCTION MANCAD
Tone(300,1)
SAVE SCREEN TO M->T_ELA
SELE 2
USE DBCAD INDEX idCAD1,idCAD2
SELE 2
SET ORDER TO 1
GOTO TOP
ENTRADA("MANUTENÄ«O DE CONTATOS")
relevo(06, 56, 08, 73, .T.) // BOTOES
relevo(09, 56, 11, 73, .T.) // BOTOES
relevo(12, 56, 14, 73, .T.) // BOTOES
relevo(15, 56, 17, 73, .T.) // BOTOES
relevo(18, 56, 20, 73, .T.) // BOTOES     
DECLARE DB_CONTE[19],DB_CAB[19]
DB_CAB[1] ="DATA"
DB_CAB[2] ="CODIGO"
DB_CAB[3] ="NOME"
DB_CAB[4] ="RG"  
DB_CAB[5] ="CPF"  
DB_CAB[6] ="C.TRABALHO"
DB_CAB[7] ="NASCIMENTO"
DB_CAB[8] ="ENDERECO"  
DB_CAB[9] ="FONE"
DB_CAB[10]="OBS"  
********************
DB_CAB[11]="EMPRESA"      
DB_CAB[12]="ENDERECO"  
DB_CAB[13]="FONE"  
DB_CAB[14]="CARGO"  
DB_CAB[15]="SALARIO"  
DB_CAB[16]="ADMISSAO"      
DB_CAB[17]="DEMISSAO"      
DB_CAB[18]="MOTIVO"      
*******************
DB_Conte[1]="c1DATA"  
DB_Conte[2]="c1CODIGO"
DB_Conte[3]="c1NOME"  
DB_Conte[4]="c1RG"    
DB_Conte[5]="c1CPF"   
DB_Conte[6]="c1CTRABN"
DB_Conte[7]="c1CTRABS"
DB_Conte[8]="c1NASCI" 
DB_Conte[9]="c1ENDE"  
DB_Conte[10]="c1FONE"  
DB_Conte[11]="c1OBS"   
************************
DB_Conte[12]="c2EMPRESA"
DB_Conte[13]="c2ENDE"   
DB_Conte[14]="c2FONE"   
DB_Conte[15]="c2CARGO"  
DB_Conte[16]="c2SALARIO"
DB_Conte[17]="c2ADMISAO"
DB_Conte[18]="c2DEMISAO"
DB_Conte[19]="c2MOTIVO" 
***********************
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
        incCAD()
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
                  altCAD(nCOLUNA)
                  RETURN(2)  
           ELSEIF nTECLA=69 .OR. nTECLA=101 .or. nTecla = 7 // TECLA: E/e/del (excluir)
                  @ 10,58 SAY padR("[E] xcluindo   ",15) COLOR "bg*/B"
                  @ 10,59 SAY "E" COLOR "bg+/B"
                  excCAD()
                  RETURN(2)  
           ELSEIF nTECLA=73 .OR. nTECLA=105 // TECLA: I/i (incluir)
                  @ 13,58 SAY padR("[I] ncluindo   ",15) COLOR "bg*/B"
                  @ 13,59 SAY "I" COLOR "bg+/B"
                  incCAD()
                  RETURN(2)  
           ELSEIF nTECLA=76 .OR. nTECLA=108 // TECLA: L/l (localizar)
                  @ 16,58 SAY padR("[L] ocalizando ",15) COLOR "bg*/B"
                  @ 16,59 SAY "L" COLOR "bg+/B"
                  locCAD()// alert("localizar VALORES;n∆o disponivel")
                  RETURN(2)  // atualiza dbedit
           ELSEIF nTECLA=82 .OR. nTECLA=114 // TECLA: R/r (relatorio)
                  @ 19,58 SAY padR("[R] elatando   ",15) COLOR "bg*/B"
                  @ 19,59 SAY "R" COLOR "bg+/B"
                  RELCONTATOS()
                  RETURN(2)  
           ELSEIF nTECLA=13
                  do while !eof()
                     if ALERT(PADc("€€€€≤≤∞∞  V I S U A L I S A R  ∞∞≤≤€€€€;;",40)+;
                        ";"+PADR("Informaáoes Pessoais",40)+;
                        ";"+PADR("Nome:"     ,10)+padr(c1Nome, 30)+;
                        ";"+PADR("Endereco:",10)+padr(c1ende, 30)+;
                        ";"+PADR("Fone:"    ,10)+padr(c1FONE, 30)+;
                        ";"+PADR("RG:"      ,10)+padr(c1RG,30)+;
                        ";"+PADR("CPF:"     ,10)+padr(c1CPF,30)+;
                        ";"+PADR("C.Trab:"  ,10)+padr(alltrim(c1Ctrabn)+" Serie: "+c1Ctrabs,30)+;
                        ";"+PADC("---X---",40)+;
                        ";"+PADR("Informaáoes do Ultimo Trabalho",40)+;
                        ";"+PADR("EMPRESA:"  ,10)+padr(C2EMPRESA,30)+;
                        ";"+PADR("CARGO:"    ,10)+padr(C2Cargo,30)+;
                        ";"+PADR("ADMISSAO:" ,10)+padr(DTOC(C2ADMISAO),30)+;
                        ";"+PADR("DEMISSAO:" ,10)+padr(DTOC(C2DEMISAO),30)+;
                        ";"+PADR("MOTIVO:"   ,10)+padr(C2MOTIVO,30),{PADC("PROXIMO",10),PADC("RETORNA",10)},"W+/N")==1
                        SKIP
                        ELSE
                        EXIT
                        ENDIF
                     ENDDO
                  return(1)
           ELSE
                  return(1)
          ENDIF
      OTHERWISE
          RETURN(1)
      ENDCASE


