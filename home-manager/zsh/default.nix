{pkgs, ...}: {
  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;
    historySubstringSearch.enable = true;
    plugins = [
      {
        name = "init-dotfile";
        src = ./.;
        file = "init.zsh";
      }
    ];
    initExtra = ''
      source ${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh
    '';
  };

  home.packages = with pkgs; [
    zsh-fzf-tab
  ];
}
