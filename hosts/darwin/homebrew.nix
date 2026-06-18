{ ... }:
{
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = false;
      cleanup = "zap";
      upgrade = false;
      extraFlags = [ "--verbose" ];
    };
    taps = [
      "homebrew/services"
      "null-dev/firefox-profile-switcher"
    ];
    brews = [
      "firefox-profile-switcher-connector"
      "media-control"
      "mole"
    ];
    casks = [
      "alacritty"
      "alt-tab"
      "brave-browser"
      "chatgpt"
      "flameshot"
      "imhex"
      "kitty"
      "localsend"
      "mole-app"
      "orbstack"
      "raycast"
      "rectangle"
      "responsively"
      "shottr"
      "slack"
      "spotify"
    ];
  };
}
