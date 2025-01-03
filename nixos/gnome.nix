# https://nixos.wiki/wiki/GNOME
{pkgs, ...}: {
  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
    gnome-characters # Already using `emote`
  ];
}
