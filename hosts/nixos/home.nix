{ lib, pkgs, ... }:
let
  packageProfiles = import ../../shared/package-profiles.nix;
  services = packageProfiles.services or { };
in
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

  home.packages = lib.mkAfter (with pkgs; [
    # NixOS-specific packages go here.
  ]);

  systemd.user.services = lib.optionalAttrs (services.colima or false) {
    colima = {
      Unit = {
        Description = "Colima";
        After = [ "network.target" ];
      };
      Service = {
        ExecStart = "${pkgs.colima}/bin/colima start";
        Restart = "on-failure";
      };
      Install = {
        WantedBy = [ "default.target" ];
      };
    };
  };

  # Add more NixOS-specific Home Manager config here.
}
