{ pkgs, lib, userConfig, ... }:
let
  system = pkgs.stdenv.hostPlatform.system;
  shared = import ../default.nix { inherit pkgs lib userConfig system; };
in
{
  home = {
    username = shared.user.user.name;
    homeDirectory = shared.user.getHomeDirectory system;
    stateVersion = shared.user.stateVersion;
    packages = shared.packages.forSystem ++ shared.fonts.packages;
  };

  programs = shared.programs;

  home.sessionVariables = shared.environment.sessionVariables;

  fonts.fontconfig = shared.fonts.fontconfig;
}
