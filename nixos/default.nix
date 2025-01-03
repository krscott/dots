{inputs, ...}: {
  imports = [
    ../common

    ./flatpak.nix
    ./games.nix
    ./gnome.nix
    ./users.nix
  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Install firefox.
  programs.firefox.enable = true;

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
  };
}
