{ pkgs, ... }:
# Android SDK composition via androidenv.composeAndroidPackages.
# Includes cmdline-tools (sdkmanager, avdmanager), platform-tools (adb,
# fastboot), build-tools, and optional emulator/NDK support.
#
# ANDROID_HOME for this composition is:
#   ${composition.androidsdk}/libexec/android-sdk
let
  composition = pkgs.androidenv.composeAndroidPackages {
    # Keep 3 latest platform SDKs for broad compatibility.
    numLatestPlatformVersions = 3;

    # Emulator support: deploy if supported by current system.
    includeEmulator = "if-supported";

    # NDK support: deploy if supported by current system.
    includeNDK = "if-supported";

    # CMake in the SDK is included by default on x86-64/Darwin; keep the
    # default behavior for NDK and native builds.
  };

  # The actual SDK root directory that tools expect in ANDROID_HOME.
  sdkRoot = "${composition.androidsdk}/libexec/android-sdk";
in
{
  # The androidsdk package itself gets installed into the profile so its
  # bin/ wrapper scripts and store path are present.
  packages = [ composition.androidsdk ];

  # Expose the composition and sdkRoot to callers (environment.nix uses these
  # to set ANDROID_HOME / ANDROID_SDK_ROOT correctly).
  inherit composition sdkRoot;
}
