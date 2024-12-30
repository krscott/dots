{
  config,
  lib,
  pkgs,
  ...
}: let
  krslib = import ../lib/krslib.nix {inherit lib;};
in {
  options.krs = {
    games.enable = krslib.mkEnableOptionFalse "games";
  };

  config = lib.mkIf config.krs.games.enable {
    # nixpkgs.overlays = [
    #   # Temporary heroic electron fix
    #   (final: prev: {
    #     electron_31 = final.electron;
    #   })
    # ];

    environment.systemPackages = with pkgs; [
      mangohud
      lutris
      # heroic
      # bottles

      (writeShellScriptBin "protonup" ''
        set -eu
        # Note: tilde (`~`) in quotes is a literal character
        ${lib.getExe protonup} -d "~/.steam/root/compatibilitytools.d/"
        ${lib.getExe protonup} "$@"
      '')
    ];

    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
    };

    # Accessed with `gamemode <command>`
    programs.gamemode.enable = true;
  };
}
