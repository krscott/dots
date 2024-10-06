{
  pkgs,
  lib,
  config,
  ...
}: let
  direnv = "${pkgs.direnv}/bin/direnv";
  cp = "cp --no-preserve=mode,ownership";

  flake-template = pkgs.writeText "flake-init-template.nix" (
    builtins.readFile ./flake-init-template.nix
  );

  flake-init = pkgs.writeShellScriptBin "flake-init" ''
    set -euo pipefail

    ${cp} ${flake-template} flake.nix
    echo "use flake . --impure" >> .envrc && ${direnv} allow

    # (These files are already added to global git excludeFile in this config)
    # cat <<EOF >> .gitignore
    #
    # .direnv/
    # .envrc
    # EOF
  '';
in {
  config = lib.mkIf config.programs.direnv.enable {
    home.packages = [
      flake-init
    ];
  };
}
