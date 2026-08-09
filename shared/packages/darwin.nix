{ pkgs, ... }:
# Darwin (macOS) specific packages
[
  # macOS specific development tools
  # GUI browsers on macOS are installed via Homebrew casks (hosts/darwin/homebrew.nix).
  # Homebrew casks put real .app bundles in /Applications on a read-write filesystem,
  # which is required for:  (1) xattrs/quarantine to be written without EPERM errors;
  # (2) Mozilla code signatures to be honored by sandbox extensions;
  # (3) the native firefox-profile-switcher-connector (brew formula) to find the
  #     browser via its hardcoded /Applications/Firefox.app paths.
  pkgs.asdf-vm
]
