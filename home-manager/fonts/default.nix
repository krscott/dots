{ config, pkgs, lib, ... }:
{
  options.krs.fonts = {
    nerdfonts = lib.mkOption {
      default = [ "JetBrainsMono" "Iosevka" "FantasqueSansMono" "DroidSansMono" ];
      description = "Enabled Nerd Fonts";
    };
    nerdCharMode = lib.mkOption {
      type = lib.types.enum [ "narrow" "wide" "disabled" ];
      default = "narrow";
      description = "How to display nerdfont special characters";
    };
  };

  config = {
    home.packages = with pkgs; [
      (nerdfonts.override {
        fonts = config.krs.fonts.nerdfonts;
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
