{ pkgs, ... }:
{
  programs = {
    git = {
      enable = true;
      package = pkgs.gitFull;  # Includes gitk
      userName = "Kris Scott";
      userEmail = "kscott91@gmail.com";
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
}
