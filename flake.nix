{
  description = "My Dotfiles Flake";

  inputs = {
    nixpkgs = {
      url = "nixpkgs/nixos-23.05";
    };
    # home-manager = {
    #   url = "github:nix-community/home-manager/release-23.05";
    #   inputs= {
    #     nixpkgs={
    #       follows="nixpkgs";
    #     };
    #   };
    # };
  };

  outputs = {self, nixpkgs, ...}:
  let
    lib = nixpkgs.lib;
  in {
    nixosConfigurations = {
      nixos = lib.nixosSystem {
        system = "x86_64-linux";
        modules = [./configuration.nix];
      };
    };
    # homeConfigurations = {
    #     kipruto = hom/lib/homeManagerConfiguration
    #     lib.nixosSystem {
    #     system = "x86_64-linux";
    #     modules = [./configuration.nix];
    #   };
    # }
  };

}