{pkgs, ...}: {
  imports = [
    ./style.nix
  ];

  programs.tmux = {
    enable = true;
    shell = "${pkgs.zsh}/bin/zsh";
    extraConfig = builtins.readFile ./tmux-init.conf;
    # Note: 'sensible' plugin is included by default
    plugins = with pkgs; [
      tmuxPlugins.vim-tmux-navigator
      tmuxPlugins.yank
    ];
  };
}
