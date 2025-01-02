{
  lib,
  pkgs,
  ...
}: let
  krslib = import ../../lib/krslib.nix {inherit lib;};
in {
  imports = [
    ./stylix.nix
    ./catppuccin.nix
  ];

  options.krs = {
    terminal = {
      font = {
        package = lib.mkOption {
          type = lib.types.package;
          default = pkgs.nerd-fonts.iosevka-term;
          description = "Terminal font package";
        };
        name = krslib.mkStrOption "Terminal font name" "IosevkaTerm Nerd Font";
        size = krslib.mkIntOption "Terminal font size" 14;
      };

      opacity = krslib.mkFloatOption "Terminal opacity" 0.85;
    };

    theme = {
      type = lib.mkOption {
        description = "Theme enum";
        type = lib.types.enum ["none" "stylix" "catppuccin"];
        default = "catppuccin";
      };

      wallpaper = lib.mkOption {
        description = "Wallpaper image";
        default = pkgs.fetchurl {
          # https://www.pexels.com/photo/green-and-white-lighted-tunnel-10753976/
          url = "https://images.pexels.com/photos/10753976/pexels-photo-10753976.jpeg";
          sha256 = "sha256-aFCLon6DO9JEvKXDkPZhB4FOHkbUyrT57rt9eOr/I2M=";
        };
      };
    };
  };
}
