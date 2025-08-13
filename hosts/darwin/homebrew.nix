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
      # "docker"
      # "biome"
      # "openjdk@17"
      # "wget"
    ];
    casks = [
      # "chatgpt"
      # "firefox"
      # "firefox@developer-edition"
      # "google-chrome"
      # "visual-studio-code"
    ];
  };
}
