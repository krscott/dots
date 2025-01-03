{
  config,
  lib,
  ...
}: let
  krslib = import ../lib/krslib.nix {inherit lib;};
  eachMainUser = f: krslib.mapAttrNames f config.krs.users.main.names;

  # Get all options that are also custom home-manager options
  commonOptions = lib.removeAttrs config.krs [
    "users"
    "vm"
  ];
in {
  options.krs.users = {
    main = {
      names = lib.mkOption {
        description = "List of main users";
        type = lib.types.nonEmptyListOf lib.types.str;
        default = [
          "kris"
        ];
      };

      options = lib.mkOption {
        description = "Custom options";
        type = lib.types.attrs;
        default = {};
      };
    };
  };

  config = {
    users.users = eachMainUser (name: {
      isNormalUser = true;
      description = lib.mkDefault name;
      extraGroups = ["networkmanager" "wheel"];
    });

    home-manager.users = eachMainUser (name: {
      imports = [
        ../users/${name}.nix
        ../home-manager
        {
          krs = commonOptions // config.krs.users.main.options;
        }
      ];
    });
  };
}
