{ config }:
str: alt:
  if (config.krs.nerdfonts.enable)
    then str
    else alt

