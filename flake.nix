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
    }: let
      pkgs = import nixpkgs {
        inherit system;
        overlays = [nixgl.overlay];
      };
    in
      home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {inherit inputs;};
        modules =
          [
            {nix.package = pkgs.nix;}
          ]
          ++ modules;
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
          ./home-manager
          ./users/kris.nix
          {
            krs = {
              cloudAi.enable = true;
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
          ./home-manager
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

      "clear" = mkHome {
        system = "x86_64-linux";
        modules = [
          ./home-manager/core.nix
          ./users/kris.nix
        ];
      };
    };

    nixGL = nixgl;

    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;
  };
}
