{
  config,
  lib,
  ...
}: {
  config = lib.mkIf (config.krs.theme.type == "stylix") {
    stylix.targets = {
      firefox.enable = false;
    };
  };
}
