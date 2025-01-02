{...}: {
  imports = [
    ./catppuccin.nix
  ];

  # Stylix creats a lazygit config, which fails if lazygit already created
  # one at runtime.
  # Create a blank file from nix to keep lazygit from creating one itself.
  xdg.configFile."lazygit/config.yml".text = "";
}
