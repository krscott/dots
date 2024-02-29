{ pkgs, ... }:
let
  inherit (import ../options.nix) gitFullName gitEmail;
in
{
  programs = {
    git = {
      enable = true;
      package = pkgs.gitFull;  # Includes gitk
      userName = gitFullName;
      userEmail = gitEmail;
      aliases = {
        s = "status";
        lol = "log --oneline --date-order";
        k = "!gitk --date-order";
        ka = "!gitk --all --date-order";
        l = "!lazygit";
      };
    };

    lazygit.enable = true;
  };

  # home.shellAliases = {
  #   gs = "git stuats";
  #   gl = "lazygit";
  # };
}
