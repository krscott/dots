{
  pkgs,
  lib,
  config,
  ...
}: let
  krslib = import ../../lib/krslib.nix {inherit lib;};

  rcloneDir = "${config.home.homeDirectory}/rclone";
  rcloneExe = "${lib.getExe pkgs.rclone}";
in {
  options.krs.rclone.enable = krslib.mkEnableOptionFalse "rclone";

  config = lib.mkIf config.krs.rclone.enable {
    sops = {
      secrets = {
        "rclone/gdrive/client_id" = {};
        "rclone/gdrive/client_secret" = {};
      };
    };

    home.packages = with pkgs; [
      rclone

      (writeShellScriptBin "krs_rclone_init" ''
        set -eu
        CFG_DIR="''${XDG_CONFIG_HOME:-$HOME/.config}/rclone"
        MNT_DIR="${rcloneDir}"

        mkdir -p "$CFG_DIR"

        cat <<EOF > "$CFG_DIR/rclone.conf"
        [gdrive]
        type = drive
        client_id = $(cat ${config.sops.secrets."rclone/gdrive/client_id".path})
        client_secret = $(cat ${config.sops.secrets."rclone/gdrive/client_secret".path})
        scope = drive
        team_drive =
        EOF

        mkdir -p "$MNT_DIR/gdrive"
        rclone config reconnect gdrive:
        # rclone mount gdrive: "$MNT_DIR/gdrive" --daemon
      '')
    ];

    systemd.user.services.rclone-gdrive-mount = {
      Unit = {
        Description = "Service that connects to Google Drive";
        # network target not available for user service
        # After = ["network-online.target"];
        # Requires = ["network-online.target"];
      };
      Install = {
        WantedBy = ["default.target"];
      };

      Service = let
        gdriveDir = "${rcloneDir}/gdrive";
      in {
        Type = "simple";
        ExecStartPre = "/run/current-system/sw/bin/mkdir -p ${gdriveDir}";
        ExecStart = "${rcloneExe} mount --vfs-cache-mode full gdrive: ${gdriveDir}";
        ExecStop = "/run/current-system/sw/bin/fusermount -u ${gdriveDir}";
        Restart = "on-failure";
        RestartSec = "10s";
        Environment = ["PATH=/run/wrappers/bin/:$PATH"];
      };
    };
  };
}
