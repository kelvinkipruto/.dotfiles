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
      "ideviceinstaller"
      "libimobiledevice"
      "mysql-client"
      "openjdk@17"
      "openapi-generator"
      "wget"
    ];
    casks = [
      "chatgpt"
      "dbeaver-community"
      "docker"
      "firefox"
      "firefox@developer-edition"
      # "google-chrome"
      # "visual-studio-code"
    ];
  };
}
