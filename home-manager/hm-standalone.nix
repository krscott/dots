# Standalone home-manager options
{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.stylix.homeManagerModules.stylix
    ./default.nix
  ];

  nix.package = pkgs.nix;
}
