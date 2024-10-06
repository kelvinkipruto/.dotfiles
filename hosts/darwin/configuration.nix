{ inputs, config, pkgs, lib, ... }:

{
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
  };

  services.nix-daemon.enable = true;

  networking.hostName = "kelvinkipruto";

  users.users.kelvinkipruto = {
    home = "/Users/kelvinkipruto";
    packages = with pkgs; [
      git
    ];
    shell = pkgs.zsh;
  };

  nixpkgs.config.allowUnfree = true;


  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;
}
