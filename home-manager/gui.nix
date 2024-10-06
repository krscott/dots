{
  config,
  lib,
  pkgs,
  ...
}: let
  krslib = import ../lib/krslib.nix {inherit lib;};
in {
  options.krs.guiApps.enable = krslib.mkEnableOptionFalse "guiApps";

  config = lib.mkIf config.krs.guiApps.enable {
    # Add app .desktop files to path
    targets.genericLinux.enable = true;
    xdg.mime.enable = true;
    xdg.systemDirs.data = [
      "${config.home.homeDirectory}/.nix-profile/share/applications"
    ];

    programs = {
      firefox.enable = true;
      chromium.enable = true;
    };

    home.packages = with pkgs; [
      emote # Emoji picker
      obsidian
    ];
  };
}
