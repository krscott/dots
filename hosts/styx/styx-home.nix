{
  config,
  pkgs,
  inputs,
  ...
}: let
  gmc = "${inputs.gnome-monitor-config.packages."${pkgs.system}".default}/bin/gnome-monitor-config";
in {
  krs.nixglWrap = config.lib.nixGL.wrap;

  home.packages = with pkgs; [
    xorg.xinput
    inputs.gnome-monitor-config.packages."${pkgs.system}".default
    (
      writeShellScriptBin "mon169" ''
        ${gmc} set -LpM DP-1 -t normal -m '2560x1440@143.999' -LM HDMI-1 -t normal -m '1024x600@59.821' -x 768 -y 1440
      ''
    )
    (
      writeShellScriptBin "mon219" ''
        ${gmc} set -LpM DP-1 -t normal -m '3440x1440@144.001' -LM HDMI-1 -t normal -m '1024x600@59.821' -x 1208 -y 1440
      ''
    )
  ];
}
