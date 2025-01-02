{
  pkgs,
  config,
  lib,
  ...
}: let
  krslib = import ../../lib/krslib.nix {inherit lib;};

  inherit (config.krs) terminal;
in {
  options.krs.stylix = {
    enable = krslib.mkEnableOptionFalse "stylix";
  };

  config = lib.mkIf config.krs.stylix.enable {
    stylix = {
      enable = true;
      polarity = "dark";

      image = pkgs.fetchurl {
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
