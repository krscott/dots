{lib, ...}: let
  krslib = import ../lib/krslib.nix {inherit lib;};
in {
  imports = [
    ./theme
  ];

  options.krs = {
    games.enable = krslib.mkEnableOptionFalse "games";
  };
}
