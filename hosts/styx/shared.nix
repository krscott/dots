{...}: {
  krs = {
    flatpak.enable = true;
    games.enable = true;
    theme.type = "stylix";

    users.main.options = {
      alacritty.enable = true;
      gnome.enable = true;
      guiApps.enable = true;
      kitty.enable = true;
      rclone.enable = true;
      secrets.enable = true;
    };
  };

  # Enable OpenGL
  hardware.graphics = {
    enable = true;
  };
}
