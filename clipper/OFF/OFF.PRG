     x := FastPCX("\DOS\OFF.LOG")
     do case
          case x = 0          && Displayed OK.
               * - Agora no modo Gr fico, pressione uma tecla e retorne ao Sistema Operacional.
          case x = 1
               ? 'Arquivo n„o encontrado.'
          case x = 2
               ? 'File Not found.'
          case x = 3
               ? 'Arquivo n„o suportou o formato PCX e/ou n„o ‚ verdadeiramente um Arquivo PCX.'
     endcase
     @ 23,00 SAY TIME()
     





















