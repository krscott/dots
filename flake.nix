{
  description = "Kris's Nix Config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

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
    ...
  } @ inputs: let
    mkHome = {
      username,
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
        extraSpecialArgs = {
          inherit inputs;
        };
        modules =
          modules
          ++ [
            {
              nix.package = pkgs.nix;
              home = {
                inherit username;
                homeDirectory = "/home/${username}";
              };
            }
          ];
      };
  in {
    homeConfigurations = {
      "kris@ubuntu-nix.styx" = mkHome {
        username = "kris";
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
            };
          }
        ];
      };

      "kris@galatea" = mkHome {
        username = "kris";
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
        username = "kris";
        system = "x86_64-linux";
        modules = [
          ./home-manager/core.nix
        ];
      };
    };

    nixGL = nixgl;

    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;
  };
}
