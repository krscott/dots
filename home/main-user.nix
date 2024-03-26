{ pkgs, ... }:
{
  imports = [
    ./core.nix
    ./sh.nix
    ./nixgl-option.nix

    ../kitty/kitty.nix
  ];

  home.packages = with pkgs; [
    firefox
    chromium
  ];

  programs.autorandr.enable = true;
}
