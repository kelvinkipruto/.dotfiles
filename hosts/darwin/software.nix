{ pkgs, ... }: {
  environment = {
    loginShell = pkgs.zsh;
    # systemPackages = [ pkgs.coreutils ];
    # systemPath = [ "/opt/homebrew/bin" ];
    # pathsToLink = [ "/Applications" ];
  };

  homebrew = {
    enable = true;
    # disabling quarantine would mean no stupid macOS do-you-really-want-to-open dialogs
    caskArgs.no_quarantine = true;
    onActivation = {
      autoUpdate = true;
      # zap is a more thorough uninstall, ref: https://docs.brew.sh/Cask-Cookbook#stanza-zap
      cleanup = "zap";
      upgrade = true;
      extraFlags = [ "--verbose" ];
    };
    taps = [
      # "homebrew/cask-versions"
      "homebrew/services"
    ];
    brews = [
      "git"
      "go"
      # "kitty"
      # "ollama"
      # "tree"
      # {
      #     name = "syncthing";
      #     start_service = true;
      #     restart_service = "changed";
      # }
      "vim"
      # "watch"
    ];
    casks = [
      # "bitwarden"
      "chatgpt"
      # "chromium"
      "dbeaver-community"
      # "docker"
      # "firefox"
      # "google-chrome"
      # "mitmproxy"
      # "obsidian"
      # "spotify"
      # "temurin17"
      # "visual-studio-code"
      # "vlc"
    ];
  };
}
