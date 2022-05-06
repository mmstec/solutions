	 CLS
	 @ 00,10 SAY "Caixa Economica Federal" color "b+/n"
	 @ 01,10 SAY "ßßßßßßßßßßßßßßßßßßßßßßß" color "rg/n"
	 ti2num_i:= Space(10)
	 DO WHILE .T.
	 IF LASTKEY()=27
	    EXIT
	 ELSE
	 @ 02, 10 say "NUMERO (sem o digito verificador)" color "w+/n"
	 @ 03, 10 get TI2NUM_I picture "@R 9999999999" valid !empty(TI2NUM_I) color "w+/bg"
	 READ
	 @ 05  , 10 say '15 PROXIMOS "NOSSO NUMERO CAUCULADO"' COLOR "w+/n"
	 FOR A=0 TO 15 
	 @ 06+A, 10 SAY STR(A,2)+" "+GER_MOD11(STR(VAL(ti2num_I)+A))              color "bg+/n"
	 NEXT
	 ENDIF
	 ENDDO
	 QUIT


* =====================================
* CAUCULO DOS DIGITOS DO NOSSO NUMERO
*
* 1-Campo com 10 posicoes.
*
* 2-Utiliza 1 digito verificador calculado atraves do modulo 11, com peso de 2 a 9.
* (XXXXXXXXXX) - D1
*
* Calculo do D1
* 8 2 0 0 0 0 0 0 3 7       Número a calcular     
* 3 2 9 8 7 6 5 4 3 2       Indice de Multiplicacao
* Divisão    51/11 = 4      Resto = 7
* Subtração  11-7  = 4
* Digito           = 4
* Numero com o digito calculado
* 8 2 0 0 0 0 0 0 3 7 4     Numero com o dígito calculado 
*
* Se o resultado da subtração for maior que (9) nove o DV será 0   (zero), caso contrário o resultado será o DV.

function GER_MOD11
   parameters dig
   a01:= Val(SubStr(dig, 01, 1))
   a02:= Val(SubStr(dig, 02, 1))
   a03:= Val(SubStr(dig, 03, 1))
   a04:= Val(SubStr(dig, 04, 1))
   a05:= Val(SubStr(dig, 05, 1))
   a06:= Val(SubStr(dig, 06, 1))
   a07:= Val(SubStr(dig, 07, 1))
   a08:= Val(SubStr(dig, 08, 1))
   a09:= Val(SubStr(dig, 09, 1))
   a10:= Val(SubStr(dig, 10, 1))
   a11:= Val(SubStr(dig, 11, 1))
   s01:= a01 * 3 + a02 * 2 + a03 * 9 + a04 * 8 + a05 * 7 + a06 * 6 + ;
	 a07 * 5 + a08 * 4 + a09 * 3 + a10 * 2
   if (s01 > 10)
      s02:= mod(s01, 11)
      c01:= 11 - s02
   else
      c01:= 11 - s01
   endif
   if (c01 > 9)
      c01:= 0
   endif
   c01:= Int(c01)
   CAUC= DIG+"-"+STR(c01,1)
   RETURN CAUC




