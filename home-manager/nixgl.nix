{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: let
  inherit (inputs) nixgl;
  krslib = import ../lib/krslib.nix {inherit lib;};
in {
  options.krs.nixgl = {
    enable = krslib.mkEnableOptionFalse "nixgl";
    wrap = lib.mkOption {
      default = pkg: pkg;
    };
  };

  config = lib.mkIf config.krs.nixgl.enable {
    # https://nix-community.github.io/home-manager/index.xhtml#sec-usage-gpu-non-nixos
    # https://nix-community.github.io/home-manager/options.xhtml#opt-nixGL.packages
    nixGL = {
      packages = nixgl.packages;
    };
    krs.nixgl.wrap = config.lib.nixGL.wrap;

    home.packages = [
      pkgs.nixgl.auto.nixGLDefault
    ];
  };
}
