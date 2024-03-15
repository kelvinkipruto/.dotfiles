{
  description = "My Dotfiles Flake";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs= {
        nixpkgs={
          follows="nixpkgs";
        };
      };
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
    };
    
  };

  
  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    hyprland,
    ...
  }: 
    let
      user = "kelvin";
    in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs self user;};
      modules = [
        ./system/configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.kelvin = import ./config/home.nix;
          home-manager.extraSpecialArgs = {inherit inputs self user;};
        }
      ];
    };
  };

}