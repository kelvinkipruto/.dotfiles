{
  description = "My Dotfiles Flake for NixOS and macOS";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs = {
        nixpkgs = {
          follows = "nixpkgs";
        };
      };
    };
    # this is a quick util a good GitHub samaritan wrote to solve for
    # https://github.com/nix-community/home-manager/issues/1341#issuecomment-1791545015
    mac-app-util = {
      url = "github:hraban/mac-app-util";
    };
  };


  outputs =
    { self
    , nixpkgs
    , home-manager
    , nix-darwin
    , mac-app-util
    , nix-homebrew
    , homebrew-core
    , homebrew-cask
    }  @inputs:
    let
      user = "kelvinkipruto";
      darwinConfig = import ./hosts/darwin/configuration.nix { inherit nixpkgs self; };
      nixOSConfig = import ./hosts/nixos/configuration.nix { inherit nixpkgs self; };
    in
    {
      darwinConfigurations.${user} = nix-darwin.lib.darwinSystem {
        modules = [
          darwinConfig
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              enable = true;
              enableRosetta = true;
              user = user;
            };
          }
          home-manager.darwinModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;

              users.${user} = {
                imports = [
                  mac-app-util.homeManagerModules.default
                  ./hosts/darwin/home.nix
                ];
              };
            };
          }
        ];
      };
      nixOSConfigurations.${user} = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          nixOSConfig
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.kelvin = import ./hosts/nixos/home.nix;
            home-manager.extraSpecialArgs = { inherit inputs self user; };
          }
        ];

      };
    };
}
