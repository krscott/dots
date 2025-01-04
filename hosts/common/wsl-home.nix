{lib, ...}: {
  krs = {
    git.useSystemSsh = true;
    secrets.enable = true;
    wsl.enable = true;
  };

  # TODO(kscott): Debug
  programs.pay-respects.enable = lib.mkForce false;
}
