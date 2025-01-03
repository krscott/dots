{
  config,
  lib,
  pkgs,
  ...
}: let
  krslib = import ../lib/krslib.nix {inherit lib;};
in {
  options.krs.vm = {
    enable = krslib.mkEnableOptionFalse "vm";
    users = lib.mkOption {
      description = "List of vm users";
      type = lib.types.nonEmptyListOf lib.types.str;
      default = config.krs.users.main.names;
    };
  };

  config = lib.mkIf config.krs.vm.enable {
    programs.virt-manager.enable = true;

    programs.dconf.enable = true;

    users.groups.libvirtd.members = config.krs.vm.users;

    environment.systemPackages = with pkgs; [
      spice
      spice-gtk
      spice-protocol
      win-virtio
      win-spice
      adwaita-icon-theme
    ];

    virtualisation = {
      libvirtd = {
        enable = true;
        qemu = {
          package = pkgs.qemu_kvm;
          # runAsRoot = false;
          swtpm.enable = true;
          ovmf = {
            enable = true;
            packages = [pkgs.OVMFFull.fd];
          };
        };
      };
      spiceUSBRedirection.enable = true;
    };
    services.spice-vdagentd.enable = true;
  };
}
