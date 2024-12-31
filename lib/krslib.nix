{lib}: {
  mkEnableOptionTrue = name:
    lib.mkOption {
      default = true;
      example = false;
      description = "Whether to enable ${name}.";
      type = lib.types.bool;
    };

  mkEnableOptionFalse = name:
    lib.mkOption {
      default = false;
      example = false;
      description = "Whether to enable ${name}.";
      type = lib.types.bool;
    };

  mkStrOption = description: default:
    lib.mkOption {
      inherit description default;
      type = lib.types.str;
    };

  mkIntOption = description: default:
    lib.mkOption {
      inherit description default;
      type = lib.types.int;
    };

  mkAppShortcut = {
    pkgs,
    name,
    exec,
    icon,
    ...
  }: let
    item = pkgs.makeDesktopItem {
      inherit name exec icon;
      desktopName = name;
    };
  in {
    home.file.".local/share/applications/${name}.desktop".text = builtins.readFile "${item}/share/applications/${name}.desktop";
  };

  appendIf = cond: x:
    if cond
    then [x]
    else [];
}
