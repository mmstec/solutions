@ECHO off 
MMS.exe
echo.
echo.
CHOICE /c:1234 .                  " Escolha uma das opcoes:" /T:4,15   
ECHO.
IF ERRORLEVEL 4 GOTO fim            
IF ERRORLEVEL 3 GOTO salva        
IF ERRORLEVEL 2 GOTO fiscal        
IF ERRORLEVEL 1 GOTO contas           

:Contas
cd\MMS\MMStec
MMSTEC \screen_saver
echo.
echo Apagando arquivos NTX...
DEL *.NTX
cls
goto fim                                                                                      
                                                                                         

:fiscal
cd\MMS\FISCAL
fiscal
echo.
echo Apagando arquivos NTX...
DEL *.ntx
cls
goto fim                                                                                      


:salva
compact
echo.
cd\DOS\SEGURA.ARJ
compact
ECHO.
ECHO Localizando arquivos MMS001...
attrib mms001 -r -H -S
CLS
ECHO.
ECHO Localizando arquivos MMS001...
compact
ECHO.
ECHO Apagando arquivos MMS001...
DEL MMS001
CD\MMS\MMSTEC
compact
echo.
echo Apagando arquivos NTX...
DEL *.NTX
compact
ECHO.
ECHO  Compactando \MMS\MMSTEC\*.* para \DOS\SEGURA.ARJ. Aguarde....   
ECHO.
arj a Cimento.arj *.*
compact
ECHO.
ECHO Movendo arquivo Cimento.arj...para c:\dos\segura.arj
MOVE CIMENTO.ARJ C:\DOS\SEGURA.ARJ
ECHO.
ECHO Movendo arquivos PRN...para c:\dos\segura.arj
move *.prn c:\dos\segura.arj
CD\DOS\SEGURA.ARJ
ECHO.
ECHO Renomeando arquivo Cimento.arj...MMS001
ren cimento.arj MMS001
ECHO.
ECHO Protegendo arquivo MMS001...
ATTRIB MMS001 +R 
CD\
ECHO.
ECHO                     Compactacao completada com suscesso!   
NET PAUSE . 3 
goto FIM


:fim
ECHO.
ECHO.
ECHO.
ECHO     (c) Copyright - 1996. (r) MMStec - All Rights Reserved.
ECHO     Av St¶ Luzia 698-A J. Romao CEP 45.200-0000 Jequie - Ba
ECHO     Fone:(073)525-5932 - Marcos Morais de Sousa.
ECHO. 
ECHO     €€€€     €€€€   €€€€     €€€€   €€€€€€€€€€€          
ECHO   ∞∞€€€€€  ∞€€€€€ ∞∞€€€€€  ∞€€€€€ ∞∞€€€€€€€€€€€     
ECHO   ∞∞€€€€€€∞€€€€€€ ∞∞€€€€€€∞€€€€€€ ∞∞€€€€∞∞∞€€€€   
ECHO   ∞∞€€€€€€€€€€€€€ ∞∞€€€€€€€€€€€€€ ∞∞€€€€ ∞∞∞∞     ‹‹                           
ECHO   ∞∞€€€€€€€€€€€€€ ∞∞€€€€€€€€€€€€€ ∞∞€€€€€€€€€€€ €€€€€€                         
ECHO   ∞∞€€€€∞€€€∞€€€€ ∞∞€€€€∞€€€∞€€€€ ∞∞€€€€€€€€€€€∞∞∞€€∞  €€€€€€€€  €€€€€€€€€ 
ECHO   ∞∞€€€€∞∞€∞∞€€€€ ∞∞€€€€∞∞€∞∞€€€€ ∞∞∞∞∞∞∞∞∞€€€€ ∞∞€€ ∞∞€€∞∞∞∞€€∞∞€€∞∞∞∞∞€€
ECHO   ∞∞€€€€∞  ∞∞€€€€ ∞∞€€€€∞  ∞∞€€€€   €€€€ ∞∞€€€€ ∞∞€€ ∞∞€€€€€€€€∞∞€€   ∞∞ 
ECHO   ∞∞€€€€   ∞∞€€€€ ∞∞€€€€   ∞∞€€€€   €€€€€€€€€€€ ∞∞€€ ∞∞€€∞∞∞∞‹‹∞∞€€     €€
ECHO   ∞∞€€€€   ∞∞€€€€ ∞∞€€€€   ∞∞€€€€ ∞∞€€€€€€€€€€€ ∞∞€€€€∞€€€€€€€€∞∞€€€€€€€€€    
ECHO   ∞∞∞∞     ∞∞∞∞   ∞∞∞∞     ∞∞∞∞   ∞∞∞∞∞∞∞∞∞∞    ∞∞∞∞ ∞∞∞∞∞∞∞∞  ∞∞∞∞∞∞∞∞∞   
ECHO.
ECHO     €ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€
ECHO   ∞∞€   I    N    F    O     R     M      A     T     I     C     A      €
ECHO   ∞∞€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹€
ECHO   ∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞                                                                                
ECHO.          
mfb
echo.
cd\


