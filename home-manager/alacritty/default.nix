{
  config,
  pkgs,
  lib,
  ...
}: let
  krslib = import ../../lib/krslib.nix {inherit lib;};
in {
  options.krs.alacritty = {
    enable = krslib.mkEnableOptionFalse "alacritty";
    # Font must also be added to fonts.nix
    fontName = krslib.mkStrOption "Font Name" "IosevkaTerm Nerd Font";
    fontSize = krslib.mkIntOption "Font Size" 16;
  };

  config = lib.mkIf config.krs.alacritty.enable {
    programs.alacritty = {
      enable = true;
      package = config.krs.nixgl.wrap pkgs.alacritty;
      settings = {
        general.import = [
          "${./alacritty.toml}"
        ];
        font = {
          size = lib.mkDefault config.krs.alacritty.fontSize;
          normal.family = lib.mkDefault config.krs.alacritty.fontName;
        };
      };
    };
  };
}
