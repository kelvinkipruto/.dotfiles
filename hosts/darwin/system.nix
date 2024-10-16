{ self, ... }:
{
  system = {
    defaults = {
      # Finder settings
      finder = {
        AppleShowAllExtensions = true;
        _FXShowPosixPathInTitle = true;
        _FXSortFoldersFirst = true;
        QuitMenuItem = true;
        ShowPathbar = true;
        ShowStatusBar = true;
      };
      # Dock settings
      dock = {
        autohide = true;
        show-recents = false;
      };
      # Global settings
      NSGlobalDomain = {
        AppleShowAllExtensions = true;
        InitialKeyRepeat = 14;
        KeyRepeat = 1;
      };
      # Trackpad settings
      trackpad = {
        Clicking = true;
      };

      # System settings
    };
    configurationRevision = self.rev or self.dirtyRev or null;
    stateVersion = 5;
  };

  networking = {
    hostName = "kelvinkipruto";
  };
  security = {
    pam = {
      enableSudoTouchIdAuth = true;
    };
  };

  time = {
    timeZone = "Africa/Nairobi";
  };
}
