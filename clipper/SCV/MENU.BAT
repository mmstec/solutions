@Echo OFF
NET LOGIN/W \\SERVIDOR LOGIN INICIO
NET USE F: \\SERVIDOR\SISTEMAS

:ENTRADA
CLS
ECHO.
ECHO. BARRETO MATERIAL DE CONSTRUCAO
ECHO. SCV - SISTEMA CONTROLADOR DE VENDAS
ECHO.
ECHO.
ECHO. DIGITE O NUMERO DA SUA OPCAO 
ECHO. =======================================================================
ECHO. [1] SCC......: Sistema Controlador de Comissoes
ECHO. [2] SVL......: Sistema de vendas da loja em dinheiro
ECHO. [3] SVC......: Sistema de vendas do cimento em dinheiro
ECHO. [4] SMC......: Sistema de entrada e saida de cimento em sacos
ECHO. [5] SAIDA      
ECHO.                                                 

CHOICE /C:12345 * OPCOES:
REM/T:4,90
ECHO.
IF ERRORLEVEL 5 GOTO FIM
IF ERRORLEVEL 4 GOTO SMC
IF ERRORLEVEL 3 GOTO SVC
IF ERRORLEVEL 2 GOTO SVL        
IF ERRORLEVEL 1 GOTO SCC
   

:SCC
F:
CD\MFB\SCV
SCC
GOTO ENTRADA

:SVL
F:
CD\MFB\SCV
SVL
GOTO ENTRADA


:SVC
F:
CD\MFB\SCV
SVC
GOTO ENTRADA

:SMC
F:
CD\MFB\SMC
SMC
GOTO ENTRADA

:FIM
C:
CD\
NET LOGOUT *
CLS
echo ESTE APARELHO JA PODE SER DESLIGADO
COMMAND /C

