{ pkgs, system ? null, lib ? pkgs.lib, userConfig, ... }:
let
  packageProfiles = import ./package-profiles.nix;
  packages = import ./packages { inherit pkgs system lib packageProfiles; };
  programs = import ./programs { inherit pkgs; };
  user = import ./user.nix { inherit lib userConfig; };
  aliases = import ./aliases.nix;
  environment = import ./environment.nix { inherit pkgs lib packageProfiles; };
  fonts = import ./fonts.nix { inherit pkgs; };
in
{
  inherit packages programs user aliases environment fonts packageProfiles;

  # Convenience exports
  inherit (packages) common darwin nixos forDarwin forNixOS forSystem;
}
