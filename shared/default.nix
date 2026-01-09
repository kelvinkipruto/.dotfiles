{ pkgs, system ? null, lib ? pkgs.lib, userConfig, ... }:
let
  packages = import ./packages { inherit pkgs system; };
  programs = import ./programs { inherit pkgs; };
  user = import ./user.nix { inherit lib userConfig; };
  aliases = import ./aliases.nix;
  environment = import ./environment.nix { inherit pkgs; };
  fonts = import ./fonts.nix { inherit pkgs; };
in
{
  inherit packages programs user aliases environment fonts;

  # Convenience exports
  inherit (packages) common darwin nixos forDarwin forNixOS forSystem;
}
