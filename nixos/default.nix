{lib, ...}: let
  krslib = import ../lib/krslib.nix {inherit lib;};
in {
  imports = [
    ./steam
  ];

  options.krs = {
    games.enable = krslib.mkEnableOptionFalse "games";
  };
}
