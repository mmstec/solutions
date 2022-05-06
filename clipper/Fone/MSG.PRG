   #include "common.ch"
   #include "inkey.ch"
   AUTOR   :="(C) Marcos Morais de Sousa - 1995/"+TRAN(YEAR(DATE()),"@E 9999")
   ANO2000 := CTOD("01/01/2000")-DATE()
   MSG2000 := '"FALTAM '+ALLTRIM(STR(ANO2000))+' DIAS PARA O ANO 2000"'
   DISP    := 0
   clear screen
   setmode(43,80) 
   @ 03,00 say ""
   text
   


          

   07:30 Ligar e fazer manutencao do Servidor Principal - SERVIDOR
         Ligar e fazer manutencao do Servidor Auxiliar  - SUPERVISOR
         Enviar arquivo REMESSA contendo as duplicatas emitidas
         Receber arquivo RETORNO contendo as duplicatas pagas

   08:00 Liberar terminais
         Atualizar arquivo RETORNO 
         Baixar duplicatas pagas em banco

   10:00 Liberar baixa do caderno

   11:55 Desligar todos os terminais
         Desligar Servidor Auxiliar  - SUPERVISOR
         Desligar Servidor Principal - SERVIDOR
   
   13:30 Ligar Servidor Principal - SERVIDOR
         Ligar Servidor Auxiliar  - SUPERVISOR
         Liberar terminais
   
   17:30 Desligar Servidor Auxiliar - SUPERVISOR

   17:45 Gerar arquivo REMESSA contendo as duplicatas emitidas
         Fechar caixa.

         Aten‡ao: As entradas posteriores ao fechamento de caixa devem,
                  ser lan‡adas na data seguinte

   18:00 Desligar todos os terminais
         Desligar Servidor Principal - SERVIDOR
   endtext

do while (.T.)
   if (LastKey() == K_ESC)
      clear
      setmode(25,80)
      exit
   endif
   do case
      case time()>= "00:00:00" .and. time() < "12:00:00"
      MSG=" - Bom Dia"
      case time()>= "12:00:00" .and. time() < "18:00:00"
      MSG=" - Boa Tarde"
      case time()>= "18:00:00" .and. time() < "24:00:00"
      MSG=" - Boa Noite"
   otherwise
      MSG="Opcao nao prevista. Procure Marcos"
   endcase
   if time()>= "11:55:00" .and. time() < "13:30:00" .or. ;
      time()>= "17:55:00" .and. time() < "18:00:00"
      tone(750.9)
      @ 06,20 say PADR('"DESLIGUE ESTE APARELHO - '+TIME()+'"',60) color "RG+*/N"
   else
      @ 06,20 say padR("",60)
   endif
   *****************
   @ 01,01 SAY "MMStec - BARRETO MATERIAL DE CONSTRUCAO" color "bg+/n"
   @ 02,01 SAY repl("Ä",78)                          color "bg+/n"
   @ 40,01 SAY repl("Ä",78)                          color "bg+/n"
   DATA("C",42,02,78,"BG+/N")
   @ 04,03 say time() color ("w+")
   IF DATE()<=CTOD("01/01/2000")
      @ 04,20 SAY MSG2000      COLOR "W*+"
   ENDIF
   inkey(0.05)
   *****************
DO CASE
   CASE TIME()>= "07:30:00" .AND. VAL(TIME()) < VAL("08:00:00")
        @ 12,01 SAY "" COLOR "W+*/N"
   CASE TIME()>= "08:00:00" .AND. TIME() < "10:00:00"
        @ 17,01 SAY "" COLOR "W+*/N"
   CASE TIME()>= "10:00:00" .AND. TIME() < "11:55:00"
        @ 21,01 SAY "" COLOR "W+*/N"
   CASE TIME()>= "11:55:00" .AND. TIME() < "13:30:00"
        @ 23,01 SAY "" COLOR "W+*/N"
   CASE TIME()>= "13:30:00" .AND. TIME() < "17:30:00"
        @ 27,01 SAY "" COLOR "W+*/N"
   CASE TIME()>= "17:30:00" .AND. TIME() < "17:45:00"
        @ 31,01 SAY "" COLOR "W+*/N"
   CASE TIME()>= "17:45:00" .AND. TIME() < "18:00:00"
        @ 33,01 SAY "" COLOR "W+*/N"
   CASE TIME()>= "18:00:00" .AND. TIME() < "23:59:00"
        @ 39,01 SAY "" COLOR "W+*/N"
ENDCASE
enddo
@ 04,02 say padc(autor,78) color "w+/n"
   
   


