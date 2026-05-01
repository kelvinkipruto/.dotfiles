{ ... }:
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
      "firefox-profile-switcher-connector"
      "media-control"
    ];
    casks = [
      "chatgpt"
    ];
  };
}
