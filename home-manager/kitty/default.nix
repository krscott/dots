{
  config,
  pkgs,
  lib,
  ...
}: let
  krslib = import ../../lib/krslib.nix {inherit lib;};
in {
  options.krs.kitty = {
    enable = krslib.mkEnableOptionFalse "kitty";
    useSystem = krslib.mkEnableOptionFalse "using system kitty";
  };

  config = lib.mkIf config.krs.kitty.enable {
    home.shellAliases = {
      # Install kitty terminfo on servers
      #s = "kitty +kitten ssh";
    };

    programs.kitty = {
      enable = true;
      package =
        if config.krs.kitty.useSystem
        then pkgs.emptyDirectory
        else config.krs.nixgl.wrap pkgs.kitty;
      font.name = lib.mkDefault config.krs.terminal.font.name;
      font.size = lib.mkDefault config.krs.terminal.font.size;
      extraConfig = builtins.readFile ./kitty.conf;
    };
  };
}
