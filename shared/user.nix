{ lib, userConfig, ... }:
# Centralized user configuration for both Darwin and NixOS
let
  username = userConfig.name;
in
{
  # User configuration
  user = {
    name = userConfig.name;
    fullName = userConfig.fullName;
    email = userConfig.email;
  };

  # System-specific home directories
  homeDirectory = {
    darwin = "/Users/${username}";
    nixos = "/home/${username}";
  };

  # Helper function to get home directory based on system
  getHomeDirectory = system:
    if lib.hasPrefix "x86_64-darwin" system || lib.hasPrefix "aarch64-darwin" system then
      "/Users/${username}"
    else
      "/home/${username}";

  # Common state version
  stateVersion = "26.05";
}
