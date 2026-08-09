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
      # Firefox (release + DevEdition) as casks on Darwin.
      # Homebrew casks install real, writable .app bundles into /Applications which is
      # required for (a) macOS quarantine/xattr writes (no EPERM-13 on /nix/store),
      # (b) valid Mozilla code signatures honored for sandbox/plugin-container extensions,
      # (c) the null-dev/firefox-profile-switcher-connector native-messaging manifest
      #     finding the browser via its hardcoded /Applications/Firefox.app paths.
      "firefox"
      "firefox@developer-edition"
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
