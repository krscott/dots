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
          size = lib.mkDefault config.krs.terminal.font.size;
          normal.family = lib.mkDefault config.krs.terminal.font.name;
        };
      };
    };
  };
}
