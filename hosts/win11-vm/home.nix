# Windows 11 VM WSL2 Ubuntu nix
# Just for testing nix home-manager on WSL2. I don't actually use this I promise.
{...}: {
  imports = [
    ../common/wsl-home.nix
    ../../home-manager/hm-standalone.nix
  ];

  krs = {
    system.hasBattery = false;
  };
}
