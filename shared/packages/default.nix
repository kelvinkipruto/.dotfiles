{ pkgs, lib ? pkgs.lib, system ? null, packageProfiles ? { ai = true; androidSecurity = false; }, ... }:
let
  common = import ./common.nix { inherit pkgs; };
  darwin = import ./darwin.nix { inherit pkgs; };
  nixos = import ./nixos.nix { inherit pkgs; };
  profiles = import ./profiles.nix { inherit pkgs; };
  enabledProfilePackages =
    lib.optionals (packageProfiles.ai or true) profiles.ai
    ++ lib.optionals (packageProfiles.androidSecurity or false) profiles.androidSecurity;
in
{
  # Export individual package sets
  inherit common darwin nixos profiles enabledProfilePackages;

  # Helper functions to get packages for specific systems
  forDarwin = common ++ enabledProfilePackages ++ darwin;
  forNixOS = common ++ enabledProfilePackages ++ nixos;

  # Auto-detect system if provided
  forSystem =
    if system == "x86_64-darwin" || system == "aarch64-darwin" then
      common ++ enabledProfilePackages ++ darwin
    else if system == "x86_64-linux" || system == "aarch64-linux" then
      common ++ enabledProfilePackages ++ nixos
    else
      common ++ enabledProfilePackages;
}
