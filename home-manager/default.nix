{pkgs, ...}: {
  imports = [
    ./cloud-ai.nix
    ./core.nix
    ./gui.nix
    ./nixgl.nix
    ./secrets.nix
    ./system-settings.nix
    ./wsl.nix

    ./theme/catppuccin.nix

    ./alacritty
    ./fonts
    ./git
    ./kitty
    ./nvim
    ./starship
    ./tmux
    ./zsh

    ./scripts
  ];

  home.packages = with pkgs; [
    # CLI
    neofetch
    tldr
    dust # du replacement
    jq

    # Rust
    rustc
    cargo
    gcc # Required for linking
  ];

  programs = {
    # CLI
    autorandr.enable = true;
    bat = {
      enable = true;
      extraPackages = with pkgs.bat-extras; [
        batdiff
        batman
        batgrep
        batwatch
      ];
    };
    btop.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    eza.enable = true;
    fd.enable = true;
    fzf = {
      enable = true;
      defaultOptions = [
        "--multi"
      ];
    };
    htop.enable = true;
    ripgrep.enable = true;
    zoxide.enable = true;
  };

  home.shellAliases = {
    l = "eza --long --git --no-filesize --icons=always --no-time --no-user --no-permissions";
    ls = "eza";
    la = "eza -a";
    ll = "eza -lah";
    cat = "bat -p";
    start-ssh-agent = "eval `ssh-agent` && ssh-add";
    bell = "echo -n -e '\\a'";
  };

  home.sessionVariables = {
    MANPAGER = "sh -c 'col -bx | bat -l man -p'";
    MANROFFOPT = "-c";
  };
}
