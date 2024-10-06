{
  config,
  pkgs,
  lib,
  ...
}: let
  krslib = import ../../lib/krslib.nix {inherit lib;};
in {
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

  config = let
    normalFonts = with pkgs; [
      ubuntu_font_family
      liberation_ttf
    ];

    nerdfonts =
      if (config.krs.nerdfonts.enable)
      then [
        (pkgs.nerdfonts.override {
          fonts = config.krs.nerdfonts.fonts;
        })
      ]
      else [];
  in {
    home.packages = normalFonts ++ nerdfonts;

    fonts.fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [
          (
            if config.krs.nerdfonts.enable
            then "Iosevka Nerd Font"
            else "Liberation Mono"
          )
        ];
        sansSerif = ["Liberation Sans"];
        serif = ["Liberation Serif"];
      };
    };
  };
}
