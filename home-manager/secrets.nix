{
  pkgs,
  lib,
  inputs,
  config,
  ...
}: let
  krslib = import ../lib/krslib.nix {inherit lib;};
in{
  imports = [
    inputs.sops-nix.homeManagerModules.sops
  ];

  options.krs.secrets.enable = krslib.mkEnableOptionFalse "secrets";

  config = {
    sops = {
      defaultSopsFile = ../secrets/secrets.yaml;
      defaultSopsFormat = "yaml";
      age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
      secrets = {};
    };

    home = lib.mkIf config.krs.secrets.enable {
      packages = with pkgs; [
        sops
      ];

      sessionVariables = {
        KRS_NIX_SECRETS_ENABLE = 1;
      };
    };
  };
}
