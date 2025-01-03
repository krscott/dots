{
  description = "Kris's Nix Config";

  # TODO: nixConfig experimental-features, cachix

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    stylix.url = "github:danth/stylix";
    catppuccin.url = "github:catppuccin/nix";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixgl = {
      url = "github:nix-community/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    gnome-monitor-config = {
      url = "github:krscott/gnome-monitor-config";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    nixgl,
    stylix,
    catppuccin,
    ...
  } @ inputs: let
    mkNixos = config:
      nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          home-manager.nixosModules.default
          stylix.nixosModules.stylix
          catppuccin.nixosModules.catppuccin
          config
        ];
      };

    mkHome = {
      system,
      modules,
    }:
      home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          inherit system;
          overlays = [nixgl.overlay];
        };
        extraSpecialArgs = {inherit inputs;};
        modules = [./home-manager/hm-standalone.nix] ++ modules;
      };
  in {
    nixosConfigurations = {
      "charon" = mkNixos ./hosts/charon/configuration.nix;
    };

    homeConfigurations = {
      "kris@ubuntu-nix.styx" = mkHome {
        system = "x86_64-linux";
        modules = [
          ./hosts/styx/styx-home.nix
          ./users/kris.nix
          {
            krs = {
              kitty.enable = true;
              nixgl.enable = true;
              system.hasBattery = false;
            };
          }
        ];
      };

      "kris@galatea" = mkHome {
        system = "x86_64-linux";
        modules = [
          ./users/kris.nix
          {
            krs = {
              cloudAi.enable = true;
              git.useSystemSsh = true;
              secrets.enable = true;
              wsl.enable = true;
            };
          }
        ];
      };

      "clear" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {system = "x86_64-linux";};
        modules = [./home-manager/core.nix];
      };
    };

    nixGL = nixgl;

    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;
  };
}
