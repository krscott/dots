{ config, lib, pkgs, ... }:
let
  krslib = import ../lib/krslib.nix { inherit lib; };
in
{
  options.krs.wsl = {
    enable = krslib.mkEnableOptionFalse "wsl";
    home = krslib.mkStrOption "home" "/mnt/c/Users/kris";
  };

  config = lib.mkIf config.krs.wsl.enable {
    krs.fonts.wideChars = lib.mkDefault [ "✘" "󰏗" "" "" "⇡" "⇣" "⇕" ];

    home.packages = with pkgs; [
      nautilus
      # wslu
      xdg-utils
    ];

    home.shellAliases = {
      winhome = "cd ${config.krs.wsl.home}";
    };

    home.sessionVariables = {
      # BROWSER = "wslview";
      # BROWSER = "/mnt/c/Program\ Files/Mozilla\ Firefox/firefox.exe";
    };
  };
}
