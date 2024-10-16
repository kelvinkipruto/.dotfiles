{
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
}
