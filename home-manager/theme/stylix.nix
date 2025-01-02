{
  config,
  inputs,
  lib,
  ...
}: {
  imports = [
    inputs.stylix.homeManagerModules.stylix
  ];

  config = lib.mkIf (config.krs.theme.type == "stylix") {
    stylix.targets = {
      firefox.enable = false;
    };
  };
}
