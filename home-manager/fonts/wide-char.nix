{ config }:
c:
  if (builtins.elem c config.krs.fonts.wideChars) then
    c + " "
  else
    c

