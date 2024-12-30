{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf config.krs.games.enable {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
    };

    environment.systemPackages = with pkgs; [
      protonup
    ];
  };
}
