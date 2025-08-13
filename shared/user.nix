{ lib, ... }:
# Centralized user configuration for both Darwin and NixOS
{
  # User configuration
  user = {
    name = "kelvinkipruto";
    fullName = "Kelvin Kipruto";
    email = "kelvin@example.com"; # Update with your actual email
  };

  # System-specific home directories
  homeDirectory = {
    darwin = "/Users/kelvinkipruto";
    nixos = "/home/kelvinkipruto";
  };

  # Helper function to get home directory based on system
  getHomeDirectory = system:
    if lib.hasPrefix "x86_64-darwin" system || lib.hasPrefix "aarch64-darwin" system then
      "/Users/kelvinkipruto"
    else
      "/home/kelvinkipruto";

  # Common state version
  stateVersion = "25.05";
}