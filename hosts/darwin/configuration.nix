{ nixpkgs, self, ... }:
let
  pkgs = import nixpkgs { system = "aarch64-darwin"; };
  systemDefaults = import ./system.nix { inherit self; };
  servicesConfig = import ./services.nix { inherit self; };
  environmentConfig = import ./environment.nix { inherit self pkgs; };
  userConfig = import ./user.nix { inherit self pkgs; };
  fontsConfig = import ./fonts.nix { inherit self pkgs; };
  programsConfig = import ./programs.nix { inherit self pkgs; };
  homeConfig = import ./homebrew.nix { inherit self pkgs; };
in
{
  nixpkgs = {
    hostPlatform = "aarch64-darwin";
    config = {
      allowUnfree = true;
    };
  };

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
    };
    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
    };
  };

  imports = [
    systemDefaults
    servicesConfig
    environmentConfig
    userConfig
    fontsConfig
    programsConfig
    homeConfig
  ];
}
