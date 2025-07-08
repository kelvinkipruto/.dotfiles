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
      "openjdk@17"
      "wget"
    ];
    casks = [
      "chatgpt"
      "docker"
      "firefox"
      "firefox@developer-edition"
      # "google-chrome"
      # "visual-studio-code"
    ];
  };
}
