{lib, ...}: let
  krslib = import ../lib/krslib.nix {inherit lib;};
in {
  imports = [
    ./theme
  ];

  options.krs = {
    games.enable = krslib.mkEnableOptionFalse "games";

    flatpak = {
      enable = krslib.mkEnableOptionFalse "flatpak";
      apps = lib.mkOption {
        description = "List of flatpak app IDs to install";
        type = lib.types.listOf lib.types.str;
        default = [
          "flathub com.spotify.Client"
          "flathub org.keepassxc.KeePassXC"
        ];
      };
    };
  };
}
