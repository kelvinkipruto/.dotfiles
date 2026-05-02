{ pkgs
, lib ? pkgs.lib
, system ? null
, packageProfiles ? {
    ai = true;
    php = true;
    games = true;
    databases = true;
    media = false;
    androidSecurity = false;
    mobile = false;
    workComms = false;
  }
, ...
}:
let
  common = import ./common.nix { inherit pkgs; };
  darwin = import ./darwin.nix { inherit pkgs; };
  nixos = import ./nixos.nix { inherit pkgs; };
  profiles = import ./profiles.nix { inherit pkgs; };
  profileNames = [
    "ai"
    "php"
    "games"
    "databases"
    "media"
    "androidSecurity"
    "mobile"
    "workComms"
  ];
  enabledProfilePackages = profileSet:
    lib.concatLists (map
      (name: lib.optionals (packageProfiles.${name} or false) (profileSet.${name} or [ ]))
      profileNames);
  enabledCommonProfilePackages = enabledProfilePackages profiles.common;
  enabledDarwinProfilePackages = enabledProfilePackages profiles.darwin;
  enabledNixOSProfilePackages = enabledProfilePackages profiles.nixos;
in
{
  # Export individual package sets
  inherit common darwin nixos profiles enabledProfilePackages;

  # Helper functions to get packages for specific systems
  forDarwin = common ++ enabledCommonProfilePackages ++ enabledDarwinProfilePackages ++ darwin;
  forNixOS = common ++ enabledCommonProfilePackages ++ enabledNixOSProfilePackages ++ nixos;

  # Auto-detect system if provided
  forSystem =
    if system == "x86_64-darwin" || system == "aarch64-darwin" then
      common ++ enabledCommonProfilePackages ++ enabledDarwinProfilePackages ++ darwin
    else if system == "x86_64-linux" || system == "aarch64-linux" then
      common ++ enabledCommonProfilePackages ++ enabledNixOSProfilePackages ++ nixos
    else
      common ++ enabledCommonProfilePackages;
}
