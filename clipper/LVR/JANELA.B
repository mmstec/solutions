* /////////////////////////////////////////////////////////////////////////////////////////////////////// ** /////////////////////////////////////////////////////////////////////////////////////////////////////// *
*
* -> Inicio da funcao que edita um box em forma de janela
*
FUNCTION JANELA
*
PARA PJAN1,PJAN2,PJAN3,PJAN4,PJAN5
IF PCOUNT()<>5
    PJAN5=""
ENDIF
SOMBRA(PJAN1,PJAN2,PJAN3+1,PJAN4)
SETCOLOR(CONTECOR[4])
@ PJAN1,PJAN2 CLEAR TO PJAN3+1,PJAN4
* /////////////////////////////////////////////////////////////////////////////////////////////////////// *
     AUTOR     :="(C) Marcos Morais de Sousa - 1995/"+TRAN(YEAR(DATE()),"@E 9999")
     MMSTEC    :="MMStec Artes Gr ficas & Inform tica Ltda"
     EMPRESA   :="MFB Material de Constru‡„O Ltda"
     CONTADOR  :=0
     HOJE      :=DATE()
     SEMANA    :="Domingo      Segunda-feiraTerca-feira  Quarta-feira Quinta-feira Sexta-feira  S bado       "
     DIA       :=TRIM(SUBS(SEMANA,DOW(HOJE)*13-12,13))+", "+ALLTRIM(STR(DAY(HOJE),2))
     MES       :="janeiro  fevereiromar‡o    abril    maio     junho    "
     MES       :=MES+"julho    agosto   setembro outubro  novembro dezembro "
     DIA       :=DIA+" de "+TRIM(SUBS(MES,MONTH(HOJE)*9-8,9))+" de "
     DIA       :=DIA+TRAN(YEAR(HOJE),"@E 9999")
     @ PJAN3,PJAN2+(((PJAN4+1-PJAN2)-LEN(DIA))/2) SAY DIA
* /////////////////////////////////////////////////////////////////////////////////////////////////////// *
DO CASE
     CASE VAL(LEFT(TIME(),2)) = 07
          @ PJAN3+1,PJAN2 SAY PADC(LEFT(TIME(),5)+"  Bom dia! Expediente Inicializado! ",PJAN4-PJAN2)               COLOR("R*/"+ALLTRIM(SUBS(CONTECOR[4],4)))
     CASE VAL(LEFT(TIME(),2)) = 12
          @ PJAN3+1,PJAN2 SAY PADC(LEFT(TIME(),5)+"  Boa tarde! Expediente finalizado! ",PJAN4-PJAN2)               COLOR("R*/"+ALLTRIM(SUBS(CONTECOR[4],4)))
     CASE VAL(LEFT(TIME(),2)) = 10 .OR. VAL(LEFT(TIME(),2)) = 15
          @ PJAN3+1,PJAN2 SAY PADC(LEFT(TIME(),5)+"  Hora do lanche! Expediente interrompido! ",PJAN4-PJAN2)        COLOR("R*/"+ALLTRIM(SUBS(CONTECOR[4],4)))
     CASE VAL(LEFT(TIME(),2)) = 18
          @ PJAN3+1,PJAN2 SAY PADC(LEFT(TIME(),5)+"  BOA NOITE! EXPEDIENTE ENCERRADO! ",PJAN4-PJAN2)                COLOR("R*/"+ALLTRIM(SUBS(CONTECOR[4],4)))
     CASE DATE() =  CTOD("01/01"+STR(YEAR(DATE())))
          @ PJAN3+1,PJAN2 SAY PADC("ANO NOVO - Dia internacional da Confraterniza‡„o",80)                          
     CASE DATE() =  CTOD("11/02"+STR(YEAR(DATE())))
          @ PJAN3+1,PJAN2 SAY PADC("Comemora‡„o do Carnaval",PJAN4+1-PJAN2)        
     CASE DATE() =  CTOD("12/02"+STR(YEAR(DATE())))
          @ PJAN3+1,PJAN2 SAY PADC("Quarta feira de Cinzas",PJAN4+1-PJAN2)                         
     CASE DATE() =  CTOD("20/03"+STR(YEAR(DATE())))
          @ PJAN3+1,PJAN2 SAY PADC("Inicio do Outono",PJAN4+1-PJAN2)                         
     CASE DATE() =  CTOD("28/03"+STR(YEAR(DATE())))
          @ PJAN3+1,PJAN2 SAY PADC("Sexta feira da PAIXAO",PJAN4+1-PJAN2)        
     CASE DATE() =  CTOD("30/03"+STR(YEAR(DATE())))
          @ PJAN3+1,PJAN2 SAY PADC("Comemora‡„o da Pascoa",PJAN4+1-PJAN2)        
     CASE DATE() =  CTOD("01/04"+STR(YEAR(DATE())))
          @ PJAN3+1,PJAN2 SAY PADC("1§ de abril - DIA DA MENTIRA",PJAN4+1-PJAN2) 
     CASE DATE() =  CTOD("02/04"+STR(YEAR(DATE())))
          @ PJAN3+1,PJAN2 SAY PADC("Dia Internacional do livro infantil",PJAN4+1-PJAN2)        
     CASE DATE() =  CTOD("07/04"+STR(YEAR(DATE())))
          @ PJAN3+1,PJAN2 SAY PADC("Dia do m‚dico legista",PJAN4+1-PJAN2)        
     CASE DATE() =  CTOD("08/04"+STR(YEAR(DATE())))
          @ PJAN3+1,PJAN2 SAY PADC("Dia do desbravador",PJAN4+1-PJAN2)        
     CASE DATE() =  CTOD("21/04"+STR(YEAR(DATE())))
          @ PJAN3+1,PJAN2 SAY PADC("Dia de Tiradentes",PJAN4+1-PJAN2)        
     CASE DATE() =  CTOD("01/05"+STR(YEAR(DATE())))
          @ PJAN3+1,PJAN2 SAY PADC("Dia do Trabalho",PJAN4+1-PJAN2)        
     CASE DATE() =  CTOD("29/05"+STR(YEAR(DATE())))
          @ PJAN3+1,PJAN2 SAY PADC("CORPUS CRISTI",PJAN4+1-PJAN2)        
     CASE DATE() =  CTOD("12/06"+STR(YEAR(DATE())))
          @ PJAN3+1,PJAN2 SAY PADC("Dia dos Namorados",PJAN4+1-PJAN2)        
     CASE DATE() =  CTOD("21/06"+STR(YEAR(DATE())))
          @ PJAN3+1,PJAN2 SAY PADC("Inicio do Inverno",PJAN4+1-PJAN2)        
     CASE DATE() =  CTOD("10/07"+STR(YEAR(DATE())))
          @ PJAN3+1,PJAN2 SAY PADC("Anivers rio de Marcos",PJAN4+1-PJAN2)        
     CASE DATE() =  CTOD("07/09"+STR(YEAR(DATE())))
          @ PJAN3+1,PJAN2 SAY PADC("Comemora‡„o da Independencia do Brasil",PJAN4+1-PJAN2)        
     CASE DATE() =  CTOD("22/09"+STR(YEAR(DATE())))
          @ PJAN3+1,PJAN2 SAY PADC("Inicio da Primavera",PJAN4+1-PJAN2)        
     CASE DATE() =  CTOD("12/10"+STR(YEAR(DATE())))
          @ PJAN3+1,PJAN2 SAY PADC("Dia da Padroeira do Brasil - N.S. APARECIDA",PJAN4+1-PJAN2)        
     CASE DATE() =  CTOD("02/11"+STR(YEAR(DATE())))
          @ PJAN3+1,PJAN2 SAY PADC("Dia de Finados",PJAN4+1-PJAN2)        
     CASE DATE() =  CTOD("15/11"+STR(YEAR(DATE())))
          @ PJAN3+1,PJAN2 SAY PADC("Comemora‡„o da Proclama‡„o da Republica do Brasil",PJAN4+1-PJAN2)        
     CASE DATE() =  CTOD("19/11"+STR(YEAR(DATE())))
          @ PJAN3+1,PJAN2 SAY PADC("Dia da Bandeira",PJAN4+1-PJAN2)        
     CASE DATE() =  CTOD("21/12"+STR(YEAR(DATE())))
          @ PJAN3+1,PJAN2 SAY PADC("Inicio do verao",PJAN4+1-PJAN2)                  
     CASE DATE() =  CTOD("25/12"+STR(YEAR(DATE())))
          @ PJAN3+1,PJAN2 SAY PADC("Comemora‡„o do NATAL - Nascimento de Jesus Cristo",PJAN4+1-PJAN2)           
     CASE DATE() =  CTOD("31/12"+STR(YEAR(DATE()))) .OR. DATE() =  CTOD("27/03"+STR(YEAR(DATE()))); 
     .OR. DATE() =  CTOD("29/03"+STR(YEAR(DATE()))) .OR. DATE() =  CTOD("20/04"+STR(YEAR(DATE()))); 
     .OR. DATE() =  CTOD("30/04"+STR(YEAR(DATE()))) .OR. DATE() =  CTOD("28/05"+STR(YEAR(DATE())));
     .OR. DATE() =  CTOD("06/09"+STR(YEAR(DATE()))) .OR. DATE() =  CTOD("11/10"+STR(YEAR(DATE())));
     .OR. DATE() =  CTOD("01/11"+STR(YEAR(DATE()))) .OR. DATE() =  CTOD("14/11"+STR(YEAR(DATE())));
     .OR. DATE() =  CTOD("24/12"+STR(YEAR(DATE())))
          @ PJAN3+1,PJAN2 SAY PADC(" Amanh„, ser  feriado  ",PJAN4+1-PJAN2)   COLOR("R*/"+ALLTRIM(SUBS(CONTECOR[4],4))) 
     OTHERWISE
          @ PJAN3+1,PJAN2 SAY PADC(AUTOR,PJAN4+1-PJAN2)           
ENDCASE
SETCOLOR(CONTECOR[5])
@ PJAN1,PJAN2 CLEAR TO PJAN1,PJAN4
IF LEN(TRIM(PJAN5)) > 0
    @ PJAN1,PJAN2+(((PJAN4+1-PJAN2)-LEN(PJAN5))/2) SAY PJAN5
ENDIF
*
* - > Final da funcao janela
*
* /////////////////////////////////////////////////////////////////////////////////////////////////////// ** /////////////////////////////////////////////////////////////////////////////////////////////////////// *
