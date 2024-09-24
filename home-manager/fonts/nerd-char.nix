{ config }:
let
  inherit (config.krs.fonts) nerdCharMode;
in
{
  # wide char - pad on "wide" terminals
  wc = str: alt:
    {
      "narrow" = str;
      "wide" = str + " ";
      "disabled" = alt;
    }.${nerdCharMode};

  # narrow char - do not pad
  nc = str: alt:
    {
      "narrow" = str;
      "wide" = str;
      "disabled" = alt;
    }.${nerdCharMode};
}

