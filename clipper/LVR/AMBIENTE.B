FUNCTION AMBIENTE
*
* SET DATE FORMAT TO "dd,mm,yyyy" // prepara FORMATO DE DATAS PARA EPOCH
* SET EPOCH TO 0100               // prepara datas para o terceiro milˆnio
*
PUBLIC OPERADOR
IF .NOT.EMPTY(M->OPERADOR) .AND. LASTKEY()<>5
OPERADOR  :=M->OPERADOR
ELSE
OPERADOR  :="Operador"
ENDIF

SETCANCEL(.f.)               // desativa ALT-C/BREAK
SET TALK OFF
SET DATE BRIT
SET BELL OFF
SET STAT OFF
SET SCORE OFF
SET WRAP ON
SET CURSOR OFF
SET DELETED ON
*
* -> Ativa a PROTECAO na tecla ...................:F07
SET KEY -6 TO SEGURANCA
*
* -> Ativa a demostracao das horas na tecla ......:F08
SET KEY -7 TO RELOGIO
*
* -> Ativa a demostracao das horas na tecla ......:F09
SET KEY -8 TO BOM_DIA
*
* -> Ativa a demostracao das horas na tecla ......:F10
SET KEY -9 TO MUSICA
*
* -> Ativa a demostracao das horas na tecla ......:F11
SET KEY -40 TO MMS_EDITOR
*
* -> Ativa a APRESENTACAO DO SISTEMA na tecla ....:F12
SET KEY -41 TO DESCANSO_MMS
AUTOR     :="(C) Marcos Morais de Sousa - 1995/"+TRAN(YEAR(DATE()),"@E 9999")
MMSTEC    :="MMStec Artes Gr ficas & Inform tica Ltda"
EMPRESA   :="MFB Material de Constru‡„o Ltda"
CONTADOR  :=0
HOJE      :=DATE()
SEMANA    :="Domingo      Segunda-feiraTerca-feira  Quarta-feira Quinta-feira Sexta-feira  S bado       "
DIA       :=TRIM(SUBS(SEMANA,DOW(HOJE)*13-12,13))+", "+ALLTRIM(STR(DAY(HOJE),2))
MES       :="janeiro  fevereiromar‡o    abril    maio     junho    "
MES       :=MES+"julho    agosto   setembro outubro  novembro dezembro "
DIA       :=DIA+" de "+TRIM(SUBS(MES,MONTH(HOJE)*9-8,9))+" de "
DIA       :=DIA+TRAN(YEAR(HOJE),"@E 9999")
RETURN .F.
