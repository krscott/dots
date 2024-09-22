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

    nixGL = {
      url = "github:nix-community/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    gnome-monitor-config = {
      url = "github:krscott/gnome-monitor-config";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, nixGL, ... } @ inputs:
    let
      mkHome = {username, system, modules}:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { inherit inputs; };
          modules = modules ++ [
            {
              nix.package = pkgs.nix;
              home = {
                inherit username;
                homeDirectory = "/home/${username}";
              };
            }
          ];
        };
    in
    {
      homeConfigurations = {
        "kris@ubuntu-nix.styx" = mkHome {
          username = "kris";
          system = "x86_64-linux";
          modules = [
            ./hosts/styx/styx-home.nix
            ./home-manager
            ./users/kris.nix
            {
              krs.cloudAi.enable = true;
              krs.kitty.enable = true;
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
              krs.wsl.enable = true;
              krs.cloudAi.enable = true;
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

      inherit nixGL;
    };
}
