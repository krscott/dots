{ pkgs, inputs, config, ... }:
{
  imports = [
    ./core.nix
    ./gui.nix
    ./wsl.nix

    ./theme/catppuccin.nix

    ./fonts
    ./git
    ./kitty
    ./nvim
    ./starship
    ./tmux
    ./zsh

    ./scripts

    # sops secret management
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
    # Secret management
    sops

    # CLI
    neofetch
    tldr
    dust    # du replacement
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
    direnv-init = "echo 'use flake . --impure' >> .envrc && direnv allow";
    start-ssh-agent = "eval `ssh-agent` && ssh-add";
  };

  home.sessionVariables = {
    MANPAGER = "sh -c 'col -bx | bat -l man -p'";
    MANROFFOPT = "-c";
  };
}
