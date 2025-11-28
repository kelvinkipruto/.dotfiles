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
      "null-dev/firefox-profile-switcher"
    ];
    brews = [
      "elixir"
      "firefox-profile-switcher-connector"
    ];
    casks = [
      "chatgpt"
    ];
  };
}
