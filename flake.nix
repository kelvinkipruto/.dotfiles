{
  description = "My Dotfiles Flake for NixOS and macOS";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
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
    , ...
    }  @inputs:
    let
      userConfig = {
        name = "kelvinkipruto";
        fullName = "Kelvin Kipruto";
        email = "kelvin@example.com";
      };
      user = userConfig.name;
      hostName = "kelvinkipruto";
      systemStateVersion = {
        nixos = "26.05";
        darwin = 6;
      };

      # System definitions
      systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];

      nixpkgsConfig = {
        allowUnfree = true;
        allowBroken = false;
        android_sdk.accept_license = true;
      };

      # Package sets with overlays
      pkgsFor = system: import nixpkgs {
        inherit system;
        config = nixpkgsConfig;
        overlays = [
        ];
      };
    in
    {
      darwinConfigurations.${user} = nix-darwin.lib.darwinSystem {
        specialArgs = { inherit inputs self user userConfig hostName nixpkgsConfig systemStateVersion; };
        modules = [
          ./hosts/darwin/configuration.nix
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              enable = true;
              enableRosetta = true;
              user = user;
              autoMigrate = true;
              # Declaratively trust third-party tap items (Homebrew 6.0+ tap-trust).
              # Prefer formula/cask granularity over whole-tap trust per upstream guidance:
              # https://docs.brew.sh/Tap-Trust
              trust = {
                formulae = [
                  "null-dev/firefox-profile-switcher/firefox-profile-switcher-connector"
                ];
                casks = [
                  "alielsokary/tap/caskhub"
                  "microsoft/sysinternalstap/zoomit"
                ];
                commands = [ ];
                taps = [ ];
              };
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
                  # mac-app-util.homeManagerModules.default
                  ./hosts/darwin/home.nix
                ];
              };
            };
          }
        ];
      };
      nixosConfigurations.${user} = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs self user userConfig hostName nixpkgsConfig systemStateVersion; };
        modules = [
          ./hosts/nixos/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${user} = {
              imports = [
                ./hosts/nixos/home.nix
              ];
            };
            home-manager.extraSpecialArgs = { inherit inputs self user userConfig; };
          }
        ];
      };

      nixosConfigurations."${user}-aarch64" = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        specialArgs = { inherit inputs self user userConfig hostName nixpkgsConfig systemStateVersion; };
        modules = [
          ./hosts/nixos/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${user} = {
              imports = [
                ./hosts/nixos/home.nix
              ];
            };
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
              deadnix
              statix
            ];
          };
        }
      );
    };
}
