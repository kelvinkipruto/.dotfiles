{ lib, ... }:
{
  imports = [
    ../../shared/home-manager
    ../../config
  ];

  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
    };
  };

  home.packages = lib.mkAfter [
    # NixOS-specific packages go here.
  ];

  # Add more NixOS-specific Home Manager config here.
}
