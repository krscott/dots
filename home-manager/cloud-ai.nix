{
  pkgs,
  lib,
  config,
  ...
}: let
  krslib = import ../lib/krslib.nix {inherit lib;};
in {
  options.krs.cloudAi.enable = krslib.mkEnableOptionFalse "Enable cloud AI services";

  config = lib.mkIf (config.krs.cloudAi.enable) {
    sops = {
      secrets = {
        openai_api_key.path = "%r/secrets/openai_api_key.txt";
      };
    };

    home.packages = [
      (pkgs.writeShellScriptBin "get_openai_api_key" ''
        cat $XDG_RUNTIME_DIR/secrets/openai_api_key.txt
      '')
    ];
  };
}
