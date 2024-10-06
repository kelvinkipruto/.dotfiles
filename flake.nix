{
  description = "My Dotfiles Flake for NixOS and macOS";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs = {
        nixpkgs = {
          follows = "nixpkgs";
        };
      };
    };
    # hyprland = {
    #   url = "github:hyprwm/Hyprland";
    # };
    # nix-darwin = {
    #   url = "github:LnL7/nix-darwin/master";
    #   inputs = {
    #     nixpkgs = {
    #       follows = "nixpkgs";
    #     };
    #   };
    # };
    # nix-homebrew = {
    #   url = "github:zhaofengli-wip/nix-homebrew";
    # };
    # homebrew-core = {
    #   url = "github:homebrew/homebrew-core";
    #   flake = false;
    # };
    # homebrew-cask = {
    #   url = "github:homebrew/homebrew-cask";
    #   flake = false;
    # };
    # homebrew-bundle = {
    #   url = "github:homebrew/homebrew-bundle";
    #   flake = false;
    # };
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
    , # hyprland,
      nix-darwin
      # , nix-homebrew
      # , homebrew-bundle
      # , homebrew-core
      # , homebrew-cask
    , mac-app-util
    , ...
    }  @inputs: {
      # NixOS
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs self; };
          modules = [
            {
              imports = [ ./hosts/nixos/configuration.nix ];
              _module.args.self = self;
            }
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.kelvin = import ./config/home.nix;
              home-manager.extraSpecialArgs = { inherit inputs self; };
            }
          ];
        };
      };

      # macOS
      darwinConfigurations = {
        "kelvinkipruto" = nix-darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          modules = [
            mac-app-util.darwinModules.default
            {
              imports = [
                ./hosts/darwin/configuration.nix
                ./hosts/darwin/software.nix
              ];
            }
            home-manager.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              users.users.kelvin = {
                home = "/Users/kelvinkipruto";
              };
              home-manager.users.kelvinkipruto = {
                imports = [
                  mac-app-util.homeManagerModules.default
                  ./hosts/darwin/home.nix
                ];
              };
            }
            # nix-homebrew.darwinModules.nix-homebrew
            # {
            #   nix-homebrew = {
            #     enable = true;
            #     enableRosetta = true;
            #     user = "kelvinkipruto";
            #   };
            # }
          ];
        };
      };
      # packages.aarch64-darwin = {
      #   default = nixpkgs.legacyPackages.aarch64-darwin.hello;
      # };
      # defaultPackage.aarch64-darwin = self.packages.aarch64-darwin.default;
    };
}
