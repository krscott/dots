{ pkgs, lib, config, ... }:
{
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
    programs = {
      vim = {
        enable = true;
        defaultEditor = true;
      };

      git = {
        enable = true;
        package = pkgs.gitFull;  # Includes gitk
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
        };
        aliases = {
          s = "status -sb";
          lol = "log --graph --abbrev-commit --date-order --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)'";
          lola = "lol --all";
          lol2 = "log --graph --abbrev-commit --date-order --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(auto)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)'";
          lola2 = "lol2 --all";
          dogs = "log --decorate --oneline --graph --stat";
          k = "!gitk --date-order";
          ka = "!gitk --all --date-order";
          l = "!lazygit";
          cr = "clone --recursive";
          smu = "submodule update --recursive --init";
        };
      };

      lazygit.enable = true;

      zsh.initExtra = if config.krs.git.useSystemSsh then ''
        export GIT_SSH=`which ssh`
      '' else "";
    };

    # home.shellAliases = {
    #   gs = "git stuats";
    #   gl = "lazygit";
    # };

  };
}
