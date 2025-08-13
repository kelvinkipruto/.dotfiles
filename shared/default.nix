{ pkgs, system ? null, lib ? pkgs.lib, ... }:
let
  packages = import ./packages { inherit pkgs system; };
  programs = import ./programs { inherit pkgs; };
  user = import ./user.nix { inherit lib; };
  environment = import ./environment.nix { inherit pkgs; };
  fonts = import ./fonts.nix { inherit pkgs; };
in
{
  inherit packages programs user environment fonts;
  
  # Convenience exports
  inherit (packages) common darwin nixos forDarwin forNixOS forSystem;
}