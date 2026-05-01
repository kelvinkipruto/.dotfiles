{ pkgs, ... }:
# Darwin (macOS) specific packages
[
  # macOS specific development tools
  pkgs.cocoapods
  # Firefox's Homebrew cask currently fails under pinned brew bundle parsing.
  pkgs.firefox-bin
  pkgs.firefox-devedition
  pkgs.watchman
  pkgs.asdf-vm
]
