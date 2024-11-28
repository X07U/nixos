{
  description = "NixOS config flake";

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      };

    textfox = {
      url = "github:adriankarlen/textfox";
      inputs.nixpkgs.follows = "nixpkgs";
      };
   
    stylix.url = "github:danth/stylix/5ab1207b2fdeb5a022f2dd7cccf6be760f1b150f";
  };

  outputs = { self, nixpkgs, home-manager, textfox, stylix, ... } @ inputs:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
  in {
    # Default NixOS configuration
    nixosConfigurations.default = nixpkgs.lib.nixosSystem {
      # Pass inputs as special arguments for module access
      specialArgs = { inherit inputs system; };

      # Modules to import
      modules = [
        ./configuration.nix
      	stylix.nixosModules.stylix
        home-manager.nixosModules.home-manager {
          home-manager.extraSpecialArgs = {
            inherit inputs;
          };
        }
      ];
    };
  };
}

