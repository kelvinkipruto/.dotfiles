{ lib, packageProfiles ? { php = true; }, system ? null, androidSdkRoot ? null, ... }:
# Shared environment configurations for both Darwin and NixOS
let
  isDarwin = system != null && (lib.hasPrefix "x86_64-darwin" system || lib.hasPrefix "aarch64-darwin" system);
  isLinux = system != null && (lib.hasPrefix "x86_64-linux" system || lib.hasPrefix "aarch64-linux" system);

  # Android SDK env vars are disabled in the dotfiles; Android Studio will manage
  # ANDROID_HOME / ANDROID_SDK_ROOT / PATH (and writes them to shell profiles too).
  #
  # Legacy commented-out reference:
  #   androidHome = if isDarwin then "$HOME/Library/Android/sdk"
  #             else if isLinux  then "$HOME/Android/Sdk"
  #             else                   "$HOME/Android/Sdk";
  #   androidPathParts = [
  #     "${androidHome}/emulator"
  #     "${androidHome}/platform-tools"
  #     "${androidHome}/cmdline-tools/latest/bin"
  #     "${androidHome}/tools"
  #     "${androidHome}/tools/bin"
  #   ];
  #   androidPath = lib.concatStringsSep ":" androidPathParts;

  # Common session variables.
  baseSessionVariables = {
    EDITOR = "nvim";
    BROWSER = "brave";
    TERMINAL = "alacritty";
    PAGER = "less";
    MANPAGER = "less";

    # Development
    LANG = "en_US.UTF-8";
    LC_ALL = "en_US.UTF-8";

    # Path additions: local user bin + Go. Android SDK PATH was here, now managed by Android Studio.
    PATH = "$HOME/.local/bin:$HOME/go/bin:$PATH";

    # Android SDK vars were here (ANDROID_HOME / ANDROID_SDK_ROOT / ANDROID_NDK_*).
    # Android Studio writes its own; nothing at this layer.
  };

  phpSessionVariables = lib.optionalAttrs (packageProfiles.php or false) {
    XDEBUG_MODE = "debug";
    XDEBUG_START_WITH_REQUEST = "yes";
    XDEBUG_CLIENT_PORT = "9003";
    XDEBUG_CLIENT_HOST = "127.0.0.1";
  };

  sessionVariables = baseSessionVariables // phpSessionVariables;
in
{
  inherit sessionVariables;
}
