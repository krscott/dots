{
  config,
  lib,
  pkgs,
  ...
}: let
  krslib = import ../../lib/krslib.nix {inherit lib;};

  mkArrIf = cond: arr:
    if cond
    then arr
    else [];
in {
  options.krs = {
    gnome.enable = krslib.mkEnableOptionFalse "GNOME";
  };

  config = lib.mkIf config.krs.gnome.enable {
    home.packages = with pkgs; [
      gnomeExtensions.clipboard-indicator
    ];

    dconf.settings = {
      # Inspiration: https://heywoodlh.io/nixos-gnome-settings-and-keyboard-shortcuts

      "org/gnome/shell" = {
        disable-user-extensions = false;
        enabled-extensions = [
          "clipboard-indicator@tudmotu.com"
        ];

        # Command to list currently pinned apps:
        #     dconf read /org/gnome/shell/favorite-apps
        favorite-apps = with config.krs;
          [
            "firefox.desktop"
            "org.gnome.Nautilus.desktop"
          ]
          ++ (
            if kitty.enable
            then ["kitty.desktop"]
            else if alacritty.enable
            then ["Alacritty.desktop"]
            else []
          )
          ++ (mkArrIf games.enable ["steam.desktop" "discord.desktop"])
          ++ (mkArrIf guiApps.enable ["obsidian.desktop"])
          ++ (mkArrIf flatpak.enable [
            "org.keepassxc.KeePassXC.desktop"
            "com.spotify.Client.desktop"
          ]);
      };

      "org/gnome/desktop/wm/preferences" = {
        button-layout = "appmenu:minimize,maximize,close";
        resize-with-right-button = true;
      };

      "org/gnome/desktop/interface" = {
        # clock-show-seconds = true;
        clock-show-weekday = true;
        color-scheme = "prefer-dark";
        enable-hot-corners = false;
        font-antialiasing = "grayscale";
        font-hinting = "slight";
        gtk-theme = lib.mkDefault "Nordic";
        toolkit-accessibility = true;
      };

      "org/gnome/desktop/peripherals/mouse" = {
        accel-profile = "flat";
      };

      "org/gnome/mutter" = {
        edge-tiling = true;
      };

      "org/gnome/settings-daemon/plugins/media-keys" = {
        # next = ["<Shift><Control>n"];
        # previous = ["<Shift><Control>p"];
        # play = ["<Shift><Control>space"];
        custom-keybindings = [
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
        ];
      };
      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
        name = "emote";
        command = "emote";
        binding = "<Super>semicolon";
      };
      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
        name = "terminal";
        command = with config.krs;
          if kitty.enable
          then "kitty -e tmux"
          else if alacritty.enable
          then "alacritty -e tmux"
          else "kgx";
        binding = "<Ctrl><Alt>t";
      };
    };
  };
}
