{
  description = "My Dotfiles Flake for NixOS and macOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-darwin = {
      url = "github:LnL7/nix-darwin/master";
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
      url = "github:nix-community/home-manager/master";
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
      userConfig = {
        name = "kelvinkipruto";
        fullName = "Kelvin Kipruto";
        email = "kelvin@example.com";
      };
      user = userConfig.name;
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
        ];
      };

      darwinConfig = import ./hosts/darwin/configuration.nix {
        inherit nixpkgs self user userConfig hostName;
      };
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
              extraSpecialArgs = { inherit inputs self user userConfig; };

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
        specialArgs = { inherit inputs self user userConfig; };
        modules = [
          ./hosts/nixos/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${user} = import ./hosts/nixos/home.nix;
            home-manager.extraSpecialArgs = { inherit inputs self user userConfig; };
          }
        ];
      };

      nixosConfigurations."${user}-aarch64" = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        specialArgs = { inherit inputs self user userConfig; };
        modules = [
          ./hosts/nixos/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${user} = import ./hosts/nixos/home.nix;
            home-manager.extraSpecialArgs = { inherit inputs self user userConfig; };
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
