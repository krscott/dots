{
  pkgs,
  lib,
  config,
  ...
}: let
  direnv-init = pkgs.writeShellScriptBin "direnv-init" ''
    set -euo pipefail

    target="''${1:-}"

    cat <<EOF > .envrc
    use flake '.?submodules=1#$target' --impure
    EOF

    direnv allow
  '';

  direnv-manual-init = pkgs.writeShellScriptBin "direnv-manual-init" ''
    set -euo pipefail

    # Reload with `nix-direnv-reload`

    target="''${1:-}"

    cat <<EOF > .envrc
    nix_direnv_manual_reload
    use flake '.?submodules=1#$target' --impure
    EOF

    direnv allow
  '';

  direnv-deinit = pkgs.writeShellScriptBin "direnv-deinit" ''
    set -euo pipefail

    rm .envrc
    rm -rf .direnv/
  '';

  direnv-reload = pkgs.writeShellScriptBin "direnv-reload" ''
    set -euo pipefail

    rm -rf .direnv/
    direnv allow
  '';
in {
  config = lib.mkIf config.programs.direnv.enable {
    home.packages = [
      direnv-init
      direnv-manual-init
      direnv-deinit
      direnv-reload
    ];
  };
}
