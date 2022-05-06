* /////////////////////////////////////////////////////////////////////////////////////////////////////// ** /////////////////////////////////////////////////////////////////////////////////////////////////////// *
*
* -> Inicio da funcao que edita um box em forma de janela
*
FUNCTION JANELA
*
PARA L,C,T
* /////////////////////////////////////////////////////////////////////////////////////////////////////// *     
     CONTADOR  :=0
     HOJE      :=DATE()
     SEMANA    :="Domingo      Segunda-feiraTerca-feira  Quarta-feira Quinta-feira Sexta-feira  S bado       "
     DIA       :=TRIM(SUBS(SEMANA,DOW(HOJE)*13-12,13))+", "+ALLTRIM(STR(DAY(HOJE),2))
     MES       :="janeiro  fevereiromar‡o    abril    maio     junho    "
     MES       :=MES+"julho    agosto   setembro outubro  novembro dezembro "
     DIA       :=DIA+" de "+TRIM(SUBS(MES,MONTH(HOJE)*9-8,9))+" de "
     DIA       :=DIA+TRAN(YEAR(HOJE),"@E 9999")
     @ PJAN3,PJAN2+(((T)-LEN(DIA))/2) SAY DIA
* /////////////////////////////////////////////////////////////////////////////////////////////////////// *
DO CASE
     CASE VAL(LEFT(TIME(),2)) = 07
          @ L,C SAY PADC(LEFT(TIME(),5)+" Bom dia, expediente Inicializado! ",PJAN4-PJAN2)               
     CASE VAL(LEFT(TIME(),2)) = 12
          @ L,C SAY PADC(LEFT(TIME(),5)+" Boa tarde, expediente finalizado! ",PJAN4-PJAN2)               
     CASE VAL(LEFT(TIME(),2)) = 10 .OR. VAL(LEFT(TIME(),2)) = 15
          @ L,C SAY PADC(LEFT(TIME(),5)+" Hora do lanche. Expediente interrompido! ",PJAN4-PJAN2)        
     CASE VAL(LEFT(TIME(),2)) = 18
          @ L,C SAY PADC(LEFT(TIME(),5)+" Boa noite, EXPEDIENTE ENCERRADO! ",PJAN4-PJAN2)                
     CASE DATE() =  CTOD("01/01"+STR(YEAR(DATE())))
          @ L,C SAY PADC("ANO NOVO - Dia internacional da Confraterniza‡„o",80)                          
     CASE DATE() =  CTOD("11/02"+STR(YEAR(DATE())))
          @ L,C SAY PADC("Comemora‡„o do Carnaval",T)        
     CASE DATE() =  CTOD("12/02"+STR(YEAR(DATE())))
          @ L,C SAY PADC("Quarta feira de Cinzas",T)                         
     CASE DATE() =  CTOD("20/03"+STR(YEAR(DATE())))
          @ L,C SAY PADC("Inicio do Outono",T)                         
     CASE DATE() =  CTOD("28/03"+STR(YEAR(DATE())))
          @ L,C SAY PADC("Sexta feira da PAIXAO",T)        
     CASE DATE() =  CTOD("30/03"+STR(YEAR(DATE())))
          @ L,C SAY PADC("Comemora‡„o da Pascoa",T)        
     CASE DATE() =  CTOD("01/04"+STR(YEAR(DATE())))
          @ L,C SAY PADC("1§ de abril - DIA DA MENTIRA",T) 
     CASE DATE() =  CTOD("21/04"+STR(YEAR(DATE())))
          @ L,C SAY PADC("Dia de Tiradentes",T)        
     CASE DATE() =  CTOD("01/05"+STR(YEAR(DATE())))
          @ L,C SAY PADC("Dia do Trabalho",T)        
     CASE DATE() =  CTOD("29/05"+STR(YEAR(DATE())))
          @ L,C SAY PADC("CORPUS CRISTI",T)        
     CASE DATE() =  CTOD("12/06"+STR(YEAR(DATE())))
          @ L,C SAY PADC("Dia dos Namorados",T)        
     CASE DATE() =  CTOD("21/06"+STR(YEAR(DATE())))
          @ L,C SAY PADC("Inicio do Inverno",T)        
     CASE DATE() =  CTOD("10/07"+STR(YEAR(DATE())))
          @ L,C SAY PADC("MMS",T)        
     CASE DATE() =  CTOD("07/09"+STR(YEAR(DATE())))
          @ L,C SAY PADC("Comemora‡„o da Independencia do Brasil",T)        
     CASE DATE() =  CTOD("22/09"+STR(YEAR(DATE())))
          @ L,C SAY PADC("Inicio da Primavera",T)        
     CASE DATE() =  CTOD("12/10"+STR(YEAR(DATE())))
          @ L,C SAY PADC("Dia da Padroeira do Brasil - N.S. APARECIDA",T)        
     CASE DATE() =  CTOD("02/11"+STR(YEAR(DATE())))
          @ L,C SAY PADC("Dia de Finados",T)        
     CASE DATE() =  CTOD("15/11"+STR(YEAR(DATE())))
          @ L,C SAY PADC("Comemora‡„o da Proclama‡„o da Republica do Brasil",T)        
     CASE DATE() =  CTOD("19/11"+STR(YEAR(DATE())))
          @ L,C SAY PADC("Dia da Bandeira",T)        
     CASE DATE() =  CTOD("21/12"+STR(YEAR(DATE())))
          @ L,C SAY PADC("Inicio do verao",T)                  
     CASE DATE() =  CTOD("25/12"+STR(YEAR(DATE())))
          @ L,C SAY PADC("Comemora‡„o do NATAL - Nascimento de Jesus Cristo",T)           
     CASE DATE() =  CTOD("31/12"+STR(YEAR(DATE()))) .OR. DATE() =  CTOD("27/03"+STR(YEAR(DATE()))); 
     .OR. DATE() =  CTOD("29/03"+STR(YEAR(DATE()))) .OR. DATE() =  CTOD("20/04"+STR(YEAR(DATE()))); 
     .OR. DATE() =  CTOD("30/04"+STR(YEAR(DATE()))) .OR. DATE() =  CTOD("28/05"+STR(YEAR(DATE())));
     .OR. DATE() =  CTOD("06/09"+STR(YEAR(DATE()))) .OR. DATE() =  CTOD("11/10"+STR(YEAR(DATE())));
     .OR. DATE() =  CTOD("01/11"+STR(YEAR(DATE()))) .OR. DATE() =  CTOD("14/11"+STR(YEAR(DATE())));
     .OR. DATE() =  CTOD("24/12"+STR(YEAR(DATE())))
          @ L,C SAY PADC(" Amanh„, ser  feriado  ",T)    
     OTHERWISE
          @ L,C SAY PADC(AUTOR,T)           
ENDCASE
*
* - > Final da funcao janela
*
* /////////////////////////////////////////////////////////////////////////////////////////////////////// ** /////////////////////////////////////////////////////////////////////////////////////////////////////// *
