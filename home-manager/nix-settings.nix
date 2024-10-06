{
  config,
  lib,
  ...
}: let
  krslib = import ../lib/krslib.nix {inherit lib;};
in {
  # Option to skip creating/managing a nix.conf file
  options.krs.defaultNixSettings = krslib.mkEnableOptionTrue "default nix.settings";

  config = lib.mkIf config.krs.defaultNixSettings {
    # Enable flakes
    nix.settings.experimental-features = ["nix-command" "flakes"];
  };
}
