{
  config,
  lib,
  pkgs,
  ...
}: let
  cmds = builtins.concatStringsSep "\n" (builtins.map (app: "flatpak install -y ${app}") config.krs.flatpak.apps);
in {
  config = lib.mkIf config.krs.flatpak.enable {
    home.packages = [
      (pkgs.writeShellScriptBin "krs_flatpak_install" ''
        set -eu
        flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

        ${cmds}
      '')
    ];
  };
}
