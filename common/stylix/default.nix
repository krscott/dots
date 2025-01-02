{
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (config.krs) terminal;
in {
  config = lib.mkIf (config.krs.style.type == "stylix") {
    stylix = {
      enable = true;
      polarity = "dark";

      image = pkgs.fetchurl {
        # https://www.pexels.com/photo/green-and-white-lighted-tunnel-10753976/
        url = "https://images.pexels.com/photos/10753976/pexels-photo-10753976.jpeg";
        sha256 = "sha256-aFCLon6DO9JEvKXDkPZhB4FOHkbUyrT57rt9eOr/I2M=";
      };

      base16Scheme = "${pkgs.base16-schemes}/share/themes/blueish.yaml";

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
