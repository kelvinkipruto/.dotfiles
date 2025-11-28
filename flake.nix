{
  description = "My Dotfiles Flake for NixOS and macOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-25.05-darwin";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-darwin = {
      url = "github:LnL7/nix-darwin/nix-darwin-25.05";
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
      url = "github:nix-community/home-manager/release-25.05";
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
    , nixpkgs-unstable
    , home-manager
    , nix-darwin
    , mac-app-util
    , nix-homebrew
    , homebrew-core
    , homebrew-cask
    }  @inputs:
    let
      user = "kelvinkipruto";
      hostName = "kelvinkipruto";

      # System definitions
      systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];

      # Package sets with overlays
      pkgsFor = system: import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
          allowBroken = false;
        };
        overlays = [
          # Add unstable packages as overlay
          (final: prev: {
            unstable = import nixpkgs-unstable {
              inherit system;
              config.allowUnfree = true;
            };
          })
        ];
      };

      darwinConfig = import ./hosts/darwin/configuration.nix { inherit nixpkgs self user hostName; };
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
              autoMigrate = true;
            };
          }
          home-manager.darwinModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "backup";
              extraSpecialArgs = { inherit inputs self user; };

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
      nixosConfigurations.${user} = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/nixos/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.kelvinkipruto = import ./hosts/nixos/home.nix;
            home-manager.extraSpecialArgs = { inherit inputs self user; };
          }
        ];
      };

      # Development shells for each system
      devShells = nixpkgs.lib.genAttrs systems (system:
        let pkgs = pkgsFor system; in {
          default = pkgs.mkShell {
            buildInputs = with pkgs; [
              nixd
              nixpkgs-fmt
            ];
          };
        }
      );
    };
}
