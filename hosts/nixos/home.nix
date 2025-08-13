{ pkgs, lib, ... }:
let
  shared = import ../../shared { inherit pkgs lib; system = pkgs.system; };
in
{
  imports = [
    ../../config
  ];

  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
    };
  };

  home = {
    username = shared.user.user.name;
    homeDirectory = shared.user.getHomeDirectory pkgs.system;
    stateVersion = shared.user.stateVersion;

    packages = shared.packages.forNixOS ++ shared.fonts.packages ++ [
      # Additional NixOS-specific packages not in shared
    ];
  };

  programs = shared.programs // {
    # NixOS-specific program overrides or additions
    # Add any Linux-specific program configurations here
  };

  # Import shared environment variables
  home.sessionVariables = shared.environment.sessionVariables;

  # Import shared font configuration
  fonts.fontconfig = shared.fonts.fontconfig;
}
