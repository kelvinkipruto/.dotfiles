{ pkgs, system ? null, ... }:
let
  common = import ./common.nix { inherit pkgs; };
  darwin = import ./darwin.nix { inherit pkgs; };
  nixos = import ./nixos.nix { inherit pkgs; };
in
{
  # Export individual package sets
  inherit common darwin nixos;

  # Helper functions to get packages for specific systems
  forDarwin = common ++ darwin;
  forNixOS = common ++ nixos;

  # Auto-detect system if provided
  forSystem = 
    if system == "x86_64-darwin" || system == "aarch64-darwin" then
      common ++ darwin
    else if system == "x86_64-linux" || system == "aarch64-linux" then
      common ++ nixos
    else
      common;
}