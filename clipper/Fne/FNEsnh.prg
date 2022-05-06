FUNCTION manSNH
SAVE SCREEN TO M->T_ELA
SELE 1
USE DBSYS INDEX IDSYS1,IDSYS2
SET ORDER TO 2
GOTO TOP
ENTRADA("Cadastro de Usu rios")
relevo(06, 56, 08, 73, .T.) // BOTOES
relevo(09, 56, 11, 73, .T.) // BOTOES
relevo(12, 56, 14, 73, .T.) // BOTOES
relevo(15, 56, 17, 73, .T.) // BOTOES
relevo(18, 56, 20, 73, .T.) // BOTOES     
DECLARE DB_CONTE[3],DB_CAB[3]
DB_CAB[1]="Usu rio"
DB_CAB[2]="Senha"
DB_CAB[3]="Nivel"
DB_CONTE[1]='Usuario'
DB_CONTE[2]='Senha'
DB_CONTE[3]='Nivel'
DBEDIT(10, 07, 19, 52,DB_CONTE,"DBEDITA4",.T.,DB_CAB,"ÄÄÄ","   ","   ")
RESTORE SCREEN FROM M->T_ELA
RETURN

FUNCTION DBEDITA4(nMODO,nCOLUNA)
LOCAL nTECLA  := LASTKEY()
LOCAL nCAMPO  := FIELDNAME(nColuna)
LOCAL nRetVaL := 1 // continua dbedit
DO CASE
   CASE nMODO = 0
        SET CURSOR OFF
        @ 07,58 SAY padR("[A] lterar   ",15) COLOR "N+/B"; @ 07,59 SAY "A" COLOR "W/B"
        @ 10,58 SAY padR("[E] xluir    ",15) COLOR "N+/B"; @ 10,59 SAY "E" COLOR "W/B"
        @ 13,58 SAY padR("[I] ncluir   ",15) COLOR "N+/B"; @ 13,59 SAY "I" COLOR "W/B"
        @ 16,58 SAY padR("[L] ocalizar ",15) COLOR "N+/B"; @ 16,59 SAY "L" COLOR "W/B"
        @ 19,58 SAY padR("[ESC] sa¡da  ",15) COLOR "N+/B"; @ 19,59 SAY "ESC" COLOR "W/B"
        @ 22,06 SAY PADC('P/ SAIR DA MANUTEN€ÇO APERTE "ESC"',69)
        RETURN(1)  // Continua dbedit
        
   CASE nMODO = 1
        @ 22,10 SAY PADC("INICIO",60)
        RETURN(1) // continua dbedit
   CASE nMODO = 2
        @ 22,10 SAY PADC("FIM",60)
        RETURN(1) // continua dbedit
   CASE nMODO = 3
        @ 23,10 SAY PADC("BANCO DE DADOS VAZIO",60)
        @ 13,58 SAY padR("[I] ncluir   ",15) COLOR "BG+/B"
        @ 13,59 SAY "I" COLOR "R+*/B"
        set order to 1
        incSNH()
        set order to 2
        RETURN(2)  // atualiza dbedit
   CASE nMODO = 4
        IF nTECLA == 27 // TECLA: ESC
                  @ 19,58 SAY padR("[ESC] SAIDA",15) COLOR "BG+/B"
                  @ 19,59 SAY "ESC" COLOR "R+*/B"
                  RETURN(0)  // aborta dbedit
                  SETCOLOR(SALVACOR)
           ELSEIF nTECLA=65 .OR. nTECLA=97 // TECLA: A/a (alterar)
                  SAVE SCREEN TO M->T_ELA
                  @ 07,58 SAY padR("[A] lterar   ",15) COLOR "BG+/B"
                  @ 07,59 SAY "A" COLOR "R+*/B"
                  altSNH(nCOLUNA)
                  RESTORE SCREEN FROM M->T_ELA
                  RETURN(2)  // atualiza dbedit
           ELSEIF nTECLA=69 .OR. nTECLA=101 .or. nTecla = 7 // TECLA: E/e/del (excluir)
                  SAVE SCREEN TO M->T_ELA
                  @ 10,58 SAY padR("[E] xluir    ",15) COLOR "BG+/B"
                  @ 10,59 SAY "E" COLOR "R+*/B"
                  excSNH()
                  RESTORE SCREEN FROM M->T_ELA
                  RETURN(2)  // atualiza dbedit
           ELSEIF nTECLA=73 .OR. nTECLA=105 // TECLA: I/i (incluir)
                  SAVE SCREEN TO M->T_ELA
                  @ 13,58 SAY padR("[I] ncluir   ",15) COLOR "BG+/B"
                  @ 13,59 SAY "I" COLOR "R+*/B"
                  set order to 1
                  incSNH()
                  set order to 2
                  RESTORE SCREEN FROM M->T_ELA
                  RETURN(2)  // atualiza dbedit
           ELSEIF nTECLA=76 .OR. nTECLA=108 // TECLA: L/l (localizar)
                  @ 16,58 SAY padR("[L] ocalizar ",15) COLOR "BG+/B"
                  @ 16,59 SAY "L" COLOR "R+*/B"
                  locSNH() 
                  RETURN(2)  // atualiza dbedit
           ELSE
                  RETURN(2)  // atualiza dbedit
          ENDIF
      OTHERWISE
          RETURN(1)
      ENDCASE



function incSNH
   AREA=SELECT()
   sele 1
   set index to idSYS1,IDSYS2
   set order to 1
   tentativa:= 0
   set cursor on
   do while (.T.)
      if (tentativa >= 3)
         alert("Sinto muito;;Esgotaram-se as tentativas permitidas;")
      endif
      cNome := space(30)
      cSenha:= space(06)
      cNivel:= 1
      RELEVO(05, 05, 21, 54,.F.,,2) // tela ESQUERDA
      RELEVO(06, 06, 08, 53,.T.,,2) // BARRA DE TITULO
      RELEVO(09, 18, 15, 53,.T.,,1) // tela ESQUERDA
      *RELEVO(16, 18, 20, 53,.T.,,2) // BARRA DE INFERIOR
      
      @ 07,07 SAY PADC("INCLUSÇO DE USUµRIO",45)  color "W+/R"
      @ 10,08 say PADL("Nome"    ,10)           COLOR "W/B"
      @ 12,08 say PADL("Senha"   ,10)           COLOR "W/B"
      @ 12,27 SAY PADR("<= USE APENAS NUMEROS",20) COLOR "R+*/B"
      @ 14,08 say PADL("Nivel"   ,10)           COLOR "W/B"
      @ 10, 19 get cNome  PICT "@!" valid !empty(cNome)    color "w+/Bg"
      @ 12, 19 get cSenha PICT "@9" valid CODIFICA(cSenha) color "w+/Bg"
      @ 14, 19 get cNivel PICT "@9" valid !empty(cNivel) .AND. cNIVEL<=3  color "w+/Bg"
      @ 17, 10 SAY "Nivel 1 = Acesso restrito"                    color "N+/B"
      @ 18, 10 SAY "Nivel 2 = Acesso medial  "                    color "N+/B"
      @ 19, 10 SAY "Nivel 3 = Acesso total   <ESC> SAI"           color "N+/B"
      @ 16,08 TO 20,53                                            color "N+/B"
      @ 16,10 SAY "Aten‡Æo"                                       color "BG/B"
      read
      if (LastKey() == 27)
         return(.f.)
      endif
      tentativa++
      a       :=0
      converte:=""
      for contador=1 to len(cSenha)
          a++
          Var1     :=ASC(substr(cSenha,a,contador))+33 // CODIFICA DIGITO PARA COMPARAR
          converte :=converte + chr(var1)
      next
      cSenha:=CONVERTE
      Append Blank
      Replace usuario with cNome
      Replace senha   with cSenha
      Replace nivel   with cNivel
   enddo
   SELECT(AREA)
   set cursor off
   return.t.

function altSNH
   AREA=SELECT()
   sele 1
   tentativa:= 0
   set cursor on
   tentativa++
   a         :=0
   DECODIFICA:=""
   for contador=1 to len(Senha)
       a++
       Var1     :=ASC(substr(Senha,a,contador))-33 // DECODIFICA DIGITO PARA COMPARAR
       DECODIFICA :=DECODIFICA - chr(var1)
   next
   cSENHA=DECODIFICA
   ***************
      RELEVO(05, 05, 21, 54,.F.,,2) // tela EQUERDA
      RELEVO(06, 06, 08, 53,.T.,,2) // BARRA DE TITULO
      RELEVO(09, 18, 17, 53,.T.,,1) // tela EQUERDA
      RELEVO(18, 18, 20, 53,.T.,,2) // BARRA DE INFERIOR
      @ 07,07 SAY PADC("INCLUSÇO DE USUµRIO",45)  color "W+/R"
      @ 10,08 say PADL("Nome"    ,10)           COLOR "W/B"
      @ 12,08 say PADL("Senha"   ,10)           COLOR "W/B"
      @ 14,08 say PADL("Nivel"   ,10)           COLOR "W/B"

      @ 10, 19 get USUARIO  PICT "@!" Color "w+/Bg"
      @ 12, 19 get cSENHA   PICT "@9" color "w+/Bg"
      @ 14, 19 get NIVEL    PICT "@9" Color "w+/Bg"
      read
      if (LastKey() == 27)
         return.f.
      endif
   ***************
   a       :=0
   CODIFICA:=""
   for contador=1 to len(cSenha)
       a++
       Var1     :=ASC(substr(CSenha,a,contador))+33 // CODIFICA DIGITO PARA COMPARAR
       CODIFICA :=CODIFICA + chr(var1)
   next
   cSENHA=CODIFICA
   ***************
   Replace usuario with USUARIO
   Replace senha   with cSENHA
   Replace nivel   with NIVEL
   SELECT(AREA)
   set cursor off
   return.t.

function excSNH
SELE 1
vREG  := RECNO()
cMENSAGEM :="ELIMINAR REGISTRO:"+;
            ";"+REPL("=",50)+;
            ";Usuario :"+PADR(Usuario,40)+;
            ";Senha   :"+PADR(Senha  ,40)+;
            ";Nivel   :"+PADR(Nivel  ,40)+;
            ";"+REPL("=",50)
            IF (Alert(cMENSAGEM,{ padc("NAO",05), padc("SIM",05) } ,"W+/R") == 2)
                DELETE
            ENDIF
            GOTO vREG
            *SEEK TRIM(USUARIO)

FUNCTION locSNH
     SELE 1
     set index to idSYS1,IDSYS2
     set order to 2
     nRec  := 0
     lDone := .F.
     psq   := SPACE(30)
     do while .T.
          nCursSave:=SETCURSOR()
          SETCURSOR(1)
          @ 22,06 say PADR("LOCALIZAR:",59)         COLOR "W+/B"
          @ 22,17 get PSQ PICT "@!"                 COLOR ",W+/R"
          READ
          SETCURSOR(nCursSave)
          if lastKey()=27
             exit
          endif
          nRec := Recno()
          seek TRIM(PSQ)
          if !found()
             @ 22,06 say PADC('VERIFIQUE SUA DIGITA€ÇO',59)        COLOR "R/B"
             tone(1000, 1)
             tone(800, 2)
             tone(1200, 1)
             ALERT('&SISTEMA.;; O sistema n„o p“de localizar uma correspondˆcia para "'+alltrim(PSQ)+'"; Caso vocˆ tenha certeza sobre a existˆncia dos dados procurados, verifique a digita‡„o e tente novamente.;;;')
             goto nRec
             loop
           else
             lDone := .T. // REGISTRO LOCALIZADO
          endif                                     
          EXIT
     ENDDO
SET DELETED ON
RETURN.T.


   function CODIFICA(chave)
   a       :=0
   converte:=""
   for contador=1 to len(chave)
       a++
       Var1     :=ASC(substr(chave,a,contador))+33 // CODIFICA DIGITO PARA COMPARAR
       converte :=converte + chr(var1)
   next
   CHAVE:=CONVERTE
   if empty(chave)
      alert("AVISO;;Preenchimento ‚ obrigatorio")
      return.f.
   endif
   if dbseek(chave)=.T.
      alert("AVISO;;Registro ja existe;;TENTE OUTRO")
      return.f.
   endif
   return.t.

