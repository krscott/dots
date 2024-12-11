{
  pkgs,
  lib,
  config,
  ...
}: {
  options.krs.git.useSystemSsh = lib.mkOption {
    type = lib.types.bool;
    description = ''
      Use local system ssh. i.e. set GIT_SSH to host system ssh;
      Fixes 'Unsupported option "gssapiauthentication"' warning.
    '';
    default = false;
    example = true;
  };

  config = {
    home.packages = [
      (
        pkgs.writeShellScriptBin "fetchme" ''
          set -euo pipefail

          if [ "$(git rev-parse --abbrev-ref HEAD)" = "$1" ]; then
              git fetch origin "$1"
              git reset --hard "origin/$1"
          else
              git fetch origin "$1:$1"
              git checkout "$1"
          fi

          git branch --set-upstream-to="origin/$1" "$1"
          git submodule update --init --recursive
        ''
      )
    ];

    programs = {
      vim = {
        enable = true;
        defaultEditor = true;
      };

      git = {
        enable = true;
        package = pkgs.gitFull; # Includes gitk
        extraConfig = {
          init = {
            defaultBranch = "main";
          };
          core = let
            excludesFile = builtins.toFile "git_excludes" ''
              .direnv/
              .envrc
            '';
          in {
            excludesFile = "${excludesFile}";
          };
          push = {
            useForceIfIncludes = true;
          };
        };
        aliases = {
          c = "clone --recursive";
          co = "checkout --recurse-submodules";
          dogs = "log --decorate --oneline --graph --stat";
          k = "!gitk --date-order";
          ka = "!gitk --all --date-order";
          l = "!lazygit";
          lol = "log --graph --abbrev-commit --date-order --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)'";
          lol2 = "log --graph --abbrev-commit --date-order --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(auto)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)'";
          lola = "lol --all";
          lola2 = "lol2 --all";
          nuke = "!git submodule foreach --recursive git clean -xffd && git submodule foreach --recursive git reset --hard && git clean -xffd && git reset --hard && git submodule sync --recursive && git restore . --recurse-submodules";
          pf = "push --force-with-lease --force-if-includes";
          prs = "pull --recurse-submodules --jobs=16";
          s = "status -sb";
          smu = "submodule update --recursive --init";
          u = "!git pull && git submodule update --recursive --init";
        };
      };

      lazygit.enable = true;

      zsh.initExtra =
        if config.krs.git.useSystemSsh
        then ''
          export GIT_SSH=`which ssh`
        ''
        else "";
    };
  };
}
