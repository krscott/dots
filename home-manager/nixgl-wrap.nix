{
  config,
  lib,
  inputs,
  ...
}: let
  inherit (inputs) nixgl;
  noop = pkg: pkg;
in {
  options.krs.nixglWrap = lib.mkOption {
    default = noop;
    example = config.lib.nixGL.wrap;
  };

  config = lib.mkIf (config.krs.nixglWrap != noop) {
    # https://nix-community.github.io/home-manager/index.xhtml#sec-usage-gpu-non-nixos
    nixGL = {
      packages = nixgl.packages;
    };
  };
}
