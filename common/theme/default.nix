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
    };
  };
}
