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
      configuration = { pkgs, ... }: {
        services.nix-daemon.enable = true;
        nixpkgs.config.allowUnfree = true;

        # Necessary for using flakes on this system.
        nix.settings.experimental-features = "nix-command flakes";

        system.defaults.finder.AppleShowAllExtensions = true;
        system.defaults.finder._FXShowPosixPathInTitle = true;
        system.defaults.dock.autohide = true;
        system.defaults.NSGlobalDomain.AppleShowAllExtensions = true;
        system.defaults.NSGlobalDomain.InitialKeyRepeat = 14;
        system.defaults.NSGlobalDomain.KeyRepeat = 1;


        system.configurationRevision = self.rev or self.dirtyRev or null;

        # Used for backwards compatibility. please read the changelog
        # before changing: `darwin-rebuild changelog`.
        system.stateVersion = 5;

        # The platform the configuration will be used on.
        # If you're on an Intel system, replace with "x86_64-darwin"
        nixpkgs.hostPlatform = "aarch64-darwin";

        # Declare the user that will be running `nix-darwin`.
        users.users.kelvinkipruto = {
          name = "kelvinkipruto";
          home = "/Users/kelvinkipruto";
        };

        # Create /etc/zshrc that loads the nix-darwin environment.
        programs.zsh.enable = true;

        environment.systemPackages = [ pkgs.neofetch pkgs.vim ];
        homebrew = {
          enable = true;
          caskArgs.no_quarantine = true;
          onActivation = {
            autoUpdate = true;
            # zap is a more thorough uninstall, ref: https://docs.brew.sh/Cask-Cookbook#stanza-zap
            cleanup = "zap";
            upgrade = true;
            extraFlags = [ "--verbose" ];
          };

          taps = [ "homebrew/services" ];
          brews = [ "cowsay" ];
          casks = [ ];
        };

        security.pam.enableSudoTouchIdAuth = true;

      };
    in
    {
      darwinConfigurations."kelvinkipruto" = nix-darwin.lib.darwinSystem {
        modules = [
          configuration
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              enable = true;
              enableRosetta = true;
              user = "kelvinkipruto";
            };
          }
          home-manager.darwinModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;

              users.kelvinkipruto = {
                imports = [
                  mac-app-util.homeManagerModules.default
                  ./hosts/darwin/home.nix
                ];
              };
            };
          }
        ];
      };
    };



  # {

  #   # macOSs
  #   darwinConfigurations = {
  #     "kelvinkipruto" = nix-darwin.lib.darwinSystem {
  #       system = "aarch64-darwin";
  #       modules = [
  #         # mac-app-util.darwinModules.default
  #         {
  #           imports = [
  #             ./hosts/darwin/configuration.nix
  #             ./hosts/darwin/software.nix
  #           ];
  #         }
  #         home-manager.darwinModules.home-manager
  #         # {
  #         #   home-manager.useGlobalPkgs = true;
  #         #   home-manager.useUserPackages = true;
  #         #   users.users.kelvinkipruto = {
  #         #     home = "/Users/kelvinkipruto";
  #         #   };
  #         #   home-manager.users.kelvinkipruto = {
  #         #     imports = [
  #         #       mac-app-util.homeManagerModules.default
  #         #       ./hosts/darwin/home.nix
  #         #     ];
  #         #   };
  #         # }
  #         {
  #           home-manager = {
  #             useGlobalPkgs = true;
  #             useUserPackages = true;
  #           };
  #         }
  #       ];
  #       # specialArgs = { inherit inputs; };
  #     };
  #   };
  # };
}
