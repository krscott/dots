{
  config,
  lib,
  ...
}: {
  config = lib.mkIf (config.krs.style.type == "catppuccin") {
    catppuccin = {
      enable = true;
      flavor = "mocha";
    };
  };
}
