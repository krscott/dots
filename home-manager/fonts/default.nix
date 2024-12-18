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
  };

  config = let
    normalFonts = with pkgs; [
      ubuntu_font_family
      liberation_ttf
    ];

    nerdfonts =
      if (config.krs.nerdfonts.enable)
      then with pkgs.nerd-fonts; [
        jetbrains-mono
        iosevka
        iosevka-term
        fantasque-sans-mono
        droid-sans-mono
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
        # monospace = ["Liberation Mono"];
        sansSerif = ["Liberation Sans"];
        serif = ["Liberation Serif"];
      };
    };
  };
}
