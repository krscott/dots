{lib, ...}: let
  krslib = import ../lib/krslib.nix {inherit lib;};
in {
  options.krs = {
    games.enable = krslib.mkEnableOptionFalse "games";
  };
}
