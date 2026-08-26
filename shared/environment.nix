{ lib, packageProfiles ? { php = true; }, system ? null, androidSdkRoot ? null, ... }:
# Shared environment configurations for both Darwin and NixOS
let
  isDarwin = system != null && (lib.hasPrefix "x86_64-darwin" system || lib.hasPrefix "aarch64-darwin" system);
  isLinux = system != null && (lib.hasPrefix "x86_64-linux" system || lib.hasPrefix "aarch64-linux" system);

  # Android SDK home directory. Prefer the Nix-managed composition if
  # provided (points to Nix store). Otherwise fall back to the canonical
  # user-managed locations so standalone tools still work.
  androidHome =
    if androidSdkRoot != null then
      androidSdkRoot
    else if isDarwin then
      "$HOME/Library/Android/sdk"
    else if isLinux then
      "$HOME/Android/Sdk"
    else
      "$HOME/Android/Sdk";

  # Android SDK subdirectories added to PATH. Note that the Nix-managed
  # androidsdk package already provides wrapper binaries under /bin in the
  # profile, but some tools (e.g. third-party Gradle scripts) still expect
  # to find things under $ANDROID_HOME/<subdir>/ directly.
  androidPathParts = [
    "${androidHome}/emulator"
    "${androidHome}/platform-tools"
    "${androidHome}/cmdline-tools/latest/bin"
    "${androidHome}/tools"
    "${androidHome}/tools/bin"
  ];
  androidPath = lib.concatStringsSep ":" androidPathParts;

  # NDK root (only meaningful when includeNDK was set to true in the
  # composeAndroidPackages call in android-sdk.nix).
  androidNdkRoot = if androidSdkRoot != null then "${androidHome}/ndk-bundle" else "";

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

    # Path additions: local user bin + Go + Android SDK tools.
    PATH = "$HOME/.local/bin:$HOME/go/bin:${androidPath}:$PATH";

    # Android SDK: ANDROID_HOME (legacy) + ANDROID_SDK_ROOT (current).
    ANDROID_HOME = androidHome;
    ANDROID_SDK_ROOT = androidHome;
  } // lib.optionalAttrs (androidSdkRoot != null) {
    # ANDROID_NDK_ROOT + ANDROID_NDK_HOME for tools that need the NDK.
    ANDROID_NDK_ROOT = androidNdkRoot;
    ANDROID_NDK_HOME = androidNdkRoot;
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
