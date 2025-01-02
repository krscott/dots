{
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (config.krs) terminal;
in {
  config = lib.mkIf (config.krs.theme.type == "stylix") {
    stylix = {
      enable = true;
      polarity = "dark";

      image = config.krs.theme.wallpaper;

      base16Scheme = lib.mkDefault "${pkgs.base16-schemes}/share/themes/blueish.yaml";

      fonts = {
        serif = {
          package = pkgs.liberation_ttf;
          name = "Liberation Serif";
        };
        sansSerif = {
          package = pkgs.liberation_ttf;
          name = "Liberation Sans";
        };
        monospace = {
          package = terminal.font.package;
          name = terminal.font.name;
        };

        sizes.terminal = terminal.font.size;
      };
      opacity.terminal = terminal.opacity;
    };
  };
}
