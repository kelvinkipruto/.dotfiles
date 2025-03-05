{ self, hostName, ... }:
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
        FXEnableExtensionChangeWarning = false;
      };
      # Dock settings
      dock = {
        autohide = true;
        show-recents = false;
        orientation = "left";
        minimize-to-application = true;
        appswitcher-all-displays = true;
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
      # Window settings
      WindowManager = {
        AutoHide = true;
        EnableStandardClickToShowDesktop = false;
      };

    };
    configurationRevision = self.rev or self.dirtyRev or null;
    stateVersion = 5;
  };

  networking = {
    hostName = hostName;
  };
  security = {
    pam = {
      # enableSudoTouchIdAuth = true;
      services.sudo_local.touchIdAuth = true;
    };
  };

  time = {
    timeZone = "Africa/Nairobi";
  };
}
