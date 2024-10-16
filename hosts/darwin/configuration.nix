{ nixpkgs, self, ... }:
let
  pkgs = import nixpkgs { system = "aarch64-darwin"; };
  systemDefaults = import ./system.nix { inherit self; };
in
{
  nixpkgs.hostPlatform = "aarch64-darwin";

  imports = [
    ./system.nix
  ];

  services.nix-daemon.enable = true;
  nixpkgs.config.allowUnfree = true;


  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
  };

  nix.gc = {
    automatic = true;
    options = "--delete-older-than 7d";
  };


  networking.hostName = "kelvinkipruto";


  # TODO: Move to a separate module
  # system.defaults.finder.AppleShowAllExtensions = true;
  # system.defaults.finder._FXShowPosixPathInTitle = true;
  # system.defaults.finder._FXSortFoldersFirst = true;
  # system.defaults.finder.QuitMenuItem = true;
  # system.defaults.finder.ShowPathbar = true;
  # system.defaults.finder.ShowStatusBar = true;

  # system.defaults.dock.autohide = true;
  # system.defaults.dock.show-recents = false;

  # system.defaults.NSGlobalDomain.AppleShowAllExtensions = true;
  # system.defaults.NSGlobalDomain.InitialKeyRepeat = 14;
  # system.defaults.NSGlobalDomain.KeyRepeat = 1;

  # system.defaults.trackpad.Clicking = true;

  # system.configurationRevision = self.rev or self.dirtyRev or null;

  users.users.kelvinkipruto = {
    name = "kelvinkipruto";
    home = "/Users/kelvinkipruto";
  };

  programs.zsh.enable = true;
  environment.systemPackages = with pkgs; [
    git
    neofetch
    # neovim
    vim
    zsh
  ];

  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

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
      "wget"
    ];
    casks = [
      "chatgpt"
      "dbeaver-community"
      "docker"
      "firefox"
      # "google-chrome"
      # "visual-studio-code"
    ];
  };

  security.pam.enableSudoTouchIdAuth = true;

  time.timeZone = "Africa/Nairobi";

  fonts = {
    packages = with pkgs; [
      fira-code
      fira-code-nerdfont
      fira-code-symbols
      material-design-icons
      font-awesome

      (nerdfonts.override {
        fonts = [
          # symbols icon only
          "NerdFontsSymbolsOnly"
          # Characters
          "FiraCode"
          "JetBrainsMono"
          "Iosevka"
        ];
      })
    ];
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  # system.stateVersion = 5;
}
