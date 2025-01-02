{
  config,
  lib,
  ...
}: {
  config = lib.mkIf (config.krs.theme.type == "catppuccin") {
    catppuccin = {
      enable = true;
      flavor = "mocha";
    };
  };
}
