{ pkgs, lib, self, user, userConfig, hostName, nixpkgsConfig, systemStateVersion, ... }:
let
  packageProfiles = import ../../shared/package-profiles.nix;
  systemDefaults = import ./system.nix { inherit self hostName user systemStateVersion; };
  servicesConfig = import ./services.nix { inherit self; };
  userModule = import ./user.nix { inherit self pkgs userConfig; };
  programsConfig = import ./programs.nix { inherit self pkgs; };
  homebrewConfig = import ./homebrew.nix { inherit self pkgs; };
  autostartConfig = import ./autostart.nix { inherit self pkgs lib packageProfiles; };
in
{
  nixpkgs = {
    hostPlatform = "aarch64-darwin";
    config = nixpkgsConfig;
  };

  imports = [
    ../../shared/modules/nix.nix
    systemDefaults
    servicesConfig
    userModule
    programsConfig
    homebrewConfig
    autostartConfig
    ./overrides.nix
  ];
}
