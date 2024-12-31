{
  config,
  lib,
  pkgs,
  ...
}: let
  krslib = import ../../lib/krslib.nix {inherit lib;};
in {
  options.krs = {
    gnome.enable = krslib.mkEnableOptionFalse "GNOME";
  };

  config = lib.mkIf config.krs.gnome.enable {
    home.packages = with pkgs; [
      gnomeExtensions.clipboard-indicator
    ];

    dconf.settings = {
      "org/gnome/shell" = {
        disable-user-extensions = false;
        enabled-extensions = [
          "clipboard-indicator@tudmotu.com"
        ];
      };
    };
  };
}
