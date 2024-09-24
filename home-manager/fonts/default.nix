{ config, pkgs, lib, ... }:
let
  krslib = import ../../lib/krslib.nix { inherit lib; };
in
{
  options.krs.nerdfonts = {
    enable = krslib.mkEnableOptionTrue "nerdfonts";
    fonts = lib.mkOption {
      default = [
        "JetBrainsMono"
        "Iosevka"
        "IosevkaTerm"
        "FantasqueSansMono"
        "DroidSansMono"
      ];
      description = "Enabled Nerd Fonts";
    };
  };

  config = {
    home.packages = with pkgs; [
      (nerdfonts.override {
        fonts = config.krs.nerdfonts.fonts;
      })
      ubuntu_font_family
      liberation_ttf
    ];

    fonts.fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [ "Iosevka Nerd Font" ];
        sansSerif = [ "Liberation Sans" ];
        serif = [ "Liberation Serif" ];
      };
    };
  };
}
