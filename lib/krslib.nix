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

  mkFloatOption = description: default:
    lib.mkOption {
      inherit description default;
      type = lib.types.float;
    };

  mkEnumOption = description: values:
    lib.mkOption {
      inherit description;
      type = lib.types.enum values;
      # default = builtins.elemAt values 0;
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

  mkArrIf = cond: arr:
    if cond
    then arr
    else [];

  getOptStr = a: b:
    if a != ""
    then a
    else b;

  getOptPosInt = a: b:
    if a >= 0
    then a
    else b;

  mapAttrNames = f: list:
    builtins.listToAttrs (builtins.map (name: {
        inherit name;
        value = f name;
      })
      list);
}
