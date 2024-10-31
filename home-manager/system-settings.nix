{lib, ...}: let
  krslib = import ../lib/krslib.nix {inherit lib;};
in {
  options.krs.system = {
    hasBattery = krslib.mkEnableOptionTrue "enable battery-related features";
  };
}
