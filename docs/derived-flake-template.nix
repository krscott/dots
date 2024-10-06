{
  description = "Nix config inheriting from Kris's personal config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixGL = {
      url = "github:nix-community/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    personal-config = {
      url = "github:krscott/nixcfg";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    nixGL,
    personal-config,
    ...
  } @ inputs: let
    mkHome = {
      username,
      system,
      modules,
    }: let
      pkgs = nixpkgs.legacyPackages.${system};
    in
      home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {inherit inputs;};
        modules =
          modules
          ++ [
            (import "${personal-config}/home-manager/default.nix")
            {
              krs = {
                # defaultNixSettings = false; # Uncomment to prevent writing nix.conf
                kitty.enable = true;
              };
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
      "kscott@work-compy" = mkHome {
        username = "kscott";
        system = "x86_64-linux";
        modules = [
          (import "${personal-config}/hosts/work-la-ubuntu/home.nix")
          ./users/kscott.nix
        ];
      };
    };

    inherit nixGL;
  };
}
