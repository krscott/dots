{ config, pkgs, lib, ... }:
{
  options.krs.fonts = {
    nerdfonts = lib.mkOption {
      default = [ "JetBrainsMono" "Iosevka" "FantasqueSansMono" "DroidSansMono" ];
      description = "Enabled Nerd Fonts";
    };
    isWideChar = lib.mkOption {
      default = c: builtins.elem c [ "✘" "󰏗" "" "" ];
      description = "Characters that should be padded when displayed";
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
