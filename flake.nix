{
  description = "Kris's Nix Config";

  # TODO: nixConfig experimental-features, cachix

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";

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

    mkHome = system: modules:
      home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          inherit system;
          overlays = [nixgl.overlay];
        };
        extraSpecialArgs = {inherit inputs;};
        inherit modules;
      };
  in {
    nixosConfigurations = {
      "styx" = mkNixos ./hosts/styx/configuration.nix;
      "charon" = mkNixos ./hosts/charon/configuration.nix;
    };

    homeConfigurations = {
      "kris@galatea" = mkHome "x86_64-linux" [
        ./users/kris.nix
        ./hosts/galatea/home.nix
      ];

      "clear" = mkHome "x86_64-linux" [
        ./home-manager/core.nix
      ];
    };

    nixGL = nixgl;

    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;
  };
}
