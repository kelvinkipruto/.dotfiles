{ lib, pkgs, ... }:
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

  systemd.user.services.colima = {
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

  # Add more NixOS-specific Home Manager config here.
}
