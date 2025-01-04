{...}: {
  krs = {
    git.useSystemSsh = true;
    secrets.enable = true;
    wsl.enable = true;
  };
}
