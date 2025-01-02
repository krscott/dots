{
  config,
  inputs,
  lib,
  ...
}: {
  imports = [
    inputs.catppuccin.homeManagerModules.catppuccin
  ];

  config = lib.mkIf (config.krs.theme.type == "catppuccin") {
    catppuccin = {
      enable = true;
      flavor = "mocha";
    };
  };
}
