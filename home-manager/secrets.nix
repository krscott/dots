{ pkgs, inputs, config, ... }:
{
  imports = [
    inputs.sops-nix.homeManagerModules.sops
  ];

  sops = {
    defaultSopsFile = ../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
    secrets = {
      openai_api_key.path = "%r/secrets/openai_api_key.txt";
    };
  };

  home.packages = with pkgs; [
    sops

    (writeShellScriptBin "get_openai_api_key" ''
      cat $XDG_RUNTIME_DIR/secrets/openai_api_key.txt
    '')
  ];
}
