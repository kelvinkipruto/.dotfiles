{ self, ... }:
{
  #   system.defaults.finder.ShowPathbar = true;
  #   system.defaults.finder.ShowStatusBar = true;

  #   system.defaults.dock.autohide = true;
  #   system.defaults.dock.show-recents = false;

  #   system.defaults.NSGlobalDomain.AppleShowAllExtensions = true;
  #   system.defaults.NSGlobalDomain.InitialKeyRepeat = 14;
  #   system.defaults.NSGlobalDomain.KeyRepeat = 1;

  #   system.defaults.trackpad.Clicking = true;

  #   system.configurationRevision = self.rev or self.dirtyRev or null;

  #   # Used for backwards compatibility, please read the changelog before changing.
  #   # $ darwin-rebuild changelog
  #   system.stateVersion = 5;

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
      configurationRevision = self.rev or self.dirtyRev or null;
    };
    stateVersion = "5";
  };

  networking = {
    hostName = "kelvinkipruto";
  };
}
