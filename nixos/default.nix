{
  config,
  lib,
  pkgs,
  ...
}: let
  krslib = import ../lib/krslib.nix {inherit lib;};
in {
  imports = [
    ./steam
  ];

  options.krs = {
    games.enable = krslib.mkEnableOptionFalse "games";
  };

  config = lib.mkIf config.krs.games.enable {
    # Enable OpenGL (already enabled if steam is enabled)
    hardware.opengl.enable = true;

    environment.systemPackages = with pkgs; [
      mangohud
    ];

    # Accessed with `gamemode <command>`
    programs.gamemode.enable = true;
  };
}
