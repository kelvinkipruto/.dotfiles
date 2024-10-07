{ nixpkgs, self, ... }:
let pkgs = import nixpkgs { system = "aarch64-darwin"; };
in
{
  nixpkgs.hostPlatform = "aarch64-darwin";

  services.nix-daemon.enable = true;
  nixpkgs.config.allowUnfree = true;


  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
  };


  networking.hostName = "kelvinkipruto";


  system.defaults.finder.AppleShowAllExtensions = true;
  system.defaults.finder._FXShowPosixPathInTitle = true;
  system.defaults.dock.autohide = true;
  system.defaults.NSGlobalDomain.AppleShowAllExtensions = true;
  system.defaults.NSGlobalDomain.InitialKeyRepeat = 14;
  system.defaults.NSGlobalDomain.KeyRepeat = 1;

  system.configurationRevision = self.rev or self.dirtyRev or null;

  users.users.kelvinkipruto = {
    name = "kelvinkipruto";
    home = "/Users/kelvinkipruto";
  };

  programs.zsh.enable = true;
  environment.systemPackages = [ pkgs.neofetch pkgs.vim pkgs.zsh pkgs.volta ];

  homebrew = {
    enable = true;
    caskArgs.no_quarantine = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
      extraFlags = [ "--verbose" ];
    };
    taps = [
      "homebrew/services"
    ];
    brews = [
    ];
    casks = [
      "chatgpt"
      "dbeaver-community"
    ];
  };

  security.pam.enableSudoTouchIdAuth = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;
}
