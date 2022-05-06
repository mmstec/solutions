* Empresa     :MMStec INFORMATICA LTDA  *
* Data        :19/09/96 JEQUIE - BAHIA  *
* Responsavel :MARCOS MORAIS DE SOUSA   *

Function TELA_1
* SETCOLOR ("N/b")
@ 00,00 CLEAR TO 22,80 
@ 11,10 SAY "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ-" COLOR "R/n"
@ 12,10 SAY "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ-" COLOR "R/n"
@ 13,10 SAY "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ" COLOR "r/n"
@ 14,10 SAY "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ-" COLOR "r/n"
@ 15,10 SAY "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ-" COLOR "r/n"
@ 16,10 SAY "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ-" COLOR "R/n"
@ 17,10 SAY "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ-" COLOR "R/n"
@ 18,10 SAY "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ-" COLOR "R/n"

@ 13,15 SAY " ÛÜ   ÜÛ " COLOR "B+/n"
@ 14,15 SAY " Û ßÜß Û " COLOR "B+/n"
@ 15,15 SAY " Û     Û " COLOR "BG/n"
@ 16,15 SAY " ß     ß " COLOR "BG+/n"
TONE(800.8)
@ 13,15 Say " ÛÜ   ÜÛ ÛÜ   ÜÛ" COLOR "B+/n"
@ 14,15 SAY " Û ßÜß Û Û ßÜß Û" COLOR "B+/n"
@ 15,15 SAY " Û     Û Û     Û" COLOR "BG/n"
@ 16,15 SAY " ß     ß ß     ß" COLOR "Bg+/n"
TONE(800.8)
@ 13,15 Say " ÛÜ   ÜÛ ÛÜ   ÜÛ ÛßßßßßÛ" COLOR "B/n"
@ 14,15 SAY " Û ßÜß Û Û ßÜß Û ÛÜÜÜÜÜÜ" COLOR "B+/n"
@ 15,15 SAY " Û     Û Û     Û Ü     Û" COLOR "BG/n"
@ 16,15 SAY " ß     ß ß     ß ßßßßßßß" COLOR "Bg+/n"
TONE(800.8)
@ 13,15 Say " ÛÜ   ÜÛ ÛÜ   ÜÛ ÛßßßßßÛ  Ü " COLOR "B/n"
@ 14,15 SAY " Û ßÜß Û Û ßÜß Û ÛÜÜÜÜÜÜ ßÛß" COLOR "B+/n"
@ 15,15 SAY " Û     Û Û     Û Ü     Û  Û " COLOR "BG/n"
@ 16,15 SAY " ß     ß ß     ß ßßßßßßß  ßß" COLOR "BG+/n"
TONE(800.8)
@ 13,15 Say " ÛÜ   ÜÛ ÛÜ   ÜÛ ÛßßßßßÛ  Ü  INFORMA" COLOR "B/n"
@ 14,15 SAY " Û ßÜß Û Û ßÜß Û ÛÜÜÜÜÜÜ ßÛß ÛßßßßßÛ" COLOR "B+/n"
@ 15,15 SAY " Û     Û Û     Û Ü     Û  Û  Ûßßßßßß" COLOR "BG/n"
@ 16,15 SAY " ß     ß ß     ß ßßßßßßß  ßß ßßßßßßß" COLOR "BG+/n"
TONE(800.8)
@ 13,15 Say " ÛÜ   ÜÛ ÛÜ   ÜÛ ÛßßßßßÛ  Ü  INFORMATICA LTDA (R)" COLOR "B/n"
@ 14,15 SAY " Û ßÜß Û Û ßÜß Û ÛÜÜÜÜÜÜ ßÛß ÛßßßßßÛ ÛßßßßßßÛ " COLOR "B+/n"
@ 15,15 SAY " Û     Û Û     Û Ü     Û  Û  Ûßßßßßß Û      Ü " COLOR "BG/n"
@ 16,15 SAY " Û     Û Û     Û ßßßßßßß  ßß ßßßßßßß ßßßßßßßß " COLOR "BG+/n"
@ 17,15 SAY " ß     ßßß     ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß " COLOR "W/n"

SETCOLOR ("RG+*/R")
@ 18,25 CLEAR TO 21,51    
@ 19,26 SAY "Sistema de Contas a Pagar" COLOR ("RG+*/R")
@ 20,26 SAY " Duplicatas / Cheques" COLOR ("RG+*/R")
TONE(800.8)

SETCOLOR ("N/W")
      @ 04,08 TO 09,70 DOUBLE 
SETCOLOR ("RG+*/R")
     @ 05,09 CLEAR TO 08,69    
     @ 06,20 SAY "   M.M.S.tec Multiusuario Vers„o 1.0" 
     @ 07,20 SAY "(C) Copyright by Marcos Morais de Sousa"
     @ 23,00 SAY TIME() COLOR ("W/n")

SETCOLOR ("RG+*/R")
@ 18,25 CLEAR TO 21,51    
@ 19,26 SAY "Sistema de Contas a Pagar" COLOR ("RG+*/R")
@ 20,26 SAY " Duplicatas / Cheques" COLOR ("RG+*/R")
TONE(800.8)

SETCOLOR ("N/W")
      @ 04,08 TO 09,70 DOUBLE 
SETCOLOR ("RG+*/R")
     @ 05,09 CLEAR TO 08,69    
     @ 06,20 SAY "   M.M.S.tec Multiusuario Vers„o 1.0" 
     @ 07,20 SAY "(C) Copyright by Marcos Morais de Sousa"
     @ 23,00 SAY TIME() COLOR ("W/n")

RETURN.F.
******************************************************************************
******************************************************************************

Function TELA_2

SETCOLOR ("N/n")
@ 00,00 CLEAR TO 22,80 

@ 11,10 SAY "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ-" COLOR "R/n"
@ 12,10 SAY "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ-" COLOR "R/n"
@ 13,10 SAY "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ" COLOR "r/n"
@ 14,10 SAY "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ-" COLOR "r/n"
@ 15,10 SAY "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ-" COLOR "r/n"
@ 16,10 SAY "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ-" COLOR "R/n"
@ 17,10 SAY "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ-" COLOR "R/n"
@ 18,10 SAY "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ-" COLOR "R/n"
***************


@ 13,15 SAY " ÛÜ   ÜÛ " COLOR "B+/n"
@ 14,15 SAY " Û ßÜß Û " COLOR "B+/n"
@ 15,15 SAY " Û     Û " COLOR "BG/n"
@ 16,15 SAY " ß     ß " COLOR "BG+/n"
TONE(800.8)
@ 13,15 Say " ÛÜ   ÜÛ ÛÜ   ÜÛ" COLOR "B+/n"
@ 14,15 SAY " Û ßÜß Û Û ßÜß Û" COLOR "B+/n"
@ 15,15 SAY " Û     Û Û     Û" COLOR "BG/n"
@ 16,15 SAY " ß     ß ß     ß" COLOR "Bg+/n"
TONE(800.8)
@ 13,15 Say " ÛÜ   ÜÛ ÛÜ   ÜÛ ÛßßßßßÛ" COLOR "B/n"
@ 14,15 SAY " Û ßÜß Û Û ßÜß Û ÛÜÜÜÜÜÜ" COLOR "B+/n"
@ 15,15 SAY " Û     Û Û     Û Ü     Û" COLOR "BG/n"
@ 16,15 SAY " ß     ß ß     ß ßßßßßßß" COLOR "Bg+/n"
TONE(800.8)
@ 13,15 Say " ÛÜ   ÜÛ ÛÜ   ÜÛ ÛßßßßßÛ  Ü " COLOR "B/n"
@ 14,15 SAY " Û ßÜß Û Û ßÜß Û ÛÜÜÜÜÜÜ ßÛß" COLOR "B+/n"
@ 15,15 SAY " Û     Û Û     Û Ü     Û  Û " COLOR "BG/n"
@ 16,15 SAY " ß     ß ß     ß ßßßßßßß  ßß" COLOR "BG+/n"
TONE(800.8)
@ 13,15 Say " ÛÜ   ÜÛ ÛÜ   ÜÛ ÛßßßßßÛ  Ü  INFORMA" COLOR "B/n"
@ 14,15 SAY " Û ßÜß Û Û ßÜß Û ÛÜÜÜÜÜÜ ßÛß ÛßßßßßÛ" COLOR "B+/n"
@ 15,15 SAY " Û     Û Û     Û Ü     Û  Û  Ûßßßßßß" COLOR "BG/n"
@ 16,15 SAY " ß     ß ß     ß ßßßßßßß  ßß ßßßßßßß" COLOR "BG+/n"
TONE(800.8)
@ 13,15 Say " ÛÜ   ÜÛ ÛÜ   ÜÛ ÛßßßßßÛ  Ü  INFORMATICA LTDA (R)" COLOR "B/n"
@ 14,15 SAY " Û ßÜß Û Û ßÜß Û ÛÜÜÜÜÜÜ ßÛß ÛßßßßßÛ ÛßßßßßßÛ " COLOR "B+/n"
@ 15,15 SAY " Û     Û Û     Û Ü     Û  Û  Ûßßßßßß Û      Ü " COLOR "BG/n"
@ 16,15 SAY " Û     Û Û     Û ßßßßßßß  ßß ßßßßßßß ßßßßßßßß " COLOR "BG+/n"
@ 17,15 SAY " ß     ßßß     ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß " COLOR "W/n"
SETCOLOR ("RG+*/R")
@ 18,25 CLEAR TO 21,51    
@ 19,30 SAY "SENHA E/OU USUARIO" COLOR "RG+*/R"
@ 20,30 SAY "     INVALIDO(s)  " COLOR "RG+*/R"
TONE(800.8)

SETCOLOR ("N/W")
      @ 04,08 TO 09,70 DOUBLE 
SETCOLOR ("RG+*/R")
     @ 05,09 CLEAR TO 08,69    
     @ 06,20 SAY "   M.M.S.tec Multiusuario Vers„o 1.0" 
     @ 07,20 SAY "(C) Copyright by Marcos Morais de Sousa"
     @ 23,00 SAY TIME() COLOR ("W/n")

******************************************************************************
******************************************************************************

Function TELA_3
* SETCOLOR ("N/b")
@ 00,00 CLEAR TO 22,80 
@ 11,10 SAY "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ-" COLOR "R/n"
@ 12,10 SAY "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ-" COLOR "R/n"
@ 13,10 SAY "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ" COLOR "r/n"
@ 14,10 SAY "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ-" COLOR "r/n"
@ 15,10 SAY "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ-" COLOR "r/n"
@ 16,10 SAY "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ-" COLOR "R/n"
@ 17,10 SAY "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ-" COLOR "R/n"
@ 18,10 SAY "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ-" COLOR "R/n"
***************


@ 13,15 SAY " ÛÜ   ÜÛ " COLOR "B+/n"
@ 14,15 SAY " Û ßÜß Û " COLOR "B+/n"
@ 15,15 SAY " Û     Û " COLOR "BG/n"
@ 16,15 SAY " ß     ß " COLOR "BG+/n"
TONE(800.8)
@ 13,15 Say " ÛÜ   ÜÛ ÛÜ   ÜÛ" COLOR "B+/n"
@ 14,15 SAY " Û ßÜß Û Û ßÜß Û" COLOR "B+/n"
@ 15,15 SAY " Û     Û Û     Û" COLOR "BG/n"
@ 16,15 SAY " ß     ß ß     ß" COLOR "Bg+/n"
TONE(800.8)
@ 13,15 Say " ÛÜ   ÜÛ ÛÜ   ÜÛ ÛßßßßßÛ" COLOR "B/n"
@ 14,15 SAY " Û ßÜß Û Û ßÜß Û ÛÜÜÜÜÜÜ" COLOR "B+/n"
@ 15,15 SAY " Û     Û Û     Û Ü     Û" COLOR "BG/n"
@ 16,15 SAY " ß     ß ß     ß ßßßßßßß" COLOR "Bg+/n"
TONE(800.8)
@ 13,15 Say " ÛÜ   ÜÛ ÛÜ   ÜÛ ÛßßßßßÛ  Ü " COLOR "B/n"
@ 14,15 SAY " Û ßÜß Û Û ßÜß Û ÛÜÜÜÜÜÜ ßÛß" COLOR "B+/n"
@ 15,15 SAY " Û     Û Û     Û Ü     Û  Û " COLOR "BG/n"
@ 16,15 SAY " ß     ß ß     ß ßßßßßßß  ßß" COLOR "BG+/n"
TONE(800.8)
@ 13,15 Say " ÛÜ   ÜÛ ÛÜ   ÜÛ ÛßßßßßÛ  Ü  INFORMA" COLOR "B/n"
@ 14,15 SAY " Û ßÜß Û Û ßÜß Û ÛÜÜÜÜÜÜ ßÛß ÛßßßßßÛ" COLOR "B+/n"
@ 15,15 SAY " Û     Û Û     Û Ü     Û  Û  Ûßßßßßß" COLOR "BG/n"
@ 16,15 SAY " ß     ß ß     ß ßßßßßßß  ßß ßßßßßßß" COLOR "BG+/n"
TONE(800.8)
@ 13,15 Say " ÛÜ   ÜÛ ÛÜ   ÜÛ ÛßßßßßÛ  Ü  INFORMATICA LTDA (R)" COLOR "B/n"
@ 14,15 SAY " Û ßÜß Û Û ßÜß Û ÛÜÜÜÜÜÜ ßÛß ÛßßßßßÛ ÛßßßßßßÛ " COLOR "B+/n"
@ 15,15 SAY " Û     Û Û     Û Ü     Û  Û  Ûßßßßßß Û      Ü " COLOR "BG/n"
@ 16,15 SAY " Û     Û Û     Û ßßßßßßß  ßß ßßßßßßß ßßßßßßßß " COLOR "BG+/n"
@ 17,15 SAY " ß     ßßß     ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß " COLOR "W/n"

SETCOLOR ("RG+*/R")
@ 18,25 CLEAR TO 21,51    
@ 19,26 SAY "Sistema de Contas a Pagar" COLOR ("RG+*/R")
@ 20,26 SAY " Duplicatas / Cheques" COLOR ("RG+*/R")
TONE(800.8)

SETCOLOR ("N/W")
      @ 04,08 TO 09,70 DOUBLE 
SETCOLOR ("RG+*/R")
     @ 05,09 CLEAR TO 08,69    
     @ 06,20 SAY "   M.M.S.tec Multiusuario Vers„o 1.0" 
     @ 07,20 SAY "(C) Copyright by Marcos Morais de Sousa"
     @ 23,00 SAY TIME() COLOR ("W/n")

