#include "dbedit.ch"
#include "inkey.ch"
STATIC acColumns :={}
SETCANCEL(.F.)               // (.F.) desativa ALT-C/BREAK
SET EPOCH TO 1960            // prepara datas para o terceiro milˆnio
SET DATE FORMAT TO "dd,mm,yyyy"
SET DATE BRIT
SET TALK OFF
SET BELL OFF
SET STAT OFF
SET SCORE OFF
SET WRAP ON
SET CURSOR OFF
SET DELETED ON



*PROCEDURE Main()
  USE DBVENDA
  INDEX on DTOS(DATA)+LKCONTA+LKCAIXA to DBVENDA1.NTX 
  CLS
  acColumns :={ "data", "lkconta", "lkcaixa", "valor", "comissao" }
  DBEDIT( 5, 5, 20, 40, acColumns, "UserFunc" )
*RETURN

FUNCTION UserFunc( nMode, nCol )
LOCAL nKey    := LASTKEY()
LOCAL nRetVaL := DE_CONT

DO CASE
CASE nMode == DE_IDLE
     nRetVal = IdleFunc()
CASE nMode == DE_HITTOP
     TONE( 100, 3)
CASE nMode == DE_HITBOTTOM
     TONE( 100, 3)
     nRetVal = AppendFunc( nKey )
CASE nMode == DE_EMPTY
     nRetVal = EmptyFunc( nKey )
CASE nMode == DE_EXCEPT
     nRetVal = ExceptFunc( nKey, nCol )
OTHERWISE
     TONE( 100, 3)
ENDCASE
RETURN nRetVal

FUNCTION AppendFunc( nKey )
         LOCAL nRetVal:=DE_CONT
         IF nKey == K_DOWN
            APPEND BLANK
            nRetVal:= DE_REFRESH
         ENDIF
RETURN nRetVal

FUNCTION ExceptFunc( nKey, nCol )
         LOCAL nRetVal:=DE_CONT
         DO CASE
         CASE nKey == K_ESC
              nRetVal:=DE_ABORT
         CASE nKey == K_RETURN
              nRetVal:=EditFunc( nCol )
         CASE nKey == K_DEL .AND. LASTREC() !=0
              IF DELETED()
                 RECALL
                 ELSE
                 DELETE
              ENDIF
        OTHERWISE
              TONE( 100, 1 )
              IF DELETED()
                 @ 00,00 SAY "DELETADO"
                 ELSE
                 @ 00,00 SAY "        "
              ENDIF

        ENDCASE
RETURN nRetVal

FUNCTION EditFunc( nCol )
LOCAL cIndexVal
LOCAL nRetVal
LOCAL nField
LOCAL nFieldVal
LOCAL nCursSave
acColumns :={ "data", "lkconta", "lkcaixa", "valor", "comissao" }
cIndexVal:= &( INDEXKEY(0) )
nField:=FIELDPOS( acColumns [ nCol ] )
IF nField !=0
   nCursSave:=SETCURSOR()
   SETCURSOR(1)
   cFieldVal:=FIELDGET( nField )
   @ ROW(), COL() GET cFieldVal
   READ
   FIELDPUT( nField, cFieldVal)
   SETCURSOR(nCursSave)
ENDIF

IF cIndexVal != &(INDEXKEY(0))
   nRequest:=DE_REFRESH
   ELSE
   nRequest:=DE_CONT
ENDIF

RETURN nRequest

FUNCTION IdleFunc()
 RETURN DE_CONT

FUNCTION EmptyFunc()
 RETURN DE_CONT










