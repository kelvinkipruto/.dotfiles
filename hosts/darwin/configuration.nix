{ nixpkgs, self, ... }:
let
  pkgs = import nixpkgs { system = "aarch64-darwin"; };
  systemDefaults = import ./system.nix { inherit self; };
  servicesConfig = import ./services.nix { inherit self; };
  environmentConfig = import ./environment.nix { inherit self pkgs; };
in
{
  nixpkgs = {
    hostPlatform = "aarch64-darwin";
    config = {
      allowUnfree = true;
    };
  };
  # nixpkgs.hostPlatform = "aarch64-darwin";

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
    };
    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
    };
  };

  imports = [
    systemDefaults
    servicesConfig
    environmentConfig
  ];

  # services.nix-daemon.enable = true;
  # nixpkgs.config.allowUnfree = true;


  # nix.settings = {
  #   experimental-features = [ "nix-command" "flakes" ];
  # };

  # nix.gc = {
  #   automatic = true;
  #   options = "--delete-older-than 7d";
  # };


  # networking.hostName = "kelvinkipruto";

  # users.users.kelvinkipruto = {
  #   name = "kelvinkipruto";
  #   home = "/Users/kelvinkipruto";
  # };

  programs.zsh.enable = true;
  # environment.systemPackages = with pkgs; [
  #   git
  #   neofetch
  #   # neovim
  #   vim
  #   zsh
  # ];

  # environment.variables = {
  #   EDITOR = "nvim";
  #   VISUAL = "nvim";
  # };

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

  # security.pam.enableSudoTouchIdAuth = true;

  # time.timeZone = "Africa/Nairobi";

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
}
