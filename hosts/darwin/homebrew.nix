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
      "alielsokary/tap"
    ];
    brews = [
      "firefox-profile-switcher-connector"
      "media-control"
      "mise"
      "mole"
      "mysql-client"
    ];
    casks = [
      "alacritty"
      "alt-tab"
      "brave-browser"
      "alielsokary/tap/caskhub"
      "chatgpt"
      "flameshot"
      "imhex"
      "kitty"
      "localsend"
      # "mole-app"
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
