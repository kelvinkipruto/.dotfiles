{ pkgs, lib, ... }:
let
  shared = import ../../shared { inherit pkgs lib; system = pkgs.system; };
in
{
  imports = [
    ../../config
  ];
  
  home = {
    username = shared.user.user.name;
    homeDirectory = shared.user.getHomeDirectory pkgs.system;
    stateVersion = shared.user.stateVersion;

    packages = shared.packages.forDarwin ++ shared.fonts.packages ++ [
      # Additional Darwin-specific packages not in shared
      # Add any custom packages here
    ];
  };

  programs = shared.programs // {
    # Darwin-specific program overrides or additions
    # Add any macOS-specific program configurations here
  };
  
  # Import shared environment variables
  home.sessionVariables = shared.environment.sessionVariables;
  
  # Import shared font configuration
  fonts.fontconfig = shared.fonts.fontconfig;
}
