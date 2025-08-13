{ self, pkgs, ... }:
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
    ];
    casks = [
      "chatgpt"
      # "google-chrome"
      # "visual-studio-code"
    ];
  };
}
