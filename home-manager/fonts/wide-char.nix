{ config }:
c:
  if (config.krs.fonts.isWideChar c) then
    c + " "
  else
    c

