{ pkgs, lib, inputs, ... }:
{
  imports = [
    inputs.home-manager.nixosModules.default
  ];

  environment.systemPackages = with pkgs; [
    git
    vim
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
